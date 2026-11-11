# 群聊功能设计取证

2026-11-10，设计阶段静态分析。设计评审稿位于 `docs/superpowers/specs/2026-11-10-group-chat-tools-design.md`。

未运行微信、未连接真实账号、未发送消息或群操作请求，未修改功能源码、构建安装包或切换服务。已有 `.theos`、历史包及其他任务审计文件未纳入本次修改。

## 目标身份与方法

- 原始 IPA：`/Users/zhangshichao/Downloads/Telegram Desktop/com.tencent.xin_8.0.80.ipa`。
- IPA SHA-256：`5cacb443b743793ccfe6026bc81c1f2678cb5cfdcd38584ad73ac7f19ecf4a5f`。
- Info.plist：`com.tencent.xin`，版本 `8.0.80`，build `8.0.80.34`。
- 主程序：arm64，545074336 bytes，`cryptid=0`，SHA-256 `1d626426df97058a8a87c661532b2801cd27b7d9fcc12e27609c751f5877b7ed`。
- REA `open_binary` 绑定用户指定 IPA，`extract_artifact` 进行内容完整性核对及提取。提取 Evidence：`ev_39fa213f745d13fcd0d6b2aa3522a043ffc822d8723ec8a7ba069115335b0df5`。
- 随后复用项目已有的 `privacy-validation/objc_metadata.py`、`merge-validation/inspect_objc.py` 与 `xcrun llvm-objdump`，离线读取 Objective-C 元数据并定点反汇编。地址均为未加 ASLR slide 的 VM 地址，不是实现中应硬编码的 Hook 地址。
- `artifact-identity.json` 保存详细来源和限制。下列取证为静态观察；原生接口提交成功不等于服务端执行或消息送达。

## 已回答的问题

| 问题 | 静态结论 | 证据 |
| --- | --- | --- |
| 项目框架与入口 | Theos/Logos/Objective-C/UIKit；“功能增强”最后为小丑；可在后面加入群聊功能 | `Makefile:18`、`Controllers/CSCustomViewController.m:840` |
| 原生群聊多选 | 已有 `CSNativeContactPickerPresent`，使用 `GroupSelectContactsViewController` scene=4 | `Controllers/CSNativeContactPicker.m:143`、`:203` |
| 真正 @ 的写入 | `setM_nsAtUserList:` 会调用 `UpdateMsgSource`，将用户列表序列化为 `<atuserlist>`，再写回 `m_nsMsgSource` | `CMessageWrap-setM_nsAtUserList_-annotated.asm`、`CMessageWrap-UpdateMsgSource-annotated.asm` |
| 群成员更新 | `OnGetChatRoomMemberDetail:` 校验响应后，更新完整成员身份列表，随后更新版本与缓存 | `events/FINDINGS.md`、对应 `-annotated.asm` |
| 不能用于成员差分的数据 | `GetGroupMember:` 可能漏掉无本地联系人对象的成员；`chatRoomMember` 详细资料可为增量；isSimplify 不等于身份名单不完整 | `events/CGroupMgr-GetGroupMember_-annotated.asm`、`events/FINDINGS.md` |
| 本人新入群识别 | 有范围的 2516 类检索未找到可证明覆盖全部方式的统一回调；应使用可信自身成员状态迁移与启动基线 | `events/self-join-search.json`、`events/FINDINGS.md` |
| 原生保存群通讯录 | 资料页 type3 设置经 `CGroupMgr.ShowInContactBook:sync:` 真实调用原生 addContact；原生提交还调度 oplog 同步，不能把 sync 参数或 BOOL 当远端完成 | `room-actions/FINDINGS.md`、对应设置/群服务汇编 |
| 原生批量退群 | `BatchQuitChatRoomLogic` 最多20群，CGI18448，逐群 outcome、有限重试、原生本地 reconcile/delegate/cancel | `room-actions/FINDINGS.md`、`BatchQuitChatRoomLogic` 对应汇编 |
| 与单群资料页的差异 | 批量引擎没有资料页 `confirmOnArriveFund:` 待收款检查，外层须补；资料页清记录默认勾选，方案显式默认保留记录 | `room-actions/FINDINGS.md`、`ChatRoomInfoViewController` / `DeleteContactConfirmActionSheet` 对应汇编 |
| 本地提示与资料页 | 项目防撤回已用 type10000 本地消息；微信 `ChatRoomUtils` 群成员资料入口支持传原群上下文和非好友分支 | `Hooks/RevokeHooks.xm:157`、`profile/ChatRoomUtils-openContactProfile-annotated.asm` |

## 关键接口

| 类/selector | ABI | IMP |
| --- | --- | --- |
| `CMessageWrap -setM_nsAtUserList:` | `v24@0:8@16` | `0x104e51b60` |
| `CMessageWrap -UpdateMsgSource` | `v16@0:8` | `0x104e56c04` |
| `CGroupMgr -OnGetChatRoomMemberDetail:` | `v24@0:8@16` | `0x10203ed80` |
| `CGroupMgr -updateChatRoomMemList:withResponse:` | `v32@0:8@16@24` | `0x10203fbc4` |
| `CGroupMgr -GetGroupMemberUserListByContact:` | `@24@0:8@16` | `0x102039cc4` |
| `CGroupMgr -GetEntireChatRoomMemberDetail:` | `B24@0:8@16` | `0x1020413dc` |
| `CGroupMgr -ShowInContactBook:sync:` | `B28@0:8@16B24` | `0x10203a6e8` |
| `CGroupMgr -QuitGroup:withUsrName:deleteAllMsg:` | `B36@0:8@16@24B32` | `0x102037e90` |
| `BatchQuitChatRoomLogic -startWithRoomNames:clearHistory:` | `v28@0:8@16B24` | `0x10038dc44` |
| `ChatRoomInfoViewController -confirmOnArriveFund:` | `v24@0:8q16` | `0x100f9bc50` |
| `ChatRoomUtils +openContactProfile:ofChatRoomContact:inViewController:delegate:` | `v48@0:8@16@24@32@40` | `0x100fd8024` |
| `ChatRoomUtils +openContactProfile:ofChatRoomContact:inViewController:delegate:searchScene:` | `v56@0:8@16@24@32@40Q48` | `0x100fd803c` |

## 设计决策与未知项

用户已明确通知去向为“仅原群内本地提示，支持点击昵称”。默认文案保留用户给定格式，真实 @ 仅用于欢迎消息；退群提示中的昵称用本地资料链接。

设计采用完整身份名单和版本差分；事件协调器在 `OnGetChatRoomMemberDetail:` 原生前捕获不可变旧基线，在原生返回、最终版本更新后发布新快照。退群差分只证明成员离开最新名单，不能区分主动退出和被移出；检测时间是本次检测时间。首次开启、冷启动与备份恢复不重放历史自动动作。

批量引擎单次20群，外层做同类资金待办检查并串行拆批；保留原生最多3次重试，插件不叠加未知结果重试。停止只能阻止尚未提交的后续批次。依据用户保留数据的长期约定，批量确认的清记录选项默认关闭，并明确这是插件页的默认策略。

尚未验证：真机成员数据更新频率、各入群方式的状态迁移覆盖、对端 @ 提醒、后台挂起时机、离群非好友完整资料、通讯录远端同步、CGI18448服务端/特殊群/OpenIM支持、账号切换期间在途请求和其他 Hook 兼容性。方案列出了对应验收项；不得把以上静态分析标记为真机验收通过。

## 文件清单

- 根目录 `*-metadata*.json`：消息对象、群聊天逻辑、发送入口元数据。
- 根目录 `*.asm` / `*-annotated.asm`：真实 @ setter、消息来源序列化及相关边界探查。
- `events/`：成员更新、完整性、取快照时序、本人入群回调检索。
- `room-actions/`：保存通讯录、退出前资金检查、清记录选项、单群和批量退出。
- `profile/`：原生资料入口和非好友分支。
- `artifact-identity.json`：原包及提取主程序身份。
- `disassembly-commands.json`：根目录首批定点反汇编的起止地址、命令结果；后续探查的目标边界也可由对应元数据和汇编确认。
