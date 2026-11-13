-[MicroMessengerAppDelegate applicationDidEnterBackground:] 0x104e85520 v24@0:8@16
0x104e85520: sub      sp, sp, #0x90
0x104e85524: stp      x26, x25, [sp, #0x40]
0x104e85528: stp      x24, x23, [sp, #0x50]
0x104e8552c: stp      x22, x21, [sp, #0x60]
0x104e85530: stp      x20, x19, [sp, #0x70]
0x104e85534: stp      x29, x30, [sp, #0x80]
0x104e85538: add      x29, sp, #0x80
0x104e8553c: mov      x19, x2
0x104e85540: mov      x20, x0
0x104e85544: adrp     x8, #0x11f751000
0x104e85548: mov      w9, #1
0x104e8554c: strb     w9, [x8, #0xe1e]
0x104e85550: mov      x0, x2
0x104e85554: bl       #0x107c27c74 ; _objc_retain
0x104e85558: adrp     x23, #0x11ed12000
0x104e8555c: ldr      x0, [x23, #0x780] ; classref MMContext | Class MMContext
0x104e85560: adrp     x8, #0x11e9c9000
0x104e85564: ldr      x1, [x8, #0xaf8] ; @selector(activeUserContext) | 'activeUserContext'
0x104e85568: bl       #0x107c27c64 ; _objc_msgSend | selector=activeUserContext
0x104e8556c: mov      x29, x29
0x104e85570: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e85574: mov      x21, x0
0x104e85578: add      x0, sp, #0x28
0x104e8557c: mov      x1, x21
0x104e85580: mov      w2, #0
0x104e85584: bl       #0x107c0cc20
0x104e85588: mov      x0, x21
0x104e8558c: bl       #0x107c27c70 ; _objc_release
0x104e85590: adrp     x24, #0x11ed12000
0x104e85594: ldr      x22, [x24, #0x618] ; classref iConsole | Class iConsole
0x104e85598: adrp     x8, #0x11e9da000 ; @selector(scrollableFinderCellViewOnValidShowItems:)
0x104e8559c: ldr      x1, [x8, #0x660] ; @selector(backgroundTimeRemaining) | 'backgroundTimeRemaining'
0x104e855a0: mov      x0, x19
0x104e855a4: bl       #0x107c27c64 ; _objc_msgSend | selector=backgroundTimeRemaining
0x104e855a8: adrp     x8, #0x11e9c9000
0x104e855ac: ldr      x21, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x104e855b0: str      d0, [sp, #8]
0x104e855b4: adrp     x8, #0x11d2ca000
0x104e855b8: add      x8, x8, #0x278 ; @'<!WXG!>applicationDidEnterBackground %f'
0x104e855bc: str      x8, [sp] ; @'<!WXG!>applicationDidEnterBackground %f'
0x104e855c0: adrp     x5, #0x11a1c7000 ; ''
0x104e855c4: add      x5, x5, #0x51c ; 'MicroMessengerAppDelegate.mm'
0x104e855c8: adrp     x7, #0x11a1c8000 ; 'iceFirstUnlock]'
0x104e855cc: add      x7, x7, #0xcb8 ; '-[MicroMessengerAppDelegate applicationDidEnterBackground:]'
0x104e855d0: mov      x0, x22 ; Class iConsole
0x104e855d4: mov      x1, x21 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x104e855d8: mov      w2, #2
0x104e855dc: mov      x3, #0
0x104e855e0: mov      w4, #0
0x104e855e4: mov      w6, #0x7f6
0x104e855e8: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x104e855ec: adrp     x8, #0x11eb26000 ; @selector(getTimelineBackgroundURLSessionIdentifierPrefix)
0x104e855f0: ldr      x1, [x8, #0x48] ; @selector(setupForShortcut) | 'setupForShortcut'
0x104e855f4: mov      x0, x20
0x104e855f8: bl       #0x107c27c64 ; _objc_msgSend | selector=setupForShortcut
0x104e855fc: adrp     x8, #0x11edc6000
0x104e85600: ldrsw    x8, [x8, #0x388] ; ivar_offset MicroMessengerAppDelegate.m_isActive=0x20
0x104e85604: strb     wzr, [x20, x8]
0x104e85608: mov      x0, #0
0x104e8560c: bl       #0x107c27e2c ; _time
0x104e85610: adrp     x22, #0x11fc6d000
0x104e85614: ldr      x8, [x22, #0x140]
0x104e85618: sub      x8, x0, x8
0x104e8561c: adrp     x9, #0x11fc6d000
0x104e85620: str      x8, [x9, #0x148]
0x104e85624: adrp     x25, #0x11fc6d000
0x104e85628: cmp      x8, #1
0x104e8562c: b.lt     #0x104e85648
0x104e85630: ldr      x9, [x25, #0x138]
0x104e85634: add      x8, x9, x8
0x104e85638: str      x8, [x25, #0x138]
0x104e8563c: mov      x0, #0
0x104e85640: bl       #0x107c27e2c ; _time
0x104e85644: str      x0, [x22, #0x140]
0x104e85648: ldr      x8, [x25, #0x138]
0x104e8564c: mov      w9, #0x5181
0x104e85650: movk     w9, #1, lsl #16
0x104e85654: cmp      x8, x9
0x104e85658: b.ge     #0x104e85858
0x104e8565c: adrp     x8, #0x11ed14000 ; classref SilkAudioCodec
0x104e85660: ldr      x0, [x8, #0x1b0] ; classref MMContextManager | Class MMContextManager
0x104e85664: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104e85668: ldr      x1, [x8, #0xd08] ; @selector(defaultManager) | 'defaultManager'
0x104e8566c: bl       #0x107c27c64 ; _objc_msgSend | selector=defaultManager
0x104e85670: mov      x29, x29
0x104e85674: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e85678: mov      x21, x0
0x104e8567c: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x104e85680: ldr      x1, [x8, #0x6e8] ; @selector(callEnterBackground) | 'callEnterBackground'
0x104e85684: bl       #0x107c27c64 ; _objc_msgSend | selector=callEnterBackground
0x104e85688: mov      x0, x21
0x104e8568c: bl       #0x107c27c70 ; _objc_release
0x104e85690: ldr      x0, [x23, #0x780] ; classref MMContext | Class MMContext
0x104e85694: adrp     x8, #0x11e9c9000
0x104e85698: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x104e8569c: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104e856a0: mov      x29, x29
0x104e856a4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e856a8: mov      x21, x0
0x104e856ac: adrp     x8, #0x11ed32000 ; classref MagicEcsNirvanaLoadingComponent
0x104e856b0: ldr      x0, [x8, #0xba8] ; classref AppleSearchMgr | Class AppleSearchMgr
0x104e856b4: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104e856b8: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x104e856bc: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104e856c0: mov      x2, x0
0x104e856c4: adrp     x8, #0x11e9c9000
0x104e856c8: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x104e856cc: mov      x0, x21
0x104e856d0: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104e856d4: mov      x29, x29
0x104e856d8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e856dc: mov      x22, x0
0x104e856e0: adrp     x8, #0x11eb26000 ; @selector(getTimelineBackgroundURLSessionIdentifierPrefix)
0x104e856e4: ldr      x1, [x8, #0x50] ; @selector(indexActivities) | 'indexActivities'
0x104e856e8: bl       #0x107c27c64 ; _objc_msgSend | selector=indexActivities
0x104e856ec: mov      x0, x22
0x104e856f0: bl       #0x107c27c70 ; _objc_release
0x104e856f4: mov      x0, x21
0x104e856f8: bl       #0x107c27c70 ; _objc_release
0x104e856fc: adrp     x8, #0x11ed12000
0x104e85700: ldr      x0, [x8, #0x6c8] ; _OBJC_CLASS_$_NSNotificationCenter
0x104e85704: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104e85708: ldr      x1, [x8, #0xcd0] ; @selector(defaultCenter) | 'defaultCenter'
0x104e8570c: bl       #0x107c27c64 ; _objc_msgSend | selector=defaultCenter
0x104e85710: mov      x29, x29
0x104e85714: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e85718: mov      x21, x0
0x104e8571c: adrp     x8, #0x11c2eb000
0x104e85720: add      x8, x8, #0xc80
0x104e85724: ldr      x2, [x8] ; @'MMApplicationDidEnterBackground'
0x104e85728: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x104e8572c: ldr      x1, [x8, #0xf08] ; @selector(postNotificationName:object:userInfo:) | 'postNotificationName:object:userInfo:'
0x104e85730: mov      x3, x20
0x104e85734: mov      x4, #0
0x104e85738: bl       #0x107c27c64 ; _objc_msgSend | selector=postNotificationName:object:userInfo:
0x104e8573c: mov      x0, x21
0x104e85740: bl       #0x107c27c70 ; _objc_release
0x104e85744: adrp     x8, #0x11eb25000 ; @selector(setNsSender:)
0x104e85748: ldr      x1, [x8, #0xfc0] ; @selector(submitAppRefreshTaskRequest) | 'submitAppRefreshTaskRequest'
0x104e8574c: mov      x0, x20
0x104e85750: bl       #0x107c27c64 ; _objc_msgSend | selector=submitAppRefreshTaskRequest
0x104e85754: adrp     x20, #0x11ed14000 ; classref SilkAudioCodec
0x104e85758: ldr      x0, [x20, #0xda0] ; classref BackgroundTask | Class BackgroundTask
0x104e8575c: adrp     x8, #0x11ea4b000 ; @selector(currentUrl)
0x104e85760: ldr      x1, [x8, #0x428] ; @selector(run) | 'run'
0x104e85764: bl       #0x107c27c64 ; _objc_msgSend | selector=run
0x104e85768: ldr      x0, [x20, #0xda0] ; classref BackgroundTask | Class BackgroundTask
0x104e8576c: adrp     x8, #0x11eb26000 ; @selector(getTimelineBackgroundURLSessionIdentifierPrefix)
0x104e85770: ldr      x1, [x8, #0x58] ; @selector(startSuspendObserver) | 'startSuspendObserver'
0x104e85774: bl       #0x107c27c64 ; _objc_msgSend | selector=startSuspendObserver
0x104e85778: add      x0, sp, #0x10
0x104e8577c: mov      w1, #7
0x104e85780: bl       #0x100080888
0x104e85784: mov      w8, #0x6564
0x104e85788: movk     w8, #0x6166, lsl #16
0x104e8578c: str      w8, [x0]
0x104e85790: mov      w8, #0x7561
0x104e85794: movk     w8, #0x746c, lsl #16
0x104e85798: stur     w8, [x0, #3]
0x104e8579c: strb     wzr, [x0, #7]
0x104e857a0: add      x1, sp, #0x10
0x104e857a4: mov      w0, #0
0x104e857a8: bl       #0x107c0c310
0x104e857ac: ldrsb    w8, [sp, #0x27]
0x104e857b0: tbz      w8, #0x1f, #0x104e857c4
0x104e857b4: ldr      x0, [sp, #0x10]
0x104e857b8: ldr      x8, [sp, #0x20]
0x104e857bc: and      x1, x8, #0x7fffffffffffffff
0x104e857c0: bl       #0x107c276f0 ; __ZdlPvm
0x104e857c4: bl       #0x105601dec
0x104e857c8: bl       #0x105602104
0x104e857cc: cbz      w0, #0x104e8581c
0x104e857d0: add      x0, sp, #0x10
0x104e857d4: mov      w1, #7
0x104e857d8: bl       #0x100080888
0x104e857dc: mov      w8, #0x6564
0x104e857e0: movk     w8, #0x6166, lsl #16
0x104e857e4: str      w8, [x0]
0x104e857e8: mov      w8, #0x7561
0x104e857ec: movk     w8, #0x746c, lsl #16
0x104e857f0: stur     w8, [x0, #3]
0x104e857f4: strb     wzr, [x0, #7]
0x104e857f8: add      x1, sp, #0x10
0x104e857fc: mov      w0, #0
0x104e85800: bl       #0x10b7439a0
0x104e85804: ldrsb    w8, [sp, #0x27]
0x104e85808: tbz      w8, #0x1f, #0x104e8581c
0x104e8580c: ldr      x0, [sp, #0x10]
0x104e85810: ldr      x8, [sp, #0x20]
0x104e85814: and      x1, x8, #0x7fffffffffffffff
0x104e85818: bl       #0x107c276f0 ; __ZdlPvm
0x104e8581c: adrp     x8, #0x11fc6e000
0x104e85820: add      x8, x8, #0xa08
0x104e85824: mov      w9, #1
0x104e85828: strb     w9, [x8]
0x104e8582c: add      x0, sp, #0x28
0x104e85830: bl       #0x107c0cc24
0x104e85834: mov      x0, x19
0x104e85838: bl       #0x107c27c70 ; _objc_release
0x104e8583c: ldp      x29, x30, [sp, #0x80]
0x104e85840: ldp      x20, x19, [sp, #0x70] ; classref SilkAudioCodec
0x104e85844: ldp      x22, x21, [sp, #0x60]
0x104e85848: ldp      x24, x23, [sp, #0x50]
0x104e8584c: ldp      x26, x25, [sp, #0x40]
0x104e85850: add      sp, sp, #0x90
0x104e85854: ret      
0x104e85858: ldr      x0, [x24, #0x618] ; classref iConsole | Class iConsole
0x104e8585c: adrp     x8, #0x11d2ca000
0x104e85860: add      x8, x8, #0x298 ; @'totalRunningTime > 60 * 60 * MAX_RUNNING_HOURS '
0x104e85864: str      x8, [sp] ; @'totalRunningTime > 60 * 60 * MAX_RUNNING_HOURS '
0x104e85868: adrp     x5, #0x11a1c7000 ; ''
0x104e8586c: add      x5, x5, #0x51c ; 'MicroMessengerAppDelegate.mm'
0x104e85870: adrp     x7, #0x11a1c8000 ; 'iceFirstUnlock]'
0x104e85874: add      x7, x7, #0xcb8 ; '-[MicroMessengerAppDelegate applicationDidEnterBackground:]'
0x104e85878: mov      x1, x21
0x104e8587c: mov      w2, #2
0x104e85880: mov      x3, #0
0x104e85884: mov      w4, #0
0x104e85888: mov      w6, #0x805
0x104e8588c: bl       #0x107c27c64 ; _objc_msgSend
0x104e85890: adrp     x8, #0x11ea08000 ; @selector(applicationSequence)
0x104e85894: ldr      x1, [x8, #0x6a8] ; @selector(applicationWillTerminate:) | 'applicationWillTerminate:'
0x104e85898: mov      x0, x20 ; classref SilkAudioCodec
0x104e8589c: mov      x2, x19
0x104e858a0: bl       #0x107c27c64 ; _objc_msgSend | selector=applicationWillTerminate:
0x104e858a4: mov      w0, #0
0x104e858a8: bl       #0x107c2791c ; _exit
