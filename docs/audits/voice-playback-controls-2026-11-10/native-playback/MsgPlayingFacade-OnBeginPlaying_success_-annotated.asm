
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
1050a6fc8: d101c3ff    	sub	sp, sp, #0x70
1050a6fcc: a9035ff8    	stp	x24, x23, [sp, #0x30]
1050a6fd0: a90457f6    	stp	x22, x21, [sp, #0x40]
1050a6fd4: a9054ff4    	stp	x20, x19, [sp, #0x50]
1050a6fd8: a9067bfd    	stp	x29, x30, [sp, #0x60]
1050a6fdc: 910183fd    	add	x29, sp, #0x60
1050a6fe0: aa0203f3    	mov	x19, x2
1050a6fe4: aa0003f4    	mov	x20, x0
1050a6fe8: 900d3568    	adrp	x8, 0x11f752000 <dyld_stub_binder+0x11f752000>
1050a6fec: 52800029    	mov	w9, #0x1                ; =1
1050a6ff0: 3919f109    	strb	w9, [x8, #0x67c]
1050a6ff4: aa0203e0    	mov	x0, x2
1050a6ff8: 94ae031f    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1050a6ffc: f00cd428    	adrp	x8, 0x11eb2d000 <dyld_stub_binder+0x11eb2d000>
1050a7000: f9466901    	ldr	x1, [x8, #0xcd0] ; selector: reporterWithMsg:
1050a7004: aa1403e0    	mov	x0, x20
1050a7008: aa1303e2    	mov	x2, x19
1050a700c: 94ae0316    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a7010: aa1d03fd    	mov	x29, x29
1050a7014: 94ae031b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1050a7018: aa0003f5    	mov	x21, x0
1050a701c: d00cd428    	adrp	x8, 0x11eb2d000 <dyld_stub_binder+0x11eb2d000>
1050a7020: f9466d01    	ldr	x1, [x8, #0xcd8] ; selector: onStartPlay
1050a7024: 94ae0310    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a7028: aa1503e0    	mov	x0, x21
1050a702c: 94ae0311    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1050a7030: 900ce908    	adrp	x8, 0x11edc7000 <dyld_stub_binder+0x11edc7000>
1050a7034: b98ee508    	ldrsw	x8, [x8, #0xee4] ; ivar: MsgPlayingFacade._currentInterruptMsg offset=48
1050a7038: f8686a80    	ldr	x0, [x20, x8]
1050a703c: f8286a9f    	str	xzr, [x20, x8]
1050a7040: 94ae030c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1050a7044: 900ce908    	adrp	x8, 0x11edc7000 <dyld_stub_binder+0x11edc7000>
1050a7048: b98eed08    	ldrsw	x8, [x8, #0xeec] ; ivar: MsgPlayingFacade.m_autoplayController offset=16
1050a704c: f8686a80    	ldr	x0, [x20, x8]
1050a7050: f00cc9e8    	adrp	x8, 0x11e9e6000 <dyld_stub_binder+0x11e9e6000>
1050a7054: f9433501    	ldr	x1, [x8, #0x668] ; selector: autoPlayEnabled
1050a7058: 94ae0303    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a705c: aa0003f4    	mov	x20, x0
1050a7060: f00ce348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1050a7064: f943c100    	ldr	x0, [x8, #0x780]
1050a7068: d00cc908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1050a706c: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
1050a7070: 94ae02fd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a7074: aa1d03fd    	mov	x29, x29
1050a7078: 94ae0302    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1050a707c: aa0003f5    	mov	x21, x0
1050a7080: 900ce348    	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
1050a7084: f9443516    	ldr	x22, [x8, #0x868]
1050a7088: d00cd428    	adrp	x8, 0x11eb2d000 <dyld_stub_binder+0x11eb2d000>
1050a708c: f9467117    	ldr	x23, [x8, #0xce0] ; selector: onBeginPlayingMsg:autoPlayEnabled:
1050a7090: b00c3528    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1050a7094: f9449908    	ldr	x8, [x8, #0x930]
1050a7098: f90003e8    	str	x8, [sp]
1050a709c: 90094108    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
1050a70a0: fd434100    	ldr	d0, [x8, #0x680] ; constant double=1.6080749353e-314
1050a70a4: fd0007e0    	str	d0, [sp, #0x8]
1050a70a8: 90000008    	adrp	x8, 0x1050a7000 <_Flutter_MMFoundation_BindContext+0x132dccc>
1050a70ac: 91047108    	add	x8, x8, #0x11c
1050a70b0: d00b8ec9    	adrp	x9, 0x11c281000 <dyld_stub_binder+0x11c281000>
1050a70b4: 912ba129    	add	x9, x9, #0xae8
1050a70b8: a90127e8    	stp	x8, x9, [sp, #0x10]
1050a70bc: f90013f3    	str	x19, [sp, #0x20]
1050a70c0: 3900a3f4    	strb	w20, [sp, #0x28]
1050a70c4: d00cc908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1050a70c8: f9472d14    	ldr	x20, [x8, #0xe58] ; selector: callExtension:selector:block:
1050a70cc: aa1303e0    	mov	x0, x19
1050a70d0: 94ae02e9    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1050a70d4: 910003e4    	mov	x4, sp
1050a70d8: aa1503e0    	mov	x0, x21
1050a70dc: aa1403e1    	mov	x1, x20
1050a70e0: aa1603e2    	mov	x2, x22
1050a70e4: aa1703e3    	mov	x3, x23
1050a70e8: 94ae02df    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a70ec: aa1503e0    	mov	x0, x21
1050a70f0: 94ae02e0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1050a70f4: f94013e0    	ldr	x0, [sp, #0x20]
1050a70f8: 94ae02de    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1050a70fc: aa1303e0    	mov	x0, x19
1050a7100: 94ae02dc    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1050a7104: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1050a7108: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1050a710c: a94457f6    	ldp	x22, x21, [sp, #0x40]
1050a7110: a9435ff8    	ldp	x24, x23, [sp, #0x30]
1050a7114: 9101c3ff    	add	sp, sp, #0x70
1050a7118: d65f03c0    	ret
1050a711c: aa0103e8    	mov	x8, x1
1050a7120: f9401002    	ldr	x2, [x0, #0x20]
1050a7124: 3940a003    	ldrb	w3, [x0, #0x28]
1050a7128: d00cd429    	adrp	x9, 0x11eb2d000 <dyld_stub_binder+0x11eb2d000>
1050a712c: f9467121    	ldr	x1, [x9, #0xce0] ; selector: onBeginPlayingMsg:autoPlayEnabled:
1050a7130: aa0803e0    	mov	x0, x8
1050a7134: 14ae02cc    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
