
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f6920c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
100f69210: a9017bfd    	stp	x29, x30, [sp, #0x10]
100f69214: 910043fd    	add	x29, sp, #0x10
100f69218: 900f9408    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100f6921c: b9850508    	ldrsw	x8, [x8, #0x504]
100f69220: 8b080013    	add	x19, x0, x8
100f69224: 6d400660    	ldp	d0, d1, [x19]
100f69228: 900e3428    	adrp	x8, 0x11d5ed000 <dyld_stub_binder+0x11d5ed000>
100f6922c: f9417908    	ldr	x8, [x8, #0x2f0]
100f69230: 6d400d02    	ldp	d2, d3, [x8]
100f69234: 1e622000    	fcmp	d0, d2
100f69238: 1e630420    	fccmp	d1, d3, #0x0, eq
100f6923c: 540000a1    	b.ne	0x100f69250 <__text+0xf61250>
100f69240: 900f78e8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f69244: f9410101    	ldr	x1, [x8, #0x200] ; calculateReplyTextSize
100f69248: 95b2f7bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6924c: 6d400660    	ldp	d0, d1, [x19]
100f69250: a9417bfd    	ldp	x29, x30, [sp, #0x10]
100f69254: a8c24ff4    	ldp	x20, x19, [sp], #0x20
100f69258: d65f03c0    	ret