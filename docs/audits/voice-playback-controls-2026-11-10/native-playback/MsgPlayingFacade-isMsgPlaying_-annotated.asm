
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
1050a61ec: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1050a61f0: a9014ff4    	stp	x20, x19, [sp, #0x10]
1050a61f4: a9027bfd    	stp	x29, x30, [sp, #0x20]
1050a61f8: 910083fd    	add	x29, sp, #0x20
1050a61fc: aa0203f3    	mov	x19, x2
1050a6200: b00ce908    	adrp	x8, 0x11edc7000 <dyld_stub_binder+0x11edc7000>
1050a6204: b98edd08    	ldrsw	x8, [x8, #0xedc] ; ivar: MsgPlayingFacade.m_playingController offset=8
1050a6208: f8686814    	ldr	x20, [x0, x8]
1050a620c: d00cc9c8    	adrp	x8, 0x11e9e0000 <dyld_stub_binder+0x11e9e0000>
1050a6210: f9446115    	ldr	x21, [x8, #0x8c0] ; selector: currentPlayingMsg
1050a6214: aa0203e0    	mov	x0, x2
1050a6218: 94ae0697    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1050a621c: aa1403e0    	mov	x0, x20
1050a6220: aa1503e1    	mov	x1, x21
1050a6224: 94ae0690    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a6228: aa1d03fd    	mov	x29, x29
1050a622c: 94ae0695    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1050a6230: aa0003f4    	mov	x20, x0
1050a6234: b00cc948    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
1050a6238: f9466d01    	ldr	x1, [x8, #0xcd8] ; selector: IsSameMsg:
1050a623c: aa1303e2    	mov	x2, x19
1050a6240: 94ae0689    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a6244: aa0003f5    	mov	x21, x0
1050a6248: aa1303e0    	mov	x0, x19
1050a624c: 94ae0689    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1050a6250: aa1403e0    	mov	x0, x20
1050a6254: 94ae0687    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1050a6258: aa1503e0    	mov	x0, x21
1050a625c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1050a6260: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1050a6264: a8c357f6    	ldp	x22, x21, [sp], #0x30
1050a6268: d65f03c0    	ret
