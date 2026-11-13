-[MicroMessengerAppDelegate handleReceiveRemoteNotification:requestID:] 0x104e8d514 v32@0:8@16@24
0x104e8d514: stp      x24, x23, [sp, #-0x40]!
0x104e8d518: stp      x22, x21, [sp, #0x10]
0x104e8d51c: stp      x20, x19, [sp, #0x20]
0x104e8d520: stp      x29, x30, [sp, #0x30]
0x104e8d524: add      x29, sp, #0x30
0x104e8d528: mov      x20, x3
0x104e8d52c: mov      x19, x2
0x104e8d530: adrp     x8, #0x11f751000
0x104e8d534: mov      w9, #1
0x104e8d538: strb     w9, [x8, #0xe36]
0x104e8d53c: mov      x0, x2
0x104e8d540: bl       #0x107c27c74 ; _objc_retain
0x104e8d544: mov      x0, x20
0x104e8d548: bl       #0x107c27c74 ; _objc_retain
0x104e8d54c: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x104e8d550: ldr      x1, [x8, #0x640] ; @selector(objectForKey:) | 'objectForKey:'
0x104e8d554: adrp     x2, #0x11cfa7000
0x104e8d558: add      x2, x2, #0x598 ; @'cmd'
0x104e8d55c: mov      x0, x19
0x104e8d560: bl       #0x107c27c64 ; _objc_msgSend | selector=objectForKey:
0x104e8d564: mov      x29, x29
0x104e8d568: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e8d56c: mov      x21, x0
0x104e8d570: cbz      x0, #0x104e8d5f8
0x104e8d574: adrp     x8, #0x11eca7000 ; @selector(didReceiveAuthenticationChallengeForDelegate:webView:challenge:completion:)
0x104e8d578: ldr      x1, [x8, #0xea8] ; @selector(hasPrefix:) | 'hasPrefix:'
0x104e8d57c: adrp     x2, #0x11d266000
0x104e8d580: add      x2, x2, #0x298 ; @'216'
0x104e8d584: mov      x0, x21
0x104e8d588: bl       #0x107c27c64 ; _objc_msgSend | selector=hasPrefix:
0x104e8d58c: cbz      w0, #0x104e8d5f8
0x104e8d590: adrp     x8, #0x11ed12000
0x104e8d594: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x104e8d598: adrp     x8, #0x11e9c9000
0x104e8d59c: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x104e8d5a0: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104e8d5a4: mov      x29, x29
0x104e8d5a8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e8d5ac: mov      x22, x0
0x104e8d5b0: adrp     x8, #0x11ed32000 ; classref MagicEcsNirvanaLoadingComponent
0x104e8d5b4: ldr      x0, [x8, #0xc08] ; classref WCFinderGlobalPushJumpMgr | Class WCFinderGlobalPushJumpMgr
0x104e8d5b8: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104e8d5bc: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x104e8d5c0: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104e8d5c4: mov      x2, x0
0x104e8d5c8: adrp     x8, #0x11e9c9000
0x104e8d5cc: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x104e8d5d0: mov      x0, x22
0x104e8d5d4: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104e8d5d8: mov      x29, x29
0x104e8d5dc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e8d5e0: mov      x23, x0
0x104e8d5e4: adrp     x8, #0x11eb26000 ; @selector(getTimelineBackgroundURLSessionIdentifierPrefix)
0x104e8d5e8: ldr      x1, [x8, #0x338] ; @selector(handleInactiveAPNSPushWithUsrInfo:) | 'handleInactiveAPNSPushWithUsrInfo:'
0x104e8d5ec: mov      x2, x19
0x104e8d5f0: bl       #0x107c27c64 ; _objc_msgSend | selector=handleInactiveAPNSPushWithUsrInfo:
0x104e8d5f4: b        #0x104e8d660
0x104e8d5f8: adrp     x8, #0x11ed12000
0x104e8d5fc: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x104e8d600: adrp     x8, #0x11e9c9000
0x104e8d604: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x104e8d608: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104e8d60c: mov      x29, x29
0x104e8d610: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e8d614: mov      x22, x0
0x104e8d618: adrp     x8, #0x11ed1b000 ; classref PatSuffixWrap
0x104e8d61c: ldr      x0, [x8, #0x918] ; classref NotificationActionsMgr | Class NotificationActionsMgr
0x104e8d620: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104e8d624: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x104e8d628: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104e8d62c: mov      x2, x0
0x104e8d630: adrp     x8, #0x11e9c9000
0x104e8d634: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x104e8d638: mov      x0, x22
0x104e8d63c: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104e8d640: mov      x29, x29
0x104e8d644: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e8d648: mov      x23, x0
0x104e8d64c: adrp     x8, #0x11eb25000 ; @selector(setNsSender:)
0x104e8d650: ldr      x1, [x8, #0xf60] ; @selector(handleReceiveRemoteNotification:requestID:) | 'handleReceiveRemoteNotification:requestID:'
0x104e8d654: mov      x2, x19
0x104e8d658: mov      x3, x20
0x104e8d65c: bl       #0x107c27c64 ; _objc_msgSend | selector=handleReceiveRemoteNotification:requestID:
0x104e8d660: mov      x0, x23
0x104e8d664: bl       #0x107c27c70 ; _objc_release
0x104e8d668: mov      x0, x22
0x104e8d66c: bl       #0x107c27c70 ; _objc_release
0x104e8d670: mov      x0, x21
0x104e8d674: bl       #0x107c27c70 ; _objc_release
0x104e8d678: mov      x0, x20
0x104e8d67c: bl       #0x107c27c70 ; _objc_release
0x104e8d680: mov      x0, x19
0x104e8d684: ldp      x29, x30, [sp, #0x30]
0x104e8d688: ldp      x20, x19, [sp, #0x20]
0x104e8d68c: ldp      x22, x21, [sp, #0x10]
0x104e8d690: ldp      x24, x23, [sp], #0x40
0x104e8d694: b        #0x107c27c70 ; _objc_release
