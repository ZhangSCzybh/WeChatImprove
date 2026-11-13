-[NewSyncService HandleSyncResp:handleResult:] 0x105463a48 v28@0:8@16B24
0x105463a48: sub      sp, sp, #0xc0
0x105463a4c: stp      x28, x27, [sp, #0x60]
0x105463a50: stp      x26, x25, [sp, #0x70]
0x105463a54: stp      x24, x23, [sp, #0x80]
0x105463a58: stp      x22, x21, [sp, #0x90]
0x105463a5c: stp      x20, x19, [sp, #0xa0]
0x105463a60: stp      x29, x30, [sp, #0xb0]
0x105463a64: add      x29, sp, #0xb0
0x105463a68: mov      x21, x3
0x105463a6c: mov      x19, x2
0x105463a70: mov      x20, x0
0x105463a74: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105463a78: ldr      x8, [x8, #0xa30] ; ___stack_chk_guard
0x105463a7c: ldr      x8, [x8]
0x105463a80: str      x8, [sp, #0x58]
0x105463a84: adrp     x8, #0x11f753000
0x105463a88: mov      w9, #1
0x105463a8c: strb     w9, [x8, #0x47f]
0x105463a90: mov      x0, x2
0x105463a94: bl       #0x107c27c74 ; _objc_retain
0x105463a98: adrp     x8, #0x11ed12000
0x105463a9c: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105463aa0: adrp     x8, #0x11e9c9000
0x105463aa4: ldr      x25, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105463aa8: mov      x1, x25 ; 'currentContext'
0x105463aac: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105463ab0: mov      x29, x29
0x105463ab4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105463ab8: mov      x22, x0
0x105463abc: adrp     x8, #0x11e9cc000 ; @selector(setCenterY:)
0x105463ac0: ldr      x1, [x8, #0xa70] ; @selector(userName) | 'userName'
0x105463ac4: bl       #0x107c27c64 ; _objc_msgSend | selector=userName
0x105463ac8: mov      x29, x29
0x105463acc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105463ad0: mov      x23, x0
0x105463ad4: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105463ad8: ldr      x24, [x8, #0xce8] ; @selector(length) | 'length'
0x105463adc: mov      x1, x24 ; 'length'
0x105463ae0: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105463ae4: mov      x26, x0
0x105463ae8: mov      x0, x23
0x105463aec: bl       #0x107c27c70 ; _objc_release
0x105463af0: mov      x0, x22
0x105463af4: bl       #0x107c27c70 ; _objc_release
0x105463af8: cbz      x26, #0x105463d44
0x105463afc: mov      x0, x20
0x105463b00: bl       #0x107c27c74 ; _objc_retain
0x105463b04: bl       #0x107c27ca4 ; _objc_sync_enter
0x105463b08: adrp     x8, #0x11edca000
0x105463b0c: ldrsw    x8, [x8, #0x8d8] ; ivar_offset NewSyncService.m_bHasInit=0x8
0x105463b10: ldrb     w8, [x20, x8]
0x105463b14: tbz      w8, #0, #0x105463dcc
0x105463b18: mov      x0, x20
0x105463b1c: bl       #0x107c27ca8 ; _objc_sync_exit
0x105463b20: mov      x0, x20
0x105463b24: bl       #0x107c27c70 ; _objc_release
0x105463b28: adrp     x8, #0x11e9da000 ; @selector(scrollableFinderCellViewOnValidShowItems:)
0x105463b2c: ldr      x1, [x8, #0x700] ; @selector(continueFlag) | 'continueFlag'
0x105463b30: mov      x0, x19
0x105463b34: bl       #0x107c27c64 ; _objc_msgSend | selector=continueFlag
0x105463b38: mov      x23, x0
0x105463b3c: adrp     x8, #0x11ea4d000 ; @selector(ConvertImg2MsgWrap:)
0x105463b40: ldr      x1, [x8, #0x528] ; @selector(keyBuf) | 'keyBuf'
0x105463b44: mov      x0, x19
0x105463b48: bl       #0x107c27c64 ; _objc_msgSend | selector=keyBuf
0x105463b4c: mov      x29, x29
0x105463b50: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105463b54: mov      x26, x0
0x105463b58: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x105463b5c: ldr      x1, [x8, #0x388] ; @selector(buffer) | 'buffer'
0x105463b60: bl       #0x107c27c64 ; _objc_msgSend | selector=buffer
0x105463b64: mov      x29, x29
0x105463b68: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105463b6c: mov      x22, x0
0x105463b70: mov      x0, x26
0x105463b74: bl       #0x107c27c70 ; _objc_release
0x105463b78: stp      xzr, xzr, [sp, #0x40]
0x105463b7c: str      xzr, [sp, #0x50]
0x105463b80: mov      x0, x22
0x105463b84: bl       #0x107c27c78 ; _objc_retainAutorelease
0x105463b88: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105463b8c: ldr      x1, [x8, #0x1e0] ; @selector(bytes) | 'bytes'
0x105463b90: bl       #0x107c27c64 ; _objc_msgSend | selector=bytes
0x105463b94: mov      x26, x0
0x105463b98: mov      x0, x22
0x105463b9c: mov      x1, x24 ; 'length'
0x105463ba0: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105463ba4: mov      x2, x0
0x105463ba8: add      x0, sp, #0x40
0x105463bac: mov      x1, x26
0x105463bb0: bl       #0x107c0cce4
0x105463bb4: adrp     x8, #0x11ed12000
0x105463bb8: ldr      x24, [x8, #0x638] ; _OBJC_CLASS_$_NSString
0x105463bbc: add      x26, sp, #0x28
0x105463bc0: add      x8, sp, #0x28
0x105463bc4: add      x0, sp, #0x40
0x105463bc8: bl       #0x107c0ccdc
0x105463bcc: ldrsb    w8, [sp, #0x3f]
0x105463bd0: ldr      x9, [sp, #0x28]
0x105463bd4: cmp      w8, #0
0x105463bd8: csel     x2, x9, x26, lt
0x105463bdc: adrp     x8, #0x11ecad000 ; @selector(sharedApplication)
0x105463be0: ldr      x1, [x8, #0x5d8] ; @selector(stringWithUTF8String:) | 'stringWithUTF8String:'
0x105463be4: mov      x0, x24
0x105463be8: bl       #0x107c27c64 ; _objc_msgSend | selector=stringWithUTF8String:
0x105463bec: mov      x29, x29
0x105463bf0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105463bf4: mov      x24, x0
0x105463bf8: ldrsb    w8, [sp, #0x3f]
0x105463bfc: tbz      w8, #0x1f, #0x105463c10
0x105463c00: ldr      x0, [sp, #0x28]
0x105463c04: ldr      x8, [sp, #0x38]
0x105463c08: and      x1, x8, #0x7fffffffffffffff
0x105463c0c: bl       #0x107c276f0 ; __ZdlPvm
0x105463c10: str      x24, [sp, #0x20]
0x105463c14: cbz      w21, #0x105463c28
0x105463c18: cbnz     w23, #0x105463c28
0x105463c1c: adrp     x8, #0x11edca000
0x105463c20: ldrsw    x8, [x8, #0x914] ; ivar_offset NewSyncService.m_bFirstSyncAfterBgfgChange=0x56
0x105463c24: strb     wzr, [x20, x8]
0x105463c28: eor      w28, w21, #1
0x105463c2c: adrp     x8, #0x11edca000
0x105463c30: ldrsw    x8, [x8, #0x910] ; ivar_offset NewSyncService.m_bSyncOpError=0x4a
0x105463c34: strb     w28, [x20, x8]
0x105463c38: adrp     x8, #0x11edca000
0x105463c3c: ldrsw    x8, [x8, #0x920] ; ivar_offset NewSyncService.m_bSyncOperating=0x4b
0x105463c40: strb     wzr, [x20, x8]
0x105463c44: adrp     x8, #0x11ed12000
0x105463c48: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105463c4c: adrp     x8, #0x11e9c9000
0x105463c50: ldr      x26, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105463c54: stp      x21, x23, [sp, #8]
0x105463c58: adrp     x8, #0x11d2f6000
0x105463c5c: add      x8, x8, #0xf58 ; @'newsync service handle sync resp ret %u continueflag %u'
0x105463c60: str      x8, [sp] ; @'newsync service handle sync resp ret %u continueflag %u'
0x105463c64: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105463c68: add      x3, x3, #0xfaf ; 'Sync'
0x105463c6c: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105463c70: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105463c74: adrp     x7, #0x11a21f000 ; 'llu,%llu'
0x105463c78: add      x7, x7, #0xfe2 ; '-[NewSyncService HandleSyncResp:handleResult:]'
0x105463c7c: mov      x1, x26 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105463c80: mov      w2, #2
0x105463c84: mov      w4, #0
0x105463c88: mov      w6, #0x26d
0x105463c8c: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105463c90: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105463c94: ldr      x27, [x8, #0xa78] ; @selector(NeedNewSync:) | 'NeedNewSync:'
0x105463c98: adrp     x24, #0x11ed12000
0x105463c9c: tbnz     w28, #0, #0x105463e60
0x105463ca0: ldr      x0, [x24, #0x8a0] ; classref CUtility | Class CUtility
0x105463ca4: mov      x1, x27 ; 'NeedNewSync:'
0x105463ca8: mov      x2, x23
0x105463cac: bl       #0x107c27c64 ; _objc_msgSend | selector=NeedNewSync:
0x105463cb0: cbz      w0, #0x105463e60
0x105463cb4: adrp     x8, #0x11edca000
0x105463cb8: ldrsw    x28, [x8, #0x8fc] ; ivar_offset NewSyncService.m_uiSyncContinueCount=0x14
0x105463cbc: ldr      w8, [x20, x28]
0x105463cc0: cmp      w8, #9
0x105463cc4: b.hi     #0x105463e60
0x105463cc8: adrp     x8, #0x11edca000
0x105463ccc: ldrsw    x8, [x8, #0x8d4] ; ivar_offset NewSyncService.m_bNeedSync=0x57
0x105463cd0: mov      w9, #1
0x105463cd4: strb     w9, [x20, x8]
0x105463cd8: mov      x0, x20
0x105463cdc: bl       #0x107c27c74 ; _objc_retain
0x105463ce0: bl       #0x107c27ca4 ; _objc_sync_enter
0x105463ce4: adrp     x8, #0x11edca000
0x105463ce8: ldrsw    x8, [x8, #0x8f8] ; ivar_offset NewSyncService.m_uiSyncScene=0x10
0x105463cec: mov      w9, #6
0x105463cf0: str      w9, [x20, x8]
0x105463cf4: mov      x0, x20
0x105463cf8: bl       #0x107c27ca8 ; _objc_sync_exit
0x105463cfc: mov      x0, x20
0x105463d00: bl       #0x107c27c70 ; _objc_release
0x105463d04: adrp     x8, #0x11edca000
0x105463d08: ldrsw    x21, [x8, #0x924] ; ivar_offset NewSyncService.m_lastSyncKeyMd5=0x18
0x105463d0c: ldr      x0, [x20, x21]
0x105463d10: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105463d14: ldr      x1, [x8, #0x7b8] ; @selector(isEqualToString:) | 'isEqualToString:'
0x105463d18: ldr      x24, [sp, #0x20]
0x105463d1c: mov      x2, x24
0x105463d20: bl       #0x107c27c64 ; _objc_msgSend | selector=isEqualToString:
0x105463d24: cbz      w0, #0x105463d34
0x105463d28: ldr      w8, [x20, x28]
0x105463d2c: add      w8, w8, #1
0x105463d30: str      w8, [x20, x28]
0x105463d34: add      x0, x20, x21
0x105463d38: mov      x1, x24
0x105463d3c: bl       #0x107c27c9c ; _objc_storeStrong
0x105463d40: b        #0x105463fd8
0x105463d44: adrp     x8, #0x11ed12000
0x105463d48: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105463d4c: adrp     x8, #0x11e9c9000
0x105463d50: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105463d54: adrp     x8, #0x11d2f6000
0x105463d58: add      x8, x8, #0x998 ; @'invalid setting info, username is nil'
0x105463d5c: str      x8, [sp] ; @'invalid setting info, username is nil'
0x105463d60: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105463d64: add      x3, x3, #0xfaf ; 'Sync'
0x105463d68: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105463d6c: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105463d70: adrp     x7, #0x11a21f000 ; 'llu,%llu'
0x105463d74: add      x7, x7, #0xfe2 ; '-[NewSyncService HandleSyncResp:handleResult:]'
0x105463d78: mov      w2, #3
0x105463d7c: mov      w4, #0
0x105463d80: mov      w6, #0x24e
0x105463d84: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105463d88: mov      w0, #0x90
0x105463d8c: mov      w1, #5
0x105463d90: mov      w2, #1
0x105463d94: mov      w3, #0
0x105463d98: mov      w4, #0
0x105463d9c: bl       #0x1020ea20c
0x105463da0: adrp     x1, #0x11d2f6000
0x105463da4: add      x1, x1, #0x9b8 ; @'5,0'
0x105463da8: mov      w0, #0x8ab9
0x105463dac: mov      w2, #0
0x105463db0: mov      w3, #0
0x105463db4: bl       #0x10241a0cc
0x105463db8: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105463dbc: ldr      x1, [x8, #0xaa0] ; @selector(resetGettingData) | 'resetGettingData'
0x105463dc0: mov      x0, x20
0x105463dc4: bl       #0x107c27c64 ; _objc_msgSend | selector=resetGettingData
0x105463dc8: b        #0x105464014
0x105463dcc: adrp     x8, #0x11ed12000
0x105463dd0: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105463dd4: adrp     x8, #0x11e9c9000
0x105463dd8: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105463ddc: adrp     x8, #0x11d2f6000
0x105463de0: add      x8, x8, #0xcf8 ; @'newsync service has not be initted'
0x105463de4: str      x8, [sp] ; @'newsync service has not be initted'
0x105463de8: adrp     x3, #0x119bc2000 ; 'Contact: %d'
0x105463dec: add      x3, x3, #0x5b ; 'Net'
0x105463df0: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105463df4: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105463df8: adrp     x7, #0x11a21f000 ; 'llu,%llu'
0x105463dfc: add      x7, x7, #0xfe2 ; '-[NewSyncService HandleSyncResp:handleResult:]'
0x105463e00: mov      w2, #3
0x105463e04: mov      w4, #0
0x105463e08: mov      w6, #0x257
0x105463e0c: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105463e10: mov      w0, #0x90
0x105463e14: mov      w1, #6
0x105463e18: mov      w2, #1
0x105463e1c: mov      w3, #0
0x105463e20: mov      w4, #0
0x105463e24: bl       #0x1020ea20c
0x105463e28: adrp     x1, #0x11d2f6000
0x105463e2c: add      x1, x1, #0xf38 ; @'6,0'
0x105463e30: mov      w0, #0x8ab9
0x105463e34: mov      w2, #0
0x105463e38: mov      w3, #0
0x105463e3c: bl       #0x10241a0cc
0x105463e40: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105463e44: ldr      x1, [x8, #0xaa0] ; @selector(resetGettingData) | 'resetGettingData'
0x105463e48: mov      x0, x20
0x105463e4c: bl       #0x107c27c64 ; _objc_msgSend | selector=resetGettingData
0x105463e50: mov      x0, x20
0x105463e54: bl       #0x107c27ca8 ; _objc_sync_exit
0x105463e58: mov      x0, x20
0x105463e5c: b        #0x105464010
0x105463e60: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105463e64: ldr      x1, [x8, #0xaa0] ; @selector(resetGettingData) | 'resetGettingData'
0x105463e68: mov      x0, x20
0x105463e6c: bl       #0x107c27c64 ; _objc_msgSend | selector=resetGettingData
0x105463e70: ldr      x0, [x24, #0x8a0]
0x105463e74: mov      x1, x27 ; 'NeedNewSync:'
0x105463e78: mov      x2, x23
0x105463e7c: bl       #0x107c27c64 ; _objc_msgSend | selector=NeedNewSync:
0x105463e80: cbz      w0, #0x105463f3c
0x105463e84: adrp     x8, #0x11ed12000
0x105463e88: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105463e8c: adrp     x8, #0x11d2f6000
0x105463e90: add      x8, x8, #0xf78 ; @'!!!!!!!something wrong!!!!!!'
0x105463e94: str      x8, [sp] ; @'!!!!!!!something wrong!!!!!!'
0x105463e98: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105463e9c: add      x3, x3, #0xfaf ; 'Sync'
0x105463ea0: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105463ea4: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105463ea8: adrp     x7, #0x11a21f000 ; 'llu,%llu'
0x105463eac: add      x7, x7, #0xfe2 ; '-[NewSyncService HandleSyncResp:handleResult:]'
0x105463eb0: mov      x1, x26 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105463eb4: mov      w2, #4
0x105463eb8: mov      w4, #0
0x105463ebc: mov      w6, #0x27d
0x105463ec0: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105463ec4: mov      w0, #0x90
0x105463ec8: mov      w1, #8
0x105463ecc: mov      w2, #1
0x105463ed0: mov      w3, #0
0x105463ed4: mov      w4, #0
0x105463ed8: bl       #0x1020ea20c
0x105463edc: adrp     x1, #0x11d2f6000
0x105463ee0: add      x1, x1, #0xf98 ; @'8,0'
0x105463ee4: mov      w0, #0x8ab9
0x105463ee8: mov      w2, #0
0x105463eec: mov      w3, #0
0x105463ef0: bl       #0x10241a0cc
0x105463ef4: adrp     x8, #0x11ed12000
0x105463ef8: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105463efc: mov      x1, x25 ; 'currentContext'
0x105463f00: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105463f04: mov      x29, x29
0x105463f08: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105463f0c: mov      x25, x0
0x105463f10: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105463f14: ldr      x2, [x8, #0x760]
0x105463f18: adrp     x8, #0x11eb36000 ; @selector(subscribeConnectedEvent:eventBlock:)
0x105463f1c: ldr      x3, [x8, #0x218] ; @selector(onNewSyncEnd) | 'onNewSyncEnd'
0x105463f20: adrp     x8, #0x11e9c9000
0x105463f24: ldr      x1, [x8, #0xe58] ; @selector(callExtension:selector:block:) | 'callExtension:selector:block:'
0x105463f28: adrp     x4, #0x11c2fd000
0x105463f2c: add      x4, x4, #0xf08 ; __NSConcreteGlobalBlock
0x105463f30: bl       #0x107c27c64 ; _objc_msgSend | selector=callExtension:selector:block:
0x105463f34: mov      x0, x25
0x105463f38: bl       #0x107c27c70 ; _objc_release
0x105463f3c: mov      x0, x20
0x105463f40: bl       #0x107c27c74 ; _objc_retain
0x105463f44: bl       #0x107c27ca4 ; _objc_sync_enter
0x105463f48: adrp     x8, #0x11edca000
0x105463f4c: ldrsw    x24, [x8, #0x8f8] ; ivar_offset NewSyncService.m_uiSyncScene=0x10
0x105463f50: ldr      w8, [x20, x24]
0x105463f54: cmp      w8, #6
0x105463f58: b.ne     #0x105463fa0
0x105463f5c: adrp     x8, #0x11ed12000
0x105463f60: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105463f64: adrp     x8, #0x11d2f6000
0x105463f68: add      x8, x8, #0xfb8 ; @'reset sync scene'
0x105463f6c: str      x8, [sp] ; @'reset sync scene'
0x105463f70: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105463f74: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105463f78: adrp     x7, #0x11a21f000 ; 'llu,%llu'
0x105463f7c: add      x7, x7, #0xfe2 ; '-[NewSyncService HandleSyncResp:handleResult:]'
0x105463f80: mov      x1, x26 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105463f84: mov      w2, #2
0x105463f88: mov      x3, #0
0x105463f8c: mov      w4, #0
0x105463f90: mov      w6, #0x285
0x105463f94: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105463f98: mov      w8, #7
0x105463f9c: str      w8, [x20, x24]
0x105463fa0: mov      x0, x20
0x105463fa4: bl       #0x107c27ca8 ; _objc_sync_exit
0x105463fa8: mov      x0, x20
0x105463fac: bl       #0x107c27c70 ; _objc_release
0x105463fb0: adrp     x8, #0x11edca000
0x105463fb4: ldrsw    x8, [x8, #0x8fc] ; ivar_offset NewSyncService.m_uiSyncContinueCount=0x14
0x105463fb8: str      wzr, [x20, x8]
0x105463fbc: adrp     x8, #0x11edca000
0x105463fc0: ldrsw    x8, [x8, #0x924] ; ivar_offset NewSyncService.m_lastSyncKeyMd5=0x18
0x105463fc4: add      x0, x20, x8
0x105463fc8: ldr      x24, [sp, #0x20]
0x105463fcc: mov      x1, x24
0x105463fd0: bl       #0x107c27c9c ; _objc_storeStrong
0x105463fd4: cbz      w21, #0x105463ffc
0x105463fd8: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105463fdc: ldr      x1, [x8, #0xc40] ; @selector(GetSelector) | 'GetSelector'
0x105463fe0: mov      x0, x20
0x105463fe4: bl       #0x107c27c64 ; _objc_msgSend | selector=GetSelector
0x105463fe8: adrp     x8, #0x11eb37000 ; @selector(handlePageSheetEdgeAction:)
0x105463fec: ldr      x1, [x8, #0xfc8] ; @selector(SetSelector:) | 'SetSelector:'
0x105463ff0: orr      w2, w0, w23
0x105463ff4: mov      x0, x20
0x105463ff8: bl       #0x107c27c64 ; _objc_msgSend | selector=SetSelector:
0x105463ffc: mov      x0, x24
0x105464000: bl       #0x107c27c70 ; _objc_release
0x105464004: add      x0, sp, #0x40
0x105464008: bl       #0x107c0ccd8
0x10546400c: mov      x0, x22
0x105464010: bl       #0x107c27c70 ; _objc_release
0x105464014: mov      x0, x19
0x105464018: bl       #0x107c27c70 ; _objc_release
0x10546401c: ldr      x8, [sp, #0x58]
0x105464020: adrp     x9, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105464024: ldr      x9, [x9, #0xa30] ; ___stack_chk_guard
0x105464028: ldr      x9, [x9]
0x10546402c: cmp      x9, x8
0x105464030: b.ne     #0x105464054
0x105464034: ldp      x29, x30, [sp, #0xb0]
0x105464038: ldp      x20, x19, [sp, #0xa0]
0x10546403c: ldp      x22, x21, [sp, #0x90]
0x105464040: ldp      x24, x23, [sp, #0x80]
0x105464044: ldp      x26, x25, [sp, #0x70] ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105464048: ldp      x28, x27, [sp, #0x60]
0x10546404c: add      sp, sp, #0xc0
0x105464050: ret      
0x105464054: bl       #0x107c27730 ; ___stack_chk_fail
