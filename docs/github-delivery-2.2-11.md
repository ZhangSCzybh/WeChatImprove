# GitHub 交付范围：2.2-11

本次提交包含聊天分组原生模型与兼容路径的改造、性能优化、滚动位置修复及生产代码清理；当前正式版本为 2.2-11。生产源码和最新 Rootless/Rootful 安装包、独立调试符号与 2026-11-03 本地封存交付的 SHA-256 一致。

功能验证为 4052 项核心回归与 199 项位置回归，共 4251 项不同功能断言；16 个负对照捕获预期行为失败。另有 69 项可选接口安装断言和两种架构的 SDK 检查。真机显示和滚动体验仍待安装验收，本次没有新增 Instruments 测量。

仓库保存开发说明、源码基线、测试夹具与脚本、结果和聚合报告。两轮 Instruments 的完整本地采样包括 `.trace`、导出 XML、设备/进程快照与附加诊断；这些体积较大且可能包含设备信息，继续保留本地。GitHub 中的 Instruments 内容为经过检查的分析汇总、操作时间线和脚本。

各 audit 的封存清单描述完整本地归档，可能列出没有上传的原始采样、生成的主机可执行文件或工作区状态快照；它不是 GitHub 子集的独立完整性声明。复核原始数据、运行依赖完整本地归档的历史保护脚本时，需使用原归档。新安装包的 SHA256SUMS 可直接核对仓库中的交付文件。

本次仅上传最新 `packages/2.2-11-session-groups-scroll-position-final/` 正式交付；历史候选和观测安装包继续保留本地。此前工作区已有的大批历史文件删除，以及 Finder 缓存、Python 缓存，不纳入本次提交。

主要入口：

- [当前功能与使用说明](../README.md)
- [2.2-11 修复、清理与交付记录](audits/session-groups-scroll-position-2026-11-03/README.md)
- [2.2-11 实际验证范围](audits/session-groups-scroll-position-2026-11-03/validation/README.md)
- [2.2-9 四场景采样对比](audits/session-groups-instruments-2.2-9-2026-11-03/comparison/version-comparison.md)
- [最新正式安装包与校验](../packages/2.2-11-session-groups-scroll-position-final/)
