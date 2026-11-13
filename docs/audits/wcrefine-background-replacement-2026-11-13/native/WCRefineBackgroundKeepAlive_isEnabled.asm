-[WCRefineBackgroundKeepAlive isEnabled] 0xec7b5c B16@0:8
0xec7b5c: sub      sp, sp, #0x30
0xec7b60: stp      x29, x30, [sp, #0x20]
0xec7b64: add      x29, sp, #0x20
0xec7b68: stur     x0, [x29, #-8]
0xec7b6c: str      x1, [sp, #0x10]
0xec7b70: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec7b74: ldr      x0, [x8, #0xa68] ; classref WCRefineConfig | _OBJC_CLASS_$_WCRefineConfig
0xec7b78: adrp     x8, #0x271f000
0xec7b7c: ldr      x1, [x8, #0x488] ; @selector(shared) | 'shared'
0xec7b80: adrp     x8, #0x25f4000
0xec7b84: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7b88: blr      x8
0xec7b8c: mov      x29, x29
0xec7b90: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec7b94: str      x0, [sp]
0xec7b98: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7b9c: ldr      x1, [x8, #0x110] ; @selector(backgroundKeepAliveEnabled) | 'backgroundKeepAliveEnabled'
0xec7ba0: adrp     x8, #0x25f4000
0xec7ba4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7ba8: blr      x8
0xec7bac: mov      x1, x0
0xec7bb0: ldr      x0, [sp]
0xec7bb4: str      w1, [sp, #0xc]
0xec7bb8: adrp     x8, #0x25f4000
0xec7bbc: ldr      x8, [x8, #0x650] ; _objc_release
0xec7bc0: blr      x8
0xec7bc4: ldr      w0, [sp, #0xc]
0xec7bc8: ldp      x29, x30, [sp, #0x20]
0xec7bcc: add      sp, sp, #0x30
0xec7bd0: ret      
