# 原生选择器递归闪退修复 · 1.8-54

基于 1.8-53（`82f70103`），修复密友群聊、红包白名单群和黑名单群打开时的闪退。红包反馈已按用户最新更正统一为“点击闪退”。

## 崩溃定位

提供的 IPS 记录主线程 `EXC_BAD_ACCESS / SIGSEGV`，提示 `Thread stack size exceeded due to excessive recursion`，原始栈 16016 帧，其中重复片段深度为 15991。

崩溃镜像为 arm64e，UUID `DD657196-2003-31F5-BD9B-B094172EC2A8`，与保存的 1.8-53 dSYM 完全一致。使用该架构的符号文件解析：

| 镜像偏移 | 1.8-53 源码位置 | 含义 |
| --- | --- | --- |
| `0x11eee8` / 1175272 | `PickerInitData`，第 81 行 | 读取选择器关联状态 |
| `0x11ef50` / 1175376 | `PickerInitData`，第 86 行 | 调用按实例动态类型解析的父类实现 |

旧代码通过 `class_getSuperclass(object_getClass(picker))` 找原生父类。当 UIKit 或其他运行时包装在插件子类上再增加一层子类时，这个“父类”实际就是插件子类，方法解析返回 `PickerInitData` 自身，形成无限递归。`objc_getAssociatedObject` 是每次递归读取状态时经过的调用，并非关联对象 getter 自身发生循环。

IPS 含 UIKit 的 `_sendViewDidLoadWithAppearanceProxyObjectTaggingEnabled` 调用，但没有记录选择器当时的实际类名；不能据此声称已直接读取手机上的包装类。测试在 `viewDidLoad` 前增加一层运行时子类，已复现旧实现的 SIGSEGV，符合该崩溃栈。符号化与日志哈希见 `crash-symbolication.json`；旧符号文件另存于该记录中的临时目录，避免新构建覆盖。

## 修复

仅修改原生选择适配层的方法转发：在注册插件子类时保存经过签名校验的原生 IMP，随后直接调用保存的实现。同步修正群聊 `initData`、群聊 `updateRightBarBtn` 与好友 `updateRightBarItemEnabled:` 三处，避免相同的动态父类解析问题。

密友群聊以及红包白名单群、黑名单群均调用 `CSNativeContactPickerPresent(..., YES, ...)`，因此共享此次修复。原生列表加载和展示时机、完成／取消、已选名单回填与持久化流程沿用 1.8-53。

## 专项验证

- 新增运行时子类复现用例，修复前退出码 139（SIGSEGV），记录见 `recursion-before-fix.json`。
- 修复后 `bash Tests/verify-native-contact-picker.sh` 共 41 项通过，记录见 `host-results.json`。
- 覆盖动态子类下的群聊初始化、按钮更新各执行一次，重复初始化保留当前选择，好友按钮转发，以及三个群聊入口的共用打开配置、勾选回填、清空保存和取消不保存。
- 原有好友搜索／标签的实时选择结果、重复完成、账号切换、密友授权变化和无法解析旧联系人时的名单保留检查通过。

测试编译实际适配器代码，使用主机上的 UIKit／微信接口替身；红包两个设置行到适配器的路由另以源码核对。未模拟真实微信列表渲染或执行手机触摸操作。

## 构建与交付

构建命令为 `make package -j4 SCHEME=rootless PACKAGE_VERSION=1.8-54`，输出 arm64／arm64e，最低 iOS 15.0。`build-result.json` 保存构建结果，`validation.json` 保存版本、架构、dSYM UUID、源码摘要、安装包与交付副本一致性的校验结果。

开发工作树：`/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove`，分支 `codex/close-friends-148`。

交付位置：`/Users/zhangshichao/Documents/Workspace/WeChatImprove/packages/com.wechat.improve_1.8-54_iphoneos-arm64.deb`。保留原项目 main 源码和历史安装包，没有安装到手机或改动微信数据。

真机待验：安装后完全退出并重新打开微信，分别点击密友群聊、红包白名单群、黑名单群，确认能打开原生选择器；各验证一次完成保存和取消，另检查密友名单的完成按钮。
