0x1007a4ff8: stp      x20, x19, [sp, #-0x20]!
0x1007a4ffc: stp      x29, x30, [sp, #0x10]
0x1007a5000: add      x29, sp, #0x10
0x1007a5004: mov      x19, x0
0x1007a5008: adrp     x8, #0x11ed82000
0x1007a500c: ldrsw    x8, [x8, #0x19c]
0x1007a5010: ldp      x9, x2, [x0, #0x20]
0x1007a5014: ldr      x0, [x9, x8]
0x1007a5018: adrp     x8, #0x11eca5000 ; @selector(voiceIdSet)
0x1007a501c: ldr      x1, [x8, #0xa38] ; @selector(addObject:) | 'addObject:'
0x1007a5020: bl       #0x107c27c64 ; _objc_msgSend | selector=addObject:
0x1007a5024: ldr      x0, [x19, #0x20]
0x1007a5028: adrp     x8, #0x11e9f2000 ; @selector(getTimelineMsgArr)
0x1007a502c: ldr      x1, [x8, #0xcb8] ; @selector(scheduleDerivedSyncTimer) | 'scheduleDerivedSyncTimer'
0x1007a5030: ldp      x29, x30, [sp, #0x10]
0x1007a5034: ldp      x20, x19, [sp], #0x20
0x1007a5038: b        #0x107c27c64 ; _objc_msgSend | selector=scheduleDerivedSyncTimer
