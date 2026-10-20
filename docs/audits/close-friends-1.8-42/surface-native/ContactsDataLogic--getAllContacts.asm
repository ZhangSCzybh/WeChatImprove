
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010a6718: d10503ff    	sub	sp, sp, #0x140
1010a671c: a90e6ffc    	stp	x28, x27, [sp, #0xe0]
1010a6720: a90f67fa    	stp	x26, x25, [sp, #0xf0]
1010a6724: a9105ff8    	stp	x24, x23, [sp, #0x100]
1010a6728: a91157f6    	stp	x22, x21, [sp, #0x110]
1010a672c: a9124ff4    	stp	x20, x19, [sp, #0x120]
1010a6730: a9137bfd    	stp	x29, x30, [sp, #0x130]
1010a6734: 9104c3fd    	add	x29, sp, #0x130
1010a6738: aa0003f3    	mov	x19, x0
1010a673c: b00e2a48    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1010a6740: f9405908    	ldr	x8, [x8, #0xb0]
1010a6744: f9400108    	ldr	x8, [x8]
1010a6748: f81a03a8    	stur	x8, [x29, #-0x60]
1010a674c: d00fdc48    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
1010a6750: 52800029    	mov	w9, #0x1                ; =1
1010a6754: 393d0d09    	strb	w9, [x8, #0xf43]
1010a6758: b00f8668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1010a675c: f9455500    	ldr	x0, [x8, #0xaa8]
1010a6760: b00f82c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1010a6764: f941a101    	ldr	x1, [x8, #0x340] ; array
1010a6768: 95ae0275    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a676c: aa1d03fd    	mov	x29, x29
1010a6770: 95ae0276    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a6774: aa0003f4    	mov	x20, x0
1010a6778: 4f00e400    	movi.16b	v0, #0x0
1010a677c: ad0083e0    	stp	q0, q0, [sp, #0x10]
1010a6780: ad0183e0    	stp	q0, q0, [sp, #0x30]
1010a6784: 900f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a6788: b9860d1b    	ldrsw	x27, [x8, #0x60c] ; ivar ContactsDataLogic.m_dicAllContacts
1010a678c: f87b6a60    	ldr	x0, [x19, x27]
1010a6790: 900f82c8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1010a6794: f947f501    	ldr	x1, [x8, #0xfe8] ; allKeys
1010a6798: 95ae0269    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a679c: aa1d03fd    	mov	x29, x29
1010a67a0: 95ae026a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a67a4: aa0003f5    	mov	x21, x0
1010a67a8: d00f82c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1010a67ac: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1010a67b0: 910043e2    	add	x2, sp, #0x10
1010a67b4: 910143e3    	add	x3, sp, #0x50
1010a67b8: f90007e1    	str	x1, [sp, #0x8]
1010a67bc: 52800204    	mov	w4, #0x10               ; =16
1010a67c0: 95ae025f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a67c4: b4000500    	cbz	x0, 0x1010a6864 <__text+0x109e864>
1010a67c8: aa0003f7    	mov	x23, x0
1010a67cc: f94013e8    	ldr	x8, [sp, #0x20]
1010a67d0: f940011c    	ldr	x28, [x8]
1010a67d4: d2800016    	mov	x22, #0x0               ; =0
1010a67d8: d00f82e8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1010a67dc: f947f118    	ldr	x24, [x8, #0xfe0] ; objectForKey:
1010a67e0: 900f82c8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1010a67e4: f946f919    	ldr	x25, [x8, #0xdf0] ; addObjectsFromArray:
1010a67e8: f94013e8    	ldr	x8, [sp, #0x20]
1010a67ec: f9400108    	ldr	x8, [x8]
1010a67f0: eb1c011f    	cmp	x8, x28
1010a67f4: 54000060    	b.eq	0x1010a6800 <__text+0x109e800>
1010a67f8: aa1503e0    	mov	x0, x21
1010a67fc: 95ae0255    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1010a6800: f9400fe8    	ldr	x8, [sp, #0x18]
1010a6804: f8767902    	ldr	x2, [x8, x22, lsl #3]
1010a6808: f87b6a60    	ldr	x0, [x19, x27]
1010a680c: aa1803e1    	mov	x1, x24
1010a6810: 95ae024b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a6814: aa1d03fd    	mov	x29, x29
1010a6818: 95ae024c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a681c: aa0003fa    	mov	x26, x0
1010a6820: aa1403e0    	mov	x0, x20
1010a6824: aa1903e1    	mov	x1, x25
1010a6828: aa1a03e2    	mov	x2, x26
1010a682c: 95ae0244    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a6830: aa1a03e0    	mov	x0, x26
1010a6834: 95ae0248    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a6838: 910006d6    	add	x22, x22, #0x1
1010a683c: eb1602ff    	cmp	x23, x22
1010a6840: 54fffd41    	b.ne	0x1010a67e8 <__text+0x109e7e8>
1010a6844: 910043e2    	add	x2, sp, #0x10
1010a6848: 910143e3    	add	x3, sp, #0x50
1010a684c: aa1503e0    	mov	x0, x21
1010a6850: f94007e1    	ldr	x1, [sp, #0x8]
1010a6854: 52800204    	mov	w4, #0x10               ; =16
1010a6858: 95ae0239    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a685c: aa0003f7    	mov	x23, x0
1010a6860: b5fffba0    	cbnz	x0, 0x1010a67d4 <__text+0x109e7d4>
1010a6864: aa1503e0    	mov	x0, x21
1010a6868: 95ae023b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a686c: f85a03a8    	ldur	x8, [x29, #-0x60]
1010a6870: b00e2a49    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1010a6874: f9405929    	ldr	x9, [x9, #0xb0]
1010a6878: f9400129    	ldr	x9, [x9]
1010a687c: eb08013f    	cmp	x9, x8
1010a6880: 54000141    	b.ne	0x1010a68a8 <__text+0x109e8a8>
1010a6884: aa1403e0    	mov	x0, x20
1010a6888: a9537bfd    	ldp	x29, x30, [sp, #0x130]
1010a688c: a9524ff4    	ldp	x20, x19, [sp, #0x120]
1010a6890: a95157f6    	ldp	x22, x21, [sp, #0x110]
1010a6894: a9505ff8    	ldp	x24, x23, [sp, #0x100]
1010a6898: a94f67fa    	ldp	x26, x25, [sp, #0xf0]
1010a689c: a94e6ffc    	ldp	x28, x27, [sp, #0xe0]
1010a68a0: 910503ff    	add	sp, sp, #0x140
1010a68a4: 15ae0233    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
1010a68a8: 95ae0233    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
