# 1.8-59：朋友圈缓存递归加锁闪退与额外持有修复

2026-10-21，基线 `d35c3e00`（1.8-58），开发目录继续使用 `/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove`，分支 `codex/close-friends-148`。

## 定位

用户提供两份微信 8.0.78 的真机日志，分别描述朋友圈滚动和点击进入时闪退：`WeChat-2026-10-21-152116.ips`、`WeChat-2026-10-21-152259.ips`。

两次都为主线程 `EXC_BREAKPOINT`，终止信息为 `Trying to recursively lock an os_unfair_lock`。日志中插件 arm64e UUID 均为 `2CC016D7-4A75-36F2-B1A9-B9EA042EEBD7`，与本机 1.8-58 dSYM 完全匹配。

共同栈为 `NSCache objectForKey:` → 插件 `ProjectedUsers` → 互动 getter → 微信原生对象归档 → 同一个 `NSCache objectForKey:`。插件偏移 `0xc00d4` 精确符号化到 `CSCloseFriendTimelineAdapter.m:143`，即 `[cache objectForKey:item]`；`0xc0314` 落在互动计数钩子。第一份的下层调用来自策略变化后的朋友圈刷新，第二份来自原生页面加载时的行数计算；二者根因相同。完整摘要、原日志 SHA-256、UUID 和插件栈符号见 `crash-analysis.json`。

1.8-58 将微信动态模型直接用作 `NSCache` 的键，触发原生模型的哈希／归档，再次读取已经被 Hook 的互动 getter。NSCache 的内部锁不能递归获取，因此系统立即终止进程。这是 1.8-58 缓存优化引入的回归；之前测试使用普通 NSObject 模型，未模拟微信模型的归档式哈希行为。

用户补充指出缓存对动态模型的强引用。核查确认，旧版两个全局 `NSCache` 分别设置 128 条的数量限制，但键直接强持有 `WCDataItem`，其存活期可能超过页面；账号缓存清理也依赖后续读取时检测 epoch。此处确有额外持有问题，现有证据不等于无限增长的内存泄漏。

## 修复

业务代码仅修改 `CSCloseFriendTimelineAdapter.m`：

- 使用 `NSValue` 包装对象指针作为缓存键，NSCache 不再调用微信模型的 `hash`／`isEqual:`。
- 缓存条目弱引用其原始 owner；对象释放或地址被复用后，owner 不匹配则重新计算，缓存也不额外保留整个动态对象。
- 动态／互动数组按对象身份和顺序比较，避免原生模型内容比较再次进入 getter，并保证同一 itemID 的新模型会更新投影。
- 原生 `viewDidDisappear:` 执行后清理互动缓存和当前页面投影；新增逻辑只释放缓存，不调用刷新或布局。
- 密友策略变化和 `CSBackupAccountChanged` 通知到达主线程时主动释放互动缓存及所有已跟踪页面的投影，包括离屏页面；页面状态登记使用弱引用。
- 保留原有账号边界、缓存上限、点赞评论隐藏、原始源数据及解锁快速路径，导航和原生布局刷新逻辑不变。

## 核心验证与交付

新增 `Tests/CloseFriendTimelineCacheTests.h`，模拟会在哈希时归档互动 getter 的原生模型。先在未修复的 1.8-58 生产方法上运行，确认调用模型哈希而失败；测试在危险调用入口受控抛出异常，避免故意触发系统死锁。修复后相同用例通过，并实际完成一次归档读取，确认不会再递归进入模型哈希。还覆盖 50 次缓存读取、同一 itemID 的对象替换及缓存不额外保留动态对象。

使用弱引用探针确认动态 owner 可释放，且离开页面、策略变化、账号切换时缓存持有的互动数据和页面投影可释放，无需等待下一次缓存读取。页面离开时原生生命周期仍执行一次，未增加 reload，重新进入后过滤正常。这是主机对象生命周期验证，未进行真机堆快照或内存峰值测量。

- 旧代码验证：`regression-before.json`／`.log`，预期失败。
- `bash Tests/verify-close-friend-social.sh`：通过；包含进入／刷新、展示索引、解锁／重新锁定、离屏恢复、原始数据及互动过滤、数据增删、账号边界等现有核心用例。
- `bash Tests/verify-close-friend-ios.sh --social`：arm64、arm64e 严格编译通过。
- `make package -j4 SCHEME=rootless PACKAGE_VERSION=1.8-59`：构建结果见 `build-result.json`。交付校验涵盖版本、双架构、最低 iOS 15.0、dylib／暂存／deb 一致性、dSYM UUID、注入过滤及历史包完整性。

安装包交付至 `/Users/zhangshichao/Documents/Workspace/WeChatImprove/packages/com.wechat.improve_1.8-59_iphoneos-arm64.deb`。SHA-256 及校验详情见 `validation.json`；可运行本目录 `verify-delivery.py` 复核。

本轮只跑朋友圈相关回归和包校验，未扩展到搜索、红包等未修改功能。原项目源码、真实微信数据和历史安装包保留。未安装到用户设备，实际进入和连续滚动仍需安装新包后复验。
