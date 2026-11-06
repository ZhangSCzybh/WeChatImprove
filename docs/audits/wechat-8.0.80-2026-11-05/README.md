# 微信 8.0.80 兼容修复：2.2-14

本次按用户提供的 IPA 和录屏适配四项功能：设置子页顶部留白后跳动、搜索密码和首页标题长按无法恢复密友、底栏样式失效、聊天气泡紧密布局失效。源码、显示版本和包版本统一为 `2.2-14`，保留此前 `2.2-13` 签名信息解析修复。

## 输入与工作环境

- 既有 checkout：`/Users/zhangshichao/Documents/Workspace/WeChatImprove`。
- IPA：`/Users/zhangshichao/Downloads/Telegram Desktop/微信_8.0.80_大礼包Push20261026_秋名山.ipa`。
- 实际应用：`com.tencent.xin`，版本 `8.0.80`，构建号 `8.0.80.34`。消息、搜索和首页实现位于主 arm64 Mach-O `Payload/WeChat.app/WeChat`。
- IPA SHA-256：`6376429b62d86d4754454ea3048454506937f5289f5536751e2eb65faf9f3a30`。
- 主二进制 SHA-256：`571c5b8cf8732eb5402ffddcbeb93830cb6695bad180be5613ad4167764524e9`。
- 录屏：`/Users/zhangshichao/Downloads/ScreenRecording_11-05-2026 20-40-53_1.MP4`，9.148 秒。
- 本项目是 Objective-C / Logos / Theos 注入插件，无前后端服务端口或服务数据库。未启动微信、连接手机或模拟器，未读写用户账号、微信数据库、Keychain 或持久配置。

REA 用于识别和提取 IPA；主二进制超过该工具 64 MiB 的 native metadata 快照预算，后续以小型 mmap 元数据读取器和 `llvm-objdump` 定点反汇编核验。没有重试整包分析或执行 IPA 内其他插件。REA 提取 Evidence 与 manifest 记录于 [input-identity.json](input-identity.json)，分析会话已关闭。

`video-contact-sheet.jpg`、`settings-before.jpg`、`settings-after.jpg` 均来自用户的原录屏；后两张分别是原有跳动前后的帧，不是修复后的真机截图。

## 框架与修复位置

`CSPluginStorageStartup` 和备份就绪调度负责现有初始化顺序；`Hooks/*.xm` 接微信私有生命周期和回调，`Controllers` 内的 Adapter / Policy 分别核验原生结构与计算行为。设置入口仍由 `CustomEntryHooks` 创建现有导航容器，经 `CSNativeSettingsHost` 承载原生宿主与插件首页，子页由 `CSCustomViewController` 及嵌套编辑器推入。此次继续沿用各功能偏好、账号隔离、授权与隐私校验。

| 问题 | 已确认的证据与修复 |
| --- | --- |
| 设置子页顶部先留白后上移 | 录屏中顶栏头像、触摸轨迹、界面净化页均有转场后上移；各页直接继承 `UITableViewController`，无统一的导航边界和 inset 策略。新增仅供插件使用的 `CSSettingsTableViewController`，在初次加载和转场前确定非延伸边界、关闭自动顶部 inset、保留底部安全区贡献；仅首次贴顶状态消除临时负 offset，后续布局与返回不重设滚动。移除顶栏头像页布局中的一次性重复 reload。不能仅靠静态方法名证明某个微信方法是留白的唯一运行时原因。 |
| 搜索密码无法恢复密友 | `onGetTextInput:isFromVoice:` 的真实编码为 `v28@0:8@16I24`，旧 BOOL hook 被 ABI 校验拒绝；`mmInputBoxTextChanged:text:` 首参为 `UITextRange`，原实现把非 nil 空范围误判为正在组词。现在精确支持旧 BOOL 与新 unsigned int，并读取合法 `isEmpty` 判断，完整密码继续在原生查询前消费。 |
| 首页标题长按无法恢复密友 | 新版存在 `m_titleView:MFTitleView` 与自定义导航承载；原手势只挂系统 navigationBar。现在优先绑定实际标题，跟随标题初始化和布局更新，目标替换时禁用旧手势；保留前台、顶层页面、账号、密码/生物识别规则。标题承载与症状一致，但实际触摸链尚待真机验证。 |
| 底栏样式失效 | 新路径为 `NewMainTabBarViewController → WCTabBarController`、`WCTabBarView.itemViews → MMMainTabBarItemView → itemView`，旧代码只接 `MMTabBarController/MMTabBar`。按实际继承链接入新容器，保留原生按钮、点击、选中和角标，支持转场副本、命中、样式关闭恢复。 |
| 紧密布局失效 | 原 `CSNativeProfile` 明确只允许 `8.0.78`，`8.0.80` 在测量前直接回退原生间距。核验新版消息测量、回复与语音转文字完整高度后，仅加入 `8.0.80` / `8.0.80.*`，未知版本仍回退。 |

设置页继承迁移覆盖插件首页直接设置入口和 AI、备份、定时任务的嵌套表页；微信原生页面不改变基类。既有联系人选择器不在迁移范围。

详细证据：

- [设置页布局验证](settings-validation/README.md)
- [密友兼容事实与回归](privacy-validation/PRIVACY_FINDINGS.md)
- [新底栏类、行为和恢复验证](tabbar-validation/README.md)
- [紧密布局测量与旧实现失败对照](merge-validation/FINDINGS.md)
- [此前签名信息修复](../account-signature-2026-11-05/README.md)

## 验证和构建

回归使用实际生产源文件或原样提取的 hook 边界，在 Foundation 与 UIKit/native 替身上执行；底栏与设置页另经真实 iPhoneOS SDK 编译。测试材料放在本审计目录，不恢复用户已删除的根 `Tests`。

- 密友：旧 BOOL 搜索、新 unsigned int 搜索和恢复手势回归通过；旧实现负对照分别复现空 marked 范围拦截、unsigned int hook 安装失败、实际标题未附手势。
- 底栏：新旧容器、原生控件、选中和角标、命中、转场、关闭恢复及原 39 项点击效果检查通过；arm64 / arm64e SDK 编译通过。
- 紧密布局：修改前 `8.0.80` / `8.0.80.34` 复现预期 36pt、实际原生 55pt 的失败；修改后 `8.0.78` / `8.0.80` / `8.0.80.34` 各 17,566 项通过，Policy 的 235,148 项通过。
- 签名信息：此前二进制 / Unicode 解析的 43 项检查再次通过。
- 设置页：首帧布局策略、初次贴顶偏移、返回滚动、底部安全区与键盘额外 inset 由专门生命周期回归验证，覆盖清单和结果见对应报告。

设置页实际生产基类的 5,114 项生命周期检查通过；38 个直接继承类、44 个表页后代和插件首页的 33 个具体分配入口均已清点。

完整构建使用 [build-packages.py](build-packages.py) 将生产源码冻结到独立临时目录，分别构建 Rootless / Rootful，均包含 arm64 / arm64e；不调用根 `make clean`。验证源码哈希、关键源文件和 hook 编译、解析函数及新适配符号、包元数据、dSYM UUID 与历史包哈希。结果见 [delivery-build/build-result.json](delivery-build/build-result.json)。

两种构建均已通过。完整构建存在旧式 UIKit API 的弃用警告与 Theos 链接器选项过时警告，没有编译或链接错误。最终交付再次核对当前源码与构建源码相同、产物校验和相同、此前签名解析实现与原 IPA 保持原样，见 [final-verification.json](final-verification.json)。

交付目录：`packages/2.2-14-wechat-8.0.80-final/`。其中 `WeChatImprove.dylib` 直接取自验证后的 Rootful 包，供现有重签工具注入与签名；同时提供两种 deb、调试符号和 SHA256SUMS。未改写原 IPA，未安装到用户手机。

## 真机验收范围

当前没有用户设备上的注入和渲染验收；本机也没有可用 iOS Simulator runtime，因此不把宿主模型验证或 SDK 编译称为真机显示通过。用户提供的 IPA 已包含多个其他注入插件；本次未执行或修改它们，仍需在原重签环境确认 hook 组合。

使用现有重签流程替换旧 WeChatImprove 插件为本版后，优先检查：

1. 连续打开顶栏头像、触摸轨迹、界面净化、账号信息，以及 AI / 备份嵌套页；首帧不留大块空白，返回原页保留滚动，弹出键盘后底部内容可达。
2. 隐藏密友后，用首页搜索输入完整密码；再独立测试首页标题长按。密码错误、组词中、后台、非首页、弹窗遮挡及生物识别失败均不得恢复。
3. 开启底栏样式，切换四个 tab、查看角标并进出聊天；关闭后恢复原生。确认正常点击与长按/反馈没有被替代。
4. 开启气泡紧密布局，检查同人连续消息、群姓名、回复、语音转文字与消息时间；关闭后恢复原生间距。

本次保留既有配置、签名信息修复、滚动位置规则及历史安装包；没有运行数据迁移或重置。
