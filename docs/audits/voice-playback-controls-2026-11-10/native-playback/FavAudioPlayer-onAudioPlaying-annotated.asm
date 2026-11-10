
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101a1943c: d10143ff    	sub	sp, sp, #0x50
101a19440: a9034ff4    	stp	x20, x19, [sp, #0x30]
101a19444: a9047bfd    	stp	x29, x30, [sp, #0x40]
101a19448: 910103fd    	add	x29, sp, #0x40
101a1944c: aa0003f3    	mov	x19, x0
101a19450: 900ee968    	adrp	x8, 0x11f745000 <dyld_stub_binder+0x11f745000>
101a19454: 52800029    	mov	w9, #0x1                ; =1
101a19458: b00e9bca    	adrp	x10, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a1945c: b98cf14a    	ldrsw	x10, [x10, #0xcf0] ; ivar: FavAudioPlayer.m_uiAudioOffset offset=24
101a19460: bc6a6800    	ldr	s0, [x0, x10]
101a19464: 393b2509    	strb	w9, [x8, #0xec9]
101a19468: 7e21d800    	ucvtf	s0, s0
101a1946c: 52a872c8    	mov	w8, #0x43960000         ; =1133903872
101a19470: 1e270101    	fmov	s1, w8
101a19474: 1e212800    	fadd	s0, s0, s1
101a19478: 7ea1b800    	fcvtzu	s0, s0
101a1947c: bc2a6800    	str	s0, [x0, x10]
101a19480: b00e97c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a19484: f943c100    	ldr	x0, [x8, #0x780]
101a19488: 900e7d88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a1948c: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
101a19490: 958839f5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a19494: aa1d03fd    	mov	x29, x29
101a19498: 958839fa    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a1949c: aa0003f4    	mov	x20, x0
101a194a0: f00e97a8    	adrp	x8, 0x11ed10000 <dyld_stub_binder+0x11ed10000>
101a194a4: f9402d02    	ldr	x2, [x8, #0x58]
101a194a8: 900e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a194ac: f944bd03    	ldr	x3, [x8, #0x978] ; selector: OnAudioPlaying:Offset:
101a194b0: f00de988    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
101a194b4: f9449908    	ldr	x8, [x8, #0x930]
101a194b8: f90007e8    	str	x8, [sp, #0x8]
101a194bc: d00af568    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
101a194c0: fd434100    	ldr	d0, [x8, #0x680] ; constant double=1.6080749353e-314
101a194c4: 90000008    	adrp	x8, 0x101a19000 <__text+0x1a11000>
101a194c8: 91142108    	add	x8, x8, #0x508
101a194cc: f00d4329    	adrp	x9, 0x11c280000 <dyld_stub_binder+0x11c280000>
101a194d0: 911f8129    	add	x9, x9, #0x7e0
101a194d4: fd000be0    	str	d0, [sp, #0x10]
101a194d8: a901a7e8    	stp	x8, x9, [sp, #0x18]
101a194dc: f90017f3    	str	x19, [sp, #0x28]
101a194e0: 900e7d88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a194e4: f9472d01    	ldr	x1, [x8, #0xe58] ; selector: callExtension:selector:block:
101a194e8: 910023e4    	add	x4, sp, #0x8
101a194ec: 958839de    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a194f0: aa1403e0    	mov	x0, x20
101a194f4: 958839df    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a194f8: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101a194fc: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101a19500: 910143ff    	add	sp, sp, #0x50
101a19504: d65f03c0    	ret
101a19508: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
101a1950c: a9014ff4    	stp	x20, x19, [sp, #0x10]
101a19510: a9027bfd    	stp	x29, x30, [sp, #0x20]
101a19514: 910083fd    	add	x29, sp, #0x20
101a19518: aa0103f3    	mov	x19, x1
101a1951c: aa0003f4    	mov	x20, x0
101a19520: f9401008    	ldr	x8, [x0, #0x20]
101a19524: b00e9bc9    	adrp	x9, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a19528: b98ced29    	ldrsw	x9, [x9, #0xcec] ; ivar: FavAudioPlayer.m_curAudioInfo offset=8
101a1952c: f8696915    	ldr	x21, [x8, x9]
101a19530: 900e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a19534: f944ad16    	ldr	x22, [x8, #0x958] ; selector: m_nsAudioID
101a19538: aa0103e0    	mov	x0, x1
101a1953c: 958839ce    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101a19540: aa1503e0    	mov	x0, x21
101a19544: aa1603e1    	mov	x1, x22
101a19548: 958839c7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a1954c: aa1d03fd    	mov	x29, x29
101a19550: 958839cc    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a19554: aa0003f5    	mov	x21, x0
101a19558: f9401288    	ldr	x8, [x20, #0x20]
101a1955c: b00e9bc9    	adrp	x9, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a19560: b98cf129    	ldrsw	x9, [x9, #0xcf0] ; ivar: FavAudioPlayer.m_uiAudioOffset offset=24
101a19564: b8696903    	ldr	w3, [x8, x9]
101a19568: 900e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a1956c: f944bd01    	ldr	x1, [x8, #0x978] ; selector: OnAudioPlaying:Offset:
101a19570: aa1303e0    	mov	x0, x19
101a19574: aa1503e2    	mov	x2, x21
101a19578: 958839bb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a1957c: aa1303e0    	mov	x0, x19
101a19580: 958839bc    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a19584: aa1503e0    	mov	x0, x21
101a19588: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101a1958c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101a19590: a8c357f6    	ldp	x22, x21, [sp], #0x30
101a19594: 158839b7    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
