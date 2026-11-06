# 2.2-20：清理文档与开发残留、正式交付

本轮基线为已交付的 2.2-19 工作树。工作目录不变；开始时 HEAD 是 a227b1677255fe0e2dc727dcc2e6f62386fc3afd，包含 2.2-13～2.2-19 未提交功能。用户本轮明确授权清理、构建 2.2-20 并提交 GitHub；此前不提交的限制在本轮提交范围内已获新授权。

## 清理范围与功能边界

复核近几轮差异后，没有发现新遗留的临时日志、性能埋点或只定义不调用的 static 函数。此前 CPU 观测已从生产代码移除；本轮没有为“清理”而删掉功能防护。原有错误诊断、测试编译入口、未知版本回退、密友授权与重置恢复均保留。详见 [生产审查](PRODUCTION-CLEANUP-REVIEW.md)。

相对任务开始时的生产目录，只有版本宏与发布说明改变；control 和 README 同步版本与交付信息。其余受保护生产文件、历史 packages 与主树 .theos 保持哈希一致。未执行 make clean、git reset、checkout 或 stash。

| 文件 | 2.2-19 SHA256 | 2.2-20 SHA256 |
| --- | --- | --- |
| Controllers/CSReleaseNotesViewController.m | `7f8fe9361b87c58a67e45360e57a433b4ec8380ba735aa50a76a1bf214816c09` | `2fabbd9ad3a2591a9d1091f5100b9acafeef2c6d967a85570d542553a03f0986` |
| Headers/CSUserInfoHelper.h | `36a1d1d2634692f77160d25ad103d4201527c1bbc9d53661f8ead8ac9eae8b48` | `d500a05149f82dabf63df43f2f4a2ec85464113644625b9c4a65ae511f88ff2e` |
| control | `371e06fbec4c301187b1540d2459709dc8fa369f8907b94e7d7d829477fc0ecd` | `b16fb646193f3b3404d25f90dc00119fc0383df63112a95271e61a2f45469c2e` |
| README.md | `0ec961531a86abf101a8f071ccf1ce389b2a6138f33cca706efc525377841f05` | `2adb45e841b28e14b4a755e9e8a07fbfbe240708cf1b377d80384d7dc351daef` |

Tests 目录在本轮开始前已被删除。用户明确选择恢复后，从 HEAD 恢复 277 个文件及原文件权限，逐字校验通过。没有改测试源码、断言或夹具。Finder 的 .DS_Store 从 Git 跟踪中移除，磁盘原文件保留并忽略。

## docs 整理

- 主归档：166 项、256,490 文件、2,130,403,146 字节，移动前后每文件 SHA256 全部一致。
- 补充扫描：58 个散落的已编译测试可执行文件、14,572,136 字节，同样逐 SHA256 一致。
- 总计归档 256,548 个文件、2,144,975,282 字节；没有销毁这些文件。
- 原始 trace、XML 导出、重复 HeadersFile、旧 Git 状态快照和编译缓存移到项目外本机归档。历史报告、WAIVER/GATE、红绿日志、方法抽取、生产快照、测试源码及全部原有样本保留。
- 原来已缺失的 6,615 个已跟踪 docs 文件属于任务开始前状态；与本轮实际归档分开记录。旧已提交版本可在 Git 历史恢复。
- 新增 [文档索引](../../README.md)，根 README 的 75 个旧缺失文档链接指向固定 a227b167 历史版本，避免最新提交出现死链。
- .gitignore 排除 Finder 元数据、Python 缓存、主树 .theos、原始 trace、重复基线头文件与审计 build 缓存；不屏蔽回归失败或删除失败清单。

本机归档：`/Users/zhangshichao/Documents/Workspace/WeChatImprove-local-archive/2.2-20-cleanup-2026-11-06/`。逐项树 SHA、恢复路径和历史符号链接限制见 [ARCHIVE-INDEX.md](ARCHIVE-INDEX.md)、[执行记录](docs-cleanup-result.json)及[补充清单](additional-cache-cleanup.json)。本轮导航模型完整 samples 也单独留有持久副本，见 [PERSISTENT-VALIDATION-SAMPLES.json](PERSISTENT-VALIDATION-SAMPLES.json)。

## 本轮实际回归

92 / 92 任务退出 0，包含原先仍绿的 82 个脚本与 10 套现代专项（包括返回 header 测试）；随后独立执行底栏导航专项。新失败为 0；325 份既有 fixture/runner 与恢复后的 277 份 Tests 前后 SHA 不变。详见 [CORE-REGRESSIONS.json](CORE-REGRESSIONS.json) 与 [可复跑输入和日志](release-core-revalidation/README.md)。分项存在重叠，不累加成总断言数。

| 项目 | 通过 / 失败 |
| --- | ---: |
| 快捷页完整重置 | 259 / 0 |
| 重置后设密与锁定/解锁 | 105 / 0 |
| 头像五击快捷入口 | 90 / 0 |
| 2.2-16 回滚与残留清理 | 232 / 0 |
| 气泡紧密 | 1,436 / 0；compact 2pt，normal 21/24pt |
| 设置生命周期 | 5,114 / 0 |
| 搜索密码与长按标题 | 357 / 0 |
| Merge policy | 235,148 / 0 |
| Merge adapter | 三个支持版本各 17,566 / 0，含 8.0.80 |
| 原生底栏适配 | 6 个步骤全部退出 0 |
| 消息布局六脚本 | 1,048,295 检查，六脚本全部退出 0 |
| 布局偏好 / 列表圆角 | 10,013 / 0、1,631 / 0 |
| 2.2-18 返回间距 | 37,152 / 0；432 场景、14 阶段 |
| 2.2-19 底栏导航 | 101,400 / 0；50 路由、49,200 阶段样本 |

**100 个原始脚本中 18 个仍未通过，本轮按用户授权豁免。** 本轮没有重跑这 18 个已知失败，也没有新增豁免。WAIVER.md、REGRESSION-GATE.json/.md 与 2.2-19 原字节相同，100/82/18、100 条 runs、18 条 failures 及原 gate_status 保留；它们是继承的历史结果，不冒充本轮执行。本轮继续沿用说明见 [WAIVER-CONTINUATION.md](WAIVER-CONTINUATION.md)。不能把这些结果描述为“全量回归通过”。

原 privacy 测试依赖历史 HEAD 作为负对照。本轮在提交前运行，HEAD 仍为 a227b167；为提交后可复跑，新 orchestrator 只为测试子进程创建固定历史 commit 的私有 Git 视图，原 runner/fixture 不改，主仓库 HEAD 不动。其 5 份负对照源字节已经独立核对。

## 构建与产物

rootless / rootful 均从冻结源码执行 make package -j1，每个方案独立临时 _THEOS_LOCAL_DATA_DIR、THEOS_BUILD_DIR、THEOS_PACKAGE_DIR。没有覆盖历史目录。构建还核对关键编译对象、去除的旧凭据重置 selector 不存在、两个架构 dylib 与 dSYM UUID 匹配。

对比 2.2-19 警告多重集：rootful arm64 / arm64e 各 4 条、rootless arm64 / arm64e 各 4 条，数量及诊断与上一版相同，**新增 0**。原始日志与比较见 [delivery-build/warning-comparison.json](delivery-build/warning-comparison.json)。

交付目录：`packages/2.2-20-cleanup/`。重签用 dylib 从 rootful deb 提取且逐字相同，为 arm64 + arm64e fat；两个 deb 的 Version 均实查为 2.2-20。

| 文件 | 字节 | SHA256 |
| --- | ---: | --- |
| SHA256SUMS | 410 | `ba478b353d0a7e48d4312ecc2391d2aadd98f8ed0b5804c2e14308040eb2a579` |
| WeChatImprove.dylib | 7170112 | `fdfacabdb12556a9af91078f8cad06eada6a4df93c153d77c051b2d67356990e` |
| com.wechat.improve_2.2-20_iphoneos-arm.deb | 1648506 | `01de0438937a6ca2617d034053badd6535e5a27bd96ec4437a6142fced58fdbf` |
| com.wechat.improve_2.2-20_iphoneos-arm64.deb | 1648952 | `b7d7a89987510a64751de4140e7e5276981b2f9776fd9a869eb62b4791ee7734` |
| com.wechat.improve_2.2-20_symbols.zip | 11710747 | `4617627934b8f7a53d6cd05e54f4ac5bcb3952561a883dfbfbaa520c494b4da7` |

实际执行 shasum -a 256 -c SHA256SUMS：

```text
WeChatImprove.dylib: OK
com.wechat.improve_2.2-20_iphoneos-arm.deb: OK
com.wechat.improve_2.2-20_iphoneos-arm64.deb: OK
com.wechat.improve_2.2-20_symbols.zip: OK
```

实际执行 dpkg-deb -f 的 Version：

```text
com.wechat.improve_2.2-20_iphoneos-arm.deb: 2.2-20
com.wechat.improve_2.2-20_iphoneos-arm64.deb: 2.2-20
```

实际 lipo -archs 输出：`arm64 arm64e`。根任务的命令与输出见 [ROOT-ARTIFACT-CHECKS.json](ROOT-ARTIFACT-CHECKS.json)，43,970 个受保护文件的核对见 [PRESERVATION-RESULT.json](PRESERVATION-RESULT.json)。

## GitHub 交付与未验证范围

本轮将 2.2-13～2.2-20 的累计生产变更、对应正式包与本轮文档整理提交到 origin/main（ZhangSCzybh/WeChatImprove）。较早的本地观测包和候选包保持原样，不纳入本次新提交。实际提交/远端 commit 以完成回复和远端核对为准，本报告不预填尚未创建的 commit。

本轮没有连接设备、安装或更换微信，没有切账号、修改偏好、数据库或真实 Keychain。全部回归属于主机策略与编译边界验证。真实手势、转场首帧、底栏样式及点击恢复、气泡间距观感、Keychain 行为仍为**未验证**。
