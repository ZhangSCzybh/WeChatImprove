# 2.1-28：返回首轮过滤、卡片布局与滚动位置一致

日期：2026-10-30，Asia/Shanghai。沿用既有 checkout `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 与 `main`。本候选补充首批 2.1-28 `af84d15d85cb056e3b9f5ea409f1c161590bb011` 的布局恢复要求；旧代码红测基线仍为未修改的 2.1-27 `e9d4601c63fbfdeb11b208777ae9dc99f5f1c3c9`。未启动服务、切换环境、安装手机或修改账号／数据库。

## 根因与最小修补

用户同段视频的第 78 帧不只包含受保护会话，还显示选中 Group 分组之外的普通私聊、服务号／公众号；第 96 帧的置顶卡片成员、行位置已稳定。原版 2.1-27 的原生 appearance index scope 被同步布局继承，行数与 cell 绕过投影，是错误行集合、卡片边界和后续上移的共同来源。首批 2.1-28 已隔离此通道，但布局入口仍有两个准备窗口：

1. 离页使 adapter dirty、原生快照失效。策略版本相同不等于行集合已更新；若原生 appearance 在 attach 之前布局，旧投影的数量／占位／位置可能先被使用。
2. 原生 appearance 可先修改 inset／offset 再同步布局；原来的位置恢复在后续 refresh／finish 才完成。首批 2.1-28 虽能保护隐私，第一次完整布局仍可能停在临时位置。

本次只在 `CSGroupListAdapter.performVisibleLayout:` 增补 15 行净代码：有效返回位置记录存在且 dirty 时先同步消费原有 refresh；无法完成时不交付新的旧几何。完整 display-scope 布局前后复用既有 `presentationScrollHeight` 与 `restoreScrollHeight`，用当前过滤集合完成布局，再按最终 contentSize／inset 在同一次同步调用返回前收口位置。详细链路与两种圆角 hook 顺序见 [源码证据](source-evidence.md)。

没有修改分组投影、圆角／隐藏规则或滚动算法，没有新增 reload 指令、固定延时、透明度、动画或延时显示。真实结构改变仍沿用既有 publication plan，稳定返回不重建列表。2.1-26 的 `setPresentationSuspended:forController:`、2.1-27 的完整 `refresh` 与 `publishProjection:` 保持逐字一致；返回高度、夹取及圆角判定方法也未改。六个方法的原样哈希见 [汇总](regressions/regression-summary.json)。另更新内置 2.1-28 发布说明和推荐下载入口。

## 红绿与限定回归

新增独立布局套件保留首批 37 项隐私测试的历史证据。最终同一版布局测试分别控制旧 27、首批 28 与补丁，不更换断言／提取器：

| 源码 | 布局断言 | 通过 | 失败 |
| --- | ---: | ---: | ---: |
| 未修改的 2.1-27 | 861 | 251 | **610** |
| 首批 2.1-28 `af84d15d` | 861 | 691 | **170** |
| 当前补丁 | 861 | **861** | **0** |

861 是逐行、逐字段并覆盖两种 hook 顺序的断言数，不是 861 个独立用户流程。旧版失败同时覆盖身份、section、逐行 y／height、first／last 圆角角色和 offset。首批 28 的首轮 offset 为原生临时值 -25，稳定参照为 360；离页行插删／置顶改变时，也先出现旧结构。当前全部相等。

新增 fixture 使用真实选中的 Group 分组和三个 section，含业务行、置顶、普通群、密友／密群、非 Group 私聊及服务号／公众号。逐项对照生产投影所得稳定态，覆盖空 section、锁定／解锁、relock、blocked→ready、同 owner 同步重入、相同策略 revision 下行插删及置顶改变。普通锁定返回明确设 dirty=YES，证明离页失效但结构未变时仍不新增刷新。

真实执行索引作用域、NativeBridge、投影过滤、各 section 数量、高度调用映射、身份解析、`CSGroupCardPosition`、shield 与 viewport helpers。UIKit 的 y 累加、固定 section 间距和原生 fixture 行高是替身；refresh 的 admission/chrome 和圆角最终 paint repair 也有明确替身边界。两条真实 table hook 与真实 restore-depth wrapper 均执行。详细说明见 [测试报告](../layout-followup/test-report.md)；[同版输入与源文件哈希](../layout-followup/test-inputs.json) 和 [三份红绿布局日志](../layout-followup/) 可复核。

旧 37 项隐私 fixture 只新增无返回位置场景的 nil viewport 兼容方法，断言不变；同版在旧 27 上仍 12 红，当前 37 全绿。原首批日志及哈希未改。最终只运行指定范围：

| 套件 | 检查 | 失败 | 日志 |
| --- | ---: | ---: | --- |
| 返回首轮布局及位置 | 861 | 0 | [日志](../layout-followup/layout-fixed28-green.log) |
| 返回隐私交付 | 37 | 0 | [日志](../layout-followup/privacy-fixed28-green.log) |
| 生命周期与顶部返回 | 239 | 0 | [日志](regressions/group-lifecycle-green.log) |
| 顶部冷启动首次发布 | 32 | 0 | [日志](regressions/group-launch-banner-green.log) |
| 分组切换与滚动位置 | 151 | 0 | [日志](regressions/group-viewport-green.log) |
| 搜索进入与返回 | 57 | 0 | [日志](regressions/group-search-green.log) |
| 密友／密群隐藏、解锁与呈现 | 174 + 55 | 0 | [日志](regressions/close-friend-session-green.log) |
| 合计 | **1,606** | **0** | [汇总](regressions/regression-summary.json) |

## 首轮布局、内容刷新与中间态

两种圆角装饰 hook 顺序结果相同。这里的 originalLayout 计算次数是几何替身被实际调用次数；完整返回次数是完整叶类 hook 退出次数，二者都不是设备帧或 UIKit commit 数。

| 返回分支 | 原始布局计算 | 完整布局返回 | 内容刷新操作 | 首轮结果 |
| --- | ---: | ---: | ---: | --- |
| 稳定锁定，dirty=YES | **1** | 1 | **0** | 过滤后结构、行 y／高度、圆角、offset 与稳定态相等 |
| 选中分组有空 section／已解锁 | 各 **1** | 各 1 | **0** | 空 section 与解锁语义保持一致 |
| 同 owner 同步重入 | **2** | 2 | **0** | 两次完整结果均一致 |
| 离页 relock／同 revision 行插删置顶变化 | 各 **2** | 各 2 | 各 **1 次既有结构刷新** | 第一次就使用更新后的过滤集合 |
| 策略 blocked → ready | 分别 **2**，合计 4 | 同左 | 安全空与过滤结果各 **1 次** | 空→过滤，无未过滤或错误完整布局 |

**第一次布局是否已使用过滤集合：是。**普通返回计算一次；真实结构变化因既有 publication 内同步布局而有两次计算，两次均使用当前过滤后的结构，没有先计算未过滤集合再归位。

**布局和位置是否一次同步准备完成：是。**每个完整叶类布局返回时，section、每行 y／height、卡片 first／last 和滚动偏移均与稳定态逐项一致。测例稳定长列表 offset 为 360，安全空状态按原规则夹取为 -140。原生 layout 内部可能调整 contentSize／inset，最终校验在同次调用退出前完成，不依赖后续帧补偿。

**是否仍有中间错位帧：**受控测试没有中间未过滤交付或错误的完整布局结果。没有采集安装本候选后的真机录屏，不能把 host 结果表述为真机已实测零错位／泄露帧。

## 构建与保护

- [构建结果](build-result.json)：独立临时目录构建 rootful／rootless，两方案退出码均 0，每包 arm64／arm64e，最低目标 iOS 15.0。未执行 make clean。
- [警告对比](warning-baseline-comparison.json)：每方案 **6 条**，与 2.1-27 去除 ANSI 后的警告多重集合完全相同，无新增警告。
- [生产输入对比](production-input-comparison.json)：42,513 份输入相对首批 28 仅 adapter 方法和发布说明两份变化，其余 42,511 份不变；相对 27 累计仍为 7 份变化。构建前后输入哈希一致。
- [历史文件保护](preserved-artifacts-after.json)：既有 `.theos` 与 `packages` 的 **1,317 个文件**没有修改或缺失；首批 28 的两个包、符号 ZIP 和 SUMS 也 [单独按原哈希复核](first-delivery-preservation.json)。原包与原构建审计未覆盖。
- [产物验证](package-verification.json)：包元数据、安装路径、payload/staging、注入目标、依赖、双架构和最低系统均通过，四份 dSYM UUID 匹配，符号 ZIP 内容及 CRC 正确。版本头、control、内置说明均为 2.1-28。

## 推荐交付

为遵守“不动已有包”，新构建位于原指定目录内的新子目录 **`packages/2.1-28-closefriend-return-leak/layout-firstframe-candidate-1/`**。它与首批包的 Debian 版本同为 2.1-28，请按完整路径和哈希选择本候选。

| 文件 | SHA-256 |
| --- | --- |
| [com.wechat.improve_2.1-28_iphoneos-arm.deb](../../../../packages/2.1-28-closefriend-return-leak/layout-firstframe-candidate-1/com.wechat.improve_2.1-28_iphoneos-arm.deb)（rootful） | `40d96b523f6235fb63c6e374e87912c12cbf457f6a651e4050089a0214e8bbca` |
| [com.wechat.improve_2.1-28_iphoneos-arm64.deb](../../../../packages/2.1-28-closefriend-return-leak/layout-firstframe-candidate-1/com.wechat.improve_2.1-28_iphoneos-arm64.deb)（rootless） | `af583dc884fbb4c87f740fab59c80d9b390ab4f2529920faa61c78893eec9442` |
| [com.wechat.improve_2.1-28_symbols.zip](../../../../packages/2.1-28-closefriend-return-leak/layout-firstframe-candidate-1/com.wechat.improve_2.1-28_symbols.zip) | `5164f0bd25523b36e97fab56641ad3bd77effc165d964483a680cdf694610454` |

另有 [SHA256SUMS](../../../../packages/2.1-28-closefriend-return-leak/layout-firstframe-candidate-1/SHA256SUMS)。沿用原设备、注入方式、账号与真实数据进行最终视觉验收；未自动安装或重启微信。
