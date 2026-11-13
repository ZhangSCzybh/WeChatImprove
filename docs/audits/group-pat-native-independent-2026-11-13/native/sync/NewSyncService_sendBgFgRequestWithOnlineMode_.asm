-[NewSyncService sendBgFgRequestWithOnlineMode:] 0x105461764 v20@0:8i16
0x105461764: sub      sp, sp, #0x80
0x105461768: stp      x28, x27, [sp, #0x20]
0x10546176c: stp      x26, x25, [sp, #0x30]
0x105461770: stp      x24, x23, [sp, #0x40]
0x105461774: stp      x22, x21, [sp, #0x50]
0x105461778: stp      x20, x19, [sp, #0x60]
0x10546177c: stp      x29, x30, [sp, #0x70]
0x105461780: add      x29, sp, #0x70
0x105461784: mov      x21, x2
0x105461788: mov      x19, x0
0x10546178c: adrp     x8, #0x11f753000
0x105461790: mov      w9, #1
0x105461794: strb     w9, [x8, #0x478]
0x105461798: adrp     x8, #0x11ed12000
0x10546179c: ldr      x0, [x8, #0x840] ; classref CAppUtil | Class CAppUtil
0x1054617a0: adrp     x8, #0x11e9ce000 ; @selector(onAddMsg:roomID:)
0x1054617a4: ldr      x1, [x8, #0x200] ; @selector(isLogin) | 'isLogin'
0x1054617a8: bl       #0x107c27c64 ; _objc_msgSend | selector=isLogin
0x1054617ac: cbz      w0, #0x1054619fc
0x1054617b0: adrp     x27, #0x11ed12000
0x1054617b4: ldr      x0, [x27, #0x780] ; classref MMContext | Class MMContext
0x1054617b8: adrp     x8, #0x11e9c9000
0x1054617bc: ldr      x23, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x1054617c0: mov      x1, x23 ; 'currentContext'
0x1054617c4: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x1054617c8: mov      x29, x29
0x1054617cc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054617d0: mov      x20, x0
0x1054617d4: adrp     x8, #0x11ed12000
0x1054617d8: ldr      x0, [x8, #0x890] ; classref ExptService | Class ExptService
0x1054617dc: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x1054617e0: ldr      x24, [x8, #0x508] ; @selector(class) | 'class'
0x1054617e4: mov      x1, x24 ; 'class'
0x1054617e8: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x1054617ec: mov      x2, x0
0x1054617f0: adrp     x8, #0x11e9c9000
0x1054617f4: ldr      x25, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x1054617f8: mov      x0, x20
0x1054617fc: mov      x1, x25 ; 'getService:'
0x105461800: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x105461804: mov      x29, x29
0x105461808: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x10546180c: mov      x26, x0
0x105461810: adrp     x8, #0x11e9c9000
0x105461814: ldr      x1, [x8, #0xe48] ; @selector(getExpt:withBoolDef:) | 'getExpt:withBoolDef:'
0x105461818: adrp     x2, #0x11d2f6000
0x10546181c: add      x2, x2, #0xc38 ; @'clicfg_bgfg_task_timeout_switch'
0x105461820: mov      w3, #0
0x105461824: bl       #0x107c27c64 ; _objc_msgSend | selector=getExpt:withBoolDef:
0x105461828: mov      x22, x0
0x10546182c: mov      x0, x26
0x105461830: bl       #0x107c27c70 ; _objc_release
0x105461834: mov      x0, x20
0x105461838: bl       #0x107c27c70 ; _objc_release
0x10546183c: adrp     x8, #0x11ed12000
0x105461840: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105461844: adrp     x8, #0x11e9c9000
0x105461848: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x10546184c: stp      x21, x22, [sp, #8]
0x105461850: adrp     x8, #0x11d2f6000
0x105461854: add      x8, x8, #0xc58 ; @'BgFgRequest onlineMode=%d, waitResponse=%d'
0x105461858: str      x8, [sp] ; @'BgFgRequest onlineMode=%d, waitResponse=%d'
0x10546185c: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105461860: add      x3, x3, #0xfaf ; 'Sync'
0x105461864: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105461868: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x10546186c: adrp     x7, #0x11a21f000 ; 'llu,%llu'
0x105461870: add      x7, x7, #0xb9a ; '-[NewSyncService sendBgFgRequestWithOnlineMode:]'
0x105461874: mov      w2, #2
0x105461878: mov      w4, #0
0x10546187c: mov      w6, #0xb8
0x105461880: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105461884: adrp     x8, #0x11ed34000 ; classref WCFinderObjectMonotonicData
0x105461888: ldr      x0, [x8, #0x2d0] ; classref BgFgRequest | Class BgFgRequest
0x10546188c: bl       #0x107c27c0c ; _objc_alloc_init
0x105461890: mov      x20, x0
0x105461894: adrp     x8, #0x11ed12000
0x105461898: ldr      x0, [x8, #0x8a0] ; classref CUtility | Class CUtility
0x10546189c: adrp     x8, #0x11eca5000 ; @selector(voiceIdSet)
0x1054618a0: ldr      x1, [x8, #0x510] ; @selector(GetVersion) | 'GetVersion'
0x1054618a4: bl       #0x107c27c64 ; _objc_msgSend | selector=GetVersion
0x1054618a8: mov      x2, x0
0x1054618ac: adrp     x8, #0x11ecab000 ; @selector(setBSearchQueueNames:)
0x1054618b0: ldr      x1, [x8, #0x370] ; @selector(setClientVersion:) | 'setClientVersion:'
0x1054618b4: mov      x0, x20
0x1054618b8: bl       #0x107c27c64 ; _objc_msgSend | selector=setClientVersion:
0x1054618bc: adrp     x8, #0x11ed1a000 ; _OBJC_CLASS_$_CXCallObserver
0x1054618c0: ldr      x0, [x8, #0x3e8] ; classref DeviceUtility | Class DeviceUtility
0x1054618c4: adrp     x8, #0x11eb11000 ; @selector(hasMigrateRedTips)
0x1054618c8: ldr      x1, [x8, #0x1f8] ; @selector(HeadDeviceType) | 'HeadDeviceType'
0x1054618cc: bl       #0x107c27c64 ; _objc_msgSend | selector=HeadDeviceType
0x1054618d0: mov      x2, x0
0x1054618d4: adrp     x8, #0x11e9d3000 ; @selector(deleteSearchableItemsWithDomainIdentifiers:completionHandler:)
0x1054618d8: ldr      x1, [x8, #0xf8] ; @selector(setDeviceTypeId:) | 'setDeviceTypeId:'
0x1054618dc: mov      x0, x20
0x1054618e0: bl       #0x107c27c64 ; _objc_msgSend | selector=setDeviceTypeId:
0x1054618e4: ldr      x0, [x27, #0x780] ; classref MMContext | Class MMContext
0x1054618e8: mov      x1, x23 ; 'currentContext'
0x1054618ec: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x1054618f0: mov      x29, x29
0x1054618f4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054618f8: mov      x23, x0
0x1054618fc: adrp     x8, #0x11ed12000
0x105461900: ldr      x0, [x8, #0xff8] ; classref CNetworkStatus | Class CNetworkStatus
0x105461904: mov      x1, x24 ; 'class'
0x105461908: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x10546190c: mov      x2, x0
0x105461910: mov      x0, x23
0x105461914: mov      x1, x25 ; 'getService:'
0x105461918: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x10546191c: mov      x29, x29
0x105461920: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105461924: mov      x24, x0
0x105461928: adrp     x8, #0x11e9d3000 ; @selector(deleteSearchableItemsWithDomainIdentifiers:completionHandler:)
0x10546192c: ldr      x1, [x8, #0x2a8] ; @selector(getNewNetType) | 'getNewNetType'
0x105461930: bl       #0x107c27c64 ; _objc_msgSend | selector=getNewNetType
0x105461934: mov      x2, x0
0x105461938: adrp     x8, #0x11ecac000 ; @selector(setManager:)
0x10546193c: ldr      x1, [x8, #0x238] ; @selector(setNetworkMode:) | 'setNetworkMode:'
0x105461940: mov      x0, x20
0x105461944: bl       #0x107c27c64 ; _objc_msgSend | selector=setNetworkMode:
0x105461948: mov      x0, x24
0x10546194c: bl       #0x107c27c70 ; _objc_release
0x105461950: mov      x0, x23
0x105461954: bl       #0x107c27c70 ; _objc_release
0x105461958: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x10546195c: ldr      x1, [x8, #0xb90] ; @selector(setOnlineMode:) | 'setOnlineMode:'
0x105461960: mov      x0, x20
0x105461964: mov      x2, x21
0x105461968: bl       #0x107c27c64 ; _objc_msgSend | selector=setOnlineMode:
0x10546196c: adrp     x8, #0x11ecaa000 ; @selector(processIdentifier)
0x105461970: ldr      x1, [x8, #0xc58] ; @selector(serializedData) | 'serializedData'
0x105461974: mov      x0, x20
0x105461978: bl       #0x107c27c64 ; _objc_msgSend | selector=serializedData
0x10546197c: mov      x29, x29
0x105461980: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105461984: mov      x21, x0
0x105461988: tbz      w22, #0, #0x105461a1c
0x10546198c: adrp     x8, #0x11ed1e000 ; classref MainSessionInfoItem
0x105461990: ldr      x0, [x8, #0x28] ; classref NetCmdLongLinkEvent | Class NetCmdLongLinkEvent
0x105461994: bl       #0x107c27c0c ; _objc_alloc_init
0x105461998: mov      x22, x0
0x10546199c: adrp     x8, #0x11eb36000 ; @selector(subscribeConnectedEvent:eventBlock:)
0x1054619a0: ldr      x1, [x8, #0xe8] ; @selector(setTaskRetryCount:) | 'setTaskRetryCount:'
0x1054619a4: mov      w2, #0
0x1054619a8: bl       #0x107c27c64 ; _objc_msgSend | selector=setTaskRetryCount:
0x1054619ac: adrp     x8, #0x11eb36000 ; @selector(subscribeConnectedEvent:eventBlock:)
0x1054619b0: ldr      x1, [x8, #0xf0] ; @selector(setTaskTotalTimeoutMS:) | 'setTaskTotalTimeoutMS:'
0x1054619b4: mov      x0, x22
0x1054619b8: mov      w2, #0x2710
0x1054619bc: bl       #0x107c27c64 ; _objc_msgSend | selector=setTaskTotalTimeoutMS:
0x1054619c0: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x1054619c4: ldr      x1, [x8, #0xba8] ; @selector(setResponseDecoder:) | 'setResponseDecoder:'
0x1054619c8: adrp     x2, #0x11c2fd000
0x1054619cc: add      x2, x2, #0xe68 ; __NSConcreteGlobalBlock
0x1054619d0: mov      x0, x22
0x1054619d4: bl       #0x107c27c64 ; _objc_msgSend | selector=setResponseDecoder:
0x1054619d8: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x1054619dc: ldr      x1, [x8, #0xbb8] ; @selector(setResponseHandler:) | 'setResponseHandler:'
0x1054619e0: adrp     x2, #0x11c2fd000
0x1054619e4: add      x2, x2, #0xea8 ; __NSConcreteGlobalBlock
0x1054619e8: mov      x0, x22
0x1054619ec: bl       #0x107c27c64 ; _objc_msgSend | selector=setResponseHandler:
0x1054619f0: adrp     x24, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x1054619f4: add      x24, x24, #0xbc0 ; @selector(addBgFgLongLinkEvent:)
0x1054619f8: b        #0x105461a34
0x1054619fc: ldp      x29, x30, [sp, #0x70]
0x105461a00: ldp      x20, x19, [sp, #0x60]
0x105461a04: ldp      x22, x21, [sp, #0x50]
0x105461a08: ldp      x24, x23, [sp, #0x40] ; @selector(addBgFgLongLinkEvent:)
0x105461a0c: ldp      x26, x25, [sp, #0x30]
0x105461a10: ldp      x28, x27, [sp, #0x20]
0x105461a14: add      sp, sp, #0x80
0x105461a18: ret      
0x105461a1c: adrp     x8, #0x11ed1e000 ; classref MainSessionInfoItem
0x105461a20: ldr      x0, [x8, #0x20] ; classref NetCmdSendOnlyEvent | Class NetCmdSendOnlyEvent
0x105461a24: bl       #0x107c27c0c ; _objc_alloc_init
0x105461a28: mov      x22, x0
0x105461a2c: adrp     x24, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105461a30: add      x24, x24, #0xba0 ; @selector(addBgFgSendOnlyEvent:)
0x105461a34: mov      w0, #0x18
0x105461a38: bl       #0x107c276f8 ; __Znwm
0x105461a3c: mov      x23, x0
0x105461a40: mov      x1, x21
0x105461a44: mov      w2, #0x138
0x105461a48: bl       #0x1053227b0
0x105461a4c: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105461a50: ldr      x1, [x8, #0xb98] ; @selector(setM_netcmd:) | 'setM_netcmd:'
0x105461a54: mov      x0, x22
0x105461a58: mov      x2, x23
0x105461a5c: bl       #0x107c27c64 ; _objc_msgSend | selector=setM_netcmd:
0x105461a60: ldr      x2, [x24] ; @selector(addBgFgSendOnlyEvent:) | 'addBgFgSendOnlyEvent:'
0x105461a64: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x105461a68: ldr      x1, [x8, #0xdf0] ; @selector(performSelectorOnMainThread:withObject:waitUntilDone:) | 'performSelectorOnMainThread:withObject:waitUntilDone:'
0x105461a6c: mov      x0, x19
0x105461a70: mov      x3, x22
0x105461a74: mov      w4, #0
0x105461a78: bl       #0x107c27c64 ; _objc_msgSend | selector=performSelectorOnMainThread:withObject:waitUntilDone:
0x105461a7c: mov      x0, x22
0x105461a80: bl       #0x107c27c70 ; _objc_release
0x105461a84: mov      x0, x21
0x105461a88: bl       #0x107c27c70 ; _objc_release
0x105461a8c: mov      x0, x20
0x105461a90: ldp      x29, x30, [sp, #0x70]
0x105461a94: ldp      x20, x19, [sp, #0x60]
0x105461a98: ldp      x22, x21, [sp, #0x50]
0x105461a9c: ldp      x24, x23, [sp, #0x40] ; @selector(addBgFgSendOnlyEvent:)
0x105461aa0: ldp      x26, x25, [sp, #0x30]
0x105461aa4: ldp      x28, x27, [sp, #0x20]
0x105461aa8: add      sp, sp, #0x80
0x105461aac: b        #0x107c27c70 ; _objc_release
