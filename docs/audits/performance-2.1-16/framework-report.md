# 2.1-16 折叠展示与路径定位优化

日期：2026-10-29。工作目录：`/Users/zhangshichao/Documents/Workspace/WeChatImprove`。

范围为 `performance-followup-2.1-15.md` 第 2、5 项。保留该目录已有的 2.1-15 完整投影复用改动；本子任务未修改版本、README、构建配置或安装包，未操作真实微信账号、服务、消息数据库和用户备份。

## 1. 稳定摘要复用原生前缀标签

`Controllers/CSCloseFriendSessionPresentation.m` 在成功调用原生 quote 后记录已拥有标签的展示状态。只有当前 message / prefix 仍是相同原生对象、仍在原生 item 内、正文和前缀一致，并且 item frame / bounds、消息和前缀 frame、字体、正文/高亮/背景颜色、对齐、行数、截断/缩字设置、系统 traits 和微信主题输入均一致时，跳过 remove / quote。

主题输入依据现有微信 8.0.78 `MainFrameItemView--quoteMessageLable_prefixText_.asm`：通过当前 MMContext 的 MMThemeManager 读取 `#mainframe_table` 的 `cell_headimg_left_margin` 与 `cell_headimg_size`。使用真实 method encoding 检查对象返回值及对象/Class 参数。将受限字符串、数字和数组值递归复制，避免主题数组原地修改后比较到同一个可变对象。接口不存在、ABI 不符、合法 nil、未知值结构或抛异常时禁用复用，继续委托原生 quote。

复用每次仍修复消息/前缀隐藏状态；调用者仍执行账号、隐私 revision、摘要身份校验、渲染后策略复核、其他原生子视图遮蔽及无障碍修复。失效或普通 cell 复用清理展示状态，保留原生后来写入的新正文。

计数夹具对相同生产方法执行 12 次布局：

| 条件 | 原生 quote | 原生 remove |
| --- | ---: | ---: |
| 禁用复用，执行原 remove / quote 路径的对照 | 12 | 12 |
| 状态稳定且主题可验证 | 0 | 0 |

稳定情况下保持同一个原生 prefix 对象，无缩进累积或标签堆积。回归覆盖主题集合原地改变、traits 替换、高亮色变化、原生 message / prefix 替换、窄宽布局、长正文、隐藏修复、主题不可用/错误 ABI/异常、普通 cell 复用、账号/revision/密友可见性改变，以及原生渲染回调中策略改变。

## 2. 折叠旧路径失配后复用用户名位置索引

`Controllers/CSGroupNativeBridge.h/.m` 增加 `CSGroupResolveNativeRowPathReusing`，保留原 resolver 及匿名业务行处理。原生旧位置仍先验证；它命中时只读取该位置的原生身份。只有折叠控制器的旧位置失配时，才使用按账号、epoch、modelRevision 标识的用户名 → 坐标列表索引。

索引由原生 controller 的关联对象拥有，仅保留复制的 Foundation 字符串、NSIndexPath、数组和字典；不持有原生 session、contact、message 或逻辑控制器。用户名重复时保留按原生顺序排列的候选坐标，最终仍核验真实 session 与 fake row 语义。每次缓存命中都再次调用 `NativeIdentityMatches`，校验失败或名称缺失即清除并重新读取当前来源，不缓存“名称不存在”的负结果。列表数量只用于边界和扫描前后校验，未用作可复用版本依据。

`Controllers/CSGroupListAdapter.m` 传入当前 projection 账号、密友账号 epoch 与原生模型 modelRevision；版本变化即使旧位置直接命中也会清理旧索引。解析后再次校验账号、epoch、modelRevision 和当前密友可见性。最终原有点击/动作校验继续保留。

计数使用同一个内存原生来源，120 个会话整体移动一位，使 120 个旧坐标全部失配。对相同来源依次调用保留的线性 resolver 和 adapter 的新 resolver：

| 路径 | 原生 session 身份 getter 次数 |
| --- | ---: |
| 原线性 resolver | 7380 |
| 索引 resolver | 360 |

新路径为首次 120 行建索引、120 次旧位置核验和 120 次最终候选身份核验。后续失配回调在位置仍有效时只做常数次身份读取。回归覆盖同指针同数量原地重排、插入、删除、同数量身份替换、未命中后新加入身份、已知 modelRevision 变化、相同账号的 epoch 变化、切号、getter 内切号/epoch/modelRevision/隐私变化、getter 抛异常，以及 fake/real 同名候选变化。

## 验证与证据

| 命令 | 结果 | 日志 |
| --- | --- | --- |
| `bash Tests/verify-close-friend-session.sh --ios` | sessions 174、presentation 55 项，0 失败；arm64 / arm64e 生产源对象编译通过 | `framework-session.log` |
| `bash Tests/verify-group-business.sh` | 633 项，0 失败 | `framework-business.log` |
| `bash Tests/verify-list-corners.sh` | 1631 项，0 失败 | `framework-list-corners.log` |
| `git diff --check`（本任务源文件及测试） | 通过 | 命令无输出 |

新增核心回归文件为 `Tests/FoldedRowLookupTests.h`；扩展 `FoldedEntryVisualTests.h`、`FoldedNativeRendererFixture.h` 及相应测试替身。Foundation/UI 替身均在隔离宿主机测试进程中执行，iOS 检查只写临时对象文件。

## 证据边界

计数证明减少原生标签创建/测量入口和重复身份读取，不代表真机帧率、耗电、温度或总耗时的固定收益。展示复用仍要读取并复制可验证主题值和比较展示状态；未知主题实现会保守退回原渲染。位置索引首次失配、失效或缺失身份时仍需一次完整扫描，持续原地变化时可能多次重建。索引以 O(F) Foundation 空间换取稳定失配回调的常数次读取，不将数量或原生数组指针视作未变化证据。
