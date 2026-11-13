-[__ThreadWarp Run] 0x1131fd4e8
0x1131fd4e8: sub      sp, sp, #0x30
0x1131fd4ec: stp      x20, x19, [sp, #0x10]
0x1131fd4f0: stp      x29, x30, [sp, #0x20]
0x1131fd4f4: add      x29, sp, #0x20
0x1131fd4f8: mov      x19, x0
0x1131fd4fc: add      x0, sp, #8
0x1131fd500: bl       #0x113201918
0x1131fd504: ldp      x0, x2, [x19, #8]
0x1131fd508: ldr      x3, [x19, #0x18]
0x1131fd50c: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x1131fd510: ldr      x1, [x8, #0xde0] ; @selector(performSelector:withObject:) | 'performSelector:withObject:'
0x1131fd514: bl       #0x116e5c544 ; _objc_msgSend | selector=performSelector:withObject:
0x1131fd518: add      x0, sp, #8
0x1131fd51c: bl       #0x11320196c
0x1131fd520: ldp      x29, x30, [sp, #0x20]
0x1131fd524: ldp      x20, x19, [sp, #0x10]
0x1131fd528: add      sp, sp, #0x30
0x1131fd52c: ret      
0x1131fd530: mov      x19, x0
0x1131fd534: add      x0, sp, #8
0x1131fd538: bl       #0x11320196c
0x1131fd53c: mov      x0, x19
0x1131fd540: bl       #0x116e52ce0 ; __Unwind_Resume
