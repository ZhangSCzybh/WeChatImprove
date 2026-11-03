# ThemeBox 聊天分组对比：证据索引

主报告：`../themebox-chat-groups-comparison-2026-11-02.md`。

- `provenance.json`：二进制路径、SHA-256、项目 HEAD 和已检查核心源文件的哈希。
- `native-metadata.json`：REA 记录 `ev_53c9987d7697f5de00238e681579c34ffc3ed2b4ac2691d461a807f4f1617516` 中三个分组核心类的元数据摘录；包含原记录覆盖说明，不是完整导出的替代品。
- `static-findings.md`：分组模型、预设、配置、完整会话源和计数/节流边界，含可从原二进制复核的显式 XOR 示例。
- `hook-analysis.md`：Hook 注册类名、selector、原 IMP 和 replacement 绑定，及数组覆盖行为。
- `selected-methods.txt`：相关 Objective-C 方法与地址。
- `manager-selectors.txt`、`hook-selectors.txt`：重点区间的 selector 引用；引用位置可能是加载 selref 的指令，实际发送消息 PC 以 hook-analysis.md 和汇编为准。
- `instruction-excerpts.txt`：关键 ARM64 指令区间。取自 `xcrun llvm-objdump`，是有限范围的摘录，不代表完整控制流。自动附带的最近符号标签不等于函数身份。

原始 dylib 没有复制到仓库。完整 REA export 和更大范围的辅助反汇编位于分析时的 `/tmp`，可能被系统清理；上列文件已将本报告需要的证据保存在项目中。静态 findings 中 `/tmp/themebox-static-*` 路径记录产生证据时的位置，阅读交付物时优先使用此目录的对应摘录。

没有执行、加载或注入目标，没有操作微信账号、设置、聊天数据库或正在运行的服务。Ghidra 完整分析超时，没有采用未完成的伪代码结果。精确提醒公式、所有筛重分支、300ms 门控的事件保留和运行时性能尚未验证。
