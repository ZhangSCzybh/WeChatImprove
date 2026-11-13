-[WCRefineBackgroundKeepAlive .cxx_destruct] 0xecb114 v16@0:8
0xecb114: sub      sp, sp, #0x30
0xecb118: stp      x29, x30, [sp, #0x20]
0xecb11c: add      x29, sp, #0x20
0xecb120: stur     x0, [x29, #-8]
0xecb124: str      x1, [sp, #0x10]
0xecb128: ldur     x8, [x29, #-8]
0xecb12c: str      x8, [sp]
0xecb130: add      x0, x8, #0x38
0xecb134: mov      x1, #0
0xecb138: str      x1, [sp, #8]
0xecb13c: bl       #0x2289118 ; _objc_storeStrong
0xecb140: ldr      x8, [sp]
0xecb144: ldr      x1, [sp, #8]
0xecb148: add      x0, x8, #0x28
0xecb14c: bl       #0x2289118 ; _objc_storeStrong
0xecb150: ldr      x8, [sp]
0xecb154: ldr      x1, [sp, #8]
0xecb158: add      x0, x8, #0x20
0xecb15c: bl       #0x2289118 ; _objc_storeStrong
0xecb160: ldr      x8, [sp]
0xecb164: ldr      x1, [sp, #8]
0xecb168: add      x0, x8, #0x18
0xecb16c: bl       #0x2289118 ; _objc_storeStrong
0xecb170: ldp      x29, x30, [sp, #0x20]
0xecb174: add      sp, sp, #0x30
0xecb178: ret      
