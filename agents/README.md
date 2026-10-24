# agents

## Claude

### Multi-Provider Architecture (Anthropic vs OpenRouter)

Claude Code を Anthropic 公式（OAuth/サブスクリプション）と OpenRouter 経由で併用・分離する構成。

#### Anthropic 公式向け（デフォルト）

- 設定ディレクトリ: `~/.claude/`
- 起動コマンド: `claude`
- ベース設定: `agents/claude/settings.json`
  - `~/.claude/settings.json` へリンク
- 認証: 公式 OAuth / サブスクリプション

#### OpenRouter 向け

- 設定ディレクトリ: `~/.claude-openrouter/`
  - `CLAUDE_CONFIG_DIR` で完全分離
- 起動コマンド: `ccor` （zsh 関数）
- ベース設定: `~/.claude-openrouter/settings.json`
  - 起動ごとに `agents/claude/settings.json` からコピー
- 差分設定: `agents/claude/settings.openrouter.json`
  - `~/.claude-openrouter/settings.openrouter.json` へリンク
- モデル: Claude は公式側で使うため、主に非 Claude モデルを割り当て
- 認証: `apiKeyHelper` 経由で 1Password CLI からオンデマンド取得

##### ステータスライン（OpenRouter 向け）

- 設定: 差分設定で ccstatusline を `--config ~/.claude-openrouter/ccstatusline-settings.json` に切り替え
  - `agents/claude/ccstatusline-settings.openrouter.json` からリンク
- 表示: 使用量の行の代わりに `agents/claude/statusline/openrouter-cost.ts` で OpenRouter のセッション費用を表示
  - Node の型ストリッピングで直接実行
  - サブエージェント分を含む
  - BYOK 分の `upstream_inference_cost` は `(BYOK $…)` として別枠表示
- 照会キー: 利用上限 $0 の専用キーを使い、macOS キーチェーンに保存
  - `security add-generic-password -U -a "$USER" -s ccor-statusline -w` を実行し、プロンプトに貼り付け

#### Zed (ACP) 連携

- `claude-acp`: Anthropic 公式向けのみ。OpenRouter 向けは CLI (`ccor`) で利用する

### Plugins

`agents/claude/plugins/` 配下のプラグイン。`.claude-plugin/marketplace.json` でマーケットプレイスとして公開し、CC・Web UI の両環境から参照する。

#### notion-workflow

Notion タスク・ノート管理ワークフロースキル集。

- `Skill(kickoff)` — 依頼を「目的/背景・制約/成果物/完了条件」に構造化し、不足を確認、計画・タスク分解した上で Notion の Notes DB に `🤖 w/ Claude Code` タグで起票する。
- `Skill(wrapup)` — セッションの決定・成果・残課題を整理し、対応する Notion Notes ページに追記する。
- `Skill(add-task)` — Notion Tasks の Inbox に新しいタスクを追加する。
- `Skill(style)` — Notion 作業メモの文体ガイドラインを提供する（他スキルから参照）。

いずれも Notion への書き込み前に内容を提示し、承認を得てから実行する。

### Statusline

- [ステータスラインをカスタマイズする - Claude Code Docs](https://code.claude.com/docs/ja/statusline)
  - [sirmalloc/ccstatusline: 🚀 Beautiful highly customizable statusline for Claude Code CLI with powerline support, themes, and more.](https://github.com/sirmalloc/ccstatusline)

## Gemini
