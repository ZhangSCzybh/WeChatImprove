
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101797cf8: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
101797cfc: a9014ff4    	stp	x20, x19, [sp, #0x10]
101797d00: a9027bfd    	stp	x29, x30, [sp, #0x20]
101797d04: 910083fd    	add	x29, sp, #0x20
101797d08: aa0003f3    	mov	x19, x0
101797d0c: 900f4f48    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
101797d10: f941e100    	ldr	x0, [x8, #0x3c0]
101797d14: f00f4b88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
101797d18: f9437d01    	ldr	x1, [x8, #0x6f8] ; sharedInstance
101797d1c: 95923d08    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101797d20: aa1d03fd    	mov	x29, x29
101797d24: 95923d09    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101797d28: aa0003f4    	mov	x20, x0
101797d2c: f00f3868    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101797d30: f9431901    	ldr	x1, [x8, #0x630] ; curSearchText
101797d34: aa1303e0    	mov	x0, x19
101797d38: 95923d01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101797d3c: aa1d03fd    	mov	x29, x29
101797d40: 95923d02    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101797d44: aa0003f5    	mov	x21, x0
101797d48: f00f3868    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101797d4c: f943a101    	ldr	x1, [x8, #0x740] ; ftsTaskKey
101797d50: aa1303e0    	mov	x0, x19
101797d54: 95923cfa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101797d58: aa1d03fd    	mov	x29, x29
101797d5c: 95923cfb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101797d60: aa0003f3    	mov	x19, x0
101797d64: f00f3888    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
101797d68: f940b901    	ldr	x1, [x8, #0x170] ; regularSessionIndexesForQuery:taskKey:
101797d6c: aa1403e0    	mov	x0, x20
101797d70: aa1503e2    	mov	x2, x21
101797d74: aa1303e3    	mov	x3, x19
101797d78: 95923cf1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101797d7c: aa1d03fd    	mov	x29, x29
101797d80: 95923cf2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101797d84: aa0003f6    	mov	x22, x0
101797d88: aa1303e0    	mov	x0, x19
101797d8c: 95923cf2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101797d90: aa1503e0    	mov	x0, x21
101797d94: 95923cf0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101797d98: aa1403e0    	mov	x0, x20
101797d9c: 95923cee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101797da0: aa1603e0    	mov	x0, x22
101797da4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101797da8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101797dac: a8c357f6    	ldp	x22, x21, [sp], #0x30
101797db0: 15923cf0    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
