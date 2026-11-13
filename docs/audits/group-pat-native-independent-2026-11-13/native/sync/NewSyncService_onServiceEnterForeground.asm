-[NewSyncService onServiceEnterForeground] 0x105461de4 v16@0:8
0x105461de4: stp      x20, x19, [sp, #-0x20]!
0x105461de8: stp      x29, x30, [sp, #0x10]
0x105461dec: add      x29, sp, #0x10
0x105461df0: mov      x19, x0
0x105461df4: adrp     x8, #0x11ed12000
0x105461df8: ldr      x0, [x8, #0x840] ; classref CAppUtil | Class CAppUtil
0x105461dfc: adrp     x8, #0x11e9ce000 ; @selector(onAddMsg:roomID:)
0x105461e00: ldr      x1, [x8, #0x200] ; @selector(isLogin) | 'isLogin'
0x105461e04: bl       #0x107c27c64 ; _objc_msgSend | selector=isLogin
0x105461e08: cbz      w0, #0x105461e44
0x105461e0c: adrp     x8, #0x11edca000
0x105461e10: ldrsw    x8, [x8, #0x914] ; ivar_offset NewSyncService.m_bFirstSyncAfterBgfgChange=0x56
0x105461e14: mov      w9, #1
0x105461e18: strb     w9, [x19, x8]
0x105461e1c: mov      w0, #0x18
0x105461e20: mov      x1, #0
0x105461e24: bl       #0x107c0c158
0x105461e28: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105461e2c: ldr      x1, [x8, #0xbc8] ; @selector(sendBgFgRequestWithOnlineMode:) | 'sendBgFgRequestWithOnlineMode:'
0x105461e30: mov      x0, x19
0x105461e34: mov      w2, #1
0x105461e38: ldp      x29, x30, [sp, #0x10]
0x105461e3c: ldp      x20, x19, [sp], #0x20
0x105461e40: b        #0x107c27c64 ; _objc_msgSend | selector=sendBgFgRequestWithOnlineMode:
0x105461e44: ldp      x29, x30, [sp, #0x10]
0x105461e48: ldp      x20, x19, [sp], #0x20
0x105461e4c: ret      
