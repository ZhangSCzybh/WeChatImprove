
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f6925c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
100f69260: a9017bfd    	stp	x29, x30, [sp, #0x10]
100f69264: 910043fd    	add	x29, sp, #0x10
100f69268: aa0003f3    	mov	x19, x0
100f6926c: 900f78e8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f69270: f9410514    	ldr	x20, [x8, #0x208] ; sourceTailSize
100f69274: aa1403e1    	mov	x1, x20
100f69278: 95b2f7b1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6927c: 900e3428    	adrp	x8, 0x11d5ed000 <dyld_stub_binder+0x11d5ed000>
100f69280: f9417908    	ldr	x8, [x8, #0x2f0]
100f69284: 6d400d02    	ldp	d2, d3, [x8]
100f69288: 1e622000    	fcmp	d0, d2
100f6928c: 1e630420    	fccmp	d1, d3, #0x0, eq
100f69290: 54000121    	b.ne	0x100f692b4 <__text+0xf612b4>
100f69294: 900f78e8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f69298: f9410901    	ldr	x1, [x8, #0x210] ; calculateCommonTailSize
100f6929c: aa1303e0    	mov	x0, x19
100f692a0: 95b2f7a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f692a4: 900f78e8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f692a8: f9410d01    	ldr	x1, [x8, #0x218] ; setSourceTailSize:
100f692ac: aa1303e0    	mov	x0, x19
100f692b0: 95b2f7a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f692b4: aa1303e0    	mov	x0, x19
100f692b8: aa1403e1    	mov	x1, x20
100f692bc: a9417bfd    	ldp	x29, x30, [sp, #0x10]
100f692c0: a8c24ff4    	ldp	x20, x19, [sp], #0x20
100f692c4: 15b2f79e    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>