-[WCRefineBackgroundKeepAlive beginBackgroundTaskIfNeeded] 0xec865c v16@0:8
0xec865c: sub      sp, sp, #0x90
0xec8660: stp      x29, x30, [sp, #0x80]
0xec8664: add      x29, sp, #0x80
0xec8668: stur     x0, [x29, #-8]
0xec866c: stur     x1, [x29, #-0x10]
0xec8670: ldur     x0, [x29, #-8]
0xec8674: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8678: ldr      x1, [x8, #0x188] ; @selector(bgTaskIdentifier) | 'bgTaskIdentifier'
0xec867c: adrp     x8, #0x25f4000
0xec8680: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8684: blr      x8
0xec8688: adrp     x8, #0x25f4000
0xec868c: ldr      x8, [x8, #0x108] ; _UIBackgroundTaskInvalid
0xec8690: ldr      x8, [x8]
0xec8694: subs     x8, x0, x8
0xec8698: b.eq     #0xec86a4
0xec869c: b        #0xec86a0
0xec86a0: b        #0xec87d8
0xec86a4: ldur     x0, [x29, #-8]
0xec86a8: adrp     x8, #0x2723000 ; @selector(menuArrowColorEnabled)
0xec86ac: ldr      x1, [x8, #0x9f0] ; @selector(isEnabled) | 'isEnabled'
0xec86b0: adrp     x8, #0x25f4000
0xec86b4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec86b8: blr      x8
0xec86bc: tbz      w0, #0, #0xec86e4
0xec86c0: b        #0xec86c4
0xec86c4: ldur     x0, [x29, #-8]
0xec86c8: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec86cc: ldr      x1, [x8, #0x140] ; @selector(isInBackground) | 'isInBackground'
0xec86d0: adrp     x8, #0x25f4000
0xec86d4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec86d8: blr      x8
0xec86dc: tbnz     w0, #0, #0xec86e8
0xec86e0: b        #0xec86e4
0xec86e4: b        #0xec87d8
0xec86e8: ldur     x1, [x29, #-8]
0xec86ec: sub      x0, x29, #0x18
0xec86f0: bl       #0x2289040 ; _objc_initWeak
0xec86f4: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec86f8: ldr      x0, [x8, #0xb20]
0xec86fc: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xec8700: ldr      x1, [x8, #0x5f8] ; @selector(sharedApplication) | 'sharedApplication'
0xec8704: adrp     x8, #0x25f4000
0xec8708: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec870c: blr      x8
0xec8710: str      x0, [sp, #0x28]
0xec8714: b        #0xec8718
0xec8718: ldr      x0, [sp, #0x28]
0xec871c: mov      x29, x29
0xec8720: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec8724: str      x0, [sp, #0x10]
0xec8728: add      x8, sp, #0x30
0xec872c: str      x8, [sp, #0x18]
0xec8730: adrp     x9, #0x25f4000
0xec8734: ldr      x9, [x9, #0x680] ; __NSConcreteStackBlock
0xec8738: str      x9, [sp, #0x30]
0xec873c: mov      w9, #-0x3e000000
0xec8740: str      w9, [sp, #0x38]
0xec8744: str      wzr, [sp, #0x3c]
0xec8748: adrp     x9, #0xec8000
0xec874c: add      x9, x9, #0x824
0xec8750: str      x9, [sp, #0x40]
0xec8754: adrp     x9, #0x25f7000
0xec8758: add      x9, x9, #0xe50
0xec875c: str      x9, [sp, #0x48]
0xec8760: add      x0, x8, #0x20
0xec8764: str      x0, [sp, #8]
0xec8768: sub      x1, x29, #0x18
0xec876c: bl       #0x2288fbc ; _objc_copyWeak
0xec8770: ldr      x0, [sp, #0x10]
0xec8774: ldr      x2, [sp, #0x18]
0xec8778: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec877c: ldr      x1, [x8, #0x198] ; @selector(beginBackgroundTaskWithExpirationHandler:) | 'beginBackgroundTaskWithExpirationHandler:'
0xec8780: adrp     x8, #0x25f4000
0xec8784: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8788: blr      x8
0xec878c: str      x0, [sp, #0x20]
0xec8790: b        #0xec8794
0xec8794: ldr      x2, [sp, #0x20]
0xec8798: ldur     x0, [x29, #-8]
0xec879c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec87a0: ldr      x1, [x8, #0x1a0] ; @selector(setBgTaskIdentifier:) | 'setBgTaskIdentifier:'
0xec87a4: adrp     x8, #0x25f4000
0xec87a8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec87ac: blr      x8
0xec87b0: b        #0xec87b4
0xec87b4: ldr      x0, [sp, #0x10]
0xec87b8: adrp     x8, #0x25f4000
0xec87bc: ldr      x8, [x8, #0x650] ; _objc_release
0xec87c0: blr      x8
0xec87c4: ldr      x0, [sp, #8]
0xec87c8: bl       #0x2288fc8 ; _objc_destroyWeak
0xec87cc: sub      x0, x29, #0x18
0xec87d0: bl       #0x2288fc8 ; _objc_destroyWeak
0xec87d4: b        #0xec87d8
0xec87d8: ldp      x29, x30, [sp, #0x80]
0xec87dc: add      sp, sp, #0x90
0xec87e0: ret      
0xec87e4: stur     x0, [x29, #-0x20]
0xec87e8: mov      x8, x1
0xec87ec: stur     w8, [x29, #-0x24]
0xec87f0: b        #0xec8810
0xec87f4: mov      x8, x0
0xec87f8: ldr      x0, [sp, #8]
0xec87fc: stur     x8, [x29, #-0x20]
0xec8800: mov      x8, x1
0xec8804: stur     w8, [x29, #-0x24]
0xec8808: bl       #0x2288fc8 ; _objc_destroyWeak
0xec880c: b        #0xec8810
0xec8810: sub      x0, x29, #0x18
0xec8814: bl       #0x2288fc8 ; _objc_destroyWeak
0xec8818: b        #0xec881c
0xec881c: ldur     x0, [x29, #-0x20]
0xec8820: bl       #0x22888f0 ; __Unwind_Resume
