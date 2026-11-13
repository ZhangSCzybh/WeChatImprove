0xec7840: sub      sp, sp, #0x20
0xec7844: stp      x29, x30, [sp, #0x10]
0xec7848: add      x29, sp, #0x10
0xec784c: adrp     x8, #0x2752000
0xec7850: ldr      x0, [x8, #0x500]
0xec7854: adrp     x8, #0x271f000
0xec7858: ldr      x1, [x8, #0x6e8] ; @selector(sharedInstance) | 'sharedInstance'
0xec785c: adrp     x8, #0x25f4000
0xec7860: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7864: blr      x8
0xec7868: mov      x29, x29
0xec786c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec7870: str      x0, [sp]
0xec7874: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7878: ldr      x1, [x8, #0x2d0] ; @selector(secondaryAudioShouldBeSilencedHint) | 'secondaryAudioShouldBeSilencedHint'
0xec787c: adrp     x8, #0x25f4000
0xec7880: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7884: blr      x8
0xec7888: mov      x1, x0
0xec788c: ldr      x0, [sp]
0xec7890: stur     w1, [x29, #-4]
0xec7894: adrp     x8, #0x25f4000
0xec7898: ldr      x8, [x8, #0x650] ; _objc_release
0xec789c: blr      x8
0xec78a0: ldur     w0, [x29, #-4]
0xec78a4: ldp      x29, x30, [sp, #0x10]
0xec78a8: add      sp, sp, #0x20
0xec78ac: ret      
