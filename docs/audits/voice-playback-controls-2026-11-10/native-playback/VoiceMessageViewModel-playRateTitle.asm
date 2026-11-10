
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
10658b388: 6dbc23e9    	stp	d9, d8, [sp, #-0x40]!
10658b38c: a90157f6    	stp	x22, x21, [sp, #0x10]
10658b390: a9024ff4    	stp	x20, x19, [sp, #0x20]
10658b394: a9037bfd    	stp	x29, x30, [sp, #0x30]
10658b398: 9100c3fd    	add	x29, sp, #0x30
10658b39c: f00c4268    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
10658b3a0: b98d1908    	ldrsw	x8, [x8, #0xd18]
10658b3a4: fc686808    	ldr	d8, [x0, x8]
10658b3a8: f00c3c28    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10658b3ac: f943c100    	ldr	x0, [x8, #0x780]
10658b3b0: d00c21e8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10658b3b4: f9440101    	ldr	x1, [x8, #0x800]
10658b3b8: 945a722b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b3bc: aa1d03fd    	mov	x29, x29
10658b3c0: 945a7230    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658b3c4: aa0003f3    	mov	x19, x0
10658b3c8: f00c3c28    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10658b3cc: f9440100    	ldr	x0, [x8, #0x800]
10658b3d0: f00c38c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10658b3d4: f9428501    	ldr	x1, [x8, #0x508]
10658b3d8: 945a7223    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b3dc: aa0003e2    	mov	x2, x0
10658b3e0: d00c21e8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10658b3e4: f9452101    	ldr	x1, [x8, #0xa40]
10658b3e8: aa1303e0    	mov	x0, x19
10658b3ec: 945a721e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b3f0: aa1d03fd    	mov	x29, x29
10658b3f4: 945a7223    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658b3f8: aa0003f4    	mov	x20, x0
10658b3fc: d00c21e8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10658b400: 900b7089    	adrp	x9, 0x11d39b000 <dyld_stub_binder+0x11d39b000>
10658b404: 9139e129    	add	x9, x9, #0xe78
10658b408: f9452501    	ldr	x1, [x8, #0xa48]
10658b40c: 900b7088    	adrp	x8, 0x11d39b000 <dyld_stub_binder+0x11d39b000>
10658b410: 91396108    	add	x8, x8, #0xe58
10658b414: 1e6e1000    	fmov	d0, #1.00000000
10658b418: 1e602100    	fcmp	d8, d0
10658b41c: 9a890102    	csel	x2, x8, x9, eq
10658b420: 945a7211    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b424: aa1d03fd    	mov	x29, x29
10658b428: 945a7216    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658b42c: aa0003f5    	mov	x21, x0
10658b430: aa1403e0    	mov	x0, x20
10658b434: 945a720f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658b438: aa1303e0    	mov	x0, x19
10658b43c: 945a720d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658b440: aa1503e0    	mov	x0, x21
10658b444: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10658b448: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10658b44c: a94157f6    	ldp	x22, x21, [sp, #0x10]
10658b450: 6cc423e9    	ldp	d9, d8, [sp], #0x40
10658b454: 145a71f3    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
