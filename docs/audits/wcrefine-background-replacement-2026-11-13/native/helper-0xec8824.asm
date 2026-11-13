0xec8824: sub      sp, sp, #0x30
0xec8828: stp      x29, x30, [sp, #0x20]
0xec882c: add      x29, sp, #0x20
0xec8830: stur     x0, [x29, #-8]
0xec8834: str      x0, [sp, #0x10]
0xec8838: add      x0, x0, #0x20
0xec883c: bl       #0x228904c ; _objc_loadWeakRetained
0xec8840: str      x0, [sp, #8]
0xec8844: ldr      x8, [sp, #8]
0xec8848: cbz      x8, #0xec886c
0xec884c: b        #0xec8850
0xec8850: ldr      x0, [sp, #8]
0xec8854: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8858: ldr      x1, [x8, #0x190] ; @selector(endBackgroundTask) | 'endBackgroundTask'
0xec885c: adrp     x8, #0x25f4000
0xec8860: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8864: blr      x8
0xec8868: b        #0xec886c
0xec886c: add      x0, sp, #8
0xec8870: mov      x1, #0
0xec8874: bl       #0x2289118 ; _objc_storeStrong
0xec8878: ldp      x29, x30, [sp, #0x20]
0xec887c: add      sp, sp, #0x30
0xec8880: ret      
