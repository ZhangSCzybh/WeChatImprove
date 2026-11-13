 0x10af23c1c
0x10af23c1c: adrp     x9, #0x11f7ae000
0x10af23c20: ldr      x9, [x9, #0x658]
0x10af23c24: cbz      x9, #0x10af23c2c
0x10af23c28: br       x9
0x10af23c2c: sub      sp, sp, #0x1c0
0x10af23c30: stp      x28, x27, [sp, #0x160]
0x10af23c34: stp      x26, x25, [sp, #0x170]
0x10af23c38: stp      x24, x23, [sp, #0x180]
0x10af23c3c: stp      x22, x21, [sp, #0x190]
0x10af23c40: stp      x20, x19, [sp, #0x1a0]
0x10af23c44: stp      x29, x30, [sp, #0x1b0]
0x10af23c48: add      x29, sp, #0x1b0
0x10af23c4c: mov      x22, x4
0x10af23c50: mov      x20, x2
0x10af23c54: mov      x23, x1
0x10af23c58: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x10af23c5c: ldr      x8, [x8, #0xa30] ; ___stack_chk_guard
0x10af23c60: ldr      x8, [x8]
0x10af23c64: stur     x8, [x29, #-0x60]
0x10af23c68: adrp     x8, #0x11f767000
0x10af23c6c: mov      w9, #1
0x10af23c70: strb     w9, [x8, #0x596]
0x10af23c74: add      x0, sp, #0xc8
0x10af23c78: bl       #0x10f83d564
0x10af23c7c: adrp     x26, #0x11ed12000
0x10af23c80: ldr      x0, [x26, #0x618] ; classref iConsole | Class iConsole
0x10af23c84: adrp     x8, #0x11e9c9000
0x10af23c88: ldr      x21, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x10af23c8c: adrp     x8, #0x11d5e0000
0x10af23c90: add      x8, x8, #0xe78 ; @'onNotify - %u'
0x10af23c94: stp      x8, x20, [sp] ; @'onNotify - %u'
0x10af23c98: adrp     x5, #0x11a7dc000 ; 'tTime'
0x10af23c9c: add      x5, x5, #0x97b ; 'stn_callback.mm'
0x10af23ca0: adrp     x7, #0x11a7db000 ; 'urePageReq'
0x10af23ca4: add      x7, x7, #0xbfd ; 'OnPush'
0x10af23ca8: mov      x1, x21 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x10af23cac: mov      w2, #2
0x10af23cb0: mov      x3, #0
0x10af23cb4: mov      w4, #0
0x10af23cb8: mov      w6, #0x5f
0x10af23cbc: bl       #0x10f85fbe8 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x10af23cc0: adrp     x8, #0x11ed14000 ; classref SilkAudioCodec
0x10af23cc4: ldr      x0, [x8, #0x1b0] ; classref MMContextManager | Class MMContextManager
0x10af23cc8: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af23ccc: ldr      x1, [x8, #0xd08] ; @selector(defaultManager) | 'defaultManager'
0x10af23cd0: bl       #0x10f85fbe8 ; _objc_msgSend | selector=defaultManager
0x10af23cd4: mov      x29, x29
0x10af23cd8: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af23cdc: mov      x24, x0
0x10af23ce0: ldrsb    w8, [x23, #0x17]
0x10af23ce4: ldr      x9, [x23]
0x10af23ce8: cmp      w8, #0
0x10af23cec: csel     x2, x9, x23, lt
0x10af23cf0: adrp     x8, #0x11ec5a000 ; @selector(inviteReportInviteConfirmWithMembers:)
0x10af23cf4: ldr      x1, [x8, #0x230] ; @selector(contextByMarsLongLinkName:) | 'contextByMarsLongLinkName:'
0x10af23cf8: bl       #0x10f85fbe8 ; _objc_msgSend | selector=contextByMarsLongLinkName:
0x10af23cfc: mov      x29, x29
0x10af23d00: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af23d04: mov      x27, x0
0x10af23d08: mov      x0, x24
0x10af23d0c: bl       #0x10f85fbf8 ; _objc_release
0x10af23d10: cbz      x27, #0x10af23dec
0x10af23d14: add      x0, sp, #0xb0
0x10af23d18: mov      x1, x27
0x10af23d1c: mov      w2, #0
0x10af23d20: bl       #0x10f83e4d4
0x10af23d24: cmp      w20, #0xe6
0x10af23d28: b.gt     #0x10af23e38
0x10af23d2c: cmp      w20, #0x3c
0x10af23d30: b.le     #0x10af23f44
0x10af23d34: cmp      w20, #0x79
0x10af23d38: b.gt     #0x10af24308
0x10af23d3c: cmp      w20, #0x3d
0x10af23d40: b.eq     #0x10af2459c
0x10af23d44: cmp      w20, #0x78
0x10af23d48: b.ne     #0x10af24d58
0x10af23d4c: adrp     x19, #0x11ed12000
0x10af23d50: ldr      x20, [x19, #0x6d8] ; _OBJC_CLASS_$_NSData
0x10af23d54: mov      x0, x22
0x10af23d58: mov      x1, #0
0x10af23d5c: bl       #0x10f83d540
0x10af23d60: mov      x23, x0
0x10af23d64: mov      x0, x22
0x10af23d68: bl       #0x10f83d544
0x10af23d6c: mov      x3, x0
0x10af23d70: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af23d74: ldr      x22, [x8, #0xb90] ; @selector(dataWithBytes:length:) | 'dataWithBytes:length:'
0x10af23d78: mov      x0, x20
0x10af23d7c: mov      x1, x22 ; 'dataWithBytes:length:'
0x10af23d80: mov      x2, x23
0x10af23d84: bl       #0x10f85fbe8 ; _objc_msgSend | selector=dataWithBytes:length:
0x10af23d88: mov      x29, x29
0x10af23d8c: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af23d90: mov      x20, x0
0x10af23d94: strb     wzr, [sp, #0x6c]
0x10af23d98: cbz      x0, #0x10af24d38
0x10af23d9c: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x10af23da0: ldr      x23, [x8, #0xce8] ; @selector(length) | 'length'
0x10af23da4: mov      x0, x20
0x10af23da8: mov      x1, x23 ; 'length'
0x10af23dac: bl       #0x10f85fbe8 ; _objc_msgSend | selector=length
0x10af23db0: cbz      x0, #0x10af24d38
0x10af23db4: adrp     x8, #0x11eca7000 ; @selector(didReceiveAuthenticationChallengeForDelegate:webView:challenge:completion:)
0x10af23db8: ldr      x1, [x8, #0x7a0] ; @selector(getBytes:length:) | 'getBytes:length:'
0x10af23dbc: add      x2, sp, #0x6c
0x10af23dc0: mov      x0, x20
0x10af23dc4: mov      w3, #1
0x10af23dc8: bl       #0x10f85fbe8 ; _objc_msgSend | selector=getBytes:length:
0x10af23dcc: ldrb     w8, [sp, #0x6c]
0x10af23dd0: cmp      w8, #0x6e
0x10af23dd4: b.eq     #0x10af24dfc
0x10af23dd8: cmp      w8, #0x65
0x10af23ddc: b.ne     #0x10af24d38
0x10af23de0: adrp     x8, #0x11ed4e000 ; classref CBTHalfScreenBizExcerptRoute
0x10af23de4: ldr      x0, [x8, #0xa28] ; classref PSTNHelper | Class PSTNHelper
0x10af23de8: b        #0x10af24d40
0x10af23dec: ldr      x0, [x26, #0x618] ; classref iConsole | Class iConsole
0x10af23df0: ldrsb    w8, [x23, #0x17]
0x10af23df4: ldr      x9, [x23] ; 'length'
0x10af23df8: cmp      w8, #0
0x10af23dfc: csel     x8, x9, x23, lt ; classref CBTHalfScreenBizExcerptRoute
0x10af23e00: adrp     x9, #0x11d5e0000
0x10af23e04: add      x9, x9, #0xe58 ; @'no context for %s'
0x10af23e08: stp      x9, x8, [sp] ; @'no context for %s'
0x10af23e0c: adrp     x5, #0x11a7dc000 ; 'tTime'
0x10af23e10: add      x5, x5, #0x97b ; 'stn_callback.mm'
0x10af23e14: adrp     x7, #0x11a7db000 ; 'urePageReq'
0x10af23e18: add      x7, x7, #0xbfd ; 'OnPush'
0x10af23e1c: mov      x1, x21 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x10af23e20: mov      w2, #4
0x10af23e24: mov      x3, #0
0x10af23e28: mov      w4, #0
0x10af23e2c: mov      w6, #0x63
0x10af23e30: bl       #0x10f85fbe8 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x10af23e34: b        #0x10af24d60
0x10af23e38: cmp      w20, #0x13d
0x10af23e3c: b.le     #0x10af24174
0x10af23e40: cmp      w20, #0x7cf
0x10af23e44: b.gt     #0x10af24368
0x10af23e48: cmp      w20, #0x13e
0x10af23e4c: b.eq     #0x10af245f4
0x10af23e50: cmp      w20, #0x13f
0x10af23e54: b.ne     #0x10af24d58
0x10af23e58: adrp     x8, #0x11ed12000
0x10af23e5c: ldr      x20, [x8, #0x6d8] ; _OBJC_CLASS_$_NSData
0x10af23e60: mov      x0, x22 ; 'dataWithBytes:length:'
0x10af23e64: mov      x1, #0
0x10af23e68: bl       #0x10f83d540
0x10af23e6c: mov      x23, x0
0x10af23e70: mov      x0, x22 ; 'dataWithBytes:length:'
0x10af23e74: bl       #0x10f83d544
0x10af23e78: mov      x3, x0
0x10af23e7c: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af23e80: ldr      x1, [x8, #0xb90] ; @selector(dataWithBytes:length:) | 'dataWithBytes:length:'
0x10af23e84: mov      x0, x20
0x10af23e88: mov      x2, x23
0x10af23e8c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=dataWithBytes:length:
0x10af23e90: mov      x29, x29
0x10af23e94: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af23e98: mov      x20, x0
0x10af23e9c: ldr      x22, [x26, #0x618] ; classref iConsole | Class iConsole
0x10af23ea0: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x10af23ea4: ldr      x1, [x8, #0xce8] ; @selector(length) | 'length'
0x10af23ea8: bl       #0x10f85fbe8 ; _objc_msgSend | selector=length
0x10af23eac: adrp     x8, #0x11d5e0000
0x10af23eb0: add      x8, x8, #0xed8 ; @'BypSyncService sync with nofity data len:%lu'
0x10af23eb4: stp      x8, x0, [sp] ; @'BypSyncService sync with nofity data len:%lu'
0x10af23eb8: adrp     x5, #0x11a7dc000 ; 'tTime'
0x10af23ebc: add      x5, x5, #0x97b ; 'stn_callback.mm'
0x10af23ec0: adrp     x7, #0x11a7db000 ; 'urePageReq'
0x10af23ec4: add      x7, x7, #0xbfd ; 'OnPush'
0x10af23ec8: mov      x0, x22 ; Class iConsole
0x10af23ecc: mov      x1, x21 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x10af23ed0: mov      w2, #2
0x10af23ed4: mov      x3, #0
0x10af23ed8: mov      w4, #0
0x10af23edc: mov      w6, #0xc9
0x10af23ee0: bl       #0x10f85fbe8 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x10af23ee4: adrp     x8, #0x11ed12000
0x10af23ee8: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x10af23eec: adrp     x8, #0x11e9c9000
0x10af23ef0: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x10af23ef4: bl       #0x10f85fbe8 ; _objc_msgSend | selector=currentContext
0x10af23ef8: mov      x29, x29
0x10af23efc: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af23f00: mov      x21, x0
0x10af23f04: adrp     x8, #0x11ed17000 ; classref BrandAttributedNotificationCellViewModel
0x10af23f08: ldr      x0, [x8, #0x6c0] ; classref BypSyncService | Class BypSyncService
0x10af23f0c: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af23f10: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x10af23f14: bl       #0x10f85fbe8 ; _objc_msgSend | selector=class
0x10af23f18: mov      x2, x0
0x10af23f1c: adrp     x8, #0x11e9c9000
0x10af23f20: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x10af23f24: mov      x0, x21
0x10af23f28: bl       #0x10f85fbe8 ; _objc_msgSend | selector=getService:
0x10af23f2c: mov      x29, x29
0x10af23f30: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af23f34: mov      x22, x0
0x10af23f38: adrp     x8, #0x11ec5a000 ; @selector(inviteReportInviteConfirmWithMembers:)
0x10af23f3c: ldr      x1, [x8, #0x270] ; @selector(syncWithNotifyData:) | 'syncWithNotifyData:'
0x10af23f40: b        #0x10af2472c
0x10af23f44: cmp      w20, #5
0x10af23f48: b.eq     #0x10af24844
0x10af23f4c: cmp      w20, #8
0x10af23f50: b.eq     #0x10af249ac
0x10af23f54: cmp      w20, #0x18
0x10af23f58: b.ne     #0x10af24d58
0x10af23f5c: adrp     x8, #0x11ed12000
0x10af23f60: ldr      x20, [x8, #0x6d8] ; _OBJC_CLASS_$_NSData
0x10af23f64: mov      x0, x22
0x10af23f68: mov      x1, #0
0x10af23f6c: bl       #0x10f83d540
0x10af23f70: mov      x23, x0
0x10af23f74: mov      x0, x22
0x10af23f78: bl       #0x10f83d544
0x10af23f7c: mov      x3, x0
0x10af23f80: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af23f84: ldr      x1, [x8, #0xba0] ; @selector(dataWithBytesNoCopy:length:freeWhenDone:) | 'dataWithBytesNoCopy:length:freeWhenDone:'
0x10af23f88: mov      x0, x20
0x10af23f8c: mov      x2, x23
0x10af23f90: mov      w4, #0
0x10af23f94: bl       #0x10f85fbe8 ; _objc_msgSend | selector=dataWithBytesNoCopy:length:freeWhenDone:
0x10af23f98: mov      x29, x29
0x10af23f9c: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af23fa0: mov      x20, x0
0x10af23fa4: cbz      x0, #0x10af24d50
0x10af23fa8: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x10af23fac: ldr      x1, [x8, #0xce8] ; @selector(length) | 'length'
0x10af23fb0: mov      x0, x20
0x10af23fb4: bl       #0x10f85fbe8 ; _objc_msgSend | selector=length
0x10af23fb8: cmp      x0, #4
0x10af23fbc: b.lo     #0x10af24d50
0x10af23fc0: str      wzr, [sp, #0x6c]
0x10af23fc4: adrp     x8, #0x11eca7000 ; @selector(didReceiveAuthenticationChallengeForDelegate:webView:challenge:completion:)
0x10af23fc8: ldr      x1, [x8, #0x7a0] ; @selector(getBytes:length:) | 'getBytes:length:'
0x10af23fcc: add      x2, sp, #0x6c
0x10af23fd0: mov      x0, x20
0x10af23fd4: mov      w3, #4
0x10af23fd8: bl       #0x10f85fbe8 ; _objc_msgSend | selector=getBytes:length:
0x10af23fdc: ldr      w8, [sp, #0x6c]
0x10af23fe0: rev      w8, w8
0x10af23fe4: str      w8, [sp, #0x6c]
0x10af23fe8: ldr      x0, [x26, #0x618] ; classref iConsole | Class iConsole
0x10af23fec: adrp     x9, #0x11d5e0000
0x10af23ff0: add      x9, x9, #0xe98 ; @'new notify uiSelector %x'
0x10af23ff4: stp      x9, x8, [sp] ; @'new notify uiSelector %x'
0x10af23ff8: adrp     x5, #0x11a7dc000 ; 'tTime'
0x10af23ffc: add      x5, x5, #0x97b ; 'stn_callback.mm'
0x10af24000: adrp     x7, #0x11a7db000 ; 'urePageReq'
0x10af24004: add      x7, x7, #0xbfd ; 'OnPush'
0x10af24008: mov      x1, x21
0x10af2400c: mov      w2, #2
0x10af24010: mov      x3, #0
0x10af24014: mov      w4, #0
0x10af24018: mov      w6, #0xa3
0x10af2401c: bl       #0x10f85fbe8 ; _objc_msgSend
0x10af24020: adrp     x8, #0x11ed12000
0x10af24024: ldr      x0, [x8, #0x8a0] ; classref CUtility | Class CUtility
0x10af24028: ldr      w2, [sp, #0x6c]
0x10af2402c: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x10af24030: ldr      x1, [x8, #0xa78] ; @selector(NeedNewSync:) | 'NeedNewSync:'
0x10af24034: bl       #0x10f85fbe8 ; _objc_msgSend | selector=NeedNewSync:
0x10af24038: cbz      w0, #0x10af240f8
0x10af2403c: adrp     x8, #0x11ed12000
0x10af24040: ldr      x0, [x8, #0x630] ; _OBJC_CLASS_$_NSMutableDictionary
0x10af24044: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af24048: ldr      x1, [x8, #0xf70] ; @selector(dictionary) | 'dictionary'
0x10af2404c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=dictionary
0x10af24050: mov      x29, x29
0x10af24054: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24058: mov      x21, x0
0x10af2405c: adrp     x8, #0x11ed12000
0x10af24060: ldr      x0, [x8, #0x638] ; _OBJC_CLASS_$_NSString
0x10af24064: adrp     x8, #0x11ecad000 ; @selector(sharedApplication)
0x10af24068: ldr      x1, [x8, #0x5c8] ; @selector(stringWithFormat:) | 'stringWithFormat:'
0x10af2406c: mov      w8, #1
0x10af24070: str      x8, [sp] ; @selector(sharedApplication)
0x10af24074: adrp     x2, #0x11cfa2000
0x10af24078: add      x2, x2, #0xaf8 ; @'%u'
0x10af2407c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=stringWithFormat:
0x10af24080: mov      x29, x29
0x10af24084: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24088: mov      x22, x0
0x10af2408c: adrp     x8, #0x11ecac000 ; @selector(setManager:)
0x10af24090: ldr      x1, [x8, #0x290] ; @selector(setObject:forKey:) | 'setObject:forKey:'
0x10af24094: adrp     x3, #0x11d184000
0x10af24098: add      x3, x3, #0xab8 ; @'86'
0x10af2409c: mov      x0, x21
0x10af240a0: mov      x2, x22
0x10af240a4: bl       #0x10f85fbe8 ; _objc_msgSend | selector=setObject:forKey:
0x10af240a8: mov      x0, x22
0x10af240ac: bl       #0x10f85fbf8 ; _objc_release
0x10af240b0: adrp     x8, #0x11ed12000
0x10af240b4: ldr      x0, [x8, #0x840] ; classref CAppUtil | Class CAppUtil
0x10af240b8: adrp     x8, #0x11e9d3000 ; @selector(deleteSearchableItemsWithDomainIdentifiers:completionHandler:)
0x10af240bc: ldr      x1, [x8, #0xb68] ; @selector(getMainController) | 'getMainController'
0x10af240c0: bl       #0x10f85fbe8 ; _objc_msgSend | selector=getMainController
0x10af240c4: mov      x29, x29
0x10af240c8: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af240cc: mov      x22, x0
0x10af240d0: adrp     x8, #0x11eb42000 ; @selector(setPolicyListLogic:)
0x10af240d4: ldr      x1, [x8, #0xa90] ; @selector(NotifyFromEvent:Message:MessageInfo:) | 'NotifyFromEvent:Message:MessageInfo:'
0x10af240d8: mov      x2, #0
0x10af240dc: mov      w3, #4
0x10af240e0: mov      x4, x21
0x10af240e4: bl       #0x10f85fbe8 ; _objc_msgSend | selector=NotifyFromEvent:Message:MessageInfo:
0x10af240e8: mov      x0, x22
0x10af240ec: bl       #0x10f85fbf8 ; _objc_release
0x10af240f0: mov      x0, x21
0x10af240f4: bl       #0x10f85fbf8 ; _objc_release
0x10af240f8: adrp     x8, #0x11ed12000
0x10af240fc: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x10af24100: adrp     x8, #0x11e9c9000
0x10af24104: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x10af24108: bl       #0x10f85fbe8 ; _objc_msgSend | selector=currentContext
0x10af2410c: mov      x29, x29
0x10af24110: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24114: mov      x21, x0
0x10af24118: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x10af2411c: ldr      x2, [x8, #0x760]
0x10af24120: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x10af24124: ldr      x3, [x8, #0xab8] ; @selector(onNewSyncPlugin:) | 'onNewSyncPlugin:'
0x10af24128: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x10af2412c: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x10af24130: str      x8, [sp, #0x48]
0x10af24134: adrp     x8, #0x1178c7000
0x10af24138: ldr      d0, [x8, #0x770]
0x10af2413c: str      d0, [sp, #0x50]
0x10af24140: adrp     x8, #0x10af25000
0x10af24144: add      x8, x8, #0x28
0x10af24148: adrp     x9, #0x11c281000
0x10af2414c: add      x9, x9, #0x898
0x10af24150: stp      x8, x9, [sp, #0x58]
0x10af24154: ldr      w8, [sp, #0x6c]
0x10af24158: str      w8, [sp, #0x68]
0x10af2415c: adrp     x8, #0x11e9c9000
0x10af24160: ldr      x1, [x8, #0xf70] ; @selector(callExtensionOnMainThread:selector:sync:block:) | 'callExtensionOnMainThread:selector:sync:block:'
0x10af24164: add      x5, sp, #0x48
0x10af24168: mov      w4, #0
0x10af2416c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=callExtensionOnMainThread:selector:sync:block:
0x10af24170: b        #0x10af249a0
0x10af24174: cmp      w20, #0xe7
0x10af24178: b.eq     #0x10af248f4
0x10af2417c: cmp      w20, #0xf1
0x10af24180: b.eq     #0x10af24ce0
0x10af24184: cmp      w20, #0x13d
0x10af24188: b.ne     #0x10af24d58
0x10af2418c: adrp     x8, #0x11ed4e000 ; classref CBTHalfScreenBizExcerptRoute
0x10af24190: ldr      x20, [x8, #0xa00] ; classref SecureNotify | Class SecureNotify
0x10af24194: mov      x0, x22
0x10af24198: mov      x1, #0
0x10af2419c: bl       #0x10f83d540
0x10af241a0: mov      x23, x0
0x10af241a4: mov      x0, x22
0x10af241a8: bl       #0x10f83d544
0x10af241ac: mov      x3, x0
0x10af241b0: adrp     x8, #0x11ec5a000 ; @selector(inviteReportInviteConfirmWithMembers:)
0x10af241b4: ldr      x1, [x8, #0x288] ; @selector(decodeSecureNotifyData:length:) | 'decodeSecureNotifyData:length:'
0x10af241b8: mov      x0, x20 ; Class SecureNotify
0x10af241bc: mov      x2, x23
0x10af241c0: bl       #0x10f85fbe8 ; _objc_msgSend | selector=decodeSecureNotifyData:length:
0x10af241c4: mov      x29, x29
0x10af241c8: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af241cc: mov      x20, x0
0x10af241d0: cbz      x0, #0x10af24da8
0x10af241d4: adrp     x19, #0x11ed12000
0x10af241d8: ldr      x0, [x19, #0x780] ; classref MMContext | Class MMContext
0x10af241dc: adrp     x8, #0x11e9c9000
0x10af241e0: ldr      x21, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x10af241e4: mov      x1, x21 ; 'currentContext'
0x10af241e8: bl       #0x10f85fbe8 ; _objc_msgSend | selector=currentContext
0x10af241ec: mov      x29, x29
0x10af241f0: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af241f4: mov      x25, x0
0x10af241f8: adrp     x8, #0x11ed12000
0x10af241fc: ldr      x0, [x8, #0x8b0] ; classref MultiTalkMgr | Class MultiTalkMgr
0x10af24200: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af24204: ldr      x22, [x8, #0x508] ; @selector(class) | 'class'
0x10af24208: mov      x1, x22 ; 'class'
0x10af2420c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=class
0x10af24210: mov      x2, x0
0x10af24214: adrp     x8, #0x11e9c9000
0x10af24218: ldr      x23, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x10af2421c: mov      x0, x25
0x10af24220: mov      x1, x23 ; 'getService:'
0x10af24224: bl       #0x10f85fbe8 ; _objc_msgSend | selector=getService:
0x10af24228: mov      x29, x29
0x10af2422c: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24230: mov      x26, x0
0x10af24234: adrp     x8, #0x11ec5a000 ; @selector(inviteReportInviteConfirmWithMembers:)
0x10af24238: ldr      x24, [x8, #0x290] ; @selector(notifyWithData:) | 'notifyWithData:'
0x10af2423c: mov      x1, x24 ; 'notifyWithData:'
0x10af24240: mov      x2, x20
0x10af24244: bl       #0x10f85fbe8 ; _objc_msgSend | selector=notifyWithData:
0x10af24248: mov      x0, x26
0x10af2424c: bl       #0x10f85fbf8 ; _objc_release
0x10af24250: mov      x0, x25
0x10af24254: bl       #0x10f85fbf8 ; _objc_release
0x10af24258: ldr      x0, [x19, #0x780] ; classref MMContext | Class MMContext
0x10af2425c: mov      x1, x21 ; 'currentContext'
0x10af24260: bl       #0x10f85fbe8 ; _objc_msgSend | selector=currentContext
0x10af24264: mov      x29, x29
0x10af24268: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af2426c: mov      x25, x0
0x10af24270: adrp     x8, #0x11ed32000 ; classref MagicEcsNirvanaLoadingComponent
0x10af24274: ldr      x0, [x8, #0x900] ; classref VOIPMessageMgr | Class VOIPMessageMgr
0x10af24278: mov      x1, x22 ; 'class'
0x10af2427c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=class
0x10af24280: mov      x2, x0
0x10af24284: mov      x0, x25
0x10af24288: mov      x1, x23 ; 'getService:'
0x10af2428c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=getService:
0x10af24290: mov      x29, x29
0x10af24294: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24298: mov      x26, x0
0x10af2429c: adrp     x8, #0x11ec5a000 ; @selector(inviteReportInviteConfirmWithMembers:)
0x10af242a0: ldr      x1, [x8, #0x298] ; @selector(receiveOtherDeviceHandleSignalFromSecurityNotify:) | 'receiveOtherDeviceHandleSignalFromSecurityNotify:'
0x10af242a4: mov      x2, x20
0x10af242a8: bl       #0x10f85fbe8 ; _objc_msgSend | selector=receiveOtherDeviceHandleSignalFromSecurityNotify:
0x10af242ac: mov      x0, x26
0x10af242b0: bl       #0x10f85fbf8 ; _objc_release
0x10af242b4: mov      x0, x25
0x10af242b8: bl       #0x10f85fbf8 ; _objc_release
0x10af242bc: ldr      x0, [x19, #0x780] ; classref MMContext | Class MMContext
0x10af242c0: mov      x1, x21 ; 'currentContext'
0x10af242c4: bl       #0x10f85fbe8 ; _objc_msgSend | selector=currentContext
0x10af242c8: mov      x29, x29
0x10af242cc: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af242d0: mov      x21, x0
0x10af242d4: adrp     x8, #0x11ed12000
0x10af242d8: ldr      x0, [x8, #0xa18] ; classref VOIPMgr | Class VOIPMgr
0x10af242dc: mov      x1, x22 ; 'class'
0x10af242e0: bl       #0x10f85fbe8 ; _objc_msgSend | selector=class
0x10af242e4: mov      x2, x0
0x10af242e8: mov      x0, x21
0x10af242ec: mov      x1, x23 ; 'getService:'
0x10af242f0: bl       #0x10f85fbe8 ; _objc_msgSend | selector=getService:
0x10af242f4: mov      x29, x29
0x10af242f8: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af242fc: mov      x22, x0
0x10af24300: mov      x1, x24 ; 'notifyWithData:'
0x10af24304: b        #0x10af2472c
0x10af24308: cmp      w20, #0x7a
0x10af2430c: b.eq     #0x10af24738
0x10af24310: cmp      w20, #0xc0
0x10af24314: b.ne     #0x10af24d58
0x10af24318: adrp     x8, #0x11ed12000
0x10af2431c: ldr      x20, [x8, #0x6d8] ; _OBJC_CLASS_$_NSData
0x10af24320: mov      x0, x22
0x10af24324: mov      x1, #0
0x10af24328: bl       #0x10f83d540
0x10af2432c: mov      x21, x0
0x10af24330: mov      x0, x22
0x10af24334: bl       #0x10f83d544
0x10af24338: mov      x3, x0
0x10af2433c: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af24340: ldr      x1, [x8, #0xb90] ; @selector(dataWithBytes:length:) | 'dataWithBytes:length:'
0x10af24344: mov      x0, x20
0x10af24348: mov      x2, x21
0x10af2434c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=dataWithBytes:length:
0x10af24350: mov      x29, x29
0x10af24354: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24358: mov      x20, x0
0x10af2435c: adrp     x8, #0x11ed1f000 ; classref FavTempNavPlaceholderViewController
0x10af24360: ldr      x0, [x8, #0x858] ; classref FavoritesSyncLogicHelper | Class FavoritesSyncLogicHelper
0x10af24364: b        #0x10af24d2c
0x10af24368: cmp      w20, #0x7d0
0x10af2436c: b.eq     #0x10af247b0
0x10af24370: mov      w8, #0xcc7d
0x10af24374: movk     w8, #0x3b9a, lsl #16
0x10af24378: cmp      w20, w8
0x10af2437c: b.ne     #0x10af24d58
0x10af24380: adrp     x8, #0x11ed12000
0x10af24384: ldr      x20, [x8, #0x6d8] ; _OBJC_CLASS_$_NSData
0x10af24388: mov      x0, x22
0x10af2438c: mov      x1, #0
0x10af24390: bl       #0x10f83d540
0x10af24394: mov      x21, x0
0x10af24398: mov      x0, x22
0x10af2439c: bl       #0x10f83d544
0x10af243a0: mov      x3, x0
0x10af243a4: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af243a8: ldr      x1, [x8, #0xba0] ; @selector(dataWithBytesNoCopy:length:freeWhenDone:) | 'dataWithBytesNoCopy:length:freeWhenDone:'
0x10af243ac: mov      x0, x20
0x10af243b0: mov      x2, x21
0x10af243b4: mov      w4, #0
0x10af243b8: bl       #0x10f85fbe8 ; _objc_msgSend | selector=dataWithBytesNoCopy:length:freeWhenDone:
0x10af243bc: mov      x29, x29
0x10af243c0: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af243c4: mov      x20, x0
0x10af243c8: adrp     x8, #0x11ed38000 ; classref TingPlayerPauseContext
0x10af243cc: ldr      x0, [x8, #0x458] ; classref CPushSend | Class CPushSend
0x10af243d0: bl       #0x10f85fb88 ; _objc_alloc_init
0x10af243d4: mov      x21, x0
0x10af243d8: adrp     x8, #0x11ec5a000 ; @selector(inviteReportInviteConfirmWithMembers:)
0x10af243dc: ldr      x1, [x8, #0x238] ; @selector(Decode:) | 'Decode:'
0x10af243e0: mov      x2, x20
0x10af243e4: bl       #0x10f85fbe8 ; _objc_msgSend | selector=Decode:
0x10af243e8: cbz      w0, #0x10af249a0
0x10af243ec: adrp     x8, #0x11ec5a000 ; @selector(inviteReportInviteConfirmWithMembers:)
0x10af243f0: ldr      x1, [x8, #0x240] ; @selector(m_subCmd) | 'm_subCmd'
0x10af243f4: mov      x0, x21
0x10af243f8: bl       #0x10f85fbe8 ; _objc_msgSend | selector=m_subCmd
0x10af243fc: sub      w8, w0, #0x18, lsl #12
0x10af24400: cmp      w8, #0x6b1
0x10af24404: b.ne     #0x10af249a0
0x10af24408: adrp     x8, #0x11ed4e000 ; classref CBTHalfScreenBizExcerptRoute
0x10af2440c: ldr      x22, [x8, #0xa18] ; classref RecvTyping | Class RecvTyping
0x10af24410: adrp     x8, #0x11eb35000 ; @selector(replaceMicroMerchantDataItem:referenceGroup:)
0x10af24414: ldr      x1, [x8, #0xb8] ; @selector(m_buffer) | 'm_buffer'
0x10af24418: mov      x0, x21
0x10af2441c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=m_buffer
0x10af24420: mov      x29, x29
0x10af24424: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24428: mov      x23, x0
0x10af2442c: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x10af24430: ldr      x1, [x8, #0x738] ; @selector(parseFromData:) | 'parseFromData:'
0x10af24434: mov      x0, x22 ; Class RecvTyping
0x10af24438: mov      x2, x23
0x10af2443c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=parseFromData:
0x10af24440: mov      x29, x29
0x10af24444: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24448: mov      x22, x0
0x10af2444c: mov      x0, x23
0x10af24450: bl       #0x10f85fbf8 ; _objc_release
0x10af24454: cbz      x22, #0x10af24998
0x10af24458: adrp     x19, #0x11ed12000
0x10af2445c: ldr      x0, [x19, #0x638] ; _OBJC_CLASS_$_NSString
0x10af24460: bl       #0x10f85fb80 ; _objc_alloc
0x10af24464: mov      x23, x0
0x10af24468: adrp     x8, #0x11ea10000 ; @selector(ownMaskTexture)
0x10af2446c: ldr      x1, [x8, #0x920] ; @selector(sender) | 'sender'
0x10af24470: mov      x0, x22
0x10af24474: bl       #0x10f85fbe8 ; _objc_msgSend | selector=sender
0x10af24478: mov      x29, x29
0x10af2447c: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24480: mov      x24, x0
0x10af24484: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x10af24488: ldr      x1, [x8, #0x268] ; @selector(initWithData:encoding:) | 'initWithData:encoding:'
0x10af2448c: mov      x0, x23
0x10af24490: mov      x2, x24
0x10af24494: mov      w3, #0x100
0x10af24498: movk     w3, #0x800, lsl #16
0x10af2449c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=initWithData:encoding:
0x10af244a0: mov      x23, x0
0x10af244a4: mov      x0, x24
0x10af244a8: bl       #0x10f85fbf8 ; _objc_release
0x10af244ac: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x10af244b0: ldr      x1, [x8, #0xce8] ; @selector(length) | 'length'
0x10af244b4: mov      x0, x23
0x10af244b8: bl       #0x10f85fbe8 ; _objc_msgSend | selector=length
0x10af244bc: cbz      x0, #0x10af24590
0x10af244c0: adrp     x8, #0x11ed12000
0x10af244c4: ldr      x0, [x8, #0x630] ; _OBJC_CLASS_$_NSMutableDictionary
0x10af244c8: bl       #0x10f85fb88 ; _objc_alloc_init
0x10af244cc: mov      x24, x0
0x10af244d0: adrp     x8, #0x11ecac000 ; @selector(setManager:)
0x10af244d4: ldr      x25, [x8, #0x290] ; @selector(setObject:forKey:) | 'setObject:forKey:'
0x10af244d8: adrp     x3, #0x11cfc1000
0x10af244dc: add      x3, x3, #0x238 ; @'5'
0x10af244e0: mov      x1, x25 ; 'setObject:forKey:'
0x10af244e4: mov      x2, x23
0x10af244e8: bl       #0x10f85fbe8 ; _objc_msgSend | selector=setObject:forKey:
0x10af244ec: ldr      x26, [x19, #0x638] ; _OBJC_CLASS_$_NSString
0x10af244f0: adrp     x8, #0x11ecad000 ; @selector(sharedApplication)
0x10af244f4: ldr      x1, [x8, #0x378] ; @selector(status) | 'status'
0x10af244f8: mov      x0, x22
0x10af244fc: bl       #0x10f85fbe8 ; _objc_msgSend | selector=status
0x10af24500: adrp     x8, #0x11ecad000 ; @selector(sharedApplication)
0x10af24504: ldr      x1, [x8, #0x5c8] ; @selector(stringWithFormat:) | 'stringWithFormat:'
0x10af24508: str      x0, [sp]
0x10af2450c: adrp     x2, #0x11cfa2000
0x10af24510: add      x2, x2, #0xaf8 ; @'%u'
0x10af24514: mov      x0, x26
0x10af24518: bl       #0x10f85fbe8 ; _objc_msgSend | selector=stringWithFormat:
0x10af2451c: mov      x29, x29
0x10af24520: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24524: mov      x26, x0
0x10af24528: adrp     x3, #0x11d184000
0x10af2452c: add      x3, x3, #0x5f8 ; @'44'
0x10af24530: mov      x0, x24
0x10af24534: mov      x1, x25 ; 'setObject:forKey:'
0x10af24538: mov      x2, x26
0x10af2453c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=setObject:forKey:
0x10af24540: mov      x0, x26
0x10af24544: bl       #0x10f85fbf8 ; _objc_release
0x10af24548: adrp     x8, #0x11ed12000
0x10af2454c: ldr      x0, [x8, #0x840] ; classref CAppUtil | Class CAppUtil
0x10af24550: adrp     x8, #0x11e9d3000 ; @selector(deleteSearchableItemsWithDomainIdentifiers:completionHandler:)
0x10af24554: ldr      x1, [x8, #0xb68] ; @selector(getMainController) | 'getMainController'
0x10af24558: bl       #0x10f85fbe8 ; _objc_msgSend | selector=getMainController
0x10af2455c: mov      x29, x29
0x10af24560: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24564: mov      x25, x0
0x10af24568: adrp     x8, #0x11eb42000 ; @selector(setPolicyListLogic:)
0x10af2456c: ldr      x1, [x8, #0xa90] ; @selector(NotifyFromEvent:Message:MessageInfo:) | 'NotifyFromEvent:Message:MessageInfo:'
0x10af24570: mov      x2, #0
0x10af24574: mov      w3, #0x4d
0x10af24578: mov      x4, x24
0x10af2457c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=NotifyFromEvent:Message:MessageInfo:
0x10af24580: mov      x0, x25
0x10af24584: bl       #0x10f85fbf8 ; _objc_release
0x10af24588: mov      x0, x24
0x10af2458c: bl       #0x10f85fbf8 ; _objc_release
0x10af24590: mov      x0, x23
0x10af24594: bl       #0x10f85fbf8 ; _objc_release
0x10af24598: b        #0x10af24998
0x10af2459c: adrp     x8, #0x11ed12000
0x10af245a0: ldr      x20, [x8, #0x6d8] ; _OBJC_CLASS_$_NSData
0x10af245a4: mov      x0, x22
0x10af245a8: mov      x1, #0
0x10af245ac: bl       #0x10f83d540
0x10af245b0: mov      x21, x0
0x10af245b4: mov      x0, x22
0x10af245b8: bl       #0x10f83d544
0x10af245bc: mov      x3, x0
0x10af245c0: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af245c4: ldr      x1, [x8, #0xb90] ; @selector(dataWithBytes:length:) | 'dataWithBytes:length:'
0x10af245c8: mov      x0, x20
0x10af245cc: mov      x2, x21
0x10af245d0: bl       #0x10f85fbe8 ; _objc_msgSend | selector=dataWithBytes:length:
0x10af245d4: mov      x29, x29
0x10af245d8: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af245dc: mov      x20, x0
0x10af245e0: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x10af245e4: ldr      x0, [x8, #0xbe0] ; classref VOIPHelper | Class VOIPHelper
0x10af245e8: adrp     x8, #0x11ec5a000 ; @selector(inviteReportInviteConfirmWithMembers:)
0x10af245ec: ldr      x1, [x8, #0x258] ; @selector(NotifyWithData:) | 'NotifyWithData:'
0x10af245f0: b        #0x10af24d48
0x10af245f4: adrp     x8, #0x11ed4e000 ; classref CBTHalfScreenBizExcerptRoute
0x10af245f8: ldr      x20, [x8, #0xa00] ; classref SecureNotify | Class SecureNotify
0x10af245fc: mov      x0, x22
0x10af24600: mov      x1, #0
0x10af24604: bl       #0x10f83d540
0x10af24608: mov      x23, x0
0x10af2460c: mov      x0, x22
0x10af24610: bl       #0x10f83d544
0x10af24614: mov      x3, x0
0x10af24618: adrp     x8, #0x11ec5a000 ; @selector(inviteReportInviteConfirmWithMembers:)
0x10af2461c: ldr      x1, [x8, #0x288] ; @selector(decodeSecureNotifyData:length:) | 'decodeSecureNotifyData:length:'
0x10af24620: mov      x0, x20 ; Class SecureNotify
0x10af24624: mov      x2, x23
0x10af24628: bl       #0x10f85fbe8 ; _objc_msgSend | selector=decodeSecureNotifyData:length:
0x10af2462c: mov      x29, x29
0x10af24630: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24634: mov      x20, x0
0x10af24638: cbnz     x0, #0x10af246d0
0x10af2463c: ldr      x0, [x26, #0x618]
0x10af24640: adrp     x8, #0x11d5e0000
0x10af24644: add      x8, x8, #0xef8 ; @'fail to decode silencenotify, try again'
0x10af24648: str      x8, [sp] ; @'fail to decode silencenotify, try again'
0x10af2464c: adrp     x5, #0x11a7dc000 ; 'tTime'
0x10af24650: add      x5, x5, #0x97b ; 'stn_callback.mm'
0x10af24654: adrp     x7, #0x11a7db000 ; 'urePageReq'
0x10af24658: add      x7, x7, #0xbfd ; 'OnPush'
0x10af2465c: mov      x1, x21
0x10af24660: mov      w2, #4
0x10af24664: mov      x3, #0
0x10af24668: mov      w4, #0
0x10af2466c: mov      w6, #0xe8
0x10af24670: bl       #0x10f85fbe8 ; _objc_msgSend
0x10af24674: mov      w0, #0x90
0x10af24678: mov      w1, #0x64
0x10af2467c: mov      w2, #1
0x10af24680: mov      w3, #0
0x10af24684: mov      w4, #0
0x10af24688: bl       #0x107c095b0
0x10af2468c: adrp     x8, #0x11ed12000
0x10af24690: ldr      x20, [x8, #0x6d8] ; _OBJC_CLASS_$_NSData
0x10af24694: mov      x0, x22
0x10af24698: mov      x1, #0
0x10af2469c: bl       #0x10f83d540
0x10af246a0: mov      x21, x0
0x10af246a4: mov      x0, x22
0x10af246a8: bl       #0x10f83d544
0x10af246ac: mov      x3, x0
0x10af246b0: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af246b4: ldr      x1, [x8, #0xb90] ; @selector(dataWithBytes:length:) | 'dataWithBytes:length:'
0x10af246b8: mov      x0, x20
0x10af246bc: mov      x2, x21
0x10af246c0: bl       #0x10f85fbe8 ; _objc_msgSend | selector=dataWithBytes:length:
0x10af246c4: mov      x29, x29
0x10af246c8: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af246cc: mov      x20, x0
0x10af246d0: adrp     x8, #0x11ed12000
0x10af246d4: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x10af246d8: adrp     x8, #0x11e9c9000
0x10af246dc: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x10af246e0: bl       #0x10f85fbe8 ; _objc_msgSend | selector=currentContext
0x10af246e4: mov      x29, x29
0x10af246e8: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af246ec: mov      x21, x0
0x10af246f0: adrp     x8, #0x11ed14000 ; classref SilkAudioCodec
0x10af246f4: ldr      x0, [x8, #0xdb0] ; classref BadRoomMgr | Class BadRoomMgr
0x10af246f8: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af246fc: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x10af24700: bl       #0x10f85fbe8 ; _objc_msgSend | selector=class
0x10af24704: mov      x2, x0
0x10af24708: adrp     x8, #0x11e9c9000
0x10af2470c: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x10af24710: mov      x0, x21
0x10af24714: bl       #0x10f85fbe8 ; _objc_msgSend | selector=getService:
0x10af24718: mov      x29, x29
0x10af2471c: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24720: mov      x22, x0
0x10af24724: adrp     x8, #0x11ec5a000 ; @selector(inviteReportInviteConfirmWithMembers:)
0x10af24728: ldr      x1, [x8, #0x290] ; @selector(notifyWithData:) | 'notifyWithData:'
0x10af2472c: mov      x2, x20
0x10af24730: bl       #0x10f85fbe8 ; _objc_msgSend | selector=notifyWithData:
0x10af24734: b        #0x10af24998
0x10af24738: adrp     x8, #0x11ed12000
0x10af2473c: ldr      x20, [x8, #0x6d8] ; _OBJC_CLASS_$_NSData
0x10af24740: mov      x0, x22
0x10af24744: mov      x1, #0
0x10af24748: bl       #0x10f83d540
0x10af2474c: mov      x21, x0
0x10af24750: mov      x0, x22
0x10af24754: bl       #0x10f83d544
0x10af24758: mov      x3, x0
0x10af2475c: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af24760: ldr      x1, [x8, #0xb90] ; @selector(dataWithBytes:length:) | 'dataWithBytes:length:'
0x10af24764: mov      x0, x20
0x10af24768: mov      x2, x21
0x10af2476c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=dataWithBytes:length:
0x10af24770: mov      x29, x29
0x10af24774: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24778: mov      x20, x0
0x10af2477c: adrp     x8, #0x11ed4e000 ; classref CBTHalfScreenBizExcerptRoute
0x10af24780: ldr      x21, [x8, #0xa30] ; classref ThreadQueue | Class ThreadQueue
0x10af24784: adrp     x8, #0x11ed12000
0x10af24788: ldr      x0, [x8, #0x840] ; classref CAppUtil | Class CAppUtil
0x10af2478c: adrp     x8, #0x11e9d3000 ; @selector(deleteSearchableItemsWithDomainIdentifiers:completionHandler:)
0x10af24790: ldr      x1, [x8, #0xb68] ; @selector(getMainController) | 'getMainController'
0x10af24794: bl       #0x10f85fbe8 ; _objc_msgSend | selector=getMainController
0x10af24798: mov      x29, x29
0x10af2479c: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af247a0: mov      x22, x0
0x10af247a4: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x10af247a8: ldr      x3, [x8, #0x700] ; @selector(HandleNewSyncPush:) | 'HandleNewSyncPush:'
0x10af247ac: b        #0x10af24824
0x10af247b0: adrp     x8, #0x11ed12000
0x10af247b4: ldr      x20, [x8, #0x6d8] ; _OBJC_CLASS_$_NSData
0x10af247b8: mov      x0, x22
0x10af247bc: mov      x1, #0
0x10af247c0: bl       #0x10f83d540
0x10af247c4: mov      x21, x0
0x10af247c8: mov      x0, x22
0x10af247cc: bl       #0x10f83d544
0x10af247d0: mov      x3, x0
0x10af247d4: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af247d8: ldr      x1, [x8, #0xb90] ; @selector(dataWithBytes:length:) | 'dataWithBytes:length:'
0x10af247dc: mov      x0, x20
0x10af247e0: mov      x2, x21
0x10af247e4: bl       #0x10f85fbe8 ; _objc_msgSend | selector=dataWithBytes:length:
0x10af247e8: mov      x29, x29
0x10af247ec: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af247f0: mov      x20, x0
0x10af247f4: adrp     x8, #0x11ed4e000 ; classref CBTHalfScreenBizExcerptRoute
0x10af247f8: ldr      x21, [x8, #0xa30] ; classref ThreadQueue | Class ThreadQueue
0x10af247fc: adrp     x8, #0x11ed12000
0x10af24800: ldr      x0, [x8, #0x840] ; classref CAppUtil | Class CAppUtil
0x10af24804: adrp     x8, #0x11e9d3000 ; @selector(deleteSearchableItemsWithDomainIdentifiers:completionHandler:)
0x10af24808: ldr      x1, [x8, #0xb68] ; @selector(getMainController) | 'getMainController'
0x10af2480c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=getMainController
0x10af24810: mov      x29, x29
0x10af24814: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24818: mov      x22, x0
0x10af2481c: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x10af24820: ldr      x3, [x8, #0x708] ; @selector(HandleNewSyncPush64:) | 'HandleNewSyncPush64:'
0x10af24824: adrp     x8, #0x11ec5a000 ; @selector(inviteReportInviteConfirmWithMembers:)
0x10af24828: ldr      x1, [x8, #0x278] ; @selector(RunWithTarget:selector:object:) | 'RunWithTarget:selector:object:'
0x10af2482c: mov      x0, x21 ; Class ThreadQueue
0x10af24830: mov      x2, x22
0x10af24834: mov      x4, x20
0x10af24838: bl       #0x10f85fbe8 ; _objc_msgSend | selector=RunWithTarget:selector:object:
0x10af2483c: mov      x0, x22
0x10af24840: b        #0x10af249a4
0x10af24844: adrp     x8, #0x11ed12000
0x10af24848: ldr      x0, [x8, #0x630] ; _OBJC_CLASS_$_NSMutableDictionary
0x10af2484c: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af24850: ldr      x1, [x8, #0xf70] ; @selector(dictionary) | 'dictionary'
0x10af24854: bl       #0x10f85fbe8 ; _objc_msgSend | selector=dictionary
0x10af24858: mov      x29, x29
0x10af2485c: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24860: mov      x20, x0
0x10af24864: adrp     x8, #0x11ed12000
0x10af24868: ldr      x0, [x8, #0x638] ; _OBJC_CLASS_$_NSString
0x10af2486c: adrp     x8, #0x11ecad000 ; @selector(sharedApplication)
0x10af24870: ldr      x1, [x8, #0x5c8] ; @selector(stringWithFormat:) | 'stringWithFormat:'
0x10af24874: mov      w8, #1
0x10af24878: str      x8, [sp] ; @selector(sharedApplication)
0x10af2487c: adrp     x2, #0x11cfa2000
0x10af24880: add      x2, x2, #0xaf8 ; @'%u'
0x10af24884: bl       #0x10f85fbe8 ; _objc_msgSend | selector=stringWithFormat:
0x10af24888: mov      x29, x29
0x10af2488c: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24890: mov      x21, x0
0x10af24894: adrp     x8, #0x11ecac000 ; @selector(setManager:)
0x10af24898: ldr      x1, [x8, #0x290] ; @selector(setObject:forKey:) | 'setObject:forKey:'
0x10af2489c: adrp     x3, #0x11d184000
0x10af248a0: add      x3, x3, #0xab8 ; @'86'
0x10af248a4: mov      x0, x20
0x10af248a8: mov      x2, x21
0x10af248ac: bl       #0x10f85fbe8 ; _objc_msgSend | selector=setObject:forKey:
0x10af248b0: mov      x0, x21
0x10af248b4: bl       #0x10f85fbf8 ; _objc_release
0x10af248b8: adrp     x8, #0x11ed12000
0x10af248bc: ldr      x0, [x8, #0x840] ; classref CAppUtil | Class CAppUtil
0x10af248c0: adrp     x8, #0x11e9d3000 ; @selector(deleteSearchableItemsWithDomainIdentifiers:completionHandler:)
0x10af248c4: ldr      x1, [x8, #0xb68] ; @selector(getMainController) | 'getMainController'
0x10af248c8: bl       #0x10f85fbe8 ; _objc_msgSend | selector=getMainController
0x10af248cc: mov      x29, x29
0x10af248d0: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af248d4: mov      x21, x0
0x10af248d8: adrp     x8, #0x11eb42000 ; @selector(setPolicyListLogic:)
0x10af248dc: ldr      x1, [x8, #0xa90] ; @selector(NotifyFromEvent:Message:MessageInfo:) | 'NotifyFromEvent:Message:MessageInfo:'
0x10af248e0: mov      x2, #0
0x10af248e4: mov      w3, #4
0x10af248e8: mov      x4, x20
0x10af248ec: bl       #0x10f85fbe8 ; _objc_msgSend | selector=NotifyFromEvent:Message:MessageInfo:
0x10af248f0: b        #0x10af249a0
0x10af248f4: adrp     x8, #0x11ed12000
0x10af248f8: ldr      x20, [x8, #0x6d8] ; _OBJC_CLASS_$_NSData
0x10af248fc: mov      x0, x22
0x10af24900: mov      x1, #0
0x10af24904: bl       #0x10f83d540
0x10af24908: mov      x21, x0
0x10af2490c: mov      x0, x22
0x10af24910: bl       #0x10f83d544
0x10af24914: mov      x3, x0
0x10af24918: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af2491c: ldr      x1, [x8, #0xb90] ; @selector(dataWithBytes:length:) | 'dataWithBytes:length:'
0x10af24920: mov      x0, x20
0x10af24924: mov      x2, x21
0x10af24928: bl       #0x10f85fbe8 ; _objc_msgSend | selector=dataWithBytes:length:
0x10af2492c: mov      x29, x29
0x10af24930: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24934: mov      x20, x0
0x10af24938: adrp     x8, #0x11ed12000
0x10af2493c: ldr      x0, [x8, #0x630] ; _OBJC_CLASS_$_NSMutableDictionary
0x10af24940: bl       #0x10f85fb88 ; _objc_alloc_init
0x10af24944: mov      x21, x0
0x10af24948: adrp     x8, #0x11ecac000 ; @selector(setManager:)
0x10af2494c: ldr      x1, [x8, #0x290] ; @selector(setObject:forKey:) | 'setObject:forKey:'
0x10af24950: adrp     x3, #0x11d04b000
0x10af24954: add      x3, x3, #0x1b8 ; @'198'
0x10af24958: mov      x2, x20
0x10af2495c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=setObject:forKey:
0x10af24960: adrp     x8, #0x11ed12000
0x10af24964: ldr      x0, [x8, #0x840] ; classref CAppUtil | Class CAppUtil
0x10af24968: adrp     x8, #0x11e9d3000 ; @selector(deleteSearchableItemsWithDomainIdentifiers:completionHandler:)
0x10af2496c: ldr      x1, [x8, #0xb68] ; @selector(getMainController) | 'getMainController'
0x10af24970: bl       #0x10f85fbe8 ; _objc_msgSend | selector=getMainController
0x10af24974: mov      x29, x29
0x10af24978: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af2497c: mov      x22, x0
0x10af24980: adrp     x8, #0x11eb42000 ; @selector(setPolicyListLogic:)
0x10af24984: ldr      x1, [x8, #0xa90] ; @selector(NotifyFromEvent:Message:MessageInfo:) | 'NotifyFromEvent:Message:MessageInfo:'
0x10af24988: mov      x2, #0
0x10af2498c: mov      w3, #0x188
0x10af24990: mov      x4, x21
0x10af24994: bl       #0x10f85fbe8 ; _objc_msgSend | selector=NotifyFromEvent:Message:MessageInfo:
0x10af24998: mov      x0, x22
0x10af2499c: bl       #0x10f85fbf8 ; _objc_release
0x10af249a0: mov      x0, x21
0x10af249a4: bl       #0x10f85fbf8 ; _objc_release
0x10af249a8: b        #0x10af24d50
0x10af249ac: adrp     x8, #0x11ed12000
0x10af249b0: ldr      x20, [x8, #0x6d8] ; _OBJC_CLASS_$_NSData
0x10af249b4: mov      x0, x22
0x10af249b8: mov      x1, #0
0x10af249bc: bl       #0x10f83d540
0x10af249c0: mov      x21, x0
0x10af249c4: mov      x0, x22
0x10af249c8: bl       #0x10f83d544
0x10af249cc: mov      x3, x0
0x10af249d0: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af249d4: ldr      x1, [x8, #0xba0] ; @selector(dataWithBytesNoCopy:length:freeWhenDone:) | 'dataWithBytesNoCopy:length:freeWhenDone:'
0x10af249d8: mov      x0, x20
0x10af249dc: mov      x2, x21
0x10af249e0: mov      w4, #0
0x10af249e4: bl       #0x10f85fbe8 ; _objc_msgSend | selector=dataWithBytesNoCopy:length:freeWhenDone:
0x10af249e8: mov      x29, x29
0x10af249ec: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af249f0: mov      x20, x0
0x10af249f4: cbz      x0, #0x10af24d50
0x10af249f8: adrp     x8, #0x11ed4e000 ; classref CBTHalfScreenBizExcerptRoute
0x10af249fc: ldr      x0, [x8, #0xa20] ; classref CDirectSend | Class CDirectSend
0x10af24a00: bl       #0x10f85fb88 ; _objc_alloc_init
0x10af24a04: mov      x25, x0
0x10af24a08: adrp     x8, #0x11ec5a000 ; @selector(inviteReportInviteConfirmWithMembers:)
0x10af24a0c: ldr      x1, [x8, #0x238] ; @selector(Decode:) | 'Decode:'
0x10af24a10: mov      x2, x20
0x10af24a14: bl       #0x10f85fbe8 ; _objc_msgSend | selector=Decode:
0x10af24a18: cbz      w0, #0x10af24cd8
0x10af24a1c: adrp     x8, #0x11ec5a000 ; @selector(inviteReportInviteConfirmWithMembers:)
0x10af24a20: ldr      x1, [x8, #0x248] ; @selector(m_ucCmdID) | 'm_ucCmdID'
0x10af24a24: mov      x0, x25
0x10af24a28: bl       #0x10f85fbe8 ; _objc_msgSend | selector=m_ucCmdID
0x10af24a2c: cmp      w0, #0x6f
0x10af24a30: b.ne     #0x10af24cd8
0x10af24a34: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x10af24a38: ldr      x21, [x8, #0x2a0] ; @selector(m_dtData) | 'm_dtData'
0x10af24a3c: mov      x0, x25
0x10af24a40: mov      x1, x21 ; 'm_dtData'
0x10af24a44: bl       #0x10f85fbe8 ; _objc_msgSend | selector=m_dtData
0x10af24a48: mov      x29, x29
0x10af24a4c: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24a50: cbz      x0, #0x10af24cd8
0x10af24a54: mov      x22, x0
0x10af24a58: mov      x0, x25
0x10af24a5c: mov      x1, x21 ; 'm_dtData'
0x10af24a60: bl       #0x10f85fbe8 ; _objc_msgSend | selector=m_dtData
0x10af24a64: mov      x29, x29
0x10af24a68: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24a6c: mov      x23, x0
0x10af24a70: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x10af24a74: ldr      x1, [x8, #0xce8] ; @selector(length) | 'length'
0x10af24a78: bl       #0x10f85fbe8 ; _objc_msgSend | selector=length
0x10af24a7c: mov      x24, x0
0x10af24a80: mov      x0, x23
0x10af24a84: bl       #0x10f85fbf8 ; _objc_release
0x10af24a88: mov      x0, x22
0x10af24a8c: bl       #0x10f85fbf8 ; _objc_release
0x10af24a90: cmp      x24, #4
0x10af24a94: b.lo     #0x10af24cd8
0x10af24a98: mov      x0, x25
0x10af24a9c: mov      x1, x21 ; 'm_dtData'
0x10af24aa0: bl       #0x10f85fbe8 ; _objc_msgSend | selector=m_dtData
0x10af24aa4: mov      x29, x29
0x10af24aa8: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24aac: mov      x21, x0
0x10af24ab0: bl       #0x10f85fc04 ; _objc_retainAutorelease
0x10af24ab4: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af24ab8: ldr      x1, [x8, #0x1e0] ; @selector(bytes) | 'bytes'
0x10af24abc: bl       #0x10f85fbe8 ; _objc_msgSend | selector=bytes
0x10af24ac0: ldr      w19, [x0]
0x10af24ac4: mov      x0, x21
0x10af24ac8: bl       #0x10f85fbf8 ; _objc_release
0x10af24acc: adrp     x8, #0x11ec5a000 ; @selector(inviteReportInviteConfirmWithMembers:)
0x10af24ad0: ldr      x21, [x8, #0x250] ; @selector(m_nsUsrNameList) | 'm_nsUsrNameList'
0x10af24ad4: mov      x0, x25
0x10af24ad8: mov      x1, x21 ; 'm_nsUsrNameList'
0x10af24adc: bl       #0x10f85fbe8 ; _objc_msgSend | selector=m_nsUsrNameList
0x10af24ae0: mov      x29, x29
0x10af24ae4: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24ae8: mov      x22, x0
0x10af24aec: bl       #0x10f85fbf8 ; _objc_release
0x10af24af0: cbz      x22, #0x10af24cd8
0x10af24af4: mov      x0, x25
0x10af24af8: mov      x1, x21 ; 'm_nsUsrNameList'
0x10af24afc: bl       #0x10f85fbe8 ; _objc_msgSend | selector=m_nsUsrNameList
0x10af24b00: mov      x29, x29
0x10af24b04: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24b08: mov      x21, x0
0x10af24b0c: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af24b10: ldr      x1, [x8, #0x678] ; @selector(componentsSeparatedByString:) | 'componentsSeparatedByString:'
0x10af24b14: adrp     x2, #0x11cf9d000
0x10af24b18: add      x2, x2, #0x7d8 ; @','
0x10af24b1c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=componentsSeparatedByString:
0x10af24b20: mov      x29, x29
0x10af24b24: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24b28: mov      x22, x0
0x10af24b2c: mov      x0, x21
0x10af24b30: bl       #0x10f85fbf8 ; _objc_release
0x10af24b34: cbz      x22, #0x10af24cd0
0x10af24b38: stp      x25, x20, [sp, #0x18]
0x10af24b3c: str      x27, [sp, #0x28]
0x10af24b40: movi     v0.16b, #0
0x10af24b44: stp      q0, q0, [sp, #0x90]
0x10af24b48: stp      q0, q0, [sp, #0x70]
0x10af24b4c: mov      x0, x22
0x10af24b50: bl       #0x10f85fc00 ; _objc_retain
0x10af24b54: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af24b58: ldr      x1, [x8, #0x858] ; @selector(countByEnumeratingWithState:objects:count:) | 'countByEnumeratingWithState:objects:count:'
0x10af24b5c: add      x2, sp, #0x70
0x10af24b60: add      x3, sp, #0xd0
0x10af24b64: str      x1, [sp, #0x30] ; 'countByEnumeratingWithState:objects:count:'
0x10af24b68: mov      w4, #0x10
0x10af24b6c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=countByEnumeratingWithState:objects:count:
0x10af24b70: cbz      x0, #0x10af24cc0
0x10af24b74: mov      x24, x0
0x10af24b78: rev      w8, w19
0x10af24b7c: stp      x22, x8, [sp, #0x38]
0x10af24b80: ldr      x8, [sp, #0x80]
0x10af24b84: ldr      x19, [x8]
0x10af24b88: mov      x20, #0
0x10af24b8c: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x10af24b90: ldr      x28, [x8, #0xce8] ; @selector(length) | 'length'
0x10af24b94: adrp     x8, #0x11ecac000 ; @selector(setManager:)
0x10af24b98: ldr      x23, [x8, #0x290] ; @selector(setObject:forKey:) | 'setObject:forKey:'
0x10af24b9c: adrp     x8, #0x11ecad000 ; @selector(sharedApplication)
0x10af24ba0: ldr      x21, [x8, #0x5c8] ; @selector(stringWithFormat:) | 'stringWithFormat:'
0x10af24ba4: adrp     x8, #0x11e9d3000 ; @selector(deleteSearchableItemsWithDomainIdentifiers:completionHandler:)
0x10af24ba8: ldr      x25, [x8, #0xb68] ; @selector(getMainController) | 'getMainController'
0x10af24bac: adrp     x8, #0x11eb42000 ; @selector(setPolicyListLogic:)
0x10af24bb0: ldr      x26, [x8, #0xa90] ; @selector(NotifyFromEvent:Message:MessageInfo:) | 'NotifyFromEvent:Message:MessageInfo:'
0x10af24bb4: ldr      x8, [sp, #0x80]
0x10af24bb8: ldr      x8, [x8]
0x10af24bbc: cmp      x8, x19
0x10af24bc0: b.eq     #0x10af24bcc
0x10af24bc4: ldr      x0, [sp, #0x38]
0x10af24bc8: bl       #0x10f85fbb8 ; _objc_enumerationMutation
0x10af24bcc: ldr      x8, [sp, #0x78]
0x10af24bd0: ldr      x27, [x8, x20, lsl #3]
0x10af24bd4: mov      x0, x27
0x10af24bd8: mov      x1, x28 ; 'length'
0x10af24bdc: bl       #0x10f85fbe8 ; _objc_msgSend | selector=length
0x10af24be0: cbz      x0, #0x10af24c94
0x10af24be4: adrp     x8, #0x11ed12000
0x10af24be8: ldr      x0, [x8, #0x630] ; _OBJC_CLASS_$_NSMutableDictionary
0x10af24bec: bl       #0x10f85fb88 ; _objc_alloc_init
0x10af24bf0: mov      x22, x0
0x10af24bf4: mov      x1, x23 ; 'setObject:forKey:'
0x10af24bf8: mov      x2, x27
0x10af24bfc: adrp     x3, #0x11cfc1000
0x10af24c00: add      x3, x3, #0x238 ; @'5'
0x10af24c04: bl       #0x10f85fbe8 ; _objc_msgSend | selector=setObject:forKey:
0x10af24c08: adrp     x8, #0x11ed12000
0x10af24c0c: ldr      x0, [x8, #0x638] ; _OBJC_CLASS_$_NSString
0x10af24c10: ldr      x8, [sp, #0x40]
0x10af24c14: str      x8, [sp]
0x10af24c18: mov      x1, x21 ; 'stringWithFormat:'
0x10af24c1c: adrp     x2, #0x11cfa2000
0x10af24c20: add      x2, x2, #0xaf8 ; @'%u'
0x10af24c24: bl       #0x10f85fbe8 ; _objc_msgSend | selector=stringWithFormat:
0x10af24c28: mov      x29, x29
0x10af24c2c: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24c30: mov      x27, x0
0x10af24c34: mov      x0, x22
0x10af24c38: mov      x1, x23 ; 'setObject:forKey:'
0x10af24c3c: mov      x2, x27
0x10af24c40: adrp     x3, #0x11d184000
0x10af24c44: add      x3, x3, #0x5f8 ; @'44'
0x10af24c48: bl       #0x10f85fbe8 ; _objc_msgSend | selector=setObject:forKey:
0x10af24c4c: mov      x0, x27
0x10af24c50: bl       #0x10f85fbf8 ; _objc_release
0x10af24c54: adrp     x8, #0x11ed12000
0x10af24c58: ldr      x0, [x8, #0x840] ; classref CAppUtil | Class CAppUtil
0x10af24c5c: mov      x1, x25 ; 'getMainController'
0x10af24c60: bl       #0x10f85fbe8 ; _objc_msgSend | selector=getMainController
0x10af24c64: mov      x29, x29
0x10af24c68: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24c6c: mov      x27, x0
0x10af24c70: mov      x1, x26 ; 'NotifyFromEvent:Message:MessageInfo:'
0x10af24c74: mov      x2, #0
0x10af24c78: mov      w3, #0x4d
0x10af24c7c: mov      x4, x22
0x10af24c80: bl       #0x10f85fbe8 ; _objc_msgSend | selector=NotifyFromEvent:Message:MessageInfo:
0x10af24c84: mov      x0, x27
0x10af24c88: bl       #0x10f85fbf8 ; _objc_release
0x10af24c8c: mov      x0, x22
0x10af24c90: bl       #0x10f85fbf8 ; _objc_release
0x10af24c94: add      x20, x20, #1
0x10af24c98: cmp      x24, x20
0x10af24c9c: b.ne     #0x10af24bb4
0x10af24ca0: add      x2, sp, #0x70
0x10af24ca4: add      x3, sp, #0xd0
0x10af24ca8: ldp      x1, x22, [sp, #0x30]
0x10af24cac: mov      x0, x22
0x10af24cb0: mov      w4, #0x10
0x10af24cb4: bl       #0x10f85fbe8 ; _objc_msgSend
0x10af24cb8: mov      x24, x0
0x10af24cbc: cbnz     x0, #0x10af24b88
0x10af24cc0: mov      x0, x22
0x10af24cc4: bl       #0x10f85fbf8 ; _objc_release
0x10af24cc8: ldp      x20, x27, [sp, #0x20]
0x10af24ccc: ldr      x25, [sp, #0x18]
0x10af24cd0: mov      x0, x22
0x10af24cd4: bl       #0x10f85fbf8 ; _objc_release
0x10af24cd8: mov      x0, x25
0x10af24cdc: b        #0x10af249a4
0x10af24ce0: adrp     x8, #0x11ed12000
0x10af24ce4: ldr      x20, [x8, #0x6d8] ; _OBJC_CLASS_$_NSData
0x10af24ce8: mov      x0, x22
0x10af24cec: mov      x1, #0
0x10af24cf0: bl       #0x10f83d540
0x10af24cf4: mov      x21, x0
0x10af24cf8: mov      x0, x22
0x10af24cfc: bl       #0x10f83d544
0x10af24d00: mov      x3, x0
0x10af24d04: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af24d08: ldr      x1, [x8, #0xb90] ; @selector(dataWithBytes:length:) | 'dataWithBytes:length:'
0x10af24d0c: mov      x0, x20
0x10af24d10: mov      x2, x21
0x10af24d14: bl       #0x10f85fbe8 ; _objc_msgSend | selector=dataWithBytes:length:
0x10af24d18: mov      x29, x29
0x10af24d1c: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24d20: mov      x20, x0
0x10af24d24: adrp     x8, #0x11ed4e000 ; classref CBTHalfScreenBizExcerptRoute
0x10af24d28: ldr      x0, [x8, #0xa38] ; classref VoiceTransSyncHelper | Class VoiceTransSyncHelper
0x10af24d2c: adrp     x8, #0x11ec5a000 ; @selector(inviteReportInviteConfirmWithMembers:)
0x10af24d30: ldr      x1, [x8, #0x280] ; @selector(NotifyByServer:) | 'NotifyByServer:'
0x10af24d34: b        #0x10af24d48
0x10af24d38: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x10af24d3c: ldr      x0, [x8, #0xbe0] ; classref VOIPHelper | Class VOIPHelper
0x10af24d40: adrp     x8, #0x11ec5a000 ; @selector(inviteReportInviteConfirmWithMembers:)
0x10af24d44: ldr      x1, [x8, #0x260] ; @selector(DataNotifyWithData:) | 'DataNotifyWithData:'
0x10af24d48: mov      x2, x20
0x10af24d4c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=DataNotifyWithData:
0x10af24d50: mov      x0, x20
0x10af24d54: bl       #0x10f85fbf8 ; _objc_release
0x10af24d58: add      x0, sp, #0xb0
0x10af24d5c: bl       #0x10f83e4d8
0x10af24d60: mov      x0, x27
0x10af24d64: bl       #0x10f85fbf8 ; _objc_release
0x10af24d68: add      x0, sp, #0xc8
0x10af24d6c: bl       #0x10f83d568
0x10af24d70: ldur     x8, [x29, #-0x60]
0x10af24d74: adrp     x9, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x10af24d78: ldr      x9, [x9, #0xa30] ; ___stack_chk_guard
0x10af24d7c: ldr      x9, [x9]
0x10af24d80: cmp      x9, x8
0x10af24d84: b.ne     #0x10af25024
0x10af24d88: ldp      x29, x30, [sp, #0x1b0]
0x10af24d8c: ldp      x20, x19, [sp, #0x1a0]
0x10af24d90: ldp      x22, x21, [sp, #0x190]
0x10af24d94: ldp      x24, x23, [sp, #0x180]
0x10af24d98: ldp      x26, x25, [sp, #0x170] ; 'NotifyFromEvent:Message:MessageInfo:'
0x10af24d9c: ldp      x28, x27, [sp, #0x160] ; 'length'
0x10af24da0: add      sp, sp, #0x1c0
0x10af24da4: ret      
0x10af24da8: ldr      x0, [x26, #0x618] ; 'ickLongDescTextView'
0x10af24dac: adrp     x8, #0x11d5e0000
0x10af24db0: add      x8, x8, #0xf18 ; @'fail to decode voip security notify, try again'
0x10af24db4: str      x8, [sp] ; @'fail to decode voip security notify, try again'
0x10af24db8: adrp     x5, #0x11a7dc000 ; 'tTime'
0x10af24dbc: add      x5, x5, #0x97b ; 'stn_callback.mm'
0x10af24dc0: adrp     x7, #0x11a7db000 ; 'urePageReq'
0x10af24dc4: add      x7, x7, #0xbfd ; 'OnPush'
0x10af24dc8: mov      x1, x21
0x10af24dcc: mov      w2, #4
0x10af24dd0: mov      x3, #0
0x10af24dd4: mov      w4, #0
0x10af24dd8: mov      w6, #0xf0
0x10af24ddc: bl       #0x10f85fbe8 ; _objc_msgSend
0x10af24de0: mov      w0, #0x90
0x10af24de4: mov      w1, #0x65
0x10af24de8: mov      w2, #1
0x10af24dec: mov      w3, #0
0x10af24df0: mov      w4, #0
0x10af24df4: bl       #0x107c095b0
0x10af24df8: b        #0x10af24d50
0x10af24dfc: ldr      x24, [x19, #0x6d8]
0x10af24e00: mov      x0, x20
0x10af24e04: bl       #0x10f85fc04 ; _objc_retainAutorelease
0x10af24e08: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af24e0c: ldr      x1, [x8, #0x1e0] ; @selector(bytes) | 'bytes'
0x10af24e10: bl       #0x10f85fbe8 ; _objc_msgSend | selector=bytes
0x10af24e14: mov      x25, x0
0x10af24e18: mov      x0, x20
0x10af24e1c: mov      x1, x23 ; 'setObject:forKey:'
0x10af24e20: bl       #0x10f85fbe8 ; _objc_msgSend | selector=setObject:forKey:
0x10af24e24: sub      x3, x0, #1
0x10af24e28: add      x2, x25, #1
0x10af24e2c: mov      x0, x24
0x10af24e30: mov      x1, x22
0x10af24e34: bl       #0x10f85fbe8 ; _objc_msgSend
0x10af24e38: mov      x29, x29
0x10af24e3c: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24e40: mov      x22, x0
0x10af24e44: ldr      x0, [x19, #0x6d8]
0x10af24e48: bl       #0x10f85fb80 ; _objc_alloc
0x10af24e4c: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x10af24e50: ldr      x1, [x8, #0x140] ; @selector(initWithBase64EncodedData:options:) | 'initWithBase64EncodedData:options:'
0x10af24e54: mov      x2, x22
0x10af24e58: mov      w3, #1
0x10af24e5c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=initWithBase64EncodedData:options:
0x10af24e60: mov      x23, x0
0x10af24e64: adrp     x8, #0x11ed33000 ; classref VoIPInvitationWindow
0x10af24e68: ldr      x0, [x8, #0x780] ; classref VoIPMtInviteMsg | Class VoIPMtInviteMsg
0x10af24e6c: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x10af24e70: ldr      x1, [x8, #0x738] ; @selector(parseFromData:) | 'parseFromData:'
0x10af24e74: mov      x2, x23
0x10af24e78: bl       #0x10f85fbe8 ; _objc_msgSend | selector=parseFromData:
0x10af24e7c: mov      x29, x29
0x10af24e80: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24e84: mov      x24, x0
0x10af24e88: adrp     x8, #0x11ed12000
0x10af24e8c: ldr      x0, [x8, #0xe10] ; classref CMessageWrap | Class CMessageWrap
0x10af24e90: bl       #0x10f85fb80 ; _objc_alloc
0x10af24e94: adrp     x8, #0x11e9cc000 ; @selector(setCenterY:)
0x10af24e98: ldr      x1, [x8, #0xa60] ; @selector(initWithMsgType:) | 'initWithMsgType:'
0x10af24e9c: mov      w2, #0x32
0x10af24ea0: bl       #0x10f85fbe8 ; _objc_msgSend | selector=initWithMsgType:
0x10af24ea4: mov      x25, x0
0x10af24ea8: adrp     x8, #0x11e9d4000 ; @selector(isVoiceTranscriptionMatchedWithChatName:audioId:)
0x10af24eac: ldr      x1, [x8, #0x40] ; @selector(createtime) | 'createtime'
0x10af24eb0: mov      x0, x24
0x10af24eb4: bl       #0x10f85fbe8 ; _objc_msgSend | selector=createtime
0x10af24eb8: lsr      x8, x0, #3
0x10af24ebc: mov      x9, #0xf7cf
0x10af24ec0: movk     x9, #0xe353, lsl #16
0x10af24ec4: movk     x9, #0x9ba5, lsl #32
0x10af24ec8: movk     x9, #0x20c4, lsl #48
0x10af24ecc: umulh    x8, x8, x9
0x10af24ed0: lsr      x2, x8, #4
0x10af24ed4: adrp     x8, #0x11e9cc000 ; @selector(setCenterY:)
0x10af24ed8: ldr      x1, [x8, #0xa98] ; @selector(setM_uiCreateTime:) | 'setM_uiCreateTime:'
0x10af24edc: mov      x0, x25
0x10af24ee0: bl       #0x10f85fbe8 ; _objc_msgSend | selector=setM_uiCreateTime:
0x10af24ee4: ldr      x26, [x26, #0x618] ; 'ickLongDescTextView'
0x10af24ee8: adrp     x8, #0x11e9df000 ; @selector(exitTracking)
0x10af24eec: ldr      x1, [x8, #0x6d8] ; @selector(roomid) | 'roomid'
0x10af24ef0: mov      x0, x24
0x10af24ef4: bl       #0x10f85fbe8 ; _objc_msgSend | selector=roomid
0x10af24ef8: mov      x19, x27
0x10af24efc: mov      x27, x0
0x10af24f00: adrp     x8, #0x11e9ce000 ; @selector(onAddMsg:roomID:)
0x10af24f04: ldr      x1, [x8, #0x80] ; @selector(debugDescription) | 'debugDescription'
0x10af24f08: mov      x0, x24
0x10af24f0c: bl       #0x10f85fbe8 ; _objc_msgSend | selector=debugDescription
0x10af24f10: mov      x29, x29
0x10af24f14: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24f18: mov      x28, x0
0x10af24f1c: stp      x27, x0, [sp, #8]
0x10af24f20: adrp     x8, #0x11d5e0000
0x10af24f24: add      x8, x8, #0xeb8 ; @'[voip-ilink] Get invitenotify ok.: roomID(%llu) %@'
0x10af24f28: str      x8, [sp] ; @'[voip-ilink] Get invitenotify ok.: roomID(%llu) %@'
0x10af24f2c: adrp     x5, #0x11a7dc000 ; 'tTime'
0x10af24f30: add      x5, x5, #0x97b ; 'stn_callback.mm'
0x10af24f34: adrp     x7, #0x11a7db000 ; 'urePageReq'
0x10af24f38: add      x7, x7, #0xbfd ; 'OnPush'
0x10af24f3c: mov      x0, x26
0x10af24f40: mov      x1, x21
0x10af24f44: mov      w2, #2
0x10af24f48: mov      x3, #0
0x10af24f4c: mov      w4, #0
0x10af24f50: mov      w6, #0xc2
0x10af24f54: bl       #0x10f85fbe8 ; _objc_msgSend
0x10af24f58: mov      x0, x28
0x10af24f5c: bl       #0x10f85fbf8 ; _objc_release
0x10af24f60: adrp     x8, #0x11ed12000
0x10af24f64: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x10af24f68: adrp     x8, #0x11e9c9000
0x10af24f6c: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x10af24f70: bl       #0x10f85fbe8 ; _objc_msgSend | selector=currentContext
0x10af24f74: mov      x29, x29
0x10af24f78: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24f7c: mov      x21, x0
0x10af24f80: adrp     x8, #0x11ed12000
0x10af24f84: ldr      x0, [x8, #0x9f8] ; classref VoIPilinkMgr | Class VoIPilinkMgr
0x10af24f88: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10af24f8c: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x10af24f90: bl       #0x10f85fbe8 ; _objc_msgSend | selector=class
0x10af24f94: mov      x2, x0
0x10af24f98: adrp     x8, #0x11e9c9000
0x10af24f9c: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x10af24fa0: mov      x0, x21
0x10af24fa4: bl       #0x10f85fbe8 ; _objc_msgSend | selector=getService:
0x10af24fa8: mov      x29, x29
0x10af24fac: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24fb0: mov      x26, x0
0x10af24fb4: adrp     x8, #0x11ea57000 ; @selector(onHeadImgDoubleClick)
0x10af24fb8: ldr      x1, [x8, #0x660] ; @selector(fromUsername) | 'fromUsername'
0x10af24fbc: mov      x0, x24
0x10af24fc0: bl       #0x10f85fbe8 ; _objc_msgSend | selector=fromUsername
0x10af24fc4: mov      x29, x29
0x10af24fc8: bl       #0x10f85fc0c ; _objc_retainAutoreleasedReturnValue
0x10af24fcc: mov      x27, x0
0x10af24fd0: adrp     x8, #0x11ec5a000 ; @selector(inviteReportInviteConfirmWithMembers:)
0x10af24fd4: ldr      x1, [x8, #0x268] ; @selector(HandleVoIPNotifyForIlink:username:MsgWrap:) | 'HandleVoIPNotifyForIlink:username:MsgWrap:'
0x10af24fd8: mov      x0, x26
0x10af24fdc: mov      x2, x24
0x10af24fe0: mov      x3, x27
0x10af24fe4: mov      x4, x25
0x10af24fe8: bl       #0x10f85fbe8 ; _objc_msgSend | selector=HandleVoIPNotifyForIlink:username:MsgWrap:
0x10af24fec: mov      x0, x27
0x10af24ff0: mov      x27, x19
0x10af24ff4: bl       #0x10f85fbf8 ; _objc_release
0x10af24ff8: mov      x0, x26
0x10af24ffc: bl       #0x10f85fbf8 ; _objc_release
0x10af25000: mov      x0, x21
0x10af25004: bl       #0x10f85fbf8 ; _objc_release
0x10af25008: mov      x0, x25
0x10af2500c: bl       #0x10f85fbf8 ; _objc_release
0x10af25010: mov      x0, x24
0x10af25014: bl       #0x10f85fbf8 ; _objc_release
0x10af25018: mov      x0, x23
0x10af2501c: bl       #0x10f85fbf8 ; _objc_release
0x10af25020: b        #0x10af2483c
0x10af25024: bl       #0x10f85f1f4 ; ___stack_chk_fail
