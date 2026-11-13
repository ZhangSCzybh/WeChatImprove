-[WCRefineGeneralFunctionViewController toggleBackgroundDropNotify:] 0x1a6e5a8 v24@0:8@16
0x1a6e5a8: sub      sp, sp, #0x60
0x1a6e5ac: stp      x29, x30, [sp, #0x50]
0x1a6e5b0: add      x29, sp, #0x50
0x1a6e5b4: mov      x8, x1
0x1a6e5b8: mov      x1, x2
0x1a6e5bc: stur     x0, [x29, #-8]
0x1a6e5c0: stur     x8, [x29, #-0x10]
0x1a6e5c4: sub      x0, x29, #0x18
0x1a6e5c8: str      x0, [sp, #0x28]
0x1a6e5cc: mov      x8, #0
0x1a6e5d0: stur     x8, [x29, #-0x20]
0x1a6e5d4: stur     xzr, [x29, #-0x18]
0x1a6e5d8: bl       #0x2289118 ; _objc_storeStrong
0x1a6e5dc: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0x1a6e5e0: ldr      x0, [x8, #0xb10] ; classref WCRefineHelper | _OBJC_CLASS_$_WCRefineHelper
0x1a6e5e4: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0x1a6e5e8: ldr      x1, [x8, #0x658] ; @selector(triggerHapticFeedback) | 'triggerHapticFeedback'
0x1a6e5ec: adrp     x8, #0x25f4000
0x1a6e5f0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e5f4: blr      x8
0x1a6e5f8: ldur     x0, [x29, #-0x18]
0x1a6e5fc: adrp     x8, #0x271f000
0x1a6e600: ldr      x1, [x8, #0xf48] ; @selector(isOn) | 'isOn'
0x1a6e604: adrp     x8, #0x25f4000
0x1a6e608: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e60c: blr      x8
0x1a6e610: str      w0, [sp, #0xc]
0x1a6e614: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0x1a6e618: ldr      x0, [x8, #0xa68] ; classref WCRefineConfig | _OBJC_CLASS_$_WCRefineConfig
0x1a6e61c: adrp     x8, #0x271f000
0x1a6e620: str      x8, [sp, #0x18]
0x1a6e624: ldr      x1, [x8, #0x488] ; @selector(shared) | 'shared'
0x1a6e628: adrp     x8, #0x25f4000
0x1a6e62c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e630: blr      x8
0x1a6e634: mov      x29, x29
0x1a6e638: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x1a6e63c: ldr      w2, [sp, #0xc]
0x1a6e640: str      x0, [sp, #0x10]
0x1a6e644: adrp     x8, #0x273f000 ; @selector(addAutoDownloadSettingCellsToSection:config:)
0x1a6e648: ldr      x1, [x8, #0xa70] ; @selector(setBackgroundDropNotifyEnabled:) | 'setBackgroundDropNotifyEnabled:'
0x1a6e64c: adrp     x8, #0x25f4000
0x1a6e650: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e654: blr      x8
0x1a6e658: ldr      x0, [sp, #0x10]
0x1a6e65c: adrp     x8, #0x25f4000
0x1a6e660: ldr      x8, [x8, #0x650] ; _objc_release
0x1a6e664: blr      x8
0x1a6e668: ldur     x0, [x29, #-8]
0x1a6e66c: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0x1a6e670: ldr      x1, [x8, #0x688] ; @selector(reloadTableData) | 'reloadTableData'
0x1a6e674: adrp     x8, #0x25f4000
0x1a6e678: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e67c: blr      x8
0x1a6e680: ldr      x8, [sp, #0x18]
0x1a6e684: adrp     x9, #0x2752000
0x1a6e688: ldr      x0, [x9, #0x638] ; classref WCRefineBackgroundKeepAlive | _OBJC_CLASS_$_WCRefineBackgroundKeepAlive
0x1a6e68c: ldr      x1, [x8, #0x488]
0x1a6e690: adrp     x8, #0x25f4000
0x1a6e694: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e698: blr      x8
0x1a6e69c: mov      x29, x29
0x1a6e6a0: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x1a6e6a4: str      x0, [sp, #0x20]
0x1a6e6a8: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0x1a6e6ac: ldr      x1, [x8, #0xf0] ; @selector(refreshSettings) | 'refreshSettings'
0x1a6e6b0: adrp     x8, #0x25f4000
0x1a6e6b4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e6b8: blr      x8
0x1a6e6bc: ldr      x0, [sp, #0x20]
0x1a6e6c0: adrp     x8, #0x25f4000
0x1a6e6c4: ldr      x8, [x8, #0x650] ; _objc_release
0x1a6e6c8: blr      x8
0x1a6e6cc: ldr      x0, [sp, #0x28]
0x1a6e6d0: ldur     x1, [x29, #-0x20]
0x1a6e6d4: bl       #0x2289118 ; _objc_storeStrong
0x1a6e6d8: ldp      x29, x30, [sp, #0x50]
0x1a6e6dc: add      sp, sp, #0x60
0x1a6e6e0: ret      
