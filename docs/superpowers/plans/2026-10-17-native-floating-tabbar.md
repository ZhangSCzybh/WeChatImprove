# Native Floating Tab Bar Implementation Plan

> **For agentic workers:** Execute the approved tasks inline in this checkout; user authorization to begin persists. Preserve unrelated changes.

**Goal:** 用原生底栏组件实现可恢复的悬浮外观，清理重复导航和角标系统。

**Architecture:** Hooks 只转发原生生命周期；CSTabBarNativeAdapter 处理原生状态与恢复；CSTabBarPreferences 读取配置和图片；CSTabBarGeometry 计算统一矩形。所有目标限定到 MainTabBarViewController 所属底栏。

**Tech Stack:** Objective-C, Logos, UIKit, QuartzCore, Theos.

**Spec:** docs/superpowers/specs/2026-10-17-native-floating-tabbar.md

## Global Constraints

- 最低编译目标 iOS 15.0；arm64 / arm64e；无新增依赖。
- 保留当前 checkout、全部旧偏好键和无关改动。
- 保留原生按钮 target/action、手势和角标对象；不改 item.index。
- 不连接或修改用户数据库，不自动部署和重启微信。

## Task 1: Preferences and geometry

- [x] 新建 Controllers/CSTabBarPreferences.h/.m，统一配置键、默认值、有限数值验证、图片缓存；声明 +current、+reload、-iconAtIndex:selected:。
- [x] 新建 Headers/CSTabBarGeometry.h，纯 C 函数 CSTabBarFloatingRect、CSTabBarItemRect、CSTabBarRequiredBottomInset；按安全区和内容高度计算，不依赖 UIKit 私有状态。
- [x] Tests/TabBarGeometryTests.c 验证 83 高底栏+34 安全区、49 高底栏、窄屏、RTL、NaN 输入和滚动余量。运行 bash Tests/verify-tabbar.sh。

## Task 2: Native lifecycle adapter

- [x] 新建 Controllers/CSTabBarNativeAdapter.h/.m；按底栏实例保存原生背景、隐藏值、item 外观与主表底部余量。
- [x] 原生布局后统一应用项目和按钮矩形，保留父子层级；命中测试将实际原生按钮返回给 UIKit。
- [x] 用 layoutIcon / layoutBadgeView / reloadIconImage 事件更新外观；角标只定位，不写内容或可见性。
- [x] 关闭、宿主隐藏、离窗和不支持的布局及时恢复；偏好通知切到主线程且合并刷新。
- [x] 替换 Hooks/TabBarStyleHooks.xm 为小型生命周期 hooks；移除 CSCustomTabBar、NSTimer、标题匹配和显示白名单。

## Task 3: Settings and verification

- [x] 设置页复用统一偏好；保留既有选项，增加内容高度和描边宽度，支持跟随原生背景，修复恢复默认遗漏。
- [x] 设置更改通知即时刷新，取消重启提示；校验枚举和负数输入。
- [x] 运行 bash Tests/verify-tabbar.sh、现有分组验证脚本，检查 git diff --check。
- [x] 执行 make package -j4 SCHEME=rootless PACKAGE_VERSION=1.6-36；同步源码版本、README 和验证说明，不运行 make clean。
- [x] 检查包版本与双架构；记录实机未验证项及原生二进制证据限制。
