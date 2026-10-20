
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10109e8ec: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
10109e8f0: a9017bfd    	stp	x29, x30, [sp, #0x10]
10109e8f4: 910043fd    	add	x29, sp, #0x10
10109e8f8: 900f6f68    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
10109e8fc: f9416101    	ldr	x1, [x8, #0x2c0] ; myNormalContactArrayUnfiltered
10109e900: 95ae220f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109e904: aa1d03fd    	mov	x29, x29
10109e908: 95ae2210    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10109e90c: aa0003f3    	mov	x19, x0
10109e910: d00f8308    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10109e914: f9431501    	ldr	x1, [x8, #0x628] ; copy
10109e918: 95ae2209    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109e91c: aa0003f4    	mov	x20, x0
10109e920: aa1303e0    	mov	x0, x19
10109e924: 95ae220c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10109e928: aa1403e0    	mov	x0, x20
10109e92c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10109e930: a8c24ff4    	ldp	x20, x19, [sp], #0x20
10109e934: 15ae220f    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
