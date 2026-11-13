-[WCRefineBackgroundKeepAlive appWillEnterForeground] 0xec7fcc v16@0:8
0xec7fcc: sub      sp, sp, #0x30
0xec7fd0: stp      x29, x30, [sp, #0x20]
0xec7fd4: add      x29, sp, #0x20
0xec7fd8: stur     x0, [x29, #-8]
0xec7fdc: str      x1, [sp, #0x10]
0xec7fe0: ldur     x0, [x29, #-8]
0xec7fe4: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7fe8: ldr      x1, [x8, #0x150] ; @selector(setIsInBackground:) | 'setIsInBackground:'
0xec7fec: mov      w8, #0
0xec7ff0: str      w8, [sp, #0xc]
0xec7ff4: and      w2, w8, #1
0xec7ff8: adrp     x8, #0x25f4000
0xec7ffc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8000: blr      x8
0xec8004: ldur     x0, [x29, #-8]
0xec8008: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec800c: ldr      x1, [x8, #0x158] ; @selector(setBackgroundEnteredAt:) | 'setBackgroundEnteredAt:'
0xec8010: mov      x2, #0
0xec8014: adrp     x8, #0x25f4000
0xec8018: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec801c: blr      x8
0xec8020: ldr      w8, [sp, #0xc]
0xec8024: ldur     x0, [x29, #-8]
0xec8028: adrp     x9, #0x272e000 ; @selector(persistUsageCache)
0xec802c: ldr      x1, [x9, #0x160] ; @selector(setDidNotifyDropEnded:) | 'setDidNotifyDropEnded:'
0xec8030: and      w2, w8, #1
0xec8034: adrp     x8, #0x25f4000
0xec8038: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec803c: blr      x8
0xec8040: ldr      w8, [sp, #0xc]
0xec8044: ldur     x0, [x29, #-8]
0xec8048: adrp     x9, #0x272e000 ; @selector(persistUsageCache)
0xec804c: ldr      x1, [x9, #0x170] ; @selector(setYieldedForHostCall:) | 'setYieldedForHostCall:'
0xec8050: and      w2, w8, #1
0xec8054: adrp     x8, #0x25f4000
0xec8058: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec805c: blr      x8
0xec8060: ldur     x0, [x29, #-8]
0xec8064: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0xec8068: ldr      x1, [x8, #0x738] ; @selector(stop) | 'stop'
0xec806c: adrp     x8, #0x25f4000
0xec8070: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8074: blr      x8
0xec8078: ldp      x29, x30, [sp, #0x20]
0xec807c: add      sp, sp, #0x30
0xec8080: ret      
