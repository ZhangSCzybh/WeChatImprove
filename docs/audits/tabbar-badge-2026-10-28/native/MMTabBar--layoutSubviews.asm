
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10471f158: d10143ff    	sub	sp, sp, #0x50
10471f15c: a90257f6    	stp	x22, x21, [sp, #0x20]
10471f160: a9034ff4    	stp	x20, x19, [sp, #0x30]
10471f164: a9047bfd    	stp	x29, x30, [sp, #0x40]
10471f168: 910103fd    	add	x29, sp, #0x40
10471f16c: aa0003f3    	mov	x19, x0
10471f170: d00e28e8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
10471f174: 52800029    	mov	w9, #0x1                ; =1
10471f178: 39196109    	strb	w9, [x8, #0x658]
10471f17c: b00dd528    	adrp	x8, 0x1201c4000 <dyld_stub_binder+0x1201c4000>
10471f180: f945fd08    	ldr	x8, [x8, #0xbf8]
10471f184: a90123e0    	stp	x0, x8, [sp, #0x10]
10471f188: f00db8e8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
10471f18c: f940a901    	ldr	x1, [x8, #0x150] ; selector layoutSubviews
10471f190: 910043e0    	add	x0, sp, #0x10
10471f194: 94d41fec    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
10471f198: d00dc2a8    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
10471f19c: f9458d01    	ldr	x1, [x8, #0xb18] ; selector findShadowView:
10471f1a0: aa1303e0    	mov	x0, x19
10471f1a4: aa1303e2    	mov	x2, x19
10471f1a8: 94d41fe5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f1ac: aa1d03fd    	mov	x29, x29
10471f1b0: 94d41fe6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471f1b4: aa0003f4    	mov	x20, x0
10471f1b8: a9007fff    	stp	xzr, xzr, [sp]
10471f1bc: 900dcf08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10471f1c0: f942f101    	ldr	x1, [x8, #0x5e0] ; selector backgroundColor
10471f1c4: 94d41fde    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f1c8: aa1d03fd    	mov	x29, x29
10471f1cc: 94d41fdf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471f1d0: aa0003f5    	mov	x21, x0
10471f1d4: f00dbaa8    	adrp	x8, 0x11fe76000 <dyld_stub_binder+0x11fe76000>
10471f1d8: f9450d01    	ldr	x1, [x8, #0xa18] ; selector getWhite:alpha:
10471f1dc: 910023e2    	add	x2, sp, #0x8
10471f1e0: 910003e3    	mov	x3, sp
10471f1e4: 94d41fd6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f1e8: aa1503e0    	mov	x0, x21
10471f1ec: 94d41fda    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471f1f0: fd4003e0    	ldr	d0, [sp]
10471f1f4: 1e602008    	fcmp	d0, #0.0
10471f1f8: 5400010d    	b.le	0x10471f218 <_Flutter_MMFoundation_BindContext+0xbfadfc>
10471f1fc: d00a3308    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10471f200: fd42d101    	ldr	d1, [x8, #0x5a0]
10471f204: f00dcf28    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10471f208: f9476901    	ldr	x1, [x8, #0xed0] ; selector setAlpha:
10471f20c: 1e601820    	fdiv	d0, d1, d0
10471f210: aa1403e0    	mov	x0, x20
10471f214: 94d41fca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f218: 900dd808    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
10471f21c: b989d515    	ldrsw	x21, [x8, #0x9d4]
10471f220: f8756a62    	ldr	x2, [x19, x21]
10471f224: 900db948    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
10471f228: f946e101    	ldr	x1, [x8, #0xdc0] ; selector sendSubviewToBack:
10471f22c: aa1303e0    	mov	x0, x19
10471f230: 94d41fc3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f234: 900dcf08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10471f238: f943d501    	ldr	x1, [x8, #0x7a8] ; selector bounds
10471f23c: aa1303e0    	mov	x0, x19
10471f240: 94d41fbf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f244: f8756a60    	ldr	x0, [x19, x21]
10471f248: b00dcf48    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10471f24c: f9403501    	ldr	x1, [x8, #0x68] ; selector setFrame:
10471f250: 94d41fbb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f254: d00dc2a8    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
10471f258: f9459101    	ldr	x1, [x8, #0xb20] ; selector relayoutTabBarItems
10471f25c: aa1303e0    	mov	x0, x19
10471f260: 94d41fb7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471f264: aa1403e0    	mov	x0, x20
10471f268: 94d41fbb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471f26c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10471f270: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10471f274: a94257f6    	ldp	x22, x21, [sp, #0x20]
10471f278: 910143ff    	add	sp, sp, #0x50
10471f27c: d65f03c0    	ret
