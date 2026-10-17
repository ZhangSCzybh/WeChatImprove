
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10471f8e4: d105c3ff    	sub	sp, sp, #0x170
10471f8e8: 6d0f2beb    	stp	d11, d10, [sp, #0xf0]
10471f8ec: 6d1023e9    	stp	d9, d8, [sp, #0x100]
10471f8f0: a9116ffc    	stp	x28, x27, [sp, #0x110]
10471f8f4: a91267fa    	stp	x26, x25, [sp, #0x120]
10471f8f8: a9135ff8    	stp	x24, x23, [sp, #0x130]
10471f8fc: a91457f6    	stp	x22, x21, [sp, #0x140]
10471f900: a9154ff4    	stp	x20, x19, [sp, #0x150]
10471f904: a9167bfd    	stp	x29, x30, [sp, #0x160]
10471f908: 910583fd    	add	x29, sp, #0x160
10471f90c: aa0003fc    	mov	x28, x0
10471f910: 900c7688    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10471f914: f9405908    	ldr	x8, [x8, #0xb0]
10471f918: f9400108    	ldr	x8, [x8]
10471f91c: f81803a8    	stur	x8, [x29, #-0x80]
10471f920: d00e28e8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
10471f924: 52800029    	mov	w9, #0x1                ; =1
10471f928: 39197109    	strb	w9, [x8, #0x65c]
10471f92c: 900dcf28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10471f930: f9459901    	ldr	x1, [x8, #0xb30] ; items
10471f934: 94d41e02    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f938: aa1d03fd    	mov	x29, x29
10471f93c: 94d41e03    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471f940: aa0003f4    	mov	x20, x0
10471f944: b00dcf08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10471f948: f9435101    	ldr	x1, [x8, #0x6a0] ; count
10471f94c: 94d41dfc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f950: aa0003f8    	mov	x24, x0
10471f954: aa1403e0    	mov	x0, x20
10471f958: 94d41dff    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471f95c: b4001218    	cbz	x24, 0x10471fb9c <_Flutter_MMFoundation_BindContext+0xbfb780>
10471f960: 900dcf68    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10471f964: f947a514    	ldr	x20, [x8, #0xf48] ; width
10471f968: aa1c03e0    	mov	x0, x28
10471f96c: aa1403e1    	mov	x1, x20
10471f970: 94d41df3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f974: 1e604009    	fmov	d9, d0
10471f978: f00dcf08    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10471f97c: f9449d01    	ldr	x1, [x8, #0x938] ; height
10471f980: aa1c03e0    	mov	x0, x28
10471f984: 94d41dee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f988: 1e604008    	fmov	d8, d0
10471f98c: aa1c03e0    	mov	x0, x28
10471f990: aa1403e1    	mov	x1, x20
10471f994: 94d41dea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f998: 1e60400a    	fmov	d10, d0
10471f99c: 4f00e400    	movi.16b	v0, #0x0
10471f9a0: ad0103e0    	stp	q0, q0, [sp, #0x20]
10471f9a4: ad0203e0    	stp	q0, q0, [sp, #0x40]
10471f9a8: 900dd808    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
10471f9ac: b989d108    	ldrsw	x8, [x8, #0x9d0]
10471f9b0: f8686b80    	ldr	x0, [x28, x8]
10471f9b4: 94d41de1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10471f9b8: b00dcf08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10471f9bc: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
10471f9c0: 910083e2    	add	x2, sp, #0x20
10471f9c4: 910183e3    	add	x3, sp, #0x60
10471f9c8: a90003e1    	stp	x1, x0, [sp]
10471f9cc: 52800204    	mov	w4, #0x10               ; =16
10471f9d0: 94d41ddb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f9d4: f9000fe0    	str	x0, [sp, #0x18]
10471f9d8: b4000940    	cbz	x0, 0x10471fb00 <_Flutter_MMFoundation_BindContext+0xbfb6e4>
10471f9dc: d2800016    	mov	x22, #0x0               ; =0
10471f9e0: 9e630300    	ucvtf	d0, x24
10471f9e4: 1e601921    	fdiv	d1, d9, d0
10471f9e8: 1e67c029    	frinti	d9, d1
10471f9ec: 1f40a920    	fmsub	d0, d9, d0, d10
10471f9f0: 1e6c1001    	fmov	d1, #0.50000000
10471f9f4: 1e610800    	fmul	d0, d0, d1
10471f9f8: 1e67c00a    	frinti	d10, d0
10471f9fc: f9401be8    	ldr	x8, [sp, #0x30]
10471fa00: f9400108    	ldr	x8, [x8]
10471fa04: f9000be8    	str	x8, [sp, #0x10]
10471fa08: d2800013    	mov	x19, #0x0               ; =0
10471fa0c: d00dc2a8    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
10471fa10: f9459918    	ldr	x24, [x8, #0xb30] ; tabBarBtnFrameAtIndex:
10471fa14: f00dcf28    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10471fa18: f9436119    	ldr	x25, [x8, #0x6c0] ; respondsToSelector:
10471fa1c: b00dcf48    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10471fa20: f940351a    	ldr	x26, [x8, #0x68] ; setFrame:
10471fa24: f9401be8    	ldr	x8, [sp, #0x30]
10471fa28: f9400108    	ldr	x8, [x8]
10471fa2c: f9400be9    	ldr	x9, [sp, #0x10]
10471fa30: eb09011f    	cmp	x8, x9
10471fa34: 54000060    	b.eq	0x10471fa40 <_Flutter_MMFoundation_BindContext+0xbfb624>
10471fa38: f94007e0    	ldr	x0, [sp, #0x8]
10471fa3c: 94d41dc5    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
10471fa40: f94017e8    	ldr	x8, [sp, #0x28]
10471fa44: f873791b    	ldr	x27, [x8, x19, lsl #3]
10471fa48: 900dd808    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
10471fa4c: b989d914    	ldrsw	x20, [x8, #0x9d8]
10471fa50: 8b140380    	add	x0, x28, x20
10471fa54: 94d41dce    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10471fa58: aa1c03f7    	mov	x23, x28
10471fa5c: aa0003fc    	mov	x28, x0
10471fa60: aa1903e1    	mov	x1, x25
10471fa64: aa1803e2    	mov	x2, x24
10471fa68: 94d41db5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fa6c: aa0003f5    	mov	x21, x0
10471fa70: aa1c03e0    	mov	x0, x28
10471fa74: 94d41db8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471fa78: 340001b5    	cbz	w21, 0x10471faac <_Flutter_MMFoundation_BindContext+0xbfb690>
10471fa7c: 8b1402e0    	add	x0, x23, x20
10471fa80: 94d41dc3    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10471fa84: aa0003f5    	mov	x21, x0
10471fa88: aa1803e1    	mov	x1, x24
10471fa8c: aa1603e2    	mov	x2, x22
10471fa90: 94d41dab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fa94: aa1b03e0    	mov	x0, x27
10471fa98: aa1a03e1    	mov	x1, x26
10471fa9c: 94d41da8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471faa0: aa1503e0    	mov	x0, x21
10471faa4: 94d41dac    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471faa8: 14000009    	b	0x10471facc <_Flutter_MMFoundation_BindContext+0xbfb6b0>
10471faac: 9e6202c0    	scvtf	d0, x22
10471fab0: 1f492800    	fmadd	d0, d0, d9, d10
10471fab4: 9e6703e1    	fmov	d1, xzr
10471fab8: aa1b03e0    	mov	x0, x27
10471fabc: aa1a03e1    	mov	x1, x26
10471fac0: 1e604122    	fmov	d2, d9
10471fac4: 1e604103    	fmov	d3, d8
10471fac8: 94d41d9d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471facc: aa1703fc    	mov	x28, x23
10471fad0: 910006d6    	add	x22, x22, #0x1
10471fad4: 91000673    	add	x19, x19, #0x1
10471fad8: f9400fe8    	ldr	x8, [sp, #0x18]
10471fadc: eb13011f    	cmp	x8, x19
10471fae0: 54fffa21    	b.ne	0x10471fa24 <_Flutter_MMFoundation_BindContext+0xbfb608>
10471fae4: 910083e2    	add	x2, sp, #0x20
10471fae8: 910183e3    	add	x3, sp, #0x60
10471faec: a94003e1    	ldp	x1, x0, [sp]
10471faf0: 52800204    	mov	w4, #0x10               ; =16
10471faf4: 94d41d92    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471faf8: f9000fe0    	str	x0, [sp, #0x18]
10471fafc: b5fff860    	cbnz	x0, 0x10471fa08 <_Flutter_MMFoundation_BindContext+0xbfb5ec>
10471fb00: f94007e0    	ldr	x0, [sp, #0x8]
10471fb04: 94d41d94    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471fb08: f00dba28    	adrp	x8, 0x11fe66000 <dyld_stub_binder+0x11fe66000>
10471fb0c: f943d914    	ldr	x20, [x8, #0x7b0] ; customDelegate
10471fb10: aa1c03e0    	mov	x0, x28
10471fb14: aa1403e1    	mov	x1, x20
10471fb18: 94d41d89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fb1c: aa1d03fd    	mov	x29, x29
10471fb20: 94d41d8a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471fb24: b40003c0    	cbz	x0, 0x10471fb9c <_Flutter_MMFoundation_BindContext+0xbfb780>
10471fb28: aa0003f6    	mov	x22, x0
10471fb2c: aa1c03e0    	mov	x0, x28
10471fb30: aa1403e1    	mov	x1, x20
10471fb34: 94d41d82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fb38: aa1d03fd    	mov	x29, x29
10471fb3c: 94d41d83    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471fb40: aa0003f7    	mov	x23, x0
10471fb44: d00dc2a8    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
10471fb48: f9459d15    	ldr	x21, [x8, #0xb38] ; onTabBarItemViewsRelayout
10471fb4c: f00dcf28    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10471fb50: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
10471fb54: aa1503e2    	mov	x2, x21
10471fb58: 94d41d79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fb5c: aa0003f8    	mov	x24, x0
10471fb60: aa1703e0    	mov	x0, x23
10471fb64: 94d41d7c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471fb68: aa1603e0    	mov	x0, x22
10471fb6c: 94d41d7a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471fb70: 34000178    	cbz	w24, 0x10471fb9c <_Flutter_MMFoundation_BindContext+0xbfb780>
10471fb74: aa1c03e0    	mov	x0, x28
10471fb78: aa1403e1    	mov	x1, x20
10471fb7c: 94d41d70    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fb80: aa1d03fd    	mov	x29, x29
10471fb84: 94d41d71    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471fb88: aa0003f3    	mov	x19, x0
10471fb8c: aa1503e1    	mov	x1, x21
10471fb90: 94d41d6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fb94: aa1303e0    	mov	x0, x19
10471fb98: 94d41d6f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471fb9c: f85803a8    	ldur	x8, [x29, #-0x80]
10471fba0: 900c7689    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10471fba4: f9405929    	ldr	x9, [x9, #0xb0]
10471fba8: f9400129    	ldr	x9, [x9]
10471fbac: eb08013f    	cmp	x9, x8
10471fbb0: 54000161    	b.ne	0x10471fbdc <_Flutter_MMFoundation_BindContext+0xbfb7c0>
10471fbb4: a9567bfd    	ldp	x29, x30, [sp, #0x160]
10471fbb8: a9554ff4    	ldp	x20, x19, [sp, #0x150]
10471fbbc: a95457f6    	ldp	x22, x21, [sp, #0x140]
10471fbc0: a9535ff8    	ldp	x24, x23, [sp, #0x130]
10471fbc4: a95267fa    	ldp	x26, x25, [sp, #0x120]
10471fbc8: a9516ffc    	ldp	x28, x27, [sp, #0x110]
10471fbcc: 6d5023e9    	ldp	d9, d8, [sp, #0x100]
10471fbd0: 6d4f2beb    	ldp	d11, d10, [sp, #0xf0]
10471fbd4: 9105c3ff    	add	sp, sp, #0x170
10471fbd8: d65f03c0    	ret
10471fbdc: 94d41d66    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>