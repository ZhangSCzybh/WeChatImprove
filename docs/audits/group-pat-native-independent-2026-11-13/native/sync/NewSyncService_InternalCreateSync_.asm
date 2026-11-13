-[NewSyncService InternalCreateSync:] 0x105462488 B20@0:8I16
0x105462488: sub      sp, sp, #0x40
0x10546248c: stp      x22, x21, [sp, #0x10]
0x105462490: stp      x20, x19, [sp, #0x20]
0x105462494: stp      x29, x30, [sp, #0x30]
0x105462498: add      x29, sp, #0x30
0x10546249c: mov      x20, x2
0x1054624a0: mov      x19, x0
0x1054624a4: adrp     x8, #0x11f753000
0x1054624a8: mov      w9, #1
0x1054624ac: strb     w9, [x8, #0x47a]
0x1054624b0: adrp     x8, #0x11edca000
0x1054624b4: ldrsw    x8, [x8, #0x8e4] ; ivar_offset NewSyncService.m_bIsSyncPause=0x54
0x1054624b8: ldrb     w8, [x0, x8]
0x1054624bc: cmp      w8, #1
0x1054624c0: b.ne     #0x1054624dc
0x1054624c4: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x1054624c8: ldr      x1, [x8, #0x6e0] ; @selector(setNeedSyncWithScene:) | 'setNeedSyncWithScene:'
0x1054624cc: mov      x0, x19
0x1054624d0: mov      x2, x20
0x1054624d4: bl       #0x107c27c64 ; _objc_msgSend | selector=setNeedSyncWithScene:
0x1054624d8: b        #0x10546266c
0x1054624dc: adrp     x8, #0x11ed12000
0x1054624e0: ldr      x0, [x8, #0x9d0] ; classref SettingUtil | Class SettingUtil
0x1054624e4: adrp     x8, #0x11e9ca000 ; @selector(isUsingEarDeviceWithRoute:)
0x1054624e8: ldr      x1, [x8, #0xbf8] ; @selector(getMainSetting) | 'getMainSetting'
0x1054624ec: bl       #0x107c27c64 ; _objc_msgSend | selector=getMainSetting
0x1054624f0: mov      x29, x29
0x1054624f4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054624f8: mov      x21, x0
0x1054624fc: adrp     x8, #0x11ea24000 ; @selector(OnCdnDownloadError:)
0x105462500: ldr      x1, [x8, #0x2b0] ; @selector(m_uiInitStatus) | 'm_uiInitStatus'
0x105462504: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiInitStatus
0x105462508: mov      x22, x0
0x10546250c: mov      x0, x21
0x105462510: bl       #0x107c27c70 ; _objc_release
0x105462514: cbz      w22, #0x1054625c0
0x105462518: mov      x0, x19
0x10546251c: bl       #0x107c27c74 ; _objc_retain
0x105462520: bl       #0x107c27ca4 ; _objc_sync_enter
0x105462524: adrp     x8, #0x11edca000
0x105462528: ldrsw    x8, [x8, #0x8d8] ; ivar_offset NewSyncService.m_bHasInit=0x8
0x10546252c: ldrb     w8, [x19, x8]
0x105462530: tbz      w8, #0, #0x105462608
0x105462534: mov      x0, x19
0x105462538: bl       #0x107c27ca8 ; _objc_sync_exit
0x10546253c: mov      x0, x19
0x105462540: bl       #0x107c27c70 ; _objc_release
0x105462544: adrp     x8, #0x11edca000
0x105462548: ldrsw    x8, [x8, #0x8e8] ; ivar_offset NewSyncService.m_syncEventID=0x50
0x10546254c: ldr      w8, [x19, x8]
0x105462550: cbz      w8, #0x105462688
0x105462554: cmp      w20, #0xc
0x105462558: b.eq     #0x10546266c
0x10546255c: adrp     x8, #0x11edca000
0x105462560: ldrsw    x20, [x8, #0x8d4] ; ivar_offset NewSyncService.m_bNeedSync=0x57
0x105462564: ldrb     w8, [x19, x20]
0x105462568: tbnz     w8, #0, #0x1054625b0
0x10546256c: adrp     x8, #0x11ed12000
0x105462570: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105462574: adrp     x8, #0x11e9c9000
0x105462578: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x10546257c: adrp     x8, #0x11d2f6000
0x105462580: add      x8, x8, #0xd18 ; @'flag to sync!'
0x105462584: str      x8, [sp] ; @'flag to sync!'
0x105462588: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x10546258c: add      x3, x3, #0xfaf ; 'Sync'
0x105462590: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105462594: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105462598: adrp     x7, #0x11a21f000 ; 'llu,%llu'
0x10546259c: add      x7, x7, #0xc96 ; '-[NewSyncService InternalCreateSync:]'
0x1054625a0: mov      w2, #2
0x1054625a4: mov      w4, #0
0x1054625a8: mov      w6, #0x15f
0x1054625ac: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x1054625b0: mov      w8, #0
0x1054625b4: mov      w9, #1
0x1054625b8: strb     w9, [x19, x20]
0x1054625bc: b        #0x105462670
0x1054625c0: adrp     x8, #0x11ed12000
0x1054625c4: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x1054625c8: adrp     x8, #0x11e9c9000
0x1054625cc: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x1054625d0: adrp     x8, #0x11d2f6000
0x1054625d4: add      x8, x8, #0xcd8 ; @'main settting init not start'
0x1054625d8: str      x8, [sp] ; @'main settting init not start'
0x1054625dc: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x1054625e0: add      x3, x3, #0xfaf ; 'Sync'
0x1054625e4: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x1054625e8: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x1054625ec: adrp     x7, #0x11a21f000 ; 'llu,%llu'
0x1054625f0: add      x7, x7, #0xc96 ; '-[NewSyncService InternalCreateSync:]'
0x1054625f4: mov      w2, #3
0x1054625f8: mov      w4, #0
0x1054625fc: mov      w6, #0x146
0x105462600: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105462604: b        #0x10546266c
0x105462608: adrp     x8, #0x11ed12000
0x10546260c: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105462610: adrp     x8, #0x11e9c9000
0x105462614: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105462618: adrp     x8, #0x11d2f6000
0x10546261c: add      x8, x8, #0xcf8 ; @'newsync service has not be initted'
0x105462620: str      x8, [sp] ; @'newsync service has not be initted'
0x105462624: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105462628: add      x3, x3, #0xfaf ; 'Sync'
0x10546262c: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105462630: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105462634: adrp     x7, #0x11a21f000 ; 'llu,%llu'
0x105462638: add      x7, x7, #0xc96 ; '-[NewSyncService InternalCreateSync:]'
0x10546263c: mov      w2, #3
0x105462640: mov      w4, #0
0x105462644: mov      w6, #0x14c
0x105462648: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x10546264c: adrp     x8, #0x11edca000
0x105462650: ldrsw    x8, [x8, #0x8d4] ; ivar_offset NewSyncService.m_bNeedSync=0x57
0x105462654: mov      w9, #1
0x105462658: strb     w9, [x19, x8]
0x10546265c: mov      x0, x19
0x105462660: bl       #0x107c27ca8 ; _objc_sync_exit
0x105462664: mov      x0, x19
0x105462668: bl       #0x107c27c70 ; _objc_release
0x10546266c: mov      w8, #0
0x105462670: and      w0, w8, #1
0x105462674: ldp      x29, x30, [sp, #0x30]
0x105462678: ldp      x20, x19, [sp, #0x20]
0x10546267c: ldp      x22, x21, [sp, #0x10]
0x105462680: add      sp, sp, #0x40
0x105462684: ret      
0x105462688: adrp     x8, #0x11edca000
0x10546268c: ldrsw    x8, [x8, #0x8d4] ; ivar_offset NewSyncService.m_bNeedSync=0x57
0x105462690: strb     wzr, [x19, x8]
0x105462694: adrp     x8, #0x11e9d4000 ; @selector(isVoiceTranscriptionMatchedWithChatName:audioId:)
0x105462698: ldr      x1, [x8, #0x268] ; @selector(setM_bHasSync:) | 'setM_bHasSync:'
0x10546269c: mov      w21, #1
0x1054626a0: mov      x0, x19
0x1054626a4: mov      w2, #1
0x1054626a8: bl       #0x107c27c64 ; _objc_msgSend | selector=setM_bHasSync:
0x1054626ac: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x1054626b0: ldr      x1, [x8, #0xbf0] ; @selector(creatPBNewSyncEvent:) | 'creatPBNewSyncEvent:'
0x1054626b4: mov      x0, x19
0x1054626b8: mov      x2, x20
0x1054626bc: bl       #0x107c27c64 ; _objc_msgSend | selector=creatPBNewSyncEvent:
0x1054626c0: cbz      w0, #0x1054626d4
0x1054626c4: adrp     x8, #0x11edca000
0x1054626c8: ldrsw    x8, [x8, #0x91c] ; ivar_offset NewSyncService.m_isGettingData=0x55
0x1054626cc: strb     w21, [x19, x8]
0x1054626d0: b        #0x1054626ec
0x1054626d4: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x1054626d8: ldr      x1, [x8, #0xaa0] ; @selector(resetGettingData) | 'resetGettingData'
0x1054626dc: mov      x0, x19
0x1054626e0: bl       #0x107c27c64 ; _objc_msgSend | selector=resetGettingData
0x1054626e4: adrp     x8, #0x11edca000
0x1054626e8: ldrsw    x8, [x8, #0x91c] ; ivar_offset NewSyncService.m_isGettingData=0x55
0x1054626ec: adrp     x9, #0x11edca000
0x1054626f0: ldrsw    x9, [x9, #0x8f0] ; ivar_offset NewSyncService.m_lastSyncFinishCallingExtension=0x4c
0x1054626f4: strb     wzr, [x19, x9]
0x1054626f8: ldrb     w8, [x19, x8]
0x1054626fc: b        #0x105462670
