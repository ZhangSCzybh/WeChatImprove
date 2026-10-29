
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a702a8: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104a702ac: a9017bfd    	stp	x29, x30, [sp, #0x10]
104a702b0: 910043fd    	add	x29, sp, #0x10
104a702b4: aa0003f3    	mov	x19, x0
104a702b8: f00db808    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a702bc: f9455500    	ldr	x0, [x8, #0xaa8] ; class NSMutableArray
104a702c0: 94c6dba6    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104a702c4: f9401268    	ldr	x8, [x19, #0x20]
104a702c8: f9001260    	str	x0, [x19, #0x20]
104a702cc: aa0803e0    	mov	x0, x8
104a702d0: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104a702d4: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104a702d8: 14c6db9f    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
