-[WCRefineBackgroundKeepAlive registerObserversIfNeeded] 0xeca8a0 v16@0:8
0xeca8a0: sub      sp, sp, #0x50
0xeca8a4: stp      x29, x30, [sp, #0x40]
0xeca8a8: add      x29, sp, #0x40
0xeca8ac: stur     x0, [x29, #-8]
0xeca8b0: stur     x1, [x29, #-0x10]
0xeca8b4: ldur     x0, [x29, #-8]
0xeca8b8: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xeca8bc: ldr      x1, [x8, #0x290] ; @selector(observersRegistered) | 'observersRegistered'
0xeca8c0: adrp     x8, #0x25f4000
0xeca8c4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca8c8: blr      x8
0xeca8cc: tbz      w0, #0, #0xeca8d8
0xeca8d0: b        #0xeca8d4
0xeca8d4: b        #0xecaa7c
0xeca8d8: ldur     x0, [x29, #-8]
0xeca8dc: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xeca8e0: ldr      x1, [x8, #0x298] ; @selector(setObserversRegistered:) | 'setObserversRegistered:'
0xeca8e4: adrp     x8, #0x25f4000
0xeca8e8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca8ec: mov      w9, #1
0xeca8f0: and      w2, w9, #1
0xeca8f4: blr      x8
0xeca8f8: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xeca8fc: ldr      x0, [x8, #0xa70]
0xeca900: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xeca904: ldr      x1, [x8, #0xd0] ; @selector(defaultCenter) | 'defaultCenter'
0xeca908: adrp     x8, #0x25f4000
0xeca90c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca910: blr      x8
0xeca914: mov      x29, x29
0xeca918: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xeca91c: sub      x8, x29, #0x18
0xeca920: str      x8, [sp, #0x18]
0xeca924: stur     x0, [x29, #-0x18]
0xeca928: ldur     x0, [x29, #-0x18]
0xeca92c: ldur     x2, [x29, #-8]
0xeca930: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xeca934: ldr      x3, [x8, #0x2a0] ; @selector(appDidEnterBackground) | 'appDidEnterBackground'
0xeca938: adrp     x8, #0x25f4000
0xeca93c: ldr      x8, [x8, #0xc0] ; _UIApplicationDidEnterBackgroundNotification
0xeca940: ldr      x4, [x8]
0xeca944: adrp     x8, #0x271f000
0xeca948: str      x8, [sp, #0x10]
0xeca94c: ldr      x1, [x8, #0x4b0] ; @selector(addObserver:selector:name:object:) | 'addObserver:selector:name:object:'
0xeca950: adrp     x8, #0x25f4000
0xeca954: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca958: mov      x5, #0
0xeca95c: str      x5, [sp, #0x20]
0xeca960: blr      x8
0xeca964: ldr      x8, [sp, #0x10]
0xeca968: ldr      x5, [sp, #0x20]
0xeca96c: ldur     x0, [x29, #-0x18]
0xeca970: ldur     x2, [x29, #-8]
0xeca974: adrp     x9, #0x272e000 ; @selector(persistUsageCache)
0xeca978: ldr      x3, [x9, #0x2a8] ; @selector(appWillEnterForeground) | 'appWillEnterForeground'
0xeca97c: adrp     x9, #0x25f4000
0xeca980: ldr      x9, [x9, #0xf0] ; _UIApplicationWillEnterForegroundNotification
0xeca984: ldr      x4, [x9]
0xeca988: ldr      x1, [x8, #0x4b0]
0xeca98c: adrp     x8, #0x25f4000
0xeca990: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca994: blr      x8
0xeca998: ldr      x8, [sp, #0x10]
0xeca99c: ldr      x5, [sp, #0x20]
0xeca9a0: ldur     x0, [x29, #-0x18]
0xeca9a4: ldur     x2, [x29, #-8]
0xeca9a8: adrp     x9, #0x272e000 ; @selector(persistUsageCache)
0xeca9ac: ldr      x3, [x9, #0x2b0] ; @selector(appDidBecomeActive) | 'appDidBecomeActive'
0xeca9b0: adrp     x9, #0x25f4000
0xeca9b4: ldr      x9, [x9, #0xb8] ; _UIApplicationDidBecomeActiveNotification
0xeca9b8: ldr      x4, [x9]
0xeca9bc: ldr      x1, [x8, #0x4b0]
0xeca9c0: adrp     x8, #0x25f4000
0xeca9c4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xeca9c8: blr      x8
0xeca9cc: ldr      x8, [sp, #0x10]
0xeca9d0: ldr      x5, [sp, #0x20]
0xeca9d4: ldur     x0, [x29, #-0x18]
0xeca9d8: ldur     x2, [x29, #-8]
0xeca9dc: adrp     x9, #0x272e000 ; @selector(persistUsageCache)
0xeca9e0: str      x9, [sp, #8] ; @selector(persistUsageCache)
0xeca9e4: ldr      x3, [x9, #0x2b8] ; @selector(audioSessionMayHaveChanged:) | 'audioSessionMayHaveChanged:'
0xeca9e8: adrp     x9, #0x25f4000
0xeca9ec: ldr      x9, [x9, #0x500] ; _AVAudioSessionRouteChangeNotification
0xeca9f0: ldr      x4, [x9]
0xeca9f4: ldr      x1, [x8, #0x4b0]
0xeca9f8: adrp     x8, #0x25f4000
0xeca9fc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecaa00: blr      x8
0xecaa04: ldr      x9, [sp, #8]
0xecaa08: ldr      x8, [sp, #0x10]
0xecaa0c: ldr      x5, [sp, #0x20]
0xecaa10: ldur     x0, [x29, #-0x18]
0xecaa14: ldur     x2, [x29, #-8]
0xecaa18: ldr      x3, [x9, #0x2b8]
0xecaa1c: adrp     x9, #0x25f4000
0xecaa20: ldr      x9, [x9, #0x4e0] ; _AVAudioSessionInterruptionNotification
0xecaa24: ldr      x4, [x9]
0xecaa28: ldr      x1, [x8, #0x4b0]
0xecaa2c: adrp     x8, #0x25f4000
0xecaa30: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecaa34: blr      x8
0xecaa38: ldr      x9, [sp, #8]
0xecaa3c: ldr      x8, [sp, #0x10]
0xecaa40: ldr      x5, [sp, #0x20]
0xecaa44: ldur     x0, [x29, #-0x18]
0xecaa48: ldur     x2, [x29, #-8]
0xecaa4c: ldr      x3, [x9, #0x2b8]
0xecaa50: adrp     x9, #0x25f4000
0xecaa54: ldr      x9, [x9, #0x508] ; _AVAudioSessionSilenceSecondaryAudioHintNotification
0xecaa58: ldr      x4, [x9]
0xecaa5c: ldr      x1, [x8, #0x4b0]
0xecaa60: adrp     x8, #0x25f4000
0xecaa64: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecaa68: blr      x8
0xecaa6c: ldr      x0, [sp, #0x18]
0xecaa70: ldr      x1, [sp, #0x20]
0xecaa74: bl       #0x2289118 ; _objc_storeStrong
0xecaa78: b        #0xecaa7c
0xecaa7c: ldp      x29, x30, [sp, #0x40]
0xecaa80: add      sp, sp, #0x50
0xecaa84: ret      
