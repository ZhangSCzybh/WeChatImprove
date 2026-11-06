# 2.2-19 最终范围与环境保护核验

基准是本次开始时冻结的 2.2-18 工作树，保留未提交的 2.2-13 至 2.2-18 改动；没有按 Git HEAD 重建。

生产与版本说明 **7 个文件，+19 / −8 行**。

| 文件 | 状态 | 增加 | 删除 | 2.2-18 SHA256 | 当前 SHA256 |
| --- | --- | ---: | ---: | --- | --- |
| `Controllers/CSAIReplySettingsViewController.m` | modified | +2 | −0 | `6ba96063b229d4a7f766a3d3e63fb43091b0744a5fc896ae2b6d1710349e88c8` | `d95767accc0059060eb053d502b39d91a3426f741663642863dd39c425dfa2b2` |
| `Controllers/CSReleaseNotesViewController.m` | modified | +4 | −0 | `054937db8b339dce2b2b6691ac332c4c5475ff96d24ab5778ed5486d841dcff5` | `7f8fe9361b87c58a67e45360e57a433b4ec8380ba735aa50a76a1bf214816c09` |
| `Controllers/CSScheduledTaskSettingsViewController.m` | modified | +2 | −0 | `058b4c2f1b388b80666886a1501efac0006f08fe7126ea1f1580b09c7cb8f868` | `b4a7989995420b1e0f0e66bfe4928bb45d7cbe7b5309087d205813dcde496315` |
| `Controllers/CSSettingsTableViewController.m` | modified | +3 | −0 | `78b4ae44fdbc8910c5fdf674d9a24bd926a39854fee865bfe7cca3201bdd7937` | `f9848ca17c2bb9c325994040b434e5aff4e9fc2020aaabcf87f520e23974f03e` |
| `Headers/CSUserInfoHelper.h` | modified | +1 | −1 | `d6cec59fae4866c1237797fcec20898fa2bca0219cac074a3d0481940b5366bd` | `36a1d1d2634692f77160d25ad103d4201527c1bbc9d53661f8ead8ac9eae8b48` |
| `README.md` | modified | +6 | −6 | `64ce847fa310a317e4bad0916d5b8a98a2b20cb978ea7a5d710758346bc1741d` | `0ec961531a86abf101a8f071ccf1ce389b2a6138f33cca706efc525377841f05` |
| `control` | modified | +1 | −1 | `c87e5f407cd90b477ffd327ef22fe1b4bb146cdf09e16da0d3a0f86dcf444b91` | `371e06fbec4c301187b1540d2459709dc8fa369f8907b94e7d7d829477fc0ecd` |

显式改动范围逐文件核验；未授权的新增、删除或修改都会失败，不以排除目录掩盖范围。

| 保护对象 | 核验项数 | 结果 |
| --- | ---: | --- |
| 冻结 2.2-18 基线（完整 set + hash） | 42524 | PASS |
| 历史 packages（完整 set + hash，含 .DS_Store） | 204 | PASS |
| 主树 .theos（完整 set + hash） | 1237 | PASS |
| HeadersFile（完整 set + hash） | 42142 | PASS |
| 2.2-18 旧审计（零编辑或删除例外） | 43268 | PASS |
| 除 7 文件显式改动名单外全部冻结输入 | 42517 | PASS |
| 原 fixture / copied_unmodified_test_inputs_and_runners | 325 | PASS |

旧审计保护窗口从 scope-preparation.json 准备时间起算；packages/.theos/冻结源码使用本任务起始 manifest。

HEAD `a227b1677255fe0e2dc727dcc2e6f62386fc3afd`；checkout `/Users/zhangshichao/Documents/Workspace/WeChatImprove`；根 Tests 不存在。

范围与保护结果：**PASS**。此结果与测试、构建和出包门槛分开。

2.2-19 产物目录：存在；存在目录也不由本脚本视为构建验证通过。
