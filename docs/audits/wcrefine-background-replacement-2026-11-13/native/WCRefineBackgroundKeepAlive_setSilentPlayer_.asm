-[WCRefineBackgroundKeepAlive setSilentPlayer:] 0xecaee8 v24@0:8@16
0xecaee8: sub      sp, sp, #0x30
0xecaeec: stp      x29, x30, [sp, #0x20]
0xecaef0: add      x29, sp, #0x20
0xecaef4: stur     x0, [x29, #-8]
0xecaef8: str      x1, [sp, #0x10]
0xecaefc: str      x2, [sp, #8]
0xecaf00: ldr      x1, [sp, #8]
0xecaf04: ldur     x8, [x29, #-8]
0xecaf08: add      x0, x8, #0x28
0xecaf0c: bl       #0x2289118 ; _objc_storeStrong
0xecaf10: ldp      x29, x30, [sp, #0x20]
0xecaf14: add      sp, sp, #0x30
0xecaf18: ret      
