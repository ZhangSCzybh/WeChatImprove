-[CMainControll NotifyFromEvent:Message:MessageInfo:] 0x104d17130 v36@0:8@16I24@28
0x104d17130: sub      sp, sp, #0xb0
0x104d17134: stp      x28, x27, [sp, #0x50]
0x104d17138: stp      x26, x25, [sp, #0x60]
0x104d1713c: stp      x24, x23, [sp, #0x70]
0x104d17140: stp      x22, x21, [sp, #0x80]
0x104d17144: stp      x20, x19, [sp, #0x90]
0x104d17148: stp      x29, x30, [sp, #0xa0]
0x104d1714c: add      x29, sp, #0xa0
0x104d17150: mov      x20, x4
0x104d17154: mov      x22, x3
0x104d17158: mov      x19, x2
0x104d1715c: mov      x28, x0
0x104d17160: adrp     x8, #0x11f751000
0x104d17164: mov      w9, #1
0x104d17168: strb     w9, [x8, #0x965]
0x104d1716c: mov      x0, x2
0x104d17170: bl       #0x107c27c74 ; _objc_retain
0x104d17174: mov      x0, x20
0x104d17178: bl       #0x107c27c74 ; _objc_retain
0x104d1717c: adrp     x23, #0x11ed12000
0x104d17180: ldr      x21, [x23, #0x618] ; classref iConsole | Class iConsole
0x104d17184: adrp     x8, #0x11e9da000 ; @selector(scrollableFinderCellViewOnValidShowItems:)
0x104d17188: ldr      x1, [x8, #0xcd0] ; @selector(GetEventType) | 'GetEventType'
0x104d1718c: mov      x0, x19
0x104d17190: bl       #0x107c27c64 ; _objc_msgSend | selector=GetEventType
0x104d17194: mov      x26, x0
0x104d17198: adrp     x8, #0x11e9da000 ; @selector(scrollableFinderCellViewOnValidShowItems:)
0x104d1719c: ldr      x1, [x8, #0xcc0] ; @selector(m_uiEventID) | 'm_uiEventID'
0x104d171a0: mov      x0, x19
0x104d171a4: str      x1, [sp, #0x38] ; 'm_uiEventID'
0x104d171a8: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiEventID
0x104d171ac: mov      x27, x0
0x104d171b0: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d171b4: ldr      x24, [x8, #0x6d0] ; @selector(m_bNeedNotify) | 'm_bNeedNotify'
0x104d171b8: mov      x0, x19
0x104d171bc: mov      x1, x24 ; 'm_bNeedNotify'
0x104d171c0: bl       #0x107c27c64 ; _objc_msgSend | selector=m_bNeedNotify
0x104d171c4: adrp     x8, #0x11e9c9000
0x104d171c8: ldr      x25, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x104d171cc: mov      x8, x22
0x104d171d0: stp      x8, x0, [sp, #0x18]
0x104d171d4: stp      x26, x27, [sp, #8]
0x104d171d8: adrp     x8, #0x11d2b9000
0x104d171dc: add      x8, x8, #0xcb8 ; @'MainControll::NotifyFromEvent:event_type:%u,id:%u,message:%u,notify:%u'
0x104d171e0: str      x8, [sp] ; @'MainControll::NotifyFromEvent:event_type:%u,id:%u,message:%u,notify:%u'
0x104d171e4: adrp     x3, #0x119bc2000 ; 'Contact: %d'
0x104d171e8: add      x3, x3, #0x5b ; 'Net'
0x104d171ec: adrp     x5, #0x11a1ac000 ; 'View'
0x104d171f0: add      x5, x5, #0x3e8 ; 'MainControll.mm'
0x104d171f4: adrp     x7, #0x11a1ac000 ; 'View'
0x104d171f8: add      x7, x7, #0x668 ; '-[CMainControll NotifyFromEvent:Message:MessageInfo:]'
0x104d171fc: mov      x0, x21 ; Class iConsole
0x104d17200: mov      x1, x25 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x104d17204: mov      w2, #2
0x104d17208: mov      w4, #0
0x104d1720c: mov      w6, #0x1cd
0x104d17210: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x104d17214: cmp      w22, #4
0x104d17218: b.eq     #0x104d1722c
0x104d1721c: cmp      w22, #0x140
0x104d17220: b.eq     #0x104d17360
0x104d17224: cmp      w22, #0x3f
0x104d17228: b.ne     #0x104d1748c
0x104d1722c: str      x28, [sp, #0x30]
0x104d17230: ldr      x0, [x23, #0x618] ; classref iConsole | Class iConsole
0x104d17234: adrp     x8, #0x11d2b9000
0x104d17238: add      x8, x8, #0xcd8 ; @'notify to sync message %u'
0x104d1723c: stp      x8, x22, [sp] ; @'notify to sync message %u'
0x104d17240: adrp     x5, #0x11a1ac000 ; 'View'
0x104d17244: add      x5, x5, #0x3e8 ; 'MainControll.mm'
0x104d17248: adrp     x7, #0x11a1ac000 ; 'View'
0x104d1724c: add      x7, x7, #0x668 ; '-[CMainControll NotifyFromEvent:Message:MessageInfo:]'
0x104d17250: mov      x1, x25 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x104d17254: mov      w2, #2
0x104d17258: mov      x3, #0
0x104d1725c: mov      w4, #0
0x104d17260: mov      w6, #0x1d1
0x104d17264: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x104d17268: adrp     x8, #0x11e9c9000
0x104d1726c: ldr      x25, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x104d17270: cmp      w22, #4
0x104d17274: b.ne     #0x104d173f4
0x104d17278: adrp     x8, #0x11ed12000
0x104d1727c: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x104d17280: mov      x1, x25 ; 'currentContext'
0x104d17284: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104d17288: mov      x29, x29
0x104d1728c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d17290: mov      x21, x0
0x104d17294: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x104d17298: ldr      x0, [x8, #0xc30] ; classref NewSyncService | Class NewSyncService
0x104d1729c: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104d172a0: ldr      x26, [x8, #0x508] ; @selector(class) | 'class'
0x104d172a4: mov      x1, x26 ; 'class'
0x104d172a8: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104d172ac: mov      x2, x0
0x104d172b0: adrp     x8, #0x11e9c9000
0x104d172b4: ldr      x27, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x104d172b8: mov      x0, x21
0x104d172bc: mov      x1, x27 ; 'getService:'
0x104d172c0: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104d172c4: mov      x29, x29
0x104d172c8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d172cc: mov      x28, x0
0x104d172d0: adrp     x8, #0x11ed12000
0x104d172d4: ldr      x0, [x8, #0x690] ; _OBJC_CLASS_$_NSDate
0x104d172d8: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104d172dc: ldr      x1, [x8, #0xbd8] ; @selector(date) | 'date'
0x104d172e0: bl       #0x107c27c64 ; _objc_msgSend | selector=date
0x104d172e4: mov      x29, x29
0x104d172e8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d172ec: mov      x23, x0
0x104d172f0: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d172f4: ldr      x1, [x8, #0x6d8] ; @selector(SetLastNotifyTime:) | 'SetLastNotifyTime:'
0x104d172f8: mov      x0, x28
0x104d172fc: mov      x2, x23
0x104d17300: bl       #0x107c27c64 ; _objc_msgSend | selector=SetLastNotifyTime:
0x104d17304: mov      x0, x23
0x104d17308: bl       #0x107c27c70 ; _objc_release
0x104d1730c: mov      x0, x28
0x104d17310: bl       #0x107c27c70 ; _objc_release
0x104d17314: mov      x0, x21
0x104d17318: bl       #0x107c27c70 ; _objc_release
0x104d1731c: cbz      x20, #0x104d1740c
0x104d17320: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x104d17324: ldr      x1, [x8, #0x640] ; @selector(objectForKey:) | 'objectForKey:'
0x104d17328: adrp     x2, #0x11d184000
0x104d1732c: add      x2, x2, #0xab8 ; @'86'
0x104d17330: mov      x0, x20
0x104d17334: bl       #0x107c27c64 ; _objc_msgSend | selector=objectForKey:
0x104d17338: mov      x29, x29
0x104d1733c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d17340: mov      x21, x0
0x104d17344: cbz      x0, #0x104d17414
0x104d17348: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x104d1734c: ldr      x1, [x8, #0xf28] ; @selector(longLongValue) | 'longLongValue'
0x104d17350: mov      x0, x21
0x104d17354: bl       #0x107c27c64 ; _objc_msgSend | selector=longLongValue
0x104d17358: mov      x28, x0
0x104d1735c: b        #0x104d17418
0x104d17360: adrp     x8, #0x11ed12000
0x104d17364: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x104d17368: adrp     x8, #0x11e9c9000
0x104d1736c: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x104d17370: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104d17374: mov      x29, x29
0x104d17378: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d1737c: mov      x25, x0
0x104d17380: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x104d17384: ldr      x0, [x8, #0xc30] ; classref NewSyncService | Class NewSyncService
0x104d17388: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104d1738c: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x104d17390: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104d17394: mov      x2, x0
0x104d17398: adrp     x8, #0x11e9c9000
0x104d1739c: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x104d173a0: mov      x0, x25
0x104d173a4: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104d173a8: mov      x29, x29
0x104d173ac: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d173b0: mov      x26, x0
0x104d173b4: adrp     x8, #0x11ed12000
0x104d173b8: ldr      x0, [x8, #0x690] ; _OBJC_CLASS_$_NSDate
0x104d173bc: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104d173c0: ldr      x1, [x8, #0xbd8] ; @selector(date) | 'date'
0x104d173c4: bl       #0x107c27c64 ; _objc_msgSend | selector=date
0x104d173c8: mov      x29, x29
0x104d173cc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d173d0: mov      x21, x0
0x104d173d4: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d173d8: ldr      x1, [x8, #0x6e8] ; @selector(SetLastLongConnDisconectTime:) | 'SetLastLongConnDisconectTime:'
0x104d173dc: mov      x0, x26
0x104d173e0: mov      x2, x21
0x104d173e4: bl       #0x107c27c64 ; _objc_msgSend | selector=SetLastLongConnDisconectTime:
0x104d173e8: mov      x0, x21
0x104d173ec: bl       #0x107c27c70 ; _objc_release
0x104d173f0: b        #0x104d1747c
0x104d173f4: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104d173f8: ldr      x26, [x8, #0x508] ; @selector(class) | 'class'
0x104d173fc: adrp     x8, #0x11e9c9000
0x104d17400: ldr      x27, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x104d17404: mov      w28, #7
0x104d17408: b        #0x104d17420
0x104d1740c: mov      w28, #1
0x104d17410: b        #0x104d17420
0x104d17414: mov      w28, #1
0x104d17418: mov      x0, x21
0x104d1741c: bl       #0x107c27c70 ; _objc_release
0x104d17420: adrp     x8, #0x11ed12000
0x104d17424: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x104d17428: mov      x1, x25
0x104d1742c: bl       #0x107c27c64 ; _objc_msgSend
0x104d17430: mov      x29, x29
0x104d17434: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d17438: mov      x25, x0
0x104d1743c: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x104d17440: ldr      x0, [x8, #0xc30] ; classref NewSyncService | Class NewSyncService
0x104d17444: mov      x1, x26 ; 'class'
0x104d17448: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104d1744c: mov      x2, x0
0x104d17450: mov      x0, x25
0x104d17454: mov      x1, x27 ; 'getService:'
0x104d17458: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104d1745c: mov      x29, x29
0x104d17460: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d17464: mov      x26, x0
0x104d17468: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d1746c: ldr      x1, [x8, #0x6e0] ; @selector(setNeedSyncWithScene:) | 'setNeedSyncWithScene:'
0x104d17470: mov      x2, x28
0x104d17474: bl       #0x107c27c64 ; _objc_msgSend | selector=setNeedSyncWithScene:
0x104d17478: ldr      x28, [sp, #0x30]
0x104d1747c: mov      x0, x26
0x104d17480: bl       #0x107c27c70 ; _objc_release
0x104d17484: mov      x0, x25
0x104d17488: bl       #0x107c27c70 ; _objc_release
0x104d1748c: cbz      x19, #0x104d1755c
0x104d17490: mov      x0, x19
0x104d17494: mov      x1, x24 ; 'm_bNeedNotify'
0x104d17498: bl       #0x107c27c64 ; _objc_msgSend | selector=m_bNeedNotify
0x104d1749c: cbz      w0, #0x104d175e8
0x104d174a0: adrp     x8, #0x11ed32000 ; classref MagicEcsNirvanaLoadingComponent
0x104d174a4: ldr      x0, [x8, #0x320] ; classref CMessage | Class CMessage
0x104d174a8: bl       #0x107c27c0c ; _objc_alloc_init
0x104d174ac: mov      x24, x0
0x104d174b0: adrp     x8, #0x11e9d4000 ; @selector(isVoiceTranscriptionMatchedWithChatName:audioId:)
0x104d174b4: ldr      x1, [x8, #0x1b8] ; @selector(setM_uiMessage:) | 'setM_uiMessage:'
0x104d174b8: mov      x2, x22
0x104d174bc: bl       #0x107c27c64 ; _objc_msgSend | selector=setM_uiMessage:
0x104d174c0: mov      x0, x19
0x104d174c4: ldr      x1, [sp, #0x38]
0x104d174c8: bl       #0x107c27c64 ; _objc_msgSend
0x104d174cc: mov      x2, x0
0x104d174d0: adrp     x8, #0x11ea3b000 ; @selector(OnBatchAddEnterpriseMsg:Brand:)
0x104d174d4: ldr      x1, [x8, #0x730] ; @selector(setM_uiEventID:) | 'setM_uiEventID:'
0x104d174d8: mov      x0, x24
0x104d174dc: bl       #0x107c27c64 ; _objc_msgSend | selector=setM_uiEventID:
0x104d174e0: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d174e4: ldr      x1, [x8, #0x6a8] ; @selector(setM_bNotify:) | 'setM_bNotify:'
0x104d174e8: mov      x0, x24
0x104d174ec: mov      w2, #1
0x104d174f0: bl       #0x107c27c64 ; _objc_msgSend | selector=setM_bNotify:
0x104d174f4: adrp     x8, #0x11ed1e000 ; classref MainSessionInfoItem
0x104d174f8: ldr      x0, [x8, #0x18] ; classref ProtobufEvent | Class ProtobufEvent
0x104d174fc: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104d17500: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x104d17504: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104d17508: mov      x2, x0
0x104d1750c: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x104d17510: ldr      x1, [x8, #0x890] ; @selector(isKindOfClass:) | 'isKindOfClass:'
0x104d17514: mov      x0, x19
0x104d17518: bl       #0x107c27c64 ; _objc_msgSend | selector=isKindOfClass:
0x104d1751c: cbz      w0, #0x104d175a4
0x104d17520: adrp     x8, #0x11ea3b000 ; @selector(OnBatchAddEnterpriseMsg:Brand:)
0x104d17524: ldr      x1, [x8, #0x688] ; @selector(m_pbCGIWrap) | 'm_pbCGIWrap'
0x104d17528: mov      x0, x19
0x104d1752c: bl       #0x107c27c64 ; _objc_msgSend | selector=m_pbCGIWrap
0x104d17530: mov      x29, x29
0x104d17534: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d17538: mov      x21, x0
0x104d1753c: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d17540: ldr      x1, [x8, #0x6f0] ; @selector(setM_pbCGIWrap:) | 'setM_pbCGIWrap:'
0x104d17544: mov      x0, x24
0x104d17548: mov      x2, x21
0x104d1754c: bl       #0x107c27c64 ; _objc_msgSend | selector=setM_pbCGIWrap:
0x104d17550: mov      x0, x21
0x104d17554: bl       #0x107c27c70 ; _objc_release
0x104d17558: b        #0x104d175b8
0x104d1755c: adrp     x8, #0x11ed32000 ; classref MagicEcsNirvanaLoadingComponent
0x104d17560: ldr      x0, [x8, #0x320] ; classref CMessage | Class CMessage
0x104d17564: bl       #0x107c27c0c ; _objc_alloc_init
0x104d17568: mov      x24, x0
0x104d1756c: adrp     x8, #0x11e9d4000 ; @selector(isVoiceTranscriptionMatchedWithChatName:audioId:)
0x104d17570: ldr      x1, [x8, #0x1b8] ; @selector(setM_uiMessage:) | 'setM_uiMessage:'
0x104d17574: mov      x2, x22
0x104d17578: bl       #0x107c27c64 ; _objc_msgSend | selector=setM_uiMessage:
0x104d1757c: adrp     x8, #0x11ea3b000 ; @selector(OnBatchAddEnterpriseMsg:Brand:)
0x104d17580: ldr      x1, [x8, #0x730] ; @selector(setM_uiEventID:) | 'setM_uiEventID:'
0x104d17584: mov      x0, x24
0x104d17588: mov      w2, #0
0x104d1758c: bl       #0x107c27c64 ; _objc_msgSend | selector=setM_uiEventID:
0x104d17590: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d17594: ldr      x1, [x8, #0x6a8] ; @selector(setM_bNotify:) | 'setM_bNotify:'
0x104d17598: mov      x0, x24
0x104d1759c: mov      w2, #1
0x104d175a0: bl       #0x107c27c64 ; _objc_msgSend | selector=setM_bNotify:
0x104d175a4: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d175a8: ldr      x1, [x8, #0x6a0] ; @selector(setM_dicMessageInfo:) | 'setM_dicMessageInfo:'
0x104d175ac: mov      x0, x24
0x104d175b0: mov      x2, x20
0x104d175b4: bl       #0x107c27c64 ; _objc_msgSend | selector=setM_dicMessageInfo:
0x104d175b8: ldr      x1, [x28, #0x28]
0x104d175bc: add      x0, sp, #0x40
0x104d175c0: bl       #0x107c0ccb0
0x104d175c4: ldr      x0, [x28, #0x30]
0x104d175c8: adrp     x8, #0x11e9ca000 ; @selector(isUsingEarDeviceWithRoute:)
0x104d175cc: ldr      x1, [x8, #0x580] ; @selector(safeAddObject:) | 'safeAddObject:'
0x104d175d0: mov      x2, x24
0x104d175d4: bl       #0x107c27c64 ; _objc_msgSend | selector=safeAddObject:
0x104d175d8: add      x0, sp, #0x40
0x104d175dc: bl       #0x107c0ccb4
0x104d175e0: mov      x0, x24
0x104d175e4: bl       #0x107c27c70 ; _objc_release
0x104d175e8: mov      x0, x20
0x104d175ec: bl       #0x107c27c70 ; _objc_release
0x104d175f0: mov      x0, x19
0x104d175f4: bl       #0x107c27c70 ; _objc_release
0x104d175f8: ldp      x29, x30, [sp, #0xa0]
0x104d175fc: ldp      x20, x19, [sp, #0x90]
0x104d17600: ldp      x22, x21, [sp, #0x80]
0x104d17604: ldp      x24, x23, [sp, #0x70]
0x104d17608: ldp      x26, x25, [sp, #0x60]
0x104d1760c: ldp      x28, x27, [sp, #0x50]
0x104d17610: add      sp, sp, #0xb0
0x104d17614: ret      
