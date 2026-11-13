-[NewSyncService HandleNewSyncPush:] 0x105464528 v24@0:8@16
0x105464528: sub      sp, sp, #0x80
0x10546452c: stp      x28, x27, [sp, #0x20]
0x105464530: stp      x26, x25, [sp, #0x30]
0x105464534: stp      x24, x23, [sp, #0x40]
0x105464538: stp      x22, x21, [sp, #0x50]
0x10546453c: stp      x20, x19, [sp, #0x60]
0x105464540: stp      x29, x30, [sp, #0x70]
0x105464544: add      x29, sp, #0x70
0x105464548: mov      x19, x2
0x10546454c: mov      x21, x0
0x105464550: adrp     x8, #0x11f753000
0x105464554: mov      w9, #1
0x105464558: strb     w9, [x8, #0x481]
0x10546455c: mov      x0, x2
0x105464560: bl       #0x107c27c74 ; _objc_retain
0x105464564: adrp     x26, #0x11ed12000
0x105464568: ldr      x0, [x26, #0x8a0] ; classref CUtility | Class CUtility
0x10546456c: adrp     x8, #0x11e9c9000
0x105464570: ldr      x1, [x8, #0xf20] ; @selector(genCurrentTimeInMs) | 'genCurrentTimeInMs'
0x105464574: bl       #0x107c27c64 ; _objc_msgSend | selector=genCurrentTimeInMs
0x105464578: mov      x22, x0
0x10546457c: adrp     x28, #0x11ed12000
0x105464580: ldr      x24, [x28, #0x618] ; classref iConsole | Class iConsole
0x105464584: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105464588: ldr      x23, [x8, #0xce8] ; @selector(length) | 'length'
0x10546458c: mov      x0, x19
0x105464590: mov      x1, x23 ; 'length'
0x105464594: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105464598: adrp     x8, #0x11e9c9000
0x10546459c: ldr      x20, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x1054645a0: adrp     x8, #0x11d2f7000
0x1054645a4: add      x8, x8, #0xb8 ; @'news sync push %lu'
0x1054645a8: stp      x8, x0, [sp] ; @'news sync push %lu'
0x1054645ac: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x1054645b0: add      x3, x3, #0xfaf ; 'Sync'
0x1054645b4: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x1054645b8: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x1054645bc: adrp     x7, #0x11a220000 ; 'p:handleResult:]'
0x1054645c0: add      x7, x7, #0x1d0 ; '-[NewSyncService HandleNewSyncPush:]'
0x1054645c4: mov      x0, x24 ; Class iConsole
0x1054645c8: mov      x1, x20 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x1054645cc: mov      w2, #2
0x1054645d0: mov      w4, #0
0x1054645d4: mov      w6, #0x2d1
0x1054645d8: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x1054645dc: mov      x0, x19
0x1054645e0: mov      x1, x23 ; 'length'
0x1054645e4: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x1054645e8: cmp      x0, #7
0x1054645ec: b.hi     #0x105464660
0x1054645f0: ldr      x21, [x28, #0x618] ; classref iConsole | Class iConsole
0x1054645f4: mov      x0, x19
0x1054645f8: mov      x1, x23 ; 'length'
0x1054645fc: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105464600: adrp     x8, #0x11d2f7000
0x105464604: add      x8, x8, #0xd8 ; @'HandleNewSyncPushNew recv len %lu'
0x105464608: stp      x8, x0, [sp] ; @'HandleNewSyncPushNew recv len %lu'
0x10546460c: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105464610: add      x3, x3, #0xfaf ; 'Sync'
0x105464614: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105464618: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x10546461c: adrp     x7, #0x11a220000 ; 'p:handleResult:]'
0x105464620: add      x7, x7, #0x1d0 ; '-[NewSyncService HandleNewSyncPush:]'
0x105464624: mov      x0, x21 ; Class iConsole
0x105464628: mov      x1, x20 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x10546462c: mov      w2, #4
0x105464630: mov      w4, #0
0x105464634: mov      w6, #0x2d3
0x105464638: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x10546463c: mov      w0, #0x90
0x105464640: mov      w1, #9
0x105464644: mov      w2, #1
0x105464648: mov      w3, #0
0x10546464c: mov      w4, #0
0x105464650: bl       #0x1020ea20c
0x105464654: adrp     x1, #0x11d2f7000
0x105464658: add      x1, x1, #0xf8 ; @'9,0'
0x10546465c: b        #0x10546488c
0x105464660: str      wzr, [sp, #0x1c]
0x105464664: adrp     x8, #0x11e9d3000 ; @selector(deleteSearchableItemsWithDomainIdentifiers:completionHandler:)
0x105464668: ldr      x24, [x8, #0x6f8] ; @selector(getBytes:range:) | 'getBytes:range:'
0x10546466c: add      x2, sp, #0x1c
0x105464670: mov      x0, x19
0x105464674: mov      x1, x24 ; 'getBytes:range:'
0x105464678: mov      x3, #0
0x10546467c: mov      w4, #4
0x105464680: bl       #0x107c27c64 ; _objc_msgSend | selector=getBytes:range:
0x105464684: ldr      w8, [sp, #0x1c]
0x105464688: rev      w8, w8
0x10546468c: stp      wzr, w8, [sp, #0x18]
0x105464690: add      x2, sp, #0x18
0x105464694: mov      x0, x19
0x105464698: mov      x1, x24 ; 'getBytes:range:'
0x10546469c: mov      w3, #4
0x1054646a0: mov      w4, #4
0x1054646a4: bl       #0x107c27c64 ; _objc_msgSend | selector=getBytes:range:
0x1054646a8: ldp      w8, w9, [sp, #0x18]
0x1054646ac: rev      w8, w8
0x1054646b0: str      w8, [sp, #0x18]
0x1054646b4: ldr      x0, [x28, #0x618] ; classref iConsole | Class iConsole
0x1054646b8: stp      x9, x8, [sp, #8]
0x1054646bc: adrp     x8, #0x11d2f7000
0x1054646c0: add      x8, x8, #0x118 ; @'new sync push flag %u data len %u'
0x1054646c4: str      x8, [sp] ; @'new sync push flag %u data len %u'
0x1054646c8: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x1054646cc: add      x3, x3, #0xfaf ; 'Sync'
0x1054646d0: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x1054646d4: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x1054646d8: adrp     x7, #0x11a220000 ; 'p:handleResult:]'
0x1054646dc: add      x7, x7, #0x1d0 ; '-[NewSyncService HandleNewSyncPush:]'
0x1054646e0: mov      x1, x20 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x1054646e4: mov      w2, #2
0x1054646e8: mov      w4, #0
0x1054646ec: mov      w6, #0x2e0
0x1054646f0: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x1054646f4: mov      x0, x19
0x1054646f8: mov      x1, x23 ; 'length'
0x1054646fc: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105464700: cmp      x0, #9
0x105464704: b.lo     #0x105464818
0x105464708: mov      x0, x19
0x10546470c: mov      x1, x23 ; 'length'
0x105464710: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105464714: ldr      w8, [sp, #0x18]
0x105464718: add      w8, w8, #8
0x10546471c: cmp      x0, x8
0x105464720: b.ne     #0x105464818
0x105464724: mov      x0, x19
0x105464728: mov      x1, x23 ; 'length'
0x10546472c: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105464730: sub      x3, x0, #8
0x105464734: adrp     x8, #0x11ecad000 ; @selector(sharedApplication)
0x105464738: ldr      x1, [x8, #0x618] ; @selector(subdataWithRange:) | 'subdataWithRange:'
0x10546473c: mov      x0, x19
0x105464740: mov      w2, #8
0x105464744: bl       #0x107c27c64 ; _objc_msgSend | selector=subdataWithRange:
0x105464748: mov      x29, x29
0x10546474c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105464750: mov      x24, x0
0x105464754: adrp     x8, #0x11ed12000
0x105464758: ldr      x0, [x8, #0x910] ; _OBJC_CLASS_$_NSMutableData
0x10546475c: bl       #0x107c27c0c ; _objc_alloc_init
0x105464760: mov      x25, x0
0x105464764: ldr      x0, [x26, #0x8a0] ; classref CUtility | Class CUtility
0x105464768: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x10546476c: ldr      x1, [x8, #0xc50] ; @selector(DecodePack:Output:) | 'DecodePack:Output:'
0x105464770: mov      x2, x24
0x105464774: mov      x3, x25
0x105464778: bl       #0x107c27c64 ; _objc_msgSend | selector=DecodePack:Output:
0x10546477c: mov      x26, x0
0x105464780: ldr      x27, [x28, #0x618] ; classref iConsole | Class iConsole
0x105464784: mov      x0, x25
0x105464788: mov      x1, x23 ; 'length'
0x10546478c: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105464790: stp      x26, x0, [sp, #8]
0x105464794: adrp     x8, #0x11d2f7000
0x105464798: add      x8, x8, #0x178 ; @'new sync push decode ret %d  data len %lu'
0x10546479c: str      x8, [sp] ; @'new sync push decode ret %d  data len %lu'
0x1054647a0: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x1054647a4: add      x3, x3, #0xfaf ; 'Sync'
0x1054647a8: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x1054647ac: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x1054647b0: adrp     x7, #0x11a220000 ; 'p:handleResult:]'
0x1054647b4: add      x7, x7, #0x1d0 ; '-[NewSyncService HandleNewSyncPush:]'
0x1054647b8: mov      x0, x27 ; Class iConsole
0x1054647bc: mov      x1, x20 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x1054647c0: mov      w2, #2
0x1054647c4: mov      w4, #0
0x1054647c8: mov      w6, #0x2ea
0x1054647cc: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x1054647d0: adrp     x8, #0x11ed33000 ; classref VoIPInvitationWindow
0x1054647d4: ldr      x0, [x8, #0xb50] ; classref NewSyncResponse | Class NewSyncResponse
0x1054647d8: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x1054647dc: ldr      x1, [x8, #0x738] ; @selector(parseFromData:) | 'parseFromData:'
0x1054647e0: mov      x2, x25
0x1054647e4: bl       #0x107c27c64 ; _objc_msgSend | selector=parseFromData:
0x1054647e8: mov      x29, x29
0x1054647ec: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054647f0: mov      x23, x0
0x1054647f4: cbz      x0, #0x1054648c4
0x1054647f8: ldr      w3, [sp, #0x1c]
0x1054647fc: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105464800: ldr      x1, [x8, #0xc48] ; @selector(__handleNewSyncResponse:flag:beginTime:) | '__handleNewSyncResponse:flag:beginTime:'
0x105464804: mov      x0, x21 ; Class iConsole
0x105464808: mov      x2, x23
0x10546480c: mov      x4, x22
0x105464810: bl       #0x107c27c64 ; _objc_msgSend | selector=__handleNewSyncResponse:flag:beginTime:
0x105464814: b        #0x10546492c
0x105464818: ldr      x21, [x28, #0x618] ; classref iConsole | Class iConsole
0x10546481c: mov      x0, x19
0x105464820: mov      x1, x23
0x105464824: bl       #0x107c27c64 ; _objc_msgSend
0x105464828: ldr      w8, [sp, #0x18]
0x10546482c: stp      x0, x8, [sp, #8]
0x105464830: adrp     x8, #0x11d2f7000
0x105464834: add      x8, x8, #0x138 ; @'HandleNewSyncPushNew recv len %lu, uilen %u'
0x105464838: str      x8, [sp] ; @'HandleNewSyncPushNew recv len %lu, uilen %u'
0x10546483c: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105464840: add      x3, x3, #0xfaf ; 'Sync'
0x105464844: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105464848: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x10546484c: adrp     x7, #0x11a220000 ; 'p:handleResult:]'
0x105464850: add      x7, x7, #0x1d0 ; '-[NewSyncService HandleNewSyncPush:]'
0x105464854: mov      x0, x21 ; Class iConsole
0x105464858: mov      x1, x20 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x10546485c: mov      w2, #4
0x105464860: mov      w4, #0
0x105464864: mov      w6, #0x2e2
0x105464868: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x10546486c: mov      w0, #0x90
0x105464870: mov      w1, #0xa
0x105464874: mov      w2, #1
0x105464878: mov      w3, #0
0x10546487c: mov      w4, #0
0x105464880: bl       #0x1020ea20c
0x105464884: adrp     x1, #0x11d2f7000
0x105464888: add      x1, x1, #0x158 ; @'10,0'
0x10546488c: mov      w0, #0x8ab9
0x105464890: mov      w2, #0
0x105464894: mov      w3, #0
0x105464898: bl       #0x10241a0cc
0x10546489c: mov      x0, x19
0x1054648a0: bl       #0x107c27c70 ; _objc_release
0x1054648a4: ldp      x29, x30, [sp, #0x70]
0x1054648a8: ldp      x20, x19, [sp, #0x60] ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x1054648ac: ldp      x22, x21, [sp, #0x50]
0x1054648b0: ldp      x24, x23, [sp, #0x40]
0x1054648b4: ldp      x26, x25, [sp, #0x30]
0x1054648b8: ldp      x28, x27, [sp, #0x20]
0x1054648bc: add      sp, sp, #0x80
0x1054648c0: ret      
0x1054648c4: ldr      x0, [x28, #0x618] ; classref iConsole | Class iConsole
0x1054648c8: adrp     x8, #0x11d2f7000
0x1054648cc: add      x8, x8, #0x198 ; @'NewSyncResponse parseFromData fail'
0x1054648d0: str      x8, [sp] ; @'NewSyncResponse parseFromData fail'
0x1054648d4: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x1054648d8: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x1054648dc: adrp     x7, #0x11a220000 ; 'p:handleResult:]'
0x1054648e0: add      x7, x7, #0x1d0 ; '-[NewSyncService HandleNewSyncPush:]'
0x1054648e4: mov      x1, x20 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x1054648e8: mov      w2, #4
0x1054648ec: mov      x3, #0
0x1054648f0: mov      w4, #0
0x1054648f4: mov      w6, #0x2ee
0x1054648f8: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x1054648fc: mov      w0, #0x90
0x105464900: mov      w1, #0xb
0x105464904: mov      w2, #1
0x105464908: mov      w3, #0
0x10546490c: mov      w4, #0
0x105464910: bl       #0x1020ea20c
0x105464914: adrp     x1, #0x11d2f7000
0x105464918: add      x1, x1, #0x1b8 ; @'11,0'
0x10546491c: mov      w0, #0x8ab9
0x105464920: mov      w2, #0
0x105464924: mov      w3, #0
0x105464928: bl       #0x10241a0cc
0x10546492c: mov      x0, x23
0x105464930: bl       #0x107c27c70 ; _objc_release
0x105464934: mov      x0, x25
0x105464938: bl       #0x107c27c70 ; _objc_release
0x10546493c: mov      x0, x24
0x105464940: bl       #0x107c27c70 ; _objc_release
0x105464944: b        #0x10546489c
