
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104adc2b0: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104adc2b4: a9017bfd    	stp	x29, x30, [sp, #0x10]
104adc2b8: 910043fd    	add	x29, sp, #0x10
104adc2bc: aa0003f3    	mov	x19, x0
104adc2c0: b00d9be8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
104adc2c4: f9421d01    	ldr	x1, [x8, #0x438] ; updateCount
104adc2c8: 94c52b9d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc2cc: f00dba28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104adc2d0: b9869d08    	ldrsw	x8, [x8, #0x69c]
104adc2d4: f8686a60    	ldr	x0, [x19, x8]
104adc2d8: d00db148    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104adc2dc: f9404501    	ldr	x1, [x8, #0x88] ; reloadData
104adc2e0: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104adc2e4: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104adc2e8: 14c52b95    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
