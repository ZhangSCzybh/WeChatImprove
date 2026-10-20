
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1060f64bc: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1060f64c0: a9017bfd    	stp	x29, x30, [sp, #0x10]
1060f64c4: 910043fd    	add	x29, sp, #0x10
1060f64c8: aa0003f4    	mov	x20, x0
1060f64cc: 91008000    	add	x0, x0, #0x20
1060f64d0: 946cc32f    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1060f64d4: aa0003f3    	mov	x19, x0
1060f64d8: b4000200    	cbz	x0, 0x1060f6518 <_Flutter_MMFoundation_BindContext+0x25d20fc>
1060f64dc: b9402a82    	ldr	w2, [x20, #0x28]
1060f64e0: 7100285f    	cmp	w2, #0xa
1060f64e4: 540000e0    	b.eq	0x1060f6500 <_Flutter_MMFoundation_BindContext+0x25d20e4>
1060f64e8: b00d0428    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
1060f64ec: f9413500    	ldr	x0, [x8, #0x268] ; class=MMConfSDKNativeEngine
1060f64f0: 3940b283    	ldrb	w3, [x20, #0x2c]
1060f64f4: 900cf008    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060f64f8: f941c101    	ldr	x1, [x8, #0x380] ; selector=hangup:isSubCall:
1060f64fc: 946cc310    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f6500: b00d0a08    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060f6504: b98a6908    	ldrsw	x8, [x8, #0xa68]
1060f6508: 38286a7f    	strb	wzr, [x19, x8]
1060f650c: b00d0a08    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060f6510: b98b4108    	ldrsw	x8, [x8, #0xb40]
1060f6514: b8286a7f    	str	wzr, [x19, x8]
1060f6518: aa1303e0    	mov	x0, x19
1060f651c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1060f6520: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1060f6524: 146cc30c    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
