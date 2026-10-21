
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108ffd430: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
108ffd434: a90167fa    	stp	x26, x25, [sp, #0x10]
108ffd438: a9025ff8    	stp	x24, x23, [sp, #0x20]
108ffd43c: a90357f6    	stp	x22, x21, [sp, #0x30]
108ffd440: a9044ff4    	stp	x20, x19, [sp, #0x40]
108ffd444: a9057bfd    	stp	x29, x30, [sp, #0x50]
108ffd448: 910143fd    	add	x29, sp, #0x50
108ffd44c: d10743ff    	sub	sp, sp, #0x1d0
108ffd450: aa0203f3    	mov	x19, x2
108ffd454: aa0003f4    	mov	x20, x0
108ffd458: d00a2f88    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
108ffd45c: f9405908    	ldr	x8, [x8, #0xb0]
108ffd460: f9400108    	ldr	x8, [x8]
108ffd464: f81a03a8    	stur	x8, [x29, #-0x60]
108ffd468: 900be288    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
108ffd46c: 52800029    	mov	w9, #0x1                ; =1
108ffd470: 393a1d09    	strb	w9, [x8, #0xe87]
108ffd474: aa0203e0    	mov	x0, x2
108ffd478: 95a177f2    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108ffd47c: d00b8ba8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
108ffd480: f9453500    	ldr	x0, [x8, #0xa68]
108ffd484: 900b71e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
108ffd488: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
108ffd48c: f00aa4e8    	adrp	x8, 0x11e49c000 <dyld_stub_binder+0x11e49c000>
108ffd490: 9122a108    	add	x8, x8, #0x8a8
108ffd494: a9004fe8    	stp	x8, x19, [sp]
108ffd498: f00910e3    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
108ffd49c: 912b2863    	add	x3, x3, #0xaca
108ffd4a0: d0096125    	adrp	x5, 0x11bc23000 <dyld_stub_binder+0x11bc23000>
108ffd4a4: 9121c4a5    	add	x5, x5, #0x871
108ffd4a8: d0096127    	adrp	x7, 0x11bc23000 <dyld_stub_binder+0x11bc23000>
108ffd4ac: 9121fce7    	add	x7, x7, #0x87f
108ffd4b0: 52800022    	mov	w2, #0x1                ; =1
108ffd4b4: 52800004    	mov	w4, #0x0                ; =0
108ffd4b8: 52803886    	mov	w6, #0x1c4              ; =452
108ffd4bc: 95a177e2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd4c0: f00b9328    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108ffd4c4: b985c508    	ldrsw	x8, [x8, #0x5c4]
108ffd4c8: a901d3e8    	stp	x8, x20, [sp, #0x18]
108ffd4cc: f8686a80    	ldr	x0, [x20, x8]
108ffd4d0: b00b8808    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
108ffd4d4: f947f501    	ldr	x1, [x8, #0xfe8] ; allKeys
108ffd4d8: 95a177db    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd4dc: aa1d03fd    	mov	x29, x29
108ffd4e0: 95a177dc    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108ffd4e4: aa0003f5    	mov	x21, x0
108ffd4e8: 4f00e400    	movi.16b	v0, #0x0
108ffd4ec: ad0403e0    	stp	q0, q0, [sp, #0x80]
108ffd4f0: ad0503e0    	stp	q0, q0, [sp, #0xa0]
108ffd4f4: aa1303e0    	mov	x0, x19
108ffd4f8: 95a177d2    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108ffd4fc: f00b8808    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
108ffd500: f9435516    	ldr	x22, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
108ffd504: 910203e2    	add	x2, sp, #0x80
108ffd508: d10383a3    	sub	x3, x29, #0xe0
108ffd50c: f9000bf3    	str	x19, [sp, #0x10]
108ffd510: aa1603e1    	mov	x1, x22
108ffd514: 52800204    	mov	w4, #0x10               ; =16
108ffd518: 95a177cb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd51c: f9001fe0    	str	x0, [sp, #0x38]
108ffd520: b4000a00    	cbz	x0, 0x108ffd660 <_Flutter_MMFoundation_BindContext+0x54d9244>
108ffd524: f9404be8    	ldr	x8, [sp, #0x90]
108ffd528: f9400108    	ldr	x8, [x8]
108ffd52c: f9001be8    	str	x8, [sp, #0x30]
108ffd530: 92f00013    	mov	x19, #0x7fffffffffffffff ; =9223372036854775807
108ffd534: d2800018    	mov	x24, #0x0               ; =0
108ffd538: d00b71e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
108ffd53c: f9462108    	ldr	x8, [x8, #0xc40] ; safeRemoveObjectForKey:
108ffd540: f90017e8    	str	x8, [sp, #0x28]
108ffd544: f9404be8    	ldr	x8, [sp, #0x90]
108ffd548: f9400108    	ldr	x8, [x8]
108ffd54c: f9401be9    	ldr	x9, [sp, #0x30]
108ffd550: eb09011f    	cmp	x8, x9
108ffd554: 54000060    	b.eq	0x108ffd560 <_Flutter_MMFoundation_BindContext+0x54d9144>
108ffd558: f9400be0    	ldr	x0, [sp, #0x10]
108ffd55c: 95a177bf    	bl	0x10f85b458 <_UR_96F1_B25D+0x3a640c8>
108ffd560: f94047e8    	ldr	x8, [sp, #0x88]
108ffd564: f8787919    	ldr	x25, [x8, x24, lsl #3]
108ffd568: 4f00e400    	movi.16b	v0, #0x0
108ffd56c: ad0203e0    	stp	q0, q0, [sp, #0x40]
108ffd570: ad0303e0    	stp	q0, q0, [sp, #0x60]
108ffd574: aa1503e0    	mov	x0, x21
108ffd578: 95a177b2    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108ffd57c: 910103e2    	add	x2, sp, #0x40
108ffd580: 910303e3    	add	x3, sp, #0xc0
108ffd584: aa1603e1    	mov	x1, x22
108ffd588: 52800204    	mov	w4, #0x10               ; =16
108ffd58c: 95a177ae    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd590: b40004c0    	cbz	x0, 0x108ffd628 <_Flutter_MMFoundation_BindContext+0x54d920c>
108ffd594: aa0003fa    	mov	x26, x0
108ffd598: f9402be8    	ldr	x8, [sp, #0x50]
108ffd59c: f9400114    	ldr	x20, [x8]
108ffd5a0: d2800017    	mov	x23, #0x0               ; =0
108ffd5a4: 900b8848    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
108ffd5a8: f946611b    	ldr	x27, [x8, #0xcc0] ; rangeOfString:
108ffd5ac: f9402be8    	ldr	x8, [sp, #0x50]
108ffd5b0: f9400108    	ldr	x8, [x8]
108ffd5b4: eb14011f    	cmp	x8, x20
108ffd5b8: 54000060    	b.eq	0x108ffd5c4 <_Flutter_MMFoundation_BindContext+0x54d91a8>
108ffd5bc: aa1503e0    	mov	x0, x21
108ffd5c0: 95a177a6    	bl	0x10f85b458 <_UR_96F1_B25D+0x3a640c8>
108ffd5c4: f94027e8    	ldr	x8, [sp, #0x48]
108ffd5c8: f877791c    	ldr	x28, [x8, x23, lsl #3]
108ffd5cc: aa1c03e0    	mov	x0, x28
108ffd5d0: aa1b03e1    	mov	x1, x27
108ffd5d4: aa1903e2    	mov	x2, x25
108ffd5d8: 95a1779b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd5dc: eb13001f    	cmp	x0, x19
108ffd5e0: 540001a1    	b.ne	0x108ffd614 <_Flutter_MMFoundation_BindContext+0x54d91f8>
108ffd5e4: 910006f7    	add	x23, x23, #0x1
108ffd5e8: eb17035f    	cmp	x26, x23
108ffd5ec: 54fffe01    	b.ne	0x108ffd5ac <_Flutter_MMFoundation_BindContext+0x54d9190>
108ffd5f0: 910103e2    	add	x2, sp, #0x40
108ffd5f4: 910303e3    	add	x3, sp, #0xc0
108ffd5f8: aa1503e0    	mov	x0, x21
108ffd5fc: aa1603e1    	mov	x1, x22
108ffd600: 52800204    	mov	w4, #0x10               ; =16
108ffd604: 95a17790    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd608: aa0003fa    	mov	x26, x0
108ffd60c: b5fffca0    	cbnz	x0, 0x108ffd5a0 <_Flutter_MMFoundation_BindContext+0x54d9184>
108ffd610: 14000006    	b	0x108ffd628 <_Flutter_MMFoundation_BindContext+0x54d920c>
108ffd614: a941a3e9    	ldp	x9, x8, [sp, #0x18]
108ffd618: f8696900    	ldr	x0, [x8, x9]
108ffd61c: f94017e1    	ldr	x1, [sp, #0x28]
108ffd620: aa1c03e2    	mov	x2, x28
108ffd624: 95a17788    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd628: aa1503e0    	mov	x0, x21
108ffd62c: 95a1778c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ffd630: 91000718    	add	x24, x24, #0x1
108ffd634: f9401fe8    	ldr	x8, [sp, #0x38]
108ffd638: eb08031f    	cmp	x24, x8
108ffd63c: 54fff841    	b.ne	0x108ffd544 <_Flutter_MMFoundation_BindContext+0x54d9128>
108ffd640: 910203e2    	add	x2, sp, #0x80
108ffd644: d10383a3    	sub	x3, x29, #0xe0
108ffd648: f9400be0    	ldr	x0, [sp, #0x10]
108ffd64c: aa1603e1    	mov	x1, x22
108ffd650: 52800204    	mov	w4, #0x10               ; =16
108ffd654: 95a1777c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd658: f9001fe0    	str	x0, [sp, #0x38]
108ffd65c: b5fff6c0    	cbnz	x0, 0x108ffd534 <_Flutter_MMFoundation_BindContext+0x54d9118>
108ffd660: f9400bf3    	ldr	x19, [sp, #0x10]
108ffd664: aa1303e0    	mov	x0, x19
108ffd668: 95a1777d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ffd66c: f00b8808    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
108ffd670: f9435101    	ldr	x1, [x8, #0x6a0] ; count
108ffd674: aa1303e0    	mov	x0, x19
108ffd678: 95a17773    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd67c: aa1503e0    	mov	x0, x21
108ffd680: 95a17777    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ffd684: aa1303e0    	mov	x0, x19
108ffd688: 95a17775    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ffd68c: f85a03a8    	ldur	x8, [x29, #-0x60]
108ffd690: d00a2f89    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
108ffd694: f9405929    	ldr	x9, [x9, #0xb0]
108ffd698: f9400129    	ldr	x9, [x9]
108ffd69c: eb08013f    	cmp	x9, x8
108ffd6a0: 54000121    	b.ne	0x108ffd6c4 <_Flutter_MMFoundation_BindContext+0x54d92a8>
108ffd6a4: 910743ff    	add	sp, sp, #0x1d0
108ffd6a8: a9457bfd    	ldp	x29, x30, [sp, #0x50]
108ffd6ac: a9444ff4    	ldp	x20, x19, [sp, #0x40]
108ffd6b0: a94357f6    	ldp	x22, x21, [sp, #0x30]
108ffd6b4: a9425ff8    	ldp	x24, x23, [sp, #0x20]
108ffd6b8: a94167fa    	ldp	x26, x25, [sp, #0x10]
108ffd6bc: a8c66ffc    	ldp	x28, x27, [sp], #0x60
108ffd6c0: d65f03c0    	ret
108ffd6c4: 95a1776e    	bl	0x10f85b47c <_UR_96F1_B25D+0x3a640ec>
