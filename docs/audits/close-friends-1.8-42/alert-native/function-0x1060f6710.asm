
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1060f6710: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1060f6714: a9017bfd    	stp	x29, x30, [sp, #0x10]
1060f6718: 910043fd    	add	x29, sp, #0x10
1060f671c: aa0003f4    	mov	x20, x0
1060f6720: 91008000    	add	x0, x0, #0x20
1060f6724: 946cc29a    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1060f6728: aa0003f3    	mov	x19, x0
1060f672c: b4000200    	cbz	x0, 0x1060f676c <_Flutter_MMFoundation_BindContext+0x25d2350>
1060f6730: b9403282    	ldr	w2, [x20, #0x30]
1060f6734: 7100285f    	cmp	w2, #0xa
1060f6738: 540000e0    	b.eq	0x1060f6754 <_Flutter_MMFoundation_BindContext+0x25d2338>
1060f673c: b00d0428    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
1060f6740: f9413500    	ldr	x0, [x8, #0x268] ; class=MMConfSDKNativeEngine
1060f6744: f9401683    	ldr	x3, [x20, #0x28]
1060f6748: 900cf008    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060f674c: f9431d01    	ldr	x1, [x8, #0x638] ; selector=hangup:roomID:
1060f6750: 946cc27b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f6754: b00d0a08    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060f6758: b98a6908    	ldrsw	x8, [x8, #0xa68]
1060f675c: 38286a7f    	strb	wzr, [x19, x8]
1060f6760: b00d0a08    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060f6764: b98b4108    	ldrsw	x8, [x8, #0xb40]
1060f6768: b8286a7f    	str	wzr, [x19, x8]
1060f676c: aa1303e0    	mov	x0, x19
1060f6770: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1060f6774: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1060f6778: 146cc277    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
