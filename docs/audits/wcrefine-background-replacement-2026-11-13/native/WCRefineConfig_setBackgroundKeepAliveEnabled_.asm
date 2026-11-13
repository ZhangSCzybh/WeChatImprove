-[WCRefineConfig setBackgroundKeepAliveEnabled:] 0x208f018 v20@0:8B16
0x208f018: sub      sp, sp, #0x60
0x208f01c: stp      x29, x30, [sp, #0x50]
0x208f020: add      x29, sp, #0x50
0x208f024: stur     x0, [x29, #-8]
0x208f028: stur     x1, [x29, #-0x10]
0x208f02c: sturb    w2, [x29, #-0x11]
0x208f030: ldur     x0, [x29, #-8]
0x208f034: adrp     x8, #0x271f000
0x208f038: str      x8, [sp, #0x20]
0x208f03c: ldr      x1, [x8, #0x718] ; @selector(class) | 'class'
0x208f040: adrp     x8, #0x25f4000
0x208f044: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f048: blr      x8
0x208f04c: adrp     x8, #0x2722000 ; @selector(screen)
0x208f050: ldr      x1, [x8, #0x460] ; @selector(configDictionary) | 'configDictionary'
0x208f054: adrp     x8, #0x25f4000
0x208f058: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f05c: blr      x8
0x208f060: mov      x29, x29
0x208f064: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208f068: sub      x8, x29, #0x20
0x208f06c: str      x8, [sp, #0x28]
0x208f070: stur     x0, [x29, #-0x20]
0x208f074: ldur     x8, [x29, #-0x20]
0x208f078: str      x8, [sp, #8]
0x208f07c: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0x208f080: ldr      x0, [x8, #0xb48]
0x208f084: ldurb    w8, [x29, #-0x11]
0x208f088: adrp     x9, #0x271f000
0x208f08c: ldr      x1, [x9, #0x818] ; @selector(numberWithBool:) | 'numberWithBool:'
0x208f090: and      w2, w8, #1
0x208f094: adrp     x8, #0x25f4000
0x208f098: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f09c: blr      x8
0x208f0a0: mov      x29, x29
0x208f0a4: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208f0a8: str      x0, [sp, #0x18]
0x208f0ac: ldur     x0, [x29, #-0x10]
0x208f0b0: bl       #0x202fdf8 ; _cmdString
0x208f0b4: mov      x29, x29
0x208f0b8: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208f0bc: ldr      x2, [sp, #0x18]
0x208f0c0: mov      x3, x0
0x208f0c4: ldr      x0, [sp, #8]
0x208f0c8: str      x3, [sp, #0x10]
0x208f0cc: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0x208f0d0: ldr      x1, [x8, #0x4e8] ; @selector(setObject:forKey:) | 'setObject:forKey:'
0x208f0d4: adrp     x8, #0x25f4000
0x208f0d8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f0dc: blr      x8
0x208f0e0: ldr      x0, [sp, #0x10]
0x208f0e4: adrp     x8, #0x25f4000
0x208f0e8: ldr      x8, [x8, #0x650] ; _objc_release
0x208f0ec: blr      x8
0x208f0f0: ldr      x0, [sp, #0x18]
0x208f0f4: adrp     x8, #0x25f4000
0x208f0f8: ldr      x8, [x8, #0x650] ; _objc_release
0x208f0fc: blr      x8
0x208f100: ldr      x8, [sp, #0x20]
0x208f104: ldur     x0, [x29, #-8]
0x208f108: ldr      x1, [x8, #0x718]
0x208f10c: adrp     x8, #0x25f4000
0x208f110: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f114: blr      x8
0x208f118: ldur     x2, [x29, #-0x20]
0x208f11c: adrp     x8, #0x2722000 ; @selector(screen)
0x208f120: ldr      x1, [x8, #0x468] ; @selector(saveConfigDictionary:) | 'saveConfigDictionary:'
0x208f124: adrp     x8, #0x25f4000
0x208f128: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f12c: blr      x8
0x208f130: ldr      x0, [sp, #0x28]
0x208f134: mov      x1, #0
0x208f138: bl       #0x2289118 ; _objc_storeStrong
0x208f13c: ldp      x29, x30, [sp, #0x50]
0x208f140: add      sp, sp, #0x60
0x208f144: ret      
