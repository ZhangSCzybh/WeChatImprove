# 2.2-17 快捷页完整重置验证

基线为本次任务开始时冻结的 `baseline-2.2-16/`，不是 Git HEAD。没有修改任何既有测试断言，也没有修改 `CSCloseFriendReset.h/.m`、EntryState、Crypto、生物识别与首页 recovery 代码。

## 修改及权限边界

- Settings `didSelectRowAtIndexPath:` 的拒绝条件仅收窄为 section 0 / row 3。section 2 调用原 `resetCloseFriends`；修改密码仍拒绝。
- `resetCloseFriends` 根据 quickEntry 选择新 Manager overload，成功后显式 `invalidateQuickEntry`，再走原 `resetFinished` / `leaveAfterReset`。
- Manager `resetFrom:settingsToken:completion:` 仅增加第一层风险说明；第二层继续使用原 `confirmResetFrom:token:completion:` 的红色 destructive action。
- Runtime `prepareResetWithSettingsToken:error:` 只准备当前 account / epoch / 随机 visit 的内存 proof；最终仍由原 `resetWithToken:error:` 调用同一 `resetStorage(account,YES)`，进入未修改的 `CSResetIntent`、`beginResetForAccountID:`、`resumeResetForAccountID:`。没有新清理 kind / 分支。
- 两级确认分别有一次性 decision guard，取消后旧 action、重复 action、同 visit 开启下一轮后旧 action均不能借用新 proof。
- 每一级转场完成后重验前台、页面、nonce、外部 epoch；最后执行在 `CSBackupPerformAtAccountEpoch` 锁内刷新账号后再核对。新 modal、切号通知尚未抵达 Runtime 等窗口均拒绝。
- `resetPending` 仅存在内存，用于已确认重置期间及失败后禁止重签 / 使用设置 nonce，不改变原来的 state、credential、snapshot 或删除顺序。成功或恢复并成功加载后解除。不存在新的永久授权偏好。

## 两项通过失败复现发现的问题

主 fixture 抽取了实际 Manager `refreshAccount`，而非用空实现替代。

1. **合法 persisted state 但 auth 已被 2.2-15 删除**：每次 refresh 会 reload blocked Runtime，清掉刚准备的 reset proof，导致最后一步失败。修复前 `missing-auth-red/run.log` 为 209 / 2 失败，修复后同 fixture 209 / 0。现在仅在成功 reload 后，原 same-account / epoch / exact settings visit 仍有效时恢复它的 quick reset proof。普通 password proof从不进入该恢复分支；取消后 nil proof也无法恢复。
2. **取消后的旧 UI action**：同 visit 新一轮 reset proof与旧 visit 相等，旧 destructive callback可借新 proof；旧 Continue也可在取消后重新弹末级。`cancelled-callback-red/run.log` 为223 / 4 失败，修复后223 / 0。两级一次性 guard消除此复活路径，普通密码分支不受新增 quick guard影响。

## 最终红绿与 provenance

- `red-final/`：冻结未修改 2.2-16，54 检查 / 3 失败。失败为：快捷页原拒绝判断、缺少 scoped prepare、缺 auth 的快捷页重置仍被拒绝。依赖入口/API的新分支在基线不存在，因此红绿检查总数不同，没有放松断言。
- `green-final/`：最终源，259 检查 / 0 失败。
- 两次运行复制相同 fixture / runner，SHA256见各自 `provenance.json`。生产 `.m` 与相关新增 `.h` 的 SHA也已记录。
- Settings routing抽取该生产方法的原样前缀，精确覆盖初始授权、修改密码拒绝、section 2 分派；其余联系人选择和选项分支不在此测试内。
- Manager确认与两条入口方法、真实 refreshAccount / validateToken、真实 Runtime / Store / Reset / EntryState / Crypto均参与执行；UIKit为主机 double，账号服务为固定测试账号 provider，Keychain为独立字节字典。没有触碰用户真 Keychain。

原 Manager `resetFrom:completion:`、Runtime `prepareResetWithPassword:token:error:`、Settings `leaveAfterReset` 三个方法与冻结 2.2-16的提取 SHA完全一致，见 provenance 中 `unchanged_normal_method_sha256`。普通入口仍先输入旧密码，再原 destructive确认；取消未改变任何持久字节。

## 覆盖

- 快捷页修改密码仍拒绝；重置通过两层确认执行。
- 展示确认、不确认、两层取消：文件路径/字节、全部 secure key集合/NSData、测试 defaults domain逐项比较无变化。
- 成功清空当前账号 state（名单、options、legacy muteRecords）、auth、biometric-domain、policy key、discovery与intent；profile恢复empty/default，enabled=NO，入口不可见。
- 完成后旧settings nonce立即失效、`quickEntryToken=nil`、`resetFinished=YES`、执行原退出方法；普通再次访问不能复用它。
- 当前账号之外的 b 账号：secure完整key集合和每条NSData、state原始bytes、discovery的精确key/value二进制plist全部保持一致。
- 逐一在 state删除、biometric-domain删除、auth删除、policy删除、intent最后删除故障位置中断；任一存储删除callback观察时Runtime均blocked、无currentProfile、无auth token、不能签发settings token，复制nonce也失效。新Runtime先恢复全部清理，再发布空profile。
- intent写入失败：所有持久字节不变，原state / credential保持、snapshot保留原enabled/options且blocked，不能重签quick nonce；成功重载后才允许新visit。
- 真正未知intent、真正整组未完成intent不被当退休marker忽略；旧 `credential-reset` 在缺auth场景仍通过原Manager block清理。
- external epoch先变、Runtime账号变、后台、suspended、页面离开、新modal拒绝任何持久写入。
- 新密码可设，lock后旧密码失效、新密码验证成功。原头像长按/重新发现/普通入口setup全链另见同级 `new-password-validation/`，未增加新设密入口。

## 实际 SIGKILL 测试与原子性限度

最终fixture启动同测试binary的真实独立子进程。注入secure writer将精确CSResetIntent及测试secure字节字典原子写入临时checkpoint文件后，立即 `kill(getpid(), SIGKILL)`，尚未调用state删除。父进程核验终止reason为signal、status=9；读回 durable intent，核对ciphertext/policy/auth均保持原字节；新建Runtime通过原resume路径完成所有清理并发布关闭保护的空profile，b账号所有字节不变。

这是实际进程被杀恢复，但secure存储为临时文件持久化double，不是iOS Keychain。原实现跨文件、defaults与Keychain逐项删除，**物理层面存在清理中的中间状态，不是跨存储原子事务**。安全保证是intent期间及任一步失败均不对任何授权观察者发布半清状态；intent最后清除，后续加载只能前向恢复。保留原state先删除、policy key后删除的顺序，不能为了声称物理原子性改变它。

真机 UIKit / Keychain / 实际手势未验证。

## 风险告知

首级确认、末级确认、section 2 footer明示：任何拿到已解锁手机的人，连点头像5下并确认，即可不可逆清空当前账号整个密友配置。这使无密码页面访问进一步扩大到配置删除能力；两级确认防误操作，不能抵挡有意操作者。修改密码、生物识别和校验规则未放宽，其他账号不受影响。
