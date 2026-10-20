
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101797db4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
101797db8: a9014ff4    	stp	x20, x19, [sp, #0x10]
101797dbc: a9027bfd    	stp	x29, x30, [sp, #0x20]
101797dc0: 910083fd    	add	x29, sp, #0x20
101797dc4: aa0203f4    	mov	x20, x2
101797dc8: f00f3888    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
101797dcc: f940bd01    	ldr	x1, [x8, #0x178] ; displayedMgrSessionIndexes
101797dd0: 95923cdb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101797dd4: aa1d03fd    	mov	x29, x29
101797dd8: 95923cdc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101797ddc: aa0003f3    	mov	x19, x0
101797de0: b7f802d4    	tbnz	x20, #0x3f, 0x101797e38 <__text+0x178fe38>
101797de4: b00f4b48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101797de8: f9435101    	ldr	x1, [x8, #0x6a0] ; count
101797dec: aa1303e0    	mov	x0, x19
101797df0: 95923cd3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101797df4: eb14001f    	cmp	x0, x20
101797df8: 54000229    	b.ls	0x101797e3c <__text+0x178fe3c>
101797dfc: b00f4b68    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101797e00: f947e101    	ldr	x1, [x8, #0xfc0] ; objectAtIndexedSubscript:
101797e04: aa1303e0    	mov	x0, x19
101797e08: aa1403e2    	mov	x2, x20
101797e0c: 95923ccc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101797e10: aa1d03fd    	mov	x29, x29
101797e14: 95923ccd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101797e18: aa0003f5    	mov	x21, x0
101797e1c: 900f4ba8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
101797e20: f9424d01    	ldr	x1, [x8, #0x498] ; unsignedIntegerValue
101797e24: 95923cc6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101797e28: aa0003f4    	mov	x20, x0
101797e2c: aa1503e0    	mov	x0, x21
101797e30: 95923cc9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101797e34: 14000002    	b	0x101797e3c <__text+0x178fe3c>
101797e38: d2800014    	mov	x20, #0x0               ; =0
101797e3c: aa1303e0    	mov	x0, x19
101797e40: 95923cc5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101797e44: aa1403e0    	mov	x0, x20
101797e48: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101797e4c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101797e50: a8c357f6    	ldp	x22, x21, [sp], #0x30
101797e54: d65f03c0    	ret
