-[WCRefineGeneralFunctionViewController handleBackgroundKeepAliveIntervalInput:] 0x1a6e8c8 v24@0:8@16
0x1a6e8c8: sub      sp, sp, #0x60
0x1a6e8cc: stp      x29, x30, [sp, #0x50]
0x1a6e8d0: add      x29, sp, #0x50
0x1a6e8d4: mov      x8, x1
0x1a6e8d8: mov      x1, x2
0x1a6e8dc: stur     x0, [x29, #-8]
0x1a6e8e0: stur     x8, [x29, #-0x10]
0x1a6e8e4: sub      x0, x29, #0x18
0x1a6e8e8: stur     xzr, [x29, #-0x18]
0x1a6e8ec: bl       #0x2289118 ; _objc_storeStrong
0x1a6e8f0: ldur     x0, [x29, #-0x18]
0x1a6e8f4: adrp     x8, #0x271f000
0x1a6e8f8: ldr      x1, [x8, #0x820] ; @selector(text) | 'text'
0x1a6e8fc: adrp     x8, #0x25f4000
0x1a6e900: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e904: blr      x8
0x1a6e908: mov      x29, x29
0x1a6e90c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x1a6e910: stur     x0, [x29, #-0x20]
0x1a6e914: ldur     x0, [x29, #-0x20]
0x1a6e918: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0x1a6e91c: ldr      x1, [x8, #0x240] ; @selector(integerValue) | 'integerValue'
0x1a6e920: adrp     x8, #0x25f4000
0x1a6e924: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e928: blr      x8
0x1a6e92c: str      x0, [sp, #0x28]
0x1a6e930: ldr      x8, [sp, #0x28]
0x1a6e934: subs     x8, x8, #0xa
0x1a6e938: b.ge     #0x1a6e94c
0x1a6e93c: b        #0x1a6e940
0x1a6e940: mov      x8, #0xa
0x1a6e944: str      x8, [sp, #0x28]
0x1a6e948: b        #0x1a6e94c
0x1a6e94c: ldr      x8, [sp, #0x28]
0x1a6e950: subs     x8, x8, #0x1e
0x1a6e954: b.le     #0x1a6e968
0x1a6e958: b        #0x1a6e95c
0x1a6e95c: mov      x8, #0x1e
0x1a6e960: str      x8, [sp, #0x28]
0x1a6e964: b        #0x1a6e968
0x1a6e968: ldr      x8, [sp, #0x28]
0x1a6e96c: str      x8, [sp]
0x1a6e970: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0x1a6e974: ldr      x0, [x8, #0xa68] ; classref WCRefineConfig | _OBJC_CLASS_$_WCRefineConfig
0x1a6e978: adrp     x8, #0x271f000
0x1a6e97c: str      x8, [sp, #0x10]
0x1a6e980: ldr      x1, [x8, #0x488] ; @selector(shared) | 'shared'
0x1a6e984: adrp     x8, #0x25f4000
0x1a6e988: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e98c: blr      x8
0x1a6e990: mov      x29, x29
0x1a6e994: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x1a6e998: ldr      x2, [sp]
0x1a6e99c: str      x0, [sp, #8]
0x1a6e9a0: adrp     x8, #0x273f000 ; @selector(addAutoDownloadSettingCellsToSection:config:)
0x1a6e9a4: ldr      x1, [x8, #0xa80] ; @selector(setBackgroundKeepAliveInterval:) | 'setBackgroundKeepAliveInterval:'
0x1a6e9a8: adrp     x8, #0x25f4000
0x1a6e9ac: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e9b0: blr      x8
0x1a6e9b4: ldr      x0, [sp, #8]
0x1a6e9b8: adrp     x8, #0x25f4000
0x1a6e9bc: ldr      x8, [x8, #0x650] ; _objc_release
0x1a6e9c0: blr      x8
0x1a6e9c4: ldur     x0, [x29, #-8]
0x1a6e9c8: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0x1a6e9cc: ldr      x1, [x8, #0x688] ; @selector(reloadTableData) | 'reloadTableData'
0x1a6e9d0: adrp     x8, #0x25f4000
0x1a6e9d4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e9d8: blr      x8
0x1a6e9dc: ldr      x8, [sp, #0x10]
0x1a6e9e0: adrp     x9, #0x2752000
0x1a6e9e4: ldr      x0, [x9, #0x638] ; classref WCRefineBackgroundKeepAlive | _OBJC_CLASS_$_WCRefineBackgroundKeepAlive
0x1a6e9e8: ldr      x1, [x8, #0x488]
0x1a6e9ec: adrp     x8, #0x25f4000
0x1a6e9f0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e9f4: blr      x8
0x1a6e9f8: mov      x29, x29
0x1a6e9fc: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x1a6ea00: str      x0, [sp, #0x18]
0x1a6ea04: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0x1a6ea08: ldr      x1, [x8, #0xf0] ; @selector(refreshSettings) | 'refreshSettings'
0x1a6ea0c: adrp     x8, #0x25f4000
0x1a6ea10: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6ea14: blr      x8
0x1a6ea18: ldr      x0, [sp, #0x18]
0x1a6ea1c: adrp     x8, #0x25f4000
0x1a6ea20: ldr      x8, [x8, #0x650] ; _objc_release
0x1a6ea24: blr      x8
0x1a6ea28: sub      x0, x29, #0x20
0x1a6ea2c: mov      x1, #0
0x1a6ea30: str      x1, [sp, #0x20]
0x1a6ea34: bl       #0x2289118 ; _objc_storeStrong
0x1a6ea38: ldr      x1, [sp, #0x20]
0x1a6ea3c: sub      x0, x29, #0x18
0x1a6ea40: bl       #0x2289118 ; _objc_storeStrong
0x1a6ea44: ldp      x29, x30, [sp, #0x50]
0x1a6ea48: add      sp, sp, #0x60
0x1a6ea4c: ret      
