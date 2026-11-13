0x1130e6870
0x1130e6870: adrp     x9, #0x11fb16000
0x1130e6874: ldr      x9, [x9, #0xa48]
0x1130e6878: cbz      x9, #0x1130e6880
0x1130e687c: br       x9
0x1130e6880: stp      x20, x19, [sp, #-0x20]!
0x1130e6884: stp      x29, x30, [sp, #0x10]
0x1130e6888: add      x29, sp, #0x10
0x1130e688c: mov      x19, x1
0x1130e6890: mov      x20, x0
0x1130e6894: bl       #0x1130e6c68
0x1130e6898: ldr      x0, [x0, #8]
0x1130e689c: mov      x1, x20
0x1130e68a0: mov      x2, x19
0x1130e68a4: ldp      x29, x30, [sp, #0x10]
0x1130e68a8: ldp      x20, x19, [sp], #0x20
0x1130e68ac: b        #0x10b635598
