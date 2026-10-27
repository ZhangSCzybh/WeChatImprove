
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105755a24: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
105755a28: a90157f6    	stp	x22, x21, [sp, #0x10]
105755a2c: a9024ff4    	stp	x20, x19, [sp, #0x20]
105755a30: a9037bfd    	stp	x29, x30, [sp, #0x30]
105755a34: 9100c3fd    	add	x29, sp, #0x30
105755a38: aa0003f3    	mov	x19, x0
105755a3c: b00d56c8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
105755a40: b98b6d18    	ldrsw	x24, [x8, #0xb6c]
105755a44: 8b180000    	add	x0, x0, x24
105755a48: 949345d1    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
105755a4c: b4000360    	cbz	x0, 0x105755ab8 <_Flutter_MMFoundation_BindContext+0x1c3169c>
105755a50: aa0003f5    	mov	x21, x0
105755a54: 8b180260    	add	x0, x19, x24
105755a58: 949345cd    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
105755a5c: aa0003f6    	mov	x22, x0
105755a60: d00d42c8    	adrp	x8, 0x11ffaf000 <dyld_stub_binder+0x11ffaf000>
105755a64: f9478114    	ldr	x20, [x8, #0xf00] ; onSelectDoneWithContacts:
105755a68: b00d4d88    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
105755a6c: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
105755a70: aa1403e2    	mov	x2, x20
105755a74: 949345b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105755a78: aa0003f7    	mov	x23, x0
105755a7c: aa1603e0    	mov	x0, x22
105755a80: 949345b5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105755a84: aa1503e0    	mov	x0, x21
105755a88: 949345b3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105755a8c: 34000177    	cbz	w23, 0x105755ab8 <_Flutter_MMFoundation_BindContext+0x1c3169c>
105755a90: 8b180260    	add	x0, x19, x24
105755a94: 949345be    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
105755a98: aa0003f5    	mov	x21, x0
105755a9c: b00d56c8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
105755aa0: b98b4908    	ldrsw	x8, [x8, #0xb48]
105755aa4: f8686a62    	ldr	x2, [x19, x8]
105755aa8: aa1403e1    	mov	x1, x20
105755aac: 949345a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105755ab0: aa1503e0    	mov	x0, x21
105755ab4: 949345a8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105755ab8: d00d3728    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105755abc: f9463101    	ldr	x1, [x8, #0xc60] ; DismissMyselfAnimated:
105755ac0: aa1303e0    	mov	x0, x19
105755ac4: 52800022    	mov	w2, #0x1                ; =1
105755ac8: a9437bfd    	ldp	x29, x30, [sp, #0x30]
105755acc: a9424ff4    	ldp	x20, x19, [sp, #0x20]
105755ad0: a94157f6    	ldp	x22, x21, [sp, #0x10]
105755ad4: a8c45ff8    	ldp	x24, x23, [sp], #0x40
105755ad8: 14934599    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
