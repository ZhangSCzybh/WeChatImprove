# 已完成：源码完整回退到 2.0-18

本记录是用户补充确认后的执行结果。上级目录中的“快照不足、尚未修改源码”检查记录保留为历史证据，不代表本次最终状态。

回退目标是已交付的 `packages/com.wechat.improve_2.0-18_iphoneos-arm.deb` 所对应的源码状态，包 SHA256 为 `201d627505a00ab44edca301f413a0a9ec1f22b0a119b2331bd833c8ede4586d`。2.0-19 的折叠显示/画布修改和 2.0-20 的圆角卡片修改均已撤回；本轮没有增加优化或修复。

## 两份清单

1. [已还原文件清单及逐文件 SHA256](restored-files.md)：21 个既有文件全部匹配；2 个后续新增测试头文件已归档移出 Tests。
2. [仍与基线存在差异的文件清单](remaining-differences.md)：当前源码、测试、版本和当前说明文件差异为 0；仍存在的是按要求保留的历史审计、用户反馈、2.0-19/2.0-20 成品包，以及本次回退证据。完整路径及摘要见 [JSON 明细](remaining-differences.json)。

完整的 2.0-18 `source-sha256.json` 共 555 项全部核对一致，源码/测试目录没有多余或缺失文件。README 和会话分组说明另与 2.0-19 修改前的完整工作区基线匹配。

## 快照缺失的处理

先在隔离目录形成候选，全部核验通过才整体写回，避免半回退状态。

- 5 个文件直接取 2.0-19 的 before 原件。
- 6 个文件取 2.0-20 的 before 原件；这些文件在 2.0-19 未改动，哈希与 2.0-18 一致。
- 3 个文件取已有 Git 对象，哈希与 2.0-18 一致。
- 其余 7 个文件从当前内容中撤销可识别的后续新增内容，**只有最终完整文件 SHA256 与历史 2.0-18 记录完全一致才接受**。7 个均通过，没有采用“语义相似”但内容不一致的候选。

候选来源和匹配证据在 [candidate-verification.json](candidate-verification.json)，已验证的完整基线副本保存在 `baseline-2.0-18/`，写回后的逐字节比较在 [restored-files.json](restored-files.json)。回退前的 23 个受影响文件保存在 `source-before-rollback.zip`，两个新增测试原文另存于 `post-2.0-18-tests/`。

版本定义 `control`、`Headers/CSUserInfoHelper.h`、当前发布说明、README 与会话分组说明均回到 2.0-18 原始内容。

## 限定回归

只运行两个直接相关脚本，没有运行全量：

| 脚本 / 内容 | 检查数 | 结果 |
| --- | ---: | --- |
| `Tests/verify-list-corners.sh`：列表圆角、外观及分组行角色 | 869 | 0 失败 |
| `Tests/verify-close-friend-session.sh`：会话/折叠逻辑与隐私门禁 | 85 | 0 失败 |
| 同脚本：折叠入口显示与复用 | 19 | 0 失败 |
| **合计** | **973** | **0 失败** |

日志：[列表外观](list-corners.log)、[会话与折叠显示](close-friend-session.log)。这些是恢复后的 2.0-18 用例，不继续保留 2.0-19/2.0-20 新增行为的断言。

## 编译与已交付包核对

仅执行 `make -j4 all SCHEME=rootful`，输出到隔离目录，完成 `arm64 / arm64e` 两个切片的编译、链接和签名；没有执行 `package`、`stage` 或 `clean`，没有产生新 deb。

编译日志见 [compile-rootful.log](compile-rootful.log)。编译通过，无新增错误或警告。保留原版的 12 条警告（10 条既有弃用 API 警告及 2 条链接器旧选项警告），与 2.0-18 历史构建逐条匹配，见 [警告比较](compile-warnings-comparison.json)。

重新编译 dylib 的整体哈希与已交付包不同，已进一步核实：

- 两个架构的全部 Mach-O section 的内容、大小、地址和属性均相同。
- load commands 仅 `LC_UUID` 内容不同。
- 排除构建 UUID 与代码签名 payload 后，两个架构的**完整二进制逐字节相同**，未发现代码或数据的语义差异。

证据：[整体校验](binary-verification.json)、[section 比较](binary-section-comparison.json)、[仅排除 UUID / 签名后的完整比较](binary-normalized-comparison.json)。

## 保留结果

- `packages/` 的 42 个既有文件全部未变，包括 2.0-18 rootful/rootless 原包和 2.0-16 至 2.0-20 的历史 deb / symbols。
- 回退前的 2,887 个既有审计文件全部保留，原文未变。
- `.theos/` 的 1,173 个既有文件全部未变。本轮编译产物位于 `candidate-verification.json` 所记隔离目录的 `compile-rootful/` 下。
- 仅本轮授权的 21 个文件被恢复，2 个后续新增测试文件被归档移出；未发现其他意外更改。

最终汇总见 [final-verification.json](final-verification.json)。未连接真机、未修改账号配置或用户数据、未生成或覆盖任何成品包。
