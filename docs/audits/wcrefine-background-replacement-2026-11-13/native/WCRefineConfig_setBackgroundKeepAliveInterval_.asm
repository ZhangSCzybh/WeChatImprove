-[WCRefineConfig setBackgroundKeepAliveInterval:] 0x208f388 v24@0:8q16
0x208f388: sub      sp, sp, #0x60
0x208f38c: stp      x29, x30, [sp, #0x50]
0x208f390: add      x29, sp, #0x50
0x208f394: stur     x0, [x29, #-8]
0x208f398: stur     x1, [x29, #-0x10]
0x208f39c: stur     x2, [x29, #-0x18]
0x208f3a0: ldur     x8, [x29, #-0x18]
0x208f3a4: subs     x8, x8, #0xa
0x208f3a8: b.ge     #0x208f3bc
0x208f3ac: b        #0x208f3b0
0x208f3b0: mov      x8, #0xa
0x208f3b4: stur     x8, [x29, #-0x18]
0x208f3b8: b        #0x208f3bc
0x208f3bc: ldur     x8, [x29, #-0x18]
0x208f3c0: subs     x8, x8, #0x1e
0x208f3c4: b.le     #0x208f3d8
0x208f3c8: b        #0x208f3cc
0x208f3cc: mov      x8, #0x1e
0x208f3d0: stur     x8, [x29, #-0x18]
0x208f3d4: b        #0x208f3d8
0x208f3d8: ldur     x0, [x29, #-8]
0x208f3dc: adrp     x8, #0x271f000
0x208f3e0: str      x8, [sp, #0x20]
0x208f3e4: ldr      x1, [x8, #0x718] ; @selector(class) | 'class'
0x208f3e8: adrp     x8, #0x25f4000
0x208f3ec: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f3f0: blr      x8
0x208f3f4: adrp     x8, #0x2722000 ; @selector(screen)
0x208f3f8: ldr      x1, [x8, #0x460] ; @selector(configDictionary) | 'configDictionary'
0x208f3fc: adrp     x8, #0x25f4000
0x208f400: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f404: blr      x8
0x208f408: mov      x29, x29
0x208f40c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208f410: sub      x8, x29, #0x20
0x208f414: str      x8, [sp, #0x28]
0x208f418: stur     x0, [x29, #-0x20]
0x208f41c: ldur     x8, [x29, #-0x20]
0x208f420: str      x8, [sp, #8]
0x208f424: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0x208f428: ldr      x0, [x8, #0xb48]
0x208f42c: ldur     x2, [x29, #-0x18]
0x208f430: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0x208f434: ldr      x1, [x8, #0xa60] ; @selector(numberWithInteger:) | 'numberWithInteger:'
0x208f438: adrp     x8, #0x25f4000
0x208f43c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f440: blr      x8
0x208f444: mov      x29, x29
0x208f448: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208f44c: str      x0, [sp, #0x18]
0x208f450: ldur     x0, [x29, #-0x10]
0x208f454: bl       #0x202fdf8 ; _cmdString
0x208f458: mov      x29, x29
0x208f45c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208f460: ldr      x2, [sp, #0x18]
0x208f464: mov      x3, x0
0x208f468: ldr      x0, [sp, #8]
0x208f46c: str      x3, [sp, #0x10]
0x208f470: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0x208f474: ldr      x1, [x8, #0x4e8] ; @selector(setObject:forKey:) | 'setObject:forKey:'
0x208f478: adrp     x8, #0x25f4000
0x208f47c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f480: blr      x8
0x208f484: ldr      x0, [sp, #0x10]
0x208f488: adrp     x8, #0x25f4000
0x208f48c: ldr      x8, [x8, #0x650] ; _objc_release
0x208f490: blr      x8
0x208f494: ldr      x0, [sp, #0x18]
0x208f498: adrp     x8, #0x25f4000
0x208f49c: ldr      x8, [x8, #0x650] ; _objc_release
0x208f4a0: blr      x8
0x208f4a4: ldr      x8, [sp, #0x20]
0x208f4a8: ldur     x0, [x29, #-8]
0x208f4ac: ldr      x1, [x8, #0x718]
0x208f4b0: adrp     x8, #0x25f4000
0x208f4b4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f4b8: blr      x8
0x208f4bc: ldur     x2, [x29, #-0x20]
0x208f4c0: adrp     x8, #0x2722000 ; @selector(screen)
0x208f4c4: ldr      x1, [x8, #0x468] ; @selector(saveConfigDictionary:) | 'saveConfigDictionary:'
0x208f4c8: adrp     x8, #0x25f4000
0x208f4cc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f4d0: blr      x8
0x208f4d4: ldr      x0, [sp, #0x28]
0x208f4d8: mov      x1, #0
0x208f4dc: bl       #0x2289118 ; _objc_storeStrong
0x208f4e0: ldp      x29, x30, [sp, #0x50]
0x208f4e4: add      sp, sp, #0x60
0x208f4e8: ret      
