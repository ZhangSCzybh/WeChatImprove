-[BypChatRoomMgr scheduleDerivedSyncTimer] 0x1007a503c v16@0:8
0x1007a503c: adrp     x8, #0x11ed82000
0x1007a5040: ldrsw    x8, [x8, #0x1a0] ; ivar_offset BypChatRoomMgr._derivedSyncTimerScheduled=0x10
0x1007a5044: ldrb     w9, [x0, x8]
0x1007a5048: tbnz     w9, #0, #0x1007a50c4
0x1007a504c: sub      sp, sp, #0x50
0x1007a5050: stp      x20, x19, [sp, #0x30]
0x1007a5054: stp      x29, x30, [sp, #0x40]
0x1007a5058: add      x29, sp, #0x40
0x1007a505c: mov      x19, x0
0x1007a5060: mov      w9, #1
0x1007a5064: strb     w9, [x0, x8]
0x1007a5068: mov      x0, #0
0x1007a506c: mov      w1, #0x6500
0x1007a5070: movk     w1, #0x1dcd, lsl #16
0x1007a5074: bl       #0x107c278fc ; _dispatch_time
0x1007a5078: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x1007a507c: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x1007a5080: str      x8, [sp, #8]
0x1007a5084: adrp     x8, #0x1178c7000
0x1007a5088: ldr      d0, [x8, #0x680]
0x1007a508c: adrp     x8, #0x1007a5000
0x1007a5090: add      x8, x8, #0xc8
0x1007a5094: str      d0, [sp, #0x10]
0x1007a5098: adrp     x9, #0x11c280000
0x1007a509c: add      x9, x9, #0x470
0x1007a50a0: stp      x8, x9, [sp, #0x18]
0x1007a50a4: str      x19, [sp, #0x28]
0x1007a50a8: adrp     x1, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x1007a50ac: ldr      x1, [x1, #0xa98] ; __dispatch_main_q
0x1007a50b0: add      x2, sp, #8
0x1007a50b4: bl       #0x107c0cba4
0x1007a50b8: ldp      x29, x30, [sp, #0x40]
0x1007a50bc: ldp      x20, x19, [sp, #0x30]
0x1007a50c0: add      sp, sp, #0x50
0x1007a50c4: ret      
