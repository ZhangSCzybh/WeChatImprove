-[WCRefineConfig backgroundDropNotifyEnabled] 0x208f4ec B16@0:8
0x208f4ec: sub      sp, sp, #0x70
0x208f4f0: stp      x29, x30, [sp, #0x60]
0x208f4f4: add      x29, sp, #0x60
0x208f4f8: stur     x0, [x29, #-8]
0x208f4fc: stur     x1, [x29, #-0x10]
0x208f500: ldur     x0, [x29, #-8]
0x208f504: adrp     x8, #0x271f000
0x208f508: ldr      x1, [x8, #0x718] ; @selector(class) | 'class'
0x208f50c: adrp     x8, #0x25f4000
0x208f510: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f514: blr      x8
0x208f518: adrp     x8, #0x2722000 ; @selector(screen)
0x208f51c: ldr      x1, [x8, #0x460] ; @selector(configDictionary) | 'configDictionary'
0x208f520: adrp     x8, #0x25f4000
0x208f524: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f528: blr      x8
0x208f52c: mov      x29, x29
0x208f530: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208f534: stur     x0, [x29, #-0x18]
0x208f538: ldur     x8, [x29, #-0x18]
0x208f53c: str      x8, [sp, #0x30]
0x208f540: ldur     x0, [x29, #-0x10]
0x208f544: bl       #0x202fdf8 ; _cmdString
0x208f548: mov      x29, x29
0x208f54c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208f550: mov      x2, x0
0x208f554: ldr      x0, [sp, #0x30]
0x208f558: stur     x2, [x29, #-0x28]
0x208f55c: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0x208f560: ldr      x1, [x8, #0xa28] ; @selector(objectForKey:) | 'objectForKey:'
0x208f564: adrp     x8, #0x25f4000
0x208f568: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f56c: blr      x8
0x208f570: mov      x29, x29
0x208f574: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208f578: mov      x8, x0
0x208f57c: ldur     x0, [x29, #-0x28]
0x208f580: stur     x8, [x29, #-0x20]
0x208f584: adrp     x8, #0x25f4000
0x208f588: ldr      x8, [x8, #0x650] ; _objc_release
0x208f58c: blr      x8
0x208f590: ldur     x8, [x29, #-0x20]
0x208f594: cbnz     x8, #0x208f668
0x208f598: b        #0x208f59c
0x208f59c: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0x208f5a0: ldr      x0, [x8, #0xb48]
0x208f5a4: adrp     x8, #0x271f000
0x208f5a8: ldr      x1, [x8, #0x818] ; @selector(numberWithBool:) | 'numberWithBool:'
0x208f5ac: adrp     x8, #0x25f4000
0x208f5b0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f5b4: mov      w9, #0
0x208f5b8: and      w2, w9, #1
0x208f5bc: blr      x8
0x208f5c0: mov      x29, x29
0x208f5c4: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208f5c8: mov      x8, x0
0x208f5cc: ldur     x0, [x29, #-0x20]
0x208f5d0: stur     x8, [x29, #-0x20]
0x208f5d4: adrp     x8, #0x25f4000
0x208f5d8: ldr      x8, [x8, #0x650] ; _objc_release
0x208f5dc: blr      x8
0x208f5e0: ldur     x8, [x29, #-0x18]
0x208f5e4: str      x8, [sp, #0x20]
0x208f5e8: ldur     x8, [x29, #-0x20]
0x208f5ec: str      x8, [sp, #0x18]
0x208f5f0: ldur     x0, [x29, #-0x10]
0x208f5f4: bl       #0x202fdf8 ; _cmdString
0x208f5f8: mov      x29, x29
0x208f5fc: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208f600: ldr      x2, [sp, #0x18]
0x208f604: mov      x3, x0
0x208f608: ldr      x0, [sp, #0x20]
0x208f60c: str      x3, [sp, #0x28]
0x208f610: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0x208f614: ldr      x1, [x8, #0x4e8] ; @selector(setObject:forKey:) | 'setObject:forKey:'
0x208f618: adrp     x8, #0x25f4000
0x208f61c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f620: blr      x8
0x208f624: ldr      x0, [sp, #0x28]
0x208f628: adrp     x8, #0x25f4000
0x208f62c: ldr      x8, [x8, #0x650] ; _objc_release
0x208f630: blr      x8
0x208f634: ldur     x0, [x29, #-8]
0x208f638: adrp     x8, #0x271f000
0x208f63c: ldr      x1, [x8, #0x718] ; @selector(class) | 'class'
0x208f640: adrp     x8, #0x25f4000
0x208f644: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f648: blr      x8
0x208f64c: ldur     x2, [x29, #-0x18]
0x208f650: adrp     x8, #0x2722000 ; @selector(screen)
0x208f654: ldr      x1, [x8, #0x468] ; @selector(saveConfigDictionary:) | 'saveConfigDictionary:'
0x208f658: adrp     x8, #0x25f4000
0x208f65c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f660: blr      x8
0x208f664: b        #0x208f668
0x208f668: sub      x8, x29, #0x20
0x208f66c: str      x8, [sp]
0x208f670: ldur     x0, [x29, #-0x20]
0x208f674: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0x208f678: ldr      x1, [x8, #0x30] ; @selector(boolValue) | 'boolValue'
0x208f67c: adrp     x8, #0x25f4000
0x208f680: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208f684: blr      x8
0x208f688: mov      x1, x0
0x208f68c: ldr      x0, [sp]
0x208f690: str      w1, [sp, #0x14]
0x208f694: mov      x1, #0
0x208f698: str      x1, [sp, #8]
0x208f69c: bl       #0x2289118 ; _objc_storeStrong
0x208f6a0: ldr      x1, [sp, #8]
0x208f6a4: sub      x0, x29, #0x18
0x208f6a8: bl       #0x2289118 ; _objc_storeStrong
0x208f6ac: ldr      w0, [sp, #0x14]
0x208f6b0: ldp      x29, x30, [sp, #0x60]
0x208f6b4: add      sp, sp, #0x70
0x208f6b8: ret      
