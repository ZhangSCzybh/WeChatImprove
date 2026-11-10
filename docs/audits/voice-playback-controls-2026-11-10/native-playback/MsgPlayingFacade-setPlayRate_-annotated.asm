
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
1050a6584: b00ce908    	adrp	x8, 0x11edc7000 <dyld_stub_binder+0x11edc7000>
1050a6588: b98edd08    	ldrsw	x8, [x8, #0xedc] ; ivar: MsgPlayingFacade.m_playingController offset=8
1050a658c: f8686800    	ldr	x0, [x0, x8]
1050a6590: b00cc968    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
1050a6594: f9453101    	ldr	x1, [x8, #0xa60] ; selector: setPlayRate:
1050a6598: 14ae05b3    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
