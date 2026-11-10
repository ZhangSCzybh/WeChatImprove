
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
1050a6284: b00ce908    	adrp	x8, 0x11edc7000 <dyld_stub_binder+0x11edc7000>
1050a6288: b98edd08    	ldrsw	x8, [x8, #0xedc] ; ivar: MsgPlayingFacade.m_playingController offset=8
1050a628c: f8686800    	ldr	x0, [x0, x8]
1050a6290: d00cc9c8    	adrp	x8, 0x11e9e0000 <dyld_stub_binder+0x11e9e0000>
1050a6294: f9446101    	ldr	x1, [x8, #0x8c0] ; selector: currentPlayingMsg
1050a6298: 14ae0673    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
