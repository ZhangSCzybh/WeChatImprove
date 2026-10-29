
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104725e74: d10183ff    	sub	sp, sp, #0x60
104725e78: a90167fa    	stp	x26, x25, [sp, #0x10]
104725e7c: a9025ff8    	stp	x24, x23, [sp, #0x20]
104725e80: a90357f6    	stp	x22, x21, [sp, #0x30]
104725e84: a9044ff4    	stp	x20, x19, [sp, #0x40]
104725e88: a9057bfd    	stp	x29, x30, [sp, #0x50]
104725e8c: 910143fd    	add	x29, sp, #0x50
104725e90: aa0203f3    	mov	x19, x2
104725e94: aa0003f4    	mov	x20, x0
104725e98: 900e28c8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
104725e9c: 52800029    	mov	w9, #0x1                ; =1
104725ea0: 3919f909    	strb	w9, [x8, #0x67e]
104725ea4: d00dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
104725ea8: b98a0119    	ldrsw	x25, [x8, #0xa00]
104725eac: f8796800    	ldr	x0, [x0, x25]
104725eb0: b5000120    	cbnz	x0, 0x104725ed4 <_Flutter_MMFoundation_BindContext+0xc01ab8>
104725eb4: 900dc288    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104725eb8: f9464501    	ldr	x1, [x8, #0xc88] ; selector getTabBarBtnViews
104725ebc: aa1403e0    	mov	x0, x20
104725ec0: 94d4049f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104725ec4: aa1d03fd    	mov	x29, x29
104725ec8: 94d404a7    	bl	0x107c27164 <_Flutter_MMFoundation_BindContext+0x4102d48>
104725ecc: f8796a80    	ldr	x0, [x20, x25]
104725ed0: b40008c0    	cbz	x0, 0x104725fe8 <_Flutter_MMFoundation_BindContext+0xc01bcc>
104725ed4: f00dcec8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104725ed8: f9435115    	ldr	x21, [x8, #0x6a0] ; selector count
104725edc: aa1503e1    	mov	x1, x21
104725ee0: 94d40497    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104725ee4: b4000820    	cbz	x0, 0x104725fe8 <_Flutter_MMFoundation_BindContext+0xc01bcc>
104725ee8: f8796a80    	ldr	x0, [x20, x25]
104725eec: aa1503e1    	mov	x1, x21
104725ef0: 94d40493    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104725ef4: eb13001f    	cmp	x0, x19
104725ef8: 54000789    	b.ls	0x104725fe8 <_Flutter_MMFoundation_BindContext+0xc01bcc>
104725efc: f8796a80    	ldr	x0, [x20, x25]
104725f00: b00db8a8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104725f04: f942c117    	ldr	x23, [x8, #0x580] ; selector safeObjectAtIndex:
104725f08: aa1703e1    	mov	x1, x23
104725f0c: aa1303e2    	mov	x2, x19
104725f10: 94d4048b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104725f14: aa1d03fd    	mov	x29, x29
104725f18: 94d4048c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104725f1c: aa0003f6    	mov	x22, x0
104725f20: d00dcf28    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104725f24: f947a901    	ldr	x1, [x8, #0xf50] ; selector window
104725f28: 94d40485    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104725f2c: aa1d03fd    	mov	x29, x29
104725f30: 94d40486    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104725f34: aa0003f8    	mov	x24, x0
104725f38: 94d40487    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104725f3c: b50007b8    	cbnz	x24, 0x104726030 <_Flutter_MMFoundation_BindContext+0xc01c14>
104725f40: d00dd268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104725f44: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
104725f48: 900db8a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104725f4c: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104725f50: d00d0228    	adrp	x8, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
104725f54: 910c2108    	add	x8, x8, #0x308 ; CFString 're gen button'
104725f58: f90003e8    	str	x8, [sp]
104725f5c: f00b8385    	adrp	x5, 0x11b798000 <dyld_stub_binder+0x11b798000>
104725f60: 912d64a5    	add	x5, x5, #0xb59 ; string 'MMTabBarController.mm'
104725f64: f00b8387    	adrp	x7, 0x11b798000 <dyld_stub_binder+0x11b798000>
104725f68: 91365ce7    	add	x7, x7, #0xd97 ; string '-[MMTabBarController getTabBarBtnForIndex:]'
104725f6c: 52800042    	mov	w2, #0x2                ; =2
104725f70: d2800003    	mov	x3, #0x0                ; =0
104725f74: 52800004    	mov	w4, #0x0                ; =0
104725f78: 52803826    	mov	w6, #0x1c1              ; =449
104725f7c: 94d40470    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104725f80: 900dc288    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104725f84: f9464901    	ldr	x1, [x8, #0xc90] ; selector clearTabBtns
104725f88: aa1403e0    	mov	x0, x20
104725f8c: 94d4046c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104725f90: 900dc288    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104725f94: f9464501    	ldr	x1, [x8, #0xc88] ; selector getTabBarBtnViews
104725f98: aa1403e0    	mov	x0, x20
104725f9c: 94d40468    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104725fa0: aa1d03fd    	mov	x29, x29
104725fa4: 94d40470    	bl	0x107c27164 <_Flutter_MMFoundation_BindContext+0x4102d48>
104725fa8: f8796a80    	ldr	x0, [x20, x25]
104725fac: aa1503e1    	mov	x1, x21
104725fb0: 94d40463    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104725fb4: eb13001f    	cmp	x0, x19
104725fb8: 540003c9    	b.ls	0x104726030 <_Flutter_MMFoundation_BindContext+0xc01c14>
104725fbc: f8796a80    	ldr	x0, [x20, x25]
104725fc0: aa1703e1    	mov	x1, x23
104725fc4: aa1303e2    	mov	x2, x19
104725fc8: 94d4045d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104725fcc: aa1d03fd    	mov	x29, x29
104725fd0: 94d4045e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104725fd4: aa0003f3    	mov	x19, x0
104725fd8: aa1603e0    	mov	x0, x22
104725fdc: 94d4045e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104725fe0: aa1303f6    	mov	x22, x19
104725fe4: 14000013    	b	0x104726030 <_Flutter_MMFoundation_BindContext+0xc01c14>
104725fe8: d00dd268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104725fec: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
104725ff0: 900db8a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104725ff4: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104725ff8: d00d0228    	adrp	x8, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
104725ffc: 910ca108    	add	x8, x8, #0x328 ; CFString "Can't find button for index: %ld"
104726000: a9004fe8    	stp	x8, x19, [sp]
104726004: 900b5823    	adrp	x3, 0x11b22a000 <dyld_stub_binder+0x11b22a000>
104726008: 9114a863    	add	x3, x3, #0x52a ; string 'TabBar'
10472600c: d00b8385    	adrp	x5, 0x11b798000 <dyld_stub_binder+0x11b798000>
104726010: 912d64a5    	add	x5, x5, #0xb59 ; string 'MMTabBarController.mm'
104726014: d00b8387    	adrp	x7, 0x11b798000 <dyld_stub_binder+0x11b798000>
104726018: 91365ce7    	add	x7, x7, #0xd97 ; string '-[MMTabBarController getTabBarBtnForIndex:]'
10472601c: 52800082    	mov	w2, #0x4                ; =4
104726020: 52800004    	mov	w4, #0x0                ; =0
104726024: 52803946    	mov	w6, #0x1ca              ; =458
104726028: 94d40445    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472602c: d2800016    	mov	x22, #0x0               ; =0
104726030: aa1603e0    	mov	x0, x22
104726034: a9457bfd    	ldp	x29, x30, [sp, #0x50]
104726038: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10472603c: a94357f6    	ldp	x22, x21, [sp, #0x30]
104726040: a9425ff8    	ldp	x24, x23, [sp, #0x20]
104726044: a94167fa    	ldp	x26, x25, [sp, #0x10]
104726048: 910183ff    	add	sp, sp, #0x60
10472604c: 14d40449    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
