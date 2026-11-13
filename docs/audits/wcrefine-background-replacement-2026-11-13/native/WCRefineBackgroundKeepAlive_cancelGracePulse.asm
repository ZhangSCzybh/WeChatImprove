-[WCRefineBackgroundKeepAlive cancelGracePulse] 0xec921c v16@0:8
0xec921c: sub      sp, sp, #0x30
0xec9220: stp      x29, x30, [sp, #0x20]
0xec9224: add      x29, sp, #0x20
0xec9228: stur     x0, [x29, #-8]
0xec922c: str      x1, [sp, #0x10]
0xec9230: ldur     x0, [x29, #-8]
0xec9234: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9238: ldr      x1, [x8, #0x1c0] ; @selector(gracePulseTimer) | 'gracePulseTimer'
0xec923c: adrp     x8, #0x25f4000
0xec9240: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9244: blr      x8
0xec9248: mov      x29, x29
0xec924c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec9250: str      x0, [sp, #8]
0xec9254: adrp     x8, #0x25f4000
0xec9258: ldr      x8, [x8, #0x650] ; _objc_release
0xec925c: blr      x8
0xec9260: ldr      x0, [sp, #8]
0xec9264: cbz      x0, #0xec92d4
0xec9268: b        #0xec926c
0xec926c: ldur     x0, [x29, #-8]
0xec9270: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9274: ldr      x1, [x8, #0x1c0] ; @selector(gracePulseTimer) | 'gracePulseTimer'
0xec9278: adrp     x8, #0x25f4000
0xec927c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9280: blr      x8
0xec9284: mov      x29, x29
0xec9288: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec928c: str      x0, [sp]
0xec9290: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xec9294: ldr      x1, [x8, #0x248] ; @selector(invalidate) | 'invalidate'
0xec9298: adrp     x8, #0x25f4000
0xec929c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec92a0: blr      x8
0xec92a4: ldr      x0, [sp]
0xec92a8: adrp     x8, #0x25f4000
0xec92ac: ldr      x8, [x8, #0x650] ; _objc_release
0xec92b0: blr      x8
0xec92b4: ldur     x0, [x29, #-8]
0xec92b8: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec92bc: ldr      x1, [x8, #0x1b8] ; @selector(setGracePulseTimer:) | 'setGracePulseTimer:'
0xec92c0: adrp     x8, #0x25f4000
0xec92c4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec92c8: mov      x2, #0
0xec92cc: blr      x8
0xec92d0: b        #0xec92d4
0xec92d4: ldp      x29, x30, [sp, #0x20]
0xec92d8: add      sp, sp, #0x30
0xec92dc: ret      
