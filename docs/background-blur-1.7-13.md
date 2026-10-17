# 后台模糊 · 1.7-13

后续实机反馈：用户确认基础功能正常，但变化过程过于生硬。渐入／渐退优化见 [1.7-14](background-blur-transition-1.7-14.md)。下文保留 1.7-13 的实现与当时验证记录。

## 功能和入口

插件设置 → 功能增强 → 后台模糊 → 启用后台模糊。默认关闭，开关立即生效。

应用或场景即将失去活跃状态时，为可见内容窗口添加系统 `UIVisualEffectView`（`UIBlurEffectStyleRegular`），在 App 切换器中模糊页面。恢复活跃后立即移除，无渐变延迟。控制中心、通知中心和系统认证也可能触发同样的失活保护。材质适应浅色、深色及系统辅助功能设置；降低透明度时外观可能更不透明。

## 与现有框架的连接

- `Controllers/CSCustomViewController.m`：沿用功能增强分组，新增入口和路由。
- `Controllers/CSBackgroundBlurSettingsViewController.h/.m`：复用 `CSSettingItem`、`CSSettingTableViewCell`，返回设置页时重新读取配置。
- `Controllers/CSBackgroundBlurManager.h/.m`：管理生命周期、窗口与遮罩。头文件集中声明配置键和通知。
- `Hooks/BackgroundBlurHooks.xm`：构造器注册单例管理器，不修改微信代理实现。
- `control`、`Headers/CSUserInfoHelper.h`、`Controllers/CSReleaseNotesViewController.m`：统一版本为 `1.7-13`，提供对应更新说明。

检查的宿主头文件包括 `MicroMessengerAppDelegate.h`、`MMMainSceneDelegate.h`、`MMSceneDelegate.h` 和 `MMUIWindow.h`。宿主确有应用／场景切换接口，但本功能使用 UIKit 通知，避免依赖私有类名及导出头文件中不完整的继承关系。项目原有 `BackgroundRun.xm` 使用的 `AppDelegate` 与导出类名不同，新功能没有复用该路径。

## 时序与边界

1. `UIApplicationWillResignActiveNotification` 或 `UISceneWillDeactivateNotification` 中同步显示，后台通知再次检查层级；不延迟到异步队列等待首次显示。UIKit 事件在主线程执行，其他线程的配置通知转交主线程。
2. 场景一旦收到显式生命周期事件，以该场景为准，避免一个场景激活时清除另一个后台场景的遮罩。没有场景事件的窗口使用实际场景状态和应用状态；无场景窗口兼容旧应用代理路径。
3. 只在已有、可见、有根控制器且尺寸非零的窗口中添加遮罩，不创建新窗口、不抢 key window、不修改导航或聊天内容。遮罩不接收触摸、不提供辅助功能元素，覆盖窗口完整 bounds。
4. 复用每个窗口的遮罩，柔性宽高适配尺寸变化。窗口显隐通知触发检查；重复失活与后台通知会重新将遮罩置顶。
5. 只有恢复活跃才移除，不在 `willEnterForeground` 过早清除。取消切换手势也走恢复活跃路径。断开场景立即清理，且防止 `connectedScenes` 尚未更新时重新添加。
6. 偏好域沿用 `com.cyansmoke.wechattweak`，键为 `com.wechat.tweak.background.blur.enabled`；监听开关专用通知和已有 settings/local_settings_changed 通知，兼容配置恢复与重置。

无截图文件、无后台保活、无定时轮询。正常前台不保留模糊视图，关闭功能立即清理。

## 验证

在原项目目录 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 构建，沿用 `/Users/zhangshichao/theos`，iPhoneOS 27.1 SDK，最低编译目标 iOS 15，Rootless 方案。

```sh
bash Tests/verify-background-blur.sh
bash Tests/verify-tabbar.sh
make package -j4 SCHEME=rootless
```

主机测试直接编译生产 `CSBackgroundBlurManager.m`，使用 UIKit 行为替身和随机测试偏好域；测试结束清除测试域。146 项行为检查通过，覆盖默认关闭、失活同步显示、重复事件、30 次快速切换、取消手势、多场景独立恢复、窗口新增／显隐／尺寸变化、配置恢复和重置、场景断开、无场景应用生命周期以及清理。

现有底栏几何、偏好及原生生命周期回归也通过，检查同一应用／场景激活通知下原有底栏恢复路径。

Rootless 构建成功，安装包 `packages/com.wechat.improve_1.7-13_iphoneos-arm64.deb` 包含 arm64 / arm64e。已解包检查版本、Rootless 安装路径及两种架构内的模糊管理器／设置控制器类符号。旧版安装包保留，未运行会删除 packages 的 `make clean`。

主机测试不模拟 UIKit 像素、系统截图或微信转场。开发工具可列出一台已配对 iPhone，但本次未向手机安装或启动插件，不能据此认定实机通过。录屏中的白色遮挡来源尚未确认；如果是另一个插件或微信自带遮挡，它可能影响底层画面及模糊观感。

## 手机验收

1. 安装匹配环境的 Rootless 包，完全退出并重新打开微信，进入上述入口开启功能。
2. 分别从聊天列表、聊天内容、我、设置和网页页面拉起 App 切换器，检查页面内容和顶／底栏模糊效果。
3. 返回微信、上划后取消、连续快速切换，确认恢复清晰且操作正常；切至其他应用后再查看微信卡片。
4. 在键盘展开、系统弹窗、Face ID 验证及控制中心／通知中心场景中检查显示与恢复；键盘和系统自有界面由系统管理，需实机核实截图覆盖范围。
5. 检查浅色、深色、横竖屏；若设备支持多窗口，检查各场景独立切换。分别检查系统降低透明度开启／关闭时的外观。
6. 关闭开关后重复操作，确认不再添加模糊；导入配置、重置设置后检查开关状态与行为一致。

本次交付的是安装包和源码，不涉及网页 URL、前后端端口或数据库迁移，未修改手机账号、聊天数据或设备端配置。
