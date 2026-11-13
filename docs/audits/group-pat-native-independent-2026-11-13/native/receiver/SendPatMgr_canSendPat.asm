-[SendPatMgr canSendPat] 0x105a93a7c B16@0:8
0x105a93a7c: stp      x22, x21, [sp, #-0x30]!
0x105a93a80: stp      x20, x19, [sp, #0x10]
0x105a93a84: stp      x29, x30, [sp, #0x20]
0x105a93a88: add      x29, sp, #0x20
0x105a93a8c: adrp     x8, #0x11ed12000
0x105a93a90: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105a93a94: adrp     x8, #0x11e9c9000
0x105a93a98: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105a93a9c: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105a93aa0: mov      x29, x29
0x105a93aa4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a93aa8: mov      x19, x0
0x105a93aac: adrp     x8, #0x11ed12000
0x105a93ab0: ldr      x0, [x8, #0x8c0] ; classref MMConfigMgr | Class MMConfigMgr
0x105a93ab4: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105a93ab8: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x105a93abc: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x105a93ac0: mov      x2, x0
0x105a93ac4: adrp     x8, #0x11e9c9000
0x105a93ac8: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x105a93acc: mov      x0, x19
0x105a93ad0: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x105a93ad4: mov      x29, x29
0x105a93ad8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a93adc: mov      x20, x0
0x105a93ae0: adrp     x8, #0x11ea08000 ; @selector(applicationSequence)
0x105a93ae4: ldr      x1, [x8, #0x608] ; @selector(uintFromDynamicConfigForKey:defaultValue:) | 'uintFromDynamicConfigForKey:defaultValue:'
0x105a93ae8: adrp     x2, #0x11d332000
0x105a93aec: add      x2, x2, #0x698 ; @'DisableSendPat'
0x105a93af0: mov      x3, #0
0x105a93af4: bl       #0x107c27c64 ; _objc_msgSend | selector=uintFromDynamicConfigForKey:defaultValue:
0x105a93af8: mov      x21, x0
0x105a93afc: mov      x0, x20
0x105a93b00: bl       #0x107c27c70 ; _objc_release
0x105a93b04: mov      x0, x19
0x105a93b08: bl       #0x107c27c70 ; _objc_release
0x105a93b0c: cmp      w21, #0
0x105a93b10: cset     w0, eq
0x105a93b14: ldp      x29, x30, [sp, #0x20]
0x105a93b18: ldp      x20, x19, [sp, #0x10]
0x105a93b1c: ldp      x22, x21, [sp], #0x30
0x105a93b20: ret      
