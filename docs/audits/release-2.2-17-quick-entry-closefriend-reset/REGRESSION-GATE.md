# 2.2-17 全量原脚本与出包门槛

原始 **100 个 verify 脚本全部实跑：82 通过、18 失败、0 安全跳过**。原 277 个文件字节保持一致。18 个失败均使用冻结的 2.2-16 对照，同一脚本复现相同退出码及完整错误文案多重集；新增失败诊断多重集为 0。不能将这些失败写成通过。

用户本次要求“任何一项失败不许出包”。负责人已就旧脚本失败的门槛范围请求澄清；答复前保留门槛，**没有生成 2.2-17 deb、symbols.zip 或 packages/2.2-17 交付目录**。候选仅 make all 编译，不属于出包。

| 失败原脚本 | 当前 exit | 冻结 .16 exit | 诊断条数（含重复） | 对照 | 分类 |
|---|---:|---:|---:|---|---|
| `verify-close-friend-alerts.sh` | 1 | 1 | 7 | 同文案、同重复次数 | 旧宿主夹具编译失配 |
| `verify-close-friend-entry.sh` | 1 | 1 | 20 | 同文案、同重复次数 | 旧宿主夹具编译失配 |
| `verify-close-friend-recovery.sh` | 1 | 1 | 7 | 同文案、同重复次数 | 旧宿主夹具编译失配 |
| `verify-close-friend-session.sh` | 1 | 1 | 20 | 同文案、同重复次数 | 旧宿主夹具编译失配 |
| `verify-close-friend-unread-panel.sh` | 1 | 1 | 3 | 同文案、同重复次数 | 旧宿主夹具编译失配 |
| `verify-group-appearance.sh` | 1 | 1 | 5 | 同文案、同重复次数 | 旧宿主夹具编译失配 |
| `verify-group-badges.sh` | 1 | 1 | 11 | 同文案、同重复次数 | 旧宿主夹具编译失配 |
| `verify-group-business.sh` | 1 | 1 | 9 | 同文案、同重复次数 | 旧宿主夹具编译失配 |
| `verify-group-incremental.sh` | 1 | 1 | 20 | 同文案、同重复次数 | 旧宿主夹具编译失配 |
| `verify-group-interactions.sh` | 1 | 1 | 20 | 同文案、同重复次数 | 旧宿主夹具编译失配 |
| `verify-group-lifecycle.sh` | 1 | 1 | 1 | 同文案、同重复次数 | 旧提取器合同失配 |
| `verify-group-search.sh` | 1 | 1 | 20 | 同文案、同重复次数 | 旧宿主夹具编译失配 |
| `verify-group-selection.sh` | 1 | 1 | 9 | 同文案、同重复次数 | 旧宿主夹具编译失配 |
| `verify-group-viewport.sh` | 1 | 1 | 1 | 同文案、同重复次数 | 旧提取器合同失配 |
| `verify-miniapp-first-frame.sh` | 1 | 1 | 20 | 同文案、同重复次数 | 旧宿主夹具编译失配 |
| `verify-miniapp-private-layout.sh` | 1 | 1 | 20 | 同文案、同重复次数 | 旧宿主夹具编译失配 |
| `verify-privacy-admission-cache-events.sh` | 1 | 1 | 12 | 同文案、同重复次数 | 旧宿主夹具编译失配 |
| `verify-privacy-admission-cache.sh` | 1 | 1 | 12 | 同文案、同重复次数 | 旧宿主夹具编译失配 |

entry 原脚本的 20 条编译错误与 .16 相同；另以附加声明/链接兼容层保留原断言真实执行后，失败于 `avatar receives exactly one recognizer`。该断言要求单手势，与 .16 已发布双手势共存行为冲突；没有过滤 tap，没有改旧断言。详见 regression/entry-compatibility/。

alerts 等旧夹具缺少新增原生 session adapter 声明；recovery 缺少标题目标、window/navigationItem 等 UIKit 夹具语义；session/unread 与 group/miniapp/admission 夹具及提取器也使用旧接口。这里只诊断，不为无关模块改生产或旧断言。安全的附加声明尝试单独留档，不能回写原文件或把 raw 失败伪装成通过。

指定门槛的现代回归另已全部通过：消息/布局六套 1,048,295；production compact 1,436（2pt / normal21、24pt）；.14 四项；.16 rollback/migration232；旧 quick-entry90。各原始日志、命令、源码和夹具 provenance 在本审计内。

逐项 100 状态、18 组当前/基线日志路径、诊断多重集、断言脚本 SHA256 见 REGRESSION-GATE.json。没有真机验证。
