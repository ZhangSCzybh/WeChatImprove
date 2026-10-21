
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010a1088: d10503ff    	sub	sp, sp, #0x140
1010a108c: a90e6ffc    	stp	x28, x27, [sp, #0xe0]
1010a1090: a90f67fa    	stp	x26, x25, [sp, #0xf0]
1010a1094: a9105ff8    	stp	x24, x23, [sp, #0x100]
1010a1098: a91157f6    	stp	x22, x21, [sp, #0x110]
1010a109c: a9124ff4    	stp	x20, x19, [sp, #0x120]
1010a10a0: a9137bfd    	stp	x29, x30, [sp, #0x130]
1010a10a4: 9104c3fd    	add	x29, sp, #0x130
1010a10a8: aa0303f4    	mov	x20, x3
1010a10ac: aa0203f3    	mov	x19, x2
1010a10b0: f90007e0    	str	x0, [sp, #0x8]
1010a10b4: d00e2a68    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1010a10b8: f9405908    	ldr	x8, [x8, #0xb0]
1010a10bc: f9400108    	ldr	x8, [x8]
1010a10c0: f81a03a8    	stur	x8, [x29, #-0x60]
1010a10c4: f00fdc68    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
1010a10c8: 52800029    	mov	w9, #0x1                ; =1
1010a10cc: 393c9d09    	strb	w9, [x8, #0xf27]
1010a10d0: aa0203e0    	mov	x0, x2
1010a10d4: 95ae1819    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1010a10d8: 4f00e400    	movi.16b	v0, #0x0
1010a10dc: ad0183e0    	stp	q0, q0, [sp, #0x30]
1010a10e0: ad0083e0    	stp	q0, q0, [sp, #0x10]
1010a10e4: f00f82e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1010a10e8: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1010a10ec: 910043e2    	add	x2, sp, #0x10
1010a10f0: 910143e3    	add	x3, sp, #0x50
1010a10f4: aa1303e0    	mov	x0, x19
1010a10f8: f90003e1    	str	x1, [sp]
1010a10fc: 52800204    	mov	w4, #0x10               ; =16
1010a1100: 95ae180f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a1104: b4000620    	cbz	x0, 0x1010a11c8 <__text+0x10991c8>
1010a1108: aa0003f7    	mov	x23, x0
1010a110c: f94013e8    	ldr	x8, [sp, #0x20]
1010a1110: f9400116    	ldr	x22, [x8]
1010a1114: d2800015    	mov	x21, #0x0               ; =0
1010a1118: d00f8308    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1010a111c: f9454118    	ldr	x24, [x8, #0xa80] ; isValid
1010a1120: d00f6cc8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1010a1124: f947d119    	ldr	x25, [x8, #0xfa0] ; isChatroom
1010a1128: f00f6cc8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1010a112c: f944bd1a    	ldr	x26, [x8, #0x978] ; isOpenImChatroomAndUpgradeOpenIMChatroom
1010a1130: 900f6dc8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
1010a1134: f945611b    	ldr	x27, [x8, #0xac0] ; addContact:
1010a1138: f94013e8    	ldr	x8, [sp, #0x20]
1010a113c: f9400108    	ldr	x8, [x8]
1010a1140: eb16011f    	cmp	x8, x22
1010a1144: 54000060    	b.eq	0x1010a1150 <__text+0x1099150>
1010a1148: aa1303e0    	mov	x0, x19
1010a114c: 95ae1801    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1010a1150: f9400fe8    	ldr	x8, [sp, #0x18]
1010a1154: f875791c    	ldr	x28, [x8, x21, lsl #3]
1010a1158: aa1c03e0    	mov	x0, x28
1010a115c: aa1803e1    	mov	x1, x24
1010a1160: 95ae17f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a1164: 340001c0    	cbz	w0, 0x1010a119c <__text+0x109919c>
1010a1168: aa1c03e0    	mov	x0, x28
1010a116c: aa1903e1    	mov	x1, x25
1010a1170: 95ae17f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a1174: 34000140    	cbz	w0, 0x1010a119c <__text+0x109919c>
1010a1178: 340000b4    	cbz	w20, 0x1010a118c <__text+0x109918c>
1010a117c: aa1c03e0    	mov	x0, x28
1010a1180: aa1a03e1    	mov	x1, x26
1010a1184: 95ae17ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a1188: 370000a0    	tbnz	w0, #0x0, 0x1010a119c <__text+0x109919c>
1010a118c: f94007e0    	ldr	x0, [sp, #0x8]
1010a1190: aa1b03e1    	mov	x1, x27
1010a1194: aa1c03e2    	mov	x2, x28
1010a1198: 95ae17e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a119c: 910006b5    	add	x21, x21, #0x1
1010a11a0: eb1502ff    	cmp	x23, x21
1010a11a4: 54fffca1    	b.ne	0x1010a1138 <__text+0x1099138>
1010a11a8: 910043e2    	add	x2, sp, #0x10
1010a11ac: 910143e3    	add	x3, sp, #0x50
1010a11b0: aa1303e0    	mov	x0, x19
1010a11b4: f94003e1    	ldr	x1, [sp]
1010a11b8: 52800204    	mov	w4, #0x10               ; =16
1010a11bc: 95ae17e0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a11c0: aa0003f7    	mov	x23, x0
1010a11c4: b5fffa80    	cbnz	x0, 0x1010a1114 <__text+0x1099114>
1010a11c8: aa1303e0    	mov	x0, x19
1010a11cc: 95ae17e2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a11d0: f85a03a8    	ldur	x8, [x29, #-0x60]
1010a11d4: d00e2a69    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1010a11d8: f9405929    	ldr	x9, [x9, #0xb0]
1010a11dc: f9400129    	ldr	x9, [x9]
1010a11e0: eb08013f    	cmp	x9, x8
1010a11e4: 54000121    	b.ne	0x1010a1208 <__text+0x1099208>
1010a11e8: a9537bfd    	ldp	x29, x30, [sp, #0x130]
1010a11ec: a9524ff4    	ldp	x20, x19, [sp, #0x120]
1010a11f0: a95157f6    	ldp	x22, x21, [sp, #0x110]
1010a11f4: a9505ff8    	ldp	x24, x23, [sp, #0x100]
1010a11f8: a94f67fa    	ldp	x26, x25, [sp, #0xf0]
1010a11fc: a94e6ffc    	ldp	x28, x27, [sp, #0xe0]
1010a1200: 910503ff    	add	sp, sp, #0x140
1010a1204: d65f03c0    	ret
1010a1208: 95ae17db    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
