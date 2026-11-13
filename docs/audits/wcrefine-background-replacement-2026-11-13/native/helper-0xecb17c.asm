0xecb17c: sub      sp, sp, #0x80
0xecb180: stp      x29, x30, [sp, #0x70]
0xecb184: add      x29, sp, #0x70
0xecb188: stur     x0, [x29, #-0x10]
0xecb18c: ldur     x0, [x29, #-0x10]
0xecb190: bl       #0x2289010 ; _objc_getClass
0xecb194: stur     x0, [x29, #-0x18]
0xecb198: ldur     x8, [x29, #-0x18]
0xecb19c: cbnz     x8, #0xecb1ac
0xecb1a0: b        #0xecb1a4
0xecb1a4: stur     xzr, [x29, #-8]
0xecb1a8: b        #0xecb4cc
0xecb1ac: adrp     x0, #0x246a000 ; 'FromUsr'
0xecb1b0: add      x0, x0, #0x26f ; 'MMContext'
0xecb1b4: bl       #0x2289010 ; _objc_getClass
0xecb1b8: stur     x0, [x29, #-0x20]
0xecb1bc: stur     xzr, [x29, #-0x28]
0xecb1c0: ldur     x8, [x29, #-0x20]
0xecb1c4: cbz      x8, #0xecb2a4
0xecb1c8: b        #0xecb1cc
0xecb1cc: ldur     x0, [x29, #-0x20]
0xecb1d0: adrp     x8, #0x271f000
0xecb1d4: ldr      x2, [x8, #0xfe0] ; @selector(currentContext) | 'currentContext'
0xecb1d8: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xecb1dc: ldr      x1, [x8, #0x308] ; @selector(respondsToSelector:) | 'respondsToSelector:'
0xecb1e0: adrp     x8, #0x25f4000
0xecb1e4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecb1e8: blr      x8
0xecb1ec: tbz      w0, #0, #0xecb230
0xecb1f0: b        #0xecb1f4
0xecb1f4: ldur     x0, [x29, #-0x20]
0xecb1f8: adrp     x8, #0x271f000
0xecb1fc: ldr      x1, [x8, #0xfe0] ; @selector(currentContext) | 'currentContext'
0xecb200: adrp     x8, #0x25f4000
0xecb204: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecb208: blr      x8
0xecb20c: mov      x29, x29
0xecb210: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xecb214: mov      x8, x0
0xecb218: ldur     x0, [x29, #-0x28]
0xecb21c: stur     x8, [x29, #-0x28]
0xecb220: adrp     x8, #0x25f4000
0xecb224: ldr      x8, [x8, #0x650] ; _objc_release
0xecb228: blr      x8
0xecb22c: b        #0xecb230
0xecb230: ldur     x8, [x29, #-0x28]
0xecb234: cbnz     x8, #0xecb2a0
0xecb238: b        #0xecb23c
0xecb23c: ldur     x0, [x29, #-0x20]
0xecb240: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0xecb244: ldr      x2, [x8, #0x398] ; @selector(activeUserContext) | 'activeUserContext'
0xecb248: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xecb24c: ldr      x1, [x8, #0x308] ; @selector(respondsToSelector:) | 'respondsToSelector:'
0xecb250: adrp     x8, #0x25f4000
0xecb254: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecb258: blr      x8
0xecb25c: tbz      w0, #0, #0xecb2a0
0xecb260: b        #0xecb264
0xecb264: ldur     x0, [x29, #-0x20]
0xecb268: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0xecb26c: ldr      x1, [x8, #0x398] ; @selector(activeUserContext) | 'activeUserContext'
0xecb270: adrp     x8, #0x25f4000
0xecb274: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecb278: blr      x8
0xecb27c: mov      x29, x29
0xecb280: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xecb284: mov      x8, x0
0xecb288: ldur     x0, [x29, #-0x28]
0xecb28c: stur     x8, [x29, #-0x28]
0xecb290: adrp     x8, #0x25f4000
0xecb294: ldr      x8, [x8, #0x650] ; _objc_release
0xecb298: blr      x8
0xecb29c: b        #0xecb2a0
0xecb2a0: b        #0xecb2a4
0xecb2a4: ldur     x8, [x29, #-0x28]
0xecb2a8: cbz      x8, #0xecb358
0xecb2ac: b        #0xecb2b0
0xecb2b0: ldur     x0, [x29, #-0x28]
0xecb2b4: adrp     x8, #0x271f000
0xecb2b8: ldr      x2, [x8, #0xb00] ; @selector(getService:) | 'getService:'
0xecb2bc: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xecb2c0: ldr      x1, [x8, #0x308] ; @selector(respondsToSelector:) | 'respondsToSelector:'
0xecb2c4: adrp     x8, #0x25f4000
0xecb2c8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecb2cc: blr      x8
0xecb2d0: tbz      w0, #0, #0xecb358
0xecb2d4: b        #0xecb2d8
0xecb2d8: ldur     x0, [x29, #-0x28]
0xecb2dc: adrp     x8, #0x271f000
0xecb2e0: ldr      x1, [x8, #0xb00] ; @selector(getService:) | 'getService:'
0xecb2e4: ldur     x2, [x29, #-0x18]
0xecb2e8: adrp     x8, #0x25f4000
0xecb2ec: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecb2f0: blr      x8
0xecb2f4: mov      x29, x29
0xecb2f8: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xecb2fc: stur     x0, [x29, #-0x30]
0xecb300: ldur     x8, [x29, #-0x30]
0xecb304: cbz      x8, #0xecb334
0xecb308: b        #0xecb30c
0xecb30c: ldur     x0, [x29, #-0x30]
0xecb310: str      x0, [sp, #0x10]
0xecb314: adrp     x8, #0x25f4000
0xecb318: ldr      x8, [x8, #0x658] ; _objc_retain
0xecb31c: blr      x8
0xecb320: ldr      x8, [sp, #0x10]
0xecb324: stur     x8, [x29, #-8]
0xecb328: mov      w8, #1
0xecb32c: stur     w8, [x29, #-0x34]
0xecb330: b        #0xecb33c
0xecb334: stur     wzr, [x29, #-0x34]
0xecb338: b        #0xecb33c
0xecb33c: sub      x0, x29, #0x30
0xecb340: mov      x1, #0
0xecb344: bl       #0x2289118 ; _objc_storeStrong
0xecb348: ldur     w8, [x29, #-0x34]
0xecb34c: cbnz     w8, #0xecb4bc
0xecb350: b        #0xecb354
0xecb354: b        #0xecb358
0xecb358: adrp     x0, #0x2469000 ; 'ndler:'
0xecb35c: add      x0, x0, #0xf1f ; 'MMServiceCenter'
0xecb360: bl       #0x2289010 ; _objc_getClass
0xecb364: str      x0, [sp, #0x30]
0xecb368: ldr      x8, [sp, #0x30]
0xecb36c: mov      w9, #0
0xecb370: and      w9, w9, #1
0xecb374: and      w9, w9, #1
0xecb378: strb     w9, [sp, #0x1f]
0xecb37c: cbz      x8, #0xecb3ec
0xecb380: b        #0xecb384
0xecb384: ldr      x0, [sp, #0x30]
0xecb388: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xecb38c: ldr      x2, [x8, #0xd0] ; @selector(defaultCenter) | 'defaultCenter'
0xecb390: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xecb394: ldr      x1, [x8, #0x308] ; @selector(respondsToSelector:) | 'respondsToSelector:'
0xecb398: adrp     x8, #0x25f4000
0xecb39c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecb3a0: blr      x8
0xecb3a4: tbz      w0, #0, #0xecb3ec
0xecb3a8: b        #0xecb3ac
0xecb3ac: ldr      x0, [sp, #0x30]
0xecb3b0: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xecb3b4: ldr      x1, [x8, #0xd0] ; @selector(defaultCenter) | 'defaultCenter'
0xecb3b8: adrp     x8, #0x25f4000
0xecb3bc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecb3c0: blr      x8
0xecb3c4: mov      x29, x29
0xecb3c8: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xecb3cc: mov      x8, x0
0xecb3d0: str      x8, [sp, #0x20]
0xecb3d4: mov      w8, #1
0xecb3d8: and      w8, w8, #1
0xecb3dc: and      w8, w8, #1
0xecb3e0: strb     w8, [sp, #0x1f]
0xecb3e4: str      x0, [sp, #8]
0xecb3e8: b        #0xecb3f8
0xecb3ec: mov      x8, #0
0xecb3f0: str      x8, [sp, #8]
0xecb3f4: b        #0xecb3f8
0xecb3f8: ldr      x0, [sp, #8]
0xecb3fc: str      x0, [sp]
0xecb400: adrp     x8, #0x25f4000
0xecb404: ldr      x8, [x8, #0x658] ; _objc_retain
0xecb408: blr      x8
0xecb40c: ldr      x8, [sp]
0xecb410: str      x8, [sp, #0x28]
0xecb414: ldrb     w8, [sp, #0x1f]
0xecb418: tbz      w8, #0, #0xecb434
0xecb41c: b        #0xecb420
0xecb420: ldr      x0, [sp, #0x20]
0xecb424: adrp     x8, #0x25f4000
0xecb428: ldr      x8, [x8, #0x650] ; _objc_release
0xecb42c: blr      x8
0xecb430: b        #0xecb434
0xecb434: ldr      x8, [sp, #0x28]
0xecb438: cbz      x8, #0xecb49c
0xecb43c: b        #0xecb440
0xecb440: ldr      x0, [sp, #0x28]
0xecb444: adrp     x8, #0x271f000
0xecb448: ldr      x2, [x8, #0xb00] ; @selector(getService:) | 'getService:'
0xecb44c: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xecb450: ldr      x1, [x8, #0x308] ; @selector(respondsToSelector:) | 'respondsToSelector:'
0xecb454: adrp     x8, #0x25f4000
0xecb458: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecb45c: blr      x8
0xecb460: tbz      w0, #0, #0xecb49c
0xecb464: b        #0xecb468
0xecb468: ldr      x0, [sp, #0x28]
0xecb46c: adrp     x8, #0x271f000
0xecb470: ldr      x1, [x8, #0xb00] ; @selector(getService:) | 'getService:'
0xecb474: ldur     x2, [x29, #-0x18]
0xecb478: adrp     x8, #0x25f4000
0xecb47c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecb480: blr      x8
0xecb484: mov      x29, x29
0xecb488: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xecb48c: stur     x0, [x29, #-8]
0xecb490: mov      w8, #1
0xecb494: stur     w8, [x29, #-0x34]
0xecb498: b        #0xecb4ac
0xecb49c: stur     xzr, [x29, #-8]
0xecb4a0: mov      w8, #1
0xecb4a4: stur     w8, [x29, #-0x34]
0xecb4a8: b        #0xecb4ac
0xecb4ac: add      x0, sp, #0x28
0xecb4b0: mov      x1, #0
0xecb4b4: bl       #0x2289118 ; _objc_storeStrong
0xecb4b8: b        #0xecb4bc
0xecb4bc: sub      x0, x29, #0x28
0xecb4c0: mov      x1, #0
0xecb4c4: bl       #0x2289118 ; _objc_storeStrong
0xecb4c8: b        #0xecb4cc
0xecb4cc: ldur     x0, [x29, #-8]
0xecb4d0: ldp      x29, x30, [sp, #0x70]
0xecb4d4: add      sp, sp, #0x80
0xecb4d8: b        #0x2288f98 ; _objc_autoreleaseReturnValue
