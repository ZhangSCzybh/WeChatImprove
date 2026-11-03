# 2.2-11 聊天列表位置修复与分组代码清理

本版修复聊天返回和切换分组后的滚动位置。用户明确确认：**切组沿用切换前的当前滚动高度，与旧修复一致**。从聊天返回时则恢复离开列表时的高度，目标组较短时夹在其实际可滚动边界内；不为各组分别恢复历史高度。

本次使用原 checkout `/Users/zhangshichao/Documents/Workspace/WeChatImprove`。没有安装手机包、重启微信、切换账号或修改设备配置、会话和聊天记录；没有新 Instruments 采样。设备背景为用户此前确认的原包名 `com.tencent.xin`、微信 8.0.78、iOS 27.0.1，最终真机工作流仍待安装后验收。

直接原因是 `viewDidAppear:` 尾部强制回顶，以及切组时设置回顶状态并删除目标锚点。当前修复在首次离页、修改选组及源刷新之前捕获有效高度；在宿主出现回调、内容发布和布局完成后恢复。未完成布局、隐私或交互校验时保留请求，由已有事件继续处理。恢复写入后再次检查 table 身份、最终 inset/contentSize 与实际落点，成功后才清除请求。点击已选组保持位置；用户主动拖动、原生回顶、搜索和原生导航覆盖旧请求。连续受阻的 A → B → C 切组沿用同一有效高度；删除待选组或偏好拒绝写入后正确收尾，避免阻塞后续同组行锚点。

源代码历史显示同类恢复曾在 2.1-25 实现，后续源码回退时丢失。用户确认至少在已安装的 2.2-8 观察到问题；源码谱系不能确定设备首次发生的具体版本，详见 [只读历史证据](review/history.md)。本版没有整体恢复旧代理或旧隐私实现。

本次按用户追加要求清理整个分组链路：删除 `CSGroupPerformanceObservation.h/.m`、`SessionGroupPerformanceObservation.xm` 三个观测文件（共 484 行），以及 Makefile 的观测开关、过滤分支和编译宏。位置修复后，旧 `returnToGroupTop` 已无生产调用方，因此删除该入口、唯一由其置位的 `pendingScrollToTop`、`applyPendingScrollToTop` 及相关死条件。UIKit 原生回顶继续工作。同组消息刷新仍保留行锚点，已知变化名单、80–250ms 消息合并、元数据与角标复用、受影响可见行刷新和账号/隐私保护均保留；没有新增轮询或逐帧任务。

静态检查覆盖分组核心、分组栏和 Hook；交付检查另扫描当前 Controllers、Hooks、Headers 与 Makefile，确认观测名称和旧回顶状态不再存在。逐架构二进制检查确认没有观测标记、观测 API 或 signpost 导入。此前正式 2.2-10 已默认排除观测编译，本次删除主要简化生产源码与构建入口；不据此声称手机 CPU、Core Animation 提交或掉帧已有量化下降。

本轮验证记录如下，所有最终证据绑定同一份生产源码：

| 验证 | 结果与范围 |
| --- | --- |
| 新增滚动行为 | 199 项通过；提取实际 Adapter、生命周期 Hook、拖动/回顶回调及兼容转发方法，编译真实模型、协调器、桥接、投影、偏好和隐私模块。UIKit 替身延迟到布局阶段才更新内容高度并模拟宿主 clamp，检查实际落点、请求消费和后续锚点 |
| 既有核心回归 | 4052 项通过：native 3382、未读面板 77、ABI 7、legacy 392、独立交互 101、兼容刷新/发布 93；2994 项选择子集包含在 native 中，不重复计数 |
| 与上轮计数差异 | 上轮核心 4055；本轮删除 native、compat、legacy 各 1 条针对已删除插件回顶状态的无效断言。结构、特殊行和隐私安全断言保留。合计本轮不同功能断言 4251 项 |
| 负对照 | 16 个均捕获预期行为失败：保留原 10 个，新增旧版切组/返回及失败恢复被提前消费、跳过最终出现收尾、copy 身份、偏好拒绝读回 6 个。不是编译失败代替行为失败 |
| 可选私有接口安装 | 7 种运行时场景、69 项断言通过，覆盖缺失方法/类、直接与继承 YES/NO、错误 ABI；macOS runtime 替代 Substrate 的安装动作 |
| SDK 检查 | 真实 iPhoneOS SDK，Adapter 与生成后的 SessionGroupHooks 各在 arm64、arm64e 检查，共 4 项通过 |
| 未改分组栏 | 本版源码 SHA 与已封存 2.2-10 的 135 项 UI 检查一致，直接继承证据，本轮没有重复运行或计入 4251；已删除观测模块的旧 63 项不继承 |
| 构建与交付 | Rootless、Rootful 均编译成功，每包包含 arm64/arm64e；包元数据、版本、dSYM UUID、逐架构删除结果与源码哈希核对通过 |

上述功能回归在 macOS Foundation 和受控宿主/UI 边界运行，不代替真机 UIKit、私有接口兼容性或物理滚动流畅性验收。没有使用主机断言数量推算手机 CPU 或耗电。独立复审见 [复审说明](review/independent-review.md)，实际断言、负对照和夹具限制见 [验证说明](validation/README.md)。

交付目录：[`packages/2.2-11-session-groups-scroll-position-final`](../../../packages/2.2-11-session-groups-scroll-position-final/)。仅提供正式包，不再输出独立观测版。

| 产物 | SHA-256 |
| --- | --- |
| [Rootless](../../../packages/2.2-11-session-groups-scroll-position-final/com.wechat.improve_2.2-11_iphoneos-arm64.deb) | `983d4fffa57110f35c3d3e725700ba5e94948e78d88934130c1f730f0fc4504b` |
| [Rootful](../../../packages/2.2-11-session-groups-scroll-position-final/com.wechat.improve_2.2-11_iphoneos-arm.deb) | `dc9ec629fe4fd4ad65a7e94e5fec9a824dad102257a4d61c1a91fdd1ee33c03e` |
| [调试符号](../../../packages/2.2-11-session-groups-scroll-position-final/com.wechat.improve_2.2-11_symbols.zip) | `56428b1b0030ca885110eaefab84cf214e3cfc9166d51ff9bf32740a0e84fa52` |

调试符号单独归档，不是注入手机的调试代码。构建在冻结副本使用隔离输出目录完成，没有运行根目录 `make clean`。原有 6892 条 tracked 删除保持，根 `Tests/` 没有恢复，123 份历史 deb/zip 保持；2.2-8/2.2-9 真机采样及 2.2-10 审计记录逐文件校验保持原样。

最终源码差异见 [source-changes.json](source-changes.json)，构建见 [build-result.json](builds/final/normal/build-result.json)，产物完整性见 [delivery-integrity.json](delivery-integrity.json)，总体验证见 [final-evidence-integrity.json](final-evidence-integrity.json)。[evidence-manifest.sha256](evidence-manifest.sha256) 对本次审计目录封存；历史审计只读，不被重新封存或改写。
