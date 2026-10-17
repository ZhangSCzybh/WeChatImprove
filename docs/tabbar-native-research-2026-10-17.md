# 悬浮底栏与微信原生底栏调查

日期：2026-10-17。阶段：源码与头文件调查，重构需求尚待明确，未修改运行代码。

## 项目基线与证据边界

- 当前 checkout：`/Users/zhangshichao/Documents/Workspace/WeChatImprove`。
- Theos / Objective-C / Logos 插件；当前工作区标记版本 1.6-35，HEAD 为 217f297b，存在已暂存的聊天分组相关改动及安装包变化，调查未改动这些内容。
- `Hooks/*.xm` 和 `Controllers/*.m` 通过 Makefile 通配符纳入编译。底栏入口位于 `Controllers/CSCustomViewController.m`。
- 本轮检查本地源码和 `HeadersFile` 的接口声明。没有连接手机，没有观察实际视图树，没有验证当前微信加载的二进制。
- README 标注近期适配微信 8.0.78；仓库既有证据记录另一个调查使用了 8.0.78.34 的本地第三方 IPA。本轮未分析该 IPA，不能把那些记录作为底栏实现已经验证的证据。
- 这是 iOS 注入插件，本轮没有启动服务、切换端口、修改微信配置、访问或迁移用户数据库。

## 当前实现

主要文件：

- `Hooks/TabBarStyleHooks.xm`：1379 行，包含偏好读取、原生 item 修改、显示状态判断、自建底栏、角标同步与动画。
- `Controllers/CSTabBarStyleSettingsViewController.m`：1314 行，包含设置、图标导入、配色和恢复默认。

现有能力：悬浮开关、隐藏标签、四个入口的普通/选中图标、自定义文本、0.6/0.7/0.8/0.9 大小档位、胶囊或圆角、位置偏移、背景、描边、触感和呼吸/心跳动画。

运行方式：

1. 修改 `MMTabbarItem` 的标题和图像；通过标题识别入口，并写入其 index。
2. 功能开启后，`MMTabBar.setHidden:` 一律传 YES 给原实现。
3. 在 `MMTabBarController.view` 上添加 `CSCustomTabBar`，使用自己的 UIButton 显示入口。
4. 点击自建按钮直接设置 controller.selectedIndex。
5. 轮询原生 `MMTabBarItemView` 的 unreadCount、badgeString、badgeView，并创建另一份 MMBadgeView。
6. `viewWillLayoutSubviews` 中按原生 tabBar.frame 计算悬浮尺寸，重建按钮并重启动画。

## 原生接口关系

以下为头文件可见职责；具体调用顺序、视图父子关系和坐标系仍需目标版本实现或运行证据。

| 类型 | 可见职责与接口 | 重构意义 |
| --- | --- | --- |
| MainTabBarViewController | 四个业务控制器和对应 item；p_createTabBarItems；懒初始化；选择代理；主列表单击/双击回调 | 业务入口身份、初始化和切换行为需要保留 |
| MMTabBarController | tabBarBtns；单击/双击手势；relayoutButtons:；tabBarBtnFrameAtIndex:；onTabBarItemViewsRelayout；show/hide 系列 | 点击热区和展示布局需要一起核对，不能只移动图标 |
| MMTabBar | backgroundView；tabBarItemViews；createTabBarItemViews；relayoutTabBarItems；calcHeight；键盘 frame 更新 | 原生背景、项目布局和底栏高度有独立处理 |
| MMTabbarItem | index、normalTitle、普通/选中文字色；普通/选中图片及深浅色 URL；customSize | 保留原生身份和资源状态，不能依赖显示文本判定入口 |
| MMTabBarItemView | MMWebImageView、UILabel、MMBadgeView；layoutIcon、layoutBadgeView、relayoutIconAndBadge、reloadIconImage | 优先复用原生显示组件和更新路径 |
| MMBadgeView | 数字、字符串、小红点、NEW、maxCount、shape、字体与颜色 | 原生角标语义多于一个未读数字 |
| MMTabBarBaseViewController | getMainTableBottomInset、getMainTableHeight、fixTabbarState、push/pop 与隐藏通知 | 页面内容占位和显示状态属于原生布局契约 |
| MMUINavigationController / MMUINavigationBar | 页面 push/pop、导航转场；顶部导航栏背景与内容布局 | 顶部导航栏与底部 TabBar 应分别分析 |

注意：dump 中 MainTabBarViewController / MMTabBarBaseViewController 声明为 NSObject；不能据名称擅自补充继承关系。

## 已确认的代码问题与影响

| 证据位置（Hooks/TabBarStyleHooks.xm） | 代码事实 | 影响 / 限定 |
| --- | --- | --- |
| 574–589、1176–1185 | 0.5 秒重复 NSTimer 强引用 target；只在 dealloc 中停止；移除底栏时未先 invalidate | run loop 持有 timer、timer 持有底栏，dealloc 清理不足；关闭后仍可能保留底栏并继续轮询 |
| 591–598、1302–1306 | 每轮 controller 布局删除全部按钮再创建，并 removeAllAnimations 后重启动画 | 产生不必要的对象创建，动画进度被反复重置 |
| 919–953 | 自建点击路径仅设置 selectedIndex 并更新显示 | 未显式保留 shouldSelect/didSelect 与主列表单击/双击语义；实际损失需实机验证 |
| 1213–1241 | 直接缩放 tabBar.frame 的宽高，隐藏标签再乘 0.88；没有明确拆分内容高度和底部安全区 | 不同安全区、键盘和系统布局下缺少可靠的几何约束 |
| 311–355、1121–1353 | 用四个类名的 containsString 判断显示；关闭功能时仍覆盖原生 hidden | 关闭功能并不等于完整退出接管；原生转场和搜索场景需核对 |
| 266–279、388–421、643–656、994–1006 | 多处依赖中英文标题识别入口，初始化还覆盖 item.index | 自定义文本和其他语言会使身份识别脆弱；显示文本不应承担稳定 ID 职责 |
| 495–506 | 隐藏文本时设置 hidden=YES 并移动图标；没有对称恢复分支 | 即时关闭隐藏文本时缺少明确恢复机制 |
| 821–858、894–914 | 已有角标内容相同即返回；仅新建角标时异步定位 | 图标布局变化时角标位置不一定更新 |
| 1359–1379 | 通知只重载全局设置，没有主动让当前底栏更新；Darwin 回调通过不匹配签名强转 | 刷新时机不完整，回调应使用正确签名和明确的主线程应用流程 |

设置页与 hook 各自定义偏好和默认值。设置页未配置描边时读取为红色，hook 未配置时读取为 nil；透明黑和未设置也存在混淆。设置层应以键是否存在区分显式值与默认值，并集中验证枚举和数值范围。

## 候选重构方向

1. **优先验证原生复用**：保留原生 controller、item view、角标和交互处理，在统一几何计算下调整背景和布局，同步原生点击热区。优点是减少状态复制；前提是确认目标版本坐标契约和布局回调顺序。
2. **独立容器承载原生元素**：外观自由度更高，但移动原生视图会改变父子关系，需额外处理坐标转换、命中测试与原生重布局。暂不作为首选。
3. **继续维护完全自绘底栏**：需要完整代理选择、重复点击、角标语义、资源变化和无障碍状态，维护面最大。只有需求无法由原生复用满足时再考虑。

建议职责拆分为：偏好与资源读取、原生接口适配、几何计算、外观渲染、生命周期接入。具体文件结构在需求明确后决定。

## 尚待明确与验证

- 用户最终要保留、移除或新增的功能；当前最不满意的可复现表现。
- 悬浮栏宽度、高度、底部距离是否独立配置；列表延伸到栏后还是留出底部占位。
- 当前真实设备的微信 / iOS / 注入环境，是否与 README 最近适配目标一致。
- 目标版本的实际 item 层级、点击热区坐标、原生显示/隐藏与转场时序。
- 原生单击/双击、未读数字/红点/NEW、浅深色资源、键盘、搜索、push/pop 取消转场、横竖屏、全局缩放和关闭功能后的恢复。

当前完成的是重构前调查；不据此宣称原生实现已完整还原或重构已完成。
