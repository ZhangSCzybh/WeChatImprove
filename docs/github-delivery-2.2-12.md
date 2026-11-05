# GitHub 交付范围：2.2-12

本次提交修复从聊天会话返回列表后，手指快速滑到顶部又跳回旧位置的问题。用户拖动开始时清除旧待恢复高度和行锚点，使拖动前捕获的快照失效；表格现有 pan 手势提供独立的开始通知。原生和兼容入口保留横滑分组准入，聊天返回与切组继续沿用已确认的高度规则。正式版本为 `2.2-12`。

本次上传生产与版本说明变更、Rootless/Rootful 安装包及符号、小体积验证夹具、脚本、日志、结果和独立审阅。功能验证通过 4317 项不同断言：4052 项核心、199 项原有位置和 66 项新增拖动接管检查。两种包均包含 arm64 / arm64e，包与最终测试、审阅的源码哈希一致。未进行本轮真机安装验收或新的 Instruments 测量。

## 仓库与本地封存的边界

完整本地归档位于 `docs/audits/session-groups-quick-top-2026-11-05/`。重复的 `baseline-2.2-11/`、完整基线哈希 `baseline.json`、工作区快照 `initial-status.z`、本地媒体说明 `video-analysis.json` 继续保留本地。用户视频和聊天截图未纳入本次提交。既有 6892 条文件删除、Finder 缓存、Python 缓存和其他未跟踪历史文件不纳入本次提交。

audit 的原始 `evidence-manifest.json` 保持封存时内容，描述完整本地归档，因此可能引用未上传文件；它不是 GitHub 子集的完整性声明。此次实际上传的文件及 SHA-256 见 [GitHub 子集清单](github-delivery-2.2-12-manifest.json)。该清单列出除清单本身之外的本次交付文件。

`verify-delivery.py` 是完整本地归档复核入口，依赖本地基线、初始工作区状态和历史安装包，不能直接作为新克隆仓库的复核入口。仓库中的安装包可直接使用 [SHA256SUMS](../packages/2.2-12-session-groups-quick-top-final/SHA256SUMS) 核对。

## 当前源码验证入口

在仓库根目录、已配置 Xcode 命令行工具的 macOS 上执行。测试使用临时可执行文件、内存配置以及 UIKit/微信替身，不连接设备、不恢复根 `Tests/`。旧比较 wrapper 引用其他历史基线，不属于本次执行入口。

```sh
# 核心原生：3382
bash docs/audits/session-groups-quick-top-2026-11-05/validation/run-native-behavior.sh
# 位置及生命周期：199；新增手指接管：66
WECHAT_SCROLL_POSITION_ONLY=1 bash docs/audits/session-groups-quick-top-2026-11-05/validation/run-native-behavior.sh
WECHAT_QUICK_TOP_ONLY=1 bash docs/audits/session-groups-quick-top-2026-11-05/validation/run-native-behavior.sh
# 兼容：93；交互调度：101
WECHAT_COMPATIBILITY_ONLY=1 bash docs/audits/session-groups-quick-top-2026-11-05/validation/run-native-behavior.sh
WECHAT_INTERACTION_ONLY=1 bash docs/audits/session-groups-quick-top-2026-11-05/validation/run-native-behavior.sh
# 未读与 ABI：77 + 7；历史核心：392
bash docs/audits/session-groups-quick-top-2026-11-05/validation/run-unread-panel.sh
python3 docs/audits/session-groups-quick-top-2026-11-05/validation/run-legacy-core.py --output-dir github-check
```

旧源码在模型中的三类失败日志已保留。需要重建 2.2-11 的测试源码时，从固定提交 `25081b45353314261b59a3cc819341d5dce84824` 将 `Controllers`、`Hooks` 导出到新的临时目录；将 `WECHAT_VALIDATION_SOURCE_ROOT` 指向该目录，再配合 `WECHAT_QUICK_TOP_ONLY=1` 和 `WECHAT_QUICK_TOP_PROBE=table-pan`、`anchor` 或 `source` 运行当前夹具。无需切换或覆盖正在工作的 checkout。三种基线捕获均在首个原生路径位置断言处失败，不能视为真机回调栈证据。

## 主要入口

- [当前说明](../README.md)
- [修复与交付记录](audits/session-groups-quick-top-2026-11-05/README.md)
- [实际验证范围](audits/session-groups-quick-top-2026-11-05/validation/README.md)
- [最终验证结果](audits/session-groups-quick-top-2026-11-05/validation/final-result.json)
- [独立审阅](audits/session-groups-quick-top-2026-11-05/review/independent-quick-top-review.md)
- [2.2-12 安装包](../packages/2.2-12-session-groups-quick-top-final/)
