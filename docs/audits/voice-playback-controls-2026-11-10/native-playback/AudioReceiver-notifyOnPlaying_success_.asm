
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10017736c: d101c3ff    	sub	sp, sp, #0x70
100177370: a9035ff8    	stp	x24, x23, [sp, #0x30]
100177374: a90457f6    	stp	x22, x21, [sp, #0x40]
100177378: a9054ff4    	stp	x20, x19, [sp, #0x50]
10017737c: a9067bfd    	stp	x29, x30, [sp, #0x60]
100177380: 910183fd    	add	x29, sp, #0x60
100177384: aa0303f4    	mov	x20, x3
100177388: aa0203f3    	mov	x19, x2
10017738c: aa0203e0    	mov	x0, x2
100177390: 95eac239    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100177394: f00f5cc8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100177398: f943c100    	ldr	x0, [x8, #0x780]
10017739c: d00f4288    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1001773a0: f9440101    	ldr	x1, [x8, #0x800]
1001773a4: 95eac230    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1001773a8: aa1d03fd    	mov	x29, x29
1001773ac: 95eac235    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1001773b0: aa0003f5    	mov	x21, x0
1001773b4: 900f5cc8    	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
1001773b8: f9432d16    	ldr	x22, [x8, #0x658]
1001773bc: 900f42e8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
1001773c0: f9454117    	ldr	x23, [x8, #0xa80]
1001773c4: b00eaea8    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1001773c8: f9449908    	ldr	x8, [x8, #0x930]
1001773cc: f90003e8    	str	x8, [sp]
1001773d0: 900bba88    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
1001773d4: fd434100    	ldr	d0, [x8, #0x680]
1001773d8: fd0007e0    	str	d0, [sp, #0x8]
1001773dc: 90000008    	adrp	x8, 0x100177000 <__text+0x16f000>
1001773e0: 91114108    	add	x8, x8, #0x450
1001773e4: d00e0849    	adrp	x9, 0x11c281000 <dyld_stub_binder+0x11c281000>
1001773e8: 912ba129    	add	x9, x9, #0xae8
1001773ec: a90127e8    	stp	x8, x9, [sp, #0x10]
1001773f0: f90013f3    	str	x19, [sp, #0x20]
1001773f4: 3900a3f4    	strb	w20, [sp, #0x28]
1001773f8: d00f4288    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1001773fc: f9472d14    	ldr	x20, [x8, #0xe58]
100177400: aa1303e0    	mov	x0, x19
100177404: 95eac21c    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100177408: 910003e4    	mov	x4, sp
10017740c: aa1503e0    	mov	x0, x21
100177410: aa1403e1    	mov	x1, x20
100177414: aa1603e2    	mov	x2, x22
100177418: aa1703e3    	mov	x3, x23
10017741c: 95eac212    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177420: aa1503e0    	mov	x0, x21
100177424: 95eac213    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100177428: f94013e0    	ldr	x0, [sp, #0x20]
10017742c: 95eac211    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100177430: aa1303e0    	mov	x0, x19
100177434: 95eac20f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100177438: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10017743c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
100177440: a94457f6    	ldp	x22, x21, [sp, #0x40]
100177444: a9435ff8    	ldp	x24, x23, [sp, #0x30]
100177448: 9101c3ff    	add	sp, sp, #0x70
10017744c: d65f03c0    	ret
100177450: aa0103e8    	mov	x8, x1
100177454: f9401002    	ldr	x2, [x0, #0x20]
100177458: 3940a003    	ldrb	w3, [x0, #0x28]
10017745c: 900f42e9    	adrp	x9, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
100177460: f9454121    	ldr	x1, [x9, #0xa80]
100177464: aa0803e0    	mov	x0, x8
100177468: 15eac1ff    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
