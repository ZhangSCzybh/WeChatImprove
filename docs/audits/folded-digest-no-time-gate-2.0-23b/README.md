# 2.0-23b：摘要不再受时间缺失门禁影响

本次执行用户对当前轮次的补充澄清：折叠入口右侧本来就不需要时间/日期，继续隐藏；时间信息不得成为摘要降级条件。以已交付 2.0-23 为基线，单独交付 2.0-23b，保留全部历史包和审计。起始时已逐个核对 2.0-23 源码清单的 559 个文件，均一致。

## 定位与修改

2.0-23 的展示代码没有因缺少右侧时间 label 而清空摘要，也没有新增时间显示。实际存在的时间门禁在取数和投影阶段：

1. `CSGroupProjection.m` 遍历可见折叠会话时，任一候选的有效时间缺失就否决整组摘要；`CSGroupListAdapter.m` 对应记录 `no_sort_time`。现已删除该否决分支和原因码。
2. `CSGroupNativeBridge.m` 在取数前后比较排序时间，时间发生变化就返回 `source_changed`。现已取消时间比较，仍检查源会话名称、消息对象与精确消息 ID。仅时间变化不再丢弃同一条已校验消息的摘要。
3. `FoldedSortTime` 中缺失的辅助会话字段按零处理，不再否决其它可读字段。继续按原生有效时间规则排序；会话时间不可用时，读取当前消息的原生 `getSessionTime`，再回退 `m_uiCreateTime`。时间只用于选候选，不用于摘要有效性判断，也不会生成右侧时间 UI。

`getSessionTime` 已在 8.0.78 静态核实，IMP `0x104ba6634`，通常读取消息创建时间，拍一拍消息读取其原生事件时间；该方法没有 setter、红点或缓存写入调用。复用既有 [反汇编证据](../folded-digest-source-2.0-23/native/CMessageWrap--getSessionTime.asm)，未为本次重复扫描二进制。

排序边界：某候选缺少全部排序元数据时按零值参与比较；所有候选均无可用排序值时视为同序，保留原生候选的稳定顺序，仍允许显示身份可信的摘要。此极端状态无法凭空确认真实先后，不把“原生列表顺序”普遍等同于消息时间，也不再用时间缺失清空整组摘要。

保留 2.0-23 的真实摘要路径：优先读取并校验原生 CellData 的 `m_textForMessageLabel`；缓存未生成、空文本或身份不匹配时，在消息副本上调用微信自己的 `ChangeForDisplay` / `digestForMsg:withSender:`。原 q/Q 消息 ID 修复、账号 epoch、隐私 revision、当前分组/可见性及消息身份校验均保留。没有使用全局聚合摘要兜底，没有新增轮询。详见 [上一轮原生取数证据](../folded-digest-source-2.0-23/native/findings.md)。上一轮报告中“时间不可信则中性”和 `no_sort_time` 的说明由本报告取代，历史报告原文件保留。

`CSCloseFriendSessionPresentation.m`、列表卡片与外观 hooks 相对 2.0-23 **逐字节不变**。原生标题、图标、两行布局、字体、连续卡片及右侧时间/全局未读隐藏保持原样。

## 先失败再修复

新增测试运行时，341 个生产文件仍与基线相同，见 [红阶段源码校验](red-production-preservation.json)。旧实现在六个断言中失败：会话时间缺失但消息时间可读、原生消息时间优先、所有时间都为零、可选时间 getter 缺失、另一个候选无时间、格式化期间仅时间变化。

另补两条展示断言：原生行根本没有时间 label 时仍显示摘要且不创建时间视图；复用时重新出现时间 label，继续隐藏且不影响摘要。原有一个“时间不明应中性”的断言按新要求替换，因此净增 7 项。

| 脚本/部分 | 修改前检查数 / 失败数 | 修改后检查数 / 失败数 |
| --- | ---: | ---: |
| `verify-list-corners.sh` | 1020 / 0 | 1020 / 0 |
| `verify-close-friend-session.sh`：会话与摘要 | 142 / 6 | 142 / 0 |
| `verify-close-friend-session.sh`：展示与复用 | 40 / 0 | 40 / 0 |
| 合计 | **1202 / 6** | **1202 / 0** |

仅运行以上两个脚本。保留缓存未生成的替代取数、最新密友顺延、全隐藏无入口、不同组隔离、账号/隐私失效、深色、复用、圆角开关等既有检查。宿主替身回归不能替代真机验收。

证据：[回归汇总](regressions.json)、[红阶段日志](logs/red-close-friend-session.log)、[会话绿阶段](logs/green-close-friend-session.log)、[圆角绿阶段](logs/green-list-corners.log)。绿阶段不再出现 `no_sort_time`。

## 日志与真机验收

继续使用 `[WeChatImprove][FoldedDigest] stage=... reason=... tab=... count=...`。例如 `ok_cache`、`ok_copy_cell_missing` 表示两种取数成功路径；`text_empty`、`message_missing`、`source_changed` 或 `policy_stale` 用于区分文本/消息/身份问题。`source_changed` 不再表示时间变化。无 `no_sort_time` 原因码，不输出正文或账号标识，仍按 stage/reason/tab 去重且每进程最多 32 条。

1. 冷启动后直接查看有可见折叠会话的分组，先不打开折叠列表；标题保持“折叠的聊天”，摘要应取本组最新可见会话的原生文本，右侧不出现时间/日期。
2. 打开一次折叠列表再返回，对照摘要；有新消息或返回刷新后应重新取数，无需手动重启来补缓存。若仍中性，请提供冷启动与返回后的 `FoldedDigest` 日志及微信版本。
3. 隐藏本组最新密友后顺延到下一条可见会话；全部隐藏时无入口。切账号或隐私状态后不得残留旧摘要。
4. 浅色/深色切换、滚动触发 cell 复用、切换分组、关闭再开启圆角：摘要与卡片正常，右侧时间继续隐藏。

## 交付与保留证据

独立构建目录见 [build-environment.json](build-environment.json)，未执行 `make clean`，未使用工作区 `.theos` 构建。版本号同步到 control、版本常量和发布说明。

- `packages/com.wechat.improve_2.0-23b_iphoneos-arm.deb`
- `packages/com.wechat.improve_2.0-23b_iphoneos-arm64.deb`
- `packages/com.wechat.improve_2.0-23b_symbols.zip`

两个安装方案均包含 arm64 / arm64e；包内版本、安装路径、四份 dSYM UUID、首个初始化器、无测试替身混入均由 [verify-release.py](verify-release.py) 核验。成品哈希见 [packages.json](packages.json)，编译警告与上一版对比见 [build-verification.json](build-verification.json)，源码差异与哈希见 [changes-from-2.0-23.diff](changes-from-2.0-23.diff) / [source-sha256.json](source-sha256.json)。

首轮交付核验因任务开始后另行出现的反馈素材 `docs/feedbacks/2026-10-27-folded-entry-native-digest-parity.txt` 中止，尚未发布任何包；该素材原样保留并记录其精确 SHA256，不作为本次生产改动。首次日志见 [release-verification-attempt1.log](logs/release-verification-attempt1.log)。历史 packages、audits、工作区 `.theos` 及该反馈素材的保留结果见 [preservation.json](preservation.json)。

最终两种安装方案均编译成功，各有 12 条既有编译/链接警告，新增 0 条。第二次核验发现 rootless 并行日志把源码 `sharedApplication` 的末尾 `tion` 插进了一条 `openURL:` 弃用警告；核对原始上下文后仅归一化这一个已确认片段，保留原始日志。见 [第二次核验日志](logs/release-verification-attempt2.log)、[精确归一化记录](warning-log-normalization.json) 和 [最终通过日志](logs/release-verification.log)。未通过删除警告、关闭警告或重编无关模块来绕过检查。

交付只新增上述三个 2.0-23b 成品，起始时的 51 个 packages 文件均保持原 SHA256。最终源码、包、历史审计及展示文件的再次只读核验见 [final-verification.json](final-verification.json)。
