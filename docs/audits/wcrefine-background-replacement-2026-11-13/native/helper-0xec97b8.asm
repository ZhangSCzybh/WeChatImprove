0xec97b8: sub      sp, sp, #0x30
0xec97bc: stp      x29, x30, [sp, #0x20]
0xec97c0: add      x29, sp, #0x20
0xec97c4: stur     x0, [x29, #-8]
0xec97c8: str      x0, [sp, #0x10]
0xec97cc: add      x0, x0, #0x20
0xec97d0: bl       #0x228904c ; _objc_loadWeakRetained
0xec97d4: str      x0, [sp, #8]
0xec97d8: ldr      x8, [sp, #8]
0xec97dc: cbz      x8, #0xec9824
0xec97e0: b        #0xec97e4
0xec97e4: ldr      x0, [sp, #8]
0xec97e8: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec97ec: ldr      x1, [x8, #0x140] ; @selector(isInBackground) | 'isInBackground'
0xec97f0: adrp     x8, #0x25f4000
0xec97f4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec97f8: blr      x8
0xec97fc: tbz      w0, #0, #0xec9824
0xec9800: b        #0xec9804
0xec9804: ldr      x0, [sp, #8]
0xec9808: adrp     x8, #0x2723000 ; @selector(menuArrowColorEnabled)
0xec980c: ldr      x1, [x8, #0x9f0] ; @selector(isEnabled) | 'isEnabled'
0xec9810: adrp     x8, #0x25f4000
0xec9814: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9818: blr      x8
0xec981c: tbnz     w0, #0, #0xec9830
0xec9820: b        #0xec9824
0xec9824: mov      w8, #1
0xec9828: str      w8, [sp, #4]
0xec982c: b        #0xec9880
0xec9830: bl       #0xec75c0
0xec9834: tbz      w0, #0, #0xec9848
0xec9838: b        #0xec983c
0xec983c: mov      w8, #1
0xec9840: str      w8, [sp, #4]
0xec9844: b        #0xec9880
0xec9848: bl       #0xec7840
0xec984c: tbz      w0, #0, #0xec9860
0xec9850: b        #0xec9854
0xec9854: mov      w8, #1
0xec9858: str      w8, [sp, #4]
0xec985c: b        #0xec9880
0xec9860: ldr      x0, [sp, #8]
0xec9864: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9868: ldr      x1, [x8, #0x1f8] ; @selector(ensureAudioPlaying) | 'ensureAudioPlaying'
0xec986c: adrp     x8, #0x25f4000
0xec9870: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9874: blr      x8
0xec9878: str      wzr, [sp, #4]
0xec987c: b        #0xec9880
0xec9880: add      x0, sp, #8
0xec9884: mov      x1, #0
0xec9888: bl       #0x2289118 ; _objc_storeStrong
0xec988c: ldp      x29, x30, [sp, #0x20]
0xec9890: add      sp, sp, #0x30
0xec9894: ret      
