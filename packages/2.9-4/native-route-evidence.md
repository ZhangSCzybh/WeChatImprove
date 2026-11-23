# 微信 8.0.80 切换账号入口静态核验

本记录区分发货二进制的静态事实、项目实现选择和未验证的设备行为。未运行或安装微信，未执行账号切换；不把静态分析描述为真机观察。

## 参考输入

- IPA：`/Users/zhangshichao/Downloads/Telegram Desktop/com.tencent.xin_8.0.80.ipa`
- IPA SHA-256：`5cacb443b743793ccfe6026bc81c1f2678cb5cfdcd38584ad73ac7f19ecf4a5f`
- 对应头文件：`/Users/zhangshichao/Downloads/Telegram Desktop/8.0.80/Main/WeChat`
- Bundle：`com.tencent.xin`；版本 `8.0.80`，build `8.0.80.34`。
- IPA 内主程序 `Payload/WeChat.app/WeChat`：545074336 字节，arm64，`cryptid=0`。
- 主程序 SHA-256：`1d626426df97058a8a87c661532b2801cd27b7d9fcc12e27609c751f5877b7ed`。

使用本地 Mach-O 映射、selector/class references 解码和目标地址范围的只读 ARM64 反汇编；地址是未叠加 ASLR slide 的虚拟地址。头文件用于定位与对照，行为结论以对应机器码为依据。REA 的目标身份会话已关闭，大型程序全量分析未完成，因此未引用不存在的反编译或运行结果。

## 原生设置行与首次提示

| 观察位置 | 机器码确认的行为 |
| --- | --- |
| `NewSettingViewController.reloadTableData`，`0x10544b2c8` | selector ref `0x11eb3a6b8` 解码为 `showLoginInfo` |
| 同方法，`0x10544b320` | 本地化键 `Login_LoginInfo_Mgr` |
| 同方法，`0x10544b33c–0x10544b358` | 调用 `centerCellForSel:target:title:`，action 为 `showLoginInfo`，target 为设置页自身；位于 iPhone 分支 |
| `showLoginInfo`，`0x10544da84–0x10544dd28` | 已看过提示时调用 `gotoSwitchAccount`；否则创建并持有 `m_introView`、设置 native delegate 后显示首次提示 |
| `onClickTipsBtn:Index:tipTag:`，`0x10544dd28–0x10544ddfc` | 原生保存已看提示状态，然后自行调用 `gotoSwitchAccount` |
| `gotoSwitchAccount`，`0x10544da10–0x10544da84` | 创建并持有 `WCAccountSwitchLogic`，设置 delegate/root owner，调用 `startLogic` |

`MMTipsViewController` 继承 `MMWindowViewController`。`show`（`0x115945830`）设置 scene 后调用父类。父类 `showWithAnimated:inWindow:showEndEditing:` 在没有 window 参数时，于 `0x11582165c–0x115821668` 创建 `MMUIWindow`，随后使用 `MMWindowMgrObject` 持有原生 window/controller。因此首次提示可能出现在独立窗口，不能仅用业务页的 `presentedViewController` 或“window 必须相同”作为识别条件。

## 检查与账号列表

普通账号的原生流程是 `WCAccountSwitchLogic.startLogic` → `WCAccountLogoutLogic.startCheckSwitch` → 状态 1 的检查 → `onLogoutCheckOK` → `onAccountLogoutLogicCheckOK` → `WCAccountControlData` / `startOneClickLoginLogic:Data:` → `WCAccountNoPwdAuthLogic.startLogic` → `WCAccountLoginUsersViewController`。

该普通路径在展示列表前没有提交 `LogOutRequest`。选择账号后的分支才进入原生授权或退出再登录流程。`isRunningAsBakDevice` 等特殊原生状态存在不同分支，不能据此保证所有状态的退出时序或插件 account epoch 均相同。插件不自行重建这些检查。

## 本项目实施与验收边界

`2.9-4` 调用真实设置行的 `showLoginInfo`。设置 owner 进入捕获的业务窗口且转场结束后，只调用一次；后续检查可见账号列表，或设置页实际持有且由它担任 delegate、`isObjShowing` 返回真、已挂载同 scene 窗口的精确提示对象。提示交接后由原生 callback 继续，插件不再次调用内部 `gotoSwitchAccount`，不直接创建账号逻辑、指定账号或调用退出／登录接口。

主机回归验证异步状态与防重取消边界；实际原生页面、提示交互、单账号／多账号与特殊账号状态仍待原设备验收。
