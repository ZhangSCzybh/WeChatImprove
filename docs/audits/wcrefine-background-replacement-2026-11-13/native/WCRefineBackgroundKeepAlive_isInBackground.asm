-[WCRefineBackgroundKeepAlive isInBackground] 0xecaf1c B16@0:8
0xecaf1c: sub      sp, sp, #0x10
0xecaf20: str      x0, [sp, #8]
0xecaf24: str      x1, [sp]
0xecaf28: ldr      x8, [sp, #8]
0xecaf2c: ldrb     w8, [x8, #8]
0xecaf30: and      w0, w8, #1
0xecaf34: add      sp, sp, #0x10
0xecaf38: ret      
