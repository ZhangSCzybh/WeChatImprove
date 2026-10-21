
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101008dbc: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
101008dc0: a9014ff4    	stp	x20, x19, [sp, #0x10]
101008dc4: a9027bfd    	stp	x29, x30, [sp, #0x20]
101008dc8: 910083fd    	add	x29, sp, #0x20
101008dcc: aa0203f3    	mov	x19, x2
101008dd0: aa0003f4    	mov	x20, x0
101008dd4: aa0203e0    	mov	x0, x2
101008dd8: 95b078d8    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101008ddc: 900f7408    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
101008de0: f9401115    	ldr	x21, [x8, #0x20] ; completeHandler
101008de4: aa1403e0    	mov	x0, x20
101008de8: aa1503e1    	mov	x1, x21
101008dec: 95b078d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101008df0: aa1d03fd    	mov	x29, x29
101008df4: 95b078d5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101008df8: aa0003f6    	mov	x22, x0
101008dfc: 95b078d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101008e00: b4000196    	cbz	x22, 0x101008e30 <__text+0x1000e30>
101008e04: aa1403e0    	mov	x0, x20
101008e08: aa1503e1    	mov	x1, x21
101008e0c: 95b078cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101008e10: aa1d03fd    	mov	x29, x29
101008e14: 95b078cd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101008e18: aa0003f4    	mov	x20, x0
101008e1c: f9400808    	ldr	x8, [x0, #0x10]
101008e20: aa1303e1    	mov	x1, x19
101008e24: d63f0100    	blr	x8
101008e28: aa1403e0    	mov	x0, x20
101008e2c: 95b078ca    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101008e30: aa1303e0    	mov	x0, x19
101008e34: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101008e38: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101008e3c: a8c357f6    	ldp	x22, x21, [sp], #0x30
101008e40: 15b078c5    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
