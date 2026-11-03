# 2.2-10 分组效率与兼容路径验证

最终生产源码通过 **4055 项互不重复的行为断言**：3383 项完整原生模型/协调器/Bridge/Adapter/Hook/切组回归、77 项隐藏密友未读面板、7 项 ABI、393 项既有核心功能、101 项独立交互调度，以及新增 94 项真实兼容刷新/发布/来源捕获检查。独立运行的 2994 项切组检查已包含在 3383 项完整原生 suite 中，不重复计数。

10 个负对照均准确命中目标断言失败。所有负对照只改临时提取体或临时源码副本，不改生产文件。最终报告的 22 个相关生产文件哈希与当前工作区一致，测试期间源码未变。

2.2-9 冻结基线保留并通过 3961 项既有检查；新增兼容观测夹具另外用 3 项断言重现其“离屏角标仍同步布局、具名内容更新仍刷新全部可见行”的行为。基线与本轮结果均写入本目录，未覆盖历史 audit，也未恢复根目录已删除的 `Tests/`。

## 新增兼容路径检查

`CompatibilityPublicationFixture.h` 使用真实生产 `publishProjection:previous:changes:changedUserNames:previouslyProjecting:`、完整兼容 `refresh` 与 `nativeSectionsForAccount:changes:changedUserNames:` 方法体。Bridge、Projection、IndexScope、Preferences、隐私策略等直接编译完整生产翻译单元。UIKit、原生来源对象、视口、调度时钟和来源回调属于受控宿主边界。

- 普通具名 Content/Structure 更新只刷新命中的可见行；离屏角标没有 `reload`、没有同步布局。
- 可见行复制的未读、红点、摘要和排序时间变化，即使未被名称提示命中，也必须刷新；名称提示不能遮蔽已知值变化。
- Unknown、隐私紧急发布、隐私 revision、账号、选择、坐标/身份/结构、特殊行、UIKit 缓存计数变化和显式滚顶，继续完整发布；持有布局时仍释放同步布局。
- 完整 `refresh` 确实消费这一批名称；嵌套 Unknown 不会被外层具名变化覆盖；源 getter 同步改变 `modelRevision` 时本轮完整刷新，下一批名称仍保留。
- 稳定来源的普通具名读取为 1/3，缓存命中为 0 次元数据读取；Unknown、缺少名称、隐私 pending、隐私 revision、blocked policy 和 epoch 变化保留完整读取；账号不匹配直接拒绝。
- 来源枚举中同步改变 revision、隐私、epoch 或账号时，旧捕获结果被丢弃，不进入缓存。
- 对真实新消息使用的 `Content|Structure` 组合，完整验证稳定结构后允许具名读取；重排、置顶变化、新分区、重复身份、分类变化、聚合/特殊身份和 Unknown 全部回到完整构建。比较结果包括未被名称提示命中但发生变化的行，防止在后面发现结构不匹配后发布早先复用的旧值。

1200 条普通会话的附加工作量对照，执行真实 Adapter 来源方法及 Bridge：

| 同一条会话变化 | 强制 Unknown 完整捕获 | 合法具名 Content\|Structure |
|---|---:|---:|
| 元数据 unread getter 读取次数 | 1200 | 1 |
| 完整坐标/身份验证 | 保留 | 保留 |
| 全部结果的来源坐标、身份、类型、分类、置顶、未读和红点 | 逐字段一致 | 逐字段一致 |

该计数衡量主机夹具中的元数据读取工作量；结构证明仍是 O(N)，不能把 1200→1 外推为整微信 CPU、耗电、帧率或 CA 提交的改善比例。本轮没有新增手机性能采样。

## 负对照

1. 临时恢复 native 整表发布，局部行断言失败。
2. 临时恢复旧 recovery budget reset，外部通知重试预算断言失败。
3. 临时恢复旧交互判断，减速期间零立即任务断言失败。
4. 临时将 selectedTabID 放回配置缓存键，切组零主源元数据读取断言失败。
5. 临时恢复兼容整表发布，离屏零刷新断言失败。
6. 临时恢复兼容无条件布局，离屏零布局断言失败。
7. 临时用名称过滤已变化的复制元数据，可见值变化断言失败。
8. 临时丢弃兼容 refresh 消费的名称，单个命中可见行断言失败。
9. 临时忽略兼容来源重入 revision，完整发布断言失败。
10. 临时禁用 Structure 严格证明，真实重排必须完整读取的断言失败。

`interim-negative-control-assertion/` 保留第 10 项初始 runner 的结果：负对照已准确触发较早的重排保护断言，但 runner 最初只匹配后面的另一条结构保护断言，因此标为不接受。最终 runner 匹配真实触发的精确断言；没有修改保护条件或跳过测试。

## 历史夹具的临时适配

历史 393 项核心断言从 Git `863bfdb350fddf678c349574d99badb241d98958:Tests` 仅导出到临时目录。断言保持原样；为了执行新生产方法，临时宿主做以下适配：

- 两个已移除薄 wrapper 的调用使用完全等价的 `CSGroupBuildNativeSectionsReusing(...,nil)`。
- 发布方法从 `@implementation CSGroupListAdapter` 之后提取，避免把新增私有声明当成方法体；历史调用新增 `changedUserNames:nil`，保留其“来源名称未知”语义。
- 补 UIKit 缓存的行数、分区数和新私有状态，链接真实 Bridge 读属性方法。
- badge/appearance 宿主提供新方法需要的 `badgeWidth`、`widthForTabButton:`、`tabLayoutValid` 几何边界，原 badge 输出和布局断言不变。真实字体、几何和动画行为另由同 audit 的 `ui-validation/` 执行。

`interim-legacy-host-fixtures/` 保存适配前的编译失败，明确区分旧宿主夹具缺失与生产回归。原生 CPU fixture 中原来“任何 Structure 一律读全表”的计数断言，针对支持严格证明的新实现改为“稳定结构读 1 条”；冻结旧实现仍按 3 条验证。真实结构变化另有完整结果与至少 N 次读取的检查，未削弱安全边界。

## 复现

所有命令从项目根目录执行，输出保持在本轮 audit。不要使用旧 audit 的默认 `final/` 输出路径，也不要运行 `make clean`。

```sh
python3 docs/audits/session-groups-efficiency-2026-11-03/validation/record-validation.py --output-dir final
python3 docs/audits/session-groups-efficiency-2026-11-03/validation/run-legacy-core.py --output-dir final
python3 docs/audits/session-groups-efficiency-2026-11-03/validation/run-negative-controls.py --output-dir final
python3 docs/audits/session-groups-efficiency-2026-11-03/validation/run-interaction-comparison.py --output-dir final
python3 docs/audits/session-groups-efficiency-2026-11-03/validation/run-compatibility-validation.py --output-dir final
```

最终结构化证据为 [validation-integrity.json](final/validation-integrity.json)、[behavior-result.json](final/behavior-result.json)、[compatibility-result.json](final/compatibility-result.json)、[legacy-core-result.json](final/legacy-core-result.json)、[negative-controls-result.json](final/negative-controls-result.json) 与 [interaction-comparison.json](final/interaction-comparison.json)。测试没有连接手机、读取真实偏好或聊天数据库、安装软件、重启应用、切换账号或变更任何服务。
