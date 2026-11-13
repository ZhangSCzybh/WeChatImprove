-[WCRefineGeneralFunctionViewController setBackgroundKeepAliveInterval] 0x1a6e6e4 v16@0:8
0x1a6e6e4: sub      sp, sp, #0x80
0x1a6e6e8: stp      x29, x30, [sp, #0x70]
0x1a6e6ec: add      x29, sp, #0x70
0x1a6e6f0: stur     x0, [x29, #-8]
0x1a6e6f4: stur     x1, [x29, #-0x10]
0x1a6e6f8: adrp     x0, #0x246a000 ; 'FromUsr'
0x1a6e6fc: add      x0, x0, #0x32 ; 'WCUIAlertView'
0x1a6e700: bl       #0x2289010 ; _objc_getClass
0x1a6e704: stur     x0, [x29, #-0x18]
0x1a6e708: ldur     x8, [x29, #-0x18]
0x1a6e70c: cbnz     x8, #0x1a6e718
0x1a6e710: b        #0x1a6e714
0x1a6e714: b        #0x1a6e8bc
0x1a6e718: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0x1a6e71c: ldr      x0, [x8, #0xa68] ; classref WCRefineConfig | _OBJC_CLASS_$_WCRefineConfig
0x1a6e720: adrp     x8, #0x271f000
0x1a6e724: ldr      x1, [x8, #0x488] ; @selector(shared) | 'shared'
0x1a6e728: adrp     x8, #0x25f4000
0x1a6e72c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e730: blr      x8
0x1a6e734: mov      x29, x29
0x1a6e738: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x1a6e73c: str      x0, [sp, #0x10]
0x1a6e740: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0x1a6e744: ldr      x1, [x8, #0x100] ; @selector(backgroundKeepAliveInterval) | 'backgroundKeepAliveInterval'
0x1a6e748: adrp     x8, #0x25f4000
0x1a6e74c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e750: blr      x8
0x1a6e754: mov      x8, x0
0x1a6e758: ldr      x0, [sp, #0x10]
0x1a6e75c: str      x8, [sp, #0x18]
0x1a6e760: adrp     x8, #0x25f4000
0x1a6e764: ldr      x8, [x8, #0x650] ; _objc_release
0x1a6e768: blr      x8
0x1a6e76c: ldr      x0, [sp, #0x18]
0x1a6e770: stur     x0, [x29, #-0x20]
0x1a6e774: ldur     x0, [x29, #-0x18]
0x1a6e778: bl       #0x2288f44 ; _objc_alloc
0x1a6e77c: adrp     x8, #0x271f000
0x1a6e780: ldr      x1, [x8, #0xc70] ; @selector(initWithTitle:message:) | 'initWithTitle:message:'
0x1a6e784: adrp     x8, #0x25f4000
0x1a6e788: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e78c: adrp     x2, #0x2698000
0x1a6e790: add      x2, x2, #0x990 ; @'设置续命周期'
0x1a6e794: adrp     x3, #0x2698000
0x1a6e798: add      x3, x3, #0x9b0 ; @'请输入续命检查周期（10-30秒）\n每隔该秒数检查后台剩余时间，快不够约30秒时再播无声音频，播完不主动停\n建议25秒'
0x1a6e79c: blr      x8
0x1a6e7a0: sub      x8, x29, #0x28
0x1a6e7a4: str      x8, [sp, #0x38]
0x1a6e7a8: stur     x0, [x29, #-0x28]
0x1a6e7ac: ldur     x0, [x29, #-0x28]
0x1a6e7b0: ldur     x3, [x29, #-8]
0x1a6e7b4: adrp     x8, #0x271f000
0x1a6e7b8: str      x8, [sp, #0x20]
0x1a6e7bc: ldr      x1, [x8, #0xc88] ; @selector(addBtnTitle:target:sel:) | 'addBtnTitle:target:sel:'
0x1a6e7c0: adrp     x8, #0x25f4000
0x1a6e7c4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e7c8: adrp     x2, #0x260b000
0x1a6e7cc: add      x2, x2, #0xcd0 ; @'取消'
0x1a6e7d0: mov      x4, #0
0x1a6e7d4: stur     x4, [x29, #-0x30]
0x1a6e7d8: blr      x8
0x1a6e7dc: ldr      x8, [sp, #0x20]
0x1a6e7e0: ldur     x0, [x29, #-0x28]
0x1a6e7e4: ldur     x3, [x29, #-8]
0x1a6e7e8: adrp     x9, #0x273f000 ; @selector(addAutoDownloadSettingCellsToSection:config:)
0x1a6e7ec: ldr      x4, [x9, #0xa78] ; @selector(handleBackgroundKeepAliveIntervalInput:) | 'handleBackgroundKeepAliveIntervalInput:'
0x1a6e7f0: ldr      x1, [x8, #0xc88]
0x1a6e7f4: adrp     x8, #0x25f4000
0x1a6e7f8: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e7fc: adrp     x2, #0x260b000
0x1a6e800: add      x2, x2, #0x910 ; @'确定'
0x1a6e804: blr      x8
0x1a6e808: ldur     x0, [x29, #-0x28]
0x1a6e80c: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0x1a6e810: ldr      x1, [x8, #0xfd8] ; @selector(showTextFieldWithMaxLen:) | 'showTextFieldWithMaxLen:'
0x1a6e814: adrp     x8, #0x25f4000
0x1a6e818: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e81c: mov      w2, #2
0x1a6e820: blr      x8
0x1a6e824: ldur     x8, [x29, #-0x28]
0x1a6e828: str      x8, [sp, #0x28]
0x1a6e82c: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0x1a6e830: ldr      x0, [x8, #0xaf8]
0x1a6e834: ldur     x9, [x29, #-0x20]
0x1a6e838: adrp     x8, #0x271f000
0x1a6e83c: ldr      x1, [x8, #0x660] ; @selector(stringWithFormat:) | 'stringWithFormat:'
0x1a6e840: adrp     x8, #0x25f4000
0x1a6e844: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e848: mov      x10, sp
0x1a6e84c: str      x9, [x10]
0x1a6e850: adrp     x2, #0x260b000
0x1a6e854: add      x2, x2, #0x8b0 ; @'%ld'
0x1a6e858: blr      x8
0x1a6e85c: mov      x29, x29
0x1a6e860: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0x1a6e864: mov      x2, x0
0x1a6e868: ldr      x0, [sp, #0x28]
0x1a6e86c: str      x2, [sp, #0x30]
0x1a6e870: adrp     x8, #0x2722000 ; @selector(screen)
0x1a6e874: ldr      x1, [x8, #0x8a8] ; @selector(setTextFieldDefaultText:) | 'setTextFieldDefaultText:'
0x1a6e878: adrp     x8, #0x25f4000
0x1a6e87c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e880: blr      x8
0x1a6e884: ldr      x0, [sp, #0x30]
0x1a6e888: adrp     x8, #0x25f4000
0x1a6e88c: ldr      x8, [x8, #0x650] ; _objc_release
0x1a6e890: blr      x8
0x1a6e894: ldur     x0, [x29, #-0x28]
0x1a6e898: adrp     x8, #0x271f000
0x1a6e89c: ldr      x1, [x8, #0xc90] ; @selector(show) | 'show'
0x1a6e8a0: adrp     x8, #0x25f4000
0x1a6e8a4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0x1a6e8a8: blr      x8
0x1a6e8ac: ldr      x0, [sp, #0x38]
0x1a6e8b0: ldur     x1, [x29, #-0x30]
0x1a6e8b4: bl       #0x2289118 ; _objc_storeStrong
0x1a6e8b8: b        #0x1a6e8bc
0x1a6e8bc: ldp      x29, x30, [sp, #0x70]
0x1a6e8c0: add      sp, sp, #0x80
0x1a6e8c4: ret      
