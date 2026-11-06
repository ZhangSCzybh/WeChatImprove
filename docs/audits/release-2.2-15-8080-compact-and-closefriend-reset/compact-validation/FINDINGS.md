# 2.2-15 紧密间距：可复现的生产门槛断点

本次确定断点是 `CSBubbleStyleAdapter.m` 的 `CSModelTemplates` 生产版本门槛：2.2-14 虽在 merge profile 放行微信 8.0.80，但计算气泡透明边距的下游模板入口仍只允许 8.0.78，因此普通文本/语音首轮测量无法获得安全的气泡占用范围，冻结为原生间距。修复只扩展这个已由实际二进制核验的入口，不改变间距数字、不移除几何和消息类型保护。

## 五项排查

1. **hook ABI 与安装条件**：实际 IPA 的 arm64 Mach-O 已逐点读取 Objective-C 方法元数据，对 `MessageMergeHooks.xm`、`BubbleStyleHooks.xm`、`MessageGestureHooks.xm` 共 64 点做 ABI 审计；62 点与方法或 UIKit 继承签名相符，无参数/返回值不匹配，另 2 个 legacy `addMessageNode:` 变体在该样本不存在，不参与初始两条文本的行高路径。见 `../native-validation/hook-abi-audit.md` / `.json`。本次没有通过用户微信进程观测 hook 安装状态；“静态签名相符”不能替代真机安装日志。已确定的生产门槛在 hook 命中之后仍必然挡住 8.0.80 文本紧密测量。
2. **残留版本门槛**：`Controllers/CSMessageMergeAdapter.m:421` 已允许 8.0.80；但基线 `Controllers/CSBubbleStyleAdapter.m:280` 只有 8.0.78。调用链是 `CSMessageMergeRowHeight` → `CSMessageMergeMeasure` (`CSMessageMergeAdapter.m:489`) → `CSNativeProfile` → `CSBubbleStyleModelInsets` (`:431`) → `CSModelTemplates` (`CSBubbleStyleAdapter.m:311`)。后者 NO 导致 `CSMessageMergeAdapter.m:432` 返回 NO；`:487` 的 `appliedDelta=0` 保留原生行高，`:497` 将决定冻结。这个断点不依赖推测字体、设备缩放或截图 pt 值。
3. **原生测量是否换路径**：实际 `BaseMsgContentViewController.tableView:heightForRowAtIndexPath:` (`0x100335424`) 仍在 `0x100335524` 调用 `cellDataForRow:`、`0x100335540` 调用 `rowHeight`。`BaseChatViewModel.rowHeight` (`0x1002abf8c`) 在 `0x1002abfd8` 调用 `measure:` 并缓存 ceil 后高度。Text 的 `cellDataForRow:` ABI 为 `@24@0:8Q16`，`numberOfRowsInSection` 为 `q16@0:8`；与现有安全分发一致。BubbleInfo 的 `getBubbleImage:isDarkMode:useCache:` 为 `@28@0:8B16B20B24` (`0x104d9ed5c`)；原生背景工厂确实仍调用同一 cached UIImage 路径。定点反汇编与带 selector 注释的调用证据统一存于 `../native-validation/`。
4. **后续 native layout 覆盖**：现有 `CSMessageCellLifecycle.m:15` 在 `%orig` 完成后调用 Render，进入前恢复自己上次拥有的 origin；没有修改原生 model 缓存。实际 `ChatTableViewCell.layoutSubviews` (`0x100fd9670`) 在 `0x100fd985c` 给 `m_cellView` 设置 frame，再于 `0x100fd9884` layoutIfNeeded，最后 `0x100fd98ac` onAppear；这两个边界均有既有后置 Render。新测试连续四轮模拟原生恢复原点后再 Render，紧密 seam 始终 2.00pt，行高不发生二次漂移。静态反汇编未发现该路径在这两个边界之后再次重写 frame；其他注入插件的真实覆盖仍未验证。
5. **设置值是否 compact**：UI `CSBubbleStyleSettingsViewController.m:103` 为“紧密”写新键值 `1`，`showChoice` 直接 `setInteger:forKey:`。`CSMessageMergePolicy.m:19` 优先新键，只有缺失才读旧键。新测试实际构造生产 `CSMessageMergeConfiguration`，断言新键 1/旧键 0 → compact，旧键负值/新键 0 → normal，新键缺失/旧键负值 → compact；日志每个场景打印 `SETTINGS ... actual=... expected=...`。没有修改 Policy 或写入逻辑。

## 为什么 2.2-14 的检查漏了

上一轮 merge 测试把 `CSBubbleStyleModelInsets` 替换为永远可用的桩；原有 merge+bubble 联合测试使用 `CS_BUBBLE_TESTING=1`，恰好跳过这次出问题的生产版本条件。因此“merge profile 已放行”以及上述测试转绿，不足以证明完整生产模板入口已放行。此次新测试同时编译真实 Merge/Bubble Adapter、Policy、Bridge、Navigation、Time 依赖，不定义 `CS_MERGE_TESTING` 或 `CS_BUBBLE_TESTING`。版本从真实 macOS `.app/Contents/Info.plist` 读取，走相同生产版本条件；只替代 UIKit/native 对象，不替代模板边距函数。

## 原样红 → 绿

先在根任务保存的完整 `baseline-2.2-14` 源码快照执行新断言，确认红日志后才改生产代码。`red-result.json` / `green-result.json` 含编译命令、源码散列、测试散列、退出码；两阶段 `test_sha256` 完全相同。

| 代码与版本 | 断言执行数 | 失败数 | 关键结果 |
| --- | ---: | ---: | --- |
| 基线 2.2-14，8.0.80 | 305 | 48 | 连续文本 seam 21.00 / 24.00pt，目标 2.00pt；normal 与不支持类型仍通过。 |
| 基线 2.2-14，8.0.80.34 | 305 | 48 | 相同断点复现，退出码 1。 |
| 修改后，8.0.78 | 369 | 0 | compact 2.00pt；normal 21.00 / 24.00pt。 |
| 修改后，8.0.80 | 369 | 0 | compact 2.00pt；normal 21.00 / 24.00pt。 |
| 修改后，8.0.80.34 | 369 | 0 | compact 2.00pt；normal 21.00 / 24.00pt。 |
| 修改后，未知版本 8.0.81 | 329 | 0 | 回退原生行高 55 / 67pt；可见 seam 21.00 / 24.00pt，原点不漂移。 |

红合计 610 项、96 次失败；绿合计 1,436 项、零失败。绿色比红色多执行的检查是模板入口被实际访问后，native double 内 `CHECK(useCache)` 的检查；断言源码完全相同。场景覆盖发送/接收两条连续文本、自定义/原生气泡、新旧设置键优先级、未知版本、精确类名单之外的消息、重复原生 layout、reuse 恢复。

测试使用受控的 8pt/17pt 原点、38pt 正文和原生行高 55pt/67pt（发送行底部 9pt；接收首条含姓名时底部 12pt），像素模板透明边距 1pt/3pt。因此原生可见 seam 为 21pt（发送）/24pt（接收首条含姓名），紧密目标为原有算法的 1pt+1pt=2pt。这些数值是可复现的宿主测试输入与输出，不是从用户截图推定的真机数值；截图只支持“可见间隙很宽”的观察。

## 最小生产差异与验证边界

相对 2.2-14 仅 `Controllers/CSBubbleStyleAdapter.m` 增 3 行、删 2 行：扩展模板版本白名单至已核验的 8.0.80 / 8.0.80.*，以及更新对应注释。`CSMessageMergeAdapter/Policy` 和所有 hooks、间距值完全未动。类型、版本、语音转文字、回复、额外内容、透明边距、变换/溢出、cache 与 no-late-shrink 等兜底保留；既有 merge/bubble/message 回归结果由根任务汇总。

这次修复是“已测得的生产门槛断点”，不是仅调小间距数字。真实用户手机上的注入状态、显示间距和大礼包其他插件组合仍 **未验证**。安装后在同一会话中对比正常/紧密模式，同发送者连续普通文本的接缝应明显缩至目标 2 个逻辑点；切回正常应恢复原生，引用/转文字/陌生消息布局不得裁切，滚动复用后不应漂移。
