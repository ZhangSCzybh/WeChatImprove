
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101765b68: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
101765b6c: a9017bfd    	stp	x29, x30, [sp, #0x10]
101765b70: 910043fd    	add	x29, sp, #0x10
101765b74: aa0003f3    	mov	x19, x0
101765b78: f00f5448    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
101765b7c: b98da908    	ldrsw	x8, [x8, #0xda8]
101765b80: f8686800    	ldr	x0, [x0, x8]
101765b84: 900f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101765b88: f9418d01    	ldr	x1, [x8, #0x318] ; searchResultList
101765b8c: 9593056c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101765b90: aa1d03fd    	mov	x29, x29
101765b94: 9593056d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101765b98: f00f5448    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
101765b9c: b98dc114    	ldrsw	x20, [x8, #0xdc0]
101765ba0: f8746a68    	ldr	x8, [x19, x20]
101765ba4: f8346a60    	str	x0, [x19, x20]
101765ba8: aa0803e0    	mov	x0, x8
101765bac: 9593056a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101765bb0: f00f37c8    	adrp	x8, 0x11fe60000 <dyld_stub_binder+0x11fe60000>
101765bb4: f946f101    	ldr	x1, [x8, #0xde0] ; updateFooterView
101765bb8: aa1303e0    	mov	x0, x19
101765bbc: 95930560    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101765bc0: f8746a60    	ldr	x0, [x19, x20]
101765bc4: a9417bfd    	ldp	x29, x30, [sp, #0x10]
101765bc8: a8c24ff4    	ldp	x20, x19, [sp], #0x20
101765bcc: 15930560    	b	0x107c2714c <_Flutter_MMFoundation_BindContext+0x4102d30>
