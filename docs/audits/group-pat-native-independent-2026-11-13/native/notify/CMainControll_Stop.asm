-[CMainControll Stop] 0x104d15900 v16@0:8
0x104d15900: sub      sp, sp, #0x80
0x104d15904: stp      x26, x25, [sp, #0x30]
0x104d15908: stp      x24, x23, [sp, #0x40]
0x104d1590c: stp      x22, x21, [sp, #0x50]
0x104d15910: stp      x20, x19, [sp, #0x60]
0x104d15914: stp      x29, x30, [sp, #0x70]
0x104d15918: add      x29, sp, #0x70
0x104d1591c: mov      x19, x0
0x104d15920: adrp     x8, #0x11f751000
0x104d15924: mov      w9, #1
0x104d15928: strb     w9, [x8, #0x95d]
0x104d1592c: adrp     x8, #0x11ed12000
0x104d15930: ldr      x0, [x8, #0x898] ; _OBJC_CLASS_$_NSObject
0x104d15934: adrp     x8, #0x11e9ce000 ; @selector(onAddMsg:roomID:)
0x104d15938: ldr      x1, [x8, #0xf0] ; @selector(safeCancelPreviousPerformRequestsWithTarget:) | 'safeCancelPreviousPerformRequestsWithTarget:'
0x104d1593c: mov      x2, x19
0x104d15940: bl       #0x107c27c64 ; _objc_msgSend | selector=safeCancelPreviousPerformRequestsWithTarget:
0x104d15944: adrp     x8, #0x11ed12000
0x104d15948: ldr      x0, [x8, #0x840] ; classref CAppUtil | Class CAppUtil
0x104d1594c: adrp     x8, #0x11e9c9000
0x104d15950: ldr      x1, [x8, #0xc08] ; @selector(removePBEventObserverListItemByObject:) | 'removePBEventObserverListItemByObject:'
0x104d15954: mov      x2, x19
0x104d15958: bl       #0x107c27c64 ; _objc_msgSend | selector=removePBEventObserverListItemByObject:
0x104d1595c: ldr      x0, [x19, #0x18]
0x104d15960: cbz      x0, #0x104d15974
0x104d15964: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x104d15968: ldr      x1, [x8, #0x660] ; @selector(invalidate) | 'invalidate'
0x104d1596c: bl       #0x107c27c64 ; _objc_msgSend | selector=invalidate
0x104d15970: ldr      x0, [x19, #0x18]
0x104d15974: str      xzr, [x19, #0x18]
0x104d15978: bl       #0x107c27c70 ; _objc_release
0x104d1597c: ldrb     w8, [x19, #0x58]
0x104d15980: tbnz     w8, #0, #0x104d15a70
0x104d15984: adrp     x1, #0x11a1ac000 ; 'View'
0x104d15988: add      x1, x1, #0x4f0 ; '-[CMainControll Stop]'
0x104d1598c: adrp     x2, #0x11a1ac000 ; 'View'
0x104d15990: add      x2, x2, #0x506 ; 'stopEventService'
0x104d15994: mov      x0, sp
0x104d15998: mov      x3, #0
0x104d1599c: bl       #0x107c0cbd4
0x104d159a0: adrp     x24, #0x11ed12000
0x104d159a4: ldr      x0, [x24, #0x780] ; classref MMContext | Class MMContext
0x104d159a8: adrp     x8, #0x11e9c9000
0x104d159ac: ldr      x21, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x104d159b0: mov      x1, x21 ; 'currentContext'
0x104d159b4: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104d159b8: mov      x29, x29
0x104d159bc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d159c0: mov      x23, x0
0x104d159c4: adrp     x25, #0x11ed12000
0x104d159c8: ldr      x0, [x25, #0xaf8] ; classref EventService | Class EventService
0x104d159cc: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104d159d0: ldr      x22, [x8, #0x508] ; @selector(class) | 'class'
0x104d159d4: mov      x1, x22 ; 'class'
0x104d159d8: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104d159dc: mov      x2, x0
0x104d159e0: adrp     x8, #0x11e9c9000
0x104d159e4: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x104d159e8: mov      x0, x23
0x104d159ec: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104d159f0: mov      x29, x29
0x104d159f4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d159f8: mov      x20, x0
0x104d159fc: mov      x0, x23
0x104d15a00: bl       #0x107c27c70 ; _objc_release
0x104d15a04: cbz      x20, #0x104d15a58
0x104d15a08: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d15a0c: ldr      x1, [x8, #0x648] ; @selector(StopService) | 'StopService'
0x104d15a10: mov      x0, x20
0x104d15a14: bl       #0x107c27c64 ; _objc_msgSend | selector=StopService
0x104d15a18: ldr      x0, [x24, #0x780] ; classref MMContext | Class MMContext
0x104d15a1c: mov      x1, x21 ; 'currentContext'
0x104d15a20: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104d15a24: mov      x29, x29
0x104d15a28: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15a2c: mov      x21, x0
0x104d15a30: ldr      x0, [x25, #0xaf8] ; classref EventService | Class EventService
0x104d15a34: mov      x1, x22 ; 'class'
0x104d15a38: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104d15a3c: mov      x2, x0
0x104d15a40: adrp     x8, #0x11ea15000 ; @selector(onRecvQuestionInfo:)
0x104d15a44: ldr      x1, [x8, #0xc80] ; @selector(removeService:) | 'removeService:'
0x104d15a48: mov      x0, x21
0x104d15a4c: bl       #0x107c27c64 ; _objc_msgSend | selector=removeService:
0x104d15a50: mov      x0, x21
0x104d15a54: bl       #0x107c27c70 ; _objc_release
0x104d15a58: mov      x0, sp
0x104d15a5c: bl       #0x107c0cbd8
0x104d15a60: mov      x0, x20
0x104d15a64: bl       #0x107c27c70 ; _objc_release
0x104d15a68: mov      x0, sp
0x104d15a6c: bl       #0x107c0cbdc
0x104d15a70: add      x0, x19, #0x20
0x104d15a74: mov      x1, #0
0x104d15a78: bl       #0x107c27ca0 ; _objc_storeWeak
0x104d15a7c: adrp     x1, #0x11a1ac000 ; 'View'
0x104d15a80: add      x1, x1, #0x4f0 ; '-[CMainControll Stop]'
0x104d15a84: adrp     x2, #0x11a1ac000 ; 'View'
0x104d15a88: add      x2, x2, #0x517 ; 'stopMMDB'
0x104d15a8c: mov      x0, sp
0x104d15a90: mov      x3, #0
0x104d15a94: bl       #0x107c0cbd4
0x104d15a98: ldr      x0, [x19, #8]
0x104d15a9c: cbz      x0, #0x104d15aac
0x104d15aa0: adrp     x8, #0x11e9ce000 ; @selector(onAddMsg:roomID:)
0x104d15aa4: ldr      x1, [x8, #0xc60] ; @selector(Close) | 'Close'
0x104d15aa8: bl       #0x107c27c64 ; _objc_msgSend | selector=Close
0x104d15aac: mov      x0, sp
0x104d15ab0: bl       #0x107c0cbd8
0x104d15ab4: ldr      x0, [x19, #0x30]
0x104d15ab8: str      xzr, [x19, #0x30]
0x104d15abc: bl       #0x107c27c70 ; _objc_release
0x104d15ac0: mov      w8, #1
0x104d15ac4: strb     w8, [x19, #0x58]
0x104d15ac8: mov      x0, sp
0x104d15acc: bl       #0x107c0cbdc
0x104d15ad0: ldp      x29, x30, [sp, #0x70]
0x104d15ad4: ldp      x20, x19, [sp, #0x60]
0x104d15ad8: ldp      x22, x21, [sp, #0x50] ; 'class'
0x104d15adc: ldp      x24, x23, [sp, #0x40]
0x104d15ae0: ldp      x26, x25, [sp, #0x30]
0x104d15ae4: add      sp, sp, #0x80
0x104d15ae8: ret      
