# Claude Workflow 範本

這個目錄是一套可重用的 Claude Code 工作流程範本。

## 內容說明

- `CLAUDE.md`：給專案使用的頂層 workflow 指南，包含需要自行替換的 placeholder
- `.claude/agents/`：核心 workflow subagents，包含 planning、execution、review、refactor、QA 與 exploration
- `.claude/skills/`：核心 `workflow-*` skills
- `.claude/settings.local.json`：核心 workflow 的本地權限預設
- `extensions/openspec/`：可選的 OpenSpec 擴充
- `extensions/specialized-agents/`：可選的專用 agent 擴充

## 使用方式

1. 將 `CLAUDE.md` 複製到目標 repository 根目錄並命名為 `CLAUDE.md`
2. 將 `.claude/` 複製到目標 repository 根目錄
3. 先編輯 `CLAUDE.md`，把 `<project-goal>`、`<docs-entrypoint>` 這類 placeholder 換成目標專案的內容
4. 視需要決定是否加入 `extensions/`
   - `.claude/agents/`、`.claude/skills/workflow-*`、`.claude/settings.local.json` 是核心模板
   - `extensions/openspec/` 適合使用 OpenSpec 的專案
   - `extensions/specialized-agents/` 適合需要更細角色分工的專案
5. 依照目標 repository 的需求調整 `.claude/settings.local.json`，加入真正要 auto-allow 的指令

## 客製化建議

- 核心 workflow 採用 `plan -> execute -> review -> refactor -> review -> test` 的循環
- 核心模板只保留 workflow、本體 subagents 與 `workflow-*` skills
- OpenSpec 相關內容已全部拆到 `extensions/openspec/`
- 其他較有方法論色彩的 agents 已拆到 `extensions/specialized-agents/`
- 如果你之後修改了這套 workflow，記得同步更新這份範本，避免內容脫節

## 建議閱讀順序

1. 先看 `CLAUDE.md`
2. 再看 `.claude/agents/` 與 `.claude/skills/workflow-*`
3. 最後再決定要不要加入 `extensions/`
