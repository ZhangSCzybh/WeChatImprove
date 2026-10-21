
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010078b4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1010078b8: a9014ff4    	stp	x20, x19, [sp, #0x10]
1010078bc: a9027bfd    	stp	x29, x30, [sp, #0x20]
1010078c0: 910083fd    	add	x29, sp, #0x20
1010078c4: aa0203f3    	mov	x19, x2
1010078c8: aa0003f4    	mov	x20, x0
1010078cc: b00fe148    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
1010078d0: 52800029    	mov	w9, #0x1                ; =1
1010078d4: 39330509    	strb	w9, [x8, #0xcc1]
1010078d8: aa0203e0    	mov	x0, x2
1010078dc: 95b07e17    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1010078e0: d00f8f08    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
1010078e4: b98f6116    	ldrsw	x22, [x8, #0xf60]
1010078e8: f8766a80    	ldr	x0, [x20, x22]
1010078ec: f00f87e8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1010078f0: f940f901    	ldr	x1, [x8, #0x1f0] ; removeFromSuperview
1010078f4: 95b07e12    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010078f8: b4000593    	cbz	x19, 0x1010079a8 <__text+0xfff9a8>
1010078fc: b00f71a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101007900: f9443101    	ldr	x1, [x8, #0x860] ; customView
101007904: aa1303e0    	mov	x0, x19
101007908: 95b07e0d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100790c: aa1d03fd    	mov	x29, x29
101007910: 95b07e0e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101007914: aa0003f5    	mov	x21, x0
101007918: b00f8b68    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10100791c: f9435900    	ldr	x0, [x8, #0x6b0]
101007920: 900f87c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101007924: f947ad01    	ldr	x1, [x8, #0xf58] ; class
101007928: 95b07e05    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100792c: aa0003e2    	mov	x2, x0
101007930: 900f7408    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
101007934: f947f101    	ldr	x1, [x8, #0xfe0] ; viewWithClass:
101007938: aa1503e0    	mov	x0, x21
10100793c: 95b07e00    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007940: aa1d03fd    	mov	x29, x29
101007944: 95b07e01    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101007948: f8766a88    	ldr	x8, [x20, x22]
10100794c: f8366a80    	str	x0, [x20, x22]
101007950: aa0803e0    	mov	x0, x8
101007954: 95b07e00    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101007958: aa1503e0    	mov	x0, x21
10100795c: 95b07dfe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101007960: f8766a80    	ldr	x0, [x20, x22]
101007964: f00f71c8    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
101007968: f9416501    	ldr	x1, [x8, #0x2c8] ; removeAllTargets
10100796c: 95b07df4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007970: f8766a80    	ldr	x0, [x20, x22]
101007974: f00f7268    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
101007978: f942b903    	ldr	x3, [x8, #0x570] ; onDone:
10100797c: f00f87a8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
101007980: f9477101    	ldr	x1, [x8, #0xee0] ; addTarget:action:forControlEvents:
101007984: aa1403e2    	mov	x2, x20
101007988: 52800804    	mov	w4, #0x40               ; =64
10100798c: 95b07dec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007990: f8766a82    	ldr	x2, [x20, x22]
101007994: f00f87a8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
101007998: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
10100799c: aa1403e0    	mov	x0, x20
1010079a0: 95b07de7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010079a4: 14000004    	b	0x1010079b4 <__text+0xfff9b4>
1010079a8: f8766a80    	ldr	x0, [x20, x22]
1010079ac: f8366a9f    	str	xzr, [x20, x22]
1010079b0: 95b07de9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010079b4: aa1303e0    	mov	x0, x19
1010079b8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1010079bc: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1010079c0: a8c357f6    	ldp	x22, x21, [sp], #0x30
1010079c4: 15b07de4    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
