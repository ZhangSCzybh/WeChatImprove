-[WCRefineBackgroundKeepAlive setGracePulseTimer:] 0xecae98 v24@0:8@16
0xecae98: sub      sp, sp, #0x30
0xecae9c: stp      x29, x30, [sp, #0x20]
0xecaea0: add      x29, sp, #0x20
0xecaea4: stur     x0, [x29, #-8]
0xecaea8: str      x1, [sp, #0x10]
0xecaeac: str      x2, [sp, #8]
0xecaeb0: ldr      x1, [sp, #8]
0xecaeb4: ldur     x8, [x29, #-8]
0xecaeb8: add      x0, x8, #0x20
0xecaebc: bl       #0x2289118 ; _objc_storeStrong
0xecaec0: ldp      x29, x30, [sp, #0x20]
0xecaec4: add      sp, sp, #0x30
0xecaec8: ret      
