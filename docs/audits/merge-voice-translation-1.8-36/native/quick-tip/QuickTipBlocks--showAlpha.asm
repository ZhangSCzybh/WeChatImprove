
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10627958c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
106279590: a9017bfd    	stp	x29, x30, [sp, #0x10]
106279594: 910043fd    	add	x29, sp, #0x10
106279598: 91008000    	add	x0, x0, #0x20
10627959c: 9466b6fc    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1062795a0: aa0003f3    	mov	x19, x0
1062795a4: b00cf468    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1062795a8: f9476901    	ldr	x1, [x8, #0xed0] ; setAlpha:
1062795ac: 1e6e1000    	fmov	d0, #1.00000000
1062795b0: 9466b6e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062795b4: aa1303e0    	mov	x0, x19
1062795b8: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1062795bc: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1062795c0: 1466b6e5    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>