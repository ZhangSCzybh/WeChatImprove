
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10109e8a0: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
10109e8a4: a9017bfd    	stp	x29, x30, [sp, #0x10]
10109e8a8: 910043fd    	add	x29, sp, #0x10
10109e8ac: 900f6f68    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
10109e8b0: f9415d01    	ldr	x1, [x8, #0x2b8] ; myNormalContactArray
10109e8b4: 95ae2222    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109e8b8: aa1d03fd    	mov	x29, x29
10109e8bc: 95ae2223    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10109e8c0: aa0003f3    	mov	x19, x0
10109e8c4: d00f8308    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10109e8c8: f9431501    	ldr	x1, [x8, #0x628] ; copy
10109e8cc: 95ae221c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109e8d0: aa0003f4    	mov	x20, x0
10109e8d4: aa1303e0    	mov	x0, x19
10109e8d8: 95ae221f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10109e8dc: aa1403e0    	mov	x0, x20
10109e8e0: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10109e8e4: a8c24ff4    	ldp	x20, x19, [sp], #0x20
10109e8e8: 15ae2222    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
