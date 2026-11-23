# WeChatImprove 2.9-3 完整版

基于当前完整源码构建，汇总 `2.9-3-beta02` 至 `beta05` 的快捷面板功能。聊天分组、底栏、朋友圈、消息增强、自动回复、人工智能、群聊工具、配置备份等原有模块均包含，使用正式构建配置 `DEBUG=0`、`FINALPACKAGE=1`。

## 安装文件

| 环境／产物 | 文件 | 说明 |
| --- | --- | --- |
| Rootless | [com.wechat.improve_2.9-3_iphoneos-arm64.deb](com.wechat.improve_2.9-3_iphoneos-arm64.deb) | 安装至 `/var/jb/Library/MobileSubstrate/DynamicLibraries/` |
| Rootful | [com.wechat.improve_2.9-3_iphoneos-arm.deb](com.wechat.improve_2.9-3_iphoneos-arm.deb) | 安装至 `/Library/MobileSubstrate/DynamicLibraries/` |
| 重签动态库 | [WeChatImprove.dylib](WeChatImprove.dylib) | 与 Rootful 安装包内动态库逐字节一致 |

两个安装包及独立动态库均包含 `arm64`／`arm64e`，最低编译目标为 iOS 15.0。按现有注入环境选择安装包；包名中的 `iphoneos-arm64`／`iphoneos-arm` 表示打包方案。调试符号见 [symbols.zip](symbols.zip)，全部发布文件的校验值见 [SHA256SUMS](SHA256SUMS)。

## 本版内容

- **快捷面板**：位于增强 Tab 的“自动功能”下方，提供总开关、预览、入口增删与排序；支持微信主页底栏上滑、聊天输入框上滑，或同时开启两个位置。
- **十五项快捷入口**：扫一扫、钱包、朋友圈、我的二维码、收藏、插件主页、个人资料、发起群聊、添加朋友、表情商店、面板设置、付款码、视频号、文件传输助手、聊天背景。包含二维码原生路径、文件传输助手会话路由及全局“设置 → 聊天 → 聊天背景”入口的调整。
- **背景与配色**：支持背景颜色、上传图片、透明度和恢复默认；字体颜色与图标颜色独立自定义。字体默认按背景选择深浅，图标默认精确跟随“界面调色”。预览与实际面板共用渲染实现。
- **顶部信息**：显示当前账号头像、昵称、微信号、时间与日期；采用系统圆润字体设计，时间保留等宽数字与动态字号支持。面板内部的“快捷面板”标题已移除。
- **配置兼容**：九项快捷面板配置纳入现有备份、恢复与重置，背景图片随资源备份迁移；已有入口选择、排序及其他配置继续沿用。
- **正式版本信息**：安装包版本、插件内部版本与更新说明统一为 `2.9-3`，历史 Beta 更新说明保留。

## 构建与验证

本次从同一源码目录使用两个独立临时构建目录重新编译 Rootless 与 Rootful，未运行 `make clean`。每个方案均完成全部 **292 个编译单元（236 个控制器实现、56 个 Logos Hook）在 arm64 与 arm64e 上的编译**，未裁减模块。编译覆盖见 [compilation-coverage.json](compilation-coverage.json)，命令见 [build-commands.json](build-commands.json)，日志见 [Rootless](build-rootless.log)／[Rootful](build-rootful.log)。

本次实际执行并通过：

- 两个方案的完整编译、打包及包内版本、安装路径、双架构核验。
- 四组架构／方案的 dSYM UUID 与对应二进制匹配，符号压缩包完整性校验。
- 实际生产更新说明函数的编译与执行，确认 `2.9-3` 正确选取六条正式更新说明；版本号和文档一致性检查。
- 更新说明控制器的 arm64／arm64e 严格语法检查（`-Wall -Wextra -Werror`）。
- 533 个构建输入与 442 个测试文件的 SHA-256 核验，构建期间源码无变化；历史安装包、动态库及现有 `.theos` 构建文件哈希保持一致。目录清单中的 `.DS_Store` 元数据差异单独记入最终核验记录。

与 `beta05` 相比，533 个构建输入中仅版本头文件、Debian `control` 和更新说明三项元数据改变，其余 530 项功能源码及全部 442 个测试文件哈希一致。因此，12 组功能回归的通过记录沿用 `beta05`，**本次未重新执行这 12 组回归**；保留日志副本，并在 [beta05-provenance.json](regressions/beta05-provenance.json) 中记录原发布版本、哈希依据及原结果。范围包括面板偏好、手势、原生入口路由、背景、配色、取色设置、备份注册表及资源、首页统计、设置首页、底栏和设置单元格。

最终核验记录见 [build-validation.json](build-validation.json)；实际新增检查见 [release-metadata-results.json](regressions/release-metadata-results.json) 和 [ios-release-results.json](regressions/ios-release-results.json)。源码与测试清单分别见 [source-manifest.json](source-manifest.json) 和 [test-manifest.json](test-manifest.json)。

## 实际设备范围

本次仅编译、打包与主机核验，没有安装到设备，也没有启动或切换微信运行环境。实际手势、私有页面跳转、照片选择、系统圆润字体与中文回退、大字号及小屏观感，仍需在原设备、原账号和原注入环境验收；本次构建不增加真机运行验证结论。备份恢复继续使用项目现有的准备计划与重启应用流程。
