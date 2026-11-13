-[WCRefineBackgroundKeepAlive setBgTimer:] 0xecae48 v24@0:8@16
0xecae48: sub      sp, sp, #0x30
0xecae4c: stp      x29, x30, [sp, #0x20]
0xecae50: add      x29, sp, #0x20
0xecae54: stur     x0, [x29, #-8]
0xecae58: str      x1, [sp, #0x10]
0xecae5c: str      x2, [sp, #8]
0xecae60: ldr      x1, [sp, #8]
0xecae64: ldur     x8, [x29, #-8]
0xecae68: add      x0, x8, #0x18
0xecae6c: bl       #0x2289118 ; _objc_storeStrong
0xecae70: ldp      x29, x30, [sp, #0x20]
0xecae74: add      sp, sp, #0x30
0xecae78: ret      
