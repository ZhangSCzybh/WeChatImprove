# 2.2-18 最终范围与环境保护核验

基准是本次开始时冻结的 2.2-17 工作树，保留未提交的 2.2-13 至 2.2-17 改动；没有按 Git HEAD 重建。

生产与版本说明 **5 个文件，+15 / −8 行**。

| 文件 | 状态 | 增加 | 删除 | 2.2-17 SHA256 | 当前 SHA256 |
| --- | --- | ---: | ---: | --- | --- |
| `Controllers/CSCustomViewController.m` | modified | +3 | −0 | `6f602715e9cf5863798accf429f0d02369d33c4214a22aca0d7b015c16519cd7` | `933c2af2174ee391c916a3f43e6c798147cb54cb6293515b9e1119210c2d26f7` |
| `Controllers/CSReleaseNotesViewController.m` | modified | +4 | −0 | `d3eee3cbc5d5c32af38f85fc9ebeaaa527360086877182cfe6fb029f41119596` | `054937db8b339dce2b2b6691ac332c4c5475ff96d24ab5778ed5486d841dcff5` |
| `Headers/CSUserInfoHelper.h` | modified | +1 | −1 | `d20ffbefef03827529f35b0b50517709b3f818d643d90b5d37ca7aefb02f0191` | `d6cec59fae4866c1237797fcec20898fa2bca0219cac074a3d0481940b5366bd` |
| `README.md` | modified | +6 | −6 | `61129793cee6bcb92ab8d4e4556952cf48ccfecd95471e6336adb70707dbfece` | `64ce847fa310a317e4bad0916d5b8a98a2b20cb978ea7a5d710758346bc1741d` |
| `control` | modified | +1 | −1 | `e8933fc97a8f4ca0047f26e3fcf2c2d8c86210671c5e070efd855c7eafc54ac5` | `c87e5f407cd90b477ffd327ef22fe1b4bb146cdf09e16da0d3a0f86dcf444b91` |

显式改动范围逐文件核验；未授权的新增、删除或修改都会失败，不以排除目录掩盖范围。

| 保护对象 | 核验项数 | 结果 |
| --- | ---: | --- |
| 冻结 2.2-17 基线（完整 set + hash） | 42524 | PASS |
| 历史 packages（完整 set + hash，含 .DS_Store） | 199 | PASS |
| 主树 .theos（完整 set + hash） | 1237 | PASS |
| HeadersFile（完整 set + hash） | 42142 | PASS |
| 2.2-17 旧审计（零编辑或删除例外） | 44688 | PASS |
| 除 5 文件显式改动名单外全部冻结输入 | 42519 | PASS |
| 原 fixture / copied_unmodified_test_inputs_and_runners | 323 | PASS |

旧审计保护窗口从 scope-preparation.json 准备时间起算；packages/.theos/冻结源码使用本任务起始 manifest。

HEAD `a227b1677255fe0e2dc727dcc2e6f62386fc3afd`；checkout `/Users/zhangshichao/Documents/Workspace/WeChatImprove`；根 Tests 不存在。

范围与保护结果：**PASS**。此结果与测试、构建和出包门槛分开。

2.2-18 产物目录：存在；存在目录也不由本脚本视为构建验证通过。
