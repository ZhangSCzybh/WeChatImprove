
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104adc2ec: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104adc2f0: a9017bfd    	stp	x29, x30, [sp, #0x10]
104adc2f4: 910043fd    	add	x29, sp, #0x10
104adc2f8: aa0203f3    	mov	x19, x2
104adc2fc: aa0003f4    	mov	x20, x0
104adc300: aa0203e0    	mov	x0, x2
104adc304: 94c52b8d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104adc308: f00dba28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104adc30c: b9869508    	ldrsw	x8, [x8, #0x694]
104adc310: 8b080280    	add	x0, x20, x8
104adc314: aa1303e1    	mov	x1, x19
104adc318: 94c52b8a    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
104adc31c: f00dba28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104adc320: b9869d08    	ldrsw	x8, [x8, #0x69c]
104adc324: f8686a88    	ldr	x8, [x20, x8]
104adc328: b40000a8    	cbz	x8, 0x104adc33c <_Flutter_MMFoundation_BindContext+0xfb7f20>
104adc32c: f00d9bc8    	adrp	x8, 0x11fe57000 <dyld_stub_binder+0x11fe57000>
104adc330: f9405501    	ldr	x1, [x8, #0xa8] ; reloadTable
104adc334: aa1403e0    	mov	x0, x20
104adc338: 94c52b81    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc33c: aa1303e0    	mov	x0, x19
104adc340: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104adc344: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104adc348: 14c52b83    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
