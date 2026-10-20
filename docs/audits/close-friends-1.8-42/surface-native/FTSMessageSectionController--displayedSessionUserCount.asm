
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101797e58: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
101797e5c: a9017bfd    	stp	x29, x30, [sp, #0x10]
101797e60: 910043fd    	add	x29, sp, #0x10
101797e64: f00f3888    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
101797e68: f940bd01    	ldr	x1, [x8, #0x178] ; displayedMgrSessionIndexes
101797e6c: 95923cb4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101797e70: aa1d03fd    	mov	x29, x29
101797e74: 95923cb5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101797e78: aa0003f3    	mov	x19, x0
101797e7c: b00f4b48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101797e80: f9435101    	ldr	x1, [x8, #0x6a0] ; count
101797e84: 95923cae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101797e88: aa0003f4    	mov	x20, x0
101797e8c: aa1303e0    	mov	x0, x19
101797e90: 95923cb1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101797e94: aa1403e0    	mov	x0, x20
101797e98: a9417bfd    	ldp	x29, x30, [sp, #0x10]
101797e9c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
101797ea0: d65f03c0    	ret
