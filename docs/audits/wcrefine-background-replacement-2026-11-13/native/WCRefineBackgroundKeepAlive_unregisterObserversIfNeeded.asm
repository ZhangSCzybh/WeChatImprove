-[WCRefineBackgroundKeepAlive unregisterObserversIfNeeded] 0xecaa88 v16@0:8
0xecaa88: sub      sp, sp, #0x70
0xecaa8c: stp      x29, x30, [sp, #0x60]
0xecaa90: add      x29, sp, #0x60
0xecaa94: stur     x0, [x29, #-8]
0xecaa98: stur     x1, [x29, #-0x10]
0xecaa9c: ldur     x0, [x29, #-8]
0xecaaa0: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xecaaa4: ldr      x1, [x8, #0x290] ; @selector(observersRegistered) | 'observersRegistered'
0xecaaa8: adrp     x8, #0x25f4000
0xecaaac: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecaab0: blr      x8
0xecaab4: tbnz     w0, #0, #0xecaac0
0xecaab8: b        #0xecaabc
0xecaabc: b        #0xecad34
0xecaac0: ldur     x0, [x29, #-8]
0xecaac4: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xecaac8: ldr      x1, [x8, #0x298] ; @selector(setObserversRegistered:) | 'setObserversRegistered:'
0xecaacc: adrp     x8, #0x25f4000
0xecaad0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecaad4: mov      w9, #0
0xecaad8: and      w2, w9, #1
0xecaadc: blr      x8
0xecaae0: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xecaae4: str      x8, [sp, #0x28] ; @selector(setWCRefineSearchEntryThemeBox:)
0xecaae8: ldr      x0, [x8, #0xa70]
0xecaaec: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xecaaf0: str      x8, [sp, #0x30] ; @selector(animationWithKeyPath:)
0xecaaf4: ldr      x1, [x8, #0xd0] ; @selector(defaultCenter) | 'defaultCenter'
0xecaaf8: adrp     x8, #0x25f4000
0xecaafc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecab00: blr      x8
0xecab04: mov      x29, x29
0xecab08: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xecab0c: str      x0, [sp]
0xecab10: ldur     x2, [x29, #-8]
0xecab14: adrp     x8, #0x25f4000
0xecab18: ldr      x8, [x8, #0xc0] ; _UIApplicationDidEnterBackgroundNotification
0xecab1c: ldr      x3, [x8]
0xecab20: adrp     x8, #0x2722000 ; @selector(screen)
0xecab24: stur     x8, [x29, #-0x28] ; @selector(screen)
0xecab28: ldr      x1, [x8, #0x20] ; @selector(removeObserver:name:object:) | 'removeObserver:name:object:'
0xecab2c: adrp     x8, #0x25f4000
0xecab30: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecab34: mov      x4, #0
0xecab38: stur     x4, [x29, #-0x20]
0xecab3c: blr      x8
0xecab40: ldr      x0, [sp]
0xecab44: adrp     x8, #0x25f4000
0xecab48: ldr      x8, [x8, #0x650] ; _objc_release
0xecab4c: blr      x8
0xecab50: ldr      x9, [sp, #0x28]
0xecab54: ldr      x8, [sp, #0x30]
0xecab58: ldr      x0, [x9, #0xa70]
0xecab5c: ldr      x1, [x8, #0xd0]
0xecab60: adrp     x8, #0x25f4000
0xecab64: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecab68: blr      x8
0xecab6c: mov      x29, x29
0xecab70: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xecab74: ldur     x8, [x29, #-0x28]
0xecab78: ldur     x4, [x29, #-0x20]
0xecab7c: str      x0, [sp, #8]
0xecab80: ldur     x2, [x29, #-8]
0xecab84: adrp     x9, #0x25f4000
0xecab88: ldr      x9, [x9, #0xf0] ; _UIApplicationWillEnterForegroundNotification
0xecab8c: ldr      x3, [x9]
0xecab90: ldr      x1, [x8, #0x20]
0xecab94: adrp     x8, #0x25f4000
0xecab98: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecab9c: blr      x8
0xecaba0: ldr      x0, [sp, #8]
0xecaba4: adrp     x8, #0x25f4000
0xecaba8: ldr      x8, [x8, #0x650] ; _objc_release
0xecabac: blr      x8
0xecabb0: ldr      x9, [sp, #0x28]
0xecabb4: ldr      x8, [sp, #0x30]
0xecabb8: ldr      x0, [x9, #0xa70]
0xecabbc: ldr      x1, [x8, #0xd0]
0xecabc0: adrp     x8, #0x25f4000
0xecabc4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecabc8: blr      x8
0xecabcc: mov      x29, x29
0xecabd0: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xecabd4: ldur     x8, [x29, #-0x28]
0xecabd8: ldur     x4, [x29, #-0x20]
0xecabdc: str      x0, [sp, #0x10]
0xecabe0: ldur     x2, [x29, #-8]
0xecabe4: adrp     x9, #0x25f4000
0xecabe8: ldr      x9, [x9, #0xb8] ; _UIApplicationDidBecomeActiveNotification
0xecabec: ldr      x3, [x9]
0xecabf0: ldr      x1, [x8, #0x20]
0xecabf4: adrp     x8, #0x25f4000
0xecabf8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecabfc: blr      x8
0xecac00: ldr      x0, [sp, #0x10]
0xecac04: adrp     x8, #0x25f4000
0xecac08: ldr      x8, [x8, #0x650] ; _objc_release
0xecac0c: blr      x8
0xecac10: ldr      x9, [sp, #0x28]
0xecac14: ldr      x8, [sp, #0x30]
0xecac18: ldr      x0, [x9, #0xa70]
0xecac1c: ldr      x1, [x8, #0xd0]
0xecac20: adrp     x8, #0x25f4000
0xecac24: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecac28: blr      x8
0xecac2c: mov      x29, x29
0xecac30: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xecac34: ldur     x8, [x29, #-0x28]
0xecac38: ldur     x4, [x29, #-0x20]
0xecac3c: str      x0, [sp, #0x18]
0xecac40: ldur     x2, [x29, #-8]
0xecac44: adrp     x9, #0x25f4000
0xecac48: ldr      x9, [x9, #0x500] ; _AVAudioSessionRouteChangeNotification
0xecac4c: ldr      x3, [x9]
0xecac50: ldr      x1, [x8, #0x20]
0xecac54: adrp     x8, #0x25f4000
0xecac58: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecac5c: blr      x8
0xecac60: ldr      x0, [sp, #0x18]
0xecac64: adrp     x8, #0x25f4000
0xecac68: ldr      x8, [x8, #0x650] ; _objc_release
0xecac6c: blr      x8
0xecac70: ldr      x9, [sp, #0x28]
0xecac74: ldr      x8, [sp, #0x30]
0xecac78: ldr      x0, [x9, #0xa70]
0xecac7c: ldr      x1, [x8, #0xd0]
0xecac80: adrp     x8, #0x25f4000
0xecac84: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecac88: blr      x8
0xecac8c: mov      x29, x29
0xecac90: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xecac94: ldur     x8, [x29, #-0x28]
0xecac98: ldur     x4, [x29, #-0x20]
0xecac9c: str      x0, [sp, #0x20]
0xecaca0: ldur     x2, [x29, #-8]
0xecaca4: adrp     x9, #0x25f4000
0xecaca8: ldr      x9, [x9, #0x4e0] ; _AVAudioSessionInterruptionNotification
0xecacac: ldr      x3, [x9]
0xecacb0: ldr      x1, [x8, #0x20]
0xecacb4: adrp     x8, #0x25f4000
0xecacb8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecacbc: blr      x8
0xecacc0: ldr      x0, [sp, #0x20]
0xecacc4: adrp     x8, #0x25f4000
0xecacc8: ldr      x8, [x8, #0x650] ; _objc_release
0xecaccc: blr      x8
0xecacd0: ldr      x9, [sp, #0x28]
0xecacd4: ldr      x8, [sp, #0x30]
0xecacd8: ldr      x0, [x9, #0xa70]
0xecacdc: ldr      x1, [x8, #0xd0]
0xecace0: adrp     x8, #0x25f4000
0xecace4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecace8: blr      x8
0xecacec: mov      x29, x29
0xecacf0: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xecacf4: ldur     x8, [x29, #-0x28]
0xecacf8: ldur     x4, [x29, #-0x20]
0xecacfc: stur     x0, [x29, #-0x18]
0xecad00: ldur     x2, [x29, #-8]
0xecad04: adrp     x9, #0x25f4000
0xecad08: ldr      x9, [x9, #0x508] ; _AVAudioSessionSilenceSecondaryAudioHintNotification
0xecad0c: ldr      x3, [x9]
0xecad10: ldr      x1, [x8, #0x20]
0xecad14: adrp     x8, #0x25f4000
0xecad18: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecad1c: blr      x8
0xecad20: ldur     x0, [x29, #-0x18]
0xecad24: adrp     x8, #0x25f4000
0xecad28: ldr      x8, [x8, #0x650] ; _objc_release
0xecad2c: blr      x8
0xecad30: b        #0xecad34
0xecad34: ldp      x29, x30, [sp, #0x60]
0xecad38: add      sp, sp, #0x70
0xecad3c: ret      
