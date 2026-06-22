## 目的

`kickoff` / `wrapup` スラッシュコマンドを `notion-workflow` プラグインのスキルに統合し、Notion ワークフロー関連のロジックをプラグインに集約する。

## 背景・制約

- `add-task` と `style` はすでにプラグイン化済み（`agents/claude/plugins/notion-workflow/skills/`）
- `kickoff.md` と `wrapup.md` はまだ `agents/claude/commands/` にスラッシュコマンドとして残っている
- プラグイン化後はスラッシュコマンドではなく `Skill(kickoff)` / `Skill(wrapup)` での呼び出しになる
  - ユーザーは `/kickoff <依頼>` と書く代わりに、会話内で「kickoff して」と依頼するか、コマンド内から `Skill(kickoff)` で呼ぶ
- `kickoff.md` は現在 `Skill(style)` を呼び出しており、プラグイン内への移動後も動作を維持する必要がある
- `wrapup.md` も同様に `Skill(style)` に依存

## 成果物

| 変更 | パス |
|------|------|
| 新規追加 | `agents/claude/plugins/notion-workflow/skills/kickoff/SKILL.md` |
| 新規追加 | `agents/claude/plugins/notion-workflow/skills/wrapup/SKILL.md` |
| 削除 | `agents/claude/commands/kickoff.md` |
| 削除 | `agents/claude/commands/wrapup.md` |
| 更新 | `agents/claude/plugins/notion-workflow/.claude-plugin/plugin.json`（description に kickoff/wrapup を追記） |

## 完了条件

- `Skill(kickoff)` / `Skill(wrapup)` がプラグイン経由で呼び出せる
- `kickoff` スキルから `Skill(style)` の呼び出しが引き続き機能する
- `wrapup` スキルから `Skill(style)` の呼び出しが引き続き機能する
- `makelink.sh` に変更が必要な場合は対応済み

## タスク分解

- [ ] `agents/claude/plugins/notion-workflow/skills/kickoff/SKILL.md` を作成
  - 既存 `kickoff.md` の内容をスキル形式（frontmatter: `name`, `description`）に変換
  - `argument-hint` を削除し、`description` にトリガー条件を記述
- [ ] `agents/claude/plugins/notion-workflow/skills/wrapup/SKILL.md` を作成
  - 既存 `wrapup.md` の内容をスキル形式に変換
- [ ] `agents/claude/commands/kickoff.md` を削除
- [ ] `agents/claude/commands/wrapup.md` を削除
- [ ] `plugin.json` の `description` を更新（add-task / kickoff / wrapup / style）
- [ ] 動作確認: `Skill(kickoff)` を手動で呼び出し、フローが正常に動くことを確認
