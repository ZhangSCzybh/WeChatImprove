# 2.2-15 最终范围与环境保护核验

比较基准是本任务开始时冻结的、含未提交 2.2-13 / 2.2-14 改动的工作树；没有按 Git HEAD 重建基线。

生产与版本说明共 **11 个文件，+176 / −16 行**。包含新文件，排除 .DS_Store。

| 文件 | 状态 | 增加 | 删除 |
| --- | --- | ---: | ---: |
| `Controllers/CSBubbleStyleAdapter.m` | modified | +3 | −2 |
| `Controllers/CSCloseFriendBridge.m` | modified | +1 | −1 |
| `Controllers/CSCloseFriendManager.m` | modified | +60 | −0 |
| `Controllers/CSCloseFriendReset.h` | modified | +6 | −0 |
| `Controllers/CSCloseFriendReset.m` | modified | +48 | −1 |
| `Controllers/CSCloseFriendRuntime.h` | modified | +8 | −0 |
| `Controllers/CSCloseFriendRuntime.m` | modified | +37 | −4 |
| `Controllers/CSReleaseNotesViewController.m` | modified | +5 | −0 |
| `Headers/CSUserInfoHelper.h` | modified | +1 | −1 |
| `README.md` | modified | +6 | −6 |
| `control` | modified | +1 | −1 |

| 保护对象 | 核验项数 | 结果 |
| --- | ---: | --- |
| 冻结基线 | 42524 | PASS |
| 历史 packages（包含 .DS_Store） | 184 | PASS |
| 主树 .theos（完整路径集合与 hash） | 1237 | PASS |
| HeadersFile | 42142 | PASS |
| 既有 2.2-13 / 2.2-14 审计 | 207 | PASS |
| 原 fixture / legacy | 277 | PASS |
| 原 fixture / compact | 7 | PASS |

旧审计的前后保护窗口是 scope-preparation.json 的准备时间至本次最终核验；其余 packages/.theos/冻结源码使用任务开始时已有 manifest。

Git HEAD 保持 `a227b1677255fe0e2dc727dcc2e6f62386fc3afd`，工作树仍有未提交改动。核验脚本仅运行只读 diff/status/rev-parse，未执行 reset、checkout、stash、clean 或提交。

整体结果：**PASS**。逐项缺失、改变、额外文件、完整 hash 与逐文件计数见 final-scope-result.json。
