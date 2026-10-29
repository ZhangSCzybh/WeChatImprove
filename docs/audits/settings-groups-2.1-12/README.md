# 2.1-12：调整插件首页设置分组

日期：2026-10-29。沿用当前项目工作目录和现有配置，更新版本号、离线更新说明与交付文档，完整打包 Rootless、Rootful 两种方案。

## 本版变化

将插件首页的“附件布局”和“文本占位”从“功能增强”移至“界面定制”，位于“布局设置”之后、“聊天分组”之前。两个条目沿用原有标题、图标和目标设置页面。设置数据及对应功能的运行逻辑不变。

`control` 中的安装包版本、`Headers/CSUserInfoHelper.h` 中的插件显示版本、`Controllers/CSReleaseNotesViewController.m` 中的当前离线说明均同步为 `2.1-12`。README 当前下载地址和打包示例同步更新。

本包继续包含 `2.1-11` 的密友消息静默移除及历史 `silenceMessages` 配置兼容；会话隐藏角标过滤、来电拒接、账号／代次校验及红包／收款摘要隐私接口继续保留。实现与此前主机行为验证见 [2.1-11 记录](../closefriend-no-message-silence-2.1-11/README.md)。

## 分组与路由核验

`Controllers/CSCustomViewController.m` 中的条目定义位于分组数组构造之前。“附件布局”和“文本占位”各在“界面定制”数组出现一次，“功能增强”数组不再包含这两个条目。

列表数据源按 `self.sections` 读取实际分组与行数；点击处理先取当前条目，再按标题选择设置控制器。两个入口分别继续进入 `CSChatAttachmentSettingsViewController` 与 `CSInputTextSettingsViewController`，不依赖固定 section／row。

分组调整完成后已对该控制器分别进行 arm64、arm64e 对象编译，结果通过。本版不重复执行上一版密友行为测试；完整构建与包校验用于验证当前源码的交付产物。

## 构建与产物核验

使用本目录 [build-packages.py](build-packages.py) 在全新临时目录分别完整构建 Rootless 和 Rootful，产物输出到 `packages/2.1-12-settings-groups/`。构建前记录生产输入和既有 `.theos`、`packages` 文件 SHA-256，构建后比较，避免覆盖已有构建缓存与历史安装包。

[verify-packages.py](verify-packages.py) 核对包元数据、安装路径、arm64／arm64e、最低 iOS 15.0、注入过滤 plist、staging 与包内动态库哈希、保留接口、退役静默接口和 dSYM UUID，生成调试符号归档及 SHA-256 清单。实际结果以 [build-result.json](build-result.json)、[package-verification.json](package-verification.json) 和 [preserved-artifacts-after.json](preserved-artifacts-after.json) 为准。

Rootless、Rootful 完整构建均退出 0，分别耗时 23.165 秒和 23.169 秒；每个安装包均包含 arm64、arm64e，最低目标均为 iOS 15.0。版本、安装前缀、过滤 plist、包内动态库与 staging 的哈希及四份 dSYM UUID 均核验通过。支付、未读聊天面板和来电接口保留，退役静默接口未导出；调试符号归档包含 12 个文件，CRC 通过。最终对 `SHA256SUMS` 执行独立复核，三份产物全部通过。

生产输入哈希前后一致，既有 `.theos` 与 `packages` 共 1,276 个文件全部保留，无缺失或哈希变化。`git diff --check` 通过。每个构建方案均有 6 条与上一版相同的既有警告：`UILocalNotification` 弃用两条、`statusBarFrame` 弃用两条、链接参数 `-multiply_defined` 过时两条，详见构建日志。

- [Rootless 安装包](../../../packages/2.1-12-settings-groups/com.wechat.improve_2.1-12_iphoneos-arm64.deb)
- [Rootful 安装包](../../../packages/2.1-12-settings-groups/com.wechat.improve_2.1-12_iphoneos-arm.deb)
- [调试符号](../../../packages/2.1-12-settings-groups/com.wechat.improve_2.1-12_symbols.zip)
- [SHA-256](../../../packages/2.1-12-settings-groups/SHA256SUMS)

## 真机验收

本次只进行本地构建与核验，尚未安装到设备。安装与注入环境匹配的包后，检查插件首页“界面定制”中的“布局设置 → 附件布局 → 文本占位 → 聊天分组”顺序；确认“功能增强”中已移除这两个入口，并逐一点击确认仍进入原设置页面、原设置值保留。密友通知相关行为沿用上一版的真机验收步骤。
