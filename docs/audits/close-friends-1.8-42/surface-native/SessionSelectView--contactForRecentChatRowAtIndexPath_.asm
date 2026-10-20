
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1057f3f60: d10503ff    	sub	sp, sp, #0x140
1057f3f64: a90e6ffc    	stp	x28, x27, [sp, #0xe0]
1057f3f68: a90f67fa    	stp	x26, x25, [sp, #0xf0]
1057f3f6c: a9105ff8    	stp	x24, x23, [sp, #0x100]
1057f3f70: a91157f6    	stp	x22, x21, [sp, #0x110]
1057f3f74: a9124ff4    	stp	x20, x19, [sp, #0x120]
1057f3f78: a9137bfd    	stp	x29, x30, [sp, #0x130]
1057f3f7c: 9104c3fd    	add	x29, sp, #0x130
1057f3f80: aa0203f3    	mov	x19, x2
1057f3f84: aa0003f4    	mov	x20, x0
1057f3f88: 900befe8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1057f3f8c: f9405908    	ldr	x8, [x8, #0xb0]
1057f3f90: f9400108    	ldr	x8, [x8]
1057f3f94: f81a03a8    	stur	x8, [x29, #-0x60]
1057f3f98: d00da268    	adrp	x8, 0x120c41000 <dyld_stub_binder+0x120c41000>
1057f3f9c: 52800029    	mov	w9, #0x1                ; =1
1057f3fa0: 3913e509    	strb	w9, [x8, #0x4f9]
1057f3fa4: aa0203e0    	mov	x0, x2
1057f3fa8: 9490cc64    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057f3fac: d00d3de8    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057f3fb0: f944d501    	ldr	x1, [x8, #0x9a8] ; contactIndexForRecentChatRowAtIndexPath:
1057f3fb4: aa1403e0    	mov	x0, x20
1057f3fb8: aa1303e2    	mov	x2, x19
1057f3fbc: 9490cc60    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3fc0: aa0003f5    	mov	x21, x0
1057f3fc4: 900d51e8    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057f3fc8: b983c508    	ldrsw	x8, [x8, #0x3c4] ; ivar SessionSelectView.m_bMultiSelect
1057f3fcc: 38686a88    	ldrb	w8, [x20, x8]
1057f3fd0: 7100051f    	cmp	w8, #0x1
1057f3fd4: 540008e1    	b.ne	0x1057f40f0 <_Flutter_MMFoundation_BindContext+0x1ccfcd4>
1057f3fd8: b00d3588    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
1057f3fdc: f9401d01    	ldr	x1, [x8, #0x38] ; isFoldTopSession
1057f3fe0: aa1403e0    	mov	x0, x20
1057f3fe4: 9490cc56    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3fe8: 34000840    	cbz	w0, 0x1057f40f0 <_Flutter_MMFoundation_BindContext+0x1ccfcd4>
1057f3fec: b00d3248    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1057f3ff0: f9427d01    	ldr	x1, [x8, #0x4f8] ; section
1057f3ff4: aa1303e0    	mov	x0, x19
1057f3ff8: 9490cc51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3ffc: aa0003e2    	mov	x2, x0
1057f4000: b00d3de8    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057f4004: f944ed01    	ldr	x1, [x8, #0x9d8] ; isRecentChatTopSessionSection:
1057f4008: aa1403e0    	mov	x0, x20
1057f400c: 9490cc4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f4010: 34000700    	cbz	w0, 0x1057f40f0 <_Flutter_MMFoundation_BindContext+0x1ccfcd4>
1057f4014: 4f00e400    	movi.16b	v0, #0x0
1057f4018: ad0183e0    	stp	q0, q0, [sp, #0x30]
1057f401c: ad0083e0    	stp	q0, q0, [sp, #0x10]
1057f4020: f00d51c8    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057f4024: b983c908    	ldrsw	x8, [x8, #0x3c8] ; ivar SessionSelectView.m_arrContacts
1057f4028: f8686a96    	ldr	x22, [x20, x8]
1057f402c: aa1603e0    	mov	x0, x22
1057f4030: 9490cc42    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057f4034: 900d4868    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1057f4038: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1057f403c: 910043e2    	add	x2, sp, #0x10
1057f4040: 910143e3    	add	x3, sp, #0x50
1057f4044: f90007e1    	str	x1, [sp, #0x8]
1057f4048: 52800204    	mov	w4, #0x10               ; =16
1057f404c: 9490cc3c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f4050: b4000480    	cbz	x0, 0x1057f40e0 <_Flutter_MMFoundation_BindContext+0x1ccfcc4>
1057f4054: aa0003f8    	mov	x24, x0
1057f4058: 5280001b    	mov	w27, #0x0               ; =0
1057f405c: f94013e8    	ldr	x8, [sp, #0x20]
1057f4060: f940011c    	ldr	x28, [x8]
1057f4064: d00d3308    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
1057f4068: d2800017    	mov	x23, #0x0               ; =0
1057f406c: f9429919    	ldr	x25, [x8, #0x530] ; isSelected:
1057f4070: f94013e8    	ldr	x8, [sp, #0x20]
1057f4074: f9400108    	ldr	x8, [x8]
1057f4078: eb1c011f    	cmp	x8, x28
1057f407c: 54000060    	b.eq	0x1057f4088 <_Flutter_MMFoundation_BindContext+0x1ccfc6c>
1057f4080: aa1603e0    	mov	x0, x22
1057f4084: 9490cc33    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1057f4088: f9400fe8    	ldr	x8, [sp, #0x18]
1057f408c: f877791a    	ldr	x26, [x8, x23, lsl #3]
1057f4090: aa1403e0    	mov	x0, x20
1057f4094: aa1903e1    	mov	x1, x25
1057f4098: aa1a03e2    	mov	x2, x26
1057f409c: 9490cc28    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f40a0: 34000080    	cbz	w0, 0x1057f40b0 <_Flutter_MMFoundation_BindContext+0x1ccfc94>
1057f40a4: eb3bc2bf    	cmp	x21, w27, sxtw
1057f40a8: 540005a0    	b.eq	0x1057f415c <_Flutter_MMFoundation_BindContext+0x1ccfd40>
1057f40ac: 1100077b    	add	w27, w27, #0x1
1057f40b0: 910006f7    	add	x23, x23, #0x1
1057f40b4: eb17031f    	cmp	x24, x23
1057f40b8: 54fffdc1    	b.ne	0x1057f4070 <_Flutter_MMFoundation_BindContext+0x1ccfc54>
1057f40bc: 910043e2    	add	x2, sp, #0x10
1057f40c0: 910143e3    	add	x3, sp, #0x50
1057f40c4: aa1603e0    	mov	x0, x22
1057f40c8: f94007e1    	ldr	x1, [sp, #0x8]
1057f40cc: 52800204    	mov	w4, #0x10               ; =16
1057f40d0: 9490cc1b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f40d4: aa0003f8    	mov	x24, x0
1057f40d8: d00d3308    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
1057f40dc: b5fffc60    	cbnz	x0, 0x1057f4068 <_Flutter_MMFoundation_BindContext+0x1ccfc4c>
1057f40e0: aa1603e0    	mov	x0, x22
1057f40e4: 9490cc1c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f40e8: d280001a    	mov	x26, #0x0               ; =0
1057f40ec: 1400000b    	b	0x1057f4118 <_Flutter_MMFoundation_BindContext+0x1ccfcfc>
1057f40f0: f00d51c8    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057f40f4: b983c908    	ldrsw	x8, [x8, #0x3c8] ; ivar SessionSelectView.m_arrContacts
1057f40f8: f8686a80    	ldr	x0, [x20, x8]
1057f40fc: d00d3228    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1057f4100: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
1057f4104: aa1503e2    	mov	x2, x21
1057f4108: 9490cc0d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f410c: aa1d03fd    	mov	x29, x29
1057f4110: 9490cc0e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f4114: aa0003fa    	mov	x26, x0
1057f4118: aa1303e0    	mov	x0, x19
1057f411c: 9490cc0e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f4120: f85a03a8    	ldur	x8, [x29, #-0x60]
1057f4124: f00befc9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1057f4128: f9405929    	ldr	x9, [x9, #0xb0]
1057f412c: f9400129    	ldr	x9, [x9]
1057f4130: eb08013f    	cmp	x9, x8
1057f4134: 540001e1    	b.ne	0x1057f4170 <_Flutter_MMFoundation_BindContext+0x1ccfd54>
1057f4138: aa1a03e0    	mov	x0, x26
1057f413c: a9537bfd    	ldp	x29, x30, [sp, #0x130]
1057f4140: a9524ff4    	ldp	x20, x19, [sp, #0x120]
1057f4144: a95157f6    	ldp	x22, x21, [sp, #0x110]
1057f4148: a9505ff8    	ldp	x24, x23, [sp, #0x100]
1057f414c: a94f67fa    	ldp	x26, x25, [sp, #0xf0]
1057f4150: a94e6ffc    	ldp	x28, x27, [sp, #0xe0]
1057f4154: 910503ff    	add	sp, sp, #0x140
1057f4158: 1490cc06    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
1057f415c: aa1a03e0    	mov	x0, x26
1057f4160: 9490cbf6    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057f4164: aa1603e0    	mov	x0, x22
1057f4168: 9490cbfb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f416c: 17ffffeb    	b	0x1057f4118 <_Flutter_MMFoundation_BindContext+0x1ccfcfc>
1057f4170: 9490cc01    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
