
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105ae6868: 900c9168    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105ae686c: f00c9749    	adrp	x9, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae6870: b984a929    	ldrsw	x9, [x9, #0x4a8] ; ivar: SessionSelectController.m_selectedContacts offset=128
105ae6874: f8696802    	ldr	x2, [x0, x9]
105ae6878: f9434500    	ldr	x0, [x8, #0x688]
105ae687c: f00c8de8    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
105ae6880: f946d101    	ldr	x1, [x8, #0xda0] ; selector: arrayWithArray:
105ae6884: 148504f8    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
