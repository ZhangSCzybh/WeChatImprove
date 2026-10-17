# 支持作者宿主兼容修复 · 1.7-6

## 问题与证据边界

用户反馈 1.7-5 点击“支持作者”闪退。该版本为了移除中转页，把已成功的 MMUIViewController 宿主换成了普通 CSCustomViewController（UIViewController 子类），并放宽类型检查。旧测试替身没有实现微信对栈顶页面的私有接口调用，因此测试通过不能说明宿主兼容。

本轮未取得手机崩溃栈。以下为确认的静态接口不兼容及针对性修复，不声称已在手机复现并消除全部崩溃。

分析对象为本机 `微信_8.0.78_大礼包20260908_秋名山.ipa` 中的主程序，Info.plist 标记 8.0.78 / 8.0.78.34，与用户报告版本一致；这不等于确认用户设备运行相同二进制或插件组合。主程序 SHA-256：`0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`，LC_ENCRYPTION_INFO_64 的 cryptid 为 0。

REA 成功绑定主程序；完整 Ghidra 分析未完成，在已有定点结果后主动终止并关闭会话，没有可引用的反编译 Evidence ID。下表来自本地 Mach-O Objective-C 方法元数据、链式指针重定位解析与 Capstone ARM64 定点反汇编，不是运行时调用栈。临时分析文件保存在 `/tmp/wechat-reward-native-investigation/`，不打入插件。

| 本地证据 | 位置（未加 ASLR 的虚拟地址） | 观察与含义 |
| --- | --- | --- |
| S1 | `ScanWXCodeRewardUrlPrefixHandler.handleUrl:`，`0x10571173c` | 经 delegate 获取控制器；`0x105711d54` 加载 `startQRCodeRewardPayerControlLogic:controlData:`，将取得的控制器传给支付服务。 |
| S2 | `WCPayControlLogic.startTopVCLoadingNonBlocked`，`0x109424b78` | 获取 `topViewControllerOfMainWindow`；`0x109424bbc` 加载 `startLoadingNonBlock`，`0x109424bc0` 调用；`0x109424c3c` 加载 `loadingViewX`，`0x109424c44` 调用。 |
| S3 | `WCPayControlLogic.stopTopVCLoadingNonBlocked`，`0x109424c9c` | 再次获取当前栈顶；`0x109424ccc` 加载 `stopLoading`，`0x109424cd0` 调用，没有在这些发送点检查 respondsToSelector。 |
| S4 | `CAppViewControllerManager.topViewControllerOfMainWindow`，`0x10014c3c4`；`topViewControllerOfWindow:`，`0x10014c58c` | 原生代码遍历窗口的导航/呈现关系；导航容器分支获取 visibleViewController。仅创建一个不在栈顶的隐藏宿主无法保证加载调用落在正确对象上。 |
| S5 | `HeadersFile/ScanQRCodeUrlPrefixHandlerDelegate-Protocol.h`、`MMUIViewController.h`，及当前设置源码 | delegate 声明返回 MMUIViewController；原生类具备上述接口，普通 CSCustomViewController 不具备。 |

S1–S5 建立了宿主兼容问题，不能单独确定用户那次异常的准确 selector 或调用栈。原生 CGI 异步回调也不在最初 handleUrl: 的异常捕获栈内，不能靠包裹入口 @try 解决这类问题。

## 修复

- `CSNativeSettingsHost` 在运行时创建真正继承 MMUIViewController 的插件容器，不引用私有类链接符号、不修改微信原有类、不替换现有对象的 isa。
- 容器调用原生 viewDidLoad，并按 UIKit containment 规则嵌入原 CSCustomViewController；保留原生 view 和加载实现。原设置内容占满容器，子设置页继续沿用原导航栈。设置内容的 navigationItem 使用容器的 navigationItem。
- “我”、微信设置、插件管理三个入口统一使用该类。容器从进入插件设置起就是导航栈中的页面，点击支持作者时不 push/present 另一个插件页面，也不在结束时显示完成页。
- presenter 将设置子控制器定位到原生父容器，再发起已验证的固定码路由。route 恢复 MMUIViewController 类型限制，并检查 startLoadingNonBlock、stopLoading、loadingViewX 的方法签名。原生类缺失时保留普通设置入口，但赞赏操作安全失败。
- 等待原生金额页期间暂时禁用设置内容交互，避免在 CGI 返回前打开另一个普通设置页面；原生金额页出现、失败、取消或超时后恢复原交互状态。结束时停止本次加载并清理本次请求，不控制全局支付栈。
- 固定码、handler、默认初始化及微信金额/支付流程沿用 1.7-3 已验证内容。

## 验证与产物

- `bash Tests/verify-native-reward.sh`：54 项路由断言、60 项宿主/页面管理断言通过。
- 新测试编译生产 route、presenter、host；验证真实继承关系、原生 viewDidLoad 调用、子控制器容纳、栈顶加载接口、handleUrl 返回后的停止加载、无插件中转页、原生返回、重复点击、超时、失败与关闭清理。UIKit / 微信类是测试替身，不是真实微信。
- 反向对照：仅在临时文件恢复 1.7-5 的普通 UIViewController 宿主检查，新路由测试必须失败，确保该缺陷不会再次被同一套测试放过。
- `make package -j4 SCHEME=rootless PACKAGE_VERSION=1.7-6` 成功，arm64 / arm64e；新增赞赏及宿主代码无编译警告，项目其他现有代码仍有警告。
- 解包确认 Version 1.7-6、Architecture iphoneos-arm64、双架构；包内 dylib 与 staging 构建文件一致；包含原生容器与已确认固定码，不含旧赞赏中间页类、提取器类或流程结束文案。
- 1.7-1、1.7-3、1.7-4、1.7-5 包的 SHA-256 与之前记录一致。

产物：`packages/com.wechat.improve_1.7-6_iphoneos-arm64.deb`（728622 字节）。

SHA-256：`ef0104bd97acf71928ce16a2155b8042651719aafbe7455fe31efafd63c941bf`。

## 待手机验收

安装 1.7-6 并完全退出、重新打开微信，确认版本信息显示 1.7-6。点击支持作者应从原设置界面进入微信赞赏金额选择页；返回后仍为原设置界面且可再次进入。还需验证三个入口、普通子设置页的进入/返回，以及网络异常后恢复操作。无需再次付款来验证跳转。

若仍闪退，应取得此次微信 `.ips` 报告的异常原因、Last Exception Backtrace 与 Crashed Thread；届时按真实异常继续定位，不能把静态推断当作实机结论。
