0xec752c: sub      sp, sp, #0x30
0xec7530: stp      x29, x30, [sp, #0x20]
0xec7534: add      x29, sp, #0x20
0xec7538: mov      x8, x0
0xec753c: stur     x8, [x29, #-8]
0xec7540: str      x0, [sp, #0x10]
0xec7544: adrp     x8, #0x2752000
0xec7548: ldr      x0, [x8, #0x638] ; classref WCRefineBackgroundKeepAlive | _OBJC_CLASS_$_WCRefineBackgroundKeepAlive
0xec754c: adrp     x8, #0x271f000
0xec7550: ldr      x1, [x8, #0x488] ; @selector(shared) | 'shared'
0xec7554: adrp     x8, #0x25f4000
0xec7558: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec755c: blr      x8
0xec7560: mov      x29, x29
0xec7564: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec7568: str      x0, [sp, #8]
0xec756c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7570: ldr      x1, [x8, #0xf0] ; @selector(refreshSettings) | 'refreshSettings'
0xec7574: adrp     x8, #0x25f4000
0xec7578: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec757c: blr      x8
0xec7580: ldr      x0, [sp, #8]
0xec7584: adrp     x8, #0x25f4000
0xec7588: ldr      x8, [x8, #0x650] ; _objc_release
0xec758c: blr      x8
0xec7590: ldp      x29, x30, [sp, #0x20]
0xec7594: add      sp, sp, #0x30
0xec7598: ret      
