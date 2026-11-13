-[WCRefineBackgroundKeepAlive isDropNotifyEnabled] 0xec7bd4 B16@0:8
0xec7bd4: sub      sp, sp, #0x40
0xec7bd8: stp      x29, x30, [sp, #0x30]
0xec7bdc: add      x29, sp, #0x30
0xec7be0: stur     x0, [x29, #-0x10]
0xec7be4: str      x1, [sp, #0x18]
0xec7be8: ldur     x0, [x29, #-0x10]
0xec7bec: adrp     x8, #0x2723000 ; @selector(menuArrowColorEnabled)
0xec7bf0: ldr      x1, [x8, #0x9f0] ; @selector(isEnabled) | 'isEnabled'
0xec7bf4: adrp     x8, #0x25f4000
0xec7bf8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7bfc: blr      x8
0xec7c00: mov      w8, #0
0xec7c04: and      w8, w8, #1
0xec7c08: and      w8, w8, #1
0xec7c0c: strb     w8, [sp, #0xf]
0xec7c10: mov      w8, #0
0xec7c14: str      w8, [sp, #8]
0xec7c18: tbz      w0, #0, #0xec7c78
0xec7c1c: b        #0xec7c20
0xec7c20: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec7c24: ldr      x0, [x8, #0xa68] ; classref WCRefineConfig | _OBJC_CLASS_$_WCRefineConfig
0xec7c28: adrp     x8, #0x271f000
0xec7c2c: ldr      x1, [x8, #0x488] ; @selector(shared) | 'shared'
0xec7c30: adrp     x8, #0x25f4000
0xec7c34: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7c38: blr      x8
0xec7c3c: mov      x29, x29
0xec7c40: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec7c44: mov      x8, x0
0xec7c48: str      x8, [sp, #0x10]
0xec7c4c: mov      w8, #1
0xec7c50: and      w8, w8, #1
0xec7c54: and      w8, w8, #1
0xec7c58: strb     w8, [sp, #0xf]
0xec7c5c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7c60: ldr      x1, [x8, #0x118] ; @selector(backgroundDropNotifyEnabled) | 'backgroundDropNotifyEnabled'
0xec7c64: adrp     x8, #0x25f4000
0xec7c68: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7c6c: blr      x8
0xec7c70: str      w0, [sp, #8]
0xec7c74: b        #0xec7c78
0xec7c78: ldr      w8, [sp, #8]
0xec7c7c: and      w8, w8, #1
0xec7c80: and      w8, w8, #1
0xec7c84: sturb    w8, [x29, #-1]
0xec7c88: ldrb     w8, [sp, #0xf]
0xec7c8c: tbz      w8, #0, #0xec7ca8
0xec7c90: b        #0xec7c94
0xec7c94: ldr      x0, [sp, #0x10]
0xec7c98: adrp     x8, #0x25f4000
0xec7c9c: ldr      x8, [x8, #0x650] ; _objc_release
0xec7ca0: blr      x8
0xec7ca4: b        #0xec7ca8
0xec7ca8: ldurb    w8, [x29, #-1]
0xec7cac: and      w0, w8, #1
0xec7cb0: ldp      x29, x30, [sp, #0x30]
0xec7cb4: add      sp, sp, #0x40
0xec7cb8: ret      
