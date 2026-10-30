# 冷启动顶部业务行：原生静态证据

本记录只说明微信原生 Header cell 与 banner 的所有权、复用和同步调用语义。未连接设备、启动微信、注入探针或采集修复后的帧；不能把静态分析或主机替身回归写成已经观察到真机空白帧消失。

## 样本身份与方法

- 本地原生样本：`/tmp/wechat-8.0.78-inset-analysis/WeChat`。
- 文件大小：567459632 字节。
- SHA-256（本次实际重算）：`0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。
- 架构：Mach-O arm64，既有审计标识为微信 8.0.78。
- 哈希与既有 `docs/audits/folded-native-parity-2.0-24/native/rendering/manifest.json` 一致。
- 本次先读取 `reverse-engineer-anything` skill，再检查 REA session（未打开原生目标）；为避免导入大型目标，复用仓库已有只读 Mach-O Objective-C 元数据解析器的读取部分，通过 `xcrun llvm-objdump -d --start-address=… --stop-address=…` 核对少量指定方法。没有修改二进制、既有审计或分析数据库。
- 方法名、地址及类引用来自 Objective-C 元数据，指令来自上述原始样本。它们是静态证据，未观察运行时调用顺序。

既有完整反汇编来源：

- `docs/audits/folded-native-parity-2.0-24/native/rendering/NewMainFrameViewController--tableView_cellForRowAtIndexPath_.asm`（方法 `0x10511eafc–0x10511f64c`，对应 manifest 标记 `truncated: false`）。
- `docs/audits/folded-card-style-2.0-20/native/NewMainFrameViewController--tableView_cellForRowAtIndexPath_.asm`（同一方法、同一文件哈希 `6032d0b8206b3c8f3947798866ebb1be7ada00311e7f5fba181d3ceb96846404`）。
- `docs/audits/list-restore-2.1-3/native/MMTableView--layoutSubviews.asm`。
- `docs/evidence/message-actions-native-2026-10-17/classes.json`（既有类地址）。
- `docs/evidence/close-friends-native-2026-10-20/extract.py`（复用读取部分，未执行其审计写入代码）。

## `getBanner:` 同步返回既存共享视图

`MainFrameHeaderLogic.getBanner:` 位于 `0x104a877c4–0x104a87824`。其操作是从 `m_bannerAry` 取包装器，再返回包装器的 `banner`：

```asm
104a877d0: adrp x8, 0x120223000
104a877d4: ldrsw x8, [x8, #0x1fc]
104a877d8: ldr x0, [x0, x8]       ; m_bannerAry
104a877e0: ldr x1, [x8, #0x580]   ; safeObjectAtIndex:
104a877e4: bl  0x107c2713c        ; objc_msgSend，索引参数仍为 x2
...
104a877f8: ldr x1, [x8, #0x400]   ; banner
104a877fc: bl  0x107c2713c
```

`BannerWrap.banner` 位于 `0x104a86eb0–0x104a86eb8`，完整方法只有：

```asm
104a86eb0: ldr x0, [x0, #0x10]
104a86eb4: ret
```

头文件 `HeadersFile/BannerWrap.h` 也将 `banner` 声明为包装器持有的 `UIView<MFBanner> *`。因此在包装器及其属性未变化时，同一索引取得同一个 UIView；这个 getter 没有创建新内容、异步准备或等待下一帧的代码。

`MainFrameHeaderLogic.bannerCount` 位于 `0x104a877ac–0x104a877c4`，直接对同一个 `m_bannerAry` 发送 `count`。

## Header cell 的清理和挂载

`NewMainFrameViewController.tableView:cellForRowAtIndexPath:` 中的 banner 分支使用复用标识 `Header`。它与普通会话 `NewMainFrameCell` 分支不同：

```asm
10511f33c: ldr x1, [x8, #0xee8]   ; dequeueReusableCellWithIdentifier:
10511f344: add x2, x2, #0x9e8     ; CFString 'Header'
10511f34c: bl  0x107c2713c
...
10511f364: ldr x1, [x8, #0x4e8]   ; contentView
10511f368: bl  0x107c2713c
...
10511f37c: ldr x1, [x8, #0xff0]   ; removeAllSubViews
10511f380: bl  0x107c2713c
```

若没有可复用的 Header cell，则 `0x10511f390–0x10511f3b4` 新建 `MMTableViewCell`，调用 `initWithStyle:reuseIdentifier:`，复用标识仍为 `Header`。

随后同步取得 banner 并放入当前 cell：

```asm
10511f54c: ldr x1, [x8, #0x810]   ; row
10511f554: bl  0x107c2713c
10511f558: mov w2, w0
10511f560: ldr x1, [x8, #0x68]    ; getBanner:
10511f564: mov x0, x19            ; MainFrameHeaderLogic
10511f568: bl  0x107c2713c
...
10511f574: mov x22, x0            ; 保存返回的 banner
10511f5a4: ldr x1, [x8, #0x318]   ; setWidth:
...
10511f5bc: ldr x1, [x8, #0xc8]    ; setAutoresizingMask:
...
10511f5d0: mov x1, x19            ; contentView selector
10511f5d4: bl  0x107c2713c
...
10511f5e8: ldr x1, [x8, #0xed8]   ; addSubview:
10511f5ec: mov x2, x22            ; 同一个 banner
10511f5f0: bl  0x107c2713c        ; [cell.contentView addSubview:banner]
```

可证结论：每次重新创建 Header cell，原生会把同一个 banner 挂到当前 contentView。UIKit 的 UIView 只有一个 superview，因此构建第二个容器会把 banner 从第一个容器移走。第一个容器的底色、几何和圆角可以继续存在，其业务内容却已经离开。它能够解释“同高卡片、图标文字同时短暂缺失”的现象，但静态证据本身不证明在用户录屏中发生的确切两个回调时刻。

## `didEndDisplaying` 与 `didMoveToSuperview` 不负责清空 banner 内容

`NewMainFrameViewController.tableView:didEndDisplayingCell:forRowAtIndexPath:` 位于 `0x105120c98–0x105120db8`。它先检查 `NewMainFrameCell`：

```asm
105120cd0: ldr x22, [x8, #0x420]  ; classref 0x12017b420
...
105120cf8: ldr x1, [x8, #0x858]   ; isKindOfClass:
105120d00: bl  0x107c2713c
...
105120d10: cbz w22, 0x105120da0   ; 非 NewMainFrameCell 直接结束
...
105120d88: ldr x1, [x8, #0xe0]    ; didEndDisplayCell:isReloadingData:
105120d94: bl  0x107c2713c
```

本次读取 classref `0x12017b420`，目标为 `0x120385228`；既有 `classes.json` 将其标识为 `NewMainFrameCell`。Header 分支创建的是 `MMTableViewCell`，不进入这个普通会话的结束显示分支。该方法完整范围内没有 Header banner 的移除或文字清空。

`MFBannerBtn.didMoveToSuperview` 位于 `0x1022b2acc–0x1022b2b60`。调用 super 后仅获取新 superview 的 `width`，再向自身发送 `setWidth:`、`setAutoresizingMask:2`。完整范围内没有 `setTitle:`、图标移除、内容清空或异步填充。

## 表头 setter 中存在同步布局入口

`MMTableView.setTableHeaderView:` 位于 `0x1167291dc–0x116729584`（入口与结束地址另与既有 `docs/audits/list-restore-2.1-3/native/methods.json` 核对）。原生先调用 super 的表头 setter，再根据 `hasSearchBarHeader`、背景和包装容器处理表头。其中一个包装容器分支在加入表头前显式同步布局：

```asm
1167292f8: ldr x1, [x8, #0x1b0]  ; setTableHeaderView:
1167292fc: mov x0, sp            ; super 调用接收结构
116729300: mov x2, x19
116729304: bl  0x118329cf8        ; objc_msgSendSuper2
...
116729428: ldr x1, [x8, #0xf40]  ; setNeedsLayout
116729430: bl  0x118329cec
116729438: ldr x1, [x8, #0xd70]  ; layoutIfNeeded
11672943c: mov x0, x21           ; 新包装容器
116729440: bl  0x118329cec
116729448: ldr x1, [x8, #0xed8]  ; addSubview:
11672944c: mov x0, x21
116729450: mov x2, x19          ; 表头视图
116729454: bl  0x118329cec
...
1167294d8: ldr x1, [x8, #0x1b0] ; setTableHeaderView:
1167294dc: add x0, sp, #0x10    ; 另一处 super 调用接收结构
1167294e0: mov x2, x21
1167294e4: bl  0x118329cf8
```

边界：这里的 `layoutIfNeeded` 接收者是包装容器，不应表述成“已观察到此指令必定同步构造 table cell”。super 表头 setter 是否在特定设备、系统和当前表状态下同步触发数据源回调，仍属于 UIKit 运行时行为。可以据此构建具有同步重入能力的表头 setter 主机替身，检查适配器在正式发布前是否允许第二次 Header cell 交付；替身结果属于受控回放证据。

另外，`MMTableView.layoutSubviews`（`0x116729e84–0x11672a124`）先调用 super，随后还有取 `singleSelectedIndexPath`、`cellForRowAtIndexPath:` 的路径。这进一步说明对表头或布局操作应保留 UIKit 重入可能性，但不等于它一定触发新的数据源 `tableView:cellForRowAtIndexPath:` 构造。

## 与本次修复论证的关系

静态原生证据能够确认：banner 内容已有同步 getter；重复构造容器会重挂同一 UIView；Header 没有依赖 didEnd 或下一帧补内容的原生协议。适配器首次发布时若先更新表头/布局，暴露可重入的数据源，再执行正式发布，可以对同一业务行重复交付容器，产生内容被抢走的风险。

适配器的确切首发调用顺序、修改后的提交次数和旧代码红项/新代码绿项，应由本目录的源码说明及核心回归报告共同证明。用户录屏已证明旧包可见空白帧；本记录没有修复后真机录屏，不能据此承诺设备上“已实测零空白帧”。
