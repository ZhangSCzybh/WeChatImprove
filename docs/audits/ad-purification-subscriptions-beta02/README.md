# WeChat 8.0.80 订阅流整卡静态核验

本目录是 beta02 新增订阅流适配的研究证据。全部操作为执行外的 Mach-O 元数据解析与定点 LLVM 反汇编；没有运行、注入或安装 WeChat，没有访问聊天/帐号数据库。旧 `ad-purification-8.0.80` 审计保持 beta01 语义，未修改其 SHA 绑定或 95 个 hook 清单。

目标为 `com.tencent.xin 8.0.80 (8.0.80.34)`，arm64 主程序 SHA-256：`1d626426df97058a8a87c661532b2801cd27b7d9fcc12e27609c751f5877b7ed`，image base `0x100000000`，`cryptid=0`，指针格式 `DYLD_CHAINED_PTR_64_OFFSET (6)`。沿用已提取的只读临时主程序，不重新解包整个 IPA。

## 已证实的整卡判定

`CMessageWrap -isBizAdCanvasMsg`，`B16@0:8`，IMP `0x104e67718`：

```objc
return [self m_uiMessageType] == 10002 && [self m_bizMsgType] == 6;
```

独立的 `-isBizRecommendCanvasMsg`，IMP `0x104e676c4`，条件是 `10002 / 8`。因此推荐 Canvas、普通订阅文章和恰好具有子类型 6 的其他消息（例如主类型 49）均不应视为该广告类型。证据：[message-ad-predicates.asm.txt](message-ad-predicates.asm.txt)。

## 采用的最窄调用边界

`FlutterBrandTLApiImplementation` 与 `FlutterFinderBoxApiImplementation` 都声明：

```text
-getMassSendDataLastOrderId:initData:resetData:completion:
v40@0:8q16B24B28@?32
```

这两个 ObjC 方法中的消息转换循环是同步执行的。它们均先调用 `BrandTimelineMsgMgr +canTimlineMsgDiscard:`，YES 分支直接跳过整张消息卡：

- 普通路径：`0x101d4ebb8` 调用 predicate，`0x101d4ebbc` 分支；YES 经日志后直接转到 `0x101d4ec68`，跳过 `convertMsgWrapToMassSendMsg:` 和 `safeAddObject:`。
- Box 路径：`0x101d68934` 装载的接收类同样是 **BrandTimelineMsgMgr**，`0x101d68940` 调用 predicate，YES 从 `0x101d689b4` 直接转到 `0x101d69218`，跳过整个 `BoxMassSendCardMsg` 构造及加入数组流程。

证据：[flutter-mass-send-data.asm.txt](flutter-mass-send-data.asm.txt)、[box-flutter-masssend-full.asm.txt](box-flutter-masssend-full.asm.txt)。

适配设计是在两个 `getMassSendData...` 的原调用范围内设置线程局部显示上下文，只在该上下文内将宿主广告谓词为真的消息报告为 discard。不得全局改变 discard，因为同一 predicate 也用于 AFF 数据迁移。

`BrandTimelineMsgMgr +canTimlineMsgDiscard:` 的原函数仅读取 `m_uiMessageType`，type `1 / 34 / 3` 返回 YES，本体没有数据库写入。最终适配先调用前驱并保留原有 YES；只有新增显示上下文内且宿主广告谓词为真时才新增 discard。证据：[brand-can-discard.asm.txt](brand-can-discard.asm.txt)。

## 迁移边界与实际返回类型

这两个类均声明 `-doDataMigrate`：

| 类 | 原始 ABI | IMP |
| --- | --- | --- |
| AffBizCppToNativeManagerImpl | `@16@0:8` | `0x1000839a0` |
| BoxAffBizCppToNativeManagerImpl | `@16@0:8` | `0x10041ed98` |

**它们返回 ObjC 对象，不能按 void 包装。** 两函数在枚举旧消息时调用 `canTimlineMsgDiscard:`，YES 会跳过 CMessageWrap → AFF 的迁移转换。不能证明首次 `getService:` 不会在显示方法栈内触发迁移，所以适配另用两个迁移 wrapper 暂停显示上下文，并在 finally 中恢复；最终适配透传前驱调用、返回对象与异常，在 finally 中恢复显示上下文。任一迁移保护类/方法不存在、ABI 错误或安装失败时，新增显示过滤保持关闭，不安装显示 wrapper。

证据：[brand-migration-whole.asm.txt](brand-migration-whole.asm.txt)、[box-migration-whole.asm.txt](box-migration-whole.asm.txt)、[selector-xrefs.json](selector-xrefs.json)。

## 排除全局卡片 converter return-nil 方案的依据

`BrandFlutterUtility +convertMsgWrapToMassSendMsg:` 确实是 `@24@0:8@16`，返回 ObjC `MassSendCardMsg`，并非 C++ 结构体。普通列表调用者用 `safeAddObject:`，但其他调用者的语义不同：

1. Box 列表调用者在 `0x101d689cc` 取得转换结果后，不检查 nil，马上 `new BoxMassSendCardMsg`、逐字段拷贝，再以 `addObject:` 加入输出。全局让 converter 对广告返回 nil 会保留一个空字段 Box 卡，不能证明整卡已消失。
2. 两 API 类的 `onAddBrandTimelineMsg:` 和 `onDelBrandTimelineMsg:msgWrap:` 把 converter 结果写入 `BizNotifyInfo.msgInfo`，然后继续发送 Flutter 数据变化通知。直接返回 nil 会改变该通知，Dart 对缺失字段的容忍未被证明。

因此最终适配不修改该 converter。证据：[brand-to-masssend.asm.txt](brand-to-masssend.asm.txt)、[masssend-add-delete-callbacks.asm.txt](masssend-add-delete-callbacks.asm.txt)、[box-masssend-add-delete-callbacks.asm.txt](box-masssend-add-delete-callbacks.asm.txt)、[masssend-selector-xrefs.json](masssend-selector-xrefs.json)。

## completion 的两类 ABI 不得混淆

两个 API 的 `getMassSendData...` 最终 completion 携带 ObjC 卡片数组和错误对象；普通成功调用点 `0x101d4eccc–0x101d4ecd0` 传入复制的数组和 nil error。

另一个方法 `BrandTimelineMsgMgr -getBizTimelineMsgListWithCompletion:`（IMP `0x10071bb78`，外部 encoding `v24@0:8@?16`）却构造并传递 C++ protobuf `BizTimelineMsgList` 对象的地址。`@?` 元数据不能表达 block 内部参数类型；不能把这个 completion 猜成 NSArray。最终适配无需重建或包装这两种 completion。证据：[brand-get-biz-timeline-list.asm.txt](brand-get-biz-timeline-list.asm.txt)。

## 其他已确认、未作为本次新 hook 的路径

- `BrandTimelineViewController` 旧 header 名在 8.0.80 主 image 中不存在；真实存在 `BrandTLFlutterViewController` 和 `BoxBrandTLFlutterViewController`。两组 Brand/Box manager 都直接继承 `MMUserService`，互为平级。
- `BrandTLExptConfig -getExptExcludeMsgTypeArr` 直接读取 `exptShowOption`，根据 bit1 缺失加入广告子类型 `@6`；不通过 `isExptNotShowAd`。单改后者无法覆盖所有消费点。证据：[brand-expt-exclusions.asm.txt](brand-expt-exclusions.asm.txt)。
- `BrandAffDataConverter +convertAffMsgInfoDataListToMsgWrapList:`（`@24@0:8@16`）把 NSData protobuf 解为 NSMutableArray<CMessageWrap *>；length 为零时返回 nil。实际同步 caller 是两 manager 的 `getTopAffMsgByCount:`，先 `getTopNData:` 再转换。它不能被表述为所有 AFF Flutter 主列表的唯一出口。本次最终方案不修改此 converter。证据：[aff-list-converter.asm.txt](aff-list-converter.asm.txt)、[brand-aff-get-top-msgs.asm.txt](brand-aff-get-top-msgs.asm.txt)、[box-aff-get-top-msgs.asm.txt](box-aff-get-top-msgs.asm.txt)。
- 两 VC 的 `getMagicBrushFlutterPlugins` 都构造包含 5 个 service getter 返回值的 NSArray，元素是插件实例。`getSclAdBrandPlugin` 的 Swift getter 绑定类型 accessor `0x10b2bfe78`；它使用的类地址 `0x11f0c06d8` 与元数据里的 `_TtC6WeChat28MagicSclBrandAdFlutterPlugin` 一致。不是 Class 名称字符串数组。证据：[brand-flutter-plugin-list.asm.txt](brand-flutter-plugin-list.asm.txt)、[box-flutter-plugin-list.asm.txt](box-flutter-plugin-list.asm.txt)、[magic-get-ad-plugin.asm.txt](magic-get-ad-plugin.asm.txt)、[ad-plugin-lazy-getter.asm.txt](ad-plugin-lazy-getter.asm.txt)、[ad-plugin-type-accessor.asm.txt](ad-plugin-type-accessor.asm.txt)。

## 复核与边界

`objc-metadata.json` 从 46,673 个主 image 类中选择 117 个相关类及其祖先，解析错误为零。`metadata-targets.json` 中的伪 selector 仅用于选择类，并非 hook 候选；对应结果已从 `hooks` 字段清空。

`verify_new_abi.py` 仅检查最终新增的五个方法与真实主程序声明，结果写入 `new-hook-abi.json/.csv`，并记录新适配源文件当时的 SHA-256。本次最终源文件 SHA-256：`fdd472e532a6fc67e9324f71cebc356dc7ab8bf5e07749d926d261de56b72ffa`；5/5 个声明已全部匹配，旧 beta01 的 95 个候选未改，候选总数为 100。以后源文件编辑完成后应重跑此脚本。

`extract_assembly.py` 依照 `assembly-ranges.json` 生成定点 LLVM 汇编，并对静态字面量 selector/class 引用添加注释。注释是线性的 ADRP/ADD 地址辅助，不是完整控制流证明；报告结论以人工核对的关键分支为准。stripped binary 的 LLVM 最近符号标签不代表方法名；IMP 与方法名绑定来自 ObjC 元数据。

`find_selector_xrefs.py` 是有界的直接 ADRP+LDR 候选搜索，保存了已确认的调用者；它不宣称穷尽动态派发或间接引用。

这份研究证明方法存在、ABI、精确广告类型和对应同步列表的 skip 行为。它没有在真机执行新代码，不能代替重启后进入订阅流、已有缓存、普通文章及推荐内容的设备验收，也不能证明所有 AFF C++/Flutter 路径都会经过这些 ObjC 方法。本轮 REA session 查询为 `open=false`，未打开 native provider，因此无待关闭的目标或临时分析进程。
