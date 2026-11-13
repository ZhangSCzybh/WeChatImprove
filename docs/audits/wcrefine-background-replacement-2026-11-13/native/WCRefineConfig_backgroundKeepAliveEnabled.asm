-[WCRefineConfig backgroundKeepAliveEnabled] 0x208ee48 B16@0:8
0x208ee48: sub      sp, sp, #0x70
0x208ee4c: stp      x29, x30, [sp, #0x60]
0x208ee50: add      x29, sp, #0x60
0x208ee54: stur     x0, [x29, #-8]
0x208ee58: stur     x1, [x29, #-0x10]
0x208ee5c: ldur     x0, [x29, #-8]
0x208ee60: adrp     x8, #0x271f000
0x208ee64: ldr      x1, [x8, #0x718] ; @selector(class) | 'class'
0x208ee68: adrp     x8, #0x25f4000
0x208ee6c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208ee70: blr      x8
0x208ee74: adrp     x8, #0x2722000 ; @selector(screen)
0x208ee78: ldr      x1, [x8, #0x460] ; @selector(configDictionary) | 'configDictionary'
0x208ee7c: adrp     x8, #0x25f4000
0x208ee80: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208ee84: blr      x8
0x208ee88: mov      x29, x29
0x208ee8c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208ee90: stur     x0, [x29, #-0x18]
0x208ee94: ldur     x8, [x29, #-0x18]
0x208ee98: str      x8, [sp, #0x30]
0x208ee9c: ldur     x0, [x29, #-0x10]
0x208eea0: bl       #0x202fdf8 ; _cmdString
0x208eea4: mov      x29, x29
0x208eea8: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208eeac: mov      x2, x0
0x208eeb0: ldr      x0, [sp, #0x30]
0x208eeb4: stur     x2, [x29, #-0x28]
0x208eeb8: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0x208eebc: ldr      x1, [x8, #0xa28] ; @selector(objectForKey:) | 'objectForKey:'
0x208eec0: adrp     x8, #0x25f4000
0x208eec4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208eec8: blr      x8
0x208eecc: mov      x29, x29
0x208eed0: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208eed4: mov      x8, x0
0x208eed8: ldur     x0, [x29, #-0x28]
0x208eedc: stur     x8, [x29, #-0x20]
0x208eee0: adrp     x8, #0x25f4000
0x208eee4: ldr      x8, [x8, #0x650] ; _objc_release
0x208eee8: blr      x8
0x208eeec: ldur     x8, [x29, #-0x20]
0x208eef0: cbnz     x8, #0x208efc4
0x208eef4: b        #0x208eef8
0x208eef8: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0x208eefc: ldr      x0, [x8, #0xb48]
0x208ef00: adrp     x8, #0x271f000
0x208ef04: ldr      x1, [x8, #0x818] ; @selector(numberWithBool:) | 'numberWithBool:'
0x208ef08: adrp     x8, #0x25f4000
0x208ef0c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208ef10: mov      w9, #0
0x208ef14: and      w2, w9, #1
0x208ef18: blr      x8
0x208ef1c: mov      x29, x29
0x208ef20: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208ef24: mov      x8, x0
0x208ef28: ldur     x0, [x29, #-0x20]
0x208ef2c: stur     x8, [x29, #-0x20]
0x208ef30: adrp     x8, #0x25f4000
0x208ef34: ldr      x8, [x8, #0x650] ; _objc_release
0x208ef38: blr      x8
0x208ef3c: ldur     x8, [x29, #-0x18]
0x208ef40: str      x8, [sp, #0x20]
0x208ef44: ldur     x8, [x29, #-0x20]
0x208ef48: str      x8, [sp, #0x18]
0x208ef4c: ldur     x0, [x29, #-0x10]
0x208ef50: bl       #0x202fdf8 ; _cmdString
0x208ef54: mov      x29, x29
0x208ef58: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x208ef5c: ldr      x2, [sp, #0x18]
0x208ef60: mov      x3, x0
0x208ef64: ldr      x0, [sp, #0x20]
0x208ef68: str      x3, [sp, #0x28]
0x208ef6c: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0x208ef70: ldr      x1, [x8, #0x4e8] ; @selector(setObject:forKey:) | 'setObject:forKey:'
0x208ef74: adrp     x8, #0x25f4000
0x208ef78: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208ef7c: blr      x8
0x208ef80: ldr      x0, [sp, #0x28]
0x208ef84: adrp     x8, #0x25f4000
0x208ef88: ldr      x8, [x8, #0x650] ; _objc_release
0x208ef8c: blr      x8
0x208ef90: ldur     x0, [x29, #-8]
0x208ef94: adrp     x8, #0x271f000
0x208ef98: ldr      x1, [x8, #0x718] ; @selector(class) | 'class'
0x208ef9c: adrp     x8, #0x25f4000
0x208efa0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208efa4: blr      x8
0x208efa8: ldur     x2, [x29, #-0x18]
0x208efac: adrp     x8, #0x2722000 ; @selector(screen)
0x208efb0: ldr      x1, [x8, #0x468] ; @selector(saveConfigDictionary:) | 'saveConfigDictionary:'
0x208efb4: adrp     x8, #0x25f4000
0x208efb8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208efbc: blr      x8
0x208efc0: b        #0x208efc4
0x208efc4: sub      x8, x29, #0x20
0x208efc8: str      x8, [sp]
0x208efcc: ldur     x0, [x29, #-0x20]
0x208efd0: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0x208efd4: ldr      x1, [x8, #0x30] ; @selector(boolValue) | 'boolValue'
0x208efd8: adrp     x8, #0x25f4000
0x208efdc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x208efe0: blr      x8
0x208efe4: mov      x1, x0
0x208efe8: ldr      x0, [sp]
0x208efec: str      w1, [sp, #0x14]
0x208eff0: mov      x1, #0
0x208eff4: str      x1, [sp, #8]
0x208eff8: bl       #0x2289118 ; _objc_storeStrong
0x208effc: ldr      x1, [sp, #8]
0x208f000: sub      x0, x29, #0x18
0x208f004: bl       #0x2289118 ; _objc_storeStrong
0x208f008: ldr      w0, [sp, #0x14]
0x208f00c: ldp      x29, x30, [sp, #0x60]
0x208f010: add      sp, sp, #0x70
0x208f014: ret      
