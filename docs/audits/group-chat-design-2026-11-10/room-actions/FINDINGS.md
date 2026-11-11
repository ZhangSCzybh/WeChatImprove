# WeChat 8.0.80.34 群资料操作静态证据

目标程序：`/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat`

SHA-256：`1d626426df97058a8a87c661532b2801cd27b7d9fcc12e27609c751f5877b7ed`

方法：既有 Objective-C 元数据解析器与 xcrun llvm-objdump 的定点反汇编。地址为未加 ASLR slide 的 VM 地址，base=0x100000000。没有执行微信或发送网络请求。

## 保存到通讯录

- ChatRoomInfoViewController.switchSaveToAddressBook:（v24@0:8@16，0x100f8d53c）读取 switch.isOn，传给 DelaySwitchSettingLogic.chatProfileSwitchSetting:withType:andValue:，type=3。
- DelaySwitchSettingLogic.processChatProfileSetting:withType:andValue:（v32@0:8@16i24B28，0x10121b824）type3+YES 调 CGroupMgr.ShowInContactBook:sync:；NO 调 UnShowInContactBook:sync:。
- CGroupMgr.ShowInContactBook:sync:（B28@0:8@16B24，0x10203a6e8）getContactByName: 后真实调用 CContactMgr.addContact:listType:opLog:callExt:，listType=1、opLog=YES、callExt=YES；找不到 contact 返回NO。此版本函数本体未使用输入sync值，不能把该参数当作同步完成回执。
- 延迟设置提交 commitAllSwitchSetting 调 NeedToSyncOplog。推荐调用原生群服务并回读保存状态，避免仅改插件名单/直接写联系人数据库。

## 单群退出等价流程

- onQuit（0x100f95f78）先调 confirmOnArriveFund:，tag=1017。
- confirmOnArriveFund:（v24@0:8q16，0x100f9bc50）查询 GetValidNewBizMsgCountByChatName:bizType:（bizType=2）和 calcValidNewTransferCountWithUsername:；用 WCPay_OnArriveMoney_Profile_QuitChatRoom_* 文案显示待收款/群收款提醒，无待办时进入 quitChatRoomConfirm。
- quitChatRoomConfirm（v16@0:8，0x100f9b118）创建 DeleteContactConfirmActionSheet.initWithContact:，setConfirmBlock: 后 showFromViewController:animated:。
- DeleteContactConfirmActionSheet.genCheckBox（0x101220508）在0x101220d00~0x101220d0c明确 setSelected:YES，因此原生清聊天记录框默认勾选。onConfirm（0x1012211e0）将checkBox.isSelected作为BOOL送confirmBlock。
- 确认回调调用 quitChatRoomWithDeleteAllMsg:（v20@0:8B16，0x100f9b45c）。当clear=YES，先cleanSessionMigrationRecord:；该方法还关闭进行中的WXTalk模式，继而调用 CGroupMgr.QuitGroup:withUsrName:deleteAllMsg:。
- QuitGroup:withUsrName:deleteAllMsg:（B36@0:8@16@24B32，0x102037e90）记录clear标志并分流普通群/OpenIM群。普通群p_QuitGroup...调用start_QuitGroup...并注册oplog回调；返回BOOL只是请求创建成功。
- CGroupMgr.oplogRet:errMsg:eventID:cgiWrap:（v40@0:8i16@20I28@32，0x1020387d0）读取响应ret，成功分支调用reconcileQuitGroupLocally...后广播 OnQuitGroupUIRespone:withResult:errorMsg:deleteAllMsg:，不应主动提前调用本地reconcile。
- 没有在上述完整函数中看到显式群主转让判断；服务器特殊群/群主限制仍需真机验证，不能宣称不存在限制。

## 已有原生批量退群引擎

- BatchQuitChatRoomLogic.startWithRoomNames:clearHistory:（v28@0:8@16B24，0x10038dc44），要求delegate，去重并限制最多20群（0x10038e070比较0x14；超额群记录失败）。
- processNextRoom（0x10038e808）逐群验证真实CContact、IsChatRoomContact、!isChatRoomDismissed和当前账号IsUsrInChatRoom后直接approveCurrentRoomAndContinue:。完整函数没有资金待办检查，因此不能当成资料页前置检查全等。
- prepareApprovedRoomsAndSend（0x10038ee1c）记录原m_uiType；clearHistory时cleanSessionMigrationRecord；关闭WXTalk模式。
- sendBatchWithRoomNames:（v24@0:8@16，0x10038f29c）创建chatroomUsernameList protobuf，CGI=18448，保存eventID/请求名单并注册PB回调。
- MessageReturn:Event:（v28@0:8@16I24，0x10038f700）核对running/eventID/CGI；handleBatchResponse:与handleResultList:requestedRoomNames:核对顶层响应和每群outcome、过滤重复/非请求群。outcome=0进入reconcileSuccessfulRoom:；缺失结果和特定暂态错误进入有限重试。
- enqueueRetryForRoom...（0x1003905d8）最多3次重试（0x100390678比较3），retryGeneration抑制过期重试。
- reconcileSuccessfulRoom:（0x100390b88）调用CGroupMgr.reconcileBatchQuitGroupLocally:withUsrName:deleteAllMsg:，原生处理成员/会话/消息/联系人状态，并回调成功。
- delegate: batchQuitChatRoomLogic:didSucceedRoom:；batchQuitChatRoomLogic:didFailRoom:errorMessage:；batchQuitChatRoomLogic:didCompleteWithSuccessRooms:failures:errorMessage:isNetworkError:。这些名称来自真实发送调用，完整ABI可按协议元数据在实现前再校验。
- cancel（0x10038e4b8）清delegate/running/队列、增加generation、移除事件观察；它不会撤销已经发到服务器的退群请求。

## 设计建议和边界

优先复用BatchQuitChatRoomLogic，外层先做资料页同类资金待办检查、明确清记录选项、账号epoch防护和逐批进度。超过20群拆批串行；不要手写退出协议或只删本地会话。用户保留历史数据的常驻要求优先，因此可建议批量页默认保留记录，但必须说明这是显式批量产品策略，底层仍按用户所选deleteAllMsg执行。

本证据仅是同IPA静态观察，没有证明服务端CGI18448当前对所有群可用、真机UI、OpenIM群批量支持、账号切换期间网络回调的最终行为、群主特殊限制。
