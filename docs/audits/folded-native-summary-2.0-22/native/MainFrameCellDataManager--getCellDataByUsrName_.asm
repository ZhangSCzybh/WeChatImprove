
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a836a8: b40001a2    	cbz	x2, 0x104a836dc <_Flutter_MMFoundation_BindContext+0xf5f2c0>
104a836ac: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
104a836b0: 910003fd    	mov	x29, sp
104a836b4: 900dbd08    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a836b8: b981ad08    	ldrsw	x8, [x8, #0x1ac]
104a836bc: f8686800    	ldr	x0, [x0, x8]
104a836c0: b00db408    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104a836c4: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
104a836c8: 94c68e9d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a836cc: aa1d03fd    	mov	x29, x29
104a836d0: 94c68e9e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a836d4: a8c17bfd    	ldp	x29, x30, [sp], #0x10
104a836d8: 14c68ea6    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
104a836dc: d2800000    	mov	x0, #0x0                ; =0
104a836e0: 14c68ea4    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
