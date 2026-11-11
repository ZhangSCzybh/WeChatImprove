# WeChatImprove 2.4-5 审计

## 2.4-4 现状与本轮设计（需求 2 改动前）

- 基线 `control` 为 `2.4-4`；[429 个生产输入快照](production-baseline.sha256)与 2.4-4 上次打包输入逐项一致。沿用当前工作区及微信账号数据；仓库是注入插件，没有本地服务 URL、端口或独立数据库。
- **进程存活。** `Hooks/BackgroundRun.xm` 已接入微信音频活动，保留原方法语义；`CSBackgroundRunManager`、`CSBackgroundRunRuntime` 已有 UIKit 后台任务、到期处理与音频接管保护。仅在宿主声明 `UIBackgroundModes=audio`、剩余预算低且宿主音频空闲时，才尝试使用现有低音量音频循环；遇宿主激活、中断、路由或媒体服务变化让出。新增群聊消费者，沿用同一个周期、任务、音频和停止路径；单独区分群聊请求与旧全局开关，避免无意启动 AI 后台同步。群聊开关默认关闭。
- **事件与名单。** `CSGroupChatRuntime` 已接入联系人变更、远端群系统消息、移人成功回包及完整名单回包。2.4-4 在真正进入后台时关闭入口，移交 `resumeBaselines` / `resumeWelcomes`，回前台才请求 `GetEntireChatRoomMemberDetail:`。保活可用时打开同一入口；保活机会开始时补查已选群，之后由原生事件触发沿用五秒合并的完整名单查询。完整性、宿主名单一致性、版本、账号与授权门槛保持；不增加后台常驻轮询或第二个全局同步器。微信未同步事件、接口未回包或进程被挂起时走原有前台补查。
- **发送。** 原生文本适配器现有 `CMessageMgr AddMsg:MsgWrap:` 路由不要求前台页面；本地退群提示使用抑制到达通知的 `AddLocalMsg:...`。放行同一发送入口时仍校验运行窗口、账号、配置、群与成员状态。原生提交不是服务器送达。把后台已处理的最新验证名单用于前台补差；未提交欢迎继续沿用原截止时间；原生提交结果不确定时不自动重发。自动保存群和手动批量退群维持原有前台边界。
- **锁屏。** 只使用宿主已有后台能力，不修改权限、音频声明、系统调度、数据保护或推送配置。若锁屏后 iOS 仍给微信执行时间且原生连接和数据可用，可以尝试同一链路；挂起和进程退出后插件无法自行执行。

## 需求 1：微信 ID 变量

| 最终变量 | 可用位置和取值 |
| --- | --- |
| `@微信ID` | 三种文案。使用完整成员名单 `GetChatRoomMemberDetailResponse.allMemberUserNameList` 中的微信账号标识，与 `ChatRoomMemberInfo.userName` 和联系人身份字段 `CContact.m_nsUsrName` 同义。欢迎取加入成员的 ID；离群取名单差分中移除的 ID。多人用「、」连接；只显示文本，不触发 @ 提醒。此字段可能为 `wxid_…` 等微信内部账号标识。 |
| `@昵称` | 三种文案。优先微信昵称，缺失时依次用群内备注、成员 ID；欢迎显示原生 @ 提醒，本地退群提示保留资料链接，本群文案为文字。 |
| `@备注` | 三种文案。群内备注，缺失留空，欢迎有多位成员时用「、」连接有备注的成员。 |
| `@群昵称` | 三种文案。当前群聊名称。 |
| `@群人数` | 三种文案。完整名单人数；欢迎提交前使用当时核对的名单。 |
| `@时间` | 三种文案。本地时区 `yyyy-MM-dd HH:mm:ss`；欢迎渲染时刻或离群名单检测时刻。 |
| `@离群类型` | 仅两种退群文案。回包证据和差分匹配时为「被移出」，否则为「离群（原因未确认）」。 |

名单来源见 [完整回包与原生名单交叉核对](../../../Controllers/CSGroupChatRuntime.m#L53)、[原生完整名单接口](../../../Controllers/CSGroupChatNativeAdapter.m#L102)、[ChatRoomMemberInfo.h:31](../../../HeadersFile/ChatRoomMemberInfo.h#L31)、[CContact.h:158](../../../HeadersFile/CContact.h#L158)。[模板渲染](../../../Controllers/CSGroupChatTemplate.m#L25)只扫描原模板；替换值中出现的占位符文字原样输出。微信 ID 为空、纯空白、`null` 或 `(null)` 时输出空值；若原模板里一对半角或全角括号只包着空 ID（可含空白、多个 ID 或嵌套括号），该括号也省略。没有新变量的旧模板继续使用原有值和默认文案。[欢迎及退群取值](../../../Controllers/CSGroupChatTemplate.m#L80)、[本地提示转义与资料链接](../../../Controllers/CSGroupChatLocalNotice.m#L19)、[本群通知渲染](../../../Controllers/CSGroupChatManager.m#L377)、[编辑器说明、示例预览及插入菜单](../../../Controllers/CSGroupChatSettingsViewController.m#L135)、[设置页变量行](../../../Controllers/CSGroupChatSettingsViewController.m#L406)。

## 需求 2：后台实时运行

| 项 | 实现与落点 |
| --- | --- |
| 开关与持久化 | **群聊功能 → 后台运行 → 后台实时运行**，配置键 `configuration.backgroundRealtimeEnabled`，默认 `false`。开关仅在当前账号授权有效且欢迎或退群监控至少选中一个群时申请后台资源。配置沿用微信沙盒 `Library/Preferences/WeChatImprove/GroupChatTools/<SHA256(accountID)>.plist` 和备份域 `group_chat_tools`，`schema/schemaVersion=1`。旧配置缺键照常读取；读取不写回；备份预览解释此开关。见 [设置页:390](../../../Controllers/CSGroupChatSettingsViewController.m#L390)、[默认与校验:44](../../../Controllers/CSGroupChatStore.m#L44)、[路径:75](../../../Controllers/CSGroupChatStore.m#L75)、[备份预览:55](../../../Controllers/CSBackupPreviewViewController.m#L55)。 |
| 进程存活 | [群聊桥接:5](../../../Hooks/GroupChatHooks.xm#L5) 把当前账号请求交给 [共享后台管理器:72](../../../Controllers/CSBackgroundRunManager.m#L72)。使用已有 `beginBackgroundTaskWithName:expirationHandler:` / `endBackgroundTask:` 生命周期；管理器使用同一套任务、调度检查和音频资源。既有 26 秒任务轮换不刷新系统总预算；剩余时间不足 8 秒（或首次任务申请失败）时，只有微信包已声明后台音频且宿主音频空闲才尝试已有近静音音频接力。原全局开关仍独立门控其旧消费者和 AI；群聊开关只控制群聊需求。返回前台、到期无可用音频、或最后一个需求关闭时释放对应资源。 |
| 事件到达及确认 | [群聊能力状态:76](../../../Controllers/CSGroupChatManager.m#L76) 在实际进入后台且保活可用时开放运行入口，并触发一次所选群完整名单补查；之后由 [原生联系人／系统消息／移人／完整回包 Hook:86](../../../Controllers/CSGroupChatRuntime.m#L86) 触发。原生请求 `GetEntireChatRoomMemberDetail:` 仍按群以 5 秒冷却合并，核对账号、群状态、完整名单及服务端版本；系统消息与移人回包只是查询信号。管理员移出仍须请求和回包证据与差分匹配，其他管理员的移出若无逐人证据只标原因未确认。见 [请求:208](../../../Controllers/CSGroupChatManager.m#L208)、[移人证据:280](../../../Controllers/CSGroupChatManager.m#L280)、[名单差分:304](../../../Controllers/CSGroupChatManager.m#L304)。 |
| 发送通道 | 欢迎在配置延迟到期且成员仍在群时走 [欢迎提交:424](../../../Controllers/CSGroupChatManager.m#L424)；退群提示走 [本地插入与可选本群提交:354](../../../Controllers/CSGroupChatManager.m#L354)。欢迎和可选本群通知均进入 [`CMessageMgr AddMsg:MsgWrap:`:83](../../../Controllers/CSMessageSendAdapter.m#L83)；欢迎使用 `m_nsAtUserList`，本群退群消息不 @ 已离群成员。本地提示走 [`AddLocalMsg`:41](../../../Controllers/CSGroupChatLocalNotice.m#L41)，保留原来的仅自己可见且不触发锁屏通知的语义。进入原生方法前仍校验后台执行机会、账号代际、配置代际和权限，群内发送另外确认群和成员状态。 |
| 去重和补齐 | [检查点与回前台:102](../../../Controllers/CSGroupChatManager.m#L102) 保留同进程最新已验证名单。差分去重身份为 **账号代际 + 配置代际 + 群 ID + 完整名单服务端版本 + 成员 ID + 加入／离开方向**：同版本同名单无差分，倒退或同版本不同名单被拒绝。待发欢迎以任务 UUID 区分，原截止时间和成员身份继续核对；退群每个差分的本地／本群通道分别消费，恢复时只处理还未调用或已知未提交的待办。可点击本地提示的 `版本.成员.UUID` 是资料链接标识，差分去重不依赖这个 UUID。所有队列及检查点只在当前进程内有效。 |

## 行为变化与风险

- **耗电：** 默认关闭，关闭时群聊回到 2.4-4 的回前台补齐模式。开启后，后台任务、按需音频和名单查询会增加耗电，幅度未验证。
- **后台被杀：** 系统仍可以限制、挂起或结束微信，音频接力不保证持续运行，系统也可能拒绝或回收资源。到期按原管理器流程结束任务，不尝试强制解挂、不伪造推送、不修改宿主权限。被杀、强退或冷启动后无法重放原进程内的事件和队列。
- **微信原有后台任务：** 只增加群聊需求和所选群查询，未改微信的生命周期、推送或网络策略，也未启动第二套保活或全局同步轮询。沿用现有音频所有权、通话／录音、中断、路由和媒体服务保护；失去音频时让出。原有任务和其他插件共存的真机表现未验证。自动保存群及批量退群保持原来的前台范围。
- **锁屏：** 若宿主声明后台音频，且系统仍允许运行、微信连接还在且相关数据可读，锁屏时可尝试同一链路。系统挂起、断网、微信暂停同步或受数据保护而拿不到原生服务时，无法实时确认事件或发送。没有另外授予后台能力或修改数据保护，无法绕过首次解锁限制，也不会产生系统锁屏通知。
- **失败回退：** 同一进程回到前台后会强制核对所选群的完整名单。还没交给微信的欢迎会在原截止时间内核对成员后补做；后台窗口关闭前已确认的离群，保留未进入原生提交的待办。原生插入或发送调用若已经开始、异常或结果不确定，不自动重发，避免重复；已调用 `AddMsg` 不等于对端收到。若缺失首份完整名单、前后名单净变化为零、微信从未返回可核对的完整名单，或者账号／配置／进程换代，则无法补齐该段事件。

## 核心回归

| 范围 | 通过 | 失败 |
| --- | ---: | ---: |
| 文案、差分与核心规则 | 110 | 0 |
| 管理器生命周期与既有欢迎／发送场景 | 108 | 0 |
| 原生 @ 提醒适配 | 45 | 0 |
| 完整成员快照运行时 | 165 | 0 |
| 本地资料链接 | 35 | 0 |
| 配置持久化 | 27 | 0 |
| 备份与预览恢复 | 57 | 0 |
| 批量退群 | 12 个场景 | 0 |
| 2.4-4 专项兼容（本群发送／前台补齐、移出、旧设置） | 76 | 0 |
| 2.4-5 专项（微信 ID、后台实时提交、关闭与缺键、到期后的通道补做、真实存储和备份） | 80 | 0 |
| 既有后台任务／生命周期／音频／运行时检查 | 447 | 0 |
| 共享任务及两开关隔离 | 18 | 0 |
| 合计 | **1,168 项检查 + 12 个场景** | **0** |

日志：[微信 ID 阶段的群聊回归](after-wechat-id-core.log)、[最终群聊回归](release-core.log)、[管理器场景](release-manager-scenarios.log)、[旧发送与补齐](legacy-manager-continuity.log)、[旧移出](legacy-kick-runtime.log)、[旧设置](legacy-settings-compatibility.log)、[2.4-5 专项](background-continuity.log)、[后台管理和音频](background-run.log)、[后台运行时](background-runtime.log)、[共享任务](shared-background-demand.log)。本轮补充脚本仅在本目录。324 个既有测试文件的改前与改后 SHA-256 一致；未增加默认入口或调整断言。

已知非核心基线红灯：紧气泡历史契约 `compact1436` 共 **144 红**，其中微信 **8.0.78 为 48 红、8.0.80 为 48 红**，另外 48 项的分组未提供。依要求未重跑、未修、未豁免，也未作为出包门槛。未执行无关全量任务。

## 真机状态

Xcode 列出的已配对 iPhone 14 Pro Max 为 `unavailable`，未安装本轮包。**后台消息实际实时送达、锁屏触发和发送、进程是否会被系统杀掉、耗电影响均未验证。** 与微信原有通话／音频／后台任务在真机上的共存亦未验证。主机夹具只证明后台条件满足时调用发送适配器、可记录原生提交及防重复；不能证明服务器接收或对端收到。

## 改动文件清单

[改前生产文件 SHA-256](production-baseline.sha256)、[最终 SHA-256](production-final.sha256)、[逐文件前后哈希](changed-files.tsv)。429 个生产输入路径一致，13 个文件内容发生变化；另更新仓库 README 和本审计目录。最终哈希清单与两套构建输入清单一致。

| 范围 | 文件 |
| --- | --- |
| 模板和设置 | `Controllers/CSGroupChatTemplate.m`、`Controllers/CSGroupChatSettingsViewController.m`、`Controllers/CSGroupChatStore.m`、`Controllers/CSBackupPreviewViewController.m` |
| 群聊后台与回前台补齐 | `Controllers/CSGroupChatManager.h`、`Controllers/CSGroupChatManager.m`、`Hooks/GroupChatHooks.xm` |
| 共享后台任务 | `Controllers/CSBackgroundRunManager.h`、`Controllers/CSBackgroundRunManager.m`、`Controllers/CSBackgroundRunViewController.m` |
| 版本和文档 | `control`、`Headers/CSUserInfoHelper.h`、`Controllers/CSReleaseNotesViewController.m`、`README.md` |

## 交付产物

版本 `2.4-5`。交付目录：[packages/2.4-5-group-chat-background](../../../packages/2.4-5-group-chat-background)。独立 dylib 和两个 deb 内的 dylib 均由 `lipo -archs` 核对为 **`arm64 arm64e`**，每个切片最低 iOS 15.0。独立 dylib 与 Rootful 包内字节一致；Rootless 使用对应 deb 内的 dylib。符号包 CRC 通过，四个归档符号文件分别匹配对应方案和架构的 UUID。校验、包内路径和 UUID 见 [package-verification.txt](package-verification.txt)，编译日志见 [Rootful](build-rootful.log)、[Rootless](build-rootless.log)。

| 文件 | SHA-256 |
| --- | --- |
| [WeChatImprove.dylib](../../../packages/2.4-5-group-chat-background/WeChatImprove.dylib) | `a0692c78cc5bddf320d336306a5122803115489bebc5d79e8f336e5f2226aaf6` |
| [Rootful deb（iphoneos-arm）](../../../packages/2.4-5-group-chat-background/com.wechat.improve_2.4-5_iphoneos-arm.deb) | `1acbe10760605c80bdacf00866b42dbdee3043416faed5303c9b0f6d3fc5b98b` |
| [Rootless deb（iphoneos-arm64）](../../../packages/2.4-5-group-chat-background/com.wechat.improve_2.4-5_iphoneos-arm64.deb) | `df7aa11f120d206e2494b4bf42506083b7755a704e3a481d68ef797bfc1bc213` |
| [symbols.zip](../../../packages/2.4-5-group-chat-background/symbols.zip) | `a6502060519bb2026f9cdc37492ce8ebe16b278f3f09f40bc93b20f4c98931f7` |

[SHA256SUMS](../../../packages/2.4-5-group-chat-background/SHA256SUMS) 四项复核通过。两种方案从现有工作区编译，使用独立临时 Theos 构建目录，未运行 `make clean`、未删除工作区 `.theos`。284 个历史包文件的路径及 SHA-256 均一致。未访问或迁移真实微信数据库、账号和聊天数据。
