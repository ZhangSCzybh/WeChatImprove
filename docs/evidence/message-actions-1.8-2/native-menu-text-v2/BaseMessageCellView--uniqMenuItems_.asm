
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002a409c: d10503ff    	sub	sp, sp, #0x140
1002a40a0: a90e6ffc    	stp	x28, x27, [sp, #0xe0]
1002a40a4: a90f67fa    	stp	x26, x25, [sp, #0xf0]
1002a40a8: a9105ff8    	stp	x24, x23, [sp, #0x100]
1002a40ac: a91157f6    	stp	x22, x21, [sp, #0x110]
1002a40b0: a9124ff4    	stp	x20, x19, [sp, #0x120]
1002a40b4: a9137bfd    	stp	x29, x30, [sp, #0x130]
1002a40b8: 9104c3fd    	add	x29, sp, #0x130
1002a40bc: aa0203f3    	mov	x19, x2
1002a40c0: f00e9a48    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1002a40c4: f9405908    	ldr	x8, [x8, #0xb0]
1002a40c8: f9400108    	ldr	x8, [x8]
1002a40cc: f81a03a8    	stur	x8, [x29, #-0x60]
1002a40d0: b0104c48    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
1002a40d4: 52800029    	mov	w9, #0x1                ; =1
1002a40d8: 39311109    	strb	w9, [x8, #0xc44]
1002a40dc: aa0203e0    	mov	x0, x2
1002a40e0: 95e60c16    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1002a40e4: f00ff668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a40e8: f9455514    	ldr	x20, [x8, #0xaa8]
1002a40ec: 900ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a40f0: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1002a40f4: aa1303e0    	mov	x0, x19
1002a40f8: 95e60c11    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a40fc: aa0003e2    	mov	x2, x0
1002a4100: f00ff2c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002a4104: f941b501    	ldr	x1, [x8, #0x368] ; arrayWithCapacity:
1002a4108: aa1403e0    	mov	x0, x20
1002a410c: 95e60c0c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4110: aa1d03fd    	mov	x29, x29
1002a4114: 95e60c0d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4118: f90007e0    	str	x0, [sp, #0x8]
1002a411c: 900ff688    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1002a4120: f946d100    	ldr	x0, [x8, #0xda0]
1002a4124: 900fdce8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1002a4128: f9469101    	ldr	x1, [x8, #0xd20] ; indexSet
1002a412c: 95e60c04    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4130: aa1d03fd    	mov	x29, x29
1002a4134: 95e60c05    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4138: aa0003f5    	mov	x21, x0
1002a413c: 4f00e400    	movi.16b	v0, #0x0
1002a4140: ad0083e0    	stp	q0, q0, [sp, #0x10]
1002a4144: ad0183e0    	stp	q0, q0, [sp, #0x30]
1002a4148: aa1303e0    	mov	x0, x19
1002a414c: 95e60bfb    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1002a4150: 900ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a4154: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1002a4158: 910043e2    	add	x2, sp, #0x10
1002a415c: 910143e3    	add	x3, sp, #0x50
1002a4160: aa1303f4    	mov	x20, x19
1002a4164: f90003e1    	str	x1, [sp]
1002a4168: 52800204    	mov	w4, #0x10               ; =16
1002a416c: 95e60bf4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4170: b4000660    	cbz	x0, 0x1002a423c <__text+0x29c23c>
1002a4174: aa0003f7    	mov	x23, x0
1002a4178: f94013e8    	ldr	x8, [sp, #0x20]
1002a417c: f9400116    	ldr	x22, [x8]
1002a4180: d2800013    	mov	x19, #0x0               ; =0
1002a4184: f00fdcc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002a4188: f9436518    	ldr	x24, [x8, #0x6c8] ; menuType
1002a418c: d00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a4190: f941b519    	ldr	x25, [x8, #0x368] ; containsIndex:
1002a4194: 900fdce8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1002a4198: f946951a    	ldr	x26, [x8, #0xd28] ; addIndex:
1002a419c: d00fdca8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1002a41a0: f943c51b    	ldr	x27, [x8, #0x788] ; safeAddObject:
1002a41a4: f94013e8    	ldr	x8, [sp, #0x20]
1002a41a8: f9400108    	ldr	x8, [x8]
1002a41ac: eb16011f    	cmp	x8, x22
1002a41b0: 54000060    	b.eq	0x1002a41bc <__text+0x29c1bc>
1002a41b4: aa1403e0    	mov	x0, x20
1002a41b8: 95e60be6    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1002a41bc: f9400fe8    	ldr	x8, [sp, #0x18]
1002a41c0: f873791c    	ldr	x28, [x8, x19, lsl #3]
1002a41c4: aa1c03e0    	mov	x0, x28
1002a41c8: aa1803e1    	mov	x1, x24
1002a41cc: 95e60bdc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a41d0: aa0003e2    	mov	x2, x0
1002a41d4: aa1503e0    	mov	x0, x21
1002a41d8: aa1903e1    	mov	x1, x25
1002a41dc: 95e60bd8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a41e0: 37000180    	tbnz	w0, #0x0, 0x1002a4210 <__text+0x29c210>
1002a41e4: aa1c03e0    	mov	x0, x28
1002a41e8: aa1803e1    	mov	x1, x24
1002a41ec: 95e60bd4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a41f0: aa0003e2    	mov	x2, x0
1002a41f4: aa1503e0    	mov	x0, x21
1002a41f8: aa1a03e1    	mov	x1, x26
1002a41fc: 95e60bd0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4200: f94007e0    	ldr	x0, [sp, #0x8]
1002a4204: aa1b03e1    	mov	x1, x27
1002a4208: aa1c03e2    	mov	x2, x28
1002a420c: 95e60bcc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4210: 91000673    	add	x19, x19, #0x1
1002a4214: eb1302ff    	cmp	x23, x19
1002a4218: 54fffc61    	b.ne	0x1002a41a4 <__text+0x29c1a4>
1002a421c: 910043e2    	add	x2, sp, #0x10
1002a4220: 910143e3    	add	x3, sp, #0x50
1002a4224: aa1403e0    	mov	x0, x20
1002a4228: f94003e1    	ldr	x1, [sp]
1002a422c: 52800204    	mov	w4, #0x10               ; =16
1002a4230: 95e60bc3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4234: aa0003f7    	mov	x23, x0
1002a4238: b5fffa40    	cbnz	x0, 0x1002a4180 <__text+0x29c180>
1002a423c: aa1403e0    	mov	x0, x20
1002a4240: 95e60bc5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4244: aa1503e0    	mov	x0, x21
1002a4248: 95e60bc3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a424c: aa1403e0    	mov	x0, x20
1002a4250: 95e60bc1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4254: f85a03a8    	ldur	x8, [x29, #-0x60]
1002a4258: f00e9a49    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1002a425c: f9405929    	ldr	x9, [x9, #0xb0]
1002a4260: f9400129    	ldr	x9, [x9]
1002a4264: eb08013f    	cmp	x9, x8
1002a4268: 54000141    	b.ne	0x1002a4290 <__text+0x29c290>
1002a426c: f94007e0    	ldr	x0, [sp, #0x8]
1002a4270: a9537bfd    	ldp	x29, x30, [sp, #0x130]
1002a4274: a9524ff4    	ldp	x20, x19, [sp, #0x120]
1002a4278: a95157f6    	ldp	x22, x21, [sp, #0x110]
1002a427c: a9505ff8    	ldp	x24, x23, [sp, #0x100]
1002a4280: a94f67fa    	ldp	x26, x25, [sp, #0xf0]
1002a4284: a94e6ffc    	ldp	x28, x27, [sp, #0xe0]
1002a4288: 910503ff    	add	sp, sp, #0x140
1002a428c: 15e60bb9    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
1002a4290: 95e60bb9    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>