# 2.5-13+online.3：后台消息网络活动修正验证包

online.1 和 online.2 均出现过“微信仍在后台执行，但群拍动直到回前台才入站”的现象。本版在原有在线模式实验上增加原生网络活动处理：只在已核对的微信进入后台调用位置，将该次 default transport 的后台信号保持为活动状态；同时保留既有 onlineMode 上报与收到通知即同步的路径。

这是包含行为修正的临时验证包，尚无本版手机实测结论。主机测试、编译成功、BgFg 响应成功都不能替代群拍动实际时效验证。

## 安装与使用

- 包：`packages/2.5-13-online-experiment-3/com.wechat.improve_2.5-13+online.3_iphoneos-arm64.deb`。
- Rootless，iOS 15+，包含 arm64 / arm64e；沿用包管理器安装，重新启动微信使新 dylib 加载。
- 当前仅适配已核对的微信 8.0.80.34：主程序 UUID `7E4A8171-5ACC-3A72-A76A-3ACE52D3D895`。启动测试时同时校验主程序 UUID、两处入口指令和调用点指令。任何不匹配均拒绝开启，不只匹配版本显示字符串。
- 已配置有效的群“拍我自动回拍”或“拍我自动回复”；即时测试时将业务延迟设为 0。
- 在“自动功能”底部先开始采样，再开启“测试后台实时接收”。此开关默认关闭，仅本次微信进程有效，10 分钟自动关闭；不要只安装而未开启测试。
- 可以沿用 HBB 后台常驻，本插件“后台运行”可保持关闭；也可单独使用本插件保活。网络修正本身不申请音频或系统后台任务，仍要求微信实际有执行机会。
- 分别测试后台、锁屏，间隔发送多次群拍动，包含进入后台后 30 秒、1 分钟及更久的情况。在发送端观察回复，不要通过打开接收端微信触发前台同步。测试后停止并导出采样。

网络入口服务于整个微信连接，不能按群或按拍动消息隔离；本测试可能增加耗电、改变通知表现。手动关闭、到期、配置失效或账号变化会释放仍属于本实验的网络覆盖；自然前台事件优先接管。没有伪造 UIApplication / Scene 状态，也没有触发整个前台生命周期。

## 最终实现

- 新模块 `CSAutomationNetworkActivity.mm` 通过 MSHookFunction 处理两路已核对的 C++ `void(bool, const std::string &)` 入口。仅主线程、`default` context、精确 AppDelegate 后台返回地址、完整 hook 安装以及当前实验/账号/群配置资格全部成立时覆盖 false。
- 其他原生调用保留参数和线程。按通道保存实际被覆盖的原生意图；后来的自然调用拥有更高优先级。账号切换时释放的是进程级 transport 覆盖，不会请求旧账号的业务服务。
- 自发状态调用与自然调用发生交错时，合并一个主队列修复，按最新原生意图收口。没有周期性计时器或消息补拉；没有跨原生回调持有互斥锁。
- `emitOwned` 与自然入口统一管理调用深度，重入关闭会在外层原生调用结束后恢复。Foreground fence 阻止旧后台 false 在真实前台交接后被重放；已明确的最新自然 true 即使 UIKit 已 Active 仍可得到修复。
- `CSAutomationOnlineExperiment.m` 保留账号、代理上下文、过期队列事件拒绝、自然在线请求接管和 10 分钟到期保护；关闭/配置/账号/前台变化同时管理网络覆盖。
- 仅归属校验通过的自发 `NetCmdLongLinkEvent` 包装已有 responseHandler。保留原 callback 的线程、NSData、两个 int 和异常，不改变 decoder 或重试策略，不捕获 event 自身。原生 errType/errCode 均为 0 才记录成功。sendOnly 路径明确无 ACK。
- add 返回后只读 `m_bgFgEventID`，记录的是原生当前事件 ID 快照，不称为服务器确认。新增阶段均加入记录器允许列表；不导出账号、群号、成员、正文或 XML。

## 验证

- 网络模块：**2771 项检查**，覆盖真实 Mach-O 指纹拒绝、半安装、调用来源、双通道、原生接管、确定性并发／重入、恢复与 ObjC/C++ 异常。
- 在线实验：**8465 项主检查 + 22 个 ABI 拒绝进程的 960 项检查**，包含真实代理上下文、账号边界、外部保活资格、过期队列保护，以及新回调包装的工作线程/数据/异常透传。
- 记录器 **16322 项**，发送回调 **639 项**；新增阶段可实际导出。
- 新模块和在线模块均通过 arm64 / arm64e 严格 iOS 对象编译；完整 Rootless 包已构建并核验。
- 455 项生产输入冻结在新的临时目录；完整补丁与 online.2 增量补丁均重新应用并逐文件核对一致。
- 正式 checkout 的既有 44262 个跟踪文件、90 个历史包文件核对未改。实验以独立安装包、源码补丁、测试补丁交付。

主要结果见 `validation-summary.json`、`package-verification.json`、`patch-replay.json` 与 `test-results/`。原生审查见 `native-review/REVIEW.md`；初版和中间审查问题均已注明最终处理。没有上传用户日志、HBB.dylib 或微信主程序。

## 重建

基线 commit：`3f0d383a4d1e0da49473bae67cf3831531430cb5`。在独立 checkout 应用 `online-source.patch` 与 `online-tests.patch`，然后运行本目录 `build_online.py PATCHED_SOURCE NEW_AUDIT_OUTPUT`。脚本创建新的 `/private/tmp` 输入副本，指定独立 Theos 数据/构建/打包目录；不要运行项目 `make clean`，以免删除历史安装包。

`online2-to-online3.patch` 可用于从上一验证包源码重建本次增量。版本号、版本说明、采样导出版本与 deb control 均为 `2.5-13+online.3`。
