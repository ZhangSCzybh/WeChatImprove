-[WCRefineBackgroundKeepAlive init] 0xec79ac @16@0:8
0xec79ac: sub      sp, sp, #0x60
0xec79b0: stp      x29, x30, [sp, #0x50]
0xec79b4: add      x29, sp, #0x50
0xec79b8: sub      x8, x29, #8
0xec79bc: str      x8, [sp, #0x28]
0xec79c0: stur     x0, [x29, #-8]
0xec79c4: stur     x1, [x29, #-0x10]
0xec79c8: ldur     x8, [x29, #-8]
0xec79cc: stur     xzr, [x29, #-8]
0xec79d0: sub      x0, x29, #0x20
0xec79d4: stur     x8, [x29, #-0x20]
0xec79d8: adrp     x8, #0x2753000 ; classref WCRefinePluginHubCellAction
0xec79dc: ldr      x8, [x8, #0x4e0] ; classref WCRefineBackgroundKeepAlive | _OBJC_CLASS_$_WCRefineBackgroundKeepAlive
0xec79e0: stur     x8, [x29, #-0x18] ; _OBJC_CLASS_$_WCRefineBackgroundKeepAlive
0xec79e4: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xec79e8: ldr      x1, [x8, #0x198] ; @selector(init) | 'init'
0xec79ec: bl       #0x228907c ; _objc_msgSendSuper2 | selector=init
0xec79f0: mov      x1, x0
0xec79f4: ldr      x0, [sp, #0x28]
0xec79f8: mov      x8, x1
0xec79fc: stur     x8, [x29, #-8]
0xec7a00: bl       #0x2289118 ; _objc_storeStrong
0xec7a04: ldur     x8, [x29, #-8]
0xec7a08: cbz      x8, #0xec7acc
0xec7a0c: b        #0xec7a10
0xec7a10: adrp     x8, #0x25f4000
0xec7a14: ldr      x8, [x8, #0x108] ; _UIBackgroundTaskInvalid
0xec7a18: ldr      x8, [x8]
0xec7a1c: ldur     x9, [x29, #-8]
0xec7a20: str      x8, [x9, #0x10]
0xec7a24: ldur     x8, [x29, #-8]
0xec7a28: strb     wzr, [x8, #8]
0xec7a2c: ldur     x0, [x29, #-8]
0xec7a30: adrp     x8, #0x271f000
0xec7a34: ldr      x1, [x8, #0x718] ; @selector(class) | 'class'
0xec7a38: adrp     x8, #0x25f4000
0xec7a3c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7a40: blr      x8
0xec7a44: str      x0, [sp, #0x18]
0xec7a48: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec7a4c: ldr      x0, [x8, #0xa68] ; classref WCRefineConfig | _OBJC_CLASS_$_WCRefineConfig
0xec7a50: adrp     x8, #0x271f000
0xec7a54: ldr      x1, [x8, #0x488] ; @selector(shared) | 'shared'
0xec7a58: adrp     x8, #0x25f4000
0xec7a5c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7a60: blr      x8
0xec7a64: mov      x29, x29
0xec7a68: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec7a6c: str      x0, [sp, #0x20]
0xec7a70: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7a74: ldr      x1, [x8, #0x100] ; @selector(backgroundKeepAliveInterval) | 'backgroundKeepAliveInterval'
0xec7a78: adrp     x8, #0x25f4000
0xec7a7c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7a80: blr      x8
0xec7a84: mov      x2, x0
0xec7a88: ldr      x0, [sp, #0x18]
0xec7a8c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7a90: ldr      x1, [x8, #0x108] ; @selector(clampedInterval:) | 'clampedInterval:'
0xec7a94: adrp     x8, #0x25f4000
0xec7a98: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7a9c: blr      x8
0xec7aa0: ldr      x0, [sp, #0x20]
0xec7aa4: ldur     x8, [x29, #-8]
0xec7aa8: str      d0, [x8, #0x30]
0xec7aac: adrp     x8, #0x25f4000
0xec7ab0: ldr      x8, [x8, #0x650] ; _objc_release
0xec7ab4: blr      x8
0xec7ab8: ldur     x8, [x29, #-8]
0xec7abc: strb     wzr, [x8, #9]
0xec7ac0: ldur     x8, [x29, #-8]
0xec7ac4: strb     wzr, [x8, #0xa]
0xec7ac8: b        #0xec7acc
0xec7acc: sub      x8, x29, #8
0xec7ad0: str      x8, [sp, #8]
0xec7ad4: ldur     x0, [x29, #-8]
0xec7ad8: str      x0, [sp, #0x10]
0xec7adc: adrp     x8, #0x25f4000
0xec7ae0: ldr      x8, [x8, #0x658] ; _objc_retain
0xec7ae4: blr      x8
0xec7ae8: ldr      x0, [sp, #8]
0xec7aec: mov      x1, #0
0xec7af0: bl       #0x2289118 ; _objc_storeStrong
0xec7af4: ldr      x0, [sp, #0x10]
0xec7af8: ldp      x29, x30, [sp, #0x50]
0xec7afc: add      sp, sp, #0x60
0xec7b00: ret      
