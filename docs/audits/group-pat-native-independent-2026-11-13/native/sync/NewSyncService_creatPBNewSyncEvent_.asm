-[NewSyncService creatPBNewSyncEvent:] 0x105462700 B20@0:8I16
0x105462700: sub      sp, sp, #0x90
0x105462704: stp      x28, x27, [sp, #0x30]
0x105462708: stp      x26, x25, [sp, #0x40]
0x10546270c: stp      x24, x23, [sp, #0x50]
0x105462710: stp      x22, x21, [sp, #0x60]
0x105462714: stp      x20, x19, [sp, #0x70]
0x105462718: stp      x29, x30, [sp, #0x80]
0x10546271c: add      x29, sp, #0x80
0x105462720: mov      x20, x2
0x105462724: str      x0, [sp, #0x28]
0x105462728: adrp     x8, #0x11f753000
0x10546272c: mov      w9, #1
0x105462730: strb     w9, [x8, #0x47b]
0x105462734: adrp     x8, #0x11ed34000 ; classref WCFinderObjectMonotonicData
0x105462738: ldr      x0, [x8, #0x2e8] ; classref NewSyncRequest | Class NewSyncRequest
0x10546273c: bl       #0x107c27c0c ; _objc_alloc_init
0x105462740: mov      x19, x0
0x105462744: adrp     x8, #0x11ecac000 ; @selector(setManager:)
0x105462748: ldr      x1, [x8, #0x7f0] ; @selector(setSelector:) | 'setSelector:'
0x10546274c: mov      w2, #7
0x105462750: movk     w2, #4, lsl #16
0x105462754: bl       #0x107c27c64 ; _objc_msgSend | selector=setSelector:
0x105462758: adrp     x8, #0x11ed22000 ; classref ChatRoomTopMsgInfo
0x10546275c: ldr      x0, [x8, #0x128] ; classref CmdList | Class CmdList
0x105462760: bl       #0x107c27c0c ; _objc_alloc_init
0x105462764: mov      x22, x0
0x105462768: adrp     x8, #0x11ea62000 ; @selector(doReqeustRemoteDetectTask:)
0x10546276c: ldr      x1, [x8, #0x628] ; @selector(setOplog:) | 'setOplog:'
0x105462770: mov      x0, x19
0x105462774: mov      x2, x22
0x105462778: bl       #0x107c27c64 ; _objc_msgSend | selector=setOplog:
0x10546277c: mov      x0, x22
0x105462780: bl       #0x107c27c70 ; _objc_release
0x105462784: adrp     x8, #0x11ed12000
0x105462788: ldr      x0, [x8, #0x658] ; _OBJC_CLASS_$_NSMutableArray
0x10546278c: adrp     x8, #0x11eca5000 ; @selector(voiceIdSet)
0x105462790: ldr      x1, [x8, #0xd88] ; @selector(array) | 'array'
0x105462794: bl       #0x107c27c64 ; _objc_msgSend | selector=array
0x105462798: mov      x29, x29
0x10546279c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054627a0: mov      x22, x0
0x1054627a4: adrp     x8, #0x11ea1d000 ; @selector(handleSearchOpenIMContactResp:)
0x1054627a8: ldr      x23, [x8, #0xc28] ; @selector(oplog) | 'oplog'
0x1054627ac: mov      x0, x19
0x1054627b0: mov      x1, x23 ; 'oplog'
0x1054627b4: bl       #0x107c27c64 ; _objc_msgSend | selector=oplog
0x1054627b8: mov      x29, x29
0x1054627bc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054627c0: mov      x24, x0
0x1054627c4: adrp     x8, #0x11e9e1000 ; @selector(ok)
0x1054627c8: ldr      x1, [x8, #0x5a0] ; @selector(setList:) | 'setList:'
0x1054627cc: mov      x2, x22
0x1054627d0: bl       #0x107c27c64 ; _objc_msgSend | selector=setList:
0x1054627d4: mov      x0, x24
0x1054627d8: bl       #0x107c27c70 ; _objc_release
0x1054627dc: mov      x0, x22
0x1054627e0: bl       #0x107c27c70 ; _objc_release
0x1054627e4: mov      x0, x19
0x1054627e8: mov      x1, x23 ; 'oplog'
0x1054627ec: bl       #0x107c27c64 ; _objc_msgSend | selector=oplog
0x1054627f0: mov      x29, x29
0x1054627f4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054627f8: mov      x22, x0
0x1054627fc: adrp     x8, #0x11e9ce000 ; @selector(onAddMsg:roomID:)
0x105462800: ldr      x1, [x8, #0xeb0] ; @selector(setCount:) | 'setCount:'
0x105462804: mov      w2, #0
0x105462808: bl       #0x107c27c64 ; _objc_msgSend | selector=setCount:
0x10546280c: mov      x0, x22
0x105462810: bl       #0x107c27c70 ; _objc_release
0x105462814: adrp     x8, #0x11ecac000 ; @selector(setManager:)
0x105462818: ldr      x1, [x8, #0x788] ; @selector(setScene:) | 'setScene:'
0x10546281c: mov      x0, x19
0x105462820: str      x20, [sp, #0x20]
0x105462824: mov      x2, x20
0x105462828: bl       #0x107c27c64 ; _objc_msgSend | selector=setScene:
0x10546282c: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x105462830: ldr      x26, [x8, #0x5e0] ; classref SKBuiltinBuffer_t | Class SKBuiltinBuffer_t
0x105462834: adrp     x23, #0x11ed12000
0x105462838: ldr      x0, [x23, #0x780] ; classref MMContext | Class MMContext
0x10546283c: adrp     x8, #0x11e9c9000
0x105462840: ldr      x22, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105462844: mov      x1, x22 ; 'currentContext'
0x105462848: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x10546284c: mov      x29, x29
0x105462850: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105462854: mov      x27, x0
0x105462858: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x10546285c: ldr      x0, [x8, #0xe98] ; classref AccountStorageMgr | Class AccountStorageMgr
0x105462860: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105462864: ldr      x24, [x8, #0x508] ; @selector(class) | 'class'
0x105462868: mov      x1, x24 ; 'class'
0x10546286c: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x105462870: mov      x2, x0
0x105462874: adrp     x8, #0x11e9c9000
0x105462878: ldr      x20, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x10546287c: mov      x0, x27
0x105462880: mov      x1, x20 ; 'getService:'
0x105462884: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x105462888: mov      x29, x29
0x10546288c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105462890: mov      x28, x0
0x105462894: adrp     x8, #0x11ea1a000 ; @selector(isMediaGroupFirstDisplayMsg:)
0x105462898: ldr      x1, [x8, #0x628] ; @selector(GetSyncBuffer) | 'GetSyncBuffer'
0x10546289c: bl       #0x107c27c64 ; _objc_msgSend | selector=GetSyncBuffer
0x1054628a0: mov      x29, x29
0x1054628a4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054628a8: mov      x21, x0
0x1054628ac: adrp     x8, #0x11e9e2000 ; @selector(setIsPickerForceFullScreen:)
0x1054628b0: ldr      x25, [x8, #0x1f8] ; @selector(skBufferWithData:) | 'skBufferWithData:'
0x1054628b4: mov      x0, x26 ; Class SKBuiltinBuffer_t
0x1054628b8: mov      x1, x25 ; 'skBufferWithData:'
0x1054628bc: mov      x2, x21
0x1054628c0: bl       #0x107c27c64 ; _objc_msgSend | selector=skBufferWithData:
0x1054628c4: mov      x29, x29
0x1054628c8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054628cc: mov      x26, x0
0x1054628d0: adrp     x8, #0x11ea4d000 ; @selector(ConvertImg2MsgWrap:)
0x1054628d4: ldr      x1, [x8, #0x4e0] ; @selector(setKeyBuf:) | 'setKeyBuf:'
0x1054628d8: mov      x0, x19
0x1054628dc: mov      x2, x26
0x1054628e0: bl       #0x107c27c64 ; _objc_msgSend | selector=setKeyBuf:
0x1054628e4: mov      x0, x26
0x1054628e8: bl       #0x107c27c70 ; _objc_release
0x1054628ec: mov      x0, x21
0x1054628f0: bl       #0x107c27c70 ; _objc_release
0x1054628f4: mov      x0, x28
0x1054628f8: bl       #0x107c27c70 ; _objc_release
0x1054628fc: mov      x0, x27
0x105462900: bl       #0x107c27c70 ; _objc_release
0x105462904: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x105462908: ldr      x21, [x8, #0x5e0] ; classref SKBuiltinBuffer_t | Class SKBuiltinBuffer_t
0x10546290c: ldr      x0, [x23, #0x780] ; classref MMContext | Class MMContext
0x105462910: mov      x1, x22 ; 'currentContext'
0x105462914: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105462918: mov      x29, x29
0x10546291c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105462920: mov      x26, x0
0x105462924: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x105462928: ldr      x0, [x8, #0xe98] ; classref AccountStorageMgr | Class AccountStorageMgr
0x10546292c: mov      x1, x24 ; 'class'
0x105462930: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x105462934: mov      x2, x0
0x105462938: mov      x0, x26
0x10546293c: mov      x1, x20 ; 'getService:'
0x105462940: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x105462944: mov      x29, x29
0x105462948: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x10546294c: mov      x27, x0
0x105462950: adrp     x8, #0x11eb35000 ; @selector(replaceMicroMerchantDataItem:referenceGroup:)
0x105462954: ldr      x1, [x8, #0x9c8] ; @selector(loadSvrSyncBufferKey) | 'loadSvrSyncBufferKey'
0x105462958: bl       #0x107c27c64 ; _objc_msgSend | selector=loadSvrSyncBufferKey
0x10546295c: mov      x29, x29
0x105462960: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105462964: mov      x28, x0
0x105462968: mov      x0, x21 ; Class SKBuiltinBuffer_t
0x10546296c: mov      x1, x25 ; 'skBufferWithData:'
0x105462970: mov      x2, x28
0x105462974: bl       #0x107c27c64 ; _objc_msgSend | selector=skBufferWithData:
0x105462978: mov      x29, x29
0x10546297c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105462980: mov      x21, x0
0x105462984: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105462988: ldr      x1, [x8, #0xbf8] ; @selector(setSyncUniqKeyBuf:) | 'setSyncUniqKeyBuf:'
0x10546298c: mov      x0, x19
0x105462990: mov      x2, x21
0x105462994: bl       #0x107c27c64 ; _objc_msgSend | selector=setSyncUniqKeyBuf:
0x105462998: mov      x0, x21
0x10546299c: bl       #0x107c27c70 ; _objc_release
0x1054629a0: mov      x0, x28
0x1054629a4: bl       #0x107c27c70 ; _objc_release
0x1054629a8: mov      x0, x27
0x1054629ac: bl       #0x107c27c70 ; _objc_release
0x1054629b0: mov      x0, x26
0x1054629b4: bl       #0x107c27c70 ; _objc_release
0x1054629b8: adrp     x8, #0x11ed12000
0x1054629bc: ldr      x0, [x8, #0x840] ; classref CAppUtil | Class CAppUtil
0x1054629c0: adrp     x8, #0x11eca7000 ; @selector(didReceiveAuthenticationChallengeForDelegate:webView:challenge:completion:)
0x1054629c4: ldr      x1, [x8, #0x8a0] ; @selector(getDeviceType) | 'getDeviceType'
0x1054629c8: bl       #0x107c27c64 ; _objc_msgSend | selector=getDeviceType
0x1054629cc: mov      x29, x29
0x1054629d0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054629d4: mov      x21, x0
0x1054629d8: adrp     x8, #0x11e9d3000 ; @selector(deleteSearchableItemsWithDomainIdentifiers:completionHandler:)
0x1054629dc: ldr      x1, [x8, #0x148] ; @selector(setDeviceType:) | 'setDeviceType:'
0x1054629e0: mov      x0, x19
0x1054629e4: mov      x2, x21
0x1054629e8: bl       #0x107c27c64 ; _objc_msgSend | selector=setDeviceType:
0x1054629ec: mov      x0, x21
0x1054629f0: bl       #0x107c27c70 ; _objc_release
0x1054629f4: ldr      x0, [x23, #0x780] ; classref MMContext | Class MMContext
0x1054629f8: mov      x1, x22 ; 'currentContext'
0x1054629fc: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105462a00: mov      x29, x29
0x105462a04: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105462a08: mov      x21, x0
0x105462a0c: adrp     x8, #0x11ed12000
0x105462a10: ldr      x0, [x8, #0xff8] ; classref CNetworkStatus | Class CNetworkStatus
0x105462a14: mov      x1, x24 ; 'class'
0x105462a18: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x105462a1c: mov      x2, x0
0x105462a20: mov      x0, x21
0x105462a24: mov      x28, x20 ; 'getService:'
0x105462a28: mov      x1, x20 ; 'getService:'
0x105462a2c: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x105462a30: mov      x29, x29
0x105462a34: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105462a38: mov      x25, x0
0x105462a3c: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x105462a40: ldr      x1, [x8, #0x6d0] ; @selector(isOnWifi) | 'isOnWifi'
0x105462a44: bl       #0x107c27c64 ; _objc_msgSend | selector=isOnWifi
0x105462a48: mov      x26, x0
0x105462a4c: mov      x0, x25
0x105462a50: bl       #0x107c27c70 ; _objc_release
0x105462a54: mov      x0, x21
0x105462a58: bl       #0x107c27c70 ; _objc_release
0x105462a5c: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105462a60: ldr      x1, [x8, #0xc00] ; @selector(setPrevDownloadFlag:) | 'setPrevDownloadFlag:'
0x105462a64: mov      w2, w26
0x105462a68: mov      x0, x19
0x105462a6c: bl       #0x107c27c64 ; _objc_msgSend | selector=setPrevDownloadFlag:
0x105462a70: adrp     x8, #0x11edca000
0x105462a74: ldrsw    x8, [x8, #0x914] ; ivar_offset NewSyncService.m_bFirstSyncAfterBgfgChange=0x56
0x105462a78: ldr      x9, [sp, #0x28]
0x105462a7c: mov      x27, x9
0x105462a80: ldrb     w8, [x9, x8]
0x105462a84: adrp     x20, #0x11ed12000
0x105462a88: adrp     x21, #0x11e9c9000
0x105462a8c: cmp      w8, #1
0x105462a90: b.ne     #0x105462ae4
0x105462a94: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105462a98: ldr      x1, [x8, #0xc08] ; @selector(setSyncMsgDigest:) | 'setSyncMsgDigest:'
0x105462a9c: mov      x0, x19
0x105462aa0: mov      w2, #1
0x105462aa4: bl       #0x107c27c64 ; _objc_msgSend | selector=setSyncMsgDigest:
0x105462aa8: ldr      x0, [x20, #0x618] ; classref iConsole | Class iConsole
0x105462aac: ldr      x1, [x21, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105462ab0: adrp     x8, #0x11d2f6000
0x105462ab4: add      x8, x8, #0xd38 ; @'sync bg2fg==1'
0x105462ab8: str      x8, [sp] ; @'sync bg2fg==1'
0x105462abc: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105462ac0: add      x3, x3, #0xfaf ; 'Sync'
0x105462ac4: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105462ac8: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105462acc: adrp     x7, #0x11a21f000 ; 'llu,%llu'
0x105462ad0: add      x7, x7, #0xd0a ; '-[NewSyncService creatPBNewSyncEvent:]'
0x105462ad4: mov      w2, #2
0x105462ad8: mov      w4, #0
0x105462adc: mov      w6, #0x179
0x105462ae0: b        #0x105462b44
0x105462ae4: adrp     x8, #0x11f5ee000
0x105462ae8: add      x8, x8, #0x10
0x105462aec: ldr      x8, [x8]
0x105462af0: blr      x8
0x105462af4: tbnz     w0, #0, #0x105462b48
0x105462af8: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105462afc: ldr      x1, [x8, #0xc08] ; @selector(setSyncMsgDigest:) | 'setSyncMsgDigest:'
0x105462b00: mov      x0, x19
0x105462b04: mov      w2, #1
0x105462b08: bl       #0x107c27c64 ; _objc_msgSend | selector=setSyncMsgDigest:
0x105462b0c: ldr      x0, [x20, #0x618] ; classref iConsole | Class iConsole
0x105462b10: ldr      x1, [x21, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105462b14: adrp     x8, #0x11d2f6000
0x105462b18: add      x8, x8, #0xd58 ; @'sync long link is NOT connected'
0x105462b1c: str      x8, [sp] ; @'sync long link is NOT connected'
0x105462b20: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105462b24: add      x3, x3, #0xfaf ; 'Sync'
0x105462b28: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105462b2c: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105462b30: adrp     x7, #0x11a21f000 ; 'llu,%llu'
0x105462b34: add      x7, x7, #0xd0a ; '-[NewSyncService creatPBNewSyncEvent:]'
0x105462b38: mov      w2, #2
0x105462b3c: mov      w4, #0
0x105462b40: mov      w6, #0x17d
0x105462b44: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105462b48: adrp     x8, #0x11ed24000 ; _OBJC_CLASS_$_MCNearbyServiceAdvertiser
0x105462b4c: ldr      x0, [x8, #0x618] ; classref LoginAgreeSyncMsgLogic | Class LoginAgreeSyncMsgLogic
0x105462b50: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105462b54: ldr      x1, [x8, #0xbe0] ; @selector(getAuthSyncFlag) | 'getAuthSyncFlag'
0x105462b58: bl       #0x107c27c64 ; _objc_msgSend | selector=getAuthSyncFlag
0x105462b5c: cbz      w0, #0x105462b7c
0x105462b60: sxtw     x25, w0
0x105462b64: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105462b68: ldr      x1, [x8, #0xbe8] ; @selector(setSyncFlag:) | 'setSyncFlag:'
0x105462b6c: mov      x0, x19
0x105462b70: mov      x2, x25
0x105462b74: bl       #0x107c27c64 ; _objc_msgSend | selector=setSyncFlag:
0x105462b78: b        #0x105462b80
0x105462b7c: mov      x25, #0
0x105462b80: ldr      x0, [x20, #0x618] ; classref iConsole | Class iConsole
0x105462b84: ldr      x26, [x21, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105462b88: adrp     x8, #0x11d2f6000
0x105462b8c: add      x8, x8, #0xd78 ; @'creatPBNewSyncEvent, syncFlag: %ld'
0x105462b90: stp      x8, x25, [sp] ; @'creatPBNewSyncEvent, syncFlag: %ld'
0x105462b94: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105462b98: add      x3, x3, #0xfaf ; 'Sync'
0x105462b9c: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105462ba0: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105462ba4: adrp     x7, #0x11a21f000 ; 'llu,%llu'
0x105462ba8: add      x7, x7, #0xd0a ; '-[NewSyncService creatPBNewSyncEvent:]'
0x105462bac: mov      x1, x26 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105462bb0: mov      w2, #1
0x105462bb4: mov      w4, #0
0x105462bb8: mov      w6, #0x186
0x105462bbc: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105462bc0: adrp     x8, #0x11ed12000
0x105462bc4: ldr      x0, [x8, #0xaf0] ; classref ProtobufCGIWrap | Class ProtobufCGIWrap
0x105462bc8: bl       #0x107c27c0c ; _objc_alloc_init
0x105462bcc: mov      x25, x0
0x105462bd0: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x105462bd4: ldr      x1, [x8, #0x840] ; @selector(setM_pbRequest:) | 'setM_pbRequest:'
0x105462bd8: mov      x2, x19
0x105462bdc: bl       #0x107c27c64 ; _objc_msgSend | selector=setM_pbRequest:
0x105462be0: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x105462be4: ldr      x1, [x8, #0x848] ; @selector(setM_uiCgi:) | 'setM_uiCgi:'
0x105462be8: mov      x0, x25
0x105462bec: mov      w2, #0x8a
0x105462bf0: bl       #0x107c27c64 ; _objc_msgSend | selector=setM_uiCgi:
0x105462bf4: ldr      x0, [x23, #0x780] ; classref MMContext | Class MMContext
0x105462bf8: mov      x1, x22 ; 'currentContext'
0x105462bfc: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105462c00: mov      x29, x29
0x105462c04: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105462c08: mov      x21, x0
0x105462c0c: adrp     x8, #0x11ed12000
0x105462c10: ldr      x0, [x8, #0xaf8] ; classref EventService | Class EventService
0x105462c14: mov      x1, x24 ; 'class'
0x105462c18: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x105462c1c: mov      x2, x0
0x105462c20: mov      x0, x21
0x105462c24: mov      x1, x28 ; 'getService:'
0x105462c28: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x105462c2c: mov      x29, x29
0x105462c30: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105462c34: mov      x22, x0
0x105462c38: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x105462c3c: ldr      x1, [x8, #0x850] ; @selector(CreateProtobufEvent:Flag:) | 'CreateProtobufEvent:Flag:'
0x105462c40: mov      x2, x25
0x105462c44: mov      w3, #5
0x105462c48: bl       #0x107c27c64 ; _objc_msgSend | selector=CreateProtobufEvent:Flag:
0x105462c4c: adrp     x8, #0x11edca000
0x105462c50: ldrsw    x23, [x8, #0x8e8] ; ivar_offset NewSyncService.m_syncEventID=0x50
0x105462c54: str      w0, [x27, x23]
0x105462c58: mov      x0, x22
0x105462c5c: bl       #0x107c27c70 ; _objc_release
0x105462c60: mov      x0, x21
0x105462c64: bl       #0x107c27c70 ; _objc_release
0x105462c68: ldr      w22, [x27, x23]
0x105462c6c: ldr      x0, [x20, #0x618] ; classref iConsole | Class iConsole
0x105462c70: cbz      w22, #0x105462d24
0x105462c74: ldr      x24, [sp, #0x20]
0x105462c78: stp      x22, x24, [sp, #8]
0x105462c7c: adrp     x8, #0x11d2f6000
0x105462c80: add      x8, x8, #0xd98 ; @'m_syncEventID:%u scene:%d'
0x105462c84: str      x8, [sp] ; @'m_syncEventID:%u scene:%d'
0x105462c88: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105462c8c: add      x3, x3, #0xfaf ; 'Sync'
0x105462c90: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105462c94: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105462c98: adrp     x7, #0x11a21f000 ; 'llu,%llu'
0x105462c9c: add      x7, x7, #0xd0a ; '-[NewSyncService creatPBNewSyncEvent:]'
0x105462ca0: mov      x1, x26 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105462ca4: mov      w2, #2
0x105462ca8: mov      w4, #0
0x105462cac: mov      w6, #0x190
0x105462cb0: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105462cb4: adrp     x8, #0x11ed32000 ; classref MagicEcsNirvanaLoadingComponent
0x105462cb8: ldr      x0, [x8, #0xb30] ; classref WCAppLaunchTimeRecorder | Class WCAppLaunchTimeRecorder
0x105462cbc: adrp     x8, #0x11ecad000 ; @selector(sharedApplication)
0x105462cc0: ldr      x1, [x8, #0x18] ; @selector(sharedInstance) | 'sharedInstance'
0x105462cc4: bl       #0x107c27c64 ; _objc_msgSend | selector=sharedInstance
0x105462cc8: mov      x29, x29
0x105462ccc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105462cd0: mov      x21, x0
0x105462cd4: adrp     x8, #0x11eb25000 ; @selector(setNsSender:)
0x105462cd8: ldr      x1, [x8, #0xc58] ; @selector(record:) | 'record:'
0x105462cdc: mov      w2, #0x34
0x105462ce0: bl       #0x107c27c64 ; _objc_msgSend | selector=record:
0x105462ce4: mov      x0, x21
0x105462ce8: bl       #0x107c27c70 ; _objc_release
0x105462cec: mov      w0, #8
0x105462cf0: mov      x1, #-1
0x105462cf4: bl       #0x107c0c158
0x105462cf8: mov      w1, w24
0x105462cfc: mov      w0, #0xa
0x105462d00: bl       #0x107c0c158
0x105462d04: adrp     x8, #0x11ed12000
0x105462d08: ldr      x0, [x8, #0x840] ; classref CAppUtil | Class CAppUtil
0x105462d0c: ldr      w2, [x27, x23]
0x105462d10: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x105462d14: ldr      x1, [x8, #0x858] ; @selector(addPBEventObserverListItem:andValue:) | 'addPBEventObserverListItem:andValue:'
0x105462d18: mov      x3, x27
0x105462d1c: bl       #0x107c27c64 ; _objc_msgSend | selector=addPBEventObserverListItem:andValue:
0x105462d20: b        #0x105462d5c
0x105462d24: adrp     x8, #0x11cfce000
0x105462d28: add      x8, x8, #0xb8 ; @'CreateProtobufEvent failed!'
0x105462d2c: str      x8, [sp] ; @'CreateProtobufEvent failed!'
0x105462d30: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105462d34: add      x3, x3, #0xfaf ; 'Sync'
0x105462d38: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105462d3c: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105462d40: adrp     x7, #0x11a21f000 ; 'llu,%llu'
0x105462d44: add      x7, x7, #0xd0a ; '-[NewSyncService creatPBNewSyncEvent:]'
0x105462d48: mov      x1, x26 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105462d4c: mov      w2, #3
0x105462d50: mov      w4, #0
0x105462d54: mov      w6, #0x18d
0x105462d58: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105462d5c: cmp      w22, #0
0x105462d60: cset     w20, ne
0x105462d64: mov      x0, x25
0x105462d68: bl       #0x107c27c70 ; _objc_release
0x105462d6c: mov      x0, x19
0x105462d70: bl       #0x107c27c70 ; _objc_release
0x105462d74: mov      x0, x20
0x105462d78: ldp      x29, x30, [sp, #0x80]
0x105462d7c: ldp      x20, x19, [sp, #0x70]
0x105462d80: ldp      x22, x21, [sp, #0x60]
0x105462d84: ldp      x24, x23, [sp, #0x50]
0x105462d88: ldp      x26, x25, [sp, #0x40] ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105462d8c: ldp      x28, x27, [sp, #0x30] ; 'getService:'
0x105462d90: add      sp, sp, #0x90
0x105462d94: ret      
