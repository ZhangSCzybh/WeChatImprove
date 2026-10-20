
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1057e43c8: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
1057e43cc: a90167fa    	stp	x26, x25, [sp, #0x10]
1057e43d0: a9025ff8    	stp	x24, x23, [sp, #0x20]
1057e43d4: a90357f6    	stp	x22, x21, [sp, #0x30]
1057e43d8: a9044ff4    	stp	x20, x19, [sp, #0x40]
1057e43dc: a9057bfd    	stp	x29, x30, [sp, #0x50]
1057e43e0: 910143fd    	add	x29, sp, #0x50
1057e43e4: d10883ff    	sub	sp, sp, #0x220
1057e43e8: aa0003f4    	mov	x20, x0
1057e43ec: f00bf048    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1057e43f0: f9405908    	ldr	x8, [x8, #0xb0]
1057e43f4: f9400108    	ldr	x8, [x8]
1057e43f8: f81a03a8    	stur	x8, [x29, #-0x60]
1057e43fc: b00da2e8    	adrp	x8, 0x120c41000 <dyld_stub_binder+0x120c41000>
1057e4400: 52800029    	mov	w9, #0x1                ; =1
1057e4404: 39130d09    	strb	w9, [x8, #0x4c3]
1057e4408: f00d5248    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057e440c: b983bd13    	ldrsw	x19, [x8, #0x3bc] ; ivar SessionSelectView._taskKey
1057e4410: f8736808    	ldr	x8, [x0, x19]
1057e4414: b5000408    	cbnz	x8, 0x1057e4494 <_Flutter_MMFoundation_BindContext+0x1cc0078>
1057e4418: f00d4c68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057e441c: f9454500    	ldr	x0, [x8, #0xa88]
1057e4420: d00d4928    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1057e4424: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
1057e4428: f90003f4    	str	x20, [sp]
1057e442c: 900c8182    	adrp	x2, 0x11e814000 <dyld_stub_binder+0x11e814000>
1057e4430: 910c2042    	add	x2, x2, #0x308
1057e4434: 94910b42    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4438: aa1d03fd    	mov	x29, x29
1057e443c: 94910b43    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4440: f8736a88    	ldr	x8, [x20, x19]
1057e4444: f8336a80    	str	x0, [x20, x19]
1057e4448: aa0803e0    	mov	x0, x8
1057e444c: 94910b42    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4450: f00d5248    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057e4454: b983d508    	ldrsw	x8, [x8, #0x3d4] ; ivar SessionSelectView.m_onlySelectSingleWeixChat
1057e4458: 38686a88    	ldrb	w8, [x20, x8]
1057e445c: 370001c8    	tbnz	w8, #0x0, 0x1057e4494 <_Flutter_MMFoundation_BindContext+0x1cc0078>
1057e4460: 900d4cc8    	adrp	x8, 0x12017c000 <dyld_stub_binder+0x12017c000>
1057e4464: f940f900    	ldr	x0, [x8, #0x1f0]
1057e4468: 94910b3e    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1057e446c: f00d3328    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
1057e4470: f9450901    	ldr	x1, [x8, #0xa10] ; initWithType:
1057e4474: 52800062    	mov	w2, #0x3                ; =3
1057e4478: 94910b31    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e447c: f00d5248    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057e4480: b983c109    	ldrsw	x9, [x8, #0x3c0] ; ivar SessionSelectView._ftsTopHitMgr
1057e4484: f8696a88    	ldr	x8, [x20, x9]
1057e4488: f8296a80    	str	x0, [x20, x9]
1057e448c: aa0803e0    	mov	x0, x8
1057e4490: 94910b31    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4494: d00d3528    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1057e4498: f9421501    	ldr	x1, [x8, #0x428] ; messageSearchLogic
1057e449c: aa1403e0    	mov	x0, x20
1057e44a0: 94910b27    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e44a4: aa1d03fd    	mov	x29, x29
1057e44a8: 94910b28    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e44ac: aa0003f3    	mov	x19, x0
1057e44b0: b5000340    	cbnz	x0, 0x1057e4518 <_Flutter_MMFoundation_BindContext+0x1cc00fc>
1057e44b4: 900d3488    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
1057e44b8: f9466501    	ldr	x1, [x8, #0xcc8] ; m_commonSearchScene
1057e44bc: aa1403e0    	mov	x0, x20
1057e44c0: 94910b1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e44c4: f100201f    	cmp	x0, #0x8
1057e44c8: 54000281    	b.ne	0x1057e4518 <_Flutter_MMFoundation_BindContext+0x1cc00fc>
1057e44cc: 900d4c88    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1057e44d0: f9401100    	ldr	x0, [x8, #0x20]
1057e44d4: b00d3d68    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
1057e44d8: f947c501    	ldr	x1, [x8, #0xf88] ; getMultiSelectContactsMessageSearchOpenSwitch
1057e44dc: 94910b18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e44e0: 34000200    	cbz	w0, 0x1057e4520 <_Flutter_MMFoundation_BindContext+0x1cc0104>
1057e44e4: d00d4d88    	adrp	x8, 0x120196000 <dyld_stub_binder+0x120196000>
1057e44e8: f9445900    	ldr	x0, [x8, #0x8b0]
1057e44ec: 94910b1d    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1057e44f0: 900d32c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1057e44f4: f942a101    	ldr	x1, [x8, #0x540] ; initWithDelegate:
1057e44f8: aa1403e2    	mov	x2, x20
1057e44fc: 94910b10    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4500: aa0003f3    	mov	x19, x0
1057e4504: d00d3528    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1057e4508: f9422101    	ldr	x1, [x8, #0x440] ; setMessageSearchLogic:
1057e450c: aa1403e0    	mov	x0, x20
1057e4510: aa1303e2    	mov	x2, x19
1057e4514: 94910b0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4518: aa1303e0    	mov	x0, x19
1057e451c: 94910b0e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4520: f00d4c73    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
1057e4524: f9455660    	ldr	x0, [x19, #0xaa8]
1057e4528: 94910b0c    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1057e452c: f00d5248    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057e4530: b983d916    	ldrsw	x22, [x8, #0x3d8] ; ivar SessionSelectView.m_specialCellList
1057e4534: f8766a88    	ldr	x8, [x20, x22]
1057e4538: f8366a80    	str	x0, [x20, x22]
1057e453c: aa0803e0    	mov	x0, x8
1057e4540: 94910b05    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4544: f00d5248    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057e4548: b983c915    	ldrsw	x21, [x8, #0x3c8] ; ivar SessionSelectView.m_arrContacts
1057e454c: f8756a88    	ldr	x8, [x20, x21]
1057e4550: b4000248    	cbz	x8, 0x1057e4598 <_Flutter_MMFoundation_BindContext+0x1cc017c>
1057e4554: f85a03a8    	ldur	x8, [x29, #-0x60]
1057e4558: f00bf049    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1057e455c: f9405929    	ldr	x9, [x9, #0xb0]
1057e4560: f9400129    	ldr	x9, [x9]
1057e4564: eb08013f    	cmp	x9, x8
1057e4568: 54003f81    	b.ne	0x1057e4d58 <_Flutter_MMFoundation_BindContext+0x1cc093c>
1057e456c: b00d3e68    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057e4570: f9441901    	ldr	x1, [x8, #0x830] ; initSectionTypes
1057e4574: aa1403e0    	mov	x0, x20
1057e4578: 910883ff    	add	sp, sp, #0x220
1057e457c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1057e4580: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1057e4584: a94357f6    	ldp	x22, x21, [sp, #0x30]
1057e4588: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1057e458c: a94167fa    	ldp	x26, x25, [sp, #0x10]
1057e4590: a8c66ffc    	ldp	x28, x27, [sp], #0x60
1057e4594: 14910aea    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4598: f9001ff6    	str	x22, [sp, #0x38]
1057e459c: f9455660    	ldr	x0, [x19, #0xaa8]
1057e45a0: 94910aee    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1057e45a4: f8756a88    	ldr	x8, [x20, x21]
1057e45a8: f9002ff4    	str	x20, [sp, #0x58]
1057e45ac: f9000ff5    	str	x21, [sp, #0x18]
1057e45b0: f8356a80    	str	x0, [x20, x21]
1057e45b4: aa0803e0    	mov	x0, x8
1057e45b8: 94910ae7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e45bc: f00d4c68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057e45c0: f945e900    	ldr	x0, [x8, #0xbd0]
1057e45c4: 900d48e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1057e45c8: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1057e45cc: f90047e1    	str	x1, [sp, #0x88]
1057e45d0: 94910adb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e45d4: aa1d03fd    	mov	x29, x29
1057e45d8: 94910adc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e45dc: aa0003f3    	mov	x19, x0
1057e45e0: 900d4c88    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1057e45e4: f9401500    	ldr	x0, [x8, #0x28] ; P;,
1057e45e8: f00d48c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1057e45ec: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1057e45f0: f90043e1    	str	x1, [sp, #0x80]
1057e45f4: 94910ad2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e45f8: aa0003e2    	mov	x2, x0
1057e45fc: b00d32a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1057e4600: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
1057e4604: aa1303e0    	mov	x0, x19
1057e4608: f9003fe1    	str	x1, [sp, #0x78]
1057e460c: 94910acc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4610: aa1d03fd    	mov	x29, x29
1057e4614: 94910acd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4618: aa0003f4    	mov	x20, x0
1057e461c: aa1303e0    	mov	x0, x19
1057e4620: 94910acd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4624: f00d3328    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
1057e4628: f9437501    	ldr	x1, [x8, #0x6e8] ; getAllBrandContacts
1057e462c: f90017f4    	str	x20, [sp, #0x28]
1057e4630: aa1403e0    	mov	x0, x20
1057e4634: 94910ac2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4638: aa1d03fd    	mov	x29, x29
1057e463c: 94910ac3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4640: aa0003fb    	mov	x27, x0
1057e4644: 4f00e400    	movi.16b	v0, #0x0
1057e4648: ad0683e0    	stp	q0, q0, [sp, #0xd0]
1057e464c: ad0783e0    	stp	q0, q0, [sp, #0xf0]
1057e4650: 900d48e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1057e4654: f943551c    	ldr	x28, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1057e4658: 910343e2    	add	x2, sp, #0xd0
1057e465c: d10383a3    	sub	x3, x29, #0xe0
1057e4660: aa1c03e1    	mov	x1, x28
1057e4664: 52800204    	mov	w4, #0x10               ; =16
1057e4668: 94910ab5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e466c: f9003bfb    	str	x27, [sp, #0x70]
1057e4670: b4000e00    	cbz	x0, 0x1057e4830 <_Flutter_MMFoundation_BindContext+0x1cc0414>
1057e4674: aa0003fa    	mov	x26, x0
1057e4678: f94073e8    	ldr	x8, [sp, #0xe0]
1057e467c: f9400118    	ldr	x24, [x8]
1057e4680: f9001bfc    	str	x28, [sp, #0x30]
1057e4684: d280001c    	mov	x28, #0x0               ; =0
1057e4688: f00d32a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057e468c: f9434d14    	ldr	x20, [x8, #0x698] ; m_nsUsrName
1057e4690: f00d3328    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
1057e4694: f940811b    	ldr	x27, [x8, #0x100] ; isInContactList:
1057e4698: f00d3328    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
1057e469c: f9435909    	ldr	x9, [x8, #0x6b0] ; isEnterpriseBrand
1057e46a0: 900d33e8    	adrp	x8, 0x11fe60000 <dyld_stub_binder+0x11fe60000>
1057e46a4: f9468d08    	ldr	x8, [x8, #0xd18] ; isEnterpriseChatSubBrand
1057e46a8: a90627e8    	stp	x8, x9, [sp, #0x60]
1057e46ac: b00d3e68    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057e46b0: f9441d09    	ldr	x9, [x8, #0x838] ; setM_cellType:
1057e46b4: b00d3e68    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057e46b8: f9442108    	ldr	x8, [x8, #0x840] ; setM_Contact:
1057e46bc: a904a7e8    	stp	x8, x9, [sp, #0x48]
1057e46c0: d00d32a8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1057e46c4: f943c508    	ldr	x8, [x8, #0x788] ; safeAddObject:
1057e46c8: f90023e8    	str	x8, [sp, #0x40]
1057e46cc: f94073e8    	ldr	x8, [sp, #0xe0]
1057e46d0: f9400108    	ldr	x8, [x8]
1057e46d4: eb18011f    	cmp	x8, x24
1057e46d8: 54000060    	b.eq	0x1057e46e4 <_Flutter_MMFoundation_BindContext+0x1cc02c8>
1057e46dc: f9403be0    	ldr	x0, [sp, #0x70]
1057e46e0: 94910a9c    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1057e46e4: f9406fe8    	ldr	x8, [sp, #0xd8]
1057e46e8: f87c7913    	ldr	x19, [x8, x28, lsl #3]
1057e46ec: f00d4c68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057e46f0: f945e900    	ldr	x0, [x8, #0xbd0]
1057e46f4: f94047e1    	ldr	x1, [sp, #0x88]
1057e46f8: 94910a91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e46fc: aa1d03fd    	mov	x29, x29
1057e4700: 94910a92    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4704: aa0003f5    	mov	x21, x0
1057e4708: 900d4c88    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1057e470c: f9401500    	ldr	x0, [x8, #0x28] ; P;,
1057e4710: f94043e1    	ldr	x1, [sp, #0x80]
1057e4714: 94910a8a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4718: aa0003e2    	mov	x2, x0
1057e471c: aa1503e0    	mov	x0, x21
1057e4720: f9403fe1    	ldr	x1, [sp, #0x78]
1057e4724: 94910a86    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4728: aa1d03fd    	mov	x29, x29
1057e472c: 94910a87    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4730: aa0003f9    	mov	x25, x0
1057e4734: aa1303e0    	mov	x0, x19
1057e4738: aa1403e1    	mov	x1, x20
1057e473c: 94910a80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4740: aa1d03fd    	mov	x29, x29
1057e4744: 94910a81    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4748: aa0003f6    	mov	x22, x0
1057e474c: aa1903e0    	mov	x0, x25
1057e4750: aa1b03e1    	mov	x1, x27
1057e4754: aa1603e2    	mov	x2, x22
1057e4758: 94910a79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e475c: aa0003f7    	mov	x23, x0
1057e4760: aa1603e0    	mov	x0, x22
1057e4764: 94910a7c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4768: aa1903e0    	mov	x0, x25
1057e476c: 94910a7a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4770: aa1503e0    	mov	x0, x21
1057e4774: 94910a78    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4778: 34000437    	cbz	w23, 0x1057e47fc <_Flutter_MMFoundation_BindContext+0x1cc03e0>
1057e477c: aa1303e0    	mov	x0, x19
1057e4780: f94037e1    	ldr	x1, [sp, #0x68]
1057e4784: 94910a6e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4788: 340003a0    	cbz	w0, 0x1057e47fc <_Flutter_MMFoundation_BindContext+0x1cc03e0>
1057e478c: aa1303e0    	mov	x0, x19
1057e4790: f94033e1    	ldr	x1, [sp, #0x60]
1057e4794: 94910a6a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4798: 34000320    	cbz	w0, 0x1057e47fc <_Flutter_MMFoundation_BindContext+0x1cc03e0>
1057e479c: f00d5248    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057e47a0: b983dd08    	ldrsw	x8, [x8, #0x3dc] ; ivar SessionSelectView.m_bShowEnterpriseChat
1057e47a4: f9402fe9    	ldr	x9, [sp, #0x58]
1057e47a8: 38686928    	ldrb	w8, [x9, x8]
1057e47ac: 7100051f    	cmp	w8, #0x1
1057e47b0: 54000261    	b.ne	0x1057e47fc <_Flutter_MMFoundation_BindContext+0x1cc03e0>
1057e47b4: d00d4d88    	adrp	x8, 0x120196000 <dyld_stub_binder+0x120196000>
1057e47b8: f9445d00    	ldr	x0, [x8, #0x8b8]
1057e47bc: 94910a67    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1057e47c0: aa0003f5    	mov	x21, x0
1057e47c4: f9402be1    	ldr	x1, [sp, #0x50]
1057e47c8: 52800022    	mov	w2, #0x1                ; =1
1057e47cc: 94910a5c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e47d0: aa1503e0    	mov	x0, x21
1057e47d4: f94027e1    	ldr	x1, [sp, #0x48]
1057e47d8: aa1303e2    	mov	x2, x19
1057e47dc: 94910a58    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e47e0: f9402fe8    	ldr	x8, [sp, #0x58]
1057e47e4: a94387e9    	ldp	x9, x1, [sp, #0x38]
1057e47e8: f8696900    	ldr	x0, [x8, x9]
1057e47ec: aa1503e2    	mov	x2, x21
1057e47f0: 94910a53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e47f4: aa1503e0    	mov	x0, x21
1057e47f8: 94910a57    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e47fc: 9100079c    	add	x28, x28, #0x1
1057e4800: eb1c035f    	cmp	x26, x28
1057e4804: 54fff641    	b.ne	0x1057e46cc <_Flutter_MMFoundation_BindContext+0x1cc02b0>
1057e4808: 910343e2    	add	x2, sp, #0xd0
1057e480c: d10383a3    	sub	x3, x29, #0xe0
1057e4810: f9403bfb    	ldr	x27, [sp, #0x70]
1057e4814: aa1b03e0    	mov	x0, x27
1057e4818: f9401bfc    	ldr	x28, [sp, #0x30]
1057e481c: aa1c03e1    	mov	x1, x28
1057e4820: 52800204    	mov	w4, #0x10               ; =16
1057e4824: 94910a46    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4828: aa0003fa    	mov	x26, x0
1057e482c: b5fff2c0    	cbnz	x0, 0x1057e4684 <_Flutter_MMFoundation_BindContext+0x1cc0268>
1057e4830: 4f00e400    	movi.16b	v0, #0x0
1057e4834: ad0583e0    	stp	q0, q0, [sp, #0xb0]
1057e4838: ad0483e0    	stp	q0, q0, [sp, #0x90]
1057e483c: aa1b03e0    	mov	x0, x27
1057e4840: 94910a3e    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057e4844: 910243e2    	add	x2, sp, #0x90
1057e4848: 910443e3    	add	x3, sp, #0x110
1057e484c: aa1c03e1    	mov	x1, x28
1057e4850: 52800204    	mov	w4, #0x10               ; =16
1057e4854: 94910a3a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4858: b40007c0    	cbz	x0, 0x1057e4950 <_Flutter_MMFoundation_BindContext+0x1cc0534>
1057e485c: aa0003f3    	mov	x19, x0
1057e4860: f94053e8    	ldr	x8, [sp, #0xa0]
1057e4864: f9400118    	ldr	x24, [x8]
1057e4868: d280001a    	mov	x26, #0x0               ; =0
1057e486c: f00d32a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057e4870: f9434d14    	ldr	x20, [x8, #0x698] ; m_nsUsrName
1057e4874: f00d3328    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
1057e4878: f9408119    	ldr	x25, [x8, #0x100] ; isInContactList:
1057e487c: f94053e8    	ldr	x8, [sp, #0xa0]
1057e4880: f9400108    	ldr	x8, [x8]
1057e4884: eb18011f    	cmp	x8, x24
1057e4888: 54000060    	b.eq	0x1057e4894 <_Flutter_MMFoundation_BindContext+0x1cc0478>
1057e488c: aa1b03e0    	mov	x0, x27
1057e4890: 94910a30    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1057e4894: f9404fe8    	ldr	x8, [sp, #0x98]
1057e4898: f87a7915    	ldr	x21, [x8, x26, lsl #3]
1057e489c: f00d4c68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057e48a0: f945e900    	ldr	x0, [x8, #0xbd0]
1057e48a4: f94047e1    	ldr	x1, [sp, #0x88]
1057e48a8: 94910a25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e48ac: aa1d03fd    	mov	x29, x29
1057e48b0: 94910a26    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e48b4: aa0003f6    	mov	x22, x0
1057e48b8: 900d4c88    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1057e48bc: f9401500    	ldr	x0, [x8, #0x28] ; P;,
1057e48c0: f94043e1    	ldr	x1, [sp, #0x80]
1057e48c4: 94910a1e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e48c8: aa0003e2    	mov	x2, x0
1057e48cc: aa1603e0    	mov	x0, x22
1057e48d0: f9403fe1    	ldr	x1, [sp, #0x78]
1057e48d4: 94910a1a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e48d8: aa1d03fd    	mov	x29, x29
1057e48dc: 94910a1b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e48e0: aa0003f7    	mov	x23, x0
1057e48e4: aa1503e0    	mov	x0, x21
1057e48e8: aa1403e1    	mov	x1, x20
1057e48ec: 94910a14    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e48f0: aa1d03fd    	mov	x29, x29
1057e48f4: 94910a15    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e48f8: aa0003f5    	mov	x21, x0
1057e48fc: aa1703e0    	mov	x0, x23
1057e4900: aa1903e1    	mov	x1, x25
1057e4904: aa1503e2    	mov	x2, x21
1057e4908: 94910a0d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e490c: aa1503e0    	mov	x0, x21
1057e4910: 94910a11    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4914: aa1703e0    	mov	x0, x23
1057e4918: 94910a0f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e491c: aa1603e0    	mov	x0, x22
1057e4920: 94910a0d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4924: 9100075a    	add	x26, x26, #0x1
1057e4928: eb1a027f    	cmp	x19, x26
1057e492c: 54fffa81    	b.ne	0x1057e487c <_Flutter_MMFoundation_BindContext+0x1cc0460>
1057e4930: 910243e2    	add	x2, sp, #0x90
1057e4934: 910443e3    	add	x3, sp, #0x110
1057e4938: aa1b03e0    	mov	x0, x27
1057e493c: aa1c03e1    	mov	x1, x28
1057e4940: 52800204    	mov	w4, #0x10               ; =16
1057e4944: 949109fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4948: aa0003f3    	mov	x19, x0
1057e494c: b5fff8e0    	cbnz	x0, 0x1057e4868 <_Flutter_MMFoundation_BindContext+0x1cc044c>
1057e4950: aa1b03e0    	mov	x0, x27
1057e4954: 94910a00    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4958: f00d4c68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057e495c: f945e900    	ldr	x0, [x8, #0xbd0]
1057e4960: f94047e1    	ldr	x1, [sp, #0x88]
1057e4964: 949109f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4968: aa1d03fd    	mov	x29, x29
1057e496c: 949109f7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4970: aa0003f3    	mov	x19, x0
1057e4974: 900d4c88    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1057e4978: f941bd00    	ldr	x0, [x8, #0x378]
1057e497c: f94043e1    	ldr	x1, [sp, #0x80]
1057e4980: 949109ef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4984: aa0003e2    	mov	x2, x0
1057e4988: aa1303e0    	mov	x0, x19
1057e498c: f9403fe1    	ldr	x1, [sp, #0x78]
1057e4990: 949109eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4994: aa1d03fd    	mov	x29, x29
1057e4998: 949109ec    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e499c: aa0003f4    	mov	x20, x0
1057e49a0: 900d3428    	adrp	x8, 0x11fe68000 <dyld_stub_binder+0x11fe68000>
1057e49a4: f9477901    	ldr	x1, [x8, #0xef0] ; forwardableSessionEnumerator
1057e49a8: 949109e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e49ac: aa1d03fd    	mov	x29, x29
1057e49b0: 949109e6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e49b4: aa0003f5    	mov	x21, x0
1057e49b8: aa1403e0    	mov	x0, x20
1057e49bc: 949109e6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e49c0: aa1303e0    	mov	x0, x19
1057e49c4: 949109e4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e49c8: 900d4908    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1057e49cc: f9465d1b    	ldr	x27, [x8, #0xcb8] ; nextObject
1057e49d0: aa1503f6    	mov	x22, x21
1057e49d4: aa1503e0    	mov	x0, x21
1057e49d8: aa1b03e1    	mov	x1, x27
1057e49dc: 949109d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e49e0: aa1d03fd    	mov	x29, x29
1057e49e4: 949109d9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e49e8: b4000de0    	cbz	x0, 0x1057e4ba4 <_Flutter_MMFoundation_BindContext+0x1cc0788>
1057e49ec: aa0003f4    	mov	x20, x0
1057e49f0: f9001bff    	str	xzr, [sp, #0x30]
1057e49f4: b00d3328    	adrp	x8, 0x11fe49000 <dyld_stub_binder+0x11fe49000>
1057e49f8: f946251c    	ldr	x28, [x8, #0xc48] ; m_extendFields
1057e49fc: 900d3428    	adrp	x8, 0x11fe68000 <dyld_stub_binder+0x11fe68000>
1057e4a00: f9477d1a    	ldr	x26, [x8, #0xef8] ; m_isHidden
1057e4a04: 900d3308    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
1057e4a08: f947d909    	ldr	x9, [x8, #0xfb0] ; m_nsUserName
1057e4a0c: 900d32c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1057e4a10: f940c908    	ldr	x8, [x8, #0x190] ; getContactByName:
1057e4a14: a90627e8    	stp	x8, x9, [sp, #0x60]
1057e4a18: f00d32a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057e4a1c: f9434d09    	ldr	x9, [x8, #0x698] ; m_nsUsrName
1057e4a20: 900d32c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1057e4a24: f945fd08    	ldr	x8, [x8, #0xbf8] ; setM_nsUsrName:
1057e4a28: a904a7e8    	stp	x8, x9, [sp, #0x48]
1057e4a2c: 900d3348    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
1057e4a30: f9476909    	ldr	x9, [x8, #0xed0] ; copyFieldFromContact:
1057e4a34: f00d3548    	adrp	x8, 0x11fe8f000 <dyld_stub_binder+0x11fe8f000>
1057e4a38: f9424508    	ldr	x8, [x8, #0x488] ; filterContact:
1057e4a3c: a903a7e8    	stp	x8, x9, [sp, #0x38]
1057e4a40: f00d32a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057e4a44: f946c908    	ldr	x8, [x8, #0xd90] ; isChatBoxContact
1057e4a48: f90013e8    	str	x8, [sp, #0x20]
1057e4a4c: d00d32a8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1057e4a50: f943c509    	ldr	x9, [x8, #0x788] ; safeAddObject:
1057e4a54: b00d3308    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
1057e4a58: f00d4c77    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
1057e4a5c: f9413108    	ldr	x8, [x8, #0x260] ; m_bIsTop
1057e4a60: a900a7e8    	stp	x8, x9, [sp, #0x8]
1057e4a64: f9402ff8    	ldr	x24, [sp, #0x58]
1057e4a68: aa1403e0    	mov	x0, x20
1057e4a6c: aa1c03e1    	mov	x1, x28
1057e4a70: 949109b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4a74: aa1d03fd    	mov	x29, x29
1057e4a78: 949109b4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4a7c: aa0003f3    	mov	x19, x0
1057e4a80: aa1a03e1    	mov	x1, x26
1057e4a84: 949109ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4a88: aa0003f5    	mov	x21, x0
1057e4a8c: aa1303e0    	mov	x0, x19
1057e4a90: 949109b1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4a94: 37000755    	tbnz	w21, #0x0, 0x1057e4b7c <_Flutter_MMFoundation_BindContext+0x1cc0760>
1057e4a98: aa1403e0    	mov	x0, x20
1057e4a9c: f94037e1    	ldr	x1, [sp, #0x68]
1057e4aa0: 949109a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4aa4: aa1d03fd    	mov	x29, x29
1057e4aa8: 949109a8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4aac: aa0003f5    	mov	x21, x0
1057e4ab0: f94017e0    	ldr	x0, [sp, #0x28]
1057e4ab4: f94033e1    	ldr	x1, [sp, #0x60]
1057e4ab8: aa1503e2    	mov	x2, x21
1057e4abc: 949109a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4ac0: aa1d03fd    	mov	x29, x29
1057e4ac4: 949109a1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4ac8: aa0003f3    	mov	x19, x0
1057e4acc: aa1503e0    	mov	x0, x21
1057e4ad0: 949109a1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4ad4: f94782e0    	ldr	x0, [x23, #0xf00] ;  /,
1057e4ad8: 949109a0    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1057e4adc: aa0003f9    	mov	x25, x0
1057e4ae0: aa1303e0    	mov	x0, x19
1057e4ae4: f9402be1    	ldr	x1, [sp, #0x50]
1057e4ae8: 94910995    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4aec: aa1d03fd    	mov	x29, x29
1057e4af0: 94910996    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4af4: aa0003f5    	mov	x21, x0
1057e4af8: aa1903e0    	mov	x0, x25
1057e4afc: f94027e1    	ldr	x1, [sp, #0x48]
1057e4b00: aa1503e2    	mov	x2, x21
1057e4b04: 9491098e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4b08: aa1503e0    	mov	x0, x21
1057e4b0c: 94910992    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4b10: aa1903e0    	mov	x0, x25
1057e4b14: f94023e1    	ldr	x1, [sp, #0x40]
1057e4b18: aa1303e2    	mov	x2, x19
1057e4b1c: 94910988    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4b20: aa1803e0    	mov	x0, x24
1057e4b24: f9401fe1    	ldr	x1, [sp, #0x38]
1057e4b28: aa1903e2    	mov	x2, x25
1057e4b2c: 94910984    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4b30: 340001e0    	cbz	w0, 0x1057e4b6c <_Flutter_MMFoundation_BindContext+0x1cc0750>
1057e4b34: aa1903e0    	mov	x0, x25
1057e4b38: f94013e1    	ldr	x1, [sp, #0x20]
1057e4b3c: 94910980    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4b40: 37000160    	tbnz	w0, #0x0, 0x1057e4b6c <_Flutter_MMFoundation_BindContext+0x1cc0750>
1057e4b44: a94123e1    	ldp	x1, x8, [sp, #0x10]
1057e4b48: f8686b00    	ldr	x0, [x24, x8]
1057e4b4c: aa1903e2    	mov	x2, x25
1057e4b50: 9491097b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4b54: aa1403e0    	mov	x0, x20
1057e4b58: f94007e1    	ldr	x1, [sp, #0x8]
1057e4b5c: 94910978    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4b60: f9401be8    	ldr	x8, [sp, #0x30]
1057e4b64: 8b204108    	add	x8, x8, w0, uxtw
1057e4b68: f9001be8    	str	x8, [sp, #0x30]
1057e4b6c: aa1903e0    	mov	x0, x25
1057e4b70: 94910979    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4b74: aa1303e0    	mov	x0, x19
1057e4b78: 94910977    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4b7c: aa1403e0    	mov	x0, x20
1057e4b80: 94910975    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4b84: aa1603e0    	mov	x0, x22
1057e4b88: aa1b03e1    	mov	x1, x27
1057e4b8c: 9491096c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4b90: aa1d03fd    	mov	x29, x29
1057e4b94: 9491096d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4b98: aa0003f4    	mov	x20, x0
1057e4b9c: b5fff660    	cbnz	x0, 0x1057e4a68 <_Flutter_MMFoundation_BindContext+0x1cc064c>
1057e4ba0: 14000003    	b	0x1057e4bac <_Flutter_MMFoundation_BindContext+0x1cc0790>
1057e4ba4: f9001bff    	str	xzr, [sp, #0x30]
1057e4ba8: f9402ff8    	ldr	x24, [sp, #0x58]
1057e4bac: b00d3d08    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
1057e4bb0: f940b101    	ldr	x1, [x8, #0x160] ; setTopSessionCount:
1057e4bb4: aa1803e0    	mov	x0, x24
1057e4bb8: f9401be2    	ldr	x2, [sp, #0x30]
1057e4bbc: 94910960    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4bc0: f00d5248    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057e4bc4: b983c108    	ldrsw	x8, [x8, #0x3c0] ; ivar SessionSelectView._ftsTopHitMgr
1057e4bc8: f8686b00    	ldr	x0, [x24, x8]
1057e4bcc: d00d3528    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1057e4bd0: f9422501    	ldr	x1, [x8, #0x448] ; doInitWorker
1057e4bd4: 9491095a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4bd8: f00d4c68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057e4bdc: f9454100    	ldr	x0, [x8, #0xa80]
1057e4be0: 9491095e    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1057e4be4: aa0003f3    	mov	x19, x0
1057e4be8: b00d3e68    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057e4bec: f9442501    	ldr	x1, [x8, #0x848] ; setMultiSelectContactSectionDict:
1057e4bf0: aa1803e0    	mov	x0, x24
1057e4bf4: aa1303e2    	mov	x2, x19
1057e4bf8: 94910951    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4bfc: aa1303e0    	mov	x0, x19
1057e4c00: 94910955    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4c04: b00d3e68    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057e4c08: f9441901    	ldr	x1, [x8, #0x830] ; initSectionTypes
1057e4c0c: aa1803e0    	mov	x0, x24
1057e4c10: 9491094b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4c14: f00d4c77    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
1057e4c18: f945eae0    	ldr	x0, [x23, #0xbd0]
1057e4c1c: f94047f5    	ldr	x21, [sp, #0x88]
1057e4c20: aa1503e1    	mov	x1, x21
1057e4c24: 94910946    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4c28: aa1d03fd    	mov	x29, x29
1057e4c2c: 94910947    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4c30: aa0003f3    	mov	x19, x0
1057e4c34: 900d4c9b    	adrp	x27, 0x120174000 <dyld_stub_binder+0x120174000>
1057e4c38: f941bf60    	ldr	x0, [x27, #0x378]
1057e4c3c: f94043f9    	ldr	x25, [sp, #0x80]
1057e4c40: aa1903e1    	mov	x1, x25
1057e4c44: 9491093e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4c48: aa0003e2    	mov	x2, x0
1057e4c4c: aa1303e0    	mov	x0, x19
1057e4c50: f9403ffa    	ldr	x26, [sp, #0x78]
1057e4c54: aa1a03e1    	mov	x1, x26
1057e4c58: 94910939    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4c5c: aa1d03fd    	mov	x29, x29
1057e4c60: 9491093a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4c64: aa0003f4    	mov	x20, x0
1057e4c68: 900d3d08    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
1057e4c6c: f9460501    	ldr	x1, [x8, #0xc08] ; canFoldTopSession
1057e4c70: 94910933    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4c74: aa0003e2    	mov	x2, x0
1057e4c78: b00d3e68    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057e4c7c: f9442901    	ldr	x1, [x8, #0x850] ; setCanFoldTopSession:
1057e4c80: aa1803e0    	mov	x0, x24
1057e4c84: 9491092e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4c88: aa1403e0    	mov	x0, x20
1057e4c8c: 94910932    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4c90: aa1303e0    	mov	x0, x19
1057e4c94: 94910930    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4c98: f945eae0    	ldr	x0, [x23, #0xbd0]
1057e4c9c: aa1503e1    	mov	x1, x21
1057e4ca0: 94910927    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4ca4: aa1d03fd    	mov	x29, x29
1057e4ca8: 94910928    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4cac: aa0003f3    	mov	x19, x0
1057e4cb0: f941bf60    	ldr	x0, [x27, #0x378]
1057e4cb4: aa1903e1    	mov	x1, x25
1057e4cb8: 94910921    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4cbc: aa0003e2    	mov	x2, x0
1057e4cc0: aa1303e0    	mov	x0, x19
1057e4cc4: aa1a03e1    	mov	x1, x26
1057e4cc8: 9491091d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4ccc: aa1d03fd    	mov	x29, x29
1057e4cd0: 9491091e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4cd4: aa0003f4    	mov	x20, x0
1057e4cd8: 900d3608    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
1057e4cdc: f9401d01    	ldr	x1, [x8, #0x38] ; isFoldTopSession
1057e4ce0: 94910917    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4ce4: aa0003e2    	mov	x2, x0
1057e4ce8: b00d3e68    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057e4cec: f9442d01    	ldr	x1, [x8, #0x858] ; setIsFoldTopSession:
1057e4cf0: aa1803e0    	mov	x0, x24
1057e4cf4: 94910912    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4cf8: aa1403e0    	mov	x0, x20
1057e4cfc: 94910916    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4d00: aa1303e0    	mov	x0, x19
1057e4d04: 94910914    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4d08: aa1603e0    	mov	x0, x22
1057e4d0c: 94910912    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4d10: f9403be0    	ldr	x0, [sp, #0x70]
1057e4d14: 94910910    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4d18: f94017e0    	ldr	x0, [sp, #0x28]
1057e4d1c: 9491090e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4d20: f85a03a8    	ldur	x8, [x29, #-0x60]
1057e4d24: f00bf049    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1057e4d28: f9405929    	ldr	x9, [x9, #0xb0]
1057e4d2c: f9400129    	ldr	x9, [x9]
1057e4d30: eb08013f    	cmp	x9, x8
1057e4d34: 54000121    	b.ne	0x1057e4d58 <_Flutter_MMFoundation_BindContext+0x1cc093c>
1057e4d38: 910883ff    	add	sp, sp, #0x220
1057e4d3c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1057e4d40: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1057e4d44: a94357f6    	ldp	x22, x21, [sp, #0x30]
1057e4d48: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1057e4d4c: a94167fa    	ldp	x26, x25, [sp, #0x10]
1057e4d50: a8c66ffc    	ldp	x28, x27, [sp], #0x60
1057e4d54: d65f03c0    	ret
1057e4d58: 94910907    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
