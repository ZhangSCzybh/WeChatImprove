
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
10658b458: d10243ff    	sub	sp, sp, #0x90
10658b45c: 6d012beb    	stp	d11, d10, [sp, #0x10]
10658b460: 6d0223e9    	stp	d9, d8, [sp, #0x20]
10658b464: a9036ffc    	stp	x28, x27, [sp, #0x30]
10658b468: a90467fa    	stp	x26, x25, [sp, #0x40]
10658b46c: a9055ff8    	stp	x24, x23, [sp, #0x50]
10658b470: a90657f6    	stp	x22, x21, [sp, #0x60]
10658b474: a9074ff4    	stp	x20, x19, [sp, #0x70]
10658b478: a9087bfd    	stp	x29, x30, [sp, #0x80]
10658b47c: 910203fd    	add	x29, sp, #0x80
10658b480: aa0003f3    	mov	x19, x0
10658b484: 900c8e68    	adrp	x8, 0x11f757000 <dyld_stub_binder+0x11f757000>
10658b488: 52800029    	mov	w9, #0x1                ; =1
10658b48c: 3908e909    	strb	w9, [x8, #0x23a]
10658b490: d00c3c48    	adrp	x8, 0x11ed15000 <dyld_stub_binder+0x11ed15000>
10658b494: f9449900    	ldr	x0, [x8, #0x930]
10658b498: 945a71dc    	bl	0x107c27c08 <_Flutter_MMFoundation_BindContext+0x3eae8d4>
10658b49c: 900c2248    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
10658b4a0: f9413501    	ldr	x1, [x8, #0x268]
10658b4a4: d2800002    	mov	x2, #0x0                ; =0
10658b4a8: 945a71ef    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b4ac: aa0003f4    	mov	x20, x0
10658b4b0: b00c22a8    	adrp	x8, 0x11e9e0000 <dyld_stub_binder+0x11e9e0000>
10658b4b4: f9440101    	ldr	x1, [x8, #0x800]
10658b4b8: 945a71eb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b4bc: aa1403e0    	mov	x0, x20
10658b4c0: 945a71ec    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658b4c4: f00c4268    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
10658b4c8: b98d1914    	ldrsw	x20, [x8, #0xd18]
10658b4cc: fc746a6a    	ldr	d10, [x19, x20]
10658b4d0: 1e6e100b    	fmov	d11, #1.00000000
10658b4d4: 1e6b2140    	fcmp	d10, d11
10658b4d8: 1e2e1000    	fmov	s0, #1.00000000
10658b4dc: 1e2f1001    	fmov	s1, #1.50000000
10658b4e0: 1e200c28    	fcsel	s8, s1, s0, eq
10658b4e4: f00c3c3a    	adrp	x26, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10658b4e8: f943c340    	ldr	x0, [x26, #0x780]
10658b4ec: d00c21e8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10658b4f0: f9440119    	ldr	x25, [x8, #0x800]
10658b4f4: aa1903e1    	mov	x1, x25
10658b4f8: 945a71db    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b4fc: aa1d03fd    	mov	x29, x29
10658b500: 945a71e0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658b504: aa0003f7    	mov	x23, x0
10658b508: d00c3c5b    	adrp	x27, 0x11ed15000 <dyld_stub_binder+0x11ed15000>
10658b50c: f940ff60    	ldr	x0, [x27, #0x1f8]
10658b510: f00c38c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10658b514: f9428515    	ldr	x21, [x8, #0x508]
10658b518: aa1503e1    	mov	x1, x21
10658b51c: 945a71d2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b520: aa0003e2    	mov	x2, x0
10658b524: d00c21e8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10658b528: f9452116    	ldr	x22, [x8, #0xa40]
10658b52c: aa1703e0    	mov	x0, x23
10658b530: aa1603e1    	mov	x1, x22
10658b534: 945a71cc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b538: aa1d03fd    	mov	x29, x29
10658b53c: 945a71d1    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658b540: aa0003f8    	mov	x24, x0
10658b544: 1e22c109    	fcvt	d9, s8
10658b548: 900c2248    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
10658b54c: f9453101    	ldr	x1, [x8, #0xa60]
10658b550: 4ea91d20    	mov.16b	v0, v9
10658b554: 945a71c4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b558: aa1803e0    	mov	x0, x24
10658b55c: 945a71c5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658b560: aa1703e0    	mov	x0, x23
10658b564: 945a71c3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658b568: f943c340    	ldr	x0, [x26, #0x780]
10658b56c: f90007f9    	str	x25, [sp, #0x8]
10658b570: aa1903e1    	mov	x1, x25
10658b574: 945a71bc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b578: aa1d03fd    	mov	x29, x29
10658b57c: 945a71c1    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658b580: aa0003f9    	mov	x25, x0
10658b584: f940ff60    	ldr	x0, [x27, #0x1f8]
10658b588: aa1503e1    	mov	x1, x21
10658b58c: 945a71b6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b590: aa0003e2    	mov	x2, x0
10658b594: aa1903e0    	mov	x0, x25
10658b598: aa1603e1    	mov	x1, x22
10658b59c: 945a71b2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b5a0: aa1d03fd    	mov	x29, x29
10658b5a4: 945a71b7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658b5a8: aa0003fa    	mov	x26, x0
10658b5ac: f00c2208    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
10658b5b0: f941bd17    	ldr	x23, [x8, #0x378]
10658b5b4: aa1303e0    	mov	x0, x19
10658b5b8: aa1703e1    	mov	x1, x23
10658b5bc: 945a71aa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b5c0: aa1d03fd    	mov	x29, x29
10658b5c4: 945a71af    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658b5c8: aa0003fb    	mov	x27, x0
10658b5cc: d00c2d08    	adrp	x8, 0x11eb2d000 <dyld_stub_binder+0x11eb2d000>
10658b5d0: f9466918    	ldr	x24, [x8, #0xcd0]
10658b5d4: aa1a03e0    	mov	x0, x26
10658b5d8: aa1803e1    	mov	x1, x24
10658b5dc: aa1b03e2    	mov	x2, x27
10658b5e0: 945a71a1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b5e4: aa1d03fd    	mov	x29, x29
10658b5e8: 945a71a6    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658b5ec: aa0003fc    	mov	x28, x0
10658b5f0: fc746a60    	ldr	d0, [x19, x20]
10658b5f4: 1e624000    	fcvt	s0, d0
10658b5f8: 900c2f48    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
10658b5fc: f9441501    	ldr	x1, [x8, #0x828]
10658b600: 4ea81d01    	mov.16b	v1, v8
10658b604: 945a7198    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b608: aa1c03e0    	mov	x0, x28
10658b60c: 945a7199    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658b610: aa1b03e0    	mov	x0, x27
10658b614: 945a7197    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658b618: aa1a03e0    	mov	x0, x26
10658b61c: 945a7195    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658b620: aa1903e0    	mov	x0, x25
10658b624: 945a7193    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658b628: 1e6b2140    	fcmp	d10, d11
10658b62c: fc346a69    	str	d9, [x19, x20]
10658b630: 54000681    	b.ne	0x10658b700 <_Flutter_MMFoundation_BindContext+0x28123cc>
10658b634: f00c3c28    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10658b638: f943c100    	ldr	x0, [x8, #0x780]
10658b63c: f94007e1    	ldr	x1, [sp, #0x8]
10658b640: 945a7189    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b644: aa1d03fd    	mov	x29, x29
10658b648: 945a718e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658b64c: aa0003f4    	mov	x20, x0
10658b650: d00c3c48    	adrp	x8, 0x11ed15000 <dyld_stub_binder+0x11ed15000>
10658b654: f940fd00    	ldr	x0, [x8, #0x1f8]
10658b658: aa1503e1    	mov	x1, x21
10658b65c: 945a7182    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b660: aa0003e2    	mov	x2, x0
10658b664: aa1403e0    	mov	x0, x20
10658b668: aa1603e1    	mov	x1, x22
10658b66c: 945a717e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b670: aa1d03fd    	mov	x29, x29
10658b674: 945a7183    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658b678: aa0003f5    	mov	x21, x0
10658b67c: aa1303e0    	mov	x0, x19
10658b680: aa1703e1    	mov	x1, x23
10658b684: 945a7178    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b688: aa1d03fd    	mov	x29, x29
10658b68c: 945a717d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658b690: aa0003f3    	mov	x19, x0
10658b694: aa1503e0    	mov	x0, x21
10658b698: aa1803e1    	mov	x1, x24
10658b69c: aa1303e2    	mov	x2, x19
10658b6a0: 945a7171    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b6a4: aa1d03fd    	mov	x29, x29
10658b6a8: 945a7176    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658b6ac: aa0003f6    	mov	x22, x0
10658b6b0: 900c2f48    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
10658b6b4: f9441901    	ldr	x1, [x8, #0x830]
10658b6b8: 945a716b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b6bc: aa1603e0    	mov	x0, x22
10658b6c0: 945a716c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658b6c4: aa1303e0    	mov	x0, x19
10658b6c8: 945a716a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658b6cc: aa1503e0    	mov	x0, x21
10658b6d0: 945a7168    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658b6d4: aa1403e0    	mov	x0, x20
10658b6d8: a9487bfd    	ldp	x29, x30, [sp, #0x80]
10658b6dc: a9474ff4    	ldp	x20, x19, [sp, #0x70]
10658b6e0: a94657f6    	ldp	x22, x21, [sp, #0x60]
10658b6e4: a9455ff8    	ldp	x24, x23, [sp, #0x50]
10658b6e8: a94467fa    	ldp	x26, x25, [sp, #0x40]
10658b6ec: a9436ffc    	ldp	x28, x27, [sp, #0x30]
10658b6f0: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
10658b6f4: 6d412beb    	ldp	d11, d10, [sp, #0x10]
10658b6f8: 910243ff    	add	sp, sp, #0x90
10658b6fc: 145a715d    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658b700: a9487bfd    	ldp	x29, x30, [sp, #0x80]
10658b704: a9474ff4    	ldp	x20, x19, [sp, #0x70]
10658b708: a94657f6    	ldp	x22, x21, [sp, #0x60]
10658b70c: a9455ff8    	ldp	x24, x23, [sp, #0x50]
10658b710: a94467fa    	ldp	x26, x25, [sp, #0x40]
10658b714: a9436ffc    	ldp	x28, x27, [sp, #0x30]
10658b718: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
10658b71c: 6d412beb    	ldp	d11, d10, [sp, #0x10]
10658b720: 910243ff    	add	sp, sp, #0x90
10658b724: d65f03c0    	ret
