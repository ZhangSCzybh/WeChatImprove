
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10627c984: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
10627c988: a9017bfd    	stp	x29, x30, [sp, #0x10]
10627c98c: 910043fd    	add	x29, sp, #0x10
10627c990: aa0003f3    	mov	x19, x0
10627c994: f00ceaa8    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10627c998: f946bd01    	ldr	x1, [x8, #0xd78] ; createTranslateView
10627c99c: 9466a9e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c9a0: aa1d03fd    	mov	x29, x29
10627c9a4: 9466a9e9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c9a8: 900cfde8    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
10627c9ac: b98d8114    	ldrsw	x20, [x8, #0xd80]
10627c9b0: f8746a68    	ldr	x8, [x19, x20]
10627c9b4: f8346a60    	str	x0, [x19, x20]
10627c9b8: aa0803e0    	mov	x0, x8
10627c9bc: 9466a9e6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c9c0: f00cfb08    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10627c9c4: 910a8108    	add	x8, x8, #0x2a0
10627c9c8: b9800108    	ldrsw	x8, [x8]
10627c9cc: f8686a60    	ldr	x0, [x19, x8]
10627c9d0: f8746a62    	ldr	x2, [x19, x20]
10627c9d4: d00cf408    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10627c9d8: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
10627c9dc: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10627c9e0: a8c24ff4    	ldp	x20, x19, [sp], #0x20
10627c9e4: 1466a9d6    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>