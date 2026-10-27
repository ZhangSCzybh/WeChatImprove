
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10511f7cc: d101c3ff    	sub	sp, sp, #0x70
10511f7d0: 6d0123e9    	stp	d9, d8, [sp, #0x10]
10511f7d4: a90267fa    	stp	x26, x25, [sp, #0x20]
10511f7d8: a9035ff8    	stp	x24, x23, [sp, #0x30]
10511f7dc: a90457f6    	stp	x22, x21, [sp, #0x40]
10511f7e0: a9054ff4    	stp	x20, x19, [sp, #0x50]
10511f7e4: a9067bfd    	stp	x29, x30, [sp, #0x60]
10511f7e8: 910183fd    	add	x29, sp, #0x60
10511f7ec: aa0303f4    	mov	x20, x3
10511f7f0: aa0203f3    	mov	x19, x2
10511f7f4: aa0003f5    	mov	x21, x0
10511f7f8: 900dd908    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
10511f7fc: 52800029    	mov	w9, #0x1                ; =1
10511f800: 392e0d09    	strb	w9, [x8, #0xb83]
10511f804: aa0203e0    	mov	x0, x2
10511f808: 94ac1e4c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511f80c: aa1403e0    	mov	x0, x20
10511f810: 94ac1e4a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511f814: b00d8848    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10511f818: b9831508    	ldrsw	x8, [x8, #0x314]
10511f81c: f8686aa0    	ldr	x0, [x21, x8]
10511f820: f00d73c8    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
10511f824: f9437501    	ldr	x1, [x8, #0x6e8] ; m_bReadyToLoadData
10511f828: 94ac1e45    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f82c: 36000160    	tbz	w0, #0x0, 0x10511f858 <_Flutter_MMFoundation_BindContext+0x15fb43c>
10511f830: b00d8848    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10511f834: b9831908    	ldrsw	x8, [x8, #0x318]
10511f838: f8686aa8    	ldr	x8, [x21, x8]
10511f83c: eb13011f    	cmp	x8, x19
10511f840: 540000c1    	b.ne	0x10511f858 <_Flutter_MMFoundation_BindContext+0x15fb43c>
10511f844: b00d68e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10511f848: f9427d01    	ldr	x1, [x8, #0x4f8] ; section
10511f84c: aa1403e0    	mov	x0, x20
10511f850: 94ac1e3b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f854: b4000220    	cbz	x0, 0x10511f898 <_Flutter_MMFoundation_BindContext+0x15fb47c>
10511f858: b00d8848    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10511f85c: b9833908    	ldrsw	x8, [x8, #0x338]
10511f860: fc686aa8    	ldr	d8, [x21, x8]
10511f864: aa1403e0    	mov	x0, x20
10511f868: 94ac1e3b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f86c: aa1303e0    	mov	x0, x19
10511f870: 94ac1e39    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f874: 1e604100    	fmov	d0, d8
10511f878: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10511f87c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10511f880: a94457f6    	ldp	x22, x21, [sp, #0x40]
10511f884: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10511f888: a94267fa    	ldp	x26, x25, [sp, #0x20]
10511f88c: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
10511f890: 9101c3ff    	add	sp, sp, #0x70
10511f894: d65f03c0    	ret
10511f898: b00d8848    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10511f89c: b9835108    	ldrsw	x8, [x8, #0x350]
10511f8a0: f8686ab5    	ldr	x21, [x21, x8]
10511f8a4: f00d7f28    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10511f8a8: f9440901    	ldr	x1, [x8, #0x810] ; row
10511f8ac: aa1403e0    	mov	x0, x20
10511f8b0: 94ac1e23    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f8b4: 2a0003e2    	mov	w2, w0
10511f8b8: 900d73e8    	adrp	x8, 0x11ff9b000 <dyld_stub_binder+0x11ff9b000>
10511f8bc: f9403501    	ldr	x1, [x8, #0x68] ; getBanner:
10511f8c0: aa1503e0    	mov	x0, x21
10511f8c4: 94ac1e1e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f8c8: aa1d03fd    	mov	x29, x29
10511f8cc: 94ac1e1f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f8d0: aa0003f5    	mov	x21, x0
10511f8d4: f00d7f08    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10511f8d8: f9449d16    	ldr	x22, [x8, #0x938] ; height
10511f8dc: b4000940    	cbz	x0, 0x10511fa04 <_Flutter_MMFoundation_BindContext+0x15fb5e8>
10511f8e0: aa1503e0    	mov	x0, x21
10511f8e4: aa1603e1    	mov	x1, x22
10511f8e8: 94ac1e15    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f8ec: 1e602008    	fcmp	d0, #0.0
10511f8f0: 540008a1    	b.ne	0x10511fa04 <_Flutter_MMFoundation_BindContext+0x15fb5e8>
10511f8f4: 900d82a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10511f8f8: f9453500    	ldr	x0, [x8, #0xa68] ; iConsole
10511f8fc: d00d68c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10511f900: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10511f904: b00cb5a8    	adrp	x8, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
10511f908: 9128a108    	add	x8, x8, #0xa28 ; CFString 'error banner height'
10511f90c: f90003e8    	str	x8, [sp]
10511f910: b00b39c5    	adrp	x5, 0x11b858000 <dyld_stub_binder+0x11b858000>
10511f914: 9122e0a5    	add	x5, x5, #0x8b8
10511f918: d00b39c7    	adrp	x7, 0x11b859000 <dyld_stub_binder+0x11b859000>
10511f91c: 9123e0e7    	add	x7, x7, #0x8f8
10511f920: 52800082    	mov	w2, #0x4                ; =4
10511f924: d2800003    	mov	x3, #0x0                ; =0
10511f928: 52800004    	mov	w4, #0x0                ; =0
10511f92c: 52814d66    	mov	w6, #0xa6b              ; =2667
10511f930: 94ac1e03    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f934: 52800720    	mov	w0, #0x39               ; =57
10511f938: 528001e1    	mov	w1, #0xf                ; =15
10511f93c: 52800022    	mov	w2, #0x1                ; =1
10511f940: 52800003    	mov	w3, #0x0                ; =0
10511f944: 52800004    	mov	w4, #0x0                ; =0
10511f948: 9738c20d    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
10511f94c: b00d82a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10511f950: f9403d16    	ldr	x22, [x8, #0x78] ; MMThemeUtil
10511f954: 900d82a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10511f958: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
10511f95c: b00d7f08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10511f960: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10511f964: 94ac1df6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f968: aa1d03fd    	mov	x29, x29
10511f96c: 94ac1df7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f970: aa0003f7    	mov	x23, x0
10511f974: b00d82a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10511f978: f9404100    	ldr	x0, [x8, #0x80] ; MMThemeManager
10511f97c: 900d7f08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10511f980: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10511f984: 94ac1dee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f988: aa0003e2    	mov	x2, x0
10511f98c: d00d68c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10511f990: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10511f994: aa1703e0    	mov	x0, x23
10511f998: 94ac1de9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f99c: aa1d03fd    	mov	x29, x29
10511f9a0: 94ac1dea    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f9a4: aa0003f8    	mov	x24, x0
10511f9a8: 900d68e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10511f9ac: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
10511f9b0: 900c9dc2    	adrp	x2, 0x11e4d7000 <dyld_stub_binder+0x11e4d7000>
10511f9b4: 9120a042    	add	x2, x2, #0x828 ; CFString 'cell_height'
10511f9b8: f00ca803    	adrp	x3, 0x11e622000 <dyld_stub_binder+0x11e622000>
10511f9bc: 91002063    	add	x3, x3, #0x8 ; CFString '#widget_tipsbar_base'
10511f9c0: 94ac1ddf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f9c4: aa1d03fd    	mov	x29, x29
10511f9c8: 94ac1de0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f9cc: aa0003f9    	mov	x25, x0
10511f9d0: b00d68e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10511f9d4: f9400101    	ldr	x1, [x8]
10511f9d8: aa1603e0    	mov	x0, x22
10511f9dc: aa1903e2    	mov	x2, x25
10511f9e0: 94ac1dd7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f9e4: 1e604008    	fmov	d8, d0
10511f9e8: aa1903e0    	mov	x0, x25
10511f9ec: 94ac1dda    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f9f0: aa1803e0    	mov	x0, x24
10511f9f4: 94ac1dd8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f9f8: aa1703e0    	mov	x0, x23
10511f9fc: 94ac1dd6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511fa00: 14000005    	b	0x10511fa14 <_Flutter_MMFoundation_BindContext+0x15fb5f8>
10511fa04: aa1503e0    	mov	x0, x21
10511fa08: aa1603e1    	mov	x1, x22
10511fa0c: 94ac1dcc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511fa10: 1e604008    	fmov	d8, d0
10511fa14: aa1503e0    	mov	x0, x21
10511fa18: 94ac1dcf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511fa1c: 17ffff92    	b	0x10511f864 <_Flutter_MMFoundation_BindContext+0x15fb448>
