
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104adb108: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
104adb10c: a90167fa    	stp	x26, x25, [sp, #0x10]
104adb110: a9025ff8    	stp	x24, x23, [sp, #0x20]
104adb114: a90357f6    	stp	x22, x21, [sp, #0x30]
104adb118: a9044ff4    	stp	x20, x19, [sp, #0x40]
104adb11c: a9057bfd    	stp	x29, x30, [sp, #0x50]
104adb120: 910143fd    	add	x29, sp, #0x50
104adb124: d10a03ff    	sub	sp, sp, #0x280
104adb128: aa0003f5    	mov	x21, x0
104adb12c: 900c58a8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104adb130: f9405908    	ldr	x8, [x8, #0xb0]
104adb134: f9400108    	ldr	x8, [x8]
104adb138: f81a03a8    	stur	x8, [x29, #-0x60]
104adb13c: f00e0b08    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104adb140: 52800029    	mov	w9, #0x1                ; =1
104adb144: 3910b509    	strb	w9, [x8, #0x42d]
104adb148: f90017e2    	str	x2, [sp, #0x28]
104adb14c: aa0203e0    	mov	x0, x2
104adb150: 94c52ffa    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104adb154: 900db4d4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
104adb158: f9455680    	ldr	x0, [x20, #0xaa8]
104adb15c: 900db128    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104adb160: f941a116    	ldr	x22, [x8, #0x340] ; array
104adb164: aa1603e1    	mov	x1, x22
104adb168: 94c52ff5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb16c: aa1d03fd    	mov	x29, x29
104adb170: 94c52ff6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb174: f9000be0    	str	x0, [sp, #0x10]
104adb178: 4f00e400    	movi.16b	v0, #0x0
104adb17c: ad0583e0    	stp	q0, q0, [sp, #0xb0]
104adb180: ad0683e0    	stp	q0, q0, [sp, #0xd0]
104adb184: f9400aa0    	ldr	x0, [x21, #0x10]
104adb188: 900db128    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104adb18c: f9401101    	ldr	x1, [x8, #0x20] ; allValues
104adb190: 94c52feb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb194: aa1d03fd    	mov	x29, x29
104adb198: 94c52fec    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb19c: aa0003f7    	mov	x23, x0
104adb1a0: b00db128    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104adb1a4: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
104adb1a8: 9102c3e2    	add	x2, sp, #0xb0
104adb1ac: d10383a3    	sub	x3, x29, #0xe0
104adb1b0: f90013e1    	str	x1, [sp, #0x20]
104adb1b4: 52800204    	mov	w4, #0x10               ; =16
104adb1b8: 94c52fe1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb1bc: b40003a0    	cbz	x0, 0x104adb230 <_Flutter_MMFoundation_BindContext+0xfb6e14>
104adb1c0: aa0003f8    	mov	x24, x0
104adb1c4: f94063e8    	ldr	x8, [sp, #0xc0]
104adb1c8: f9400113    	ldr	x19, [x8]
104adb1cc: f00db115    	adrp	x21, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
104adb1d0: d280001a    	mov	x26, #0x0               ; =0
104adb1d4: f946fab9    	ldr	x25, [x21, #0xdf0] ; addObjectsFromArray:
104adb1d8: f94063e8    	ldr	x8, [sp, #0xc0]
104adb1dc: f9400108    	ldr	x8, [x8]
104adb1e0: eb13011f    	cmp	x8, x19
104adb1e4: 54000060    	b.eq	0x104adb1f0 <_Flutter_MMFoundation_BindContext+0xfb6dd4>
104adb1e8: aa1703e0    	mov	x0, x23
104adb1ec: 94c52fd9    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
104adb1f0: f9405fe8    	ldr	x8, [sp, #0xb8]
104adb1f4: f87a7902    	ldr	x2, [x8, x26, lsl #3]
104adb1f8: f9400be0    	ldr	x0, [sp, #0x10]
104adb1fc: aa1903e1    	mov	x1, x25
104adb200: 94c52fcf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb204: 9100075a    	add	x26, x26, #0x1
104adb208: eb1a031f    	cmp	x24, x26
104adb20c: 54fffe61    	b.ne	0x104adb1d8 <_Flutter_MMFoundation_BindContext+0xfb6dbc>
104adb210: 9102c3e2    	add	x2, sp, #0xb0
104adb214: d10383a3    	sub	x3, x29, #0xe0
104adb218: aa1703e0    	mov	x0, x23
104adb21c: f94013e1    	ldr	x1, [sp, #0x20]
104adb220: 52800204    	mov	w4, #0x10               ; =16
104adb224: 94c52fc6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb228: aa0003f8    	mov	x24, x0
104adb22c: b5fffd20    	cbnz	x0, 0x104adb1d0 <_Flutter_MMFoundation_BindContext+0xfb6db4>
104adb230: aa1703e0    	mov	x0, x23
104adb234: 94c52fc8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb238: f9455680    	ldr	x0, [x20, #0xaa8]
104adb23c: aa1603e1    	mov	x1, x22
104adb240: 94c52fbf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb244: aa1d03fd    	mov	x29, x29
104adb248: 94c52fc0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb24c: aa0003f6    	mov	x22, x0
104adb250: 4f00e400    	movi.16b	v0, #0x0
104adb254: ad0383e0    	stp	q0, q0, [sp, #0x70]
104adb258: ad0483e0    	stp	q0, q0, [sp, #0x90]
104adb25c: f9400be0    	ldr	x0, [sp, #0x10]
104adb260: 94c52fb6    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104adb264: 9101c3e2    	add	x2, sp, #0x70
104adb268: 9105c3e3    	add	x3, sp, #0x170
104adb26c: f94013e1    	ldr	x1, [sp, #0x20]
104adb270: 52800204    	mov	w4, #0x10               ; =16
104adb274: 94c52fb2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb278: f90007e0    	str	x0, [sp, #0x8]
104adb27c: b4000ac0    	cbz	x0, 0x104adb3d4 <_Flutter_MMFoundation_BindContext+0xfb6fb8>
104adb280: f94043e8    	ldr	x8, [sp, #0x80]
104adb284: f9400108    	ldr	x8, [x8]
104adb288: f90003e8    	str	x8, [sp]
104adb28c: d2800013    	mov	x19, #0x0               ; =0
104adb290: f94043e8    	ldr	x8, [sp, #0x80]
104adb294: f9400108    	ldr	x8, [x8]
104adb298: f94003e9    	ldr	x9, [sp]
104adb29c: eb09011f    	cmp	x8, x9
104adb2a0: 54000060    	b.eq	0x104adb2ac <_Flutter_MMFoundation_BindContext+0xfb6e90>
104adb2a4: f9400be0    	ldr	x0, [sp, #0x10]
104adb2a8: 94c52faa    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
104adb2ac: f9403fe8    	ldr	x8, [sp, #0x78]
104adb2b0: f9000ff3    	str	x19, [sp, #0x18]
104adb2b4: f8737918    	ldr	x24, [x8, x19, lsl #3]
104adb2b8: 4f00e400    	movi.16b	v0, #0x0
104adb2bc: ad0183e0    	stp	q0, q0, [sp, #0x30]
104adb2c0: ad0283e0    	stp	q0, q0, [sp, #0x50]
104adb2c4: f94017e0    	ldr	x0, [sp, #0x28]
104adb2c8: 94c52f9c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104adb2cc: 9100c3e2    	add	x2, sp, #0x30
104adb2d0: 9103c3e3    	add	x3, sp, #0xf0
104adb2d4: f94013e1    	ldr	x1, [sp, #0x20]
104adb2d8: 52800204    	mov	w4, #0x10               ; =16
104adb2dc: 94c52f98    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb2e0: b40005c0    	cbz	x0, 0x104adb398 <_Flutter_MMFoundation_BindContext+0xfb6f7c>
104adb2e4: aa0003f9    	mov	x25, x0
104adb2e8: f94023e8    	ldr	x8, [sp, #0x40]
104adb2ec: f9400115    	ldr	x21, [x8]
104adb2f0: d2800013    	mov	x19, #0x0               ; =0
104adb2f4: 900d9b08    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104adb2f8: f9434d1a    	ldr	x26, [x8, #0x698] ; m_nsUsrName
104adb2fc: 900db148    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104adb300: f943c91b    	ldr	x27, [x8, #0x790] ; isEqualToString:
104adb304: f00d9ae8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104adb308: f943c51c    	ldr	x28, [x8, #0x788] ; safeAddObject:
104adb30c: f94023e8    	ldr	x8, [sp, #0x40]
104adb310: f9400108    	ldr	x8, [x8]
104adb314: eb15011f    	cmp	x8, x21
104adb318: 54000060    	b.eq	0x104adb324 <_Flutter_MMFoundation_BindContext+0xfb6f08>
104adb31c: f94017e0    	ldr	x0, [sp, #0x28]
104adb320: 94c52f8c    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
104adb324: f9401fe8    	ldr	x8, [sp, #0x38]
104adb328: f8737914    	ldr	x20, [x8, x19, lsl #3]
104adb32c: aa1803e0    	mov	x0, x24
104adb330: aa1a03e1    	mov	x1, x26
104adb334: 94c52f82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb338: aa1d03fd    	mov	x29, x29
104adb33c: 94c52f83    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb340: aa0003f7    	mov	x23, x0
104adb344: aa1b03e1    	mov	x1, x27
104adb348: aa1403e2    	mov	x2, x20
104adb34c: 94c52f7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb350: aa0003f4    	mov	x20, x0
104adb354: aa1703e0    	mov	x0, x23
104adb358: 94c52f7f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb35c: 340000b4    	cbz	w20, 0x104adb370 <_Flutter_MMFoundation_BindContext+0xfb6f54>
104adb360: aa1603e0    	mov	x0, x22
104adb364: aa1c03e1    	mov	x1, x28
104adb368: aa1803e2    	mov	x2, x24
104adb36c: 94c52f74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb370: 91000673    	add	x19, x19, #0x1
104adb374: eb13033f    	cmp	x25, x19
104adb378: 54fffca1    	b.ne	0x104adb30c <_Flutter_MMFoundation_BindContext+0xfb6ef0>
104adb37c: 9100c3e2    	add	x2, sp, #0x30
104adb380: 9103c3e3    	add	x3, sp, #0xf0
104adb384: a94203e1    	ldp	x1, x0, [sp, #0x20]
104adb388: 52800204    	mov	w4, #0x10               ; =16
104adb38c: 94c52f6c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb390: aa0003f9    	mov	x25, x0
104adb394: b5fffae0    	cbnz	x0, 0x104adb2f0 <_Flutter_MMFoundation_BindContext+0xfb6ed4>
104adb398: f94017e0    	ldr	x0, [sp, #0x28]
104adb39c: 94c52f6e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb3a0: f9400ff3    	ldr	x19, [sp, #0x18]
104adb3a4: 91000673    	add	x19, x19, #0x1
104adb3a8: f94007e8    	ldr	x8, [sp, #0x8]
104adb3ac: eb08027f    	cmp	x19, x8
104adb3b0: 54fff701    	b.ne	0x104adb290 <_Flutter_MMFoundation_BindContext+0xfb6e74>
104adb3b4: 9101c3e2    	add	x2, sp, #0x70
104adb3b8: 9105c3e3    	add	x3, sp, #0x170
104adb3bc: f9400be0    	ldr	x0, [sp, #0x10]
104adb3c0: f94013e1    	ldr	x1, [sp, #0x20]
104adb3c4: 52800204    	mov	w4, #0x10               ; =16
104adb3c8: 94c52f5d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb3cc: f90007e0    	str	x0, [sp, #0x8]
104adb3d0: b5fff5e0    	cbnz	x0, 0x104adb28c <_Flutter_MMFoundation_BindContext+0xfb6e70>
104adb3d4: f9400bf3    	ldr	x19, [sp, #0x10]
104adb3d8: aa1303e0    	mov	x0, x19
104adb3dc: 94c52f5e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb3e0: aa1303e0    	mov	x0, x19
104adb3e4: 94c52f5c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb3e8: f94017e0    	ldr	x0, [sp, #0x28]
104adb3ec: 94c52f5a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb3f0: f85a03a8    	ldur	x8, [x29, #-0x60]
104adb3f4: 900c58a9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104adb3f8: f9405929    	ldr	x9, [x9, #0xb0]
104adb3fc: f9400129    	ldr	x9, [x9]
104adb400: eb08013f    	cmp	x9, x8
104adb404: 54000141    	b.ne	0x104adb42c <_Flutter_MMFoundation_BindContext+0xfb7010>
104adb408: aa1603e0    	mov	x0, x22
104adb40c: 910a03ff    	add	sp, sp, #0x280
104adb410: a9457bfd    	ldp	x29, x30, [sp, #0x50]
104adb414: a9444ff4    	ldp	x20, x19, [sp, #0x40]
104adb418: a94357f6    	ldp	x22, x21, [sp, #0x30]
104adb41c: a9425ff8    	ldp	x24, x23, [sp, #0x20]
104adb420: a94167fa    	ldp	x26, x25, [sp, #0x10]
104adb424: a8c66ffc    	ldp	x28, x27, [sp], #0x60
104adb428: 14c52f52    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
104adb42c: 94c52f52    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
