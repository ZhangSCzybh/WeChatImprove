-[CMainControll Start:] 0x104d15138 v24@0:8@16
0x104d15138: sub      sp, sp, #0xa0
0x104d1513c: stp      x28, x27, [sp, #0x40]
0x104d15140: stp      x26, x25, [sp, #0x50]
0x104d15144: stp      x24, x23, [sp, #0x60]
0x104d15148: stp      x22, x21, [sp, #0x70]
0x104d1514c: stp      x20, x19, [sp, #0x80]
0x104d15150: stp      x29, x30, [sp, #0x90]
0x104d15154: add      x29, sp, #0x90
0x104d15158: mov      x19, x2
0x104d1515c: mov      x24, x0
0x104d15160: adrp     x8, #0x11f751000
0x104d15164: mov      w9, #1
0x104d15168: strb     w9, [x8, #0x95c]
0x104d1516c: mov      x0, x2
0x104d15170: bl       #0x107c27c74 ; _objc_retain
0x104d15174: adrp     x8, #0x11ed12000
0x104d15178: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x104d1517c: adrp     x8, #0x11e9c9000
0x104d15180: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x104d15184: adrp     x8, #0x11d2b9000
0x104d15188: add      x8, x8, #0xbb8 ; @'main control start'
0x104d1518c: str      x8, [sp] ; @'main control start'
0x104d15190: adrp     x3, #0x119ba9000 ; 'st %@'
0x104d15194: add      x3, x3, #0xcd2 ; 'Kern'
0x104d15198: adrp     x5, #0x11a1ac000 ; 'View'
0x104d1519c: add      x5, x5, #0x3e8 ; 'MainControll.mm'
0x104d151a0: adrp     x7, #0x11a1ac000 ; 'View'
0x104d151a4: add      x7, x7, #0x494 ; '-[CMainControll Start:]'
0x104d151a8: str      x1, [sp, #0x30] ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x104d151ac: mov      w2, #2
0x104d151b0: mov      w4, #0
0x104d151b4: mov      w6, #0x90
0x104d151b8: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x104d151bc: cbnz     x19, #0x104d151e0
0x104d151c0: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x104d151c4: ldr      x0, [x8, #0x910] ; classref CAppObserverCenter | Class CAppObserverCenter
0x104d151c8: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104d151cc: ldr      x1, [x8, #0xcd0] ; @selector(defaultCenter) | 'defaultCenter'
0x104d151d0: bl       #0x107c27c64 ; _objc_msgSend | selector=defaultCenter
0x104d151d4: mov      x29, x29
0x104d151d8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d151dc: mov      x19, x0
0x104d151e0: adrp     x8, #0x11ed12000
0x104d151e4: ldr      x0, [x8, #0x8e8] ; classref MMTimer | Class MMTimer
0x104d151e8: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d151ec: ldr      x3, [x8, #0x610] ; @selector(TimerCheckEvent) | 'TimerCheckEvent'
0x104d151f0: adrp     x8, #0x11e9ca000 ; @selector(isUsingEarDeviceWithRoute:)
0x104d151f4: ldr      x1, [x8, #0x2c0] ; @selector(scheduledNoRetainTimerWithTimeInterval:target:selector:userInfo:repeats:) | 'scheduledNoRetainTimerWithTimeInterval:target:selector:userInfo:repeats:'
0x104d151f8: adrp     x8, #0x1178c7000
0x104d151fc: ldr      d0, [x8, #0x9e0]
0x104d15200: mov      x2, x24
0x104d15204: mov      x4, #0
0x104d15208: mov      w5, #1
0x104d1520c: bl       #0x107c27c64 ; _objc_msgSend | selector=scheduledNoRetainTimerWithTimeInterval:target:selector:userInfo:repeats:
0x104d15210: mov      x29, x29
0x104d15214: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15218: ldr      x8, [x24, #0x18]
0x104d1521c: str      x0, [x24, #0x18]
0x104d15220: mov      x0, x8
0x104d15224: bl       #0x107c27c70 ; _objc_release
0x104d15228: add      x0, x24, #0x20
0x104d1522c: str      x19, [sp, #0x28]
0x104d15230: mov      x1, x19
0x104d15234: bl       #0x107c27ca0 ; _objc_storeWeak
0x104d15238: adrp     x19, #0x11ed12000
0x104d1523c: ldr      x0, [x19, #0x780] ; classref MMContext | Class MMContext
0x104d15240: adrp     x8, #0x11e9c9000
0x104d15244: ldr      x21, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x104d15248: mov      x1, x21 ; 'currentContext'
0x104d1524c: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104d15250: mov      x29, x29
0x104d15254: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15258: mov      x25, x0
0x104d1525c: adrp     x8, #0x11ed12000
0x104d15260: ldr      x0, [x8, #0xaf8] ; classref EventService | Class EventService
0x104d15264: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104d15268: ldr      x22, [x8, #0x508] ; @selector(class) | 'class'
0x104d1526c: mov      x1, x22 ; 'class'
0x104d15270: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104d15274: mov      x2, x0
0x104d15278: adrp     x8, #0x11e9c9000
0x104d1527c: ldr      x23, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x104d15280: mov      x0, x25
0x104d15284: mov      x1, x23 ; 'getService:'
0x104d15288: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104d1528c: mov      x29, x29
0x104d15290: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15294: mov      x26, x0
0x104d15298: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d1529c: ldr      x1, [x8, #0x618] ; @selector(StartService) | 'StartService'
0x104d152a0: bl       #0x107c27c64 ; _objc_msgSend | selector=StartService
0x104d152a4: mov      x0, x26
0x104d152a8: bl       #0x107c27c70 ; _objc_release
0x104d152ac: mov      x0, x25
0x104d152b0: bl       #0x107c27c70 ; _objc_release
0x104d152b4: ldr      x0, [x19, #0x780] ; classref MMContext | Class MMContext
0x104d152b8: mov      x1, x21 ; 'currentContext'
0x104d152bc: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104d152c0: mov      x29, x29
0x104d152c4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d152c8: mov      x25, x0
0x104d152cc: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x104d152d0: ldr      x0, [x8, #0xc30] ; classref NewSyncService | Class NewSyncService
0x104d152d4: mov      x1, x22 ; 'class'
0x104d152d8: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104d152dc: mov      x2, x0
0x104d152e0: mov      x0, x25
0x104d152e4: mov      x1, x23 ; 'getService:'
0x104d152e8: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104d152ec: mov      x29, x29
0x104d152f0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d152f4: mov      x26, x0
0x104d152f8: str      x24, [sp, #0x20]
0x104d152fc: ldr      x27, [x24, #8]
0x104d15300: mov      x20, x19
0x104d15304: ldr      x0, [x19, #0x780] ; classref MMContext | Class MMContext
0x104d15308: mov      x1, x21 ; 'currentContext'
0x104d1530c: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104d15310: mov      x29, x29
0x104d15314: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15318: mov      x28, x0
0x104d1531c: adrp     x8, #0x11e9d3000 ; @selector(deleteSearchableItemsWithDomainIdentifiers:completionHandler:)
0x104d15320: ldr      x1, [x8, #0xb98] ; @selector(contextLock) | 'contextLock'
0x104d15324: bl       #0x107c27c64 ; _objc_msgSend | selector=contextLock
0x104d15328: mov      x29, x29
0x104d1532c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15330: mov      x19, x0
0x104d15334: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d15338: ldr      x1, [x8, #0x620] ; @selector(InitDB:Lock:) | 'InitDB:Lock:'
0x104d1533c: mov      x0, x26
0x104d15340: mov      x2, x27
0x104d15344: mov      x3, x19
0x104d15348: bl       #0x107c27c64 ; _objc_msgSend | selector=InitDB:Lock:
0x104d1534c: mov      x0, x19
0x104d15350: bl       #0x107c27c70 ; _objc_release
0x104d15354: mov      x0, x28
0x104d15358: bl       #0x107c27c70 ; _objc_release
0x104d1535c: mov      x0, x26
0x104d15360: bl       #0x107c27c70 ; _objc_release
0x104d15364: mov      x0, x25
0x104d15368: bl       #0x107c27c70 ; _objc_release
0x104d1536c: adrp     x8, #0x11ed12000
0x104d15370: ldr      x19, [x8, #0x618] ; classref iConsole | Class iConsole
0x104d15374: ldr      x0, [x20, #0x780] ; classref MMContext | Class MMContext
0x104d15378: mov      x1, x21 ; 'currentContext'
0x104d1537c: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104d15380: mov      x29, x29
0x104d15384: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15388: mov      x27, x0
0x104d1538c: adrp     x20, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x104d15390: ldr      x0, [x20, #0xc70] ; classref LocalInfoMgr | Class LocalInfoMgr
0x104d15394: mov      x1, x22 ; 'class'
0x104d15398: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104d1539c: mov      x2, x0
0x104d153a0: mov      x0, x27
0x104d153a4: mov      x1, x23 ; 'getService:'
0x104d153a8: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104d153ac: mov      x29, x29
0x104d153b0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d153b4: mov      x28, x0
0x104d153b8: adrp     x8, #0x11ea3b000 ; @selector(OnBatchAddEnterpriseMsg:Brand:)
0x104d153bc: ldr      x25, [x8, #0xd00] ; @selector(localInfo) | 'localInfo'
0x104d153c0: mov      x1, x25 ; 'localInfo'
0x104d153c4: bl       #0x107c27c64 ; _objc_msgSend | selector=localInfo
0x104d153c8: mov      x29, x29
0x104d153cc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d153d0: mov      x24, x0
0x104d153d4: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d153d8: ldr      x26, [x8, #0x628] ; @selector(m_uiNetControlBitFlag) | 'm_uiNetControlBitFlag'
0x104d153dc: mov      x1, x26 ; 'm_uiNetControlBitFlag'
0x104d153e0: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiNetControlBitFlag
0x104d153e4: adrp     x8, #0x11d2b9000
0x104d153e8: add      x8, x8, #0xbd8 ; @'SetMmtlsCtrlFlag: %u'
0x104d153ec: stp      x8, x0, [sp] ; @'SetMmtlsCtrlFlag: %u'
0x104d153f0: adrp     x3, #0x119ba9000 ; 'st %@'
0x104d153f4: add      x3, x3, #0xcd2 ; 'Kern'
0x104d153f8: adrp     x5, #0x11a1ac000 ; 'View'
0x104d153fc: add      x5, x5, #0x3e8 ; 'MainControll.mm'
0x104d15400: adrp     x7, #0x11a1ac000 ; 'View'
0x104d15404: add      x7, x7, #0x494 ; '-[CMainControll Start:]'
0x104d15408: mov      x0, x19 ; Class iConsole
0x104d1540c: ldr      x1, [sp, #0x30]
0x104d15410: mov      w2, #2
0x104d15414: mov      w4, #0
0x104d15418: mov      w6, #0xdd
0x104d1541c: bl       #0x107c27c64 ; _objc_msgSend
0x104d15420: mov      x0, x24
0x104d15424: bl       #0x107c27c70 ; _objc_release
0x104d15428: mov      x0, x28
0x104d1542c: adrp     x28, #0x11ed12000
0x104d15430: bl       #0x107c27c70 ; _objc_release
0x104d15434: mov      x0, x27
0x104d15438: bl       #0x107c27c70 ; _objc_release
0x104d1543c: ldr      x0, [x28, #0x780] ; classref MMContext | Class MMContext
0x104d15440: mov      x1, x21 ; 'currentContext'
0x104d15444: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104d15448: mov      x29, x29
0x104d1544c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15450: mov      x19, x0
0x104d15454: ldr      x0, [x20, #0xc70] ; classref LocalInfoMgr | Class LocalInfoMgr
0x104d15458: mov      x1, x22 ; 'class'
0x104d1545c: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104d15460: mov      x2, x0
0x104d15464: mov      x0, x19
0x104d15468: mov      x1, x23 ; 'getService:'
0x104d1546c: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104d15470: mov      x29, x29
0x104d15474: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15478: mov      x24, x0
0x104d1547c: mov      x1, x25 ; 'localInfo'
0x104d15480: bl       #0x107c27c64 ; _objc_msgSend | selector=localInfo
0x104d15484: mov      x29, x29
0x104d15488: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d1548c: mov      x27, x0
0x104d15490: mov      x1, x26 ; 'm_uiNetControlBitFlag'
0x104d15494: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiNetControlBitFlag
0x104d15498: tst      w0, #1
0x104d1549c: cset     w0, eq
0x104d154a0: bl       #0x107c0c114
0x104d154a4: mov      x0, x27
0x104d154a8: bl       #0x107c27c70 ; _objc_release
0x104d154ac: mov      x0, x24
0x104d154b0: bl       #0x107c27c70 ; _objc_release
0x104d154b4: mov      x0, x19
0x104d154b8: bl       #0x107c27c70 ; _objc_release
0x104d154bc: bl       #0x105601dec
0x104d154c0: bl       #0x105602104
0x104d154c4: cbz      w0, #0x104d15548
0x104d154c8: ldr      x0, [x28, #0x780] ; classref MMContext | Class MMContext
0x104d154cc: mov      x1, x21 ; 'currentContext'
0x104d154d0: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104d154d4: mov      x29, x29
0x104d154d8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d154dc: mov      x19, x0
0x104d154e0: ldr      x0, [x20, #0xc70] ; classref LocalInfoMgr | Class LocalInfoMgr
0x104d154e4: mov      x1, x22 ; 'class'
0x104d154e8: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104d154ec: mov      x2, x0
0x104d154f0: mov      x0, x19
0x104d154f4: mov      x1, x23 ; 'getService:'
0x104d154f8: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104d154fc: mov      x29, x29
0x104d15500: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15504: mov      x24, x0
0x104d15508: mov      x1, x25 ; 'localInfo'
0x104d1550c: bl       #0x107c27c64 ; _objc_msgSend | selector=localInfo
0x104d15510: mov      x29, x29
0x104d15514: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15518: mov      x25, x0
0x104d1551c: mov      x1, x26 ; 'm_uiNetControlBitFlag'
0x104d15520: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiNetControlBitFlag
0x104d15524: tst      w0, #1
0x104d15528: cset     w0, eq
0x104d1552c: bl       #0x10b655380
0x104d15530: mov      x0, x25
0x104d15534: bl       #0x107c27c70 ; _objc_release
0x104d15538: mov      x0, x24
0x104d1553c: bl       #0x107c27c70 ; _objc_release
0x104d15540: mov      x0, x19
0x104d15544: bl       #0x107c27c70 ; _objc_release
0x104d15548: adrp     x8, #0x11ed12000
0x104d1554c: ldr      x19, [x8, #0x618] ; classref iConsole | Class iConsole
0x104d15550: ldr      x0, [x28, #0x780] ; classref MMContext | Class MMContext
0x104d15554: mov      x1, x21 ; 'currentContext'
0x104d15558: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104d1555c: mov      x29, x29
0x104d15560: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15564: mov      x24, x0
0x104d15568: adrp     x8, #0x11e9cc000 ; @selector(setCenterY:)
0x104d1556c: ldr      x25, [x8, #0xa70] ; @selector(userName) | 'userName'
0x104d15570: mov      x1, x25 ; 'userName'
0x104d15574: bl       #0x107c27c64 ; _objc_msgSend | selector=userName
0x104d15578: mov      x29, x29
0x104d1557c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15580: mov      x26, x0
0x104d15584: adrp     x8, #0x11ed12000
0x104d15588: ldr      x0, [x8, #0x9d0] ; classref SettingUtil | Class SettingUtil
0x104d1558c: adrp     x8, #0x11e9ca000 ; @selector(isUsingEarDeviceWithRoute:)
0x104d15590: ldr      x1, [x8, #0xbf8] ; @selector(getMainSetting) | 'getMainSetting'
0x104d15594: bl       #0x107c27c64 ; _objc_msgSend | selector=getMainSetting
0x104d15598: mov      x29, x29
0x104d1559c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d155a0: mov      x27, x0
0x104d155a4: adrp     x8, #0x11e9d4000 ; @selector(isVoiceTranscriptionMatchedWithChatName:audioId:)
0x104d155a8: ldr      x1, [x8, #0x510] ; @selector(m_bAuthAnotherPlace) | 'm_bAuthAnotherPlace'
0x104d155ac: bl       #0x107c27c64 ; _objc_msgSend | selector=m_bAuthAnotherPlace
0x104d155b0: stp      x26, x0, [sp, #8]
0x104d155b4: adrp     x8, #0x11d2b9000
0x104d155b8: add      x8, x8, #0xbf8 ; @'check setting %@ another %u'
0x104d155bc: str      x8, [sp] ; @'check setting %@ another %u'
0x104d155c0: adrp     x3, #0x119ba9000 ; 'st %@'
0x104d155c4: add      x3, x3, #0xcd2 ; 'Kern'
0x104d155c8: adrp     x5, #0x11a1ac000 ; 'View'
0x104d155cc: add      x5, x5, #0x3e8 ; 'MainControll.mm'
0x104d155d0: adrp     x7, #0x11a1ac000 ; 'View'
0x104d155d4: add      x7, x7, #0x494 ; '-[CMainControll Start:]'
0x104d155d8: mov      x0, x19 ; Class iConsole
0x104d155dc: ldr      x1, [sp, #0x30]
0x104d155e0: mov      w2, #2
0x104d155e4: mov      w4, #0
0x104d155e8: mov      w6, #0xe3
0x104d155ec: bl       #0x107c27c64 ; _objc_msgSend
0x104d155f0: mov      x0, x27
0x104d155f4: bl       #0x107c27c70 ; _objc_release
0x104d155f8: mov      x0, x26
0x104d155fc: bl       #0x107c27c70 ; _objc_release
0x104d15600: mov      x0, x24
0x104d15604: bl       #0x107c27c70 ; _objc_release
0x104d15608: ldr      x0, [x28, #0x780] ; classref MMContext | Class MMContext
0x104d1560c: mov      x1, x21 ; 'currentContext'
0x104d15610: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104d15614: mov      x29, x29
0x104d15618: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d1561c: mov      x19, x0
0x104d15620: mov      x1, x25 ; 'userName'
0x104d15624: bl       #0x107c27c64 ; _objc_msgSend | selector=userName
0x104d15628: mov      x29, x29
0x104d1562c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15630: mov      x24, x0
0x104d15634: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x104d15638: ldr      x1, [x8, #0xce8] ; @selector(length) | 'length'
0x104d1563c: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x104d15640: mov      x26, x0
0x104d15644: mov      x0, x24
0x104d15648: bl       #0x107c27c70 ; _objc_release
0x104d1564c: mov      x0, x19
0x104d15650: bl       #0x107c27c70 ; _objc_release
0x104d15654: ldr      x20, [sp, #0x20]
0x104d15658: cbz      x26, #0x104d157e8
0x104d1565c: strb     wzr, [sp, #0x3f]
0x104d15660: ldp      x19, x24, [x20, #8]
0x104d15664: ldr      x0, [x28, #0x780] ; classref MMContext | Class MMContext
0x104d15668: mov      x1, x21 ; 'currentContext'
0x104d1566c: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104d15670: mov      x29, x29
0x104d15674: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15678: mov      x26, x0
0x104d1567c: mov      x1, x25 ; 'userName'
0x104d15680: bl       #0x107c27c64 ; _objc_msgSend | selector=userName
0x104d15684: mov      x29, x29
0x104d15688: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d1568c: mov      x25, x0
0x104d15690: adrp     x8, #0x11eb11000 ; @selector(hasMigrateRedTips)
0x104d15694: ldr      x1, [x8, #0x680] ; @selector(InitMMDB:UsrName:NewUser:) | 'InitMMDB:UsrName:NewUser:'
0x104d15698: add      x4, sp, #0x3f
0x104d1569c: mov      x0, x19
0x104d156a0: mov      x2, x24
0x104d156a4: mov      x3, x25
0x104d156a8: bl       #0x107c27c64 ; _objc_msgSend | selector=InitMMDB:UsrName:NewUser:
0x104d156ac: mov      x0, x25
0x104d156b0: bl       #0x107c27c70 ; _objc_release
0x104d156b4: mov      x0, x26
0x104d156b8: bl       #0x107c27c70 ; _objc_release
0x104d156bc: ldr      x0, [x28, #0x780] ; classref MMContext | Class MMContext
0x104d156c0: mov      x1, x21 ; 'currentContext'
0x104d156c4: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104d156c8: mov      x29, x29
0x104d156cc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d156d0: mov      x19, x0
0x104d156d4: adrp     x25, #0x11ed12000
0x104d156d8: ldr      x0, [x25, #0xbe8] ; classref CContactMgr | Class CContactMgr
0x104d156dc: mov      x1, x22 ; 'class'
0x104d156e0: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104d156e4: mov      x2, x0
0x104d156e8: mov      x0, x19
0x104d156ec: mov      x1, x23 ; 'getService:'
0x104d156f0: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104d156f4: mov      x29, x29
0x104d156f8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d156fc: mov      x24, x0
0x104d15700: ldr      x2, [x20, #8]
0x104d15704: ldrb     w3, [sp, #0x3f]
0x104d15708: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d1570c: ldr      x1, [x8, #0x630] ; @selector(updateNewDB:NewUser:) | 'updateNewDB:NewUser:'
0x104d15710: bl       #0x107c27c64 ; _objc_msgSend | selector=updateNewDB:NewUser:
0x104d15714: mov      x0, x24
0x104d15718: bl       #0x107c27c70 ; _objc_release
0x104d1571c: mov      x0, x19
0x104d15720: bl       #0x107c27c70 ; _objc_release
0x104d15724: ldr      x0, [x28, #0x780] ; classref MMContext | Class MMContext
0x104d15728: mov      x1, x21 ; 'currentContext'
0x104d1572c: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104d15730: mov      x29, x29
0x104d15734: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15738: mov      x19, x0
0x104d1573c: ldr      x0, [x25, #0xbe8] ; classref CContactMgr | Class CContactMgr
0x104d15740: mov      x1, x22 ; 'class'
0x104d15744: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104d15748: mov      x2, x0
0x104d1574c: mov      x0, x19
0x104d15750: mov      x1, x23 ; 'getService:'
0x104d15754: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104d15758: mov      x29, x29
0x104d1575c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15760: mov      x24, x0
0x104d15764: ldr      x2, [x20, #8]
0x104d15768: adrp     x8, #0x11ea1c000 ; @selector(textStateJumpTopicSquareWithReporter:)
0x104d1576c: ldr      x1, [x8, #0x310] ; @selector(initDB:) | 'initDB:'
0x104d15770: bl       #0x107c27c64 ; _objc_msgSend | selector=initDB:
0x104d15774: mov      x0, x24
0x104d15778: bl       #0x107c27c70 ; _objc_release
0x104d1577c: mov      x0, x19
0x104d15780: bl       #0x107c27c70 ; _objc_release
0x104d15784: ldr      x0, [x28, #0x780] ; classref MMContext | Class MMContext
0x104d15788: mov      x1, x21 ; 'currentContext'
0x104d1578c: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104d15790: mov      x29, x29
0x104d15794: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15798: mov      x19, x0
0x104d1579c: adrp     x8, #0x11ed12000
0x104d157a0: ldr      x0, [x8, #0xc20] ; classref CMessageMgr | Class CMessageMgr
0x104d157a4: mov      x1, x22 ; 'class'
0x104d157a8: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104d157ac: mov      x2, x0
0x104d157b0: mov      x0, x19
0x104d157b4: mov      x1, x23 ; 'getService:'
0x104d157b8: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104d157bc: mov      x29, x29
0x104d157c0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d157c4: mov      x24, x0
0x104d157c8: ldr      x2, [x20, #8]
0x104d157cc: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d157d0: ldr      x1, [x8, #0x638] ; @selector(InitMsgMgr:) | 'InitMsgMgr:'
0x104d157d4: bl       #0x107c27c64 ; _objc_msgSend | selector=InitMsgMgr:
0x104d157d8: mov      x0, x24
0x104d157dc: bl       #0x107c27c70 ; _objc_release
0x104d157e0: mov      x0, x19
0x104d157e4: bl       #0x107c27c70 ; _objc_release
0x104d157e8: ldr      x0, [x28, #0x780] ; classref MMContext | Class MMContext
0x104d157ec: mov      x1, x21 ; 'currentContext'
0x104d157f0: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104d157f4: mov      x29, x29
0x104d157f8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d157fc: mov      x19, x0
0x104d15800: adrp     x8, #0x11ed12000
0x104d15804: ldr      x0, [x8, #0xff8] ; classref CNetworkStatus | Class CNetworkStatus
0x104d15808: mov      x1, x22 ; 'class'
0x104d1580c: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104d15810: mov      x2, x0
0x104d15814: mov      x0, x19
0x104d15818: mov      x1, x23 ; 'getService:'
0x104d1581c: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104d15820: mov      x29, x29
0x104d15824: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15828: mov      x22, x0
0x104d1582c: adrp     x8, #0x11eb0a000 ; @selector(playWithMusicInfo:updateSessionId:)
0x104d15830: ldr      x23, [x8, #0xea8] ; @selector(Start:) | 'Start:'
0x104d15834: adrp     x8, #0x11e9ca000 ; @selector(isUsingEarDeviceWithRoute:)
0x104d15838: ldr      x1, [x8, #0xf48] ; @selector(weakContextObject) | 'weakContextObject'
0x104d1583c: mov      x0, x20
0x104d15840: bl       #0x107c27c64 ; _objc_msgSend | selector=weakContextObject
0x104d15844: mov      x29, x29
0x104d15848: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d1584c: mov      x20, x0
0x104d15850: adrp     x8, #0x11e9c9000
0x104d15854: ldr      x1, [x8, #0xec8] ; @selector(safePerformSelector:withObject:afterDelay:) | 'safePerformSelector:withObject:afterDelay:'
0x104d15858: fmov     d0, xzr
0x104d1585c: mov      x0, x22
0x104d15860: mov      x2, x23 ; 'Start:'
0x104d15864: mov      x3, x20
0x104d15868: bl       #0x107c27c64 ; _objc_msgSend | selector=safePerformSelector:withObject:afterDelay:
0x104d1586c: mov      x0, x20
0x104d15870: bl       #0x107c27c70 ; _objc_release
0x104d15874: mov      x0, x22
0x104d15878: bl       #0x107c27c70 ; _objc_release
0x104d1587c: mov      x0, x19
0x104d15880: bl       #0x107c27c70 ; _objc_release
0x104d15884: ldr      x0, [x28, #0x780] ; classref MMContext | Class MMContext
0x104d15888: mov      x1, x21 ; 'currentContext'
0x104d1588c: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104d15890: mov      x29, x29
0x104d15894: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15898: mov      x19, x0
0x104d1589c: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x104d158a0: ldr      x2, [x8, #0x5d8]
0x104d158a4: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d158a8: ldr      x3, [x8, #0x640] ; @selector(onMainControllStart) | 'onMainControllStart'
0x104d158ac: adrp     x8, #0x11e9c9000
0x104d158b0: ldr      x1, [x8, #0xe58] ; @selector(callExtension:selector:block:) | 'callExtension:selector:block:'
0x104d158b4: adrp     x4, #0x11c2f4000
0x104d158b8: add      x4, x4, #0xdd0 ; __NSConcreteGlobalBlock
0x104d158bc: bl       #0x107c27c64 ; _objc_msgSend | selector=callExtension:selector:block:
0x104d158c0: mov      x0, x19
0x104d158c4: bl       #0x107c27c70 ; _objc_release
0x104d158c8: ldr      x0, [sp, #0x28]
0x104d158cc: bl       #0x107c27c70 ; _objc_release
0x104d158d0: ldp      x29, x30, [sp, #0x90]
0x104d158d4: ldp      x20, x19, [sp, #0x80]
0x104d158d8: ldp      x22, x21, [sp, #0x70]
0x104d158dc: ldp      x24, x23, [sp, #0x60]
0x104d158e0: ldp      x26, x25, [sp, #0x50]
0x104d158e4: ldp      x28, x27, [sp, #0x40]
0x104d158e8: add      sp, sp, #0xa0
0x104d158ec: ret      
