
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106279700: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
106279704: a9017bfd    	stp	x29, x30, [sp, #0x10]
106279708: 910043fd    	add	x29, sp, #0x10
10627970c: 91008000    	add	x0, x0, #0x20
106279710: 9466b69f    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
106279714: aa0003f3    	mov	x19, x0
106279718: b00cf468    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10627971c: f9476901    	ldr	x1, [x8, #0xed0] ; setAlpha:
106279720: 9e6703e0    	fmov	d0, xzr
106279724: 9466b686    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106279728: aa1303e0    	mov	x0, x19
10627972c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
106279730: a8c24ff4    	ldp	x20, x19, [sp], #0x20
106279734: 1466b688    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>