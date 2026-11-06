# 2.2-16 快捷入口独立只读复核

复核时间 UTC：2026-11-05T21:16:29.278924+00:00

本次只读审查最终 live Runtime 页面 nonce、密友 Settings 的读写/epoch/lifecycle、插件头像手势和确认框 dismissal。没有修改生产代码或测试，没有重复执行旧断言。已核对 quick-entry-validation/green/provenance.json 中全部生产 SHA 与现行源相同；归档日志为 **90 检查 / 0 失败**。该数字属于原执行结果，本报告不是另一轮新测试。

## 结论与剩余阻断

最终源码中，未发现除下述已知根入口可达性以外的新增阻断项；此前三项发现均已定点修复。**auth 已被 2.2-15 删除且 hidePluginEntry=YES 时，原样 .14 Bridge 和首页恢复行为仍可能令整个插件入口不可达**。清 marker 与页面 token 不能自行恢复那个根入口，也不能恢复已删除 verifier。此范围仍须根任务与用户决定，不能从 90 个头像/页面合同测试推断该账号形态可达。相关边界在 rollback-validation/FINDINGS.md 和 cleanup-report.md 中完整保留。

UIKit 原生手势识别先后、实际导航与 iOS Keychain 均未在真机验证。主机 doubles 与静态复核只能覆盖方法分支、持有的授权和事件合同，不等同设备 UI 验收。

## 先前三项发现的修复核对

1. **外部账号 epoch 已变化而 Runtime 通知尚未到达。** Settings `settingsTokenIsCurrent:`（现行 Settings.m:126）直接检查 CSBackupAccountIsSuspended 与 CSCloseFriendAccountEpoch，再验证 Runtime nonce，不依赖延后的 Runtime 通知。`settingsProfile` 先走同一检查；保存（:212）先进入 CSBackupPerformAtAccountEpoch，检查 suspended，刷新 Manager 后再次验证 token 才调用 Runtime 写入。外部 epoch 提前到达时，旧页读返回 nil、写不会进入旧账号。已有测试明确把 global epoch 提前到 Runtime 之前。
2. **微信已处于锁定态时撤销 nonce，没有刷新敏感行。** Runtime `lock`（Runtime.m:96）把 `self.settingsAccess` 纳入 changed 条件，再置 nil 并调用 changed，故原本没有 reveal timer 的 quick 页也会触发 policy 更新。Settings policyChanged 在 quick 授权不再有效时 invalidateQuickEntry、revalidate picker 并 reloadData；行数变成 0。不是只撤私有 token 而留下可见旧列表。
3. **原生 picker 打开期间 owner 被移除，迟到 completion 仍写名单。** Settings `willMoveToParentViewController:nil`（Settings.m:141）显式撤销 nonce；`viewWillDisappear` 亦对被 pop、dismiss、导航替换生效。即使漏过另一次 disappear，`settingsTokenIsCurrent:` 要求当前 Settings 仍是自己的 navigation.top。picker validity 与 completion 都复核此条件，save 再复核 epoch，因此迟到回调不能写。CSNativeContactPicker 的实际展示是独立 full-screen UINavigationController modal，owner 的导航 top 保持 Settings；该合法 picker 子流程不必因 owner 暂时被盖住就失效。

## Runtime 授权与隐藏边界

页面 token 只存在内存 `settingsAccess`，包含 account、epoch、独立 NSUUID visit。创建与验证仅基于已成功加载的合法 state、活动状态与账号边界，不修改 blocked、revealUntil、credential、失败计数或临时解锁时长，也没有新增 NSUserDefaults 或 Keychain 写入。普通 authenticationToken 无 visit，不能替代页面 token；复制旧字典也会在 invalidate 后失效。

同账号、同 epoch、active 的 missing-auth state 会在必要的 Runtime 重新加载后保留**同一次** visit，原因是该账号本来 blocked=YES，Manager 每次 refresh 都需重新验证存储；如果读取失败、账号/epoch变化或进入 suspended，就不恢复 visit。该逻辑不创建 verifier，也不使普通密码流程通过。

页面 profile 更新使用独立 updateProfile:settingsToken:error:，仍规范化数据并读回写入结果。名单和选项的主动修改属于该无密码页获准的能力；切换“启用/保护选项”本身会改变隐藏规则，不能承诺用户主动关闭保护后还保持相同规则。确认文案明确区分“进入本身不解锁列表”和“主动修改保护选项会影响隐藏规则”。修改密码与整组重置在 quick 页被挡住，Runtime 原来的密码权限也没有被页面 nonce 替代。

## 手势与确认框

只在插件主设置页 avatarImageView 安装单指单次 UITapGestureRecognizer；旧 UILongPressGestureRecognizer 的 2.0 秒、移动容差、触点数和原行为保留。tap 显式 requireGestureRecognizerToFail:longPress：短触释放会使 longPress 失败并交付单击；真正 longPress 识别成功会抑制 tap，并由原长按处理清除 tap 序列。没有相反的依赖，也没有 timer 或 dispatch_after 数次数。

计数在 Ended 时读取单调 uptime，超过 0.8 秒或时钟回退则从当前一下重新计数；第 5 下立即发起风险确认。进入前后台、切号、离开源页或长按都使序列/nonce失效。确认时及 dismissal 完成后再次检查来源页仍可见、navigation.top、是否有新的 modal、账号 epoch 与 nonce。转场代码只 dismiss 该 alert，不 dismiss 承载插件的 host。原生自动 dismissal 已进行时等待 transition completion；若后续出现竞争 modal，canDiscover 检查会拒绝 push，保留那个 modal。token 在 push 前转交设置页并从源页置 nil，因此源页自身 viewWillDisappear 不会误撤销已交出的访问令牌。

离开 Settings（pop、dismiss、替换、willMove:nil）、进入后台、lock 或账号边界使页面能力失效；再次直接普通入口仍使用原密码流程，再走快捷入口需新的 5 下。picker 作为当前 visit 的子操作保留授权，完成后仍回到同一 Settings；离开整个设置 visit 才结束。

## 风险告知

此入口没有校验密友凭据。任何可操作已解锁手机、能到达插件头像的人，都能连击并确认后查看和修改当前账号名单与保护选项。确认框、页面 footer、应用内发布说明均需保留该明示；“隐藏入口”不是认证保障。只限制密码与全组 reset，不能抵消名单保密边界已被撤掉的事实。

## 本次审查源快照

- `Controllers/CSCloseFriendRuntime.h`：`9bc00628b7c7c662a60f7e4c2ca7614aa7165ca6b1c8778edb90556d9c1ddc4d`
- `Controllers/CSCloseFriendRuntime.m`：`35de29d20061b58ae320cc824bd5526824b0cfc2672ba222734a1ea7a34a53f7`
- `Controllers/CSCloseFriendSettingsViewController.h`：`b4fecd4e976ba522bca92ac4a13ce3e9cdb75b683798c69c5f56acac2e3b7627`
- `Controllers/CSCloseFriendSettingsViewController.m`：`da567f1047a64a8bdabef42220aa6e4b1f641e50c80d7fcb1d0a88950e8609e9`
- `Controllers/CSCustomViewController.m`：`4fe22c3775424b65e204ba5eb5951024329afbdbc1d4924da593919e26859008`
- `Controllers/CSCloseFriendManager.m`：`4ad68df9b623f8797930b7c37ee15395240c10d3356c4a3d2db19b37a32324a2`
- `Controllers/CSCloseFriendBridge.m`：`7a052bf3316b45040747a7fd495b673c46ee5bc9224fc0b326db8380db1e2bdf`
- `Controllers/CSNativeContactPicker.m`：`2d7c6070247818648ae43639d51282b664965c656a3fd99b6c56a0dcde7bd003`


本快照无设备执行数据；手势、UIKit 转场和最终气泡像素均为 **未验证**。
