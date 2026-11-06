# 2.2-17 独立初审

审查对象为当前 2.2-16 未提交工作树；本审查未修改生产代码、历史断言、Keychain、用户账号库或历史产物。这里的行号对应初审时的 2.2-16 源码，最终实现需重新核对。

## 结论

完整重置成功后，现有「头像长按 2 秒 → 发现捉迷藏呀 → 普通入口 → 设置新密码」代码路径可用，不依赖旧 verifier。无需为快捷页放开“修改密码”，也无需重新引入 2.2-15 的凭据重置/重新设密 API。实际方法提取主机测试已执行：未修改 2.2-16 原路径 50/0；新增快捷终态分支后同 fixture 在冻结 .16 为 51/1、当前实现 105/0，详情见 `new-password-validation/README.md`。

现有 forward-only 协议保证未完成重置无法作为正常账号状态使用，并在加载账号前恢复；它不是跨密文文件、NSUserDefaults 和 Keychain 的物理原子事务。故应明确区分“存在带 intent 的中间存储步骤”和“半清状态能被用户读取/使用”。用户要求的后者可以验证；前者在保留现有机制的约束下不可宣称不存在。

## 重置完成后的设密真实路径

1. `CSCloseFriendReset.m:53` 的 finish 按顺序删除当前账号密文文件、入口发现记录，然后删除当前账号的 `biometric-domain`、`auth`、`policy`，最后才删除 `reset` intent。`CSCloseFriendStore.m:135` 对账号哈希命名的文件删除并 fsync，`CSCloseFriendEntryState.m:49` 删除当前账号哈希命名的发现偏好并同步。
2. `CSCloseFriendRuntime.m:269` 在成功时置 `state={profile: empty, muteRecords:{}}`、`credential=nil`、`blocked=NO`。进程重启后 `synchronizeAccount:epoch:suspended:`（`:63–73`）先 resume，再发现 state/auth 均缺失，构造相同空 profile，`state!=nil && !credential` 为假，不会将完整重置后的新设置状态误判为“有名单无 verifier”。
3. 默认 profile `enabled=NO`，因此 `CSCloseFriendBridge.m:15` 的全插件入口隐藏条件为假；`CSCloseFriendEntryState.m:26–36` 因无 credential 且无发现记录使“捉迷藏呀”隐藏。与“尚有名单、只有 auth 被删”的 2.2-15 残留场景不同。
4. `CSCustomViewController.m:567–574` 的原 long-press recognizer 最短两秒。`:604–608` 的 touch 委托获取 `settingsEntryDiscoveryToken`，该 Manager 方法（`:380–384`）使用 `runtime.authenticationToken`，不要求已有 credential。`:610–622` 的 Began 事件调用 `discoverSettingsEntryWithToken:` 并重建菜单。
5. `CSCloseFriendManager.m:386–392` 在账号 epoch 互斥内检查当前 token，通过 `EntryState.discoverEntryForSnapshot:hasCredential:` 写当前账号发现记录。该方法在空且未阻断 snapshot 上可成功（EntryState `:38–47`）。
6. `CSCustomViewController.m:692–696` 重新增加“捉迷藏呀”；`:975–976` 点击后调用 Manager `presentSettingsFrom:`（`:395–402`），先检查入口显示，再 `authenticateFrom:`。
7. Manager `authenticateFrom:`（`:342–374`）取当前认证 token；`:354` 明确 `setup=![self.runtime hasCredential]`。完整重置后 setup=YES，跳过生物识别支路，`:374` 调用 `passwordPrompt:token:setup:YES:completion:`。
8. `passwordPrompt`（`:259–281`）显示“设置密友密码”与两次输入；`:269–274` 验当前 token、两次一致，在原账号 epoch 互斥内调用 `runtime setPassword:token:error:`。Runtime `:127–137` 在 credential=nil 时不要求旧授权，使用原有密码规则生成新盐和 PBKDF verifier 并写 auth。随后原 `lock` 和 `authenticatePassword`（Runtime `:93–103`, `:144` 起）可按新 verifier 锁定/解锁。

建议测试必须从真实重置成功结果出发，而非手写 `credential=nil`：断言存储 state/auth/discovery 删除，模拟原头像 longpress Began、实际发现方法、实际普通 present/authenticate/passwordPrompt 方法，观察 setup 标志与两个输入框，输入新密码，lock 后旧密码失败、新密码成功。另测新进程加载后的相同路径，避免仅覆盖成功时内存分支。

## 快捷页放行的安全约束

- 仅移除 `CSCloseFriendSettingsViewController.m:236` 的 section 2 禁止项，保留 section 0 row 3 修改密码禁止。
- 原普通重置 `resetFrom:` 仍需密码 proof，原 `canResetFrom:token:`、`prepareResetWithPassword:`、`resetWithToken:` 语义不得因快捷页而放宽。推荐快捷页以独立 settings nonce 进入两级确认，最终复用同一个 `resetStorage(account,YES)` 入口。
- 不应把页面 settings token 转换成普通 authenticationToken 或伪造 `isAuthorized`；它不应扩大到 reveal/chat 密友解锁。
- 第一级明确逐项清空/保留内容、风险及不可撤销；第二级使用 destructive action；两级取消及中途页面失效都应零存储变更。
- 末级 destructive action 内，在 `CSBackupPerformAtAccountEpoch(token.epoch)` 锁中再次验证 global epoch、suspended、foreground、host/top、settings nonce，再开始重置。不能只依赖确认框弹出时的检查。
- 模态框的自动 dismissal 与后续页面转场复用 `finishResetAlert`；不能 dismiss 更新的 modal 或整个设置 navigation。
- 开始重置前须使页面令牌失效，失败也不得继续读/写旧名单。成功回调显式 `invalidateQuickEntry`、`resetFinished=YES`、执行原 `leaveAfterReset` 收尾；旧复制 token 也应失效。

## 中断恢复：需要验证的边界

现有 Reset `beginResetForAccountID:`（`:29–39`）先写 `CSResetIntent`，读回确认，再调用 finish。finish 每步幂等，最后删除 intent。Runtime 普通 reset（`:262–272`）在执行存储前撤销 token、generation++、revealUntil=0、blocked=YES；加载（`:63`）必须先恢复，再读 profile。快捷路径也必须有同样发布顺序。

断点至少覆盖：intent 写入后、readback 后、密文删除前/后、发现记录删除后、biometric-domain 删除后、auth 删除后、policy 删除后、intent 删除后。每个断点新建 Runtime 模拟进程重启；恢复失败保持 blocked 且无可用 settings token，恢复成功只发布全空状态。原协议有意在密文已删除但 key 尚在时保留 intent，不能将这种安全删除顺序记录成“从未出现物理半状态”。无 intent 时也不能有未完成步骤；policy key 不可先删以免出现无法读取且无法恢复的密文。

跨账号断言应逐字节比较另一账号所有 key 的集合和值、密文文件内容、defaults key 集合和值；不能只比较名单数量。取消路径应对整个当前账号和另一账号的存储快照逐字节比较。

## 审查范围限制

初次实现复审发现：合法持久化 state 但 auth 缺失的账号保持 blocked，每次 Manager refresh 都重新 synchronize。它会保留成功加载后的 settings nonce，却通过 `invalidateSearchVerification` 清除第一层确认准备的 reset proof。若末级确认先 refresh 再直接用旧 proof，会导致实际重置被拒绝。建议末级动作在 epoch 锁内 refresh 并重新验证当前 settings nonce 后，仅对该快捷 nonce 重新 prepare proof，再调用原 resetWithToken；不得让普通密码 proof 跨同步继续有效。已通知主任务与实现者，须追加先红后绿的实际 Manager 两级链断言。

这里只作源码独立审查与主机测试；最终代码及缺陷修复仍待冻结后复核。真机 UIKit 手势仲裁、确认框转场、iOS Keychain durability、进程实际强杀均未验证。最终复审将对冻结的实现和主机证据重新核验。
