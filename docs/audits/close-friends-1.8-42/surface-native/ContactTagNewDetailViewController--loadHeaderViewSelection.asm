
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101062080: 900f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
101062084: b9838108    	ldrsw	x8, [x8, #0x380] ; ivar ContactTagNewDetailViewController._tableView
101062088: f8686800    	ldr	x0, [x0, x8]
10106208c: b00f6ec8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101062090: f945a901    	ldr	x1, [x8, #0xb50] ; reloadIndexView
101062094: 15af142a    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
