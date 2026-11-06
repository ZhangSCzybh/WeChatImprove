# 微信 8.0.80 原生紧密布局链路核验

本目录只读分析用户提供的 IPA 所提取的主 `WeChat` Mach-O。没有执行其中任何代码、安装手机应用、修改生产源码或改动旧审计。输入为 `com.tencent.xin` / `8.0.80` / `8.0.80.34`，arm64 主二进制 SHA-256 为 `571c5b8cf8732eb5402ffddcbeb93830cb6695bad180be5613ad4167764524e9`。具体命令、元数据读取器和源码散列见 `native-provenance.json`、`disassembly-commands.json`。

## 已确定的阻断点

2.2-14 的 `Controllers/CSMessageMergeAdapter.m:421` 已允许 8.0.80，**下游** `Controllers/CSBubbleStyleAdapter.m:280` 的生产 `CSModelTemplates` 却仍只允许 8.0.78。后者在检查/调用真实 `BubbleInfo` 工厂前就返回 NO，导致 `CSBubbleStyleModelInsets` 失败；`CSMessageMergeAdapter.m:431` 得不到模板边距，`:432` 拒绝首轮几何 profile；`:487` 初始化的 `appliedDelta=0` 没有改变，`:497` 冻结本轮决定。因此命中原生行高 hook 也会返回原生行高。这一条件对版本 8.0.80 是确定的生产代码分支，不依赖截图推算、字体或设备 frame。

后续 Render 保持安全设计：`CSMessageMergeAdapter.m:653` 在 `appliedDelta>=0` 时不凭后到的样本再次偷偷缩行。因此首次模板门槛被拒绝也不会在显示后“自行恢复紧密”。本次由 compact 子任务修改的内容只放行已核验的 8.0.80 / 8.0.80.* 模板入口，没有修改 2pt 目标、原生间距数字、模型缓存或该安全回退。

## 所有 hook 的 ABI

`hook-abi-audit.md` / `hook-abi-audit.json` 逐个列出源文件与行号、类、selector、显式参数个数、hook 返回值/参数编码、实际 native owner、完整编码及 IMP。覆盖三个实际参与合并/测量/气泡与渲染生命周期的源文件：

- `Hooks/MessageMergeHooks.xm`。
- `Hooks/BubbleStyleHooks.xm`。
- `Hooks/MessageGestureHooks.xm`；Render 的实际入口在此文件，不能只检查前两个文件。

共 64 个 hook 声明：62 个与本二进制方法或外部 UIKit 继承声明匹配，ABI mismatch 为 0；另 2 个旧增量变体在本二进制继承链中不存在。实际二进制里它们变成带 `addNewMsg:` 的 `addMessageNode:addMoreMsg:addNewMsg:` (`v32@0:8@16B24B28`，`0x10032ae24`) 和 `addMessageNode:layout:addMoreMsg:addNewMsg:` (`v36@0:8@16B24B28B32`，`0x10032ae3c`)。这两个缺失点是 `MessageMergeHooks.xm:47` / `:50`，本次没有顺手改动；初始历史消息仍经过已匹配的 height/cell/willDisplay 边界，`addChatViewModel:addMoreMsg:` 亦仍存在。这两个 legacy 变体不能计作已安装 hook，也不能作为本次“初始两条文本依然宽”的根因。

本套 Logos hook 直接由 `%init` 安装，不经过密友模块的 `CSCloseFriendInstallHook` ABI 拒绝器。静态结果说明未发现与上次搜索回调类似的参数/返回类型失配；**没有用户微信进程的运行时安装日志，不能声称真机上的 62 个 hook 已逐个安装成功。**

## 原生行高路径仍在实际表格分发链上

| 定点位置 | 二进制证据 | 与生产代码的关系 |
| --- | --- | --- |
| `BaseMsgContentViewController.initTableView` (`0x10032f3d0`) | `0x10032f558` 加载 `setDelegate:`、`0x10032f56c` 加载 `setDataSource:`，参数为当前控制器。 | 这些表代理方法仍由该聊天控制器提供。 |
| `tableView:heightForRowAtIndexPath:` (`0x100335424`) | `d32@0:8@16@24`；`0x100335524` 加载并发送 `cellDataForRow:`，`0x100335540` 加载并发送 `rowHeight`。 | 与 `MessageMergeHooks.xm:16` 的 `double`、两个对象参数匹配；`:19` 在 `%orig` 后投影最终行高。 |
| `TextMessageViewModel.cellDataForRow:` (`0x105f0f3ac`) | `@24@0:8Q16`；`0x105f0f3c8` 测试 `isLongSplitMessage`，普通文本的 `0x105f0f418` 返回 `self`，分片走 `subViewModels`。 | 与 Adapter 的安全 `Q` 分发匹配；普通文本未被另一个新 row model 取代，分片保护仍有意义。 |
| `TextMessageViewModel.numberOfRowsInSection` (`0x105f0f284`) | `q16@0:8`。 | Adapter 的 `CSUInt` 接受非负 `q`；不是只接受 `Q` 导致文本失效。 |
| `BaseChatViewModel.rowHeight` (`0x1002abf8c`) | `0x1002abfd8` 加载 `measure:` 并分发；`0x1002abfe4` 对返回 CGSize.height 向上取整，`:fe8` 写原生高度缓存。 | 原生模型仍负责自己的测量/缓存；我们在 table delegate `%orig` 后处理返回值。 |
| `CommonMessageViewModel.measure:` (`0x10104e014`) | `{CGSize=dd}32@0:8{CGSize=dd}16`；`0x10104e328` 调用 `measureContentViewSize:`；还读取 CSS 顶距、`replyTextSize` (`0x10104e564`)、`replyTextInset` (`0x10104e598`)。 | 仍是文本/回复完整原生测量链；没有用旧 selector 的“仅存在但不被本链调用”情况。 |
| `TextMessageViewModel.measureContentViewSize:` (`0x105f104a0`) | `{CGSize=dd}32@0:8{CGSize=dd}16`；`0x105f104c0` 获取 `contentHeight`。 | 正文测量协议仍在。 |
| `tableView:cellForRowAtIndexPath:` (`0x100335588`) | `@32@0:8@16@24`；`0x10033590c` 发送 `makeCell:indexPath:`。`makeCell` 在 `0x100334d68` 再取 `cellDataForRow:`，`0x100334d84` 发送 `setViewModel:`。 | 与 Bind 使用同一 row model；并非单独新容器完全绕过绑定链。 |
| `TextMessageViewModel.cellViewClassName` (`0x105f0f278`) | `0x105f0f27c` 返回具体 CFString `TextMessageCellView`。`ChatTableViewCell.setViewModel:` 在 `0x100fd9388` 读取此 selector，`:93ac` 发送 `initWithViewModel:`，复用路径则 `:9354` / `:9450` 发送 `setViewModel:`。 | 普通 Text 的创建和复用确实进入已有 Common/Text cell 继承与 hook 链，旧类并非只剩孤立方法声明。 |

完整 `.asm` 与 `-annotated.asm` 并存。注释通过同一 Mach-O 的 selector refs / ivar / CFString 数据加入，未用字符串搜索代替方法存在或调用关系证据。方法边界取下一个 Objective-C IMP，某些范围也包含该方法使用的本地 block invoke 函数；证据中明确使用具体地址，未把整个区间都称作一个不可分割的方法体。

## 透明边距工厂协议仍与原生背景共用

真实 `BubbleInfo.getBubbleImage:isDarkMode:useCache:` 的编码为 **`@28@0:8B16B20B24`**，IMP 为 `0x104d9ed5c`：返回对象、三个显式 BOOL，恰好匹配 `CSBubbleStyleAdapter.m:285` 起的参数个数/返回/逐参数校验。

- 原生 `CommonMessageCellView.initBgImageView` 内 block 位于 `0x10103e228` / `0x10103e2c4`；分别从当前 model 取 `bgBubbleInfo`，在 `0x10103e280` / `0x10103e31c` 发送 `getBubbleImage:isDarkMode:`，normal 参数 `w2=0`，highlight 参数 `w2=1`。
- 二参数包装方法 `0x104d9ed00` 在 `0x104d9ed04` 加载三参数 selector，在 `0x104d9ed08` 设置 `w4=1`，尾调同一工厂，说明原生背景同样使用 `useCache:YES` 路径。
- 三参数工厂将 `x4` 保存为 `x21`，`0x104d9ee70` 检查 `w21` 决定是否读缓存；`0x104d9ee7c` 为 `objectForKeyedSubscript:`。命中时返回缓存对象；未命中时 `0x104d9ef58` 调用 `resolvedBubbleImage:isDarkMode:`，随后解析 image asset/configuration。
- `0x104d9f0e0`、`0x104d9f194`、`0x104d9f254`、`0x104d9f34c` 等分支调用 `resizableImageWithCapInsets:resizingMode:`。`0x104d9f37c` 再检查保存的 useCache，`0x104d9f38c` 为 `safeSetObject:forKey:`。返回寄存器最后在 `0x104d9f3d4` 置为生成/缓存的图像对象。

由此放行的是已核验的 cached stretchable UIImage 工厂；没有换成随意数字或绕过现有 UIImage、方向、动画、cap inset 与像素透明边距检查。

## 后续容器 layout 与 Render 顺序

`ChatTableViewCell.layoutSubviews` (`0x100fd9670`) 在 `0x100fd985c` 先把外层 contentView bounds 赋给 `m_cellView.frame`，在 `0x100fd9870` / `0x100fd9880` 分别发送 setNeedsLayout / layoutIfNeeded；之后若首次显示，则 `0x100fd98a8` 加载 onAppear 并调用。该函数后半段没有在 layoutIfNeeded / onAppear 之后再次写 `m_cellView.frame`。

`CommonMessageCellView.layoutSubviews` (`0x101035af0`) 调用 super；`BaseChatCellView.layoutSubviews` (`0x1002ab850`) 在 `0x1002ab95c` 动态调用 `layoutInternal`，因此仍进入 `CommonMessageCellView.layoutInternal` (`0x1010360b4`)，其 `0x101036694` 动态分发 `layoutContentView` 到实际 Text/Voice 等子类。原生文字、头像、气泡和 content container 的布局均发生在该原生调用内。

外层插件边界是 `Hooks/MessageGestureHooks.xm:15` → `CSMessageCellPerformLayout`。后者在 `CSMessageCellLifecycle.m:22` 恢复自己上次拥有的 origin，在 `:23` 执行完整 native layout，在 `:28` 才 Render；嵌套 depth 保证一次外层执行。上述后续 onAppear 还会通过 `MessageGestureHooks.xm:17` → `CSMessageCellRefresh` → `CSMessageCellLifecycle.m:60` 再次 Render。因此已检查的原生容器重设 frame 路径位于最终插件 Render 之前，不能解释“在首次测量早已拒绝 profile”的基线失败。新联合测试还重复原生原点恢复/Render，检查 seam 与行高稳定。

原生 model 的 rowHeight cache 仍保持原生值，这是既有设计。每次表格请求均在已核 ABI 的 delegate 返回边界重新投影一次；不存在通过缩小原生缓存引发第二次相减的改动。运行中如发现未知子视图、溢出、变换或附加内容，Render 仍可主动回退，属于保留的安全措施。

## 设置和上次测试遗漏

`CSBubbleStyleSettingsViewController.m:103` 的“紧密”选项写新键值 1，`CSMessageMergePolicy.h:10` 的 compact 枚举值就是 1；Policy `:19`–`:27` 优先读取新键，只有新键缺失才读取旧键负数。新 compact 联合测试在实际生产 Configuration 上断言这些优先级，详细数值和红/绿结果见 `../compact-validation/FINDINGS.md`。没有手机持久设置读取证据，不能把受控测试值声称为用户设备的真实 preference。

上一轮 `docs/audits/wechat-8.0.80-2026-11-05/merge-validation/fixtures/MessageMergeAdapterTests.m:31` 将 `CSBubbleStyleModelInsets` 替换为直接 YES 的桩；`run-validation.py:24` 的源文件集合不包含真实 Bubble Adapter。原来的气泡测试宏 `CS_BUBBLE_TESTING` 又绕过生产版本门槛。因此上次“merge profile 白名单转绿”没有穿透这条下游真实依赖，本次红/绿测试已补上该覆盖缺口。

## 重放与验证边界

```sh
python3 docs/audits/release-2.2-15-8080-compact-and-closefriend-reset/native-validation/collect_native_evidence.py
```

脚本先核对主二进制 SHA-256，再读取 Objective-C metadata、审计 ABI，运行定点 `xcrun llvm-objdump`，生成可追溯注释与命令。`abi-check.log` 显示 64 个声明、62 个匹配、2 个明确 legacy 缺失、0 个 ABI mismatch。

本目录证据为静态协议与生产代码分支证据。用户真机中的 hook 安装、最终 2pt 可见间距、字体/动态 CSS 和大礼包其他注入插件干扰均 **未验证**。本次已经测得并红/绿验证的是 2.2-14 的确定版本门槛断点；真机显示验收仍由交付后同会话正常/紧密切换、滚动复用和特殊消息检查完成。
