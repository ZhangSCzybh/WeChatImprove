# 回退到 2.0-18：快照完整性检查

状态：**按用户“快照缺失先停下说明”的要求暂停，尚未修改源码。** 当前源码版本仍为 2.0-20，未执行回归、编译或打包。只新增本检查目录，既有审计和成品包保持不变。

## 已核实的证据

- 2.0-19 的 `preservation.json` 记录 13 个既有文件发生变化，其 `before/` 实际只有 5 个文件。
- 这 5 个文件的完整 SHA256 均与 2.0-18 的源码记录或 2.0-19 开始前基线一致：`CSCloseFriendSessionPresentation.m`、`CSListCornerPageContext.m`、`ListCornerRadiusHooks.xm`、`CloseFriendSessionPresentationTests.m`、`ListCornerSemanticsTests.m`。
- 当前还叠加了 2.0-20 的改动。要完整回到 2.0-18，合并去重后共有 21 个既有文件需要恢复，另有两个新增测试头文件需要退出当前测试树并归档保留。
- 在上述 21 个文件中，14 个已经找到 SHA256 与 2.0-18 记录完全一致的还原来源：5 个来自 2.0-19 的 before 快照，6 个来自 2.0-20 的 before 快照，3 个来自已有 Git 对象。仍有 7 个没有找到可直接复制的完整原文。
- 与 2.0-18 源码清单的比较没有发现上述范围之外的额外差异。

详细的目标 SHA256、当前 SHA256、各候选来源及匹配结果均已写入 [preflight.json](preflight.json)。2.0-19 开始前的基线文件本身也已与历史 `preservation.json` 中的 SHA256 核对一致。

## 2.0-19 before 快照缺失的 8 个文件

| 文件 | 当前证据 |
| --- | --- |
| `Controllers/CSReleaseNotesViewController.m` | 有旧 SHA256，未找到完整原文 |
| `Headers/CSUserInfoHelper.h` | 有旧 SHA256，未找到完整原文 |
| `Hooks/SessionGroupHooks.xm` | 有旧 SHA256；2.0-20 的 before 保存的是已修改后的 2.0-19 内容，不能直接使用 |
| `README.md` | 有旧 SHA256，未找到完整原文 |
| `Tests/extract-list-corners.py` | Git `21bf426cdcf8f5e1af76c5c962eeee5b0e509303` 中的原文 SHA256 与 2.0-18 一致 |
| `Tests/verify-close-friend-session.sh` | 有旧 SHA256；2.0-20 的 before 保存的是已修改后的 2.0-19 内容，不能直接使用 |
| `control` | 有旧 SHA256，未找到完整原文 |
| `docs/session-groups.md` | 有旧 SHA256，未找到完整原文 |

用户明确要求快照缺失时先停下，故没有手工删除方法、替换版本号或重写说明，也没有先恢复部分文件而留下混合状态。

可选后续处理：取得缺失原件；或经用户明确允许后，仅在隔离目录重建这 7 个文件的候选内容，以既有 2.0-18 SHA256 为硬性条件，全部逐字节一致后才执行整体回退。任一文件不一致则继续停止，不以“语义相似”代替完整原文。

## 成品包与已有资料

2.0-16、2.0-17、2.0-18、2.0-19、2.0-20 的 15 个 deb / symbols 均已与各自历史 `packages.json` 的 SHA256 比较一致。用户指定的 2.0-18 rootful 包为：

`201d627505a00ab44edca301f413a0a9ec1f22b0a119b2331bd833c8ede4586d`

2.0-18 rootless 包为：

`11d39621462d085ffc698d8173681a5106c2d4b373cc87f1ff7c087ffd7f86f8`

所有 packages 文件、559 个当前源码/测试/版本文档文件、2,883 个历史审计文件的观察摘要见 [preserved-files-sha256.json](preserved-files-sha256.json)。没有删除或覆盖任何历史包、历史审计，也没有改动 `.theos`。

未恢复源码，因此本轮编译和回归均未运行，不能报告“回退后编译通过”或“已与 2.0-18 dylib 语义一致”。
