-[WCRefineBackgroundKeepAlive dealloc] 0xecad40 v16@0:8
0xecad40: sub      sp, sp, #0x40
0xecad44: stp      x29, x30, [sp, #0x30]
0xecad48: add      x29, sp, #0x30
0xecad4c: stur     x0, [x29, #-8]
0xecad50: stur     x1, [x29, #-0x10]
0xecad54: ldur     x0, [x29, #-8]
0xecad58: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xecad5c: ldr      x1, [x8, #0x1a8] ; @selector(cancelGracePulse) | 'cancelGracePulse'
0xecad60: adrp     x8, #0x25f4000
0xecad64: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecad68: blr      x8
0xecad6c: adrp     x8, #0x2751000 ; @selector(setWCRefineSearchEntryThemeBox:)
0xecad70: ldr      x0, [x8, #0xa70]
0xecad74: adrp     x8, #0x274e000 ; @selector(animationWithKeyPath:)
0xecad78: ldr      x1, [x8, #0xd0] ; @selector(defaultCenter) | 'defaultCenter'
0xecad7c: adrp     x8, #0x25f4000
0xecad80: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecad84: blr      x8
0xecad88: mov      x29, x29
0xecad8c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xecad90: str      x0, [sp, #8]
0xecad94: ldur     x2, [x29, #-8]
0xecad98: adrp     x8, #0x2721000 ; @selector(setHighlighted:animated:)
0xecad9c: ldr      x1, [x8, #0xc30] ; @selector(removeObserver:) | 'removeObserver:'
0xecada0: adrp     x8, #0x25f4000
0xecada4: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xecada8: blr      x8
0xecadac: ldr      x0, [sp, #8]
0xecadb0: adrp     x8, #0x25f4000
0xecadb4: ldr      x8, [x8, #0x650] ; _objc_release
0xecadb8: blr      x8
0xecadbc: ldur     x8, [x29, #-8]
0xecadc0: add      x0, sp, #0x10
0xecadc4: str      x8, [sp, #0x10]
0xecadc8: adrp     x8, #0x2753000 ; classref WCRefinePluginHubCellAction
0xecadcc: ldr      x8, [x8, #0x4e0] ; classref WCRefineBackgroundKeepAlive | _OBJC_CLASS_$_WCRefineBackgroundKeepAlive
0xecadd0: str      x8, [sp, #0x18] ; _OBJC_CLASS_$_WCRefineBackgroundKeepAlive
0xecadd4: adrp     x8, #0x2720000 ; @selector(childViewControllers)
0xecadd8: ldr      x1, [x8, #0x698] ; @selector(dealloc) | 'dealloc'
0xecaddc: bl       #0x228907c ; _objc_msgSendSuper2 | selector=dealloc
0xecade0: ldp      x29, x30, [sp, #0x30]
0xecade4: add      sp, sp, #0x40
0xecade8: ret      
