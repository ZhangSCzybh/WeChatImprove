
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ea093c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104ea0940: a9017bfd    	stp	x29, x30, [sp, #0x10]
104ea0944: 910043fd    	add	x29, sp, #0x10
104ea0948: aa0003f3    	mov	x19, x0
104ea094c: d00d7da8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
104ea0950: f942a901    	ldr	x1, [x8, #0x550] ; updatePanelBtn
104ea0954: 94b619fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0958: b00d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea095c: f946b901    	ldr	x1, [x8, #0xd70] ; updateToolViewSelectedContacts
104ea0960: aa1303e0    	mov	x0, x19
104ea0964: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104ea0968: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104ea096c: 14b619f4    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
