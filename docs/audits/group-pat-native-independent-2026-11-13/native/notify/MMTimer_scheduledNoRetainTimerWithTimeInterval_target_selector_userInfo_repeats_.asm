+[MMTimer scheduledNoRetainTimerWithTimeInterval:target:selector:userInfo:repeats:] 0x1160ee538
0x1160ee538: sub      sp, sp, #0x160
0x1160ee53c: stp      d9, d8, [sp, #0xf0]
0x1160ee540: stp      x28, x27, [sp, #0x100]
0x1160ee544: stp      x26, x25, [sp, #0x110]
0x1160ee548: stp      x24, x23, [sp, #0x120]
0x1160ee54c: stp      x22, x21, [sp, #0x130]
0x1160ee550: stp      x20, x19, [sp, #0x140]
0x1160ee554: stp      x29, x30, [sp, #0x150]
0x1160ee558: add      x29, sp, #0x150
0x1160ee55c: mov      x19, x5
0x1160ee560: mov      x21, x4
0x1160ee564: mov      x20, x3
0x1160ee568: mov      x1, x2
0x1160ee56c: mov      v8.16b, v0.16b
0x1160ee570: sub      x0, x29, #0x70
0x1160ee574: bl       #0x116e5c4fc ; _objc_initWeak
0x1160ee578: adrp     x8, #0x11ed55000 ; classref WCCustomNavigationBarItemContentView
0x1160ee57c: ldr      x22, [x8, #0xcd0] ; classref MMNoRetainTimerTarget | Class MMNoRetainTimerTarget
0x1160ee580: mov      x0, x21
0x1160ee584: bl       #0x116e5c5d4 ; _objc_retain
0x1160ee588: mov      x0, x22 ; Class MMNoRetainTimerTarget
0x1160ee58c: bl       #0x116e5c3d0 ; _objc_alloc
0x1160ee590: mov      x22, x0
0x1160ee594: sub      x0, x29, #0x70
0x1160ee598: bl       #0x116e5c514 ; _objc_loadWeakRetained
0x1160ee59c: mov      x23, x0
0x1160ee5a0: adrp     x8, #0x11eca0000 ; @selector(animationDidReachToValueBlock)
0x1160ee5a4: ldr      x1, [x8, #0x880] ; @selector(initWithTarget:withAction:) | 'initWithTarget:withAction:'
0x1160ee5a8: mov      x0, x22
0x1160ee5ac: mov      x2, x23
0x1160ee5b0: mov      x3, x20
0x1160ee5b4: bl       #0x116e5c544 ; _objc_msgSend | selector=initWithTarget:withAction:
0x1160ee5b8: mov      x20, x0
0x1160ee5bc: mov      x0, x23
0x1160ee5c0: bl       #0x116e5c5bc ; _objc_release
0x1160ee5c4: adrp     x8, #0x11ed14000 ; classref SilkAudioCodec
0x1160ee5c8: ldr      x0, [x8, #0x3d8] ; _OBJC_CLASS_$_NSTimer
0x1160ee5cc: adrp     x8, #0x11eca0000 ; @selector(animationDidReachToValueBlock)
0x1160ee5d0: ldr      x3, [x8, #0x888] ; @selector(onNoRetainTimer:) | 'onNoRetainTimer:'
0x1160ee5d4: adrp     x8, #0x11ecaa000 ; @selector(processIdentifier)
0x1160ee5d8: ldr      x1, [x8, #0xa70] ; @selector(scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:) | 'scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:'
0x1160ee5dc: mov      v0.16b, v8.16b
0x1160ee5e0: mov      x2, x20
0x1160ee5e4: mov      x4, x21
0x1160ee5e8: mov      x5, x19
0x1160ee5ec: bl       #0x116e5c544 ; _objc_msgSend | selector=scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:
0x1160ee5f0: mov      x29, x29
0x1160ee5f4: bl       #0x116e5c5f8 ; _objc_retainAutoreleasedReturnValue
0x1160ee5f8: mov      x19, x0
0x1160ee5fc: mov      x0, x21
0x1160ee600: bl       #0x116e5c5bc ; _objc_release
0x1160ee604: sub      x24, x29, #0xa0
0x1160ee608: stp      xzr, x24, [x29, #-0xa0]
0x1160ee60c: adrp     x8, #0x1178cf000
0x1160ee610: ldr      d8, [x8, #0xb78]
0x1160ee614: stur     d8, [x29, #-0x90]
0x1160ee618: adrp     x21, #0x1160ee000
0x1160ee61c: add      x21, x21, #0x7a8
0x1160ee620: adrp     x22, #0x1160ee000
0x1160ee624: add      x22, x22, #0x7b4
0x1160ee628: stp      x21, x22, [x29, #-0x88]
0x1160ee62c: add      x0, x24, #0x28
0x1160ee630: mov      x1, x19
0x1160ee634: bl       #0x116e5c4fc ; _objc_initWeak
0x1160ee638: add      x25, sp, #0x80
0x1160ee63c: stp      xzr, x25, [sp, #0x80]
0x1160ee640: str      d8, [sp, #0x90]
0x1160ee644: stp      x21, x22, [sp, #0x98]
0x1160ee648: add      x0, x25, #0x28
0x1160ee64c: sub      x1, x29, #0x70
0x1160ee650: bl       #0x116e5c46c ; _objc_copyWeak
0x1160ee654: adrp     x26, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x1160ee658: ldr      x21, [x26, #0x920] ; classref DeallocHelper | Class DeallocHelper
0x1160ee65c: sub      x0, x29, #0x70
0x1160ee660: bl       #0x116e5c514 ; _objc_loadWeakRetained
0x1160ee664: mov      x22, x0
0x1160ee668: adrp     x27, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x1160ee66c: ldr      x27, [x27, #0x930] ; __NSConcreteStackBlock
0x1160ee670: str      x27, [sp, #0x48]
0x1160ee674: adrp     x8, #0x1178c7000
0x1160ee678: ldr      d8, [x8, #0x680]
0x1160ee67c: adrp     x8, #0x1160ee000
0x1160ee680: add      x8, x8, #0x7bc
0x1160ee684: str      d8, [sp, #0x50]
0x1160ee688: adrp     x28, #0x11cf35000
0x1160ee68c: add      x28, x28, #0xa38
0x1160ee690: stp      x8, x28, [sp, #0x58]
0x1160ee694: str      x25, [sp, #0x70]
0x1160ee698: mov      x0, x20
0x1160ee69c: bl       #0x116e5c5d4 ; _objc_retain
0x1160ee6a0: str      x20, [sp, #0x68]
0x1160ee6a4: str      x24, [sp, #0x78]
0x1160ee6a8: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x1160ee6ac: ldr      x23, [x8, #0xa70] ; @selector(attachToObject:key:whenDeallocDoThis:) | 'attachToObject:key:whenDeallocDoThis:'
0x1160ee6b0: add      x4, sp, #0x48
0x1160ee6b4: mov      x0, x21 ; Class DeallocHelper
0x1160ee6b8: mov      x1, x23 ; 'attachToObject:key:whenDeallocDoThis:'
0x1160ee6bc: mov      x2, x22
0x1160ee6c0: mov      x3, x20
0x1160ee6c4: bl       #0x116e5c544 ; _objc_msgSend | selector=attachToObject:key:whenDeallocDoThis:
0x1160ee6c8: mov      x0, x22
0x1160ee6cc: bl       #0x116e5c5bc ; _objc_release
0x1160ee6d0: ldr      x21, [x26, #0x920] ; classref DeallocHelper | Class DeallocHelper
0x1160ee6d4: str      x27, [sp, #0x10]
0x1160ee6d8: adrp     x8, #0x1160ee000
0x1160ee6dc: add      x8, x8, #0x87c
0x1160ee6e0: str      d8, [sp, #0x18]
0x1160ee6e4: stp      x8, x28, [sp, #0x20]
0x1160ee6e8: stp      x24, x25, [sp, #0x38]
0x1160ee6ec: str      x20, [sp, #0x30]
0x1160ee6f0: mov      x0, x20
0x1160ee6f4: bl       #0x116e5c5d4 ; _objc_retain
0x1160ee6f8: add      x4, sp, #0x10
0x1160ee6fc: mov      x0, x21 ; Class DeallocHelper
0x1160ee700: mov      x1, x23 ; 'attachToObject:key:whenDeallocDoThis:'
0x1160ee704: mov      x2, x19
0x1160ee708: mov      x3, x20
0x1160ee70c: bl       #0x116e5c544 ; _objc_msgSend | selector=attachToObject:key:whenDeallocDoThis:
0x1160ee710: adrp     x8, #0x11ed12000
0x1160ee714: ldr      x0, [x8, #0x8e8] ; classref MMTimer | Class MMTimer
0x1160ee718: bl       #0x116e5c3e8 ; _objc_alloc_init
0x1160ee71c: mov      x21, x0
0x1160ee720: adrp     x8, #0x11ea19000 ; @selector(setContentID:)
0x1160ee724: ldr      x1, [x8, #0x2e8] ; @selector(setM_timer:) | 'setM_timer:'
0x1160ee728: mov      x2, x19
0x1160ee72c: bl       #0x116e5c544 ; _objc_msgSend | selector=setM_timer:
0x1160ee730: ldr      x0, [sp, #0x30]
0x1160ee734: bl       #0x116e5c5bc ; _objc_release
0x1160ee738: ldr      x0, [sp, #0x68]
0x1160ee73c: bl       #0x116e5c5bc ; _objc_release
0x1160ee740: mov      x0, x20
0x1160ee744: bl       #0x116e5c5bc ; _objc_release
0x1160ee748: add      x0, sp, #0x80
0x1160ee74c: mov      w1, #8
0x1160ee750: bl       #0x116e52b24 ; __Block_object_dispose
0x1160ee754: add      x0, x25, #0x28
0x1160ee758: bl       #0x116e5c478 ; _objc_destroyWeak
0x1160ee75c: sub      x0, x29, #0xa0
0x1160ee760: mov      w1, #8
0x1160ee764: bl       #0x116e52b24 ; __Block_object_dispose
0x1160ee768: add      x0, x24, #0x28
0x1160ee76c: bl       #0x116e5c478 ; _objc_destroyWeak
0x1160ee770: mov      x0, x19
0x1160ee774: bl       #0x116e5c5bc ; _objc_release
0x1160ee778: sub      x0, x29, #0x70
0x1160ee77c: bl       #0x116e5c478 ; _objc_destroyWeak
0x1160ee780: mov      x0, x21
0x1160ee784: ldp      x29, x30, [sp, #0x150]
0x1160ee788: ldp      x20, x19, [sp, #0x140]
0x1160ee78c: ldp      x22, x21, [sp, #0x130]
0x1160ee790: ldp      x24, x23, [sp, #0x120]
0x1160ee794: ldp      x26, x25, [sp, #0x110] ; classref CommonAffServiceCenterCpp
0x1160ee798: ldp      x28, x27, [sp, #0x100]
0x1160ee79c: ldp      d9, d8, [sp, #0xf0]
0x1160ee7a0: add      sp, sp, #0x160
0x1160ee7a4: b        #0x116e5c430 ; _objc_autoreleaseReturnValue
