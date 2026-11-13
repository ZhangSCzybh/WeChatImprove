-[WCRefineBackgroundKeepAlive notifyDropEndedOnTerminate] 0xec9b90 v16@0:8
0xec9b90: sub      sp, sp, #0xf0
0xec9b94: stp      x29, x30, [sp, #0xe0]
0xec9b98: add      x29, sp, #0xe0
0xec9b9c: stur     x0, [x29, #-8]
0xec9ba0: stur     x1, [x29, #-0x10]
0xec9ba4: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec9ba8: ldr      x0, [x8, #0xa68] ; classref WCRefineConfig | _OBJC_CLASS_$_WCRefineConfig
0xec9bac: adrp     x8, #0x271f000
0xec9bb0: ldr      x1, [x8, #0x488] ; @selector(shared) | 'shared'
0xec9bb4: adrp     x8, #0x25f4000
0xec9bb8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9bbc: blr      x8
0xec9bc0: mov      x29, x29
0xec9bc4: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec9bc8: stur     x0, [x29, #-0x68]
0xec9bcc: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9bd0: ldr      x1, [x8, #0x118] ; @selector(backgroundDropNotifyEnabled) | 'backgroundDropNotifyEnabled'
0xec9bd4: adrp     x8, #0x25f4000
0xec9bd8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9bdc: blr      x8
0xec9be0: mov      x8, x0
0xec9be4: ldur     x0, [x29, #-0x68]
0xec9be8: stur     w8, [x29, #-0x5c]
0xec9bec: adrp     x8, #0x25f4000
0xec9bf0: ldr      x8, [x8, #0x650] ; _objc_release
0xec9bf4: blr      x8
0xec9bf8: ldur     w0, [x29, #-0x5c]
0xec9bfc: tbnz     w0, #0, #0xec9c08
0xec9c00: b        #0xec9c04
0xec9c04: b        #0xec9f7c
0xec9c08: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec9c0c: ldr      x0, [x8, #0xa68] ; classref WCRefineConfig | _OBJC_CLASS_$_WCRefineConfig
0xec9c10: adrp     x8, #0x271f000
0xec9c14: ldr      x1, [x8, #0x488] ; @selector(shared) | 'shared'
0xec9c18: adrp     x8, #0x25f4000
0xec9c1c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9c20: blr      x8
0xec9c24: mov      x29, x29
0xec9c28: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec9c2c: str      x0, [sp, #0x68]
0xec9c30: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9c34: ldr      x1, [x8, #0x110] ; @selector(backgroundKeepAliveEnabled) | 'backgroundKeepAliveEnabled'
0xec9c38: adrp     x8, #0x25f4000
0xec9c3c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9c40: blr      x8
0xec9c44: mov      w8, #0
0xec9c48: and      w8, w8, #1
0xec9c4c: and      w8, w8, #1
0xec9c50: sturb    w8, [x29, #-0x19]
0xec9c54: mov      w8, #0
0xec9c58: stur     w8, [x29, #-0x6c]
0xec9c5c: tbnz     w0, #0, #0xec9cac
0xec9c60: b        #0xec9c64
0xec9c64: ldur     x0, [x29, #-8]
0xec9c68: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9c6c: ldr      x1, [x8, #0x180] ; @selector(backgroundEnteredAt) | 'backgroundEnteredAt'
0xec9c70: adrp     x8, #0x25f4000
0xec9c74: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9c78: blr      x8
0xec9c7c: mov      x29, x29
0xec9c80: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec9c84: mov      x8, x0
0xec9c88: stur     x8, [x29, #-0x18]
0xec9c8c: mov      w8, #1
0xec9c90: and      w8, w8, #1
0xec9c94: and      w8, w8, #1
0xec9c98: sturb    w8, [x29, #-0x19]
0xec9c9c: subs     x8, x0, #0
0xec9ca0: cset     w8, eq
0xec9ca4: stur     w8, [x29, #-0x6c]
0xec9ca8: b        #0xec9cac
0xec9cac: ldur     w8, [x29, #-0x6c]
0xec9cb0: str      w8, [sp, #0x64]
0xec9cb4: ldurb    w8, [x29, #-0x19]
0xec9cb8: tbz      w8, #0, #0xec9cd4
0xec9cbc: b        #0xec9cc0
0xec9cc0: ldur     x0, [x29, #-0x18]
0xec9cc4: adrp     x8, #0x25f4000
0xec9cc8: ldr      x8, [x8, #0x650] ; _objc_release
0xec9ccc: blr      x8
0xec9cd0: b        #0xec9cd4
0xec9cd4: ldr      x0, [sp, #0x68]
0xec9cd8: adrp     x8, #0x25f4000
0xec9cdc: ldr      x8, [x8, #0x650] ; _objc_release
0xec9ce0: blr      x8
0xec9ce4: ldr      w8, [sp, #0x64]
0xec9ce8: tbz      w8, #0, #0xec9cf4
0xec9cec: b        #0xec9cf0
0xec9cf0: b        #0xec9f7c
0xec9cf4: ldur     x0, [x29, #-8]
0xec9cf8: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9cfc: ldr      x1, [x8, #0x260] ; @selector(didNotifyDropEnded) | 'didNotifyDropEnded'
0xec9d00: adrp     x8, #0x25f4000
0xec9d04: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9d08: blr      x8
0xec9d0c: tbz      w0, #0, #0xec9d18
0xec9d10: b        #0xec9d14
0xec9d14: b        #0xec9f7c
0xec9d18: fmov     d0, xzr
0xec9d1c: stur     d0, [x29, #-0x28]
0xec9d20: ldur     x0, [x29, #-8]
0xec9d24: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9d28: ldr      x1, [x8, #0x180] ; @selector(backgroundEnteredAt) | 'backgroundEnteredAt'
0xec9d2c: adrp     x8, #0x25f4000
0xec9d30: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9d34: blr      x8
0xec9d38: mov      x29, x29
0xec9d3c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec9d40: str      x0, [sp, #0x58]
0xec9d44: adrp     x8, #0x25f4000
0xec9d48: ldr      x8, [x8, #0x650] ; _objc_release
0xec9d4c: blr      x8
0xec9d50: ldr      x0, [sp, #0x58]
0xec9d54: cbz      x0, #0xec9dec
0xec9d58: b        #0xec9d5c
0xec9d5c: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec9d60: ldr      x0, [x8, #0xa98]
0xec9d64: adrp     x8, #0x271f000
0xec9d68: ldr      x1, [x8, #0x500] ; @selector(date) | 'date'
0xec9d6c: adrp     x8, #0x25f4000
0xec9d70: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9d74: blr      x8
0xec9d78: mov      x29, x29
0xec9d7c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec9d80: str      x0, [sp, #0x50]
0xec9d84: ldur     x0, [x29, #-8]
0xec9d88: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9d8c: ldr      x1, [x8, #0x180] ; @selector(backgroundEnteredAt) | 'backgroundEnteredAt'
0xec9d90: adrp     x8, #0x25f4000
0xec9d94: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9d98: blr      x8
0xec9d9c: mov      x29, x29
0xec9da0: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec9da4: mov      x2, x0
0xec9da8: ldr      x0, [sp, #0x50]
0xec9dac: str      x2, [sp, #0x48]
0xec9db0: adrp     x8, #0x271f000
0xec9db4: ldr      x1, [x8, #0x530] ; @selector(timeIntervalSinceDate:) | 'timeIntervalSinceDate:'
0xec9db8: adrp     x8, #0x25f4000
0xec9dbc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9dc0: blr      x8
0xec9dc4: ldr      x0, [sp, #0x48]
0xec9dc8: stur     d0, [x29, #-0x28]
0xec9dcc: adrp     x8, #0x25f4000
0xec9dd0: ldr      x8, [x8, #0x650] ; _objc_release
0xec9dd4: blr      x8
0xec9dd8: ldr      x0, [sp, #0x50]
0xec9ddc: adrp     x8, #0x25f4000
0xec9de0: ldr      x8, [x8, #0x650] ; _objc_release
0xec9de4: blr      x8
0xec9de8: b        #0xec9dec
0xec9dec: ldur     x0, [x29, #-8]
0xec9df0: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9df4: ldr      x1, [x8, #0x160] ; @selector(setDidNotifyDropEnded:) | 'setDidNotifyDropEnded:'
0xec9df8: adrp     x8, #0x25f4000
0xec9dfc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9e00: mov      w9, #1
0xec9e04: and      w2, w9, #1
0xec9e08: blr      x8
0xec9e0c: ldur     x0, [x29, #-8]
0xec9e10: adrp     x8, #0x271f000
0xec9e14: ldr      x1, [x8, #0x718] ; @selector(class) | 'class'
0xec9e18: adrp     x8, #0x25f4000
0xec9e1c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9e20: blr      x8
0xec9e24: str      x0, [sp, #0x40]
0xec9e28: ldur     d0, [x29, #-0x28]
0xec9e2c: stur     d0, [x29, #-0x38]
0xec9e30: stur     wzr, [x29, #-0x3c]
0xec9e34: ldur     d0, [x29, #-0x38]
0xec9e38: ldur     s2, [x29, #-0x3c]
0xec9e3c: fmov     s1, s2
0xec9e40: sshll    v1.2d, v1.2s, #0
0xec9e44: scvtf    d1, d1
0xec9e48: fcmp     d0, d1
0xec9e4c: b.pl     #0xec9e6c
0xec9e50: b        #0xec9e54
0xec9e54: ldur     s1, [x29, #-0x3c]
0xec9e58: fmov     s0, s1
0xec9e5c: sshll    v0.2d, v0.2s, #0
0xec9e60: scvtf    d0, d0
0xec9e64: str      d0, [sp, #0x38]
0xec9e68: b        #0xec9e78
0xec9e6c: ldur     d0, [x29, #-0x38]
0xec9e70: str      d0, [sp, #0x38]
0xec9e74: b        #0xec9e78
0xec9e78: ldr      x0, [sp, #0x40]
0xec9e7c: ldr      d0, [sp, #0x38]
0xec9e80: stur     d0, [x29, #-0x48]
0xec9e84: ldur     d0, [x29, #-0x48]
0xec9e88: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9e8c: ldr      x1, [x8, #0x268] ; @selector(formattedBackgroundDuration:) | 'formattedBackgroundDuration:'
0xec9e90: adrp     x8, #0x25f4000
0xec9e94: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9e98: blr      x8
0xec9e9c: mov      x29, x29
0xec9ea0: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec9ea4: sub      x8, x29, #0x30
0xec9ea8: str      x8, [sp, #0x28]
0xec9eac: stur     x0, [x29, #-0x30]
0xec9eb0: adrp     x8, #0x25f4000
0xec9eb4: ldr      x8, [x8, #0x658] ; _objc_retain
0xec9eb8: adrp     x0, #0x2645000
0xec9ebc: add      x0, x0, #0xbb0 ; @'后台保活即将失效'
0xec9ec0: str      x0, [sp, #0x10] ; @'后台保活即将失效'
0xec9ec4: blr      x8
0xec9ec8: ldr      x8, [sp, #0x10]
0xec9ecc: sub      x9, x29, #0x50
0xec9ed0: str      x9, [sp, #0x20]
0xec9ed4: stur     x8, [x29, #-0x50]
0xec9ed8: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec9edc: ldr      x0, [x8, #0xaf8]
0xec9ee0: ldur     x9, [x29, #-0x30]
0xec9ee4: adrp     x8, #0x271f000
0xec9ee8: ldr      x1, [x8, #0x660] ; @selector(stringWithFormat:) | 'stringWithFormat:'
0xec9eec: adrp     x8, #0x25f4000
0xec9ef0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9ef4: mov      x10, sp
0xec9ef8: str      x9, [x10]
0xec9efc: adrp     x2, #0x2645000
0xec9f00: add      x2, x2, #0xbd0 ; @'当前保活时长 %@'
0xec9f04: blr      x8
0xec9f08: mov      x29, x29
0xec9f0c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec9f10: sub      x8, x29, #0x58
0xec9f14: str      x8, [sp, #0x18]
0xec9f18: stur     x0, [x29, #-0x58]
0xec9f1c: ldur     x0, [x29, #-8]
0xec9f20: adrp     x8, #0x271f000
0xec9f24: ldr      x1, [x8, #0x718] ; @selector(class) | 'class'
0xec9f28: adrp     x8, #0x25f4000
0xec9f2c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9f30: blr      x8
0xec9f34: ldur     x2, [x29, #-0x50]
0xec9f38: ldur     x3, [x29, #-0x58]
0xec9f3c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9f40: ldr      x1, [x8, #0x270] ; @selector(sendTerminateLocalNotificationWithTitle:body:) | 'sendTerminateLocalNotificationWithTitle:body:'
0xec9f44: adrp     x8, #0x25f4000
0xec9f48: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9f4c: blr      x8
0xec9f50: ldr      x0, [sp, #0x18]
0xec9f54: mov      x1, #0
0xec9f58: str      x1, [sp, #0x30]
0xec9f5c: bl       #0x2289118 ; _objc_storeStrong
0xec9f60: ldr      x0, [sp, #0x20]
0xec9f64: ldr      x1, [sp, #0x30]
0xec9f68: bl       #0x2289118 ; _objc_storeStrong
0xec9f6c: ldr      x0, [sp, #0x28]
0xec9f70: ldr      x1, [sp, #0x30]
0xec9f74: bl       #0x2289118 ; _objc_storeStrong
0xec9f78: b        #0xec9f7c
0xec9f7c: ldp      x29, x30, [sp, #0xe0]
0xec9f80: add      sp, sp, #0xf0
0xec9f84: ret      
