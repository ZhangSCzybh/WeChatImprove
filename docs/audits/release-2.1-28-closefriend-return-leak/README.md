# 2.1-28：返回聊天列表的密友／密群短暂露出

> 本文保留首批交付的历史记录。补充首轮 section／行位置／圆角／滚动位置要求后的推荐安装包及审计位于 [layout-firstframe-candidate-1](layout-firstframe-candidate-1/README.md)。首批包及校验值保持原样；相同版本请按完整路径与 SHA-256 区分。

日期：2026-10-30，Asia/Shanghai。沿用 `/Users/zhangshichao/Documents/Workspace/WeChatImprove`、`main`，基线为未修改的 2.1-27 提交 `e9d4601c63fbfdeb11b208777ae9dc99f5f1c3c9`。没有切换 checkout、启动服务、安装到手机或更改账号、配置和数据库。

## 根因与修改范围

用户录屏第 86 帧可见受保护的密友／密群，第 92 帧已移除。调查确认的缺口是原生 appearance 的 native index scope 被同步表格布局继承：`cellForDisplayPath:` 和 `forwardInvocation:` 在 native scope 直接查询原生 cell 与行数，绕过已经过滤的投影。因此即使策略已锁定，也可能先交付两条私密行，随后正常投影移除；先多出两行再移除也足以解释伴随的整体上移。

这不是把策略未知误判为 privacy=false。既有 runtime 初始和 epoch 边界使用 blocked 快照，投影对未知策略保持安全空内容。另一个需要守住的窗口是策略快照同步变更、通知异步送达：通知尚未送到时不能仅信任 pending flag，也不能让之前解锁状态的缓存可见 cell 留在首帧。Display scope 中 `currentPathForRow:` 已按当前策略拒绝新交付隐藏身份；旧缓存、旧数量和几何仍需在布局前处理。源码、原生静态证据与结论边界见 [调查记录](source-evidence.md)。

生产行为只新增可见布局边界：

1. `Hooks/SessionGroupHooks.xm`：在完整 `MainFrameTableView.layoutSubviews` 的 `%orig` 外调用适配器。叶类边界也覆盖原生 `MMTableView` 在 super layout 返回后的查询。
2. `Controllers/CSGroupListAdapter.m/.h`：新增 `performVisibleLayout:`，同步核对当前策略、账户和投影 privacy revision；未就绪时先用既有 shield 保护缓存敏感 cell，再通过既有 refresh 准备安全投影。事务内无法完成时跳过不安全布局。真正布局执行于 display index scope，退出前再次核对策略。revision 为零的既有安全空占位可以稳定复用，避免反复恢复／刷新。
3. `Controllers/CSGroupProjection.h`：只读公开既有 `privacyRevision`，未修改投影结构或算法。

2.1-26 的 `setPresentationSuspended:forController:`、2.1-27 的完整 `refresh` 和完整 `publishProjection:` 均与基线逐字一致，方法哈希记录在 [回归汇总](regressions/regression-summary.json)。密友隐藏／解锁规则、分组结构、滚动恢复、底栏、AI 和备份未修改。没有新增 reload 指令、延时、透明度或动画；真实结构变化继续使用原有 publication plan。另同步 control、版本头、内置发布说明和 README 的版本及交付入口。

## 红绿验证

新增回归使用真实生产的 Native scope、可见布局 hook／guard、策略、NativeBridge、投影过滤、身份映射、cell 交付、invocation forwarding、publication plan 和 list shield。Host refresh 的 admission/chrome/viewport 部分及 UIKit 原始 layout 为受控替身；每次原始 layout 都重新查询所有 cell，以覆盖同步重入。其边界在 [输入哈希记录](regressions/return-privacy-test-inputs.json) 中明确。

新增用例先在冻结的原版 2.1-27 上跑出失败，最终同一版测试输入哈希相同：**37 项中 12 项失败、25 项通过 → 修复后 37 项通过、0 失败**。覆盖锁定返回首轮交付、通知晚到的重新锁定、blocked 策略、安全空占位、事务内 shielding，以及解锁继续显示原有内容。

可重放旧代码控制：

```bash
bash Tests/verify-group-return-privacy.sh \
  docs/audits/release-2.1-28-closefriend-return-leak/regressions/CSGroupListAdapter.m-2.1-27.txt \
  docs/audits/release-2.1-28-closefriend-return-leak/regressions/SessionGroupHooks.xm-2.1-27.txt
```

只运行要求的核心范围：

| 套件 | 检查 | 失败 | 日志 |
| --- | ---: | ---: | --- |
| 新增返回隐私边界 | 37 | 0 | [旧版红](regressions/return-privacy-red.log)／[修复绿](regressions/return-privacy-green.log) |
| 页面返回、生命周期及顶部区域 | 239 | 0 | [日志](regressions/group-lifecycle-green.log) |
| 2.1-27 顶部首次发布 | 32 | 0 | [日志](regressions/group-launch-banner-green.log) |
| 分组切换及滚动位置 | 151 | 0 | [日志](regressions/group-viewport-green.log) |
| 搜索进入与返回 | 57 | 0 | [日志](regressions/group-search-green.log) |
| 密友／密群隐藏、解锁及身份映射 | 174 | 0 | [日志](regressions/close-friend-session-green.log) |
| 密友会话呈现 | 55 | 0 | 同上 |
| 合计 | **745** | **0** | [汇总](regressions/regression-summary.json) |

现有 close-friend-session 测试的提取器原先在全文件搜索第一个 `BOOL privacy`；新增方法后会截错。现改为先提取 refresh 再定位该语句。早先提取失败的日志单独保留，未计入旧代码的 12 项有效红项。

## 返回提交次数与未过滤中间态

下表将已有表刷新操作与测试布局采样分开；布局采样不等于 UIKit 内容事务或设备帧。

| 场景 | 表内容刷新操作 | 可见布局采样 | 首轮及后续内容 |
| --- | ---: | ---: | --- |
| 策略稳定、已锁定返回 | **0**，复用离页前安全投影 | 1 | 首轮即过滤后的 4 行；私密原生 cell 调用 0 |
| 策略稳定、已解锁返回 | **0** | 1 | 既有 6 行，保留解锁语义 |
| 离页重新锁定，通知尚未送达 | **1 次既有结构刷新** | 2 次同步采样 | 两次均为安全 4 行；私密原生 cell 调用 0 |
| 策略 blocked，随后 ready | **2 次既有结构刷新** | 4 | 空、空、过滤 4 行、过滤 4 行 |

策略真正改变结构时仍使用原有全表 publication 分支，没有把原先局部刷新替换为全表刷新；普通返回不重建列表。新增 guard 不写滚动位置，现有 viewport 回归通过。两条额外私密行不再先插入后移除，未另加位移补偿。

**首次提交是否过滤：**上述受控返回序列的首次内容交付已应用隐私过滤；未就绪时交付安全空内容或保留受保护的既有画面。**是否仍有中间未过滤内容：**所有覆盖序列均没有，锁定分支的私密原生 cell 构造调用为 0。不能把所有分支统一称为“只提交一次”：稳定返回 0 次刷新，重新锁定 1 次，blocked→ready 2 次。

**真机帧边界：**尚未安装 2.1-28 或采集修复后真机录屏，不能声称已经测得零泄露帧。用户视频的约 6 帧／0.2 秒是旧版现象证据；host 身份交付日志证明修复封住了回放中的未过滤通道，不测量 iOS 合成帧。

## 构建与产物校验

- [构建结果](build-result.json)：rootful、rootless 均在新临时目录编译，退出码 0，每包 arm64／arm64e，目标 iOS 15.0；没有运行 make clean。
- [生产输入对比](production-input-comparison.json)：42,513 份输入中仅上述四个行为相关文件及三处版本／发布元数据变化，共 7 份；其余 42,506 份不变，构建前后输入哈希一致。
- [警告对比](warning-baseline-comparison.json)：每方案 6 条，去除 ANSI 后与 2.1-27 的警告多重集合完全一致。既有 UILocalNotification 弃用 ×2、statusBarFrame 弃用 ×2、链接器 multiply_defined 过时 ×2，无新增警告。
- [历史保护](preserved-artifacts-after.json)：既有 `.theos` 与 `packages` 的 1,313 个文件没有修改、没有缺失；新目录未覆盖历史包。
- [包校验](package-verification.json)：版本、安装路径、payload/staging、注入目标、依赖、双架构、最低系统均一致，四份 dSYM UUID 匹配，符号 ZIP 内容及 CRC 通过。

## 交付

新目录：`packages/2.1-28-closefriend-return-leak/`。

| 文件 | SHA-256 |
| --- | --- |
| [com.wechat.improve_2.1-28_iphoneos-arm.deb](../../../packages/2.1-28-closefriend-return-leak/com.wechat.improve_2.1-28_iphoneos-arm.deb)（rootful） | `d7121ebbb9142e2e1be6598732327d7f772f2edb25e49ac3d72b8b88a0c18be1` |
| [com.wechat.improve_2.1-28_iphoneos-arm64.deb](../../../packages/2.1-28-closefriend-return-leak/com.wechat.improve_2.1-28_iphoneos-arm64.deb)（rootless） | `a6242d09c4919662359feb6ca73d71313096c1b8a19bd5fd5194849bf4a294c1` |
| [com.wechat.improve_2.1-28_symbols.zip](../../../packages/2.1-28-closefriend-return-leak/com.wechat.improve_2.1-28_symbols.zip) | `9e1d33ec6ae117cb68b1103a16ccfec9c1e03f4010b67cdf3c71ad6eecf2e70d` |

另有 [SHA256SUMS](../../../packages/2.1-28-closefriend-return-leak/SHA256SUMS)。保留原设备、注入方式、账号和真实数据进行安装后验收：锁定状态从其他页面返回，逐帧确认受保护会话首帧不可见，再检查解锁／再锁定、顶部两行、分组切换、搜索返回与滚动位置。
