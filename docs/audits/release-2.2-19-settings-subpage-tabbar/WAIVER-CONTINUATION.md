# 2.2-19 基线失败豁免延续

本轮授权来源是用户的 2.2-19 任务原文，留档于 `docs/feedbacks/2026-11-06-settings-subpage-tabbar-leak.txt`。原文要求：

> 原有 100 个 verify 脚本中 18 个未通过的，继续按 2.2-17/2.2-18 已确认的豁免执行：
> script_count=100 / passed=82 / failed=18 的数字、100 条 runs、18 条 failures 一律不许改；
> WAIVER 记录沿用原字节，新增本轮授权说明文件，不要声称「全量通过」。

`WAIVER.md` 与 2.2-18 和 2.2-17 原件逐字节相同。豁免严格限于其中 18 个脚本：16 个 existing_fixture_compile_incompatibility、2 个 existing_extractor_contract_incompatibility。原头像手势断言冲突属于已有脚本诊断，不是第 19 项。

100 个原始脚本中 18 个仍未通过，本轮按用户授权豁免。本目录 REGRESSION-GATE.json 保留原 script_count、passed、failed、100 条 runs、18 条 failures、退出码和诊断；只更新状态及授权出处元数据。REGRESSION-GATE.md 原字节保留。它们是继承的历史原始结果，本轮复跑另存 release-core-revalidation/result.json。

本轮状态为 `waived_by_user_explicit_authorization; 18 baseline failures accepted for 2.2-19 by continued waiver`，不表示 pass、green 或 all-clear。七项核心、原仍绿 82 脚本、2.2-18 header 37,152 断言、本轮新底栏测试均必须通过；任何豁免清单外的新失败立即停止出包并报告。
