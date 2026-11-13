-[WCRefineBackgroundKeepAlive onGracePulse] 0xec92e0 v16@0:8
0xec92e0: sub      sp, sp, #0x20
0xec92e4: stp      x29, x30, [sp, #0x10]
0xec92e8: add      x29, sp, #0x10
0xec92ec: str      x0, [sp, #8]
0xec92f0: str      x1, [sp]
0xec92f4: ldr      x0, [sp, #8]
0xec92f8: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec92fc: ldr      x1, [x8, #0x1b8] ; @selector(setGracePulseTimer:) | 'setGracePulseTimer:'
0xec9300: mov      x2, #0
0xec9304: adrp     x8, #0x25f4000
0xec9308: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec930c: blr      x8
0xec9310: ldr      x0, [sp, #8]
0xec9314: adrp     x8, #0x2723000 ; @selector(menuArrowColorEnabled)
0xec9318: ldr      x1, [x8, #0x9f0] ; @selector(isEnabled) | 'isEnabled'
0xec931c: adrp     x8, #0x25f4000
0xec9320: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9324: blr      x8
0xec9328: tbz      w0, #0, #0xec9350
0xec932c: b        #0xec9330
0xec9330: ldr      x0, [sp, #8]
0xec9334: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9338: ldr      x1, [x8, #0x140] ; @selector(isInBackground) | 'isInBackground'
0xec933c: adrp     x8, #0x25f4000
0xec9340: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9344: blr      x8
0xec9348: tbnz     w0, #0, #0xec9354
0xec934c: b        #0xec9350
0xec9350: b        #0xec9370
0xec9354: ldr      x0, [sp, #8]
0xec9358: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec935c: ldr      x1, [x8, #0x1e8] ; @selector(requestMoreTime) | 'requestMoreTime'
0xec9360: adrp     x8, #0x25f4000
0xec9364: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9368: blr      x8
0xec936c: b        #0xec9370
0xec9370: ldp      x29, x30, [sp, #0x10]
0xec9374: add      sp, sp, #0x20
0xec9378: ret      
