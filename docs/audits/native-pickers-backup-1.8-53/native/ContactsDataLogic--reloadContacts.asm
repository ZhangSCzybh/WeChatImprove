
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010a458c: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
1010a4590: a90167fa    	stp	x26, x25, [sp, #0x10]
1010a4594: a9025ff8    	stp	x24, x23, [sp, #0x20]
1010a4598: a90357f6    	stp	x22, x21, [sp, #0x30]
1010a459c: a9044ff4    	stp	x20, x19, [sp, #0x40]
1010a45a0: a9057bfd    	stp	x29, x30, [sp, #0x50]
1010a45a4: 910143fd    	add	x29, sp, #0x50
1010a45a8: d10b03ff    	sub	sp, sp, #0x2c0
1010a45ac: aa0003f8    	mov	x24, x0
1010a45b0: f00e2a48    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1010a45b4: f9405908    	ldr	x8, [x8, #0xb0]
1010a45b8: f9400108    	ldr	x8, [x8]
1010a45bc: f81a03a8    	stur	x8, [x29, #-0x60]
1010a45c0: 900fdc68    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
1010a45c4: 52800029    	mov	w9, #0x1                ; =1
1010a45c8: 393ce509    	strb	w9, [x8, #0xf39]
1010a45cc: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a45d0: b9860508    	ldrsw	x8, [x8, #0x604]
1010a45d4: 38686800    	ldrb	w0, [x0, x8]
1010a45d8: 7100041f    	cmp	w0, #0x1
1010a45dc: 54003581    	b.ne	0x1010a4c8c <__text+0x109cc8c>
1010a45e0: f90023e8    	str	x8, [sp, #0x40]
1010a45e4: b90037e0    	str	w0, [sp, #0x34]
1010a45e8: f00f8668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1010a45ec: f9454500    	ldr	x0, [x8, #0xa88]
1010a45f0: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a45f4: b9863509    	ldrsw	x9, [x8, #0x634]
1010a45f8: d00f8328    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1010a45fc: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
1010a4600: f90017e9    	str	x9, [sp, #0x28]
1010a4604: b8696b08    	ldr	w8, [x24, x9]
1010a4608: f90003e8    	str	x8, [sp]
1010a460c: f00ea522    	adrp	x2, 0x11e54b000 <dyld_stub_binder+0x11e54b000>
1010a4610: 9125a042    	add	x2, x2, #0x968
1010a4614: f9002fe1    	str	x1, [sp, #0x58]
1010a4618: 95ae0ac9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a461c: aa1d03fd    	mov	x29, x29
1010a4620: 95ae0aca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a4624: aa0003f3    	mov	x19, x0
1010a4628: 900f8308    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1010a462c: f9450901    	ldr	x1, [x8, #0xa10] ; mutableCopy
1010a4630: f90013e1    	str	x1, [sp, #0x20]
1010a4634: 95ae0ac2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4638: f9002be0    	str	x0, [sp, #0x50]
1010a463c: aa1303e0    	mov	x0, x19
1010a4640: 95ae0ac5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4644: 4f00e400    	movi.16b	v0, #0x0
1010a4648: ad0883e0    	stp	q0, q0, [sp, #0x110]
1010a464c: ad0783e0    	stp	q0, q0, [sp, #0xf0]
1010a4650: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a4654: b9860d08    	ldrsw	x8, [x8, #0x60c]
1010a4658: f90037e8    	str	x8, [sp, #0x68]
1010a465c: f8686b00    	ldr	x0, [x24, x8]
1010a4660: 95ae0ab6    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1010a4664: 900f82e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1010a4668: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1010a466c: 9103c3e2    	add	x2, sp, #0xf0
1010a4670: d10383a3    	sub	x3, x29, #0xe0
1010a4674: f90027e0    	str	x0, [sp, #0x48]
1010a4678: f9001fe1    	str	x1, [sp, #0x38]
1010a467c: 52800204    	mov	w4, #0x10               ; =16
1010a4680: 95ae0aaf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4684: f90033f8    	str	x24, [sp, #0x60]
1010a4688: b40007a0    	cbz	x0, 0x1010a477c <__text+0x109c77c>
1010a468c: aa0003fb    	mov	x27, x0
1010a4690: f94083e8    	ldr	x8, [sp, #0x100]
1010a4694: f9400115    	ldr	x21, [x8]
1010a4698: f00ea53a    	adrp	x26, 0x11e54b000 <dyld_stub_binder+0x11e54b000>
1010a469c: 9126235a    	add	x26, x26, #0x988
1010a46a0: d2800019    	mov	x25, #0x0               ; =0
1010a46a4: 900f8308    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1010a46a8: f947f113    	ldr	x19, [x8, #0xfe0] ; objectForKey:
1010a46ac: 900f82e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1010a46b0: f943511c    	ldr	x28, [x8, #0x6a0] ; count
1010a46b4: 900f6cc8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1010a46b8: f944d516    	ldr	x22, [x8, #0x9a8] ; safeAppendString:
1010a46bc: f94083e8    	ldr	x8, [sp, #0x100]
1010a46c0: f9400108    	ldr	x8, [x8]
1010a46c4: eb15011f    	cmp	x8, x21
1010a46c8: 54000060    	b.eq	0x1010a46d4 <__text+0x109c6d4>
1010a46cc: f94027e0    	ldr	x0, [sp, #0x48]
1010a46d0: 95ae0aa0    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1010a46d4: f9407fe8    	ldr	x8, [sp, #0xf8]
1010a46d8: f8797917    	ldr	x23, [x8, x25, lsl #3]
1010a46dc: f94037e8    	ldr	x8, [sp, #0x68]
1010a46e0: f8686b00    	ldr	x0, [x24, x8]
1010a46e4: aa1303e1    	mov	x1, x19
1010a46e8: aa1703e2    	mov	x2, x23
1010a46ec: 95ae0a94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a46f0: aa1d03fd    	mov	x29, x29
1010a46f4: 95ae0a95    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a46f8: aa0003f8    	mov	x24, x0
1010a46fc: f00f8668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1010a4700: f9454514    	ldr	x20, [x8, #0xa88]
1010a4704: aa1c03e1    	mov	x1, x28
1010a4708: 95ae0a8d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a470c: a90003f7    	stp	x23, x0, [sp]
1010a4710: aa1403e0    	mov	x0, x20
1010a4714: f9402fe1    	ldr	x1, [sp, #0x58]
1010a4718: aa1a03e2    	mov	x2, x26
1010a471c: 95ae0a88    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4720: aa1d03fd    	mov	x29, x29
1010a4724: 95ae0a89    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a4728: aa0003f4    	mov	x20, x0
1010a472c: f9402be0    	ldr	x0, [sp, #0x50]
1010a4730: aa1603e1    	mov	x1, x22
1010a4734: aa1403e2    	mov	x2, x20
1010a4738: 95ae0a81    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a473c: aa1403e0    	mov	x0, x20
1010a4740: 95ae0a85    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4744: aa1803e0    	mov	x0, x24
1010a4748: f94033f8    	ldr	x24, [sp, #0x60]
1010a474c: 95ae0a82    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4750: 91000739    	add	x25, x25, #0x1
1010a4754: eb19037f    	cmp	x27, x25
1010a4758: 54fffb21    	b.ne	0x1010a46bc <__text+0x109c6bc>
1010a475c: 9103c3e2    	add	x2, sp, #0xf0
1010a4760: d10383a3    	sub	x3, x29, #0xe0
1010a4764: f94027e0    	ldr	x0, [sp, #0x48]
1010a4768: f9401fe1    	ldr	x1, [sp, #0x38]
1010a476c: 52800204    	mov	w4, #0x10               ; =16
1010a4770: 95ae0a73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4774: aa0003fb    	mov	x27, x0
1010a4778: b5fff940    	cbnz	x0, 0x1010a46a0 <__text+0x109c6a0>
1010a477c: f94027e0    	ldr	x0, [sp, #0x48]
1010a4780: 95ae0a75    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4784: f00f8668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1010a4788: f9453500    	ldr	x0, [x8, #0xa68]
1010a478c: b00f6ca8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1010a4790: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1010a4794: 900e9fc9    	adrp	x9, 0x11e49c000 <dyld_stub_binder+0x11e49c000>
1010a4798: 9122a129    	add	x9, x9, #0x8a8
1010a479c: f9402be8    	ldr	x8, [sp, #0x50]
1010a47a0: a90023e9    	stp	x9, x8, [sp]
1010a47a4: b00d1665    	adrp	x5, 0x11b371000 <dyld_stub_binder+0x11b371000>
1010a47a8: 910874a5    	add	x5, x5, #0x21d
1010a47ac: b00d1667    	adrp	x7, 0x11b371000 <dyld_stub_binder+0x11b371000>
1010a47b0: 9108c8e7    	add	x7, x7, #0x232
1010a47b4: f9000fe1    	str	x1, [sp, #0x18]
1010a47b8: 52800042    	mov	w2, #0x2                ; =2
1010a47bc: d2800003    	mov	x3, #0x0                ; =0
1010a47c0: 52800004    	mov	w4, #0x0                ; =0
1010a47c4: 528093a6    	mov	w6, #0x49d              ; =1181
1010a47c8: 95ae0a5d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a47cc: f94023e8    	ldr	x8, [sp, #0x40]
1010a47d0: 38286b1f    	strb	wzr, [x24, x8]
1010a47d4: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a47d8: b9861508    	ldrsw	x8, [x8, #0x614]
1010a47dc: b8286b1f    	str	wzr, [x24, x8]
1010a47e0: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a47e4: b9861d08    	ldrsw	x8, [x8, #0x61c]
1010a47e8: b8286b1f    	str	wzr, [x24, x8]
1010a47ec: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a47f0: b9862113    	ldrsw	x19, [x8, #0x620]
1010a47f4: f8736b00    	ldr	x0, [x24, x19]
1010a47f8: f8336b1f    	str	xzr, [x24, x19]
1010a47fc: 95ae0a56    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4800: f94037f4    	ldr	x20, [sp, #0x68]
1010a4804: f8746b00    	ldr	x0, [x24, x20]
1010a4808: f8346b1f    	str	xzr, [x24, x20]
1010a480c: 95ae0a52    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4810: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a4814: b9862508    	ldrsw	x8, [x8, #0x624]
1010a4818: f8686b00    	ldr	x0, [x24, x8]
1010a481c: f8286b1f    	str	xzr, [x24, x8]
1010a4820: 95ae0a4d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4824: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a4828: b9861116    	ldrsw	x22, [x8, #0x610]
1010a482c: f8766b00    	ldr	x0, [x24, x22]
1010a4830: f8366b1f    	str	xzr, [x24, x22]
1010a4834: 95ae0a48    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4838: f00f8675    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
1010a483c: f94556a0    	ldr	x0, [x21, #0xaa8]
1010a4840: 95ae0a46    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1010a4844: f8736b08    	ldr	x8, [x24, x19]
1010a4848: f8336b00    	str	x0, [x24, x19]
1010a484c: aa0803e0    	mov	x0, x8
1010a4850: 95ae0a41    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4854: f00f8668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1010a4858: f9454100    	ldr	x0, [x8, #0xa80]
1010a485c: 95ae0a3f    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1010a4860: f8746b08    	ldr	x8, [x24, x20]
1010a4864: f8346b00    	str	x0, [x24, x20]
1010a4868: aa0803e0    	mov	x0, x8
1010a486c: 95ae0a3a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4870: f94556a0    	ldr	x0, [x21, #0xaa8]
1010a4874: f00f82c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1010a4878: f941a113    	ldr	x19, [x8, #0x340] ; array
1010a487c: aa1303e1    	mov	x1, x19
1010a4880: 95ae0a2f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4884: aa1d03fd    	mov	x29, x29
1010a4888: 95ae0a30    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a488c: aa0003f4    	mov	x20, x0
1010a4890: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a4894: f941fd01    	ldr	x1, [x8, #0x3f8] ; setMyNormalContactArray:
1010a4898: aa1803e0    	mov	x0, x24
1010a489c: aa1403e2    	mov	x2, x20
1010a48a0: 95ae0a27    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a48a4: aa1403e0    	mov	x0, x20
1010a48a8: 95ae0a2b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a48ac: f94556a0    	ldr	x0, [x21, #0xaa8]
1010a48b0: aa1303e1    	mov	x1, x19
1010a48b4: 95ae0a22    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a48b8: aa1d03fd    	mov	x29, x29
1010a48bc: 95ae0a23    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a48c0: aa0003f4    	mov	x20, x0
1010a48c4: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a48c8: f9420101    	ldr	x1, [x8, #0x400] ; setMyNormalContactArrayUnfiltered:
1010a48cc: aa1803e0    	mov	x0, x24
1010a48d0: aa1403e2    	mov	x2, x20
1010a48d4: 95ae0a1a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a48d8: aa1403e0    	mov	x0, x20
1010a48dc: 95ae0a1e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a48e0: f8766b00    	ldr	x0, [x24, x22]
1010a48e4: d00f8308    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1010a48e8: f9408114    	ldr	x20, [x8, #0x100] ; removeAllObjects
1010a48ec: aa1403e1    	mov	x1, x20
1010a48f0: 95ae0a13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a48f4: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a48f8: b9862908    	ldrsw	x8, [x8, #0x628]
1010a48fc: f8686b00    	ldr	x0, [x24, x8]
1010a4900: aa1403e1    	mov	x1, x20
1010a4904: 95ae0a0e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4908: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a490c: b9861908    	ldrsw	x8, [x8, #0x618]
1010a4910: f8686b00    	ldr	x0, [x24, x8]
1010a4914: aa1403e1    	mov	x1, x20
1010a4918: 95ae0a09    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a491c: f94556a0    	ldr	x0, [x21, #0xaa8]
1010a4920: aa1303e1    	mov	x1, x19
1010a4924: 95ae0a06    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4928: aa1d03fd    	mov	x29, x29
1010a492c: 95ae0a07    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a4930: f90023e0    	str	x0, [sp, #0x40]
1010a4934: f00f8668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1010a4938: f945e900    	ldr	x0, [x8, #0xbd0]
1010a493c: 900f82e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1010a4940: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1010a4944: 95ae09fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4948: aa1d03fd    	mov	x29, x29
1010a494c: 95ae09ff    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a4950: aa0003f3    	mov	x19, x0
1010a4954: 900f8688    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1010a4958: f9401500    	ldr	x0, [x8, #0x28] ; P;,
1010a495c: f00f82c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1010a4960: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1010a4964: 95ae09f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4968: aa0003e2    	mov	x2, x0
1010a496c: b00f6ca8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1010a4970: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
1010a4974: aa1303e0    	mov	x0, x19
1010a4978: 95ae09f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a497c: aa1d03fd    	mov	x29, x29
1010a4980: 95ae09f2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a4984: aa0003f4    	mov	x20, x0
1010a4988: aa1303e0    	mov	x0, x19
1010a498c: 95ae09f2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4990: 900f6e88    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
1010a4994: f9477501    	ldr	x1, [x8, #0xee8] ; getContactList:contactType:
1010a4998: f9000bf4    	str	x20, [sp, #0x10]
1010a499c: aa1403e0    	mov	x0, x20
1010a49a0: 52800022    	mov	w2, #0x1                ; =1
1010a49a4: 52800003    	mov	w3, #0x0                ; =0
1010a49a8: 95ae09e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a49ac: aa1d03fd    	mov	x29, x29
1010a49b0: 95ae09e6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a49b4: 4f00e400    	movi.16b	v0, #0x0
1010a49b8: ad0583e0    	stp	q0, q0, [sp, #0xb0]
1010a49bc: ad0683e0    	stp	q0, q0, [sp, #0xd0]
1010a49c0: 9102c3e2    	add	x2, sp, #0xb0
1010a49c4: 9106c3e3    	add	x3, sp, #0x1b0
1010a49c8: f90027e0    	str	x0, [sp, #0x48]
1010a49cc: f9401fe1    	ldr	x1, [sp, #0x38]
1010a49d0: 52800204    	mov	w4, #0x10               ; =16
1010a49d4: 95ae09da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a49d8: b4000540    	cbz	x0, 0x1010a4a80 <__text+0x109ca80>
1010a49dc: aa0003f3    	mov	x19, x0
1010a49e0: f94063e8    	ldr	x8, [sp, #0xc0]
1010a49e4: f9400114    	ldr	x20, [x8]
1010a49e8: f00f6cb5    	adrp	x21, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1010a49ec: f00f6d37    	adrp	x23, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
1010a49f0: d00f6cb8    	adrp	x24, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1010a49f4: d280001c    	mov	x28, #0x0               ; =0
1010a49f8: f947beb6    	ldr	x22, [x21, #0xf78] ; m_isPlugin
1010a49fc: f946eaf9    	ldr	x25, [x23, #0xdd0] ; isWeClawBot
1010a4a00: f943c71a    	ldr	x26, [x24, #0x788] ; safeAddObject:
1010a4a04: f94063e8    	ldr	x8, [sp, #0xc0]
1010a4a08: f9400108    	ldr	x8, [x8]
1010a4a0c: eb14011f    	cmp	x8, x20
1010a4a10: 54000060    	b.eq	0x1010a4a1c <__text+0x109ca1c>
1010a4a14: f94027e0    	ldr	x0, [sp, #0x48]
1010a4a18: 95ae09ce    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1010a4a1c: f9405fe8    	ldr	x8, [sp, #0xb8]
1010a4a20: f87c791b    	ldr	x27, [x8, x28, lsl #3]
1010a4a24: aa1b03e0    	mov	x0, x27
1010a4a28: aa1603e1    	mov	x1, x22
1010a4a2c: 95ae09c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4a30: 37000120    	tbnz	w0, #0x0, 0x1010a4a54 <__text+0x109ca54>
1010a4a34: aa1b03e0    	mov	x0, x27
1010a4a38: aa1903e1    	mov	x1, x25
1010a4a3c: 95ae09c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4a40: 370000a0    	tbnz	w0, #0x0, 0x1010a4a54 <__text+0x109ca54>
1010a4a44: f94023e0    	ldr	x0, [sp, #0x40]
1010a4a48: aa1a03e1    	mov	x1, x26
1010a4a4c: aa1b03e2    	mov	x2, x27
1010a4a50: 95ae09bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4a54: 9100079c    	add	x28, x28, #0x1
1010a4a58: eb1c027f    	cmp	x19, x28
1010a4a5c: 54fffd41    	b.ne	0x1010a4a04 <__text+0x109ca04>
1010a4a60: 9102c3e2    	add	x2, sp, #0xb0
1010a4a64: 9106c3e3    	add	x3, sp, #0x1b0
1010a4a68: f94027e0    	ldr	x0, [sp, #0x48]
1010a4a6c: f9401fe1    	ldr	x1, [sp, #0x38]
1010a4a70: 52800204    	mov	w4, #0x10               ; =16
1010a4a74: 95ae09b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4a78: aa0003f3    	mov	x19, x0
1010a4a7c: b5fffbc0    	cbnz	x0, 0x1010a49f4 <__text+0x109c9f4>
1010a4a80: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a4a84: f9420501    	ldr	x1, [x8, #0x408] ; filtInContacts:
1010a4a88: f94033f4    	ldr	x20, [sp, #0x60]
1010a4a8c: aa1403e0    	mov	x0, x20
1010a4a90: f94023e2    	ldr	x2, [sp, #0x40]
1010a4a94: 95ae09aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4a98: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a4a9c: f9420901    	ldr	x1, [x8, #0x410] ; getNeedSort
1010a4aa0: aa1403e0    	mov	x0, x20
1010a4aa4: 95ae09a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4aa8: 340000a0    	cbz	w0, 0x1010a4abc <__text+0x109cabc>
1010a4aac: b00f6da8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
1010a4ab0: f9423901    	ldr	x1, [x8, #0x470] ; sort
1010a4ab4: aa1403e0    	mov	x0, x20
1010a4ab8: 95ae09a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4abc: f00f8668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1010a4ac0: f9454500    	ldr	x0, [x8, #0xa88]
1010a4ac4: f94017e8    	ldr	x8, [sp, #0x28]
1010a4ac8: b8686a88    	ldr	w8, [x20, x8]
1010a4acc: f90003e8    	str	x8, [sp]
1010a4ad0: f00ea522    	adrp	x2, 0x11e54b000 <dyld_stub_binder+0x11e54b000>
1010a4ad4: 9126a042    	add	x2, x2, #0x9a8
1010a4ad8: f9402fe1    	ldr	x1, [sp, #0x58]
1010a4adc: 95ae0998    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4ae0: aa1d03fd    	mov	x29, x29
1010a4ae4: 95ae0999    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a4ae8: aa0003f3    	mov	x19, x0
1010a4aec: f94013e1    	ldr	x1, [sp, #0x20]
1010a4af0: 95ae0993    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4af4: aa0003f7    	mov	x23, x0
1010a4af8: f9402be0    	ldr	x0, [sp, #0x50]
1010a4afc: 95ae0996    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4b00: aa1303e0    	mov	x0, x19
1010a4b04: 95ae0994    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4b08: 4f00e400    	movi.16b	v0, #0x0
1010a4b0c: ad0483e0    	stp	q0, q0, [sp, #0x90]
1010a4b10: ad0383e0    	stp	q0, q0, [sp, #0x70]
1010a4b14: f94037e8    	ldr	x8, [sp, #0x68]
1010a4b18: f8686a80    	ldr	x0, [x20, x8]
1010a4b1c: 95ae0987    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1010a4b20: 9101c3e2    	add	x2, sp, #0x70
1010a4b24: 9104c3e3    	add	x3, sp, #0x130
1010a4b28: f9002be0    	str	x0, [sp, #0x50]
1010a4b2c: f9401fe1    	ldr	x1, [sp, #0x38]
1010a4b30: 52800204    	mov	w4, #0x10               ; =16
1010a4b34: 95ae0982    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4b38: b4000760    	cbz	x0, 0x1010a4c24 <__text+0x109cc24>
1010a4b3c: aa0003f3    	mov	x19, x0
1010a4b40: f94043e8    	ldr	x8, [sp, #0x80]
1010a4b44: f9400118    	ldr	x24, [x8]
1010a4b48: d2800019    	mov	x25, #0x0               ; =0
1010a4b4c: 900f8308    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1010a4b50: f947f11b    	ldr	x27, [x8, #0xfe0] ; objectForKey:
1010a4b54: 900f82e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1010a4b58: f9435116    	ldr	x22, [x8, #0x6a0] ; count
1010a4b5c: 900f6cc8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1010a4b60: f944d51a    	ldr	x26, [x8, #0x9a8] ; safeAppendString:
1010a4b64: f94043e8    	ldr	x8, [sp, #0x80]
1010a4b68: f9400108    	ldr	x8, [x8]
1010a4b6c: eb18011f    	cmp	x8, x24
1010a4b70: 54000060    	b.eq	0x1010a4b7c <__text+0x109cb7c>
1010a4b74: f9402be0    	ldr	x0, [sp, #0x50]
1010a4b78: 95ae0976    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1010a4b7c: f9403fe8    	ldr	x8, [sp, #0x78]
1010a4b80: f8797914    	ldr	x20, [x8, x25, lsl #3]
1010a4b84: a94627e8    	ldp	x8, x9, [sp, #0x60]
1010a4b88: f8696900    	ldr	x0, [x8, x9]
1010a4b8c: aa1b03e1    	mov	x1, x27
1010a4b90: aa1403e2    	mov	x2, x20
1010a4b94: 95ae096a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4b98: aa1d03fd    	mov	x29, x29
1010a4b9c: 95ae096b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a4ba0: aa0003fc    	mov	x28, x0
1010a4ba4: f00f8668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1010a4ba8: f9454515    	ldr	x21, [x8, #0xa88]
1010a4bac: aa1603e1    	mov	x1, x22
1010a4bb0: 95ae0963    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4bb4: a90003f4    	stp	x20, x0, [sp]
1010a4bb8: aa1503e0    	mov	x0, x21
1010a4bbc: f9402fe1    	ldr	x1, [sp, #0x58]
1010a4bc0: f00ea522    	adrp	x2, 0x11e54b000 <dyld_stub_binder+0x11e54b000>
1010a4bc4: 91262042    	add	x2, x2, #0x988
1010a4bc8: 95ae095d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4bcc: aa1d03fd    	mov	x29, x29
1010a4bd0: 95ae095e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a4bd4: aa0003f4    	mov	x20, x0
1010a4bd8: aa1703e0    	mov	x0, x23
1010a4bdc: aa1a03e1    	mov	x1, x26
1010a4be0: aa1403e2    	mov	x2, x20
1010a4be4: 95ae0956    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4be8: aa1403e0    	mov	x0, x20
1010a4bec: 95ae095a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4bf0: aa1c03e0    	mov	x0, x28
1010a4bf4: 95ae0958    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4bf8: 91000739    	add	x25, x25, #0x1
1010a4bfc: eb19027f    	cmp	x19, x25
1010a4c00: 54fffb21    	b.ne	0x1010a4b64 <__text+0x109cb64>
1010a4c04: 9101c3e2    	add	x2, sp, #0x70
1010a4c08: 9104c3e3    	add	x3, sp, #0x130
1010a4c0c: f9402be0    	ldr	x0, [sp, #0x50]
1010a4c10: f9401fe1    	ldr	x1, [sp, #0x38]
1010a4c14: 52800204    	mov	w4, #0x10               ; =16
1010a4c18: 95ae0949    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4c1c: aa0003f3    	mov	x19, x0
1010a4c20: b5fff940    	cbnz	x0, 0x1010a4b48 <__text+0x109cb48>
1010a4c24: f9402be0    	ldr	x0, [sp, #0x50]
1010a4c28: 95ae094b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4c2c: f00f8668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1010a4c30: f9453500    	ldr	x0, [x8, #0xa68]
1010a4c34: 900e9fc8    	adrp	x8, 0x11e49c000 <dyld_stub_binder+0x11e49c000>
1010a4c38: 9122a108    	add	x8, x8, #0x8a8
1010a4c3c: a9005fe8    	stp	x8, x23, [sp]
1010a4c40: b00d1665    	adrp	x5, 0x11b371000 <dyld_stub_binder+0x11b371000>
1010a4c44: 910874a5    	add	x5, x5, #0x21d
1010a4c48: b00d1667    	adrp	x7, 0x11b371000 <dyld_stub_binder+0x11b371000>
1010a4c4c: 9108c8e7    	add	x7, x7, #0x232
1010a4c50: f9400fe1    	ldr	x1, [sp, #0x18]
1010a4c54: 52800042    	mov	w2, #0x2                ; =2
1010a4c58: d2800003    	mov	x3, #0x0                ; =0
1010a4c5c: 52800004    	mov	w4, #0x0                ; =0
1010a4c60: 528098a6    	mov	w6, #0x4c5              ; =1221
1010a4c64: 95ae0936    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4c68: f94027e0    	ldr	x0, [sp, #0x48]
1010a4c6c: 95ae093a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4c70: f9400be0    	ldr	x0, [sp, #0x10]
1010a4c74: 95ae0938    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4c78: f94023e0    	ldr	x0, [sp, #0x40]
1010a4c7c: 95ae0936    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4c80: aa1703e0    	mov	x0, x23
1010a4c84: 95ae0934    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4c88: b94037e0    	ldr	w0, [sp, #0x34]
1010a4c8c: f85a03a8    	ldur	x8, [x29, #-0x60]
1010a4c90: f00e2a49    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1010a4c94: f9405929    	ldr	x9, [x9, #0xb0]
1010a4c98: f9400129    	ldr	x9, [x9]
1010a4c9c: eb08013f    	cmp	x9, x8
1010a4ca0: 54000121    	b.ne	0x1010a4cc4 <__text+0x109ccc4>
1010a4ca4: 910b03ff    	add	sp, sp, #0x2c0
1010a4ca8: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1010a4cac: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1010a4cb0: a94357f6    	ldp	x22, x21, [sp, #0x30]
1010a4cb4: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1010a4cb8: a94167fa    	ldp	x26, x25, [sp, #0x10]
1010a4cbc: a8c66ffc    	ldp	x28, x27, [sp], #0x60
1010a4cc0: d65f03c0    	ret
1010a4cc4: 95ae092c    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
