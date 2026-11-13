-[WCRefineBackgroundKeepAlive audioSessionMayHaveChanged:] 0xec937c v24@0:8@16
0xec937c: sub      sp, sp, #0xf0
0xec9380: stp      x29, x30, [sp, #0xe0]
0xec9384: add      x29, sp, #0xe0
0xec9388: mov      x8, x1
0xec938c: mov      x1, x2
0xec9390: stur     x0, [x29, #-8]
0xec9394: stur     x8, [x29, #-0x10]
0xec9398: sub      x0, x29, #0x18
0xec939c: stur     xzr, [x29, #-0x18]
0xec93a0: bl       #0x2289118 ; _objc_storeStrong
0xec93a4: ldur     x0, [x29, #-8]
0xec93a8: adrp     x8, #0x2723000 ; @selector(menuArrowColorEnabled)
0xec93ac: ldr      x1, [x8, #0x9f0] ; @selector(isEnabled) | 'isEnabled'
0xec93b0: adrp     x8, #0x25f4000
0xec93b4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec93b8: blr      x8
0xec93bc: tbz      w0, #0, #0xec93e4
0xec93c0: b        #0xec93c4
0xec93c4: ldur     x0, [x29, #-8]
0xec93c8: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec93cc: ldr      x1, [x8, #0x140] ; @selector(isInBackground) | 'isInBackground'
0xec93d0: adrp     x8, #0x25f4000
0xec93d4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec93d8: blr      x8
0xec93dc: tbnz     w0, #0, #0xec93f0
0xec93e0: b        #0xec93e4
0xec93e4: mov      w8, #1
0xec93e8: stur     w8, [x29, #-0x1c]
0xec93ec: b        #0xec97a0
0xec93f0: bl       #0xec75c0
0xec93f4: tbz      w0, #0, #0xec944c
0xec93f8: b        #0xec93fc
0xec93fc: ldur     x0, [x29, #-8]
0xec9400: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9404: ldr      x1, [x8, #0x178] ; @selector(stopAudio) | 'stopAudio'
0xec9408: adrp     x8, #0x25f4000
0xec940c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9410: blr      x8
0xec9414: ldur     x0, [x29, #-8]
0xec9418: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec941c: ldr      x1, [x8, #0x170] ; @selector(setYieldedForHostCall:) | 'setYieldedForHostCall:'
0xec9420: adrp     x8, #0x25f4000
0xec9424: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9428: mov      w9, #1
0xec942c: and      w2, w9, #1
0xec9430: blr      x8
0xec9434: b        #0xec9438
0xec9438: b        #0xec943c
0xec943c: b        #0xec9440
0xec9440: mov      w8, #1
0xec9444: stur     w8, [x29, #-0x1c]
0xec9448: b        #0xec97a0
0xec944c: sturb    wzr, [x29, #-0x1d]
0xec9450: ldur     x0, [x29, #-0x18]
0xec9454: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0xec9458: ldr      x1, [x8, #0x210] ; @selector(name) | 'name'
0xec945c: adrp     x8, #0x25f4000
0xec9460: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9464: blr      x8
0xec9468: mov      x29, x29
0xec946c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec9470: str      x0, [sp, #0x70]
0xec9474: adrp     x8, #0x25f4000
0xec9478: ldr      x8, [x8, #0x4e0] ; _AVAudioSessionInterruptionNotification
0xec947c: ldr      x2, [x8]
0xec9480: adrp     x8, #0x271f000
0xec9484: ldr      x1, [x8, #0x680] ; @selector(isEqualToString:) | 'isEqualToString:'
0xec9488: adrp     x8, #0x25f4000
0xec948c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9490: blr      x8
0xec9494: mov      x8, x0
0xec9498: ldr      x0, [sp, #0x70]
0xec949c: stur     w8, [x29, #-0x64]
0xec94a0: adrp     x8, #0x25f4000
0xec94a4: ldr      x8, [x8, #0x650] ; _objc_release
0xec94a8: blr      x8
0xec94ac: ldur     w0, [x29, #-0x64]
0xec94b0: tbz      w0, #0, #0xec9560
0xec94b4: b        #0xec94b8
0xec94b8: ldur     x0, [x29, #-0x18]
0xec94bc: adrp     x8, #0x2721000 ; @selector(setHighlighted:animated:)
0xec94c0: ldr      x1, [x8, #0xc40] ; @selector(userInfo) | 'userInfo'
0xec94c4: adrp     x8, #0x25f4000
0xec94c8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec94cc: blr      x8
0xec94d0: mov      x29, x29
0xec94d4: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec94d8: str      x0, [sp, #0x60]
0xec94dc: adrp     x8, #0x25f4000
0xec94e0: ldr      x8, [x8, #0x4e8] ; _AVAudioSessionInterruptionTypeKey
0xec94e4: ldr      x2, [x8]
0xec94e8: adrp     x8, #0x271f000
0xec94ec: ldr      x1, [x8, #0xa50] ; @selector(objectForKeyedSubscript:) | 'objectForKeyedSubscript:'
0xec94f0: adrp     x8, #0x25f4000
0xec94f4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec94f8: blr      x8
0xec94fc: mov      x29, x29
0xec9500: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec9504: str      x0, [sp, #0x58]
0xec9508: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xec950c: ldr      x1, [x8, #0x240] ; @selector(integerValue) | 'integerValue'
0xec9510: adrp     x8, #0x25f4000
0xec9514: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9518: blr      x8
0xec951c: mov      x8, x0
0xec9520: ldr      x0, [sp, #0x58]
0xec9524: str      x8, [sp, #0x68]
0xec9528: adrp     x8, #0x25f4000
0xec952c: ldr      x8, [x8, #0x650] ; _objc_release
0xec9530: blr      x8
0xec9534: ldr      x0, [sp, #0x60]
0xec9538: adrp     x8, #0x25f4000
0xec953c: ldr      x8, [x8, #0x650] ; _objc_release
0xec9540: blr      x8
0xec9544: ldr      x0, [sp, #0x68]
0xec9548: stur     x0, [x29, #-0x28]
0xec954c: ldur     x8, [x29, #-0x28]
0xec9550: subs     x8, x8, #1
0xec9554: cset     w8, eq
0xec9558: sturb    w8, [x29, #-0x1d]
0xec955c: b        #0xec9674
0xec9560: ldur     x0, [x29, #-0x18]
0xec9564: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0xec9568: ldr      x1, [x8, #0x210] ; @selector(name) | 'name'
0xec956c: adrp     x8, #0x25f4000
0xec9570: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9574: blr      x8
0xec9578: mov      x29, x29
0xec957c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec9580: str      x0, [sp, #0x48]
0xec9584: adrp     x8, #0x25f4000
0xec9588: ldr      x8, [x8, #0x508] ; _AVAudioSessionSilenceSecondaryAudioHintNotification
0xec958c: ldr      x2, [x8]
0xec9590: adrp     x8, #0x271f000
0xec9594: ldr      x1, [x8, #0x680] ; @selector(isEqualToString:) | 'isEqualToString:'
0xec9598: adrp     x8, #0x25f4000
0xec959c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec95a0: blr      x8
0xec95a4: mov      x8, x0
0xec95a8: ldr      x0, [sp, #0x48]
0xec95ac: str      w8, [sp, #0x54]
0xec95b0: adrp     x8, #0x25f4000
0xec95b4: ldr      x8, [x8, #0x650] ; _objc_release
0xec95b8: blr      x8
0xec95bc: ldr      w0, [sp, #0x54]
0xec95c0: tbz      w0, #0, #0xec9670
0xec95c4: b        #0xec95c8
0xec95c8: ldur     x0, [x29, #-0x18]
0xec95cc: adrp     x8, #0x2721000 ; @selector(setHighlighted:animated:)
0xec95d0: ldr      x1, [x8, #0xc40] ; @selector(userInfo) | 'userInfo'
0xec95d4: adrp     x8, #0x25f4000
0xec95d8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec95dc: blr      x8
0xec95e0: mov      x29, x29
0xec95e4: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec95e8: str      x0, [sp, #0x38]
0xec95ec: adrp     x8, #0x25f4000
0xec95f0: ldr      x8, [x8, #0x510] ; _AVAudioSessionSilenceSecondaryAudioHintTypeKey
0xec95f4: ldr      x2, [x8]
0xec95f8: adrp     x8, #0x271f000
0xec95fc: ldr      x1, [x8, #0xa50] ; @selector(objectForKeyedSubscript:) | 'objectForKeyedSubscript:'
0xec9600: adrp     x8, #0x25f4000
0xec9604: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9608: blr      x8
0xec960c: mov      x29, x29
0xec9610: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec9614: str      x0, [sp, #0x30]
0xec9618: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xec961c: ldr      x1, [x8, #0x240] ; @selector(integerValue) | 'integerValue'
0xec9620: adrp     x8, #0x25f4000
0xec9624: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec9628: blr      x8
0xec962c: mov      x8, x0
0xec9630: ldr      x0, [sp, #0x30]
0xec9634: str      x8, [sp, #0x40]
0xec9638: adrp     x8, #0x25f4000
0xec963c: ldr      x8, [x8, #0x650] ; _objc_release
0xec9640: blr      x8
0xec9644: ldr      x0, [sp, #0x38]
0xec9648: adrp     x8, #0x25f4000
0xec964c: ldr      x8, [x8, #0x650] ; _objc_release
0xec9650: blr      x8
0xec9654: ldr      x0, [sp, #0x40]
0xec9658: stur     x0, [x29, #-0x30]
0xec965c: ldur     x8, [x29, #-0x30]
0xec9660: subs     x8, x8, #1
0xec9664: cset     w8, eq
0xec9668: sturb    w8, [x29, #-0x1d]
0xec966c: b        #0xec9670
0xec9670: b        #0xec9674
0xec9674: ldurb    w8, [x29, #-0x1d]
0xec9678: tbnz     w8, #0, #0xec968c
0xec967c: b        #0xec9680
0xec9680: bl       #0xec7840
0xec9684: tbz      w0, #0, #0xec96dc
0xec9688: b        #0xec968c
0xec968c: ldur     x0, [x29, #-8]
0xec9690: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec9694: ldr      x1, [x8, #0x178] ; @selector(stopAudio) | 'stopAudio'
0xec9698: adrp     x8, #0x25f4000
0xec969c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec96a0: blr      x8
0xec96a4: ldur     x0, [x29, #-8]
0xec96a8: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec96ac: ldr      x1, [x8, #0x230] ; @selector(setYieldedForOtherAudio:) | 'setYieldedForOtherAudio:'
0xec96b0: adrp     x8, #0x25f4000
0xec96b4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec96b8: mov      w9, #1
0xec96bc: and      w2, w9, #1
0xec96c0: blr      x8
0xec96c4: b        #0xec96c8
0xec96c8: b        #0xec96cc
0xec96cc: b        #0xec96d0
0xec96d0: mov      w8, #1
0xec96d4: stur     w8, [x29, #-0x1c]
0xec96d8: b        #0xec97a0
0xec96dc: ldur     x1, [x29, #-8]
0xec96e0: sub      x0, x29, #0x38
0xec96e4: str      x0, [sp, #0x28]
0xec96e8: bl       #0x2289040 ; _objc_initWeak
0xec96ec: mov      x0, #0
0xec96f0: mov      x1, #0x8400
0xec96f4: movk     x1, #0x17d7, lsl #16
0xec96f8: bl       #0x2288d04 ; _dispatch_time
0xec96fc: str      x0, [sp, #8]
0xec9700: adrp     x0, #0x25f4000
0xec9704: ldr      x0, [x0, #0x6a0] ; __dispatch_main_q
0xec9708: str      x0, [sp]
0xec970c: bl       #0x22890c4 ; _objc_retainAutoreleaseReturnValue
0xec9710: ldr      x0, [sp]
0xec9714: mov      x29, x29
0xec9718: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec971c: ldr      x1, [sp, #0x28]
0xec9720: str      x0, [sp, #0x18]
0xec9724: sub      x8, x29, #0x60
0xec9728: str      x8, [sp, #0x10]
0xec972c: adrp     x9, #0x25f4000
0xec9730: ldr      x9, [x9, #0x680] ; __NSConcreteStackBlock
0xec9734: stur     x9, [x29, #-0x60]
0xec9738: mov      w9, #-0x3e000000
0xec973c: stur     w9, [x29, #-0x58]
0xec9740: stur     wzr, [x29, #-0x54]
0xec9744: adrp     x9, #0xec9000
0xec9748: add      x9, x9, #0x7b8
0xec974c: stur     x9, [x29, #-0x50]
0xec9750: adrp     x9, #0x25f7000
0xec9754: add      x9, x9, #0xe50
0xec9758: stur     x9, [x29, #-0x48]
0xec975c: add      x0, x8, #0x20
0xec9760: str      x0, [sp, #0x20]
0xec9764: bl       #0x2288fbc ; _objc_copyWeak
0xec9768: ldr      x0, [sp, #8]
0xec976c: ldr      x2, [sp, #0x10]
0xec9770: ldr      x1, [sp, #0x18]
0xec9774: bl       #0x2288bc0 ; _dispatch_after
0xec9778: ldr      x0, [sp, #0x18]
0xec977c: adrp     x8, #0x25f4000
0xec9780: ldr      x8, [x8, #0x650] ; _objc_release
0xec9784: blr      x8
0xec9788: ldr      x0, [sp, #0x20]
0xec978c: bl       #0x2288fc8 ; _objc_destroyWeak
0xec9790: ldr      x0, [sp, #0x28]
0xec9794: bl       #0x2288fc8 ; _objc_destroyWeak
0xec9798: stur     wzr, [x29, #-0x1c]
0xec979c: b        #0xec97a0
0xec97a0: sub      x0, x29, #0x18
0xec97a4: mov      x1, #0
0xec97a8: bl       #0x2289118 ; _objc_storeStrong
0xec97ac: ldp      x29, x30, [sp, #0xe0]
0xec97b0: add      sp, sp, #0xf0
0xec97b4: ret      
