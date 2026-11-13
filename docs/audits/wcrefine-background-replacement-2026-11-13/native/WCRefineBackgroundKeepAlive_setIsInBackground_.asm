-[WCRefineBackgroundKeepAlive setIsInBackground:] 0xecaf3c v20@0:8B16
0xecaf3c: sub      sp, sp, #0x20
0xecaf40: str      x0, [sp, #0x18]
0xecaf44: str      x1, [sp, #0x10]
0xecaf48: strb     w2, [sp, #0xf]
0xecaf4c: ldrb     w8, [sp, #0xf]
0xecaf50: ldr      x9, [sp, #0x18]
0xecaf54: and      w8, w8, #1
0xecaf58: strb     w8, [x9, #8]
0xecaf5c: add      sp, sp, #0x20
0xecaf60: ret      
