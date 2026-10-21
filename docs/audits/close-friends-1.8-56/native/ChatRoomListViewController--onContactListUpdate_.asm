
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100ed7f6c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
100ed7f70: a9017bfd    	stp	x29, x30, [sp, #0x10]
100ed7f74: 910043fd    	add	x29, sp, #0x10
100ed7f78: aa0003f3    	mov	x19, x0
100ed7f7c: 900f9a68    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
100ed7f80: 911a5108    	add	x8, x8, #0x694
100ed7f84: b9800108    	ldrsw	x8, [x8]
100ed7f88: f8686800    	ldr	x0, [x0, x8]
100ed7f8c: f00f7d48    	adrp	x8, 0x11fe82000 <dyld_stub_binder+0x11fe82000>
100ed7f90: f9479101    	ldr	x1, [x8, #0xf20] ; reloadMemberList:
100ed7f94: d2800002    	mov	x2, #0x0                ; =0
100ed7f98: 95b53c69    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100ed7f9c: 900f7c08    	adrp	x8, 0x11fe57000 <dyld_stub_binder+0x11fe57000>
100ed7fa0: f9405501    	ldr	x1, [x8, #0xa8] ; reloadTable
100ed7fa4: aa1303e0    	mov	x0, x19
100ed7fa8: a9417bfd    	ldp	x29, x30, [sp, #0x10]
100ed7fac: a8c24ff4    	ldp	x20, x19, [sp], #0x20
100ed7fb0: 15b53c63    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
