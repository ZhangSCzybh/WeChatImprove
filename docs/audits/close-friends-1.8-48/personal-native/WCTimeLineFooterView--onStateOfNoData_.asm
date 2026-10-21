
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a0ab21c: d101c3ff    	sub	sp, sp, #0x70
10a0ab220: 6d0123e9    	stp	d9, d8, [sp, #0x10]
10a0ab224: a90267fa    	stp	x26, x25, [sp, #0x20]
10a0ab228: a9035ff8    	stp	x24, x23, [sp, #0x30]
10a0ab22c: a90457f6    	stp	x22, x21, [sp, #0x40]
10a0ab230: a9054ff4    	stp	x20, x19, [sp, #0x50]
10a0ab234: a9067bfd    	stp	x29, x30, [sp, #0x60]
10a0ab238: 910183fd    	add	x29, sp, #0x60
10a0ab23c: aa0203f3    	mov	x19, x2
10a0ab240: aa0003f4    	mov	x20, x0
10a0ab244: d00b5d28    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a0ab248: 52800029    	mov	w9, #0x1                ; =1
10a0ab24c: 39111109    	strb	w9, [x8, #0x444]
10a0ab250: aa0203e0    	mov	x0, x2
10a0ab254: 955ec07b    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a0ab258: b00b0948    	adrp	x8, 0x1201d4000 <dyld_stub_binder+0x1201d4000>
10a0ab25c: f9405508    	ldr	x8, [x8, #0xa8]
10a0ab260: a90023f4    	stp	x20, x8, [sp]
10a0ab264: 900aeec8    	adrp	x8, 0x11fe83000 <dyld_stub_binder+0x11fe83000>
10a0ab268: f9406d01    	ldr	x1, [x8, #0xd8] ; onStateOfNoData:
10a0ab26c: 910003e0    	mov	x0, sp
10a0ab270: aa1303e2    	mov	x2, x19
10a0ab274: 955ec076    	bl	0x10f85b44c <_UR_96F1_B25D+0x3a640bc>
10a0ab278: f00aefe8    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
10a0ab27c: f942d101    	ldr	x1, [x8, #0x5a0] ; removeSubViewWithTag:
10a0ab280: aa1403e0    	mov	x0, x20
10a0ab284: 5280d202    	mov	w2, #0x690              ; =1680
10a0ab288: 955ec06f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab28c: b00b0e48    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0ab290: b981a515    	ldrsw	x21, [x8, #0x1a4]
10a0ab294: f8756a80    	ldr	x0, [x20, x21]
10a0ab298: b4000240    	cbz	x0, 0x10a0ab2e0 <_Flutter_MMFoundation_BindContext+0x6586ec4>
10a0ab29c: f00b0628    	adrp	x8, 0x120172000 <dyld_stub_binder+0x120172000>
10a0ab2a0: f945d102    	ldr	x2, [x8, #0xba0]
10a0ab2a4: b00b02a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a0ab2a8: f9415d01    	ldr	x1, [x8, #0x2b8] ; conformsToProtocol:
10a0ab2ac: 955ec066    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab2b0: 340000c0    	cbz	w0, 0x10a0ab2c8 <_Flutter_MMFoundation_BindContext+0x6586eac>
10a0ab2b4: f8756a80    	ldr	x0, [x20, x21]
10a0ab2b8: 900aef48    	adrp	x8, 0x11fe93000 <dyld_stub_binder+0x11fe93000>
10a0ab2bc: f9452501    	ldr	x1, [x8, #0xa48] ; setTips:
10a0ab2c0: aa1303e2    	mov	x2, x19
10a0ab2c4: 955ec060    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab2c8: f8756a82    	ldr	x2, [x20, x21]
10a0ab2cc: f00b0288    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10a0ab2d0: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
10a0ab2d4: aa1403e0    	mov	x0, x20
10a0ab2d8: 955ec05b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab2dc: 1400007c    	b	0x10a0ab4cc <_Flutter_MMFoundation_BindContext+0x65870b0>
10a0ab2e0: b00b0e48    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0ab2e4: b9817d19    	ldrsw	x25, [x8, #0x17c]
10a0ab2e8: f8796a82    	ldr	x2, [x20, x25]
10a0ab2ec: f00b0288    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10a0ab2f0: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
10a0ab2f4: aa1403e0    	mov	x0, x20
10a0ab2f8: 955ec053    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab2fc: b00b0e48    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0ab300: b9818d08    	ldrsw	x8, [x8, #0x18c]
10a0ab304: f8686a82    	ldr	x2, [x20, x8]
10a0ab308: b40000a2    	cbz	x2, 0x10a0ab31c <_Flutter_MMFoundation_BindContext+0x6586f00>
10a0ab30c: f8796a80    	ldr	x0, [x20, x25]
10a0ab310: b00b02e8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10a0ab314: f9400501    	ldr	x1, [x8, #0x8] ; setFont:
10a0ab318: 955ec04b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab31c: f8796a80    	ldr	x0, [x20, x25]
10a0ab320: d00b02e8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
10a0ab324: f9469101    	ldr	x1, [x8, #0xd20] ; setTextAlignment:
10a0ab328: 52800022    	mov	w2, #0x1                ; =1
10a0ab32c: 955ec046    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab330: 900b0648    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0ab334: f9463100    	ldr	x0, [x8, #0xc60]
10a0ab338: b00b02a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a0ab33c: f9408501    	ldr	x1, [x8, #0x108] ; colorWithRed:green:blue:alpha:
10a0ab340: d0076768    	adrp	x8, 0x118d99000 <dyld_stub_binder+0x118d99000>
10a0ab344: fd47ed00    	ldr	d0, [x8, #0xfd8]
10a0ab348: 1e6e1003    	fmov	d3, #1.00000000
10a0ab34c: 1e604001    	fmov	d1, d0
10a0ab350: 1e604002    	fmov	d2, d0
10a0ab354: 955ec03c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab358: aa1d03fd    	mov	x29, x29
10a0ab35c: 955ec03d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0ab360: aa0003f5    	mov	x21, x0
10a0ab364: f8796a80    	ldr	x0, [x20, x25]
10a0ab368: d00b02e8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
10a0ab36c: f9469501    	ldr	x1, [x8, #0xd28] ; setTextColor:
10a0ab370: aa1503e2    	mov	x2, x21
10a0ab374: 955ec034    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab378: aa1503e0    	mov	x0, x21
10a0ab37c: 955ec038    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0ab380: f8796a80    	ldr	x0, [x20, x25]
10a0ab384: d00b02e8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
10a0ab388: f9468d01    	ldr	x1, [x8, #0xd18] ; setText:
10a0ab38c: aa1303e2    	mov	x2, x19
10a0ab390: 955ec02d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab394: b00b0648    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a0ab398: f9404916    	ldr	x22, [x8, #0x90]
10a0ab39c: f8796a80    	ldr	x0, [x20, x25]
10a0ab3a0: 900b0308    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10a0ab3a4: f9401501    	ldr	x1, [x8, #0x28] ; text
10a0ab3a8: 955ec027    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab3ac: aa1d03fd    	mov	x29, x29
10a0ab3b0: 955ec028    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0ab3b4: aa0003f7    	mov	x23, x0
10a0ab3b8: 900b0308    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10a0ab3bc: f947a515    	ldr	x21, [x8, #0xf48] ; width
10a0ab3c0: aa1403e0    	mov	x0, x20
10a0ab3c4: aa1503e1    	mov	x1, x21
10a0ab3c8: 955ec01f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab3cc: 1e604008    	fmov	d8, d0
10a0ab3d0: f8796a80    	ldr	x0, [x20, x25]
10a0ab3d4: d00b02a8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
10a0ab3d8: f9456d01    	ldr	x1, [x8, #0xad8] ; font
10a0ab3dc: 955ec01a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab3e0: aa1d03fd    	mov	x29, x29
10a0ab3e4: 955ec01b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0ab3e8: aa0003f8    	mov	x24, x0
10a0ab3ec: b00aec88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a0ab3f0: f9404901    	ldr	x1, [x8, #0x90] ; labelHeight:maxWidth:font:
10a0ab3f4: aa1603e0    	mov	x0, x22
10a0ab3f8: aa1703e2    	mov	x2, x23
10a0ab3fc: 1e604100    	fmov	d0, d8
10a0ab400: aa1803e3    	mov	x3, x24
10a0ab404: 955ec010    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab408: 1e604008    	fmov	d8, d0
10a0ab40c: aa1803e0    	mov	x0, x24
10a0ab410: 955ec013    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0ab414: aa1703e0    	mov	x0, x23
10a0ab418: 955ec011    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0ab41c: f8796a80    	ldr	x0, [x20, x25]
10a0ab420: b00b02e8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10a0ab424: f947f901    	ldr	x1, [x8, #0xff0] ; setNumberOfLines:
10a0ab428: d2800002    	mov	x2, #0x0                ; =0
10a0ab42c: 955ec006    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab430: b00b0e48    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0ab434: b9819108    	ldrsw	x8, [x8, #0x190]
10a0ab438: 38686a88    	ldrb	w8, [x20, x8]
10a0ab43c: 1e65d009    	fmov	d9, #15.00000000
10a0ab440: 7100051f    	cmp	w8, #0x1
10a0ab444: 54000141    	b.ne	0x10a0ab46c <_Flutter_MMFoundation_BindContext+0x6587050>
10a0ab448: f00b02a8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10a0ab44c: f9449d01    	ldr	x1, [x8, #0x938] ; height
10a0ab450: aa1403e0    	mov	x0, x20
10a0ab454: 955ebffc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab458: 1e683800    	fsub	d0, d0, d8
10a0ab45c: 1e6c1001    	fmov	d1, #0.50000000
10a0ab460: 1e610800    	fmul	d0, d0, d1
10a0ab464: 9e6703e1    	fmov	d1, xzr
10a0ab468: 1e616809    	fmaxnm	d9, d0, d1
10a0ab46c: aa1403e0    	mov	x0, x20
10a0ab470: aa1503e1    	mov	x1, x21
10a0ab474: 955ebff4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab478: 1e604002    	fmov	d2, d0
10a0ab47c: f8796a80    	ldr	x0, [x20, x25]
10a0ab480: b00b02e8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10a0ab484: f9403501    	ldr	x1, [x8, #0x68] ; setFrame:
10a0ab488: 9e6703e0    	fmov	d0, xzr
10a0ab48c: 1e604121    	fmov	d1, d9
10a0ab490: 1e604103    	fmov	d3, d8
10a0ab494: 955ebfec    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab498: 900b02c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a0ab49c: f946e901    	ldr	x1, [x8, #0xdd0] ; length
10a0ab4a0: aa1303e0    	mov	x0, x19
10a0ab4a4: 955ebfe8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab4a8: aa0003e8    	mov	x8, x0
10a0ab4ac: f8796a80    	ldr	x0, [x20, x25]
10a0ab4b0: b00b02e9    	adrp	x9, 0x120108000 <dyld_stub_binder+0x120108000>
10a0ab4b4: f9411121    	ldr	x1, [x9, #0x220] ; setHidden:
10a0ab4b8: b4000068    	cbz	x8, 0x10a0ab4c4 <_Flutter_MMFoundation_BindContext+0x65870a8>
10a0ab4bc: 52800002    	mov	w2, #0x0                ; =0
10a0ab4c0: 14000002    	b	0x10a0ab4c8 <_Flutter_MMFoundation_BindContext+0x65870ac>
10a0ab4c4: 52800022    	mov	w2, #0x1                ; =1
10a0ab4c8: 955ebfdf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab4cc: b00b0e48    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0ab4d0: b9817908    	ldrsw	x8, [x8, #0x178]
10a0ab4d4: f8686a80    	ldr	x0, [x20, x8]
10a0ab4d8: f00aeca8    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
10a0ab4dc: f947fd01    	ldr	x1, [x8, #0xff8] ; stopAnimating
10a0ab4e0: 955ebfd9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab4e4: b00b0e48    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0ab4e8: b9819908    	ldrsw	x8, [x8, #0x198]
10a0ab4ec: 38686a88    	ldrb	w8, [x20, x8]
10a0ab4f0: 370000c8    	tbnz	w8, #0x0, 0x10a0ab508 <_Flutter_MMFoundation_BindContext+0x65870ec>
10a0ab4f4: 900b02e8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10a0ab4f8: f946bd01    	ldr	x1, [x8, #0xd78] ; setEnabled:
10a0ab4fc: aa1403e0    	mov	x0, x20
10a0ab500: 52800002    	mov	w2, #0x0                ; =0
10a0ab504: 955ebfd0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab508: aa1303e0    	mov	x0, x19
10a0ab50c: 955ebfd4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0ab510: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10a0ab514: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10a0ab518: a94457f6    	ldp	x22, x21, [sp, #0x40]
10a0ab51c: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10a0ab520: a94267fa    	ldp	x26, x25, [sp, #0x20]
10a0ab524: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
10a0ab528: 9101c3ff    	add	sp, sp, #0x70
10a0ab52c: d65f03c0    	ret
