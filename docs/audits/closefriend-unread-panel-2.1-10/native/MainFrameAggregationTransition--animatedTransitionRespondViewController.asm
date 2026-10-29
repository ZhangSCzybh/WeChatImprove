
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a70868: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104a7086c: a9017bfd    	stp	x29, x30, [sp, #0x10]
104a70870: 910043fd    	add	x29, sp, #0x10
104a70874: 900db488    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a70878: f946f101    	ldr	x1, [x8, #0xde0] ; selector delegate
104a7087c: 94c6da30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a70880: aa1d03fd    	mov	x29, x29
104a70884: 94c6da31    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a70888: aa0003f3    	mov	x19, x0
104a7088c: f00d9e48    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104a70890: f945d501    	ldr	x1, [x8, #0xba8] ; selector getViewController
104a70894: 94c6da2a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a70898: aa1d03fd    	mov	x29, x29
104a7089c: 94c6da2b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a708a0: aa0003f4    	mov	x20, x0
104a708a4: aa1303e0    	mov	x0, x19
104a708a8: 94c6da2b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a708ac: aa1403e0    	mov	x0, x20
104a708b0: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104a708b4: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104a708b8: 14c6da2e    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
