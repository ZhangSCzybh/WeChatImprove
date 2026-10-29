
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104abfa30: d100c3ff    	sub	sp, sp, #0x30
104abfa34: a9014ff4    	stp	x20, x19, [sp, #0x10]
104abfa38: a9027bfd    	stp	x29, x30, [sp, #0x20]
104abfa3c: 910083fd    	add	x29, sp, #0x20
104abfa40: f00e0be8    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104abfa44: 52800029    	mov	w9, #0x1                ; =1
104abfa48: 390f0109    	strb	w9, [x8, #0x3c0]
104abfa4c: 900dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abfa50: b984a114    	ldrsw	x20, [x8, #0x4a0]
104abfa54: f8746808    	ldr	x8, [x0, x20]
104abfa58: b40000a8    	cbz	x8, 0x104abfa6c <_Flutter_MMFoundation_BindContext+0xf9b650>
104abfa5c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104abfa60: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104abfa64: 9100c3ff    	add	sp, sp, #0x30
104abfa68: d65f03c0    	ret
104abfa6c: aa0003f3    	mov	x19, x0
104abfa70: 900db5a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104abfa74: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
104abfa78: d00d9bc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104abfa7c: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104abfa80: 900ce708    	adrp	x8, 0x11e79f000 <dyld_stub_binder+0x11e79f000>
104abfa84: 910f2108    	add	x8, x8, #0x3c8 ; CFString 'quick launch: createNewMainFrameViewController'
104abfa88: f90003e8    	str	x8, [sp]
104abfa8c: f00b3b43    	adrp	x3, 0x11b22a000 <dyld_stub_binder+0x11b22a000>
104abfa90: 9114a863    	add	x3, x3, #0x52a ; string 'TabBar'
104abfa94: 900b69a5    	adrp	x5, 0x11b7f3000 <dyld_stub_binder+0x11b7f3000>
104abfa98: 910370a5    	add	x5, x5, #0xdc ; string 'MainTabBarViewController.mm'
104abfa9c: 900b69a7    	adrp	x7, 0x11b7f3000 <dyld_stub_binder+0x11b7f3000>
104abfaa0: 910e08e7    	add	x7, x7, #0x382 ; string '-[MainTabBarViewController p_createNewMainFrameViewController]'
104abfaa4: 52800042    	mov	w2, #0x2                ; =2
104abfaa8: 52800004    	mov	w4, #0x0                ; =0
104abfaac: 52803846    	mov	w6, #0x1c2              ; =450
104abfab0: 94c59da3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abfab4: 900dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abfab8: b9848508    	ldrsw	x8, [x8, #0x484]
104abfabc: b8686a69    	ldr	w9, [x19, x8]
104abfac0: 321f0129    	orr	w9, w9, #0x2
104abfac4: b8286a69    	str	w9, [x19, x8]
104abfac8: b00db5a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104abfacc: f941b900    	ldr	x0, [x8, #0x370] ; class NewMainFrameViewController
104abfad0: 94c59da2    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104abfad4: f8746a68    	ldr	x8, [x19, x20]
104abfad8: f8346a60    	str	x0, [x19, x20]
104abfadc: aa0803e0    	mov	x0, x8
104abfae0: 94c59d9d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abfae4: f00db688    	adrp	x8, 0x120192000 <dyld_stub_binder+0x120192000>
104abfae8: f9453d00    	ldr	x0, [x8, #0xa78] ; class StatusBarMonitorNavigationController
104abfaec: 94c59d9d    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104abfaf0: f8746a62    	ldr	x2, [x19, x20]
104abfaf4: 900db228    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104abfaf8: f940d901    	ldr	x1, [x8, #0x1b0] ; selector initWithRootViewController:
104abfafc: 94c59d90    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abfb00: aa0003f4    	mov	x20, x0
104abfb04: 900dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abfb08: b9849108    	ldrsw	x8, [x8, #0x490]
104abfb0c: f8686a62    	ldr	x2, [x19, x8]
104abfb10: d00da628    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104abfb14: f9417901    	ldr	x1, [x8, #0x2f0] ; selector setTabBarItem:
104abfb18: 94c59d89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abfb1c: 900db248    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
104abfb20: f9451501    	ldr	x1, [x8, #0xa28] ; selector setDelegate:
104abfb24: aa1403e0    	mov	x0, x20
104abfb28: aa1403e2    	mov	x2, x20
104abfb2c: 94c59d84    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abfb30: 900dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abfb34: b9848908    	ldrsw	x8, [x8, #0x488]
104abfb38: f8686a60    	ldr	x0, [x19, x8]
104abfb3c: f00d9be8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104abfb40: f946d901    	ldr	x1, [x8, #0xdb0] ; selector safeReplaceObjectAtIndex:withObject:
104abfb44: d2800002    	mov	x2, #0x0                ; =0
104abfb48: aa1403e3    	mov	x3, x20
104abfb4c: 94c59d7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abfb50: aa1403e0    	mov	x0, x20
104abfb54: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104abfb58: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104abfb5c: 9100c3ff    	add	sp, sp, #0x30
104abfb60: 14c59d7d    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
