
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106e8e15c: d10183ff    	sub	sp, sp, #0x60
106e8e160: 6d012beb    	stp	d11, d10, [sp, #0x10]
106e8e164: 6d0223e9    	stp	d9, d8, [sp, #0x20]
106e8e168: a90357f6    	stp	x22, x21, [sp, #0x30]
106e8e16c: a9044ff4    	stp	x20, x19, [sp, #0x40]
106e8e170: a9057bfd    	stp	x29, x30, [sp, #0x50]
106e8e174: 910143fd    	add	x29, sp, #0x50
106e8e178: aa0003f3    	mov	x19, x0
106e8e17c: 900cedc8    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
106e8e180: 52800029    	mov	w9, #0x1                ; =1
106e8e184: 391ac909    	strb	w9, [x8, #0x6b2]
106e8e188: b00c9736    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
106e8e18c: f94702c0    	ldr	x0, [x22, #0xe00]
106e8e190: d00c7d68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e8e194: f9419114    	ldr	x20, [x8, #0x320] ; pageScopeWidthFor:
106e8e198: aa1403e1    	mov	x1, x20
106e8e19c: aa1303e2    	mov	x2, x19
106e8e1a0: 943663e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8e1a4: 1e604008    	fmov	d8, d0
106e8e1a8: f00c9da8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e8e1ac: b984dd15    	ldrsw	x21, [x8, #0x4dc]
106e8e1b0: f8756a60    	ldr	x0, [x19, x21]
106e8e1b4: b00c93e8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
106e8e1b8: f947a501    	ldr	x1, [x8, #0xf48] ; width
106e8e1bc: 943663e0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8e1c0: 1e604009    	fmov	d9, d0
106e8e1c4: b00c99e8    	adrp	x8, 0x1201cb000 <dyld_stub_binder+0x1201cb000>
106e8e1c8: f944e908    	ldr	x8, [x8, #0x9d0]
106e8e1cc: a90023f3    	stp	x19, x8, [sp]
106e8e1d0: d00c7d68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e8e1d4: f941a101    	ldr	x1, [x8, #0x340] ; viewDidLayoutSubviews
106e8e1d8: 910003e0    	mov	x0, sp
106e8e1dc: 943663da    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
106e8e1e0: b00c9728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e8e1e4: f9468d00    	ldr	x0, [x8, #0xd18]
106e8e1e8: d00c7de8    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
106e8e1ec: f9458d01    	ldr	x1, [x8, #0xb18] ; isSupportSplitView
106e8e1f0: 943663d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8e1f4: 36000080    	tbz	w0, #0x0, 0x106e8e204 <_Flutter_MMFoundation_BindContext+0x3369de8>
106e8e1f8: 1e692100    	fcmp	d8, d9
106e8e1fc: 54000141    	b.ne	0x106e8e224 <_Flutter_MMFoundation_BindContext+0x3369e08>
106e8e200: 14000030    	b	0x106e8e2c0 <_Flutter_MMFoundation_BindContext+0x3369ea4>
106e8e204: 900c9748    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
106e8e208: f940a500    	ldr	x0, [x8, #0x148]
106e8e20c: f00c7e68    	adrp	x8, 0x11fe5d000 <dyld_stub_binder+0x11fe5d000>
106e8e210: f944d901    	ldr	x1, [x8, #0x9b0] ; isMultiSceneSupported
106e8e214: 943663ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8e218: 1e692100    	fcmp	d8, d9
106e8e21c: 54000520    	b.eq	0x106e8e2c0 <_Flutter_MMFoundation_BindContext+0x3369ea4>
106e8e220: 36000500    	tbz	w0, #0x0, 0x106e8e2c0 <_Flutter_MMFoundation_BindContext+0x3369ea4>
106e8e224: f94702c0    	ldr	x0, [x22, #0xe00]
106e8e228: aa1403e1    	mov	x1, x20
106e8e22c: aa1303e2    	mov	x2, x19
106e8e230: 943663c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8e234: 1e604008    	fmov	d8, d0
106e8e238: d00c7d68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e8e23c: f9419501    	ldr	x1, [x8, #0x328] ; getVisibleHeight
106e8e240: aa1303e0    	mov	x0, x19
106e8e244: 943663be    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8e248: 1e604009    	fmov	d9, d0
106e8e24c: 900c8b88    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e8e250: f9441d01    	ldr	x1, [x8, #0x838] ; getTableViewMarginToBottom
106e8e254: aa1303e0    	mov	x0, x19
106e8e258: 943663b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8e25c: 1e603923    	fsub	d3, d9, d0
106e8e260: f8756a60    	ldr	x0, [x19, x21]
106e8e264: d00c93c8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
106e8e268: f9403501    	ldr	x1, [x8, #0x68] ; setFrame:
106e8e26c: 9e6703e0    	fmov	d0, xzr
106e8e270: 9e6703e1    	fmov	d1, xzr
106e8e274: 1e604102    	fmov	d2, d8
106e8e278: 943663b1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8e27c: f8756a60    	ldr	x0, [x19, x21]
106e8e280: d00c7d68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e8e284: f940d901    	ldr	x1, [x8, #0x1b0] ; setTableHeaderView:
106e8e288: d2800002    	mov	x2, #0x0                ; =0
106e8e28c: 943663ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8e290: b00c7de8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
106e8e294: f940ad01    	ldr	x1, [x8, #0x158] ; initTableHeaderView
106e8e298: aa1303e0    	mov	x0, x19
106e8e29c: 943663a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8e2a0: 900c8b88    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e8e2a4: f943b101    	ldr	x1, [x8, #0x760] ; updateHeaderGridView
106e8e2a8: aa1303e0    	mov	x0, x19
106e8e2ac: 943663a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8e2b0: b00c7d68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106e8e2b4: f9458901    	ldr	x1, [x8, #0xb10] ; reloadTableView
106e8e2b8: aa1303e0    	mov	x0, x19
106e8e2bc: 943663a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8e2c0: f8756a60    	ldr	x0, [x19, x21]
106e8e2c4: b00c7d68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106e8e2c8: f945b901    	ldr	x1, [x8, #0xb70] ; contentInset
106e8e2cc: 9436639c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8e2d0: 1e604008    	fmov	d8, d0
106e8e2d4: 1e604029    	fmov	d9, d1
106e8e2d8: 1e60406a    	fmov	d10, d3
106e8e2dc: f00c8b68    	adrp	x8, 0x11fffd000 <dyld_stub_binder+0x11fffd000>
106e8e2e0: f9475901    	ldr	x1, [x8, #0xeb0] ; bForbideComment
106e8e2e4: aa1303e0    	mov	x0, x19
106e8e2e8: 94366395    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8e2ec: 37000120    	tbnz	w0, #0x0, 0x106e8e310 <_Flutter_MMFoundation_BindContext+0x3369ef4>
106e8e2f0: f8756a60    	ldr	x0, [x19, x21]
106e8e2f4: b00c93c8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
106e8e2f8: f9439501    	ldr	x1, [x8, #0x728] ; setContentInset:
106e8e2fc: 9e6703e2    	fmov	d2, xzr
106e8e300: 1e604100    	fmov	d0, d8
106e8e304: 1e604121    	fmov	d1, d9
106e8e308: 1e604143    	fmov	d3, d10
106e8e30c: 9436638c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8e310: a9457bfd    	ldp	x29, x30, [sp, #0x50]
106e8e314: a9444ff4    	ldp	x20, x19, [sp, #0x40]
106e8e318: a94357f6    	ldp	x22, x21, [sp, #0x30]
106e8e31c: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
106e8e320: 6d412beb    	ldp	d11, d10, [sp, #0x10]
106e8e324: 910183ff    	add	sp, sp, #0x60
106e8e328: d65f03c0    	ret
