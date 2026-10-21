
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ff8ef8: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104ff8efc: a9017bfd    	stp	x29, x30, [sp, #0x10]
104ff8f00: 910043fd    	add	x29, sp, #0x10
104ff8f04: aa0203e0    	mov	x0, x2
104ff8f08: d00d7ce8    	adrp	x8, 0x11ff96000 <dyld_stub_binder+0x11ff96000>
104ff8f0c: f9473101    	ldr	x1, [x8, #0xe60] ; currentAction
104ff8f10: 94b0b88b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8f14: aa1d03fd    	mov	x29, x29
104ff8f18: 94b0b88c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ff8f1c: aa0003f3    	mov	x19, x0
104ff8f20: d00d7ce8    	adrp	x8, 0x11ff96000 <dyld_stub_binder+0x11ff96000>
104ff8f24: f9479901    	ldr	x1, [x8, #0xf30] ; commentFlag
104ff8f28: 94b0b885    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8f2c: 53114414    	ubfx	w20, w0, #17, #1
104ff8f30: aa1303e0    	mov	x0, x19
104ff8f34: 94b0b888    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ff8f38: aa1403e0    	mov	x0, x20
104ff8f3c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104ff8f40: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104ff8f44: d65f03c0    	ret
