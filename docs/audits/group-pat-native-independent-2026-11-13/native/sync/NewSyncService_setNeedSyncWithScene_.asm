-[NewSyncService setNeedSyncWithScene:] 0x105463448 v20@0:8i16
0x105463448: sub      sp, sp, #0x60
0x10546344c: stp      x24, x23, [sp, #0x20]
0x105463450: stp      x22, x21, [sp, #0x30]
0x105463454: stp      x20, x19, [sp, #0x40]
0x105463458: stp      x29, x30, [sp, #0x50]
0x10546345c: add      x29, sp, #0x50
0x105463460: mov      x20, x2
0x105463464: mov      x19, x0
0x105463468: adrp     x8, #0x11f753000
0x10546346c: mov      w23, #1
0x105463470: strb     w23, [x8, #0x47d]
0x105463474: adrp     x8, #0x11ed12000
0x105463478: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x10546347c: adrp     x8, #0x11e9c9000
0x105463480: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105463484: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105463488: mov      x29, x29
0x10546348c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105463490: mov      x21, x0
0x105463494: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x105463498: ldr      x1, [x8, #0x310] ; @selector(uin64) | 'uin64'
0x10546349c: bl       #0x107c27c64 ; _objc_msgSend | selector=uin64
0x1054634a0: mov      x22, x0
0x1054634a4: mov      x0, x21
0x1054634a8: bl       #0x107c27c70 ; _objc_release
0x1054634ac: cbz      x22, #0x105463540
0x1054634b0: cmp      w20, #1
0x1054634b4: mov      w8, #7
0x1054634b8: csel     w20, w8, w20, lt
0x1054634bc: adrp     x8, #0x11ed12000
0x1054634c0: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x1054634c4: adrp     x8, #0x11edca000
0x1054634c8: ldrsw    x21, [x8, #0x8d4] ; ivar_offset NewSyncService.m_bNeedSync=0x57
0x1054634cc: ldrb     w8, [x19, x21]
0x1054634d0: adrp     x9, #0x11e9c9000
0x1054634d4: ldr      x1, [x9, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x1054634d8: stp      x8, x20, [sp, #8]
0x1054634dc: adrp     x9, #0x11d2f6000
0x1054634e0: add      x9, x9, #0xeb8 ; @'set need to sync: before %d, sync scene %d'
0x1054634e4: str      x9, [sp] ; @'set need to sync: before %d, sync scene %d'
0x1054634e8: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x1054634ec: add      x3, x3, #0xfaf ; 'Sync'
0x1054634f0: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x1054634f4: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x1054634f8: adrp     x7, #0x11a21f000 ; 'llu,%llu'
0x1054634fc: add      x7, x7, #0xf1d ; '-[NewSyncService setNeedSyncWithScene:]'
0x105463500: mov      w2, #2
0x105463504: mov      w4, #0
0x105463508: mov      w6, #0x20b
0x10546350c: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105463510: mov      x0, x19
0x105463514: bl       #0x107c27c74 ; _objc_retain
0x105463518: bl       #0x107c27ca4 ; _objc_sync_enter
0x10546351c: adrp     x8, #0x11edca000
0x105463520: ldrsw    x8, [x8, #0x8f8] ; ivar_offset NewSyncService.m_uiSyncScene=0x10
0x105463524: str      w20, [x19, x8]
0x105463528: mov      x0, x19
0x10546352c: bl       #0x107c27ca8 ; _objc_sync_exit
0x105463530: mov      x0, x19
0x105463534: bl       #0x107c27c70 ; _objc_release
0x105463538: strb     w23, [x19, x21]
0x10546353c: b        #0x105463584
0x105463540: adrp     x8, #0x11ed12000
0x105463544: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105463548: adrp     x8, #0x11e9c9000
0x10546354c: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105463550: adrp     x8, #0x11d2f6000
0x105463554: add      x8, x8, #0xe98 ; @'Skip need sync due to not logged in， scene %d'
0x105463558: stp      x8, x20, [sp] ; @'Skip need sync due to not logged in， scene %d'
0x10546355c: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105463560: add      x3, x3, #0xfaf ; 'Sync'
0x105463564: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105463568: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x10546356c: adrp     x7, #0x11a21f000 ; 'llu,%llu'
0x105463570: add      x7, x7, #0xf1d ; '-[NewSyncService setNeedSyncWithScene:]'
0x105463574: mov      w2, #3
0x105463578: mov      w4, #0
0x10546357c: mov      w6, #0x205
0x105463580: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105463584: ldp      x29, x30, [sp, #0x50]
0x105463588: ldp      x20, x19, [sp, #0x40]
0x10546358c: ldp      x22, x21, [sp, #0x30]
0x105463590: ldp      x24, x23, [sp, #0x20]
0x105463594: add      sp, sp, #0x60
0x105463598: ret      
