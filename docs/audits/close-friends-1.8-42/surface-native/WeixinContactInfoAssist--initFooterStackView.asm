
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a9503f0: d10183ff    	sub	sp, sp, #0x60
10a9503f4: a90357f6    	stp	x22, x21, [sp, #0x30]
10a9503f8: a9044ff4    	stp	x20, x19, [sp, #0x40]
10a9503fc: a9057bfd    	stp	x29, x30, [sp, #0x50]
10a950400: 910143fd    	add	x29, sp, #0x50
10a950404: aa0003f3    	mov	x19, x0
10a950408: f00b1808    	adrp	x8, 0x120c53000 <dyld_stub_binder+0x120c53000>
10a95040c: 52800029    	mov	w9, #0x1                ; =1
10a950410: 390be909    	strb	w9, [x8, #0x2fa]
10a950414: f00ac128    	adrp	x8, 0x120177000 <dyld_stub_binder+0x120177000>
10a950418: f945d500    	ldr	x0, [x8, #0xba8]
10a95041c: 900abda8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10a950420: f9461d01    	ldr	x1, [x8, #0xc38] ; new
10a950424: 953c2c08    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950428: f00ac948    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a95042c: b9873516    	ldrsw	x22, [x8, #0x734] ; ivar WeixinContactInfoAssist._footerStackView
10a950430: f8766a68    	ldr	x8, [x19, x22]
10a950434: f8366a60    	str	x0, [x19, x22]
10a950438: aa0803e0    	mov	x0, x8
10a95043c: 953c2c08    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a950440: f8766a60    	ldr	x0, [x19, x22]
10a950444: 900aa848    	adrp	x8, 0x11fe58000 <dyld_stub_binder+0x11fe58000>
10a950448: f943b501    	ldr	x1, [x8, #0x768] ; setAxis:
10a95044c: 52800022    	mov	w2, #0x1                ; =1
10a950450: 953c2bfd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950454: f8766a60    	ldr	x0, [x19, x22]
10a950458: d00abda8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10a95045c: f9472d01    	ldr	x1, [x8, #0xe58] ; setAlignment:
10a950460: 52800062    	mov	w2, #0x3                ; =3
10a950464: 953c2bf8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950468: f00ac948    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a95046c: b986f108    	ldrsw	x8, [x8, #0x6f0] ; ivar WeixinContactInfoAssist.m_tableViewInfo
10a950470: f8686a60    	ldr	x0, [x19, x8]
10a950474: d00abdc8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10a950478: f947bd01    	ldr	x1, [x8, #0xf78] ; tableView
10a95047c: 953c2bf2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950480: aa1d03fd    	mov	x29, x29
10a950484: 953c2bf3    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a950488: aa0003f4    	mov	x20, x0
10a95048c: 900aa808    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
10a950490: f9452101    	ldr	x1, [x8, #0xa40] ; tableFooterView
10a950494: 953c2bec    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950498: aa1d03fd    	mov	x29, x29
10a95049c: 953c2bed    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9504a0: aa0003f5    	mov	x21, x0
10a9504a4: f8766a62    	ldr	x2, [x19, x22]
10a9504a8: d00abd68    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10a9504ac: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
10a9504b0: 953c2be5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9504b4: aa1503e0    	mov	x0, x21
10a9504b8: 953c2be9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9504bc: aa1403e0    	mov	x0, x20
10a9504c0: 953c2be7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9504c4: f8766a60    	ldr	x0, [x19, x22]
10a9504c8: d00964e8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10a9504cc: f947dd08    	ldr	x8, [x8, #0xfb8]
10a9504d0: f90007e8    	str	x8, [sp, #0x8]
10a9504d4: b0072188    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10a9504d8: fd41c500    	ldr	d0, [x8, #0x388]
10a9504dc: 90000008    	adrp	x8, 0x10a950000 <_Flutter_MMFoundation_BindContext+0x6e2bbe4>
10a9504e0: 91149108    	add	x8, x8, #0x524
10a9504e4: d0096569    	adrp	x9, 0x11d5fe000 <dyld_stub_binder+0x11d5fe000>
10a9504e8: 91010129    	add	x9, x9, #0x40
10a9504ec: fd000be0    	str	d0, [sp, #0x10]
10a9504f0: a901a7e8    	stp	x8, x9, [sp, #0x18]
10a9504f4: f90017f3    	str	x19, [sp, #0x28]
10a9504f8: d00aa828    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
10a9504fc: f943b501    	ldr	x1, [x8, #0x768] ; mas_makeConstraints:
10a950500: 910023e2    	add	x2, sp, #0x8
10a950504: 953c2bd0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950508: aa1d03fd    	mov	x29, x29
10a95050c: 953c2bd8    	bl	0x10f85b46c <_UR_96F1_B25D+0x3a640dc>
10a950510: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10a950514: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10a950518: a94357f6    	ldp	x22, x21, [sp, #0x30]
10a95051c: 910183ff    	add	sp, sp, #0x60
10a950520: d65f03c0    	ret
