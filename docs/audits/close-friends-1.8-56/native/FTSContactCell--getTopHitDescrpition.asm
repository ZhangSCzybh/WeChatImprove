
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1016a45b8: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1016a45bc: a9014ff4    	stp	x20, x19, [sp, #0x10]
1016a45c0: a9027bfd    	stp	x29, x30, [sp, #0x20]
1016a45c4: 910083fd    	add	x29, sp, #0x20
1016a45c8: d00fac68    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
1016a45cc: 52800029    	mov	w9, #0x1                ; =1
1016a45d0: 39180509    	strb	w9, [x8, #0x601]
1016a45d4: 900f5a68    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1016a45d8: b9838d08    	ldrsw	x8, [x8, #0x38c]
1016a45dc: 38686808    	ldrb	w8, [x0, x8]
1016a45e0: 7100051f    	cmp	w8, #0x1
1016a45e4: 54000e61    	b.ne	0x1016a47b0 <__text+0x169c7b0>
1016a45e8: aa0003f3    	mov	x19, x0
1016a45ec: 900f5a68    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1016a45f0: b9839114    	ldrsw	x20, [x8, #0x390]
1016a45f4: f8746800    	ldr	x0, [x0, x20]
1016a45f8: d00f3d28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1016a45fc: f942a901    	ldr	x1, [x8, #0x550] ; isOpenImKefuContact
1016a4600: 95960acf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a4604: 370000c0    	tbnz	w0, #0x0, 0x1016a461c <__text+0x169c61c>
1016a4608: f8746a60    	ldr	x0, [x19, x20]
1016a460c: d00f4008    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1016a4610: f9443501    	ldr	x1, [x8, #0x868] ; isFTSKFContact
1016a4614: 95960aca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a4618: 36000480    	tbz	w0, #0x0, 0x1016a46a8 <__text+0x169c6a8>
1016a461c: f00e7733    	adrp	x19, 0x11e58b000 <dyld_stub_binder+0x11e58b000>
1016a4620: 9120a273    	add	x19, x19, #0x828
1016a4624: f00f5668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1016a4628: f945e900    	ldr	x0, [x8, #0xbd0]
1016a462c: 900f52e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1016a4630: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1016a4634: 95960ac2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a4638: aa1d03fd    	mov	x29, x29
1016a463c: 95960ac3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a4640: aa0003f4    	mov	x20, x0
1016a4644: f00f5668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1016a4648: f9462900    	ldr	x0, [x8, #0xc50]
1016a464c: f00f52c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1016a4650: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1016a4654: 95960aba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a4658: aa0003e2    	mov	x2, x0
1016a465c: b00f3ca8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1016a4660: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
1016a4664: aa1403e0    	mov	x0, x20
1016a4668: 95960ab5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a466c: aa1d03fd    	mov	x29, x29
1016a4670: 95960ab6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a4674: aa0003f5    	mov	x21, x0
1016a4678: b00f3ca8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1016a467c: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
1016a4680: aa1303e2    	mov	x2, x19
1016a4684: 95960aae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a4688: aa1d03fd    	mov	x29, x29
1016a468c: 95960aaf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a4690: aa0003f3    	mov	x19, x0
1016a4694: aa1503e0    	mov	x0, x21
1016a4698: 95960aaf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a469c: aa1403e0    	mov	x0, x20
1016a46a0: 95960aad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a46a4: 14000044    	b	0x1016a47b4 <__text+0x169c7b4>
1016a46a8: f8746a60    	ldr	x0, [x19, x20]
1016a46ac: 900f3e88    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
1016a46b0: f941e501    	ldr	x1, [x8, #0x3c8] ; isWeAppContact
1016a46b4: 95960aa2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a46b8: 36000080    	tbz	w0, #0x0, 0x1016a46c8 <__text+0x169c6c8>
1016a46bc: f00e7733    	adrp	x19, 0x11e58b000 <dyld_stub_binder+0x11e58b000>
1016a46c0: 91212273    	add	x19, x19, #0x848
1016a46c4: 17ffffd8    	b	0x1016a4624 <__text+0x169c624>
1016a46c8: f8746a60    	ldr	x0, [x19, x20]
1016a46cc: f00f3ca8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1016a46d0: f947b501    	ldr	x1, [x8, #0xf68] ; isBrandContact
1016a46d4: 95960a9a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a46d8: 370000c0    	tbnz	w0, #0x0, 0x1016a46f0 <__text+0x169c6f0>
1016a46dc: f8746a60    	ldr	x0, [x19, x20]
1016a46e0: 900f3d68    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
1016a46e4: f9464501    	ldr	x1, [x8, #0xc88] ; isPhotoBrand
1016a46e8: 95960a95    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a46ec: 34000220    	cbz	w0, 0x1016a4730 <__text+0x169c730>
1016a46f0: f8746a60    	ldr	x0, [x19, x20]
1016a46f4: 900f3d48    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
1016a46f8: f9474d01    	ldr	x1, [x8, #0xe98] ; isSubscriptionBrand
1016a46fc: 95960a90    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a4700: 36000080    	tbz	w0, #0x0, 0x1016a4710 <__text+0x169c710>
1016a4704: f00e7533    	adrp	x19, 0x11e54b000 <dyld_stub_binder+0x11e54b000>
1016a4708: 912a2273    	add	x19, x19, #0xa88
1016a470c: 17ffffc6    	b	0x1016a4624 <__text+0x169c624>
1016a4710: f8746a60    	ldr	x0, [x19, x20]
1016a4714: 900f3d08    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
1016a4718: f9437101    	ldr	x1, [x8, #0x6e0] ; isServiceBrand
1016a471c: 95960a88    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a4720: 36000180    	tbz	w0, #0x0, 0x1016a4750 <__text+0x169c750>
1016a4724: f00e7533    	adrp	x19, 0x11e54b000 <dyld_stub_binder+0x11e54b000>
1016a4728: 912aa273    	add	x19, x19, #0xaa8
1016a472c: 17ffffbe    	b	0x1016a4624 <__text+0x169c624>
1016a4730: f8746a60    	ldr	x0, [x19, x20]
1016a4734: d00f4008    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1016a4738: f9443901    	ldr	x1, [x8, #0x870] ; isFinderUser
1016a473c: 95960a80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a4740: 36000180    	tbz	w0, #0x0, 0x1016a4770 <__text+0x169c770>
1016a4744: f00e7733    	adrp	x19, 0x11e58b000 <dyld_stub_binder+0x11e58b000>
1016a4748: 91222273    	add	x19, x19, #0x888
1016a474c: 17ffffb6    	b	0x1016a4624 <__text+0x169c624>
1016a4750: f8746a60    	ldr	x0, [x19, x20]
1016a4754: 900f3d68    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
1016a4758: f9464501    	ldr	x1, [x8, #0xc88] ; isPhotoBrand
1016a475c: 95960a78    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a4760: 36000280    	tbz	w0, #0x0, 0x1016a47b0 <__text+0x169c7b0>
1016a4764: f00e7733    	adrp	x19, 0x11e58b000 <dyld_stub_binder+0x11e58b000>
1016a4768: 9121a273    	add	x19, x19, #0x868
1016a476c: 17ffffae    	b	0x1016a4624 <__text+0x169c624>
1016a4770: f8746a60    	ldr	x0, [x19, x20]
1016a4774: f00f3ca8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1016a4778: f947d101    	ldr	x1, [x8, #0xfa0] ; isChatroom
1016a477c: 95960a70    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a4780: 36000080    	tbz	w0, #0x0, 0x1016a4790 <__text+0x169c790>
1016a4784: f00e7533    	adrp	x19, 0x11e54b000 <dyld_stub_binder+0x11e54b000>
1016a4788: 9129a273    	add	x19, x19, #0xa68
1016a478c: 17ffffa6    	b	0x1016a4624 <__text+0x169c624>
1016a4790: f8746a60    	ldr	x0, [x19, x20]
1016a4794: 900f3cc8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1016a4798: f940cd01    	ldr	x1, [x8, #0x198] ; isMMContact
1016a479c: 95960a68    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a47a0: 34000080    	cbz	w0, 0x1016a47b0 <__text+0x169c7b0>
1016a47a4: f00e7533    	adrp	x19, 0x11e54b000 <dyld_stub_binder+0x11e54b000>
1016a47a8: 91292273    	add	x19, x19, #0xa48
1016a47ac: 17ffff9e    	b	0x1016a4624 <__text+0x169c624>
1016a47b0: d2800013    	mov	x19, #0x0               ; =0
1016a47b4: aa1303e0    	mov	x0, x19
1016a47b8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1016a47bc: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1016a47c0: a8c357f6    	ldp	x22, x21, [sp], #0x30
1016a47c4: 15960a6b    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
