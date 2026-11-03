# 分组交互调度和切组复用验证

本目录在既有 2.2-8 的真实代码验证框架上，验证 2.2-9 的普通刷新调度修复、切组模型复用及隐私/配置边界。所有输出位于本轮 audit，不改旧 audit，也不恢复工作区已删除的 `Tests/`。

最终冻结源码通过 **3383 + 77 + 7 + 393 + 101 = 3961 项行为检查**，其中原有 866 项相关断言保留。`final/interaction-comparison.json` 中单独运行的 2994 项 selection 检查是完整 3383 项 native suite 的子集，不重复计入总数。四个负对照均要求命中对应断言失败。

运行命令：

```sh
python3 docs/audits/session-groups-interaction-2026-11-03/validation/record-validation.py --output-dir final
python3 docs/audits/session-groups-interaction-2026-11-03/validation/run-legacy-core.py --output-dir final
python3 docs/audits/session-groups-interaction-2026-11-03/validation/run-negative-controls.py --output-dir final
python3 docs/audits/session-groups-interaction-2026-11-03/validation/run-interaction-comparison.py --output-dir final
```

生产 Model、Projection、Coordinator、Bridge、Preferences 和隐私签名按完整翻译单元编译为 macOS Foundation 可执行文件。Adapter 的 `refreshNativeSessionModel`、调度器、统一交互谓词、终止唤醒方法等直接提取自实际生产方法；原生微信 scroll/edit Hook 的实际方法体也提取执行，仅以受控回调替换不可运行的 `%orig`。替身提供 UIKit、原生宿主 getter/setter、内存偏好与确定性调度时钟，不替换生产分组算法。

`InteractionSchedulingFixture.h` 覆盖：

- 冻结 2.2-8 真实方法在 dirty + decelerating + tracking=false 时，同一时刻连续执行 64 个零延迟任务后仍有下一个 pending；测试以预算停止，不让错误路径卡死测试机。
- 修复后 tracking、dragging、decelerating、editing、swipe、group pan、菜单静止/移动 8 类状态，都只使用有上限的延迟重试；2 秒预算后保留 dirty 并停止队列，后续普通消息不会重新开始轮询。
- 真实减速结束、无减速拖动结束、编辑结束及菜单终止回调能立即唤醒发布；重试停止后抵达的新会话值不会丢失。
- 隐私紧急发布在所有交互状态下均可立即执行；离屏等待的 native action 继续使用原有例外。通知合并、内层 mutation、拖动继续减速的时序也保留。

`SelectionReuseFixture.h` 覆盖：

- 32 组 source/fold/privacy/duplicate/optional allTop 配置，各 6 次选择，共 192 次 All、群聊、私聊、自定义、公众号往返，与同输入完整 build 的原生对象顺序、置顶数组、完整 badge/count、映射、隐藏状态及全部折叠展示字段逐项等价。
- folded 包含不可用 nil、确认空、单 child、两个混合 child（一个隐藏群聊、一个可见私聊）；nil 与空、任一 child 未读变化，以及 6 个 foldedEntry presentation 字段变化均拒绝旧源复用。
- 多个 wrapper 与全量来源复用相同会话身份，完整统计优先级、不可变 sourceRows、disabled 归一 All、无效组、复制定义不被原输入后续修改影响。
- 已知源增量之后切组保留未选中行的新数值；同轮源 delta + selection 变化不会互相覆盖。
- Coordinator 120 会话的 5 次切组，冻结 2.2-8 每次读取 120 次主源未读 getter；修复后每次为 0。配置定义、去重、隐私、账号、epoch、未知源变动及 folded 源变化仍走完整重算；同步 getter 重新隐藏密友后不允许旧模型再公开该行。

负对照只在临时提取体或临时源码副本中恢复旧行为，生产哈希必须保持一致：

1. 恢复整表 UI 发布，局部行断言必须失败。
2. 恢复旧 recovery budget reset，外部通知重试预算断言必须失败。
3. 恢复调度器旧交互条件而保留真实 native refresh 门禁，减速期间零立即任务断言必须失败。
4. 在配置缓存键重新放回 selectedTabID，切组零主源元数据 getter 断言必须失败。

`interim/` 保留最初组合 suite 的失败：新增交互测试把宿主会话改为 2 行，后面的旧 Reentrant fixture 按其既定 3 行数据取 index 2，触发宿主替身数组越界；负对照也因此没有到达目标断言。最终将新的 Interaction suite 放入独立进程，保留原 suite 的输入前提；`interim-suite-isolation/` 及 `final/` 记录修正后的成功。该修正没有修改生产代码或删改既有断言。

所有测试使用临时可执行文件、从 Git 历史仅导出到临时目录的旧核心 fixtures，以及进程内 NSUserDefaults。没有访问设备、实际微信配置、账号或聊天数据库，没有安装应用、重启服务或更换端口。

这些结果证明调度边界、主源 getter 次数和分组结果的一致性。它们不能换算为整微信 CPU、耗电、热状态或 hitch 改善百分比；最终真机效果需用相同负载、温度和版本再次对照。
