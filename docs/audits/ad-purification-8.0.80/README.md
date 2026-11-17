# 微信 8.0.80 广告适配静态核对

核对日期：2026-11-17。仅定向解压主程序与 Info.plist；未运行、加载、注入或重新打包此 IPA。未做全量 Ghidra 分析。

本目录同时保留参考插件的 198 项注册核对和项目最终实现的 [95 项实际 Hook 核对](actual-hook-compatibility.md)（[JSON](actual-hook-compatibility.json)）。最终实现中 83 项显式声明且完整 ABI 匹配、11 项为 protobuf dynamic getter、1 项为系统 NSURL；实际接入范围以最终实现清单为准。

## 样本身份

- IPA：`/Users/zhangshichao/Downloads/Telegram Desktop/com.tencent.xin_8.0.80.ipa`。
- IPA SHA-256：`5cacb443b743793ccfe6026bc81c1f2678cb5cfdcd38584ad73ac7f19ecf4a5f`。
- Bundle：`com.tencent.xin`；显示版本 `8.0.80`；构建 `8.0.80.34`；最低 iOS `15.0`。
- 主程序：`Payload/WeChat.app/WeChat`，545,074,336 字节，thin arm64；SHA-256 `1d626426df97058a8a87c661532b2801cd27b7d9fcc12e27609c751f5877b7ed`。
- `LC_ENCRYPTION_INFO_64 cryptid=0`，cryptoff=32768，cryptsize=472334336；代码在该文件中未标记为加密。
- `LC_BUILD_VERSION`：iOS，minos=15.0，sdk=27.0；UUID `7E4A8171-5ACC-3A72-A76A-3ACE52D3D895`。
- 原始 load commands 见 `load-commands.txt`；版本的 REA Evidence 为 `ev_66496293fb7dd61c9f777fe91904be1b9f9ac47dce6733a7de08978fc7780b7d`（`plist-evidence.json`）。

## 核对方法与覆盖

`inspect_objc_metadata.py` 直接读取 Mach-O 文件的 ObjC class/category/method/ivar/property 元数据，并解码该主程序使用的 DYLD_CHAINED_PTR_64_OFFSET(6) rebase 与 import。共读到 46,673 个类，聚焦参考样本的 64 个目标及其镜像内祖先，保存 81 个类，解析错误为 0。
参考样本共 198 项注册：167 项在目标类/其 category 中有显式声明，6 项由镜像内祖先声明，23 项未在这些方法表中声明，2 项为主镜像外系统类。此数量包含参考样本新增的两个方法，因此“未声明”不等同于“不兼容”。完整逐方法表见 `hook-compatibility.csv`；原始地址和编码见 `objc-metadata.json`。

## 当前版本的重要差异

1. `WCFinderFeedContentVM` 已去掉旧 init 的 `dataScene:` 段，当前三个入口是 `initWithDataItem:scene:`、`initWithDataItem:scene:isFinderIdentity:`、`initWithDataItem:scene:sessionExtraKey:`。scene 为 32 位有符号 int（`i`），不是 64 位。
2. VM 的 `dataItem` property 属性为 `T@"WCFinderDataItem",&,N,V_dataItem`。两种扩展 init 将原 x2/dataItem 和 x3/scene 原样转调基础 init；基础 init 对原 x2 发送 `username`、`contact`，与 WCFinderDataItem 契约一致。支持此判断的原始汇编及 selector ref 解码见 `finder-init-assembly.txt`。
3. `WCAdvertiseDataHelper` 的 `m_advertiseList`、`m_advertiseMsgXmlList`、`m_bLoaded` 是 ivar，当前没有同名 getter 声明；`getCachedBodyWrapList` 也未在该类/镜像内祖先中声明，不能照搬旧样本的方法 Hook。
4. `FinderObjectAdInfo`、`ObjectAdItem`、`ObjectAdContentH5` 继承外部 `WXPBGeneratedMessage`；它们的广告 getter 在 ObjC 方法表中未声明，但 property 表包含 `D`（dynamic）和具体类型。不能把这种情况表述为字段不存在；也不能仅凭 property 推断安装 Hook 时已有可取的 IMP。
5. `WCFinderRouterHelper` 广告路由当前签名在 `cardType:` 后新增 `commentScene:`；完整当前编码保存在该类 methods 表。
6. `WAJSInvoker invokeInJsContext:` 返回对象（`@`），不是 void。JSFunctionDef 的 permission BitSet/2/3 参数为 uint32（`I`），而 PermissionByteIndex 为 int64（`q`）。
7. NSURL 与 UIApplication 是系统框架类，未包含在主程序 classlist。此审计不把宿主 macOS 的同名系统类视作 iOS 设备证据。

## 重点方法 ABI

编码图例：`@` 对象、`:` selector、`B` BOOL、`i` int32、`I` uint32、`q` int64、`Q` uint64、`v` void。编码字符串中的数字为声明布局信息，保留原值；不将它们直接当作运行时栈上传参位置。

| 类 | 方法 | 原始类型编码 | 实现地址 |
|---|---|---|---|
| `JSEvent` | `-initWithDelegate:parameters:` | `@32@0:8@16@24` | `0x1021d0118` |
| `JSFunctionDef` | `+FuncDefWithFunc:Selector:FuncType:PermissionBitSet:RunInWebViewType:` | `@52@0:8@16:24q32I40Q44` | `0x1021d060c` |
| `JSFunctionDef` | `+FuncDefWithFunc:Selector:FuncType:PermissionBitSet2:RunInWebViewType:` | `@52@0:8@16:24q32I40Q44` | `0x1021d0760` |
| `JSFunctionDef` | `+FuncDefWithFunc:Selector:FuncType:PermissionBitSet3:RunInWebViewType:` | `@52@0:8@16:24q32I40Q44` | `0x1021d08b4` |
| `JSFunctionDef` | `+FuncDefWithFunc:Selector:FuncType:PermissionByteIndex:RunInWebViewType:` | `@56@0:8@16:24q32q40Q48` | `0x1021d0a08` |
| `MMWebViewConfig` | `+isEnableWebDebugFunctions` | `B16@0:8` | `0x104afdb5c` |
| `WAJSInvoker` | `-invokeInJsContext:` | `@24@0:8@16` | `0x1151bc26c` |
| `WCJSInvoker` | `-initWithJavascript:` | `@24@0:8@16` | `0x11579877c` |
| `WCJSInvoker` | `-initWithObj:Func:Args:` | `@40@0:8@16@24@32` | `0x1157987e8` |
| `WXSearchJSLogicImpl` | `-functionCall:withParams:withCallbackID:` | `v40@0:8@16@24@32` | `0x10aa74398` |
| `LocalJSEventHandler_WebAPIBridge` | `-initWithEvent:context:` | `@32@0:8@16@24` | `0x1023dafdc` |
| `LocalJSEventHandler_WebAPIBridge` | `-handleJSEvent:` | `v24@0:8@16` | `0x1023db1a0` |
| `LocalJSEventHandler_WebAPIBridge` | `-sendEventToJSBridge:Param:` | `v32@0:8@16@24` | `0x1023db540` |
| `LocalJSLogicBase` | `-sendEvent:handler:result:` | `v40@0:8@16@24@32` | `0x1023fc73c` |
| `BrandTLExptConfig` | `-isExptNotShowAd` | `B16@0:8` | `0x1006d8150` |
| `BrandTLExptConfig` | `-isExptNotShowRecCard` | `B16@0:8` | `0x1006d8194` |
| `BrandTLExptConfig` | `-isExptNotShowFinderLiveBar` | `B16@0:8` | `0x1006d81dc` |
| `BrandTLExptConfig` | `-isExptNotShowRecoFlow` | `B16@0:8` | `0x1006d8220` |
| `BrandTLFlutterViewController` | `-initWithExptConfig:` | `@24@0:8@16` | `0x1006d86e8` |
| `BrandTLFlutterViewController` | `-getMagicBrushFlutterPlugins` | `@16@0:8` | `0x1006d97ec` |
| `BrandTLFlutterViewController` | `-reportAdBrandCardOnClick` | `v16@0:8` | `0x1006dc244` |
| `BrandTLFlutterViewController` | `-insertMockCanvasModelToRecAtIndex:frameSetName:frameSetData:` | `v40@0:8q16@24@32` | `0x1006dc480` |
| `BrandTLFlutterViewController` | `-enableAd` | `B16@0:8` | `0x1006dc700` |
| `BrandTLCanvasCardMgr` | `-handleBizAdNotifyNewXml:` | `v24@0:8@16` | `0x1006d797c` |
| `BrandTLCanvasCardMgr` | `+isAdCardOpen` | `B16@0:8` | `0x1006d7340` |
| `BrandTLCanvasCardMgr` | `+isAdRequestOpen` | `B16@0:8` | `0x1006d74c4` |
| `WCAdvertiseDataHelper` | `-init` | `@16@0:8` | `0x106dc7f7c` |
| `WCAdvertiseDataHelper` | `-isAdPreviewExpired:` | `B24@0:8@16` | `0x106dc90d8` |
| `WCAdvertiseDataHelper` | `-IsAdvertiseDataValid:dataItem:` | `B32@0:8@16@24` | `0x106dc92f0` |
| `WCAdvertiseDataHelper` | `-tryLoadAdvertiseData` | `v16@0:8` | `0x106dca044` |
| `WCAdvertiseDataHelper` | `-saveAdvertiseDatas` | `v16@0:8` | `0x106dca980` |
| `WCAdvertiseDataHelper` | `-addAdvertiseData:needUpdateCreateTime:` | `v28@0:8@16B24` | `0x106dcbcb8` |
| `WCAdvertiseDataHelper` | `-addAdvertiseDataList:` | `v24@0:8@16` | `0x106dcbcf4` |
| `WCAdvertiseDataHelper` | `-saveAdvertiseMsgXmlDatas` | `v16@0:8` | `0x106dcd530` |
| `WCAdvertiseDataHelper` | `-saveAdPullCompareInfo:` | `v24@0:8@16` | `0x106dce094` |
| `WCAdvertiseStorage` | `-oAdvertiseData` | `@16@0:8` | `0x106e2554c` |
| `WCAdvertiseStorage` | `+PBArrayAdd_nsAdvertiseID` | `v16@0:8` | `0x106e25254` |
| `WCAdvertiseStorage` | `+PBArrayAdd_nsUsername` | `v16@0:8` | `0x106e25270` |
| `WCAdvertiseStorage` | `+PBArrayAdd_uiAdCreateTime` | `v16@0:8` | `0x106e2528c` |
| `WCAdvertiseStorage` | `+PBArrayAdd_uiAdDisplayTime` | `v16@0:8` | `0x106e252a8` |
| `WCAdvertiseStorage` | `+PBArrayAdd_oAdvertiseData` | `v16@0:8` | `0x106e252c4` |
| `WCAdvertiseStorage` | `+initialize` | `v16@0:8` | `0x106e252e0` |
| `WCAdDB` | `-initDB` | `v16@0:8` | `0x106c309cc` |
| `WCAdDB` | `-createTables` | `v16@0:8` | `0x106c30bc0` |
| `WCAdDB` | `-createPullRecordTable` | `v16@0:8` | `0x106c30bcc` |
| `WCAdvertisePushService` | `-OnGetNewXmlMsg:Type:MsgWrap:` | `v40@0:8@16@24@32` | `0x106df6324` |
| `WCAdvertisePushService` | `-handlePushMsg:` | `v24@0:8@16` | `0x106df6404` |
| `WCFinderDataItem` | `-adFlag` | `Q16@0:8` | `0x1078a4b94` |
| `WCFinderDataItem` | `-adsParams` | `@16@0:8` | `0x1078a4cb4` |
| `WCFinderDataItem` | `-isAdsLive` | `B16@0:8` | `0x1078a4d3c` |
| `WCFinderDataItem` | `+adFlag` | `r^v16@0:8` | `0x107894b3c` |
| `WCFinderDataItem` | `+finderDataItemFromObject:` | `@24@0:8@16` | `0x1078980fc` |
| `WCFinderFeedContentVM` | `-initWithDataItem:scene:isFinderIdentity:` | `@32@0:8@16i24B28` | `0x107a85534` |
| `WCFinderFeedContentVM` | `-initWithDataItem:scene:sessionExtraKey:` | `@36@0:8@16i24@28` | `0x107a85800` |
| `WCFinderFeedContentVM` | `-initWithDataItem:scene:` | `@28@0:8@16i24` | `0x107a85c04` |
| `WAAppTask` | `-isSplashADFinished` | `B16@0:8` | `0x11504fbc0` |
| `WAAppTaskSplashADConfig` | `-splashADHasContent` | `B16@0:8` | `0x11532f884` |
| `WAAppTaskSplashADConfig` | `-canShowSplashADWindow` | `B16@0:8` | `0x11532f8a4` |
| `WAAppTaskSplashADConfig` | `-canHotStartShowSplashAD` | `B16@0:8` | `0x11532f8c4` |

## 关键字段

| 类 | 字段 | 类型 | 字节偏移 |
|---|---|---|---:|
| `WCFinderDataItem` | `_isAdsLive` | `B` | 24 |
| `WCFinderDataItem` | `_adFlag` | `Q` | 696 |
| `WCFinderDataItem` | `_adsParams` | `@"MMLiveAdsParams"` | 800 |
| `BrandTLExptConfig` | `_showDynamicCard` | `B` | 8 |
| `BrandTLExptConfig` | `_showDynamicCardToast` | `B` | 9 |
| `BrandTLExptConfig` | `_exptShowOption` | `I` | 20 |
| `JSEvent` | `m_params` | `@"NSMutableDictionary"` | 8 |
| `JSEvent` | `m_funcName` | `@"NSString"` | 32 |
| `WCAdvertiseDataHelper` | `m_advertiseList` | `@"NSMutableArray"` | 8 |
| `WCAdvertiseDataHelper` | `m_advertiseMsgXmlList` | `@"NSMutableArray"` | 16 |
| `WCAdvertiseDataHelper` | `m_bLoaded` | `B` | 32 |

## 证据边界与接入建议

- 此审计确认类、显式方法、声明编码、字段和有限 init 传参；不证明某方法在用户操作中必然执行，也不证明开启广告过滤的效果。
- 不把参考插件的广告标记数值解释当作微信官方语义证明。`adFlag/isAdsLive/adsParams` 的存在和类型已确认；具体过滤条件仍是待设备验证的适配策略。
- `LocalJSLogicBase sendEvent:handler:result:` 的 ABI 已确认；特定 JSON 数据布局和前三项是否广告未由本次元数据审计证明。
- 方法接入应在运行时核对类与方法存在及参数/返回类型；缺失时跳过，关闭设置时调用 original。对于 dynamic property 需等实际 method 可用，不能用 getter名存在于字符串池代替。
- 本次未读取聊天数据库、账户资料或启动共享服务；临时目录只保存静态提取物，不作为项目运行环境。
- `HeadersFile` 仅辅助比对命名和类型，以上表的来源均是指定 IPA 的文件字节；版本变更优先服从 IPA。

## 文件

- `artifact-identity.json`：IPA 与提取物身份。
- `plist-evidence.json` / `rea-evidence-bundle.json`：版本核对 REA 记录。
- `objc-metadata.json`：81 类完整聚焦元数据及参考注册匹配。
- `hook-compatibility.csv`：198 项注册的可检索对应表。
- `finder-init-assembly.txt`：有限范围原始 disassembly 与 selector ref 解码。
- `inspect_objc_metadata.py`：无需执行目标的可复现解析器。
- `load-commands.txt`：加密标志、架构、依赖等原始输出。
