# 8.0.78 的微信 tab root 与 index 建立顺序

只读分析同一份本地 arm64 微信镜像，SHA256 为 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。本轮未运行微信或连接设备，地址未加 ASLR slide。沿用上级审计已验证的 Objective-C metadata parser 和有界 LLVM 反汇编，在本目录复制脚本后仅修改选中方法，不改旧证据。`extract.py`、`disassemble.py`、`metadata.json`、`methods.json` 与 `extraction.log` 保留提取过程。

## 已确认的原生顺序

| 方法 / IMP | 关键指令与含义 |
| --- | --- |
| [MainTabBarViewController init](MainTabBarViewController--init.asm)，`0x104abe968` | `0x104abe9d4–9dc` 创建 tab items；`0x104abe9e4–9ec` 调 `p_createSlimViewControllers`；`0x104abe9f4–9fc` 创建主会话页；`0x104abea00–a18` 将 `m_arrViewController` 传给 `setViewControllers:`。这些调用在正常 init 返回前同步完成。 |
| [p_createSlimViewControllers](MainTabBarViewController--p_createSlimViewControllers.asm)，`0x104abf754` | 初始化 controller 数组，依次加入四个占位 UIViewController 并绑定对应 tab item。它证明存在初始化中的占位阶段，不证明 badge setter 一定在这一阶段运行。 |
| [p_createNewMainFrameViewController](MainTabBarViewController--p_createNewMainFrameViewController.asm)，`0x104abfa30` | `0x104abfacc–adc` 新建 `NewMainFrameViewController` 并保存；`0x104abfae8–afc` 用它作为 `StatusBarMonitorNavigationController` 的 root；`0x104abfb38–b4c` 对 `m_arrViewController` 发送 `safeReplaceObjectAtIndex:withObject:`，x2=0，以该导航替换第 0 项。 |
| [MMTabBarController setViewControllers:](MMTabBarController--setViewControllers_.asm)，`0x1047244d8` | `0x104724510–51c` 将同一个 array 交给 superclass 的 setter；随后记录 controller count。 |
| [p_tryToInitAllControllers](MainTabBarViewController--p_tryToInitAllControllers.asm)，`0x104abec50` | 再次确保四个真实 controller 存在，并调用 `setViewControllers:`；主会话项不是等其它 tab 全部懒加载后才创建。 |

metadata 中 `m_arrViewController`、`m_mainFrameViewController` 与相关 tab item 的 ivar 名称已核对；导航父类链见 [navigation-superclass-chain.json](navigation-superclass-chain.json)：`StatusBarMonitorNavigationController → MMUINavigationController → UINavigationController`。因此这层 wrapper 满足项目 `ChatTab` 中对 UINavigationController 的解包条件。

结合上级 [未读写入静态证据](../../native/README.md)，`NewMainFrameViewController.updateUnReadCount` 的普通写入也明确使用 index 0。结论是：**8.0.78 正常初始化及主未读更新路径的微信 tab 是第 0 项，正常 init 完成时实际 root 已建立。** 项目 `ChatTab` 自身仍按给定 index 的实际 root 类型判断，并不强制 index=0；其它插件、额外模式或重排不能靠这份静态路径一概保证。

## 对冷启动假设的约束

- 在 array 尚未设置、index 越界或仍是占位 UIViewController 时，`ChatTab` 可以返回 NO，项目三个内容 Hook 因而透传原生值。这个条件真实存在。
- 但上述原生顺序**不支持把“界面已经正常显示后还要运行一段时间才建立微信 root”作为默认解释**。正常 init 返回前已经创建并安装主会话导航。需要捕获实际初次 badge setter，才能证明它是否落在前面的占位/未安装阶段。
- 只读 `ChatTab` 是“当前 controller 对象在该次 setter 上是否匹配”的判断，不会永久缓存失败。每次 setter 都重新读取实际 `viewControllers`。
- 底栏样式 adapter/Hook 没有替换 `viewControllers` 或导航 root 的写入；它布局 item 与图标、文字、badge 和背景。其是否 applied 与 `ChatTab` 的类型判定没有直接条件依赖。
- “密友策略未加载所以 getter 返回 nil”不能从代码推出：`CSCloseFriendRuntime` 初始 `_blocked=YES`；账号/epoch 边界也发布 blocked snapshot；被 `ChatTab` 命中后 getter 对 blocked 返回 `@0`。nil 需要非 blocked 且无需过滤/名单为空等明确条件。

本目录没有记录实际冷启动的时间戳或调用次数。静态证据只能收窄可能窗口，不能补造“冷启动判定失败 → 后来成功”的设备日志。启动前后 Hook 安装、策略、快照可用性和首个 setter 所处阶段仍需现场观察。
