
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104e9e1d4: d10303ff    	sub	sp, sp, #0xc0
104e9e1d8: a9066ffc    	stp	x28, x27, [sp, #0x60]
104e9e1dc: a90767fa    	stp	x26, x25, [sp, #0x70]
104e9e1e0: a9085ff8    	stp	x24, x23, [sp, #0x80]
104e9e1e4: a90957f6    	stp	x22, x21, [sp, #0x90]
104e9e1e8: a90a4ff4    	stp	x20, x19, [sp, #0xa0]
104e9e1ec: a90b7bfd    	stp	x29, x30, [sp, #0xb0]
104e9e1f0: 9102c3fd    	add	x29, sp, #0xb0
104e9e1f4: aa0203f3    	mov	x19, x2
104e9e1f8: aa0003f4    	mov	x20, x0
104e9e1fc: b00ded08    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
104e9e200: 52800029    	mov	w9, #0x1                ; =1
104e9e204: 39076d09    	strb	w9, [x8, #0x1db]
104e9e208: aa0203e0    	mov	x0, x2
104e9e20c: 94b623cb    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104e9e210: b4001453    	cbz	x19, 0x104e9e498 <_Flutter_MMFoundation_BindContext+0x137a07c>
104e9e214: b00d7ce8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104e9e218: f947d101    	ldr	x1, [x8, #0xfa0] ; isChatroom
104e9e21c: aa1303e0    	mov	x0, x19
104e9e220: 94b623c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9e224: 34001340    	cbz	w0, 0x104e9e48c <_Flutter_MMFoundation_BindContext+0x137a070>
104e9e228: b00d96a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104e9e22c: f9478115    	ldr	x21, [x8, #0xf00] ;  /,
104e9e230: b00d7cfa    	adrp	x26, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104e9e234: f9434f41    	ldr	x1, [x26, #0x698] ; m_nsUsrName
104e9e238: aa1303e0    	mov	x0, x19
104e9e23c: 94b623c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9e240: aa1d03fd    	mov	x29, x29
104e9e244: 94b623c1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9e248: aa0003f6    	mov	x22, x0
104e9e24c: 900d7dc8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
104e9e250: f9429501    	ldr	x1, [x8, #0x528] ; getChatRoomMemberWithoutMyself:
104e9e254: aa1503e0    	mov	x0, x21
104e9e258: aa1603e2    	mov	x2, x22
104e9e25c: 94b623b8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9e260: aa1d03fd    	mov	x29, x29
104e9e264: 94b623b9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9e268: aa0003f5    	mov	x21, x0
104e9e26c: aa1603e0    	mov	x0, x22
104e9e270: 94b623b9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9e274: b40010f5    	cbz	x21, 0x104e9e490 <_Flutter_MMFoundation_BindContext+0x137a074>
104e9e278: d00d9308    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104e9e27c: f9435116    	ldr	x22, [x8, #0x6a0] ; count
104e9e280: aa1503e0    	mov	x0, x21
104e9e284: aa1603e1    	mov	x1, x22
104e9e288: 94b623ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9e28c: b4001020    	cbz	x0, 0x104e9e490 <_Flutter_MMFoundation_BindContext+0x137a074>
104e9e290: f00d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104e9e294: f9465101    	ldr	x1, [x8, #0xca0] ; setBShouldDelayUpdatePanelBtnAndToolViewSelectedContacts:
104e9e298: aa1403e0    	mov	x0, x20
104e9e29c: 52800022    	mov	w2, #0x1                ; =1
104e9e2a0: 94b623a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9e2a4: aa1503e0    	mov	x0, x21
104e9e2a8: aa1603e1    	mov	x1, x22
104e9e2ac: 94b623a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9e2b0: b4000b80    	cbz	x0, 0x104e9e420 <_Flutter_MMFoundation_BindContext+0x137a004>
104e9e2b4: d280001c    	mov	x28, #0x0               ; =0
104e9e2b8: d2800017    	mov	x23, #0x0               ; =0
104e9e2bc: 900d7ce8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104e9e2c0: f942c118    	ldr	x24, [x8, #0x580] ; safeObjectAtIndex:
104e9e2c4: 900d7dc8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
104e9e2c8: f9429919    	ldr	x25, [x8, #0x530] ; isSelected:
104e9e2cc: 900d7dc8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
104e9e2d0: f9429d09    	ldr	x9, [x8, #0x538] ; isExisted:
104e9e2d4: d00d7ce8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104e9e2d8: f940cd08    	ldr	x8, [x8, #0x198] ; isMMContact
104e9e2dc: a902a7e8    	stp	x8, x9, [sp, #0x28]
104e9e2e0: b00d7ce8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104e9e2e4: f9474909    	ldr	x9, [x8, #0xe90] ; isOpenImContact
104e9e2e8: f00d7e48    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104e9e2ec: f941850a    	ldr	x10, [x8, #0x308] ; updateMultiSelect:fromRecommendSection:fromInputView:needReloadTableView:
104e9e2f0: f9434f48    	ldr	x8, [x26, #0x698] ; m_nsUsrName
104e9e2f4: a901abe8    	stp	x8, x10, [sp, #0x18]
104e9e2f8: f00d7cc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104e9e2fc: f942c908    	ldr	x8, [x8, #0x590] ; safeSetObject:forKey:
104e9e300: a900a3e9    	stp	x9, x8, [sp, #0x8]
104e9e304: aa1c03fb    	mov	x27, x28
104e9e308: aa1503e0    	mov	x0, x21
104e9e30c: aa1803e1    	mov	x1, x24
104e9e310: aa1703e2    	mov	x2, x23
104e9e314: 94b6238a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9e318: aa1d03fd    	mov	x29, x29
104e9e31c: 94b6238b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9e320: aa0003fc    	mov	x28, x0
104e9e324: aa1b03e0    	mov	x0, x27
104e9e328: 94b6238b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9e32c: b400065c    	cbz	x28, 0x104e9e3f4 <_Flutter_MMFoundation_BindContext+0x1379fd8>
104e9e330: 900d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9e334: b988511a    	ldrsw	x26, [x8, #0x850]
104e9e338: f87a6a80    	ldr	x0, [x20, x26]
104e9e33c: aa1903e1    	mov	x1, x25
104e9e340: aa1c03e2    	mov	x2, x28
104e9e344: 94b6237e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9e348: 37000560    	tbnz	w0, #0x0, 0x104e9e3f4 <_Flutter_MMFoundation_BindContext+0x1379fd8>
104e9e34c: aa1403e0    	mov	x0, x20
104e9e350: f9401be1    	ldr	x1, [sp, #0x30]
104e9e354: aa1c03e2    	mov	x2, x28
104e9e358: 94b62379    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9e35c: 370004c0    	tbnz	w0, #0x0, 0x104e9e3f4 <_Flutter_MMFoundation_BindContext+0x1379fd8>
104e9e360: 900d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9e364: b9885508    	ldrsw	x8, [x8, #0x854]
104e9e368: b8686a88    	ldr	w8, [x20, x8]
104e9e36c: 7100611f    	cmp	w8, #0x18
104e9e370: 7a4f1904    	ccmp	w8, #0xf, #0x4, ne
104e9e374: 54000121    	b.ne	0x104e9e398 <_Flutter_MMFoundation_BindContext+0x1379f7c>
104e9e378: aa1c03e0    	mov	x0, x28
104e9e37c: f94017e1    	ldr	x1, [sp, #0x28]
104e9e380: 94b6236f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9e384: 340003e0    	cbz	w0, 0x104e9e400 <_Flutter_MMFoundation_BindContext+0x1379fe4>
104e9e388: aa1c03e0    	mov	x0, x28
104e9e38c: f94007e1    	ldr	x1, [sp, #0x8]
104e9e390: 94b6236b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9e394: 37000360    	tbnz	w0, #0x0, 0x104e9e400 <_Flutter_MMFoundation_BindContext+0x1379fe4>
104e9e398: f87a6a80    	ldr	x0, [x20, x26]
104e9e39c: f94013e1    	ldr	x1, [sp, #0x20]
104e9e3a0: aa1c03e2    	mov	x2, x28
104e9e3a4: 52800003    	mov	w3, #0x0                ; =0
104e9e3a8: 52800004    	mov	w4, #0x0                ; =0
104e9e3ac: 52800005    	mov	w5, #0x0                ; =0
104e9e3b0: 94b62363    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9e3b4: 900d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9e3b8: b9883108    	ldrsw	x8, [x8, #0x830]
104e9e3bc: f8686a9b    	ldr	x27, [x20, x8]
104e9e3c0: aa1c03e0    	mov	x0, x28
104e9e3c4: f9400fe1    	ldr	x1, [sp, #0x18]
104e9e3c8: 94b6235d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9e3cc: aa1d03fd    	mov	x29, x29
104e9e3d0: 94b6235e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9e3d4: aa0003fa    	mov	x26, x0
104e9e3d8: aa1b03e0    	mov	x0, x27
104e9e3dc: f9400be1    	ldr	x1, [sp, #0x10]
104e9e3e0: aa1c03e2    	mov	x2, x28
104e9e3e4: aa1a03e3    	mov	x3, x26
104e9e3e8: 94b62355    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9e3ec: aa1a03e0    	mov	x0, x26
104e9e3f0: 94b62359    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9e3f4: aa1c03e0    	mov	x0, x28
104e9e3f8: 94b62357    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9e3fc: d280001c    	mov	x28, #0x0               ; =0
104e9e400: 910006f7    	add	x23, x23, #0x1
104e9e404: aa1503e0    	mov	x0, x21
104e9e408: aa1603e1    	mov	x1, x22
104e9e40c: 94b6234c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9e410: eb0002ff    	cmp	x23, x0
104e9e414: 54fff783    	b.lo	0x104e9e304 <_Flutter_MMFoundation_BindContext+0x1379ee8>
104e9e418: aa1c03e0    	mov	x0, x28
104e9e41c: 94b6234e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9e420: d2800000    	mov	x0, #0x0                ; =0
104e9e424: 52946001    	mov	w1, #0xa300             ; =41728
104e9e428: 72a23c21    	movk	w1, #0x11e1, lsl #16
104e9e42c: 94b62365    	bl	0x107c271c0 <_Flutter_MMFoundation_BindContext+0x4102da4>
104e9e430: 900c3a88    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
104e9e434: f947e108    	ldr	x8, [x8, #0xfc0]
104e9e438: f9001fe8    	str	x8, [sp, #0x38]
104e9e43c: f009f708    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
104e9e440: fd41c100    	ldr	d0, [x8, #0x380]
104e9e444: 90000008    	adrp	x8, 0x104e9e000 <_Flutter_MMFoundation_BindContext+0x1379be4>
104e9e448: 91130108    	add	x8, x8, #0x4c0
104e9e44c: fd0023e0    	str	d0, [sp, #0x40]
104e9e450: 900c3ac9    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
104e9e454: 9115c129    	add	x9, x9, #0x570
104e9e458: a904a7e8    	stp	x8, x9, [sp, #0x48]
104e9e45c: f9002ff4    	str	x20, [sp, #0x58]
104e9e460: b00c3a81    	adrp	x1, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104e9e464: f9408c21    	ldr	x1, [x1, #0x118]
104e9e468: 9100e3e2    	add	x2, sp, #0x38
104e9e46c: 94b5bb6f    	bl	0x107c0d228 <_Flutter_MMFoundation_BindContext+0x40e8e0c>
104e9e470: 900d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9e474: b9885108    	ldrsw	x8, [x8, #0x850]
104e9e478: f8686a80    	ldr	x0, [x20, x8]
104e9e47c: b00d7ce8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104e9e480: f9458901    	ldr	x1, [x8, #0xb10] ; reloadTableView
104e9e484: 94b6232e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9e488: 14000002    	b	0x104e9e490 <_Flutter_MMFoundation_BindContext+0x137a074>
104e9e48c: d2800015    	mov	x21, #0x0               ; =0
104e9e490: aa1503e0    	mov	x0, x21
104e9e494: 94b62330    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9e498: aa1303e0    	mov	x0, x19
104e9e49c: 94b6232e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9e4a0: a94b7bfd    	ldp	x29, x30, [sp, #0xb0]
104e9e4a4: a94a4ff4    	ldp	x20, x19, [sp, #0xa0]
104e9e4a8: a94957f6    	ldp	x22, x21, [sp, #0x90]
104e9e4ac: a9485ff8    	ldp	x24, x23, [sp, #0x80]
104e9e4b0: a94767fa    	ldp	x26, x25, [sp, #0x70]
104e9e4b4: a9466ffc    	ldp	x28, x27, [sp, #0x60]
104e9e4b8: 910303ff    	add	sp, sp, #0xc0
104e9e4bc: d65f03c0    	ret
