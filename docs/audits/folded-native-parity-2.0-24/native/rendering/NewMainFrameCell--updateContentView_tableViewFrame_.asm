
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1050fe42c: 6dbb23e9    	stp	d9, d8, [sp, #-0x50]!
1050fe430: a9015ff8    	stp	x24, x23, [sp, #0x10]
1050fe434: a90257f6    	stp	x22, x21, [sp, #0x20]
1050fe438: a9034ff4    	stp	x20, x19, [sp, #0x30]
1050fe43c: a9047bfd    	stp	x29, x30, [sp, #0x40]
1050fe440: 910103fd    	add	x29, sp, #0x40
1050fe444: 1e604048    	fmov	d8, d2
1050fe448: aa0203f3    	mov	x19, x2
1050fe44c: aa0003f4    	mov	x20, x0
1050fe450: b00dda08    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
1050fe454: 52800029    	mov	w9, #0x1                ; =1
1050fe458: 392c2509    	strb	w9, [x8, #0xb09]
1050fe45c: aa0203e0    	mov	x0, x2
1050fe460: 94aca336    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1050fe464: d00d8948    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1050fe468: b982d108    	ldrsw	x8, [x8, #0x2d0]
1050fe46c: f8686a82    	ldr	x2, [x20, x8]
1050fe470: 900d74e8    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
1050fe474: f9428101    	ldr	x1, [x8, #0x500] ; setM_oldCellData:
1050fe478: aa1403e0    	mov	x0, x20
1050fe47c: 94aca330    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fe480: d00d7428    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
1050fe484: f944b101    	ldr	x1, [x8, #0x960] ; setM_cellData:
1050fe488: aa1403e0    	mov	x0, x20
1050fe48c: aa1303e2    	mov	x2, x19
1050fe490: 94aca32b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fe494: 900d74e8    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
1050fe498: f9428501    	ldr	x1, [x8, #0x508] ; updateMoreMenu:
1050fe49c: aa1403e0    	mov	x0, x20
1050fe4a0: aa1303e2    	mov	x2, x19
1050fe4a4: 94aca326    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fe4a8: d00d6c08    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
1050fe4ac: f943e101    	ldr	x1, [x8, #0x7c0] ; m_cellData
1050fe4b0: aa1403e0    	mov	x0, x20
1050fe4b4: 94aca322    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fe4b8: aa1d03fd    	mov	x29, x29
1050fe4bc: 94aca323    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1050fe4c0: aa0003f6    	mov	x22, x0
1050fe4c4: 900d6a48    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
1050fe4c8: f9438d15    	ldr	x21, [x8, #0x718] ; m_sessionInfo
1050fe4cc: aa1503e1    	mov	x1, x21
1050fe4d0: 94aca31b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fe4d4: aa1d03fd    	mov	x29, x29
1050fe4d8: 94aca31c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1050fe4dc: aa0003f7    	mov	x23, x0
1050fe4e0: b00d69e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1050fe4e4: f947d901    	ldr	x1, [x8, #0xfb0] ; m_contact
1050fe4e8: 94aca315    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fe4ec: aa1d03fd    	mov	x29, x29
1050fe4f0: 94aca316    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1050fe4f4: aa0003f8    	mov	x24, x0
1050fe4f8: d00d88e8    	adrp	x8, 0x12021c000 <dyld_stub_binder+0x12021c000>
1050fe4fc: 91395108    	add	x8, x8, #0xe54
1050fe500: b9800108    	ldrsw	x8, [x8]
1050fe504: f8686a80    	ldr	x0, [x20, x8]
1050fe508: b00d69e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1050fe50c: f946dd01    	ldr	x1, [x8, #0xdb8] ; setM_contact:
1050fe510: aa1803e2    	mov	x2, x24
1050fe514: 94aca30a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fe518: aa1803e0    	mov	x0, x24
1050fe51c: 94aca30e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1050fe520: aa1703e0    	mov	x0, x23
1050fe524: 94aca30c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1050fe528: aa1603e0    	mov	x0, x22
1050fe52c: 94aca30a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1050fe530: d00d8948    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1050fe534: b982c916    	ldrsw	x22, [x8, #0x2c8]
1050fe538: f8766a80    	ldr	x0, [x20, x22]
1050fe53c: b4000200    	cbz	x0, 0x1050fe57c <_Flutter_MMFoundation_BindContext+0x15da160>
1050fe540: b00d6e28    	adrp	x8, 0x11fec3000 <dyld_stub_binder+0x11fec3000>
1050fe544: f9430101    	ldr	x1, [x8, #0x600] ; updateWithCellData:
1050fe548: aa1303e2    	mov	x2, x19
1050fe54c: 94aca2fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fe550: aa1303e0    	mov	x0, x19
1050fe554: aa1503e1    	mov	x1, x21
1050fe558: 94aca2f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fe55c: aa1d03fd    	mov	x29, x29
1050fe560: 94aca2fa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1050fe564: aa0003f5    	mov	x21, x0
1050fe568: d00d7428    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
1050fe56c: f9403901    	ldr	x1, [x8, #0x70] ; updateCellBackground:
1050fe570: aa1403e0    	mov	x0, x20
1050fe574: aa1503e2    	mov	x2, x21
1050fe578: 14000024    	b	0x1050fe608 <_Flutter_MMFoundation_BindContext+0x15da1ec>
1050fe57c: d00d84a8    	adrp	x8, 0x120194000 <dyld_stub_binder+0x120194000>
1050fe580: f942f500    	ldr	x0, [x8, #0x5e8] ; MainFrameItemView
1050fe584: 94aca2f7    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1050fe588: d00d8948    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1050fe58c: b982cd08    	ldrsw	x8, [x8, #0x2cc]
1050fe590: fc686a80    	ldr	d0, [x20, x8]
1050fe594: 1e701001    	fmov	d1, #-2.00000000
1050fe598: 1f412002    	fmadd	d2, d0, d1, d8
1050fe59c: 900d6d88    	adrp	x8, 0x11feae000 <dyld_stub_binder+0x11feae000>
1050fe5a0: f941b101    	ldr	x1, [x8, #0x360] ; initWithCellData:frame:
1050fe5a4: 9e6703e1    	fmov	d1, xzr
1050fe5a8: 9e6703e3    	fmov	d3, xzr
1050fe5ac: aa1303e2    	mov	x2, x19
1050fe5b0: 94aca2e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fe5b4: f8766a88    	ldr	x8, [x20, x22]
1050fe5b8: f8366a80    	str	x0, [x20, x22]
1050fe5bc: aa0803e0    	mov	x0, x8
1050fe5c0: 94aca2e5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1050fe5c4: f8766a80    	ldr	x0, [x20, x22]
1050fe5c8: f00d8048    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1050fe5cc: f9466501    	ldr	x1, [x8, #0xcc8] ; setTag:
1050fe5d0: 52807d22    	mov	w2, #0x3e9              ; =1001
1050fe5d4: 94aca2da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fe5d8: f8766a88    	ldr	x8, [x20, x22]
1050fe5dc: b40001c8    	cbz	x8, 0x1050fe614 <_Flutter_MMFoundation_BindContext+0x15da1f8>
1050fe5e0: d00d8008    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1050fe5e4: f9427501    	ldr	x1, [x8, #0x4e8] ; contentView
1050fe5e8: aa1403e0    	mov	x0, x20
1050fe5ec: 94aca2d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fe5f0: aa1d03fd    	mov	x29, x29
1050fe5f4: 94aca2d5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1050fe5f8: aa0003f5    	mov	x21, x0
1050fe5fc: f8766a82    	ldr	x2, [x20, x22]
1050fe600: 900d8008    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1050fe604: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
1050fe608: 94aca2cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fe60c: aa1503e0    	mov	x0, x21
1050fe610: 94aca2d1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1050fe614: f8766a80    	ldr	x0, [x20, x22]
1050fe618: 900d74e8    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
1050fe61c: f9428901    	ldr	x1, [x8, #0x510] ; setLabelHighlighted:
1050fe620: 52800002    	mov	w2, #0x0                ; =0
1050fe624: 94aca2c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fe628: d00d69e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1050fe62c: f9436501    	ldr	x1, [x8, #0x6c8] ; setSelectionStyle:
1050fe630: aa1403e0    	mov	x0, x20
1050fe634: 52800022    	mov	w2, #0x1                ; =1
1050fe638: 94aca2c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fe63c: aa1303e0    	mov	x0, x19
1050fe640: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1050fe644: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1050fe648: a94257f6    	ldp	x22, x21, [sp, #0x20]
1050fe64c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
1050fe650: 6cc523e9    	ldp	d9, d8, [sp], #0x50
1050fe654: 14aca2c0    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
