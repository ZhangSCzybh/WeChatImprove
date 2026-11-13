0x10b7439a0
0x10b7439a0: adrp     x9, #0x11f806000
0x10b7439a4: ldr      x9, [x9, #0xe88]
0x10b7439a8: cbz      x9, #0x10b7439b0
0x10b7439ac: br       x9
0x10b7439b0: stp      x20, x19, [sp, #-0x20]!
0x10b7439b4: stp      x29, x30, [sp, #0x10]
0x10b7439b8: add      x29, sp, #0x10
0x10b7439bc: mov      x19, x1
0x10b7439c0: mov      x20, x0
0x10b7439c4: bl       #0x10b7443ec
0x10b7439c8: ldr      x0, [x0, #8]
0x10b7439cc: mov      x1, x20
0x10b7439d0: mov      x2, x19
0x10b7439d4: ldp      x29, x30, [sp, #0x10]
0x10b7439d8: ldp      x20, x19, [sp], #0x20
0x10b7439dc: b        #0x10b635598
