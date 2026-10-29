
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104726bec: d10243ff    	sub	sp, sp, #0x90
104726bf0: 6d012beb    	stp	d11, d10, [sp, #0x10]
104726bf4: 6d0223e9    	stp	d9, d8, [sp, #0x20]
104726bf8: a9036ffc    	stp	x28, x27, [sp, #0x30]
104726bfc: a90467fa    	stp	x26, x25, [sp, #0x40]
104726c00: a9055ff8    	stp	x24, x23, [sp, #0x50]
104726c04: a90657f6    	stp	x22, x21, [sp, #0x60]
104726c08: a9074ff4    	stp	x20, x19, [sp, #0x70]
104726c0c: a9087bfd    	stp	x29, x30, [sp, #0x80]
104726c10: 910203fd    	add	x29, sp, #0x80
104726c14: f00e28a8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
104726c18: 52800029    	mov	w9, #0x1                ; =1
104726c1c: 391a0d09    	strb	w9, [x8, #0x683]
104726c20: f00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104726c24: f945f901    	ldr	x1, [x8, #0xbf0] ; selector customTabBar
104726c28: f90007e0    	str	x0, [sp, #0x8]
104726c2c: 94d40144    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726c30: aa1d03fd    	mov	x29, x29
104726c34: 94d40145    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104726c38: aa0003f4    	mov	x20, x0
104726c3c: b40008c0    	cbz	x0, 0x104726d54 <_Flutter_MMFoundation_BindContext+0xc02938>
104726c40: b00dcee8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104726c44: f9459915    	ldr	x21, [x8, #0xb30] ; selector items
104726c48: aa1403e0    	mov	x0, x20
104726c4c: aa1503e1    	mov	x1, x21
104726c50: 94d4013b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726c54: aa1d03fd    	mov	x29, x29
104726c58: 94d4013c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104726c5c: aa0003f6    	mov	x22, x0
104726c60: d00dced3    	adrp	x19, 0x120100000 <dyld_stub_binder+0x120100000>
104726c64: f9435261    	ldr	x1, [x19, #0x6a0] ; selector count
104726c68: 94d40135    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726c6c: aa0003f7    	mov	x23, x0
104726c70: aa1603e0    	mov	x0, x22
104726c74: 94d40138    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104726c78: b40006f7    	cbz	x23, 0x104726d54 <_Flutter_MMFoundation_BindContext+0xc02938>
104726c7c: d2800016    	mov	x22, #0x0               ; =0
104726c80: b00dbd08    	adrp	x8, 0x11fec7000 <dyld_stub_binder+0x11fec7000>
104726c84: f9457117    	ldr	x23, [x8, #0xae0] ; selector tabBarItemViewAtIndex:
104726c88: f00dcec8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
104726c8c: f945a118    	ldr	x24, [x8, #0xb40] ; selector frame
104726c90: f00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104726c94: f9463d19    	ldr	x25, [x8, #0xc78] ; selector getTabBarBtnForIndex:
104726c98: d00dcf08    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104726c9c: f940351a    	ldr	x26, [x8, #0x68] ; selector setFrame:
104726ca0: f943527b    	ldr	x27, [x19, #0x6a0] ; selector count
104726ca4: aa1403e0    	mov	x0, x20
104726ca8: aa1703e1    	mov	x1, x23
104726cac: aa1603e2    	mov	x2, x22
104726cb0: 94d40123    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726cb4: aa1d03fd    	mov	x29, x29
104726cb8: 94d40124    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104726cbc: aa0003fc    	mov	x28, x0
104726cc0: aa1803e1    	mov	x1, x24
104726cc4: 94d4011e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726cc8: 1e604008    	fmov	d8, d0
104726ccc: 1e604029    	fmov	d9, d1
104726cd0: 1e60404a    	fmov	d10, d2
104726cd4: 1e60406b    	fmov	d11, d3
104726cd8: f94007e0    	ldr	x0, [sp, #0x8]
104726cdc: aa1903e1    	mov	x1, x25
104726ce0: aa1603e2    	mov	x2, x22
104726ce4: 94d40116    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726ce8: aa1d03fd    	mov	x29, x29
104726cec: 94d40117    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104726cf0: aa0003f3    	mov	x19, x0
104726cf4: aa1a03e1    	mov	x1, x26
104726cf8: 1e604100    	fmov	d0, d8
104726cfc: 1e604121    	fmov	d1, d9
104726d00: 1e604142    	fmov	d2, d10
104726d04: 1e604163    	fmov	d3, d11
104726d08: 94d4010d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726d0c: aa1303e0    	mov	x0, x19
104726d10: 94d40111    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104726d14: aa1c03e0    	mov	x0, x28
104726d18: 94d4010f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104726d1c: 910006d6    	add	x22, x22, #0x1
104726d20: aa1403e0    	mov	x0, x20
104726d24: aa1503e1    	mov	x1, x21
104726d28: 94d40105    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726d2c: aa1d03fd    	mov	x29, x29
104726d30: 94d40106    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104726d34: aa0003f3    	mov	x19, x0
104726d38: aa1b03e1    	mov	x1, x27
104726d3c: 94d40100    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726d40: aa0003fc    	mov	x28, x0
104726d44: aa1303e0    	mov	x0, x19
104726d48: 94d40103    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104726d4c: eb1c02df    	cmp	x22, x28
104726d50: 54fffaa3    	b.lo	0x104726ca4 <_Flutter_MMFoundation_BindContext+0xc02888>
104726d54: aa1403e0    	mov	x0, x20
104726d58: a9487bfd    	ldp	x29, x30, [sp, #0x80]
104726d5c: a9474ff4    	ldp	x20, x19, [sp, #0x70]
104726d60: a94657f6    	ldp	x22, x21, [sp, #0x60]
104726d64: a9455ff8    	ldp	x24, x23, [sp, #0x50]
104726d68: a94467fa    	ldp	x26, x25, [sp, #0x40]
104726d6c: a9436ffc    	ldp	x28, x27, [sp, #0x30]
104726d70: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
104726d74: 6d412beb    	ldp	d11, d10, [sp, #0x10]
104726d78: 910243ff    	add	sp, sp, #0x90
104726d7c: 14d400f6    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
