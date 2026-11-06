# 微信 8.0.80 底栏适配记录

用户 IPA 经根任务的 REA 会话解包，本记录针对提取出的 `Payload/WeChat.app/WeChat` 读取 Mach-O Objective-C 元数据、dyld chained fixups 和定点反汇编；没有运行该 iOS 可执行文件，也没有向设备安装插件。

- Bundle：`com.tencent.xin`
- 显示版本：`8.0.80`
- 构建版本：`8.0.80.34`
- WeChat 主可执行文件 SHA-256：`571c5b8cf8732eb5402ffddcbeb93830cb6695bad180be5613ad4167764524e9`

## 已确认的变化

8.0.80 同时保留旧底栏代码和新的底栏代码。新路径的真实继承链为：

```text
NewMainTabBarViewController → WCTabBarController → UIViewController
WCTabBarView → UIView
MMMainTabBarItemView → WCTabBarItemView → UIControl
MMMainTabBarItemView.itemView → MMTabBarItemView → UIView
```

`WCTabBarController` 与 `WCTabBarView` 覆盖 `isKindOfClass:`，向旧调用方提供 UIKit 类型兼容；`NewMainTabBarViewController` 还提供旧主容器 API 的消息转发。因此，依靠 `isKindOfClass:` 或 `respondsToSelector:` 并不能确定旧的存储结构或真实控件仍然存在。

旧适配只 hook `MMTabBar` / `MMTabBarController`，只通过 `customDelegate`、`tabBarItemViews`、`getTabBarBtnForIndex:` 取真实 UI。新路径改为 `WCTabBarController.tabBarView`、`WCTabBarView.visibilityDelegate`、`WCTabBarView.itemViews`，实际按钮是包裹旧渲染器的 `MMMainTabBarItemView`。这使旧适配无法进入有效的样式状态。

以下证据文件保留真实 selector、类型编码、IMP 地址和 ivar：

- `native-new-tabbar.json`：新根控制器及 WCTabBar 类的库存；外部 superclass 通过 chained-fixups imports 解出，确认是 UIViewController / UIView / UIControl。
- `native-tabbar-inventory.json`：旧 MMTabBar 系列及新 MMMainTabBarItemView 的库存。
- `native-tabbar-categories.json`：WCTabBar 兼容接口的补充库存。
- `native-tabbar-disassembly.txt`：MMTabBarController 的旧路径、`customTabBar` 的 iPad 18 分支，以及 MMMainTabBarItemView 创建并保留内部旧渲染器的代码。
- `native-modern-snapshot.txt`：`WCTabBarView snapshotViewAfterScreenUpdates:` 创建独立的新 bar、保留 item provider、复制各项的 transition visual state 并 layout 的代码。

这些属于静态包证据，不表示已经观察到用户手机实际选中的类路径；原生旧、新两条分支均得到适配。

## 实现

生产改动仅位于：

- `Controllers/CSTabBarNativeAdapter.h`
- `Controllers/CSTabBarNativeAdapter.m`
- `Hooks/TabBarStyleHooks.xm`

适配器按实际 Objective-C class chain 区分旧、新容器，避免兼容层的 UIKit 类型伪装。新路径读取原生 wrapper / 内部 MMTabBarItemView；索引根据真实 wrapper 顺序确定，不把兼容模型与 legacy 模型当作同一对象。

布局先移动原生 UIControl，再让其内部渲染器填满按钮，避免嵌套层级重复偏移。自定义图标、文字、隐藏文字、背景、边框、点击反馈复用已有实现；角标仍由同一原生对象持有，只调整视觉锚点。选中与导航仍由原生 control target 完成。

新增 WCTabBarView / WCTabBarController 的布局、重建、可见性、命中与快照 hook。新的转场快照是独立的 WCTabBarView，通过相同适配器维持后续布局；它不会读取或修改真实页面的滚动 inset，也不会触发点击反馈。关闭功能或遇到不支持的 wrapper 结构时恢复原背景、分隔线、clip 状态、控件与子元素 frame、文字和图标，并移除插件添加的 target。

## 验证与边界

运行 `python3 docs/audits/wechat-8.0.80-2026-11-05/tabbar-validation/run-validation.py` 可复验。结果记录在 `validation-result.json` 及各 `.log`。

已通过：

- 真实 iPhoneOS SDK 的 arm64 / arm64e 编译检查，开启 `-Wall -Wextra -Werror`。
- 原底栏几何检查。
- 原宿主底栏生命周期、样式、角标、快照、关闭恢复检查，以及 39 项点击特效检查。
- 新 8.0.80 层级 fixture：独立的兼容模型与 legacy 模型、UIKit 类型兼容伪装、嵌套原生 UIControl、反复布局不漂移、图标/文字样式、保留角标对象、浮动区域命中、原生 target 选中、点击反馈、同窗口转场副本不读取页面树、不支持的 wrapper 安全恢复、关闭后完整恢复。

宿主测试调用的是生产适配器和偏好代码，Foundation / CoreGraphics / QuartzCore 为真实系统框架，UIKit 为行为替身。它能验证选择分支、frame 计算、对象关系、target 与状态恢复，不能证明 iPhone 上的像素渲染、触摸投递、微信实际导航动画和其他注入插件的交互。真机验收应在用户原来的 IPA 重签环境中进行；本任务没有安装、重启或更换用户的账号、数据库、偏好及 IPA。

根 `Tests` 目录和其他预先删除文件均未恢复；审计目录内的原测试材料从 Git HEAD 独立读取，用于本次验证。
