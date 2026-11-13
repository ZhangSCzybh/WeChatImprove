-[MMNoRetainTimerTarget onNoRetainTimer:] 0x1160ee498
0x1160ee498: stp      x22, x21, [sp, #-0x30]!
0x1160ee49c: stp      x20, x19, [sp, #0x10]
0x1160ee4a0: stp      x29, x30, [sp, #0x20]
0x1160ee4a4: add      x29, sp, #0x20
0x1160ee4a8: mov      x19, x2
0x1160ee4ac: mov      x21, x0
0x1160ee4b0: mov      x0, x2
0x1160ee4b4: bl       #0x116e5c5d4 ; _objc_retain
0x1160ee4b8: add      x0, x21, #0x10
0x1160ee4bc: bl       #0x116e5c514 ; _objc_loadWeakRetained
0x1160ee4c0: mov      x20, x0
0x1160ee4c4: cbz      x0, #0x1160ee4e0
0x1160ee4c8: ldr      x2, [x21, #8]
0x1160ee4cc: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x1160ee4d0: ldr      x1, [x8, #0xde0] ; @selector(performSelector:withObject:) | 'performSelector:withObject:'
0x1160ee4d4: mov      x0, x20
0x1160ee4d8: mov      x3, x19
0x1160ee4dc: bl       #0x116e5c544 ; _objc_msgSend | selector=performSelector:withObject:
0x1160ee4e0: mov      x0, x20
0x1160ee4e4: bl       #0x116e5c5bc ; _objc_release
0x1160ee4e8: mov      x0, x19
0x1160ee4ec: ldp      x29, x30, [sp, #0x20]
0x1160ee4f0: ldp      x20, x19, [sp, #0x10]
0x1160ee4f4: ldp      x22, x21, [sp], #0x30
0x1160ee4f8: b        #0x116e5c5bc ; _objc_release
