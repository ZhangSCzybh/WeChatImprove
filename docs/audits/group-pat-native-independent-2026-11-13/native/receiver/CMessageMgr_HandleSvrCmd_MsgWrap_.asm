-[CMessageMgr HandleSvrCmd:MsgWrap:] 0x104def554 v32@0:8@16@24
0x104def554: sub      sp, sp, #0x170
0x104def558: stp      d9, d8, [sp, #0x100]
0x104def55c: stp      x28, x27, [sp, #0x110]
0x104def560: stp      x26, x25, [sp, #0x120]
0x104def564: stp      x24, x23, [sp, #0x130]
0x104def568: stp      x22, x21, [sp, #0x140]
0x104def56c: stp      x20, x19, [sp, #0x150]
0x104def570: stp      x29, x30, [sp, #0x160]
0x104def574: add      x29, sp, #0x160
0x104def578: mov      x19, x3
0x104def57c: mov      x20, x2
0x104def580: mov      x22, x0
0x104def584: adrp     x8, #0x11f751000
0x104def588: mov      w9, #1
0x104def58c: strb     w9, [x8, #0xc51]
0x104def590: mov      x0, x2
0x104def594: bl       #0x107c27c74 ; _objc_retain
0x104def598: mov      x0, x19
0x104def59c: bl       #0x107c27c74 ; _objc_retain
0x104def5a0: sub      x0, x29, #0x88
0x104def5a4: mov      w1, #1
0x104def5a8: bl       #0x107c0cc6c
0x104def5ac: adrp     x8, #0x11e9ce000 ; @selector(onAddMsg:roomID:)
0x104def5b0: ldr      x21, [x8, #0x460] ; @selector(m_nsContent) | 'm_nsContent'
0x104def5b4: mov      x0, x19
0x104def5b8: mov      x1, x21 ; 'm_nsContent'
0x104def5bc: bl       #0x107c27c64 ; _objc_msgSend | selector=m_nsContent
0x104def5c0: mov      x29, x29
0x104def5c4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104def5c8: mov      x23, x0
0x104def5cc: bl       #0x107c27c78 ; _objc_retainAutorelease
0x104def5d0: adrp     x8, #0x11eca5000 ; @selector(voiceIdSet)
0x104def5d4: ldr      x1, [x8, #0x6b8] ; @selector(UTF8String) | 'UTF8String'
0x104def5d8: bl       #0x107c27c64 ; _objc_msgSend | selector=UTF8String
0x104def5dc: mov      x24, x0
0x104def5e0: mov      x0, x19
0x104def5e4: mov      x1, x21 ; 'm_nsContent'
0x104def5e8: bl       #0x107c27c64 ; _objc_msgSend | selector=m_nsContent
0x104def5ec: mov      x29, x29
0x104def5f0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104def5f4: mov      x21, x0
0x104def5f8: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x104def5fc: ldr      x1, [x8, #0xcf0] ; @selector(lengthOfBytesUsingEncoding:) | 'lengthOfBytesUsingEncoding:'
0x104def600: mov      w2, #4
0x104def604: bl       #0x107c27c64 ; _objc_msgSend | selector=lengthOfBytesUsingEncoding:
0x104def608: mov      x2, x0
0x104def60c: sub      x0, x29, #0x88
0x104def610: mov      x1, x24
0x104def614: bl       #0x107c0cc70
0x104def618: mov      x0, x21
0x104def61c: bl       #0x107c27c70 ; _objc_release
0x104def620: mov      x0, x23
0x104def624: bl       #0x107c27c70 ; _objc_release
0x104def628: sub      x0, x29, #0x88
0x104def62c: bl       #0x107c0cc74
0x104def630: cbz      x0, #0x104def958
0x104def634: mov      x21, x0
0x104def638: adrp     x1, #0x119c22000 ; 'History) loadHistoryPageWithPageSize:completion:]_block_invoke'
0x104def63c: add      x1, x1, #0xf19 ; 'appmsg'
0x104def640: bl       #0x107c0cc48
0x104def644: cbz      x0, #0x104def714
0x104def648: adrp     x1, #0x11a805000 ; '刷掌模型资源'
0x104def64c: add      x1, x1, #0x2d2 ; 'type'
0x104def650: bl       #0x107c0cc48
0x104def654: cbz      x0, #0x104def714
0x104def658: bl       #0x107c0cc30
0x104def65c: bl       #0x107c2778c ; _atoi
0x104def660: cmp      w0, #0x23
0x104def664: b.ne     #0x104def714
0x104def668: adrp     x8, #0x11ed12000
0x104def66c: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x104def670: adrp     x8, #0x11e9c9000
0x104def674: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x104def678: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104def67c: mov      x29, x29
0x104def680: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104def684: mov      x21, x0
0x104def688: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x104def68c: ldr      x22, [x8, #0x618]
0x104def690: adrp     x8, #0x11eb24000 ; @selector(setM_firstSendTime:)
0x104def694: ldr      x23, [x8, #0x368] ; @selector(onRevChatSyncRequest:MsgWrap:) | 'onRevChatSyncRequest:MsgWrap:'
0x104def698: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x104def69c: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x104def6a0: str      x8, [sp, #0xa8]
0x104def6a4: adrp     x8, #0x1178c7000
0x104def6a8: ldr      d0, [x8, #0x680]
0x104def6ac: str      d0, [sp, #0xb0]
0x104def6b0: adrp     x8, #0x104def000
0x104def6b4: add      x8, x8, #0xd7c
0x104def6b8: adrp     x9, #0x11c284000
0x104def6bc: add      x9, x9, #0x8e0
0x104def6c0: stp      x8, x9, [sp, #0xb8]
0x104def6c4: mov      x0, x20
0x104def6c8: bl       #0x107c27c74 ; _objc_retain
0x104def6cc: str      x20, [sp, #0xc8]
0x104def6d0: mov      x0, x19
0x104def6d4: bl       #0x107c27c74 ; _objc_retain
0x104def6d8: str      x19, [sp, #0xd0]
0x104def6dc: adrp     x8, #0x11e9c9000
0x104def6e0: ldr      x1, [x8, #0xe58] ; @selector(callExtension:selector:block:) | 'callExtension:selector:block:'
0x104def6e4: add      x4, sp, #0xa8
0x104def6e8: mov      x0, x21
0x104def6ec: mov      x2, x22
0x104def6f0: mov      x3, x23 ; 'onRevChatSyncRequest:MsgWrap:'
0x104def6f4: bl       #0x107c27c64 ; _objc_msgSend | selector=callExtension:selector:block:
0x104def6f8: mov      x0, x21
0x104def6fc: bl       #0x107c27c70 ; _objc_release
0x104def700: ldr      x0, [sp, #0xd0]
0x104def704: bl       #0x107c27c70 ; _objc_release
0x104def708: ldr      x0, [sp, #0xc8]
0x104def70c: bl       #0x107c27c70 ; _objc_release
0x104def710: b        #0x104defa98
0x104def714: adrp     x1, #0x119bbb000 ; '-scene Enter all value not supported!'
0x104def718: add      x1, x1, #0x807 ; 'sysmsg'
0x104def71c: mov      x0, x21
0x104def720: bl       #0x107c0cc48
0x104def724: cbz      x0, #0x104def99c
0x104def728: adrp     x1, #0x11a805000 ; '刷掌模型资源'
0x104def72c: add      x1, x1, #0x2d2 ; 'type'
0x104def730: bl       #0x107c0cc3c
0x104def734: mov      x21, x0
0x104def738: bl       #0x107c27dd8 ; _strlen
0x104def73c: mov      x23, x0
0x104def740: add      x25, sp, #0x90
0x104def744: add      x0, sp, #0x90
0x104def748: mov      x1, x23
0x104def74c: bl       #0x100080888
0x104def750: mov      x24, x0
0x104def754: mov      x1, x21
0x104def758: mov      x2, x23
0x104def75c: bl       #0x107c27bc4 ; _memmove
0x104def760: strb     wzr, [x24, x23]
0x104def764: adrp     x8, #0x11ed12000
0x104def768: ldr      x0, [x8, #0x638] ; _OBJC_CLASS_$_NSString
0x104def76c: ldrsb    w8, [sp, #0xa7]
0x104def770: ldr      x9, [sp, #0x90]
0x104def774: cmp      w8, #0
0x104def778: csel     x8, x9, x25, lt
0x104def77c: adrp     x9, #0x11a7de000 ; 'BrandProfile_ArticleModifyInProgress'
0x104def780: add      x9, x9, #0x6a0 ; ''
0x104def784: cmp      x8, #0
0x104def788: csel     x2, x9, x8, eq
0x104def78c: adrp     x8, #0x11ecad000 ; @selector(sharedApplication)
0x104def790: ldr      x1, [x8, #0x5d8] ; @selector(stringWithUTF8String:) | 'stringWithUTF8String:'
0x104def794: bl       #0x107c27c64 ; _objc_msgSend | selector=stringWithUTF8String:
0x104def798: mov      x29, x29
0x104def79c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104def7a0: mov      x21, x0
0x104def7a4: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x104def7a8: ldr      x23, [x8, #0xce8] ; @selector(length) | 'length'
0x104def7ac: mov      x1, x23 ; 'length'
0x104def7b0: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x104def7b4: adrp     x26, #0x11ed12000
0x104def7b8: ldr      x24, [x26, #0x618] ; classref iConsole | Class iConsole
0x104def7bc: cbz      x0, #0x104def9e4
0x104def7c0: adrp     x8, #0x11e9cc000 ; @selector(setCenterY:)
0x104def7c4: ldr      x1, [x8, #0xfd0] ; @selector(m_n64MesSvrID) | 'm_n64MesSvrID'
0x104def7c8: mov      x0, x19
0x104def7cc: bl       #0x107c27c64 ; _objc_msgSend | selector=m_n64MesSvrID
0x104def7d0: adrp     x8, #0x11e9c9000
0x104def7d4: ldr      x25, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x104def7d8: stp      x21, x0, [sp, #8]
0x104def7dc: adrp     x8, #0x11d2c2000
0x104def7e0: add      x8, x8, #0xb98 ; @'handle syscmd type:%@, svrid:%llu'
0x104def7e4: str      x8, [sp] ; @'handle syscmd type:%@, svrid:%llu'
0x104def7e8: adrp     x5, #0x11a1b9000 ; 'otImage for appId=%@'
0x104def7ec: add      x5, x5, #0xfe2 ; 'MessageMgr.mm'
0x104def7f0: adrp     x7, #0x11a1bc000 ; 'er message! %@'
0x104def7f4: add      x7, x7, #0x113 ; '-[CMessageMgr HandleSvrCmd:MsgWrap:]'
0x104def7f8: mov      x0, x24 ; Class iConsole
0x104def7fc: mov      x1, x25 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x104def800: mov      w2, #2
0x104def804: mov      x3, #0
0x104def808: mov      w4, #0
0x104def80c: mov      w6, #0xf9e
0x104def810: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x104def814: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x104def818: ldr      x24, [x8, #0x7b8] ; @selector(isEqualToString:) | 'isEqualToString:'
0x104def81c: adrp     x2, #0x11cfbd000
0x104def820: add      x2, x2, #0x2f8 ; @'revokemsg'
0x104def824: mov      x0, x21
0x104def828: mov      x1, x24 ; 'isEqualToString:'
0x104def82c: bl       #0x107c27c64 ; _objc_msgSend | selector=isEqualToString:
0x104def830: cbz      w0, #0x104defa28
0x104def834: ldr      x0, [x26, #0x618] ; classref iConsole | Class iConsole
0x104def838: adrp     x8, #0x11cfbd000
0x104def83c: add      x8, x8, #0x318 ; @'is revoke msg'
0x104def840: str      x8, [sp] ; @'is revoke msg'
0x104def844: adrp     x3, #0x119ba3000 ; 'cordMessageCellView'
0x104def848: add      x3, x3, #0x1d9 ; 'Msg'
0x104def84c: adrp     x5, #0x11a1b9000 ; 'otImage for appId=%@'
0x104def850: add      x5, x5, #0xfe2 ; 'MessageMgr.mm'
0x104def854: adrp     x7, #0x11a1bc000 ; 'er message! %@'
0x104def858: add      x7, x7, #0x113 ; '-[CMessageMgr HandleSvrCmd:MsgWrap:]'
0x104def85c: mov      x1, x25 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x104def860: mov      w2, #1
0x104def864: mov      w4, #0
0x104def868: mov      w6, #0xfa1
0x104def86c: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x104def870: adrp     x28, #0x11ed12000
0x104def874: ldr      x0, [x28, #0x780] ; classref MMContext | Class MMContext
0x104def878: adrp     x8, #0x11e9c9000
0x104def87c: ldr      x22, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x104def880: mov      x1, x22 ; 'currentContext'
0x104def884: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104def888: mov      x29, x29
0x104def88c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104def890: mov      x23, x0
0x104def894: adrp     x8, #0x11ed14000 ; classref SilkAudioCodec
0x104def898: ldr      x0, [x8, #0xed0] ; classref MessageRevokeMgr | Class MessageRevokeMgr
0x104def89c: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104def8a0: ldr      x24, [x8, #0x508] ; @selector(class) | 'class'
0x104def8a4: mov      x1, x24 ; 'class'
0x104def8a8: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104def8ac: mov      x2, x0
0x104def8b0: adrp     x8, #0x11e9c9000
0x104def8b4: ldr      x25, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x104def8b8: mov      x0, x23
0x104def8bc: mov      x1, x25 ; 'getService:'
0x104def8c0: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104def8c4: mov      x29, x29
0x104def8c8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104def8cc: mov      x26, x0
0x104def8d0: adrp     x8, #0x11e9db000 ; @selector(dr_setDynamicParamsBlock)
0x104def8d4: ldr      x27, [x8, #8] ; @selector(onRevokeMsg:) | 'onRevokeMsg:'
0x104def8d8: mov      x1, x27 ; 'onRevokeMsg:'
0x104def8dc: mov      x2, x19
0x104def8e0: bl       #0x107c27c64 ; _objc_msgSend | selector=onRevokeMsg:
0x104def8e4: mov      x0, x26
0x104def8e8: bl       #0x107c27c70 ; _objc_release
0x104def8ec: mov      x0, x23
0x104def8f0: bl       #0x107c27c70 ; _objc_release
0x104def8f4: ldr      x0, [x28, #0x780] ; classref MMContext | Class MMContext
0x104def8f8: mov      x1, x22 ; 'currentContext'
0x104def8fc: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104def900: mov      x29, x29
0x104def904: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104def908: mov      x22, x0
0x104def90c: adrp     x8, #0x11ed14000 ; classref SilkAudioCodec
0x104def910: ldr      x0, [x8, #0xec8] ; classref MessageBatchRevokeMgr | Class MessageBatchRevokeMgr
0x104def914: mov      x1, x24 ; 'class'
0x104def918: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104def91c: mov      x2, x0
0x104def920: mov      x0, x22
0x104def924: mov      x1, x25 ; 'getService:'
0x104def928: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104def92c: mov      x29, x29
0x104def930: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104def934: mov      x23, x0
0x104def938: mov      x1, x27 ; 'onRevokeMsg:'
0x104def93c: mov      x2, x19
0x104def940: bl       #0x107c27c64 ; _objc_msgSend | selector=onRevokeMsg:
0x104def944: mov      x0, x23
0x104def948: bl       #0x107c27c70 ; _objc_release
0x104def94c: mov      x0, x22
0x104def950: bl       #0x107c27c70 ; _objc_release
0x104def954: b        #0x104defa78
0x104def958: adrp     x8, #0x11ed12000
0x104def95c: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x104def960: adrp     x8, #0x11e9c9000
0x104def964: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x104def968: adrp     x8, #0x11cfbd000
0x104def96c: add      x8, x8, #0x298 ; @'return for get rootNode failed! msg: %@'
0x104def970: stp      x8, x19, [sp] ; @'return for get rootNode failed! msg: %@'
0x104def974: adrp     x3, #0x119ba3000 ; 'cordMessageCellView'
0x104def978: add      x3, x3, #0x1d9 ; 'Msg'
0x104def97c: adrp     x5, #0x11a1b9000 ; 'otImage for appId=%@'
0x104def980: add      x5, x5, #0xfe2 ; 'MessageMgr.mm'
0x104def984: adrp     x7, #0x11a1bc000 ; 'er message! %@'
0x104def988: add      x7, x7, #0x113 ; '-[CMessageMgr HandleSvrCmd:MsgWrap:]'
0x104def98c: mov      w2, #4
0x104def990: mov      w4, #0
0x104def994: mov      w6, #0xf81
0x104def998: b        #0x104def9dc
0x104def99c: adrp     x8, #0x11ed12000
0x104def9a0: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x104def9a4: adrp     x8, #0x11e9c9000
0x104def9a8: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x104def9ac: adrp     x8, #0x11cfbd000
0x104def9b0: add      x8, x8, #0x2b8 ; @'return for get sysmsg failed! msg: %@'
0x104def9b4: stp      x8, x19, [sp] ; @'return for get sysmsg failed! msg: %@'
0x104def9b8: adrp     x3, #0x119ba3000 ; 'cordMessageCellView'
0x104def9bc: add      x3, x3, #0x1d9 ; 'Msg'
0x104def9c0: adrp     x5, #0x11a1b9000 ; 'otImage for appId=%@'
0x104def9c4: add      x5, x5, #0xfe2 ; 'MessageMgr.mm'
0x104def9c8: adrp     x7, #0x11a1bc000 ; 'er message! %@'
0x104def9cc: add      x7, x7, #0x113 ; '-[CMessageMgr HandleSvrCmd:MsgWrap:]'
0x104def9d0: mov      w2, #4
0x104def9d4: mov      w4, #0
0x104def9d8: mov      w6, #0xf94
0x104def9dc: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x104def9e0: b        #0x104defa98
0x104def9e4: adrp     x8, #0x11e9c9000
0x104def9e8: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x104def9ec: adrp     x8, #0x11cfbd000
0x104def9f0: add      x8, x8, #0x2d8 ; @'return for get type failed! msg: %@'
0x104def9f4: stp      x8, x19, [sp] ; @'return for get type failed! msg: %@'
0x104def9f8: adrp     x3, #0x119ba3000 ; 'cordMessageCellView'
0x104def9fc: add      x3, x3, #0x1d9 ; 'Msg'
0x104defa00: adrp     x5, #0x11a1b9000 ; 'otImage for appId=%@'
0x104defa04: add      x5, x5, #0xfe2 ; 'MessageMgr.mm'
0x104defa08: adrp     x7, #0x11a1bc000 ; 'er message! %@'
0x104defa0c: add      x7, x7, #0x113 ; '-[CMessageMgr HandleSvrCmd:MsgWrap:]'
0x104defa10: mov      x0, x24 ; 'class'
0x104defa14: mov      w2, #4
0x104defa18: mov      w4, #0
0x104defa1c: mov      w6, #0xf9a
0x104defa20: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x104defa24: b        #0x104defa78
0x104defa28: adrp     x2, #0x11d2c2000
0x104defa2c: add      x2, x2, #0xbb8 ; @'secmsg'
0x104defa30: mov      x0, x21
0x104defa34: mov      x1, x24 ; 'class'
0x104defa38: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104defa3c: cbz      w0, #0x104defa4c
0x104defa40: adrp     x8, #0x11eb24000 ; @selector(setM_firstSendTime:)
0x104defa44: ldr      x1, [x8, #0x370] ; @selector(onSecMsg:) | 'onSecMsg:'
0x104defa48: b        #0x104defa6c
0x104defa4c: adrp     x2, #0x11d2c2000
0x104defa50: add      x2, x2, #0xbd8 ; @'wxchatbot_loginauth'
0x104defa54: mov      x0, x21
0x104defa58: mov      x1, x24 ; 'class'
0x104defa5c: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104defa60: cbz      w0, #0x104defad4
0x104defa64: adrp     x8, #0x11eb24000 ; @selector(setM_firstSendTime:)
0x104defa68: ldr      x1, [x8, #0x378] ; @selector(onChatBotLoginAuth:) | 'onChatBotLoginAuth:'
0x104defa6c: mov      x0, x22
0x104defa70: mov      x2, x19
0x104defa74: bl       #0x107c27c64 ; _objc_msgSend | selector=onChatBotLoginAuth:
0x104defa78: mov      x0, x21
0x104defa7c: bl       #0x107c27c70 ; _objc_release
0x104defa80: ldrsb    w8, [sp, #0xa7]
0x104defa84: tbz      w8, #0x1f, #0x104defa98
0x104defa88: ldr      x0, [sp, #0x90]
0x104defa8c: ldr      x8, [sp, #0xa0]
0x104defa90: and      x1, x8, #0x7fffffffffffffff
0x104defa94: bl       #0x107c276f0 ; __ZdlPvm
0x104defa98: sub      x0, x29, #0x88
0x104defa9c: bl       #0x107c0cc60
0x104defaa0: mov      x0, x19
0x104defaa4: bl       #0x107c27c70 ; _objc_release
0x104defaa8: mov      x0, x20
0x104defaac: bl       #0x107c27c70 ; _objc_release
0x104defab0: ldp      x29, x30, [sp, #0x160]
0x104defab4: ldp      x20, x19, [sp, #0x150]
0x104defab8: ldp      x22, x21, [sp, #0x140]
0x104defabc: ldp      x24, x23, [sp, #0x130] ; 'class'
0x104defac0: ldp      x26, x25, [sp, #0x120]
0x104defac4: ldp      x28, x27, [sp, #0x110]
0x104defac8: ldp      d9, d8, [sp, #0x100]
0x104defacc: add      sp, sp, #0x170
0x104defad0: ret      
0x104defad4: adrp     x2, #0x11d2c2000
0x104defad8: add      x2, x2, #0xbf8 ; @'revokehistoryinjoinroommsg'
0x104defadc: mov      x0, x21
0x104defae0: mov      x1, x24 ; 'class'
0x104defae4: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104defae8: cbz      w0, #0x104defaf8
0x104defaec: adrp     x8, #0x11eb24000 ; @selector(setM_firstSendTime:)
0x104defaf0: ldr      x1, [x8, #0x380] ; @selector(onRevokeRoomHistory:msg:) | 'onRevokeRoomHistory:msg:'
0x104defaf4: b        #0x104defb18
0x104defaf8: adrp     x2, #0x11d2c2000
0x104defafc: add      x2, x2, #0xc18 ; @'uploadfinishmsg'
0x104defb00: mov      x0, x21
0x104defb04: mov      x1, x24 ; 'class'
0x104defb08: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104defb0c: cbz      w0, #0x104defb2c
0x104defb10: adrp     x8, #0x11eb24000 ; @selector(setM_firstSendTime:)
0x104defb14: ldr      x1, [x8, #0x388] ; @selector(onReceiveFileMsgUploadNotice:msg:) | 'onReceiveFileMsgUploadNotice:msg:'
0x104defb18: mov      x0, x22
0x104defb1c: mov      x2, x20
0x104defb20: mov      x3, x19
0x104defb24: bl       #0x107c27c64 ; _objc_msgSend | selector=onReceiveFileMsgUploadNotice:msg:
0x104defb28: b        #0x104defa78
0x104defb2c: adrp     x8, #0x11e9dc000 ; @selector(SendNotGameEmoticonMessage:errorMsg:)
0x104defb30: ldr      x1, [x8, #0x138] ; @selector(m_nsSpecifiedChatName) | 'm_nsSpecifiedChatName'
0x104defb34: mov      x0, x19
0x104defb38: bl       #0x107c27c64 ; _objc_msgSend | selector=m_nsSpecifiedChatName
0x104defb3c: mov      x29, x29
0x104defb40: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104defb44: mov      x22, x0
0x104defb48: mov      x1, x23
0x104defb4c: bl       #0x107c27c64 ; _objc_msgSend
0x104defb50: mov      x23, x0
0x104defb54: mov      x0, x22
0x104defb58: bl       #0x107c27c70 ; _objc_release
0x104defb5c: cbz      x23, #0x104defb6c
0x104defb60: adrp     x8, #0x11e9c9000
0x104defb64: ldr      x22, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x104defb68: b        #0x104defc2c
0x104defb6c: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x104defb70: ldr      x23, [x8, #0x578] ; @selector(m_nsFromUsr) | 'm_nsFromUsr'
0x104defb74: mov      x0, x19
0x104defb78: mov      x1, x23 ; 'm_nsFromUsr'
0x104defb7c: bl       #0x107c27c64 ; _objc_msgSend | selector=m_nsFromUsr
0x104defb80: mov      x29, x29
0x104defb84: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104defb88: mov      x25, x0
0x104defb8c: adrp     x8, #0x11ed12000
0x104defb90: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x104defb94: adrp     x8, #0x11e9c9000
0x104defb98: ldr      x22, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x104defb9c: mov      x1, x22 ; 'currentContext'
0x104defba0: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104defba4: mov      x29, x29
0x104defba8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104defbac: mov      x26, x0
0x104defbb0: adrp     x8, #0x11e9cc000 ; @selector(setCenterY:)
0x104defbb4: ldr      x1, [x8, #0xa70] ; @selector(userName) | 'userName'
0x104defbb8: bl       #0x107c27c64 ; _objc_msgSend | selector=userName
0x104defbbc: mov      x29, x29
0x104defbc0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104defbc4: mov      x27, x0
0x104defbc8: mov      x0, x25
0x104defbcc: mov      x1, x24 ; 'class'
0x104defbd0: mov      x2, x27
0x104defbd4: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104defbd8: mov      x24, x0
0x104defbdc: mov      x0, x27
0x104defbe0: bl       #0x107c27c70 ; _objc_release
0x104defbe4: mov      x0, x26
0x104defbe8: bl       #0x107c27c70 ; _objc_release
0x104defbec: mov      x0, x25
0x104defbf0: bl       #0x107c27c70 ; _objc_release
0x104defbf4: cbz      w24, #0x104defc08
0x104defbf8: adrp     x8, #0x11e9cf000 ; @selector(lastUpdateWatermarkTime)
0x104defbfc: ldr      x1, [x8, #0x368] ; @selector(m_nsToUsr) | 'm_nsToUsr'
0x104defc00: mov      x0, x19
0x104defc04: b        #0x104defc10
0x104defc08: mov      x0, x19
0x104defc0c: mov      x1, x23 ; 'm_nsFromUsr'
0x104defc10: bl       #0x107c27c64 ; _objc_msgSend | selector=m_nsFromUsr
0x104defc14: mov      x29, x29
0x104defc18: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104defc1c: mov      x23, x0
0x104defc20: mov      x0, x20
0x104defc24: bl       #0x107c27c70 ; _objc_release
0x104defc28: mov      x20, x23
0x104defc2c: adrp     x8, #0x11ed12000
0x104defc30: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x104defc34: mov      x1, x22 ; 'currentContext'
0x104defc38: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104defc3c: mov      x29, x29
0x104defc40: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104defc44: mov      x24, x0
0x104defc48: adrp     x27, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x104defc4c: ldr      x25, [x27, #0x618]
0x104defc50: adrp     x8, #0x11ea56000 ; @selector(notifyFriendAssistUnreadCountChanged)
0x104defc54: ldr      x23, [x8, #0x418] ; @selector(OnGetNewXmlMsg:Type:MsgWrap:) | 'OnGetNewXmlMsg:Type:MsgWrap:'
0x104defc58: adrp     x28, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x104defc5c: ldr      x28, [x28, #0x930] ; __NSConcreteStackBlock
0x104defc60: str      x28, [sp, #0x58]
0x104defc64: adrp     x8, #0x1178c7000
0x104defc68: ldr      d8, [x8, #0x680]
0x104defc6c: str      d8, [sp, #0x60]
0x104defc70: adrp     x8, #0x104def000
0x104defc74: add      x8, x8, #0xd94
0x104defc78: adrp     x26, #0x11c298000
0x104defc7c: add      x26, x26, #0x8c0
0x104defc80: stp      x8, x26, [sp, #0x68]
0x104defc84: mov      x0, x20
0x104defc88: bl       #0x107c27c74 ; _objc_retain
0x104defc8c: str      x20, [sp, #0x78]
0x104defc90: mov      x0, x21
0x104defc94: bl       #0x107c27c74 ; _objc_retain
0x104defc98: str      x21, [sp, #0x80]
0x104defc9c: mov      x0, x19
0x104defca0: bl       #0x107c27c74 ; _objc_retain
0x104defca4: str      x19, [sp, #0x88]
0x104defca8: adrp     x8, #0x11e9c9000
0x104defcac: ldr      x1, [x8, #0xe58] ; @selector(callExtension:selector:block:) | 'callExtension:selector:block:'
0x104defcb0: add      x4, sp, #0x58
0x104defcb4: mov      x0, x24
0x104defcb8: mov      x2, x25
0x104defcbc: mov      x3, x23 ; 'OnGetNewXmlMsg:Type:MsgWrap:'
0x104defcc0: bl       #0x107c27c64 ; _objc_msgSend | selector=callExtension:selector:block:
0x104defcc4: mov      x0, x24
0x104defcc8: bl       #0x107c27c70 ; _objc_release
0x104defccc: ldr      x0, [sp, #0x88]
0x104defcd0: bl       #0x107c27c70 ; _objc_release
0x104defcd4: ldr      x0, [sp, #0x80]
0x104defcd8: bl       #0x107c27c70 ; _objc_release
0x104defcdc: ldr      x0, [sp, #0x78]
0x104defce0: bl       #0x107c27c70 ; _objc_release
0x104defce4: adrp     x8, #0x11ed12000
0x104defce8: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x104defcec: mov      x1, x22 ; 'currentContext'
0x104defcf0: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104defcf4: mov      x29, x29
0x104defcf8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104defcfc: mov      x22, x0
0x104defd00: ldr      x24, [x27, #0x618]
0x104defd04: str      x28, [sp, #0x20]
0x104defd08: str      d8, [sp, #0x28]
0x104defd0c: adrp     x8, #0x104def000
0x104defd10: add      x8, x8, #0xdb0
0x104defd14: stp      x8, x26, [sp, #0x30]
0x104defd18: mov      x0, x20
0x104defd1c: bl       #0x107c27c74 ; _objc_retain
0x104defd20: str      x20, [sp, #0x40]
0x104defd24: mov      x0, x21
0x104defd28: bl       #0x107c27c74 ; _objc_retain
0x104defd2c: str      x21, [sp, #0x48]
0x104defd30: mov      x0, x19
0x104defd34: bl       #0x107c27c74 ; _objc_retain
0x104defd38: str      x19, [sp, #0x50]
0x104defd3c: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x104defd40: ldr      x1, [x8, #0x838] ; @selector(callKeyExtension:key:selector:block:) | 'callKeyExtension:key:selector:block:'
0x104defd44: add      x5, sp, #0x20
0x104defd48: mov      x0, x22
0x104defd4c: mov      x2, x24
0x104defd50: mov      x3, x21
0x104defd54: mov      x4, x23 ; 'OnGetNewXmlMsg:Type:MsgWrap:'
0x104defd58: bl       #0x107c27c64 ; _objc_msgSend | selector=callKeyExtension:key:selector:block:
0x104defd5c: mov      x0, x22
0x104defd60: bl       #0x107c27c70 ; _objc_release
0x104defd64: ldr      x0, [sp, #0x50]
0x104defd68: bl       #0x107c27c70 ; _objc_release
0x104defd6c: ldr      x0, [sp, #0x48]
0x104defd70: bl       #0x107c27c70 ; _objc_release
0x104defd74: ldr      x0, [sp, #0x40]
0x104defd78: b        #0x104def950
