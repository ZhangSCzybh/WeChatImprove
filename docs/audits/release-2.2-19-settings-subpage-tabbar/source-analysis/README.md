# 2.2-19 原生底栏泄露：静态来源证据

本目录只读核对用户指定 8.0.80 IPA 的既存提取映像及当前插件源码。原生映像 SHA256 为 `571c5b8cf8732eb5402ffddcbeb93830cb6695bad180be5613ad4167764524e9`，与 2.2-15 审计一致；通过 REA `open_binary` 绑定身份后，用保留的 Objective-C 元数据 reader 与 `xcrun llvm-objdump` 定点反汇编。`rea-target-binding.json`、`native-provenance.json`、`commands.json` 保留工具和输入身份。未运行 WeChat，也未读取真实 MMTabBar 视图属性。反汇编中的 `_O266DecReleaseOutputPicture+...` 是最近残留符号标签，不能当方法名；方法身份由 Objective-C method list 的 selector、encoding、IMP 三者确定。

## 可由源码和二进制直接证明的机制

1. 插件原生「插件」列表注册的入口是 `CSNativeSettingsControllerClass()`：`Hooks/CustomEntryHooks.xm:261` 取其类名，`:268` 调用原生 `registerControllerWithTitle:version:controller:`。`Controllers/CSNativeSettingsHost.m:30–47` 动态建立 `MMUIViewController` 的子类 `CSNativeSettingsHostController`；根列表 `CSCustomViewController` 仅在 `:17–25` 被加入为内容 child。普通功能子页则直接 push 到此原生宿主所在的导航栈。
2. **原生根宿主继承了 `hidesBottomBarWhenPushed=YES`。** `MMUIViewController initWithNibName:bundle:` 的 IMP 是 `0x115878564`；`0x1158785cc` 载入 selector `setHidesBottomBarWhenPushed:`，`0x1158785d8` 设置 `w2=1`，`0x1158785dc` 调用。元数据里没有该属性 getter 的原生覆写。见 `MMUIViewController-initWithNibName_bundle_-annotated.asm:33` 起。
3. **插件功能页没有继承这项原生默认值。** `CSSettingsTableViewController` 继承 `UITableViewController`，2.2-18 全文没有 `hidesBottomBarWhenPushed` 声明/设置；四个纯编辑器直接继承 `UIViewController`。Apple SDK `UIKit.framework/Headers/UINavigationController.h:152` 明确该属性默认 `NO`。它不会因为当前页面的前一页是原生宿主就自动成为 `YES`。
4. **新版微信使用目的页/栈顶自己的属性重新决定显示，而非将栈内祖先的 YES 合并。** `WCTabBarBaseNavigationController pushViewController:animated:`（IMP `0x1157d7ca4`）在 push 前向 transition delegate 发 `tabBarNavigationController:willPushViewController:animated:`，随后走原生 super。`navigationController:willShowViewController:animated:`（IMP `0x1157d7d6c`）先处理原生导航布局，再向同一个 delegate 发 willShow；didShow 同样转发。
5. `WCTabBarController transitionForNavigationController:destinationViewController:animated:`（IMP `0x1157db5d4`）在当前导航栈 count≥2 时，`0x1157db648` 读取 **destination** 的 `hidesBottomBarWhenPushed`，`0x1157db84c` / `0x1157db8b8` 将其作为 `targetHidden`。willShow（IMP `0x1157db3fc`）取得该 transition 后调用 prepare/begin。
6. `prepareTabBarForTransition:`（IMP `0x1157db994`）在 targetHidden 为 NO 的分支，`0x1157dbb58–0x1157dbb68` 调用 `setTabBarHidden:NO animated:NO`，随后取得转场 copy，并将其加入原生导航的转场视图。**这是基线从隐藏的宿主 push 到默认 NO 子页时，原生 owner 主动准备显示底栏的具体位置。** 此过程同时改变 live bar 与 transition copy，不能仅靠录屏认定图像必定是 live MMTabBar。
7. `syncTabBarVisibilityForNavigationController:`（IMP `0x1157dbfec`）只处理 selected navigation controller；count≥2 时 `0x1157dc088` 读取 **topViewController** 的 `hidesBottomBarWhenPushed`，`0x1157dc0ac–0x1157dc0bc` 调用 `setTabBarHidden:animated:`（读值、NO）。didShow 在没有 active transition 时走这里。`finishTabBarTransition:cancelled:`（IMP `0x1157dc26c`）依据取消与否选择 sourceHidden/targetHidden，恢复 live bar，移除 copy。

据此，代码缺口是**插件 push 目的页没有声明应隐藏原生底栏的导航意图**；根列表能继承原生 YES，push 的 UIKit 子页却返回默认 NO，被原生 WCTabBarController 在转场准备和最终同步阶段采用。根页的设置没有“被样式 hook 改掉”；发生的是导航目的页改变后，原生 owner 读取了新的属性值。

## 为什么不在底栏样式层修

`Hooks/TabBarStyleHooks.xm:16–24` 与 `:108–112` 的 `setHidden:`、`setAlpha:` 都把原参数交给 `%orig`。`CSTabBarNativeAdapter.m` 装饰原生控件或原生转场 copy；对 bar.hidden/bar.alpha 只有读取，没有强制显示写入。它会隐藏自己识别的原生背景子视图（`:507–510`），并显示自有装饰 surface，不能把这些子视图操作误认为改变整个原生底栏可见性。`:554–567` 保留了原生 WCTabBarView 转场 copy 的装饰，所以泄露物具有已配置的圆角、绿色边框、缩放是可解释的；不构成它拥有导航显示决策的证据。

最小修复层是插件页面类型：共享表格基类 getter 返回 YES；四个不继承该基类的 AI/定时任务编辑器同样声明 YES。getter 在任何 init 路径及 view load 之前即可被读取，覆盖 push 准备阶段；不写全局 bar，不写永久导航状态，不在返回时“恢复”主界面，主界面自己的 NO 和原生控制器决策照常生效。

## 2.2-18 是否引入

2.2-18 的实际范围报告 `../release-2.2-18-settings-return-header-gap/final-scope.md` 列明五个文件，唯一布局业务变更是在根列表 `setupUI` 添加 `estimatedSectionHeaderHeight=0`。共享子页基类、AI/定时任务编辑器、原生宿主、入口 hook、样式 hook/adapter 与冻结的 2.2-17 逐字节相同。根列表的其余导航 dispatch 也相同。因此可确定：**这次已定位的“子页默认 NO”代码缺口在冻结 2.2-17 已存在，不是 2.2-18 新增的导航/可见性改动。** 不能据此声称已在 2.2-17 真机重现同一录屏现象；旧版真机行为未验证。

## 边界和未取得的证据

没有可用真机和 simulator runtime。无法取得 push 起始/中途/完成、pop 起始/完成、根列表、退出插件主界面的真实 `hidden/alpha/superview/frame/window`，以及真实 VC 的 modal/child 层级值；主机样本中同名字段全部是清楚标注的 policy model，不能填补这些运行时未知值。视频能测图像，不公开 UIKit 对象类型/指针/属性；绿色 ROI 消失也可能是 copy 移出 ROI，不能直接等同 setHidden。

本目录的原生证据证明静态决策链；实际新包在该设备上是否始终不出现 live bar 或 copy，以及退回主界面全部样式、未读角标和点击是否正常，仍需真机验证。
