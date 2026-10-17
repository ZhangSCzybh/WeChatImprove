
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100311f44: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
100311f48: a9014ff4    	stp	x20, x19, [sp, #0x10]
100311f4c: a9027bfd    	stp	x29, x30, [sp, #0x20]
100311f50: 910083fd    	add	x29, sp, #0x20
100311f54: aa0203f3    	mov	x19, x2
100311f58: aa0003f4    	mov	x20, x0
100311f5c: d00ff668    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
100311f60: b9842515    	ldrsw	x21, [x8, #0x424]
100311f64: aa0203e0    	mov	x0, x2
100311f68: 95e45474    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100311f6c: 8b150280    	add	x0, x20, x21
100311f70: 95e45487    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
100311f74: aa0003f4    	mov	x20, x0
100311f78: b00fd9c8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
100311f7c: f9431901    	ldr	x1, [x8, #0x630] ; isMsgCanRevoke:
100311f80: aa1303e2    	mov	x2, x19
100311f84: 95e4546e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100311f88: aa0003f5    	mov	x21, x0
100311f8c: aa1303e0    	mov	x0, x19
100311f90: 95e45471    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100311f94: aa1403e0    	mov	x0, x20
100311f98: 95e4546f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100311f9c: aa1503e0    	mov	x0, x21
100311fa0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100311fa4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100311fa8: a8c357f6    	ldp	x22, x21, [sp], #0x30
100311fac: d65f03c0    	ret