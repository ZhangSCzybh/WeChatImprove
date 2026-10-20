
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105c0dafc: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
105c0db00: a9017bfd    	stp	x29, x30, [sp, #0x10]
105c0db04: 910043fd    	add	x29, sp, #0x10
105c0db08: d00d3128    	adrp	x8, 0x120233000 <dyld_stub_binder+0x120233000>
105c0db0c: b9803d08    	ldrsw	x8, [x8, #0x3c]
105c0db10: 8b080013    	add	x19, x0, x8
105c0db14: 6d400660    	ldp	d0, d1, [x19]
105c0db18: 900bcf08    	adrp	x8, 0x11d5ed000 <dyld_stub_binder+0x11d5ed000>
105c0db1c: f9417908    	ldr	x8, [x8, #0x2f0]
105c0db20: 6d400d02    	ldp	d2, d3, [x8]
105c0db24: 1e622000    	fcmp	d0, d2
105c0db28: 1e630420    	fccmp	d1, d3, #0x0, eq
105c0db2c: 540000a1    	b.ne	0x105c0db40 <_Flutter_MMFoundation_BindContext+0x20e9724>
105c0db30: b00d15e8    	adrp	x8, 0x11feca000 <dyld_stub_binder+0x11feca000>
105c0db34: f9438101    	ldr	x1, [x8, #0x700] ; calculateContentTextSize
105c0db38: 94806581    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0db3c: 6d400660    	ldp	d0, d1, [x19]
105c0db40: a9417bfd    	ldp	x29, x30, [sp, #0x10]
105c0db44: a8c24ff4    	ldp	x20, x19, [sp], #0x20
105c0db48: d65f03c0    	ret