+[WCRefineBackgroundKeepAlive formattedBackgroundDuration:] 0xec9f88 @24@0:8d16
0xec9f88: sub      sp, sp, #0x90
0xec9f8c: stp      x29, x30, [sp, #0x80]
0xec9f90: add      x29, sp, #0x80
0xec9f94: mov      x8, #0x5180
0xec9f98: movk     x8, #1, lsl #16
0xec9f9c: str      x8, [sp, #0x20]
0xec9fa0: stur     x0, [x29, #-0x10]
0xec9fa4: stur     x1, [x29, #-0x18]
0xec9fa8: stur     d0, [x29, #-0x20]
0xec9fac: ldur     d0, [x29, #-0x20]
0xec9fb0: fcvtzs   x8, d0
0xec9fb4: stur     x8, [x29, #-0x28]
0xec9fb8: ldur     x8, [x29, #-0x28]
0xec9fbc: subs     x8, x8, #0
0xec9fc0: b.gt     #0xec9fec
0xec9fc4: b        #0xec9fc8
0xec9fc8: adrp     x8, #0x25f4000
0xec9fcc: ldr      x8, [x8, #0x658] ; _objc_retain
0xec9fd0: adrp     x0, #0x2645000
0xec9fd4: add      x0, x0, #0xbf0 ; @'0秒'
0xec9fd8: str      x0, [sp, #0x18] ; @'0秒'
0xec9fdc: blr      x8
0xec9fe0: ldr      x8, [sp, #0x18]
0xec9fe4: stur     x8, [x29, #-8]
0xec9fe8: b        #0xeca298
0xec9fec: ldur     x8, [x29, #-0x28]
0xec9ff0: subs     x8, x8, #0x3c
0xec9ff4: b.ge     #0xeca03c
0xec9ff8: b        #0xec9ffc
0xec9ffc: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xeca000: ldr      x0, [x8, #0xaf8]
0xeca004: ldur     x9, [x29, #-0x28]
0xeca008: adrp     x8, #0x271f000
0xeca00c: ldr      x1, [x8, #0x660] ; @selector(stringWithFormat:) | 'stringWithFormat:'
0xeca010: adrp     x8, #0x25f4000
0xeca014: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca018: mov      x10, sp
0xeca01c: str      x9, [x10]
0xeca020: adrp     x2, #0x2645000
0xeca024: add      x2, x2, #0xc10 ; @'%lld秒'
0xeca028: blr      x8
0xeca02c: mov      x29, x29
0xeca030: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xeca034: stur     x0, [x29, #-8]
0xeca038: b        #0xeca298
0xeca03c: ldur     x8, [x29, #-0x28]
0xeca040: subs     x8, x8, #0xe10
0xeca044: b.ge     #0xeca104
0xeca048: b        #0xeca04c
0xeca04c: ldur     x8, [x29, #-0x28]
0xeca050: mov      x10, #0x3c
0xeca054: sdiv     x8, x8, x10
0xeca058: stur     x8, [x29, #-0x30]
0xeca05c: ldur     x8, [x29, #-0x28]
0xeca060: sdiv     x9, x8, x10
0xeca064: mul      x9, x9, x10
0xeca068: subs     x8, x8, x9
0xeca06c: stur     x8, [x29, #-0x38]
0xeca070: ldur     x8, [x29, #-0x38]
0xeca074: cbnz     x8, #0xeca0bc
0xeca078: b        #0xeca07c
0xeca07c: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xeca080: ldr      x0, [x8, #0xaf8]
0xeca084: ldur     x9, [x29, #-0x30]
0xeca088: adrp     x8, #0x271f000
0xeca08c: ldr      x1, [x8, #0x660] ; @selector(stringWithFormat:) | 'stringWithFormat:'
0xeca090: adrp     x8, #0x25f4000
0xeca094: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca098: mov      x10, sp
0xeca09c: str      x9, [x10]
0xeca0a0: adrp     x2, #0x2645000
0xeca0a4: add      x2, x2, #0xc30 ; @'%lld分'
0xeca0a8: blr      x8
0xeca0ac: mov      x29, x29
0xeca0b0: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xeca0b4: stur     x0, [x29, #-8]
0xeca0b8: b        #0xeca298
0xeca0bc: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xeca0c0: ldr      x0, [x8, #0xaf8]
0xeca0c4: ldur     x11, [x29, #-0x30]
0xeca0c8: ldur     x9, [x29, #-0x38]
0xeca0cc: adrp     x8, #0x271f000
0xeca0d0: ldr      x1, [x8, #0x660] ; @selector(stringWithFormat:) | 'stringWithFormat:'
0xeca0d4: adrp     x8, #0x25f4000
0xeca0d8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca0dc: mov      x10, sp
0xeca0e0: str      x11, [x10]
0xeca0e4: str      x9, [x10, #8]
0xeca0e8: adrp     x2, #0x2645000
0xeca0ec: add      x2, x2, #0xc50 ; @'%lld分%lld秒'
0xeca0f0: blr      x8
0xeca0f4: mov      x29, x29
0xeca0f8: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xeca0fc: stur     x0, [x29, #-8]
0xeca100: b        #0xeca298
0xeca104: ldr      x9, [sp, #0x20]
0xeca108: ldur     x8, [x29, #-0x28]
0xeca10c: subs     x8, x8, x9
0xeca110: b.ge     #0xeca1d8
0xeca114: b        #0xeca118
0xeca118: ldur     x8, [x29, #-0x28]
0xeca11c: mov      x10, #0xe10
0xeca120: sdiv     x8, x8, x10
0xeca124: str      x8, [sp, #0x40]
0xeca128: ldur     x8, [x29, #-0x28]
0xeca12c: sdiv     x9, x8, x10
0xeca130: mul      x9, x9, x10
0xeca134: subs     x8, x8, x9
0xeca138: mov      x9, #0x3c
0xeca13c: sdiv     x8, x8, x9
0xeca140: str      x8, [sp, #0x38]
0xeca144: ldr      x8, [sp, #0x38]
0xeca148: cbnz     x8, #0xeca190
0xeca14c: b        #0xeca150
0xeca150: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xeca154: ldr      x0, [x8, #0xaf8]
0xeca158: ldr      x9, [sp, #0x40]
0xeca15c: adrp     x8, #0x271f000
0xeca160: ldr      x1, [x8, #0x660] ; @selector(stringWithFormat:) | 'stringWithFormat:'
0xeca164: adrp     x8, #0x25f4000
0xeca168: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca16c: mov      x10, sp
0xeca170: str      x9, [x10]
0xeca174: adrp     x2, #0x2645000
0xeca178: add      x2, x2, #0xc70 ; @'%lld小时'
0xeca17c: blr      x8
0xeca180: mov      x29, x29
0xeca184: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xeca188: stur     x0, [x29, #-8]
0xeca18c: b        #0xeca298
0xeca190: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xeca194: ldr      x0, [x8, #0xaf8]
0xeca198: ldr      x11, [sp, #0x40]
0xeca19c: ldr      x9, [sp, #0x38]
0xeca1a0: adrp     x8, #0x271f000
0xeca1a4: ldr      x1, [x8, #0x660] ; @selector(stringWithFormat:) | 'stringWithFormat:'
0xeca1a8: adrp     x8, #0x25f4000
0xeca1ac: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca1b0: mov      x10, sp
0xeca1b4: str      x11, [x10]
0xeca1b8: str      x9, [x10, #8]
0xeca1bc: adrp     x2, #0x2645000
0xeca1c0: add      x2, x2, #0xc90 ; @'%lld小时%lld分'
0xeca1c4: blr      x8
0xeca1c8: mov      x29, x29
0xeca1cc: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xeca1d0: stur     x0, [x29, #-8]
0xeca1d4: b        #0xeca298
0xeca1d8: ldr      x10, [sp, #0x20]
0xeca1dc: ldur     x8, [x29, #-0x28]
0xeca1e0: sdiv     x8, x8, x10
0xeca1e4: str      x8, [sp, #0x30]
0xeca1e8: ldur     x8, [x29, #-0x28]
0xeca1ec: sdiv     x9, x8, x10
0xeca1f0: mul      x9, x9, x10
0xeca1f4: subs     x8, x8, x9
0xeca1f8: mov      x9, #0xe10
0xeca1fc: sdiv     x8, x8, x9
0xeca200: str      x8, [sp, #0x28]
0xeca204: ldr      x8, [sp, #0x28]
0xeca208: cbnz     x8, #0xeca250
0xeca20c: b        #0xeca210
0xeca210: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xeca214: ldr      x0, [x8, #0xaf8]
0xeca218: ldr      x9, [sp, #0x30]
0xeca21c: adrp     x8, #0x271f000
0xeca220: ldr      x1, [x8, #0x660] ; @selector(stringWithFormat:) | 'stringWithFormat:'
0xeca224: adrp     x8, #0x25f4000
0xeca228: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca22c: mov      x10, sp
0xeca230: str      x9, [x10]
0xeca234: adrp     x2, #0x2645000
0xeca238: add      x2, x2, #0xcb0 ; @'%lld天'
0xeca23c: blr      x8
0xeca240: mov      x29, x29
0xeca244: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xeca248: stur     x0, [x29, #-8]
0xeca24c: b        #0xeca298
0xeca250: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xeca254: ldr      x0, [x8, #0xaf8]
0xeca258: ldr      x11, [sp, #0x30]
0xeca25c: ldr      x9, [sp, #0x28]
0xeca260: adrp     x8, #0x271f000
0xeca264: ldr      x1, [x8, #0x660] ; @selector(stringWithFormat:) | 'stringWithFormat:'
0xeca268: adrp     x8, #0x25f4000
0xeca26c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca270: mov      x10, sp
0xeca274: str      x11, [x10]
0xeca278: str      x9, [x10, #8]
0xeca27c: adrp     x2, #0x2645000
0xeca280: add      x2, x2, #0xcd0 ; @'%lld天%lld小时'
0xeca284: blr      x8
0xeca288: mov      x29, x29
0xeca28c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xeca290: stur     x0, [x29, #-8]
0xeca294: b        #0xeca298
0xeca298: ldur     x0, [x29, #-8]
0xeca29c: ldp      x29, x30, [sp, #0x80]
0xeca2a0: add      sp, sp, #0x90
0xeca2a4: b        #0x2288f98 ; _objc_autoreleaseReturnValue
