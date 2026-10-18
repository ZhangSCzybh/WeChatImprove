# 1.8-9 代码清理与剩余性能风险

2026-10-18，基于本次会话已交付的 1.8-8 性能优化版本继续清理。用户确认手机已安装 1.8-8，且语音转发正常；此前“转发失效”的反馈已撤回。本版不包含针对该误报的发送流程改造。

**状态：清理完成，10 组相关主机回归全部通过，Rootless arm64 / arm64e 构建及包内容核对通过。1.8-9 未由本任务安装到设备，尚无真机 CPU、GPU、温度和后台数小时恢复的测量结果。**

## 本版清理

清理前在本机临时目录保存了源码基线。与这份基线的差异见 [cleanup-only.diff](cleanup-only.diff)，文件哈希和数量见 [cleanup-scope.json](cleanup-scope.json)。该差异只包含本次清理与版本说明，不混入此前未提交的性能修改。

| 清理项 | 具体内容 | 功能边界 |
|---|---|---|
| 64 处正常流程日志 | 发现页入口判断、设置页逐项遍历、自定义入口加载、头像设置加载、红包任务正常执行、统计和群列表计数 | 保留异常、失败、超时和重试诊断；保留原有判断、早退和调用 |
| 7 个透传 Hook | 用户名查询 1 个、语音确认相关 2 个、前后台状态 3 个、收款逻辑初始化 1 个 | 删除只调用 `%orig` 的包装层；微信原方法继续自然执行 |
| 1 个空通知监听 | 后台运行模块注册后不执行任何工作的后台通知 block | 真正的前后台处理入口、保活定时器与停止逻辑保留 |
| 无用状态与代码 | 只写不读的 `appReady`、只累加不读取的 `timerFireCount`、无调用的静态 URL 解析函数、空 `else` 分支、未使用的 `weakSelf` | 保留消息数据准备、任务取消、异常保护与原有 URL 参数提取函数 |
| 无用查询及局部变量 | 转账处理中未使用的当前账号查询；设置页移除项只为日志保留的标题和 KVC 读取；未使用的调用返回值变量 | 收款接口、红包自动回复、转账自动回复调用本身仍执行，不改变参数、顺序或时机 |

测试、审计工具和 dSYM 是开发验证材料，未被当成运行时代码删除。Makefile 仍仅收集 `Hooks/*.xm` 和 `Controllers/*.m`；本轮未新增运行时调试开关、日志写文件任务或性能采样定时器。清理日志的收益是减少格式化、取值和系统日志处理，不能据此声称温度降低了多少。

## 本轮整体优化带来的改变

以下包括 1.8-8 已交付的改进；详细实现和此前 17 组回归见 [1.8-8 记录](../performance-resume-2026-10-18/implementation.md)。

| 场景 | 改变及作用 | 可量化的代码／主机测试证据 |
|---|---|---|
| 冷启动、长时间后台返回 | 联系人服务调用栈不再读写 Defaults 或等待主队列；头像缓存合并异步写入，通知刷新异步合并；去除配置锁内的 Defaults 读取 | 主线程被占用时 1,000 次头像采集仍返回；旧账号代次结果被丢弃；针对原日志中的服务锁／通知等待链 |
| 设置通知、消息时间 | 去除布局同名通知回发循环；消息时间只读取相关设置，相同快照不刷新 | 只读 8 个相关键；1,000 次配置通知合成一次刷新 |
| 触摸轨迹 | 配置与图片缓存；限制采样、拖尾生成和可见对象数量；后台／关闭清理 | 10,000 次移动不新增配置和图片读取；移动上限 60 次/秒，拖尾上限 30 次/秒，每触点最多 48 个可见拖尾，运行时淡出不超过 2 秒 |
| 底栏持续动画 | 失活、离窗、隐藏、减弱动态效果、严重／危急热状态时暂停，条件允许时恢复 | 四类动画的生命周期回归通过，已有动画不重复创建 |
| 聊天分组 | 合并被动消息事件，后台投递先去重，每批只保存一次视口锚点 | 80ms 合并窗口；200 个通知一批只获取一次锚点、发布一次结果；原生模型变化仍及时失效缓存 |
| 消息旁路 | 无待处理下载或非最终语音分块快速返回；转账关闭／无关消息不排队到主线程 | 保留微信原处理、有效语音完成和有效转账候选处理；主机测试未调用真实发送或支付服务 |
| 本次清理 | 去掉正常流程记录、空 Hook、空监听和无用查询 | 64 处日志、7 个透传 Hook、1 个空监听移除；10 组回归通过 |

这轮优先解决确定的相互等待和重复工作。功能启用时合理的渲染、网络与会话计算仍存在；“卡首屏已修复”特指已发现的插件等待链已在代码中处理，最终恢复表现还需要原设备验证。

## 仍可能影响发热或性能的地方

下面是源码确认的触发路径与进一步优化方向，不是已经测得的耗电排名。用户已确认开启聊天分组、触摸轨迹、底栏持续动画，其他开关状态未知。

| 优先级／触发条件 | 剩余工作 | 建议及定位 |
|---|---|---|
| 优先核对：后台保活开启且微信进入后台 | 无限循环无声音频，并按设置间隔进行后台时间检查，正常读取范围为 10～60 秒。这会妨碍系统按普通应用方式休眠；回前台已有停止处理 | 如无保持后台执行的需要，关闭保活最直接；本版没有替用户更改开关。代码：[BackgroundRun.xm](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/BackgroundRun.xm:39) |
| 优先测量：底栏可见、前台活跃且启用持续动画 | 阴影、透明度、路径等动画仍持续渲染；热保护不会使正常前台动画变成零成本 | 在同一静止首屏对比动画开／关的能耗；保留动画时再评估阴影范围、模糊和动画频率。代码：[CSTabBarNativeAdapter.m](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTabBarNativeAdapter.m:231) |
| 中：开启头像旋转，且视图是 tag=101 的个人头像 | 两类头像视图注册无限旋转；尚未像底栏一样显式依据可见性、应用状态、Reduce Motion 和温度移除／恢复。系统仍可能暂停不可见或后台绘制，不能直接认定后台一直满速 | 下一步可复用相同生命周期策略；本次只删该文件的加载日志。代码：[CSAvatarShape.xm](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/CSAvatarShape.xm:138) |
| 中：开启输入框自定义样式并频繁输入／改变布局 | 布局回调读取多个 Defaults、反归档颜色、创建富文本并重复设置占位文字；颜色数据异常时还可能重复打印错误 | 适合做配置快照与颜色缓存，相同样式跳过应用；需要另做输入法、占位内容和开关恢复回归。代码：[InputTextHooks.xm](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/InputTextHooks.xm:184) |
| 中：分组开启、会话数多或后台补消息量大 | 合并降低重复次数，但会话快照重建、筛选、投影和部分列表刷新仍在主线程。安全访问微信私有对象的成本没有消失 | 根据真实会话数和批量消息录制耗时，决定是否进一步增量化；不把私有可变对象直接移到任意后台线程。代码：[CSGroupListAdapter.m](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSGroupListAdapter.m:384) |
| 中低：持续滑动并展示触摸轨迹 | 有限数量的图片、透明度和淡出效果仍有合成成本；上限避免增长失控，不代表触摸时不耗电 | 用相同滚动场景比较开／关及不同密度，空闲后应回落。代码：[TouchTrailHooks.xm](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/TouchTrailHooks.xm) |
| 次要：开启导航头像，反复进入不同聊天或头像 URL 改变 | 同一视图内有 URL 去重，但不同视图／URL 更新创建新 NSURLSession，图片在主队列构建；该路径未见 session 的显式 invalidate | 可评估共享 session、跨视图缓存和适当缩图；这是页面进入／变化时的成本，不是静止首屏每帧执行。代码：[NavigationTitleHooks.xm](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/NavigationTitleHooks.xm:273) |

红包开启且同时收到多个任务时仍有服务查询和同步主队列提交（`CSReceiveRedEnvelopOperation`）；本轮没有发现可据此确认的双向等待链，不把一个 `dispatch_sync` 单独当成新死锁证据。只在该场景卡顿时进一步采样，避免为了删除代码改变资金相关行为。

分组设置页的 1 秒账号检查离页会停止；消息导航的 display link 属于有 8 秒截止的单次请求；赞赏观察属于打开赞赏后的会话并在结束时释放。这些不是微信首屏常驻运行的轮询。设置页用户操作时的 `synchronize` 也不能仅凭出现次数解释静止发热。微信自身冷启动补消息、网络、媒体加载以及其他插件的开销需要用真机采样区分。

## 验证与交付

10 组相关脚本全部退出 0，详细结果见 [test-results.json](test-results.json)，每组完整输出单独保留。此次没有修改现有测试以适配清理结果。

| 回归 | 结果 |
|---|---|
| preference-concurrency | 12 项通过 |
| message-actions-core / execution / gesture | 1,362 / 1,013 / 272 项通过 |
| transfer-admission | 7 项通过；未调用真实支付 |
| touch-trail | 10,015 项通过 |
| tabbar | 几何、设置和原生适配器生命周期通过 |
| message-time | 142 项通过 |
| group-lifecycle | 67 项通过 |
| list-corners | 869 项通过 |

另逐项复核了删除差异：设置页过滤所需标题仍读取，索引保护仍在，正常日志中的实质操作未随日志删除；转账收款、红包及转账回复的调用均保留。`git diff --check` 通过。完整双架构构建找到了另一个未使用的 `weakSelf`，删除后再次构建通过；剩余为既有 API 弃用和链接器过时参数警告。

采用原 checkout 和独立 Theos 构建目录，未执行会删除旧产物的 `make clean`。具体命令与目录见 [build-paths.json](build-paths.json)，编译输出见 [build-1.8-9.log](build-1.8-9.log)。测试在主机替身／隔离设置域中运行；没有安装或启动手机微信、发送真实消息、调用支付服务、重置设置或修改聊天数据。

- 安装包：[com.wechat.improve_1.8-9_iphoneos-arm64.deb](/Users/zhangshichao/Documents/Workspace/WeChatImprove/packages/com.wechat.improve_1.8-9_iphoneos-arm64.deb)
- 调试符号：[WeChatImprove-1.8-9-dSYMs.zip](/Users/zhangshichao/Documents/Workspace/WeChatImprove/packages/WeChatImprove-1.8-9-dSYMs.zip)
- Rootless，包内动态库含 arm64 和 arm64e，安装位置 `/var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib`。
- 包 SHA-256：`61a3a4becaf32cb2d469ed7a91ced241d7fc14dbc53070faa014c7b2b50528fc`。
- arm64 UUID：`134516ED-DE03-3E25-9F99-560715AB688F`。
- arm64e UUID：`E70EFC0D-25A2-35A0-A9B0-F7E3B9ADDC3B`。
- 包内动态库与构建输出哈希一致，dSYM UUID 分别匹配；旧 1.8-8 安装包和符号文件哈希保持一致。
- [包核对结果](package-verification.json) · [最终源码与产物清单](delivery-manifest.json)

建议真机先沿用原账号、原数据及现有三项开关验证：完全结束微信后冷启动、静止首屏、持续滚动后静止，以及后台 30 分钟和 2～4 小时后返回。保持亮度、充电和网络条件一致，再单独对比底栏动画、触摸轨迹以及保活（若已开启）。观察能否交互、负载能否回落；若仍卡首屏，使用本版 UUID 与对应 dSYM 分析新日志。具体验收表沿用 1.8-8 记录，安装后的版本核对改为 1.8-9。
