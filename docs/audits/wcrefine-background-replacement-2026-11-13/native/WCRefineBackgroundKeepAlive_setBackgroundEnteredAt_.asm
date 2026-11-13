-[WCRefineBackgroundKeepAlive setBackgroundEnteredAt:] 0xecb008 v24@0:8@16
0xecb008: sub      sp, sp, #0x30
0xecb00c: stp      x29, x30, [sp, #0x20]
0xecb010: add      x29, sp, #0x20
0xecb014: stur     x0, [x29, #-8]
0xecb018: str      x1, [sp, #0x10]
0xecb01c: str      x2, [sp, #8]
0xecb020: ldr      x1, [sp, #8]
0xecb024: ldur     x8, [x29, #-8]
0xecb028: add      x0, x8, #0x38
0xecb02c: bl       #0x2289118 ; _objc_storeStrong
0xecb030: ldp      x29, x30, [sp, #0x20]
0xecb034: add      sp, sp, #0x30
0xecb038: ret      
