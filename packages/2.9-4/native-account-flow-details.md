> 本文为本机静态调查报告副本。文中提及的 `.asm` / references JSON 保存在原证据目录 `/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-account-switch-evidence-d_imrjwq/`，未随安装产物分发。入口及首次提示的发布核验见 `native-route-evidence.md`。

# WeChat 8.0.80 原生切换账号：检查、列表与退出时序静态证据

## 结论

在普通账号、原生账号检查正常通过的路径中，`startCheckSwitch` 并不发送退出登录请求。它以状态 `1` 执行检查，检查成功后通过 delegate 启动 `WCAccountNoPwdAuthLogic`，由该 logic 创建 `WCAccountLoginUsersViewController` 展示账号列表。真正退出走状态 `2`，其 `finalQuit:` 暂停同步、构造 `LogOutRequest` 并提交 CGI。

选择账号回调中的一条分支明确经 `WCAccountControlMgr.logoutCurrentAccount:` 调用之前登记的 `WCAccountSwitchLogic.logoutCurrentAccount`，因此“选择账号→请求退出→后续登录”的因果链完整可见。无密码 ticket 存在时进入另一个原生授权 logic；本报告不扩展该授权 logic 的全部内部实现。

这不是“任何状态、任何账号都绝不在列表前退出”的保证：`startLogic:` 中 `OnlineClientMgr.isRunningAsBakDevice` 为 true 的分支能直接调用 `finalQuit:4`。账号保护与密码检查 UI 也能改变交互路径，应交给原生入口处理。

本报告分析的是原生退出协议和 UI 顺序，不能单凭 native 的静态流程保证插件自己的 accountEpoch 计数绝不变化。

## 输入与方法

唯一输入二进制：

`/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-8.0.80-static-ne_tuqlq/WeChat`

头文件对照：

`/Users/zhangshichao/Downloads/Telegram Desktop/8.0.80/Main/WeChat`

仅使用只读 mmap 解析 Mach-O selector/class/ivar references，以及 `llvm-objdump -d --start-address --stop-address` 的有界反汇编。未使用共享 REA、未启动目标、未构建或清理项目、未联网、未改动项目。所有本次新增写入仅在本临时证据目录。

ARM64 调用约定：`x0=self`，`x1=SEL`，`x2/x3=前两个显式参数`。函数地址为未加运行时 ASLR slide 的映像虚拟地址，所有 stop 地址均 exclusive。

`resolved_references.json` 保存有界范围、直接 selref/classref 解析和 import branch trail。其 `selector_candidate` / `class_candidate` 为简化寄存器跟踪提示，可能有旧寄存器残值；本报告关键结论使用直接 selref 解析并人工对照寄存器和指令，不使用提示作为独立证据。

## 1. 初始 switch logic 只启动检查

`WCAccountSwitchLogic.startLogic`：`0x106b4b208–0x106b4b37c`，见 `switch_start.asm`。

关键调用：

- `0x106b4b278`：alloc/init `WCAccountLogoutLogic`。
- `0x106b4b2a4`：`setDelegate:self`。
- `0x106b4b2b8`：`getCurrentViewController`。
- `0x106b4b2d8`：`setRootViewControllerDelegate:`。
- `0x106b4b2f0`：`startCheckSwitch`。

`WCAccountLogoutLogic.startCheckSwitch`：`0x106b0ce88–0x106b0cf00`，见 `logout_start_check_switch.asm`。`0x106b0ceec` 设置 `w2=1`，`0x106b0cefc` 尾调用 `startLogic:`；selector slot `0x11ea24aa8`。

状态定义有直接比较指令：

- `isForCheckSwitch`：`0x106b0cf90–0x106b0cfa8`，`0x106b0cf9c cmp x8,#1`。
- `isForSwitch`：`0x106b0cf78–0x106b0cf90`，`0x106b0cf84 cmp x8,#2`。

两者读取同一 `m_status`，ivar slot `0x11eddfbf0`，有效偏移 `+0x40`。

## 2. 状态 1 成功回调，状态 2 退出

`WCAccountLogoutLogic.startLogic:`：`0x106b0cfa8–0x106b0d248`，见 `logout_start_logic_status.asm`。

- `0x106b0cfe0` 将参数存入 `m_status`。
- `0x106b0cfe8` 取 `isForSwitch`，true 直接 `finalQuit:0`，最终尾调用 `0x106b0d0cc`。
- 其余分支检查 `isForCheckSwitch`、`OnlineClientMgr.isRunningAsBakDevice`、`isMobileVerified`、`cannotModAlias`。
- `isRunningAsBakDevice` selector slot `0x11ea22208`，true 分支 `0x106b0d0a4` 取 `finalQuit:`，`0x106b0d0ac` 设置参数 `4`，同样尾调用。
- 普通账号检查分支分别去 `showNakedAcctProtectAlert`、`preFinalQuit` 或 `checkNeedSetPasswd`；不应由插件自行重建这些检查。

`preFinalQuit`：`0x106b0d7a0–0x106b0e0a0`，见 `logout_pre_final.asm`。

关键分流：

```text
106b0df84 ldr x1,[x8,#0x208]   ; selref 0x11eb86208 = isForCheckSwitch
106b0df90 bl  objc_msgSend
106b0df94 cbz w0,0x106b0dfc4

; 状态 1：只通知检查通过
106b0df9c ldr x1,[x8,#0x210]   ; selref 0x11eb86210 = onLogoutCheckOK
106b0dfc0 b   objc_msgSend

; 非状态 1：执行退出
106b0dfc8 ldr x1,[x8,#0x200]   ; selref 0x11eb86200 = finalQuit:
106b0dfd0 mov w2,#4
106b0dff0 b   objc_msgSend
```

`onLogoutCheckOK`：`0x106b0e0a0–0x106b0e16c`，见 `logout_check_ok.asm`。它取 delegate，检测 `respondsToSelector:onAccountLogoutLogicCheckOK` 后于 `0x106b0e13c` 回调该 selector。selector slot `0x11eb86250`。

## 3. 检查成功直接构造账号列表 flow

`WCAccountSwitchLogic.onAccountLogoutLogicCheckOK`：`0x106b4b734–0x106b4b9f8`，见 `switch_check_ok.asm`。

人工对照后的等价伪代码：

```objc
WCAccountControlMgr *mgr = [MMContext.currentContext getService:WCAccountControlMgr.class];
[mgr setSwitchLogin:self];
WCAccountControlData *data = [[WCAccountControlData alloc] init];
data.m_arrUserInfos = [NSMutableArray arrayWithArray:[mgr getLoginUserInfos]];
WCAccountManualLoginControlMgr *manual = [MMContext.currentContext getService:WCAccountManualLoginControlMgr.class];
[manual startOneClickLoginLogic:nil Data:data];
[[manual getCurrentLogic] setDelegate:self];
```

| 调用地址 | selector / class | 直接 reference slot |
| --- | --- | --- |
| `0x106b4b814` | `setSwitchLogin:` | `0x11eb84f88` |
| `0x106b4b830` | alloc/init `WCAccountControlData` | classref `0x11ed21ea8` |
| `0x106b4b880` | `getLoginUserInfos` | `0x11ea93138` |
| `0x106b4b8d4` | `setM_arrUserInfos:` | `0x11eb85020` |
| `0x106b4b934` | `startOneClickLoginLogic:Data:` (`x2=nil`, `x3=data`) | `0x11eb85080` |
| `0x106b4b990` | `getCurrentLogic` | `0x11ea1d088` |
| `0x106b4b9c0` | `setDelegate:self` | `0x11ecab618` |

`WCAccountManualLoginControlMgr.startOneClickLoginLogic:Data:`：`0x106b1c028–0x106b1c0d8`，见 `manual_oneclick_start.asm`。

- classref `0x11ed3acd8` = `WCAccountNoPwdAuthLogic`。
- `0x106b1c070`：`initWithData:`。
- `0x106b1c090`：`setRootViewControllerDelegate:`。
- `0x106b1c0ac`：manager `startLogic:`。

`WCAccountNoPwdAuthLogic.startLogic`：`0x106b24a68–0x106b24ae0`，见 `nopwd_start.asm`。

```objc
id vc = [self setRootviewController:WCAccountLoginUsersViewController.class
                         withData:self.m_data];
[self setLoginUsersVC:vc];
```

- classref `0x11ed3ad38` = `WCAccountLoginUsersViewController`。
- `0x106b24aac` 调用 `setRootviewController:withData:`，selref `0x11eb85820`。
- `0x106b24acc` 调用 `setLoginUsersVC:`，selref `0x11eb86590`。

这条已检查成功的 UI 创建链上没有调用 `finalQuit:` 或构造 `LogOutRequest`。

## 4. 选择账号后的退出链

`WCAccountNoPwdAuthLogic.onLoginUsersLoginUserName:`：主要 handler `0x106b25324–0x106b259b0`；其 completion block 位于 `0x106b259b0` 起。两部分一起保存在有界 `nopwd_select_user.asm`（stop `0x106b25ae0`）。

- 先于 `0x106b25380` 将用户选择写入 `m_data.m_userInfo`，selref `0x11ea30ea0 = setM_userInfo:`。
- 确认当前 VC 是 `WCAccountLoginUsersViewController`。
- 读取所选 `m_nsNoPwdLoginTicket` 并检查 `length`；有 ticket 的分支创建 `WCAccountManualAuthControlLogic`，在 `0x106b25778` 启动授权。
- 缺少 ticket 的分支于 `0x106b2592c` 调用 `WCAccountControlMgr.logoutCurrentAccount:`（selref `0x11e9d2d60`），传入 completion block，block invoke 地址 `0x106b259b0`。
- 该 block 后续通过 `WCAccountManualLoginControlMgr.startLastUserLoginLogic:Data:` 继续，调用地址 `0x106b25aac`，selref `0x11eb85088`。

`WCAccountControlMgr.logoutCurrentAccount:`：`0x106acc680–0x106acc79c`，见 `account_mgr_logout.asm` 与 `account_mgr_logout_references.json`。

```objc
if ([self isInSwitchView]) {
    self.callbackAtOffset0x30 = [completion copy];
    [self.switchLogicAtOffset0x20 logoutCurrentAccount];
} else if (completion) {
    completion();
}
```

- `0x106acc6b8`：`isInSwitchView`，selref `0x11eb84c90`。
- `0x106acc71c`：保存 copied block 到 ivar `+0x30`（ivar slot `0x11eddf8ac`）。
- `0x106acc730`：取 ivar `+0x20`（slot `0x11eddf8a8`）。
- `0x106acc73c`：对该对象调用 `logoutCurrentAccount`，selref `0x11eb85120`。
- `setSwitchLogin:`：`0x106acc79c–0x106acc7b0`，见 `account_mgr_set_switch.asm`，同一 ivar slot `0x11eddf8a8`，因此对象就是列表启动时登记的 switch logic。

`WCAccountSwitchLogic.logoutCurrentAccount`：`0x106b4b37c–0x106b4b3f8`，见 `switch_logout_current.asm`。对 `m_logoutLogic` 于 `0x106b4b3f4` 调用 `startSwitchToLogin`；selref `0x11eb86c98`。

`WCAccountLogoutLogic.startSwitchToLogin`：`0x106b0ce10–0x106b0ce88`，见 `logout_start_switch_login.asm`。`0x106b0ce74` 设置 `w2=2`，随后尾调用 `startLogic:`。由此进入前述 `isForSwitch` 和实际退出路径。

## 5. 实际退出请求和退出回调

`WCAccountLogoutLogic.finalQuit:`：`0x106b0e16c–0x106b0e3c0`，见 `logout_final_quit.asm`。

- `0x106b0e264`：`NewSyncService.makeSyncPause`，selref `0x11eb244f0`。
- `0x106b0e280`：alloc/init `LogOutRequest`，classref `0x11ed3ac88`。
- 构造 `ProtobufCGIWrap`，`setM_pbRequest:`、`setM_uiCgi:282`、`setM_douTimeout:15.0`。
- `0x106b0e334`：`EventService.CreateProtobufEvent:Flag:`，selref `0x11e9cb850`。
- 随后注册 event observer 并 `startLoadingBlocked`。

`WCAccountSwitchLogic.onAccountLogoutLogicDidQuit`：`0x106b4b9f8–0x106b4bae0`，见 `switch_did_quit.asm`。

- `0x106b4ba5c`：清空 `m_logoutLogic`（ivar `+0x30`，slot `0x11eddff1c`）并 release。
- `0x106b4bac0`：获取 `WCAccountControlMgr` 后调用 `quitLogin`，selref `0x11eb41ef0`。

不能把 DidQuit 当成账号列表展示前的必经阶段；列表是 CheckOK 回调启动的。

## 路由实现含义

主任务已在其他证据中证明设置原生 row 的动作入口是 `showLoginInfo`，首次提示确认后才继续 `gotoSwitchAccount`。本报告的 logout 检查结果支持继续使用完整原生入口：由原生保留账号保护、首次提示、列表选择、授权和退出顺序。

路由可以在 dispatch 前使用 account/session epoch 排除陈旧动作；dispatch 成功后，应把控制权交给原生逻辑。静态证据没有证明项目自己的 epoch hook 将保持不变；而 backup-device 特殊路径确有立即退出可能，因此不宜把“dispatch 后 epoch 必须不变”作为统一的动作成功条件。

## 文件索引

- `bounded_account_evidence.py`：只读 parser 与所有主要函数的有界反汇编脚本。
- `resolved_references.json`：直接 Objective-C references、bounded function ranges、import branch trails。
- `account_mgr_logout_references.json`：选择后转发退出方法的补充 references。
- `*.asm`：原始有界 ARM64 反汇编，文件名与各节对应。
