-[WCRefineBackgroundKeepAlive startIfNeeded] 0xec80e0 v16@0:8
0xec80e0: sub      sp, sp, #0xe0
0xec80e4: stp      x29, x30, [sp, #0xd0]
0xec80e8: add      x29, sp, #0xd0
0xec80ec: stur     x0, [x29, #-8]
0xec80f0: stur     x1, [x29, #-0x10]
0xec80f4: ldur     x0, [x29, #-8]
0xec80f8: adrp     x8, #0x2723000 ; @selector(menuArrowColorEnabled)
0xec80fc: ldr      x1, [x8, #0x9f0] ; @selector(isEnabled) | 'isEnabled'
0xec8100: adrp     x8, #0x25f4000
0xec8104: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8108: blr      x8
0xec810c: tbnz     w0, #0, #0xec8118
0xec8110: b        #0xec8114
0xec8114: b        #0xec85e8
0xec8118: ldur     x0, [x29, #-8]
0xec811c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8120: ldr      x1, [x8, #0x180] ; @selector(backgroundEnteredAt) | 'backgroundEnteredAt'
0xec8124: adrp     x8, #0x25f4000
0xec8128: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec812c: blr      x8
0xec8130: mov      x29, x29
0xec8134: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec8138: stur     x0, [x29, #-0x58]
0xec813c: adrp     x8, #0x25f4000
0xec8140: ldr      x8, [x8, #0x650] ; _objc_release
0xec8144: blr      x8
0xec8148: ldur     x0, [x29, #-0x58]
0xec814c: cbnz     x0, #0xec81ac
0xec8150: b        #0xec8154
0xec8154: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec8158: ldr      x0, [x8, #0xa98]
0xec815c: adrp     x8, #0x271f000
0xec8160: ldr      x1, [x8, #0x500] ; @selector(date) | 'date'
0xec8164: adrp     x8, #0x25f4000
0xec8168: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec816c: blr      x8
0xec8170: mov      x29, x29
0xec8174: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec8178: mov      x2, x0
0xec817c: stur     x2, [x29, #-0x60]
0xec8180: ldur     x0, [x29, #-8]
0xec8184: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8188: ldr      x1, [x8, #0x158] ; @selector(setBackgroundEnteredAt:) | 'setBackgroundEnteredAt:'
0xec818c: adrp     x8, #0x25f4000
0xec8190: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8194: blr      x8
0xec8198: ldur     x0, [x29, #-0x60]
0xec819c: adrp     x8, #0x25f4000
0xec81a0: ldr      x8, [x8, #0x650] ; _objc_release
0xec81a4: blr      x8
0xec81a8: b        #0xec81ac
0xec81ac: ldur     x0, [x29, #-8]
0xec81b0: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec81b4: ldr      x1, [x8, #0x188] ; @selector(bgTaskIdentifier) | 'bgTaskIdentifier'
0xec81b8: adrp     x8, #0x25f4000
0xec81bc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec81c0: blr      x8
0xec81c4: adrp     x8, #0x25f4000
0xec81c8: ldr      x8, [x8, #0x108] ; _UIBackgroundTaskInvalid
0xec81cc: ldr      x8, [x8]
0xec81d0: subs     x8, x0, x8
0xec81d4: b.ne     #0xec8304
0xec81d8: b        #0xec81dc
0xec81dc: ldur     x1, [x29, #-8]
0xec81e0: sub      x0, x29, #0x18
0xec81e4: bl       #0x2289040 ; _objc_initWeak
0xec81e8: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec81ec: ldr      x0, [x8, #0xb20]
0xec81f0: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xec81f4: ldr      x1, [x8, #0x5f8] ; @selector(sharedApplication) | 'sharedApplication'
0xec81f8: adrp     x8, #0x25f4000
0xec81fc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8200: blr      x8
0xec8204: str      x0, [sp, #0x68]
0xec8208: b        #0xec820c
0xec820c: ldr      x0, [sp, #0x68]
0xec8210: mov      x29, x29
0xec8214: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec8218: str      x0, [sp, #0x50]
0xec821c: sub      x8, x29, #0x50
0xec8220: str      x8, [sp, #0x58]
0xec8224: adrp     x9, #0x25f4000
0xec8228: ldr      x9, [x9, #0x680] ; __NSConcreteStackBlock
0xec822c: stur     x9, [x29, #-0x50]
0xec8230: mov      w9, #-0x3e000000
0xec8234: stur     w9, [x29, #-0x48]
0xec8238: stur     wzr, [x29, #-0x44]
0xec823c: adrp     x9, #0xec8000
0xec8240: add      x9, x9, #0x5fc
0xec8244: stur     x9, [x29, #-0x40]
0xec8248: adrp     x9, #0x25f7000
0xec824c: add      x9, x9, #0xe50
0xec8250: stur     x9, [x29, #-0x38]
0xec8254: add      x0, x8, #0x20
0xec8258: str      x0, [sp, #0x48]
0xec825c: sub      x1, x29, #0x18
0xec8260: bl       #0x2288fbc ; _objc_copyWeak
0xec8264: ldr      x0, [sp, #0x50]
0xec8268: ldr      x2, [sp, #0x58]
0xec826c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8270: ldr      x1, [x8, #0x198] ; @selector(beginBackgroundTaskWithExpirationHandler:) | 'beginBackgroundTaskWithExpirationHandler:'
0xec8274: adrp     x8, #0x25f4000
0xec8278: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec827c: blr      x8
0xec8280: str      x0, [sp, #0x60]
0xec8284: b        #0xec8288
0xec8288: ldr      x2, [sp, #0x60]
0xec828c: ldur     x0, [x29, #-8]
0xec8290: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8294: ldr      x1, [x8, #0x1a0] ; @selector(setBgTaskIdentifier:) | 'setBgTaskIdentifier:'
0xec8298: adrp     x8, #0x25f4000
0xec829c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec82a0: blr      x8
0xec82a4: b        #0xec82a8
0xec82a8: ldr      x0, [sp, #0x50]
0xec82ac: adrp     x8, #0x25f4000
0xec82b0: ldr      x8, [x8, #0x650] ; _objc_release
0xec82b4: blr      x8
0xec82b8: ldr      x0, [sp, #0x48]
0xec82bc: bl       #0x2288fc8 ; _objc_destroyWeak
0xec82c0: sub      x0, x29, #0x18
0xec82c4: bl       #0x2288fc8 ; _objc_destroyWeak
0xec82c8: b        #0xec8304
0xec82cc: stur     x0, [x29, #-0x20]
0xec82d0: mov      x8, x1
0xec82d4: stur     w8, [x29, #-0x24]
0xec82d8: b        #0xec82f8
0xec82dc: mov      x8, x0
0xec82e0: ldr      x0, [sp, #0x48]
0xec82e4: stur     x8, [x29, #-0x20]
0xec82e8: mov      x8, x1
0xec82ec: stur     w8, [x29, #-0x24]
0xec82f0: bl       #0x2288fc8 ; _objc_destroyWeak
0xec82f4: b        #0xec82f8
0xec82f8: sub      x0, x29, #0x18
0xec82fc: bl       #0x2288fc8 ; _objc_destroyWeak
0xec8300: b        #0xec85f4
0xec8304: ldur     x0, [x29, #-8]
0xec8308: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec830c: ldr      x1, [x8, #0x1a8] ; @selector(cancelGracePulse) | 'cancelGracePulse'
0xec8310: adrp     x8, #0x25f4000
0xec8314: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8318: blr      x8
0xec831c: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec8320: ldr      x0, [x8, #0xd20]
0xec8324: ldur     x2, [x29, #-8]
0xec8328: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec832c: ldr      x3, [x8, #0x1b0] ; @selector(onGracePulse) | 'onGracePulse'
0xec8330: adrp     x8, #0x2727000 ; @selector(atMentionNotificationEnabled)
0xec8334: ldr      x1, [x8, #0x4b8] ; @selector(scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:) | 'scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:'
0xec8338: adrp     x8, #0x25f4000
0xec833c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8340: fmov     d0, #1.50000000
0xec8344: mov      x4, #0
0xec8348: mov      w9, #0
0xec834c: and      w5, w9, #1
0xec8350: blr      x8
0xec8354: mov      x29, x29
0xec8358: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec835c: mov      x2, x0
0xec8360: str      x2, [sp, #0x28]
0xec8364: ldur     x0, [x29, #-8]
0xec8368: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec836c: ldr      x1, [x8, #0x1b8] ; @selector(setGracePulseTimer:) | 'setGracePulseTimer:'
0xec8370: adrp     x8, #0x25f4000
0xec8374: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8378: blr      x8
0xec837c: ldr      x0, [sp, #0x28]
0xec8380: adrp     x8, #0x25f4000
0xec8384: ldr      x8, [x8, #0x650] ; _objc_release
0xec8388: blr      x8
0xec838c: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec8390: ldr      x0, [x8, #0xca8]
0xec8394: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xec8398: ldr      x1, [x8, #0x298] ; @selector(mainRunLoop) | 'mainRunLoop'
0xec839c: adrp     x8, #0x25f4000
0xec83a0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec83a4: blr      x8
0xec83a8: mov      x29, x29
0xec83ac: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec83b0: str      x0, [sp, #0x38]
0xec83b4: ldur     x0, [x29, #-8]
0xec83b8: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec83bc: ldr      x1, [x8, #0x1c0] ; @selector(gracePulseTimer) | 'gracePulseTimer'
0xec83c0: adrp     x8, #0x25f4000
0xec83c4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec83c8: blr      x8
0xec83cc: mov      x29, x29
0xec83d0: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec83d4: mov      x2, x0
0xec83d8: ldr      x0, [sp, #0x38]
0xec83dc: str      x2, [sp, #0x30]
0xec83e0: adrp     x8, #0x25f4000
0xec83e4: ldr      x8, [x8, #0x260] ; _NSRunLoopCommonModes
0xec83e8: ldr      x3, [x8]
0xec83ec: adrp     x8, #0x274d000 ; @selector(previewingModelId)
0xec83f0: ldr      x1, [x8, #0xfc0] ; @selector(addTimer:forMode:) | 'addTimer:forMode:'
0xec83f4: adrp     x8, #0x25f4000
0xec83f8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec83fc: blr      x8
0xec8400: ldr      x0, [sp, #0x30]
0xec8404: adrp     x8, #0x25f4000
0xec8408: ldr      x8, [x8, #0x650] ; _objc_release
0xec840c: blr      x8
0xec8410: ldr      x0, [sp, #0x38]
0xec8414: adrp     x8, #0x25f4000
0xec8418: ldr      x8, [x8, #0x650] ; _objc_release
0xec841c: blr      x8
0xec8420: ldur     x0, [x29, #-8]
0xec8424: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8428: ldr      x1, [x8, #0x1c8] ; @selector(bgTimer) | 'bgTimer'
0xec842c: adrp     x8, #0x25f4000
0xec8430: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8434: blr      x8
0xec8438: mov      x29, x29
0xec843c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec8440: str      x0, [sp, #0x40]
0xec8444: adrp     x8, #0x25f4000
0xec8448: ldr      x8, [x8, #0x650] ; _objc_release
0xec844c: blr      x8
0xec8450: ldr      x0, [sp, #0x40]
0xec8454: cbz      x0, #0xec84c4
0xec8458: b        #0xec845c
0xec845c: ldur     x0, [x29, #-8]
0xec8460: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8464: ldr      x1, [x8, #0x1c8] ; @selector(bgTimer) | 'bgTimer'
0xec8468: adrp     x8, #0x25f4000
0xec846c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8470: blr      x8
0xec8474: mov      x29, x29
0xec8478: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec847c: str      x0, [sp, #0x20]
0xec8480: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xec8484: ldr      x1, [x8, #0x248] ; @selector(invalidate) | 'invalidate'
0xec8488: adrp     x8, #0x25f4000
0xec848c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8490: blr      x8
0xec8494: ldr      x0, [sp, #0x20]
0xec8498: adrp     x8, #0x25f4000
0xec849c: ldr      x8, [x8, #0x650] ; _objc_release
0xec84a0: blr      x8
0xec84a4: ldur     x0, [x29, #-8]
0xec84a8: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec84ac: ldr      x1, [x8, #0x1d0] ; @selector(setBgTimer:) | 'setBgTimer:'
0xec84b0: adrp     x8, #0x25f4000
0xec84b4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec84b8: mov      x2, #0
0xec84bc: blr      x8
0xec84c0: b        #0xec84c4
0xec84c4: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec84c8: ldr      x8, [x8, #0xd20]
0xec84cc: str      x8, [sp]
0xec84d0: ldur     x0, [x29, #-8]
0xec84d4: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec84d8: ldr      x1, [x8, #0x1d8] ; @selector(timerInterval) | 'timerInterval'
0xec84dc: adrp     x8, #0x25f4000
0xec84e0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec84e4: blr      x8
0xec84e8: ldr      x0, [sp]
0xec84ec: ldur     x2, [x29, #-8]
0xec84f0: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec84f4: ldr      x3, [x8, #0x1e0] ; @selector(onTimer) | 'onTimer'
0xec84f8: adrp     x8, #0x2727000 ; @selector(atMentionNotificationEnabled)
0xec84fc: ldr      x1, [x8, #0x4b8] ; @selector(scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:) | 'scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:'
0xec8500: adrp     x8, #0x25f4000
0xec8504: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8508: mov      x4, #0
0xec850c: mov      w9, #1
0xec8510: and      w5, w9, #1
0xec8514: blr      x8
0xec8518: mov      x29, x29
0xec851c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec8520: mov      x2, x0
0xec8524: str      x2, [sp, #8]
0xec8528: ldur     x0, [x29, #-8]
0xec852c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8530: ldr      x1, [x8, #0x1d0] ; @selector(setBgTimer:) | 'setBgTimer:'
0xec8534: adrp     x8, #0x25f4000
0xec8538: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec853c: blr      x8
0xec8540: ldr      x0, [sp, #8]
0xec8544: adrp     x8, #0x25f4000
0xec8548: ldr      x8, [x8, #0x650] ; _objc_release
0xec854c: blr      x8
0xec8550: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xec8554: ldr      x0, [x8, #0xca8]
0xec8558: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xec855c: ldr      x1, [x8, #0x298] ; @selector(mainRunLoop) | 'mainRunLoop'
0xec8560: adrp     x8, #0x25f4000
0xec8564: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec8568: blr      x8
0xec856c: mov      x29, x29
0xec8570: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec8574: str      x0, [sp, #0x18]
0xec8578: ldur     x0, [x29, #-8]
0xec857c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec8580: ldr      x1, [x8, #0x1c8] ; @selector(bgTimer) | 'bgTimer'
0xec8584: adrp     x8, #0x25f4000
0xec8588: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec858c: blr      x8
0xec8590: mov      x29, x29
0xec8594: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec8598: mov      x2, x0
0xec859c: ldr      x0, [sp, #0x18]
0xec85a0: str      x2, [sp, #0x10]
0xec85a4: adrp     x8, #0x25f4000
0xec85a8: ldr      x8, [x8, #0x260] ; _NSRunLoopCommonModes
0xec85ac: ldr      x3, [x8]
0xec85b0: adrp     x8, #0x274d000 ; @selector(previewingModelId)
0xec85b4: ldr      x1, [x8, #0xfc0] ; @selector(addTimer:forMode:) | 'addTimer:forMode:'
0xec85b8: adrp     x8, #0x25f4000
0xec85bc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec85c0: blr      x8
0xec85c4: ldr      x0, [sp, #0x10]
0xec85c8: adrp     x8, #0x25f4000
0xec85cc: ldr      x8, [x8, #0x650] ; _objc_release
0xec85d0: blr      x8
0xec85d4: ldr      x0, [sp, #0x18]
0xec85d8: adrp     x8, #0x25f4000
0xec85dc: ldr      x8, [x8, #0x650] ; _objc_release
0xec85e0: blr      x8
0xec85e4: b        #0xec85e8
0xec85e8: ldp      x29, x30, [sp, #0xd0]
0xec85ec: add      sp, sp, #0xe0
0xec85f0: ret      
0xec85f4: ldur     x0, [x29, #-0x20]
0xec85f8: bl       #0x22888f0 ; __Unwind_Resume
