-[WCRefineBackgroundKeepAlive stop] 0xec9a40 v16@0:8
0xec9a40: sub      sp, sp, #0x40
0xec9a44: stp      x29, x30, [sp, #0x30]
0xec9a48: add      x29, sp, #0x30
0xec9a4c: stur     x0, [x29, #-8]
0xec9a50: stur     x1, [x29, #-0x10]
0xec9a54: ldur     x0, [x29, #-8]
0xec9a58: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9a5c: ldr      x1, [x8, #0x1c8] ; @selector(bgTimer) | 'bgTimer'
0xec9a60: adrp     x8, #0x25f4000
0xec9a64: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9a68: blr      x8
0xec9a6c: mov      x29, x29
0xec9a70: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec9a74: str      x0, [sp, #0x18]
0xec9a78: adrp     x8, #0x25f4000
0xec9a7c: ldr      x8, [x8, #0x650] ; _objc_release
0xec9a80: blr      x8
0xec9a84: ldr      x0, [sp, #0x18]
0xec9a88: cbz      x0, #0xec9af8
0xec9a8c: b        #0xec9a90
0xec9a90: ldur     x0, [x29, #-8]
0xec9a94: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9a98: ldr      x1, [x8, #0x1c8] ; @selector(bgTimer) | 'bgTimer'
0xec9a9c: adrp     x8, #0x25f4000
0xec9aa0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9aa4: blr      x8
0xec9aa8: mov      x29, x29
0xec9aac: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec9ab0: str      x0, [sp, #0x10]
0xec9ab4: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xec9ab8: ldr      x1, [x8, #0x248] ; @selector(invalidate) | 'invalidate'
0xec9abc: adrp     x8, #0x25f4000
0xec9ac0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9ac4: blr      x8
0xec9ac8: ldr      x0, [sp, #0x10]
0xec9acc: adrp     x8, #0x25f4000
0xec9ad0: ldr      x8, [x8, #0x650] ; _objc_release
0xec9ad4: blr      x8
0xec9ad8: ldur     x0, [x29, #-8]
0xec9adc: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9ae0: ldr      x1, [x8, #0x1d0] ; @selector(setBgTimer:) | 'setBgTimer:'
0xec9ae4: adrp     x8, #0x25f4000
0xec9ae8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9aec: mov      x2, #0
0xec9af0: blr      x8
0xec9af4: b        #0xec9af8
0xec9af8: ldur     x0, [x29, #-8]
0xec9afc: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9b00: ldr      x1, [x8, #0x1a8] ; @selector(cancelGracePulse) | 'cancelGracePulse'
0xec9b04: adrp     x8, #0x25f4000
0xec9b08: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9b0c: blr      x8
0xec9b10: ldur     x0, [x29, #-8]
0xec9b14: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9b18: ldr      x1, [x8, #0x178] ; @selector(stopAudio) | 'stopAudio'
0xec9b1c: adrp     x8, #0x25f4000
0xec9b20: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9b24: blr      x8
0xec9b28: ldur     x0, [x29, #-8]
0xec9b2c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9b30: ldr      x1, [x8, #0x190] ; @selector(endBackgroundTask) | 'endBackgroundTask'
0xec9b34: adrp     x8, #0x25f4000
0xec9b38: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9b3c: blr      x8
0xec9b40: ldur     x0, [x29, #-8]
0xec9b44: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9b48: ldr      x1, [x8, #0x170] ; @selector(setYieldedForHostCall:) | 'setYieldedForHostCall:'
0xec9b4c: adrp     x8, #0x25f4000
0xec9b50: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9b54: mov      w9, #0
0xec9b58: str      w9, [sp, #0xc]
0xec9b5c: and      w2, w9, #1
0xec9b60: blr      x8
0xec9b64: ldr      w9, [sp, #0xc]
0xec9b68: ldur     x0, [x29, #-8]
0xec9b6c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9b70: ldr      x1, [x8, #0x230] ; @selector(setYieldedForOtherAudio:) | 'setYieldedForOtherAudio:'
0xec9b74: adrp     x8, #0x25f4000
0xec9b78: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9b7c: and      w2, w9, #1
0xec9b80: blr      x8
0xec9b84: ldp      x29, x30, [sp, #0x30]
0xec9b88: add      sp, sp, #0x40
0xec9b8c: ret      
