
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104e9dfa4: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104e9dfa8: a9017bfd    	stp	x29, x30, [sp, #0x10]
104e9dfac: 910043fd    	add	x29, sp, #0x10
104e9dfb0: aa0003f3    	mov	x19, x0
104e9dfb4: d00d96e8    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
104e9dfb8: f9431d00    	ldr	x0, [x8, #0x638]
104e9dfbc: 94b62467    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104e9dfc0: b00d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9dfc4: b9884509    	ldrsw	x9, [x8, #0x844]
104e9dfc8: f8696a68    	ldr	x8, [x19, x9]
104e9dfcc: f8296a60    	str	x0, [x19, x9]
104e9dfd0: aa0803e0    	mov	x0, x8
104e9dfd4: 94b62460    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9dfd8: 900d87a8    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104e9dfdc: f945ed01    	ldr	x1, [x8, #0xbd8] ; checkUseNewSearchBarInChatRoom
104e9dfe0: aa1303e0    	mov	x0, x19
104e9dfe4: 94b62456    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9dfe8: 34000100    	cbz	w0, 0x104e9e008 <_Flutter_MMFoundation_BindContext+0x1379bec>
104e9dfec: b00d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9dff0: b9883d08    	ldrsw	x8, [x8, #0x83c]
104e9dff4: f8686a60    	ldr	x0, [x19, x8]
104e9dff8: f8286a7f    	str	xzr, [x19, x8]
104e9dffc: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104e9e000: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104e9e004: 14b62454    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9e008: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104e9e00c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104e9e010: d65f03c0    	ret
