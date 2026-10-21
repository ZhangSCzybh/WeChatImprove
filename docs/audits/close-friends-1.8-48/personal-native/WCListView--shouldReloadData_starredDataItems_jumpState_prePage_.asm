
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108ffd6e4: 6dba23e9    	stp	d9, d8, [sp, #-0x60]!
108ffd6e8: a90167fa    	stp	x26, x25, [sp, #0x10]
108ffd6ec: a9025ff8    	stp	x24, x23, [sp, #0x20]
108ffd6f0: a90357f6    	stp	x22, x21, [sp, #0x30]
108ffd6f4: a9044ff4    	stp	x20, x19, [sp, #0x40]
108ffd6f8: a9057bfd    	stp	x29, x30, [sp, #0x50]
108ffd6fc: 910143fd    	add	x29, sp, #0x50
108ffd700: aa0503f8    	mov	x24, x5
108ffd704: aa0403f9    	mov	x25, x4
108ffd708: aa0303f4    	mov	x20, x3
108ffd70c: aa0203f3    	mov	x19, x2
108ffd710: aa0003f5    	mov	x21, x0
108ffd714: 900be288    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
108ffd718: 52800029    	mov	w9, #0x1                ; =1
108ffd71c: 393a2109    	strb	w9, [x8, #0xe88]
108ffd720: aa0203e0    	mov	x0, x2
108ffd724: 95a17747    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108ffd728: aa1403e0    	mov	x0, x20
108ffd72c: 95a17745    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108ffd730: b00b8048    	adrp	x8, 0x120006000 <dyld_stub_binder+0x120006000>
108ffd734: f9412501    	ldr	x1, [x8, #0x248] ; isJumpState
108ffd738: aa1503e0    	mov	x0, x21
108ffd73c: 95a17742    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd740: d00b8348    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ffd744: f940f116    	ldr	x22, [x8, #0x1e0] ; setJumpStateChanging:
108ffd748: 4a190002    	eor	w2, w0, w25
108ffd74c: aa1503e0    	mov	x0, x21
108ffd750: aa1603e1    	mov	x1, x22
108ffd754: 95a1773c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd758: f00b9328    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108ffd75c: b9857d1a    	ldrsw	x26, [x8, #0x57c]
108ffd760: f87a6aa0    	ldr	x0, [x21, x26]
108ffd764: b00b7228    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
108ffd768: f9442917    	ldr	x23, [x8, #0x850] ; contentSize
108ffd76c: aa1703e1    	mov	x1, x23
108ffd770: 95a17735    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd774: 1e604028    	fmov	d8, d1
108ffd778: f87a6aa0    	ldr	x0, [x21, x26]
108ffd77c: f00b8808    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
108ffd780: f9425d01    	ldr	x1, [x8, #0x4b8] ; contentOffset
108ffd784: 95a17730    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd788: 1e604029    	fmov	d9, d1
108ffd78c: d00b8348    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ffd790: f940f501    	ldr	x1, [x8, #0x1e8] ; updateJumpState:
108ffd794: aa1503e0    	mov	x0, x21
108ffd798: aa1903e2    	mov	x2, x25
108ffd79c: 95a1772a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd7a0: f00b9328    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108ffd7a4: b985a119    	ldrsw	x25, [x8, #0x5a0]
108ffd7a8: 8b1902a0    	add	x0, x21, x25
108ffd7ac: aa1303e1    	mov	x1, x19
108ffd7b0: 95a17726    	bl	0x10f85b448 <_UR_96F1_B25D+0x3a640b8>
108ffd7b4: f00b9328    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108ffd7b8: b985a508    	ldrsw	x8, [x8, #0x5a4]
108ffd7bc: 8b0802a0    	add	x0, x21, x8
108ffd7c0: aa1403e1    	mov	x1, x20
108ffd7c4: 95a17721    	bl	0x10f85b448 <_UR_96F1_B25D+0x3a640b8>
108ffd7c8: f8796aa0    	ldr	x0, [x21, x25]
108ffd7cc: f00b8808    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
108ffd7d0: f9435101    	ldr	x1, [x8, #0x6a0] ; count
108ffd7d4: 95a1771c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd7d8: f100001f    	cmp	x0, #0x0
108ffd7dc: 1a9f17e2    	cset	w2, eq
108ffd7e0: d00b8348    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ffd7e4: f940f901    	ldr	x1, [x8, #0x1f0] ; showNoContentTips:
108ffd7e8: aa1503e0    	mov	x0, x21
108ffd7ec: 95a17716    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd7f0: d00b8348    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ffd7f4: f940d101    	ldr	x1, [x8, #0x1a0] ; updateRowsData
108ffd7f8: aa1503e0    	mov	x0, x21
108ffd7fc: 95a17712    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd800: 340004b8    	cbz	w24, 0x108ffd894 <_Flutter_MMFoundation_BindContext+0x54d9478>
108ffd804: 1e693908    	fsub	d8, d8, d9
108ffd808: d00b8348    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ffd80c: f940e501    	ldr	x1, [x8, #0x1c8] ; listHeaderViewInJumpState
108ffd810: aa1503e0    	mov	x0, x21
108ffd814: 95a1770c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd818: aa1d03fd    	mov	x29, x29
108ffd81c: 95a1770d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108ffd820: aa0003f8    	mov	x24, x0
108ffd824: f00b72e8    	adrp	x8, 0x11fe5c000 <dyld_stub_binder+0x11fe5c000>
108ffd828: f9472d01    	ldr	x1, [x8, #0xe58] ; resetStatus:
108ffd82c: d2800002    	mov	x2, #0x0                ; =0
108ffd830: 95a17705    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd834: aa1803e0    	mov	x0, x24
108ffd838: 95a17709    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ffd83c: f87a6aa0    	ldr	x0, [x21, x26]
108ffd840: b00b8848    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
108ffd844: f9404501    	ldr	x1, [x8, #0x88] ; reloadData
108ffd848: 95a176ff    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd84c: f87a6aa0    	ldr	x0, [x21, x26]
108ffd850: d00b8828    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
108ffd854: f946b901    	ldr	x1, [x8, #0xd70] ; layoutIfNeeded
108ffd858: 95a176fb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd85c: f87a6ab8    	ldr	x24, [x21, x26]
108ffd860: aa1803e0    	mov	x0, x24
108ffd864: aa1703e1    	mov	x1, x23
108ffd868: 95a176f7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd86c: 1e683821    	fsub	d1, d1, d8
108ffd870: d00b71e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
108ffd874: f945b501    	ldr	x1, [x8, #0xb68] ; setContentOffset:animated:
108ffd878: 9e6703e0    	fmov	d0, xzr
108ffd87c: aa1803e0    	mov	x0, x24
108ffd880: 52800002    	mov	w2, #0x0                ; =0
108ffd884: 95a176f0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd888: d00b8357    	adrp	x23, 0x120067000 <dyld_stub_binder+0x120067000>
108ffd88c: 910822f7    	add	x23, x23, #0x208
108ffd890: 14000007    	b	0x108ffd8ac <_Flutter_MMFoundation_BindContext+0x54d9490>
108ffd894: f87a6aa0    	ldr	x0, [x21, x26]
108ffd898: b00b8848    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
108ffd89c: f9404501    	ldr	x1, [x8, #0x88] ; reloadData
108ffd8a0: 95a176e9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd8a4: d00b8357    	adrp	x23, 0x120067000 <dyld_stub_binder+0x120067000>
108ffd8a8: 910842f7    	add	x23, x23, #0x210
108ffd8ac: aa1503e0    	mov	x0, x21
108ffd8b0: aa1603e1    	mov	x1, x22
108ffd8b4: 52800002    	mov	w2, #0x0                ; =0
108ffd8b8: 95a176e3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd8bc: d00b8348    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ffd8c0: f940fd01    	ldr	x1, [x8, #0x1f8] ; updateYearFlowView
108ffd8c4: aa1503e0    	mov	x0, x21
108ffd8c8: 95a176df    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd8cc: d00b8348    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ffd8d0: f9410101    	ldr	x1, [x8, #0x200] ; multipleImageViewController
108ffd8d4: aa1503e0    	mov	x0, x21
108ffd8d8: 95a176db    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd8dc: aa1d03fd    	mov	x29, x29
108ffd8e0: 95a176dc    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108ffd8e4: aa0003f6    	mov	x22, x0
108ffd8e8: f00b9328    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108ffd8ec: b985c908    	ldrsw	x8, [x8, #0x5c8]
108ffd8f0: f8686aa2    	ldr	x2, [x21, x8]
108ffd8f4: f94002e1    	ldr	x1, [x23]
108ffd8f8: 95a176d3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd8fc: aa1603e0    	mov	x0, x22
108ffd900: 95a176d7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ffd904: aa1403e0    	mov	x0, x20
108ffd908: 95a176d5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ffd90c: aa1303e0    	mov	x0, x19
108ffd910: a9457bfd    	ldp	x29, x30, [sp, #0x50]
108ffd914: a9444ff4    	ldp	x20, x19, [sp, #0x40]
108ffd918: a94357f6    	ldp	x22, x21, [sp, #0x30]
108ffd91c: a9425ff8    	ldp	x24, x23, [sp, #0x20]
108ffd920: a94167fa    	ldp	x26, x25, [sp, #0x10]
108ffd924: 6cc623e9    	ldp	d9, d8, [sp], #0x60
108ffd928: 15a176cd    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
