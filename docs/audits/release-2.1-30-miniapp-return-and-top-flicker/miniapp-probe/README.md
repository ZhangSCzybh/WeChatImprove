# 小程序容器返回：UI 查询边界与隐私就绪审计

此目录验证 2.1-29 提交 `73e8e78ad5bbc87cb2b73bcf64ed8e0e9ac13f8e` 中一个可执行的 UI 代理边界缺口，并记录最小修复的红绿结果。它是宿主程序的受控回放，**不是真机自然小程序返回的回调日志，也不是真机修复后逐帧验收**。

## 已确认的代码问题与修复

旧代码的 `performVisibleLayout:` 在聊天表 `layoutSubviews` 入口建立 Display 索引范围；但是 UI 代理的必选取 cell 和转发查询会继承外层 Native 索引范围。如果原生 owner 同步调用 UI 代理，而当时尚未经过表的 `layoutSubviews`，代理会直接返回原始列表的数量、高度和 cell。这样不仅能取到密友/密群，普通分组行的 y 坐标和卡片首尾角色也与随后稳定投影不同。

该缺口可在完整生产代理、完整 `refresh`、投影、原生桥接、索引范围和卡片角色逻辑中执行复现。受控输入确实出现“先有未过滤内容，后续表布局恢复过滤、位置和卡片角色”的状态变化；目前证据还不能证明录屏中的自然小程序返回恰好使用了这一回调顺序。

生产改动仅在 `Controllers/CSGroupListAdapter.m` 私有代理边界：

- 可见查询先只读检查策略存在、非 blocked、账号一致；处于投影模式时还检查投影有效、账号和策略 revision 一致。`dirty` 本身不让同 revision 的已验证投影失效。
- 不就绪时，数量/几何/标题查询返回中性值，必选 cell 返回非空、空内容且不接受交互的占位；调用已有隐私 shield 处理已显示行。该分支不刷新、不请求 recovery、不布局、不写 offset、不安排后续计时任务。
- 就绪时，仅 UI 的数量、布局、分区标题/索引和 cell 查询进入 Display 范围。原始桥接读模型、滚动、动作、生命周期回调保持原有范围和行为。

没有把 `performVisibleLayout:` 搬进取 cell/取数量回调。那会在 UIKit 查询过程中触发刷新或 offset 修复。补丁也没有增加固定延时、透明度/过渡、整表重建或新的发布周期。

## 正式回放：先红后绿

| 测试 | 旧 2.1-29 | 修复后 |
| --- | ---: | ---: |
| 正式容器返回回放 | 1,052 检查，378 失败，674 通过 | 996 检查，0 失败，996 通过 |
| 独立就绪契约 | 82 检查，34 失败，48 通过 | 82 检查，0 失败，82 通过 |

两套测试分别运行、分别留档，未合并总数。均用 macOS clang `-Wall -Wextra -Werror` 编译，编译警告为 0。

正式回放测试文件在红绿之间完全未改，SHA256 为：

```text
77afa277aa300c000612474326508f23b5e58b42993399aaabae2ccd8bc990e1  Tests/GroupContainerReturnTests.m
```

1,052 → 996 的 56 项差异来自同一测试对实际返回行逐行断言：8 次 `CompareFirst` 在旧代码下各多拿到 7 条原始列表行，修复后这些行不再进入首份 UI 内容，因此少执行 8 × 7 条“本行不是受保护身份”的动态断言。未删除场景或修改断言；逐场景计数见 `before-after-counters.json`。提取器、runner 和依赖提取器的哈希也与正式红测试快照一致，见 `input-hashes.json`。

独立契约测试 SHA256 在两次执行中同为：

```text
54de0e60a55833a955f31fe58c2a92a766c045dccc9a8530a0cab9fbe9e02d21  Tests/GroupContainerContractsTests.m
```

契约覆盖 nil 策略（投影/原生两种模式）、策略账号错误、nil/无效/错误账号投影、过期 revision、锁定状态的非投影入口、同 revision 但 dirty 的已验证投影，以及 ready/unlocked 的原生展示语义。无效投影由真实投影构造器验证重复原始坐标，未伪造 `isValid` 返回值。

## 直接输出的关键差异

以下值均为受控宿主输入和确定性几何 double 的输出，单位和次数不应解释为手机像素、屏幕帧数或 UIKit commit 次数。两种真实 corner 表钩子嵌套顺序均覆盖；进入 UI 查询前不调用标准 appearance 回调，不调用表 `layoutSubviews`。其“0 次”是测试明确给定的输入。

| 受控 Native owner 范围内的首次 UI 查询 | 旧代码 | 修复后 |
| --- | --- | --- |
| 三个 section 的行数 | `[2, 5, 18]` | `[2, 2, 14]` |
| 原生受保护 cell getter 调用 | 2 | 0 |
| `normal-a@chatroom` 的 y | 586 | 318，与过滤后稳定投影一致 |
| 首次身份、行高、y、卡片首尾角色 | 与稳定投影不一致 | 全部与稳定投影一致 |
| 整表 reload / 行 reload / offset 写入 | 0 / 0 / 0 | 0 / 0 / 0 |

Display 范围的对照输入在旧代码上已经安全；失败集中在查询继承 Native owner 范围时。保留离开前内容和明确给定“先空内容”的两类受控输入均执行，后一项不等于声称观察到某个手机清空回调。

策略 blocked 且晚到、包括原生事务中的陈旧查询：旧代码返回 3 个 section、受保护行高 70、原生标题和 `secret@chatroom` cell；修复后数量/行高/section 高度均为 0、标题 nil、非空的安全空 cell，受保护 getter、recovery、整表 reload 均为 0。策略通过正常发布路径就绪后，第一份查询内容已符合过滤后的稳定投影。

锁定时密群不可见，解锁时仍可按原有语义显示；选中的 Group 分组在两种状态都排除私聊。原始 native bridge 仍可完整读取密群模型；显式 native action 仍同步在原始坐标运行一次并清空队列，锁定/解锁 UI 语义不变。该验证区分原始模型读取与 UI 内容交付。

## 发布次数和证据边界

返回的就绪 UI 查询只复用当前不可变投影，未触发额外刷新或发布。未就绪查询不会交付未过滤内容。不应将测试收集的 `first-ui-content` 和 `later-layout-content` 两份采样称为“两次实际内容提交”：geometry double 会故意在每次允许的原始布局中重新询问全部 cell，以放大重入问题。

本测试可以回答：在受控返回入口，第一份交付内容已经过滤，不存在随后才删除密友/密群的中间内容样本，且无需额外 reload 或滚动补偿。**自然小程序返回到底提交几次、是否还存在真机未过滤帧、录屏空白帧的真实 UIView 实例/回调来源，仍需安装后的设备日志和录屏确认。** 本目录不据宿主计数宣称这些设备结论已经通过。

## 输入完整性与复现

- `baseline.json`：旧提交、10 份生产输入快照和正式测试输入快照哈希。
- `input-hashes.json`：当前源哈希、四个受保护 adapter 方法体的同一性哈希、所有提取后 header 的红绿哈希。只有 `GroupContainerProxy.h` 不同；`refresh`、首次投影发布、`setPresentationSuspended:forController:`、`performVisibleLayout:` 方法体与旧 29 相同。
- `before-after-counters.json`：逐场景检查数、首份内容/策略/锁定/动作输出和原始日志哈希。
- `*-events.jsonl` / `*.stderr.log` / `*-run.json`：完整断言、失败文本、命令和退出码。
- `SHA256SUMS`：此目录除校验文件自身外的完整性清单。

正式旧代码回放：

```sh
bash Tests/verify-group-container-return.sh \
  docs/audits/release-2.1-30-miniapp-return-and-top-flicker/miniapp-probe/CSGroupListAdapter.m-2.1-29.txt \
  docs/audits/release-2.1-30-miniapp-return-and-top-flicker/miniapp-probe/SessionGroupHooks.xm-2.1-29.txt
```

正式修复后回放：`bash Tests/verify-group-container-return.sh`。

独立契约使用 `bash Tests/verify-group-container-contracts.sh`；加上同一对旧 adapter/hooks 参数即可复现旧代码失败。本 agent 没有运行既有回归组；由主任务统一执行和汇总，避免重复消耗。
