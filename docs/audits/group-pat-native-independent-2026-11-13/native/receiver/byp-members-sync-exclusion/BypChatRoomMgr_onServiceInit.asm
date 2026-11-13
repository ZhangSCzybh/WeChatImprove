-[BypChatRoomMgr onServiceInit] 0x1007a2d54 v16@0:8
0x1007a2d54: sub      sp, sp, #0x30
0x1007a2d58: stp      x20, x19, [sp, #0x10]
0x1007a2d5c: stp      x29, x30, [sp, #0x20]
0x1007a2d60: add      x29, sp, #0x20
0x1007a2d64: mov      x19, x0
0x1007a2d68: adrp     x8, #0x11ed12000
0x1007a2d6c: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x1007a2d70: adrp     x8, #0x11e9c9000
0x1007a2d74: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x1007a2d78: adrp     x8, #0x11cfec000
0x1007a2d7c: add      x8, x8, #0xb18 ; @'BypChatRoomMgr init'
0x1007a2d80: str      x8, [sp] ; @'BypChatRoomMgr init'
0x1007a2d84: adrp     x3, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a2d88: add      x3, x3, #0xc3c ; 'BypChatRoom'
0x1007a2d8c: adrp     x5, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a2d90: add      x5, x5, #0xc48 ; 'BypChatRoomMgr.mm'
0x1007a2d94: adrp     x7, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a2d98: add      x7, x7, #0xc5a ; '-[BypChatRoomMgr onServiceInit]'
0x1007a2d9c: mov      w2, #2
0x1007a2da0: mov      w4, #0
0x1007a2da4: mov      w6, #0x27
0x1007a2da8: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x1007a2dac: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x1007a2db0: ldr      x0, [x8, #0x260] ; _OBJC_CLASS_$_NSMutableSet
0x1007a2db4: adrp     x8, #0x11ecaa000 ; @selector(processIdentifier)
0x1007a2db8: ldr      x1, [x8, #0xca8] ; @selector(set) | 'set'
0x1007a2dbc: bl       #0x107c27c64 ; _objc_msgSend | selector=set
0x1007a2dc0: mov      x29, x29
0x1007a2dc4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a2dc8: adrp     x8, #0x11ed82000
0x1007a2dcc: ldrsw    x9, [x8, #0x19c] ; ivar_offset BypChatRoomMgr._pendingDerivedSyncRooms=0x8
0x1007a2dd0: ldr      x8, [x19, x9]
0x1007a2dd4: str      x0, [x19, x9]
0x1007a2dd8: mov      x0, x8
0x1007a2ddc: bl       #0x107c27c70 ; _objc_release
0x1007a2de0: adrp     x8, #0x11ed82000
0x1007a2de4: ldrsw    x8, [x8, #0x1a0] ; ivar_offset BypChatRoomMgr._derivedSyncTimerScheduled=0x10
0x1007a2de8: strb     wzr, [x19, x8]
0x1007a2dec: adrp     x8, #0x11ed12000
0x1007a2df0: ldr      x0, [x8, #0x630] ; _OBJC_CLASS_$_NSMutableDictionary
0x1007a2df4: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x1007a2df8: ldr      x1, [x8, #0xf70] ; @selector(dictionary) | 'dictionary'
0x1007a2dfc: bl       #0x107c27c64 ; _objc_msgSend | selector=dictionary
0x1007a2e00: mov      x29, x29
0x1007a2e04: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a2e08: adrp     x8, #0x11ed82000
0x1007a2e0c: ldrsw    x9, [x8, #0x1a4] ; ivar_offset BypChatRoomMgr._custAsstRoomIndex=0x18
0x1007a2e10: ldr      x8, [x19, x9]
0x1007a2e14: str      x0, [x19, x9]
0x1007a2e18: mov      x0, x8
0x1007a2e1c: ldp      x29, x30, [sp, #0x20]
0x1007a2e20: ldp      x20, x19, [sp, #0x10]
0x1007a2e24: add      sp, sp, #0x30
0x1007a2e28: b        #0x107c27c70 ; _objc_release
