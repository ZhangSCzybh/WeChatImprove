-[WCRefineBackgroundKeepAlive ensureAudioPlaying] 0xec8a08 v16@0:8
0xec8a08: sub      sp, sp, #0x160
0xec8a0c: stp      x28, x27, [sp, #0x140]
0xec8a10: stp      x29, x30, [sp, #0x150]
0xec8a14: add      x29, sp, #0x150
0xec8a18: stur     x0, [x29, #-0x18]
0xec8a1c: stur     x1, [x29, #-0x20]
0xec8a20: bl       #0xec75c0
0xec8a24: tbz      w0, #0, #0xec8af0
0xec8a28: b        #0xec8a2c
0xec8a2c: ldur     x0, [x29, #-0x18]
0xec8a30: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8a34: ldr      x1, [x8, #0x208] ; @selector(silentPlayer) | 'silentPlayer'
0xec8a38: adrp     x8, #0x25f4000
0xec8a3c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8a40: blr      x8
0xec8a44: mov      x29, x29
0xec8a48: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec8a4c: stur     x0, [x29, #-0xa0]
0xec8a50: mov      w8, #1
0xec8a54: stur     w8, [x29, #-0x98]
0xec8a58: cbnz     x0, #0xec8a84
0xec8a5c: b        #0xec8a60
0xec8a60: ldur     x0, [x29, #-0x18]
0xec8a64: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8a68: ldr      x1, [x8, #0x210] ; @selector(yieldedForHostCall) | 'yieldedForHostCall'
0xec8a6c: adrp     x8, #0x25f4000
0xec8a70: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8a74: blr      x8
0xec8a78: eor      w8, w0, #1
0xec8a7c: stur     w8, [x29, #-0x98]
0xec8a80: b        #0xec8a84
0xec8a84: ldur     x0, [x29, #-0xa0]
0xec8a88: ldur     w8, [x29, #-0x98]
0xec8a8c: stur     w8, [x29, #-0xa4]
0xec8a90: adrp     x8, #0x25f4000
0xec8a94: ldr      x8, [x8, #0x650] ; _objc_release
0xec8a98: blr      x8
0xec8a9c: ldur     w8, [x29, #-0xa4]
0xec8aa0: tbz      w8, #0, #0xec8ab4
0xec8aa4: b        #0xec8aa8
0xec8aa8: b        #0xec8aac
0xec8aac: b        #0xec8ab0
0xec8ab0: b        #0xec8ab4
0xec8ab4: ldur     x0, [x29, #-0x18]
0xec8ab8: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8abc: ldr      x1, [x8, #0x170] ; @selector(setYieldedForHostCall:) | 'setYieldedForHostCall:'
0xec8ac0: adrp     x8, #0x25f4000
0xec8ac4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8ac8: mov      w9, #1
0xec8acc: and      w2, w9, #1
0xec8ad0: blr      x8
0xec8ad4: ldur     x0, [x29, #-0x18]
0xec8ad8: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8adc: ldr      x1, [x8, #0x178] ; @selector(stopAudio) | 'stopAudio'
0xec8ae0: adrp     x8, #0x25f4000
0xec8ae4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8ae8: blr      x8
0xec8aec: b        #0xec920c
0xec8af0: ldur     x0, [x29, #-0x18]
0xec8af4: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8af8: ldr      x1, [x8, #0x210] ; @selector(yieldedForHostCall) | 'yieldedForHostCall'
0xec8afc: adrp     x8, #0x25f4000
0xec8b00: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8b04: blr      x8
0xec8b08: tbz      w0, #0, #0xec8b3c
0xec8b0c: b        #0xec8b10
0xec8b10: b        #0xec8b14
0xec8b14: b        #0xec8b18
0xec8b18: ldur     x0, [x29, #-0x18]
0xec8b1c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8b20: ldr      x1, [x8, #0x170] ; @selector(setYieldedForHostCall:) | 'setYieldedForHostCall:'
0xec8b24: adrp     x8, #0x25f4000
0xec8b28: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8b2c: mov      w9, #0
0xec8b30: and      w2, w9, #1
0xec8b34: blr      x8
0xec8b38: b        #0xec8b3c
0xec8b3c: stur     xzr, [x29, #-0x28]
0xec8b40: adrp     x8, #0x2752000
0xec8b44: ldr      x0, [x8, #0x500]
0xec8b48: adrp     x8, #0x271f000
0xec8b4c: ldr      x1, [x8, #0x6e8] ; @selector(sharedInstance) | 'sharedInstance'
0xec8b50: adrp     x8, #0x25f4000
0xec8b54: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8b58: blr      x8
0xec8b5c: mov      x29, x29
0xec8b60: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec8b64: stur     x0, [x29, #-0x30]
0xec8b68: mov      x8, #1
0xec8b6c: stur     x8, [x29, #-0x38]
0xec8b70: ldur     x0, [x29, #-0x30]
0xec8b74: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8b78: ldr      x1, [x8, #0x218] ; @selector(category) | 'category'
0xec8b7c: adrp     x8, #0x25f4000
0xec8b80: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8b84: blr      x8
0xec8b88: mov      x29, x29
0xec8b8c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec8b90: str      x0, [sp, #0xa0]
0xec8b94: adrp     x8, #0x25f4000
0xec8b98: ldr      x8, [x8, #0x4d8] ; _AVAudioSessionCategoryPlayback
0xec8b9c: ldr      x2, [x8]
0xec8ba0: adrp     x8, #0x271f000
0xec8ba4: ldr      x1, [x8, #0x680] ; @selector(isEqualToString:) | 'isEqualToString:'
0xec8ba8: adrp     x8, #0x25f4000
0xec8bac: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8bb0: blr      x8
0xec8bb4: mov      w8, #0
0xec8bb8: str      w8, [sp, #0xa8]
0xec8bbc: tbz      w0, #0, #0xec8bf8
0xec8bc0: b        #0xec8bc4
0xec8bc4: ldur     x0, [x29, #-0x30]
0xec8bc8: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8bcc: ldr      x1, [x8, #0x220] ; @selector(categoryOptions) | 'categoryOptions'
0xec8bd0: adrp     x8, #0x25f4000
0xec8bd4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8bd8: blr      x8
0xec8bdc: ldur     x8, [x29, #-0x38]
0xec8be0: and      x8, x0, x8
0xec8be4: ldur     x9, [x29, #-0x38]
0xec8be8: subs     x8, x8, x9
0xec8bec: cset     w8, eq
0xec8bf0: str      w8, [sp, #0xa8]
0xec8bf4: b        #0xec8bf8
0xec8bf8: ldr      x0, [sp, #0xa0]
0xec8bfc: ldr      w8, [sp, #0xa8]
0xec8c00: str      w8, [sp, #0x9c]
0xec8c04: adrp     x8, #0x25f4000
0xec8c08: ldr      x8, [x8, #0x650] ; _objc_release
0xec8c0c: blr      x8
0xec8c10: ldr      w8, [sp, #0x9c]
0xec8c14: mov      w9, #1
0xec8c18: and      w8, w8, w9
0xec8c1c: sturb    w8, [x29, #-0x39]
0xec8c20: ldurb    w8, [x29, #-0x39]
0xec8c24: tbnz     w8, #0, #0xec8c78
0xec8c28: b        #0xec8c2c
0xec8c2c: ldur     x0, [x29, #-0x30]
0xec8c30: adrp     x8, #0x25f4000
0xec8c34: ldr      x8, [x8, #0x4d8] ; _AVAudioSessionCategoryPlayback
0xec8c38: ldr      x2, [x8]
0xec8c3c: ldur     x3, [x29, #-0x38]
0xec8c40: sub      x8, x29, #0x28
0xec8c44: str      x8, [sp, #0x90]
0xec8c48: ldur     x8, [x29, #-0x28]
0xec8c4c: sub      x4, x29, #0x48
0xec8c50: stur     x8, [x29, #-0x48]
0xec8c54: adrp     x8, #0x272b000 ; @selector(initHeaderLogicAndHeaderView)
0xec8c58: ldr      x1, [x8, #0xcb0] ; @selector(setCategory:withOptions:error:) | 'setCategory:withOptions:error:'
0xec8c5c: adrp     x8, #0x25f4000
0xec8c60: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8c64: blr      x8
0xec8c68: ldr      x0, [sp, #0x90]
0xec8c6c: ldur     x1, [x29, #-0x48]
0xec8c70: bl       #0x2289118 ; _objc_storeStrong
0xec8c74: b        #0xec8c78
0xec8c78: bl       #0xec7840
0xec8c7c: tbz      w0, #0, #0xec8d58
0xec8c80: b        #0xec8c84
0xec8c84: ldur     x0, [x29, #-0x18]
0xec8c88: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8c8c: ldr      x1, [x8, #0x208] ; @selector(silentPlayer) | 'silentPlayer'
0xec8c90: adrp     x8, #0x25f4000
0xec8c94: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8c98: blr      x8
0xec8c9c: mov      x29, x29
0xec8ca0: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec8ca4: str      x0, [sp, #0x80]
0xec8ca8: mov      w8, #1
0xec8cac: str      w8, [sp, #0x8c]
0xec8cb0: cbnz     x0, #0xec8cdc
0xec8cb4: b        #0xec8cb8
0xec8cb8: ldur     x0, [x29, #-0x18]
0xec8cbc: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8cc0: ldr      x1, [x8, #0x228] ; @selector(yieldedForOtherAudio) | 'yieldedForOtherAudio'
0xec8cc4: adrp     x8, #0x25f4000
0xec8cc8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8ccc: blr      x8
0xec8cd0: eor      w8, w0, #1
0xec8cd4: str      w8, [sp, #0x8c]
0xec8cd8: b        #0xec8cdc
0xec8cdc: ldr      x0, [sp, #0x80]
0xec8ce0: ldr      w8, [sp, #0x8c]
0xec8ce4: str      w8, [sp, #0x7c]
0xec8ce8: adrp     x8, #0x25f4000
0xec8cec: ldr      x8, [x8, #0x650] ; _objc_release
0xec8cf0: blr      x8
0xec8cf4: ldr      w8, [sp, #0x7c]
0xec8cf8: tbz      w8, #0, #0xec8d10
0xec8cfc: b        #0xec8d00
0xec8d00: b        #0xec8d04
0xec8d04: b        #0xec8d08
0xec8d08: b        #0xec8d0c
0xec8d0c: b        #0xec8d10
0xec8d10: ldur     x0, [x29, #-0x18]
0xec8d14: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8d18: ldr      x1, [x8, #0x230] ; @selector(setYieldedForOtherAudio:) | 'setYieldedForOtherAudio:'
0xec8d1c: adrp     x8, #0x25f4000
0xec8d20: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8d24: mov      w9, #1
0xec8d28: str      w9, [sp, #0x78]
0xec8d2c: and      w2, w9, #1
0xec8d30: blr      x8
0xec8d34: ldur     x0, [x29, #-0x18]
0xec8d38: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8d3c: ldr      x1, [x8, #0x178] ; @selector(stopAudio) | 'stopAudio'
0xec8d40: adrp     x8, #0x25f4000
0xec8d44: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8d48: blr      x8
0xec8d4c: ldr      w8, [sp, #0x78]
0xec8d50: stur     w8, [x29, #-0x4c]
0xec8d54: b        #0xec91f0
0xec8d58: ldur     x0, [x29, #-0x18]
0xec8d5c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8d60: ldr      x1, [x8, #0x228] ; @selector(yieldedForOtherAudio) | 'yieldedForOtherAudio'
0xec8d64: adrp     x8, #0x25f4000
0xec8d68: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8d6c: blr      x8
0xec8d70: tbz      w0, #0, #0xec8da8
0xec8d74: b        #0xec8d78
0xec8d78: b        #0xec8d7c
0xec8d7c: b        #0xec8d80
0xec8d80: b        #0xec8d84
0xec8d84: ldur     x0, [x29, #-0x18]
0xec8d88: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8d8c: ldr      x1, [x8, #0x230] ; @selector(setYieldedForOtherAudio:) | 'setYieldedForOtherAudio:'
0xec8d90: adrp     x8, #0x25f4000
0xec8d94: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8d98: mov      w9, #0
0xec8d9c: and      w2, w9, #1
0xec8da0: blr      x8
0xec8da4: b        #0xec8da8
0xec8da8: ldur     x0, [x29, #-0x18]
0xec8dac: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8db0: ldr      x1, [x8, #0x208] ; @selector(silentPlayer) | 'silentPlayer'
0xec8db4: adrp     x8, #0x25f4000
0xec8db8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8dbc: blr      x8
0xec8dc0: mov      x29, x29
0xec8dc4: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec8dc8: str      x0, [sp, #0x68]
0xec8dcc: mov      w8, #0
0xec8dd0: and      w8, w8, #1
0xec8dd4: and      w8, w8, #1
0xec8dd8: sturb    w8, [x29, #-0x59]
0xec8ddc: mov      w8, #0
0xec8de0: str      w8, [sp, #0x74]
0xec8de4: cbz      x0, #0xec8e40
0xec8de8: b        #0xec8dec
0xec8dec: ldur     x0, [x29, #-0x18]
0xec8df0: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8df4: ldr      x1, [x8, #0x208] ; @selector(silentPlayer) | 'silentPlayer'
0xec8df8: adrp     x8, #0x25f4000
0xec8dfc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8e00: blr      x8
0xec8e04: mov      x29, x29
0xec8e08: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec8e0c: mov      x8, x0
0xec8e10: stur     x8, [x29, #-0x58]
0xec8e14: mov      w8, #1
0xec8e18: and      w8, w8, #1
0xec8e1c: and      w8, w8, #1
0xec8e20: sturb    w8, [x29, #-0x59]
0xec8e24: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8e28: ldr      x1, [x8, #0x238] ; @selector(isPlaying) | 'isPlaying'
0xec8e2c: adrp     x8, #0x25f4000
0xec8e30: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8e34: blr      x8
0xec8e38: str      w0, [sp, #0x74]
0xec8e3c: b        #0xec8e40
0xec8e40: ldr      w8, [sp, #0x74]
0xec8e44: str      w8, [sp, #0x64]
0xec8e48: ldurb    w8, [x29, #-0x59]
0xec8e4c: tbz      w8, #0, #0xec8e68
0xec8e50: b        #0xec8e54
0xec8e54: ldur     x0, [x29, #-0x58]
0xec8e58: adrp     x8, #0x25f4000
0xec8e5c: ldr      x8, [x8, #0x650] ; _objc_release
0xec8e60: blr      x8
0xec8e64: b        #0xec8e68
0xec8e68: ldr      x0, [sp, #0x68]
0xec8e6c: adrp     x8, #0x25f4000
0xec8e70: ldr      x8, [x8, #0x650] ; _objc_release
0xec8e74: blr      x8
0xec8e78: ldr      w8, [sp, #0x64]
0xec8e7c: tbz      w8, #0, #0xec8e90
0xec8e80: b        #0xec8e84
0xec8e84: mov      w8, #1
0xec8e88: stur     w8, [x29, #-0x4c]
0xec8e8c: b        #0xec91f0
0xec8e90: sub      x8, x29, #0x68
0xec8e94: str      x8, [sp, #0x50]
0xec8e98: stur     xzr, [x29, #-0x68]
0xec8e9c: ldur     x0, [x29, #-0x30]
0xec8ea0: ldur     x8, [x29, #-0x68]
0xec8ea4: sub      x3, x29, #0x70
0xec8ea8: stur     x8, [x29, #-0x70]
0xec8eac: adrp     x8, #0x272b000 ; @selector(initHeaderLogicAndHeaderView)
0xec8eb0: ldr      x1, [x8, #0xcb8] ; @selector(setActive:error:) | 'setActive:error:'
0xec8eb4: adrp     x8, #0x25f4000
0xec8eb8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8ebc: mov      w9, #1
0xec8ec0: and      w2, w9, #1
0xec8ec4: blr      x8
0xec8ec8: ldr      x0, [sp, #0x50]
0xec8ecc: ldur     x1, [x29, #-0x70]
0xec8ed0: bl       #0x2289118 ; _objc_storeStrong
0xec8ed4: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec8ed8: ldr      x0, [x8, #0xf28]
0xec8edc: adrp     x8, #0x2723000 ; @selector(menuArrowColorEnabled)
0xec8ee0: ldr      x1, [x8, #0x730] ; @selector(mainBundle) | 'mainBundle'
0xec8ee4: adrp     x8, #0x25f4000
0xec8ee8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8eec: blr      x8
0xec8ef0: mov      x29, x29
0xec8ef4: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec8ef8: str      x0, [sp, #0x58]
0xec8efc: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8f00: ldr      x1, [x8, #0x240] ; @selector(URLForResource:withExtension:) | 'URLForResource:withExtension:'
0xec8f04: adrp     x8, #0x25f4000
0xec8f08: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8f0c: adrp     x2, #0x2645000
0xec8f10: add      x2, x2, #0xb90 ; @'blank'
0xec8f14: adrp     x3, #0x263b000
0xec8f18: add      x3, x3, #0xa10 ; @'caf'
0xec8f1c: blr      x8
0xec8f20: mov      x29, x29
0xec8f24: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec8f28: mov      x8, x0
0xec8f2c: ldr      x0, [sp, #0x58]
0xec8f30: stur     x8, [x29, #-0x78]
0xec8f34: adrp     x8, #0x25f4000
0xec8f38: ldr      x8, [x8, #0x650] ; _objc_release
0xec8f3c: blr      x8
0xec8f40: ldur     x8, [x29, #-0x78]
0xec8f44: cbnz     x8, #0xec8f58
0xec8f48: b        #0xec8f4c
0xec8f4c: mov      w8, #1
0xec8f50: stur     w8, [x29, #-0x4c]
0xec8f54: b        #0xec91d0
0xec8f58: sub      x8, x29, #0x80
0xec8f5c: str      x8, [sp, #0x38]
0xec8f60: stur     xzr, [x29, #-0x80]
0xec8f64: adrp     x8, #0x2752000
0xec8f68: ldr      x0, [x8, #0x640]
0xec8f6c: bl       #0x2288f44 ; _objc_alloc
0xec8f70: ldur     x2, [x29, #-0x78]
0xec8f74: ldur     x8, [x29, #-0x80]
0xec8f78: sub      x3, x29, #0x88
0xec8f7c: stur     x8, [x29, #-0x88]
0xec8f80: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8f84: ldr      x1, [x8, #0x248] ; @selector(initWithContentsOfURL:error:) | 'initWithContentsOfURL:error:'
0xec8f88: adrp     x8, #0x25f4000
0xec8f8c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8f90: blr      x8
0xec8f94: mov      x1, x0
0xec8f98: ldr      x0, [sp, #0x38]
0xec8f9c: str      x1, [sp, #0x40]
0xec8fa0: ldur     x1, [x29, #-0x88]
0xec8fa4: bl       #0x2289118 ; _objc_storeStrong
0xec8fa8: ldr      x2, [sp, #0x40]
0xec8fac: ldur     x0, [x29, #-0x18]
0xec8fb0: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8fb4: ldr      x1, [x8, #0x250] ; @selector(setSilentPlayer:) | 'setSilentPlayer:'
0xec8fb8: adrp     x8, #0x25f4000
0xec8fbc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8fc0: blr      x8
0xec8fc4: ldr      x0, [sp, #0x40]
0xec8fc8: adrp     x8, #0x25f4000
0xec8fcc: ldr      x8, [x8, #0x650] ; _objc_release
0xec8fd0: blr      x8
0xec8fd4: ldur     x8, [x29, #-0x80]
0xec8fd8: mov      w9, #0
0xec8fdc: and      w9, w9, #1
0xec8fe0: and      w9, w9, #1
0xec8fe4: sturb    w9, [x29, #-0x91]
0xec8fe8: mov      w9, #1
0xec8fec: str      w9, [sp, #0x4c]
0xec8ff0: cbnz     x8, #0xec9040
0xec8ff4: b        #0xec8ff8
0xec8ff8: ldur     x0, [x29, #-0x18]
0xec8ffc: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9000: ldr      x1, [x8, #0x208] ; @selector(silentPlayer) | 'silentPlayer'
0xec9004: adrp     x8, #0x25f4000
0xec9008: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec900c: blr      x8
0xec9010: mov      x29, x29
0xec9014: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec9018: mov      x8, x0
0xec901c: stur     x8, [x29, #-0x90]
0xec9020: mov      w8, #1
0xec9024: and      w8, w8, #1
0xec9028: and      w8, w8, #1
0xec902c: sturb    w8, [x29, #-0x91]
0xec9030: subs     x8, x0, #0
0xec9034: cset     w8, eq
0xec9038: str      w8, [sp, #0x4c]
0xec903c: b        #0xec9040
0xec9040: ldr      w8, [sp, #0x4c]
0xec9044: str      w8, [sp, #0x34]
0xec9048: ldurb    w8, [x29, #-0x91]
0xec904c: tbz      w8, #0, #0xec9068
0xec9050: b        #0xec9054
0xec9054: ldur     x0, [x29, #-0x90]
0xec9058: adrp     x8, #0x25f4000
0xec905c: ldr      x8, [x8, #0x650] ; _objc_release
0xec9060: blr      x8
0xec9064: b        #0xec9068
0xec9068: ldr      w8, [sp, #0x34]
0xec906c: tbz      w8, #0, #0xec909c
0xec9070: b        #0xec9074
0xec9074: ldur     x0, [x29, #-0x18]
0xec9078: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec907c: ldr      x1, [x8, #0x250] ; @selector(setSilentPlayer:) | 'setSilentPlayer:'
0xec9080: adrp     x8, #0x25f4000
0xec9084: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9088: mov      x2, #0
0xec908c: blr      x8
0xec9090: mov      w8, #1
0xec9094: stur     w8, [x29, #-0x4c]
0xec9098: b        #0xec91c0
0xec909c: ldur     x0, [x29, #-0x18]
0xec90a0: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec90a4: str      x8, [sp, #0x20] ; @selector(persistUsageCache)
0xec90a8: ldr      x1, [x8, #0x208] ; @selector(silentPlayer) | 'silentPlayer'
0xec90ac: adrp     x8, #0x25f4000
0xec90b0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec90b4: blr      x8
0xec90b8: mov      x29, x29
0xec90bc: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec90c0: str      x0, [sp, #0x10]
0xec90c4: adrp     x8, #0x2721000 ; @selector(setHighlighted:animated:)
0xec90c8: ldr      x1, [x8, #0xd88] ; @selector(setVolume:) | 'setVolume:'
0xec90cc: adrp     x8, #0x25f4000
0xec90d0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec90d4: fmov     s0, wzr
0xec90d8: blr      x8
0xec90dc: ldr      x0, [sp, #0x10]
0xec90e0: adrp     x8, #0x25f4000
0xec90e4: ldr      x8, [x8, #0x650] ; _objc_release
0xec90e8: blr      x8
0xec90ec: ldr      x8, [sp, #0x20]
0xec90f0: ldur     x0, [x29, #-0x18]
0xec90f4: ldr      x1, [x8, #0x208]
0xec90f8: adrp     x8, #0x25f4000
0xec90fc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9100: blr      x8
0xec9104: mov      x29, x29
0xec9108: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec910c: str      x0, [sp, #0x18]
0xec9110: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9114: ldr      x1, [x8, #0x258] ; @selector(prepareToPlay) | 'prepareToPlay'
0xec9118: adrp     x8, #0x25f4000
0xec911c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9120: blr      x8
0xec9124: ldr      x0, [sp, #0x18]
0xec9128: adrp     x8, #0x25f4000
0xec912c: ldr      x8, [x8, #0x650] ; _objc_release
0xec9130: blr      x8
0xec9134: ldr      x8, [sp, #0x20]
0xec9138: ldur     x0, [x29, #-0x18]
0xec913c: ldr      x1, [x8, #0x208]
0xec9140: adrp     x8, #0x25f4000
0xec9144: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9148: blr      x8
0xec914c: mov      x29, x29
0xec9150: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec9154: str      x0, [sp, #0x28]
0xec9158: adrp     x8, #0x2721000 ; @selector(setHighlighted:animated:)
0xec915c: ldr      x1, [x8, #0xdb8] ; @selector(play) | 'play'
0xec9160: adrp     x8, #0x25f4000
0xec9164: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9168: blr      x8
0xec916c: mov      x8, x0
0xec9170: ldr      x0, [sp, #0x28]
0xec9174: str      w8, [sp, #0x30]
0xec9178: adrp     x8, #0x25f4000
0xec917c: ldr      x8, [x8, #0x650] ; _objc_release
0xec9180: blr      x8
0xec9184: ldr      w0, [sp, #0x30]
0xec9188: tbnz     w0, #0, #0xec91b8
0xec918c: b        #0xec9190
0xec9190: ldur     x0, [x29, #-0x18]
0xec9194: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9198: ldr      x1, [x8, #0x250] ; @selector(setSilentPlayer:) | 'setSilentPlayer:'
0xec919c: adrp     x8, #0x25f4000
0xec91a0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec91a4: mov      x2, #0
0xec91a8: blr      x8
0xec91ac: mov      w8, #1
0xec91b0: stur     w8, [x29, #-0x4c]
0xec91b4: b        #0xec91c0
0xec91b8: stur     wzr, [x29, #-0x4c]
0xec91bc: b        #0xec91c0
0xec91c0: sub      x0, x29, #0x80
0xec91c4: mov      x1, #0
0xec91c8: bl       #0x2289118 ; _objc_storeStrong
0xec91cc: b        #0xec91d0
0xec91d0: sub      x0, x29, #0x78
0xec91d4: mov      x1, #0
0xec91d8: str      x1, [sp, #8]
0xec91dc: bl       #0x2289118 ; _objc_storeStrong
0xec91e0: ldr      x1, [sp, #8]
0xec91e4: sub      x0, x29, #0x68
0xec91e8: bl       #0x2289118 ; _objc_storeStrong
0xec91ec: b        #0xec91f0
0xec91f0: sub      x0, x29, #0x30
0xec91f4: mov      x1, #0
0xec91f8: str      x1, [sp]
0xec91fc: bl       #0x2289118 ; _objc_storeStrong
0xec9200: ldr      x1, [sp]
0xec9204: sub      x0, x29, #0x28
0xec9208: bl       #0x2289118 ; _objc_storeStrong
0xec920c: ldp      x29, x30, [sp, #0x150]
0xec9210: ldp      x28, x27, [sp, #0x140]
0xec9214: add      sp, sp, #0x160
0xec9218: ret      
