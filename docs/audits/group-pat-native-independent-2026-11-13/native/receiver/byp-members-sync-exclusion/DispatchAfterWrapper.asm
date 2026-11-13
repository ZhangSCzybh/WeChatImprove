0x1160a5d88: adrp     x9, #0x11fc1b000
0x1160a5d8c: ldr      x9, [x9, #0xb20]
0x1160a5d90: cbz      x9, #0x1160a5d98
0x1160a5d94: br       x9
0x1160a5d98: stp      x22, x21, [sp, #-0x30]!
0x1160a5d9c: stp      x20, x19, [sp, #0x10]
0x1160a5da0: stp      x29, x30, [sp, #0x20]
0x1160a5da4: add      x29, sp, #0x20
0x1160a5da8: mov      x21, x2
0x1160a5dac: mov      x19, x1
0x1160a5db0: mov      x20, x0
0x1160a5db4: adrp     x22, #0x11ff67000
0x1160a5db8: ldr      x8, [x22, #0x2a0]
0x1160a5dbc: cbnz     x8, #0x1160a5dd4
0x1160a5dc0: adrp     x1, #0x11b190000 ; 'ol - choose what info you want to share with apps.'
0x1160a5dc4: add      x1, x1, #0x959 ; 'dispatch_after'
0x1160a5dc8: mov      x0, #-1
0x1160a5dcc: bl       #0x116e5a7d4 ; _dlsym
0x1160a5dd0: str      x0, [x22, #0x2a0]
0x1160a5dd4: mov      x0, x21
0x1160a5dd8: bl       #0x1160a5820
0x1160a5ddc: mov      x21, x0
0x1160a5de0: ldr      x8, [x22, #0x2a0]
0x1160a5de4: mov      x0, x20
0x1160a5de8: mov      x1, x19
0x1160a5dec: mov      x2, x21
0x1160a5df0: blr      x8
0x1160a5df4: mov      x0, x21
0x1160a5df8: ldp      x29, x30, [sp, #0x20]
0x1160a5dfc: ldp      x20, x19, [sp, #0x10]
0x1160a5e00: ldp      x22, x21, [sp], #0x30
0x1160a5e04: b        #0x116e5c5bc ; _objc_release
