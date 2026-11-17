# 生产广告 Hook 与微信 8.0.80.34 静态核对

共展开 95 个唯一候选（Native 83、Web 12）。类型已按 return/self/SEL/各参数核对，忽略编码中的布局数字。当前镜像下明确声明的候选类型不匹配数为 0。候选数不等于运行时安装数量或广告拦截效果。

| 分类 | 数量 | 含义 |
|---|---:|---|
| `declared` | 83 | 类/category 中有显式方法声明，类型匹配 |
| `dynamic-property-no-declared-imp` | 11 | 动态 property 有契约，当前无声明 IMP；运行时缺失则跳过 |
| `inherited` | 0 | 当前生产候选没有依赖镜像内继承方法的项目 |
| `undeclared-safe-skip` | 0 | 除下面 11 个 dynamic property 外，无普通未声明目标 |
| `external-class` | 1 | 系统/外部类，主镜像无方法证据 |

重点结论：

- Finder 三个 VM 初始化器已使用当前无 `dataScene:` 的接口，scene 为 int32；广告路由已带 `commentScene:`，完整 ABI 匹配。未在已声明候选中发现因接口更名而整段落空的情况。
- FinderObjectAdInfo/ObjectAdItem/ObjectAdContentH5 共 11 个 getter 是 protobuf dynamic property。静态表没有 IMP；如果运行时尚未生成方法，安装器会跳过。因此这些广告信息清空路径的实际覆盖仍待运行时验证；Finder 的显式工厂、VM、预加载和路由入口仍有匹配声明。
- NSURL 属主镜像外系统类；本核对没有用 macOS 同名类替代 iOS 系统证据。
- 通用 JSFunctionDef/Web bridge 的过滤要求同时开启六个广告范围；单项开启不能据此宣称通用桥过滤已启用。这是明确的范围隔离规则，未显示接口缺失。
- 所有未声明/不符场景均经过 `CSAdPurificationInstallHook` 的完整方法签名检查；这是安全跳过条件，不能作为成功安装证据。

| 模块/范围 | 目标 | 期望编码（候选） | IPA 原编码 | 分类 |
|---|---|---|---|
| Native / Articles | `-[WebviewJSEventHandler_adDataReport handleJSEvent:HandlerFacade:ExtraData:]` | `v@:@@@` | `v40@0:8@16@24@32` | `declared` |
| Native / Articles | `-[WebviewJSEventHandler_getAdIdInfo handleJSEvent:HandlerFacade:ExtraData:]` | `v@:@@@` | `v40@0:8@16@24@32` | `declared` |
| Native / Subscriptions | `-[BrandTLExptConfig isExptNotShowAd]` | `B@: / c@:` | `B16@0:8` | `declared` |
| Native / Subscriptions | `-[BrandTLFlutterViewController enableAd]` | `B@: / c@:` | `B16@0:8` | `declared` |
| Native / Subscriptions | `+[BrandTLCanvasCardMgr isAdRequestOpen]` | `B@: / c@:` | `B16@0:8` | `declared` |
| Native / Subscriptions | `+[BrandTLCanvasCardMgr isAdCardOpen]` | `B@: / c@:` | `B16@0:8` | `declared` |
| Native / Subscriptions | `-[BrandTLFlutterViewController getMagicBrushFlutterPlugins]` | `@@:` | `@16@0:8` | `declared` |
| Native / Subscriptions | `-[BrandTLFlutterViewController reportAdBrandCardOnClick]` | `v@:` | `v16@0:8` | `declared` |
| Native / Subscriptions | `-[BrandTLCanvasCardMgr handleBizAdNotifyNewXml:]` | `v@:@` | `v24@0:8@16` | `declared` |
| Native / Subscriptions | `-[MagicAdPushMgrService handleAdMsg:]` | `v@:@` | `v24@0:8@16` | `declared` |
| Native / Subscriptions | `-[MagicAdPushMgrService OnGetNewXmlMsg:Type:MsgWrap:]` | `v@:@@@` | `v40@0:8@16@24@32` | `declared` |
| Native / Subscriptions | `-[MBEventHandler_getAdPushMsg invoke:]` | `v@:@` | `v24@0:8@16` | `declared` |
| Native / Subscriptions | `-[MBEventHandler_getOldAdInfo invoke:]` | `v@:@` | `v24@0:8@16` | `declared` |
| Native / Subscriptions | `-[MBEventHandler_setAdCardRequestInfo invoke:]` | `v@:@` | `v24@0:8@16` | `declared` |
| Native / Subscriptions | `-[MBEventHandler_setAdRequestInfo invoke:]` | `v@:@` | `v24@0:8@16` | `declared` |
| Native / Subscriptions | `-[MBEventHandler_setFeedsAdRequestInfo invoke:]` | `v@:@` | `v24@0:8@16` | `declared` |
| Native / Subscriptions | `+[BrandAdDataParser adDataItemForContent:]` | `@@:@` | `@24@0:8@16` | `declared` |
| Native / Subscriptions | `+[BrandAdDataParser adDataItemForMsgWrap:]` | `@@:@` | `@24@0:8@16` | `declared` |
| Native / Subscriptions | `+[BrandAdDataParser adInfoDicForContent:]` | `@@:@` | `@24@0:8@16` | `declared` |
| Native / Subscriptions | `+[BrandAdDataParser adInfoDicForMsgWrap:]` | `@@:@` | `@24@0:8@16` | `declared` |
| Native / Subscriptions | `-[BrandAdDataItem dicAdInfo]` | `@@:` | `@16@0:8` | `declared` |
| Native / Subscriptions | `-[BrandAdDataItem content]` | `@@:` | `@16@0:8` | `declared` |
| Native / Recommendations | `-[BrandTLExptConfig isExptNotShowRecCard]` | `B@: / c@:` | `B16@0:8` | `declared` |
| Native / Recommendations | `-[BrandTLExptConfig isExptNotShowFinderLiveBar]` | `B@: / c@:` | `B16@0:8` | `declared` |
| Native / Recommendations | `-[BrandTLExptConfig isExptNotShowRecoFlow]` | `B@: / c@:` | `B16@0:8` | `declared` |
| Native / Recommendations | `-[BrandTLExptConfig showDynamicCard]` | `B@: / c@:` | `B16@0:8` | `declared` |
| Native / Recommendations | `-[BrandTLExptConfig showDynamicCardToast]` | `B@: / c@:` | `B16@0:8` | `declared` |
| Native / Moments | `-[WCAdvertiseDataHelper IsAdvertiseDataValid:dataItem:]` | `B@:@@ / c@:@@` | `B32@0:8@16@24` | `declared` |
| Native / Moments | `-[WCAdvertiseDataHelper isAdPreviewExpired:]` | `B@:@ / c@:@` | `B24@0:8@16` | `declared` |
| Native / Moments | `-[WCAdvertiseInfo adExpired]` | `B@: / c@:` | `B16@0:8` | `declared` |
| Native / Moments | `-[WCAdDynamicCanvasServerData isValid]` | `B@: / c@:` | `B16@0:8` | `declared` |
| Native / Moments | `-[WCAdvertisePushService handlePushMsg:]` | `v@:@` | `v24@0:8@16` | `declared` |
| Native / Moments | `-[WCAdvertisePushService OnGetNewXmlMsg:Type:MsgWrap:]` | `v@:@@@` | `v40@0:8@16@24@32` | `declared` |
| Native / Moments | `-[WCCanvasDynamicDataLoader handleAdCanvasInfoResponse:]` | `v@:@` | `v24@0:8@16` | `declared` |
| Native / Moments | `-[WCAdvertiseStatMgr getAdvertiseInfoForItem:]` | `@@:@` | `@24@0:8@16` | `declared` |
| Native / Moments | `-[WCAdvertiseInfo h5PageWrap]` | `@@:` | `@16@0:8` | `declared` |
| Native / Moments | `-[WCAdvertiseInfo poiH5PageWrap]` | `@@:` | `@16@0:8` | `declared` |
| Native / Moments | `-[WCAdDynamicCanvasPageInfo fetchRealUxInfo]` | `@@:` | `@16@0:8` | `declared` |
| Native / Moments | `-[WCAdDynamicCanvasPageInfo fetchPageInfoExtraDic]` | `@@:` | `@16@0:8` | `declared` |
| Native / Moments | `-[WCAdDynamicCanvasPageInfo fetchPageInfoDic]` | `@@:` | `@16@0:8` | `declared` |
| Native / Moments | `-[WCAdDynamicCanvasPageInfo fetchLaunchString]` | `@@:` | `@16@0:8` | `declared` |
| Native / Moments | `-[WCAdvertiseStatMgr logHeadImageH5:]` | `v@:@` | `v24@0:8@16` | `declared` |
| Native / Moments | `-[WCAdvertiseStatMgr logADBrandProfile:]` | `v@:@` | `v24@0:8@16` | `declared` |
| Native / Moments | `-[WCAdvertiseStatMgr logADFloatView:]` | `v@:@` | `v24@0:8@16` | `declared` |
| Native / Moments | `-[WCAdvertiseStatMgr logADPoiH5:]` | `v@:@` | `v24@0:8@16` | `declared` |
| Native / Moments | `-[WCAdvertiseStatMgr logADH5:]` | `v@:@` | `v24@0:8@16` | `declared` |
| Native / Moments | `-[WCAdvertiseStatMgr logADCommentLog:]` | `v@:@` | `v24@0:8@16` | `declared` |
| Native / Moments | `-[WCAdvertiseStatMgr logADBodyLog:]` | `v@:@` | `v24@0:8@16` | `declared` |
| Native / Moments | `-[WCAdvertiseStatMgr logADDetail:dataItem:]` | `v@:@@` | `v32@0:8@16@24` | `declared` |
| Native / Moments | `-[WCAdvertiseStatMgr logSphereViewInDetailWithWrapInfo:dataItem:]` | `v@:@@` | `v32@0:8@16@24` | `declared` |
| Native / Moments | `-[WCAdvertiseStatMgr logSphereViewInTimeLineWithWrapInfo:dataItem:]` | `v@:@@` | `v32@0:8@16@24` | `declared` |
| Native / Moments | `-[WCAdvertiseStatMgr reportAllFeedsADLog]` | `v@:` | `v16@0:8` | `declared` |
| Native / Moments | `-[WCAdvertiseStatMgr logADH5:withUserInfo:reportType:]` | `v@:@@Q` | `v40@0:8@16@24Q32` | `declared` |
| Native / Moments | `-[WCAdvertiseStatMgr logSphereViewWithSphereReportInfo:dataItem:scene:]` | `v@:@@I` | `v36@0:8@16@24I32` | `declared` |
| Native / Moments | `+[WCAdXmlParser SetAdvertiseInfo:ByAdInfo:]` | `B@:@@ / c@:@@` | `B32@0:8@16@24` | `declared` |
| Native / Moments | `+[WCAdXmlParser SetAdvertiseXml:ByAdXml:]` | `B@:@@ / c@:@@` | `B32@0:8@16@24` | `declared` |
| Native / Moments | `+[WCAdXmlParser ExtractRecommendAdInfo:ByAdMsgXml:]` | `B@:@@ / c@:@@` | `B32@0:8@16@24` | `declared` |
| Native / Finder | `+[WCFinderDataItem finderDataItemFromObject:]` | `@@:@` | `@24@0:8@16` | `declared` |
| Native / Finder | `-[WCFinderFeedContentVM initWithDataItem:scene:]` | `@@:@i` | `@28@0:8@16i24` | `declared` |
| Native / Finder | `-[WCFinderFeedContentVM initWithDataItem:scene:sessionExtraKey:]` | `@@:@i@` | `@36@0:8@16i24@28` | `declared` |
| Native / Finder | `-[WCFinderFeedContentVM initWithDataItem:scene:isFinderIdentity:]` | `@@:@iB / @@:@ic` | `@32@0:8@16i24B28` | `declared` |
| Native / Finder | `+[WCFinderRouterHelper pushFinderAdPageViewControllerWithEncrytedObjectidTid:nonceId:currentNavController:enterScene:customParam:reportModel:cardType:commentScene:requestScene:functionalParams:]` | `v@:@@@Q@@iiQ@` | `v88@0:8@16@24@32Q40@48@56i64i68Q72@80` | `declared` |
| Native / Finder | `+[_TtC6WeChat31MBJsEventOnFinderMediaAdPreload startPreloadAdMedia]` | `@@:` | `@16@0:8` | `declared` |
| Native / Finder | `-[WCAdFinderInfo isValid]` | `B@: / c@:` | `B16@0:8` | `declared` |
| Native / Finder | `-[FinderObjectAdInfo adDesc]` | `@@:` | `T@"ObjectAdDesc",&,D,N` | `dynamic-property-no-declared-imp` |
| Native / Finder | `-[FinderObjectAdInfo adH5]` | `@@:` | `T@"ObjectAdContentH5",&,D,N` | `dynamic-property-no-declared-imp` |
| Native / Finder | `-[FinderObjectAdInfo adLeadLink]` | `@@:` | `T@"ObjectAdContentLeadLink",&,D,N` | `dynamic-property-no-declared-imp` |
| Native / Finder | `-[FinderObjectAdInfo adMiniApp]` | `@@:` | `T@"ObjectAdContentMiniApp",&,D,N` | `dynamic-property-no-declared-imp` |
| Native / Finder | `-[FinderObjectAdInfo adItems]` | `@@:` | `T@"NSMutableArray",&,D,N` | `dynamic-property-no-declared-imp` |
| Native / Finder | `-[ObjectAdItem adDesc]` | `@@:` | `T@"ObjectAdDesc",&,D,N` | `dynamic-property-no-declared-imp` |
| Native / Finder | `-[ObjectAdItem adH5]` | `@@:` | `T@"ObjectAdContentH5",&,D,N` | `dynamic-property-no-declared-imp` |
| Native / Finder | `-[ObjectAdItem adLeadLink]` | `@@:` | `T@"ObjectAdContentLeadLink",&,D,N` | `dynamic-property-no-declared-imp` |
| Native / Finder | `-[ObjectAdItem adMiniApp]` | `@@:` | `T@"ObjectAdContentMiniApp",&,D,N` | `dynamic-property-no-declared-imp` |
| Native / Finder | `-[ObjectAdItem uxinfo]` | `@@:` | `T@"NSString",&,D,N` | `dynamic-property-no-declared-imp` |
| Native / Finder | `-[ObjectAdContentH5 url]` | `@@:` | `T@"NSString",&,D,N` | `dynamic-property-no-declared-imp` |
| Native / MiniPrograms | `-[WAAppTask isSplashADFinished]` | `B@: / c@:` | `B16@0:8` | `declared` |
| Native / MiniPrograms | `-[WAAppTaskSplashADConfig canShowSplashADWindow]` | `B@: / c@:` | `B16@0:8` | `declared` |
| Native / MiniPrograms | `-[WAAppTaskSplashADConfig canHotStartShowSplashAD]` | `B@: / c@:` | `B16@0:8` | `declared` |
| Native / MiniPrograms | `-[WAAppTaskSplashADConfig splashADHasContent]` | `B@: / c@:` | `B16@0:8` | `declared` |
| Native / MiniPrograms | `-[WAJSEventHandler_showSplashAd handleJSEvent:]` | `v@:@` | `v24@0:8@16` | `declared` |
| Native / MiniPrograms | `-[WAJSEventHandler_showSplashAdMenu handleJSEvent:]` | `v@:@` | `v24@0:8@16` | `declared` |
| Native / MiniPrograms | `-[WAJSEventHandler_adOperateWXData handleJSEvent:]` | `v@:@` | `v24@0:8@16` | `declared` |
| Native / Search | `-[WCAdSearchH5Info isValid]` | `B@: / c@:` | `B16@0:8` | `declared` |
| Web / Articles + Moments + MiniPrograms | `+[NSURL URLWithString:]` | `@@:@` | `—` | `external-class` |
| Web / ALL_SIX_AD_SCOPES | `+[JSFunctionDef FuncDefWithFunc:Selector:FuncType:PermissionBitSet:RunInWebViewType:]` | `@@:@:qIQ` | `@52@0:8@16:24q32I40Q44` | `declared` |
| Web / ALL_SIX_AD_SCOPES | `+[JSFunctionDef FuncDefWithFunc:Selector:FuncType:PermissionBitSet2:RunInWebViewType:]` | `@@:@:qIQ` | `@52@0:8@16:24q32I40Q44` | `declared` |
| Web / ALL_SIX_AD_SCOPES | `+[JSFunctionDef FuncDefWithFunc:Selector:FuncType:PermissionBitSet3:RunInWebViewType:]` | `@@:@:qIQ` | `@52@0:8@16:24q32I40Q44` | `declared` |
| Web / ALL_SIX_AD_SCOPES | `+[JSFunctionDef FuncDefWithFunc:Selector:FuncType:PermissionByteIndex:RunInWebViewType:]` | `@@:@:qqQ` | `@56@0:8@16:24q32q40Q48` | `declared` |
| Web / MiniPrograms | `-[WAJSInvoker invokeInJsContext:]` | `@@:@` | `@24@0:8@16` | `declared` |
| Web / Search | `-[WXSearchJSLogicImpl functionCall:withParams:withCallbackID:]` | `v@:@@@` | `v40@0:8@16@24@32` | `declared` |
| Web / Search | `-[LocalJSLogicBase sendEvent:handler:result:]` | `v@:@@@` | `v40@0:8@16@24@32` | `declared` |
| Web / Articles | `-[JSEvent initWithDelegate:parameters:]` | `@@:@@` | `@32@0:8@16@24` | `declared` |
| Web / MiniPrograms_OR_ALL_SIX_AD_SCOPES | `-[WCJSInvoker initWithObj:Func:Args:]` | `@@:@@@` | `@40@0:8@16@24@32` | `declared` |
| Web / MiniPrograms_OR_ALL_SIX_AD_SCOPES | `-[WCJSInvoker initWithJavascript:]` | `@@:@` | `@24@0:8@16` | `declared` |
| Web / ALL_SIX_AD_SCOPES | `-[LocalJSEventHandler_WebAPIBridge initWithEvent:context:]` | `@@:@@` | `@32@0:8@16@24` | `declared` |

证据来源：`objc-metadata.json`、`hook-compatibility.csv` 及当前生产 Native/Web 源文件。JSON 保存源文件 SHA-256、方法元数据地址、IMP 和逐项类型比较。报告仅描述静态候选与声明契合，未启动微信或重开 REA。
