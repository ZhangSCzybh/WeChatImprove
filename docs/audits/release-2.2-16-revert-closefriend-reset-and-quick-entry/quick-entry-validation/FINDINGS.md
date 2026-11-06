# 2.2-16 头像五连击：实现、证据与范围

## 实现与作用域

`Controllers/CSCustomViewController.m` 只在插件主设置页头像安装单击 `UITapGestureRecognizer`。每次成功 Ended 记录 `NSProcessInfo.systemUptime`，相邻点击最多 0.8 秒；超时或时间倒退重新从第 1 次计数，第 5 次立即呈现明确风险确认。没有等待凑次数的 `dispatch_after`、轮询或新增定时器。

点击显式 `requireGestureRecognizerToFail:` 原有 2 秒长按：短按抬手使长按立即失败，单击随后成功；长按成功后单击失败。长按 Began 清除点击计数，原来的发现入口行为仍调用原 Manager API。微信首页标题的 recoveryGesture 代码不在本改动范围。

第 5 次后的确认框直接说明：该入口无需密码，可查看和修改当前账号的密友/密群名单及保护选项；任何能操作已解锁手机的人都能使用。进入本身不解锁微信聊天列表；用户主动修改保护选项会按其选择改变隐藏规则。修改密码与整组重置不获此凭据权限。

## 页面访问与聊天解锁分离

Runtime 增加仅内存保存的随机 visit nonce，独立于原 authenticationToken。页面获得当前账号/epoch/nonce 的访问票据，只有这次设置访问可以读和显式保存 profile，复用原规范化和加密存储逻辑。发票据、进入、退出均不改变 `revealed`、`revealUntil`、密码或永久偏好。

普通入口仍检查原密码授权。快捷页的修改密码/整组重置按钮明确要求从普通入口认证，不创建新的无密码重设能力。快捷页当前状态按真实 snapshot 显示“保持隐藏”或“临时显示”。

设置页与其原生联系人选择模态子流程属于同一次访问；回到插件主设置、关闭设置导航、跳转其他页、后台或切号均令票据失效。复制出来的旧票据也不可再读写。`willMoveToParentViewController:nil` 补上设置页已被全屏 picker 遮住后程序化 pop 的生命周期窗口；晚到的 picker 回调还检查原 owner 是否仍为 navigation.topViewController。

页面的读取、回调和保存同时校验原生全局 epoch/暂停边界，保存使用 `CSBackupPerformAtAccountEpoch` 锁内刷新账号并复核票据。即使原生账号边界已变化、主线程通知尚未交付、Runtime 缓存仍旧，旧页也不能读写旧账号。

合法持久化 state 且 auth 缺失（2.2-15 曾删掉密码）可获得独立页面票据；普通密码 token 仍为 nil、Runtime blocked 仍维持原 2.2-14 安全行为。损坏 state、凭据读错或真实 reset pending 均不能获得此页面访问。

## 可重复红绿

Runner：`run_validation.py`。测试：`QuickEntryTests.m`。

同一测试文件 SHA256：`227c54528f0acfaecb1ea7f3749d2608889edda114dda3df94653d7954297eaa`。

- frozen 2.2-15：`red-final/run.log`，40 个检查、12 个失败，运行退出码 1。
- 当前生产：`green/run.log`，90 个检查、0 个失败，运行退出码 0。
- 两次的 `provenance.json` 保存生产路径和逐文件 SHA256；运行时抽取实际 Custom/Settings 方法及实际 Manager.resetStorage block，链接真实 Crypto/Policy/Store/Reset/Runtime，所有数据写到独立临时目录和安全记录替身，未接触用户 Keychain、数据库或微信状态。

红失败实际包含：旧版没有头像 tap、没有手势失败依赖、第五次不能进入、断开后的新序列不能进入、缺页面 API；两组旧 marker 无法清除且不能进入新页面。新断言没有修改任何既有测试。

绿色覆盖：4/5 次边界、相邻 0.8 秒与 2 秒超时、长按互斥、风险确认、自动 dismiss 转场等待、转场期间新 modal 保留、取消后旧确认无效、后台/切号、全局 epoch 先变而 Runtime 通知未到、页面退出复制票据失效、原生 picker 临时模态不撤销、picker owner 被移除后的晚回调、显式保存名单/保护选项不改变 reveal/计时器、密码/整组 reset 仍需原凭据、损坏文件拒绝访问、already-locked 时撤票据仍发布清页通知。

另外联合真实遗留清理 block 与缺 auth 的 state，分别保存 hidePluginEntry=NO/YES：当前账号 credential-reset marker 清除且重复加载后不复现，另一个账号 marker 字节及两账号 state 文件字节不变，页面内能查看原名单，微信列表仍隐藏。

## 证据边界

以上是主机测试；UIKit 手势识别、原生 picker 实际呈现、手机上的视觉间距与设备安装均**未验证**。stub 的失败依赖断言证明生产安装了指定依赖，不能替代真机验证 UIKit 手势仲裁。

`MigrationQuickEntry` 通过已创建的插件主设置页验证页面局部路径；hidePluginEntry=YES 时原内置根入口的可达性由主审计另行说明，不能把这个用例当作已证明根入口可达。
