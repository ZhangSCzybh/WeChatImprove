-[WCRefineBackgroundKeepAlive refreshSettings] 0xec7cbc v16@0:8
0xec7cbc: sub      sp, sp, #0x40
0xec7cc0: stp      x29, x30, [sp, #0x30]
0xec7cc4: add      x29, sp, #0x30
0xec7cc8: stur     x0, [x29, #-8]
0xec7ccc: stur     x1, [x29, #-0x10]
0xec7cd0: ldur     x0, [x29, #-8]
0xec7cd4: adrp     x8, #0x271f000
0xec7cd8: ldr      x1, [x8, #0x718] ; @selector(class) | 'class'
0xec7cdc: adrp     x8, #0x25f4000
0xec7ce0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7ce4: blr      x8
0xec7ce8: str      x0, [sp, #0x10]
0xec7cec: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec7cf0: ldr      x0, [x8, #0xa68] ; classref WCRefineConfig | _OBJC_CLASS_$_WCRefineConfig
0xec7cf4: adrp     x8, #0x271f000
0xec7cf8: ldr      x1, [x8, #0x488] ; @selector(shared) | 'shared'
0xec7cfc: adrp     x8, #0x25f4000
0xec7d00: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7d04: blr      x8
0xec7d08: mov      x29, x29
0xec7d0c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec7d10: str      x0, [sp, #0x18]
0xec7d14: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7d18: ldr      x1, [x8, #0x100] ; @selector(backgroundKeepAliveInterval) | 'backgroundKeepAliveInterval'
0xec7d1c: adrp     x8, #0x25f4000
0xec7d20: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7d24: blr      x8
0xec7d28: mov      x2, x0
0xec7d2c: ldr      x0, [sp, #0x10]
0xec7d30: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7d34: ldr      x1, [x8, #0x108] ; @selector(clampedInterval:) | 'clampedInterval:'
0xec7d38: adrp     x8, #0x25f4000
0xec7d3c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7d40: blr      x8
0xec7d44: ldur     x0, [x29, #-8]
0xec7d48: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7d4c: ldr      x1, [x8, #0x120] ; @selector(setTimerInterval:) | 'setTimerInterval:'
0xec7d50: adrp     x8, #0x25f4000
0xec7d54: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7d58: blr      x8
0xec7d5c: ldr      x0, [sp, #0x18]
0xec7d60: adrp     x8, #0x25f4000
0xec7d64: ldr      x8, [x8, #0x650] ; _objc_release
0xec7d68: blr      x8
0xec7d6c: ldur     x0, [x29, #-8]
0xec7d70: adrp     x8, #0x2723000 ; @selector(menuArrowColorEnabled)
0xec7d74: ldr      x1, [x8, #0x9f0] ; @selector(isEnabled) | 'isEnabled'
0xec7d78: adrp     x8, #0x25f4000
0xec7d7c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7d80: blr      x8
0xec7d84: tbnz     w0, #0, #0xec7dc0
0xec7d88: b        #0xec7d8c
0xec7d8c: ldur     x0, [x29, #-8]
0xec7d90: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7d94: ldr      x1, [x8, #0x128] ; @selector(unregisterObserversIfNeeded) | 'unregisterObserversIfNeeded'
0xec7d98: adrp     x8, #0x25f4000
0xec7d9c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7da0: blr      x8
0xec7da4: ldur     x0, [x29, #-8]
0xec7da8: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0xec7dac: ldr      x1, [x8, #0x738] ; @selector(stop) | 'stop'
0xec7db0: adrp     x8, #0x25f4000
0xec7db4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7db8: blr      x8
0xec7dbc: b        #0xec7ea4
0xec7dc0: ldur     x0, [x29, #-8]
0xec7dc4: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7dc8: ldr      x1, [x8, #0x130] ; @selector(registerObserversIfNeeded) | 'registerObserversIfNeeded'
0xec7dcc: adrp     x8, #0x25f4000
0xec7dd0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7dd4: blr      x8
0xec7dd8: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec7ddc: ldr      x0, [x8, #0xa68] ; classref WCRefineConfig | _OBJC_CLASS_$_WCRefineConfig
0xec7de0: adrp     x8, #0x271f000
0xec7de4: ldr      x1, [x8, #0x488] ; @selector(shared) | 'shared'
0xec7de8: adrp     x8, #0x25f4000
0xec7dec: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7df0: blr      x8
0xec7df4: mov      x29, x29
0xec7df8: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec7dfc: str      x0, [sp]
0xec7e00: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7e04: ldr      x1, [x8, #0x118] ; @selector(backgroundDropNotifyEnabled) | 'backgroundDropNotifyEnabled'
0xec7e08: adrp     x8, #0x25f4000
0xec7e0c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7e10: blr      x8
0xec7e14: mov      x8, x0
0xec7e18: ldr      x0, [sp]
0xec7e1c: str      w8, [sp, #0xc]
0xec7e20: adrp     x8, #0x25f4000
0xec7e24: ldr      x8, [x8, #0x650] ; _objc_release
0xec7e28: blr      x8
0xec7e2c: ldr      w0, [sp, #0xc]
0xec7e30: tbz      w0, #0, #0xec7e68
0xec7e34: b        #0xec7e38
0xec7e38: ldur     x0, [x29, #-8]
0xec7e3c: adrp     x8, #0x271f000
0xec7e40: ldr      x1, [x8, #0x718] ; @selector(class) | 'class'
0xec7e44: adrp     x8, #0x25f4000
0xec7e48: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7e4c: blr      x8
0xec7e50: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7e54: ldr      x1, [x8, #0x138] ; @selector(requestNotificationPermissionIfNeeded) | 'requestNotificationPermissionIfNeeded'
0xec7e58: adrp     x8, #0x25f4000
0xec7e5c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7e60: blr      x8
0xec7e64: b        #0xec7e68
0xec7e68: ldur     x0, [x29, #-8]
0xec7e6c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7e70: ldr      x1, [x8, #0x140] ; @selector(isInBackground) | 'isInBackground'
0xec7e74: adrp     x8, #0x25f4000
0xec7e78: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7e7c: blr      x8
0xec7e80: tbz      w0, #0, #0xec7ea4
0xec7e84: b        #0xec7e88
0xec7e88: ldur     x0, [x29, #-8]
0xec7e8c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7e90: ldr      x1, [x8, #0x148] ; @selector(startIfNeeded) | 'startIfNeeded'
0xec7e94: adrp     x8, #0x25f4000
0xec7e98: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7e9c: blr      x8
0xec7ea0: b        #0xec7ea4
0xec7ea4: ldp      x29, x30, [sp, #0x30]
0xec7ea8: add      sp, sp, #0x40
0xec7eac: ret      
