-[WCRefineBackgroundKeepAlive appDidBecomeActive] 0xec8084 v16@0:8
0xec8084: sub      sp, sp, #0x20
0xec8088: stp      x29, x30, [sp, #0x10]
0xec808c: add      x29, sp, #0x10
0xec8090: str      x0, [sp, #8]
0xec8094: str      x1, [sp]
0xec8098: ldr      x0, [sp, #8]
0xec809c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec80a0: ldr      x1, [x8, #0x140] ; @selector(isInBackground) | 'isInBackground'
0xec80a4: adrp     x8, #0x25f4000
0xec80a8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec80ac: blr      x8
0xec80b0: tbnz     w0, #0, #0xec80d4
0xec80b4: b        #0xec80b8
0xec80b8: ldr      x0, [sp, #8]
0xec80bc: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec80c0: ldr      x1, [x8, #0x178] ; @selector(stopAudio) | 'stopAudio'
0xec80c4: adrp     x8, #0x25f4000
0xec80c8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec80cc: blr      x8
0xec80d0: b        #0xec80d4
0xec80d4: ldp      x29, x30, [sp, #0x10]
0xec80d8: add      sp, sp, #0x20
0xec80dc: ret      
