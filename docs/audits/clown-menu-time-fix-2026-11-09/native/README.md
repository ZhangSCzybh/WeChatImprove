# 微信 8.0.80：转账菜单与原生时间切换的静态证据

本轮使用 `reverse-engineer-anything` 技能，复用既有纯净 IPA 解包主程序：

`/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat`

SHA256：`1d626426df97058a8a87c661532b2801cd27b7d9fcc12e27609c751f5877b7ed`，545,074,336 bytes。原 IPA 为 `/Users/zhangshichao/Downloads/Telegram Desktop/com.tencent.xin_8.0.80.ipa`；既有 `wechat-8.0.80-ui-revoke-followup-2026-11-09` 审计确认版本 8.0.80.34，并确认其与此前大礼包主程序的 58 个有内容 Mach-O section 地址、大小、偏移及内容哈希相同。本轮没有再次解包，没有启动微信、读取聊天数据库或调用支付/发送接口。

REA 成功打开并识别此 arm64 Mach-O；Ghidra 首次 `search_procedures` 在 600,000 ms 返回 `provider_timeout`，没有可引用的成功反编译 Evidence ID。本目录随后直接解析同一文件的 ObjC 元数据，并对精确 IMP 范围执行 `xcrun llvm-objdump`。下述为静态观察及由其推导的调用关系，不能等同真机执行轨迹。

## 转账形态和菜单

- `WCPayTransferMessageCellView` 的父类为 `WCPayBaseMessageCellView`，后者父类为 `CommonMessageCellView`。基础转账类声明 `m_titleLabel` 为 `@"UILabel"`、实例偏移 192，`m_descLabel` 为 `@"UILabel"`、偏移 184。`WCPayBaseMessageCellView-initTitleLabel.asm` 的 `0x1097b7a90` 引用实际分配类 `MMUILabel`。没有发现本轮主程序 classlist 中第二个名称含 Transfer 和 CellView 的类；此负面结论仅限本主程序，不包含未搜索框架和实际设备注入类。
- `WCPayTransferMessageCellView-updateTitleLabel.asm` 的普通转账分支在 `0x109e747a8` 读取 `titleText`，随后调用 `setText:`；群转账分支读取 `groupTransferTitleAttributedText` 并调用 `setAttributedText:`。没有证据表明普通转账仅把金额藏在 attributedText 且 `.text` 必为 nil，也没有证据支持此版统一改用 YYLabel/FitMesureLabel。
- `WCPayTransferMessageViewModel-innerTitleText.asm` 读取 `messageWrap.m_oWCPayInfoItem.m_nsFeeDesc`；非群转账且 feeDesc 非空时直接返回原字符串，不补货币符号。缺失 feeDesc 等分支返回 `messageWrap.m_nsDesc`。因此旧插件只接受 `¥`／`￥`／`元` 的金额正则确实有输入覆盖缺口：纯数字及其它币种的 native feeDesc 会被拒绝。**本轮没有真机读取用户实际转账标签，不能据此声称这就是该设备菜单消失的唯一原因。**
- `WCPayInfoItem.m_nsFeeDesc` 方法 ABI 为 `@16@0:8`，IMP `0x1099e1188`。`CMessageWrap.m_oWCPayInfoItem` 属性元数据为 `T@"WCPayInfoItem",&,D`（动态 getter）；其调用可见于 native title 方法，但静态 class 方法表没有该动态 getter 的直接 IMP。字段仅用于只读识别/预填。
- `+[WCPayTransferMessageViewModel canCreateMessageViewModelWithMessageWrap:]` IMP `0x109e76f8c` 明确要求 `m_uiMessageType == 49`，且 `m_uiAppMsgInnerType == 2000` 或 `2011`。`m_uiMessageType` ABI 为 `I16@0:8`。本 artifact 不支持以“转账实际走 419430449 等复合 type”解释故障，应保留 49 gate。
- 长按静态链为 `LongPressEvents` → `onLongTouch:` → `onLongTouch` → `showOperationMenu`。`showOperationMenu` 在 `0x1002b4070` 调用 `generateOperationMenu`，之后依次 `uniqMenuItems:`（`0x1002b408c`）、`filteredMenuItems:`（`0x1002b40b4`），再经 `SessionMenuAdjuester` 处理并交给 `MMMenuController`。`generateOperationMenu` 的 `0x1002b1288` 动态调用 cell 的 `operationMenuItems`。转账 override `0x109e76780` 自建数组并调用 `addRevokeOrDeleteMenuItem:`，不依赖 Common builder。因此转账专属 override hook 是正确入口，但 builder 后仍有原生去重和过滤，不能仅用 adapter 单元测试证明最终真机菜单可见。

## 最终菜单过滤补查

对同一主程序完整读取 `BaseMessageCellView.filteredMenuItems:`（`0x1002b3620`）、`SessionMenuAdjuester` 两个处理方法及其插入 helper 后，**未发现普通允许操作的 iPhone 聊天因自定义 menuType 未登记而被剔除的规则**。标准 `MMMenuItem` 的自定义转账类型 `0x43534303` 不命中这些方法的类型过滤或重排条件，因此没有静态证据支持为此绕过原生过滤。此结论有明确前提：菜单条目已由 builder 产生、未在前置去重中发生冲突，而且会话/消息未触发以下原生限制。

- `filteredMenuItems:` 先检查会话用户名。普通用户名在 `MMKernelUtil.IsBypMsgUserName:` 为 false 时（分支 `0x1002b36f4`）跳过特殊标题策略；bypass/bot 会话另有按 `.title` 的白名单或黑名单策略，不能据此保证自定义标题始终保留。
- `isOnlyShowDeleteMenu` 调用点 `0x1002b39a8`；该 helper 读取 `viewModel.messageWrap.IsMsgBubbleForbidAll`。为 true 时仅保留类型 8/4/5 或原生删除标题，自定义类型可能被移除。这是原生受限消息策略，不是针对转账的专门判断。
- `DeviceInfo.isVisionPro` 调用点 `0x1002b3c04`；为 false 时直接跳向返回 copy。Vision Pro 分支用 `containsObject:` 检查 menuType 14/13/3/25/12/19/15，命中后在 `0x1002b3e90` 跳过 `addObject:`，属于已知类型黑名单。`0x43534303` 不在其中。该方法没有 `canPerformAction:` 调用，也没有未知 menuType 通用白名单。
- `+[SessionMenuAdjuester adjustCustomMenuItems:]` IMP `0x105ae11b4`，ABI `@24@0:8@16`。它对数组 `mutableCopy`，只把 `MMMenuItem` 类型 5/4/8/46/47/57/58 的索引加入待移除 index set，随后重新插入/追加这些已知条目；未知的 `0x43534303` 未加入移除集合，保留在副本中。`insert:toMenuItems:atIndex:`（`0x105ae1808`）仅按 count 选择插入或追加，不清空、不再筛选数组。
- `+[SessionMenuAdjuester pinAskXiaoWeiMenuItemToEnd:]` IMP `0x105ae1544`，ABI `@24@0:8@16`。实验开关关闭时返回原数组；打开时仅收集 `menuType == 54`（比较点 `0x105ae16e0`）的 `MMMenuItem`，再将这些条目移到数组末尾。自定义类型既不被收集也不被删除。两个 adjuster 方法均未检查转账类、messageWrap 或 messageType。

上述 selector/class ref 已直接解引用校验，包含 `menuType`、`addIndex:`、`safeRemoveObjectAtIndex:`、`indexLessThanIndex:`、`removeObjectsInArray:`、`addObjectsFromArray:` 和 `MMMenuItem`。新增原始证据为三个 `SessionMenuAdjuester-*.asm` 与 `menu-adjuster-followup.json`，后者保存精确函数边界、命令、方法 ABI 和本次校验的引用槽。REA 会话已关闭；此补查没有重新启动 Ghidra、执行微信或修改生产代码。

**328 项真实 UIKit 测试没有执行微信完整 native generate → uniq → filter → adjuster → MMMenuController 链。** 本节是同一 artifact 的静态证据；实际设备上的最终菜单、其他插件注入及运行时状态仍需真机确认，不能将此静态结论或 UIKit 检查表述为已完成微信真机验收。

## 原生时间点击与模型生命周期

- 此版 `ChatTimeCellView` 比旧仓库 header 多 `onClickTimeLabel`，IMP `0x100fdf9b0`，ABI `v16@0:8`。它读取 viewModel 的 `showingTime`，必要时回退 `createTime`，检查 delegate 是否响应 `toggleTimeShowMode:`，随后发送此原生调用。
- `BaseMsgContentViewController.toggleTimeShowMode:` IMP `0x1003229b4`，ABI `v24@0:8d16`。它翻转页面的 `m_isTimeShowInDetail`，遍历已有节点，对同一 `ChatTimeViewModel` 对象依次调用 `resetLayoutCache`（调用点 `0x100322acc`）和 `updateLayouts`（`0x100322ad8`）。这个方法没有分配/替换这些时间模型，按弱模型指针保存临时日期可以跨此模式切换保留。
- `ChatTimeViewModel.measure:` 会查询 delegate 的 `isNeedShowTimeInDetail`；`updateLayouts` 在相同模型与现有 cell 上刷新布局。插件应让原生点击与模式翻转先执行，再按页面当前模式重绘临时日期覆盖层，不改原模型时间或 native 字符串。

## 证据与复现

- `artifact.json`：主程序身份、大小、解析脚本身份与范围限制。
- `objc-metadata.json`：9 个相关类的真实实例方法、类方法、ivars 和 properties；保留准确 ObjC type encoding。
- `transfer-cell-class-inventory.json`：主程序中 Transfer/CellView 名称过滤结果。
- `disassembly-commands.json`：22 个精确方法的命令、起止地址、输出文件；方法边界来自 `LC_FUNCTION_STARTS`，终点不含在范围内。
- `*.asm`：未经重写的 LLVM 反汇编。最近导出符号标签（如 `_Flutter_MMFoundation_BindContext`）不代表 ObjC 方法名；应按元数据中的 IMP 地址核对。
- `reference-annotations.json`：从字面 ADRP/LDR 地址推得的 selector/class ref 辅助索引，未作完整控制流或跨过程值流分析；判断以原始指令和元数据为准。
- `rea-results.json`：REA 打开身份、搜索 timeout 与关闭结果。
- `extract-native.py`：仅只读输入 Mach-O，输出本目录的元数据与精确范围反汇编。复跑时传入上述绝对主程序路径。

建议回归覆盖标准转入/转出/已收款卡片、纯数字 feeDesc、带其它币种与千分位的 feeDesc、群转账富文本、record detail 排除、重复长按去重、经 native generate → uniq → filter 后仍可见，以及修改后的时间反复点击切换简略/详细显示。消息内容、`m_oWCPayInfoItem`、支付状态与数据库均必须保持原值；最终菜单是否显示仍需目标微信真机确认。
