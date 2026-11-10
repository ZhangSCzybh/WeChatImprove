
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105ae8dbc: b00c9748    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae8dc0: b9848508    	ldrsw	x8, [x8, #0x484] ; ivar: SessionSelectController.m_bMultiSelect offset=200
105ae8dc4: 3828681f    	strb	wzr, [x0, x8]
105ae8dc8: d00c7968    	adrp	x8, 0x11ea16000 <dyld_stub_binder+0x11ea16000>
105ae8dcc: f9464101    	ldr	x1, [x8, #0xc80] ; selector: animateUpdateView
105ae8dd0: 1484fba5    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
