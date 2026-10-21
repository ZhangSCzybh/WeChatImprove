
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1017674a8: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1017674ac: a9017bfd    	stp	x29, x30, [sp, #0x10]
1017674b0: 910043fd    	add	x29, sp, #0x10
1017674b4: 900f36a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1017674b8: f9478d01    	ldr	x1, [x8, #0xf18] ; searchBar
1017674bc: 9592ff20    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017674c0: aa1d03fd    	mov	x29, x29
1017674c4: 9592ff21    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017674c8: aa0003f3    	mov	x19, x0
1017674cc: d00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017674d0: f9421101    	ldr	x1, [x8, #0x420] ; inputBoxGetText
1017674d4: 9592ff1a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017674d8: aa1d03fd    	mov	x29, x29
1017674dc: 9592ff1b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017674e0: aa0003f4    	mov	x20, x0
1017674e4: aa1303e0    	mov	x0, x19
1017674e8: 9592ff1b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017674ec: aa1403e0    	mov	x0, x20
1017674f0: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1017674f4: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1017674f8: 1592ff1e    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
