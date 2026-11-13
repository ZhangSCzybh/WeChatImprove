-[WCRefineBackgroundKeepAlive appDidEnterBackground] 0xec7eb0 v16@0:8
0xec7eb0: sub      sp, sp, #0x30
0xec7eb4: stp      x29, x30, [sp, #0x20]
0xec7eb8: add      x29, sp, #0x20
0xec7ebc: stur     x0, [x29, #-8]
0xec7ec0: str      x1, [sp, #0x10]
0xec7ec4: ldur     x0, [x29, #-8]
0xec7ec8: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7ecc: ldr      x1, [x8, #0x150] ; @selector(setIsInBackground:) | 'setIsInBackground:'
0xec7ed0: mov      w8, #1
0xec7ed4: and      w2, w8, #1
0xec7ed8: adrp     x8, #0x25f4000
0xec7edc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7ee0: blr      x8
0xec7ee4: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec7ee8: ldr      x0, [x8, #0xa98]
0xec7eec: adrp     x8, #0x271f000
0xec7ef0: ldr      x1, [x8, #0x500] ; @selector(date) | 'date'
0xec7ef4: adrp     x8, #0x25f4000
0xec7ef8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7efc: blr      x8
0xec7f00: mov      x29, x29
0xec7f04: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec7f08: mov      x2, x0
0xec7f0c: str      x2, [sp, #8]
0xec7f10: ldur     x0, [x29, #-8]
0xec7f14: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7f18: ldr      x1, [x8, #0x158] ; @selector(setBackgroundEnteredAt:) | 'setBackgroundEnteredAt:'
0xec7f1c: adrp     x8, #0x25f4000
0xec7f20: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7f24: blr      x8
0xec7f28: ldr      x0, [sp, #8]
0xec7f2c: adrp     x8, #0x25f4000
0xec7f30: ldr      x8, [x8, #0x650] ; _objc_release
0xec7f34: blr      x8
0xec7f38: ldur     x0, [x29, #-8]
0xec7f3c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7f40: ldr      x1, [x8, #0x160] ; @selector(setDidNotifyDropEnded:) | 'setDidNotifyDropEnded:'
0xec7f44: mov      w8, #0
0xec7f48: and      w2, w8, #1
0xec7f4c: adrp     x8, #0x25f4000
0xec7f50: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7f54: blr      x8
0xec7f58: ldur     x0, [x29, #-8]
0xec7f5c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7f60: ldr      x1, [x8, #0x168] ; @selector(isDropNotifyEnabled) | 'isDropNotifyEnabled'
0xec7f64: adrp     x8, #0x25f4000
0xec7f68: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7f6c: blr      x8
0xec7f70: tbz      w0, #0, #0xec7fa8
0xec7f74: b        #0xec7f78
0xec7f78: ldur     x0, [x29, #-8]
0xec7f7c: adrp     x8, #0x271f000
0xec7f80: ldr      x1, [x8, #0x718] ; @selector(class) | 'class'
0xec7f84: adrp     x8, #0x25f4000
0xec7f88: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7f8c: blr      x8
0xec7f90: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7f94: ldr      x1, [x8, #0x138] ; @selector(requestNotificationPermissionIfNeeded) | 'requestNotificationPermissionIfNeeded'
0xec7f98: adrp     x8, #0x25f4000
0xec7f9c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7fa0: blr      x8
0xec7fa4: b        #0xec7fa8
0xec7fa8: ldur     x0, [x29, #-8]
0xec7fac: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7fb0: ldr      x1, [x8, #0x148] ; @selector(startIfNeeded) | 'startIfNeeded'
0xec7fb4: adrp     x8, #0x25f4000
0xec7fb8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7fbc: blr      x8
0xec7fc0: ldp      x29, x30, [sp, #0x20]
0xec7fc4: add      sp, sp, #0x30
0xec7fc8: ret      
