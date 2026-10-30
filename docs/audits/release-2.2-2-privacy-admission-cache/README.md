# 2.2-2：隐私准入证明缓存

基线为 `8467df87bebb2998f021238b7d88eaea65266214`（2.2-1）。本轮仅实施 CPU 分析报告第 6 节方案 C：复用同一不可变投影的成功准入证明，消除稳定布局中重复的全行隐私扫描。方案 A、方案 B 未实施；不修改隐私规则、解锁语义、投影行集合、索引映射、几何、折叠摘要、搜索、角标、备份及 Hooks。

结果：新增测试 **333 checks / 0 failures**，指定既有回归 **2,595 checks / 0 failures**。相同新断言在未修改 2.2-1 上为 **333 checks / 10 failures**，红日志单独归档、不计成功数。K=25、N=32 的稳定布局从 **25 次全量扫描 / 800 次逐行判定**降至 **1 次全量扫描 / 32 次逐行判定**；快照读取仍为 50 次，原生布局仍为 25 次。rootful/rootless 均构建成功，各 6 条警告，与 2.2-1 警告多重集完全一致。包校验三项均 OK。未做真机安装或整机 CPU 测量，不声称整机 CPU 降幅。

## 1. 改动与范围核对

生产功能改动仅在 `Controllers/CSGroupListAdapter.m`；另外四个原有文件用于版本、应用内说明和 README 同步。无需增加 Projection provenance：现有只读 `privacyRevision`、不可变实例身份已足够，`CSGroupProjection.h/.m` 均未改动。

| 文件 | 增删行数（相对 8467df87；新增文件按全文件计） |
| --- | ---: |
| `Controllers/CSGroupListAdapter.m` | +49 / −5 |
| `Controllers/CSReleaseNotesViewController.m` | +3 / −0 |
| `Headers/CSUserInfoHelper.h` | +1 / −1 |
| `README.md` | +7 / −7 |
| `control` | +1 / −1 |
| `Tests/PrivacyAdmissionCacheTests.m` | +208 / −0 |
| `Tests/PrivacyAdmissionCacheAdditionalTests.m` | +84 / −0 |
| `Tests/verify-privacy-admission-cache.sh` | +38 / −0 |
| `Tests/verify-privacy-admission-cache-events.sh` | +23 / −0 |

完整实施差异：[changes.patch](changes.patch)；机器可读统计：[change-statistics.json](change-statistics.json)。审计文件另位于本目录；不纳入上述代码差异。既有 Tests 的文件内容与基线逐字节一致，未更改任何既有断言；完整核对见 [tracked-source-scope.json](tracked-source-scope.json)。开始前已有的 `.DS_Store`、`packages/.DS_Store` 变化及 feedback/分析素材保留，没有纳入本次实现。

Adapter 的具体改动：

1. `performSessionListLayout:`（当前第 649 行起）在 ready 条件之后核验缓存键。缺失或不匹配时走原全行扫描；只有全部行无需隐藏才有资格建立证明。
2. 布局后的原快照复检保留。额外核验入口实际扫描的 projection/table 与全部捕获值仍一致，防止同步布局重入把旧证明贴给新对象；仅在复检成功后保存证明。
3. `invalidateNativeSnapshot`（第 807 行）清证明。既有策略通知（第 459 行起）、前后台通知（第 492 行起）、页面挂起及原生模型事件均通过这个入口明确失效。
4. `detach`（第 524 行起）清证明；`refresh` 发现账号变化（第 864 行）复用失效入口。新 table 的绑定原本就先 detach 旧 adapter、再建立新实例；额外的弱 table 身份键也阻止直接换表复用。

缓存只是一份 adapter 关联对象中的内存 NSDictionary；不写 projection、不序列化、不落盘、不进入备份/导出。字典强持有被证明的不可变 projection 和 policy，以免地址回收重用冒充同实例；table 用单元素弱 NSHashTable 持有身份，避免 table→adapter→proof→table 引用环。每次命中复用同一字典，不重新分配证明。所有 proof set/clear 使用 `OBJC_ASSOCIATION_RETAIN`，保证后台原生失效通知与主线程读取之间的对象寿命；`modelRevision` 继续沿用原有原子/同步更新。

## 2. 缓存键及变化覆盖

成功缓存的唯一结论是：**按这份当前策略，这份不可变投影的全部行都不需要隐藏。** 以下全部键均匹配才可复用；不以行数、section 数量或数组地址充当证明。

| 键 / 前置条件 | 覆盖的变化与失效方式 |
| --- | --- |
| projection 对象身份 | 投影替换、重建即失效；同实例的不可变行集合可复用 |
| 当前账号 ID，且 policy/projection 账号均一致 | 切号、退出、旧账号投影和新账号策略混用被拒绝 |
| `CSCloseFriendAccountEpoch()`，且 `snapshotEpoch` 相等 | 账号 will/did 边界、异步通知到达前的世代变化 |
| `policy.revision` | 名单增删、主开关、各 surface 配置、手动上锁、到期等 Runtime 状态变化 |
| `policy.enabled` | 主开关当前状态，独立于 revision 再核对 |
| `policy.revealed` | 解锁/锁定的当前有效可见状态 |
| `policy.blocked` | blocked 一律不能建立或命中证明，走原有 hold/shield |
| `options[@"hideSessions"]` 当前 BOOL | 会话 surface 开关；只有已知 NSNumber 类型允许缓存，未知类型仍走原检查 |
| projection 自身 `privacyRevision` | 旧策略生成的投影不得给新策略放行；读取 fallback −1 时不缓存 |
| `snapshotRetryAttempted` | retry/placeholder 期间不放行；置位即清旧证明，恢复后重新验证 |
| **附加：policy 对象身份** | 即使数值相同，替换快照也重新扫描；强化独立 snapshot 边界 |
| **附加：modelRevision** | 原生模型失效/同步重入的保守 token；普通模型事件也清缓存并重新验证 |
| **附加：弱 table 对象身份，且非 nil** | 换表或 table 释放即失效；不强持有表格 |

所有键在入口捕获；证明保存前再次检查 table/projection、有效性、账号、epoch/snapshotEpoch、retry、model token、policy 身份和各值、可读 privacyRevision。同步替换后即使恢复旧对象，也不会沿用中途失效的证明。更保守的 model token 意味着模型事件后可能多扫一次，这是 fail-closed 取舍，不改变发布行为。

## 3. 解锁到期与隐私事件语义

**解锁到期：已覆盖，由每次快照读取时的同步到期检测 + revision + revealed + policy 身份键共同覆盖。** 不依赖定时通知先到。

未修改的 `CSCloseFriendRuntime.m:77–89` 每次 `snapshotForEpoch:suspended:` 计算 `revealUntil > elapsedClock()`；第 84–85 行若有效 revealed 与已发布快照不同，会调用 `changed`（第 42 行）同步增加 revision 并丢弃旧快照。因此即使没有 timer/notification，下一次 layout 的首个 `CSCloseFriendCurrentSnapshot()` 已经返回锁定后的新策略，旧证明不可命中；旧投影 privacyRevision 失配时，按原有逻辑 shield + dirty + requestRefresh。

真实 Runtime 测试通过公开 reveal API 建立解锁，再把隔离替身的单调时钟推进 301 秒：下一次布局 orig=0、三份替身 cell 均 shield、一次恢复请求，revealed=false 且 revision 增加。没有延时或调低隐私实时性。

名单（friends/groups）增删、enabled、hideSessions 和其它 surface 选项均通过 `updateProfile:215` → `saveState:208–213` → `changed:42` 改 revision。手动 `lock:92–99` 在可见状态变化时改 revision；已锁定且规则不变时是既有合法 no-op。账号切换的 will/did 边界在未修改的 `CSBackupBootstrap.m:135–145` 增加原子 epoch，通知异步，因此缓存始终保留 live epoch/账号/blocked 核对。逐项证据及输入 SHA256 见 [privacy-key-semantics.md](privacy-key-semantics.md) / [JSON](privacy-key-semantics.json)。

## 4. Fail-closed 与原行为保护

- blocked、账号/epoch 不匹配、投影无效或 retry=true：不命中缓存；原先 ready=NO 的 hold、shieldCell、privacyRefreshPending、dirty、requestRefresh、return 完整保留。原代码这些状态本就不扫描、不交给 native；本次没有为了计数强行扫描不可信数据。
- 任一缓存键未知：不命中。hideSessions 类型未知但原 boolValue 可读时继续原有全行路径；privacyRevision 读取失败按原 ready gate 拒绝。未知态不产生成功证明。
- 键正常但失配：先丢弃证明，再做原有逐行 `hidesUserName:surface:CSCloseFriendSurfaceSession` 判定。存在隐藏行时不建立成功证明、不调用原生布局。
- 布局期间策略/账号/epoch 变化：原复检分支继续 shield + dirty + requestRefresh，不保留扫描证明。原复检在 `CSGroupWithDisplayIndices(self.table,layout)` **之后**执行；保留基线的实际顺序，没有把它改成新的发布时序。测试会记录一次基于入口安全投影的 layout，随后在 wrapper 返回前遮蔽；不能把这写成真机中间帧证明。
- 命中证明仍执行 `CSGroupWithDisplayIndices(self.table,layout)`、原复检、`sessionLayoutHeld=NO` 和 `[self.privacyShield prepareForPublication]`。
- 每次布局至少读取一次最新 snapshot；成功准入时仍前后各一次，25 次对应 50 次读取。

原 ready-NO 块、原 post-layout mismatch 块，以及 `projectionForSections:`、`publishProjection:`、`setPresentationSuspended:` 与 2.2-1 基线逐字节一致。完整文本及原始哈希见 [baseline-protected-blocks.json](baseline-protected-blocks.json)，命中与现值对比见 [protected-blocks-verification.json](protected-blocks-verification.json)。本轮没有任何新增 reloadData、延时、降频、动画或截图 cover。

## 5. 先红后绿与计数证据

测试提取完整生产 admission/invalidation 方法，并编译真实 Projection、Policy、Runtime、NativeBridge 数值读取、IndexScope；UIKit table/cell 和持久化/凭据提供者为隔离的内存替身，不访问真实账号数据。计数断言没有毫秒阈值。

| 新增套件 | 未修改 8467df87（正式红） | 最终源码（正式绿） |
| --- | ---: | ---: |
| `verify-privacy-admission-cache.sh` | 218 checks / 4 failures | 218 checks / 0 failures |
| `verify-privacy-admission-cache-events.sh` | 115 checks / 6 failures | 115 checks / 0 failures |
| 合计 | **333 / 10，排除于成功数之外** | **333 / 0** |

正式主套红测在修改生产之前完成。追加事件套用 `/tmp` 内由 `git show 8467df87:<path>` 构成的精确旧源码执行；两份红源 provenance 相同，均命中 HEAD。主套测试/脚本红绿字节一致；追加套独立文件，不改变原 218 项断言。四个文件冻结哈希、最终源哈希见 [admission-test-freeze-final.json](admission-test-freeze-final.json)。最终 Adapter SHA256 为 `82e96b805c63593b036804ca46159de95e44b15c3dfb59f6377ebc0b423c8ec8`，与构建输入相同。

4 个主套红失败项是：25 次稳定布局只应扫描一次；enabled、revealed、hideSessions 改变后重新扫描成功，下一次应复用。6 个追加红失败项是：projection/table/native-invalidation/enabled/revision-readable/retry 同步重入前的稳定调用应命中证明，而旧实现仍逐行扫描。隐私拒绝和旧行为断言在红绿两侧均保留。

| K=25、N=32 稳定场景 | 2.2-1 | 2.2-2 |
| --- | ---: | ---: |
| 全量扫描 | 25 | 1 |
| 逐行 hides 查询 | 800 | 32 |
| snapshot 读取 | 50 | 50 |
| 原生布局调用 | 25 | 25 |
| dirty / refresh 请求 | 0 / 0 | 0 / 0 |

命中时省掉双层 section/row 遍历、每行 userName 读取及 `hidesUserName` 内的姓名合法性检查/NSSet membership 判定；保留常数数量键比较和安全复检。对应 CPU 分析第 3.2 节 policy-only 旧扫描成本：锁定隐藏 1,000 行约 0.219 ms/次，10,000 行约 2.1996 ms/次，为开关关闭时约 15.4 倍。本轮以调用次数证明消除重复子步骤，没有重测/承诺缓存后的毫秒数，没有估算或宣称整机 CPU 降幅，也未改变外部触发布局的频率。

覆盖：完整键失效、未知键、锁定/解锁、真实 Runtime 到期与手动上锁、friend/group 增删、其它 surface 配置、隐藏投影拒绝、账号/epoch/retry、直接换表、同步替换投影/表格/可读性/重试/模型状态及 policy 复检变化。完整原始记录见 [admission-counts-before-after.json](admission-counts-before-after.json)，测试边界见 [admission-test-notes.md](admission-test-notes.md)。

正式红日志：[主套](admission-red.log)、[事件套](admission-events-red.log)；正式绿日志：[主套](admission-green.log)、[事件套](admission-events-green.log)。准备时的编译/fixture 问题、第一次绿的直接换表漏失效（218/1）已单独留在 attempt 日志，修正生产实现后才得到最终 218/0；未改断言。初期 miniapp/search 宿主编译问题通过生产身份局部采用 `id`、账号边界复用既有 invalidate 入口解决，既有测试未动。中途 35 项重入 probe 已被正式 115 项套替代，不重复计成功。

## 6. 指定回归

| 套件 | checks | failures |
| --- | ---: | ---: |
| `verify-miniapp-private-layout` | 72 | 0 |
| `verify-close-friend-session` | 229 | 0 |
| `verify-group-lifecycle` | 191 | 0 |
| `verify-group-selection` | 30 | 0 |
| `verify-group-incremental` | 180 | 0 |
| `verify-group-badges` | 136 | 0 |
| `verify-group-viewport` | 72 | 0 |
| `verify-group-search` | 54 | 0 |
| `verify-list-corners` | 1631 | 0 |
| **合计** | **2,595** | **0** |

`verify-close-friend-session` 的 229 项包含 session 174 项、presentation 55 项。每套原始日志与子计数见 [regression-results.json](regression-results.json) 及 `regression-*.log`。最终新增 + 既有回归合计 **2,928 checks / 0 failures**，不包含红测、失败准备尝试或中途 probe。

本轮只跑上面九套必需回归及两套新增计数/事件测试，没有铺开无关 AI/备份/调度等全量套件；相关生产文件未改。双架构真实 iOS 编译由下面的隔离构建覆盖，未用 host suite 的 UIKit 替身宣称设备通过。

## 7. 构建、警告及历史产物保护

`control`、`Headers/CSUserInfoHelper.h`、应用内发布说明和 README 均已同步到 2.2-2，当前发布说明只描述本次隐私准入缓存。

| scheme | 构建 | 警告数 | 对比 2.2-1 完整归一化多重集 |
| --- | --- | ---: | --- |
| rootful | exit 0 | 6 | 完全一致，新增 0 |
| rootless | exit 0 | 6 | 完全一致，新增 0 |

只去掉 ANSI、空白及源代码行/列差异，保留完整消息与出现次数；不是仅比较总条数。命令、耗时、原始与归一化警告见 [build-result.json](build-result.json)、`build-rootful.log`、`build-rootless.log`。两个 scheme 各用 fresh 临时 `_THEOS_LOCAL_DATA_DIR`、`THEOS_BUILD_DIR`、`THEOS_PACKAGE_DIR`，路径见 [build-directory.txt](build-directory.txt)，未执行 `make clean`。

42,511 项生产输入在构建前后及独立终检 SHA256 不变；1,337 个既有产物文件与 56 个既有目录全部保留且内容不变，主树 `.theos` 无新增文件，历史包目录无新增文件。只新建 `packages/2.2-2-privacy-admission-cache/`，没有删除/覆盖旧包。原始清单与独立结果见 [independent-final-verification.json](independent-final-verification.json)、`historical-artifacts-before.json`、`historical-directories-before.json`。

## 8. 可安装产物与校验

产物目录：`packages/2.2-2-privacy-admission-cache/`。

| 文件 | 字节数 | SHA256 |
| --- | ---: | --- |
| `com.wechat.improve_2.2-2_iphoneos-arm.deb` | 1,522,928 | `c4f05b02e1b84a66d56b00efd39a85cd62524ab3607c0810a1708aa432e37af0` |
| `com.wechat.improve_2.2-2_iphoneos-arm64.deb` | 1,522,568 | `7793e15997c547ccc280f4fb186b49bd53c9c09c0d6239b31157c30e1f911232` |
| `com.wechat.improve_2.2-2_symbols.zip` | 11,055,521 | `88f602959a254e321d346af3d6a5adaa55a854a8031fb1fc20881effd8202674` |

`dpkg-deb -f` 已核验：两包 Version 均为 **2.2-2**；rootful Architecture 为 **iphoneos-arm**，rootless 为 **iphoneos-arm64**。两包 dylib 均含 arm64/arm64e，最低 iOS 15.0；安装路径、filter、包内 dylib 与 staging 一致，4 份 dSYM UUID 匹配，符号 ZIP 的 12 个文件 CRC 校验通过。明细见 [package-verification.json](package-verification.json)。

在交付目录实际执行 `shasum -a 256 -c SHA256SUMS`，主任务另行独立复跑也得到相同结果；原始输出见 [shasum-check.log](shasum-check.log)：

```text
com.wechat.improve_2.2-2_iphoneos-arm.deb: OK
com.wechat.improve_2.2-2_iphoneos-arm64.deb: OK
com.wechat.improve_2.2-2_symbols.zip: OK
```

本轮没有 commit、push 或真机安装。

## 9. 未验证项与真机验收

1. 未采 Instruments/设备 CPU；不能证明接近 100% 的整机现象已解决。方案 C 只确认消除稳定投影的重复逐行扫描，A/B 和外部布局驱动原样保留。
2. 未测自然 UIKit/CoreAnimation 的实际布局频率、设备上的缓存命中比例与耗时/耗电；主机 K 次驱动是可复现的计数口径。
3. 真实 UIView 身份、屏幕中间帧、首帧隐私、返回转场、卡片绘制、触摸/滚动链路及其它插件组合，仍须真机安装复录。本轮主机只证明替身下的拒绝/遮蔽、显示索引、原状态路径和现有几何/滚动回归。
4. 真实系统前后台、自然切号与到期事件序列仍需设备确认；host 已用真实 Runtime 公共 API 与可控时钟证明到期失效逻辑，没有替代设备事件采样。

建议真机用同一账号/同一会话集对比 2.2-1 与 2.2-2：分组 + 隐藏密友驻留；再检查手动解锁/到期重新隐藏、增删名单、切号、前后台及小程序/聊天返回。保持原隐私验收标准，不以 CPU 变化替代隐私验收。
