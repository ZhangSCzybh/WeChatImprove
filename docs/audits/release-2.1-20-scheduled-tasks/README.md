# WeChatImprove 2.1-20：定时任务时间段与左滑操作

日期：2026-10-30。基于当前 2.1-19 工作树中已完成的时间段规则与列表左滑操作，更新版本和内容说明，并编译 rootful／rootless 双包。本轮未再改变定时任务实现，五个 Store／Manager／Settings 文件与左滑功能交付时逐字节一致。未安装到设备、未发送真实消息、未提交 GitHub。

## 本版内容与入口

- 插件设置 → 功能增强 → 定时任务 → 新建／编辑 → 时间规则 → 时间段内执行：每天、周一至周五或指定星期，开始到结束之间每 N 分钟／每 N 小时执行，支持跨午夜。包含开始、不包含结束，星期归属开始日，每个时段从开始重排；结束后不补发。
- 任务列表左滑：已启用显示“停止”，已停用显示“启用”，保留删除与原有全滑删除。启用单项不打开总开关；停止通过现有保存路径取消尚未交给微信的执行，已提交消息无法撤回。
- 保留原有单次／分钟／小时／每天／每周规则；窗口定义纳入账号备份，恢复总开关保持关闭。继续使用最近到期的一次性定时器。系统挂起、强退或关机仍无法保证准点执行。

## 版本与改动留档

`control`、`Headers/CSUserInfoHelper.h` 的 `kPluginVersionString`、`CSReleaseNotesViewController` 的当前版本说明统一为 2.1-20。README 的当前版本、包链接及说明同步更新；功能文档更新版本并移除尚未发布表述。

相对已提交 2.1-19 的 15 个项目文件（含此前完成的功能实现）及前后 SHA256 见 [change-manifest.json](change-manifest.json)。本次版本更新前的 5 个元数据／文档副本见 [baseline/manifest.json](baseline/manifest.json)。功能实现证据见 [时间段审计](../scheduled-window-2026-10-30/README.md) 与 [左滑审计](../scheduled-task-swipes-2026-10-30/README.md)；历史审计不改写。

## 聚焦回归

| 范围 | 通过项数 | 日志 |
| --- | ---: | --- |
| `bash Tests/verify-scheduled-tasks.sh` | 387 | [scheduled-tasks.log](scheduled-tasks.log) |
| `bash Tests/verify-scheduled-task-manager.sh` | 2360 | [scheduled-task-manager.log](scheduled-task-manager.log) |
| `bash Tests/verify-scheduled-task-backup.sh` | 505 | [scheduled-task-backup.log](scheduled-task-backup.log) |
| `bash Tests/verify-scheduled-task-swipes.sh` | 165 | [scheduled-task-swipes.log](scheduled-task-swipes.log) |
| `bash Tests/verify-close-friend-automation.sh` | 187 | [close-friend-automation.log](close-friend-automation.log) |
| `CS_TEST_SCHEDULED_PICKER=1 bash Tests/verify-native-contact-picker.sh` | 278 | [scheduled-picker-presentation.log](scheduled-picker-presentation.log) |

六组共 3,882 项全部通过，退出码均为 0，测试编译无警告。使用临时任务库、隔离 defaults suite 和原生替身；没有访问真实账号或发送消息。覆盖时间边界、跨午夜、DST、窗口外不补发、异步发送边界、停止已领取单次任务、旧菜单身份／隐私保护及备份恢复。没有全量扩测。

## 构建及包校验

运行 [build-packages.py](build-packages.py)，两个方案在独立临时目录完整构建，均 exit 0，每个方案仍为 6 条警告。与 2.1-17 的 6 条基线一致，也与 2.1-19 的具体警告类型一致：UILocalNotification 弃用、statusBarFrame 弃用、链接器 -multiply_defined 过时，各双架构一次。此次改动无新增警告。日志见 [rootful](build-rootful.log)、[rootless](build-rootless.log)。

包版本均为 2.1-20；两个包内均包含 arm64／arm64e，最低 iOS 15.0。安装路径、filter、staging／payload 哈希、定时任务与既有功能符号均通过核验。四个 dSYM 与对应二进制 UUID 一致，symbols ZIP CRC 检查通过。完整数据见 [package-verification.json](package-verification.json)。

| 方案 | 动态库路径 | 架构 → UUID |
| --- | --- | --- |
| rootless | `/var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib` | arm64: `A8F2962A-E458-3172-9677-FFE329D6B9A7`<br>arm64e: `C145FFDA-59D2-3548-93DD-48E84F019B10` |
| rootful | `/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib` | arm64: `B9591941-334F-3D2A-A534-B34D375F5FCC`<br>arm64e: `A29737B7-570D-36C4-8EE7-D2914D7EE321` |

| 产物 | 字节数 | SHA256 |
| --- | ---: | --- |
| [com.wechat.improve_2.1-20_iphoneos-arm.deb](../../../packages/2.1-20-scheduled-tasks/com.wechat.improve_2.1-20_iphoneos-arm.deb) | 1533174 | `c65da67d63067e88c677443a02e619778f624679ab3038575a7375f1a90ab2cd` |
| [com.wechat.improve_2.1-20_iphoneos-arm64.deb](../../../packages/2.1-20-scheduled-tasks/com.wechat.improve_2.1-20_iphoneos-arm64.deb) | 1531676 | `acc01940d66b0e5179d07e7d1524832e47a438f240e81c8014a93ee21b28be45` |
| [com.wechat.improve_2.1-20_symbols.zip](../../../packages/2.1-20-scheduled-tasks/com.wechat.improve_2.1-20_symbols.zip) | 11123576 | `e7784669f8064d143409dde0bc94824ce6994b26bfc8f16902f06616617a8048` |

[SHA256SUMS](../../../packages/2.1-20-scheduled-tasks/SHA256SUMS) 与双包／symbols 位于新目录 `packages/2.1-20-scheduled-tasks/`。未运行 make clean；原有 .theos 与 packages 共 1,279 个文件路径和 SHA256 均保留，最终再次复核通过。构建前后生产输入哈希一致。

校验脚本首次把中文常量假定为 UTF-8，导致内容断言失败；实际 Mach-O 的 Objective-C 中文常量存于 UTF-16LE 的 __ustring。按两种存储编码检查后通过，没有改源码或重编包。具体证据见 [编码核对](package-verifier-encoding-correction.json)。

## 真机验收步骤

1. 安装与注入环境匹配的包，退出并重新打开微信，在插件“关于 → 版本信息”核对 2.1-20 与两条更新说明。
2. 用文件传输助手创建每天短时段、每 1 分钟的任务；确认开始包含、结束排除、下次执行显示及任务保存。检查指定星期、跨午夜和小时单位；起止相同应拒绝保存。
3. 时间段内／结束后分别回前台，确认按原补发规则最多处理最近一次，结束后不补发；总开关关闭再开不补发积压。
4. 列表左滑确认启用、停止、删除及全滑删除；总开关关闭时只启用单项仍不发送。停止后未提交任务应取消；已提交微信的消息仍可能发出。检查深浅色、长标题、菜单收起。
5. 编辑、重启、切账号、密友锁定后重新操作旧菜单，确认不串任务或泄露受保护列表；同账号备份恢复保留时间段定义，总开关关闭。

主机回归与双包编译不等同于真机交互、微信私有接口及后台调度验收；本轮未连接设备，也未自动安装。最终核对见 [final-verification.json](final-verification.json)。
