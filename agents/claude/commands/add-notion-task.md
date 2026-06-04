---
description: Notion Tasks に新しいタスクを Inbox として追加する
argument-hint: <タスク名>
---

`$ARGUMENTS` を Notion Tasks の Inbox に追加します。

## 手順

### 1. タスク名の確認

`$ARGUMENTS` が空の場合は、追加するタスク名をユーザーに確認してください。

### 2. 構造化の要否確認

`AskUserQuestion` で「本文を構造化しますか？」を確認してください。

### 3. 構造化（要の場合のみ）

これまでの会話コンテキスト＋ヒアリングをもとに、以下の3項目を構造化してください。
一意に定まらない箇所があれば `AskUserQuestion` で補完してください。

- **目的**: 何を達成したいか
- **背景・制約**: 前提、守るべき制約
- **完了条件**: 何をもって「完了」とするか

### 4. Tasks DB のスキーマ取得

`mcp__claude_ai_Notion__notion-search` で「Tasks」を検索し、Tasks データベースを特定してください。
次に `mcp__claude_ai_Notion__notion-fetch` でそのデータベースを取得し、`Category` と `Horizon` の現在の選択肢一覧を確認してください。

### 5. Category / Horizon のヒアリング

取得したスキーマの選択肢を使って `AskUserQuestion` で以下を同時に確認してください。

- **Category**（複数選択可、任意）: スキーマの選択肢から提示（options は最大4件のため入りきらない場合は頻度の高そうなものを優先し、残りは Other で入力してもらう）
- **Horizon**（単一選択、任意）: スキーマの選択肢から提示

**重要**: Other で入力された値がスキーマの既存選択肢にない場合は、登録を中断してユーザーに確認すること。新規の選択肢を勝手に作成しないこと。

### 6. セルフレビュー

登録前に内容を見直してください（手順3を実施した場合は特に）。

- タスク名は明確で実行可能な形になっているか
- 本文（目的・背景・完了条件）に矛盾や見落としはないか

### 7. Notion Tasks に登録

`mcp__claude_ai_Notion__notion-create-pages` で登録してください。

- parent: 手順4で取得した data_source_id
- `Task`（title）: タスク名
- `Status`: `📤 Inbox`
- `Category`: 選択された値（未選択の場合は省略）
- `Horizon`: 選択された値（未選択の場合は省略）
- 本文: 構造化した内容（手順3を実施した場合のみ）

### 8. 完了報告

登録されたページの URL を出力してください。
