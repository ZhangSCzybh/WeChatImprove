# 2.2-3：小程序返回前的隐私闸门

基线：`faa294ff12ff17eab7336c0802693d968923154d`（2.2-2）。本轮在该基线上增量修复，没有回退或重新执行历史回退核验。最终核对时共享工作树 HEAD 已推进为 `ad031947f858dc55a3f09792964d47c707c91dc4`（本轮 2.2-3 提交）；生产源码与本轮测试、构建记录的 SHA256 仍一致，基线对照继续使用 faa294ff。

## 结论与证据边界

源码已确认的缺口是：**2.2-1 的隐私闸门只拦截 table 内容布局；覆盖层直接揭露已有 cell、期间没有内容布局时，旧内容没有进入任何可见前校验。** 2.2-2 缓存只减少这个既有闸门的扫描次数，没有增加“即将可见”入口，因此没有消除这个时间窗。另一个已由宿主测试重现的漏口是 inactive adapter 搭配有效安全投影时，旧 ready 判断允许布局，但代理仍会在 inactive 时使用 native 数据。

本轮增加三个真实小程序退场入口，在 `%orig` 前同步校验并中性化无法证明安全的已有 cell；普通布局不能提前解除中性态，恢复仅走正式过滤发布流程。九套既有回归 2,595 checks / 0 failures；两套缓存测试 333 / 0；新增首帧测试 56 / 0。最终绿测合计 2,984 / 0。双架构构建与包校验通过。

**没有连接真机取数。** 真实回调序列、isActive 值、UIView 身份、原生截图合成和屏幕中间帧均未验证。以下次数属于执行生产方法的主机替身测试，不是帧 133–168 的设备计数。三个入口是否先于该设备第一可见帧，需要安装后复录确认；本报告不把宿主通过写成设备首帧已验收。

## 录屏时间线

下表直接引用用户已完成 signalstats 与人工核对的事实，本轮没有把它表述为重新进行的设备采样。原素材与四张关键帧保留在 `docs/feedbacks/`，未修改。

| 原始帧 | 时间 | 已知屏幕事实 |
| --- | --- | --- |
| 0–132 | 0.00–4.40s | 肯德基小程序覆盖列表 |
| 133 | 4.43s | 小程序向下退场，列表开始露出 |
| 152 | 5.07s | Pero. 隐私行可见 |
| 168 | 5.60s | Pero. 与隐私群完整可见；第 4 行仍是另一份旧内容 |
| 175 | 5.83s | 隐私行消失，第 4 行换成另一份内容 |
| 200 | 6.67s | 与 175 稳定态一致 |

隐私行可见区间约为 152–174，共 23 帧 / 0.77s；完整露出后约 0.23s。行内容整体不同，支持“先揭露旧内容、后替换集合”的判断，但单凭录屏不能证明具体 cell 指针或某个 refresh 的堆栈。

## 五个根因方向逐项核对

以下旧行号均对着 `faa294ff`，完整出处和入口 class dump 证据见 [visibility-entry-evidence.md](visibility-entry-evidence.md)。

1. **已有内容揭露：成立于屏幕事实与静态可达性。** 帧 168 与 175 行内容不同；基线没有 miniapp 可见前 gate。父容器动画可以直接露出原 table，不要求重新交付 cell。真实 cell 身份未测，因此不宣称指针身份已确认。
2. **`:652` 的 `!isActive && !privacy` 早退：privacy=true 不会命中。** 不能把它直接当作“开启隐私仍无条件放行”的原因。`isActive` 返回 `projecting`（基线 `:507`），suspended 方法不把它设成 NO；天然小程序路径的 isActive 值未知。真正重现的附加漏口在后续 ready：它原来不要求 active，安全 projection 与 inactive native passthrough 可以组合出原生未过滤布局。本轮要求 active；未知 hideSessions、账号不匹配也不能走 native 快捷布局。
3. **`:1154` 原生索引 shortcut：存在，但不是已确认的小程序入口。** 该方法用于显式选会话/上下条导航，现有调用者先检查 active。收紧隐私开启或未知状态下的 inactive shortcut，并沿原动作队列刷新，防止重入状态下 native 放行；没有把它宣称为本录屏必经路径。
4. **零次内容布局：基线确有漏口，实际帧间次数未知。** `performSessionListLayout:` 的唯一入口是 `MainFrameTableView -layoutSubviews`（基线 Hooks `:368`）。纯容器揭露可以零次调用，新增测试正是零次内容 layout；没有声称帧 133–168 的真机调用次数已采到。
5. **晚到刷新：与屏幕更换内容相符，实际调度点未知。** 基线 refresh 在 suspended 且无导航动作时延后（`:839–841`），正常 refresh 构造过滤投影后再 publish（`:905–940`）。这可以解释事后才切换，但缺少真机堆栈，不能写成“已测到某毫秒触发 refresh”。修复把保护放到原退场处理前，不再要求事后布局才能保护已有内容。

## 改动与发布边界

### 真实可见前入口

三个 hook 均先同步调用 `+[CSGroupListAdapter prepareForListVisibility]`，再执行 `%orig`：

| 类 / 方法 | 当前基线已有定义 | 用途 |
| --- | --- | --- |
| `WAAppDismissAnimateTransition -animateTransition:` | `HeadersFile/WAAppDismissAnimateTransition.h:28` | animator 开始原始退场处理前 |
| `WAAppTansitionController -onMiniTaskDismissalGestureWillBegin` | `HeadersFile/WAAppTansitionController.h:117` | 交互下滑退场开始前 |
| `WAAppTansitionController -sheetDismissalTransitionWillBegin:` | `HeadersFile/WAAppTansitionController.h:52` | sheet 退场开始前 |

类名和 selector 均来自现存 class dump。没有广泛铺设其它猜测入口，也没有假定所有设备都必经这三个入口。

### 保护与恢复

- 前置 gate 同时验证当前策略、账号/epoch、投影有效性与 privacyRevision、retry 状态，以及实际 visibleCells 的交付记录、行身份和会话隐藏规则。不能仅凭“projection 安全”认定已有 native cell 安全。
- 账号/策略/键未知、blocked、投影或交付记录不匹配时，复用既有 shield **整批中性化当前可见 cell**，不单独挖去某几行。没有新增遮罩截图、动画、等待时间或整表刷新；table 的 contentSize、inset、offset、滚动及手势属性不被 gate 改写。
- 前置 hold 使用 adapter 的进程内 associated object。普通后续 layout 不能提前恢复旧 cell；必须在已知 hideSessions 的正式 publishing 阶段才允许过滤后的内容布局。正常完成后清 hold，继续原发布流程。
- 未知 hideSessions 在新可见边界始终 fail-closed：即使发生 publishing layout 或 finished 收尾也不解 hold，等待已知策略事件与安全 refresh。2.2-2 既有“无可见 hold 时，未知类型走全扫、不缓存”的测试契约保持；没有为此改旧断言。
- `performInNativePresentation:` 对隐私+inactive 动作保留账号/epoch guard，改走现有导航动作队列和 refresh，避免收紧 shortcut 后动作永久滞留。隐私规则、解锁语义、投影行集合和几何算法未改。
- 稳定 active 布局继续使用 2.2-2 的准入证明；没有在每次 layout 加入 visible-cell 扫描。前置检查只在上述退场入口发生。

### 文件与行数

本轮实现、版本与测试共 10 文件，新增 340 行、删除 14 行；运行时代码三文件共 +67 / -5。审计文件与既有 Finder `.DS_Store` 变化不计入。逐文件基线/当前 SHA256 见 [source-change-inventory.json](source-change-inventory.json)，完整范围见 [changes.patch](changes.patch)。

| 文件 | 新增 | 删除 |
| --- | ---: | ---: |
| Controllers/CSGroupListAdapter.h | 2 | 0 |
| Controllers/CSGroupListAdapter.m | 54 | 5 |
| Hooks/SessionGroupHooks.xm | 11 | 0 |
| Controllers/CSReleaseNotesViewController.m | 3 | 0 |
| Headers/CSUserInfoHelper.h | 1 | 1 |
| control | 1 | 1 |
| README.md | 7 | 7 |
| Tests/GroupSearchTests.m | 1 | 0 |
| Tests/MiniappFirstFrameTests.m（新增） | 189 | 0 |
| Tests/verify-miniapp-first-frame.sh（新增） | 71 | 0 |

既有 Tests 唯一改动是 GroupSearchTests 增加 `<objc/runtime.h>` import，以编译提取的完整 refresh 方法中的 associated-object 调用；没有改任何既有断言。没有修改 shield 实现、圆角、底栏角标、AI、备份或密友规则。没有重新带回 2.1-21～2.1-31 的实现。

## 受保护定义逐字节核对

四项全部与 HEAD 基线逐字节相同。下列 SHA256 的 baseline/current 两列完整值另存 [protected-blocks-comparison.json](protected-blocks-comparison.json)，修改前文本与哈希见 [protected-blocks-before.json](protected-blocks-before.json)。`verify-source.py` 会重新从 `git show faa294ff:path` 核对。

| 定义 | 基线与当前共同 SHA256 | 结果 |
| --- | --- | --- |
| projectionForSections: | `c6a58fc7e5e446563e0cf2de6c08fd4daeed515d5c61fbfe06c5ed286f04be8c` | 相同 |
| publishProjection: | `715e977c1bb1ea4a0b05b63fe617349e41be5686f7567552ab56ce48a69d8d3b` | 相同 |
| +setPresentationSuspended: | `ce9d77decc5c6bffa604b663a9f0393b41609de7a427c80655226d6fc77d281d` | 相同 |
| performSessionListLayout: ready-NO 块 | `55d2a855a93ce8736264525eb7aeb89a210c4fe19c3606e55978e4b78d2f6800` | 相同 |

原 publisher 内既有 reloadData 条件保持原样。本轮没有新增强制全表 reload；不能把宿主恢复替身的 reload=0 延伸成“真机所有既有发布路径永远不会 reloadData”。

## 红绿测试、计数与回归

### 新增测试

最终同批 56 项断言：**未修改 2.2-2 为 56 / 23；本轮为 56 / 0**。红色失败不计入成功数。旧输入由 `git show faa294ff:path` 逐文件导出在工作树外，红色 provenance 中 adapter SHA 为 `82e96b805c63593b036804ca46159de95e44b15c3dfb59f6377ebc0b423c8ec8`，与该 commit 一致。完整失败断言、原始记录和当前源码哈希见 [miniapp-first-frame-results.json](miniapp-first-frame-results.json)。

过程说明：最初 43 checks / 18 failures 在生产改动前已跑出；其独立初始红日志后来被最终红日志覆盖，未保留，不能补造。后续增加滚动状态和未知键断言，再对完整原版 2.2-2 导出运行，形成目前保留的 56 / 23 红日志。因此不宣称全部 56 项断言都先于生产修改已有。初期两次测试提取/声明编译错误保留在 attempt 日志，没有计入通过数；最终测试可独立编译、执行且全部通过。

| 场景 / 主机计数 | 原版 2.2-2 | 修复后 |
| --- | ---: | ---: |
| 三个退场入口各自：gate→原回调期间内容 layout | 0 | 0 |
| 三个入口各自：首个原回调可见隐私行 | 3 | 0 |
| 三个入口各自：首个原回调可见总行 | 7 | 0（中性态） |
| gate 后插入一次内容 layout：旧 native 内容是否放开 | 是 | 否 |
| gate→安全恢复序列实际执行内容 layout | 2 | 1（过滤后） |
| 安全恢复后的可见安全行 / 隐私行 | 4 / 0 | 4 / 0 |
| gate 引入 offset 写入 / 全表 reload | 0 / 0 | 0 / 0 |
| 已经安全的实际 cell：新增 layout / refresh 请求 | 0 / 0 | 0 / 0 |
| inactive + privacy + 有效投影：原生布局次数 | 1 | 0（hold） |
| 未知 hideSessions 的 gate→publishing→finished→layout：内容 layout | 2 | 0（持续中性） |

过滤后首次恢复的 section、行 y、卡片首末行判定与稳定态逐项相同；offset 保持 128，无中间写入。中性态保留的宿主 contentSize=592×2048、inset=(20,0,12,0)、滚动/交互/手势状态一致；程序 offset 从 128 改为 160 的替身操作可生效且不露隐私。它不等于真机拖动链路已验收。

解锁正常显示、到期重锁、gate 内同步策略变化、账号/epoch 切换、blocked、未知 hideSessions 均有断言。新测试使用完整生产 gate、layout、hook、投影、策略与索引域；UIKit/callback/refresh 驱动是主机替身，具体口径见 [miniapp-first-frame-test-method.md](miniapp-first-frame-test-method.md)。

### 九套回归与两套缓存测试

| 脚本（Tests/） | checks | failures |
| --- | ---: | ---: |
| verify-miniapp-private-layout.sh | 72 | 0 |
| verify-close-friend-session.sh | 229（174+55） | 0 |
| verify-group-lifecycle.sh | 191 | 0 |
| verify-group-selection.sh | 30 | 0 |
| verify-group-incremental.sh | 180 | 0 |
| verify-group-badges.sh | 136 | 0 |
| verify-group-viewport.sh | 72 | 0 |
| verify-group-search.sh | 54 | 0 |
| verify-list-corners.sh | 1,631 | 0 |
| 九套小计 | 2,595 | 0 |
| verify-privacy-admission-cache.sh | 218 | 0 |
| verify-privacy-admission-cache-events.sh | 115 | 0 |
| 十一套合计 | 2,928 | 0 |
| 加新增首帧测试 | 2,984 | 0 |

所有最终进程退出码为 0。每套原始日志 `regression-*.log` 与哈希见 [regression-results.json](regression-results.json)；回归前后 42,511 个生产输入 SHA256 一致。

缓存相同口径 K=25、N=32，2.2-2 审计基线与本轮一致：

| 指标 | 2.2-2 | 2.2-3 |
| --- | ---: | ---: |
| 完整逐行扫描 | 1 | 1 |
| rowHidesQueries | 32 | 32 |
| snapshotReads | 50 | 50 |
| originalLayouts | 25 | 25 |
| 新增 refresh requests | 0 | 0 |
| held / dirty | false / false | false / false |

当前原始 `ADMISSION` 行位于 `regression-privacy-admission-cache.log`。新增 gate 不会把稳定布局退化成每次逐行扫描；不作整机 CPU 降幅声明。

## 构建、历史保护与包校验

`build-packages.py` 使用独立临时 `_THEOS_LOCAL_DATA_DIR`、THEOS_BUILD_DIR 和 THEOS_PACKAGE_DIR；未执行 make clean。构建路径记录在 [build-directory.txt](build-directory.txt)。rootful 20.191s、rootless 20.268s，退出码均 0。两边均 6 条警告，与 2.2-2 的**完整警告多重集**相同；仅规范化 ANSI、空白和源码行列号，保留警告文本与重数。没有新增警告。

构建前后生产输入哈希相同。历史 `.theos` 与 packages 的 1,341 个文件、59 个目录核对：缺失 0、内容变化 0、异常新目录 0；仅新增用户指定的 2.2-3 产物目录。既有 packages 的 104 个受保护文件也包含在该集合中。原有 Finder `.DS_Store` 工作树修改保持原状。

| 产物 | 大小（字节） | SHA256 |
| --- | ---: | --- |
| com.wechat.improve_2.2-3_iphoneos-arm.deb | 1,523,854 | `487cdea0c049c35beb82b9c8ee206a99b66918e1e94d818c9342489ffc873c62` |
| com.wechat.improve_2.2-3_iphoneos-arm64.deb | 1,522,838 | `56cea546fcbe671368b36b4086bd10210fae77ad28f86232ea8300a9ec24db17` |
| com.wechat.improve_2.2-3_symbols.zip | 11,065,348 | `08878a983c4ce32442f5d8e1479b785afbc80ca36e2c971eb4c5b8b0f3aa45b2` |

目录：`packages/2.2-3-miniapp-return-first-frame/`。dpkg-deb 实查 Version 均为 2.2-3，Architecture 分别为 iphoneos-arm / iphoneos-arm64。dylib 均含 arm64/arm64e，包内容与 staging 的 dylib 哈希相同，dSYM UUID 与 ZIP CRC 通过。完整数据见 [build-result.json](build-result.json)、[package-verification.json](package-verification.json) 和历史保护 JSON。

实际运行 `shasum -a 256 -c SHA256SUMS`，构建验证与主任务独立复查均为：

```text
com.wechat.improve_2.2-3_iphoneos-arm.deb: OK
com.wechat.improve_2.2-3_iphoneos-arm64.deb: OK
com.wechat.improve_2.2-3_symbols.zip: OK
```

## 真机未验证与验收动作

1. **真实入口覆盖与先后顺序未验证。** 需要确认设备上实际使用的 animator/gesture/sheet 至少命中一个新增 hook，并先于列表第一可见帧；其它微信版本、其它原生 animator 和截图合成路径未覆盖证明。
2. **真实生命周期未验证。** 未测 isActive、appear/disappear、帧 133–168 内容 layout 次数和 refresh 堆栈。若发生 disappear 但没有对应 appear，原 presentationSuspended 可能延后恢复；当前会保持安全中性态，恢复时机需要真机确认，未改受保护方法去猜测处理。
3. **屏幕首帧与 UIView 身份未验证。** 宿主断言保证其 `%orig` 边界不暴露，但不能证明原生过渡没有预先截图、没有另一可见 table 或合成中间帧。
4. **真实触摸与滚动未验证。** 几何、属性和程序 offset 替身通过，不代表触摸命中或横向切组已测。
5. **解锁到期使用宿主策略变化注入验证。** 缓存套件还覆盖真实 Runtime 过期逻辑，但自然设备退场中恰逢到期/换账号的时序尚未录制。

建议用同一肯德基小程序复录普通退出、下滑交互退出（含取消一次再退出）、半屏关闭：从列表最初露出的帧起不得看见 Pero. 或隐私群的头像/昵称/摘要；未就绪时可短暂中性，内容首次出现就应是过滤后的集合和正确卡片边界，不应晚到删除或跳位。整个返回及恢复后都要能上下滚动、左右切组，位置不回弹；解锁时可正常显示，到期重锁后任何可见帧都不得露出。

## 复现本轮核验

```sh
bash Tests/verify-miniapp-first-frame.sh
bash Tests/verify-privacy-admission-cache.sh
bash Tests/verify-privacy-admission-cache-events.sh
python3 docs/audits/release-2.2-3-miniapp-return-first-frame/verify-source.py
python3 docs/audits/release-2.2-3-miniapp-return-first-frame/verify-final.py
```

其余九套脚本按上表独立运行。红色测试需传入工作树外完整 `faa294ff` 源码导出路径，不要改当前工作树回退。构建脚本只允许在新目标目录不存在时执行，不能重跑覆盖现有交付物。所有报告、原始日志和补充复审均保存在本审计目录。
