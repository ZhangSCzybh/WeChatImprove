0xec85fc: sub      sp, sp, #0x30
0xec8600: stp      x29, x30, [sp, #0x20]
0xec8604: add      x29, sp, #0x20
0xec8608: stur     x0, [x29, #-8]
0xec860c: str      x0, [sp, #0x10]
0xec8610: add      x0, x0, #0x20
0xec8614: bl       #0x228904c ; _objc_loadWeakRetained
0xec8618: str      x0, [sp, #8]
0xec861c: ldr      x8, [sp, #8]
0xec8620: cbz      x8, #0xec8644
0xec8624: b        #0xec8628
0xec8628: ldr      x0, [sp, #8]
0xec862c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8630: ldr      x1, [x8, #0x190] ; @selector(endBackgroundTask) | 'endBackgroundTask'
0xec8634: adrp     x8, #0x25f4000
0xec8638: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec863c: blr      x8
0xec8640: b        #0xec8644
0xec8644: add      x0, sp, #8
0xec8648: mov      x1, #0
0xec864c: bl       #0x2289118 ; _objc_storeStrong
0xec8650: ldp      x29, x30, [sp, #0x20]
0xec8654: add      sp, sp, #0x30
0xec8658: ret      
