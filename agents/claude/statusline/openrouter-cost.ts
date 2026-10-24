#!/usr/bin/env node
// OpenRouter cost for a ccstatusline Custom Command widget. Runs with Node's built-in type stripping.
// Based on https://github.com/OpenRouterTeam/openrouter-examples/tree/main/claude-code (MIT).
// The API key is a dedicated $0-limit key in the macOS Keychain (service: ccor-statusline).

import { execFileSync } from 'node:child_process';
import { existsSync, readdirSync, readFileSync, renameSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';

// Keep each refresh well inside ccstatusline's 2000ms timeout; the rest is picked up next refresh
const MAX_FETCH_PER_RUN = 20;

interface StatuslineInput {
  session_id?: string;
  transcript_path?: string;
}

interface GenerationData {
  total_cost: number;
  cache_discount: number | null;
  is_byok: boolean;
  upstream_inference_cost: number | null;
  provider_name: string;
  model: string;
}

interface State {
  seen_ids: string[];
  total_cost: number;
  total_byok_cost: number;
  total_cache_discount: number;
  last_provider: string;
  last_model: string;
}

function readKey(): string {
  try {
    return execFileSync('security', ['find-generic-password', '-s', 'ccor-statusline', '-w'], {
      encoding: 'utf8',
      stdio: ['ignore', 'pipe', 'ignore'],
    }).trim();
  } catch {
    return '';
  }
}

// Some routes (e.g. OpenAI models) return msg_* as message.id; the generation ID is then in requestId.
function generationIds(transcriptPath: string): string[] {
  const isGenerationId = (v: unknown): v is string => typeof v === 'string' && v.startsWith('gen-');
  const ids = readFileSync(transcriptPath, 'utf8')
    .split('\n')
    .values()
    .filter((line) => line.includes('"gen-'))
    .flatMap((line): any[] => {
      try {
        return [JSON.parse(line)];
      } catch {
        return []; // e.g. a line still being written
      }
    })
    .filter((entry) => !entry.isApiErrorMessage) // failed requests are never billed and 404 on lookup
    .map((entry) => [entry.message?.id, entry.requestId].find(isGenerationId))
    .filter(isGenerationId);
  return [...new Set(ids)];
}

// Subagent transcripts live next to the main one: <session>/subagents/*.jsonl
function transcriptFiles(transcriptPath: string): string[] {
  const dir = join(transcriptPath.replace(/\.jsonl$/, ''), 'subagents');
  try {
    const subagents = readdirSync(dir).filter((f) => f.endsWith('.jsonl'));
    return [transcriptPath, ...subagents.map((f) => join(dir, f))];
  } catch {
    return [transcriptPath];
  }
}

const emptyState = (): State => ({
  seen_ids: [],
  total_cost: 0,
  total_byok_cost: 0,
  total_cache_discount: 0,
  last_provider: '',
  last_model: '',
});

function loadState(statePath: string): State {
  try {
    const saved = JSON.parse(readFileSync(statePath, 'utf8'));
    return Array.isArray(saved.seen_ids) ? { ...emptyState(), ...saved } : emptyState();
  } catch {
    return emptyState(); // missing or corrupt
  }
}

// Write then rename so a run killed mid-write never leaves a truncated file
function saveState(statePath: string, state: State): void {
  const tmp = `${statePath}.${process.pid}.tmp`;
  writeFileSync(tmp, JSON.stringify(state));
  renameSync(tmp, statePath);
}

async function fetchGeneration(id: string, key: string): Promise<GenerationData | null> {
  try {
    const res = await fetch(`https://openrouter.ai/api/v1/generation?id=${encodeURIComponent(id)}`, {
      headers: { Authorization: `Bearer ${key}` },
      signal: AbortSignal.timeout(1500),
    });
    if (!res.ok) return null;
    const { data } = (await res.json()) as { data: GenerationData };
    return data;
  } catch {
    return null;
  }
}

async function main(): Promise<void> {
  let raw = '';
  for await (const chunk of process.stdin) raw += chunk;
  const { session_id: sessionId, transcript_path: transcriptPath }: StatuslineInput = JSON.parse(raw);
  if (!sessionId || !/^[\w-]+$/.test(sessionId) || !transcriptPath || !existsSync(transcriptPath)) return;

  const statePath = join(tmpdir(), `claude-openrouter-cost-${sessionId}.json`);
  const state = loadState(statePath);

  const seen = new Set(state.seen_ids);
  const pending = [...new Set(transcriptFiles(transcriptPath).flatMap(generationIds))]
    .filter((id) => !seen.has(id))
    .slice(0, MAX_FETCH_PER_RUN);
  const key = pending.length > 0 ? readKey() : '';
  if (key) {
    const results = await Promise.all(pending.map((id) => fetchGeneration(id, key)));
    results.forEach((gen, i) => {
      if (typeof gen?.total_cost !== 'number') return; // not ready yet; retried next refresh
      state.total_cost += gen.total_cost;
      // BYOK: OpenRouter's total_cost is only its fee; the provider bills upstream_inference_cost
      if (gen.is_byok) state.total_byok_cost += gen.upstream_inference_cost ?? 0;
      state.total_cache_discount += gen.cache_discount ?? 0;
      state.last_provider = gen.provider_name || state.last_provider;
      state.last_model = gen.model || state.last_model;
      state.seen_ids.push(pending[i]);
    });
    saveState(statePath, state);
  }

  if (state.seen_ids.length === 0) return;
  const model = state.last_model.replace(/^[^/]+\//, '').replace(/-\d{8}$/, '');
  // cache_discount goes negative when cache writes cost more than reads saved
  const d = state.total_cache_discount;
  const cache = d ? ` (cache ${d > 0 ? '-' : '+'}$${Math.abs(d).toFixed(4)})` : '';
  const byok = state.total_byok_cost ? ` (BYOK $${state.total_byok_cost.toFixed(4)})` : '';
  process.stdout.write(`${state.last_provider}: ${model} | $${state.total_cost.toFixed(4)}${byok}${cache}`);
}

main().catch(() => {});
