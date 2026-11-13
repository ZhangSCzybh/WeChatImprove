-[WCRefineBackgroundKeepAlive stopAudio] 0xec9898 v16@0:8
0xec9898: sub      sp, sp, #0x30
0xec989c: stp      x29, x30, [sp, #0x20]
0xec98a0: add      x29, sp, #0x20
0xec98a4: stur     x0, [x29, #-8]
0xec98a8: str      x1, [sp, #0x10]
0xec98ac: ldur     x0, [x29, #-8]
0xec98b0: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec98b4: ldr      x1, [x8, #0x208] ; @selector(silentPlayer) | 'silentPlayer'
0xec98b8: adrp     x8, #0x25f4000
0xec98bc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec98c0: blr      x8
0xec98c4: mov      x29, x29
0xec98c8: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec98cc: str      x0, [sp, #8]
0xec98d0: adrp     x8, #0x25f4000
0xec98d4: ldr      x8, [x8, #0x650] ; _objc_release
0xec98d8: blr      x8
0xec98dc: ldr      x0, [sp, #8]
0xec98e0: cbz      x0, #0xec9950
0xec98e4: b        #0xec98e8
0xec98e8: ldur     x0, [x29, #-8]
0xec98ec: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec98f0: ldr      x1, [x8, #0x208] ; @selector(silentPlayer) | 'silentPlayer'
0xec98f4: adrp     x8, #0x25f4000
0xec98f8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec98fc: blr      x8
0xec9900: mov      x29, x29
0xec9904: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec9908: str      x0, [sp]
0xec990c: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0xec9910: ldr      x1, [x8, #0x738] ; @selector(stop) | 'stop'
0xec9914: adrp     x8, #0x25f4000
0xec9918: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec991c: blr      x8
0xec9920: ldr      x0, [sp]
0xec9924: adrp     x8, #0x25f4000
0xec9928: ldr      x8, [x8, #0x650] ; _objc_release
0xec992c: blr      x8
0xec9930: ldur     x0, [x29, #-8]
0xec9934: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9938: ldr      x1, [x8, #0x250] ; @selector(setSilentPlayer:) | 'setSilentPlayer:'
0xec993c: adrp     x8, #0x25f4000
0xec9940: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9944: mov      x2, #0
0xec9948: blr      x8
0xec994c: b        #0xec9950
0xec9950: ldp      x29, x30, [sp, #0x20]
0xec9954: add      sp, sp, #0x30
0xec9958: ret      
