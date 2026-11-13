-[SyncCmdHandler processSpecialMessage:] 0x105e412d0 B24@0:8@16
0x105e412d0: sub      sp, sp, #0x70
0x105e412d4: stp      x22, x21, [sp, #0x40]
0x105e412d8: stp      x20, x19, [sp, #0x50]
0x105e412dc: stp      x29, x30, [sp, #0x60]
0x105e412e0: add      x29, sp, #0x60
0x105e412e4: mov      x19, x2
0x105e412e8: adrp     x8, #0x11f755000
0x105e412ec: mov      w9, #1
0x105e412f0: strb     w9, [x8, #0x8f2]
0x105e412f4: mov      x0, x2
0x105e412f8: bl       #0x107c27c74 ; _objc_retain
0x105e412fc: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x105e41300: ldr      x1, [x8, #0x578] ; @selector(m_nsFromUsr) | 'm_nsFromUsr'
0x105e41304: mov      x0, x19
0x105e41308: bl       #0x107c27c64 ; _objc_msgSend | selector=m_nsFromUsr
0x105e4130c: mov      x29, x29
0x105e41310: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e41314: mov      x21, x0
0x105e41318: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105e4131c: ldr      x1, [x8, #0x7b8] ; @selector(isEqualToString:) | 'isEqualToString:'
0x105e41320: adrp     x2, #0x11cfac000
0x105e41324: add      x2, x2, #0xdb8 ; @'weixin'
0x105e41328: bl       #0x107c27c64 ; _objc_msgSend | selector=isEqualToString:
0x105e4132c: cbz      w0, #0x105e41438
0x105e41330: adrp     x8, #0x11e9ce000 ; @selector(onAddMsg:roomID:)
0x105e41334: ldr      x20, [x8, #0x3f0] ; @selector(m_uiMessageType) | 'm_uiMessageType'
0x105e41338: mov      x0, x19
0x105e4133c: mov      x1, x20 ; 'm_uiMessageType'
0x105e41340: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiMessageType
0x105e41344: mov      x22, x0
0x105e41348: mov      x0, x21
0x105e4134c: bl       #0x107c27c70 ; _objc_release
0x105e41350: mov      w8, #0x270e
0x105e41354: cmp      w22, w8
0x105e41358: b.ne     #0x105e41448
0x105e4135c: adrp     x8, #0x11ed12000
0x105e41360: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e41364: adrp     x8, #0x11e9c9000
0x105e41368: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105e4136c: adrp     x8, #0x11d353000
0x105e41370: add      x8, x8, #0x8b8 ; @'recv ipxx'
0x105e41374: str      x8, [sp] ; @'recv ipxx'
0x105e41378: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105e4137c: add      x3, x3, #0xfaf ; 'Sync'
0x105e41380: adrp     x5, #0x11a2e0000 ; 'tice?language='
0x105e41384: add      x5, x5, #0x21 ; 'SyncCmdHandler.mm'
0x105e41388: adrp     x7, #0x11a2e0000 ; 'tice?language='
0x105e4138c: add      x7, x7, #0x39d ; '-[SyncCmdHandler processSpecialMessage:]'
0x105e41390: mov      w2, #2
0x105e41394: mov      w4, #0
0x105e41398: mov      w6, #0x186
0x105e4139c: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105e413a0: adrp     x8, #0x11ed12000
0x105e413a4: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e413a8: adrp     x8, #0x11e9c9000
0x105e413ac: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105e413b0: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105e413b4: mov      x29, x29
0x105e413b8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e413bc: mov      x20, x0
0x105e413c0: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e413c4: ldr      x21, [x8, #0x760]
0x105e413c8: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e413cc: ldr      x22, [x8, #0x7a0] ; @selector(onNewSyncIPXX:) | 'onNewSyncIPXX:'
0x105e413d0: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e413d4: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e413d8: str      x8, [sp, #0x18]
0x105e413dc: adrp     x8, #0x1178c7000
0x105e413e0: ldr      d0, [x8, #0x680]
0x105e413e4: str      d0, [sp, #0x20]
0x105e413e8: adrp     x8, #0x105e41000
0x105e413ec: add      x8, x8, #0x594
0x105e413f0: adrp     x9, #0x11c280000
0x105e413f4: add      x9, x9, #0x7e0
0x105e413f8: stp      x8, x9, [sp, #0x28]
0x105e413fc: mov      x0, x19
0x105e41400: bl       #0x107c27c74 ; _objc_retain
0x105e41404: str      x19, [sp, #0x38]
0x105e41408: adrp     x8, #0x11e9c9000
0x105e4140c: ldr      x1, [x8, #0xf70] ; @selector(callExtensionOnMainThread:selector:sync:block:) | 'callExtensionOnMainThread:selector:sync:block:'
0x105e41410: add      x5, sp, #0x18
0x105e41414: mov      x0, x20
0x105e41418: mov      x2, x21
0x105e4141c: mov      x3, x22 ; 'onNewSyncIPXX:'
0x105e41420: mov      w4, #0
0x105e41424: bl       #0x107c27c64 ; _objc_msgSend | selector=callExtensionOnMainThread:selector:sync:block:
0x105e41428: mov      x0, x20
0x105e4142c: bl       #0x107c27c70 ; _objc_release
0x105e41430: ldr      x0, [sp, #0x38]
0x105e41434: b        #0x105e41508
0x105e41438: mov      x0, x21
0x105e4143c: bl       #0x107c27c70 ; _objc_release
0x105e41440: adrp     x8, #0x11e9ce000 ; @selector(onAddMsg:roomID:)
0x105e41444: ldr      x20, [x8, #0x3f0] ; @selector(m_uiMessageType) | 'm_uiMessageType'
0x105e41448: mov      x0, x19
0x105e4144c: mov      x1, x20 ; 'm_uiMessageType'
0x105e41450: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiMessageType
0x105e41454: mov      w8, #0x270f
0x105e41458: cmp      w0, w8
0x105e4145c: b.ne     #0x105e41510
0x105e41460: adrp     x8, #0x11ed12000
0x105e41464: ldr      x20, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e41468: adrp     x8, #0x11e9ce000 ; @selector(onAddMsg:roomID:)
0x105e4146c: ldr      x21, [x8, #0x460] ; @selector(m_nsContent) | 'm_nsContent'
0x105e41470: mov      x0, x19
0x105e41474: mov      x1, x21 ; 'm_nsContent'
0x105e41478: bl       #0x107c27c64 ; _objc_msgSend | selector=m_nsContent
0x105e4147c: mov      x29, x29
0x105e41480: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e41484: mov      x22, x0
0x105e41488: adrp     x8, #0x11e9c9000
0x105e4148c: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105e41490: adrp     x8, #0x11d353000
0x105e41494: add      x8, x8, #0x8d8 ; @'SysNotice:%@'
0x105e41498: stp      x8, x0, [sp] ; @'SysNotice:%@'
0x105e4149c: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105e414a0: add      x3, x3, #0xfaf ; 'Sync'
0x105e414a4: adrp     x5, #0x11a2e0000 ; 'tice?language='
0x105e414a8: add      x5, x5, #0x21 ; 'SyncCmdHandler.mm'
0x105e414ac: adrp     x7, #0x11a2e0000 ; 'tice?language='
0x105e414b0: add      x7, x7, #0x39d ; '-[SyncCmdHandler processSpecialMessage:]'
0x105e414b4: mov      x0, x20 ; Class iConsole
0x105e414b8: mov      w2, #2
0x105e414bc: mov      w4, #0
0x105e414c0: mov      w6, #0x18e
0x105e414c4: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105e414c8: mov      x0, x22
0x105e414cc: bl       #0x107c27c70 ; _objc_release
0x105e414d0: adrp     x8, #0x11ed37000 ; classref GetEmotionRewardRequest
0x105e414d4: ldr      x20, [x8, #0x158] ; classref CUpdateInfo | Class CUpdateInfo
0x105e414d8: mov      x0, x19
0x105e414dc: mov      x1, x21 ; 'm_nsContent'
0x105e414e0: bl       #0x107c27c64 ; _objc_msgSend | selector=m_nsContent
0x105e414e4: mov      x29, x29
0x105e414e8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e414ec: mov      x21, x0
0x105e414f0: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e414f4: ldr      x1, [x8, #0x7a8] ; @selector(updateSysNotice:) | 'updateSysNotice:'
0x105e414f8: mov      x0, x20 ; Class CUpdateInfo
0x105e414fc: mov      x2, x21
0x105e41500: bl       #0x107c27c64 ; _objc_msgSend | selector=updateSysNotice:
0x105e41504: mov      x0, x21
0x105e41508: bl       #0x107c27c70 ; _objc_release
0x105e4150c: b        #0x105e41568
0x105e41510: mov      x0, x19
0x105e41514: mov      x1, x20 ; Class CUpdateInfo
0x105e41518: bl       #0x107c27c64 ; _objc_msgSend | selector=�	
0x105e4151c: cmp      w0, #0x24
0x105e41520: b.ne     #0x105e4158c
0x105e41524: adrp     x8, #0x11ed12000
0x105e41528: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e4152c: adrp     x8, #0x11e9c9000
0x105e41530: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105e41534: adrp     x8, #0x11d353000
0x105e41538: add      x8, x8, #0x8f8 ; @'Ignore qq msg'
0x105e4153c: str      x8, [sp] ; @'Ignore qq msg'
0x105e41540: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105e41544: add      x3, x3, #0xfaf ; 'Sync'
0x105e41548: adrp     x5, #0x11a2e0000 ; 'tice?language='
0x105e4154c: add      x5, x5, #0x21 ; 'SyncCmdHandler.mm'
0x105e41550: adrp     x7, #0x11a2e0000 ; 'tice?language='
0x105e41554: add      x7, x7, #0x39d ; '-[SyncCmdHandler processSpecialMessage:]'
0x105e41558: mov      w2, #2
0x105e4155c: mov      w4, #0
0x105e41560: mov      w6, #0x195
0x105e41564: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105e41568: mov      w20, #1
0x105e4156c: mov      x0, x19
0x105e41570: bl       #0x107c27c70 ; _objc_release
0x105e41574: mov      x0, x20 ; Class CUpdateInfo
0x105e41578: ldp      x29, x30, [sp, #0x60]
0x105e4157c: ldp      x20, x19, [sp, #0x50] ; Class CUpdateInfo
0x105e41580: ldp      x22, x21, [sp, #0x40]
0x105e41584: add      sp, sp, #0x70
0x105e41588: ret      
0x105e4158c: mov      w20, #0
0x105e41590: b        #0x105e4156c
