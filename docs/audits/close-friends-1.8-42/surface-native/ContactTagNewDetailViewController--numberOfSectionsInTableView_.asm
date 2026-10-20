
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010617a4: b00f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010617a8: b9838508    	ldrsw	x8, [x8, #0x384] ; ivar ContactTagNewDetailViewController._contactsKeyArray
1010617ac: f8686800    	ldr	x0, [x0, x8]
1010617b0: f00f84e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1010617b4: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1010617b8: 15af1661    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
