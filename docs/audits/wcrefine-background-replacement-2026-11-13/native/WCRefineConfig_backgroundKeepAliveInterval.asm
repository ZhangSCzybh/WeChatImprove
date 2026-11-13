-[WCRefineConfig backgroundKeepAliveInterval] 0x208f148 q16@0:8
0x208f148: sub      sp, sp, #0x80
0x208f14c: stp      x29, x30, [sp, #0x70]
0x208f150: add      x29, sp, #0x70
0x208f154: stur     x0, [x29, #-8]
0x208f158: stur     x1, [x29, #-0x10]
0x208f15c: ldur     x0, [x29, #-8]
0x208f160: adrp     x8, #0x271f000
0x208f164: ldr      x1, [x8, #0x718] ; @selector(class) | 'class'
0x208f168: adrp     x8, #0x25f4000
0x208f16c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f170: blr      x8
0x208f174: adrp     x8, #0x2722000 ; @selector(screen)
0x208f178: ldr      x1, [x8, #0x460] ; @selector(configDictionary) | 'configDictionary'
0x208f17c: adrp     x8, #0x25f4000
0x208f180: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f184: blr      x8
0x208f188: mov      x29, x29
0x208f18c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208f190: stur     x0, [x29, #-0x18]
0x208f194: ldur     x8, [x29, #-0x18]
0x208f198: str      x8, [sp, #0x38]
0x208f19c: ldur     x0, [x29, #-0x10]
0x208f1a0: bl       #0x202fdf8 ; _cmdString
0x208f1a4: mov      x29, x29
0x208f1a8: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208f1ac: mov      x2, x0
0x208f1b0: ldr      x0, [sp, #0x38]
0x208f1b4: stur     x2, [x29, #-0x30]
0x208f1b8: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0x208f1bc: ldr      x1, [x8, #0xa28] ; @selector(objectForKey:) | 'objectForKey:'
0x208f1c0: adrp     x8, #0x25f4000
0x208f1c4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f1c8: blr      x8
0x208f1cc: mov      x29, x29
0x208f1d0: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208f1d4: mov      x8, x0
0x208f1d8: ldur     x0, [x29, #-0x30]
0x208f1dc: stur     x8, [x29, #-0x20]
0x208f1e0: adrp     x8, #0x25f4000
0x208f1e4: ldr      x8, [x8, #0x650] ; _objc_release
0x208f1e8: blr      x8
0x208f1ec: ldur     x8, [x29, #-0x20]
0x208f1f0: cbz      x8, #0x208f218
0x208f1f4: b        #0x208f1f8
0x208f1f8: ldur     x0, [x29, #-0x20]
0x208f1fc: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0x208f200: ldr      x1, [x8, #0x240] ; @selector(integerValue) | 'integerValue'
0x208f204: adrp     x8, #0x25f4000
0x208f208: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f20c: blr      x8
0x208f210: str      x0, [sp, #0x30]
0x208f214: b        #0x208f224
0x208f218: mov      x8, #0x19
0x208f21c: str      x8, [sp, #0x30]
0x208f220: b        #0x208f224
0x208f224: ldr      x8, [sp, #0x30]
0x208f228: stur     x8, [x29, #-0x28]
0x208f22c: ldur     x8, [x29, #-0x28]
0x208f230: subs     x8, x8, #0xa
0x208f234: b.ge     #0x208f248
0x208f238: b        #0x208f23c
0x208f23c: mov      x8, #0xa
0x208f240: stur     x8, [x29, #-0x28]
0x208f244: b        #0x208f248
0x208f248: ldur     x8, [x29, #-0x28]
0x208f24c: subs     x8, x8, #0x1e
0x208f250: b.le     #0x208f264
0x208f254: b        #0x208f258
0x208f258: mov      x8, #0x1e
0x208f25c: stur     x8, [x29, #-0x28]
0x208f260: b        #0x208f264
0x208f264: ldur     x8, [x29, #-0x20]
0x208f268: cbz      x8, #0x208f298
0x208f26c: b        #0x208f270
0x208f270: ldur     x0, [x29, #-0x20]
0x208f274: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0x208f278: ldr      x1, [x8, #0x240] ; @selector(integerValue) | 'integerValue'
0x208f27c: adrp     x8, #0x25f4000
0x208f280: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f284: blr      x8
0x208f288: ldur     x8, [x29, #-0x28]
0x208f28c: subs     x8, x0, x8
0x208f290: b.eq     #0x208f354
0x208f294: b        #0x208f298
0x208f298: ldur     x8, [x29, #-0x18]
0x208f29c: str      x8, [sp, #0x18]
0x208f2a0: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0x208f2a4: ldr      x0, [x8, #0xb48]
0x208f2a8: ldur     x2, [x29, #-0x28]
0x208f2ac: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0x208f2b0: ldr      x1, [x8, #0xa60] ; @selector(numberWithInteger:) | 'numberWithInteger:'
0x208f2b4: adrp     x8, #0x25f4000
0x208f2b8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f2bc: blr      x8
0x208f2c0: mov      x29, x29
0x208f2c4: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208f2c8: str      x0, [sp, #0x28]
0x208f2cc: ldur     x0, [x29, #-0x10]
0x208f2d0: bl       #0x202fdf8 ; _cmdString
0x208f2d4: mov      x29, x29
0x208f2d8: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208f2dc: ldr      x2, [sp, #0x28]
0x208f2e0: mov      x3, x0
0x208f2e4: ldr      x0, [sp, #0x18]
0x208f2e8: str      x3, [sp, #0x20]
0x208f2ec: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0x208f2f0: ldr      x1, [x8, #0x4e8] ; @selector(setObject:forKey:) | 'setObject:forKey:'
0x208f2f4: adrp     x8, #0x25f4000
0x208f2f8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f2fc: blr      x8
0x208f300: ldr      x0, [sp, #0x20]
0x208f304: adrp     x8, #0x25f4000
0x208f308: ldr      x8, [x8, #0x650] ; _objc_release
0x208f30c: blr      x8
0x208f310: ldr      x0, [sp, #0x28]
0x208f314: adrp     x8, #0x25f4000
0x208f318: ldr      x8, [x8, #0x650] ; _objc_release
0x208f31c: blr      x8
0x208f320: ldur     x0, [x29, #-8]
0x208f324: adrp     x8, #0x271f000
0x208f328: ldr      x1, [x8, #0x718] ; @selector(class) | 'class'
0x208f32c: adrp     x8, #0x25f4000
0x208f330: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f334: blr      x8
0x208f338: ldur     x2, [x29, #-0x18]
0x208f33c: adrp     x8, #0x2722000 ; @selector(screen)
0x208f340: ldr      x1, [x8, #0x468] ; @selector(saveConfigDictionary:) | 'saveConfigDictionary:'
0x208f344: adrp     x8, #0x25f4000
0x208f348: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f34c: blr      x8
0x208f350: b        #0x208f354
0x208f354: ldur     x8, [x29, #-0x28]
0x208f358: str      x8, [sp, #0x10]
0x208f35c: sub      x0, x29, #0x20
0x208f360: mov      x1, #0
0x208f364: str      x1, [sp, #8]
0x208f368: bl       #0x2289118 ; _objc_storeStrong
0x208f36c: ldr      x1, [sp, #8]
0x208f370: sub      x0, x29, #0x18
0x208f374: bl       #0x2289118 ; _objc_storeStrong
0x208f378: ldr      x0, [sp, #0x10]
0x208f37c: ldp      x29, x30, [sp, #0x70]
0x208f380: add      sp, sp, #0x80
0x208f384: ret      
