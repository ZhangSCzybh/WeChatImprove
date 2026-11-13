-[SendPatMgr OnGetNewXmlMsg:Type:MsgWrap:] 0x105a9bc80 v40@0:8@16@24@32
0x105a9bc80: sub      sp, sp, #0x130
0x105a9bc84: stp      x28, x27, [sp, #0xd0]
0x105a9bc88: stp      x26, x25, [sp, #0xe0]
0x105a9bc8c: stp      x24, x23, [sp, #0xf0]
0x105a9bc90: stp      x22, x21, [sp, #0x100]
0x105a9bc94: stp      x20, x19, [sp, #0x110]
0x105a9bc98: stp      x29, x30, [sp, #0x120]
0x105a9bc9c: add      x29, sp, #0x120
0x105a9bca0: mov      x19, x4
0x105a9bca4: mov      x22, x3
0x105a9bca8: mov      x21, x0
0x105a9bcac: adrp     x8, #0x11f754000
0x105a9bcb0: mov      w9, #1
0x105a9bcb4: strb     w9, [x8, #0xb9d]
0x105a9bcb8: mov      x0, x4
0x105a9bcbc: bl       #0x107c27c74 ; _objc_retain
0x105a9bcc0: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105a9bcc4: ldr      x20, [x8, #0x7b8] ; @selector(isEqualToString:) | 'isEqualToString:'
0x105a9bcc8: adrp     x2, #0x11d333000
0x105a9bccc: add      x2, x2, #0x38 ; @'pat'
0x105a9bcd0: mov      x0, x22
0x105a9bcd4: mov      x1, x20 ; 'isEqualToString:'
0x105a9bcd8: bl       #0x107c27c64 ; _objc_msgSend | selector=isEqualToString:
0x105a9bcdc: cbz      w0, #0x105a9be20
0x105a9bce0: adrp     x8, #0x11ea1a000 ; @selector(isMediaGroupFirstDisplayMsg:)
0x105a9bce4: ldr      x1, [x8, #0x130] ; @selector(canSendPat) | 'canSendPat'
0x105a9bce8: mov      x0, x21
0x105a9bcec: bl       #0x107c27c64 ; _objc_msgSend | selector=canSendPat
0x105a9bcf0: tbz      w0, #0, #0x105a9bde0
0x105a9bcf4: adrp     x8, #0x11ed12000
0x105a9bcf8: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105a9bcfc: adrp     x8, #0x11e9c9000
0x105a9bd00: ldr      x26, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105a9bd04: mov      x1, x26 ; 'currentContext'
0x105a9bd08: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105a9bd0c: mov      x29, x29
0x105a9bd10: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9bd14: mov      x23, x0
0x105a9bd18: adrp     x8, #0x11ed12000
0x105a9bd1c: ldr      x0, [x8, #0xc20] ; classref CMessageMgr | Class CMessageMgr
0x105a9bd20: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105a9bd24: ldr      x27, [x8, #0x508] ; @selector(class) | 'class'
0x105a9bd28: mov      x1, x27 ; 'class'
0x105a9bd2c: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x105a9bd30: mov      x2, x0
0x105a9bd34: adrp     x8, #0x11e9c9000
0x105a9bd38: ldr      x28, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x105a9bd3c: mov      x0, x23
0x105a9bd40: mov      x1, x28 ; 'getService:'
0x105a9bd44: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x105a9bd48: mov      x29, x29
0x105a9bd4c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9bd50: mov      x24, x0
0x105a9bd54: adrp     x8, #0x11e9cc000 ; @selector(setCenterY:)
0x105a9bd58: ldr      x22, [x8, #0xfd0] ; @selector(m_n64MesSvrID) | 'm_n64MesSvrID'
0x105a9bd5c: mov      x0, x19
0x105a9bd60: mov      x1, x22 ; 'm_n64MesSvrID'
0x105a9bd64: bl       #0x107c27c64 ; _objc_msgSend | selector=m_n64MesSvrID
0x105a9bd68: mov      x2, x0
0x105a9bd6c: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a9bd70: ldr      x1, [x8, #0x438] ; @selector(GetRevokeMsgBySvrId:) | 'GetRevokeMsgBySvrId:'
0x105a9bd74: mov      x0, x24
0x105a9bd78: bl       #0x107c27c64 ; _objc_msgSend | selector=GetRevokeMsgBySvrId:
0x105a9bd7c: mov      x29, x29
0x105a9bd80: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9bd84: mov      x25, x0
0x105a9bd88: bl       #0x107c27c70 ; _objc_release
0x105a9bd8c: mov      x0, x24
0x105a9bd90: bl       #0x107c27c70 ; _objc_release
0x105a9bd94: mov      x0, x23
0x105a9bd98: bl       #0x107c27c70 ; _objc_release
0x105a9bd9c: cbz      x25, #0x105a9be48
0x105a9bda0: adrp     x8, #0x11ed12000
0x105a9bda4: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105a9bda8: adrp     x8, #0x11e9c9000
0x105a9bdac: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a9bdb0: adrp     x8, #0x11d333000
0x105a9bdb4: add      x8, x8, #0x78 ; @'found message in revoke table, pat message already been revoked'
0x105a9bdb8: str      x8, [sp] ; @'found message in revoke table, pat message already been revoked'
0x105a9bdbc: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9bdc0: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9bdc4: adrp     x7, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9bdc8: add      x7, x7, #0xb1d ; '-[SendPatMgr OnGetNewXmlMsg:Type:MsgWrap:]'
0x105a9bdcc: mov      w2, #2
0x105a9bdd0: mov      x3, #0
0x105a9bdd4: mov      w4, #0
0x105a9bdd8: mov      w6, #0x721
0x105a9bddc: b        #0x105a9be1c
0x105a9bde0: adrp     x8, #0x11ed12000
0x105a9bde4: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105a9bde8: adrp     x8, #0x11e9c9000
0x105a9bdec: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a9bdf0: adrp     x8, #0x11d333000
0x105a9bdf4: add      x8, x8, #0x58 ; @'can not add pat message due to config'
0x105a9bdf8: str      x8, [sp] ; @'can not add pat message due to config'
0x105a9bdfc: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9be00: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9be04: adrp     x7, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9be08: add      x7, x7, #0xb1d ; '-[SendPatMgr OnGetNewXmlMsg:Type:MsgWrap:]'
0x105a9be0c: mov      w2, #2
0x105a9be10: mov      x3, #0
0x105a9be14: mov      w4, #0
0x105a9be18: mov      w6, #0x71c
0x105a9be1c: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105a9be20: mov      x0, x19
0x105a9be24: bl       #0x107c27c70 ; _objc_release
0x105a9be28: ldp      x29, x30, [sp, #0x120]
0x105a9be2c: ldp      x20, x19, [sp, #0x110] ; 'isEqualToString:'
0x105a9be30: ldp      x22, x21, [sp, #0x100] ; 'm_n64MesSvrID'
0x105a9be34: ldp      x24, x23, [sp, #0xf0]
0x105a9be38: ldp      x26, x25, [sp, #0xe0] ; 'currentContext'
0x105a9be3c: ldp      x28, x27, [sp, #0xd0] ; 'getService:'
0x105a9be40: add      sp, sp, #0x130
0x105a9be44: ret      
0x105a9be48: stp      x28, x27, [sp, #0x88] ; 'getService:'
0x105a9be4c: stur     x26, [x29, #-0x88] ; 'currentContext'
0x105a9be50: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a9be54: ldr      x28, [x8, #0xa08] ; @selector(serverIdToReceivePatWrapMap) | 'serverIdToReceivePatWrapMap'
0x105a9be58: mov      x0, x21
0x105a9be5c: mov      x1, x28 ; 'serverIdToReceivePatWrapMap'
0x105a9be60: bl       #0x107c27c64 ; _objc_msgSend | selector=serverIdToReceivePatWrapMap
0x105a9be64: mov      x29, x29
0x105a9be68: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9be6c: mov      x23, x0
0x105a9be70: adrp     x8, #0x11ed12000
0x105a9be74: ldr      x25, [x8, #0x6c0] ; _OBJC_CLASS_$_NSNumber
0x105a9be78: mov      x0, x19
0x105a9be7c: mov      x1, x22 ; 'm_n64MesSvrID'
0x105a9be80: bl       #0x107c27c64 ; _objc_msgSend | selector=m_n64MesSvrID
0x105a9be84: mov      x2, x0
0x105a9be88: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x105a9be8c: ldr      x26, [x8, #0x5c0] ; @selector(numberWithLongLong:) | 'numberWithLongLong:'
0x105a9be90: mov      x0, x25
0x105a9be94: mov      x1, x26 ; 'numberWithLongLong:'
0x105a9be98: bl       #0x107c27c64 ; _objc_msgSend | selector=numberWithLongLong:
0x105a9be9c: mov      x29, x29
0x105a9bea0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9bea4: mov      x24, x0
0x105a9bea8: adrp     x8, #0x11ecad000 ; @selector(sharedApplication)
0x105a9beac: stur     x21, [x29, #-0x80]
0x105a9beb0: mov      x21, x22 ; 'm_n64MesSvrID'
0x105a9beb4: ldr      x22, [x8, #0x5a0] ; @selector(stringValue) | 'stringValue'
0x105a9beb8: mov      x1, x22 ; 'stringValue'
0x105a9bebc: bl       #0x107c27c64 ; _objc_msgSend | selector=stringValue
0x105a9bec0: mov      x29, x29
0x105a9bec4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9bec8: mov      x25, x0
0x105a9becc: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x105a9bed0: ldr      x1, [x8, #0x650] ; @selector(objectForKeyedSubscript:) | 'objectForKeyedSubscript:'
0x105a9bed4: mov      x0, x23
0x105a9bed8: mov      x2, x25
0x105a9bedc: bl       #0x107c27c64 ; _objc_msgSend | selector=objectForKeyedSubscript:
0x105a9bee0: mov      x29, x29
0x105a9bee4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9bee8: mov      x27, x0
0x105a9beec: bl       #0x107c27c70 ; _objc_release
0x105a9bef0: mov      x0, x25
0x105a9bef4: bl       #0x107c27c70 ; _objc_release
0x105a9bef8: mov      x0, x24
0x105a9befc: bl       #0x107c27c70 ; _objc_release
0x105a9bf00: mov      x0, x23
0x105a9bf04: bl       #0x107c27c70 ; _objc_release
0x105a9bf08: cbz      x27, #0x105a9bf5c
0x105a9bf0c: adrp     x8, #0x11ed12000
0x105a9bf10: ldr      x20, [x8, #0x618] ; classref iConsole | Class iConsole
0x105a9bf14: mov      x0, x19
0x105a9bf18: mov      x1, x21 ; 'm_n64MesSvrID'
0x105a9bf1c: bl       #0x107c27c64 ; _objc_msgSend | selector=m_n64MesSvrID
0x105a9bf20: adrp     x8, #0x11e9c9000
0x105a9bf24: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a9bf28: adrp     x8, #0x11d333000
0x105a9bf2c: add      x8, x8, #0x98 ; @'receive pat message with same server id: %lld'
0x105a9bf30: stp      x8, x0, [sp] ; @'receive pat message with same server id: %lld'
0x105a9bf34: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9bf38: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9bf3c: adrp     x7, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9bf40: add      x7, x7, #0xb1d ; '-[SendPatMgr OnGetNewXmlMsg:Type:MsgWrap:]'
0x105a9bf44: mov      x0, x20 ; Class iConsole
0x105a9bf48: mov      w2, #2
0x105a9bf4c: mov      x3, #0
0x105a9bf50: mov      w4, #0
0x105a9bf54: mov      w6, #0x726
0x105a9bf58: b        #0x105a9be1c
0x105a9bf5c: ldur     x27, [x29, #-0x80]
0x105a9bf60: stp      x22, x26, [sp, #0x78] ; 'stringValue'
0x105a9bf64: str      x28, [sp, #0x70] ; 'serverIdToReceivePatWrapMap'
0x105a9bf68: adrp     x8, #0x11e9ce000 ; @selector(onAddMsg:roomID:)
0x105a9bf6c: ldr      x1, [x8, #0x460] ; @selector(m_nsContent) | 'm_nsContent'
0x105a9bf70: mov      x0, x19
0x105a9bf74: bl       #0x107c27c64 ; _objc_msgSend | selector=m_nsContent
0x105a9bf78: mov      x29, x29
0x105a9bf7c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9bf80: mov      x24, x0
0x105a9bf84: adrp     x25, #0x11ed12000
0x105a9bf88: ldr      x0, [x25, #0x618] ; classref iConsole | Class iConsole
0x105a9bf8c: adrp     x8, #0x11e9c9000
0x105a9bf90: ldr      x22, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a9bf94: adrp     x8, #0x11d333000
0x105a9bf98: add      x8, x8, #0xb8 ; @'on receive pat message: %@'
0x105a9bf9c: stp      x8, x24, [sp] ; @'on receive pat message: %@'
0x105a9bfa0: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9bfa4: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9bfa8: adrp     x7, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9bfac: add      x7, x7, #0xb1d ; '-[SendPatMgr OnGetNewXmlMsg:Type:MsgWrap:]'
0x105a9bfb0: mov      x1, x22 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a9bfb4: mov      w2, #1
0x105a9bfb8: mov      x3, #0
0x105a9bfbc: mov      w4, #0
0x105a9bfc0: mov      w6, #0x72c
0x105a9bfc4: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105a9bfc8: sub      x0, x29, #0x78
0x105a9bfcc: mov      w1, #1
0x105a9bfd0: bl       #0x107c0cc6c
0x105a9bfd4: mov      x0, x24
0x105a9bfd8: bl       #0x107c27c78 ; _objc_retainAutorelease
0x105a9bfdc: adrp     x8, #0x11eca5000 ; @selector(voiceIdSet)
0x105a9bfe0: ldr      x1, [x8, #0x6b8] ; @selector(UTF8String) | 'UTF8String'
0x105a9bfe4: bl       #0x107c27c64 ; _objc_msgSend | selector=UTF8String
0x105a9bfe8: mov      x23, x0
0x105a9bfec: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105a9bff0: ldr      x1, [x8, #0xcf0] ; @selector(lengthOfBytesUsingEncoding:) | 'lengthOfBytesUsingEncoding:'
0x105a9bff4: mov      x0, x24
0x105a9bff8: mov      w2, #4
0x105a9bffc: bl       #0x107c27c64 ; _objc_msgSend | selector=lengthOfBytesUsingEncoding:
0x105a9c000: mov      x2, x0
0x105a9c004: sub      x0, x29, #0x78
0x105a9c008: mov      x1, x23
0x105a9c00c: bl       #0x107c0cc70
0x105a9c010: sub      x0, x29, #0x78
0x105a9c014: bl       #0x107c0cc74
0x105a9c018: cbz      x0, #0x105a9c57c
0x105a9c01c: adrp     x1, #0x119bbb000 ; '-scene Enter all value not supported!'
0x105a9c020: add      x1, x1, #0x807 ; 'sysmsg'
0x105a9c024: bl       #0x107c0cc48
0x105a9c028: cbz      x0, #0x105a9c5b4
0x105a9c02c: adrp     x1, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9c030: add      x1, x1, #0xb19 ; 'pat'
0x105a9c034: bl       #0x107c0cc48
0x105a9c038: cbz      x0, #0x105a9c5ec
0x105a9c03c: mov      x23, x0
0x105a9c040: adrp     x1, #0x119cf8000 ; 'ta for %@, membcount = %u'
0x105a9c044: add      x1, x1, #0x8ab ; 'fromusername'
0x105a9c048: bl       #0x107c0cc48
0x105a9c04c: cbz      x0, #0x105a9c624
0x105a9c050: mov      x28, x0
0x105a9c054: adrp     x1, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9c058: add      x1, x1, #0xc2c ; 'chatusername'
0x105a9c05c: mov      x0, x23
0x105a9c060: bl       #0x107c0cc48
0x105a9c064: cbz      x0, #0x105a9c65c
0x105a9c068: mov      x26, x0
0x105a9c06c: adrp     x1, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9c070: add      x1, x1, #0xc59 ; 'pattedusername'
0x105a9c074: mov      x0, x23
0x105a9c078: bl       #0x107c0cc48
0x105a9c07c: cbz      x0, #0x105a9c694
0x105a9c080: str      x0, [sp, #0x60]
0x105a9c084: adrp     x1, #0x119d35000 ; 't realtimeReport fail!'
0x105a9c088: add      x1, x1, #0x9d6 ; 'template'
0x105a9c08c: mov      x0, x23
0x105a9c090: bl       #0x107c0cc48
0x105a9c094: cbz      x0, #0x105a9c730
0x105a9c098: stp      x22, x0, [sp, #0x40] ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a9c09c: str      x24, [sp, #0x50]
0x105a9c0a0: adrp     x22, #0x11ed12000
0x105a9c0a4: ldr      x23, [x22, #0x638] ; _OBJC_CLASS_$_NSString
0x105a9c0a8: mov      x0, x28
0x105a9c0ac: bl       #0x107c0cc30
0x105a9c0b0: mov      x2, x0
0x105a9c0b4: adrp     x8, #0x11ecad000 ; @selector(sharedApplication)
0x105a9c0b8: ldr      x24, [x8, #0x5d8] ; @selector(stringWithUTF8String:) | 'stringWithUTF8String:'
0x105a9c0bc: mov      x0, x23
0x105a9c0c0: mov      x1, x24 ; 'stringWithUTF8String:'
0x105a9c0c4: bl       #0x107c27c64 ; _objc_msgSend | selector=stringWithUTF8String:
0x105a9c0c8: mov      x29, x29
0x105a9c0cc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9c0d0: str      x0, [sp, #0x68]
0x105a9c0d4: ldr      x23, [x22, #0x638] ; _OBJC_CLASS_$_NSString
0x105a9c0d8: mov      x28, x22
0x105a9c0dc: ldr      x0, [sp, #0x60]
0x105a9c0e0: bl       #0x107c0cc30
0x105a9c0e4: mov      x2, x0
0x105a9c0e8: mov      x0, x23
0x105a9c0ec: mov      x1, x24 ; 'stringWithUTF8String:'
0x105a9c0f0: bl       #0x107c27c64 ; _objc_msgSend | selector=stringWithUTF8String:
0x105a9c0f4: mov      x29, x29
0x105a9c0f8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9c0fc: mov      x22, x0
0x105a9c100: ldr      x23, [x28, #0x638] ; _OBJC_CLASS_$_NSString
0x105a9c104: mov      x0, x26
0x105a9c108: bl       #0x107c0cc30
0x105a9c10c: mov      x2, x0
0x105a9c110: mov      x0, x23
0x105a9c114: mov      x1, x24 ; 'stringWithUTF8String:'
0x105a9c118: bl       #0x107c27c64 ; _objc_msgSend | selector=stringWithUTF8String:
0x105a9c11c: mov      x29, x29
0x105a9c120: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9c124: str      x0, [sp, #0x58]
0x105a9c128: ldr      x23, [x28, #0x638] ; _OBJC_CLASS_$_NSString
0x105a9c12c: ldr      x26, [sp, #0x68]
0x105a9c130: ldr      x0, [sp, #0x48]
0x105a9c134: bl       #0x107c0cc30
0x105a9c138: mov      x2, x0
0x105a9c13c: mov      x0, x23
0x105a9c140: mov      x1, x24 ; 'stringWithUTF8String:'
0x105a9c144: bl       #0x107c27c64 ; _objc_msgSend | selector=stringWithUTF8String:
0x105a9c148: mov      x29, x29
0x105a9c14c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9c150: mov      x23, x0
0x105a9c154: adrp     x8, #0x11ed34000 ; classref WCFinderObjectMonotonicData
0x105a9c158: ldr      x0, [x8, #0xc70] ; classref PatWrap | Class PatWrap
0x105a9c15c: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a9c160: ldr      x1, [x8, #0xac8] ; @selector(templateFromTemplate:fromUserName:pattedUserName:) | 'templateFromTemplate:fromUserName:pattedUserName:'
0x105a9c164: mov      x2, x23
0x105a9c168: mov      x3, x26
0x105a9c16c: str      x22, [sp, #0x60]
0x105a9c170: mov      x4, x22
0x105a9c174: ldr      x22, [sp, #0x58]
0x105a9c178: bl       #0x107c27c64 ; _objc_msgSend | selector=templateFromTemplate:fromUserName:pattedUserName:
0x105a9c17c: mov      x29, x29
0x105a9c180: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9c184: mov      x24, x0
0x105a9c188: mov      x0, x23
0x105a9c18c: bl       #0x107c27c70 ; _objc_release
0x105a9c190: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105a9c194: ldr      x23, [x8, #0xce8] ; @selector(length) | 'length'
0x105a9c198: mov      x0, x26
0x105a9c19c: mov      x26, x24
0x105a9c1a0: mov      x1, x23 ; 'length'
0x105a9c1a4: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105a9c1a8: cbz      x0, #0x105a9c6cc
0x105a9c1ac: ldr      x0, [sp, #0x60]
0x105a9c1b0: mov      x1, x23 ; 'length'
0x105a9c1b4: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105a9c1b8: cbz      x0, #0x105a9c6cc
0x105a9c1bc: mov      x0, x22
0x105a9c1c0: mov      x1, x23 ; 'length'
0x105a9c1c4: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105a9c1c8: cbz      x0, #0x105a9c6cc
0x105a9c1cc: mov      x0, x26
0x105a9c1d0: mov      x1, x23 ; 'length'
0x105a9c1d4: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105a9c1d8: cbz      x0, #0x105a9c6cc
0x105a9c1dc: adrp     x8, #0x11ed12000
0x105a9c1e0: ldr      x0, [x8, #0xbc0] ; classref MMKernelUtil | Class MMKernelUtil
0x105a9c1e4: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x105a9c1e8: ldr      x1, [x8, #0xec0] ; @selector(IsChatRoom:) | 'IsChatRoom:'
0x105a9c1ec: mov      x2, x22
0x105a9c1f0: bl       #0x107c27c64 ; _objc_msgSend | selector=IsChatRoom:
0x105a9c1f4: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x105a9c1f8: ldr      x1, [x8, #0x990] ; @selector(currentUserName) | 'currentUserName'
0x105a9c1fc: str      x1, [sp, #0x38] ; 'currentUserName'
0x105a9c200: tbnz     w0, #0, #0x105a9c254
0x105a9c204: adrp     x8, #0x11ed12000
0x105a9c208: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105a9c20c: bl       #0x107c27c64 ; _objc_msgSend | selector=currentUserName
0x105a9c210: mov      x29, x29
0x105a9c214: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9c218: mov      x23, x0
0x105a9c21c: ldr      x0, [sp, #0x68]
0x105a9c220: mov      x1, x20 ; Class iConsole
0x105a9c224: mov      x2, x23
0x105a9c228: bl       #0x107c27c64 ; _objc_msgSend | selector=p4
0x105a9c22c: mov      x22, x0
0x105a9c230: mov      x0, x23
0x105a9c234: bl       #0x107c27c70 ; _objc_release
0x105a9c238: tbnz     w22, #0, #0x105a9c254
0x105a9c23c: ldr      x22, [sp, #0x68]
0x105a9c240: mov      x0, x22
0x105a9c244: bl       #0x107c27c74 ; _objc_retain
0x105a9c248: ldr      x0, [sp, #0x58]
0x105a9c24c: bl       #0x107c27c70 ; _objc_release
0x105a9c250: str      x22, [sp, #0x58]
0x105a9c254: mov      x22, x21 ; 'm_n64MesSvrID'
0x105a9c258: adrp     x8, #0x11ed34000 ; classref WCFinderObjectMonotonicData
0x105a9c25c: ldr      x0, [x8, #0xc70] ; classref PatWrap | Class PatWrap
0x105a9c260: bl       #0x107c27c0c ; _objc_alloc_init
0x105a9c264: mov      x23, x0
0x105a9c268: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a9c26c: ldr      x1, [x8, #0x6e0] ; @selector(setFromUserName:) | 'setFromUserName:'
0x105a9c270: ldr      x2, [sp, #0x68]
0x105a9c274: bl       #0x107c27c64 ; _objc_msgSend | selector=setFromUserName:
0x105a9c278: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a9c27c: ldr      x1, [x8, #0x808] ; @selector(setPattedUserName:) | 'setPattedUserName:'
0x105a9c280: mov      x0, x23
0x105a9c284: ldr      x21, [sp, #0x60]
0x105a9c288: mov      x2, x21
0x105a9c28c: bl       #0x107c27c64 ; _objc_msgSend | selector=setPattedUserName:
0x105a9c290: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a9c294: ldr      x1, [x8, #0x840] ; @selector(setTemplete:) | 'setTemplete:'
0x105a9c298: mov      x0, x23
0x105a9c29c: mov      x2, x26
0x105a9c2a0: bl       #0x107c27c64 ; _objc_msgSend | selector=setTemplete:
0x105a9c2a4: adrp     x8, #0x11e9cc000 ; @selector(setCenterY:)
0x105a9c2a8: ldr      x1, [x8, #0xfd8] ; @selector(m_uiCreateTime) | 'm_uiCreateTime'
0x105a9c2ac: mov      x0, x19
0x105a9c2b0: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiCreateTime
0x105a9c2b4: mov      w8, #0x3e8
0x105a9c2b8: umull    x2, w0, w8
0x105a9c2bc: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a9c2c0: ldr      x1, [x8, #0x708] ; @selector(setCreateTime:) | 'setCreateTime:'
0x105a9c2c4: mov      x0, x23
0x105a9c2c8: str      x1, [sp, #0x28] ; 'setCreateTime:'
0x105a9c2cc: bl       #0x107c27c64 ; _objc_msgSend | selector=setCreateTime:
0x105a9c2d0: mov      x0, x19
0x105a9c2d4: str      x22, [sp, #0x30] ; 'm_n64MesSvrID'
0x105a9c2d8: mov      x1, x22 ; 'm_n64MesSvrID'
0x105a9c2dc: bl       #0x107c27c64 ; _objc_msgSend | selector=m_n64MesSvrID
0x105a9c2e0: mov      x2, x0
0x105a9c2e4: adrp     x8, #0x11e9ea000 ; @selector(shouldHandleCategoryItem:)
0x105a9c2e8: ldr      x1, [x8, #0xff0] ; @selector(setServerId:) | 'setServerId:'
0x105a9c2ec: mov      x0, x23
0x105a9c2f0: str      x1, [sp, #0x20] ; 'setServerId:'
0x105a9c2f4: bl       #0x107c27c64 ; _objc_msgSend | selector=setServerId:
0x105a9c2f8: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a9c2fc: ldr      x1, [x8, #0xfa8] ; @selector(setIsRead:) | 'setIsRead:'
0x105a9c300: mov      x0, x23
0x105a9c304: mov      w2, #0
0x105a9c308: bl       #0x107c27c64 ; _objc_msgSend | selector=setIsRead:
0x105a9c30c: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a9c310: ldr      x1, [x8, #0x8a8] ; @selector(setShowChangeSuffixRemind:) | 'setShowChangeSuffixRemind:'
0x105a9c314: str      x23, [sp, #0x48]
0x105a9c318: mov      x0, x23
0x105a9c31c: mov      x22, x1 ; 'setShowChangeSuffixRemind:'
0x105a9c320: mov      w2, #0
0x105a9c324: bl       #0x107c27c64 ; _objc_msgSend | selector=setShowChangeSuffixRemind:
0x105a9c328: adrp     x24, #0x11ed12000
0x105a9c32c: ldr      x0, [x24, #0x780] ; classref MMContext | Class MMContext
0x105a9c330: ldr      x1, [sp, #0x38]
0x105a9c334: bl       #0x107c27c64 ; _objc_msgSend
0x105a9c338: mov      x29, x29
0x105a9c33c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9c340: mov      x23, x0
0x105a9c344: mov      x0, x21
0x105a9c348: mov      x1, x20 ; Class iConsole
0x105a9c34c: mov      x2, x23
0x105a9c350: bl       #0x107c27c64 ; _objc_msgSend | selector=p4
0x105a9c354: mov      x20, x0
0x105a9c358: mov      x0, x23
0x105a9c35c: bl       #0x107c27c70 ; _objc_release
0x105a9c360: mov      x21, x27
0x105a9c364: cbz      w20, #0x105a9c39c
0x105a9c368: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a9c36c: ldr      x1, [x8, #0x958] ; @selector(needShowChangeSuffixRemind) | 'needShowChangeSuffixRemind'
0x105a9c370: mov      x0, x21
0x105a9c374: bl       #0x107c27c64 ; _objc_msgSend | selector=needShowChangeSuffixRemind
0x105a9c378: cbz      w0, #0x105a9c39c
0x105a9c37c: ldr      x0, [sp, #0x48]
0x105a9c380: mov      x1, x22 ; 'setShowChangeSuffixRemind:'
0x105a9c384: mov      w2, #1
0x105a9c388: bl       #0x107c27c64 ; _objc_msgSend | selector=setShowChangeSuffixRemind:
0x105a9c38c: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a9c390: ldr      x1, [x8, #0x960] ; @selector(updateModifyPatSuffixTimeAndCount) | 'updateModifyPatSuffixTimeAndCount'
0x105a9c394: mov      x0, x21
0x105a9c398: bl       #0x107c27c64 ; _objc_msgSend | selector=updateModifyPatSuffixTimeAndCount
0x105a9c39c: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a9c3a0: ldr      x1, [x8, #0x968] ; @selector(addPatWrap:toChat:newXMLMessageWrap:index:) | 'addPatWrap:toChat:newXMLMessageWrap:index:'
0x105a9c3a4: mov      x0, x21
0x105a9c3a8: ldr      x23, [sp, #0x48]
0x105a9c3ac: mov      x2, x23
0x105a9c3b0: ldr      x22, [sp, #0x58]
0x105a9c3b4: mov      x3, x22
0x105a9c3b8: mov      x4, x19
0x105a9c3bc: mov      x5, #0
0x105a9c3c0: bl       #0x107c27c64 ; _objc_msgSend | selector=addPatWrap:toChat:newXMLMessageWrap:index:
0x105a9c3c4: mov      x20, x0
0x105a9c3c8: adrp     x8, #0x11e9ea000 ; @selector(shouldHandleCategoryItem:)
0x105a9c3cc: ldr      x1, [x8, #0xfc8] ; @selector(serverId) | 'serverId'
0x105a9c3d0: mov      x0, x23
0x105a9c3d4: str      x1, [sp, #0x18] ; 'serverId'
0x105a9c3d8: bl       #0x107c27c64 ; _objc_msgSend | selector=serverId
0x105a9c3dc: cbz      x0, #0x105a9c7d0
0x105a9c3e0: str      x26, [sp, #0x38]
0x105a9c3e4: ldr      x0, [x24, #0x780] ; classref MMContext | Class MMContext
0x105a9c3e8: ldur     x1, [x29, #-0x88]
0x105a9c3ec: bl       #0x107c27c64 ; _objc_msgSend
0x105a9c3f0: mov      x29, x29
0x105a9c3f4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9c3f8: mov      x23, x0
0x105a9c3fc: adrp     x8, #0x11ed12000
0x105a9c400: ldr      x0, [x8, #0xc20] ; classref CMessageMgr | Class CMessageMgr
0x105a9c404: ldr      x1, [sp, #0x90]
0x105a9c408: bl       #0x107c27c64 ; _objc_msgSend
0x105a9c40c: mov      x2, x0
0x105a9c410: mov      x0, x23
0x105a9c414: ldr      x1, [sp, #0x88]
0x105a9c418: bl       #0x107c27c64 ; _objc_msgSend
0x105a9c41c: mov      x29, x29
0x105a9c420: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9c424: mov      x24, x0
0x105a9c428: adrp     x8, #0x11e9d3000 ; @selector(deleteSearchableItemsWithDomainIdentifiers:completionHandler:)
0x105a9c42c: ldr      x1, [x8, #0xf28] ; @selector(GetMsg:LocalID:) | 'GetMsg:LocalID:'
0x105a9c430: mov      x2, x22
0x105a9c434: mov      x3, x20
0x105a9c438: bl       #0x107c27c64 ; _objc_msgSend | selector=GetMsg:LocalID:
0x105a9c43c: mov      x29, x29
0x105a9c440: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9c444: mov      x26, x0
0x105a9c448: mov      x0, x24
0x105a9c44c: bl       #0x107c27c70 ; _objc_release
0x105a9c450: mov      x0, x23
0x105a9c454: bl       #0x107c27c70 ; _objc_release
0x105a9c458: ldr      x20, [sp, #0x30]
0x105a9c45c: cbz      x26, #0x105a9c77c
0x105a9c460: mov      x0, x26
0x105a9c464: mov      x1, x20
0x105a9c468: bl       #0x107c27c64 ; _objc_msgSend
0x105a9c46c: cbz      x0, #0x105a9c77c
0x105a9c470: adrp     x8, #0x11ed36000 ; classref ScanQRCodeMerchantPayUrlHandler
0x105a9c474: ldr      x0, [x8, #0x2d0] ; classref ReceivePatWrap | Class ReceivePatWrap
0x105a9c478: bl       #0x107c27c0c ; _objc_alloc_init
0x105a9c47c: mov      x24, x0
0x105a9c480: mov      x0, x26
0x105a9c484: mov      x1, x20
0x105a9c488: bl       #0x107c27c64 ; _objc_msgSend
0x105a9c48c: mov      x2, x0
0x105a9c490: mov      x0, x24
0x105a9c494: ldr      x1, [sp, #0x20]
0x105a9c498: bl       #0x107c27c64 ; _objc_msgSend
0x105a9c49c: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a9c4a0: ldr      x1, [x8, #0xe18] ; @selector(setChatUserName:) | 'setChatUserName:'
0x105a9c4a4: mov      x0, x24
0x105a9c4a8: ldr      x2, [sp, #0x58]
0x105a9c4ac: bl       #0x107c27c64 ; _objc_msgSend | selector=setChatUserName:
0x105a9c4b0: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a9c4b4: ldr      x1, [x8, #0x7d0] ; @selector(createTime) | 'createTime'
0x105a9c4b8: ldr      x23, [sp, #0x48]
0x105a9c4bc: mov      x0, x23
0x105a9c4c0: bl       #0x107c27c64 ; _objc_msgSend | selector=createTime
0x105a9c4c4: mov      x2, x0
0x105a9c4c8: mov      x0, x24
0x105a9c4cc: ldr      x1, [sp, #0x28]
0x105a9c4d0: bl       #0x107c27c64 ; _objc_msgSend
0x105a9c4d4: mov      x0, x21
0x105a9c4d8: ldr      x1, [sp, #0x70]
0x105a9c4dc: bl       #0x107c27c64 ; _objc_msgSend
0x105a9c4e0: mov      x29, x29
0x105a9c4e4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9c4e8: mov      x20, x0
0x105a9c4ec: adrp     x8, #0x11ed12000
0x105a9c4f0: ldr      x22, [x8, #0x6c0] ; _OBJC_CLASS_$_NSNumber
0x105a9c4f4: mov      x0, x23
0x105a9c4f8: ldr      x1, [sp, #0x18]
0x105a9c4fc: bl       #0x107c27c64 ; _objc_msgSend
0x105a9c500: mov      x2, x0
0x105a9c504: mov      x0, x22
0x105a9c508: ldr      x1, [sp, #0x80]
0x105a9c50c: bl       #0x107c27c64 ; _objc_msgSend
0x105a9c510: mov      x29, x29
0x105a9c514: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9c518: mov      x22, x0
0x105a9c51c: ldr      x1, [sp, #0x78]
0x105a9c520: bl       #0x107c27c64 ; _objc_msgSend
0x105a9c524: mov      x29, x29
0x105a9c528: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9c52c: mov      x23, x0
0x105a9c530: adrp     x8, #0x11ecac000 ; @selector(setManager:)
0x105a9c534: ldr      x1, [x8, #0x298] ; @selector(setObject:forKeyedSubscript:) | 'setObject:forKeyedSubscript:'
0x105a9c538: mov      x0, x20
0x105a9c53c: mov      x2, x24
0x105a9c540: mov      x3, x23
0x105a9c544: bl       #0x107c27c64 ; _objc_msgSend | selector=setObject:forKeyedSubscript:
0x105a9c548: mov      x0, x23
0x105a9c54c: bl       #0x107c27c70 ; _objc_release
0x105a9c550: mov      x0, x22
0x105a9c554: bl       #0x107c27c70 ; _objc_release
0x105a9c558: mov      x0, x20
0x105a9c55c: bl       #0x107c27c70 ; _objc_release
0x105a9c560: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a9c564: ldr      x1, [x8, #0xa10] ; @selector(saveServerIdToReceivePatWrapMap) | 'saveServerIdToReceivePatWrapMap'
0x105a9c568: mov      x0, x21
0x105a9c56c: bl       #0x107c27c64 ; _objc_msgSend | selector=saveServerIdToReceivePatWrapMap
0x105a9c570: mov      x0, x24
0x105a9c574: bl       #0x107c27c70 ; _objc_release
0x105a9c578: b        #0x105a9c7b4
0x105a9c57c: ldr      x0, [x25, #0x618] ; classref iConsole | Class iConsole
0x105a9c580: adrp     x8, #0x11d2fb000
0x105a9c584: add      x8, x8, #0x158 ; @'fail to get root node'
0x105a9c588: str      x8, [sp] ; @'fail to get root node'
0x105a9c58c: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9c590: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9c594: adrp     x7, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9c598: add      x7, x7, #0xb1d ; '-[SendPatMgr OnGetNewXmlMsg:Type:MsgWrap:]'
0x105a9c59c: mov      x1, x22
0x105a9c5a0: mov      w2, #4
0x105a9c5a4: mov      x3, #0
0x105a9c5a8: mov      w4, #0
0x105a9c5ac: mov      w6, #0x731
0x105a9c5b0: b        #0x105a9c764
0x105a9c5b4: ldr      x0, [x25, #0x618] ; classref iConsole | Class iConsole
0x105a9c5b8: adrp     x8, #0x11d2fb000
0x105a9c5bc: add      x8, x8, #0x178 ; @'fail to get sysmsg node'
0x105a9c5c0: str      x8, [sp] ; @'fail to get sysmsg node'
0x105a9c5c4: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9c5c8: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9c5cc: adrp     x7, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9c5d0: add      x7, x7, #0xb1d ; '-[SendPatMgr OnGetNewXmlMsg:Type:MsgWrap:]'
0x105a9c5d4: mov      x1, x22
0x105a9c5d8: mov      w2, #4
0x105a9c5dc: mov      x3, #0
0x105a9c5e0: mov      w4, #0
0x105a9c5e4: mov      w6, #0x736
0x105a9c5e8: b        #0x105a9c764
0x105a9c5ec: ldr      x0, [x25, #0x618] ; classref iConsole | Class iConsole
0x105a9c5f0: adrp     x8, #0x11d333000
0x105a9c5f4: add      x8, x8, #0xd8 ; @'fail to get pat node'
0x105a9c5f8: str      x8, [sp] ; @'fail to get pat node'
0x105a9c5fc: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9c600: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9c604: adrp     x7, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9c608: add      x7, x7, #0xb1d ; '-[SendPatMgr OnGetNewXmlMsg:Type:MsgWrap:]'
0x105a9c60c: mov      x1, x22
0x105a9c610: mov      w2, #4
0x105a9c614: mov      x3, #0
0x105a9c618: mov      w4, #0
0x105a9c61c: mov      w6, #0x73b
0x105a9c620: b        #0x105a9c764
0x105a9c624: ldr      x0, [x25, #0x618] ; classref iConsole | Class iConsole
0x105a9c628: adrp     x8, #0x11d333000
0x105a9c62c: add      x8, x8, #0xf8 ; @'fail to get from user name node'
0x105a9c630: str      x8, [sp] ; @'fail to get from user name node'
0x105a9c634: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9c638: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9c63c: adrp     x7, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9c640: add      x7, x7, #0xb1d ; '-[SendPatMgr OnGetNewXmlMsg:Type:MsgWrap:]'
0x105a9c644: mov      x1, x22
0x105a9c648: mov      w2, #4
0x105a9c64c: mov      x3, #0
0x105a9c650: mov      w4, #0
0x105a9c654: mov      w6, #0x740
0x105a9c658: b        #0x105a9c764
0x105a9c65c: ldr      x0, [x25, #0x618] ; classref iConsole | Class iConsole
0x105a9c660: adrp     x8, #0x11d333000
0x105a9c664: add      x8, x8, #0x118 ; @'fail to get chat user name node'
0x105a9c668: str      x8, [sp] ; @'fail to get chat user name node'
0x105a9c66c: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9c670: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9c674: adrp     x7, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9c678: add      x7, x7, #0xb1d ; '-[SendPatMgr OnGetNewXmlMsg:Type:MsgWrap:]'
0x105a9c67c: mov      x1, x22
0x105a9c680: mov      w2, #4
0x105a9c684: mov      x3, #0
0x105a9c688: mov      w4, #0
0x105a9c68c: mov      w6, #0x745
0x105a9c690: b        #0x105a9c764
0x105a9c694: ldr      x0, [x25, #0x618] ; classref iConsole | Class iConsole
0x105a9c698: adrp     x8, #0x11d333000
0x105a9c69c: add      x8, x8, #0x138 ; @'fail to get patted user name node'
0x105a9c6a0: str      x8, [sp] ; @'fail to get patted user name node'
0x105a9c6a4: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9c6a8: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9c6ac: adrp     x7, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9c6b0: add      x7, x7, #0xb1d ; '-[SendPatMgr OnGetNewXmlMsg:Type:MsgWrap:]'
0x105a9c6b4: mov      x1, x22
0x105a9c6b8: mov      w2, #4
0x105a9c6bc: mov      x3, #0
0x105a9c6c0: mov      w4, #0
0x105a9c6c4: mov      w6, #0x74a
0x105a9c6c8: b        #0x105a9c764
0x105a9c6cc: ldr      x0, [x25, #0x618] ; classref iConsole | Class iConsole
0x105a9c6d0: adrp     x8, #0x11d333000
0x105a9c6d4: add      x8, x8, #0x178 ; @'invalid string from XML parser'
0x105a9c6d8: str      x8, [sp] ; @'invalid string from XML parser'
0x105a9c6dc: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9c6e0: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9c6e4: adrp     x7, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9c6e8: add      x7, x7, #0xb1d ; '-[SendPatMgr OnGetNewXmlMsg:Type:MsgWrap:]'
0x105a9c6ec: ldr      x1, [sp, #0x40]
0x105a9c6f0: mov      w2, #4
0x105a9c6f4: mov      x3, #0
0x105a9c6f8: mov      w4, #0
0x105a9c6fc: mov      w6, #0x75a
0x105a9c700: bl       #0x107c27c64 ; _objc_msgSend
0x105a9c704: ldr      x24, [sp, #0x50]
0x105a9c708: ldr      x20, [sp, #0x68]
0x105a9c70c: mov      x0, x26
0x105a9c710: bl       #0x107c27c70 ; _objc_release
0x105a9c714: mov      x0, x22
0x105a9c718: bl       #0x107c27c70 ; _objc_release
0x105a9c71c: ldr      x0, [sp, #0x60]
0x105a9c720: bl       #0x107c27c70 ; _objc_release
0x105a9c724: mov      x0, x20
0x105a9c728: bl       #0x107c27c70 ; _objc_release
0x105a9c72c: b        #0x105a9c768
0x105a9c730: ldr      x0, [x25, #0x618] ; classref iConsole | Class iConsole
0x105a9c734: adrp     x8, #0x11d333000
0x105a9c738: add      x8, x8, #0x158 ; @'fail to get template node'
0x105a9c73c: str      x8, [sp] ; @'fail to get template node'
0x105a9c740: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9c744: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9c748: adrp     x7, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9c74c: add      x7, x7, #0xb1d ; '-[SendPatMgr OnGetNewXmlMsg:Type:MsgWrap:]'
0x105a9c750: mov      x1, x22
0x105a9c754: mov      w2, #4
0x105a9c758: mov      x3, #0
0x105a9c75c: mov      w4, #0
0x105a9c760: mov      w6, #0x74f
0x105a9c764: bl       #0x107c27c64 ; _objc_msgSend
0x105a9c768: sub      x0, x29, #0x78
0x105a9c76c: bl       #0x107c0cc60
0x105a9c770: mov      x0, x24
0x105a9c774: bl       #0x107c27c70 ; _objc_release
0x105a9c778: b        #0x105a9be20
0x105a9c77c: ldr      x0, [x25, #0x618] ; classref iConsole | Class iConsole
0x105a9c780: adrp     x8, #0x11d333000
0x105a9c784: add      x8, x8, #0x198 ; @'can not get message wrap or message wrap has no server id'
0x105a9c788: str      x8, [sp] ; @'can not get message wrap or message wrap has no server id'
0x105a9c78c: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9c790: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9c794: adrp     x7, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9c798: add      x7, x7, #0xb1d ; '-[SendPatMgr OnGetNewXmlMsg:Type:MsgWrap:]'
0x105a9c79c: ldr      x1, [sp, #0x40]
0x105a9c7a0: mov      w2, #3
0x105a9c7a4: mov      x3, #0
0x105a9c7a8: mov      w4, #0
0x105a9c7ac: mov      w6, #0x783
0x105a9c7b0: bl       #0x107c27c64 ; _objc_msgSend
0x105a9c7b4: ldr      x24, [sp, #0x50]
0x105a9c7b8: mov      x0, x26
0x105a9c7bc: bl       #0x107c27c70 ; _objc_release
0x105a9c7c0: ldr      x20, [sp, #0x68]
0x105a9c7c4: ldr      x22, [sp, #0x58]
0x105a9c7c8: ldr      x26, [sp, #0x38]
0x105a9c7cc: b        #0x105a9c810
0x105a9c7d0: ldr      x0, [x25, #0x618] ; classref iConsole | Class iConsole
0x105a9c7d4: adrp     x8, #0x11d333000
0x105a9c7d8: add      x8, x8, #0x1b8 ; @'received pat has 0 server id'
0x105a9c7dc: str      x8, [sp] ; @'received pat has 0 server id'
0x105a9c7e0: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9c7e4: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9c7e8: adrp     x7, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9c7ec: add      x7, x7, #0xb1d ; '-[SendPatMgr OnGetNewXmlMsg:Type:MsgWrap:]'
0x105a9c7f0: ldr      x1, [sp, #0x40]
0x105a9c7f4: mov      w2, #3
0x105a9c7f8: mov      x3, #0
0x105a9c7fc: mov      w4, #0
0x105a9c800: mov      w6, #0x78d
0x105a9c804: bl       #0x107c27c64 ; _objc_msgSend
0x105a9c808: ldr      x24, [sp, #0x50]
0x105a9c80c: ldr      x20, [sp, #0x68]
0x105a9c810: ldr      x0, [sp, #0x48]
0x105a9c814: bl       #0x107c27c70 ; _objc_release
0x105a9c818: b        #0x105a9c70c
