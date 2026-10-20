
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a9be3f8: 6dbc23e9    	stp	d9, d8, [sp, #-0x40]!
10a9be3fc: a90157f6    	stp	x22, x21, [sp, #0x10]
10a9be400: a9024ff4    	stp	x20, x19, [sp, #0x20]
10a9be404: a9037bfd    	stp	x29, x30, [sp, #0x30]
10a9be408: 9100c3fd    	add	x29, sp, #0x30
10a9be40c: aa0303f4    	mov	x20, x3
10a9be410: 1e604028    	fmov	d8, d1
10a9be414: 1e604009    	fmov	d9, d0
10a9be418: aa0203f3    	mov	x19, x2
10a9be41c: b00b14a8    	adrp	x8, 0x120c53000 <dyld_stub_binder+0x120c53000>
10a9be420: 52800029    	mov	w9, #0x1                ; =1
10a9be424: 39140509    	strb	w9, [x8, #0x501]
10a9be428: aa0203e0    	mov	x0, x2
10a9be42c: 953a7405    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9be430: aa1403e0    	mov	x0, x20
10a9be434: 953a7403    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9be438: f0096168    	adrp	x8, 0x11d5ed000 <dyld_stub_binder+0x11d5ed000>
10a9be43c: f9417908    	ldr	x8, [x8, #0x2f0]
10a9be440: 6d400500    	ldp	d0, d1, [x8]
10a9be444: 1e602120    	fcmp	d9, d0
10a9be448: 1e610500    	fccmp	d8, d1, #0x0, eq
10a9be44c: 540004e0    	b.eq	0x10a9be4e8 <_Flutter_MMFoundation_BindContext+0x6e9a0cc>
10a9be450: b00abda8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a9be454: f946d515    	ldr	x21, [x8, #0xda8]
10a9be458: 900aba68    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10a9be45c: f9442501    	ldr	x1, [x8, #0x848] ; size
10a9be460: aa1303e0    	mov	x0, x19
10a9be464: 953a73f8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be468: 1e682120    	fcmp	d9, d8
10a9be46c: 1e694d02    	fcsel	d2, d8, d9, mi
10a9be470: 1e780042    	fcvtzs	w2, d2
10a9be474: d00aa6e8    	adrp	x8, 0x11fe9c000 <dyld_stub_binder+0x11fe9c000>
10a9be478: f9450101    	ldr	x1, [x8, #0xa00] ; calculateFitSize:maxWidth:maxHeight:
10a9be47c: aa1503e0    	mov	x0, x21
10a9be480: aa0203e3    	mov	x3, x2
10a9be484: 953a73f0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be488: 1e6e1002    	fmov	d2, #1.00000000
10a9be48c: 1e622000    	fcmp	d0, d2
10a9be490: 1e604c48    	fcsel	d8, d2, d0, mi
10a9be494: 1e622020    	fcmp	d1, d2
10a9be498: 1e614c49    	fcsel	d9, d2, d1, mi
10a9be49c: 9e6703e2    	fmov	d2, xzr
10a9be4a0: 1e604100    	fmov	d0, d8
10a9be4a4: 1e604121    	fmov	d1, d9
10a9be4a8: 52800000    	mov	w0, #0x0                ; =0
10a9be4ac: 953a7445    	bl	0x10f85b5c0 <_UR_96F1_B25D+0x3a64230>
10a9be4b0: f00aba08    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
10a9be4b4: f941ed01    	ldr	x1, [x8, #0x3d8] ; drawInRect:
10a9be4b8: 9e6703e0    	fmov	d0, xzr
10a9be4bc: 9e6703e1    	fmov	d1, xzr
10a9be4c0: aa1303e0    	mov	x0, x19
10a9be4c4: 1e604102    	fmov	d2, d8
10a9be4c8: 1e604123    	fmov	d3, d9
10a9be4cc: 953a73de    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be4d0: f9400a88    	ldr	x8, [x20, #0x10]
10a9be4d4: aa1403e0    	mov	x0, x20
10a9be4d8: d63f0100    	blr	x8
10a9be4dc: 34000300    	cbz	w0, 0x10a9be53c <_Flutter_MMFoundation_BindContext+0x6e9a120>
10a9be4e0: 953a7467    	bl	0x10f85b67c <_UR_96F1_B25D+0x3a642ec>
10a9be4e4: 14000014    	b	0x10a9be534 <_Flutter_MMFoundation_BindContext+0x6e9a118>
10a9be4e8: 1e6e1000    	fmov	d0, #1.00000000
10a9be4ec: 1e6e1001    	fmov	d1, #1.00000000
10a9be4f0: 9e6703e2    	fmov	d2, xzr
10a9be4f4: 52800000    	mov	w0, #0x0                ; =0
10a9be4f8: 953a7432    	bl	0x10f85b5c0 <_UR_96F1_B25D+0x3a64230>
10a9be4fc: f00aba08    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
10a9be500: f941ed01    	ldr	x1, [x8, #0x3d8] ; drawInRect:
10a9be504: 9e6703e0    	fmov	d0, xzr
10a9be508: 9e6703e1    	fmov	d1, xzr
10a9be50c: 1e6e1002    	fmov	d2, #1.00000000
10a9be510: 1e6e1003    	fmov	d3, #1.00000000
10a9be514: aa1303e0    	mov	x0, x19
10a9be518: 953a73cb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be51c: f9400a88    	ldr	x8, [x20, #0x10]
10a9be520: aa1403e0    	mov	x0, x20
10a9be524: d63f0100    	blr	x8
10a9be528: aa0003f5    	mov	x21, x0
10a9be52c: 953a7454    	bl	0x10f85b67c <_UR_96F1_B25D+0x3a642ec>
10a9be530: 360002f5    	tbz	w21, #0x0, 0x10a9be58c <_Flutter_MMFoundation_BindContext+0x6e9a170>
10a9be534: d2800015    	mov	x21, #0x0               ; =0
10a9be538: 14000018    	b	0x10a9be598 <_Flutter_MMFoundation_BindContext+0x6e9a17c>
10a9be53c: 953a744b    	bl	0x10f85b668 <_UR_96F1_B25D+0x3a642d8>
10a9be540: aa1d03fd    	mov	x29, x29
10a9be544: 953a73c3    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9be548: aa0003f6    	mov	x22, x0
10a9be54c: f00aa708    	adrp	x8, 0x11fea1000 <dyld_stub_binder+0x11fea1000>
10a9be550: f9413501    	ldr	x1, [x8, #0x268] ; capInsets
10a9be554: aa1303e0    	mov	x0, x19
10a9be558: 953a73bb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be55c: f00aa808    	adrp	x8, 0x11fec1000 <dyld_stub_binder+0x11fec1000>
10a9be560: f940a501    	ldr	x1, [x8, #0x148] ; resizableImageWithCapInsets:resizingMode:
10a9be564: aa1603e0    	mov	x0, x22
10a9be568: 52800022    	mov	w2, #0x1                ; =1
10a9be56c: 953a73b6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be570: aa1d03fd    	mov	x29, x29
10a9be574: 953a73b7    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9be578: aa0003f5    	mov	x21, x0
10a9be57c: aa1603e0    	mov	x0, x22
10a9be580: 953a73b7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be584: 953a743e    	bl	0x10f85b67c <_UR_96F1_B25D+0x3a642ec>
10a9be588: 14000004    	b	0x10a9be598 <_Flutter_MMFoundation_BindContext+0x6e9a17c>
10a9be58c: aa1303e0    	mov	x0, x19
10a9be590: 953a73ac    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9be594: aa1303f5    	mov	x21, x19
10a9be598: aa1403e0    	mov	x0, x20
10a9be59c: 953a73b0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be5a0: aa1303e0    	mov	x0, x19
10a9be5a4: 953a73ae    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be5a8: aa1503e0    	mov	x0, x21
10a9be5ac: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10a9be5b0: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10a9be5b4: a94157f6    	ldp	x22, x21, [sp, #0x10]
10a9be5b8: 6cc423e9    	ldp	d9, d8, [sp], #0x40
10a9be5bc: 153a73af    	b	0x10f85b478 <_UR_96F1_B25D+0x3a640e8>