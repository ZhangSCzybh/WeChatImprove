# 2.2-18 基线失败豁免延续

本轮授权来源是用户的 2.2-18 任务原文，留档于 `docs/feedbacks/2026-11-06-settings-return-header-gap-jump.txt`。原文要求：

> 那 18 个基线失败仍然豁免，规则不变：`REGRESSION-GATE` 的计数不许改、新版本继续沿用 `WAIVER.md` 的豁免清单，且**除这 18 个之外出现任何新失败就停下来报告**。

本目录 `WAIVER.md` 与 2.2-17 原件逐字节相同，继续限定在其中 18 个脚本。原始 100 个脚本中 18 个仍未通过，本轮按用户授权豁免。16 个属于 `existing_fixture_compile_incompatibility`，2 个属于 `existing_extractor_contract_incompatibility`；原头像手势断言冲突是其中一个脚本的补充诊断，不是第 19 项豁免。

`REGRESSION-GATE.json` 延续原始 `script_count=100`、`passed=82`、`failed=18`、100 条 runs、18 条 failures 以及所有退出码/诊断；只更新发布状态和授权出处元数据。其历史日志路径以 `inherited_evidence_base` 指向的 2.2-17 审计目录为根。本轮复跑结果另写 `release-core-revalidation/result.json`，不得把旧的 18 失败改写成通过。原 `REGRESSION-GATE.md` 原字节保留。

本轮状态：`waived_by_user_explicit_authorization; 18 baseline failures accepted for 2.2-18 by continued waiver`。它不表示 pass、green 或 all-clear。七项核心、其他 82 脚本及本轮新增视觉缺陷测试仍必须通过；任何新失败停止出包。

授权原文 SHA256：`275025fc34a6792e9965421b8eaae77e9596811689a18f090230ec0728ee5ed6`。
