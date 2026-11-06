# 近期生产代码清理审查

检查对象是基于 a227b167 的 2.2-13～2.2-19 待提交改动及四个新增源文件。检查新增日志、性能埋点、调试开关、静态函数引用和功能调用链。

- 新增实现没有 NSLog、os_log、os_signpost 或临时调试计时输出；此前分组 CPU 观测代码已不在当前 Controllers/Hooks 中。
- 改动中的 static 函数均有调用；没有发现可证明无用的新增实现。
- Makefile 保持 DEBUG=0、FINALPACKAGE=1。
- CS_BUBBLE_TESTING、CS_MERGE_TESTING、CSCF_CALL_REPLY_TESTING 是主机测试编译分支，正式构建不启用。保留这些测试入口与原断言。
- 现存错误日志用于读取、注册或异常诊断；未把它们当作无用调试输出批量删除。

结论：不删除近期业务实现。签名解析、未知版本回退、8.0.80 适配、原生导航属性、密友授权及重置中断保护均保留。2.2-20 的生产文件只同步版本宏和应用内发布说明；control 和 README 同步交付信息。文档归档与仓库忽略规则不参与 dylib 的业务逻辑。

根 Tests 目录在任务开始前已缺失。用户明确选择“恢复测试文件并保留测试套件”，本轮用 git archive HEAD Tests 恢复 277 个原始文件，没有修改断言或夹具。恢复来源与操作另见 test-restoration.json。
