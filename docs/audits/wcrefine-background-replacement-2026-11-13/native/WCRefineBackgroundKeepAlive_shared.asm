+[WCRefineBackgroundKeepAlive shared] 0xec78b0 @16@0:8
0xec78b0: sub      sp, sp, #0x60
0xec78b4: stp      x29, x30, [sp, #0x50]
0xec78b8: add      x29, sp, #0x50
0xec78bc: stur     x0, [x29, #-0x18]
0xec78c0: stur     x1, [x29, #-0x20]
0xec78c4: add      x1, sp, #8
0xec78c8: adrp     x8, #0x25f4000
0xec78cc: ldr      x8, [x8, #0x678] ; __NSConcreteGlobalBlock
0xec78d0: str      x8, [sp, #8]
0xec78d4: mov      w8, #-0x2f800000
0xec78d8: str      w8, [sp, #0x10]
0xec78dc: str      wzr, [sp, #0x14]
0xec78e0: adrp     x8, #0xec7000
0xec78e4: add      x8, x8, #0x960
0xec78e8: str      x8, [sp, #0x18]
0xec78ec: adrp     x8, #0x25f4000
0xec78f0: add      x8, x8, #0xc28
0xec78f4: str      x8, [sp, #0x20]
0xec78f8: ldur     x8, [x29, #-0x18]
0xec78fc: str      x8, [sp, #0x28]
0xec7900: adrp     x8, #0x295b000
0xec7904: add      x8, x8, #0x538
0xec7908: stur     x8, [x29, #-8]
0xec790c: sub      x0, x29, #0x10
0xec7910: stur     xzr, [x29, #-0x10]
0xec7914: bl       #0x2289118 ; _objc_storeStrong
0xec7918: ldur     x8, [x29, #-8]
0xec791c: ldr      x8, [x8]
0xec7920: adds     x8, x8, #1
0xec7924: b.eq     #0xec793c
0xec7928: b        #0xec792c
0xec792c: ldur     x0, [x29, #-8]
0xec7930: ldur     x1, [x29, #-0x10]
0xec7934: bl       #0x2288c50 ; _dispatch_once
0xec7938: b        #0xec7940
0xec793c: b        #0xec7940
0xec7940: sub      x0, x29, #0x10
0xec7944: mov      x1, #0
0xec7948: bl       #0x2289118 ; _objc_storeStrong
0xec794c: adrp     x8, #0x295b000
0xec7950: ldr      x0, [x8, #0x530]
0xec7954: ldp      x29, x30, [sp, #0x50]
0xec7958: add      sp, sp, #0x60
0xec795c: b        #0x22890c4 ; _objc_retainAutoreleaseReturnValue
