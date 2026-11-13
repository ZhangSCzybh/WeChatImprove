-[WCRefineBackgroundKeepAlive requestMoreTime] 0xec88bc v16@0:8
0xec88bc: sub      sp, sp, #0x40
0xec88c0: stp      x29, x30, [sp, #0x30]
0xec88c4: add      x29, sp, #0x30
0xec88c8: stur     x0, [x29, #-8]
0xec88cc: stur     x1, [x29, #-0x10]
0xec88d0: ldur     x0, [x29, #-8]
0xec88d4: adrp     x8, #0x2723000 ; @selector(menuArrowColorEnabled)
0xec88d8: ldr      x1, [x8, #0x9f0] ; @selector(isEnabled) | 'isEnabled'
0xec88dc: adrp     x8, #0x25f4000
0xec88e0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec88e4: blr      x8
0xec88e8: tbz      w0, #0, #0xec8910
0xec88ec: b        #0xec88f0
0xec88f0: ldur     x0, [x29, #-8]
0xec88f4: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec88f8: ldr      x1, [x8, #0x140] ; @selector(isInBackground) | 'isInBackground'
0xec88fc: adrp     x8, #0x25f4000
0xec8900: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8904: blr      x8
0xec8908: tbnz     w0, #0, #0xec8914
0xec890c: b        #0xec8910
0xec8910: b        #0xec89fc
0xec8914: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec8918: ldr      x0, [x8, #0xb20]
0xec891c: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xec8920: ldr      x1, [x8, #0x5f8] ; @selector(sharedApplication) | 'sharedApplication'
0xec8924: adrp     x8, #0x25f4000
0xec8928: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec892c: blr      x8
0xec8930: mov      x29, x29
0xec8934: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec8938: str      x0, [sp, #8]
0xec893c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8940: ldr      x1, [x8, #0x1f0] ; @selector(backgroundTimeRemaining) | 'backgroundTimeRemaining'
0xec8944: adrp     x8, #0x25f4000
0xec8948: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec894c: blr      x8
0xec8950: ldr      x0, [sp, #8]
0xec8954: str      d0, [sp, #0x10]
0xec8958: adrp     x8, #0x25f4000
0xec895c: ldr      x8, [x8, #0x650] ; _objc_release
0xec8960: blr      x8
0xec8964: ldr      d0, [sp, #0x10]
0xec8968: str      d0, [sp, #0x18]
0xec896c: ldr      d0, [sp, #0x18]
0xec8970: fmov     d1, #30.00000000
0xec8974: fcmp     d0, d1
0xec8978: b.ge     #0xec89ac
0xec897c: b        #0xec8980
0xec8980: ldr      d0, [sp, #0x18]
0xec8984: fcmp     d0, #0.0
0xec8988: b.ls     #0xec89ac
0xec898c: b        #0xec8990
0xec8990: ldr      d0, [sp, #0x18]
0xec8994: mov      x8, #0x848000000000
0xec8998: movk     x8, #0x412e, lsl #48
0xec899c: fmov     d1, x8
0xec89a0: fcmp     d0, d1
0xec89a4: b.lt     #0xec89b0
0xec89a8: b        #0xec89ac
0xec89ac: b        #0xec89fc
0xec89b0: ldur     x0, [x29, #-8]
0xec89b4: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec89b8: ldr      x1, [x8, #0x1f8] ; @selector(ensureAudioPlaying) | 'ensureAudioPlaying'
0xec89bc: adrp     x8, #0x25f4000
0xec89c0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec89c4: blr      x8
0xec89c8: ldur     x0, [x29, #-8]
0xec89cc: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec89d0: ldr      x1, [x8, #0x190] ; @selector(endBackgroundTask) | 'endBackgroundTask'
0xec89d4: adrp     x8, #0x25f4000
0xec89d8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec89dc: blr      x8
0xec89e0: ldur     x0, [x29, #-8]
0xec89e4: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec89e8: ldr      x1, [x8, #0x200] ; @selector(beginBackgroundTaskIfNeeded) | 'beginBackgroundTaskIfNeeded'
0xec89ec: adrp     x8, #0x25f4000
0xec89f0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec89f4: blr      x8
0xec89f8: b        #0xec89fc
0xec89fc: ldp      x29, x30, [sp, #0x30]
0xec8a00: add      sp, sp, #0x40
0xec8a04: ret      
