
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1062878e0: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1062878e4: a9017bfd    	stp	x29, x30, [sp, #0x10]
1062878e8: 910043fd    	add	x29, sp, #0x10
1062878ec: b00cf3c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1062878f0: f946f101    	ldr	x1, [x8, #0xde0] ; delegate
1062878f4: 94667e12    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062878f8: aa1d03fd    	mov	x29, x29
1062878fc: 94667e13    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106287900: aa0003f3    	mov	x19, x0
106287904: 900cdda8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106287908: f945d501    	ldr	x1, [x8, #0xba8] ; getViewController
10628790c: 94667e0c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287910: aa1d03fd    	mov	x29, x29
106287914: 94667e0d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106287918: aa0003f4    	mov	x20, x0
10628791c: aa1303e0    	mov	x0, x19
106287920: 94667e0d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106287924: aa1403e0    	mov	x0, x20
106287928: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10628792c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
106287930: 14667e10    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>