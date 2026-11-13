-[SendPatMgr patSendDelayInterval] 0x105a954a4 I16@0:8
0x105a954a4: stp      x22, x21, [sp, #-0x30]!
0x105a954a8: stp      x20, x19, [sp, #0x10]
0x105a954ac: stp      x29, x30, [sp, #0x20]
0x105a954b0: add      x29, sp, #0x20
0x105a954b4: adrp     x8, #0x11ed12000
0x105a954b8: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105a954bc: adrp     x8, #0x11e9c9000
0x105a954c0: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105a954c4: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105a954c8: mov      x29, x29
0x105a954cc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a954d0: mov      x19, x0
0x105a954d4: adrp     x8, #0x11ed12000
0x105a954d8: ldr      x0, [x8, #0x890] ; classref ExptService | Class ExptService
0x105a954dc: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105a954e0: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x105a954e4: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x105a954e8: mov      x2, x0
0x105a954ec: adrp     x8, #0x11e9c9000
0x105a954f0: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x105a954f4: mov      x0, x19
0x105a954f8: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x105a954fc: mov      x29, x29
0x105a95500: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a95504: mov      x20, x0
0x105a95508: adrp     x8, #0x11e9ca000 ; @selector(isUsingEarDeviceWithRoute:)
0x105a9550c: ldr      x1, [x8, #0x228] ; @selector(getIntegerExpt:withDef:) | 'getIntegerExpt:withDef:'
0x105a95510: adrp     x2, #0x11d332000
0x105a95514: add      x2, x2, #0x898 ; @'clicfg_pat_send_delay_interval'
0x105a95518: mov      w3, #5
0x105a9551c: bl       #0x107c27c64 ; _objc_msgSend | selector=getIntegerExpt:withDef:
0x105a95520: mov      x21, x0
0x105a95524: mov      x0, x20
0x105a95528: bl       #0x107c27c70 ; _objc_release
0x105a9552c: mov      x0, x19
0x105a95530: bl       #0x107c27c70 ; _objc_release
0x105a95534: mov      x0, x21
0x105a95538: ldp      x29, x30, [sp, #0x20]
0x105a9553c: ldp      x20, x19, [sp, #0x10]
0x105a95540: ldp      x22, x21, [sp], #0x30
0x105a95544: ret      
