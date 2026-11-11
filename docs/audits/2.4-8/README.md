# 2.4-8：群聊文案编辑页布局统一

本次基于当前实际 checkout 的 2.4-7，仅调整「欢迎文案」「通知文案」「本群文案」共用编辑器的界面布局，并同步 2.4-8 发布元数据。三个入口使用同一个 `CSGroupChatTemplateEditor`；群聊功能首页的三行及业务保存链路保持原样。

工作目录：`/Users/zhangshichao/Documents/Workspace/WeChatImprove`。这是 iOS 注入插件的本地源码和离线打包任务；未启动、切换或重启任何前后端服务，没有服务 URL、监听端口或应用数据库路径变更，未访问实际微信账号或聊天数据库。测试使用原脚本的临时宿主和测试目录。构建脚本把本 checkout 的生产输入冻结到独立 `/private/tmp` 目录，rootful/rootless 使用各自 Theos 输出目录；交付包对应当前 checkout 的最终源码。

## 修改范围

| 生产文件 | 修改内容 |
| --- | --- |
| `Controllers/CSGroupChatSettingsViewController.m` | 仅改共用文案编辑器布局、局部快捷行的长文字布局、footer 更新、键盘避让和 popover 锚点；三个编辑入口的构造由 `new` 改为 `initWithStyle:UITableViewStyleInsetGrouped`；增加 `math.h`。 |
| `control` | Debian 版本 `2.4-7` → `2.4-8`。 |
| `Headers/CSUserInfoHelper.h` | 关于页版本常量 `2.4-7` → `2.4-8`。 |
| `Controllers/CSReleaseNotesViewController.m` | 增加 2.4-8 的本次布局更新说明，保留历史版本说明。 |

[生产变更哈希清单](changed-files.json)列出上述四个文件的改前、改后 SHA-256。除四个文件外，429 个生产输入中的其他文件与改前相同。`CSGroupChatTemplate.m`、`CSGroupChatStore.m`、`CSGroupChatManager.m`、共享设置表格基类和共享 cell 均未修改。

审计新增文件全部位于 `docs/audits/2.4-8/`，包括改前快照、比较脚本、保护清单、门禁及编译日志、构建与校验脚本和本报告。新增发布文件仅位于 `packages/2.4-8-group-chat-template-layout/`。没有执行任何 Git 操作或 `make clean`。

## 界面元素改前、改后

| 元素 | 2.4-7 | 2.4-8 |
| --- | --- | --- |
| 页面容器与返回 | `UIViewController` + 手工 `UIScrollView` / `UIStackView`。 | `CSSettingsTableViewController` + inset grouped 表格，共享 pushed 页布局与返回规则，沿用 `CSGCConfigureTable` 的分组背景和 `0/54` 分隔线缩进。 |
| 文案内容 | 固定 220 点高的独立圆角 `UITextView`。 | 「文案内容」分组内标准设置 cell 嵌入同一个可编辑 `UITextView`，带 `text.alignleft` 图标，约 200 点最小高度经 `UIFontMetrics` 缩放，实际高度随内容、宽度和字体变化。背景由标准 cell 提供。 |
| 字符计数 | 编辑区下方裸 label。 | 「文案内容」section footer，原 `%lu / 4,000` 文案和超过上限变红条件不变。固定预留高度，编辑时只改目标 footer 的文字和颜色。 |
| 插入变量 | 横向并排的裸按钮。 | 「快捷操作」内标准设置行，`textformat` 图标、蓝色、右侧「在光标处插入」和 disclosure；窄屏或大字号时局部多行排列。原 action sheet 及插入逻辑不变。 |
| 恢复默认 | 横向并排的裸按钮。 | 「快捷操作」内标准设置行，`arrow.counterclockwise` 图标、橙色、右侧「使用默认文案」和 disclosure。原恢复方法不变。 |
| 变量说明 | 三套裸帮助 label。 | 「快捷操作」section footer。三套原说明逐字保留，补足 `@群昵称`、`@群人数`、`@时间` 的含义；不同文案各自的适用范围保持一致。 |
| 预览 | 裸标题 label + 自带圆角背景的裸预览 label。 | 「预览」分组内标准设置 cell，`text.bubble` 图标和可完整换行的内容，颜色及背景由既有设置组件提供。 |
| 预览说明 / 账号变化 | 裸状态 label。 | 「预览」section footer，保留两条原提示；按两种提示最大高度预留，切换状态只更新文字。 |
| 导航操作 | 「取消」Plain +「保存」Done，保存中标题为「保存中…」。 | 文案、style、状态规则与保存后返回判断原样保留。 |
| 输入与表格刷新 | 手工堆叠布局。 | 持有同一个 editor cell/textView，`reuseIdentifier:nil`，不进入共享复用池；输入期间无 `reloadData` 或 `reloadRows`，不主动重设文本或选区；仅真实测量高度改变时无动画更新表格高度。 |
| 键盘 | 独立 scroll view 底边约束到 keyboard guide。 | 键盘通知按屏幕 → window → table 转换坐标；只用自身新旧 inset 的 delta 叠加当前 bottom inset，保留基类 `cs_updateBottomSafeArea` 的贡献。浮动 iPad 键盘若遮住光标且短页面滚动空间不足，仅补足所缺滚动空间，键盘移动/隐藏时撤回。 |
| iPad 变量 sheet | 固定 `y=180` 锚点。 | 使用「插入变量」行与实际可见区域的交集，行不可见时回退到可见区域中心，sourceRect 保持有效。 |

系统 label 仅作为设置 cell 或 section footer 的组成部分。未另建按钮样式、卡片配色或独立视觉体系。快捷操作的多行适配限于编辑器局部，未改变群聊首页原有的 cell 布局。

## 必须不变的行为逐条核对

以下结果为源码逐字对照及指定离线门禁证据；真机交互和最终排版范围见文末。可重跑 `python3 docs/audits/2.4-8/compare-editor-behavior.py`；[最终对照](behavior-comparison.md)共 **18 / 18 项通过**，详细机器结果见 [JSON](behavior-comparison.json)。

| 用户要求 | 核对结果 |
| --- | --- |
| 变量集合、插入位置、sheet 顺序与内容 | **源码通过。** 顺序仍为 `@昵称`、`@备注`、`@微信ID`、`@群昵称`、`@时间`、`@群人数`，通知/本群才追加 `@离群类型`，最后是取消。仍经 `CSSettingsAfterDismissingSheet` 后 `becomeFirstResponder` + `insertText:` 在当前选区/光标处插入，完整方法仅 popover 锚点变化。 |
| 恢复默认写入完全相同的文案 | **源码通过。** `restoreDefault` 逐字不变；入口仍调用 `CSGroupChatDefaultWelcome()`、`CSGroupChatDefaultDeparture()`、`CSGroupChatDefaultRoomDeparture()`，默认实现文件未动。 |
| 4000 字符上限、全空白校验、失败提示 | **源码通过。** `save` 完整方法逐字不变。仍允许输入超过 4000，计数变红，保存时以原提示拦截；不截断输入。保留「请输入文案，内容不能全为空白。」「文案不能超过 4,000 个字符。」「保存失败，请重试。」及 `error.localizedDescription` 的原优先关系。 |
| 保存链路与 context / 授权 / pop 条件 | **源码通过。** `updateConfiguration:completion:`、`CSGCContextValid`、`CSGCRequireAuthorization` 均不变；成功且自己是 `topViewController` 才 pop，失败仍在当前页面提示。 |
| 账号或设置变化时禁用保存和编辑 | **源码通过。** `valid && !saving` 的 enabled/editable 规则和有效或保存中状态判断不变。完整失效提示仍为「账号或设置已变化，请返回后重新编辑。当前内容尚未保存。」；只迁移到 section footer。 |
| 预览使用原 renderer 和示例值 | **源码通过。** 仍走 `CSGroupChatRenderTemplate`；昵称张三、备注三哥、微信ID `wxid_zhangsan`、群昵称读书群、人数128、当前时间以及离群类型「被移出」均不变。欢迎 `@昵称` 的精确示例值保留 `@张三\u2005`，末尾是 U+2005。 |
| 标题、accessibilityLabel、取消/保存文案和 style | **源码通过。** 三个标题仍由原入口设置；`text.accessibilityLabel=self.title` 保留，取消 Plain / 保存 Done、保存中「保存中…」保留，取消方法逐字不变。 |
| hidesBottomBarWhenPushed、动态字体、深色、SE、横屏、iPad | **源码实现核对通过；真机未验。** 保留 `hidesBottomBarWhenPushed=YES`；复用基类 inset，使用语义颜色、preferred font/动态字号、多行标准行、按宽度测高、稳定 footer、caret 避让和有效 popover 锚点。不能把源码或编译结果当作上述设备最终无截断/无重叠的实测证明。 |
| 首页三行标题、图标、颜色、详情和点击行为 | **源码通过。** 首页 `reloadSettings`、`rowEnabled`、cell 和点击处理整段逐字不变。`editTemplate` 唯一变化为显式 inset grouped 构造；「本群文案」在开关关闭时仍显示「开启后可编辑」，原开关限制、授权和点击流程保留。 |
| 三套变量说明原信息不丢失 | **源码通过。** 三套原始完整字符串均可在最终源文件中逐字找到；`@昵称` 欢迎提醒、通知资料点击、本群成员可见、备注/ID 缺失说明和 `@离群类型` 适用范围保留，footer 追加三个群聊/时间变量的含义。 |
| 编辑时不得因刷新失焦或光标跳头 | **源码检查通过；连续交互真机未验。** 同一 textView 生命周期、不 reload、不重设 selection；直接取 `footerViewForSection:0/2` 更新当前可见 footer，避免复用写错；计数和状态不触发高度刷新。 |
| 键盘不覆盖基类 bottom inset 管理 | **源码检查通过；交互真机未验。** 自身贡献以 delta 加到当前 content/indicator inset，共享基类文件哈希不变；短页面浮动键盘的所需滚动缺口已补齐。 |

## 编译和十项原门禁

最终编辑器分别使用 iOS 15.0 目标对 arm64、arm64e 执行语法编译，均 exit 0；[arm64 日志](editor-syntax-arm64.log)、[arm64e 日志](editor-syntax-arm64e.log)为空，表示没有诊断。完整生产构建由打包脚本分别编译 rootful/rootless 的 arm64 + arm64e；结果见下方构建证据。

按用户收尾要求重新执行全部十个原脚本，未改任何断言，每个脚本本轮仅执行一次。[结果总表](validation/results.json)与 [基线对照](validation/baseline-comparison.json)保留原退出码。

| 脚本 | 结果 | 日志 |
| --- | --- | --- |
| `verify-group-chat-core.sh` | 110 项通过，exit 0 | [日志](validation/verify-group-chat-core.sh.log) |
| `verify-group-chat-manager.sh` | **既有失败，exit 1**；与 2.4-7 历史日志逐字节相同 | [日志](validation/verify-group-chat-manager.sh.log) |
| `verify-group-chat-runtime.sh` | 165 项通过，exit 0 | [日志](validation/verify-group-chat-runtime.sh.log) |
| `verify-group-chat-store.sh` | 27 项通过，exit 0 | [日志](validation/verify-group-chat-store.sh.log) |
| `verify-group-chat-backup.sh` | 57 项通过，exit 0 | [日志](validation/verify-group-chat-backup.sh.log) |
| `verify-group-chat-mentions.sh` | 45 项通过，exit 0 | [日志](validation/verify-group-chat-mentions.sh.log) |
| `verify-group-chat-notice.sh` | 35 项通过，exit 0 | [日志](validation/verify-group-chat-notice.sh.log) |
| `verify-group-chat-quit.sh` | 12 个场景通过，exit 0 | [日志](validation/verify-group-chat-quit.sh.log) |
| `verify-background-run.sh` | 53 + 161 + 186 项通过，exit 0 | [日志](validation/verify-background-run.sh.log) |
| `verify-background-run-runtime.sh` | 47 项通过，exit 0 | [日志](validation/verify-background-run-runtime.sh.log) |

manager 的原停止点为 `Tests/GroupChatManagerTests.m:289`：`FAIL: background disables ingress and clears pending welcome`。2.4-7 已记录此断言要求进入后台清除 ingress/待欢迎任务，与 2.4-7 后台运行行为冲突；本次未改 Manager 或测试，保留同一失败，不能记作通过，停止点之后没有覆盖。它与 `compact1436` 的 144 条历史红灯分开披露。

`compact1436` 的 **144 条历史红灯**继续按用户指定认定为基线自带：未修、未豁免、未重跑，不阻塞本次出包。

## 数据和历史产物保护

- `Tests/` 可见顶层条目保持 **307**：[改前](tests-top-level-baseline.txt)、[改后](tests-top-level-final.txt)逐字节一致。递归含隐藏文件共 **324 个文件**，路径、内容哈希[改前](tests-baseline.sha256)、[改后](tests-final.sha256)完全相同，没有新增测试文件或修改断言。
- 历史 `packages/` 的 **300 个既有文件**按[改前](historical-packages-before.sha256)、[改后](historical-packages-after.sha256)逐一校验一致，既有发布目录的文件列表也一致，覆盖历史 `packages/2.4-*`。
- [最终保护核验](final-protection-checks.json)与 [可复跑脚本](finalize-audit.py)记录口径。429 项[最终生产输入](production-final.sha256)与[冻结构建输入](package-build-inputs.sha256)一致，交付不使用另一个 checkout 或示例数据源。

## 发布产物

交付目录：`packages/2.4-8-group-chat-template-layout/`。

| 产物 | 目标与核验 |
| --- | --- |
| [WeChatImprove.dylib](../../../packages/2.4-8-group-chat-template-layout/WeChatImprove.dylib) | fat `arm64 + arm64e`，与 rootful 包内 dylib 字节一致，最低 iOS 15.0。 |
| [Rootless deb](../../../packages/2.4-8-group-chat-template-layout/com.wechat.improve_2.4-8_iphoneos-arm64.deb) | 版本 2.4-8，Architecture `iphoneos-arm64`，包内 dylib 双架构，安装到 `/var/jb/Library/MobileSubstrate/DynamicLibraries/`。 |
| [Rootful deb](../../../packages/2.4-8-group-chat-template-layout/com.wechat.improve_2.4-8_iphoneos-arm.deb) | 版本 2.4-8，Architecture `iphoneos-arm`，包内 dylib 双架构，安装到 `/Library/MobileSubstrate/DynamicLibraries/`。 |
| [symbols.zip](../../../packages/2.4-8-group-chat-template-layout/symbols.zip) | rootful/rootless 各两架构共四份 dSYM，UUID 与对应包切片一致，ZIP CRC 通过。 |
| [SHA256SUMS](../../../packages/2.4-8-group-chat-template-layout/SHA256SUMS) | 四项产物 SHA-256，逐项核验。 |

[出包验证](package-verification.txt)记录实际冻结源路径、构建退出码、包元数据、架构、UUID、RPATH 和完整 SHA-256。[rootful 构建日志](build-rootful.log)、[rootless 构建日志](build-rootless.log)与[打包脚本](build-packages.py)一并保留。本次没有执行安装、注入或重启微信。

## 真机未验证声明

**本次未在真实 iPhone/iPad 或可用 Simulator 上运行 UI。** 当前 `simctl list devices available` 没有可用设备；源码对照、语法编译和包核验不能替代真实 UIKit 排版与交互验收。

仍需真机核验三个页面在 iPhone SE 小屏、横屏、iPad 及分屏、深色模式、所有动态字体特别是辅助功能大字号下的完整显示；长文连续输入、选区、中文输入法组合、插入变量及恢复默认时的焦点与光标；停靠/浮动/交互收起键盘的光标避让；账号或设置失效提示；iPad action sheet 定位；rootful/rootless 安装与注入。此处明确列为未验证，不宣称已有实测通过。
