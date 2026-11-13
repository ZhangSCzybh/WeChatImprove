0x105e44154: stp      d9, d8, [sp, #-0x70]!
0x105e44158: stp      x28, x27, [sp, #0x10]
0x105e4415c: stp      x26, x25, [sp, #0x20]
0x105e44160: stp      x24, x23, [sp, #0x30]
0x105e44164: stp      x22, x21, [sp, #0x40]
0x105e44168: stp      x20, x19, [sp, #0x50]
0x105e4416c: stp      x29, x30, [sp, #0x60]
0x105e44170: add      x29, sp, #0x60
0x105e44174: sub      sp, sp, #0xce0
0x105e44178: mov      x19, x0
0x105e4417c: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e44180: ldr      x8, [x8, #0xa30] ; ___stack_chk_guard
0x105e44184: ldr      x8, [x8]
0x105e44188: stur     x8, [x29, #-0x70]
0x105e4418c: adrp     x8, #0x11ed12000
0x105e44190: ldr      x21, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e44194: ldr      x0, [x0, #0x20]
0x105e44198: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105e4419c: ldr      x20, [x8, #0x850] ; @selector(count) | 'count'
0x105e441a0: mov      x1, x20 ; 'count'
0x105e441a4: bl       #0x107c27c64 ; _objc_msgSend | selector=count
0x105e441a8: mov      x22, x0
0x105e441ac: ldr      x0, [x19, #0x28]
0x105e441b0: mov      x1, x20 ; 'count'
0x105e441b4: bl       #0x107c27c64 ; _objc_msgSend | selector=count
0x105e441b8: mov      x23, x0
0x105e441bc: ldr      x0, [x19, #0x30]
0x105e441c0: str      x20, [sp, #0x128] ; 'count'
0x105e441c4: mov      x1, x20 ; 'count'
0x105e441c8: bl       #0x107c27c64 ; _objc_msgSend | selector=count
0x105e441cc: adrp     x8, #0x11e9c9000
0x105e441d0: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105e441d4: stp      x23, x0, [sp, #0x10]
0x105e441d8: adrp     x8, #0x11d353000
0x105e441dc: add      x8, x8, #0xb58 ; @'local push count:%lu arrNotifyList:%lu arrStatusNotifyList:%lu'
0x105e441e0: stp      x8, x22, [sp] ; @'local push count:%lu arrNotifyList:%lu arrStatusNotifyList:%lu'
0x105e441e4: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105e441e8: add      x3, x3, #0xfaf ; 'Sync'
0x105e441ec: adrp     x5, #0x11a2e0000 ; 'tice?language='
0x105e441f0: add      x5, x5, #0x21 ; 'SyncCmdHandler.mm'
0x105e441f4: adrp     x7, #0x11a2e0000 ; 'tice?language='
0x105e441f8: add      x7, x7, #0x66d ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]_block_invoke'
0x105e441fc: mov      x0, x21 ; Class iConsole
0x105e44200: str      x1, [sp, #0x140] ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105e44204: mov      w2, #2
0x105e44208: mov      w4, #0
0x105e4420c: mov      w6, #0x369
0x105e44210: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105e44214: movi     v0.16b, #0
0x105e44218: str      q0, [sp, #0x840]
0x105e4421c: str      q0, [sp, #0x830]
0x105e44220: str      q0, [sp, #0x820]
0x105e44224: str      q0, [sp, #0x810]
0x105e44228: str      x19, [sp, #0x148]
0x105e4422c: ldr      x21, [x19, #0x28]
0x105e44230: mov      x0, x21
0x105e44234: bl       #0x107c27c74 ; _objc_retain
0x105e44238: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105e4423c: ldr      x1, [x8, #0x858] ; @selector(countByEnumeratingWithState:objects:count:) | 'countByEnumeratingWithState:objects:count:'
0x105e44240: add      x2, sp, #0x810
0x105e44244: sub      x3, x29, #0xf0
0x105e44248: str      x1, [sp, #0x110] ; 'countByEnumeratingWithState:objects:count:'
0x105e4424c: mov      w4, #0x10
0x105e44250: bl       #0x107c27c64 ; _objc_msgSend | selector=countByEnumeratingWithState:objects:count:
0x105e44254: cbz      x0, #0x105e4433c
0x105e44258: mov      x22, x0
0x105e4425c: ldr      x8, [sp, #0x820]
0x105e44260: ldr      x19, [x8]
0x105e44264: adrp     x8, #0x1178c7000
0x105e44268: ldr      d8, [x8, #0x680]
0x105e4426c: adrp     x27, #0x105e45000
0x105e44270: add      x27, x27, #0xb34
0x105e44274: mov      x28, #0
0x105e44278: adrp     x8, #0x11e9c9000
0x105e4427c: ldr      x23, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105e44280: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44284: ldr      x24, [x8, #0x8a8] ; @selector(onNewSyncAddMessage:) | 'onNewSyncAddMessage:'
0x105e44288: adrp     x8, #0x11e9c9000
0x105e4428c: ldr      x25, [x8, #0xe58] ; @selector(callExtension:selector:block:) | 'callExtension:selector:block:'
0x105e44290: ldr      x8, [sp, #0x820]
0x105e44294: ldr      x8, [x8]
0x105e44298: cmp      x8, x19
0x105e4429c: b.eq     #0x105e442a8
0x105e442a0: mov      x0, x21
0x105e442a4: bl       #0x107c27c3c ; _objc_enumerationMutation
0x105e442a8: ldr      x8, [sp, #0x818]
0x105e442ac: ldr      x20, [x8, x28, lsl #3]
0x105e442b0: adrp     x8, #0x11ed12000
0x105e442b4: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e442b8: mov      x1, x23 ; 'currentContext'
0x105e442bc: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105e442c0: mov      x29, x29
0x105e442c4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e442c8: mov      x26, x0
0x105e442cc: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e442d0: ldr      x2, [x8, #0x760]
0x105e442d4: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e442d8: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e442dc: str      x8, [sp, #0x7e8]
0x105e442e0: str      d8, [sp, #0x7f0]
0x105e442e4: str      x27, [sp, #0x7f8]
0x105e442e8: adrp     x8, #0x11c280000
0x105e442ec: add      x8, x8, #0x7e0
0x105e442f0: str      x8, [sp, #0x800]
0x105e442f4: str      x20, [sp, #0x808]
0x105e442f8: add      x4, sp, #0x7e8
0x105e442fc: mov      x1, x25 ; 'callExtension:selector:block:'
0x105e44300: mov      x3, x24 ; 'onNewSyncAddMessage:'
0x105e44304: bl       #0x107c27c64 ; _objc_msgSend | selector=callExtension:selector:block:
0x105e44308: mov      x0, x26
0x105e4430c: bl       #0x107c27c70 ; _objc_release
0x105e44310: add      x28, x28, #1
0x105e44314: cmp      x22, x28
0x105e44318: b.ne     #0x105e44290
0x105e4431c: add      x2, sp, #0x810
0x105e44320: sub      x3, x29, #0xf0
0x105e44324: mov      x0, x21
0x105e44328: ldr      x1, [sp, #0x110]
0x105e4432c: mov      w4, #0x10
0x105e44330: bl       #0x107c27c64 ; _objc_msgSend
0x105e44334: mov      x22, x0
0x105e44338: cbnz     x0, #0x105e44274
0x105e4433c: mov      x0, x21
0x105e44340: bl       #0x107c27c70 ; _objc_release
0x105e44344: ldr      x19, [sp, #0x148]
0x105e44348: ldr      x0, [x19, #0x38]
0x105e4434c: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44350: ldr      x1, [x8, #0x8b0] ; @selector(m_ignoreSession) | 'm_ignoreSession'
0x105e44354: bl       #0x107c27c64 ; _objc_msgSend | selector=m_ignoreSession
0x105e44358: tbnz     w0, #0, #0x105e44408
0x105e4435c: adrp     x8, #0x11ed12000
0x105e44360: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e44364: adrp     x8, #0x11e9c9000
0x105e44368: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105e4436c: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105e44370: mov      x29, x29
0x105e44374: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e44378: mov      x21, x0
0x105e4437c: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e44380: ldr      x22, [x8, #0x760]
0x105e44384: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44388: ldr      x23, [x8, #0x8b8] ; @selector(onNewSyncAddMsgSessionArray:withUsers:) | 'onNewSyncAddMsgSessionArray:withUsers:'
0x105e4438c: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e44390: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e44394: str      x8, [sp, #0x7b8]
0x105e44398: adrp     x8, #0x1178c7000
0x105e4439c: ldr      d0, [x8, #0x680]
0x105e443a0: str      d0, [sp, #0x7c0]
0x105e443a4: adrp     x8, #0x105e45000
0x105e443a8: add      x8, x8, #0xb4c
0x105e443ac: str      x8, [sp, #0x7c8]
0x105e443b0: adrp     x8, #0x11c284000
0x105e443b4: add      x8, x8, #0x8e0
0x105e443b8: str      x8, [sp, #0x7d0]
0x105e443bc: ldr      x0, [x19, #0x40]
0x105e443c0: bl       #0x107c27c74 ; _objc_retain
0x105e443c4: str      x0, [sp, #0x7d8]
0x105e443c8: ldr      x0, [x19, #0x48]
0x105e443cc: bl       #0x107c27c74 ; _objc_retain
0x105e443d0: str      x0, [sp, #0x7e0]
0x105e443d4: adrp     x8, #0x11e9c9000
0x105e443d8: ldr      x1, [x8, #0xe58] ; @selector(callExtension:selector:block:) | 'callExtension:selector:block:'
0x105e443dc: add      x4, sp, #0x7b8
0x105e443e0: mov      x0, x21
0x105e443e4: mov      x2, x22
0x105e443e8: mov      x3, x23 ; 'onNewSyncAddMsgSessionArray:withUsers:'
0x105e443ec: bl       #0x107c27c64 ; _objc_msgSend | selector=callExtension:selector:block:
0x105e443f0: mov      x0, x21
0x105e443f4: bl       #0x107c27c70 ; _objc_release
0x105e443f8: ldr      x0, [sp, #0x7e0]
0x105e443fc: bl       #0x107c27c70 ; _objc_release
0x105e44400: ldr      x0, [sp, #0x7d8]
0x105e44404: bl       #0x107c27c70 ; _objc_release
0x105e44408: movi     v0.16b, #0
0x105e4440c: str      q0, [sp, #0x7a0]
0x105e44410: str      q0, [sp, #0x790]
0x105e44414: str      q0, [sp, #0x780]
0x105e44418: str      q0, [sp, #0x770]
0x105e4441c: ldr      x21, [x19, #0x50]
0x105e44420: mov      x0, x21
0x105e44424: bl       #0x107c27c74 ; _objc_retain
0x105e44428: add      x2, sp, #0x770
0x105e4442c: add      x3, sp, #0xbd0
0x105e44430: ldr      x1, [sp, #0x110]
0x105e44434: mov      w4, #0x10
0x105e44438: bl       #0x107c27c64 ; _objc_msgSend
0x105e4443c: cbz      x0, #0x105e44524
0x105e44440: mov      x22, x0
0x105e44444: ldr      x8, [sp, #0x780]
0x105e44448: ldr      x19, [x8]
0x105e4444c: adrp     x8, #0x1178c7000
0x105e44450: ldr      d8, [x8, #0x680]
0x105e44454: adrp     x27, #0x105e45000
0x105e44458: add      x27, x27, #0xb64
0x105e4445c: mov      x28, #0
0x105e44460: adrp     x8, #0x11e9c9000
0x105e44464: ldr      x23, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105e44468: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e4446c: ldr      x24, [x8, #0x8c0] ; @selector(onNewSyncNotAddDBMessage:) | 'onNewSyncNotAddDBMessage:'
0x105e44470: adrp     x8, #0x11e9c9000
0x105e44474: ldr      x25, [x8, #0xe58] ; @selector(callExtension:selector:block:) | 'callExtension:selector:block:'
0x105e44478: ldr      x8, [sp, #0x780]
0x105e4447c: ldr      x8, [x8]
0x105e44480: cmp      x8, x19
0x105e44484: b.eq     #0x105e44490
0x105e44488: mov      x0, x21
0x105e4448c: bl       #0x107c27c3c ; _objc_enumerationMutation
0x105e44490: ldr      x8, [sp, #0x778]
0x105e44494: ldr      x20, [x8, x28, lsl #3]
0x105e44498: adrp     x8, #0x11ed12000
0x105e4449c: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e444a0: mov      x1, x23 ; 'currentContext'
0x105e444a4: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105e444a8: mov      x29, x29
0x105e444ac: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e444b0: mov      x26, x0
0x105e444b4: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e444b8: ldr      x2, [x8, #0x760]
0x105e444bc: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e444c0: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e444c4: str      x8, [sp, #0x748]
0x105e444c8: str      d8, [sp, #0x750]
0x105e444cc: str      x27, [sp, #0x758]
0x105e444d0: adrp     x8, #0x11c280000
0x105e444d4: add      x8, x8, #0x7e0
0x105e444d8: str      x8, [sp, #0x760]
0x105e444dc: str      x20, [sp, #0x768]
0x105e444e0: add      x4, sp, #0x748
0x105e444e4: mov      x1, x25 ; 'callExtension:selector:block:'
0x105e444e8: mov      x3, x24 ; 'onNewSyncNotAddDBMessage:'
0x105e444ec: bl       #0x107c27c64 ; _objc_msgSend | selector=callExtension:selector:block:
0x105e444f0: mov      x0, x26
0x105e444f4: bl       #0x107c27c70 ; _objc_release
0x105e444f8: add      x28, x28, #1
0x105e444fc: cmp      x22, x28
0x105e44500: b.ne     #0x105e44478
0x105e44504: add      x2, sp, #0x770
0x105e44508: add      x3, sp, #0xbd0
0x105e4450c: mov      x0, x21
0x105e44510: ldr      x1, [sp, #0x110]
0x105e44514: mov      w4, #0x10
0x105e44518: bl       #0x107c27c64 ; _objc_msgSend
0x105e4451c: mov      x22, x0
0x105e44520: cbnz     x0, #0x105e4445c
0x105e44524: mov      x0, x21
0x105e44528: bl       #0x107c27c70 ; _objc_release
0x105e4452c: movi     v0.16b, #0
0x105e44530: str      q0, [sp, #0x730]
0x105e44534: str      q0, [sp, #0x720]
0x105e44538: str      q0, [sp, #0x710]
0x105e4453c: str      q0, [sp, #0x700]
0x105e44540: ldr      x8, [sp, #0x148]
0x105e44544: ldr      x21, [x8, #0x58]
0x105e44548: mov      x0, x21
0x105e4454c: bl       #0x107c27c74 ; _objc_retain
0x105e44550: add      x2, sp, #0x700
0x105e44554: add      x3, sp, #0xb50
0x105e44558: ldr      x1, [sp, #0x110]
0x105e4455c: mov      w4, #0x10
0x105e44560: bl       #0x107c27c64 ; _objc_msgSend
0x105e44564: cbz      x0, #0x105e4464c
0x105e44568: mov      x22, x0
0x105e4456c: ldr      x8, [sp, #0x710]
0x105e44570: ldr      x19, [x8]
0x105e44574: adrp     x8, #0x1178c7000
0x105e44578: ldr      d8, [x8, #0x680]
0x105e4457c: adrp     x27, #0x105e45000
0x105e44580: add      x27, x27, #0xb7c
0x105e44584: mov      x28, #0
0x105e44588: adrp     x8, #0x11e9c9000
0x105e4458c: ldr      x23, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105e44590: adrp     x8, #0x11eb3c000 ; @selector(uploadCost)
0x105e44594: ldr      x24, [x8, #0x520] ; @selector(onNewSyncClearUnread:) | 'onNewSyncClearUnread:'
0x105e44598: adrp     x8, #0x11e9c9000
0x105e4459c: ldr      x25, [x8, #0xe58] ; @selector(callExtension:selector:block:) | 'callExtension:selector:block:'
0x105e445a0: ldr      x8, [sp, #0x710]
0x105e445a4: ldr      x8, [x8]
0x105e445a8: cmp      x8, x19
0x105e445ac: b.eq     #0x105e445b8
0x105e445b0: mov      x0, x21
0x105e445b4: bl       #0x107c27c3c ; _objc_enumerationMutation
0x105e445b8: ldr      x8, [sp, #0x708]
0x105e445bc: ldr      x20, [x8, x28, lsl #3]
0x105e445c0: adrp     x8, #0x11ed12000
0x105e445c4: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e445c8: mov      x1, x23 ; 'currentContext'
0x105e445cc: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105e445d0: mov      x29, x29
0x105e445d4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e445d8: mov      x26, x0
0x105e445dc: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e445e0: ldr      x2, [x8, #0x760]
0x105e445e4: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e445e8: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e445ec: str      x8, [sp, #0x6d8]
0x105e445f0: str      d8, [sp, #0x6e0]
0x105e445f4: str      x27, [sp, #0x6e8]
0x105e445f8: adrp     x8, #0x11c280000
0x105e445fc: add      x8, x8, #0x7e0
0x105e44600: str      x8, [sp, #0x6f0]
0x105e44604: str      x20, [sp, #0x6f8]
0x105e44608: add      x4, sp, #0x6d8
0x105e4460c: mov      x1, x25 ; 'callExtension:selector:block:'
0x105e44610: mov      x3, x24 ; 'onNewSyncClearUnread:'
0x105e44614: bl       #0x107c27c64 ; _objc_msgSend | selector=callExtension:selector:block:
0x105e44618: mov      x0, x26
0x105e4461c: bl       #0x107c27c70 ; _objc_release
0x105e44620: add      x28, x28, #1
0x105e44624: cmp      x22, x28
0x105e44628: b.ne     #0x105e445a0
0x105e4462c: add      x2, sp, #0x700
0x105e44630: add      x3, sp, #0xb50
0x105e44634: mov      x0, x21
0x105e44638: ldr      x1, [sp, #0x110]
0x105e4463c: mov      w4, #0x10
0x105e44640: bl       #0x107c27c64 ; _objc_msgSend
0x105e44644: mov      x22, x0
0x105e44648: cbnz     x0, #0x105e44584
0x105e4464c: mov      x0, x21
0x105e44650: bl       #0x107c27c70 ; _objc_release
0x105e44654: movi     v0.16b, #0
0x105e44658: str      q0, [sp, #0x6c0]
0x105e4465c: str      q0, [sp, #0x6b0]
0x105e44660: str      q0, [sp, #0x6a0]
0x105e44664: str      q0, [sp, #0x690]
0x105e44668: ldr      x20, [sp, #0x148]
0x105e4466c: ldr      x0, [x20, #0x60]
0x105e44670: bl       #0x107c27c74 ; _objc_retain
0x105e44674: add      x2, sp, #0x690
0x105e44678: add      x3, sp, #0xad0
0x105e4467c: str      x0, [sp, #0x130]
0x105e44680: ldr      x1, [sp, #0x110]
0x105e44684: mov      w4, #0x10
0x105e44688: bl       #0x107c27c64 ; _objc_msgSend
0x105e4468c: cbz      x0, #0x105e447c8
0x105e44690: mov      x22, x0
0x105e44694: ldr      x8, [sp, #0x6a0]
0x105e44698: ldr      x21, [x8]
0x105e4469c: adrp     x8, #0x1178c7000
0x105e446a0: ldr      d8, [x8, #0x680]
0x105e446a4: mov      x24, #0
0x105e446a8: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x105e446ac: ldr      x23, [x8, #0x640] ; @selector(objectForKey:) | 'objectForKey:'
0x105e446b0: adrp     x8, #0x11e9c9000
0x105e446b4: ldr      x8, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105e446b8: str      x8, [sp, #0x138] ; 'currentContext'
0x105e446bc: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e446c0: ldr      x25, [x8, #0x8c8] ; @selector(onNewSyncSpecialSession:withMessages:) | 'onNewSyncSpecialSession:withMessages:'
0x105e446c4: adrp     x8, #0x11e9c9000
0x105e446c8: ldr      x26, [x8, #0xe58] ; @selector(callExtension:selector:block:) | 'callExtension:selector:block:'
0x105e446cc: ldr      x8, [sp, #0x6a0]
0x105e446d0: ldr      x8, [x8]
0x105e446d4: cmp      x8, x21
0x105e446d8: b.eq     #0x105e446e4
0x105e446dc: ldr      x0, [sp, #0x130]
0x105e446e0: bl       #0x107c27c3c ; _objc_enumerationMutation
0x105e446e4: ldr      x8, [sp, #0x698]
0x105e446e8: ldr      x28, [x8, x24, lsl #3]
0x105e446ec: ldr      x0, [x20, #0x60]
0x105e446f0: mov      x1, x23 ; 'objectForKey:'
0x105e446f4: mov      x2, x28
0x105e446f8: bl       #0x107c27c64 ; _objc_msgSend | selector=objectForKey:
0x105e446fc: mov      x29, x29
0x105e44700: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e44704: mov      x27, x0
0x105e44708: cbz      x0, #0x105e44794
0x105e4470c: adrp     x8, #0x11ed12000
0x105e44710: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e44714: ldr      x1, [sp, #0x138]
0x105e44718: bl       #0x107c27c64 ; _objc_msgSend
0x105e4471c: mov      x29, x29
0x105e44720: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e44724: mov      x20, x0
0x105e44728: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e4472c: ldr      x19, [x8, #0x760]
0x105e44730: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e44734: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e44738: str      x8, [sp, #0x660]
0x105e4473c: str      d8, [sp, #0x668]
0x105e44740: adrp     x8, #0x105e45000
0x105e44744: add      x8, x8, #0xb94
0x105e44748: str      x8, [sp, #0x670]
0x105e4474c: adrp     x8, #0x11c284000
0x105e44750: add      x8, x8, #0x8e0
0x105e44754: str      x8, [sp, #0x678]
0x105e44758: str      x28, [sp, #0x680]
0x105e4475c: mov      x0, x27
0x105e44760: bl       #0x107c27c74 ; _objc_retain
0x105e44764: str      x27, [sp, #0x688]
0x105e44768: add      x4, sp, #0x660
0x105e4476c: mov      x0, x20
0x105e44770: mov      x1, x26 ; 'callExtension:selector:block:'
0x105e44774: mov      x2, x19
0x105e44778: mov      x3, x25 ; 'onNewSyncSpecialSession:withMessages:'
0x105e4477c: bl       #0x107c27c64 ; _objc_msgSend | selector=callExtension:selector:block:
0x105e44780: mov      x0, x20
0x105e44784: ldr      x20, [sp, #0x148]
0x105e44788: bl       #0x107c27c70 ; _objc_release
0x105e4478c: ldr      x0, [sp, #0x688]
0x105e44790: bl       #0x107c27c70 ; _objc_release
0x105e44794: mov      x0, x27
0x105e44798: bl       #0x107c27c70 ; _objc_release
0x105e4479c: add      x24, x24, #1
0x105e447a0: cmp      x22, x24
0x105e447a4: b.ne     #0x105e446cc
0x105e447a8: add      x2, sp, #0x690
0x105e447ac: add      x3, sp, #0xad0
0x105e447b0: ldr      x0, [sp, #0x130]
0x105e447b4: ldr      x1, [sp, #0x110]
0x105e447b8: mov      w4, #0x10
0x105e447bc: bl       #0x107c27c64 ; _objc_msgSend
0x105e447c0: mov      x22, x0
0x105e447c4: cbnz     x0, #0x105e446a4
0x105e447c8: ldr      x0, [sp, #0x130]
0x105e447cc: bl       #0x107c27c70 ; _objc_release
0x105e447d0: movi     v0.16b, #0
0x105e447d4: str      q0, [sp, #0x650]
0x105e447d8: str      q0, [sp, #0x640]
0x105e447dc: str      q0, [sp, #0x630]
0x105e447e0: str      q0, [sp, #0x620]
0x105e447e4: ldr      x0, [x20, #0x68]
0x105e447e8: bl       #0x107c27c74 ; _objc_retain
0x105e447ec: add      x2, sp, #0x620
0x105e447f0: add      x3, sp, #0xa50
0x105e447f4: str      x0, [sp, #0x130]
0x105e447f8: ldr      x1, [sp, #0x110]
0x105e447fc: mov      w4, #0x10
0x105e44800: bl       #0x107c27c64 ; _objc_msgSend
0x105e44804: cbz      x0, #0x105e44940
0x105e44808: mov      x22, x0
0x105e4480c: ldr      x8, [sp, #0x630]
0x105e44810: ldr      x21, [x8]
0x105e44814: adrp     x8, #0x1178c7000
0x105e44818: ldr      d8, [x8, #0x680]
0x105e4481c: mov      x24, #0
0x105e44820: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x105e44824: ldr      x23, [x8, #0x640] ; @selector(objectForKey:) | 'objectForKey:'
0x105e44828: adrp     x8, #0x11e9c9000
0x105e4482c: ldr      x8, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105e44830: str      x8, [sp, #0x138] ; 'currentContext'
0x105e44834: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44838: ldr      x25, [x8, #0x8d0] ; @selector(onNewSyncNotAddDBSession:withMessages:) | 'onNewSyncNotAddDBSession:withMessages:'
0x105e4483c: adrp     x8, #0x11e9c9000
0x105e44840: ldr      x26, [x8, #0xe58] ; @selector(callExtension:selector:block:) | 'callExtension:selector:block:'
0x105e44844: ldr      x8, [sp, #0x630]
0x105e44848: ldr      x8, [x8]
0x105e4484c: cmp      x8, x21
0x105e44850: b.eq     #0x105e4485c
0x105e44854: ldr      x0, [sp, #0x130]
0x105e44858: bl       #0x107c27c3c ; _objc_enumerationMutation
0x105e4485c: ldr      x8, [sp, #0x628]
0x105e44860: ldr      x28, [x8, x24, lsl #3]
0x105e44864: ldr      x0, [x20, #0x68]
0x105e44868: mov      x1, x23 ; 'objectForKey:'
0x105e4486c: mov      x2, x28
0x105e44870: bl       #0x107c27c64 ; _objc_msgSend | selector=objectForKey:
0x105e44874: mov      x29, x29
0x105e44878: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e4487c: mov      x27, x0
0x105e44880: cbz      x0, #0x105e4490c
0x105e44884: adrp     x8, #0x11ed12000
0x105e44888: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e4488c: ldr      x1, [sp, #0x138]
0x105e44890: bl       #0x107c27c64 ; _objc_msgSend
0x105e44894: mov      x29, x29
0x105e44898: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e4489c: mov      x19, x0
0x105e448a0: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e448a4: ldr      x20, [x8, #0x760]
0x105e448a8: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e448ac: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e448b0: str      x8, [sp, #0x5f0]
0x105e448b4: str      d8, [sp, #0x5f8]
0x105e448b8: adrp     x8, #0x105e45000
0x105e448bc: add      x8, x8, #0xbac
0x105e448c0: str      x8, [sp, #0x600]
0x105e448c4: adrp     x8, #0x11c284000
0x105e448c8: add      x8, x8, #0x8e0
0x105e448cc: str      x8, [sp, #0x608]
0x105e448d0: str      x28, [sp, #0x610]
0x105e448d4: mov      x0, x27
0x105e448d8: bl       #0x107c27c74 ; _objc_retain
0x105e448dc: str      x27, [sp, #0x618]
0x105e448e0: add      x4, sp, #0x5f0
0x105e448e4: mov      x0, x19
0x105e448e8: mov      x1, x26 ; 'callExtension:selector:block:'
0x105e448ec: mov      x2, x20
0x105e448f0: ldr      x20, [sp, #0x148]
0x105e448f4: mov      x3, x25 ; 'onNewSyncNotAddDBSession:withMessages:'
0x105e448f8: bl       #0x107c27c64 ; _objc_msgSend | selector=callExtension:selector:block:
0x105e448fc: mov      x0, x19
0x105e44900: bl       #0x107c27c70 ; _objc_release
0x105e44904: ldr      x0, [sp, #0x618]
0x105e44908: bl       #0x107c27c70 ; _objc_release
0x105e4490c: mov      x0, x27
0x105e44910: bl       #0x107c27c70 ; _objc_release
0x105e44914: add      x24, x24, #1
0x105e44918: cmp      x22, x24
0x105e4491c: b.ne     #0x105e44844
0x105e44920: add      x2, sp, #0x620
0x105e44924: add      x3, sp, #0xa50
0x105e44928: ldr      x0, [sp, #0x130]
0x105e4492c: ldr      x1, [sp, #0x110]
0x105e44930: mov      w4, #0x10
0x105e44934: bl       #0x107c27c64 ; _objc_msgSend
0x105e44938: mov      x22, x0
0x105e4493c: cbnz     x0, #0x105e4481c
0x105e44940: ldr      x0, [sp, #0x130]
0x105e44944: bl       #0x107c27c70 ; _objc_release
0x105e44948: ldrb     w8, [x20, #0x78]
0x105e4494c: cmp      w8, #1
0x105e44950: b.ne     #0x105e44bd4
0x105e44954: movi     v0.16b, #0
0x105e44958: str      q0, [sp, #0x5e0]
0x105e4495c: str      q0, [sp, #0x5d0]
0x105e44960: str      q0, [sp, #0x5c0]
0x105e44964: str      q0, [sp, #0x5b0]
0x105e44968: ldr      x0, [x20, #0x20]
0x105e4496c: bl       #0x107c27c74 ; _objc_retain
0x105e44970: add      x2, sp, #0x5b0
0x105e44974: add      x3, sp, #0x9d0
0x105e44978: str      x0, [sp, #0x138]
0x105e4497c: ldr      x1, [sp, #0x110]
0x105e44980: mov      w4, #0x10
0x105e44984: bl       #0x107c27c64 ; _objc_msgSend
0x105e44988: cbz      x0, #0x105e44a7c
0x105e4498c: mov      x22, x0
0x105e44990: ldr      x8, [sp, #0x5c0]
0x105e44994: ldr      x20, [x8]
0x105e44998: adrp     x8, #0x1178c7000
0x105e4499c: ldr      d8, [x8, #0x680]
0x105e449a0: adrp     x27, #0x105e45000
0x105e449a4: add      x27, x27, #0xbc4
0x105e449a8: adrp     x28, #0x11c281000
0x105e449ac: add      x28, x28, #0xae8
0x105e449b0: mov      x26, #0
0x105e449b4: adrp     x8, #0x11e9c9000
0x105e449b8: ldr      x23, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105e449bc: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e449c0: ldr      x24, [x8, #0x8d8] ; @selector(onNewSyncShowPush:isAlwaysShow:) | 'onNewSyncShowPush:isAlwaysShow:'
0x105e449c4: adrp     x8, #0x11e9c9000
0x105e449c8: ldr      x25, [x8, #0xe58] ; @selector(callExtension:selector:block:) | 'callExtension:selector:block:'
0x105e449cc: ldr      x8, [sp, #0x5c0]
0x105e449d0: ldr      x8, [x8]
0x105e449d4: cmp      x8, x20
0x105e449d8: b.eq     #0x105e449e4
0x105e449dc: ldr      x0, [sp, #0x138]
0x105e449e0: bl       #0x107c27c3c ; _objc_enumerationMutation
0x105e449e4: ldr      x8, [sp, #0x5b8]
0x105e449e8: ldr      x21, [x8, x26, lsl #3]
0x105e449ec: adrp     x8, #0x11ed12000
0x105e449f0: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e449f4: mov      x1, x23 ; 'currentContext'
0x105e449f8: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105e449fc: mov      x29, x29
0x105e44a00: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e44a04: mov      x19, x0
0x105e44a08: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e44a0c: ldr      x2, [x8, #0x760]
0x105e44a10: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e44a14: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e44a18: str      x8, [sp, #0x580]
0x105e44a1c: str      d8, [sp, #0x588]
0x105e44a20: str      x27, [sp, #0x590]
0x105e44a24: str      x28, [sp, #0x598]
0x105e44a28: str      x21, [sp, #0x5a0]
0x105e44a2c: ldr      x8, [sp, #0x148]
0x105e44a30: ldrb     w8, [x8, #0x79]
0x105e44a34: strb     w8, [sp, #0x5a8]
0x105e44a38: add      x4, sp, #0x580
0x105e44a3c: mov      x1, x25 ; 'callExtension:selector:block:'
0x105e44a40: mov      x3, x24 ; 'onNewSyncShowPush:isAlwaysShow:'
0x105e44a44: bl       #0x107c27c64 ; _objc_msgSend | selector=callExtension:selector:block:
0x105e44a48: mov      x0, x19
0x105e44a4c: bl       #0x107c27c70 ; _objc_release
0x105e44a50: add      x26, x26, #1
0x105e44a54: cmp      x22, x26
0x105e44a58: b.ne     #0x105e449cc
0x105e44a5c: add      x2, sp, #0x5b0
0x105e44a60: add      x3, sp, #0x9d0
0x105e44a64: ldr      x0, [sp, #0x138]
0x105e44a68: ldr      x1, [sp, #0x110]
0x105e44a6c: mov      w4, #0x10
0x105e44a70: bl       #0x107c27c64 ; _objc_msgSend
0x105e44a74: mov      x22, x0
0x105e44a78: cbnz     x0, #0x105e449b0
0x105e44a7c: ldr      x0, [sp, #0x138]
0x105e44a80: bl       #0x107c27c70 ; _objc_release
0x105e44a84: ldr      x20, [sp, #0x148]
0x105e44a88: ldrb     w8, [x20, #0x78]
0x105e44a8c: cmp      w8, #1
0x105e44a90: b.ne     #0x105e44bd4
0x105e44a94: ldr      x0, [x20, #0x70]
0x105e44a98: ldr      x1, [sp, #0x128]
0x105e44a9c: bl       #0x107c27c64 ; _objc_msgSend
0x105e44aa0: cbz      x0, #0x105e44bd4
0x105e44aa4: movi     v0.16b, #0
0x105e44aa8: str      q0, [sp, #0x570]
0x105e44aac: str      q0, [sp, #0x560]
0x105e44ab0: str      q0, [sp, #0x550]
0x105e44ab4: str      q0, [sp, #0x540]
0x105e44ab8: ldr      x0, [x20, #0x70]
0x105e44abc: bl       #0x107c27c74 ; _objc_retain
0x105e44ac0: add      x2, sp, #0x540
0x105e44ac4: add      x3, sp, #0x950
0x105e44ac8: str      x0, [sp, #0x138]
0x105e44acc: ldr      x1, [sp, #0x110]
0x105e44ad0: mov      w4, #0x10
0x105e44ad4: bl       #0x107c27c64 ; _objc_msgSend
0x105e44ad8: cbz      x0, #0x105e44bcc
0x105e44adc: mov      x21, x0
0x105e44ae0: ldr      x8, [sp, #0x550]
0x105e44ae4: ldr      x25, [x8]
0x105e44ae8: adrp     x8, #0x1178c7000
0x105e44aec: ldr      d8, [x8, #0x680]
0x105e44af0: adrp     x27, #0x105e45000
0x105e44af4: add      x27, x27, #0xbe0
0x105e44af8: adrp     x28, #0x11c281000
0x105e44afc: add      x28, x28, #0xae8
0x105e44b00: mov      x26, #0
0x105e44b04: adrp     x8, #0x11e9c9000
0x105e44b08: ldr      x22, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105e44b0c: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44b10: ldr      x23, [x8, #0x8d8] ; @selector(onNewSyncShowPush:isAlwaysShow:) | 'onNewSyncShowPush:isAlwaysShow:'
0x105e44b14: adrp     x8, #0x11e9c9000
0x105e44b18: ldr      x24, [x8, #0xe58] ; @selector(callExtension:selector:block:) | 'callExtension:selector:block:'
0x105e44b1c: ldr      x8, [sp, #0x550]
0x105e44b20: ldr      x8, [x8]
0x105e44b24: cmp      x8, x25
0x105e44b28: b.eq     #0x105e44b34
0x105e44b2c: ldr      x0, [sp, #0x138]
0x105e44b30: bl       #0x107c27c3c ; _objc_enumerationMutation
0x105e44b34: ldr      x8, [sp, #0x548]
0x105e44b38: ldr      x20, [x8, x26, lsl #3]
0x105e44b3c: adrp     x8, #0x11ed12000
0x105e44b40: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e44b44: mov      x1, x22 ; 'currentContext'
0x105e44b48: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105e44b4c: mov      x29, x29
0x105e44b50: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e44b54: mov      x19, x0
0x105e44b58: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e44b5c: ldr      x2, [x8, #0x760]
0x105e44b60: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e44b64: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e44b68: str      x8, [sp, #0x510]
0x105e44b6c: str      d8, [sp, #0x518]
0x105e44b70: str      x27, [sp, #0x520]
0x105e44b74: str      x28, [sp, #0x528]
0x105e44b78: str      x20, [sp, #0x530]
0x105e44b7c: ldr      x20, [sp, #0x148]
0x105e44b80: ldrb     w8, [x20, #0x79]
0x105e44b84: strb     w8, [sp, #0x538]
0x105e44b88: add      x4, sp, #0x510
0x105e44b8c: mov      x1, x24 ; 'callExtension:selector:block:'
0x105e44b90: mov      x3, x23 ; 'onNewSyncShowPush:isAlwaysShow:'
0x105e44b94: bl       #0x107c27c64 ; _objc_msgSend | selector=callExtension:selector:block:
0x105e44b98: mov      x0, x19
0x105e44b9c: bl       #0x107c27c70 ; _objc_release
0x105e44ba0: add      x26, x26, #1
0x105e44ba4: cmp      x21, x26
0x105e44ba8: b.ne     #0x105e44b1c
0x105e44bac: add      x2, sp, #0x540
0x105e44bb0: add      x3, sp, #0x950
0x105e44bb4: ldr      x0, [sp, #0x138]
0x105e44bb8: ldr      x1, [sp, #0x110]
0x105e44bbc: mov      w4, #0x10
0x105e44bc0: bl       #0x107c27c64 ; _objc_msgSend
0x105e44bc4: mov      x21, x0
0x105e44bc8: cbnz     x0, #0x105e44b00
0x105e44bcc: ldr      x0, [sp, #0x138]
0x105e44bd0: bl       #0x107c27c70 ; _objc_release
0x105e44bd4: movi     v0.16b, #0
0x105e44bd8: str      q0, [sp, #0x500]
0x105e44bdc: str      q0, [sp, #0x4f0]
0x105e44be0: str      q0, [sp, #0x4e0]
0x105e44be4: str      q0, [sp, #0x4d0]
0x105e44be8: ldr      x8, [x20, #0x38]
0x105e44bec: adrp     x9, #0x11edd4000
0x105e44bf0: ldrsw    x9, [x9, #0x5fc] ; ivar_offset SyncCmdHandler.m_dicWebWxClearUnRead=0x10
0x105e44bf4: ldr      x20, [x8, x9]
0x105e44bf8: mov      x0, x20
0x105e44bfc: bl       #0x107c27c74 ; _objc_retain
0x105e44c00: add      x2, sp, #0x4d0
0x105e44c04: add      x3, sp, #0x8d0
0x105e44c08: ldr      x1, [sp, #0x110]
0x105e44c0c: mov      w4, #0x10
0x105e44c10: bl       #0x107c27c64 ; _objc_msgSend
0x105e44c14: cbz      x0, #0x105e44cfc
0x105e44c18: mov      x21, x0
0x105e44c1c: ldr      x8, [sp, #0x4e0]
0x105e44c20: ldr      x25, [x8]
0x105e44c24: adrp     x8, #0x1178c7000
0x105e44c28: ldr      d8, [x8, #0x680]
0x105e44c2c: adrp     x27, #0x105e45000
0x105e44c30: add      x27, x27, #0xbfc
0x105e44c34: mov      x28, #0
0x105e44c38: adrp     x8, #0x11e9c9000
0x105e44c3c: ldr      x22, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105e44c40: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44c44: ldr      x23, [x8, #0x8e0] ; @selector(onNewSyncBadRoomClearUnread:) | 'onNewSyncBadRoomClearUnread:'
0x105e44c48: adrp     x8, #0x11e9c9000
0x105e44c4c: ldr      x24, [x8, #0xe58] ; @selector(callExtension:selector:block:) | 'callExtension:selector:block:'
0x105e44c50: ldr      x8, [sp, #0x4e0]
0x105e44c54: ldr      x8, [x8]
0x105e44c58: cmp      x8, x25
0x105e44c5c: b.eq     #0x105e44c68
0x105e44c60: mov      x0, x20
0x105e44c64: bl       #0x107c27c3c ; _objc_enumerationMutation
0x105e44c68: ldr      x8, [sp, #0x4d8]
0x105e44c6c: ldr      x26, [x8, x28, lsl #3]
0x105e44c70: adrp     x8, #0x11ed12000
0x105e44c74: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e44c78: mov      x1, x22 ; 'currentContext'
0x105e44c7c: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105e44c80: mov      x29, x29
0x105e44c84: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e44c88: mov      x19, x0
0x105e44c8c: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e44c90: ldr      x2, [x8, #0x760]
0x105e44c94: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e44c98: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e44c9c: str      x8, [sp, #0x4a8]
0x105e44ca0: str      d8, [sp, #0x4b0]
0x105e44ca4: str      x27, [sp, #0x4b8]
0x105e44ca8: adrp     x8, #0x11c280000
0x105e44cac: add      x8, x8, #0x7e0
0x105e44cb0: str      x8, [sp, #0x4c0]
0x105e44cb4: str      x26, [sp, #0x4c8]
0x105e44cb8: add      x4, sp, #0x4a8
0x105e44cbc: mov      x1, x24 ; 'callExtension:selector:block:'
0x105e44cc0: mov      x3, x23 ; 'onNewSyncBadRoomClearUnread:'
0x105e44cc4: bl       #0x107c27c64 ; _objc_msgSend | selector=callExtension:selector:block:
0x105e44cc8: mov      x0, x19
0x105e44ccc: bl       #0x107c27c70 ; _objc_release
0x105e44cd0: add      x28, x28, #1
0x105e44cd4: cmp      x21, x28
0x105e44cd8: b.ne     #0x105e44c50
0x105e44cdc: add      x2, sp, #0x4d0
0x105e44ce0: add      x3, sp, #0x8d0
0x105e44ce4: mov      x0, x20
0x105e44ce8: ldr      x1, [sp, #0x110]
0x105e44cec: mov      w4, #0x10
0x105e44cf0: bl       #0x107c27c64 ; _objc_msgSend
0x105e44cf4: mov      x21, x0
0x105e44cf8: cbnz     x0, #0x105e44c34
0x105e44cfc: mov      x0, x20
0x105e44d00: bl       #0x107c27c70 ; _objc_release
0x105e44d04: movi     v0.16b, #0
0x105e44d08: str      q0, [sp, #0x490]
0x105e44d0c: str      q0, [sp, #0x480]
0x105e44d10: str      q0, [sp, #0x470]
0x105e44d14: str      q0, [sp, #0x460]
0x105e44d18: ldr      x8, [sp, #0x148]
0x105e44d1c: ldr      x0, [x8, #0x30]
0x105e44d20: bl       #0x107c27c74 ; _objc_retain
0x105e44d24: add      x2, sp, #0x460
0x105e44d28: add      x3, sp, #0x850
0x105e44d2c: str      x0, [sp, #0x118]
0x105e44d30: ldr      x1, [sp, #0x110]
0x105e44d34: mov      w4, #0x10
0x105e44d38: bl       #0x107c27c64 ; _objc_msgSend
0x105e44d3c: str      x0, [sp, #0x138]
0x105e44d40: cbz      x0, #0x105e45aec
0x105e44d44: ldr      x8, [sp, #0x470]
0x105e44d48: ldr      x8, [x8]
0x105e44d4c: str      x8, [sp, #0x130]
0x105e44d50: adrp     x8, #0x1178c7000
0x105e44d54: ldr      d8, [x8, #0x680]
0x105e44d58: mov      x23, #0
0x105e44d5c: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x105e44d60: ldr      x24, [x8, #0x650] ; @selector(objectForKeyedSubscript:) | 'objectForKeyedSubscript:'
0x105e44d64: adrp     x8, #0x11ecad000 ; @selector(sharedApplication)
0x105e44d68: ldr      x28, [x8, #0xac8] ; @selector(unsignedIntValue) | 'unsignedIntValue'
0x105e44d6c: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x105e44d70: ldr      x21, [x8, #0x640] ; @selector(objectForKey:) | 'objectForKey:'
0x105e44d74: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105e44d78: ldr      x22, [x8, #0x7b8] ; @selector(isEqualToString:) | 'isEqualToString:'
0x105e44d7c: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105e44d80: ldr      x8, [x8, #0xce8] ; @selector(length) | 'length'
0x105e44d84: str      x8, [sp, #0x68] ; 'length'
0x105e44d88: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105e44d8c: ldr      x9, [x8, #0xb88] ; @selector(dataUsingEncoding:) | 'dataUsingEncoding:'
0x105e44d90: adrp     x8, #0x11eca5000 ; @selector(voiceIdSet)
0x105e44d94: ldr      x8, [x8, #0x568] ; @selector(JSONObjectWithData:options:error:) | 'JSONObjectWithData:options:error:'
0x105e44d98: stp      x8, x9, [sp, #0x48] ; 'JSONObjectWithData:options:error:'
0x105e44d9c: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105e44da0: ldr      x9, [x8, #0x148] ; @selector(initWithBase64EncodedString:options:) | 'initWithBase64EncodedString:options:'
0x105e44da4: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105e44da8: ldr      x8, [x8, #0x268] ; @selector(initWithData:encoding:) | 'initWithData:encoding:'
0x105e44dac: stp      x8, x9, [sp, #0x38] ; 'initWithData:encoding:'
0x105e44db0: adrp     x8, #0x11e9c9000
0x105e44db4: ldr      x9, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105e44db8: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44dbc: ldr      x10, [x8, #0x980] ; @selector(onNewSyncChatbotNotifyReaded:) | 'onNewSyncChatbotNotifyReaded:'
0x105e44dc0: adrp     x8, #0x11e9c9000
0x105e44dc4: ldr      x8, [x8, #0xe58] ; @selector(callExtension:selector:block:) | 'callExtension:selector:block:'
0x105e44dc8: stp      x8, x9, [sp, #0x120] ; 'callExtension:selector:block:'
0x105e44dcc: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44dd0: ldr      x8, [x8, #0x978] ; @selector(onNewSyncChatbotMsgSync:) | 'onNewSyncChatbotMsgSync:'
0x105e44dd4: stp      x8, x10, [sp, #0xf8] ; 'onNewSyncChatbotMsgSync:'
0x105e44dd8: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44ddc: ldr      x9, [x8, #0x970] ; @selector(onNewSyncRecordSync:) | 'onNewSyncRecordSync:'
0x105e44de0: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44de4: ldr      x8, [x8, #0x968] ; @selector(onNewSyncRoamResult:) | 'onNewSyncRoamResult:'
0x105e44de8: stp      x8, x9, [sp, #0xe8] ; 'onNewSyncRoamResult:'
0x105e44dec: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44df0: ldr      x9, [x8, #0x960] ; @selector(onNewSyncScheduleChange:) | 'onNewSyncScheduleChange:'
0x105e44df4: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44df8: ldr      x8, [x8, #0x958] ; @selector(onNewSyncShareCardMessageStatus:) | 'onNewSyncShareCardMessageStatus:'
0x105e44dfc: stp      x8, x9, [sp, #0xd8] ; 'onNewSyncShareCardMessageStatus:'
0x105e44e00: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44e04: ldr      x9, [x8, #0x950] ; @selector(onNewSyncPauseMigration:) | 'onNewSyncPauseMigration:'
0x105e44e08: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44e0c: ldr      x8, [x8, #0x948] ; @selector(onNewSyncCloseMigration:) | 'onNewSyncCloseMigration:'
0x105e44e10: stp      x8, x9, [sp, #0xc8] ; 'onNewSyncCloseMigration:'
0x105e44e14: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44e18: ldr      x9, [x8, #0x940] ; @selector(onNewSyncSendCommand:) | 'onNewSyncSendCommand:'
0x105e44e1c: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44e20: ldr      x8, [x8, #0x938] ; @selector(onNewSyncNotifyUnlock:) | 'onNewSyncNotifyUnlock:'
0x105e44e24: stp      x8, x9, [sp, #0xb8] ; 'onNewSyncNotifyUnlock:'
0x105e44e28: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44e2c: ldr      x9, [x8, #0x930] ; @selector(onNewSyncMarkFunction:) | 'onNewSyncMarkFunction:'
0x105e44e30: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44e34: ldr      x8, [x8, #0x928] ; @selector(onNewSyncQuitFunction:) | 'onNewSyncQuitFunction:'
0x105e44e38: stp      x8, x9, [sp, #0xa8] ; 'onNewSyncQuitFunction:'
0x105e44e3c: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44e40: ldr      x9, [x8, #0x920] ; @selector(onNewSyncEnterFunction:) | 'onNewSyncEnterFunction:'
0x105e44e44: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44e48: ldr      x8, [x8, #0x918] ; @selector(onNewSyncChatListSession:) | 'onNewSyncChatListSession:'
0x105e44e4c: stp      x8, x9, [sp, #0x98] ; 'onNewSyncChatListSession:'
0x105e44e50: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44e54: ldr      x9, [x8, #0x910] ; @selector(onNewSyncMarkUnread:) | 'onNewSyncMarkUnread:'
0x105e44e58: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44e5c: ldr      x8, [x8, #0x8f0] ; @selector(StatusNotifyParseCreateTime:chatName:) | 'StatusNotifyParseCreateTime:chatName:'
0x105e44e60: str      x8, [sp, #0x108] ; 'StatusNotifyParseCreateTime:chatName:'
0x105e44e64: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44e68: ldr      x8, [x8, #0x908] ; @selector(onNewSyncHideSession:createTime:) | 'onNewSyncHideSession:createTime:'
0x105e44e6c: stp      x8, x9, [sp, #0x88] ; 'onNewSyncHideSession:createTime:'
0x105e44e70: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44e74: ldr      x9, [x8, #0x900] ; @selector(onNewSyncQuitSession:createTime:) | 'onNewSyncQuitSession:createTime:'
0x105e44e78: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44e7c: ldr      x8, [x8, #0x8f8] ; @selector(onNewSyncEnterSession:createTime:) | 'onNewSyncEnterSession:createTime:'
0x105e44e80: stp      x8, x9, [sp, #0x78] ; 'onNewSyncEnterSession:createTime:'
0x105e44e84: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e44e88: ldr      x8, [x8, #0x8e8] ; @selector(onNewSyncGetAllChat) | 'onNewSyncGetAllChat'
0x105e44e8c: str      x8, [sp, #0x70] ; 'onNewSyncGetAllChat'
0x105e44e90: ldr      x8, [sp, #0x470]
0x105e44e94: ldr      x8, [x8]
0x105e44e98: ldr      x9, [sp, #0x130]
0x105e44e9c: cmp      x8, x9
0x105e44ea0: b.eq     #0x105e44eac
0x105e44ea4: ldr      x0, [sp, #0x118]
0x105e44ea8: bl       #0x107c27c3c ; _objc_enumerationMutation
0x105e44eac: ldr      x8, [sp, #0x468]
0x105e44eb0: ldr      x20, [x8, x23, lsl #3]
0x105e44eb4: mov      x0, x20
0x105e44eb8: mov      x1, x24 ; 'objectForKeyedSubscript:'
0x105e44ebc: adrp     x2, #0x11d2b1000
0x105e44ec0: add      x2, x2, #0x338 ; @'opcode'
0x105e44ec4: bl       #0x107c27c64 ; _objc_msgSend | selector=objectForKeyedSubscript:
0x105e44ec8: mov      x29, x29
0x105e44ecc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e44ed0: mov      x26, x0
0x105e44ed4: mov      x1, x28 ; 'unsignedIntValue'
0x105e44ed8: bl       #0x107c27c64 ; _objc_msgSend | selector=unsignedIntValue
0x105e44edc: mov      x25, x0
0x105e44ee0: adrp     x8, #0x11ed12000
0x105e44ee4: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e44ee8: adrp     x8, #0x11d353000
0x105e44eec: add      x8, x8, #0xb78 ; @'local push count uiOpCode:%u'
0x105e44ef0: stp      x8, x25, [sp] ; @'local push count uiOpCode:%u'
0x105e44ef4: ldr      x1, [sp, #0x140]
0x105e44ef8: mov      w2, #2
0x105e44efc: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105e44f00: add      x3, x3, #0xfaf ; 'Sync'
0x105e44f04: mov      w4, #0
0x105e44f08: adrp     x5, #0x11a2e0000 ; 'tice?language='
0x105e44f0c: add      x5, x5, #0x21 ; 'SyncCmdHandler.mm'
0x105e44f10: mov      w6, #0x3a9
0x105e44f14: adrp     x7, #0x11a2e0000 ; 'tice?language='
0x105e44f18: add      x7, x7, #0x5a9 ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]_block_invoke_3'
0x105e44f1c: bl       #0x107c27c64 ; _objc_msgSend
0x105e44f20: mov      x0, x20
0x105e44f24: mov      x1, x21 ; 'objectForKey:'
0x105e44f28: adrp     x2, #0x11cfab000
0x105e44f2c: add      x2, x2, #0x4d8 ; @'chatname'
0x105e44f30: bl       #0x107c27c64 ; _objc_msgSend | selector=objectForKey:
0x105e44f34: mov      x29, x29
0x105e44f38: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e44f3c: mov      x27, x0
0x105e44f40: mov      x1, x22 ; 'isEqualToString:'
0x105e44f44: adrp     x2, #0x11d353000
0x105e44f48: add      x2, x2, #0xb98 ; @'notifymessage'
0x105e44f4c: bl       #0x107c27c64 ; _objc_msgSend | selector=isEqualToString:
0x105e44f50: cbz      w0, #0x105e44f64
0x105e44f54: mov      x0, x27
0x105e44f58: bl       #0x107c27c70 ; _objc_release
0x105e44f5c: adrp     x27, #0x11cfae000
0x105e44f60: add      x27, x27, #0x6f8 ; @'notification_messages'
0x105e44f64: sub      w8, w25, #2
0x105e44f68: cmp      w8, #0x1b
0x105e44f6c: b.hi     #0x105e45ab0
0x105e44f70: adrp     x11, #0x1178da000
0x105e44f74: add      x11, x11, #0x638
0x105e44f78: adr      x9, #0x105e44f88
0x105e44f7c: ldrh     w10, [x11, x8, lsl #1]
0x105e44f80: add      x9, x9, x10, lsl #2
0x105e44f84: br       x9
0x105e44f88: ldr      x8, [sp, #0x148]
0x105e44f8c: ldr      x0, [x8, #0x38]
0x105e44f90: ldr      x1, [sp, #0x108]
0x105e44f94: mov      x2, x20
0x105e44f98: mov      x3, x27 ; @'notification_messages'
0x105e44f9c: bl       #0x107c27c64 ; _objc_msgSend
0x105e44fa0: mov      x19, x0
0x105e44fa4: adrp     x8, #0x11ed12000
0x105e44fa8: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e44fac: ldr      x1, [sp, #0x128]
0x105e44fb0: bl       #0x107c27c64 ; _objc_msgSend
0x105e44fb4: mov      x29, x29
0x105e44fb8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e44fbc: mov      x20, x0
0x105e44fc0: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e44fc4: ldr      x25, [x8, #0x760]
0x105e44fc8: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e44fcc: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e44fd0: str      x8, [sp, #0x430]
0x105e44fd4: str      d8, [sp, #0x438]
0x105e44fd8: adrp     x8, #0x105e45000
0x105e44fdc: add      x8, x8, #0xc24
0x105e44fe0: str      x8, [sp, #0x440]
0x105e44fe4: adrp     x8, #0x11c280000
0x105e44fe8: add      x8, x8, #0x8a0
0x105e44fec: str      x8, [sp, #0x448]
0x105e44ff0: mov      x0, x27 ; @'notification_messages'
0x105e44ff4: bl       #0x107c27c74 ; _objc_retain
0x105e44ff8: str      x27, [sp, #0x450] ; @'notification_messages'
0x105e44ffc: str      w19, [sp, #0x458]
0x105e45000: add      x4, sp, #0x430
0x105e45004: mov      x0, x20
0x105e45008: ldr      x1, [sp, #0x120]
0x105e4500c: mov      x2, x25
0x105e45010: ldr      x3, [sp, #0x78]
0x105e45014: bl       #0x107c27c64 ; _objc_msgSend
0x105e45018: mov      x0, x20
0x105e4501c: bl       #0x107c27c70 ; _objc_release
0x105e45020: ldr      x0, [sp, #0x450]
0x105e45024: b        #0x105e45aac
0x105e45028: adrp     x8, #0x11ed12000
0x105e4502c: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e45030: ldr      x1, [sp, #0x128]
0x105e45034: bl       #0x107c27c64 ; _objc_msgSend
0x105e45038: mov      x29, x29
0x105e4503c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e45040: mov      x19, x0
0x105e45044: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e45048: ldr      x2, [x8, #0x760]
0x105e4504c: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e45050: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e45054: str      x8, [sp, #0x1a0]
0x105e45058: str      d8, [sp, #0x1a8]
0x105e4505c: adrp     x8, #0x105e45000
0x105e45060: add      x9, x8, #0xdb0
0x105e45064: adrp     x8, #0x11c280000
0x105e45068: add      x8, x8, #0x7e0
0x105e4506c: stp      x9, x8, [sp, #0x1b0]
0x105e45070: str      x20, [sp, #0x1c0]
0x105e45074: add      x4, sp, #0x1a0
0x105e45078: ldr      x1, [sp, #0x120]
0x105e4507c: ldr      x3, [sp, #0xf8]
0x105e45080: b        #0x105e45aa4
0x105e45084: adrp     x8, #0x11ed12000
0x105e45088: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e4508c: ldr      x1, [sp, #0x128]
0x105e45090: bl       #0x107c27c64 ; _objc_msgSend
0x105e45094: mov      x29, x29
0x105e45098: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e4509c: mov      x19, x0
0x105e450a0: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e450a4: ldr      x2, [x8, #0x760]
0x105e450a8: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e450ac: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e450b0: str      x8, [sp, #0x240]
0x105e450b4: str      d8, [sp, #0x248]
0x105e450b8: adrp     x8, #0x105e45000
0x105e450bc: add      x8, x8, #0xd50
0x105e450c0: str      x8, [sp, #0x250]
0x105e450c4: adrp     x8, #0x11c280000
0x105e450c8: add      x8, x8, #0x7e0
0x105e450cc: str      x8, [sp, #0x258]
0x105e450d0: str      x20, [sp, #0x260]
0x105e450d4: add      x4, sp, #0x240
0x105e450d8: ldr      x1, [sp, #0x120]
0x105e450dc: ldr      x3, [sp, #0xd8]
0x105e450e0: b        #0x105e45aa4
0x105e450e4: ldr      x8, [sp, #0x148]
0x105e450e8: ldr      x0, [x8, #0x38]
0x105e450ec: ldr      x1, [sp, #0x108]
0x105e450f0: mov      x2, x20
0x105e450f4: mov      x3, x27 ; @'notification_messages'
0x105e450f8: bl       #0x107c27c64 ; _objc_msgSend
0x105e450fc: mov      x19, x0
0x105e45100: adrp     x8, #0x11ed12000
0x105e45104: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e45108: ldr      x1, [sp, #0x128]
0x105e4510c: bl       #0x107c27c64 ; _objc_msgSend
0x105e45110: mov      x29, x29
0x105e45114: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e45118: mov      x20, x0
0x105e4511c: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e45120: ldr      x25, [x8, #0x760]
0x105e45124: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e45128: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e4512c: str      x8, [sp, #0x3d0]
0x105e45130: str      d8, [sp, #0x3d8]
0x105e45134: adrp     x8, #0x105e45000
0x105e45138: add      x8, x8, #0xc5c
0x105e4513c: str      x8, [sp, #0x3e0]
0x105e45140: adrp     x8, #0x11c280000
0x105e45144: add      x8, x8, #0x8a0
0x105e45148: str      x8, [sp, #0x3e8]
0x105e4514c: mov      x0, x27 ; @'notification_messages'
0x105e45150: bl       #0x107c27c74 ; _objc_retain
0x105e45154: str      x27, [sp, #0x3f0] ; @'notification_messages'
0x105e45158: str      w19, [sp, #0x3f8]
0x105e4515c: add      x4, sp, #0x3d0
0x105e45160: mov      x0, x20
0x105e45164: ldr      x1, [sp, #0x120]
0x105e45168: mov      x2, x25
0x105e4516c: ldr      x3, [sp, #0x88]
0x105e45170: bl       #0x107c27c64 ; _objc_msgSend
0x105e45174: mov      x0, x20
0x105e45178: bl       #0x107c27c70 ; _objc_release
0x105e4517c: ldr      x0, [sp, #0x3f0]
0x105e45180: b        #0x105e45aac
0x105e45184: adrp     x8, #0x11ed12000
0x105e45188: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e4518c: ldr      x1, [sp, #0x128]
0x105e45190: bl       #0x107c27c64 ; _objc_msgSend
0x105e45194: mov      x29, x29
0x105e45198: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e4519c: mov      x19, x0
0x105e451a0: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e451a4: ldr      x2, [x8, #0x760]
0x105e451a8: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e451ac: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e451b0: str      x8, [sp, #0x268]
0x105e451b4: str      d8, [sp, #0x270]
0x105e451b8: adrp     x8, #0x105e45000
0x105e451bc: add      x8, x8, #0xd38
0x105e451c0: str      x8, [sp, #0x278]
0x105e451c4: adrp     x8, #0x11c280000
0x105e451c8: add      x8, x8, #0x7e0
0x105e451cc: str      x8, [sp, #0x280]
0x105e451d0: str      x20, [sp, #0x288]
0x105e451d4: add      x4, sp, #0x268
0x105e451d8: ldr      x1, [sp, #0x120]
0x105e451dc: ldr      x3, [sp, #0xd0]
0x105e451e0: b        #0x105e45aa4
0x105e451e4: adrp     x8, #0x11ed12000
0x105e451e8: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e451ec: ldr      x1, [sp, #0x128]
0x105e451f0: bl       #0x107c27c64 ; _objc_msgSend
0x105e451f4: mov      x29, x29
0x105e451f8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e451fc: mov      x19, x0
0x105e45200: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e45204: ldr      x2, [x8, #0x760]
0x105e45208: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e4520c: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e45210: str      x8, [sp, #0x178]
0x105e45214: str      d8, [sp, #0x180]
0x105e45218: adrp     x8, #0x105e45000
0x105e4521c: add      x9, x8, #0xdc8
0x105e45220: adrp     x8, #0x11c280000
0x105e45224: add      x8, x8, #0x7e0
0x105e45228: stp      x9, x8, [sp, #0x188]
0x105e4522c: str      x20, [sp, #0x198]
0x105e45230: add      x4, sp, #0x178
0x105e45234: ldr      x1, [sp, #0x120]
0x105e45238: ldr      x3, [sp, #0x100]
0x105e4523c: b        #0x105e45aa4
0x105e45240: mov      x0, x20
0x105e45244: mov      x1, x21 ; 'objectForKey:'
0x105e45248: adrp     x2, #0x11d353000
0x105e4524c: add      x2, x2, #0xbb8 ; @'unreadSessions'
0x105e45250: bl       #0x107c27c64 ; _objc_msgSend | selector=objectForKey:
0x105e45254: mov      x29, x29
0x105e45258: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e4525c: mov      x19, x0
0x105e45260: adrp     x8, #0x11ed12000
0x105e45264: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e45268: ldr      x1, [sp, #0x128]
0x105e4526c: bl       #0x107c27c64 ; _objc_msgSend
0x105e45270: mov      x29, x29
0x105e45274: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e45278: mov      x20, x0
0x105e4527c: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e45280: ldr      x25, [x8, #0x760]
0x105e45284: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e45288: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e4528c: str      x8, [sp, #0x380]
0x105e45290: str      d8, [sp, #0x388]
0x105e45294: adrp     x8, #0x105e45000
0x105e45298: add      x8, x8, #0xc90
0x105e4529c: str      x8, [sp, #0x390]
0x105e452a0: adrp     x8, #0x11c280000
0x105e452a4: add      x8, x8, #0x7e0
0x105e452a8: str      x8, [sp, #0x398]
0x105e452ac: str      x19, [sp, #0x3a0]
0x105e452b0: mov      x0, x19
0x105e452b4: bl       #0x107c27c74 ; _objc_retain
0x105e452b8: add      x4, sp, #0x380
0x105e452bc: mov      x0, x20
0x105e452c0: ldr      x1, [sp, #0x120]
0x105e452c4: mov      x2, x25
0x105e452c8: ldr      x3, [sp, #0x98]
0x105e452cc: bl       #0x107c27c64 ; _objc_msgSend
0x105e452d0: mov      x0, x20
0x105e452d4: bl       #0x107c27c70 ; _objc_release
0x105e452d8: ldr      x0, [sp, #0x3a0]
0x105e452dc: bl       #0x107c27c70 ; _objc_release
0x105e452e0: b        #0x105e45aa8
0x105e452e4: adrp     x8, #0x11ed12000
0x105e452e8: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e452ec: ldr      x1, [sp, #0x128]
0x105e452f0: bl       #0x107c27c64 ; _objc_msgSend
0x105e452f4: mov      x29, x29
0x105e452f8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e452fc: mov      x19, x0
0x105e45300: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e45304: ldr      x2, [x8, #0x760]
0x105e45308: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e4530c: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e45310: str      x8, [sp, #0x330]
0x105e45314: str      d8, [sp, #0x338]
0x105e45318: adrp     x8, #0x105e45000
0x105e4531c: add      x8, x8, #0xcc0
0x105e45320: str      x8, [sp, #0x340]
0x105e45324: adrp     x8, #0x11c280000
0x105e45328: add      x8, x8, #0x7e0
0x105e4532c: str      x8, [sp, #0x348]
0x105e45330: str      x20, [sp, #0x350]
0x105e45334: add      x4, sp, #0x330
0x105e45338: ldr      x1, [sp, #0x120]
0x105e4533c: ldr      x3, [sp, #0xa8]
0x105e45340: b        #0x105e45aa4
0x105e45344: adrp     x8, #0x11ed12000
0x105e45348: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e4534c: ldr      x1, [sp, #0x128]
0x105e45350: bl       #0x107c27c64 ; _objc_msgSend
0x105e45354: mov      x29, x29
0x105e45358: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e4535c: mov      x19, x0
0x105e45360: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e45364: ldr      x2, [x8, #0x760]
0x105e45368: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e4536c: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e45370: str      x8, [sp, #0x290]
0x105e45374: str      d8, [sp, #0x298]
0x105e45378: adrp     x8, #0x105e45000
0x105e4537c: add      x8, x8, #0xd20
0x105e45380: str      x8, [sp, #0x2a0]
0x105e45384: adrp     x8, #0x11c280000
0x105e45388: add      x8, x8, #0x7e0
0x105e4538c: str      x8, [sp, #0x2a8]
0x105e45390: str      x20, [sp, #0x2b0]
0x105e45394: add      x4, sp, #0x290
0x105e45398: ldr      x1, [sp, #0x120]
0x105e4539c: ldr      x3, [sp, #0xc8]
0x105e453a0: b        #0x105e45aa4
0x105e453a4: adrp     x8, #0x11ed12000
0x105e453a8: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e453ac: ldr      x1, [sp, #0x128]
0x105e453b0: bl       #0x107c27c64 ; _objc_msgSend
0x105e453b4: mov      x29, x29
0x105e453b8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e453bc: mov      x19, x0
0x105e453c0: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e453c4: ldr      x2, [x8, #0x760]
0x105e453c8: ldr      x1, [sp, #0x120]
0x105e453cc: ldr      x3, [sp, #0x70]
0x105e453d0: adrp     x4, #0x11c309000
0x105e453d4: add      x4, x4, #0x5c8 ; __NSConcreteGlobalBlock
0x105e453d8: b        #0x105e45aa4
0x105e453dc: adrp     x8, #0x11ed12000
0x105e453e0: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e453e4: ldr      x1, [sp, #0x128]
0x105e453e8: bl       #0x107c27c64 ; _objc_msgSend
0x105e453ec: mov      x29, x29
0x105e453f0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e453f4: mov      x19, x0
0x105e453f8: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e453fc: ldr      x2, [x8, #0x760]
0x105e45400: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e45404: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e45408: str      x8, [sp, #0x308]
0x105e4540c: str      d8, [sp, #0x310]
0x105e45410: adrp     x8, #0x105e45000
0x105e45414: add      x8, x8, #0xcd8
0x105e45418: str      x8, [sp, #0x318]
0x105e4541c: adrp     x8, #0x11c280000
0x105e45420: add      x8, x8, #0x7e0
0x105e45424: str      x8, [sp, #0x320]
0x105e45428: str      x20, [sp, #0x328]
0x105e4542c: add      x4, sp, #0x308
0x105e45430: ldr      x1, [sp, #0x120]
0x105e45434: ldr      x3, [sp, #0xb0]
0x105e45438: b        #0x105e45aa4
0x105e4543c: adrp     x8, #0x11ed12000
0x105e45440: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e45444: ldr      x1, [sp, #0x128]
0x105e45448: bl       #0x107c27c64 ; _objc_msgSend
0x105e4544c: mov      x29, x29
0x105e45450: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e45454: mov      x19, x0
0x105e45458: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e4545c: ldr      x2, [x8, #0x760]
0x105e45460: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e45464: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e45468: str      x8, [sp, #0x2b8]
0x105e4546c: str      d8, [sp, #0x2c0]
0x105e45470: adrp     x8, #0x105e45000
0x105e45474: add      x8, x8, #0xd08
0x105e45478: str      x8, [sp, #0x2c8]
0x105e4547c: adrp     x8, #0x11c280000
0x105e45480: add      x8, x8, #0x7e0
0x105e45484: str      x8, [sp, #0x2d0]
0x105e45488: str      x20, [sp, #0x2d8]
0x105e4548c: add      x4, sp, #0x2b8
0x105e45490: ldr      x1, [sp, #0x120]
0x105e45494: ldr      x3, [sp, #0xc0]
0x105e45498: b        #0x105e45aa4
0x105e4549c: adrp     x8, #0x11ed12000
0x105e454a0: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e454a4: ldr      x1, [sp, #0x128]
0x105e454a8: bl       #0x107c27c64 ; _objc_msgSend
0x105e454ac: mov      x29, x29
0x105e454b0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e454b4: mov      x19, x0
0x105e454b8: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e454bc: ldr      x2, [x8, #0x760]
0x105e454c0: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e454c4: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e454c8: str      x8, [sp, #0x218]
0x105e454cc: str      d8, [sp, #0x220]
0x105e454d0: adrp     x8, #0x105e45000
0x105e454d4: add      x8, x8, #0xd68
0x105e454d8: str      x8, [sp, #0x228]
0x105e454dc: adrp     x8, #0x11c280000
0x105e454e0: add      x8, x8, #0x7e0
0x105e454e4: str      x8, [sp, #0x230]
0x105e454e8: str      x20, [sp, #0x238]
0x105e454ec: add      x4, sp, #0x218
0x105e454f0: ldr      x1, [sp, #0x120]
0x105e454f4: ldr      x3, [sp, #0xe0]
0x105e454f8: b        #0x105e45aa4
0x105e454fc: adrp     x8, #0x11ed12000
0x105e45500: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e45504: ldr      x1, [sp, #0x128]
0x105e45508: bl       #0x107c27c64 ; _objc_msgSend
0x105e4550c: mov      x29, x29
0x105e45510: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e45514: mov      x19, x0
0x105e45518: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e4551c: ldr      x2, [x8, #0x760]
0x105e45520: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e45524: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e45528: str      x8, [sp, #0x1f0]
0x105e4552c: str      d8, [sp, #0x1f8]
0x105e45530: adrp     x8, #0x105e45000
0x105e45534: add      x8, x8, #0xd80
0x105e45538: str      x8, [sp, #0x200]
0x105e4553c: adrp     x8, #0x11c280000
0x105e45540: add      x8, x8, #0x7e0
0x105e45544: str      x8, [sp, #0x208]
0x105e45548: str      x20, [sp, #0x210]
0x105e4554c: add      x4, sp, #0x1f0
0x105e45550: ldr      x1, [sp, #0x120]
0x105e45554: ldr      x3, [sp, #0xe8]
0x105e45558: b        #0x105e45aa4
0x105e4555c: ldr      x8, [sp, #0x148]
0x105e45560: ldr      x0, [x8, #0x38]
0x105e45564: ldr      x1, [sp, #0x108]
0x105e45568: mov      x2, x20
0x105e4556c: mov      x3, x27 ; @'notification_messages'
0x105e45570: bl       #0x107c27c64 ; _objc_msgSend
0x105e45574: mov      x19, x0
0x105e45578: adrp     x8, #0x11ed12000
0x105e4557c: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e45580: ldr      x1, [sp, #0x128]
0x105e45584: bl       #0x107c27c64 ; _objc_msgSend
0x105e45588: mov      x29, x29
0x105e4558c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e45590: mov      x20, x0
0x105e45594: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e45598: ldr      x25, [x8, #0x760]
0x105e4559c: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e455a0: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e455a4: str      x8, [sp, #0x400]
0x105e455a8: str      d8, [sp, #0x408]
0x105e455ac: adrp     x8, #0x105e45000
0x105e455b0: add      x8, x8, #0xc40
0x105e455b4: str      x8, [sp, #0x410]
0x105e455b8: adrp     x8, #0x11c280000
0x105e455bc: add      x8, x8, #0x8a0
0x105e455c0: str      x8, [sp, #0x418]
0x105e455c4: mov      x0, x27 ; @'notification_messages'
0x105e455c8: bl       #0x107c27c74 ; _objc_retain
0x105e455cc: str      x27, [sp, #0x420] ; @'notification_messages'
0x105e455d0: str      w19, [sp, #0x428]
0x105e455d4: add      x4, sp, #0x400
0x105e455d8: mov      x0, x20
0x105e455dc: ldr      x1, [sp, #0x120]
0x105e455e0: mov      x2, x25
0x105e455e4: ldr      x3, [sp, #0x80]
0x105e455e8: bl       #0x107c27c64 ; _objc_msgSend
0x105e455ec: mov      x0, x20
0x105e455f0: bl       #0x107c27c70 ; _objc_release
0x105e455f4: ldr      x0, [sp, #0x420]
0x105e455f8: b        #0x105e45aac
0x105e455fc: adrp     x8, #0x11ed12000
0x105e45600: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e45604: ldr      x1, [sp, #0x128]
0x105e45608: bl       #0x107c27c64 ; _objc_msgSend
0x105e4560c: mov      x29, x29
0x105e45610: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e45614: mov      x19, x0
0x105e45618: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e4561c: ldr      x2, [x8, #0x760]
0x105e45620: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e45624: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e45628: str      x8, [sp, #0x358]
0x105e4562c: str      d8, [sp, #0x360]
0x105e45630: adrp     x8, #0x105e45000
0x105e45634: add      x8, x8, #0xca8
0x105e45638: str      x8, [sp, #0x368]
0x105e4563c: adrp     x8, #0x11c280000
0x105e45640: add      x8, x8, #0x7e0
0x105e45644: str      x8, [sp, #0x370]
0x105e45648: str      x20, [sp, #0x378]
0x105e4564c: add      x4, sp, #0x358
0x105e45650: ldr      x1, [sp, #0x120]
0x105e45654: ldr      x3, [sp, #0xa0]
0x105e45658: b        #0x105e45aa4
0x105e4565c: adrp     x8, #0x11ed12000
0x105e45660: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e45664: ldr      x1, [sp, #0x128]
0x105e45668: bl       #0x107c27c64 ; _objc_msgSend
0x105e4566c: mov      x29, x29
0x105e45670: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e45674: mov      x19, x0
0x105e45678: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e4567c: ldr      x20, [x8, #0x760]
0x105e45680: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e45684: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e45688: str      x8, [sp, #0x3a8]
0x105e4568c: str      d8, [sp, #0x3b0]
0x105e45690: adrp     x8, #0x105e45000
0x105e45694: add      x8, x8, #0xc78
0x105e45698: str      x8, [sp, #0x3b8]
0x105e4569c: adrp     x8, #0x11c280000
0x105e456a0: add      x8, x8, #0x7e0
0x105e456a4: str      x8, [sp, #0x3c0]
0x105e456a8: mov      x0, x27 ; @'notification_messages'
0x105e456ac: bl       #0x107c27c74 ; _objc_retain
0x105e456b0: str      x27, [sp, #0x3c8] ; @'notification_messages'
0x105e456b4: add      x4, sp, #0x3a8
0x105e456b8: mov      x0, x19
0x105e456bc: ldr      x1, [sp, #0x120]
0x105e456c0: mov      x2, x20
0x105e456c4: ldr      x3, [sp, #0x90]
0x105e456c8: bl       #0x107c27c64 ; _objc_msgSend
0x105e456cc: mov      x0, x19
0x105e456d0: bl       #0x107c27c70 ; _objc_release
0x105e456d4: ldr      x0, [sp, #0x3c8]
0x105e456d8: b        #0x105e45aac
0x105e456dc: adrp     x8, #0x11ed12000
0x105e456e0: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e456e4: ldr      x1, [sp, #0x128]
0x105e456e8: bl       #0x107c27c64 ; _objc_msgSend
0x105e456ec: mov      x29, x29
0x105e456f0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e456f4: mov      x19, x0
0x105e456f8: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e456fc: ldr      x2, [x8, #0x760]
0x105e45700: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e45704: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e45708: str      x8, [sp, #0x2e0]
0x105e4570c: str      d8, [sp, #0x2e8]
0x105e45710: adrp     x8, #0x105e45000
0x105e45714: add      x8, x8, #0xcf0
0x105e45718: str      x8, [sp, #0x2f0]
0x105e4571c: adrp     x8, #0x11c280000
0x105e45720: add      x8, x8, #0x7e0
0x105e45724: str      x8, [sp, #0x2f8]
0x105e45728: str      x20, [sp, #0x300]
0x105e4572c: add      x4, sp, #0x2e0
0x105e45730: ldr      x1, [sp, #0x120]
0x105e45734: ldr      x3, [sp, #0xb8]
0x105e45738: b        #0x105e45aa4
0x105e4573c: mov      x0, x20
0x105e45740: mov      x1, x24 ; 'objectForKeyedSubscript:'
0x105e45744: adrp     x2, #0x11d01e000
0x105e45748: add      x2, x2, #0x658 ; @'functionName'
0x105e4574c: bl       #0x107c27c64 ; _objc_msgSend | selector=objectForKeyedSubscript:
0x105e45750: mov      x29, x29
0x105e45754: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e45758: mov      x19, x0
0x105e4575c: adrp     x8, #0x11ed12000
0x105e45760: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e45764: adrp     x8, #0x11d353000
0x105e45768: add      x8, x8, #0xbd8 ; @'MM_STATUSNOTIFY_SECURITYVERIFICATIONWINDOW functionName=%@'
0x105e4576c: stp      x8, x19, [sp] ; @'MM_STATUSNOTIFY_SECURITYVERIFICATIONWINDOW functionName=%@'
0x105e45770: ldr      x1, [sp, #0x140]
0x105e45774: mov      w2, #2
0x105e45778: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105e4577c: add      x3, x3, #0xfaf ; 'Sync'
0x105e45780: mov      w4, #0
0x105e45784: adrp     x5, #0x11a2e0000 ; 'tice?language='
0x105e45788: add      x5, x5, #0x21 ; 'SyncCmdHandler.mm'
0x105e4578c: mov      w6, #0x3f3
0x105e45790: adrp     x7, #0x11a2e0000 ; 'tice?language='
0x105e45794: add      x7, x7, #0x5a9 ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]_block_invoke_3'
0x105e45798: bl       #0x107c27c64 ; _objc_msgSend
0x105e4579c: mov      x0, x19
0x105e457a0: mov      x1, x22 ; 'isEqualToString:'
0x105e457a4: adrp     x2, #0x11d353000
0x105e457a8: add      x2, x2, #0xbf8 ; @'SecurityVerificationWindow'
0x105e457ac: bl       #0x107c27c64 ; _objc_msgSend | selector=isEqualToString:
0x105e457b0: cbz      w0, #0x105e45aa8
0x105e457b4: stp      x28, x19, [sp, #0x58] ; 'unsignedIntValue'
0x105e457b8: mov      x0, x20
0x105e457bc: mov      x1, x24 ; 'objectForKeyedSubscript:'
0x105e457c0: adrp     x2, #0x11d01e000
0x105e457c4: add      x2, x2, #0x678 ; @'arg'
0x105e457c8: bl       #0x107c27c64 ; _objc_msgSend | selector=objectForKeyedSubscript:
0x105e457cc: mov      x29, x29
0x105e457d0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e457d4: mov      x20, x0
0x105e457d8: adrp     x8, #0x11ed12000
0x105e457dc: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e457e0: adrp     x8, #0x11d353000
0x105e457e4: add      x8, x8, #0xc18 ; @'MM_STATUSNOTIFY_SECURITYVERIFICATIONWINDOW arg=%@'
0x105e457e8: stp      x8, x20, [sp] ; @'MM_STATUSNOTIFY_SECURITYVERIFICATIONWINDOW arg=%@'
0x105e457ec: ldr      x28, [sp, #0x140]
0x105e457f0: mov      x1, x28
0x105e457f4: mov      w2, #2
0x105e457f8: adrp     x25, #0x119cf5000 ; 'ns_filled_pause2'
0x105e457fc: add      x25, x25, #0xfaf ; 'Sync'
0x105e45800: mov      x3, x25 ; 'Sync'
0x105e45804: mov      w4, #0
0x105e45808: adrp     x19, #0x11a2e0000 ; 'tice?language='
0x105e4580c: add      x19, x19, #0x21 ; 'SyncCmdHandler.mm'
0x105e45810: mov      x5, x19 ; 'SyncCmdHandler.mm'
0x105e45814: mov      w6, #0x3f6
0x105e45818: adrp     x7, #0x11a2e0000 ; 'tice?language='
0x105e4581c: add      x7, x7, #0x5a9 ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]_block_invoke_3'
0x105e45820: bl       #0x107c27c64 ; _objc_msgSend
0x105e45824: adrp     x8, #0x11ed12000
0x105e45828: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e4582c: adrp     x8, #0x11d353000
0x105e45830: add      x8, x8, #0xc38 ; @'SecurityVerificationWindow arg=%@'
0x105e45834: stp      x8, x20, [sp] ; @'SecurityVerificationWindow arg=%@'
0x105e45838: mov      x1, x28
0x105e4583c: mov      w2, #2
0x105e45840: mov      x3, x25 ; 'Sync'
0x105e45844: mov      w4, #0
0x105e45848: mov      x5, x19 ; 'SyncCmdHandler.mm'
0x105e4584c: mov      w6, #0x3f7
0x105e45850: adrp     x7, #0x11a2e0000 ; 'tice?language='
0x105e45854: add      x7, x7, #0x5a9 ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]_block_invoke_3'
0x105e45858: bl       #0x107c27c64 ; _objc_msgSend
0x105e4585c: mov      x0, x20
0x105e45860: ldr      x25, [sp, #0x68]
0x105e45864: mov      x1, x25
0x105e45868: bl       #0x107c27c64 ; _objc_msgSend
0x105e4586c: cbz      x0, #0x105e45a3c
0x105e45870: adrp     x8, #0x11ed12000
0x105e45874: ldr      x19, [x8, #0x6e0] ; _OBJC_CLASS_$_NSJSONSerialization
0x105e45878: str      x20, [sp, #0x30]
0x105e4587c: mov      x0, x20
0x105e45880: ldr      x1, [sp, #0x50]
0x105e45884: mov      w2, #4
0x105e45888: bl       #0x107c27c64 ; _objc_msgSend
0x105e4588c: mov      x29, x29
0x105e45890: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e45894: mov      x20, x0
0x105e45898: mov      x0, x19
0x105e4589c: ldr      x1, [sp, #0x48]
0x105e458a0: mov      x2, x20
0x105e458a4: mov      x3, #0
0x105e458a8: mov      x4, #0
0x105e458ac: bl       #0x107c27c64 ; _objc_msgSend
0x105e458b0: mov      x29, x29
0x105e458b4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e458b8: mov      x19, x0
0x105e458bc: mov      x0, x20
0x105e458c0: bl       #0x107c27c70 ; _objc_release
0x105e458c4: mov      x0, x19
0x105e458c8: mov      x1, x24 ; 'objectForKeyedSubscript:'
0x105e458cc: adrp     x2, #0x11d353000
0x105e458d0: add      x2, x2, #0xc58 ; @'windowxml'
0x105e458d4: bl       #0x107c27c64 ; _objc_msgSend | selector=objectForKeyedSubscript:
0x105e458d8: mov      x29, x29
0x105e458dc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e458e0: mov      x20, x0
0x105e458e4: adrp     x8, #0x11ed12000
0x105e458e8: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e458ec: adrp     x8, #0x11d353000
0x105e458f0: add      x8, x8, #0xc78 ; @'SecurityVerificationWindow windowxml(base64)=%@'
0x105e458f4: stp      x8, x20, [sp] ; @'SecurityVerificationWindow windowxml(base64)=%@'
0x105e458f8: ldr      x1, [sp, #0x140]
0x105e458fc: mov      w2, #2
0x105e45900: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105e45904: add      x3, x3, #0xfaf ; 'Sync'
0x105e45908: mov      w4, #0
0x105e4590c: adrp     x5, #0x11a2e0000 ; 'tice?language='
0x105e45910: add      x5, x5, #0x21 ; 'SyncCmdHandler.mm'
0x105e45914: mov      w6, #0x3fd
0x105e45918: adrp     x7, #0x11a2e0000 ; 'tice?language='
0x105e4591c: add      x7, x7, #0x5a9 ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]_block_invoke_3'
0x105e45920: bl       #0x107c27c64 ; _objc_msgSend
0x105e45924: mov      x0, x20
0x105e45928: mov      x1, x25
0x105e4592c: bl       #0x107c27c64 ; _objc_msgSend
0x105e45930: cbz      x0, #0x105e45a28
0x105e45934: adrp     x8, #0x11ed12000
0x105e45938: ldr      x0, [x8, #0x6d8] ; _OBJC_CLASS_$_NSData
0x105e4593c: bl       #0x107c27c08 ; _objc_alloc
0x105e45940: ldr      x1, [sp, #0x40]
0x105e45944: str      x20, [sp, #0x28]
0x105e45948: mov      x2, x20
0x105e4594c: mov      x3, #0
0x105e45950: bl       #0x107c27c64 ; _objc_msgSend
0x105e45954: mov      x20, x0
0x105e45958: adrp     x8, #0x11ed12000
0x105e4595c: ldr      x0, [x8, #0x638] ; _OBJC_CLASS_$_NSString
0x105e45960: bl       #0x107c27c08 ; _objc_alloc
0x105e45964: ldr      x1, [sp, #0x38]
0x105e45968: mov      x28, x20
0x105e4596c: mov      x2, x20
0x105e45970: mov      w3, #4
0x105e45974: bl       #0x107c27c64 ; _objc_msgSend
0x105e45978: mov      x20, x0
0x105e4597c: adrp     x8, #0x11ed12000
0x105e45980: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e45984: adrp     x8, #0x11d353000
0x105e45988: add      x8, x8, #0xc98 ; @'SecurityVerificationWindow decodedXml=%@'
0x105e4598c: stp      x8, x20, [sp] ; @'SecurityVerificationWindow decodedXml=%@'
0x105e45990: ldr      x1, [sp, #0x140]
0x105e45994: mov      w2, #2
0x105e45998: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105e4599c: add      x3, x3, #0xfaf ; 'Sync'
0x105e459a0: mov      w4, #0
0x105e459a4: adrp     x5, #0x11a2e0000 ; 'tice?language='
0x105e459a8: add      x5, x5, #0x21 ; 'SyncCmdHandler.mm'
0x105e459ac: mov      w6, #0x401
0x105e459b0: adrp     x7, #0x11a2e0000 ; 'tice?language='
0x105e459b4: add      x7, x7, #0x5a9 ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]_block_invoke_3'
0x105e459b8: bl       #0x107c27c64 ; _objc_msgSend
0x105e459bc: mov      x0, x20
0x105e459c0: mov      x1, x25
0x105e459c4: bl       #0x107c27c64 ; _objc_msgSend
0x105e459c8: cbz      x0, #0x105e45a14
0x105e459cc: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e459d0: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e459d4: str      x8, [sp, #0x150]
0x105e459d8: str      d8, [sp, #0x158]
0x105e459dc: adrp     x8, #0x105e45000
0x105e459e0: add      x9, x8, #0xde0
0x105e459e4: adrp     x8, #0x11c280000
0x105e459e8: add      x8, x8, #0x470
0x105e459ec: stp      x9, x8, [sp, #0x160]
0x105e459f0: mov      x0, x20
0x105e459f4: bl       #0x107c27c74 ; _objc_retain
0x105e459f8: str      x20, [sp, #0x170]
0x105e459fc: add      x1, sp, #0x150
0x105e45a00: adrp     x0, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e45a04: ldr      x0, [x0, #0xa98] ; __dispatch_main_q
0x105e45a08: bl       #0x107c0cb9c
0x105e45a0c: ldr      x0, [sp, #0x170]
0x105e45a10: bl       #0x107c27c70 ; _objc_release
0x105e45a14: mov      x0, x20
0x105e45a18: bl       #0x107c27c70 ; _objc_release
0x105e45a1c: mov      x0, x28
0x105e45a20: bl       #0x107c27c70 ; _objc_release
0x105e45a24: ldr      x20, [sp, #0x28]
0x105e45a28: mov      x0, x20
0x105e45a2c: bl       #0x107c27c70 ; _objc_release
0x105e45a30: mov      x0, x19
0x105e45a34: bl       #0x107c27c70 ; _objc_release
0x105e45a38: ldr      x20, [sp, #0x30]
0x105e45a3c: mov      x0, x20
0x105e45a40: bl       #0x107c27c70 ; _objc_release
0x105e45a44: ldp      x28, x19, [sp, #0x58]
0x105e45a48: b        #0x105e45aa8
0x105e45a4c: adrp     x8, #0x11ed12000
0x105e45a50: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e45a54: ldr      x1, [sp, #0x128]
0x105e45a58: bl       #0x107c27c64 ; _objc_msgSend
0x105e45a5c: mov      x29, x29
0x105e45a60: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e45a64: mov      x19, x0
0x105e45a68: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e45a6c: ldr      x2, [x8, #0x760]
0x105e45a70: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e45a74: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e45a78: str      x8, [sp, #0x1c8]
0x105e45a7c: str      d8, [sp, #0x1d0]
0x105e45a80: adrp     x8, #0x105e45000
0x105e45a84: add      x9, x8, #0xd98
0x105e45a88: adrp     x8, #0x11c280000
0x105e45a8c: add      x8, x8, #0x7e0
0x105e45a90: stp      x9, x8, [sp, #0x1d8]
0x105e45a94: str      x20, [sp, #0x1e8]
0x105e45a98: add      x4, sp, #0x1c8
0x105e45a9c: ldr      x1, [sp, #0x120]
0x105e45aa0: ldr      x3, [sp, #0xf0]
0x105e45aa4: bl       #0x107c27c64 ; _objc_msgSend
0x105e45aa8: mov      x0, x19
0x105e45aac: bl       #0x107c27c70 ; _objc_release
0x105e45ab0: mov      x0, x27 ; @'notification_messages'
0x105e45ab4: bl       #0x107c27c70 ; _objc_release
0x105e45ab8: mov      x0, x26
0x105e45abc: bl       #0x107c27c70 ; _objc_release
0x105e45ac0: add      x23, x23, #1
0x105e45ac4: ldr      x8, [sp, #0x138]
0x105e45ac8: cmp      x8, x23
0x105e45acc: b.ne     #0x105e44e90
0x105e45ad0: add      x2, sp, #0x460
0x105e45ad4: add      x3, sp, #0x850
0x105e45ad8: ldp      x1, x0, [sp, #0x110]
0x105e45adc: mov      w4, #0x10
0x105e45ae0: bl       #0x107c27c64 ; _objc_msgSend
0x105e45ae4: str      x0, [sp, #0x138]
0x105e45ae8: cbnz     x0, #0x105e44d58
0x105e45aec: ldr      x0, [sp, #0x118]
0x105e45af0: bl       #0x107c27c70 ; _objc_release
0x105e45af4: ldur     x8, [x29, #-0x70]
0x105e45af8: adrp     x9, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e45afc: ldr      x9, [x9, #0xa30] ; ___stack_chk_guard
0x105e45b00: ldr      x9, [x9]
0x105e45b04: cmp      x9, x8
0x105e45b08: b.ne     #0x105e45b30
0x105e45b0c: add      sp, sp, #0xce0
0x105e45b10: ldp      x29, x30, [sp, #0x60]
0x105e45b14: ldp      x20, x19, [sp, #0x50]
0x105e45b18: ldp      x22, x21, [sp, #0x40] ; 'isEqualToString:'
0x105e45b1c: ldp      x24, x23, [sp, #0x30] ; 'objectForKeyedSubscript:'
0x105e45b20: ldp      x26, x25, [sp, #0x20]
0x105e45b24: ldp      x28, x27, [sp, #0x10]
0x105e45b28: ldp      d9, d8, [sp], #0x70
0x105e45b2c: ret      
0x105e45b30: bl       #0x107c27730 ; ___stack_chk_fail
