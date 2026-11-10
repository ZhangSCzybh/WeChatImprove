
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105ae8da0: b00c9748    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae8da4: b9848508    	ldrsw	x8, [x8, #0x484] ; ivar: SessionSelectController.m_bMultiSelect offset=200
105ae8da8: 52800029    	mov	w9, #0x1                ; =1
105ae8dac: 38286809    	strb	w9, [x0, x8]
105ae8db0: d00c7968    	adrp	x8, 0x11ea16000 <dyld_stub_binder+0x11ea16000>
105ae8db4: f9464101    	ldr	x1, [x8, #0xc80] ; selector: animateUpdateView
105ae8db8: 1484fbab    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
