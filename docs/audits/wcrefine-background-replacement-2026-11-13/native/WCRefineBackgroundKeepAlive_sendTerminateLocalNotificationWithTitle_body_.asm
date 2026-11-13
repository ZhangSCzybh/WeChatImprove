+[WCRefineBackgroundKeepAlive sendTerminateLocalNotificationWithTitle:body:] 0xeca488 v32@0:8@16@24
0xeca488: sub      sp, sp, #0x130
0xeca48c: stp      x28, x27, [sp, #0x110]
0xeca490: stp      x29, x30, [sp, #0x120]
0xeca494: add      x29, sp, #0x120
0xeca498: mov      x8, x1
0xeca49c: mov      x1, x2
0xeca4a0: stur     x3, [x29, #-0x80]
0xeca4a4: adrp     x9, #0x25f4000
0xeca4a8: ldr      x9, [x9, #0x690] ; ___stack_chk_guard
0xeca4ac: ldr      x9, [x9]
0xeca4b0: stur     x9, [x29, #-0x18]
0xeca4b4: stur     x0, [x29, #-0x40]
0xeca4b8: stur     x8, [x29, #-0x48]
0xeca4bc: sub      x0, x29, #0x50
0xeca4c0: stur     xzr, [x29, #-0x50]
0xeca4c4: bl       #0x2289118 ; _objc_storeStrong
0xeca4c8: ldur     x1, [x29, #-0x80]
0xeca4cc: sub      x0, x29, #0x58
0xeca4d0: stur     xzr, [x29, #-0x58]
0xeca4d4: bl       #0x2289118 ; _objc_storeStrong
0xeca4d8: mov      w8, #1
0xeca4dc: tbz      w8, #0, #0xeca854
0xeca4e0: b        #0xeca4e4
0xeca4e4: adrp     x8, #0x2752000
0xeca4e8: ldr      x0, [x8, #0x498]
0xeca4ec: adrp     x8, #0x272b000 ; @selector(initHeaderLogicAndHeaderView)
0xeca4f0: ldr      x1, [x8, #0x328] ; @selector(currentNotificationCenter) | 'currentNotificationCenter'
0xeca4f4: adrp     x8, #0x25f4000
0xeca4f8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca4fc: blr      x8
0xeca500: mov      x29, x29
0xeca504: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xeca508: stur     x0, [x29, #-0x60]
0xeca50c: adrp     x8, #0x2752000
0xeca510: ldr      x0, [x8, #0x330]
0xeca514: bl       #0x2288f5c ; _objc_alloc_init
0xeca518: stur     x0, [x29, #-0x68]
0xeca51c: ldur     x0, [x29, #-0x50]
0xeca520: adrp     x8, #0x271f000
0xeca524: ldr      x1, [x8, #0x658] ; @selector(length) | 'length'
0xeca528: adrp     x8, #0x25f4000
0xeca52c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca530: blr      x8
0xeca534: cbz      x0, #0xeca548
0xeca538: b        #0xeca53c
0xeca53c: ldur     x8, [x29, #-0x50]
0xeca540: stur     x8, [x29, #-0x88]
0xeca544: b        #0xeca558
0xeca548: adrp     x8, #0x2645000
0xeca54c: add      x8, x8, #0xbb0 ; @'后台保活即将失效'
0xeca550: stur     x8, [x29, #-0x88] ; @'后台保活即将失效'
0xeca554: b        #0xeca558
0xeca558: ldur     x2, [x29, #-0x88]
0xeca55c: ldur     x0, [x29, #-0x68]
0xeca560: adrp     x8, #0x271f000
0xeca564: ldr      x1, [x8, #0x8a8] ; @selector(setTitle:) | 'setTitle:'
0xeca568: adrp     x8, #0x25f4000
0xeca56c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca570: blr      x8
0xeca574: ldur     x8, [x29, #-0x58]
0xeca578: str      x8, [sp, #0x90]
0xeca57c: cbz      x8, #0xeca590
0xeca580: b        #0xeca584
0xeca584: ldr      x8, [sp, #0x90]
0xeca588: str      x8, [sp, #0x88]
0xeca58c: b        #0xeca5a0
0xeca590: adrp     x8, #0x260b000
0xeca594: add      x8, x8, #0x930 ; @''
0xeca598: str      x8, [sp, #0x88] ; @''
0xeca59c: b        #0xeca5a0
0xeca5a0: ldr      x2, [sp, #0x88]
0xeca5a4: sub      x8, x29, #0x68 ; @''
0xeca5a8: str      x8, [sp, #0x70] ; @''
0xeca5ac: ldur     x0, [x29, #-0x68]
0xeca5b0: adrp     x8, #0x2729000 ; @selector(setM_uGreenLabelType:)
0xeca5b4: ldr      x1, [x8, #0x3e0] ; @selector(setBody:) | 'setBody:'
0xeca5b8: adrp     x8, #0x25f4000
0xeca5bc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca5c0: blr      x8
0xeca5c4: adrp     x8, #0x2752000
0xeca5c8: ldr      x0, [x8, #0x4a0]
0xeca5cc: adrp     x8, #0x272b000 ; @selector(initHeaderLogicAndHeaderView)
0xeca5d0: ldr      x1, [x8, #0x340] ; @selector(defaultSound) | 'defaultSound'
0xeca5d4: adrp     x8, #0x25f4000
0xeca5d8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca5dc: blr      x8
0xeca5e0: mov      x29, x29
0xeca5e4: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xeca5e8: mov      x2, x0
0xeca5ec: str      x2, [sp, #0x10]
0xeca5f0: ldur     x0, [x29, #-0x68]
0xeca5f4: adrp     x8, #0x2729000 ; @selector(setM_uGreenLabelType:)
0xeca5f8: ldr      x1, [x8, #0x3e8] ; @selector(setSound:) | 'setSound:'
0xeca5fc: adrp     x8, #0x25f4000
0xeca600: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca604: blr      x8
0xeca608: ldr      x0, [sp, #0x10]
0xeca60c: adrp     x8, #0x25f4000
0xeca610: ldr      x8, [x8, #0x650] ; _objc_release
0xeca614: blr      x8
0xeca618: sub      x3, x29, #0x28
0xeca61c: adrp     x8, #0x2628000
0xeca620: add      x8, x8, #0x50 ; @'wcr'
0xeca624: stur     x8, [x29, #-0x28] ; @'wcr'
0xeca628: sub      x2, x29, #0x20
0xeca62c: adrp     x8, #0x2645000
0xeca630: add      x8, x8, #0xcf0 ; @'background_drop_ended'
0xeca634: stur     x8, [x29, #-0x20] ; @'background_drop_ended'
0xeca638: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xeca63c: ldr      x0, [x8, #0xba0]
0xeca640: adrp     x8, #0x271f000
0xeca644: ldr      x1, [x8, #0xf10] ; @selector(dictionaryWithObjects:forKeys:count:) | 'dictionaryWithObjects:forKeys:count:'
0xeca648: adrp     x8, #0x25f4000
0xeca64c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca650: mov      x4, #1
0xeca654: str      x4, [sp, #0x40]
0xeca658: blr      x8
0xeca65c: mov      x29, x29
0xeca660: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xeca664: mov      x2, x0
0xeca668: str      x2, [sp, #0x18]
0xeca66c: ldur     x0, [x29, #-0x68]
0xeca670: adrp     x8, #0x2724000 ; @selector(fileTransferTaskCompleted:)
0xeca674: ldr      x1, [x8, #0x330] ; @selector(setUserInfo:) | 'setUserInfo:'
0xeca678: adrp     x8, #0x25f4000
0xeca67c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca680: blr      x8
0xeca684: ldr      x0, [sp, #0x18]
0xeca688: adrp     x8, #0x25f4000
0xeca68c: ldr      x8, [x8, #0x650] ; _objc_release
0xeca690: blr      x8
0xeca694: ldr      x3, [sp, #0x40]
0xeca698: sub      x8, x29, #0x60
0xeca69c: str      x8, [sp, #0x78]
0xeca6a0: ldur     x8, [x29, #-0x60]
0xeca6a4: str      x8, [sp, #0x20]
0xeca6a8: sub      x2, x29, #0x30
0xeca6ac: adrp     x8, #0x2645000
0xeca6b0: add      x8, x8, #0xd10 ; @'wcr_background_drop_ended'
0xeca6b4: str      x8, [sp, #0x58] ; @'wcr_background_drop_ended'
0xeca6b8: stur     x8, [x29, #-0x30] ; @'wcr_background_drop_ended'
0xeca6bc: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xeca6c0: str      x8, [sp, #0x30] ; @selector(setWCRefineSearchEntryThemeBox:)
0xeca6c4: ldr      x0, [x8, #0xaf0]
0xeca6c8: adrp     x8, #0x271f000
0xeca6cc: str      x8, [sp, #0x38]
0xeca6d0: ldr      x1, [x8, #0x628] ; @selector(arrayWithObjects:count:) | 'arrayWithObjects:count:'
0xeca6d4: adrp     x8, #0x25f4000
0xeca6d8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca6dc: blr      x8
0xeca6e0: mov      x29, x29
0xeca6e4: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xeca6e8: mov      x2, x0
0xeca6ec: ldr      x0, [sp, #0x20]
0xeca6f0: str      x2, [sp, #0x28]
0xeca6f4: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xeca6f8: ldr      x1, [x8, #0x278] ; @selector(removeDeliveredNotificationsWithIdentifiers:) | 'removeDeliveredNotificationsWithIdentifiers:'
0xeca6fc: adrp     x8, #0x25f4000
0xeca700: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca704: blr      x8
0xeca708: ldr      x0, [sp, #0x28]
0xeca70c: adrp     x8, #0x25f4000
0xeca710: ldr      x8, [x8, #0x650] ; _objc_release
0xeca714: blr      x8
0xeca718: ldr      x9, [sp, #0x30]
0xeca71c: ldr      x8, [sp, #0x38]
0xeca720: ldr      x3, [sp, #0x40]
0xeca724: ldr      x10, [sp, #0x58]
0xeca728: ldur     x11, [x29, #-0x60]
0xeca72c: str      x11, [sp, #0x48]
0xeca730: sub      x2, x29, #0x38
0xeca734: stur     x10, [x29, #-0x38]
0xeca738: ldr      x0, [x9, #0xaf0]
0xeca73c: ldr      x1, [x8, #0x628]
0xeca740: adrp     x8, #0x25f4000
0xeca744: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca748: blr      x8
0xeca74c: mov      x29, x29
0xeca750: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xeca754: mov      x2, x0
0xeca758: ldr      x0, [sp, #0x48]
0xeca75c: str      x2, [sp, #0x50]
0xeca760: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xeca764: ldr      x1, [x8, #0x280] ; @selector(removePendingNotificationRequestsWithIdentifiers:) | 'removePendingNotificationRequestsWithIdentifiers:'
0xeca768: adrp     x8, #0x25f4000
0xeca76c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca770: blr      x8
0xeca774: ldr      x0, [sp, #0x50]
0xeca778: adrp     x8, #0x25f4000
0xeca77c: ldr      x8, [x8, #0x650] ; _objc_release
0xeca780: blr      x8
0xeca784: adrp     x8, #0x2752000
0xeca788: ldr      x0, [x8, #0x648]
0xeca78c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xeca790: ldr      x1, [x8, #0x288] ; @selector(triggerWithTimeInterval:repeats:) | 'triggerWithTimeInterval:repeats:'
0xeca794: adrp     x8, #0x25f4000
0xeca798: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca79c: fmov     d0, #1.00000000
0xeca7a0: mov      w9, #0
0xeca7a4: and      w2, w9, #1
0xeca7a8: blr      x8
0xeca7ac: mov      x29, x29
0xeca7b0: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xeca7b4: ldr      x2, [sp, #0x58]
0xeca7b8: sub      x8, x29, #0x70
0xeca7bc: str      x8, [sp, #0x68]
0xeca7c0: stur     x0, [x29, #-0x70]
0xeca7c4: adrp     x8, #0x2752000
0xeca7c8: ldr      x0, [x8, #0x338]
0xeca7cc: ldur     x3, [x29, #-0x68]
0xeca7d0: ldur     x4, [x29, #-0x70]
0xeca7d4: adrp     x8, #0x2729000 ; @selector(setM_uGreenLabelType:)
0xeca7d8: ldr      x1, [x8, #0x3f8] ; @selector(requestWithIdentifier:content:trigger:) | 'requestWithIdentifier:content:trigger:'
0xeca7dc: adrp     x8, #0x25f4000
0xeca7e0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca7e4: blr      x8
0xeca7e8: mov      x29, x29
0xeca7ec: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xeca7f0: sub      x8, x29, #0x78
0xeca7f4: str      x8, [sp, #0x60]
0xeca7f8: stur     x0, [x29, #-0x78]
0xeca7fc: ldur     x0, [x29, #-0x60]
0xeca800: ldur     x2, [x29, #-0x78]
0xeca804: adrp     x8, #0x2729000 ; @selector(setM_uGreenLabelType:)
0xeca808: ldr      x1, [x8, #0x3b0] ; @selector(addNotificationRequest:withCompletionHandler:) | 'addNotificationRequest:withCompletionHandler:'
0xeca80c: adrp     x8, #0x25f4000
0xeca810: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca814: mov      x3, #0
0xeca818: str      x3, [sp, #0x80]
0xeca81c: blr      x8
0xeca820: ldr      x0, [sp, #0x60]
0xeca824: ldr      x1, [sp, #0x80]
0xeca828: bl       #0x2289118 ; _objc_storeStrong
0xeca82c: ldr      x0, [sp, #0x68]
0xeca830: ldr      x1, [sp, #0x80]
0xeca834: bl       #0x2289118 ; _objc_storeStrong
0xeca838: ldr      x0, [sp, #0x70]
0xeca83c: ldr      x1, [sp, #0x80]
0xeca840: bl       #0x2289118 ; _objc_storeStrong
0xeca844: ldr      x0, [sp, #0x78]
0xeca848: ldr      x1, [sp, #0x80]
0xeca84c: bl       #0x2289118 ; _objc_storeStrong
0xeca850: b        #0xeca854
0xeca854: sub      x0, x29, #0x58
0xeca858: mov      x1, #0
0xeca85c: str      x1, [sp, #8]
0xeca860: bl       #0x2289118 ; _objc_storeStrong
0xeca864: ldr      x1, [sp, #8]
0xeca868: sub      x0, x29, #0x50
0xeca86c: bl       #0x2289118 ; _objc_storeStrong
0xeca870: ldur     x9, [x29, #-0x18]
0xeca874: adrp     x8, #0x25f4000
0xeca878: ldr      x8, [x8, #0x690] ; ___stack_chk_guard
0xeca87c: ldr      x8, [x8]
0xeca880: subs     x8, x8, x9
0xeca884: b.eq     #0xeca890
0xeca888: b        #0xeca88c
0xeca88c: bl       #0x22889b0 ; ___stack_chk_fail
0xeca890: ldp      x29, x30, [sp, #0x120]
0xeca894: ldp      x28, x27, [sp, #0x110]
0xeca898: add      sp, sp, #0x130
0xeca89c: ret      
