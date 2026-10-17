
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104afa2f8: d10083ff    	sub	sp, sp, #0x20
104afa2fc: a9017bfd    	stp	x29, x30, [sp, #0x10]
104afa300: 910043fd    	add	x29, sp, #0x10
104afa304: 381ff3bf    	sturb	wzr, [x29, #-0x1]
104afa308: 900d9ee8    	adrp	x8, 0x11fed6000 <dyld_stub_binder+0x11fed6000>
104afa30c: f944ed01    	ldr	x1, [x8, #0x9d8] ; GetMsg:LocalID:hasError:needOriginContent:
104afa310: d10007a4    	sub	x4, x29, #0x1
104afa314: 52800005    	mov	w5, #0x0                ; =0
104afa318: 94c4b389    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104afa31c: aa1d03fd    	mov	x29, x29
104afa320: 94c4b38a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104afa324: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104afa328: 910083ff    	add	sp, sp, #0x20
104afa32c: 14c4b391    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>