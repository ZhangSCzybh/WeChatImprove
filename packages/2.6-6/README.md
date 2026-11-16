# 2.6-6 完整版

发布日期：2026-11-16。基于当前 `2.6-6-beta04` 完整工作区修复，包含 beta01 至 beta03 的后台运行优化、beta04 的朋友圈未读和互动修复，以及既有全部功能。当前用户环境为 **Rootless**，使用下方 Rootless 主安装包。

| 产物 | 内容 |
| --- | --- |
| [Rootless 安装包](com.wechat.improve_2.6-6_iphoneos-arm64.deb) | `iphoneos-arm64`；安装至 `/var/jb/Library/MobileSubstrate/DynamicLibraries/` |
| [Rootful 安装包](com.wechat.improve_2.6-6_iphoneos-arm.deb) | `iphoneos-arm`；安装至 `/Library/MobileSubstrate/DynamicLibraries/` |
| [重签用动态库](WeChatImprove.dylib) | 与本版 Rootful 包内动态库逐字节一致 |
| [调试符号](symbols.zip) | 两方案各含 arm64 / arm64e dSYM，共四份 |
| [SHA256 校验清单](SHA256SUMS) | 两个 deb、独立动态库与符号附件的校验值 |

两个安装包均包含 **arm64 + arm64e，最低编译目标 iOS 15.0**。Debian 元数据、插件显示版本和内置更新说明均为正式版本 `2.6-6`。

## 本次修复

**后台运行设置图标错位**：旧实现对 UIKit 内置 `UITableViewCell.imageView` 添加固定约束，UIKit 在布局和复用时仍会调整该视图，造成位置争用。共享设置单元格改用私有图片视图，由自身约束统一控制左边距、尺寸和垂直居中；保留原有文字和右侧控件布局。其他共用设置页面一并受益。

**系统到期时间图标缺失**：旧图标名 `exclamationmark.clock` 未能返回图片，改用基础符号 `hourglass`。非空系统图标名称查找失败时显示 `questionmark.circle` 作为兜底；有意不设置图标的行仍保持无图标。

**图片和控件复用清理**：自定义图片继续按比例显示，系统图标保留设定颜色；切换至无图标或准备复用时，清理图片、颜色、显示模式和可见状态。直接重新配置同一单元格时，移除旧开关并清理排序状态，避免控件叠加或上一行状态残留；复用恢复默认选中样式。

本版累积保留 beta04 的普通朋友圈消息精确已读、隐藏密友未读保留、提示统一、删除认证和加载更多修复，以及 beta01 至 beta03 的后台开销优化。相对 beta04，业务生产逻辑变更仅在共享设置单元格与后台设置页的图标定义，其余变更为测试、版本和说明。

## 聚焦核心回归

| 检查 | 实际结果 |
| --- | --- |
| `bash Tests/verify-setting-cell-layout.sh` | **101 项通过，0 失败**；原样执行生产 cell、模型和后台摘要方法，覆盖原生图片视图布局干扰、44–112 点行高、图片切换、复用、重复开关配置、普通／输入／操作／展开／排序类型切换及到期图标映射 |
| 同一图标回归读取 beta04 冻结源码 | 编译并运行成功后，**51 条断言按预期失败**，退出码 1；能够检出旧布局、图标定义和控件复用问题 |
| `bash Tests/verify-background-run-view-refresh.sh` | **30 项通过**；保留页面可见刷新、通知合并和离屏保护 |
| `bash Tests/verify-close-friend-interactions.sh` | **46 项通过**；保留 beta04 生产互动 Hook 的已读、隐藏保留、账号／策略边界、认证、提示和原生分页行为 |
| 本次两个产品文件 iOS 严格语法检查 | arm64 / arm64e 全部通过，`-Werror` 下零诊断；最终单元格补测覆盖最后一次状态清理改动 |
| Rootless / Rootful 完整编译打包 | 均成功；两方案各含 arm64 / arm64e |

图标回归使用 macOS Foundation 与轻量 UIKit 替身，验证实际生产配置、复用方法和约束所有权，不执行 iOS UIKit 的真实布局引擎。主机 AppKit 实际查找 `hourglass`、`questionmark.circle` 成功，旧 `exclamationmark.clock` 失败；这与 iOS 真机资产验收区分记录。未重复运行未改动的后台运行管理器、音频和 AI 全量回归，历史验证见各 beta 发布记录。

## 构建和产物核验

从当前工作区冻结 **42,940 个输入文件**到 `.theos/release-2.6-6/source/`，包含工作区已有未提交的累积修复。相对 beta04 冻结输入，共修改 6 个文件、新增 4 个测试文件，无删除。Rootless 和 Rootful 使用同一完整快照与各自全新缓存构建，分别约 **18.5 秒、17.5 秒**。

实际核验通过：Debian 版本和架构、安装路径、载荷和注入 plist、两个 CPU slices、最低系统版本、Rootless RPATH、逐架构 CodeDirectory SHA1/SHA256 页面与特殊槽哈希、四份 dSYM UUID、符号 ZIP CRC／内容哈希、独立 dylib 与 Rootful 载荷一致性、全部交付附件 SHA256。确认本次 UI 文件及保留的朋友圈两个适配器在两方案、两架构均重新编译。

冻结源码和当前工作区的 **42,940 个输入**一致。构建前后 **23,145 个历史文件**保持 SHA256、大小和修改时间一致，包括 59 个历史 packages 文件。两方案各有 8 条既有工程警告，规范化后与 beta04 完全一致，无新增警告。

构建入口为 `.theos/release-2.6-6/build_release.py`，真实命令和耗时见该目录中的 `build-results.json`。核心回归见 `core-tests.json`，冻结来源和差异见 `source-freeze.json`、`formal-release-changes.patch`，产物核验见 `validation.json`，工作区一致性见 `workspace-source-verification.json`，警告对照见 `warnings-comparison.json`。

## 手机验收范围

本次完成主机回归、完整编译和产物核验，尚未安装到手机。未启动或修改用户微信进程、账号、配置或数据库，历史包继续保留。

在原 Rootless 环境重点查看后台运行设置页：首次打开、上下滚动、状态刷新、离开再进入、前后台切换后，图标保持同列并在行内居中；无记录、未到期和已到期状态下，“系统到期时间”均显示沙漏。抽查其他设置页的开关、自定义图片与排序显示。朋友圈普通未读一次阅读后消失、隐藏密友仍保留未读的手机验收要求继续保留。
