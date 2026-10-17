
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10152fa70: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
10152fa74: a9017bfd    	stp	x29, x30, [sp, #0x10]
10152fa78: 910043fd    	add	x29, sp, #0x10
10152fa7c: 900f6588    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10152fa80: 91086108    	add	x8, x8, #0x218
10152fa84: b9800108    	ldrsw	x8, [x8]
10152fa88: 8b080000    	add	x0, x0, x8
10152fa8c: 959bddc0    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10152fa90: aa0003f3    	mov	x19, x0
10152fa94: 900f4868    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10152fa98: f945d501    	ldr	x1, [x8, #0xba8] ; getViewController
10152fa9c: 959bdda8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152faa0: aa1d03fd    	mov	x29, x29
10152faa4: 959bdda9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10152faa8: aa0003f4    	mov	x20, x0
10152faac: aa1303e0    	mov	x0, x19
10152fab0: 959bdda9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152fab4: aa1403e0    	mov	x0, x20
10152fab8: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10152fabc: a8c24ff4    	ldp	x20, x19, [sp], #0x20
10152fac0: 159bddac    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>