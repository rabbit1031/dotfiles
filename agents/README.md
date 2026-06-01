# agents

## Claude

### Commands

`agents/claude/commands/` 配下のカスタムスラッシュコマンド。`makelink.sh` で `~/.claude/commands` にシンボリックリンクされる。

- `/kickoff <依頼>` — 依頼を「目的/背景・制約/成果物/完了条件」に構造化し、不足を確認、計画・タスク分解した上で Notion の Notes DB に `🤖 Claude Code` タグで起票する。
- `/wrapup [ページURL]` — セッションの決定・成果・残課題を整理し、対応する Notion Notes ページに追記する。

いずれも Notion への書き込み前に内容を提示し、承認を得てから実行する。

### Statusline

- [ステータスラインをカスタマイズする - Claude Code Docs](https://code.claude.com/docs/ja/statusline)
  - [sirmalloc/ccstatusline: 🚀 Beautiful highly customizable statusline for Claude Code CLI with powerline support, themes, and more.](https://github.com/sirmalloc/ccstatusline)

## Gemini
