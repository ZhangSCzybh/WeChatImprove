# WeChatImprove 2.4-4 群聊工具审计

## 实施方案（基于当前 2.4-3-1）

1. **昵称与备注。** 原生 `CContact.m_nsNickName` 用于微信昵称，`ChatRoomData.getDislayNameForUserName:` 用于群内备注。完整快照分别携带两者；欢迎文案的可见名称与 `setM_nsAtUserList:` 所用成员 ID 分开。昵称缺失时用群备注，再用成员 ID；备注缺失时用空字符串。通知模板共享一次替换，保留现有本地资料链接及转义。
2. **通知发送本群。** 在退群监控添加默认关闭的 `departureSendToRoom` 和独立的 `departureRoomTemplate` 多行设置。继续插入原群中仅自己可见的原有本地提示。开启时另用现有微信文本发送路径，目标固定为该成员离开的群，不给已经离群的人发 @ 提醒。当前基线没有私聊／指定会话通知目标的实现或配置，保持原有路由。
3. **移出成员。** `CGroupMgr.OnDeleteChatRoomMemberResponse:` 及其请求／响应结构是当前头文件中可识别的管理员移出信号；成功结果触发完整名单刷新，核对离群成员后才发通知。现有联系人／远端系统消息钩子继续触发完整名单请求，名单差分可检测任一来源的离群。不能证明原因时明确为未确认，不根据本地化提示或成员消失推断主动退出。
4. **回前台补齐。** 当前管理器进入后台关闭入站和发送，回前台又清空名单。保留同一进程、账号和配置下最后一份已验证名单及未交给微信的欢迎任务；返回前台主动取完整名单后进行一次性差分和恢复。继续校验版本、账号、配置和成员身份，不增加后台定时器。挂起期间不承诺实时；从未建立名单、进程重启或名单净变化无法反映的中间事件不可恢复。

先验证现有群聊脚本；新增路径只使用本目录的临时核验（如需）。沿用工作区与原有构建缓存，版本同步为 2.4-4，生成独立的新发布目录。

## 实现与运行边界

| 需求 | 代码落点 | 实际行为 |
| --- | --- | --- |
| 1. 通知发送本群 | [群聊设置:376](../../../Controllers/CSGroupChatSettingsViewController.m#L376)、[配置校验:44](../../../Controllers/CSGroupChatStore.m#L44)、[原群发送:294](../../../Controllers/CSGroupChatManager.m#L294)、[原本地提示:19](../../../Controllers/CSGroupChatLocalNotice.m#L19) | 关闭时只走原有本地提示路径；开启后额外向事件群提交普通文本。本群文案独立编辑，保留原有本地昵称资料链接。发送前二次校验账号、配置、授权、群状态；提交状态不确定时不自动重发。2.4-3-1 当前源码没有私聊或指定会话的通知目标字段。 |
| 2. 微信昵称、群内备注与 @ | [成员资料回包:36](../../../Controllers/CSGroupChatRuntime.m#L36)、[原生昵称:91](../../../Controllers/CSGroupChatNativeAdapter.m#L91)、[模板渲染:28](../../../Controllers/CSGroupChatTemplate.m#L28)、[编辑预览:166](../../../Controllers/CSGroupChatSettingsViewController.m#L166)、[原生 @ 字段:109](../../../Controllers/CSMessageSendAdapter.m#L109) | 优先读完整回包中的 `nickName` / `displayName`，分别回退到 `CContact.m_nsNickName` / `ChatRoomData.getDislayNameForUserName:`。真实 @ 仍用成员 ID 写入 `m_nsAtUserList`，与显示文字分开。 |
| 3. 管理员移出成员 | [回包提取:111](../../../Controllers/CSGroupChatRuntime.m#L111)、[原生钩子:124](../../../Controllers/CSGroupChatRuntime.m#L124)、[证据关联:224](../../../Controllers/CSGroupChatManager.m#L224)、[版本与名单差分:17](../../../Controllers/CSGroupChatEventPolicy.m#L17) | 本账号发起移出时，`OnDeleteChatRoomMemberResponse:` 成功回包触发完整名单刷新；请求和回包共同确认的成员才有移出证据。随后仍要在可信完整名单中确认其消失。对其他管理员的操作，现有联系人／系统消息入口可以触发名单查询，名单消失可发通知，但当前没有确认所有远端移出和主动退群的逐人类型信号。该部分不能承诺完全区分。 |
| 4. 后台期间的欢迎和监控 | [生命周期:57](../../../Controllers/CSGroupChatManager.m#L57)、[名单接收:248](../../../Controllers/CSGroupChatManager.m#L248)、[恢复待发欢迎:310](../../../Controllers/CSGroupChatManager.m#L310)、[补查时间判断:38](../../../Controllers/CSGroupChatEventPolicy.m#L38) | 进入后台后不请求、不发消息，暂存同一进程内已有名单及未提交的欢迎。回前台主动请求完整名单，拒绝旧会话包与倒退版本。若首个回包仍是同版本，保留恢复对照供后续更新；重复回包没有新差分。仍在群且未过原截止时间的待发欢迎可恢复。冷启动、账号／配置切换、首次名单前的变化、前后名单相同的中间变化，以及拿不到完整回包的情形不能补齐。 |

管理员信号依据为 [CGroupMgr.h:104](../../../HeadersFile/CGroupMgr.h#L104)、[DelChatRoomMemberRequest.h:18](../../../HeadersFile/DelChatRoomMemberRequest.h#L18)、[DelChatRoomMemberResponse.h:18](../../../HeadersFile/DelChatRoomMemberResponse.h#L18) 和两者的嵌套 `memberName`。被移出的标记只与实际名单减少合并；整体成功但逐人证据缺失时仅请求刷新。现有本地模板原样保留，想在本地通知里看到区分可插入 `@离群类型`。

| 新增键（`configuration`） | 默认值 | 生效范围 |
| --- | --- | --- |
| `departureSendToRoom` | `false` | 仅已开启退群监控并选中的群 |
| `departureRoomTemplate` | 四行：`@昵称 已离开「@群昵称」`、`离群类型：@离群类型`、`检测时间：@时间`、`当前剩余 @群人数 人` | 仅「通知发送本群」开启时编辑和发送；非空，最多 4,000 个 UTF-16 代码单元 |

账号配置沿用微信沙盒 `Library/Preferences/WeChatImprove/GroupChatTools/<SHA256(accountID)>.plist`，备份域 `group_chat_tools`，保持 `schema/schemaVersion = 1`。旧配置与备份缺少新键时仍可读取，管理器在内存补默认值；读取不写回，保存沿用文件锁、原子替换及目录同步。诊断用 `.plist.members` 不作为运行队列加载或备份。工作区没有服务端口、URL 或数据库切换；未安装到微信，也未访问真实微信账号数据。

| 文案变量 | 最终取值 |
| --- | --- |
| `@昵称` | 微信昵称；缺失时用群内备注，再缺失时用成员 ID。欢迎文案显示 @ 文本并以成员 ID 提交真实提醒；本地退群通知可点昵称打开资料；本群退群文案为纯文本。旧模板继续识别此变量。 |
| `@备注` | 群内备注，缺失时为空；欢迎有多位成员时用「、」连接有备注的成员。不会触发 @ 提醒。 |
| `@群昵称` | 当前群聊名称。 |
| `@群人数` | 完整名单人数；欢迎提交前使用当时核对的名单。 |
| `@时间` | 本地时区 `yyyy-MM-dd HH:mm:ss`；欢迎渲染时刻或退群名单检测时刻。 |
| `@离群类型` | 仅两种退群文案。证据与差分匹配时为「被移出」；其余为「离群（原因未确认）」。欢迎编辑器不提供此变量。 |

模板只替换一次，昵称或备注内恰好出现的占位符不会被再次解释。空值、纯空白、原生占位字符串 `null` / `(null)` 视为缺失。欢迎的昵称和备注清除会破坏 @ 分段的换行和 U+2005；本地通知转义 XML 特殊字符并过滤 XML 无效控制字符；正常 emoji 保留。

## 核心回归

改前在本工作区记录了 [429 个生产输入 SHA-256](production-baseline.sha256)，且 `control` 为 2.4-3-1。按相同范围重跑，详见 [改前群聊脚本](baseline-core.log)、[改前管理器场景](baseline-manager-scenarios.log)、[2.4-4 群聊脚本](release-core.log) 和 [2.4-4 管理器场景](release-manager-scenarios.log)。

| 核心验证 | 通过 | 失败 |
| --- | ---: | ---: |
| 文案、差分与核心规则 | 110 | 0 |
| 管理器生命周期 | 48 | 0 |
| 管理器短间隔、系统提示、前台恢复及发送失败等 8 个场景 | 60 | 0 |
| 原生 @ 提醒适配夹具 | 45 | 0 |
| 成员快照运行时夹具 | 165 | 0 |
| 本地资料链接 | 35 | 0 |
| 配置持久化 | 27 | 0 |
| 备份与预览恢复 | 57 | 0 |
| 批量退群协调器 | 12 个场景 | 0 |
| 合计 | 547 项检查 + 12 个场景 | 0 |

另有仅在本审计目录运行的 [设置兼容检查](settings-compatibility.log) 27 通过、[移出回包与资料检查](kick-runtime.log) 26 通过、[本群发送与前台补齐检查](manager-continuity.log) 23 通过，共 76 项补充检查、0 失败。默认测试入口没有新增文件或改变断言；两个既有夹具仅更新了生产调用签名／空实现。本次未启动 UIKit 宿主、Catalyst 或真机测试，也未运行无关全量任务。

已知 2.4-3-1 非核心红灯（用户给定的基线复现结果，本轮未重跑）：紧气泡历史契约 `compact1436` 共 144 红，包含微信 8.0.78、8.0.80 各 48 红；其余 48 项的分组未提供。本轮未改动紧气泡代码、夹具或断言，不以此阻断出包。

## 真机状态

Xcode 能列出此前配对的 iPhone 14 Pro Max，状态为 `unavailable`。以下均**未验证**：另一账号是否收到本群通知、欢迎是否真的提醒被 @ 的成员、本账号及其他管理员踢人在实际微信中的回调和差分、微信挂起后的前台同步及补齐。主机夹具仅验证交给原生发送接口及本地处理条件，不能证明送达。

## 发布产物

版本 `2.4-4` 已同步至 `control`、应用内版本和更新说明。交付目录为 [packages/2.4-4-group-chat-notices](../../../packages/2.4-4-group-chat-notices)。两个 deb 的版本、包架构及内容路径均已核对。独立 dylib 和两个 deb 提取出的 dylib 均通过 `lipo -archs`（`arm64 arm64e`），两切片的最低 iOS 版本均为 15.0。独立 dylib 与 Rootful 包内 dylib 字节相同；Rootless 包请使用其 deb 内的 dylib。符号包的四个 DWARF 条目通过 CRC 校验，并逐一匹配两种包的两切片 UUID。

| 文件 | SHA-256 |
| --- | --- |
| [WeChatImprove.dylib](../../../packages/2.4-4-group-chat-notices/WeChatImprove.dylib) | `737d3e46cead89dc9a3964ab35bb6c43b4a8469c849fafc0a8974b217e658ca8` |
| [Rootful deb](../../../packages/2.4-4-group-chat-notices/com.wechat.improve_2.4-4_iphoneos-arm.deb) | `e2b9bcd6f732d125ce9a393ca27d0cf19a289d9b14759170685752247e812e28` |
| [Rootless deb](../../../packages/2.4-4-group-chat-notices/com.wechat.improve_2.4-4_iphoneos-arm64.deb) | `7e23674e8a43fce6b38314ac1b95a8821107350a86cf6857c9881a6b88d99e42` |
| [symbols.zip](../../../packages/2.4-4-group-chat-notices/symbols.zip) | `80f8d4463aa6eb739b76a54795a7da9d4a3924b3c53b8a7fd09abc833808e21f` |

校验文件见 [SHA256SUMS](../../../packages/2.4-4-group-chat-notices/SHA256SUMS)，编译日志见 [Rootful](build-rootful.log) 与 [Rootless](build-rootless.log)，具体架构、UUID 和历史包完整性见 [package-verification.txt](package-verification.txt)。最初在工作区独立暂存目录编译时，macOS 拒绝重命名中间文件；改用临时构建目录后，两种包均从原工作区成功编译。未运行 `make clean` 或删除原有缓存。对比构建前后的清单，280 个历史包文件的路径和内容均未变。
