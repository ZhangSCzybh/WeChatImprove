# 2.2-16 最终范围与环境保护核验

比较基准是本任务开始时冻结的、含未提交 2.2-13 / 2.2-14 / 2.2-15 改动的工作树；没有按 Git HEAD 重建基线。

生产与版本说明共 **13 个文件，+204 / −195 行**。包含新文件，排除 .DS_Store。

| 文件 | 状态 | 增加 | 删除 |
| --- | --- | ---: | ---: |
| `Controllers/CSCloseFriendBridge.m` | modified | +1 | −1 |
| `Controllers/CSCloseFriendManager.m` | modified | +1 | −60 |
| `Controllers/CSCloseFriendReset.h` | modified | +0 | −6 |
| `Controllers/CSCloseFriendReset.m` | modified | +5 | −48 |
| `Controllers/CSCloseFriendRuntime.h` | modified | +6 | −8 |
| `Controllers/CSCloseFriendRuntime.m` | modified | +30 | −38 |
| `Controllers/CSCloseFriendSettingsViewController.h` | modified | +3 | −0 |
| `Controllers/CSCloseFriendSettingsViewController.m` | modified | +63 | −23 |
| `Controllers/CSCustomViewController.m` | modified | +81 | −0 |
| `Controllers/CSReleaseNotesViewController.m` | modified | +6 | −3 |
| `Headers/CSUserInfoHelper.h` | modified | +1 | −1 |
| `README.md` | modified | +6 | −6 |
| `control` | modified | +1 | −1 |

## 密友回滚逐文件 SHA256

本表逐字节比较 2.2-14、2.2-15 和当前文件；若为了本次残留兼容或五连击新增了代码，当前文件会如实显示不等于 2.2-14，不能声称完全还原。

| 文件 | 2.2-14 SHA256 | 2.2-15 SHA256 | 当前 SHA256 | 当前等于 2.2-14 |
| --- | --- | --- | --- | --- |
| `Controllers/CSCloseFriendReset.h` | `ef63c7a60a1563c9806ba95328ac28d17f4281b5e6f64ec8a5ca28a67aca04f7` | `5b41d337226c46a5a51bcb612d5a3dcd73e7c42fcbaa7bdaa062c6fa29be4a62` | `ef63c7a60a1563c9806ba95328ac28d17f4281b5e6f64ec8a5ca28a67aca04f7` | True |
| `Controllers/CSCloseFriendReset.m` | `57cec6a01ec95d881cb188d2484aa35e8b7bf82ae96b0e3aa42829aca339456a` | `323c577c74c0972ca9a25bdd2e85faec461c14779a2aee338f792b7f82907f4c` | `57da5d4a4558fee6d192290eef19c6d22c55999416c8ba21c61dd478bf5be39b` | False |
| `Controllers/CSCloseFriendRuntime.h` | `399a386dd7912f8671e2c06c44ce21dd28d77eadcead05d0cd67513d69bce1f6` | `d42b649e88a8f680a8dc5803b93b7e31a006e95f7240fae4bc665109732a830d` | `9bc00628b7c7c662a60f7e4c2ca7614aa7165ca6b1c8778edb90556d9c1ddc4d` | False |
| `Controllers/CSCloseFriendRuntime.m` | `b08edf89b04a94306f5dc8d8766224b4d182fddbd5964286d30c69813b650829` | `413898575ff4c3ec45db34b08c6359e1484be1be442740e08671632444002bc3` | `35de29d20061b58ae320cc824bd5526824b0cfc2672ba222734a1ea7a34a53f7` | False |
| `Controllers/CSCloseFriendManager.m` | `8292cb7754fbb5a3c7c29238766eb0346c87f4bec06d70753b455e9dfa168915` | `a290c21c125dbe12ed771537e5189330a691a257c1cb9253a11522674005d214` | `4ad68df9b623f8797930b7c37ee15395240c10d3356c4a3d2db19b37a32324a2` | False |
| `Controllers/CSCloseFriendBridge.m` | `7a052bf3316b45040747a7fd495b673c46ee5bc9224fc0b326db8380db1e2bdf` | `de13dfe44f00105dd46e5510e55a00e48ae849ba5a816e6e3cb041c5e51535d3` | `7a052bf3316b45040747a7fd495b673c46ee5bc9224fc0b326db8380db1e2bdf` | True |

| 保护对象 | 核验项数 | 结果 |
| --- | ---: | --- |
| 冻结基线 | 42524 | PASS |
| 历史 packages（包含 .DS_Store） | 189 | PASS |
| 主树 .theos（完整路径集合与 hash） | 1237 | PASS |
| HeadersFile | 42142 | PASS |
| 既有审计（除用户明确删除的 .15 reset-validation） | 43259 | FAIL |
| 原 fixture / all_copied_prior_fixtures | 314 | PASS |
| 原 fixture / legacy | 277 | PASS |
| 原 fixture / compact | 7 | PASS |

旧审计的前后保护窗口是 scope-preparation.json 的准备时间至本次最终核验；其余 packages/.theos/冻结源码使用任务开始时已有 manifest。

旧 2.2-15 README.md 仅为清除已撤回凭据重置测试的失效链接及追加历史说明而列入显式授权名单；其前后 SHA256 仍记录在 JSON，不计为不可修改文件的假失败。

Git HEAD 保持 `a227b1677255fe0e2dc727dcc2e6f62386fc3afd`，工作树仍有未提交改动。核验脚本仅运行只读 diff/status/rev-parse，未执行 reset、checkout、stash、clean 或提交。

整体结果：**FAIL**。逐项缺失、改变、额外文件、完整 hash 与逐文件计数见 final-scope-result.json。
