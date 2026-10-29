
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10471f65c: d10243ff    	sub	sp, sp, #0x90
10471f660: 6d0223e9    	stp	d9, d8, [sp, #0x20]
10471f664: a9036ffc    	stp	x28, x27, [sp, #0x30]
10471f668: a90467fa    	stp	x26, x25, [sp, #0x40]
10471f66c: a9055ff8    	stp	x24, x23, [sp, #0x50]
10471f670: a90657f6    	stp	x22, x21, [sp, #0x60]
10471f674: a9074ff4    	stp	x20, x19, [sp, #0x70]
10471f678: a9087bfd    	stp	x29, x30, [sp, #0x80]
10471f67c: 910203fd    	add	x29, sp, #0x80
10471f680: aa0003f3    	mov	x19, x0
10471f684: d00e28e8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
10471f688: 52800029    	mov	w9, #0x1                ; =1
10471f68c: 39196d09    	strb	w9, [x8, #0x65b]
10471f690: 900dd808    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
10471f694: b989d11c    	ldrsw	x28, [x8, #0x9d0]
10471f698: f87c6808    	ldr	x8, [x0, x28]
10471f69c: b5000188    	cbnz	x8, 0x10471f6cc <_Flutter_MMFoundation_BindContext+0xbfb2b0>
10471f6a0: 900dd2a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10471f6a4: f9455500    	ldr	x0, [x8, #0xaa8] ; class NSMutableArray
10471f6a8: 900dcf08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10471f6ac: f941a101    	ldr	x1, [x8, #0x340] ; selector array
10471f6b0: 94d41ea3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f6b4: aa1d03fd    	mov	x29, x29
10471f6b8: 94d41ea4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471f6bc: f87c6a68    	ldr	x8, [x19, x28]
10471f6c0: f83c6a60    	str	x0, [x19, x28]
10471f6c4: aa0803e0    	mov	x0, x8
10471f6c8: 94d41ea3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471f6cc: 900dcf68    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10471f6d0: f947a501    	ldr	x1, [x8, #0xf48] ; selector width
10471f6d4: aa1303e0    	mov	x0, x19
10471f6d8: 94d41e99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f6dc: 1e604009    	fmov	d9, d0
10471f6e0: 900dcf28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10471f6e4: f9459914    	ldr	x20, [x8, #0xb30] ; selector items
10471f6e8: aa1303e0    	mov	x0, x19
10471f6ec: aa1403e1    	mov	x1, x20
10471f6f0: 94d41e93    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f6f4: aa1d03fd    	mov	x29, x29
10471f6f8: 94d41e94    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471f6fc: aa0003f6    	mov	x22, x0
10471f700: b00dcf08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10471f704: f9435115    	ldr	x21, [x8, #0x6a0] ; selector count
10471f708: aa1503e1    	mov	x1, x21
10471f70c: 94d41e8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f710: aa0003f7    	mov	x23, x0
10471f714: aa1603e0    	mov	x0, x22
10471f718: 94d41e8f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471f71c: f00dcf08    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10471f720: f9449d01    	ldr	x1, [x8, #0x938] ; selector height
10471f724: aa1303e0    	mov	x0, x19
10471f728: 94d41e85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f72c: 1e604008    	fmov	d8, d0
10471f730: aa1303e0    	mov	x0, x19
10471f734: aa1403e1    	mov	x1, x20
10471f738: 94d41e81    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f73c: aa1d03fd    	mov	x29, x29
10471f740: 94d41e82    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471f744: aa0003f6    	mov	x22, x0
10471f748: aa1503e1    	mov	x1, x21
10471f74c: 94d41e7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f750: aa0003f8    	mov	x24, x0
10471f754: aa1603e0    	mov	x0, x22
10471f758: 94d41e7f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471f75c: b4000b38    	cbz	x24, 0x10471f8c0 <_Flutter_MMFoundation_BindContext+0xbfb4a4>
10471f760: d2800016    	mov	x22, #0x0               ; =0
10471f764: 9e6302e0    	ucvtf	d0, x23
10471f768: 1e601920    	fdiv	d0, d9, d0
10471f76c: 1e67c009    	frinti	d9, d0
10471f770: f00db8c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10471f774: f942c117    	ldr	x23, [x8, #0x580] ; selector safeObjectAtIndex:
10471f778: 900dcf08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10471f77c: f947ad18    	ldr	x24, [x8, #0xf58] ; selector class
10471f780: 900dcf28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10471f784: f9442d19    	ldr	x25, [x8, #0x858] ; selector isKindOfClass:
10471f788: f00dc248    	adrp	x8, 0x11ff6a000 <dyld_stub_binder+0x11ff6a000>
10471f78c: f947c509    	ldr	x9, [x8, #0xf88] ; selector initWithItem:frame:
10471f790: f00dcee8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10471f794: f946f508    	ldr	x8, [x8, #0xde8] ; selector addObject:
10471f798: a90127e8    	stp	x8, x9, [sp, #0x10]
10471f79c: f00dcee8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10471f7a0: f9476d08    	ldr	x8, [x8, #0xed8] ; selector addSubview:
10471f7a4: f90007e8    	str	x8, [sp, #0x8]
10471f7a8: f87c6a60    	ldr	x0, [x19, x28]
10471f7ac: aa1503e1    	mov	x1, x21
10471f7b0: 94d41e63    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f7b4: eb0002df    	cmp	x22, x0
10471f7b8: 54000683    	b.lo	0x10471f888 <_Flutter_MMFoundation_BindContext+0xbfb46c>
10471f7bc: aa1303e0    	mov	x0, x19
10471f7c0: aa1403e1    	mov	x1, x20
10471f7c4: 94d41e5e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f7c8: aa1d03fd    	mov	x29, x29
10471f7cc: 94d41e5f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471f7d0: aa0003fb    	mov	x27, x0
10471f7d4: aa1703e1    	mov	x1, x23
10471f7d8: aa1603e2    	mov	x2, x22
10471f7dc: 94d41e58    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f7e0: aa1d03fd    	mov	x29, x29
10471f7e4: 94d41e59    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471f7e8: aa0003fa    	mov	x26, x0
10471f7ec: aa1b03e0    	mov	x0, x27
10471f7f0: 94d41e59    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471f7f4: f00dd308    	adrp	x8, 0x120182000 <dyld_stub_binder+0x120182000>
10471f7f8: f9434900    	ldr	x0, [x8, #0x690] ; class MMTabbarItem
10471f7fc: aa1803e1    	mov	x1, x24
10471f800: 94d41e4f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f804: aa0003e2    	mov	x2, x0
10471f808: aa1a03e0    	mov	x0, x26
10471f80c: aa1903e1    	mov	x1, x25
10471f810: 94d41e4b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f814: 34000360    	cbz	w0, 0x10471f880 <_Flutter_MMFoundation_BindContext+0xbfb464>
10471f818: b00dd388    	adrp	x8, 0x120190000 <dyld_stub_binder+0x120190000>
10471f81c: f940e11b    	ldr	x27, [x8, #0x1c0] ; class MMTabBarItemView
10471f820: aa1a03e0    	mov	x0, x26
10471f824: 94d41e45    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10471f828: aa1b03e0    	mov	x0, x27
10471f82c: 94d41e4d    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10471f830: 9e6703e0    	fmov	d0, xzr
10471f834: 9e6703e1    	fmov	d1, xzr
10471f838: f9400fe1    	ldr	x1, [sp, #0x18]
10471f83c: aa1a03e2    	mov	x2, x26
10471f840: 1e604122    	fmov	d2, d9
10471f844: 1e604103    	fmov	d3, d8
10471f848: 94d41e3d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f84c: aa0003fb    	mov	x27, x0
10471f850: aa1a03e0    	mov	x0, x26
10471f854: 94d41e40    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471f858: f87c6a60    	ldr	x0, [x19, x28]
10471f85c: f9400be1    	ldr	x1, [sp, #0x10]
10471f860: aa1b03e2    	mov	x2, x27
10471f864: 94d41e36    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f868: aa1303e0    	mov	x0, x19
10471f86c: f94007e1    	ldr	x1, [sp, #0x8]
10471f870: aa1b03e2    	mov	x2, x27
10471f874: 94d41e32    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f878: aa1b03e0    	mov	x0, x27
10471f87c: 94d41e36    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471f880: aa1a03e0    	mov	x0, x26
10471f884: 94d41e34    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471f888: 910006d6    	add	x22, x22, #0x1
10471f88c: aa1303e0    	mov	x0, x19
10471f890: aa1403e1    	mov	x1, x20
10471f894: 94d41e2a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f898: aa1d03fd    	mov	x29, x29
10471f89c: 94d41e2b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471f8a0: aa0003fa    	mov	x26, x0
10471f8a4: aa1503e1    	mov	x1, x21
10471f8a8: 94d41e25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f8ac: aa0003fb    	mov	x27, x0
10471f8b0: aa1a03e0    	mov	x0, x26
10471f8b4: 94d41e28    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471f8b8: eb1b02df    	cmp	x22, x27
10471f8bc: 54fff763    	b.lo	0x10471f7a8 <_Flutter_MMFoundation_BindContext+0xbfb38c>
10471f8c0: a9487bfd    	ldp	x29, x30, [sp, #0x80]
10471f8c4: a9474ff4    	ldp	x20, x19, [sp, #0x70]
10471f8c8: a94657f6    	ldp	x22, x21, [sp, #0x60]
10471f8cc: a9455ff8    	ldp	x24, x23, [sp, #0x50]
10471f8d0: a94467fa    	ldp	x26, x25, [sp, #0x40]
10471f8d4: a9436ffc    	ldp	x28, x27, [sp, #0x30]
10471f8d8: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
10471f8dc: 910243ff    	add	sp, sp, #0x90
10471f8e0: d65f03c0    	ret
