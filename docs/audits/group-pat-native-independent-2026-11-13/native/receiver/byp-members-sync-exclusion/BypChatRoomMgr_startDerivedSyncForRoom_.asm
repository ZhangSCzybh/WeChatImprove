-[BypChatRoomMgr startDerivedSyncForRoom:] 0x1007a4df4 v24@0:8@16
0x1007a4df4: sub      sp, sp, #0x80
0x1007a4df8: stp      x24, x23, [sp, #0x40]
0x1007a4dfc: stp      x22, x21, [sp, #0x50]
0x1007a4e00: stp      x20, x19, [sp, #0x60]
0x1007a4e04: stp      x29, x30, [sp, #0x70]
0x1007a4e08: add      x29, sp, #0x70
0x1007a4e0c: mov      x19, x2
0x1007a4e10: mov      x20, x0
0x1007a4e14: adrp     x8, #0x11f741000
0x1007a4e18: mov      w9, #1
0x1007a4e1c: strb     w9, [x8, #0xbb9]
0x1007a4e20: mov      x0, x2
0x1007a4e24: bl       #0x107c27c74 ; _objc_retain
0x1007a4e28: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x1007a4e2c: ldr      x1, [x8, #0xce8] ; @selector(length) | 'length'
0x1007a4e30: mov      x0, x19
0x1007a4e34: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x1007a4e38: cbz      x0, #0x1007a4fd8
0x1007a4e3c: adrp     x23, #0x11ed12000
0x1007a4e40: ldr      x0, [x23, #0x618] ; classref iConsole | Class iConsole
0x1007a4e44: adrp     x8, #0x11e9c9000
0x1007a4e48: ldr      x21, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x1007a4e4c: adrp     x8, #0x11cfec000
0x1007a4e50: add      x8, x8, #0xb78 ; @'startDerivedSyncForRoom:%@'
0x1007a4e54: stp      x8, x19, [sp] ; @'startDerivedSyncForRoom:%@'
0x1007a4e58: adrp     x3, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a4e5c: add      x3, x3, #0xc3c ; 'BypChatRoom'
0x1007a4e60: adrp     x5, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a4e64: add      x5, x5, #0xc48 ; 'BypChatRoomMgr.mm'
0x1007a4e68: adrp     x7, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a4e6c: add      x7, x7, #0xc9e ; '-[BypChatRoomMgr startDerivedSyncForRoom:]'
0x1007a4e70: mov      x1, x21 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x1007a4e74: mov      w2, #2
0x1007a4e78: mov      w4, #0
0x1007a4e7c: mov      w6, #0x132
0x1007a4e80: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x1007a4e84: adrp     x8, #0x11e9f2000 ; @selector(getTimelineMsgArr)
0x1007a4e88: ldr      x1, [x8, #0xcb0] ; @selector(getDerivedSyncKey:) | 'getDerivedSyncKey:'
0x1007a4e8c: mov      x0, x20
0x1007a4e90: mov      x2, x19
0x1007a4e94: bl       #0x107c27c64 ; _objc_msgSend | selector=getDerivedSyncKey:
0x1007a4e98: mov      x29, x29
0x1007a4e9c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a4ea0: mov      x22, x0
0x1007a4ea4: bl       #0x107c27c70 ; _objc_release
0x1007a4ea8: cbz      x22, #0x1007a4f00
0x1007a4eac: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x1007a4eb0: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x1007a4eb4: str      x8, [sp, #0x10]
0x1007a4eb8: adrp     x8, #0x1178c7000
0x1007a4ebc: ldr      d0, [x8, #0x680]
0x1007a4ec0: adrp     x8, #0x1007a4000
0x1007a4ec4: add      x8, x8, #0xff8
0x1007a4ec8: str      d0, [sp, #0x18]
0x1007a4ecc: adrp     x9, #0x11c281000
0x1007a4ed0: add      x9, x9, #0x10
0x1007a4ed4: stp      x8, x9, [sp, #0x20]
0x1007a4ed8: str      x20, [sp, #0x30]
0x1007a4edc: mov      x0, x19
0x1007a4ee0: bl       #0x107c27c74 ; _objc_retain
0x1007a4ee4: str      x19, [sp, #0x38]
0x1007a4ee8: adrp     x0, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x1007a4eec: ldr      x0, [x0, #0xa98] ; __dispatch_main_q
0x1007a4ef0: add      x1, sp, #0x10
0x1007a4ef4: bl       #0x107c0cb9c
0x1007a4ef8: ldr      x0, [sp, #0x38]
0x1007a4efc: b        #0x1007a4fd4
0x1007a4f00: ldr      x0, [x23, #0x618] ; classref iConsole | Class iConsole
0x1007a4f04: adrp     x8, #0x11cfec000
0x1007a4f08: add      x8, x8, #0xb98 ; @'startDerivedSyncForRoom: no sync key, init via BypGetContact for room:%@'
0x1007a4f0c: stp      x8, x19, [sp] ; @'startDerivedSyncForRoom: no sync key, init via BypGetContact for room:%@'
0x1007a4f10: adrp     x3, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a4f14: add      x3, x3, #0xc3c ; 'BypChatRoom'
0x1007a4f18: adrp     x5, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a4f1c: add      x5, x5, #0xc48 ; 'BypChatRoomMgr.mm'
0x1007a4f20: adrp     x7, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a4f24: add      x7, x7, #0xc9e ; '-[BypChatRoomMgr startDerivedSyncForRoom:]'
0x1007a4f28: mov      x1, x21 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x1007a4f2c: mov      w2, #2
0x1007a4f30: mov      w4, #0
0x1007a4f34: mov      w6, #0x136
0x1007a4f38: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x1007a4f3c: adrp     x8, #0x11ed12000
0x1007a4f40: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x1007a4f44: adrp     x8, #0x11e9c9000
0x1007a4f48: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x1007a4f4c: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x1007a4f50: mov      x29, x29
0x1007a4f54: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a4f58: mov      x20, x0
0x1007a4f5c: adrp     x8, #0x11ed12000
0x1007a4f60: ldr      x0, [x8, #0xbe8] ; classref CContactMgr | Class CContactMgr
0x1007a4f64: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x1007a4f68: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x1007a4f6c: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x1007a4f70: mov      x2, x0
0x1007a4f74: adrp     x8, #0x11e9c9000
0x1007a4f78: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x1007a4f7c: mov      x0, x20
0x1007a4f80: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x1007a4f84: mov      x29, x29
0x1007a4f88: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a4f8c: mov      x21, x0
0x1007a4f90: adrp     x8, #0x11e9e4000 ; @selector(readPedometerProfileTarget:)
0x1007a4f94: ldr      x1, [x8, #0x318] ; @selector(botContactMgr) | 'botContactMgr'
0x1007a4f98: bl       #0x107c27c64 ; _objc_msgSend | selector=botContactMgr
0x1007a4f9c: mov      x29, x29
0x1007a4fa0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a4fa4: mov      x22, x0
0x1007a4fa8: adrp     x8, #0x11e9e4000 ; @selector(readPedometerProfileTarget:)
0x1007a4fac: ldr      x1, [x8, #0xd0] ; @selector(getContactsFromServer:scene:bizType:) | 'getContactsFromServer:scene:bizType:'
0x1007a4fb0: mov      x2, x19
0x1007a4fb4: mov      w3, #1
0x1007a4fb8: mov      w4, #0x1b
0x1007a4fbc: bl       #0x107c27c64 ; _objc_msgSend | selector=getContactsFromServer:scene:bizType:
0x1007a4fc0: mov      x0, x22
0x1007a4fc4: bl       #0x107c27c70 ; _objc_release
0x1007a4fc8: mov      x0, x21
0x1007a4fcc: bl       #0x107c27c70 ; _objc_release
0x1007a4fd0: mov      x0, x20
0x1007a4fd4: bl       #0x107c27c70 ; _objc_release
0x1007a4fd8: mov      x0, x19
0x1007a4fdc: bl       #0x107c27c70 ; _objc_release
0x1007a4fe0: ldp      x29, x30, [sp, #0x70]
0x1007a4fe4: ldp      x20, x19, [sp, #0x60]
0x1007a4fe8: ldp      x22, x21, [sp, #0x50]
0x1007a4fec: ldp      x24, x23, [sp, #0x40]
0x1007a4ff0: add      sp, sp, #0x80
0x1007a4ff4: ret      
