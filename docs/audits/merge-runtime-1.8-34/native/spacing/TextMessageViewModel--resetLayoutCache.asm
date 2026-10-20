
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105c0ba38: d100c3ff    	sub	sp, sp, #0x30
105c0ba3c: a9014ff4    	stp	x20, x19, [sp, #0x10]
105c0ba40: a9027bfd    	stp	x29, x30, [sp, #0x20]
105c0ba44: 910083fd    	add	x29, sp, #0x20
105c0ba48: aa0003f3    	mov	x19, x0
105c0ba4c: f00d81a8    	adrp	x8, 0x120c42000 <dyld_stub_binder+0x120c42000>
105c0ba50: 52800029    	mov	w9, #0x1                ; =1
105c0ba54: 390fb909    	strb	w9, [x8, #0x3ee]
105c0ba58: 900d2de8    	adrp	x8, 0x1201c7000 <dyld_stub_binder+0x1201c7000>
105c0ba5c: f947d108    	ldr	x8, [x8, #0xfa0]
105c0ba60: a90023e0    	stp	x0, x8, [sp]
105c0ba64: f00d11e8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
105c0ba68: f9409d01    	ldr	x1, [x8, #0x138] ; resetLayoutCache
105c0ba6c: 910003e0    	mov	x0, sp
105c0ba70: 94806db5    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
105c0ba74: 900d3148    	adrp	x8, 0x120233000 <dyld_stub_binder+0x120233000>
105c0ba78: b9803908    	ldrsw	x8, [x8, #0x38]
105c0ba7c: f8686a60    	ldr	x0, [x19, x8]
105c0ba80: f8286a7f    	str	xzr, [x19, x8]
105c0ba84: 94806db4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0ba88: 900d3148    	adrp	x8, 0x120233000 <dyld_stub_binder+0x120233000>
105c0ba8c: b9802d08    	ldrsw	x8, [x8, #0x2c]
105c0ba90: f8686a60    	ldr	x0, [x19, x8]
105c0ba94: f8286a7f    	str	xzr, [x19, x8]
105c0ba98: 94806daf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0ba9c: 900d3148    	adrp	x8, 0x120233000 <dyld_stub_binder+0x120233000>
105c0baa0: b9803d08    	ldrsw	x8, [x8, #0x3c]
105c0baa4: d00bcf09    	adrp	x9, 0x11d5ed000 <dyld_stub_binder+0x11d5ed000>
105c0baa8: f9417929    	ldr	x9, [x9, #0x2f0]
105c0baac: 3dc00120    	ldr	q0, [x9]
105c0bab0: 3ca86a60    	str	q0, [x19, x8]
105c0bab4: 900d3148    	adrp	x8, 0x120233000 <dyld_stub_binder+0x120233000>
105c0bab8: b9804108    	ldrsw	x8, [x8, #0x40]
105c0babc: 3dc00120    	ldr	q0, [x9]
105c0bac0: 3ca86a60    	str	q0, [x19, x8]
105c0bac4: 900d3148    	adrp	x8, 0x120233000 <dyld_stub_binder+0x120233000>
105c0bac8: b9804508    	ldrsw	x8, [x8, #0x44]
105c0bacc: f8686a60    	ldr	x0, [x19, x8]
105c0bad0: f8286a7f    	str	xzr, [x19, x8]
105c0bad4: 94806da0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0bad8: 900d3148    	adrp	x8, 0x120233000 <dyld_stub_binder+0x120233000>
105c0badc: b9803108    	ldrsw	x8, [x8, #0x30]
105c0bae0: f8686a60    	ldr	x0, [x19, x8]
105c0bae4: f8286a7f    	str	xzr, [x19, x8]
105c0bae8: 94806d9b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0baec: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105c0baf0: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105c0baf4: 9100c3ff    	add	sp, sp, #0x30
105c0baf8: d65f03c0    	ret