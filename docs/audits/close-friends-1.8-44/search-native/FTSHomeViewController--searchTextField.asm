
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1017675a4: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1017675a8: a9017bfd    	stp	x29, x30, [sp, #0x10]
1017675ac: 910043fd    	add	x29, sp, #0x10
1017675b0: 900f36a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1017675b4: f9478d01    	ldr	x1, [x8, #0xf18] ; searchBar
1017675b8: 9592fee1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017675bc: aa1d03fd    	mov	x29, x29
1017675c0: 9592fee2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017675c4: aa0003f3    	mov	x19, x0
1017675c8: f00f38a8    	adrp	x8, 0x11fe7e000 <dyld_stub_binder+0x11fe7e000>
1017675cc: f945e501    	ldr	x1, [x8, #0xbc8] ; textField
1017675d0: 9592fedb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017675d4: aa1d03fd    	mov	x29, x29
1017675d8: 9592fedc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017675dc: aa0003f4    	mov	x20, x0
1017675e0: aa1303e0    	mov	x0, x19
1017675e4: 9592fedc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017675e8: aa1403e0    	mov	x0, x20
1017675ec: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1017675f0: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1017675f4: 1592fedf    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
