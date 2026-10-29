
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104728d64: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
104728d68: 910003fd    	mov	x29, sp
104728d6c: f00dcf08    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104728d70: f947a501    	ldr	x1, [x8, #0xf48] ; selector width
104728d74: 94d3f8f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728d78: 1e6c1001    	fmov	d1, #0.50000000
104728d7c: 1e610800    	fmul	d0, d0, d1
104728d80: 1e611001    	fmov	d1, #3.00000000
104728d84: 1e612800    	fadd	d0, d0, d1
104728d88: a8c17bfd    	ldp	x29, x30, [sp], #0x10
104728d8c: d65f03c0    	ret
