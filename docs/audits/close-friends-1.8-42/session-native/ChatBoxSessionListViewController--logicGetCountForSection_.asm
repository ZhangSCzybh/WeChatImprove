
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e4b704: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
100e4b708: a9014ff4    	stp	x20, x19, [sp, #0x10]
100e4b70c: a9027bfd    	stp	x29, x30, [sp, #0x20]
100e4b710: 910083fd    	add	x29, sp, #0x20
100e4b714: aa0203f3    	mov	x19, x2
100e4b718: aa0003f4    	mov	x20, x0
100e4b71c: f00f95e8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
100e4b720: f947bd01    	ldr	x1, [x8, #0xf78] ; tableView
100e4b724: 95b76e86    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b728: aa1d03fd    	mov	x29, x29
100e4b72c: 95b76e87    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4b730: aa0003f5    	mov	x21, x0
100e4b734: b00f80c8    	adrp	x8, 0x11fe64000 <dyld_stub_binder+0x11fe64000>
100e4b738: f943a501    	ldr	x1, [x8, #0x748] ; tableView:numberOfRowsInSection:
100e4b73c: aa1403e0    	mov	x0, x20
100e4b740: aa1503e2    	mov	x2, x21
100e4b744: aa1303e3    	mov	x3, x19
100e4b748: 95b76e7d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b74c: aa0003f3    	mov	x19, x0
100e4b750: aa1503e0    	mov	x0, x21
100e4b754: 95b76e80    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4b758: aa1303e0    	mov	x0, x19
100e4b75c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100e4b760: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100e4b764: a8c357f6    	ldp	x22, x21, [sp], #0x30
100e4b768: d65f03c0    	ret
