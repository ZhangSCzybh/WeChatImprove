
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108fe6584: d10183ff    	sub	sp, sp, #0x60
108fe6588: 6d0123e9    	stp	d9, d8, [sp, #0x10]
108fe658c: a9025ff8    	stp	x24, x23, [sp, #0x20]
108fe6590: a90357f6    	stp	x22, x21, [sp, #0x30]
108fe6594: a9044ff4    	stp	x20, x19, [sp, #0x40]
108fe6598: a9057bfd    	stp	x29, x30, [sp, #0x50]
108fe659c: 910143fd    	add	x29, sp, #0x50
108fe65a0: aa0003f3    	mov	x19, x0
108fe65a4: f00be328    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
108fe65a8: 52800029    	mov	w9, #0x1                ; =1
108fe65ac: 39388909    	strb	w9, [x8, #0xe22]
108fe65b0: f00b8f48    	adrp	x8, 0x1201d1000 <dyld_stub_binder+0x1201d1000>
108fe65b4: f9411508    	ldr	x8, [x8, #0x228] ; `UC
108fe65b8: a90023e0    	stp	x0, x8, [sp]
108fe65bc: 900b72c8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
108fe65c0: f940a901    	ldr	x1, [x8, #0x150] ; layoutSubviews
108fe65c4: 910003e0    	mov	x0, sp
108fe65c8: 95a1d3a1    	bl	0x10f85b44c <_UR_96F1_B25D+0x3a640bc>
108fe65cc: b00b8e16    	adrp	x22, 0x1201a7000 <dyld_stub_binder+0x1201a7000>
108fe65d0: f9401ac0    	ldr	x0, [x22, #0x30] ; `UC
108fe65d4: 900b8408    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe65d8: f946e514    	ldr	x20, [x8, #0xdc8] ; getTimeLabelMarginLeftCurOri
108fe65dc: aa1403e1    	mov	x1, x20
108fe65e0: 95a1d399    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe65e4: d00b93e8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108fe65e8: b9846d08    	ldrsw	x8, [x8, #0x46c]
108fe65ec: f8686a60    	ldr	x0, [x19, x8]
108fe65f0: f00b7288    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
108fe65f4: f9465515    	ldr	x21, [x8, #0xca8] ; setWcOrigin:
108fe65f8: 9e6703e1    	fmov	d1, xzr
108fe65fc: aa1503e1    	mov	x1, x21
108fe6600: 95a1d391    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe6604: f9401ac0    	ldr	x0, [x22, #0x30] ; `UC
108fe6608: 900b8408    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe660c: f946e101    	ldr	x1, [x8, #0xdc0] ; getTimeLabelWidthCurOri
108fe6610: 95a1d38d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe6614: 1e604008    	fmov	d8, d0
108fe6618: d00b93e8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108fe661c: b9845d17    	ldrsw	x23, [x8, #0x45c]
108fe6620: f8776a60    	ldr	x0, [x19, x23]
108fe6624: d00b8928    	adrp	x8, 0x12010c000 <dyld_stub_binder+0x12010c000>
108fe6628: f9402901    	ldr	x1, [x8, #0x50] ; y
108fe662c: 95a1d386    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe6630: 1e604001    	fmov	d1, d0
108fe6634: f8776a60    	ldr	x0, [x19, x23]
108fe6638: aa1503e1    	mov	x1, x21
108fe663c: 1e604100    	fmov	d0, d8
108fe6640: 95a1d381    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe6644: f8776a60    	ldr	x0, [x19, x23]
108fe6648: d00b72a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108fe664c: f9432501    	ldr	x1, [x8, #0x648] ; centerY
108fe6650: 95a1d37d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe6654: d00b93e8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108fe6658: b9846915    	ldrsw	x21, [x8, #0x468]
108fe665c: f8756a60    	ldr	x0, [x19, x21]
108fe6660: d00b72a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108fe6664: f9401901    	ldr	x1, [x8, #0x30] ; setCenterY:
108fe6668: 95a1d377    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe666c: b00b8928    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
108fe6670: f947a501    	ldr	x1, [x8, #0xf48] ; width
108fe6674: aa1303e0    	mov	x0, x19
108fe6678: 95a1d373    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe667c: 1e604008    	fmov	d8, d0
108fe6680: f9401ac0    	ldr	x0, [x22, #0x30] ; `UC
108fe6684: aa1403e1    	mov	x1, x20
108fe6688: 95a1d36f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe668c: 1e603900    	fsub	d0, d8, d0
108fe6690: f8756a60    	ldr	x0, [x19, x21]
108fe6694: d00b72a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108fe6698: f9401501    	ldr	x1, [x8, #0x28] ; setRight:
108fe669c: 95a1d36a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe66a0: a9457bfd    	ldp	x29, x30, [sp, #0x50]
108fe66a4: a9444ff4    	ldp	x20, x19, [sp, #0x40]
108fe66a8: a94357f6    	ldp	x22, x21, [sp, #0x30]
108fe66ac: a9425ff8    	ldp	x24, x23, [sp, #0x20]
108fe66b0: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
108fe66b4: 910183ff    	add	sp, sp, #0x60
108fe66b8: d65f03c0    	ret
