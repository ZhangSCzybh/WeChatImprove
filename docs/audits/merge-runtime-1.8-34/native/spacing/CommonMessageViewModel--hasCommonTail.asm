
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f6ac24: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
100f6ac28: a9017bfd    	stp	x29, x30, [sp, #0x10]
100f6ac2c: 910043fd    	add	x29, sp, #0x10
100f6ac30: aa0003f3    	mov	x19, x0
100f6ac34: 900f9068    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
100f6ac38: f9452900    	ldr	x0, [x8, #0xa50]
100f6ac3c: b00f8ca8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f6ac40: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100f6ac44: 95b2f13e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6ac48: aa0003e2    	mov	x2, x0
100f6ac4c: b00f8cc8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100f6ac50: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
100f6ac54: aa1303e0    	mov	x0, x19
100f6ac58: 95b2f139    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6ac5c: 36000060    	tbz	w0, #0x0, 0x100f6ac68 <__text+0xf62c68>
100f6ac60: 52800013    	mov	w19, #0x0               ; =0
100f6ac64: 1400000d    	b	0x100f6ac98 <__text+0xf62c98>
100f6ac68: b00f93a8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
100f6ac6c: 910b0108    	add	x8, x8, #0x2c0
100f6ac70: b9800108    	ldrsw	x8, [x8]
100f6ac74: f8686a60    	ldr	x0, [x19, x8]
100f6ac78: f00f78c8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f6ac7c: f9411101    	ldr	x1, [x8, #0x220] ; commonTail
100f6ac80: 95b2f12f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6ac84: aa1d03fd    	mov	x29, x29
100f6ac88: 95b2f130    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6ac8c: f100001f    	cmp	x0, #0x0
100f6ac90: 1a9f07f3    	cset	w19, ne
100f6ac94: 95b2f130    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6ac98: aa1303e0    	mov	x0, x19
100f6ac9c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
100f6aca0: a8c24ff4    	ldp	x20, x19, [sp], #0x20
100f6aca4: d65f03c0    	ret