# 擴充套件說明

這個目錄放的是核心 Claude workflow 之外的可選擴充。

核心模板刻意保持精簡，只包含：
- `.claude/agents/`
- `.claude/skills/workflow-*`
- `.claude/settings.local.json`
- `CLAUDE.md`

只有在目標 repository 真的需要時，才建議加入這些 extension。

## 可用擴充

### `openspec/`

提供 OpenSpec 相關的 workflow 支援：
- `openspec-*` skills
- `opsx/*` command wrappers

適合：
- repository 已經使用 OpenSpec
- 團隊希望用 OpenSpec 管 proposal、design、spec、tasks
- workflow 需要直接依賴 OpenSpec artifacts

不適合：
- repository 使用其他 planning system
- 團隊偏好用 issue、ticket 或一般文件做輕量規劃
- 執行環境沒有安裝 OpenSpec

### `specialized-agents/`

提供較明確分工的專用 agents：
- `domain`
- `server`
- `reference-alignment`
- `test-guard`

適合：
- repository 的架構邊界清楚
- 團隊希望把核心邏輯、介面層、參考系統比對、測試策略分開處理
- 核心 workflow agents 對這個 codebase 來說太通用

不適合：
- repository 很小，核心 agents 就夠了
- 額外角色只會增加複雜度
- 團隊偏好更少、更寬鬆的 prompt

## 安裝方式

只複製你需要的 extension，然後把裡面的 `.claude/` 內容合併到目標 repository 的根目錄 `.claude/`。

複製後建議：
1. 檢查 prompt 內容，刪掉不適合目標 repository 的規則
2. 如果 extension 會影響團隊使用 workflow 的方式，同步調整 `CLAUDE.md`
3. 如果 extension 引入了新的指令，再去更新 `.claude/settings.local.json`
