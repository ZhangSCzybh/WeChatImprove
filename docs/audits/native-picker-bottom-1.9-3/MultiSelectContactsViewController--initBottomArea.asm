
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ea43a4: d10503ff    	sub	sp, sp, #0x140
104ea43a8: 6d0d23e9    	stp	d9, d8, [sp, #0xd0]
104ea43ac: a90e6ffc    	stp	x28, x27, [sp, #0xe0]
104ea43b0: a90f67fa    	stp	x26, x25, [sp, #0xf0]
104ea43b4: a9105ff8    	stp	x24, x23, [sp, #0x100]
104ea43b8: a91157f6    	stp	x22, x21, [sp, #0x110]
104ea43bc: a9124ff4    	stp	x20, x19, [sp, #0x120]
104ea43c0: a9137bfd    	stp	x29, x30, [sp, #0x130]
104ea43c4: 9104c3fd    	add	x29, sp, #0x130
104ea43c8: aa0003f3    	mov	x19, x0
104ea43cc: f00decc8    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
104ea43d0: 52800029    	mov	w9, #0x1                ; =1
104ea43d4: 3907d909    	strb	w9, [x8, #0x1f6]
104ea43d8: b00d8768    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea43dc: f9469101    	ldr	x1, [x8, #0xd20] ; embeddedInContainer
104ea43e0: 94b60b57    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea43e4: 37002580    	tbnz	w0, #0x0, 0x104ea4894 <_Flutter_MMFoundation_BindContext+0x1380478>
104ea43e8: b00d8768    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea43ec: f946fd01    	ldr	x1, [x8, #0xdf8] ; shouldUseBottomToolView
104ea43f0: aa1303e0    	mov	x0, x19
104ea43f4: 94b60b52    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea43f8: 340024e0    	cbz	w0, 0x104ea4894 <_Flutter_MMFoundation_BindContext+0x1380478>
104ea43fc: d00d9c08    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea4400: b9883908    	ldrsw	x8, [x8, #0x838]
104ea4404: fc686a68    	ldr	d8, [x19, x8]
104ea4408: d00d7ce8    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
104ea440c: f9462d01    	ldr	x1, [x8, #0xc58] ; getSafeBottomInset
104ea4410: aa1303e0    	mov	x0, x19
104ea4414: 94b60b4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea4418: 1e602908    	fadd	d8, d8, d0
104ea441c: b00d96a8    	adrp	x8, 0x120179000 <dyld_stub_binder+0x120179000>
104ea4420: f9416500    	ldr	x0, [x8, #0x2c8] ; `D, 
104ea4424: 94b60b4f    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104ea4428: aa0003f5    	mov	x21, x0
104ea442c: f00d9328    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104ea4430: f946d514    	ldr	x20, [x8, #0xda8] ; view
104ea4434: aa1303e0    	mov	x0, x19
104ea4438: aa1403e1    	mov	x1, x20
104ea443c: 94b60b40    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea4440: aa1d03fd    	mov	x29, x29
104ea4444: 94b60b41    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea4448: aa0003f6    	mov	x22, x0
104ea444c: d00d92e8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104ea4450: f9449d01    	ldr	x1, [x8, #0x938] ; height
104ea4454: 94b60b3a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea4458: 1e683809    	fsub	d9, d0, d8
104ea445c: aa1303e0    	mov	x0, x19
104ea4460: aa1403e1    	mov	x1, x20
104ea4464: 94b60b36    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea4468: aa1d03fd    	mov	x29, x29
104ea446c: 94b60b37    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea4470: aa0003f7    	mov	x23, x0
104ea4474: f00d9328    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104ea4478: f947a501    	ldr	x1, [x8, #0xf48] ; width
104ea447c: 94b60b30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea4480: 1e604002    	fmov	d2, d0
104ea4484: d00d92e8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104ea4488: f947d901    	ldr	x1, [x8, #0xfb0] ; initWithFrame:
104ea448c: 9e6703e0    	fmov	d0, xzr
104ea4490: aa1503e0    	mov	x0, x21
104ea4494: 1e604121    	fmov	d1, d9
104ea4498: 1e604103    	fmov	d3, d8
104ea449c: 94b60b28    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea44a0: d00d9c08    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea44a4: b9886119    	ldrsw	x25, [x8, #0x860]
104ea44a8: f8796a68    	ldr	x8, [x19, x25]
104ea44ac: f8396a60    	str	x0, [x19, x25]
104ea44b0: aa0803e0    	mov	x0, x8
104ea44b4: 94b60b28    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea44b8: aa1703e0    	mov	x0, x23
104ea44bc: 94b60b26    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea44c0: aa1603e0    	mov	x0, x22
104ea44c4: 94b60b24    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea44c8: f8796a75    	ldr	x21, [x19, x25]
104ea44cc: 900d7f28    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
104ea44d0: f9407501    	ldr	x1, [x8, #0xe8] ; colorProxy
104ea44d4: aa1303e0    	mov	x0, x19
104ea44d8: 94b60b19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea44dc: aa1d03fd    	mov	x29, x29
104ea44e0: 94b60b1a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea44e4: aa0003f6    	mov	x22, x0
104ea44e8: b00d7e28    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104ea44ec: f9412901    	ldr	x1, [x8, #0x250] ; attachBarBlur
104ea44f0: 94b60b13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea44f4: aa1d03fd    	mov	x29, x29
104ea44f8: 94b60b14    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea44fc: aa0003f7    	mov	x23, x0
104ea4500: f00d7d08    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
104ea4504: f9452501    	ldr	x1, [x8, #0xa48] ; addBlurEffectWithColor:
104ea4508: aa1503e0    	mov	x0, x21
104ea450c: aa1703e2    	mov	x2, x23
104ea4510: 94b60b0b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea4514: aa1703e0    	mov	x0, x23
104ea4518: 94b60b0f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea451c: aa1603e0    	mov	x0, x22
104ea4520: 94b60b0d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea4524: f8796a60    	ldr	x0, [x19, x25]
104ea4528: f00d9308    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
104ea452c: f9406501    	ldr	x1, [x8, #0xc8] ; setAutoresizingMask:
104ea4530: 52800142    	mov	w2, #0xa                ; =10
104ea4534: 94b60b02    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea4538: aa1303e0    	mov	x0, x19
104ea453c: aa1403e1    	mov	x1, x20
104ea4540: 94b60aff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea4544: aa1d03fd    	mov	x29, x29
104ea4548: 94b60b00    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea454c: aa0003f4    	mov	x20, x0
104ea4550: f8796a62    	ldr	x2, [x19, x25]
104ea4554: d00d92c8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
104ea4558: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
104ea455c: 94b60af8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea4560: aa1403e0    	mov	x0, x20
104ea4564: 94b60afc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea4568: b00d8768    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea456c: f946cd01    	ldr	x1, [x8, #0xd98] ; canSelectMsgHistory
104ea4570: aa1303e0    	mov	x0, x19
104ea4574: 94b60af2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea4578: 360007c0    	tbz	w0, #0x0, 0x104ea4670 <_Flutter_MMFoundation_BindContext+0x1380254>
104ea457c: f00d9668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104ea4580: f945e900    	ldr	x0, [x8, #0xbd0]
104ea4584: 900d92e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104ea4588: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104ea458c: 94b60aec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea4590: aa1d03fd    	mov	x29, x29
104ea4594: 94b60aed    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea4598: aa0003f5    	mov	x21, x0
104ea459c: 900d9688    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104ea45a0: f9403100    	ldr	x0, [x8, #0x60]
104ea45a4: f00d92c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104ea45a8: f947ad01    	ldr	x1, [x8, #0xf58] ; class
104ea45ac: 94b60ae4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea45b0: aa0003e2    	mov	x2, x0
104ea45b4: b00d7ca8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104ea45b8: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104ea45bc: aa1503e0    	mov	x0, x21
104ea45c0: 94b60adf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea45c4: aa1d03fd    	mov	x29, x29
104ea45c8: 94b60ae0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea45cc: aa0003f6    	mov	x22, x0
104ea45d0: b00d8768    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea45d4: f9475101    	ldr	x1, [x8, #0xea0] ; getSessionContact
104ea45d8: aa1303e0    	mov	x0, x19
104ea45dc: 94b60ad8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea45e0: aa1d03fd    	mov	x29, x29
104ea45e4: 94b60ad9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea45e8: aa0003f7    	mov	x23, x0
104ea45ec: f00d7ca8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104ea45f0: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
104ea45f4: 94b60ad2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea45f8: aa1d03fd    	mov	x29, x29
104ea45fc: 94b60ad3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea4600: aa0003f8    	mov	x24, x0
104ea4604: d00d8648    	adrp	x8, 0x11ff6e000 <dyld_stub_binder+0x11ff6e000>
104ea4608: f941fd01    	ldr	x1, [x8, #0x3f8] ; GetLastNonSysMsg:
104ea460c: aa1603e0    	mov	x0, x22
104ea4610: aa1803e2    	mov	x2, x24
104ea4614: 94b60aca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea4618: aa1d03fd    	mov	x29, x29
104ea461c: 94b60acb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea4620: aa0003f4    	mov	x20, x0
104ea4624: aa1803e0    	mov	x0, x24
104ea4628: 94b60acb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea462c: aa1703e0    	mov	x0, x23
104ea4630: 94b60ac9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea4634: aa1603e0    	mov	x0, x22
104ea4638: 94b60ac7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea463c: aa1503e0    	mov	x0, x21
104ea4640: 94b60ac5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea4644: b4000314    	cbz	x20, 0x104ea46a4 <_Flutter_MMFoundation_BindContext+0x1380288>
104ea4648: d00d9c08    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea464c: b9888108    	ldrsw	x8, [x8, #0x880]
104ea4650: f8686a60    	ldr	x0, [x19, x8]
104ea4654: b00d8768    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea4658: f9475501    	ldr	x1, [x8, #0xea8] ; setHasExposedShareEntry:
104ea465c: 52800022    	mov	w2, #0x1                ; =1
104ea4660: 94b60ab7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea4664: 900d9328    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104ea4668: f9411115    	ldr	x21, [x8, #0x220] ; setHidden:
104ea466c: 1400001c    	b	0x104ea46dc <_Flutter_MMFoundation_BindContext+0x13802c0>
104ea4670: f8796a60    	ldr	x0, [x19, x25]
104ea4674: b00d7e28    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104ea4678: f9412d01    	ldr	x1, [x8, #0x258] ; msgHistoryButton
104ea467c: 94b60ab0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea4680: aa1d03fd    	mov	x29, x29
104ea4684: 94b60ab1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea4688: aa0003f4    	mov	x20, x0
104ea468c: 900d9328    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104ea4690: f9411115    	ldr	x21, [x8, #0x220] ; setHidden:
104ea4694: aa1503e1    	mov	x1, x21
104ea4698: 52800022    	mov	w2, #0x1                ; =1
104ea469c: 94b60aa8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea46a0: 1400000f    	b	0x104ea46dc <_Flutter_MMFoundation_BindContext+0x13802c0>
104ea46a4: f8796a60    	ldr	x0, [x19, x25]
104ea46a8: b00d7e28    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104ea46ac: f9412d01    	ldr	x1, [x8, #0x258] ; msgHistoryButton
104ea46b0: 94b60aa3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea46b4: aa1d03fd    	mov	x29, x29
104ea46b8: 94b60aa4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea46bc: aa0003f6    	mov	x22, x0
104ea46c0: 900d9328    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104ea46c4: f9411115    	ldr	x21, [x8, #0x220] ; setHidden:
104ea46c8: aa1503e1    	mov	x1, x21
104ea46cc: 52800022    	mov	w2, #0x1                ; =1
104ea46d0: 94b60a9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea46d4: aa1603e0    	mov	x0, x22
104ea46d8: 94b60a9f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea46dc: aa1403e0    	mov	x0, x20
104ea46e0: 94b60a9d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea46e4: b00d8768    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea46e8: f946c901    	ldr	x1, [x8, #0xd90] ; shouldShowSelectContactViewInBottomToolView
104ea46ec: aa1303e0    	mov	x0, x19
104ea46f0: 94b60a93    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea46f4: aa0003f4    	mov	x20, x0
104ea46f8: f8796a60    	ldr	x0, [x19, x25]
104ea46fc: b00d7e28    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104ea4700: f9413101    	ldr	x1, [x8, #0x260] ; selectContactsView
104ea4704: 94b60a8e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea4708: aa1d03fd    	mov	x29, x29
104ea470c: 94b60a8f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea4710: aa0003f6    	mov	x22, x0
104ea4714: 52000282    	eor	w2, w20, #0x1
104ea4718: aa1503e1    	mov	x1, x21
104ea471c: 94b60a88    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea4720: aa1603e0    	mov	x0, x22
104ea4724: 94b60a8c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea4728: d101a3a0    	sub	x0, x29, #0x68
104ea472c: aa1303e1    	mov	x1, x19
104ea4730: 94b60a8f    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
104ea4734: d00c3a56    	adrp	x22, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
104ea4738: f947e2d6    	ldr	x22, [x22, #0xfc0]
104ea473c: f81703b6    	stur	x22, [x29, #-0x90]
104ea4740: b009f6e8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
104ea4744: fd41c108    	ldr	d8, [x8, #0x380]
104ea4748: 90000008    	adrp	x8, 0x104ea4000 <_Flutter_MMFoundation_BindContext+0x137fbe4>
104ea474c: 9122e108    	add	x8, x8, #0x8b8
104ea4750: fc1783a8    	stur	d8, [x29, #-0x88]
104ea4754: b00c3ab7    	adrp	x23, 0x11d5f9000 <dyld_stub_binder+0x11d5f9000>
104ea4758: 9119c2f7    	add	x23, x23, #0x670
104ea475c: a9385fa8    	stp	x8, x23, [x29, #-0x80]
104ea4760: d10243b4    	sub	x20, x29, #0x90
104ea4764: 91008280    	add	x0, x20, #0x20
104ea4768: d101a3a1    	sub	x1, x29, #0x68
104ea476c: 94b60a83    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
104ea4770: f8796a60    	ldr	x0, [x19, x25]
104ea4774: b00d7e28    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104ea4778: f9413d01    	ldr	x1, [x8, #0x278] ; setCompleteHandler:
104ea477c: d10243a2    	sub	x2, x29, #0x90
104ea4780: 94b60a6f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea4784: f9003ff6    	str	x22, [sp, #0x78]
104ea4788: fd0043e8    	str	d8, [sp, #0x80]
104ea478c: 90000008    	adrp	x8, 0x104ea4000 <_Flutter_MMFoundation_BindContext+0x137fbe4>
104ea4790: 91244108    	add	x8, x8, #0x910
104ea4794: a908dfe8    	stp	x8, x23, [sp, #0x88]
104ea4798: 9101e3f5    	add	x21, sp, #0x78
104ea479c: 910082a0    	add	x0, x21, #0x20
104ea47a0: d101a3a1    	sub	x1, x29, #0x68
104ea47a4: 94b60a75    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
104ea47a8: f8796a60    	ldr	x0, [x19, x25]
104ea47ac: b00d8768    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea47b0: f9476901    	ldr	x1, [x8, #0xed0] ; setRetryHandler:
104ea47b4: 9101e3e2    	add	x2, sp, #0x78
104ea47b8: 94b60a61    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea47bc: f9002bf6    	str	x22, [sp, #0x50]
104ea47c0: fd002fe8    	str	d8, [sp, #0x58]
104ea47c4: 90000008    	adrp	x8, 0x104ea4000 <_Flutter_MMFoundation_BindContext+0x137fbe4>
104ea47c8: 9128b108    	add	x8, x8, #0xa2c
104ea47cc: a9065fe8    	stp	x8, x23, [sp, #0x60]
104ea47d0: 910143f8    	add	x24, sp, #0x50
104ea47d4: 91008300    	add	x0, x24, #0x20
104ea47d8: d101a3a1    	sub	x1, x29, #0x68
104ea47dc: 94b60a67    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
104ea47e0: f8796a60    	ldr	x0, [x19, x25]
104ea47e4: b00d8768    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea47e8: f9477101    	ldr	x1, [x8, #0xee0] ; setViewMsgHistoryHandler:
104ea47ec: 910143e2    	add	x2, sp, #0x50
104ea47f0: 94b60a53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea47f4: f90017f6    	str	x22, [sp, #0x28]
104ea47f8: fd001be8    	str	d8, [sp, #0x30]
104ea47fc: 90000008    	adrp	x8, 0x104ea4000 <_Flutter_MMFoundation_BindContext+0x137fbe4>
104ea4800: 912a0108    	add	x8, x8, #0xa80
104ea4804: a903dfe8    	stp	x8, x23, [sp, #0x38]
104ea4808: 9100a3fa    	add	x26, sp, #0x28
104ea480c: 91008340    	add	x0, x26, #0x20
104ea4810: d101a3a1    	sub	x1, x29, #0x68
104ea4814: 94b60a59    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
104ea4818: f8796a60    	ldr	x0, [x19, x25]
104ea481c: b00d7e28    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104ea4820: f9414d01    	ldr	x1, [x8, #0x298] ; setDeselectContactHandler:
104ea4824: 9100a3e2    	add	x2, sp, #0x28
104ea4828: 94b60a45    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea482c: f90003f6    	str	x22, [sp]
104ea4830: fd0007e8    	str	d8, [sp, #0x8]
104ea4834: 90000008    	adrp	x8, 0x104ea4000 <_Flutter_MMFoundation_BindContext+0x137fbe4>
104ea4838: 912f9108    	add	x8, x8, #0xbe4
104ea483c: a9015fe8    	stp	x8, x23, [sp, #0x10]
104ea4840: 910003f6    	mov	x22, sp
104ea4844: 910082c0    	add	x0, x22, #0x20
104ea4848: d101a3a1    	sub	x1, x29, #0x68
104ea484c: 94b60a4b    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
104ea4850: f8796a60    	ldr	x0, [x19, x25]
104ea4854: b00d7e28    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104ea4858: f9414501    	ldr	x1, [x8, #0x288] ; setPreviewSelectedContactHandler:
104ea485c: 910003e2    	mov	x2, sp
104ea4860: 94b60a37    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea4864: 910082c0    	add	x0, x22, #0x20
104ea4868: 94b60a4a    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
104ea486c: 91008340    	add	x0, x26, #0x20
104ea4870: 94b60a48    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
104ea4874: 91008300    	add	x0, x24, #0x20
104ea4878: 94b60a46    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
104ea487c: 910082a0    	add	x0, x21, #0x20
104ea4880: 94b60a44    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
104ea4884: 91008280    	add	x0, x20, #0x20
104ea4888: 94b60a42    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
104ea488c: d101a3a0    	sub	x0, x29, #0x68
104ea4890: 94b60a40    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
104ea4894: a9537bfd    	ldp	x29, x30, [sp, #0x130]
104ea4898: a9524ff4    	ldp	x20, x19, [sp, #0x120]
104ea489c: a95157f6    	ldp	x22, x21, [sp, #0x110]
104ea48a0: a9505ff8    	ldp	x24, x23, [sp, #0x100]
104ea48a4: a94f67fa    	ldp	x26, x25, [sp, #0xf0]
104ea48a8: a94e6ffc    	ldp	x28, x27, [sp, #0xe0]
104ea48ac: 6d4d23e9    	ldp	d9, d8, [sp, #0xd0]
104ea48b0: 910503ff    	add	sp, sp, #0x140
104ea48b4: d65f03c0    	ret
