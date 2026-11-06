# 微信 8.0.80 紧密布局适配证据

用户提供的 IPA 已由主任务用 REA 打开并提取。本目录在同一个提取结果上做只读定点分析；未另开 REA native session，未安装或启动该 IPA。

## 目标和确定根因

- `Payload/WeChat.app/Info.plist`：`com.tencent.xin`，`CFBundleExecutable=WeChat`，`CFBundleShortVersionString=8.0.80`，`CFBundleVersion=8.0.80.34`。
- 实际消息实现位于主 `WeChat` arm64 Mach-O；SHA-256：`571c5b8cf8732eb5402ffddcbeb93830cb6695bad180be5613ad4167764524e9`。不是同包的 `WeChatDylib.framework`（它是另一个二进制）。
- 旧 `CSMessageMergeAdapter.m` 的 `CSNativeProfile` 仅允许 `8.0.78` 和 `8.0.78.*`。`8.0.80` 在任何内容测量之前直接返回 `NO`。这足以解释连续消息头像可以合并而“紧密”仍保留原生间距。

## 静态核验范围

`wechat80-objc.json` 由 `inspect_objc.py` 直接读取该主 Mach-O 的 Objective-C 类、relative method list、selector refs 和 ivars，处理该样本的 chained rebase 指针。`*-annotated.asm` 是 `xcrun llvm-objdump --disassemble --start-address=... --stop-address=...` 的定点反汇编，并按同文件的 selector/CFString/ivar 元数据添加说明。未把 selector 字符串命中当作方法存在证据。

| 实际方法 | IMP | 核验结果 |
| --- | --- | --- |
| `BaseMsgContentViewController.GetMessageNodeDataArray` | `0x100324ed0` | 对象返回，现有节点数组入口存在。 |
| `BaseMsgContentViewController.getTableView` | `0x10036843c` | 对象返回，现有消息页内表入口存在。 |
| `BaseMsgContentViewController.tableView:heightForRowAtIndexPath:` | `0x100335424` | 返回 `double`，现有行高 hook 签名匹配。 |
| `TextMessageViewModel.numberOfRowsInSection` | `0x105f0f284` | 返回 `q`；分片/多行保护仍可读取。 |
| `TextMessageViewModel.cellDataForRow:` | `0x105f0f3ac` | 返回对象、参数 `Q`；现有动态分发匹配。 |
| `CommonMessageViewModel.isShowChatRoomDisplayName` | `0x10104ca4c` | 返回 `BOOL`；合并姓名 hook 仍匹配。 |
| `CommonMessageViewModel.measure:` | `0x10104e014` | 仍按头部、群名、正文和原生附加内容测量。回复区仍含 `replyTextSize`、`replyTextInset` 及 4pt 内部间隔。 |
| `CommonMessageCellView.layoutInternal` | `0x1010360b4` | 仍分别设置头像和内容区原点，并调用实际子类 `layoutContentView`。 |
| `VoiceMessageViewModel.measureContentViewSize:` | `0x106588d70` | 仍返回 `voiceNodeWidth` 和 `voiceNodeHeight`。 |
| `VoiceMessageViewModel.voiceNodeHeight` | `0x106589714` | 仍包含语音转文字内容和原生 4pt 内部间隔；二次翻译、加载和方言控件继续由现有保护排除。 |

确认的原生槽位包括 `BaseMessageCellView.m_contentView`、`CommonMessageCellView.m_headImageView` / `m_bgImageView`、`VoiceMessageCellView.m_playingImageView`，分别为实例偏移 24、72、112、208。代码继续通过 runtime ivar 查找，不写死这些偏移。

样本内 CSS 与原生方法仍通过 `#message_node_view` 的 `message_node_bkg_margin_top`、`text_message_margin_top` 等规则计算外距。静态分析确认了调用关系和几何协议，未观测用户设备上字体、动态规则或其他注入插件造成的最终 frame；实际子视图、溢出、变换与附加内容仍由现有 Render 验证。

## 修改

仅修改生产文件 `Controllers/CSMessageMergeAdapter.m`：将已检查的 `8.0.80` / `8.0.80.*` 加入首轮几何 profile。保留 `8.0.78` 兼容，其他版本继续原生间距回退。没有更改气泡正文/语音/转文字内部 frame、native model 缓存、时间和大字号保护、姓名/头像规则、关闭后的恢复机制或新旧版本的消息数据。

## 可执行验证

运行：

```sh
python3 docs/audits/wechat-8.0.80-2026-11-05/merge-validation/run-validation.py
```

脚本编译实际生产 Adapter/Policy/Bridge/Navigation/Time 源文件，以 Foundation 和受控 UIKit/native 对象作为边界；不访问手机、真实账号、微信数据库或持久设置。为保留用户已删除的根 `Tests` 状态，所需既有测试从 Git `HEAD` 读取到本审计目录；来源散列见 `fixture-origin.json`。fixture 的唯一逻辑调整是通过 `WECHAT_PROFILE` 选择本次验证版本，并在未知版本用例后恢复到所选版本。

| 代码 | profile | 结果 |
| --- | --- | --- |
| 修改前快照 | 8.0.78 | 17,566 项 Adapter/Navigation 检查通过。 |
| 修改前快照 | 8.0.80 / 8.0.80.34 | 均在语音紧密行高断言失败：期待紧密 36pt，旧实现保留原生 55pt。 |
| 修改后生产文件 | 8.0.78 / 8.0.80 / 8.0.80.34 | 每个 profile 均通过 17,566 项检查。 |
| 未修改的 Policy | 所有受控输入 | 235,148 项检查通过。 |

覆盖首/中/末消息的间距、语音和转文字内部布局、回复、透明气泡内距、分片/辅助内容保护、未知版本回退、原生缓存失效、复用、关闭恢复、时间保护和后台/菜单期间延期发布等。完整日志、源码散列和返回码见 `result.json`。

尚未在用户手机的微信 8.0.80 进程中注入、渲染或验收；以上为静态原生协议核验和宿主可执行回归。
