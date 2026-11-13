+[WCRefineBackgroundKeepAlive requestNotificationPermissionIfNeeded] 0xeca2a8 v16@0:8
0xeca2a8: sub      sp, sp, #0x80
0xeca2ac: stp      x29, x30, [sp, #0x70]
0xeca2b0: add      x29, sp, #0x70
0xeca2b4: stur     x0, [x29, #-8]
0xeca2b8: stur     x1, [x29, #-0x10]
0xeca2bc: mov      w8, #1
0xeca2c0: tbz      w8, #0, #0xeca398
0xeca2c4: b        #0xeca2c8
0xeca2c8: adrp     x8, #0x2752000
0xeca2cc: ldr      x0, [x8, #0x498]
0xeca2d0: adrp     x8, #0x272b000 ; @selector(initHeaderLogicAndHeaderView)
0xeca2d4: ldr      x1, [x8, #0x328] ; @selector(currentNotificationCenter) | 'currentNotificationCenter'
0xeca2d8: adrp     x8, #0x25f4000
0xeca2dc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca2e0: blr      x8
0xeca2e4: mov      x29, x29
0xeca2e8: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xeca2ec: sub      x8, x29, #0x18
0xeca2f0: str      x8, [sp, #0x20]
0xeca2f4: stur     x0, [x29, #-0x18]
0xeca2f8: ldur     x8, [x29, #-0x18]
0xeca2fc: str      x8, [sp]
0xeca300: add      x8, sp, #0x30
0xeca304: str      x8, [sp, #0x10]
0xeca308: adrp     x9, #0x25f4000
0xeca30c: ldr      x9, [x9, #0x680] ; __NSConcreteStackBlock
0xeca310: str      x9, [sp, #0x30]
0xeca314: mov      w9, #-0x3e000000
0xeca318: str      w9, [sp, #0x38]
0xeca31c: str      wzr, [sp, #0x3c]
0xeca320: adrp     x9, #0xeca000
0xeca324: add      x9, x9, #0x3a4
0xeca328: str      x9, [sp, #0x40]
0xeca32c: adrp     x9, #0x25fd000
0xeca330: add      x9, x9, #0xe98
0xeca334: str      x9, [sp, #0x48]
0xeca338: add      x8, x8, #0x20
0xeca33c: str      x8, [sp, #0x18]
0xeca340: ldur     x0, [x29, #-0x18]
0xeca344: str      x0, [sp, #8]
0xeca348: adrp     x8, #0x25f4000
0xeca34c: ldr      x8, [x8, #0x658] ; _objc_retain
0xeca350: blr      x8
0xeca354: ldr      x0, [sp]
0xeca358: ldr      x8, [sp, #8]
0xeca35c: ldr      x2, [sp, #0x10]
0xeca360: str      x8, [sp, #0x50]
0xeca364: adrp     x8, #0x272b000 ; @selector(initHeaderLogicAndHeaderView)
0xeca368: ldr      x1, [x8, #0x338] ; @selector(getNotificationSettingsWithCompletionHandler:) | 'getNotificationSettingsWithCompletionHandler:'
0xeca36c: adrp     x8, #0x25f4000
0xeca370: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca374: blr      x8
0xeca378: ldr      x0, [sp, #0x18]
0xeca37c: mov      x1, #0
0xeca380: str      x1, [sp, #0x28]
0xeca384: bl       #0x2289118 ; _objc_storeStrong
0xeca388: ldr      x0, [sp, #0x20]
0xeca38c: ldr      x1, [sp, #0x28]
0xeca390: bl       #0x2289118 ; _objc_storeStrong
0xeca394: b        #0xeca398
0xeca398: ldp      x29, x30, [sp, #0x70]
0xeca39c: add      sp, sp, #0x80
0xeca3a0: ret      
