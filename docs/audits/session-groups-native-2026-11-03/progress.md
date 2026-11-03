# SDD ledger — plan: docs/superpowers/plans/2026-11-03-native-session-groups.md

用户已批准上一轮设计并要求直接执行。生产基线 HEAD 863bfdb3；当前用户已有 6892 个删除项和 .DS_Store 修改，均保留。

Ruling: 在用户当前 checkout 完成交付，使用冻结源码与临时夹具隔离构建/验证，不另切运行环境、不提交用户既有改动 — 用户环境保留要求及当前工作区基线优先。

Ruling: 按互不重叠文件/方法并行实现，再独立交叉复核 — 开发者要求主动并行，Adapter 调度区由父任务唯一负责。

| 任务/接口 | 检查与归属 |
|---|---|
| 1 原生模型与协调器 | reference_audit；共享 API 兼容历史冻结源，新完整源 scope 明确返回安全状态 |
| 2 主列表与桥接 | groups_audit；只写指定六文件，调度方法保留给父任务 |
| 3 面板与调度 | root；消费 Task 1 scope，且面板实际调用根据 BOOL 判定结果 |
| 4 验证 | privacy_audit 负责可复跑夹具；root 负责隔离构建、结果与交付 |
| 1→2 / 1→3 | scope 签名已协调；Forward 产物必须 scope 内物化 |
| 2↔3 | Adapter 调度方法及新增状态字段由 root 写；其余集成由 groups_audit 写 |
| 1/2/3→4 | 验证必须编译本轮当前生产源码，不沿用历史通过数 |

Task 1: complete
Task 2: complete
Task 3: complete
Task 4: complete


## 完成证据

- 独立审查复现并关闭发布 setter 重入丢事件；新增 publication 版本与最多 3 次自动恢复，预算前校验账号/epoch/manager，真实 off-main 事件可恢复预算。
- 未读面板失败保持遮罩且拒绝排队打开回调；完整源恢复后的同步通知变化再次后验验证；Adapter 发布中新增隐私请求保留。
- 五套现有核心检查本轮最终源码重跑：23 + 180 + 136 + 8 + 46，全部通过。Tests 仅从固定起点提交导出到临时目录。
- 当前生产行为夹具及哈希见 validation/behavior-result.json；构建输入与其交叉校验见 delivery-verification.json。
- 最终 rootless/rootful 冻结构建通过；均含 arm64/arm64e，包元数据及 dSYM UUID 核对通过；inputs_unchanged 与 historical_packages_preserved 均为 true。
- 最终包目录：packages/2.2-6-native-groups-2026-11-03-final。早一轮候选保留，不能代替最终包。
- 当前既有 6,892 删除项保留，无设备安装、账号/数据库访问、版本变更、分支切换或提交。真机私有接口、同步表事务、首帧与性能仍待实际验收。
