---
description: セッションの決定・成果を整理し、対応する Notion Notes ページを更新する
argument-hint: "[対象ページ URL（省略可）]"
---

あなたはタスクの締め（wrapup）を担当します。今回のセッションの成果を Notion の該当ページに記録してください。

## 1. 整理

このセッションでの以下を簡潔に整理してください。

- **決定事項**: 議論の末に採用した方針・選択とその理由
- **成果**: 実際に作成・変更したもの
- **残課題**: 未対応・フォローが必要な事項

## 2. 対象ページの特定

- `$ARGUMENTS` に Notion ページ URL があれば、それを対象にします。
- 無ければ `mcp__claude_ai_Notion__notion-search` で「`🤖 w/ Claude Code`」タグを持つ最近のページを検索し、どれが対象かユーザーに確認してください。

## 3. 更新

本文を追記する前に `Skill(notion-style)` を呼び出し、文体ガイドラインを確認すること。

- ツール: `mcp__claude_ai_Notion__notion-update-page`
- 本文に `## 決定事項` / `## 成果` / `## 残課題` を追記する

**重要**: 書き込みは外向きアクションです。追記内容を先にユーザーに提示し、**承認を得てから** 更新を実行してください。

## 4. コミット

コミットやプッシュが必要な場合は、既存の権限設定（`settings.json`）と CLAUDE.md のルールに従ってください。`git push` は独断で実行しないこと。

## 5. タスクのクローズ（任意）

kickoff で紐付けたタスクがある場合はクローズしてください。

`mcp__claude_ai_Notion__notion-search` で Tasks データベース内を今回の作業に関連するキーワードで検索し、`AskUserQuestion` でユーザーに確認してください（「なし」を選択肢に含める）。

タスクが選択された場合、以下の更新内容をユーザーに提示し、**承認を得てから** `notion-update-page` を実行してください。

- `Status`: `✅ Done`
- `Horizon`: `Completed`
- `Completed At`: 本日の日付（`date:Completed At:start` に ISO-8601 形式で設定）
