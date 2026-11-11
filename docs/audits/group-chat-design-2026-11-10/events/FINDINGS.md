# 微信 8.0.80 群成员事件静态分析

目标：用户指定 IPA 提取的 WeChat arm64 主程序，SHA-256 `1d626426df97058a8a87c661532b2801cd27b7d9fcc12e27609c751f5877b7ed`。全部离线读取，未运行目标、未修改源码、未连接真实账号、未执行群操作。根任务负责 REA session，本子任务未打开或关闭共享 session。

## 已证实的 selector / ABI / IMP

| 类 | selector | Objective-C 编码 | IMP |
|---|---|---|---|
| CGroupMgr | updateChatRoomMemList:withResponse: | v32@0:8@16@24 | 0x10203fbc4 |
| CGroupMgr | OnGetChatRoomMemberDetail: | v24@0:8@16 | 0x10203ed80 |
| CGroupMgr | GetGroupMemberUserListByContact: | @24@0:8@16 | 0x102039cc4 |
| CGroupMgr | GetGroupMember: | @24@0:8@16 | 0x102039898 |
| CGroupMgr | GetEntireChatRoomMemberDetail: | B24@0:8@16 | 0x1020413dc |
| CGroupMgr | OnUpdateContact: | v24@0:8@16 | 0x102040438 |
| CGroupMgr | onModifyContact: | v24@0:8@16 | 0x10204b370 |
| CContactMgr | callOnModifyExt: | v24@0:8@16 | 0x1010b4b00 |
| CContactMgr | setContact:chatRoomMemList:isNotify: | B36@0:8@16@24B32 | 0x100c77bd0 |
| CContactMgr | setContact:nsAdminList:nsMemberList: | B40@0:8@16@24@32 | 0x100c77820 |
| CContactMgr | thread_onPushModifyContact:isInit:arrNewContact: | B36@0:8@16B24@28 | 0x100c7176c |
| CContactMgr | thread_onBatchModifyChatRoomMember: | @24@0:8@16 | 0x1010c4f6c |
| CMessageMgr | AsyncOnAddMsg:MsgWrap: | v32@0:8@16@24 | 0x104dd9d54 |
| CMessageMgr | onNewSyncAddMessage: | v24@0:8@16 | 0x104df0cf8 |
| ChatRoomData | getJoinTimeForUsername: | I24@0:8@16 | 0x100f7af2c |
| ChatRoomData | hasJoinInfoForUsername: | B24@0:8@16 | 0x100f7af80 |
| ChatRoomData | localMemberVersion | I16@0:8 | 0x100f7c3c0 |
| ChatRoomData | chatRoomVersion | I16@0:8 | 0x100f7c3b0 |
| ChatRoomData | isSimplify | B16@0:8 | 0x100f7c3d0 |

## 成员列表更新链

`CGroupMgr.OnGetChatRoomMemberDetail:` 读取 CGI wrapper 的 `m_pbResponse`、`m_pbRequest`，检查 response 存在及 `baseResponse.ret == 0`。成功分支在 `0x10203f124` 加载 `updateChatRoomMemList:withResponse:` 并调用，随后更新 ChatRoomData、client/server version，并记录 cache。

`updateChatRoomMemList:withResponse:` 明确读取 `allMemberUserNameList`、`allMemberCount`、`adminUserNameList`、`adminCount`，遍历用户名重建成员字符串，写 `setM_nsChatRoomMemList:`，最后交由 `CContactMgr.setContact:nsAdminList:nsMemberList:` 持久化。该响应路径的 allMemberUserNameList 是候选完整身份列表；实施时仍需核对用户名有效、去重计数和 response.allMemberCount 一致、群身份匹配及版本不倒退，不能凭 selector 名称就把任何传入数据都当完整快照。

重要细节：`newChatroomData.chatRoomMember` 中是可 merge 的详细资料集合，不等于完整成员身份名单。`ChatRoomData.merge:` 逐项合并 displayName、Flag 等；必须使用 allMemberUserNameList 或 m_nsChatRoomMemList 做成员增减判断。isSimplify 是资料简化信号，单凭它也不能判定身份列表是否完整。

原生完整请求 `GetEntireChatRoomMemberDetail:` 明确设置 request.clientVersion = 0，CGI = 551，并有同群请求队列去重。可以用于首次建立/重新确认基线的原生通道；不建议轮询所有群。

## 不能误用的近似入口

1. `CContactMgr.thread_onBatchModifyChatRoomMember:` 处理批量成员昵称、type、头像 URL、openIMAppid 等资料，输出经过数据库批量修改后的 contacts。其函数名不能被解释为“收到完整群成员增减名单”。其调用者 `GetChatRoomMemberDetailEventHandler.OnProtocolResponse:shouldContinue:` 从 newChatroomData.chatRoomMember 生成 contacts 后调用此方法，再 thread_ReloadMemConact:ChatRoom:。
2. `CGroupMgr.GetGroupMember:` 会把 m_nsChatRoomMemList 拆成 ID 后逐个查联系人数据库。某成员 CContact 缺失时日志 `member %@ not in db`，并可能未加入返回数组。对其返回 contacts 做差分，会将资料未落库误判为退群。
3. `GetGroupMemberUserListByContact:` 直接取 m_nsChatRoomMemList 并按 `;` 拆分，适合作身份列表读取入口，仍须过滤空串/重复项。
4. `callOnModifyExt:` 广播 IContactMgrExt 的 onModifyContact:，是普通联系人修改扩展，内容包括群名/头像/状态等多种变化。可作为“该群可能需要刷新”的轻量信号，不能直接发送退群通知。
5. `OnAddChatRoomMember:`、`OnDeleteChatRoomMemberResponse:` 是自身操作 CGI 回包的入口，不能独立覆盖其他人通过任意客户端加入或退出。
6. 在所扫描 classmap 中没有名为 ChatRoomObserver 的类；这不是对协议/动态类/外部模块不存在的证明。

## 建议设计约束（基于以上观察的推论）

- 每账号每群保存最近一次已确认完整成员 username 集合、版本和捕获时间。首次开启、首次选群、恢复配置、无法确认旧快照时只建基线，不欢迎全部老成员，不提示历史退群。
- 以 `new - old` 生成候选入群、`old - new` 生成候选离群；群名/备注名修改、联系人资料加载失败不产生事件。自身已经不在群、解散/被移出、群快照异常大幅缩减时先失效/重建基线，不批量宣告所有人退群。
- 相同账号/群/成员/变更方向/成员版本事件去重；同人退出后重新加入属于新的事件。Hook 内只捕获不可变数据和调度，不发同步网络请求、不长时间占用微信业务线程。
- 欢迎仅对已确认的新入群事件排队，排队/发送时再次核对成员仍在群和当前账号、设置开关。可用 joinTime/结构化入群系统事件佐证时效；离线恢复或来源不明的旧增量默认不补发欢迎。
- 退群差分只证明“已不在最新成员列表”，不能单独区分主动退群、被管理员移除或其他原因。只有带明确原因的结构化系统事件才可赋予具体原因；默认产品语义应说明按成员变化检测。
- 被动监听受微信何时同步完整群资料、网络和 iOS 后台挂起影响。不能承诺所有群实时、精确退群时刻、后台进程被杀时继续工作。文案使用“检测时间”准确，离线时间不伪装为真实退群时间。
- 仅匹配中文“加入了群聊/退出了群聊”文案不可靠：语言、模板、邀请/扫码/审批等场景变化都影响文本，普通成员也不一定收到别人主动退群的系统消息。结构化系统消息只作辅助，完整成员快照为主要依据。此为实现建议/平台语义限制，静态分析未执行服务器场景验证。
- 群人数以本次已确认完整身份集合为准，包含当前账号自身；不要复用 `GetGroupMemberWithOutMyself:` 导致人数少一人。

## 证据文件

- classes.json / full-metadata.json：selector、ABI、IMP 与 ivar 元数据。
- CGroupMgr-updateChatRoomMemList_withResponse_-annotated.asm：响应列表到持久化成员列表链。
- CGroupMgr-OnGetChatRoomMemberDetail_-annotated.asm：ret 校验、成员更新和版本处理。
- CGroupMgr-GetEntireChatRoomMemberDetail_-annotated.asm：clientVersion=0、CGI551。
- CGroupMgr-GetGroupMember_-annotated.asm：缺本地 contact 的遗漏风险。
- CGroupMgr-GetGroupMemberUserListByContact_-annotated.asm：分号分隔身份列表。
- CContactMgr-thread_onBatchModifyChatRoomMember_-annotated.asm：资料修改而非完整成员名单。
- GetChatRoomMemberDetailEventHandler-OnProtocolResponse_shouldContinue_-annotated.asm：newChatroomData 部分详细资料处理路径。
- ChatRoomData-initWithNewChatRoomData_-annotated.asm / ChatRoomData-merge_-annotated.asm：资料简化与增量合并。

静态结果证明类/方法存在和上述调用/字段流；未证明实际设备上的回调频率、所有群类型覆盖、服务器推送行为、具体 Hook 与其他插件的兼容性。

## 补充：取快照顺序与本人入群

- 观察到 OnGetChatRoomMemberDetail: 在 0x10203f124 先调用 updateChatRoomMemList:withResponse:；后者在 0x1020400e8 写群 contact 的 m_nsChatRoomMemList，再在 0x102040224 持久化。回到上层后，0x10203f504 设置 ChatRoomData.chatRoomVersion，0x10203f58c 设置 localMemberVersion，0x10203f864 记录详情 cache。因此在 updateChatRoomMemList: 的 %orig 之后立刻读版本，可能尚未得到本次最终详情版本。
- 推荐 Hook OnGetChatRoomMemberDetail: 外层：调用原生前捕获当前账号/epoch、群 ID、request/response 与旧基线的不可变副本；让原生完整处理；原生返回后再次核对账号/epoch、ret、响应完整性、同群当前 contact 和最终版本，并只在与本次响应吻合时发布新快照。若需要在 updateChatRoomMemList: 前复制旧字符串，只作核对，不把会被原地修改的 CContact 对象当旧快照持有。持久基线仍应来自前一次已确认完整快照，避免缓存早于上层回调已变而漏事件。响应异步落库是否完成不能凭 BOOL 提交返回推断，需使用原生已修改状态和本次响应一致性作确认。
- 扫描了名称含 Room/Group/QRCode/Scan/Verify/Contact/OpenIM 的 2516 个类，筛选 join+chatroom/group 与 join success/response 方法，未找到一个可证明覆盖普通微信群“邀请、扫码、审批、面对面、其他端同步”等全部入口的通用本人入群成功回调。已有 CGroupMgr.OnCreateChatRoom: 仅建群路径；JoinChatRoomHandler 是第三方/H5跳转链；RadarCreateRoomViewController.HandleEnterRoomResp:Event: 是面对面路径；Ting/Finder/Game/Track 的 join 回调属于其他业务，不能混用。
- “加入新群后自动保存”应基于原生群联系人更新 + 当前账号由不在群到已在群的状态转换，辅以已确认的建群/入群操作路径。冷启动/初次启用仅记录当前已加入群，不能把批量同步所有旧群误认为新加入。不能把“联系人第一次进入本地 cache/数据库”直接当入群成功。
- 专项检索结果保留 self-join-search.json（含范围和 72 项匹配），未找到通用回调是有范围的阴性结论，不是证明动态实现或协议中绝不存在该入口。
