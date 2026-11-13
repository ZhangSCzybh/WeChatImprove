0xecb4dc: sub      sp, sp, #0x40
0xecb4e0: stp      x29, x30, [sp, #0x30]
0xecb4e4: add      x29, sp, #0x30
0xecb4e8: str      x0, [sp]
0xecb4ec: mov      x0, x1
0xecb4f0: ldr      x1, [sp]
0xecb4f4: str      x0, [sp, #8]
0xecb4f8: sub      x0, x29, #0x10
0xecb4fc: stur     xzr, [x29, #-0x10]
0xecb500: bl       #0x2289118 ; _objc_storeStrong
0xecb504: ldr      x1, [sp, #8]
0xecb508: str      x1, [sp, #0x18]
0xecb50c: ldur     x8, [x29, #-0x10]
0xecb510: cbz      x8, #0xecb548
0xecb514: b        #0xecb518
0xecb518: ldr      x8, [sp, #0x18]
0xecb51c: cbz      x8, #0xecb548
0xecb520: b        #0xecb524
0xecb524: ldur     x0, [x29, #-0x10]
0xecb528: ldr      x2, [sp, #0x18]
0xecb52c: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xecb530: ldr      x1, [x8, #0x308] ; @selector(respondsToSelector:) | 'respondsToSelector:'
0xecb534: adrp     x8, #0x25f4000
0xecb538: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecb53c: blr      x8
0xecb540: tbnz     w0, #0, #0xecb564
0xecb544: b        #0xecb548
0xecb548: mov      w9, #0
0xecb54c: mov      w8, #1
0xecb550: and      w9, w9, #1
0xecb554: and      w9, w9, w8
0xecb558: sturb    w9, [x29, #-1]
0xecb55c: str      w8, [sp, #0x14]
0xecb560: b        #0xecb58c
0xecb564: ldur     x0, [x29, #-0x10]
0xecb568: ldr      x1, [sp, #0x18]
0xecb56c: adrp     x8, #0x25f4000
0xecb570: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecb574: blr      x8
0xecb578: mov      w8, #1
0xecb57c: and      w9, w0, w8
0xecb580: sturb    w9, [x29, #-1]
0xecb584: str      w8, [sp, #0x14]
0xecb588: b        #0xecb58c
0xecb58c: sub      x0, x29, #0x10
0xecb590: mov      x1, #0
0xecb594: bl       #0x2289118 ; _objc_storeStrong
0xecb598: ldurb    w8, [x29, #-1]
0xecb59c: and      w0, w8, #1
0xecb5a0: ldp      x29, x30, [sp, #0x30]
0xecb5a4: add      sp, sp, #0x40
0xecb5a8: ret      
