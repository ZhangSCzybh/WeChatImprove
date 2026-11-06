# 2.2-17 独立最终复审

基于实现者宣布冻结后的当前工作树，检查源码及主机测试证据。未修改生产代码、既有断言、真实账号数据或历史包。审查源码的准确 SHA256 在 `review-final-source-sha256.json`；本结论仅适用于该快照。未发现本次范围内尚未修复的阻塞缺陷；构建/全部回归放行由主任务另外核对。

## 放行范围与确认

`CSCloseFriendSettingsViewController.m:236` 的 quickEntry 禁止条件仅保留 section 0 row 3，因此修改密码仍拒绝；section 2 使用原 resetCloseFriends 路由。该方法根据入口类型调用 Manager 原密码入口或新增 settings-token 入口，成功后显式 invalidateQuickEntry、resetFinished 并执行原 leaveAfterReset（`:313–328`）。原 leaveAfterReset 完整字节不变。

Manager `:473` 的快捷入口第一层列出全部删除项、不受影响的数据、不可撤销及无凭据破坏风险；点击“继续”才进入 `:424` 原不可撤销说明和 destructive“重置密友”。两级各有一次性 decision guard，取消后旧 callback 不能重新激活，旧 destructive 也不能借同 visit 新一轮的 proof；普通密码分支不新增此限制。末级在 account epoch 互斥内 refresh 并再次检查前台、账号 epoch、suspended、page top 和实际 settings nonce，才执行原 resetWithToken。

## 两个实际边界缺陷的修复复核

1. **pending reset 仍可重签页面权限。** `.16` reset 失败保留内存 state/credential，原 settingsAccessToken 只要求 state 存在，可能给 pending 账号签发新 nonce。本版增加仅内存 resetPending（Runtime `:23`, `:119`, `:125`, `:281`）：确认后开始 reset 时置位，阻止新令牌及旧令牌的页面读写；成功或 resume+load 被接受时清除。state/credential 本体、snapshot 隐藏与锁状态语义保持旧行为，没有用清空 state 来掩盖 pending。
2. **合法 state 缺 auth 时末级 refresh 丢 reset proof。** 缺 auth 的持久化名单保持 blocked，每次 refresh 会重载并 invalidate。Runtime `:61` 只捕获当前合法 settings nonce 的 reset proof，原 invalidate 仍执行；仅 resume+state/auth 成功读取、同 account/epoch 的原 settingsAccess 成功恢复后，`:80` 再次判断 nonce 才恢复这份 quick proof。普通密码 proof 从未捕获；取消后的 nil proof 不会恢复，跨号/epoch/后台/pending 不能恢复。

没有采取“末级重新 prepare”方案，避免该方案自行绕过已取消 proof；两层一次性 UI guard 进一步防同 visit 回调复用。实际缺 auth 两级 Manager 回归已先红 209/2 后绿 209/0；取消/旧回调专项已先红 223/4 后绿 223/0。

## 重置协议与隔离

Reset.h/m、EntryState.m、Bridge.m、Policy.m 均与冻结 .16 字节一致；`CSResetIntent`、begin/resume、退休 credential-reset 标记清理和严格未知 intent 处理未改。Manager 从 checkHomepageSearchPassword 到文件末尾也保持字节一致，首页搜索/长按解锁代码未动。

新增 quick proof 只拓宽确认后允许调用原 resetWithToken 的权限来源，不签发普通认证 token，不触发 reveal，不新增清理逻辑。最终仍通过相同 resetStorage(account,YES) → beginReset → secure intent 写入读回 → finishReset；最后才移除 intent。

主 fixture 在 intent 后/密文删除前、biometric-domain、auth、policy、reset 删除失败等断点检查 blocked、无 currentProfile、不可签发 settings nonce、复制 nonce 不可用；新 Runtime 加载在 resume 完成后才发布空状态。另一个账号 secure key 集合及每个 NSData、密文文件字节、发现记录原始 key/value 二进制 plist 均比较不变。取消两层确认对全部持久化快照比较相等。

**物理存储并非跨文件/Keychain 原子提交。** 原 forward-only 有意先持久删除密文、再删除密钥，因此可能存在“密文已删、key 尚在、intent 尚在”的安全删除窗口。本版保证该窗口不作为可用状态发布、任何入口不能读写半状态、下次恢复继续完成；不能声称存储层从未存在中间步骤。这里的中断测试是故障注入和重建 Runtime，非真机强杀。

## 原重新设密路径的独立执行证据

`new-password-validation` 直接编译生产 Reset/Store/EntryState/Runtime/Crypto/Policy，逐字提取 Custom 长按和 Manager discovery/present/authenticate/passwordPrompt。原普通重置路径先在冻结 .16 跑 **50/0**；新增快捷终态分支而不改这 50 项断言后，同一最终 fixture 在冻结 .16 跑红 **51/1**，当前冻结实现独立复跑 **105/0**（`green-release/run.log`）。

普通与快捷重置都覆盖同进程及重新构造 Runtime：真实完整 reset 删除 state/auth/discovery 后，原两秒长按可取得 discovery token 并发现入口；原 ordinary authenticate 因 hasCredential=NO 显示“设置密友密码”两输入框；实际 passwordPrompt 使用原 setPassword 生成新 verifier；随后原 lock 生效、旧密码拒绝、新密码解锁成功。故无需放开“修改密码”，也无需增加无凭据改密 API。测试调用 UI doubles，真实菜单标题跳转分支已源码核对；不证明真机手势仲裁或UIKit转场。

主快捷 reset fixture 亦独立复跑 **243 checks / 0 failures**（`quick-reset-validation/independent-review/run.log`），含两级确认、取消、pending 各删除阶段、跨号隔离、缺 auth、旧回调、普通入口不变。它与上述 105 项是两套不同测试，不能合并为真机验证。

## 风险告知

第五击入口提示、重置两级确认、section 2 footer、.17 应用内发布说明均明确“任何能操作已解锁手机的人，可五击并确认后不可逆清空整个密友配置”。两次确认仅防误触，不验证身份。此版扩大的是已解锁设备操作者的删除能力；原密码保密边界对名单查看已在 .16 快捷页放开，本版再移除整个密友配置删除时的原密码边界。确认前进入页面本身仍不解锁微信列表，执行完整重置则按用户明确授权关闭保护。

真机手势、UIKit 转场、iOS Keychain 及强杀恢复：**未验证**。

## 最终 fixture 补充：主机实际 SIGKILL

在上述已复审生产源码完全未变的情况下，主 fixture 新增主机实际子进程 kill 测试。独立复跑最终 fixture：**259 checks / 0 failures**，日志在 `quick-reset-validation/independent-final/run.log`，源码/test/runner SHA256 在同目录 `provenance.json`；最终测试 SHA256 为 `6bf19aeff02a07aabfe3ae362141a12e8ce4338a3d5ddf5f10319f38a9fdf233`。既有独立 243/0 证据及以上历史审查内容保留。

检查 `QuickResetTests.m:86` 的 crash checkpoint：测试 secure writer 收到真实 `CSResetIntent` 写入后，先将隔离 secure 字典以 atomic plist 保存，再调用 `kill(getpid(),SIGKILL)`；此位置在 writer 返回和 reset intent readback 之前，因此也在清除名单前。`:387–396` 使用 `NSTask` 启动独立程序，父进程确认终止原因为 uncaught signal、status 为 9，读取保存的 secure 数据，确认精确 intent 仍在、当前账号密文及 policy/auth 与杀进程前逐字节相等，再构造新 Runtime 执行生产 resume 完成全部删除。

另一个账号比较覆盖全部 `b/` secure key 集合和每个 NSData、密文 state 字节，以及账号哈希对应 discovery 的原始 key/value 二进制 plist；kill 前后及恢复后均一致。独立输出为：

```text
Actual SIGKILL recovery: signal=9, durable intent recovered, other account unchanged
Quick reset: 259 checks, 0 failures
```

这是 **macOS 主机子进程实际 SIGKILL＋隔离文件/模拟 secure 存储** 的证据，不是 iOS 设备进程或真实 Keychain 的验证，也不证明断电 durability。iOS 真机手势、转场、Keychain 及强杀恢复仍为 **未验证**。物理删除窗口与 forward-only 可观测状态的界限，仍以本报告前述说明为准。
