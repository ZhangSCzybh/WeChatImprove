-[NewSyncService HandleNewSyncPush64:] 0x10546407c v24@0:8@16
0x10546407c: sub      sp, sp, #0xb0
0x105464080: stp      x28, x27, [sp, #0x50]
0x105464084: stp      x26, x25, [sp, #0x60]
0x105464088: stp      x24, x23, [sp, #0x70]
0x10546408c: stp      x22, x21, [sp, #0x80]
0x105464090: stp      x20, x19, [sp, #0x90]
0x105464094: stp      x29, x30, [sp, #0xa0]
0x105464098: add      x29, sp, #0xa0
0x10546409c: mov      x19, x2
0x1054640a0: mov      x21, x0
0x1054640a4: adrp     x8, #0x11f753000
0x1054640a8: mov      w9, #1
0x1054640ac: strb     w9, [x8, #0x480]
0x1054640b0: mov      x0, x2
0x1054640b4: bl       #0x107c27c74 ; _objc_retain
0x1054640b8: adrp     x8, #0x11ed12000
0x1054640bc: ldr      x0, [x8, #0x8a0] ; classref CUtility | Class CUtility
0x1054640c0: adrp     x8, #0x11e9c9000
0x1054640c4: ldr      x1, [x8, #0xf20] ; @selector(genCurrentTimeInMs) | 'genCurrentTimeInMs'
0x1054640c8: bl       #0x107c27c64 ; _objc_msgSend | selector=genCurrentTimeInMs
0x1054640cc: mov      x22, x0
0x1054640d0: adrp     x27, #0x11ed12000
0x1054640d4: ldr      x23, [x27, #0x618] ; classref iConsole | Class iConsole
0x1054640d8: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x1054640dc: ldr      x24, [x8, #0xce8] ; @selector(length) | 'length'
0x1054640e0: mov      x0, x19
0x1054640e4: mov      x1, x24 ; 'length'
0x1054640e8: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x1054640ec: adrp     x8, #0x11e9c9000
0x1054640f0: ldr      x20, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x1054640f4: adrp     x8, #0x11d2f6000
0x1054640f8: add      x8, x8, #0xfd8 ; @'HandleNewSyncPush64 new sync push wxpkg len:%lu'
0x1054640fc: stp      x8, x0, [sp] ; @'HandleNewSyncPush64 new sync push wxpkg len:%lu'
0x105464100: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105464104: add      x3, x3, #0xfaf ; 'Sync'
0x105464108: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x10546410c: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105464110: adrp     x7, #0x11a220000 ; 'p:handleResult:]'
0x105464114: add      x7, x7, #0x7f ; '-[NewSyncService HandleNewSyncPush64:]'
0x105464118: mov      x0, x23 ; Class iConsole
0x10546411c: mov      x1, x20 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105464120: mov      w2, #2
0x105464124: mov      w4, #0
0x105464128: mov      w6, #0x29c
0x10546412c: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105464130: mov      x0, x19
0x105464134: mov      x1, x24 ; 'length'
0x105464138: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x10546413c: cmp      x0, #7
0x105464140: b.hi     #0x10546419c
0x105464144: ldr      x21, [x27, #0x618] ; classref iConsole | Class iConsole
0x105464148: mov      x0, x19
0x10546414c: mov      x1, x24 ; 'length'
0x105464150: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105464154: adrp     x8, #0x11d2f6000
0x105464158: add      x8, x8, #0xff8 ; @'HandleNewSyncPush64 recv len %lu'
0x10546415c: stp      x8, x0, [sp] ; @'HandleNewSyncPush64 recv len %lu'
0x105464160: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105464164: add      x3, x3, #0xfaf ; 'Sync'
0x105464168: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x10546416c: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105464170: adrp     x7, #0x11a220000 ; 'p:handleResult:]'
0x105464174: add      x7, x7, #0x7f ; '-[NewSyncService HandleNewSyncPush64:]'
0x105464178: mov      x0, x21 ; Class iConsole
0x10546417c: mov      x1, x20 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105464180: mov      w2, #4
0x105464184: mov      w4, #0
0x105464188: mov      w6, #0x29e
0x10546418c: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105464190: mov      w0, #0x866
0x105464194: mov      w1, #1
0x105464198: b        #0x1054643d0
0x10546419c: str      wzr, [sp, #0x4c]
0x1054641a0: adrp     x8, #0x11e9d3000 ; @selector(deleteSearchableItemsWithDomainIdentifiers:completionHandler:)
0x1054641a4: ldr      x23, [x8, #0x6f8] ; @selector(getBytes:range:) | 'getBytes:range:'
0x1054641a8: add      x2, sp, #0x4c
0x1054641ac: mov      x0, x19
0x1054641b0: mov      x1, x23 ; 'getBytes:range:'
0x1054641b4: mov      x3, #0
0x1054641b8: mov      w4, #4
0x1054641bc: bl       #0x107c27c64 ; _objc_msgSend | selector=getBytes:range:
0x1054641c0: ldr      w8, [sp, #0x4c]
0x1054641c4: rev      w8, w8
0x1054641c8: stp      wzr, w8, [sp, #0x48]
0x1054641cc: add      x2, sp, #0x48
0x1054641d0: mov      x0, x19
0x1054641d4: mov      x1, x23 ; 'getBytes:range:'
0x1054641d8: mov      w3, #4
0x1054641dc: mov      w4, #4
0x1054641e0: bl       #0x107c27c64 ; _objc_msgSend | selector=getBytes:range:
0x1054641e4: ldp      w8, w9, [sp, #0x48]
0x1054641e8: rev      w8, w8
0x1054641ec: str      w8, [sp, #0x48]
0x1054641f0: ldr      x0, [x27, #0x618] ; classref iConsole | Class iConsole
0x1054641f4: stp      x9, x8, [sp, #8]
0x1054641f8: adrp     x8, #0x11d2f7000
0x1054641fc: add      x8, x8, #0x18 ; @'new sync push64 flag %u data len %u'
0x105464200: str      x8, [sp] ; @'new sync push64 flag %u data len %u'
0x105464204: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105464208: add      x3, x3, #0xfaf ; 'Sync'
0x10546420c: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105464210: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105464214: adrp     x7, #0x11a220000 ; 'p:handleResult:]'
0x105464218: add      x7, x7, #0x7f ; '-[NewSyncService HandleNewSyncPush64:]'
0x10546421c: mov      x1, x20 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105464220: mov      w2, #2
0x105464224: mov      w4, #0
0x105464228: mov      w6, #0x2ab
0x10546422c: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105464230: mov      x0, x19
0x105464234: mov      x1, x24 ; 'length'
0x105464238: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x10546423c: ldr      w8, [sp, #0x48]
0x105464240: add      w8, w8, #8
0x105464244: cmp      x0, x8
0x105464248: b.ne     #0x105464374
0x10546424c: mov      x0, x19
0x105464250: mov      x1, x24 ; 'length'
0x105464254: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105464258: sub      x3, x0, #8
0x10546425c: adrp     x8, #0x11ecad000 ; @selector(sharedApplication)
0x105464260: ldr      x1, [x8, #0x618] ; @selector(subdataWithRange:) | 'subdataWithRange:'
0x105464264: mov      x0, x19
0x105464268: mov      w2, #8
0x10546426c: bl       #0x107c27c64 ; _objc_msgSend | selector=subdataWithRange:
0x105464270: mov      x29, x29
0x105464274: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105464278: mov      x23, x0
0x10546427c: add      x0, sp, #0x20
0x105464280: mov      w1, #0x80
0x105464284: bl       #0x107c0c3b4
0x105464288: str      xzr, [sp, #0x18]
0x10546428c: bl       #0x104d71a2c
0x105464290: bl       #0x104d7226c
0x105464294: cbz      x0, #0x1054643e4
0x105464298: mov      x25, x0
0x10546429c: mov      x0, x23
0x1054642a0: bl       #0x107c27c78 ; _objc_retainAutorelease
0x1054642a4: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x1054642a8: ldr      x1, [x8, #0x1e0] ; @selector(bytes) | 'bytes'
0x1054642ac: bl       #0x107c27c64 ; _objc_msgSend | selector=bytes
0x1054642b0: mov      x26, x0
0x1054642b4: mov      x0, x23
0x1054642b8: mov      x1, x24 ; 'length'
0x1054642bc: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x1054642c0: mov      x2, x0
0x1054642c4: add      x3, sp, #0x20
0x1054642c8: add      x4, sp, #0x1c
0x1054642cc: add      x5, sp, #0x18
0x1054642d0: mov      x0, x25
0x1054642d4: mov      x1, x26
0x1054642d8: bl       #0x107c0c2fc
0x1054642dc: ldr      w9, [sp, #0x18]
0x1054642e0: cbz      w0, #0x10546442c
0x1054642e4: cbnz     w9, #0x10546442c
0x1054642e8: adrp     x8, #0x11ed12000
0x1054642ec: ldr      x24, [x8, #0x6d8] ; _OBJC_CLASS_$_NSData
0x1054642f0: add      x0, sp, #0x20
0x1054642f4: mov      x1, #0
0x1054642f8: bl       #0x107c0c3d0
0x1054642fc: mov      x25, x0
0x105464300: add      x0, sp, #0x20
0x105464304: bl       #0x107c0c3c8
0x105464308: mov      x3, x0
0x10546430c: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105464310: ldr      x1, [x8, #0xb90] ; @selector(dataWithBytes:length:) | 'dataWithBytes:length:'
0x105464314: mov      x0, x24
0x105464318: mov      x2, x25
0x10546431c: bl       #0x107c27c64 ; _objc_msgSend | selector=dataWithBytes:length:
0x105464320: mov      x29, x29
0x105464324: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105464328: mov      x24, x0
0x10546432c: adrp     x8, #0x11ed33000 ; classref VoIPInvitationWindow
0x105464330: ldr      x0, [x8, #0xb50] ; classref NewSyncResponse | Class NewSyncResponse
0x105464334: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x105464338: ldr      x1, [x8, #0x738] ; @selector(parseFromData:) | 'parseFromData:'
0x10546433c: mov      x2, x24
0x105464340: bl       #0x107c27c64 ; _objc_msgSend | selector=parseFromData:
0x105464344: mov      x29, x29
0x105464348: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x10546434c: mov      x25, x0
0x105464350: cbz      x0, #0x10546448c
0x105464354: ldr      w3, [sp, #0x4c]
0x105464358: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x10546435c: ldr      x1, [x8, #0xc48] ; @selector(__handleNewSyncResponse:flag:beginTime:) | '__handleNewSyncResponse:flag:beginTime:'
0x105464360: mov      x0, x21 ; Class iConsole
0x105464364: mov      x2, x25
0x105464368: mov      x4, x22
0x10546436c: bl       #0x107c27c64 ; _objc_msgSend | selector=__handleNewSyncResponse:flag:beginTime:
0x105464370: b        #0x1054644e0
0x105464374: ldr      x21, [x27, #0x618] ; classref iConsole | Class iConsole
0x105464378: mov      x0, x19
0x10546437c: mov      x1, x24
0x105464380: bl       #0x107c27c64 ; _objc_msgSend
0x105464384: ldr      w8, [sp, #0x48]
0x105464388: stp      x0, x8, [sp, #8]
0x10546438c: adrp     x8, #0x11d2f7000
0x105464390: add      x8, x8, #0x38 ; @'HandleNewSyncPush64 recv len %lu, uilen %u'
0x105464394: str      x8, [sp] ; @'HandleNewSyncPush64 recv len %lu, uilen %u'
0x105464398: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x10546439c: add      x3, x3, #0xfaf ; 'Sync'
0x1054643a0: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x1054643a4: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x1054643a8: adrp     x7, #0x11a220000 ; 'p:handleResult:]'
0x1054643ac: add      x7, x7, #0x7f ; '-[NewSyncService HandleNewSyncPush64:]'
0x1054643b0: mov      x0, x21 ; Class iConsole
0x1054643b4: mov      x1, x20 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x1054643b8: mov      w2, #4
0x1054643bc: mov      w4, #0
0x1054643c0: mov      w6, #0x2ad
0x1054643c4: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x1054643c8: mov      w0, #0x866
0x1054643cc: mov      w1, #2
0x1054643d0: mov      w2, #1
0x1054643d4: mov      w3, #0
0x1054643d8: mov      w4, #0
0x1054643dc: bl       #0x1020ea20c
0x1054643e0: b        #0x105464500
0x1054643e4: ldr      x0, [x27, #0x618] ; classref iConsole | Class iConsole
0x1054643e8: adrp     x8, #0x11d2f7000
0x1054643ec: add      x8, x8, #0x58 ; @'HandleNewSyncPush64 account manager not ready'
0x1054643f0: str      x8, [sp] ; @'HandleNewSyncPush64 account manager not ready'
0x1054643f4: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x1054643f8: add      x3, x3, #0xfaf ; 'Sync'
0x1054643fc: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105464400: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105464404: adrp     x7, #0x11a220000 ; 'p:handleResult:]'
0x105464408: add      x7, x7, #0x7f ; '-[NewSyncService HandleNewSyncPush64:]'
0x10546440c: mov      x1, x20 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105464410: mov      w2, #4
0x105464414: mov      w4, #0
0x105464418: mov      w6, #0x2ba
0x10546441c: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105464420: mov      w0, #0x866
0x105464424: mov      w1, #5
0x105464428: b        #0x105464478
0x10546442c: ldr      x8, [x27, #0x618] ; classref iConsole | Class iConsole
0x105464430: stp      x0, x9, [sp, #8]
0x105464434: adrp     x9, #0x11d2f7000
0x105464438: add      x9, x9, #0x78 ; @'HandleNewSyncPush64 decode fail ok:%d ret:%d'
0x10546443c: str      x9, [sp] ; @'HandleNewSyncPush64 decode fail ok:%d ret:%d'
0x105464440: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105464444: add      x3, x3, #0xfaf ; 'Sync'
0x105464448: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x10546444c: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105464450: adrp     x7, #0x11a220000 ; 'p:handleResult:]'
0x105464454: add      x7, x7, #0x7f ; '-[NewSyncService HandleNewSyncPush64:]'
0x105464458: mov      x0, x8 ; Class iConsole
0x10546445c: mov      x1, x20 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105464460: mov      w2, #4
0x105464464: mov      w4, #0
0x105464468: mov      w6, #0x2c0
0x10546446c: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105464470: mov      w0, #0x866
0x105464474: mov      w1, #3
0x105464478: mov      w2, #1
0x10546447c: mov      w3, #0
0x105464480: mov      w4, #0
0x105464484: bl       #0x1020ea20c
0x105464488: b        #0x1054644f0
0x10546448c: ldr      x0, [x27, #0x618] ; classref iConsole | Class iConsole
0x105464490: adrp     x8, #0x11d2f7000
0x105464494: add      x8, x8, #0x98 ; @'HandleNewSyncPush64 parse NewSyncResponse fail'
0x105464498: str      x8, [sp] ; @'HandleNewSyncPush64 parse NewSyncResponse fail'
0x10546449c: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x1054644a0: add      x3, x3, #0xfaf ; 'Sync'
0x1054644a4: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x1054644a8: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x1054644ac: adrp     x7, #0x11a220000 ; 'p:handleResult:]'
0x1054644b0: add      x7, x7, #0x7f ; '-[NewSyncService HandleNewSyncPush64:]'
0x1054644b4: mov      x1, x20 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x1054644b8: mov      w2, #4
0x1054644bc: mov      w4, #0
0x1054644c0: mov      w6, #0x2c7
0x1054644c4: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x1054644c8: mov      w0, #0x866
0x1054644cc: mov      w1, #4
0x1054644d0: mov      w2, #1
0x1054644d4: mov      w3, #0
0x1054644d8: mov      w4, #0
0x1054644dc: bl       #0x1020ea20c
0x1054644e0: mov      x0, x25
0x1054644e4: bl       #0x107c27c70 ; _objc_release
0x1054644e8: mov      x0, x24
0x1054644ec: bl       #0x107c27c70 ; _objc_release
0x1054644f0: add      x0, sp, #0x20
0x1054644f4: bl       #0x107c0c3b8
0x1054644f8: mov      x0, x23
0x1054644fc: bl       #0x107c27c70 ; _objc_release
0x105464500: mov      x0, x19
0x105464504: bl       #0x107c27c70 ; _objc_release
0x105464508: ldp      x29, x30, [sp, #0xa0]
0x10546450c: ldp      x20, x19, [sp, #0x90] ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105464510: ldp      x22, x21, [sp, #0x80]
0x105464514: ldp      x24, x23, [sp, #0x70]
0x105464518: ldp      x26, x25, [sp, #0x60]
0x10546451c: ldp      x28, x27, [sp, #0x50]
0x105464520: add      sp, sp, #0xb0
0x105464524: ret      
