
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002ecdfc: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1002ece00: a9017bfd    	stp	x29, x30, [sp, #0x10]
1002ece04: 910043fd    	add	x29, sp, #0x10
1002ece08: aa0203f3    	mov	x19, x2
1002ece0c: aa0003f4    	mov	x20, x0
1002ece10: aa0203e0    	mov	x0, x2
1002ece14: 95e4e8c9    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1002ece18: b4000113    	cbz	x19, 0x1002ece38 <__text+0x2e4e38>
1002ece1c: f00ff088    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002ece20: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1002ece24: aa1303e0    	mov	x0, x19
1002ece28: 95e4e8c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002ece2c: f00ff788    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
1002ece30: b9842108    	ldrsw	x8, [x8, #0x420]
1002ece34: f8286a80    	str	x0, [x20, x8]
1002ece38: f00ff788    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
1002ece3c: b9842508    	ldrsw	x8, [x8, #0x424]
1002ece40: 8b080280    	add	x0, x20, x8
1002ece44: aa1303e1    	mov	x1, x19
1002ece48: 95e4e8d3    	bl	0x107c27194 <_Flutter_MMFoundation_BindContext+0x4102d78>
1002ece4c: aa1303e0    	mov	x0, x19
1002ece50: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1002ece54: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1002ece58: 15e4e8bf    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>