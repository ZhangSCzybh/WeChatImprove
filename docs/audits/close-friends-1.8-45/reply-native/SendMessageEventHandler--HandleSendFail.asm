
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1057783e8: d10643ff    	sub	sp, sp, #0x190
1057783ec: a9136ffc    	stp	x28, x27, [sp, #0x130]
1057783f0: a91467fa    	stp	x26, x25, [sp, #0x140]
1057783f4: a9155ff8    	stp	x24, x23, [sp, #0x150]
1057783f8: a91657f6    	stp	x22, x21, [sp, #0x160]
1057783fc: a9174ff4    	stp	x20, x19, [sp, #0x170]
105778400: a9187bfd    	stp	x29, x30, [sp, #0x180]
105778404: 910603fd    	add	x29, sp, #0x180
105778408: aa0003f8    	mov	x24, x0
10577840c: f00bf3a8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
105778410: f9405908    	ldr	x8, [x8, #0xb0]
105778414: f9400108    	ldr	x8, [x8]
105778418: f81a03a8    	stur	x8, [x29, #-0x60]
10577841c: b00da648    	adrp	x8, 0x120c41000 <dyld_stub_binder+0x120c41000>
105778420: 52800029    	mov	w9, #0x1                ; =1
105778424: 390c3509    	strb	w9, [x8, #0x30d]
105778428: d00d55a8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
10577842c: b98cb519    	ldrsw	x25, [x8, #0xcb4]
105778430: f8796800    	ldr	x0, [x0, x25]
105778434: 900d4c48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105778438: f9435101    	ldr	x1, [x8, #0x6a0] ; count
10577843c: 9492bb40    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105778440: b4000fa0    	cbz	x0, 0x105778634 <_Flutter_MMFoundation_BindContext+0x1c54218>
105778444: 4f00e400    	movi.16b	v0, #0x0
105778448: ad0403e0    	stp	q0, q0, [sp, #0x80]
10577844c: ad0303e0    	stp	q0, q0, [sp, #0x60]
105778450: f8796b00    	ldr	x0, [x24, x25]
105778454: 9492bb39    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105778458: 900d4c48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10577845c: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
105778460: 910183e2    	add	x2, sp, #0x60
105778464: 910283e3    	add	x3, sp, #0xa0
105778468: a90003e1    	stp	x1, x0, [sp]
10577846c: 52800204    	mov	w4, #0x10               ; =16
105778470: 9492bb33    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105778474: f9001be0    	str	x0, [sp, #0x30]
105778478: b4000940    	cbz	x0, 0x1057785a0 <_Flutter_MMFoundation_BindContext+0x1c54184>
10577847c: f9403be8    	ldr	x8, [sp, #0x70]
105778480: f9400108    	ldr	x8, [x8]
105778484: f9000be8    	str	x8, [sp, #0x10]
105778488: d2800017    	mov	x23, #0x0               ; =0
10577848c: 900d4c68    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
105778490: f947f109    	ldr	x9, [x8, #0xfe0] ; objectForKey:
105778494: 900d3628    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105778498: f9454108    	ldr	x8, [x8, #0xa80] ; setM_uiStatus:
10577849c: a90227e8    	stp	x8, x9, [sp, #0x20]
1057784a0: f00d3608    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057784a4: f9450108    	ldr	x8, [x8, #0xa00] ; m_uiStatus
1057784a8: f9000fe8    	str	x8, [sp, #0x18]
1057784ac: f00d3628    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1057784b0: f940d91a    	ldr	x26, [x8, #0x1b0] ; m_nsToUsr
1057784b4: 900d3628    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1057784b8: f947d11b    	ldr	x27, [x8, #0xfa0] ; m_uiMesLocalID
1057784bc: 900d41c8    	adrp	x8, 0x11ffb0000 <dyld_stub_binder+0x11ffb0000>
1057784c0: f941ed1c    	ldr	x28, [x8, #0x3d8] ; UpdateMessageStatus:byChatName:localId:
1057784c4: f9403be8    	ldr	x8, [sp, #0x70]
1057784c8: f9400108    	ldr	x8, [x8]
1057784cc: f9400be9    	ldr	x9, [sp, #0x10]
1057784d0: eb09011f    	cmp	x8, x9
1057784d4: 54000060    	b.eq	0x1057784e0 <_Flutter_MMFoundation_BindContext+0x1c540c4>
1057784d8: f94007e0    	ldr	x0, [sp, #0x8]
1057784dc: 9492bb1d    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1057784e0: f94037e8    	ldr	x8, [sp, #0x68]
1057784e4: f8777902    	ldr	x2, [x8, x23, lsl #3]
1057784e8: f8796b00    	ldr	x0, [x24, x25]
1057784ec: f94017e1    	ldr	x1, [sp, #0x28]
1057784f0: 9492bb13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057784f4: aa1d03fd    	mov	x29, x29
1057784f8: 9492bb14    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057784fc: aa0003f5    	mov	x21, x0
105778500: f94013e1    	ldr	x1, [sp, #0x20]
105778504: 528000a2    	mov	w2, #0x5                ; =5
105778508: 9492bb0d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577850c: d00d55a8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
105778510: b98cbd08    	ldrsw	x8, [x8, #0xcbc]
105778514: f8686b14    	ldr	x20, [x24, x8]
105778518: aa1503e0    	mov	x0, x21
10577851c: f9400fe1    	ldr	x1, [sp, #0x18]
105778520: 9492bb07    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105778524: aa0003f6    	mov	x22, x0
105778528: aa1503e0    	mov	x0, x21
10577852c: aa1a03e1    	mov	x1, x26
105778530: 9492bb03    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105778534: aa1d03fd    	mov	x29, x29
105778538: 9492bb04    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10577853c: aa0003f3    	mov	x19, x0
105778540: aa1503e0    	mov	x0, x21
105778544: aa1b03e1    	mov	x1, x27
105778548: 9492bafd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577854c: aa0003e4    	mov	x4, x0
105778550: aa1403e0    	mov	x0, x20
105778554: aa1c03e1    	mov	x1, x28
105778558: aa1603e2    	mov	x2, x22
10577855c: aa1303e3    	mov	x3, x19
105778560: 9492baf7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105778564: aa1303e0    	mov	x0, x19
105778568: 9492bafb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577856c: aa1503e0    	mov	x0, x21
105778570: 9492baf9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105778574: 910006f7    	add	x23, x23, #0x1
105778578: f9401be8    	ldr	x8, [sp, #0x30]
10577857c: eb17011f    	cmp	x8, x23
105778580: 54fffa21    	b.ne	0x1057784c4 <_Flutter_MMFoundation_BindContext+0x1c540a8>
105778584: 910183e2    	add	x2, sp, #0x60
105778588: 910283e3    	add	x3, sp, #0xa0
10577858c: a94003e1    	ldp	x1, x0, [sp]
105778590: 52800204    	mov	w4, #0x10               ; =16
105778594: 9492baea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105778598: f9001be0    	str	x0, [sp, #0x30]
10577859c: b5fff760    	cbnz	x0, 0x105778488 <_Flutter_MMFoundation_BindContext+0x1c5406c>
1057785a0: f94007e0    	ldr	x0, [sp, #0x8]
1057785a4: 9492baec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057785a8: f00d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057785ac: f9455500    	ldr	x0, [x8, #0xaa8]
1057785b0: d00d55a8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
1057785b4: b98cb914    	ldrsw	x20, [x8, #0xcb8]
1057785b8: f8746b02    	ldr	x2, [x24, x20]
1057785bc: f00d4c28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1057785c0: f941b101    	ldr	x1, [x8, #0x360] ; arrayWithArray:
1057785c4: 9492bade    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057785c8: aa1d03fd    	mov	x29, x29
1057785cc: 9492badf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057785d0: aa0003f3    	mov	x19, x0
1057785d4: d00bf3a8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1057785d8: f947e108    	ldr	x8, [x8, #0xfc0]
1057785dc: f9001fe8    	str	x8, [sp, #0x38]
1057785e0: b009b048    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1057785e4: fd41c100    	ldr	d0, [x8, #0x380]
1057785e8: 90000008    	adrp	x8, 0x105778000 <_Flutter_MMFoundation_BindContext+0x1c53be4>
1057785ec: 9119c108    	add	x8, x8, #0x670
1057785f0: fd0023e0    	str	d0, [sp, #0x40]
1057785f4: d00bf3e9    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
1057785f8: 9115c129    	add	x9, x9, #0x570
1057785fc: a904a7e8    	stp	x8, x9, [sp, #0x48]
105778600: f9002fe0    	str	x0, [sp, #0x58]
105778604: f00bf3a0    	adrp	x0, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
105778608: f9408c00    	ldr	x0, [x0, #0x118]
10577860c: 9100e3e1    	add	x1, sp, #0x38
105778610: 94925304    	bl	0x107c0d220 <_Flutter_MMFoundation_BindContext+0x40e8e04>
105778614: f8796b00    	ldr	x0, [x24, x25]
105778618: f8396b1f    	str	xzr, [x24, x25]
10577861c: 9492bace    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105778620: f8746b00    	ldr	x0, [x24, x20]
105778624: f8346b1f    	str	xzr, [x24, x20]
105778628: 9492bacb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577862c: aa1303e0    	mov	x0, x19
105778630: 9492bac9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105778634: f85a03a8    	ldur	x8, [x29, #-0x60]
105778638: f00bf3a9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10577863c: f9405929    	ldr	x9, [x9, #0xb0]
105778640: f9400129    	ldr	x9, [x9]
105778644: eb08013f    	cmp	x9, x8
105778648: 54000121    	b.ne	0x10577866c <_Flutter_MMFoundation_BindContext+0x1c54250>
10577864c: a9587bfd    	ldp	x29, x30, [sp, #0x180]
105778650: a9574ff4    	ldp	x20, x19, [sp, #0x170]
105778654: a95657f6    	ldp	x22, x21, [sp, #0x160]
105778658: a9555ff8    	ldp	x24, x23, [sp, #0x150]
10577865c: a95467fa    	ldp	x26, x25, [sp, #0x140]
105778660: a9536ffc    	ldp	x28, x27, [sp, #0x130]
105778664: 910643ff    	add	sp, sp, #0x190
105778668: d65f03c0    	ret
10577866c: 9492bac2    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
