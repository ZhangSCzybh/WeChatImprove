-[WCRefineGeneralFunctionViewController toggleBackgroundKeepAlive:] 0x1a6e46c v24@0:8@16
0x1a6e46c: sub      sp, sp, #0x60
0x1a6e470: stp      x29, x30, [sp, #0x50]
0x1a6e474: add      x29, sp, #0x50
0x1a6e478: mov      x8, x1
0x1a6e47c: mov      x1, x2
0x1a6e480: stur     x0, [x29, #-8]
0x1a6e484: stur     x8, [x29, #-0x10]
0x1a6e488: sub      x0, x29, #0x18
0x1a6e48c: str      x0, [sp, #0x28]
0x1a6e490: mov      x8, #0
0x1a6e494: stur     x8, [x29, #-0x20]
0x1a6e498: stur     xzr, [x29, #-0x18]
0x1a6e49c: bl       #0x2289118 ; _objc_storeStrong
0x1a6e4a0: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0x1a6e4a4: ldr      x0, [x8, #0xb10] ; classref WCRefineHelper | _OBJC_CLASS_$_WCRefineHelper
0x1a6e4a8: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0x1a6e4ac: ldr      x1, [x8, #0x658] ; @selector(triggerHapticFeedback) | 'triggerHapticFeedback'
0x1a6e4b0: adrp     x8, #0x25f4000
0x1a6e4b4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e4b8: blr      x8
0x1a6e4bc: ldur     x0, [x29, #-0x18]
0x1a6e4c0: adrp     x8, #0x271f000
0x1a6e4c4: ldr      x1, [x8, #0xf48] ; @selector(isOn) | 'isOn'
0x1a6e4c8: adrp     x8, #0x25f4000
0x1a6e4cc: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e4d0: blr      x8
0x1a6e4d4: str      w0, [sp, #0xc]
0x1a6e4d8: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0x1a6e4dc: ldr      x0, [x8, #0xa68] ; classref WCRefineConfig | _OBJC_CLASS_$_WCRefineConfig
0x1a6e4e0: adrp     x8, #0x271f000
0x1a6e4e4: str      x8, [sp, #0x18]
0x1a6e4e8: ldr      x1, [x8, #0x488] ; @selector(shared) | 'shared'
0x1a6e4ec: adrp     x8, #0x25f4000
0x1a6e4f0: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e4f4: blr      x8
0x1a6e4f8: mov      x29, x29
0x1a6e4fc: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x1a6e500: ldr      w2, [sp, #0xc]
0x1a6e504: str      x0, [sp, #0x10]
0x1a6e508: adrp     x8, #0x273f000 ; @selector(addAutoDownloadSettingCellsToSection:config:)
0x1a6e50c: ldr      x1, [x8, #0xa68] ; @selector(setBackgroundKeepAliveEnabled:) | 'setBackgroundKeepAliveEnabled:'
0x1a6e510: adrp     x8, #0x25f4000
0x1a6e514: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e518: blr      x8
0x1a6e51c: ldr      x0, [sp, #0x10]
0x1a6e520: adrp     x8, #0x25f4000
0x1a6e524: ldr      x8, [x8, #0x650] ; _objc_release
0x1a6e528: blr      x8
0x1a6e52c: ldur     x0, [x29, #-8]
0x1a6e530: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0x1a6e534: ldr      x1, [x8, #0x688] ; @selector(reloadTableData) | 'reloadTableData'
0x1a6e538: adrp     x8, #0x25f4000
0x1a6e53c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e540: blr      x8
0x1a6e544: ldr      x8, [sp, #0x18]
0x1a6e548: adrp     x9, #0x2752000
0x1a6e54c: ldr      x0, [x9, #0x638] ; classref WCRefineBackgroundKeepAlive | _OBJC_CLASS_$_WCRefineBackgroundKeepAlive
0x1a6e550: ldr      x1, [x8, #0x488]
0x1a6e554: adrp     x8, #0x25f4000
0x1a6e558: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e55c: blr      x8
0x1a6e560: mov      x29, x29
0x1a6e564: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x1a6e568: str      x0, [sp, #0x20]
0x1a6e56c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0x1a6e570: ldr      x1, [x8, #0xf0] ; @selector(refreshSettings) | 'refreshSettings'
0x1a6e574: adrp     x8, #0x25f4000
0x1a6e578: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e57c: blr      x8
0x1a6e580: ldr      x0, [sp, #0x20]
0x1a6e584: adrp     x8, #0x25f4000
0x1a6e588: ldr      x8, [x8, #0x650] ; _objc_release
0x1a6e58c: blr      x8
0x1a6e590: ldr      x0, [sp, #0x28]
0x1a6e594: ldur     x1, [x29, #-0x20]
0x1a6e598: bl       #0x2289118 ; _objc_storeStrong
0x1a6e59c: ldp      x29, x30, [sp, #0x50]
0x1a6e5a0: add      sp, sp, #0x60
0x1a6e5a4: ret      
