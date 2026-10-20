# 1.8-38：备份与恢复预览界面整理

本次按用户确认的范围调整 **备份配置和恢复预览**。版本 1.8-38，已完成核心回归与 Rootless arm64/arm64e 构建，未安装手机。没有可用 iOS Simulator runtime，因此没有声称完成真机或模拟器的视觉验收。

## 页面变化

- 备份页改为「状态摘要 → 保存当前配置 → 本机备份 → 恢复与维护」。创建、导入、自动备份有独立说明；备份行统一名称、日期、类型、容量和收藏标识。空列表有明确提示。
- 取消计划、重试和修复放入可展开的维护组，普通浏览时收起；读取异常或启动恢复等待时自动展开。原操作及保护条件继续由原 manager/engine 执行。
- 恢复预览将备份摘要、警告、模块选择、账号范围和变更明细分开。模块/账号使用统一的圆形勾选标识，显示已选数量；布尔差异显示「开启 / 关闭」，删除状态独立标识。
- 两页使用原生 Inset Grouped 列表和 UIListContentConfiguration，统一 16pt 水平内容留白、正文/说明间距、图标尺寸及颜色。自动行高支持长名称换行，字体采用系统 Dynamic Type，颜色跟随浅色/深色。选择项补充 VoiceOver 的选中状态。

本次既有运行页面仅修改 `CSBackupSettingsViewController.m`、`CSBackupPreviewViewController.m`，增加局部展示助手 `CSSettingsAppearance.h/.m`；其余为版本和说明更新。插件首页、通用设置单元格、重置入口及备份核心均与本轮开始时逐字节一致。重置进入的共享预览页面会使用此次新样式。

## 聚焦核心的验证

| 检查 | 结果 |
| --- | --- |
| 新展示助手与两个页面的 iOS arm64 语法检查 | 通过，启用 `-Werror` |
| `verify-backup-engine.sh` | 22 项通过 |
| `verify-backup-transactions.sh` | 89 项通过 |
| Rootless arm64 / arm64e 构建 | 通过 |
| 包版本、架构、注入过滤、二进制和 dSYM UUID | 匹配 |
| 变更范围、历史包哈希与 `git diff --check` | 通过 |

本轮只运行上述 **2 组、111 项核心测试**，没有重新运行与展示调整无关的全项目矩阵。测试在临时目录和独立偏好域执行。备份格式、登记表、存储、账号校验、自动调度、启动屏障及恢复事务没有改动；原 1.8-37 全套结果仍属于该轮历史证据。

手工复核了重排后的入口映射：创建、导入、开关、空列表、备份操作菜单、维护组展开/收起、取消/重试/修复，以及模块/账号选择与准备按钮的异步禁用。此项为源码复核，不等同于设备点击验证。核心输出见 [测试结果](test-results.json)、[引擎日志](verify-backup-engine.log)、[事务日志](verify-backup-transactions.log)。

构建使用独立目录，见 [构建路径](build-path.json) 和 [构建日志](build.log)，未执行 `make clean`。新页面无编译警告；日志中既有授权模块 `openURL:`、红包模块 `statusBarFrame` 及链接器过时选项警告未在此视觉任务扩展处理。

## 产物与保留

- [com.wechat.improve_1.8-38_iphoneos-arm64.deb](../../../packages/com.wechat.improve_1.8-38_iphoneos-arm64.deb) — SHA-256 `0f08e9a863e835ace7227ce27cff647648859dc8728d1d9d58bced97f68eeed5`
- [WeChatImprove-1.8-38-dSYMs.zip](../../../packages/WeChatImprove-1.8-38-dSYMs.zip) — SHA-256 `b97029d1eb070c86b05f04fd7a55e6ccc22ddc485ccedbe1230770841c68ce91`

arm64 UUID：`05917416-1E75-31E9-BD41-36901420DFB5`；arm64e UUID：`8835FA64-4555-3F30-8A11-1359207B3F62`。完整核对见 [verification.json](verification.json)，编译时源码哈希见 [source-hashes.json](source-hashes.json)。

本轮基线记录的 287 个既有源文件及历史产物保持哈希一致，既有变化仅为两个页面及四个版本/说明文件；原工作区与历史安装包保留。没有切换服务、读取真实微信数据、安装、提交或推送。

真机仍需查看小屏/大字体下的长备份名称、深色模式、展开维护组、选择模块/账号与系统文件分享的最终外观。此次没有为视觉验收下载模拟器系统或启动替代环境。
