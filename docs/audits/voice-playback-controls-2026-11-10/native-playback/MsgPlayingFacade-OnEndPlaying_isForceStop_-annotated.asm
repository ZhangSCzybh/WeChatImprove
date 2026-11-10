
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
1050a722c: d101c3ff    	sub	sp, sp, #0x70
1050a7230: a9035ff8    	stp	x24, x23, [sp, #0x30]
1050a7234: a90457f6    	stp	x22, x21, [sp, #0x40]
1050a7238: a9054ff4    	stp	x20, x19, [sp, #0x50]
1050a723c: a9067bfd    	stp	x29, x30, [sp, #0x60]
1050a7240: 910183fd    	add	x29, sp, #0x60
1050a7244: aa0203f3    	mov	x19, x2
1050a7248: aa0003f5    	mov	x21, x0
1050a724c: f00d3548    	adrp	x8, 0x11f752000 <dyld_stub_binder+0x11f752000>
1050a7250: 52800029    	mov	w9, #0x1                ; =1
1050a7254: 3919f509    	strb	w9, [x8, #0x67d]
1050a7258: aa0203e0    	mov	x0, x2
1050a725c: 94ae0286    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1050a7260: 900ce908    	adrp	x8, 0x11edc7000 <dyld_stub_binder+0x11edc7000>
1050a7264: b98eed16    	ldrsw	x22, [x8, #0xeec] ; ivar: MsgPlayingFacade.m_autoplayController offset=16
1050a7268: f8766aa0    	ldr	x0, [x21, x22]
1050a726c: f00cc9e8    	adrp	x8, 0x11e9e6000 <dyld_stub_binder+0x11e9e6000>
1050a7270: f9433501    	ldr	x1, [x8, #0x668] ; selector: autoPlayEnabled
1050a7274: 94ae027c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a7278: aa0003f4    	mov	x20, x0
1050a727c: 36000160    	tbz	w0, #0x0, 0x1050a72a8 <_Flutter_MMFoundation_BindContext+0x132df74>
1050a7280: f8766aa0    	ldr	x0, [x21, x22]
1050a7284: f00ccd68    	adrp	x8, 0x11ea56000 <dyld_stub_binder+0x11ea56000>
1050a7288: f9456501    	ldr	x1, [x8, #0xac8] ; selector: paused
1050a728c: 94ae0276    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a7290: 34000280    	cbz	w0, 0x1050a72e0 <_Flutter_MMFoundation_BindContext+0x132dfac>
1050a7294: d00cd428    	adrp	x8, 0x11eb2d000 <dyld_stub_binder+0x11eb2d000>
1050a7298: f9461d01    	ldr	x1, [x8, #0xc38] ; selector: hideMinimizeViewIfNeed
1050a729c: aa1503e0    	mov	x0, x21
1050a72a0: 94ae0271    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a72a4: 14000009    	b	0x1050a72c8 <_Flutter_MMFoundation_BindContext+0x132df94>
1050a72a8: d00cd428    	adrp	x8, 0x11eb2d000 <dyld_stub_binder+0x11eb2d000>
1050a72ac: f9461d02    	ldr	x2, [x8, #0xc38] ; selector: hideMinimizeViewIfNeed
1050a72b0: d00cc908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1050a72b4: f9476501    	ldr	x1, [x8, #0xec8] ; selector: safePerformSelector:withObject:afterDelay:
1050a72b8: 1e601000    	fmov	d0, #2.00000000
1050a72bc: aa1503e0    	mov	x0, x21
1050a72c0: d2800003    	mov	x3, #0x0                ; =0
1050a72c4: 94ae0268    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a72c8: 900ce908    	adrp	x8, 0x11edc7000 <dyld_stub_binder+0x11edc7000>
1050a72cc: b98ee108    	ldrsw	x8, [x8, #0xee0] ; ivar: MsgPlayingFacade.m_minimizeController offset=24
1050a72d0: f8686aa0    	ldr	x0, [x21, x8]
1050a72d4: d00ce028    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1050a72d8: f941e501    	ldr	x1, [x8, #0x3c8] ; selector: stopAnimating
1050a72dc: 94ae0262    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a72e0: f00ce348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1050a72e4: f943c100    	ldr	x0, [x8, #0x780]
1050a72e8: d00cc908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1050a72ec: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
1050a72f0: 94ae025d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a72f4: aa1d03fd    	mov	x29, x29
1050a72f8: 94ae0262    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1050a72fc: aa0003f5    	mov	x21, x0
1050a7300: 900ce348    	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
1050a7304: f9443516    	ldr	x22, [x8, #0x868]
1050a7308: d00cd428    	adrp	x8, 0x11eb2d000 <dyld_stub_binder+0x11eb2d000>
1050a730c: f9467917    	ldr	x23, [x8, #0xcf0] ; selector: onEndPlayingMsg:autoPlayEnabled:
1050a7310: b00c3528    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1050a7314: f9449908    	ldr	x8, [x8, #0x930]
1050a7318: f90003e8    	str	x8, [sp]
1050a731c: 90094108    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
1050a7320: fd434100    	ldr	d0, [x8, #0x680] ; constant double=1.6080749353e-314
1050a7324: fd0007e0    	str	d0, [sp, #0x8]
1050a7328: 90000008    	adrp	x8, 0x1050a7000 <_Flutter_MMFoundation_BindContext+0x132dccc>
1050a732c: 910e7108    	add	x8, x8, #0x39c
1050a7330: d00b8ec9    	adrp	x9, 0x11c281000 <dyld_stub_binder+0x11c281000>
1050a7334: 912ba129    	add	x9, x9, #0xae8
1050a7338: a90127e8    	stp	x8, x9, [sp, #0x10]
1050a733c: f90013f3    	str	x19, [sp, #0x20]
1050a7340: 3900a3f4    	strb	w20, [sp, #0x28]
1050a7344: d00cc908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1050a7348: f9472d14    	ldr	x20, [x8, #0xe58] ; selector: callExtension:selector:block:
1050a734c: aa1303e0    	mov	x0, x19
1050a7350: 94ae0249    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1050a7354: 910003e4    	mov	x4, sp
1050a7358: aa1503e0    	mov	x0, x21
1050a735c: aa1403e1    	mov	x1, x20
1050a7360: aa1603e2    	mov	x2, x22
1050a7364: aa1703e3    	mov	x3, x23
1050a7368: 94ae023f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a736c: aa1503e0    	mov	x0, x21
1050a7370: 94ae0240    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1050a7374: f94013e0    	ldr	x0, [sp, #0x20]
1050a7378: 94ae023e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1050a737c: aa1303e0    	mov	x0, x19
1050a7380: 94ae023c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1050a7384: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1050a7388: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1050a738c: a94457f6    	ldp	x22, x21, [sp, #0x40]
1050a7390: a9435ff8    	ldp	x24, x23, [sp, #0x30]
1050a7394: 9101c3ff    	add	sp, sp, #0x70
1050a7398: d65f03c0    	ret
1050a739c: aa0103e8    	mov	x8, x1
1050a73a0: f9401002    	ldr	x2, [x0, #0x20]
1050a73a4: 3940a003    	ldrb	w3, [x0, #0x28]
1050a73a8: d00cd429    	adrp	x9, 0x11eb2d000 <dyld_stub_binder+0x11eb2d000>
1050a73ac: f9467921    	ldr	x1, [x9, #0xcf0] ; selector: onEndPlayingMsg:autoPlayEnabled:
1050a73b0: aa0803e0    	mov	x0, x8
1050a73b4: 14ae022c    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
