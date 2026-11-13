-[WCRefineBackgroundKeepAlive endBackgroundTask] 0xec995c v16@0:8
0xec995c: sub      sp, sp, #0x30
0xec9960: stp      x29, x30, [sp, #0x20]
0xec9964: add      x29, sp, #0x20
0xec9968: stur     x0, [x29, #-8]
0xec996c: str      x1, [sp, #0x10]
0xec9970: ldur     x0, [x29, #-8]
0xec9974: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9978: ldr      x1, [x8, #0x188] ; @selector(bgTaskIdentifier) | 'bgTaskIdentifier'
0xec997c: adrp     x8, #0x25f4000
0xec9980: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9984: blr      x8
0xec9988: adrp     x8, #0x25f4000
0xec998c: ldr      x8, [x8, #0x108] ; _UIBackgroundTaskInvalid
0xec9990: ldr      x8, [x8]
0xec9994: subs     x8, x0, x8
0xec9998: b.eq     #0xec9a34
0xec999c: b        #0xec99a0
0xec99a0: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec99a4: ldr      x0, [x8, #0xb20]
0xec99a8: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xec99ac: ldr      x1, [x8, #0x5f8] ; @selector(sharedApplication) | 'sharedApplication'
0xec99b0: adrp     x8, #0x25f4000
0xec99b4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec99b8: blr      x8
0xec99bc: mov      x29, x29
0xec99c0: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec99c4: str      x0, [sp, #8]
0xec99c8: ldur     x0, [x29, #-8]
0xec99cc: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec99d0: ldr      x1, [x8, #0x188] ; @selector(bgTaskIdentifier) | 'bgTaskIdentifier'
0xec99d4: adrp     x8, #0x25f4000
0xec99d8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec99dc: blr      x8
0xec99e0: mov      x2, x0
0xec99e4: ldr      x0, [sp, #8]
0xec99e8: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0xec99ec: ldr      x1, [x8, #0x68] ; @selector(endBackgroundTask:) | 'endBackgroundTask:'
0xec99f0: adrp     x8, #0x25f4000
0xec99f4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec99f8: blr      x8
0xec99fc: ldr      x0, [sp, #8]
0xec9a00: adrp     x8, #0x25f4000
0xec9a04: ldr      x8, [x8, #0x650] ; _objc_release
0xec9a08: blr      x8
0xec9a0c: adrp     x8, #0x25f4000
0xec9a10: ldr      x8, [x8, #0x108] ; _UIBackgroundTaskInvalid
0xec9a14: ldr      x2, [x8]
0xec9a18: ldur     x0, [x29, #-8]
0xec9a1c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9a20: ldr      x1, [x8, #0x1a0] ; @selector(setBgTaskIdentifier:) | 'setBgTaskIdentifier:'
0xec9a24: adrp     x8, #0x25f4000
0xec9a28: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9a2c: blr      x8
0xec9a30: b        #0xec9a34
0xec9a34: ldp      x29, x30, [sp, #0x20]
0xec9a38: add      sp, sp, #0x30
0xec9a3c: ret      
