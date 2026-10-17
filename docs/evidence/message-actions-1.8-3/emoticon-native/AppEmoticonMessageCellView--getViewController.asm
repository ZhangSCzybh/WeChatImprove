
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1000c7eec: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1000c7ef0: a9017bfd    	stp	x29, x30, [sp, #0x10]
1000c7ef4: 910043fd    	add	x29, sp, #0x10
1000c7ef8: 901008c8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
1000c7efc: 91086108    	add	x8, x8, #0x218
1000c7f00: b9800108    	ldrsw	x8, [x8]
1000c7f04: 8b080000    	add	x0, x0, x8
1000c7f08: 95ed7ca1    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1000c7f0c: aa0003f3    	mov	x19, x0
1000c7f10: 900feba8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1000c7f14: f945d501    	ldr	x1, [x8, #0xba8] ; getViewController
1000c7f18: 95ed7c89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c7f1c: aa1d03fd    	mov	x29, x29
1000c7f20: 95ed7c8a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000c7f24: aa0003f4    	mov	x20, x0
1000c7f28: aa1303e0    	mov	x0, x19
1000c7f2c: 95ed7c8a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c7f30: aa1403e0    	mov	x0, x20
1000c7f34: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1000c7f38: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1000c7f3c: 15ed7c8d    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
