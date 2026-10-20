
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105c7e1a4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
105c7e1a8: a9014ff4    	stp	x20, x19, [sp, #0x10]
105c7e1ac: a9027bfd    	stp	x29, x30, [sp, #0x20]
105c7e1b0: 910083fd    	add	x29, sp, #0x20
105c7e1b4: aa0303f4    	mov	x20, x3
105c7e1b8: aa0003f3    	mov	x19, x0
105c7e1bc: 900d7e28    	adrp	x8, 0x120c42000 <dyld_stub_binder+0x120c42000>
105c7e1c0: 52800035    	mov	w21, #0x1               ; =1
105c7e1c4: 39178115    	strb	w21, [x8, #0x5e0]
105c7e1c8: d00d1a08    	adrp	x8, 0x11ffc0000 <dyld_stub_binder+0x11ffc0000>
105c7e1cc: f940b501    	ldr	x1, [x8, #0x168] ; isTopInfoCellForSection:
105c7e1d0: aa0303e2    	mov	x2, x3
105c7e1d4: 947ea3da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7e1d8: 37000620    	tbnz	w0, #0x0, 0x105c7e29c <_Flutter_MMFoundation_BindContext+0x2159e80>
105c7e1dc: d00d1a08    	adrp	x8, 0x11ffc0000 <dyld_stub_binder+0x11ffc0000>
105c7e1e0: f9405101    	ldr	x1, [x8, #0xa0] ; topInfoCellCount
105c7e1e4: aa1303e0    	mov	x0, x19
105c7e1e8: 947ea3d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7e1ec: cb000295    	sub	x21, x20, x0
105c7e1f0: d00d1a08    	adrp	x8, 0x11ffc0000 <dyld_stub_binder+0x11ffc0000>
105c7e1f4: f9401901    	ldr	x1, [x8, #0x30] ; friendTopicList
105c7e1f8: aa1303e0    	mov	x0, x19
105c7e1fc: 947ea3d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7e200: aa1d03fd    	mov	x29, x29
105c7e204: 947ea3d1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c7e208: aa0003f6    	mov	x22, x0
105c7e20c: 900d0de8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105c7e210: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
105c7e214: aa1503e2    	mov	x2, x21
105c7e218: 947ea3c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7e21c: aa1d03fd    	mov	x29, x29
105c7e220: 947ea3ca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c7e224: aa0003f4    	mov	x20, x0
105c7e228: aa1603e0    	mov	x0, x22
105c7e22c: 947ea3ca    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c7e230: d00d1a08    	adrp	x8, 0x11ffc0000 <dyld_stub_binder+0x11ffc0000>
105c7e234: f940b901    	ldr	x1, [x8, #0x170] ; shouldFoldForSection:
105c7e238: aa1303e0    	mov	x0, x19
105c7e23c: aa1503e2    	mov	x2, x21
105c7e240: 947ea3bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7e244: 340000e0    	cbz	w0, 0x105c7e260 <_Flutter_MMFoundation_BindContext+0x2159e44>
105c7e248: d00d1a08    	adrp	x8, 0x11ffc0000 <dyld_stub_binder+0x11ffc0000>
105c7e24c: f9404d01    	ldr	x1, [x8, #0x98] ; itemNumberPerRow
105c7e250: aa1303e0    	mov	x0, x19
105c7e254: 947ea3ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7e258: d37ef415    	lsl	x21, x0, #2
105c7e25c: 1400000e    	b	0x105c7e294 <_Flutter_MMFoundation_BindContext+0x2159e78>
105c7e260: 900d0ee8    	adrp	x8, 0x11fe5a000 <dyld_stub_binder+0x11fe5a000>
105c7e264: f9456d01    	ldr	x1, [x8, #0xad8] ; usernames
105c7e268: aa1403e0    	mov	x0, x20
105c7e26c: 947ea3b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7e270: aa1d03fd    	mov	x29, x29
105c7e274: 947ea3b5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c7e278: aa0003f3    	mov	x19, x0
105c7e27c: d00d2408    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105c7e280: f9435101    	ldr	x1, [x8, #0x6a0] ; count
105c7e284: 947ea3ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7e288: aa0003f5    	mov	x21, x0
105c7e28c: aa1303e0    	mov	x0, x19
105c7e290: 947ea3b1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c7e294: aa1403e0    	mov	x0, x20
105c7e298: 947ea3af    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c7e29c: aa1503e0    	mov	x0, x21
105c7e2a0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105c7e2a4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105c7e2a8: a8c357f6    	ldp	x22, x21, [sp], #0x30
105c7e2ac: d65f03c0    	ret
