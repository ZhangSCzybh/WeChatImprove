# 2.2-19 实际交付代码核验

结果：5 个 getter × rootful/rootless × arm64/arm64e，共 **20/20** 组实际 object 与最终包内代码一致，均为 `mov w0,#1; ret`（返回 BOOL YES）。

取证链：绿色测试快照源 SHA = 当前源 SHA = 隔离构建源 SHA；构建记录里的 object SHA = 实际 object SHA；交付 deb SHA = 其已抽取 fat dylib 对应的构建记录；fat 每个 slice 的原始字节 SHA = 被反汇编 thin dylib SHA；thin UUID = dSYM UUID；dSYM 文件字节与交付 symbols.zip 内条目一致；dSYM 的精确 Objective-C 方法符号提供最终地址，在最终 thin dylib 对应地址的 8 字节窗口核对指令。重签注入用 dylib 与 rootful deb 内 fat dylib 字节相同。

这不是 selector 字符串检查。最终 stripped dylib 的方法地址来自 UUID 匹配的 dSYM 符号，然后读取实际最终代码；完整命令在 `commands.json`，每组有 `*-object.asm` 与 `*-final.asm`。

| scheme | CPU | 方法所属类 | 最终地址 | 指令 |
|---|---|---|---|---|
| rootless | arm64 | CSSettingsTableViewController | `0x1cde9c` | `mov w0,#1; ret` |
| rootless | arm64 | CSAIConnectionEditor | `0x6ab78` | `mov w0,#1; ret` |
| rootless | arm64 | CSAIPresetEditor | `0x6be04` | `mov w0,#1; ret` |
| rootless | arm64 | CSScheduledTaskTextEditor | `0x1ba8e8` | `mov w0,#1; ret` |
| rootless | arm64 | CSScheduledTaskTimeEditor | `0x1bb104` | `mov w0,#1; ret` |
| rootless | arm64e | CSSettingsTableViewController | `0x1e6438` | `mov w0,#1; ret` |
| rootless | arm64e | CSAIConnectionEditor | `0x72298` | `mov w0,#1; ret` |
| rootless | arm64e | CSAIPresetEditor | `0x735c0` | `mov w0,#1; ret` |
| rootless | arm64e | CSScheduledTaskTextEditor | `0x1d1a3c` | `mov w0,#1; ret` |
| rootless | arm64e | CSScheduledTaskTimeEditor | `0x1d22bc` | `mov w0,#1; ret` |
| rootful | arm64 | CSSettingsTableViewController | `0x1cde9c` | `mov w0,#1; ret` |
| rootful | arm64 | CSAIConnectionEditor | `0x6ab78` | `mov w0,#1; ret` |
| rootful | arm64 | CSAIPresetEditor | `0x6be04` | `mov w0,#1; ret` |
| rootful | arm64 | CSScheduledTaskTextEditor | `0x1ba8e8` | `mov w0,#1; ret` |
| rootful | arm64 | CSScheduledTaskTimeEditor | `0x1bb104` | `mov w0,#1; ret` |
| rootful | arm64e | CSSettingsTableViewController | `0x1e6438` | `mov w0,#1; ret` |
| rootful | arm64e | CSAIConnectionEditor | `0x72298` | `mov w0,#1; ret` |
| rootful | arm64e | CSAIPresetEditor | `0x735c0` | `mov w0,#1; ret` |
| rootful | arm64e | CSScheduledTaskTextEditor | `0x1d1a3c` | `mov w0,#1; ret` |
| rootful | arm64e | CSScheduledTaskTimeEditor | `0x1d22bc` | `mov w0,#1; ret` |

源文件 SHA256：

- `Controllers/CSSettingsTableViewController.m`：`f9848ca17c2bb9c325994040b434e5aff4e9fc2020aaabcf87f520e23974f03e`
- `Controllers/CSAIReplySettingsViewController.m`：`d95767accc0059060eb053d502b39d91a3426f741663642863dd39c425dfa2b2`
- `Controllers/CSScheduledTaskSettingsViewController.m`：`b4a7989995420b1e0f0e66bfe4928bb45d7cbe7b5309087d205813dcde496315`

限制：仅证明实际交付文件里含正确生产实现及其精确机器码。Objective-C 真机动态分派、微信实际转场、live MMTabBar 的 hidden/alpha/superview/frame/window、四 tab 切换、主界面样式恢复、视觉或点击效果全部 **未验证**。不将主机模型或静态反汇编冒充设备日志。

重跑：`python3 docs/audits/release-2.2-19-settings-subpage-tabbar/packed-fix-verification/verify.py`。脚本只读取生产/包/构建文件，输出本目录证据，不修改生产源、夹具或历史审计。
