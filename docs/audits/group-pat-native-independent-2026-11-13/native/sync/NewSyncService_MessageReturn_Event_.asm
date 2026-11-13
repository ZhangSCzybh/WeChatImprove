-[NewSyncService MessageReturn:Event:] 0x105463690 v28@0:8@16I24
0x105463690: sub      sp, sp, #0x60
0x105463694: stp      x24, x23, [sp, #0x20]
0x105463698: stp      x22, x21, [sp, #0x30]
0x10546369c: stp      x20, x19, [sp, #0x40]
0x1054636a0: stp      x29, x30, [sp, #0x50]
0x1054636a4: add      x29, sp, #0x50
0x1054636a8: mov      x21, x3
0x1054636ac: mov      x19, x2
0x1054636b0: mov      x20, x0
0x1054636b4: adrp     x8, #0x11f753000
0x1054636b8: mov      w9, #1
0x1054636bc: strb     w9, [x8, #0x47e]
0x1054636c0: mov      x0, x2
0x1054636c4: bl       #0x107c27c74 ; _objc_retain
0x1054636c8: adrp     x8, #0x11e9c9000
0x1054636cc: ldr      x22, [x8, #0xc28] ; @selector(m_uiCgi) | 'm_uiCgi'
0x1054636d0: mov      x0, x19
0x1054636d4: mov      x1, x22 ; 'm_uiCgi'
0x1054636d8: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiCgi
0x1054636dc: cmp      w0, #0x2a9
0x1054636e0: b.ne     #0x105463700
0x1054636e4: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x1054636e8: ldr      x1, [x8, #0xc20] ; @selector(HandleOplog:Event:) | 'HandleOplog:Event:'
0x1054636ec: mov      x0, x20
0x1054636f0: mov      x2, x19
0x1054636f4: mov      x3, x21
0x1054636f8: bl       #0x107c27c64 ; _objc_msgSend | selector=HandleOplog:Event:
0x1054636fc: b        #0x105463a0c
0x105463700: mov      x0, x19
0x105463704: mov      x1, x22 ; 'm_uiCgi'
0x105463708: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiCgi
0x10546370c: cmp      w0, #0x8a
0x105463710: b.ne     #0x1054638c0
0x105463714: adrp     x8, #0x11edca000
0x105463718: ldrsw    x8, [x8, #0x8e8] ; ivar_offset NewSyncService.m_syncEventID=0x50
0x10546371c: str      wzr, [x20, x8]
0x105463720: adrp     x8, #0x11ed12000
0x105463724: ldr      x23, [x8, #0x618] ; classref iConsole | Class iConsole
0x105463728: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x10546372c: ldr      x22, [x8, #0xce0] ; @selector(m_uiMessage) | 'm_uiMessage'
0x105463730: mov      x0, x19
0x105463734: mov      x1, x22 ; 'm_uiMessage'
0x105463738: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiMessage
0x10546373c: adrp     x8, #0x11e9c9000
0x105463740: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105463744: stp      x21, x0, [sp, #8]
0x105463748: adrp     x8, #0x11d2f6000
0x10546374c: add      x8, x8, #0xef8 ; @'EventID: %u, message:%u'
0x105463750: str      x8, [sp] ; @'EventID: %u, message:%u'
0x105463754: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105463758: add      x3, x3, #0xfaf ; 'Sync'
0x10546375c: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105463760: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105463764: adrp     x7, #0x11a21f000 ; 'llu,%llu'
0x105463768: add      x7, x7, #0xf9f ; '-[NewSyncService MessageReturn:Event:]'
0x10546376c: mov      x0, x23 ; Class iConsole
0x105463770: mov      w2, #2
0x105463774: mov      w4, #0
0x105463778: mov      w6, #0x22d
0x10546377c: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105463780: adrp     x8, #0x11ed12000
0x105463784: ldr      x0, [x8, #0x840] ; classref CAppUtil | Class CAppUtil
0x105463788: adrp     x8, #0x11e9c9000
0x10546378c: ldr      x1, [x8, #0xc30] ; @selector(removePBEventObserverListItem:andValue:) | 'removePBEventObserverListItem:andValue:'
0x105463790: mov      x2, x21
0x105463794: mov      x3, x20
0x105463798: bl       #0x107c27c64 ; _objc_msgSend | selector=removePBEventObserverListItem:andValue:
0x10546379c: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x1054637a0: ldr      x1, [x8, #0x868] ; @selector(m_pbRequest) | 'm_pbRequest'
0x1054637a4: mov      x0, x19
0x1054637a8: bl       #0x107c27c64 ; _objc_msgSend | selector=m_pbRequest
0x1054637ac: mov      x29, x29
0x1054637b0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054637b4: mov      x21, x0
0x1054637b8: adrp     x8, #0x11ecaa000 ; @selector(processIdentifier)
0x1054637bc: ldr      x1, [x8, #0xa60] ; @selector(scene) | 'scene'
0x1054637c0: bl       #0x107c27c64 ; _objc_msgSend | selector=scene
0x1054637c4: cmp      w0, #0xc
0x1054637c8: b.ne     #0x10546380c
0x1054637cc: adrp     x8, #0x11ed12000
0x1054637d0: ldr      x0, [x8, #0x6c8] ; _OBJC_CLASS_$_NSNotificationCenter
0x1054637d4: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x1054637d8: ldr      x1, [x8, #0xcd0] ; @selector(defaultCenter) | 'defaultCenter'
0x1054637dc: bl       #0x107c27c64 ; _objc_msgSend | selector=defaultCenter
0x1054637e0: mov      x29, x29
0x1054637e4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054637e8: mov      x23, x0
0x1054637ec: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x1054637f0: ldr      x1, [x8, #0xf00] ; @selector(postNotificationName:object:) | 'postNotificationName:object:'
0x1054637f4: adrp     x2, #0x11d2ca000
0x1054637f8: add      x2, x2, #0x78 ; @'fetchsyncdone'
0x1054637fc: mov      x3, #0
0x105463800: bl       #0x107c27c64 ; _objc_msgSend | selector=postNotificationName:object:
0x105463804: mov      x0, x23
0x105463808: bl       #0x107c27c70 ; _objc_release
0x10546380c: mov      x0, x19
0x105463810: mov      x1, x22 ; 'm_uiMessage'
0x105463814: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiMessage
0x105463818: cmp      w0, #1
0x10546381c: b.ne     #0x105463994
0x105463820: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105463824: ldr      x1, [x8, #0xaa0] ; @selector(resetGettingData) | 'resetGettingData'
0x105463828: mov      x0, x20
0x10546382c: bl       #0x107c27c64 ; _objc_msgSend | selector=resetGettingData
0x105463830: adrp     x8, #0x11edca000
0x105463834: ldrsw    x8, [x8, #0x8f0] ; ivar_offset NewSyncService.m_lastSyncFinishCallingExtension=0x4c
0x105463838: mov      w9, #1
0x10546383c: strb     w9, [x20, x8]
0x105463840: adrp     x8, #0x11ed12000
0x105463844: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105463848: adrp     x8, #0x11e9c9000
0x10546384c: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105463850: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105463854: mov      x29, x29
0x105463858: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x10546385c: mov      x20, x0
0x105463860: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105463864: ldr      x2, [x8, #0x760]
0x105463868: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x10546386c: ldr      x3, [x8, #0xc28] ; @selector(onNewSyncOplogConnectFail) | 'onNewSyncOplogConnectFail'
0x105463870: adrp     x8, #0x11e9c9000
0x105463874: ldr      x1, [x8, #0xe58] ; @selector(callExtension:selector:block:) | 'callExtension:selector:block:'
0x105463878: adrp     x4, #0x11c2fd000
0x10546387c: add      x4, x4, #0xec8 ; __NSConcreteGlobalBlock
0x105463880: bl       #0x107c27c64 ; _objc_msgSend | selector=callExtension:selector:block:
0x105463884: mov      x0, x20
0x105463888: bl       #0x107c27c70 ; _objc_release
0x10546388c: mov      w0, #0x90
0x105463890: mov      w1, #4
0x105463894: mov      w2, #1
0x105463898: mov      w3, #0
0x10546389c: mov      w4, #0
0x1054638a0: bl       #0x1020ea20c
0x1054638a4: adrp     x1, #0x11d2f6000
0x1054638a8: add      x1, x1, #0xf18 ; @'4,0'
0x1054638ac: mov      w0, #0x8ab9
0x1054638b0: mov      w2, #0
0x1054638b4: mov      w3, #0
0x1054638b8: bl       #0x10241a0cc
0x1054638bc: b        #0x105463a04
0x1054638c0: mov      x0, x19
0x1054638c4: mov      x1, x22 ; 'm_uiMessage'
0x1054638c8: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiMessage
0x1054638cc: cmp      w0, #0x8b
0x1054638d0: b.ne     #0x105463a0c
0x1054638d4: adrp     x8, #0x11ed12000
0x1054638d8: ldr      x20, [x8, #0x618] ; classref iConsole | Class iConsole
0x1054638dc: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x1054638e0: ldr      x22, [x8, #0xce0] ; @selector(m_uiMessage) | 'm_uiMessage'
0x1054638e4: mov      x0, x19
0x1054638e8: mov      x1, x22 ; 'm_uiMessage'
0x1054638ec: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiMessage
0x1054638f0: adrp     x8, #0x11e9c9000
0x1054638f4: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x1054638f8: adrp     x8, #0x11d2f6000
0x1054638fc: add      x8, x8, #0xef8 ; @'EventID: %u, message:%u'
0x105463900: stp      x21, x0, [sp, #8]
0x105463904: str      x8, [sp] ; @'EventID: %u, message:%u'
0x105463908: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x10546390c: add      x3, x3, #0xfaf ; 'Sync'
0x105463910: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105463914: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105463918: adrp     x7, #0x11a21f000 ; 'llu,%llu'
0x10546391c: add      x7, x7, #0xf9f ; '-[NewSyncService MessageReturn:Event:]'
0x105463920: mov      x0, x20 ; Class iConsole
0x105463924: mov      w2, #2
0x105463928: mov      w4, #0
0x10546392c: mov      w6, #0x245
0x105463930: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105463934: mov      x0, x19
0x105463938: mov      x1, x22 ; 'm_uiMessage'
0x10546393c: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiMessage
0x105463940: cmp      w0, #1
0x105463944: b.ne     #0x105463a0c
0x105463948: adrp     x8, #0x11ed12000
0x10546394c: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105463950: adrp     x8, #0x11e9c9000
0x105463954: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105463958: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x10546395c: mov      x29, x29
0x105463960: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105463964: mov      x20, x0
0x105463968: adrp     x8, #0x11ed10000
0x10546396c: ldr      x2, [x8, #0x268]
0x105463970: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105463974: ldr      x3, [x8, #0xc38] ; @selector(onNewInitConnectFail) | 'onNewInitConnectFail'
0x105463978: adrp     x8, #0x11e9c9000
0x10546397c: ldr      x1, [x8, #0xe58] ; @selector(callExtension:selector:block:) | 'callExtension:selector:block:'
0x105463980: adrp     x4, #0x11c2fd000
0x105463984: add      x4, x4, #0xee8 ; __NSConcreteGlobalBlock
0x105463988: bl       #0x107c27c64 ; _objc_msgSend | selector=callExtension:selector:block:
0x10546398c: mov      x0, x20
0x105463990: b        #0x105463a08
0x105463994: adrp     x8, #0x11e9cf000 ; @selector(lastUpdateWatermarkTime)
0x105463998: ldr      x1, [x8, #0xa0] ; @selector(m_oUserData) | 'm_oUserData'
0x10546399c: mov      x0, x19
0x1054639a0: bl       #0x107c27c64 ; _objc_msgSend | selector=m_oUserData
0x1054639a4: mov      x29, x29
0x1054639a8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054639ac: mov      x22, x0
0x1054639b0: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x1054639b4: ldr      x1, [x8, #0x870] ; @selector(m_pbResponse) | 'm_pbResponse'
0x1054639b8: mov      x0, x19
0x1054639bc: bl       #0x107c27c64 ; _objc_msgSend | selector=m_pbResponse
0x1054639c0: mov      x29, x29
0x1054639c4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054639c8: mov      x23, x0
0x1054639cc: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x1054639d0: ldr      x1, [x8, #0x108] ; @selector(boolValue) | 'boolValue'
0x1054639d4: mov      x0, x22
0x1054639d8: bl       #0x107c27c64 ; _objc_msgSend | selector=boolValue
0x1054639dc: mov      x3, x0
0x1054639e0: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x1054639e4: ldr      x1, [x8, #0xc30] ; @selector(HandleSyncResp:handleResult:) | 'HandleSyncResp:handleResult:'
0x1054639e8: mov      x0, x20
0x1054639ec: mov      x2, x23
0x1054639f0: bl       #0x107c27c64 ; _objc_msgSend | selector=HandleSyncResp:handleResult:
0x1054639f4: mov      x0, x23
0x1054639f8: bl       #0x107c27c70 ; _objc_release
0x1054639fc: mov      x0, x22
0x105463a00: bl       #0x107c27c70 ; _objc_release
0x105463a04: mov      x0, x21
0x105463a08: bl       #0x107c27c70 ; _objc_release
0x105463a0c: mov      x0, x19
0x105463a10: ldp      x29, x30, [sp, #0x50]
0x105463a14: ldp      x20, x19, [sp, #0x40]
0x105463a18: ldp      x22, x21, [sp, #0x30]
0x105463a1c: ldp      x24, x23, [sp, #0x20]
0x105463a20: add      sp, sp, #0x60
0x105463a24: b        #0x107c27c70 ; _objc_release
