# 微信底栏角标修复 2.1-9

已在当前 2.1-6 源码基线上完成修复、主机回归、Rootless/Rootful 全量编译和安装包校验。交付版本为 **2.1-9**。尚未安装到设备，本文的通过结果均不表示微信真机验收已完成。

## 问题与修复后的行为

原链路把“当前没有可靠未读快照”与“真实未读为零”都表示为 `@0`。设置密友／密群后，微信新消息回调会先进入原生数据事务，再同步写底栏角标；这时快照正在失效，旧 Hook 就把微信传入的正数改成零。数据稍后恢复时只刷新分组顶部角标，底栏没有可靠的补发入口。主列表离屏、关闭聊天分组，以及临时显示但仍启用消息静默时，还可能长期没有可供底栏使用的 UI 快照。

本版将底栏的显示决策拆成原生透传、等待可靠来源、可靠数字／纯红点三种状态，并为底栏维护独立的只读数据来源。普通消息刷新期间保留同账号、同策略和同 UI 对象下已验证的显示；当前原生数据稳定后发布新的结果。在聊天页、设置页或关闭聊天分组时仍可维护计数，数据维护不执行列表 reload、layout 或滚动位置恢复。

| 场景 | 修复后的行为与主机验证 |
| --- | --- |
| 受保护会话数字 3，普通会话数字 7 | 隐藏或启用消息静默时，底栏显示 7。普通会话再来一条显示 8，读完后按当前剩余普通未读减少。 |
| 原生事务或来源暂不可用 | 同一有效身份下保留已验证的 7，不把未知值写成数字 0；数据恢复后主动更新。 |
| 普通会话只有原生纯红点 | 通过微信原生 dot API 保留红点。真实数字零且无点时才写数字 0。 |
| 主列表离屏、分组关闭 | 在前台按原生模型事件只读重建计数，更新底栏；后台不扫描，返回前台后补算。 |
| 临时显示，`silenceMessages=YES` | 继续排除受保护会话，保留 2.1-6 的既有口径。 |
| 清空最后一个密友／密群，或关闭保护 | 对插件曾改写的当前目标主动恢复当前原生数字／纯红点，随后交还微信自己的 number/string/dot 输出；不需要再等一条新消息。 |
| 恢复时聊天列表尚未 attach | 保存当前 root 的账号／epoch 恢复请求，后续 attach 后完成一次可靠来源构建；请求不携带旧数字，也不授予可信显示凭据。 |
| 账号、epoch、策略或目标对象变化 | 失效旧显示；不借另一 root 的来源确认当前 root，不回放旧账号排队的微信角标值。 |
| 通讯录／发现等其他 tab | 原始数字、字符串及纯点更新正常透传，包括后台排队期间策略发生变化的情况。 |

## 实现范围

- `CSGroupListAdapter.h/.m`：增加底栏专用决策、来源缓存及来源通知；用 account/epoch/modelRevision/policy 前后校验只读构建结果。来源请求由 attach、原生事务结束、策略变化和前台活动等事件唤醒，合并同一轮请求，没有固定延时或轮询。
- `CloseFriendNotificationHooks.xm`：数字、字符串和纯点三个入口使用同一决策；操作原生 `customTabBar → item → badgeView`，不新建 badge。主动恢复核验实际 root、原生 logic、sourceRevision 和 UI 对象，并处理原生 setter 同步重入后的最终写入覆盖。
- 只有可靠结果能建立可复用显示凭据；Pending 和边界隐藏保留恢复义务。重复同值去重，发布最多同步协调两轮，确有新事件时再排主队列处理。
- `control`、`CSUserInfoHelper.h`、内置更新说明和项目 README 同步为 2.1-9。

现有通知／App 图标 getter、非 tab 通知与通话 Hook、原 `ChatTab` 判定及策略 observer 的通知／App 图标前缀均逐字保持一致，见 [preserved-methods.json](preserved-methods.json)。底栏专用过滤条件仍为 `concealsSession || (enabled && silenceMessages)`，且实际保护名单非空；未修改密友存储、隐藏策略、投影数学或底栏几何。

完整源码差异见 [production.patch](production.patch)，版本与说明差异见 [release.patch](release.patch)，测试差异见 [tests.patch](tests.patch)。

本次开始前保存的 1,866 项文件中，1,853 项原样、13 项按上述范围修改，另新增一个底栏测试文件；没有文件缺失。最终源码仍与构建输入及专项测试采样 SHA 一致，见 [范围与输入校验](preservation-result.json)。差异基于本次保存的 2.1-6 工作区副本，未把工作区原有改动混入本次修复。

## 验证证据

旧 2.1-6 的真实 getter 和三个 Hook block 已在隔离副本重放：**编译 exit 0，行为测试 exit 1**。三项失败分别为已验证 7 被 Pending 清零、可靠来源恢复却不补发、普通纯红点丢失。见 [red/result.json](red/result.json) 与 [原始失败日志](red/legacy-regression.log)。这不是编译失败，也不是设备现场记录。

最终回归结果：

| 测试 | 结果 |
| --- | --- |
| 通知及底栏专用输出 | 原有 alerts **216** + tab badge **897** 项通过；[日志](validation/close-friend-alerts.log)。 |
| 分组／来源生命周期 | **140** 项，0 失败；[日志](validation/group-lifecycle.log)。 |
| 分组角标 | **136** 项，0 失败；[日志](validation/group-badges.log)。 |
| 未读增量 | **180** 项，0 失败；[日志](validation/group-incremental.log)。 |
| 分组交互 | **124** 项，0 失败；[日志](validation/group-interactions-fixture-repaired.log)。 |
| 分组搜索／顶部栏／业务行 | **54 / 46 / 633** 项，均 0 失败；[搜索](validation/group-search.log)、[顶部栏](validation/group-header.log)、[业务行](validation/group-business.log)。 |
| 密友会话及会话呈现 | **148 + 44** 项，0 失败；[日志](validation/close-friend-session.log)。 |
| 分组视口 | **72** 项，0 失败；[日志](validation/group-viewport.log)。 |
| 底栏布局与原生生命周期 | geometry PASS、点击效果 **39** 项通过、preferences/native lifecycle PASS；[日志](validation/tabbar.log)。 |

底栏套件直接抽取生产决策、getter、Hook 和发布代码，source-ready 事件为明确控制的 host 边界；生命周期套件另执行生产 request/build/begin/end/通知逻辑，覆盖离屏 20 条独立消息、200 条 burst 合并、事务内不发布、读取中 epoch/revision 变化、前后台、分组关闭与静音过滤，以及延迟 attach 的恢复请求。新边界还包括持续同步来源通知、自然 setter 嵌套新来源、Native 恢复途中策略／来源变化和非聊天 tab 排队透传。[专项机器摘要](validation/tab-badge-suite-results.json) 记录最终来源 SHA。

分组交互最初暴露 13 条既有 host 替身编译缺口；已补齐 privacy/epoch 依赖与 context epoch。相同抽取脚本对 baseline 和当前生产源生成的三份输入逐字节相等，修复后的同一 fixture 分别搭配 baseline／当前源均为 124 项通过，见 [对照结果](validation/group-interactions-fixture-parity.json)。视口与搜索也只补测试替身依赖，未降低生产校验或删去原断言。

这些测试验证状态、原生 API 参数、对象归属与事件衔接，不覆盖真实微信全部私有数据表现、设备渲染、免打扰与 @ 提醒的所有映射及真机性能。原生行中的“以点呈现”字段没有被擅自等同于免打扰开关。

## 构建与交付

两方案均以全新独立 Theos 目录完整编译，编译前后生产输入 SHA 一致。每方案约 27 秒，exit 0；每方案仅 6 条历史警告：两架构各一条 `UILocalNotification`、`statusBarFrame` 弃用警告及链接器旧选项警告，无新增。见 [构建结果](build-result.json)、[Rootless 日志](build-rootless.log) 与 [Rootful 日志](build-rootful.log)。

| 方案 | 包架构 | dylib 架构／最低 iOS | 安装路径 |
| --- | --- | --- | --- |
| Rootless | iphoneos-arm64 | arm64 + arm64e／15.0 | `/var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib` |
| Rootful | iphoneos-arm | arm64 + arm64e／15.0 | `/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib` |

包版本、注入 Filter、双架构、最低系统、路径及四个 dylib/dSYM UUID 均通过；symbols ZIP 包含 12 个文件且 CRC 通过。[包校验结果](package-verification.json) 及 [SHA256SUMS](../../../packages/2.1-9-wechat-badge/SHA256SUMS) 可复核。

- [Rootless 安装包](../../../packages/2.1-9-wechat-badge/com.wechat.improve_2.1-9_iphoneos-arm64.deb)
- [Rootful 安装包](../../../packages/2.1-9-wechat-badge/com.wechat.improve_2.1-9_iphoneos-arm.deb)
- [调试符号](../../../packages/2.1-9-wechat-badge/com.wechat.improve_2.1-9_symbols.zip)

本轮未运行 `make clean`，未重置工作区；开始前登记的 **1,264 项**历史 `.theos/` 和 `packages/` 文件全部保持原 SHA，见 [保存校验](historical-artifact-preservation.json)。没有启动服务、改变端口、连接设备、安装插件或操作用户账号／聊天数据库。实际加载版本尚未读取，真机当前环境没有被更新。

包核验脚本按 plist 结构比较 Theos 转换后的 Filter，并用 `otool -arch all` 核验两架构最低系统；这两项检查的脚本适配未改变生产代码或包内容。[构建脚本](build-packages.py) 与 [校验脚本](verify-packages.py) 保存了完整命令。

## 安装后的验收步骤（待执行）

1. 在同一微信账号中准备普通会话未读 7、受保护会话未读 3。隐藏密友后应显示 7；普通会话再来一条应为 8，受保护会话新消息不增加这个数字，普通未读清完后按实际剩余显示或隐藏。
2. 留在聊天页或插件设置页接收普通消息，再返回首页；分别开关聊天分组和底栏样式，核对数字持续更新。检查纯红点、真实零和 99+，并分别验证普通免打扰与 @ 提醒。
3. 临时显示且保留消息静默时，继续沿用当前排除口径；关闭静默且没有会话隐藏时应回到原生显示。清空最后一个保护对象／关闭保护后，应自动恢复原生总数或纯点，无需等待新消息。
4. 切换底栏、前后台及账号；确认其他 tab 正常更新、旧账号数字不残留。记录设备、iOS、微信版本、注入方案、包 SHA 与实际截图／日志后，才能给出真机通过结论。
