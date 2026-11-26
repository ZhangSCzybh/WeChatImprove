# WeChatImprove 2.9-10：首滑真机日志定位与正式修复

日期：2026-11-26。已先完成 Rootless／Rootful 正式包、fat dylib、symbols.zip 和 SHA256SUMS，再写本报告。两版修复效果均为 **真机未验证**；2.9-9 日志中的已发生事件与宿主验证结果分开陈述。

## 1. 结论与输入完整性

**主要阻断是未消费的 `presentationViewport`，不是必须先竖滑才能生成快照。** 该段真机返回流程只有 will-appear 记录，没有进入已埋点的 did-appear 完成入口；`presentationReturnFinished` 持续为 false，独立 return key 未建立。已有 `preparePageSourceForPan` 虽被调用，却在“存在 presentationViewport 且返回未完成”处提前退出，因而不能消费已恢复高度的返回请求，也不能在该返回准备范围内刷新 dirty 来源。转场 begin 随后被 pending 或 dirty 拒绝。

最直接的同一次返回、同来源同目标对照为 **G13 → 竖滑 → G14（分组索引 2→1）**：#2371/#2375 明确拒绝 `self.presentationViewport`；#2381→#2383 的 `vertical.before/after` 将 `requests.presentation.present` 从 1 清为 0，offset 此刻仍为 `{0,-98}`，dirty 和 layout-held 都没有被清理操作改变；随后 #2626 的转场准备成功。这是 pending 清理的运行证据，不是仅靠源码猜测。

另有独立失败 G3：竖滑后已经通过 adapter 准入并得到非 nil outgoing，但短目标列表把滚动位置钳回顶部，分组栏重新进入可视区，incoming 的可视区域由 `{{0,98},{430,834}}` 变为 `{{0,150},{430,782}}`，被严格 frame guard 拒绝。这一条解释了 incoming entry 比 result/ready 多一次，以及唯一一次 `horizontal.capture_suppressed`；不能混入 G1/G13 的 pending 故障。

输入为任务书指定的归档文件：

`/Users/zhangshichao/Documents/Workspace/WeChatImprove-local-archive/audits/2.9-10/first-swipe-diagnostic.jsonl`

完整解析 **2,918 行／9,592,674 bytes**，单 session，sequence 连续 1–2918，sample_uptime 非递减，带该字段的记录均为主线程。末尾 #2918 `export.status`：`written_records=2917`（不含 status 自身）、`queue_dropped=0`、`size_limit_dropped=0`、`pending_after_export_barrier=0`、`io_error=0`；数据未触及 16MiB／128 入队限额。就此次导出屏障之前的已入队记录，没有队列／大小截断证据；这不代表采集开始前或导出后的行为也被记录。

按 definitions 解释：event/reason 记录原短路表达式的第一个实际拒绝条件；状态相同的记录会去重，因此 event 数不是回调数。account/policy 是原业务读取后的保留观察，带 read uptime，不能把辅助快照当作 guard 当下新增读取或证明所有后续 guard 都已经执行。sample_uptime 是回调采样时间，不是物理抬指时刻、帧耗时或卡顿测量。报告与派生证据均不包含聊天正文、账号／分组原始标识或像素数据。

## 2. 按 sequence 重建的 15 次横滑

用同一个 adapter owner（`0x145214900`）的 `horizontal.began` 到 terminal 划分手势；再按该区间的 animator owner、begin/result、incoming、确认／rollback 状态关联转场。分组索引为当次日志数值，0 起算，不是聊天或分组名称。返回边界采用实际 `return.will_appear` sequence，不能使用一直为 0 的 `comparison.return` 硬拼多次返回。时间相对 #1，单位秒，仅用于时序。

“准备成功”指有 `transition.begin.result / prepared` 且 incoming 已 ready，不能据此宣称真机每一帧视觉正常。“确认选择”有 `selection_accepted=true` 记录；“取消回弹”有 `rolling_back=true` 记录，不当作截图失败。

| 手势 | began–terminal sequence | 相对时间 | 所属最近 return | 来源→目标 | 日志走向 | prepared sequence | 首个阻断／补充 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| G1 | #180–#194 | 6.186–6.502 | #122 | 2→3 | 准备失败／回退原路径 | — | presentationViewport；后遇 dirty |
| G2 | #226–#262 | 7.837–8.103 | #122 | 3→2 | 准备成功、确认选择 | #257 | — |
| G3 | #622–#680 | 14.314–14.458 | #310 | 2→3 | 准备失败／回退原路径 | — | incoming 可视区不一致；attemptedTarget |
| G4 | #709–#747 | 15.945–16.093 | #310 | 3→2 | 准备成功、取消回弹 | #742 | — |
| G5 | #775–#811 | 16.610–16.743 | #310 | 3→2 | 准备成功、确认选择 | #806 | — |
| G6 | #913–#923 | 19.731–20.080 | #859 | 2→1 | 准备失败／回退原路径 | — | dirty（来源准备先被未完成返回挡住） |
| G7 | #952–#988 | 20.747–20.847 | #859 | 1→2 | 准备成功、确认选择 | #983 | — |
| G8 | #1016–#1052 | 21.180–21.230 | #859 | 2→3 | 准备成功、确认选择 | #1047 | — |
| G9 | #1080–#1116 | 21.715–21.797 | #859 | 3→2 | 准备成功、确认选择 | #1111 | — |
| G10 | #1692–#1730 | 28.275–28.856 | #1164 | 2→1 | 准备成功、确认选择 | #1725 | — |
| G11 | #2140–#2178 | 31.560–32.407 | #1164 | 1→2 | 准备成功、取消回弹 | #2173 | — |
| G12 | #2206–#2242 | 33.858–33.957 | #1164 | 1→2 | 准备成功、确认选择 | #2237 | — |
| G13 | #2366–#2376 | 41.603–42.043 | #2290 | 2→1 | 准备失败／回退原路径 | — | presentationViewport |
| G14 | #2593–#2631 | 43.663–44.298 | #2290 | 2→1 | 准备成功、确认选择 | #2626 | — |
| G15 | #2659–#2695 | 45.014–45.162 | #2290 | 1→2 | 准备成功、确认选择 | #2690 | — |

共 **11 次完成转场准备：9 次观察到确认选择，2 次观察到取消回弹（G4/G11）**；4 次未完成准备（G1/G3/G6/G13）。12 次 `animator.cancel` 包含正常完成或回弹后的移除，不能全部算失败。

G1/G6 虽无页面转场，结束后仍可走原有分组选择／刷新；G2/G7 的来源索引相应改变，并且不先竖滑就可准备成功。因此“每次都必须竖滑才能有动画”不是日志结论。G3 则是先竖滑后仍失败的另一问题。最有力的 pending 对照是 G13/G14，不将不同返回、不同目标的状态拼成 A/B。

有 19 次 should-begin、15 次 began/first-update/terminal；未进入 began 的方向判断不能当作一次已识别横滑失败。15 对 vertical.before/after 有短时重复入口，按其实际 sequence 比较状态，不把 15 条入口计成 15 次物理竖滑。

## 3. 主因的 event、reason 与状态证据

### 3.1 G1：准备先被 pending 挡住，后又 dirty

- #179／#182／#187 `event=preparePageSourceForPan`，`reason=(self.presentationViewport && !self.presentationReturnFinished)`。
- #185／#189 `event=beginSwipePageTransitionToIndex:direction:`，`reason=self.presentationViewport`。
- #185：`requests.presentation.present=1,height="0",generation=0,epoch=3,generation_matches=1,account_matches=true,tab_matches_published=true`；`flags.return_finished=false,dirty=false,session_layout_held=false,initial_pending=false`；`requests.return_key_present=0`。
- 高度并非零宽／未布局：table frame 为 `{{0,0},{430,932}}`，offset `{0,-98}`，adjustedInset.top=98，保存 height=0 对应的实际高度也为 0。#175 已进入高度恢复，#176 后 presentation 仍保留，符合“高度接受了，但返回未完成不能消费”的路径。
- #190 之后 dirty 变 true，#193 的第一个拒绝理由变为 `self.dirty`；#191 的来源准备仍被同一未完成返回挡住。不能把 #193 的 dirty 倒灌成 #185 的首个原因。

46 次 source.prepare.entry 对应 46 次 selector 拒绝：10 次未完成返回、25 次既无 completed return 也无 accepted switch、11 次已有 animator；没有 source.prepare.exit。这说明上版增加调用时机实际执行了，但日志命中的返回仍未获准进入准备体，继续追加调用次数不能解决它。

### 3.2 G6：dirty 的直接拒绝与上游原因分开

#912／#915／#920 来源准备仍是上述未完成返回 guard；#918／#922 转场 begin 的第一个拒绝为 `self.dirty`。此时 presentation.present=1、return_finished=false、return_key_present=0，viewport generation=3，session_layout_held=false。修复应在合法返回准备内实际刷新来源，不能直接把 dirty 或 layout-held 置 false。

### 3.3 G13 → 竖滑 → G14：同方向可用性对照

| 状态 | #2371 G13 拒绝 | #2381 vertical.before | #2383 vertical.after | #2597 G14 begin.entry |
| --- | --- | --- | --- | --- |
| presentation.present | 1 | 1 | **0** | 0 |
| presentation.height | "0" | "0" | null | null |
| return_finished | false | false | false | false |
| return_key_present | 0 | 0 | 0 | 0 |
| viewport generation | 12 | 12 | **13** | 15 |
| dirty | false | false | false | false |
| session_layout_held | false | false | false | false |
| initial_pending | false | false | false | false |
| contentOffset.y | -98 | -98 | **-98（尚未移动）** | -33.6667 |
| 已观察 projection_valid／account_matches | true／true | true／true | true／true | true／true |
| 已观察 policy_blocked／layout_proof_present | false／1 | false／1 | false／1 | false／1 |

G13 #2371/#2375 的 event 均为 begin selector、reason 均为 `self.presentationViewport`。#2383 清除请求时 offset 尚未移动，直接证明解锁量是 pending 及其定位代次，而非必须先滚出某个 y 值才能捕获。随后短时重复入口使 generation 到 15；#2626 `transition.begin.result / prepared`、#2634 观察到 selection_accepted。return_finished 一直 false，没有被竖滑“修成 true”。

8 条 return.will_appear 覆盖多次返回，但整个采集区间无 `return.did_appear.before/key/after`；`comparison.return=0`、return key 缺失与此一致。可以确认该诊断入口在记录范围内未进入，**不能仅凭日志确定宿主为何缺少这条生命周期回调**。本版使用已准入的真实横滑作为安全兜底完成条件，不再依赖那个未到达的回调。

## 4. 独立的 incoming 失败与 attemptedTarget

G3（#622–680）不可与 G1/G13 合并：

1. #626 开始转场；#628 `snapshot.outgoing.result / snapshot_non_nil`，#629 animator.begin.ready。原 table bounds 为 `{{0,31.6667},{430,932}}`，stored/source viewport=`{{0,98},{430,834}}`。
2. 邻页发布后 #634 的 content_size.height 约 638.630，原高度无法由短内容承载。#639 实际 table layout 后 bounds/offset 变为 `{{0,-98},{430,932}}`／`{0,-98}`。table、rail、host、window 身份均未换。
3. #648 `animator.incoming.entry`；#649 `event=matchesTable:belowView:`，`reason=false: CGRectEqualToRect(self.viewport,[self visibleFrameForTable:table belowView:rail])`。state 中 table_matches、rail_matches、host_matches、window_matches、overlay_host_matches 全为 1，`frame_matches=false`；stored_viewport 为 y98/h834，current_visible 为 y150/h782，底边均为 932，差 **52pt**，与分组栏高度一致。
4. #650 `prepareIncomingWithTable:belowView:readiness:` 被 `![self matchesTable:table belowView:rail]` 拒绝，尚未调用 incoming snapshot；#652 adapter 收到 incoming 准备失败并回退。
5. #674 `horizontal.capture_suppressed / attempted_target_latched`，attempted_target_present=1、animator/context/preview 均已清理。它属于 G3，不属于 G1/G13。锁住的是该次真实捕获尝试的同一目标，保留锁可以避免一轮手势反复捕获；本版不删除该保护。

实际 12 次 outgoing result 和 11 次 incoming result 全是 non-nil。incoming entry=12、result=11、ready=11 的差值正由上述捕获前 geometry guard 解释，没有证据说丢了一张返回记录、首次快照 nil 或竖滑建立了全局截图缓存。export 的 dropped 均为 0，但相同状态去重仍适用。

## 5. 对上轮五个候选的落地判定

| 上轮候选 | 本次证据结论 |
| --- | --- |
| 几何／尺寸／内容未初始化 | 主故障没有零尺寸或缺失 window。另有 G3 的真实短列表滚动钳制与顶部可视区域变化，成立且单独修复。 |
| 首滑 early-return | **成立，已命名具体 guard**：来源准备被 unfinished presentation 拒绝；begin 被 presentation 或 dirty 拒绝。 |
| 竖滑清掉／改变状态 | **直接证明清掉 presentation pending**，并递增 viewport generation；同对快照 dirty、layout-held 未变化，不把它们误写成直接清零。 |
| 首次快照未就绪／attemptedTarget | nil／全局缓存解释无证据；G3 几何 guard 与随后的 attemptedTarget 抑制成立，属于下游独立失败。 |
| 冷启动与返回差异 | 失败手势 initial_pending=false，不是本轮主阻断。没有删冷启动保护。did-appear 完成入口未进入使返回请求无法消费是实际缺口。 |

这些手势的 proofs.native_mode=false，不能把 native_account_matches=false 当作原生 coordinator 失败；该分支并未在本组手势启用。本轮不改 coordinator 的准入／账号／隐私逻辑。

## 6. 本轮最小修复与文件范围

相对本轮开始只改以下六个已有文件，`changes.diff` 以起点文件生成，未将此前未提交改动误当成本轮工作：

| 文件 | 修改 |
| --- | --- |
| `Controllers/CSGroupListAdapter.m:2883–2956` | `preparePageSourceForPan` 增加 gestureReturn：仅 Began/Changed 的已准入分组横滑且保存视口仍满足账号／epoch／generation／height 有效性时，允许进入原返回准备。沿用原策略、模型、搜索、菜单、原生交互、table/controller/pending 身份复验；实际刷新来源并请求真实布局后才标记返回可消费，调用原 restorePendingViewport。拒绝的高度恢复保留请求，不直接清 pending／dirty／held。 |
| `Controllers/CSGroupPageAnimator.m:21–24,199–234,254–301` | 缓存捕获时的外部几何；仅 scroll bounds.origin.y 改变而同一 table/rail/host/window、frame、尺寸、rail bounds、host/window bounds 和 adjustedInsets 均稳定时，允许把 outgoing 的原像素平移裁剪到较小共同视口。不缩放、不重拍 outgoing，不改变横向运动曲线。取消恢复长来源时继续校验共同区域仍完全可见；外部变化或覆盖区域再缩小仍拒绝。保留 capture 前后 identity/generation/readiness 与减弱动态效果检查。 |
| `control` | Version=2.9-10。 |
| `Headers/CSUserInfoHelper.h` | kPluginVersionString=2.9-10。 |
| `Controllers/CSReleaseNotesViewController.m` | 新增正式版说明，不宣称设备已验证。 |
| `README.md` | 版本、正式包入口和本版范围。 |

横滑兜底不会在被动布局、仅 possible 的方向判断或竖滑上执行；不把“没有任何返回／切换请求的普通 dirty”当作可以强行刷新的情况。真实定位代次或账号变化、搜索与新 table 替换仍使旧请求失效。冷启动仅在已确认的后续横滑命令具有有效返回请求时沿用原取消初始定位流程，普通启动分支保持。

G3 的修复保留安全含义：共同区域必须是已有 outgoing 像素的子集，且 current visible 的底边、宽度和 x 一致；只裁去被重新出现的分组栏遮挡的顶部。回弹时来源可视区可扩大，但不扩张已捕获像素，只验证原共同区域仍被当前可视区完整包含；旋转、inset、frame、host/window、rail 变化均不能套用该例外。裁剪后每次 matches 校验也强制要求外部几何保持稳定；即使窗口裁切使 visible frame 恰好仍相等，table 或 window 的宽度变化仍会拒绝。不是将 frame guard 一律改成 YES。

诊断采用**正式包默认关闭**方式：诊断源码保留在 `#if defined(CS_GROUP_FIRST_SWIPE_DIAG)` 后，Makefile 不默认定义它，两方案构建均显式 `-UCS_GROUP_FIRST_SWIPE_DIAG`。实际二进制检查 `CSFirstSwipeRecord`、`CSFirstSwipeExport`、日志队列标记和 `cs_firstSwipeEvent:` 均为 0；Other Settings 诊断行及落盘逻辑未进入正式包。没有恢复或新增诊断偏好键。

`Controllers/CSMessageMergeAdapter.m` 本轮前后 SHA-256 完全相同；语音转文字合并未动。Hooks、coordinator、Other Settings 和既有诊断文件本轮保持起点，未回滚此前未提交改动。未改转场 duration／曲线、距离／速度阈值或指示器。

## 7. 回归与状态回放

基线直接读取 `packages/2.9-8/core-gates-results.json`，没有重建历史包、改变断言或制造通过。该归档的六项基线全部 exit=0；较早版本的两个红灯不属于这份基线，本轮按实际归档比较。

| 核心门禁 | 2.9-8 | 最终 2.9-10 | 新失败 |
| --- | --- | --- | --- |
| tabbar | PASS | PASS | 0 |
| settings-tab-bar | PASS | PASS | 0 |
| settings-home | PASS | PASS（803 模型 + 227 控制器检查） | 0 |
| moments-card | PASS | PASS（73,467 几何 + 113 配置检查） | 0 |
| moments-share | PASS | PASS（103 检查） | 0 |
| plugin-header-entry | PASS | PASS（35 检查） | 0 |

**new_failures=0**。`core-gates-results.json` 保留逐项退出码和日志路径。七项分组专项也通过：page-lifecycle 182、page-animator 84、interactions 191、initial-viewport 105、native-preview 209、search 163、indicator 183。最终源码修改后已重跑，未改 Tests 中任何断言。

临时回放放在本轮系统临时目录，复用原有桩及抽取器，只额外编译宿主入口，不写入 Tests、不注册默认回归：

- lifecycle：原 182 + **额外 16 项** = 198 checks，0 failures。复现无 didAppear 的有效 pending、dirty 来源、拒绝 offset 保留、刷新期间不提前消费；并检查账号、策略、epoch、generation、菜单、suspended、search、native-boundary 与普通冷启动不能绕过。
- animator：原 84 + **额外 15 项** = 99 checks，0 failures。用日志的 430×932、y31.6667→−98、viewport y98/h834→y150/h782，验证 outgoing 向上偏移 52pt、不缩放／不重拍、四分之一横向进度不变；恢复长来源仍能动画取消并清理；inset、rail、宽度、host/window 和首次捕获区域扩张均拒绝；额外覆盖裁剪后 table 宽度变化被窗口裁切掩盖、window bounds 宽度变化两项。
- 临时 lifecycle 探针曾因同时观察来源刷新和后续目标预览刷新而误报 1 项；将该探针限定为一次来源回调后重跑通过，未修改生产门禁或既有桩／断言。保留初次及最终回放日志，最终结果见 `lifecycle-replay-final.log` 和 `animator-replay-final.log`。

Tests 的实际文件数 **468→468**（包含两个隐藏文件）；`rg --files Tests` 口径 **466**。开始和结束的 `git diff --binary -- Tests` 摘要一致，且为无改动。没有沿用过时的 426 数字。记录见 `environment-integrity.json`。全部是宿主验证；不等同于修复后的真机首滑、视觉或触感通过。

## 8. 正式构建、包与校验

最终命令形态：

```sh
make -j6 package SCHEME=<rootful|rootless> \
  _THEOS_LOCAL_DATA_DIR=<本轮临时目录>/build-<scheme>-v2 \
  _THEOS_SWIFT_AUXILIARY_DIR=<本轮临时目录>/swift-<scheme>-final2 \
  THEOS_PACKAGE_DIR=<项目>/packages/2.9-10 \
  PACKAGE_VERSION=2.9-10 PACKAGE_BUILDNAME= \
  ADDITIONAL_CFLAGS=-UCS_GROUP_FIRST_SWIPE_DIAG KEEP_LOGOS_INTERMEDIATES=1
```

两方案均为 Release／FINALPACKAGE，最终退出 0。各架构完整构建与最终增量编译并集为 298 个源码单元；完整构建各 8 条 warning，最后增量构建各 2 条链接器 obsolete warning，最终 0 编译错误，不表述为零警告。

期间首次 Rootful 的 Theos 自删 Logos `.xm.mm` 被宿主拒绝 `Operation not permitted`，退出 2；改独立目录并保留 Logos 中间文件后成功。一次 Rootless 复用目录又在 Theos 清理自身 `swift` 辅助目录时遭同类拒绝；保留失败记录，换独立目录，最后增量使用独立 Swift 辅助路径完成。未执行 clean、未删除历史包或旧临时树。

| 环境／产物 | 路径 | arm64 UUID | arm64e UUID |
| --- | --- | --- | --- |
| Rootless | `packages/2.9-10/com.wechat.improve_2.9-10_iphoneos-arm64.deb` | `C62DE5D8-7E32-3FD1-9524-1C84DE442F87` | `7029A94B-F7AF-3D7F-A219-43AF908A564A` |
| Rootful | `packages/2.9-10/com.wechat.improve_2.9-10_iphoneos-arm.deb` | `EE2EB6B2-C937-3F82-897F-F2B2D3D99255` | `B7E9ABCD-41B2-358A-A868-4F51C04B607F` |
| fat dylib | `packages/2.9-10/WeChatImprove.dylib`，与 Rootful 包内库一致 | 同 Rootful | 同 Rootful |
| symbols | `packages/2.9-10/symbols.zip` | 两方案各自 arm64 dSYM 匹配 | 两方案各自 arm64e dSYM 匹配 |

包 ID、精确版本 2.9-10、架构、安装路径、两 slice 最低 iOS 15.0、动态库与最终构建对象一致、注入 plist 与源码语义一致、诊断标记缺失、四份 dSYM UUID、ZIP CRC 均已检查。`artifact-validation.json` 有机器记录。

`packages/2.9-10/SHA256SUMS` 覆盖两个 deb、fat dylib、symbols.zip、包 README 与 core-gates JSON 共六项，**六项全部 OK**，日志为 `logs/sha256sum-check.log`。仅校验本版产物，没有对历史包或 local-archive 做全量哈希。历史目录没有写入动作。

## 9. 真机未验证项与验收步骤

日志已经证明的是 **2.9-9 的拒绝原因与竖滑前后的状态变化**。修改后的真实触摸延迟、首帧绘制、取消回弹连续性、原生布局时机和安全边界运行效果均为 **真机未验证**，不能用宿主通过或 UUID 检查代替。

1. 在原设备、原账号、原分组配置、原注入环境安装对应 2.9-10，重启微信；保留原页面转场开关设置。确认其他设置不再出现诊断导出行。
2. 从原会话或其他 tab 返回首页，不先竖滑，立即同方向横滑；分别覆盖原索引 2→1 的长列表对照及返回后来源有新消息／dirty 的情况。确认第一次拖动已有转场，而不是仅结束后切组。
3. 先竖滑到分组栏可随列表位置变化的高度，再进入短相邻列表，确认此前 y98→y150 的可视区域变化不再使转场消失；做不足阈值取消、快速反向与连续快滑，检查回弹时没有拉伸、错位或残留遮罩。
4. 核对右侧 15% 原生菜单区、长按菜单、搜索返回、其他 tab 返回、table 重建、系统减弱动态效果和冷启动定位；账号／隐私变化时应即时清理旧像素，不能为了动画突破边界。

如仍有异常，应回传按次标记的复现视频和路径；本正式包默认不记录首滑 JSONL。当前没有修复后设备日志，故本报告不声称设备问题已获确认解决，也不提供帧耗时结论。
