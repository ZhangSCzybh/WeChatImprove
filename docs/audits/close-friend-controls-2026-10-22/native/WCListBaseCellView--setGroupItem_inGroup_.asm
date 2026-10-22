
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108fe66bc: d10183ff    	sub	sp, sp, #0x60
108fe66c0: 6d0123e9    	stp	d9, d8, [sp, #0x10]
108fe66c4: a9025ff8    	stp	x24, x23, [sp, #0x20]
108fe66c8: a90357f6    	stp	x22, x21, [sp, #0x30]
108fe66cc: a9044ff4    	stp	x20, x19, [sp, #0x40]
108fe66d0: a9057bfd    	stp	x29, x30, [sp, #0x50]
108fe66d4: 910143fd    	add	x29, sp, #0x50
108fe66d8: aa0303f4    	mov	x20, x3
108fe66dc: aa0203f3    	mov	x19, x2
108fe66e0: aa0003f5    	mov	x21, x0
108fe66e4: f00be328    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
108fe66e8: 52800029    	mov	w9, #0x1                ; =1
108fe66ec: 39388d09    	strb	w9, [x8, #0xe23]
108fe66f0: aa0203e0    	mov	x0, x2
108fe66f4: 95a1d353    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108fe66f8: aa1403e0    	mov	x0, x20
108fe66fc: 95a1d351    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108fe6700: d00b93e8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108fe6704: b9847108    	ldrsw	x8, [x8, #0x470]
108fe6708: f8686aa9    	ldr	x9, [x21, x8]
108fe670c: eb13013f    	cmp	x9, x19
108fe6710: 54000080    	b.eq	0x108fe6720 <_Flutter_MMFoundation_BindContext+0x54c2304>
108fe6714: 8b0802a0    	add	x0, x21, x8
108fe6718: aa1303e1    	mov	x1, x19
108fe671c: 95a1d34b    	bl	0x10f85b448 <_UR_96F1_B25D+0x3a640b8>
108fe6720: d00b93e8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108fe6724: b9847517    	ldrsw	x23, [x8, #0x474]
108fe6728: f8776aa8    	ldr	x8, [x21, x23]
108fe672c: eb14011f    	cmp	x8, x20
108fe6730: 54000080    	b.eq	0x108fe6740 <_Flutter_MMFoundation_BindContext+0x54c2324>
108fe6734: 8b1702a0    	add	x0, x21, x23
108fe6738: aa1403e1    	mov	x1, x20
108fe673c: 95a1d343    	bl	0x10f85b448 <_UR_96F1_B25D+0x3a640b8>
108fe6740: 900b8408    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe6744: f946e901    	ldr	x1, [x8, #0xdd0] ; m_arrPhotoDatas
108fe6748: aa1303e0    	mov	x0, x19
108fe674c: 95a1d33e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe6750: aa1d03fd    	mov	x29, x29
108fe6754: 95a1d33f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe6758: d00b93e8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108fe675c: b9847916    	ldrsw	x22, [x8, #0x478]
108fe6760: f8766aa8    	ldr	x8, [x21, x22]
108fe6764: f8366aa0    	str	x0, [x21, x22]
108fe6768: aa0803e0    	mov	x0, x8
108fe676c: 95a1d33c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe6770: f8766aa0    	ldr	x0, [x21, x22]
108fe6774: f00b88c8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
108fe6778: f9452101    	ldr	x1, [x8, #0xa40] ; firstObject
108fe677c: 95a1d332    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe6780: aa1d03fd    	mov	x29, x29
108fe6784: 95a1d333    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe6788: d00b93e8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108fe678c: b9847d16    	ldrsw	x22, [x8, #0x47c]
108fe6790: f8766aa8    	ldr	x8, [x21, x22]
108fe6794: f8366aa0    	str	x0, [x21, x22]
108fe6798: aa0803e0    	mov	x0, x8
108fe679c: 95a1d330    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe67a0: f8766aa0    	ldr	x0, [x21, x22]
108fe67a4: b00b7448    	adrp	x8, 0x11fe6f000 <dyld_stub_binder+0x11fe6f000>
108fe67a8: f941d901    	ldr	x1, [x8, #0x3b0] ; cpKeyForContent
108fe67ac: 95a1d326    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe67b0: aa1d03fd    	mov	x29, x29
108fe67b4: 95a1d327    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe67b8: aa0003f6    	mov	x22, x0
108fe67bc: 910023e0    	add	x0, sp, #0x8
108fe67c0: aa1603e1    	mov	x1, x22
108fe67c4: 95a13384    	bl	0x10f8335d4 <_UR_96F1_B25D+0x3a3c244>
108fe67c8: aa1603e0    	mov	x0, x22
108fe67cc: 95a1d324    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe67d0: d00b72a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108fe67d4: f941b101    	ldr	x1, [x8, #0x360] ; initView
108fe67d8: aa1503e0    	mov	x0, x21
108fe67dc: 95a1d31a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe67e0: 900b8408    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe67e4: f9472501    	ldr	x1, [x8, #0xe48] ; initDateTimeLabel
108fe67e8: aa1503e0    	mov	x0, x21
108fe67ec: 95a1d316    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe67f0: 900b8408    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe67f4: f9472901    	ldr	x1, [x8, #0xe50] ; initAccessoryView
108fe67f8: aa1503e0    	mov	x0, x21
108fe67fc: 95a1d312    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe6800: d00b93e8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108fe6804: b9845508    	ldrsw	x8, [x8, #0x454]
108fe6808: 38686ab8    	ldrb	w24, [x21, x8]
108fe680c: 7100071f    	cmp	w24, #0x1
108fe6810: 54000201    	b.ne	0x108fe6850 <_Flutter_MMFoundation_BindContext+0x54c2434>
108fe6814: f8776aa0    	ldr	x0, [x21, x23]
108fe6818: d00b88e8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
108fe681c: f9400501    	ldr	x1, [x8, #0x8] ; location
108fe6820: 95a1d309    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe6824: aa1d03fd    	mov	x29, x29
108fe6828: 95a1d30a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe682c: aa0003f6    	mov	x22, x0
108fe6830: b00b88e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
108fe6834: f946e901    	ldr	x1, [x8, #0xdd0] ; length
108fe6838: 95a1d303    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe683c: f100001f    	cmp	x0, #0x0
108fe6840: 9e6703e0    	fmov	d0, xzr
108fe6844: 1e6e1001    	fmov	d1, #1.00000000
108fe6848: 1e601c28    	fcsel	d8, d1, d0, ne
108fe684c: 14000002    	b	0x108fe6854 <_Flutter_MMFoundation_BindContext+0x54c2438>
108fe6850: 9e6703e8    	fmov	d8, xzr
108fe6854: d00b93e8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108fe6858: b9848108    	ldrsw	x8, [x8, #0x480]
108fe685c: f8686aa0    	ldr	x0, [x21, x8]
108fe6860: b00b88e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
108fe6864: f9469501    	ldr	x1, [x8, #0xd28] ; layer
108fe6868: 95a1d2f7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe686c: aa1d03fd    	mov	x29, x29
108fe6870: 95a1d2f8    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe6874: aa0003f7    	mov	x23, x0
108fe6878: d00b7308    	adrp	x8, 0x11fe48000 <dyld_stub_binder+0x11fe48000>
108fe687c: f9409101    	ldr	x1, [x8, #0x120] ; setZPosition:
108fe6880: 1e604100    	fmov	d0, d8
108fe6884: 95a1d2f0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe6888: aa1703e0    	mov	x0, x23
108fe688c: 95a1d2f4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe6890: 34000078    	cbz	w24, 0x108fe689c <_Flutter_MMFoundation_BindContext+0x54c2480>
108fe6894: aa1603e0    	mov	x0, x22
108fe6898: 95a1d2f1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe689c: 900b8408    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe68a0: f9472d01    	ldr	x1, [x8, #0xe58] ; layoutStatusIconImageView
108fe68a4: aa1503e0    	mov	x0, x21
108fe68a8: 95a1d2e7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe68ac: d00b7748    	adrp	x8, 0x11fed0000 <dyld_stub_binder+0x11fed0000>
108fe68b0: f9479901    	ldr	x1, [x8, #0xf30] ; updateAccessibility
108fe68b4: aa1503e0    	mov	x0, x21
108fe68b8: 95a1d2e3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe68bc: 910023e0    	add	x0, sp, #0x8
108fe68c0: 95a13346    	bl	0x10f8335d8 <_UR_96F1_B25D+0x3a3c248>
108fe68c4: aa1403e0    	mov	x0, x20
108fe68c8: 95a1d2e5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe68cc: aa1303e0    	mov	x0, x19
108fe68d0: 95a1d2e3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe68d4: a9457bfd    	ldp	x29, x30, [sp, #0x50]
108fe68d8: a9444ff4    	ldp	x20, x19, [sp, #0x40]
108fe68dc: a94357f6    	ldp	x22, x21, [sp, #0x30]
108fe68e0: a9425ff8    	ldp	x24, x23, [sp, #0x20]
108fe68e4: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
108fe68e8: 910183ff    	add	sp, sp, #0x60
108fe68ec: d65f03c0    	ret
