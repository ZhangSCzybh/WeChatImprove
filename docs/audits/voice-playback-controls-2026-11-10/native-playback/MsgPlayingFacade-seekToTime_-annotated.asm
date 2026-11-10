
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
1050a659c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1050a65a0: a9014ff4    	stp	x20, x19, [sp, #0x10]
1050a65a4: a9027bfd    	stp	x29, x30, [sp, #0x20]
1050a65a8: 910083fd    	add	x29, sp, #0x20
1050a65ac: aa0203f3    	mov	x19, x2
1050a65b0: b00ce908    	adrp	x8, 0x11edc7000 <dyld_stub_binder+0x11edc7000>
1050a65b4: b98edd08    	ldrsw	x8, [x8, #0xedc] ; ivar: MsgPlayingFacade.m_playingController offset=8
1050a65b8: f8686814    	ldr	x20, [x0, x8]
1050a65bc: d00cc9c8    	adrp	x8, 0x11e9e0000 <dyld_stub_binder+0x11e9e0000>
1050a65c0: f9446101    	ldr	x1, [x8, #0x8c0] ; selector: currentPlayingMsg
1050a65c4: 94ae05a8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a65c8: aa1d03fd    	mov	x29, x29
1050a65cc: 94ae05ad    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1050a65d0: aa0003f5    	mov	x21, x0
1050a65d4: f00cd428    	adrp	x8, 0x11eb2d000 <dyld_stub_binder+0x11eb2d000>
1050a65d8: f9464501    	ldr	x1, [x8, #0xc88] ; selector: SeekVoiceMsg:toTime:
1050a65dc: aa1403e0    	mov	x0, x20
1050a65e0: aa1503e2    	mov	x2, x21
1050a65e4: aa1303e3    	mov	x3, x19
1050a65e8: 94ae059f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a65ec: aa1503e0    	mov	x0, x21
1050a65f0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1050a65f4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1050a65f8: a8c357f6    	ldp	x22, x21, [sp], #0x30
1050a65fc: 14ae059d    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
