# 1.8-31 气泡样式与合并消息逻辑审查

本轮任务为审查。用户已确认 1.8-31 在真机恢复正常。未修改生产源码、版本号或安装包；新增内容只在本审查目录，编译运行的主机程序位于 `work-path.txt` 指向的临时目录。源码 342 项与已交付 1.8-31 完全一致，deb 校验通过，见 `integrity.json`。

## 已确认的行为问题

### 1. 行高与内容位移没有使用同一个已发布方案（P2，优先处理）

位置：`Controllers/CSMessageMergeAdapter.m:420`、`:513`、`:525`、`:532`。

首次高度查询只保存 appliedDelta；渲染时基于实测范围重新计算 actual.originDelta，并且把 measurementDecided 清为 NO。下次高度查询会直接使用新范围，允许同样的内容、宽度和配置返回更小的行高。当前只是避免主动发起“缩小”的 table transaction，并未保证已经显示的几何不再缩小。

主机复现 `merge-probes.log`：给定原生行高 55pt、背景框 y=8/h=38、上下透明边距 1/3pt、同组中间条，首次返回 40pt；渲染位移 -8pt，当前行与下一条 1pt 起点之间的可见空隙为 6pt；没有更改消息或配置，再次查询返回 36pt，间隙才会成为 2pt。这是受控几何样本，不是声称用户当前屏幕上必定出现同样数值。

关联触发条件：`CSBubbleStyleVisibleInsets` 要求普通态和按压态都可测。1.8-31 允许普通背景先自定义，但未解码按压态仍令边距函数返回 NO。`bubble-probes.log` 显示，普通态已自定义时按压前不可测、按压解码后可测，返回上/下 1/3pt；因此加载/长按时机可改变合并布局使用的范围。

建议：行高和内容位移作为一个已发布方案统一保存/使用。图片就绪后更新候选度量，已显示行只允许必要的安全扩展；真正内容、宽度或用户配置变化时重建。未解码按压态应有明确且稳定的保守范围，不能让是否长按决定普通态间距；同时保留按压内容不裁切的保护。

### 2. 无实际变化的缓存通知仍触发全体可见行失效（P2）

位置：`Hooks/MessageMergeHooks.xm:70`、`:77`、`:81`、`:85`；`Controllers/CSMessageMergeAdapter.m:258`、`:626`、`:573`。

`clearNodeLayoutCache`、单条 reloadNode 与 reloadMessagesInternal 都无条件递增整个会话 epoch。随后每个可见 model 都被标记为几何失效并清除已验证范围。滚动中 flush 会暂缓，停止后一起 beginUpdates/endUpdates。

主机复现同一消息/尺寸/配置不变，发出等价的缓存失效协议：滚动中 0 次 table update；停止后 1 次 table update、同一 model 2 次 reset；之前实测得到的 36pt 高度又回到 40pt 首次预算。

建议：将缓存通知视为“需要验证”，比较消息身份、邻接关系、内容尺寸、附加内容及布局配置后再失效。针对单条变化只处理该条及必要邻居，保留已验证且仍有效的几何。真正字体/宽度/内容改变仍必须触发重新布局。

### 3. 深色模式的边距测量固定读取浅色图片（P2，条件触发）

位置：`Controllers/CSBubbleStyleAdapter.m:157`。

`CSBubbleStyleApply` 会使用实际主题，`CSBubbleStyleVisibleInsets` 却固定调用 `CSDecodedImage(source,NO)`。关闭自定义背景但开启合并、或者仍在使用原生背景/按压态时，若浅深色素材透明边距不同，会取错 occupied bounds。

主机复现：view 为 Dark，同一 YYImage 的 LM 边距是 1/3pt，DM 为 4/6pt，边距函数返回 1/3pt。原生显示选择当前模式的证据已保留于 `../bubble-readiness-1.8-31/native/YYImage--decodeImage.asm`。未假定所有微信自带素材的浅深色边距都不同；该问题在不同边距素材上触发。

建议：边距测量和实际样式应用共用同一有效主题解析；当前主题未就绪时应明确标记未知，不能把另一主题的度量默认为当前主题。

### 4. 过早缓存“不支持”，元数据补齐后普通刷新仍不重试（P2，条件触发）

位置：`Controllers/CSBubbleStyleAdapter.m:184`、`:270`。

`CSDescribe` 一进入就把 descriptorValid 设为 YES。isSender、messageWrap 或 bgBubbleInfo 尚未准备好时返回，supported 会被缓存为 NO。后续 Apply 只检查 position 是否变化；bgBubbleInfo 从 nil 变成合法 position=0 与初始化值相同，不会重新描述。图片完成回调也只调用 Apply，不能消除此状态。

主机复现：图片与 messageWrap 已就绪，首次 bgBubbleInfo=nil；补齐 position=0 后普通 Apply 仍是原生背景，显式 NativeChanged 才恢复自定义。说明 1.8-31 已解决图片延迟就绪，但描述信息延迟就绪仍存在类似边界缺口。

建议：区分“暂未就绪”和“确定不支持”。前者在关键元数据补齐时重试；缓存命中时至少验证支持资格所依赖的身份、类型、发送方向和分段信息。

## 性能与结构观察

- 同一布局可能从 CommonMessageCellView.layoutSubviews、文本/语音的 layoutContentView、最终 CSMessageMergeRender 多次进入 CSBubbleStyleApply。图片缓存避免了重复像素扫描，但字体目标收集、反射和临时数组仍重复执行。建议后续把同一布局事务的样式应用统一到最终阶段，保留独立的异步图片完成/原生状态变化入口；这是低优先级优化，本次没有真实设备 CPU/frame-time 测量。
- 两套核心测试目前分别替换对方模块：合并测试将 CSBubbleStyleVisibleInsets/CSBubbleStyleApply 换成 stub，气泡测试将 CSMessageMergeReadAppearance 换成 stub。因此各自大量断言通过，仍不能覆盖“图片完成 → 边距变化 → 行高/位移”的完整联动。建议增加少量组合回归，重点覆盖这条链路，不扩大到无关模块。
- 保留合理的内容安全例外：显示昵称、头像下时间、翻译或附加内容时，保护完整内容优先于气泡本体严格 2pt。群昵称位于两条背景之间时，背景到背景距离本身就会大于 2pt；当前设置文案已说明这一点，不能把这些保护直接删掉。
- 未确认新的可复现闪退点。此前崩溃路径的主动 originImage 解码调用没有恢复，显示完成回调具有绑定/消息/图片身份校验。该结论不等价于全机型无线程问题保证。

## 验证结果与边界

本轮只运行两个核心回归入口：

- `Tests/verify-bubble-style.sh`：策略/渲染/所有权 36,979 项，adapter 生命周期 2,490 项通过。
- `Tests/verify-message-merge.sh`：策略/导航 235,148 项，adapter/导航生命周期 16,979 项通过。

新增的审查 probes 直接链接未修改的生产 adapter，复用现有主机 UIKit 替身。`merge-probes.m` 验证布局二次变化和空失效通知；`bubble-probes.m` 验证主题、描述就绪和按压边距。它们的 CHECK 断言用于确认当前问题确实存在，不是修复后的验收断言。运行命令 `python3 docs/audits/bubble-merge-review-1.8-31-2026-10-20/run-review.py`，可附 `merge-probes` 或 `bubble-probes` 仅重跑对应复现。

所有测试设置使用进程内 NSArgumentDomain，不改用户持久配置。未在 iPhone 上复现本报告边界场景，也没有把 host test 当成原生滚动验收。
