# agents

## Claude

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
