独立复审结论：已完成对本轮最终冻结的 `CSGroupListAdapter.h/.m`、`SessionGroupHooks.xm` 及清理后的 Makefile 的源码复核，在已约定范围内没有尚未关闭的阻断发现。最终 Adapter.m SHA-256 为 `ecc54b7c105e9700b26468ab88e5119bf8e2d75d96f54c5c7b2011a50bb8451c`。本复审只在本次 audit 的 `review/` 中写入证据；没有修改生产、验证代理的 fixture、旧 audit、安装包、真机或用户配置。

用户确认的行为是**跨组沿用当时的滚动高度，从聊天返回时恢复离开前的高度**。短组只能夹到当前有效范围；离开这个短组再切组时，沿用短组当前实际高度。同组内部收消息或重排仍保留可见会话的行锚点。这里没有引入每个分组分别记忆历史位置的行为。

| 审阅项 | 最终行为与依据 |
| --- | --- |
| 离开列表 | `setPresentationSuspended:forController:` 第一次转为 suspended 时，在宿主离页方法执行前捕获有效高度、账号与 epoch；重复 didDisappear 不覆盖第一次离开位置。 |
| 聊天返回 | Hook 先运行宿主 `viewDidAppear:`，再 attach，最后调用 `finishPresentationReturnForController:`。此前 willAppear 的恢复不消费离开位置；didAppear 完成后才能消费。 |
| 切组捕获 | `selectIndex:` 在修改持久选择与发布新列表前捕获高度。连续待发布的 A→B→C 沿用同一个待恢复高度并更新最终目标；普通同组点击直接返回。 |
| 发布与延迟布局 | 原生与兼容刷新均在目标投影发布后尝试恢复；dirty、隐私边界、未完成批次、无效/零几何、交互期间保留请求，由已有发布、布局或交互结束事件重试。没有位置恢复轮询或自重排的定时器。 |
| 高度与夹边 | 使用 `contentOffset.y + adjustedContentInset.top` 表示有效高度，以目标表格当前 adjusted inset、bounds 与 contentSize 夹边。宿主切换 inset 后暂留旧 offset，不被当作真实用户回弹而永久拒绝。真正空组可以落到顶部；有行但 contentSize 尚为零时继续等待。 |
| 写后确认 | `restoreScrollHeight:` 调用 setContentOffset 后，重新校验账号、epoch、模型版本、隐私 revision、表格/投影/分组身份及交互状态，再重读最终几何与实际 offset。只有实际落点距离新目标不超过 0.5 才视为恢复成功；宿主覆盖 offset、改变 inset 或替换表格时保留请求。 |
| 重入与请求消费 | `restoringViewport` 阻止 setContentOffset 同步回调递归。消费时比较当前属性对象身份，避免误消费后来的请求。删除待选组时，retarget 后使用 `viewport=self.switchViewport`，与 copy 属性实际保存的对象一致。 |
| 横滑收尾 | groupPan Ended/Cancelled/Failed 只排入一次弱引用主队列任务。它在 UIKit 的 tracking 状态有机会清理后恢复，解决水平手势可能没有竖向 scroll-end 回调的情况；没有自重排任务链。 |
| 新的用户定位命令 | 真实竖向 willBeginDragging 在宿主处理前清理旧请求。原生搜索、明确的原生导航，以及被宿主接受的状态栏回顶，也取消旧位置；宿主拒绝回顶时保留待恢复位置。 |
| 删除或隐藏待选组 | 仅在发布、dirty、隐私和布局边界已通过、当前已发布组等于实际选择且仍存在，而原 target 已从 preferences.tabs 消失时，把同一高度转到有效 fallback；成功消费后恢复同组 anchor。 |
| 选择被拒绝 | 真实 preferences setter 可能因保护 schema 或 defaults 写入失败拒绝选择。Adapter 回读选择，不留下从未被接受的 target，并把 chrome 选择还原为实际选择。 |
| 性能与隐私边界 | 新位置逻辑只在有请求时进入实际恢复；静置无新增定时任务。保留当前原生模型增量、局部刷新、账号/epoch 与隐私发布边界。这里没有测量或推算真机 CPU 降幅。 |

独立运行时检查直接提取最终 Hook 中的 `MainScrollToTop` / `InstallMainScrollToTopHook`、真实 `CSCloseFriendInstallHook` 及 ABI 检查函数，在 macOS Foundation 下动态建立类并调用，共 **7 种情况、69 项断言全部通过**：optional 方法缺失、直接实现返回 YES/NO、继承实现返回 YES/NO、错误 ABI、目标类缺失。检查确认缺失方法通过 class_addMethod 安装、没有 original 时不调用空指针；已有实现的返回值与父类实现保持；错误 ABI 不安装替换。兼容 `forwardInvocation:` 另经源码复核，读取宿主 BOOL 返回值后没有改写返回槽，且所需 scroll selectors 已由真实 InvocationMapper 支持。

这项运行时证据使用本机 `class_replaceMethod` 代替不可用的 Substrate `MSHookMessageEx`，使用受控接收器记录 Adapter 的通知次数。它验证可选方法安装与返回值语义，**不能当作 iPhone UIKit、WeChat 8.0.78 的交互验证或 Instruments 采样**。可复跑脚本和原始结果是 [runtime-install-check.py](runtime-install-check.py) 与 [runtime-install-result.json](runtime-install-result.json)。完整列表/生命周期回归、SDK 编译和正式打包由主任务及验证代理另行记录。

清理范围已独立确认：原 `CSGroupPerformanceObservation.h/.m` 和 `SessionGroupPerformanceObservation.xm` 没有其他生产 caller；现三文件及 Makefile 的 observation 开关、filter 和宏均已移除。`returnToGroupTop`、`pendingScrollToTop`、`applyPendingScrollToTop` 的无调用死链一并删除。分组相关 Controllers / Hooks 与 Makefile 扫描未发现残留 observation/signpost、NSLog、printf/fprintf 或调试断言；`export DEBUG=0` 属于正式构建设置并保留。历史 audit、trace 与旧包没有参与清理。

复审期间提出的 inset 切换拒绝、写后未确认、横滑缺少收尾、删除待选组悬空请求与持久化选择被拒绝等发现，均已在上述最终冻结中关闭。删除目标组的 copy 身份问题由验证代理的新回归捕获并修复，本复审已重新读取最终赋值与消费逻辑。历史源码谱系的独立证据见 [history.md](history.md) 与 [history-evidence.json](history-evidence.json)：它们只能定位源码回退边界，不推断用户设备每次实际加载的候选包。

最终 source、清理状态、运行时证据及本复审文件的 SHA-256 绑定记录为 [independent-review-result.json](independent-review-result.json)。此结论以记录中的生产输入为准；输入变化后需针对变化重新审阅。
