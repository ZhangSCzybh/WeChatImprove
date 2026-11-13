-[MicroMessengerAppDelegate applicationWillEnterForeground:] 0x104e86180 v24@0:8@16
0x104e86180: sub      sp, sp, #0xb0
0x104e86184: stp      x28, x27, [sp, #0x50]
0x104e86188: stp      x26, x25, [sp, #0x60]
0x104e8618c: stp      x24, x23, [sp, #0x70]
0x104e86190: stp      x22, x21, [sp, #0x80]
0x104e86194: stp      x20, x19, [sp, #0x90]
0x104e86198: stp      x29, x30, [sp, #0xa0]
0x104e8619c: add      x29, sp, #0xa0
0x104e861a0: mov      x19, x0
0x104e861a4: adrp     x8, #0x11f751000
0x104e861a8: mov      w9, #1
0x104e861ac: strb     w9, [x8, #0xe1f]
0x104e861b0: adrp     x8, #0x11ed12000
0x104e861b4: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x104e861b8: adrp     x8, #0x11e9c9000
0x104e861bc: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x104e861c0: adrp     x8, #0x11d2ca000
0x104e861c4: add      x8, x8, #0x338 ; @'<!WXG!>applicationWillEnterForeground'
0x104e861c8: str      x8, [sp] ; @'<!WXG!>applicationWillEnterForeground'
0x104e861cc: adrp     x5, #0x11a1c7000 ; ''
0x104e861d0: add      x5, x5, #0x51c ; 'MicroMessengerAppDelegate.mm'
0x104e861d4: adrp     x7, #0x11a1c8000 ; 'iceFirstUnlock]'
0x104e861d8: add      x7, x7, #0xdcf ; '-[MicroMessengerAppDelegate applicationWillEnterForeground:]'
0x104e861dc: mov      w2, #2
0x104e861e0: mov      x3, #0
0x104e861e4: mov      w4, #0
0x104e861e8: mov      w6, #0x857
0x104e861ec: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x104e861f0: adrp     x8, #0x11ed20000 ; classref FinderComponentInfo
0x104e861f4: ldr      x0, [x8, #0x638] ; classref MMLocalNotificationUtil | Class MMLocalNotificationUtil
0x104e861f8: adrp     x8, #0x11eb06000 ; @selector(isCurrentRenderStateInPre)
0x104e861fc: ldr      x1, [x8, #0xc8] ; @selector(cancelAllNotReservedLocalNotificationsWithCompletion:) | 'cancelAllNotReservedLocalNotificationsWithCompletion:'
0x104e86200: mov      x2, #0
0x104e86204: bl       #0x107c27c64 ; _objc_msgSend | selector=cancelAllNotReservedLocalNotificationsWithCompletion:
0x104e86208: adrp     x27, #0x11ed12000
0x104e8620c: ldr      x0, [x27, #0x780] ; classref MMContext | Class MMContext
0x104e86210: adrp     x8, #0x11e9c9000
0x104e86214: ldr      x21, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x104e86218: mov      x1, x21 ; 'currentContext'
0x104e8621c: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104e86220: mov      x29, x29
0x104e86224: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e86228: mov      x24, x0
0x104e8622c: adrp     x28, #0x11ed16000 ; _OBJC_CLASS_$_EAAccessoryManager
0x104e86230: ldr      x0, [x28, #0xc30] ; classref CNetworkStatusMgr | Class CNetworkStatusMgr
0x104e86234: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104e86238: ldr      x22, [x8, #0x508] ; @selector(class) | 'class'
0x104e8623c: mov      x1, x22 ; 'class'
0x104e86240: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104e86244: mov      x2, x0
0x104e86248: adrp     x8, #0x11e9c9000
0x104e8624c: ldr      x23, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x104e86250: mov      x0, x24
0x104e86254: mov      x1, x23 ; 'getService:'
0x104e86258: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104e8625c: mov      x29, x29
0x104e86260: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e86264: mov      x20, x0
0x104e86268: mov      x0, x24
0x104e8626c: bl       #0x107c27c70 ; _objc_release
0x104e86270: adrp     x8, #0x11eb26000 ; @selector(getTimelineBackgroundURLSessionIdentifierPrefix)
0x104e86274: ldr      x1, [x8, #0xa0] ; @selector(setReadToGettingData) | 'setReadToGettingData'
0x104e86278: mov      x0, x20
0x104e8627c: bl       #0x107c27c64 ; _objc_msgSend | selector=setReadToGettingData
0x104e86280: adrp     x8, #0x11eb26000 ; @selector(getTimelineBackgroundURLSessionIdentifierPrefix)
0x104e86284: ldr      x1, [x8, #0xa8] ; @selector(handleOpenPush) | 'handleOpenPush'
0x104e86288: mov      x0, x19
0x104e8628c: bl       #0x107c27c64 ; _objc_msgSend | selector=handleOpenPush
0x104e86290: adrp     x8, #0x11ed14000 ; classref SilkAudioCodec
0x104e86294: ldr      x0, [x8, #0x1b0] ; classref MMContextManager | Class MMContextManager
0x104e86298: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104e8629c: ldr      x1, [x8, #0xd08] ; @selector(defaultManager) | 'defaultManager'
0x104e862a0: bl       #0x107c27c64 ; _objc_msgSend | selector=defaultManager
0x104e862a4: mov      x29, x29
0x104e862a8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e862ac: mov      x24, x0
0x104e862b0: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x104e862b4: ldr      x1, [x8, #0x6f0] ; @selector(callEnterForeground) | 'callEnterForeground'
0x104e862b8: bl       #0x107c27c64 ; _objc_msgSend | selector=callEnterForeground
0x104e862bc: mov      x0, x24
0x104e862c0: bl       #0x107c27c70 ; _objc_release
0x104e862c4: adrp     x8, #0x11ed12000
0x104e862c8: ldr      x0, [x8, #0x6c8] ; _OBJC_CLASS_$_NSNotificationCenter
0x104e862cc: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104e862d0: ldr      x1, [x8, #0xcd0] ; @selector(defaultCenter) | 'defaultCenter'
0x104e862d4: bl       #0x107c27c64 ; _objc_msgSend | selector=defaultCenter
0x104e862d8: mov      x29, x29
0x104e862dc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e862e0: mov      x24, x0
0x104e862e4: adrp     x8, #0x11c2eb000
0x104e862e8: add      x8, x8, #0xc88
0x104e862ec: ldr      x2, [x8] ; @'MMApplicationWillEnterForeground'
0x104e862f0: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x104e862f4: ldr      x1, [x8, #0xf08] ; @selector(postNotificationName:object:userInfo:) | 'postNotificationName:object:userInfo:'
0x104e862f8: mov      x3, x19
0x104e862fc: mov      x4, #0
0x104e86300: bl       #0x107c27c64 ; _objc_msgSend | selector=postNotificationName:object:userInfo:
0x104e86304: mov      x0, x24
0x104e86308: bl       #0x107c27c70 ; _objc_release
0x104e8630c: add      x0, sp, #0x38
0x104e86310: mov      w1, #7
0x104e86314: bl       #0x100080888
0x104e86318: mov      w8, #0x6564
0x104e8631c: movk     w8, #0x6166, lsl #16
0x104e86320: str      w8, [x0]
0x104e86324: mov      w8, #0x7561
0x104e86328: movk     w8, #0x746c, lsl #16
0x104e8632c: stur     w8, [x0, #3]
0x104e86330: strb     wzr, [x0, #7]
0x104e86334: add      x1, sp, #0x38
0x104e86338: mov      w0, #1
0x104e8633c: bl       #0x107c0c310
0x104e86340: ldrsb    w8, [sp, #0x4f]
0x104e86344: tbz      w8, #0x1f, #0x104e86358
0x104e86348: ldr      x0, [sp, #0x38]
0x104e8634c: ldr      x8, [sp, #0x48]
0x104e86350: and      x1, x8, #0x7fffffffffffffff
0x104e86354: bl       #0x107c276f0 ; __ZdlPvm
0x104e86358: bl       #0x105601dec
0x104e8635c: bl       #0x105602104
0x104e86360: cbz      w0, #0x104e863b0
0x104e86364: add      x0, sp, #0x38
0x104e86368: mov      w1, #7
0x104e8636c: bl       #0x100080888
0x104e86370: mov      w8, #0x6564
0x104e86374: movk     w8, #0x6166, lsl #16
0x104e86378: str      w8, [x0]
0x104e8637c: mov      w8, #0x7561
0x104e86380: movk     w8, #0x746c, lsl #16
0x104e86384: stur     w8, [x0, #3]
0x104e86388: strb     wzr, [x0, #7]
0x104e8638c: add      x1, sp, #0x38
0x104e86390: mov      w0, #1
0x104e86394: bl       #0x10b7439a0
0x104e86398: ldrsb    w8, [sp, #0x4f]
0x104e8639c: tbz      w8, #0x1f, #0x104e863b0
0x104e863a0: ldr      x0, [sp, #0x38]
0x104e863a4: ldr      x8, [sp, #0x48]
0x104e863a8: and      x1, x8, #0x7fffffffffffffff
0x104e863ac: bl       #0x107c276f0 ; __ZdlPvm
0x104e863b0: adrp     x8, #0x11fc6e000
0x104e863b4: add      x8, x8, #0xa08
0x104e863b8: strb     wzr, [x8]
0x104e863bc: adrp     x8, #0x11fc6e000
0x104e863c0: add      x8, x8, #0xa09
0x104e863c4: strb     wzr, [x8]
0x104e863c8: ldr      x0, [x27, #0x780] ; classref MMContext | Class MMContext
0x104e863cc: mov      x1, x21 ; 'currentContext'
0x104e863d0: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104e863d4: mov      x29, x29
0x104e863d8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e863dc: mov      x24, x0
0x104e863e0: adrp     x8, #0x11e9cc000 ; @selector(setCenterY:)
0x104e863e4: ldr      x1, [x8, #0xa70] ; @selector(userName) | 'userName'
0x104e863e8: bl       #0x107c27c64 ; _objc_msgSend | selector=userName
0x104e863ec: mov      x29, x29
0x104e863f0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e863f4: mov      x25, x0
0x104e863f8: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x104e863fc: ldr      x1, [x8, #0xce8] ; @selector(length) | 'length'
0x104e86400: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x104e86404: mov      x26, x0
0x104e86408: mov      x0, x25
0x104e8640c: bl       #0x107c27c70 ; _objc_release
0x104e86410: mov      x0, x24
0x104e86414: bl       #0x107c27c70 ; _objc_release
0x104e86418: cbz      x26, #0x104e864d8
0x104e8641c: ldr      x0, [x27, #0x780] ; classref MMContext | Class MMContext
0x104e86420: mov      x1, x21 ; 'currentContext'
0x104e86424: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104e86428: mov      x29, x29
0x104e8642c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e86430: mov      x24, x0
0x104e86434: adrp     x26, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x104e86438: ldr      x0, [x26, #0xc30] ; classref NewSyncService | Class NewSyncService
0x104e8643c: mov      x1, x22 ; 'class'
0x104e86440: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104e86444: mov      x2, x0
0x104e86448: mov      x0, x24
0x104e8644c: mov      x1, x23 ; 'getService:'
0x104e86450: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104e86454: mov      x29, x29
0x104e86458: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e8645c: mov      x25, x0
0x104e86460: adrp     x8, #0x11eb26000 ; @selector(getTimelineBackgroundURLSessionIdentifierPrefix)
0x104e86464: ldr      x1, [x8, #0xb0] ; @selector(BackGroundToForeGroundSync) | 'BackGroundToForeGroundSync'
0x104e86468: bl       #0x107c27c64 ; _objc_msgSend | selector=BackGroundToForeGroundSync
0x104e8646c: mov      x0, x25
0x104e86470: bl       #0x107c27c70 ; _objc_release
0x104e86474: mov      x0, x24
0x104e86478: bl       #0x107c27c70 ; _objc_release
0x104e8647c: ldr      x0, [x27, #0x780] ; classref MMContext | Class MMContext
0x104e86480: mov      x1, x21 ; 'currentContext'
0x104e86484: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104e86488: mov      x29, x29
0x104e8648c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e86490: mov      x24, x0
0x104e86494: ldr      x0, [x26, #0xc30] ; classref NewSyncService | Class NewSyncService
0x104e86498: mov      x1, x22 ; 'class'
0x104e8649c: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104e864a0: mov      x2, x0
0x104e864a4: mov      x0, x24
0x104e864a8: mov      x1, x23 ; 'getService:'
0x104e864ac: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104e864b0: mov      x29, x29
0x104e864b4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e864b8: mov      x25, x0
0x104e864bc: adrp     x8, #0x11e9e4000 ; @selector(readPedometerProfileTarget:)
0x104e864c0: ldr      x1, [x8, #0x250] ; @selector(NeedToSyncOplog) | 'NeedToSyncOplog'
0x104e864c4: bl       #0x107c27c64 ; _objc_msgSend | selector=NeedToSyncOplog
0x104e864c8: mov      x0, x25
0x104e864cc: bl       #0x107c27c70 ; _objc_release
0x104e864d0: mov      x0, x24
0x104e864d4: bl       #0x107c27c70 ; _objc_release
0x104e864d8: ldr      x0, [x27, #0x780] ; classref MMContext | Class MMContext
0x104e864dc: mov      x1, x21 ; 'currentContext'
0x104e864e0: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104e864e4: mov      x29, x29
0x104e864e8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e864ec: mov      x24, x0
0x104e864f0: adrp     x8, #0x11ed32000 ; classref MagicEcsNirvanaLoadingComponent
0x104e864f4: ldr      x0, [x8, #0xbb0] ; classref VoIPFirstMessageStatisticsService | Class VoIPFirstMessageStatisticsService
0x104e864f8: mov      x1, x22 ; 'class'
0x104e864fc: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104e86500: mov      x2, x0
0x104e86504: mov      x0, x24
0x104e86508: mov      x1, x23 ; 'getService:'
0x104e8650c: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104e86510: mov      x29, x29
0x104e86514: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e86518: mov      x25, x0
0x104e8651c: adrp     x8, #0x11eb26000 ; @selector(getTimelineBackgroundURLSessionIdentifierPrefix)
0x104e86520: ldr      x1, [x8, #0xb8] ; @selector(didLaunchWhenApplicaionEnterForeground) | 'didLaunchWhenApplicaionEnterForeground'
0x104e86524: bl       #0x107c27c64 ; _objc_msgSend | selector=didLaunchWhenApplicaionEnterForeground
0x104e86528: mov      x0, x25
0x104e8652c: bl       #0x107c27c70 ; _objc_release
0x104e86530: mov      x0, x24
0x104e86534: bl       #0x107c27c70 ; _objc_release
0x104e86538: adrp     x8, #0x11ed12000
0x104e8653c: ldr      x0, [x8, #0x840] ; classref CAppUtil | Class CAppUtil
0x104e86540: adrp     x8, #0x11e9ce000 ; @selector(onAddMsg:roomID:)
0x104e86544: ldr      x1, [x8, #0x200] ; @selector(isLogin) | 'isLogin'
0x104e86548: bl       #0x107c27c64 ; _objc_msgSend | selector=isLogin
0x104e8654c: cbz      w0, #0x104e865ac
0x104e86550: ldr      x0, [x27, #0x780] ; classref MMContext | Class MMContext
0x104e86554: mov      x1, x21 ; 'currentContext'
0x104e86558: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104e8655c: mov      x29, x29
0x104e86560: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e86564: mov      x21, x0
0x104e86568: ldr      x0, [x28, #0xc30] ; classref CNetworkStatusMgr | Class CNetworkStatusMgr
0x104e8656c: mov      x1, x22 ; 'class'
0x104e86570: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104e86574: mov      x2, x0
0x104e86578: mov      x0, x21
0x104e8657c: mov      x1, x23 ; 'getService:'
0x104e86580: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104e86584: mov      x29, x29
0x104e86588: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104e8658c: mov      x22, x0
0x104e86590: adrp     x8, #0x11eb26000 ; @selector(getTimelineBackgroundURLSessionIdentifierPrefix)
0x104e86594: ldr      x1, [x8, #0xc0] ; @selector(CheckBG2FG) | 'CheckBG2FG'
0x104e86598: bl       #0x107c27c64 ; _objc_msgSend | selector=CheckBG2FG
0x104e8659c: mov      x0, x22
0x104e865a0: bl       #0x107c27c70 ; _objc_release
0x104e865a4: mov      x0, x21
0x104e865a8: bl       #0x107c27c70 ; _objc_release
0x104e865ac: adrp     x8, #0x11edc6000
0x104e865b0: ldrsw    x8, [x8, #0x344] ; ivar_offset MicroMessengerAppDelegate.m_isInSafeModeOrMemoryStat=0x5a
0x104e865b4: ldrb     w8, [x19, x8]
0x104e865b8: tbnz     w8, #0, #0x104e865e8
0x104e865bc: adrp     x8, #0x11eb26000 ; @selector(getTimelineBackgroundURLSessionIdentifierPrefix)
0x104e865c0: ldr      x1, [x8, #0xc8] ; @selector(checkAppLockEnabled) | 'checkAppLockEnabled'
0x104e865c4: mov      x0, x19
0x104e865c8: bl       #0x107c27c64 ; _objc_msgSend | selector=checkAppLockEnabled
0x104e865cc: cbz      w0, #0x104e865e8
0x104e865d0: adrp     x8, #0x11eb26000 ; @selector(getTimelineBackgroundURLSessionIdentifierPrefix)
0x104e865d4: ldr      x1, [x8, #0xd0] ; @selector(reportAppLockEvent:) | 'reportAppLockEvent:'
0x104e865d8: adrp     x2, #0x11d2ca000
0x104e865dc: add      x2, x2, #0x358 ; @'app_lock_request_unlock'
0x104e865e0: mov      x0, x19
0x104e865e4: bl       #0x107c27c64 ; _objc_msgSend | selector=reportAppLockEvent:
0x104e865e8: adrp     x8, #0x11edc6000
0x104e865ec: ldrsw    x8, [x8, #0x348] ; ivar_offset MicroMessengerAppDelegate.m_isNormalLaunch=0x59
0x104e865f0: ldrb     w8, [x19, x8]
0x104e865f4: cmp      w8, #1
0x104e865f8: b.ne     #0x104e8666c
0x104e865fc: adrp     x8, #0x11edc6000
0x104e86600: ldrsw    x8, [x8, #0x370] ; ivar_offset MicroMessengerAppDelegate.m_firstActive=0x21
0x104e86604: ldrb     w8, [x19, x8]
0x104e86608: tbnz     w8, #0, #0x104e8666c
0x104e8660c: adrp     x8, #0x11edc6000
0x104e86610: ldrsw    x8, [x8, #0x360] ; ivar_offset MicroMessengerAppDelegate.m_hasCheckEnterForeground=0x5b
0x104e86614: ldrb     w8, [x19, x8]
0x104e86618: tbnz     w8, #0, #0x104e8666c
0x104e8661c: mov      x0, #0
0x104e86620: mov      w1, #0x9400
0x104e86624: movk     w1, #0x7735, lsl #16
0x104e86628: bl       #0x107c278fc ; _dispatch_time
0x104e8662c: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x104e86630: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x104e86634: str      x8, [sp, #0x10]
0x104e86638: adrp     x8, #0x1178c7000
0x104e8663c: ldr      d0, [x8, #0x680]
0x104e86640: adrp     x8, #0x104e86000
0x104e86644: add      x8, x8, #0x694
0x104e86648: str      d0, [sp, #0x18]
0x104e8664c: adrp     x9, #0x11c280000
0x104e86650: add      x9, x9, #0x470
0x104e86654: stp      x8, x9, [sp, #0x20]
0x104e86658: str      x19, [sp, #0x30]
0x104e8665c: adrp     x1, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x104e86660: ldr      x1, [x1, #0xa98] ; __dispatch_main_q
0x104e86664: add      x2, sp, #0x10
0x104e86668: bl       #0x107c0cba4
0x104e8666c: mov      x0, x20
0x104e86670: bl       #0x107c27c70 ; _objc_release
0x104e86674: ldp      x29, x30, [sp, #0xa0]
0x104e86678: ldp      x20, x19, [sp, #0x90]
0x104e8667c: ldp      x22, x21, [sp, #0x80]
0x104e86680: ldp      x24, x23, [sp, #0x70]
0x104e86684: ldp      x26, x25, [sp, #0x60] ; classref CommonAffServiceCenterCpp
0x104e86688: ldp      x28, x27, [sp, #0x50] ; _OBJC_CLASS_$_EAAccessoryManager
0x104e8668c: add      sp, sp, #0xb0
0x104e86690: ret      
