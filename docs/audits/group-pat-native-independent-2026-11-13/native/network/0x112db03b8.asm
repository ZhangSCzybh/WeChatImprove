0x112db03b8
0x112db03b8: adrp     x9, #0x11fb00000
0x112db03bc: ldr      x9, [x9, #0x150]
0x112db03c0: cbz      x9, #0x112db03c8
0x112db03c4: br       x9
0x112db03c8: stp      x20, x19, [sp, #-0x20]!
0x112db03cc: stp      x29, x30, [sp, #0x10]
0x112db03d0: add      x29, sp, #0x10
0x112db03d4: mov      x19, x0
0x112db03d8: mov      x0, x1
0x112db03dc: bl       #0x112d8d44c
0x112db03e0: bl       #0x112d94cc0
0x112db03e4: cbz      x0, #0x112db03f8
0x112db03e8: mov      x1, x19
0x112db03ec: ldp      x29, x30, [sp, #0x10]
0x112db03f0: ldp      x20, x19, [sp], #0x20
0x112db03f4: b        #0x112db26e0
0x112db03f8: ldp      x29, x30, [sp, #0x10]
0x112db03fc: ldp      x20, x19, [sp], #0x20
0x112db0400: ret      
