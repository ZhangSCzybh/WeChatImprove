# 2.2-17 原始回归失败的限定豁免

**100 个原始脚本中 18 个仍未通过，本轮按用户授权豁免。** 原始统计仍为 script_count=100、passed=82、failed=18；失败不计为通过。该豁免仅用于本次 2.2-17 正式出包，不自动延伸到其他版本、任何新失败或七项核心回归。

授权来源：[USER-AUTHORIZATION.md](USER-AUTHORIZATION.md)，为当前任务用户 2026-11-06 明确授权消息的原文留档。本文件逐项记录其适用范围。用户明确表示：“本次授权豁免这 18 个，按「本次新增 + 列明核心回归全部通过」出包。这一条覆盖我之前说的「任何一项失败不许出包」。”

gate_status：`waived_by_user_explicit_authorization; 18 baseline failures accepted for 2.2-17`。不是 pass、green 或 all-clear。

| 脚本 | 原退出码 | 冻结 .16 复现 | 分类 | 与本次改动无关的依据 | 豁免授权来源 |
| --- | ---: | --- | --- | --- | --- |
| `verify-close-friend-alerts.sh` | 1 | 是；exit=1，完整诊断文案及重复次数一致 | `existing_fixture_compile_incompatibility` | 旧夹具缺少 CSGroupListAdapter 的 usesNativeSessionModel、tabBadgeSections 等原生会话属性；冻结 .16 同样 7 条诊断，本次未改该 adapter。 | [用户明确授权原文](USER-AUTHORIZATION.md)，本文件逐项记录 |
| `verify-close-friend-entry.sh` | 1 | 是；exit=1，完整诊断文案及重复次数一致 | `existing_fixture_compile_incompatibility` | 旧夹具缺少 .16 已新增的点击手势及页面 token 声明，冻结 .16 同样 20 条诊断；补声明后的原单手势断言也与 .16 双手势行为冲突，本次只改头像风险文案。 | [用户明确授权原文](USER-AUTHORIZATION.md)，本文件逐项记录 |
| `verify-close-friend-recovery.sh` | 1 | 是；exit=1，完整诊断文案及重复次数一致 | `existing_fixture_compile_incompatibility` | 旧 UIKit 夹具缺少标题目标、window/navigationItem 等语义，冻结 .16 同样 7 条诊断；生产首页 recovery 整段字节保持 .16。 | [用户明确授权原文](USER-AUTHORIZATION.md)，本文件逐项记录 |
| `verify-close-friend-session.sh` | 1 | 是；exit=1，完整诊断文案及重复次数一致 | `existing_fixture_compile_incompatibility` | 旧夹具缺少原生 session coordinator 与 adapter 声明，冻结 .16 同样 20 条诊断；本次未改 session groups 实现。 | [用户明确授权原文](USER-AUTHORIZATION.md)，本文件逐项记录 |
| `verify-close-friend-unread-panel.sh` | 1 | 是；exit=1，完整诊断文案及重复次数一致 | `existing_fixture_compile_incompatibility` | 旧夹具缺少 CSGroupNativeSessionCoordinator 等声明，冻结 .16 同样 3 条诊断；本次未改未读面板实现。 | [用户明确授权原文](USER-AUTHORIZATION.md)，本文件逐项记录 |
| `verify-group-appearance.sh` | 1 | 是；exit=1，完整诊断文案及重复次数一致 | `existing_fixture_compile_incompatibility` | 旧 group appearance 夹具与原生会话 adapter 接口不匹配，冻结 .16 同样 5 条诊断；本次未改聊天分组外观实现。 | [用户明确授权原文](USER-AUTHORIZATION.md)，本文件逐项记录 |
| `verify-group-badges.sh` | 1 | 是；exit=1，完整诊断文案及重复次数一致 | `existing_fixture_compile_incompatibility` | 旧 group badge 夹具缺少当前原生 session adapter 接口，冻结 .16 同样 11 条诊断；本次未改分组角标实现。 | [用户明确授权原文](USER-AUTHORIZATION.md)，本文件逐项记录 |
| `verify-group-business.sh` | 1 | 是；exit=1，完整诊断文案及重复次数一致 | `existing_fixture_compile_incompatibility` | 旧 group business 夹具与当前 adapter 声明不匹配，冻结 .16 同样 9 条诊断；本次未改业务行实现。 | [用户明确授权原文](USER-AUTHORIZATION.md)，本文件逐项记录 |
| `verify-group-incremental.sh` | 1 | 是；exit=1，完整诊断文案及重复次数一致 | `existing_fixture_compile_incompatibility` | 旧增量夹具缺少当前原生 coordinator/adapter 接口，冻结 .16 同样 20 条诊断；本次未改分组增量实现。 | [用户明确授权原文](USER-AUTHORIZATION.md)，本文件逐项记录 |
| `verify-group-interactions.sh` | 1 | 是；exit=1，完整诊断文案及重复次数一致 | `existing_fixture_compile_incompatibility` | 旧交互夹具缺少当前 adapter 接口，冻结 .16 同样 20 条诊断；本次未改分组交互实现。 | [用户明确授权原文](USER-AUTHORIZATION.md)，本文件逐项记录 |
| `verify-group-lifecycle.sh` | 1 | 是；exit=1，完整诊断文案及重复次数一致 | `existing_extractor_contract_incompatibility` | 旧方法提取器合同与 .16 源码形态不匹配，冻结 .16 同样 AssertionError；本次未改分组生命周期源码或提取器。 | [用户明确授权原文](USER-AUTHORIZATION.md)，本文件逐项记录 |
| `verify-group-search.sh` | 1 | 是；exit=1，完整诊断文案及重复次数一致 | `existing_fixture_compile_incompatibility` | 旧搜索夹具缺少当前原生 coordinator/adapter 接口，冻结 .16 同样 20 条诊断；本次未改分组搜索实现。 | [用户明确授权原文](USER-AUTHORIZATION.md)，本文件逐项记录 |
| `verify-group-selection.sh` | 1 | 是；exit=1，完整诊断文案及重复次数一致 | `existing_fixture_compile_incompatibility` | 旧选择夹具缺少 beginUserDragging/beginUserScrolling/restorePendingViewport 等接口，冻结 .16 同样 9 条诊断；本次未改选择/滚动实现。 | [用户明确授权原文](USER-AUTHORIZATION.md)，本文件逐项记录 |
| `verify-group-viewport.sh` | 1 | 是；exit=1，完整诊断文案及重复次数一致 | `existing_extractor_contract_incompatibility` | 旧 viewport 提取器合同与 .16 源码形态不匹配，冻结 .16 同样 AssertionError；本次未改分组 viewport 源码或提取器。 | [用户明确授权原文](USER-AUTHORIZATION.md)，本文件逐项记录 |
| `verify-miniapp-first-frame.sh` | 1 | 是；exit=1，完整诊断文案及重复次数一致 | `existing_fixture_compile_incompatibility` | 旧夹具抽取及声明与当前原生会话/滚动接口不匹配，冻结 .16 同样 20 条诊断；本次未改小程序首帧实现。 | [用户明确授权原文](USER-AUTHORIZATION.md)，本文件逐项记录 |
| `verify-miniapp-private-layout.sh` | 1 | 是；exit=1，完整诊断文案及重复次数一致 | `existing_fixture_compile_incompatibility` | 旧夹具抽取及声明与当前原生会话/滚动接口不匹配，冻结 .16 同样 20 条诊断；本次未改小程序布局实现。 | [用户明确授权原文](USER-AUTHORIZATION.md)，本文件逐项记录 |
| `verify-privacy-admission-cache-events.sh` | 1 | 是；exit=1，完整诊断文案及重复次数一致 | `existing_fixture_compile_incompatibility` | 旧夹具缺少原生 coordinator/admission adapter 接口，冻结 .16 同样 12 条诊断；本次未改隐私 admission cache 实现。 | [用户明确授权原文](USER-AUTHORIZATION.md)，本文件逐项记录 |
| `verify-privacy-admission-cache.sh` | 1 | 是；exit=1，完整诊断文案及重复次数一致 | `existing_fixture_compile_incompatibility` | 旧夹具缺少原生 coordinator/admission adapter 接口，冻结 .16 同样 12 条诊断；本次未改隐私 admission cache 实现。 | [用户明确授权原文](USER-AUTHORIZATION.md)，本文件逐项记录 |

分类合计：16 个 `existing_fixture_compile_incompatibility`，2 个 `existing_extractor_contract_incompatibility`。另有 1 处 `avatar receives exactly one recognizer` 行为断言冲突属于上述 `verify-close-friend-entry.sh` 的补充诊断，不是第 19 个豁免脚本。

原始 REGRESSION-GATE.md 完整字节保留；REGRESSION-GATE.json 只更新 gate_status 并新增授权元数据。原 script_count/passed/failed、100 条 runs、18 条 failures、退出码与诊断均不变；修改前原件另存 pre-waiver-gate/。逐项日志和脚本 SHA256 继续以原 REGRESSION-GATE.json 为准。

本次正式出包前另执行未获豁免的原 82 个脚本，以及七项核心回归。重跑时仅跳过此表 18 个；不能把新失败加入本表。核心回归与其余脚本任一失败都停止出包，不改断言、夹具、测试期望或生产门槛。正式重跑结果单独保存，不覆盖原始 100 个脚本结果。

真机手势、UIKit 转场与首帧、间距观感、iOS Keychain 及设备强杀恢复均未验证；豁免不构成这些设备行为的验证证据。
