-[WCRefineConfig setBackgroundDropNotifyEnabled:] 0x208f6bc v20@0:8B16
0x208f6bc: sub      sp, sp, #0x60
0x208f6c0: stp      x29, x30, [sp, #0x50]
0x208f6c4: add      x29, sp, #0x50
0x208f6c8: stur     x0, [x29, #-8]
0x208f6cc: stur     x1, [x29, #-0x10]
0x208f6d0: sturb    w2, [x29, #-0x11]
0x208f6d4: ldur     x0, [x29, #-8]
0x208f6d8: adrp     x8, #0x271f000
0x208f6dc: str      x8, [sp, #0x20]
0x208f6e0: ldr      x1, [x8, #0x718] ; @selector(class) | 'class'
0x208f6e4: adrp     x8, #0x25f4000
0x208f6e8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f6ec: blr      x8
0x208f6f0: adrp     x8, #0x2722000 ; @selector(screen)
0x208f6f4: ldr      x1, [x8, #0x460] ; @selector(configDictionary) | 'configDictionary'
0x208f6f8: adrp     x8, #0x25f4000
0x208f6fc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f700: blr      x8
0x208f704: mov      x29, x29
0x208f708: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208f70c: sub      x8, x29, #0x20
0x208f710: str      x8, [sp, #0x28]
0x208f714: stur     x0, [x29, #-0x20]
0x208f718: ldur     x8, [x29, #-0x20]
0x208f71c: str      x8, [sp, #8]
0x208f720: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0x208f724: ldr      x0, [x8, #0xb48]
0x208f728: ldurb    w8, [x29, #-0x11]
0x208f72c: adrp     x9, #0x271f000
0x208f730: ldr      x1, [x9, #0x818] ; @selector(numberWithBool:) | 'numberWithBool:'
0x208f734: and      w2, w8, #1
0x208f738: adrp     x8, #0x25f4000
0x208f73c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f740: blr      x8
0x208f744: mov      x29, x29
0x208f748: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208f74c: str      x0, [sp, #0x18]
0x208f750: ldur     x0, [x29, #-0x10]
0x208f754: bl       #0x202fdf8 ; _cmdString
0x208f758: mov      x29, x29
0x208f75c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208f760: ldr      x2, [sp, #0x18]
0x208f764: mov      x3, x0
0x208f768: ldr      x0, [sp, #8]
0x208f76c: str      x3, [sp, #0x10]
0x208f770: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0x208f774: ldr      x1, [x8, #0x4e8] ; @selector(setObject:forKey:) | 'setObject:forKey:'
0x208f778: adrp     x8, #0x25f4000
0x208f77c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f780: blr      x8
0x208f784: ldr      x0, [sp, #0x10]
0x208f788: adrp     x8, #0x25f4000
0x208f78c: ldr      x8, [x8, #0x650] ; _objc_release
0x208f790: blr      x8
0x208f794: ldr      x0, [sp, #0x18]
0x208f798: adrp     x8, #0x25f4000
0x208f79c: ldr      x8, [x8, #0x650] ; _objc_release
0x208f7a0: blr      x8
0x208f7a4: ldr      x8, [sp, #0x20]
0x208f7a8: ldur     x0, [x29, #-8]
0x208f7ac: ldr      x1, [x8, #0x718]
0x208f7b0: adrp     x8, #0x25f4000
0x208f7b4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f7b8: blr      x8
0x208f7bc: ldur     x2, [x29, #-0x20]
0x208f7c0: adrp     x8, #0x2722000 ; @selector(screen)
0x208f7c4: ldr      x1, [x8, #0x468] ; @selector(saveConfigDictionary:) | 'saveConfigDictionary:'
0x208f7c8: adrp     x8, #0x25f4000
0x208f7cc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f7d0: blr      x8
0x208f7d4: ldr      x0, [sp, #0x28]
0x208f7d8: mov      x1, #0
0x208f7dc: bl       #0x2289118 ; _objc_storeStrong
0x208f7e0: ldp      x29, x30, [sp, #0x50]
0x208f7e4: add      sp, sp, #0x60
0x208f7e8: ret      
