# 调试日志与历史代码清理 · 2026-10-28

本次按用户确认的清单，依次清理日志、无入口代码、旧系统分支及历史测试文件。改动直接位于既定 checkout `/Users/zhangshichao/Documents/Workspace/WeChatImprove`，基线提交为 `7ff8a17d`，版本保持 `2.1-4`。

## 清理结果

- 编译源码中的 `NSLog` 从 67 处降至 43 处；移除授权正常路径、录屏事件、选择器排查与设置页完整堆栈输出。保留仍有用途的失败诊断。语音转发异常仅记录异常类型，不再输出原始会话 ID 和异常原因。
- 删除无项目调用的 `CSChatRoomSelectViewController.{h,m}` 和 `CSTimeLineTailSettingsViewController.{h,m}`。现用原生选择器保留；朋友圈后缀的 `WCUploadTaskHook.xm`、两个配置键及备份注册均未改变。
- 删除授权管理中无入口的 `openBrandProfileWithContact:fromViewController:`、`openBrandProfileWithBizUtil:`、`searchOfficialAccount` 三个方法。现用 TingRouter → profile URL → 备用 URL 的失败回退顺序保留。
- 按最低 iOS 15 目标精简 37 处 iOS 10/13/14/15 版本判断，仅保留支持范围内原本执行的分支。保留局部变量作用域、深浅色、Scene/窗口、图标替代、状态栏高度和 sheet 对象存在性检查；消除一处深浅色两边赋同值的冗余判断。
- 删除 6 个无现行入口的历史测试/副本：`Tests/CSReleaseNotesViewController.m`、`extract-feature-contracts.py`、`FeatureDrawingDouble.{h,m}`、`LegacyMessageTimeFormat.h`、`ListCornerConfigurationTests.m`。
- 删除旧圆角测试前，将仍有意义的持久化数值、六配色透明/仅 alpha、主题与只读边界迁入现行 `ListCornerSemanticsTests.m`，现行回归增加 266 条断言，使用局部内存 defaults。
- 删除空 npm 锁文件 `package-lock.json` 和未引用的 0 字节 `log.txt`。

源码、测试和两个辅助文件合计涉及 32 个文件，其中删除 12 个文件；新增 129 行、删除 1506 行，净减少 1377 行。此统计不包含本审计目录。生产编译单元从 204 个降为 202 个。

## 验证

19 个相关验证脚本最终全部通过，原生选择器分别执行定时任务与分组选人模式。各脚本的完整输出见下表；它们使用测试替身、内存或临时测试存储，不向真实会话发消息。

| 验证脚本 | 结果 | 证据 |
| --- | --- | --- |
| `verify-authorization-read.sh` | 67 checks | [日志](logs/phase1-authorization-read.log) |
| `verify-plugin-framework.sh` | 21 entry + 25 startup integration checks | [日志](logs/phase3-plugin-framework.log) |
| `verify-touch-trail.sh` | 10015 checks | [日志](logs/phase1-touch-trail.log) |
| `verify-native-contact-picker.sh` | 278 scheduled-picker checks; group mode separately 609 checks | [日志](logs/phase1-scheduled-picker.log) |
| `verify-backup-registry.sh` | 1404 assertions | [日志](logs/backup-registry.log) |
| `verify-navigation-images.sh` | 131 checks | [日志](logs/phase3-navigation-images.log) |
| `verify-managed-image-files.sh` | 125 deletion + 29 cleanup checks | [日志](logs/phase3-managed-image-files.log) |
| `verify-payment-core.sh` | 2215 core + 528 automation checks | [日志](logs/phase3-payment-core.log) |
| `verify-close-friend-entry.sh` | 45 entry + 26 gesture checks | [日志](logs/phase3-close-friend-entry.log) |
| `verify-avatar-input-style.sh` | 139 checks | [日志](logs/phase3-avatar-input-style.log) |
| `verify-message-time.sh` | 142 checks | [日志](logs/phase3-message-time.log) |
| `verify-message-actions-execution.sh` | 2578 checks | [日志](logs/phase1-message-actions-execution.log) |
| `verify-list-corners.sh` | 1623 checks, 0 failures | [日志](logs/phase4-list-corners.log) |
| `verify-bubble-style.sh` | 36979 policy/renderer + 2547 adapter checks | [日志](logs/phase4-bubble-style.log) |
| `verify-revoke-interception.sh` | 73 checks | [日志](logs/phase4-revoke-interception.log) |
| `verify-backup-bootstrap.sh` | 36 checks; 35 gated features, 8 independent adapters, 2 recovery hooks; all generated iOS hooks syntax + C linkage | [日志](logs/phase4-backup-bootstrap-rerun.log) |
| `verify-backup-transactions.sh` | 89 checks | [日志](logs/phase4-backup-transactions.log) |
| `verify-scheduled-tasks.sh` | 102 checks | [日志](logs/phase4-scheduled-tasks.log) |
| `verify-group-preferences.sh` | 23 checks, 0 failures | [日志](logs/phase4-group-preferences.log) |

[分组选人模式日志](logs/group-picker.log)；[完整命令与结果](verification.json)。

本次额外修复一处既有验证误报：`verify-backup-bootstrap.sh` 原来要求 `CSBackupWhenReady(^{` 后必须为空格或换行，因此不接受现有 AI Hook 的紧凑写法。已通过与 HEAD 逐字节比较确认 Hook 和原脚本均未被清理改动，旧检查仍失败；现改为识别可选空白，保留初始化前不得安装 Hook 的检查。重跑通过：35 个受启动门控制的功能文件、8 个独立原生适配、2 个恢复基础文件，全部生成 Hook 通过 iOS arm64 语法编译，C 符号链接验证通过。失败原始日志及[基线复现](bootstrap-baseline-reproduction.json)保留供复核。

## 完整构建与产物核对

Rootless 与 Rootful 都完成完整构建、合并、签名及打包，均包含 `arm64` / `arm64e`，最低 iOS 15。构建命令将 `_THEOS_LOCAL_DATA_DIR`、`THEOS_BUILD_DIR` 和 `THEOS_PACKAGE_DIR` 全部指定到独立临时目录，未运行 clean/install。

- [Rootless 构建日志](logs/build-rootless.log)
- [Rootful 构建日志](logs/build-rootful.log)
- [安装包元数据、SHA-256 与内容核对](package-verification.json)

安装包中的两个旧页面类名及三个已删除方法名均不再出现；原生选择器、备份引擎/审计、AI 管理器与朋友圈后缀配置名仍存在。构建保留已有 `UILocalNotification`、`statusBarFrame` 和链接器 `-multiply_defined` 弃用提示，没有构建错误；本次不改动仍用于兼容回退的 API。

临时验证包：

- `/tmp/wechatimprove-cleanup-20261028.JiJFSd/packages/com.wechat.improve_2.1-4_iphoneos-arm64.deb`
- `/tmp/wechatimprove-cleanup-20261028.JiJFSd/packages/com.wechat.improve_2.1-4_iphoneos-arm.deb`

## 环境与验证边界

原 `.theos/` 与 `packages/` 的 1242 个文件已在构建前后比较路径集合及 SHA-256，全部一致。备份审计、恢复引擎、`checkpoint` 测试注入点、插件存储迁移、后缀 Hook/配置键、版本、注入过滤和打包方案配置均保持原样。

当前项目是注入插件，本次没有切换前后端服务、端口或真实数据库，也没有安装到手机。源码已在原 checkout 更新；已有安装包保留原内容，独立临时包只用于本次构建验证。主机回归、iOS 编译和源码独立审查没有发现功能回归，真机显示和实际宿主运行仍需使用清理后的包验收。
