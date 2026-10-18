# 1.8-8 首屏恢复与性能优化交付记录

2026-10-18。按用户确认的顺序，先处理后台返回首屏卡住的等待链，再处理上一轮答复的第 1～4 项优化，并完成第 5 项中的本机回归、构建和真机验收准备。

**状态：代码修改、17 个相关回归脚本、Rootless 双架构构建和包内容核对已完成。尚未安装到手机，尚无真机 CPU、GPU、温升或后台数小时恢复的实测结果。**

## 首屏卡住的修复

原日志中的插件在微信服务初始化过程中，通过 `CContactMgr.getSelfContact` 同步写头像 Defaults；写入触发配置通知，后台线程可能等待主队列，而主线程在等待服务初始化锁。日志帧在 `setObject:forKey:` 中，单独删除 `synchronize` 不足以解决。

本版的处理：

- 联系人 Hook 在调用原生方法前取得账号代次，返回后只复制账号和 URL，写入内存待处理项。该调用栈不读取／写入 Defaults，也不等待主线程。
- 头像缓存通过异步主队列合并落盘，相同账号／URL 不重复写入。注销停止接收、登录开启新代次，旧代次尚未返回的联系人结果被丢弃。
- 头像显示、消息时间、气泡样式的全局 Defaults 观察者使用 `queue:nil` 接收，只进行线程安全的合并投递，UI 刷新异步执行。
- 消息操作设置和列表圆角设置不再在持有自身同步锁时读取 Defaults；配置通知可以进入并使快照失效。分组通知锁内也不再读取 UIKit 视口。

关键实现：

- [UserInfoHooks.xm](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/UserInfoHooks.xm:63)
- [CSAvatarURLCache.m](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAvatarURLCache.m:21)
- [CSPreferenceRefresh.h](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSPreferenceRefresh.h:6)

修复针对已经找到的插件等待链。微信原生或其他插件造成的首屏卡顿仍需依靠真机恢复测试和新日志区分。

## 其余优化

| 项目 | 本版行为 | 保留的边界 |
|---|---|---|
| 布局设置通知 | 移除接收后重新发送同名 Darwin 通知的监听；原有 getter 直接读取当前设置 | 不修改已保存字体、缩放等值 |
| 消息时间 | 仅读取 8 个相关键，值相同时跳过刷新；通知合并，时区／语言变化保留强制刷新 | 不遍历整个微信 Defaults |
| 语音下载 | 保留原生处理；非最终分块或无插件待下载操作立即返回；最终回调先匹配会话和消息，再读取账号 | 语音复读与语音转发共享下载流程，均保留 |
| 转账旁路 | 开关关闭或私聊／群聊都关闭时提前退出；非 type=49、没有转账文本或 native URL 标记的消息不投递主队列 | 原生消息处理总会执行；收款处理仍在主线程复查设置；测试不调用支付服务 |
| 触摸轨迹 | 配置和图片缓存；事件处理中不读 Defaults／文件；换图和恢复设置时失效；移动更新最高 60 次/秒、拖尾最高 30 次/秒 | 用户开关、颜色、边框、图片保留；最高密度的生成频率降低 |
| 拖尾对象 | 弱引用集合；每触点最多 48 个可见拖尾；淡出时间运行时最多 2 秒；后台／关闭时清理 | 不改写用户保存的密度或持续时间值 |
| 录屏限定 | 运行时监听屏幕捕获状态，直接由开关、录屏状态和前台状态决定显示 | 不依赖设置页面是否打开、或旧的 display.state 值 |
| 底栏持续动画 | 应用失活、场景失活、底栏／祖先不可见、离窗、减弱动态效果、热状态达到 serious/critical 时停动画；允许时恢复 | 保留静态外观、按钮几何、角标和所选动画；可见且温度正常时仍有动画渲染成本 |
| 分组批量消息 | 被动通知从首个事件起合并 80ms；后台投递先去重；一批通知只保存一次视口锚点，发布最终快照 | 用户直接操作仍可立即提升刷新优先级；每次原生模型变化仍失效快照，避免复用过期会话数据 |

分组没有将微信私有可变对象移到任意后台线程读取，也没有声称消除全部会话扫描；优化的是每批事件的重复工作。可见分组的被动消息刷新最多增加约 80ms 合并等待。

## 验证结果

以下均为 macOS 主机上的生产代码／抽取的真实 Hook 配合 UIKit 或微信接口替身，不等同于真机帧率或能耗测试。

| 执行脚本（Tests/） | 结果 |
|---|---|
| verify-preference-concurrency.sh | 12 项通过；主线程占用时 1,000 次头像采集正常返回；无同步写；旧账号代次丢弃；1,000 次通知合成一次，最终值保留；读取配置期间后台刷新不被锁住 |
| verify-touch-trail.sh | 10,015 项通过；10,000 次移动无新增配置／图片读取；可见拖尾上限、过期对象释放、换图、录屏与前后台行为通过 |
| verify-transfer-admission.sh | 7 项通过；2,000 个无效／关闭状态回调保持原生处理且无插件处理；有效候选继续进入处理；未调用支付服务 |
| verify-tabbar.sh | 几何和真实适配器生命周期通过；四种动画均测试失活、高热、隐藏祖先、场景失活与恢复，不重复添加已存在动画 |
| verify-message-actions-core.sh | 1,362 项通过 |
| verify-message-actions-execution.sh | 1,013 项通过；包括抽取的语音下载 Hook、无待处理任务提前返回、无关消息不读账号、有效最终回调及重复回调 |
| verify-message-gesture.sh | 272 项通过 |
| verify-message-time.sh | 142 项通过 |
| verify-bubble-style.sh | 8,269 项策略／绘图所有权和 111 项真实适配器生命周期通过 |
| verify-message-merge.sh | 53,200 项合并／导航和 2,872 项原生适配器生命周期通过 |
| verify-list-corners.sh | 869 项通过，包含配置读锁／通知失效并发回归 |
| verify-group-lifecycle.sh | 67 项通过；200 个可见消息通知一批只取一次锚点、发布一次；后台独立事件不发布 |
| verify-group-business.sh | 27 项通过 |
| verify-group-incremental.sh | 178 项通过 |
| verify-group-interactions.sh | 124 项通过 |
| verify-group-selection.sh | 30 项通过 |
| verify-group-viewport.sh | 72 项通过 |

`git diff --check` 通过。构建仍有项目原有的 API 弃用／未使用局部变量和链接器过时参数警告，没有编译或链接错误。

## 构建与安装包身份

在原 checkout 修改源代码。使用独立 Theos 构建目录，未执行 `make clean`：

```bash
make package -j4 SCHEME=rootless PACKAGE_VERSION=1.8-8 \
  _THEOS_LOCAL_DATA_DIR=/tmp/wechat-improve-resume-20261018-build \
  THEOS_PACKAGE_DIR=/tmp/wechat-improve-resume-20261018-packages
```

已同步 `control`、插件内版本、更新说明及 README 到 1.8-8。构建结束信息也改为输出真实安装包目录，并移除对不存在的 install.sh 的提示。

- 安装包：[com.wechat.improve_1.8-8_iphoneos-arm64.deb](/Users/zhangshichao/Documents/Workspace/WeChatImprove/packages/com.wechat.improve_1.8-8_iphoneos-arm64.deb)
- 调试符号：[WeChatImprove-1.8-8-dSYMs.zip](/Users/zhangshichao/Documents/Workspace/WeChatImprove/packages/WeChatImprove-1.8-8-dSYMs.zip)
- 包方案：Rootless；控制字段 Architecture 为 iphoneos-arm64；动态库同时包含 arm64 和 arm64e。
- 安装路径：`/var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib`。
- 包内提取的动态库 SHA-256 与构建输出一致；各架构 dSYM UUID 与动态库一致。
- 包 SHA-256：`ef2f264b36a54889d0e9e40395734a69ae3f21dea2baaa04b45d20041b3d0c19`。
- arm64 UUID：`C1E1AEA8-EB87-3A18-8F20-738AB6DB9429`。
- arm64e UUID：`6CED236E-716E-33B4-818A-236AA4128C53`。
- 旧 1.8-7 和 1.8-7-b1 包与原审计清单的 SHA-256 完全一致；原有配置、账号和聊天数据未修改。

[最终构建日志](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/performance-resume-2026-10-18/build-1.8-8.log) · [源码与产物哈希清单](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/performance-resume-2026-10-18/implementation-manifest.json)

## 真机验收（待执行）

沿用原手机、原微信、原账号和数据，保留已确认开启的聊天分组、触摸轨迹、底栏持续动画。安装匹配现有注入环境的包后完全退出微信重新进入；插件设置内版本应为 1.8-8。不需要重置设置、删除数据库或重建账号。

| 场景 | 操作与观察 | 通过条件 |
|---|---|---|
| 冷启动 | 完全结束微信后重开 5 次，记录点击图标到首屏可操作的时间；观察前 30 秒与之后 2 分钟 | 每次能进入并操作；启动负载回落；没有持续通知循环 |
| 静止首屏 | 不触摸 5 分钟，记录微信进程 CPU、GPU／Energy、系统热状态；亮度、网络与充电条件保持一致 | 没有不断增长的任务／对象；将可见底栏动画的稳定渲染成本与冷启动峰值分开 |
| 触摸轨迹 | 连续滚动／长按移动 2 分钟，抬手后再静止；覆盖换图片、仅录屏显示、录屏开始／停止 | 拖尾正常显示、不会随手势时长无限积累；停止操作后回落；后台没有残留轨迹 |
| 固定消息输入 | 使用固定数量的测试消息，检查分组未读、置顶、排序、切换、搜索及左滑；验证原有语音复读／转发入口 | 分组结果正确、交互不被被动刷新长期阻塞、消息操作无重复发送；本机未代用户发消息 |
| 长时间后台 | 分别后台 30 分钟与 2～4 小时再打开；覆盖无新消息、批量补消息、弱网恢复、快速切换前后台 | 能回到可交互首屏；未复现原通知／服务锁等待链；动画只在允许时恢复 |
| 账号与设置边界 | 使用用户既有账号切换流程；改头像、布局设置、恢复已有备份 | 头像不被旧请求覆盖，配置变化生效，布局通知不自触发循环 |

没有手机连接和上述测量结果，因此当前只交付可安装候选包，不能将“编译与回归通过”表述为“真机卡死／发热已经验证消失”。若仍卡首屏，新的 .ips 必须先按本包 UUID 对齐，再结合对应 dSYM 分析；旧 1.8-7 的偏移不能直接套用。
