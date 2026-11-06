# 2.2-17 最终范围与环境保护核验

基准是本次开始时冻结的 2.2-16 工作树，保留未提交的 2.2-13 至 2.2-16 改动；没有按 Git HEAD 重建。

生产与版本说明 **10 个文件，+83 / −27 行**。

| 文件 | 状态 | 增加 | 删除 | 2.2-16 SHA256 | 当前 SHA256 |
| --- | --- | ---: | ---: | --- | --- |
| `Controllers/CSCloseFriendManager.h` | modified | +1 | −0 | `acb17fb492c0d2aa389240cb74caae83ef213649f6230a787f2c2b4cf79549e9` | `f2cddaf8320735b6f6c5fa0f96035194ca1b0a1fbf47fcfb426f87b0f34ef0c4` |
| `Controllers/CSCloseFriendManager.m` | modified | +36 | −5 | `4ad68df9b623f8797930b7c37ee15395240c10d3356c4a3d2db19b37a32324a2` | `916198133c42c6c0e02b30f2fa67c7076d658b133ce849405ad59f23026541c7` |
| `Controllers/CSCloseFriendRuntime.h` | modified | +2 | −0 | `9bc00628b7c7c662a60f7e4c2ca7614aa7165ca6b1c8778edb90556d9c1ddc4d` | `5fc06fcffa68bd86ce0f38eaac1855090f763650129f202e47a9cb3011c7cc23` |
| `Controllers/CSCloseFriendRuntime.m` | modified | +21 | −7 | `35de29d20061b58ae320cc824bd5526824b0cfc2672ba222734a1ea7a34a53f7` | `92d54fe8182546fff0b3e72a302a5126ed486a135c0fbdb6e46b0746e01b7e95` |
| `Controllers/CSCloseFriendSettingsViewController.m` | modified | +8 | −5 | `da567f1047a64a8bdabef42220aa6e4b1f641e50c80d7fcb1d0a88950e8609e9` | `60c19468d4c9910d7aeb47f4415750c227a413c592f814bfda525200360548c8` |
| `Controllers/CSCustomViewController.m` | modified | +1 | −1 | `4fe22c3775424b65e204ba5eb5951024329afbdbc1d4924da593919e26859008` | `6f602715e9cf5863798accf429f0d02369d33c4214a22aca0d7b015c16519cd7` |
| `Controllers/CSReleaseNotesViewController.m` | modified | +5 | −0 | `4bead9506e393543200ad1f2ccfb2a34066cb99d338d4b9d237da2b16335a6c5` | `d3eee3cbc5d5c32af38f85fc9ebeaaa527360086877182cfe6fb029f41119596` |
| `Headers/CSUserInfoHelper.h` | modified | +1 | −1 | `5eea1f6b26f2c2d2cf1978c8d9a3035ffded76ba45732c3de4987f42ffd52e24` | `d20ffbefef03827529f35b0b50517709b3f818d643d90b5d37ca7aefb02f0191` |
| `README.md` | modified | +7 | −7 | `cebdf3f17a22d73ca443a20f5fe209766cf9f0bdf6fc380477497bb12f62ee50` | `61129793cee6bcb92ab8d4e4556952cf48ccfecd95471e6336adb70707dbfece` |
| `control` | modified | +1 | −1 | `1670fef7699ecac123422a037735f4eea9cecab4b47684d7ec4898f3c175729b` | `e8933fc97a8f4ca0047f26e3fcf2c2d8c86210671c5e070efd855c7eafc54ac5` |

显式改动范围逐文件核验；未授权的新增、删除或修改都会失败，不以排除目录掩盖范围。

| 保护对象 | 核验项数 | 结果 |
| --- | ---: | --- |
| 冻结 2.2-16 基线（完整 set + hash） | 42524 | PASS |
| 历史 packages（完整 set + hash，含 .DS_Store） | 194 | PASS |
| 主树 .theos（完整 set + hash） | 1237 | PASS |
| HeadersFile（完整 set + hash） | 42142 | PASS |
| 2.2-16 旧审计（零编辑或删除例外） | 43588 | PASS |
| 除 10 文件显式改动名单外全部冻结输入 | 42514 | PASS |
| 原 fixture / all_copied_prior_fixtures | 314 | PASS |
| 原 fixture / legacy | 277 | PASS |
| 原 fixture / compact | 7 | PASS |
| 原 fixture / compact_with_existing_production_support | 8 | PASS |

旧审计保护窗口从 scope-preparation.json 准备时间起算；packages/.theos/冻结源码使用本任务起始 manifest。

HEAD `a227b1677255fe0e2dc727dcc2e6f62386fc3afd`；checkout `/Users/zhangshichao/Documents/Workspace/WeChatImprove`；根 Tests 不存在。

范围与保护结果：**PASS**。此结果与测试、构建和出包门槛分开。

2.2-17 产物目录：存在；存在目录也不由本脚本视为构建验证通过。
