0xec7448: sub      sp, sp, #0x50
0xec744c: stp      x29, x30, [sp, #0x40]
0xec7450: add      x29, sp, #0x40
0xec7454: str      x0, [sp, #8]
0xec7458: mov      x0, x1
0xec745c: ldr      x1, [sp, #8]
0xec7460: str      x0, [sp, #0x10]
0xec7464: str      x2, [sp, #0x18]
0xec7468: sub      x0, x29, #8
0xec746c: stur     xzr, [x29, #-8]
0xec7470: bl       #0x2289118 ; _objc_storeStrong
0xec7474: ldr      x8, [sp, #0x10]
0xec7478: ldr      x1, [sp, #0x18]
0xec747c: stur     x8, [x29, #-0x10]
0xec7480: sub      x0, x29, #0x18
0xec7484: stur     xzr, [x29, #-0x18]
0xec7488: bl       #0x2289118 ; _objc_storeStrong
0xec748c: adrp     x8, #0x2752000
0xec7490: ldr      x0, [x8, #0x638] ; classref WCRefineBackgroundKeepAlive | _OBJC_CLASS_$_WCRefineBackgroundKeepAlive
0xec7494: adrp     x8, #0x271f000
0xec7498: ldr      x1, [x8, #0x488] ; @selector(shared) | 'shared'
0xec749c: adrp     x8, #0x25f4000
0xec74a0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec74a4: blr      x8
0xec74a8: mov      x29, x29
0xec74ac: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec74b0: str      x0, [sp, #0x20]
0xec74b4: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec74b8: ldr      x1, [x8, #0x2c0] ; @selector(notifyDropEndedOnTerminate) | 'notifyDropEndedOnTerminate'
0xec74bc: adrp     x8, #0x25f4000
0xec74c0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec74c4: blr      x8
0xec74c8: ldr      x0, [sp, #0x20]
0xec74cc: adrp     x8, #0x25f4000
0xec74d0: ldr      x8, [x8, #0x650] ; _objc_release
0xec74d4: blr      x8
0xec74d8: adrp     x8, #0x295b000
0xec74dc: ldr      x8, [x8, #0x528]
0xec74e0: cbz      x8, #0xec7504
0xec74e4: b        #0xec74e8
0xec74e8: adrp     x8, #0x295b000
0xec74ec: ldr      x8, [x8, #0x528]
0xec74f0: ldur     x0, [x29, #-8]
0xec74f4: ldur     x1, [x29, #-0x10]
0xec74f8: ldur     x2, [x29, #-0x18]
0xec74fc: blr      x8
0xec7500: b        #0xec7504
0xec7504: sub      x0, x29, #0x18
0xec7508: mov      x1, #0
0xec750c: str      x1, [sp]
0xec7510: bl       #0x2289118 ; _objc_storeStrong
0xec7514: ldr      x1, [sp]
0xec7518: sub      x0, x29, #8
0xec751c: bl       #0x2289118 ; _objc_storeStrong
0xec7520: ldp      x29, x30, [sp, #0x40]
0xec7524: add      sp, sp, #0x50
0xec7528: ret      
