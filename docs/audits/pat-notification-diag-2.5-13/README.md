# 2.5-13 群后台拍动通知定位审计

基线 `65193f29b33988b0154bdfe96372d8d86dde64fc`。本轮用户确认群免打扰和折叠均关闭，群后台仍需回到前台才回复，私聊后台正常。没有本版真机运行轨迹，因此不将静态差异发布成已确认修复。

交付是独立 `2.5-13+diag.1` 临时包，正式生产源与版本保持 2.5-13。安装、一次群／私同轮采样步骤和已知边界见 [包说明](../../../packages/2.5-13-pat-notification-diagnostic/README.md)。

## 已确认与未知

目标为此前选定的微信 8.0.80.34 arm64 可执行文件，SHA-256 `e484889f7e32adce054e6b19bef373e2d1c3eb6984bc01176bbd40906373f317`，UUID `7E4A8171-5ACC-3A72-A76A-3ACE52D3D895`，base `0x100000000`。本轮通过 REA 校验目标身份，再用同一二进制的 Objective-C 元数据、LC_FUNCTION_STARTS 和有界 llvm-objdump 复核；未执行手机微信。REA 会话已关闭。

| 结论 | 证据与范围 |
| --- | --- |
| 群／私共用收拍 | `SendPatMgr.OnGetNewXmlMsg:Type:MsgWrap:` `0x105a9bc80`，群判别 `0x105a9c1e8`；私聊只归一会话名，两者在 `0x105a9c3c0` 调同一 `addPatWrap`。 |
| 群可合并已有拍动展示 | `addPatWrap` `0x105a9a3e8`，群合并更新在 `0x105a9aadc` 调 `ModMsgByBitSet`；共同外层 Hook 正常非零 localID 返回均覆盖。 |
| 纠正旧报告的一个表述 | 新建 `AddLocalMsg:…NewMsgArriveNotify:` `0x105a9a83c–0x105a9a854` 的 fixTime/notify 都是 0。`!IsChatRoom` 控制合并资格，不能解释成群专有通知延迟。 |
| raw10002 默认可进入批次快照 | Cmd5 解码后 `0x105e4065c–0x105e40670` 追加 `m_arrMsgList`；`getReceiveMsgList` `0x105e412c0` 读同一 ivar（实例偏移 8）。没有证明本次手机响应包含目标消息。 |
| 前后台向服务器上报不同模式 | `onServiceEnterBackground` `0x105461dd4` 传 2；foreground `0x105461de4` 传 1；`sendBgFgRequestWithOnlineMode:` `0x105461764` 构造请求。服务端如何选择群推送仍未知，本包不改此模式。 |
| 现有 need hook 不是所有入口 | `ApnsNotifySync` `0x105462e5c` 有 5 秒内忽略分支；`__handleNewSyncResponse` `0x105464948` 有错误／暂停／处理中丢弃分支。不由这些静态分支推断现场命中。 |
| 群提交有额外资料检查 | 当前 Manager 的 supportsConversation 调用群状态、成员与退出检查；暂不可用会保留重试，回前台会重排。未找到直接的“群必须前台”提交条件，也未证明本次走了资料阻塞。 |

## 诊断实现

`diagnostic-source.patch` 为当前正式基线到临时包的完整生产源码差异，包括临时采样 UI、记录器、原有拍动／群门槛／发送记录、8 个被动原生探针、事件同步状态记录，以及临时版本和版本说明。`diagnostic-tests.patch` 保存对应测试与 runner 支持。

原生探针保留 receiver、selector、全部参数、返回值和异常对象；不解包数据、不获取服务、不额外发请求。严格 ABI 验证，8.0.80 才安装，缺少能力如实导出失败。begin/end 用捕获代次隔离，旧录制的迟到 end 不会进入新录制。主队列 pulse 每 2 秒只写内存，停止或到期取消；不能自行唤醒被系统挂起的微信。

新增字段沿用 `t_ms/stage/key/epoch/flags/main/app_state/protected_available`，schema=2，版本=2.5-13+diag.1。

- `native.hook.state`：低 8 位为编号，bit8=已安装。编号依次为 NotifyFromEvent、ApnsNotifySync、HandleNewSyncPush、HandleNewSyncPush64、NotifyToSync、sendBgFgRequestWithOnlineMode、__handleNewSyncResponse、handleAddMessageActionNotifyData。
- `native.notify.*` flags 为消息码；`native.online.*` 为 int 模式的低 32 位；`native.request.end` bit0 为 BOOL 返回。所有 native end 的 bit63 表示原调用抛异常。其他记录不包含载荷。
- `sync.wake.*`、`sync.drain.*`、`sync.event.*` 状态位：bit0 installed，bit1 raw 服务类匹配，bit2 need，bit3 initialized，bit4 operating，bit5 pause，bit6 syncOpError，bit7 gettingData，bit8 eventID 非零，bit9 pending，bit10 queued，bit11 driving，bit12 driveDepth，bit13 handleDepth。未带 state 的调用不解释 bit9–11。bit16 在 wake 表 newNeed，在 handle 表 processed，在 drain.return 表 accepted。
- `sync.manager.begin` bit0 ready、bit1 loading、bit2 saving、bit3 enteringForeground。`sync.manager.reject` 原因码 1=入口／代次，2/4=前后两次 eligibility，3/5=两次服务或配置复核，6=最终配置／账号／需求复核。`authorized` 后的 `scope` 表示实际进入账号作用域。
- `sync.feature.installed` bit0 表示原事件同步 Hook 已装；`runtime.pulse` 只表明该时刻主队列运行过。

其余拍动与发送记录继续使用 2.5-11 diag2 格式。没有任何记录可单独等价于对方最终可见；没有事件时须先检查采样上限、Hook 安装、前后台边界和 pulse。

## 复现与核验

在新的临时目录从上述基线导出 `Controllers Headers Hooks Tests Makefile control WeChatImprove.plist`，依次应用生产和测试补丁；不要覆盖现用 checkout。构建指定 Rootless、`PACKAGE_VERSION=2.5-13+diag.1` 以及独立 `_THEOS_LOCAL_DATA_DIR`、`THEOS_BUILD_DIR`、`THEOS_PACKAGE_DIR`。不要执行项目 `make clean`，它会删除历史 packages。

`package-build-inputs.sha256` 为451个生产输入；`package-verification.json` 为成品元数据、UUID、哈希及历史包保持核验。完整测试汇总见 `baseline-validation-summary.json`；专项原生探针结果见 `automation-native-diagnostics.json`；开启真实记录器的同步集成输出见 `automation-native-sync-integration-active.log`。完整本地审核与构建日志留在 WeChatImprove-local-archive/audits/2.5-13-diag.1。

已通过的重点验证：记录器16285项、回复关联639项、被动原生探针2081项；开启／关闭记录的同步集成分别保留528项业务断言，开启时实际观察547条记录和同步阶段顺序；原始解析、原生动作、拍动 Hook 与 Manager 相关回归通过。新录制代次有跨停止／重启／清空／到期测试。arm64 与 arm64e 严格对象编译和完整 Rootless 打包通过。最初新增探针的 ARC switch 作用域编译问题已修正后重新冻结并完整构建。

这些是本机及合成输入验证，不能证明手机通知实际到达、真实群缓存状态或发送送达。群后台回前台才回复仍为待定位问题。
