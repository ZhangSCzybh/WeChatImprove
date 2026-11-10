
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002a91fc: d10103ff    	sub	sp, sp, #0x40
1002a9200: 6d0223e9    	stp	d9, d8, [sp, #0x20]
1002a9204: a9037bfd    	stp	x29, x30, [sp, #0x30]
1002a9208: 9100c3fd    	add	x29, sp, #0x30
1002a920c: 1e602008    	fcmp	d0, #0.0
1002a9210: 1e6e1001    	fmov	d1, #1.00000000
1002a9214: 1e600c28    	fcsel	d8, d1, d0, eq
1002a9218: fd001408    	str	d8, [x0, #0x28]
1002a921c: f9400408    	ldr	x8, [x0, #0x8]
1002a9220: f9401d00    	ldr	x0, [x8, #0x38]
1002a9224: b40002e0    	cbz	x0, 0x1002a9280 <__text+0x2a1280>
1002a9228: 1e624100    	fcvt	s0, d8
1002a922c: 52800041    	mov	w1, #0x2                ; =2
1002a9230: 95e5f444    	bl	0x107c26340 <_Flutter_MMFoundation_BindContext+0x3ead00c>
1002a9234: b00f5348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002a9238: f9430d08    	ldr	x8, [x8, #0x618]
1002a923c: 900f3909    	adrp	x9, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002a9240: f9418921    	ldr	x1, [x9, #0x310]
1002a9244: f9000be0    	str	x0, [sp, #0x10]
1002a9248: fd0007e8    	str	d8, [sp, #0x8]
1002a924c: 900e68a9    	adrp	x9, 0x11cfbd000 <dyld_stub_binder+0x11cfbd000>
1002a9250: 911de129    	add	x9, x9, #0x778
1002a9254: f90003e9    	str	x9, [sp]
1002a9258: 900cc8c5    	adrp	x5, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a925c: 9120a4a5    	add	x5, x5, #0x829
1002a9260: 900cc8c7    	adrp	x7, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a9264: 912c80e7    	add	x7, x7, #0xb20
1002a9268: aa0803e0    	mov	x0, x8
1002a926c: 52800042    	mov	w2, #0x2                ; =2
1002a9270: d2800003    	mov	x3, #0x0                ; =0
1002a9274: 52800004    	mov	w4, #0x0                ; =0
1002a9278: 528034a6    	mov	w6, #0x1a5              ; =421
1002a927c: 95e5fa7a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9280: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1002a9284: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
1002a9288: 910103ff    	add	sp, sp, #0x40
1002a928c: d65f03c0    	ret
