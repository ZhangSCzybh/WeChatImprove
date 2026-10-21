
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104adae04: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104adae08: a9014ff4    	stp	x20, x19, [sp, #0x10]
104adae0c: a9027bfd    	stp	x29, x30, [sp, #0x20]
104adae10: 910083fd    	add	x29, sp, #0x20
104adae14: aa0303f3    	mov	x19, x3
104adae18: f9400814    	ldr	x20, [x0, #0x10]
104adae1c: f00da548    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104adae20: f9450d01    	ldr	x1, [x8, #0xa18] ; getKeyAtSection:
104adae24: 94c530c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adae28: aa1d03fd    	mov	x29, x29
104adae2c: 94c530c7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adae30: aa0003f5    	mov	x21, x0
104adae34: d00db148    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104adae38: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
104adae3c: aa1403e0    	mov	x0, x20
104adae40: aa1503e2    	mov	x2, x21
104adae44: 94c530be    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adae48: aa1d03fd    	mov	x29, x29
104adae4c: 94c530bf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adae50: aa0003f4    	mov	x20, x0
104adae54: 900d9b08    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104adae58: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
104adae5c: aa1303e2    	mov	x2, x19
104adae60: 94c530b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adae64: aa1d03fd    	mov	x29, x29
104adae68: 94c530b8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adae6c: aa0003f3    	mov	x19, x0
104adae70: aa1403e0    	mov	x0, x20
104adae74: 94c530b8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adae78: aa1503e0    	mov	x0, x21
104adae7c: 94c530b6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adae80: aa1303e0    	mov	x0, x19
104adae84: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104adae88: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104adae8c: a8c357f6    	ldp	x22, x21, [sp], #0x30
104adae90: 14c530b8    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
