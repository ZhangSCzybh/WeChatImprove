
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109ca605c: d101c3ff    	sub	sp, sp, #0x70
109ca6060: a9016ffc    	stp	x28, x27, [sp, #0x10]
109ca6064: a90267fa    	stp	x26, x25, [sp, #0x20]
109ca6068: a9035ff8    	stp	x24, x23, [sp, #0x30]
109ca606c: a90457f6    	stp	x22, x21, [sp, #0x40]
109ca6070: a9054ff4    	stp	x20, x19, [sp, #0x50]
109ca6074: a9067bfd    	stp	x29, x30, [sp, #0x60]
109ca6078: 910183fd    	add	x29, sp, #0x60
109ca607c: aa0203f6    	mov	x22, x2
109ca6080: aa0003f4    	mov	x20, x0
109ca6084: d00b7d48    	adrp	x8, 0x120c50000 <dyld_stub_binder+0x120c50000>
109ca6088: 52800029    	mov	w9, #0x1                ; =1
109ca608c: 391ab109    	strb	w9, [x8, #0x6ac]
109ca6090: 900b2828    	adrp	x8, 0x1201aa000 <dyld_stub_binder+0x1201aa000>
109ca6094: f943c113    	ldr	x19, [x8, #0x780] ; 0yE 
109ca6098: b00b1ec8    	adrp	x8, 0x12007f000 <dyld_stub_binder+0x12007f000>
109ca609c: f9464d15    	ldr	x21, [x8, #0xc98] ; cgiCmd
109ca60a0: aa0203e0    	mov	x0, x2
109ca60a4: 956ed4e7    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
109ca60a8: aa1603e0    	mov	x0, x22
109ca60ac: aa1503e1    	mov	x1, x21
109ca60b0: 956ed4e5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ca60b4: aa0003e2    	mov	x2, x0
109ca60b8: 900b1f48    	adrp	x8, 0x12008e000 <dyld_stub_binder+0x12008e000>
109ca60bc: f9426d01    	ldr	x1, [x8, #0x4d8] ; idkeyCmdReport:keyName:
109ca60c0: f00a6ac3    	adrp	x3, 0x11ea01000 <dyld_stub_binder+0x11ea01000>
109ca60c4: 912b2063    	add	x3, x3, #0xac8 ; CFSTR request_total_count
109ca60c8: aa1303e0    	mov	x0, x19
109ca60cc: 956ed4de    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ca60d0: b00b2668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109ca60d4: f9479900    	ldr	x0, [x8, #0xf30] ; ��8 
109ca60d8: 956ed4e2    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
109ca60dc: aa0003f3    	mov	x19, x0
109ca60e0: b00b0ca8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
109ca60e4: f9446501    	ldr	x1, [x8, #0x8c8] ; setM_pbRequest:
109ca60e8: aa1603e2    	mov	x2, x22
109ca60ec: 956ed4d6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ca60f0: aa1603e0    	mov	x0, x22
109ca60f4: aa1503e1    	mov	x1, x21
109ca60f8: 956ed4d3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ca60fc: aa0003f5    	mov	x21, x0
109ca6100: aa1603e0    	mov	x0, x22
109ca6104: 956ed4d6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ca6108: b00b0ca8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
109ca610c: f9446901    	ldr	x1, [x8, #0x8d0] ; setM_uiCgi:
109ca6110: 710022bf    	cmp	w21, #0x8
109ca6114: 5400014c    	b.gt	0x109ca613c <_Flutter_MMFoundation_BindContext+0x6181d20>
109ca6118: 71000ebf    	cmp	w21, #0x3
109ca611c: 5400026c    	b.gt	0x109ca6168 <_Flutter_MMFoundation_BindContext+0x6181d4c>
109ca6120: 710006bf    	cmp	w21, #0x1
109ca6124: 5400042c    	b.gt	0x109ca61a8 <_Flutter_MMFoundation_BindContext+0x6181d8c>
109ca6128: 34000715    	cbz	w21, 0x109ca6208 <_Flutter_MMFoundation_BindContext+0x6181dec>
109ca612c: 710006bf    	cmp	w21, #0x1
109ca6130: 54000681    	b.ne	0x109ca6200 <_Flutter_MMFoundation_BindContext+0x6181de4>
109ca6134: 5280c4f5    	mov	w21, #0x627             ; =1575
109ca6138: 1400003f    	b	0x109ca6234 <_Flutter_MMFoundation_BindContext+0x6181e18>
109ca613c: 52822288    	mov	w8, #0x1114             ; =4372
109ca6140: 6b0802bf    	cmp	w21, w8
109ca6144: 5400022c    	b.gt	0x109ca6188 <_Flutter_MMFoundation_BindContext+0x6181d6c>
109ca6148: 71002abf    	cmp	w21, #0xa
109ca614c: 540003ac    	b.gt	0x109ca61c0 <_Flutter_MMFoundation_BindContext+0x6181da4>
109ca6150: 710026bf    	cmp	w21, #0x9
109ca6154: 540005e0    	b.eq	0x109ca6210 <_Flutter_MMFoundation_BindContext+0x6181df4>
109ca6158: 71002abf    	cmp	w21, #0xa
109ca615c: 54000521    	b.ne	0x109ca6200 <_Flutter_MMFoundation_BindContext+0x6181de4>
109ca6160: 5280cdf5    	mov	w21, #0x66f             ; =1647
109ca6164: 14000034    	b	0x109ca6234 <_Flutter_MMFoundation_BindContext+0x6181e18>
109ca6168: 710016bf    	cmp	w21, #0x5
109ca616c: 5400032c    	b.gt	0x109ca61d0 <_Flutter_MMFoundation_BindContext+0x6181db4>
109ca6170: 710012bf    	cmp	w21, #0x4
109ca6174: 54000520    	b.eq	0x109ca6218 <_Flutter_MMFoundation_BindContext+0x6181dfc>
109ca6178: 710016bf    	cmp	w21, #0x5
109ca617c: 54000421    	b.ne	0x109ca6200 <_Flutter_MMFoundation_BindContext+0x6181de4>
109ca6180: 5280c635    	mov	w21, #0x631             ; =1585
109ca6184: 1400002c    	b	0x109ca6234 <_Flutter_MMFoundation_BindContext+0x6181e18>
109ca6188: 52824d88    	mov	w8, #0x126c             ; =4716
109ca618c: 6b0802bf    	cmp	w21, w8
109ca6190: 540002cc    	b.gt	0x109ca61e8 <_Flutter_MMFoundation_BindContext+0x6181dcc>
109ca6194: 528222a8    	mov	w8, #0x1115             ; =4373
109ca6198: 6b0802bf    	cmp	w21, w8
109ca619c: 540004c0    	b.eq	0x109ca6234 <_Flutter_MMFoundation_BindContext+0x6181e18>
109ca61a0: 52823e68    	mov	w8, #0x11f3             ; =4595
109ca61a4: 14000015    	b	0x109ca61f8 <_Flutter_MMFoundation_BindContext+0x6181ddc>
109ca61a8: 71000abf    	cmp	w21, #0x2
109ca61ac: 540003a0    	b.eq	0x109ca6220 <_Flutter_MMFoundation_BindContext+0x6181e04>
109ca61b0: 71000ebf    	cmp	w21, #0x3
109ca61b4: 54000261    	b.ne	0x109ca6200 <_Flutter_MMFoundation_BindContext+0x6181de4>
109ca61b8: 5280c5b5    	mov	w21, #0x62d             ; =1581
109ca61bc: 1400001e    	b	0x109ca6234 <_Flutter_MMFoundation_BindContext+0x6181e18>
109ca61c0: 71002ebf    	cmp	w21, #0xb
109ca61c4: 54000320    	b.eq	0x109ca6228 <_Flutter_MMFoundation_BindContext+0x6181e0c>
109ca61c8: 52821e68    	mov	w8, #0x10f3             ; =4339
109ca61cc: 1400000b    	b	0x109ca61f8 <_Flutter_MMFoundation_BindContext+0x6181ddc>
109ca61d0: 71001abf    	cmp	w21, #0x6
109ca61d4: 540002e0    	b.eq	0x109ca6230 <_Flutter_MMFoundation_BindContext+0x6181e14>
109ca61d8: 710022bf    	cmp	w21, #0x8
109ca61dc: 54000121    	b.ne	0x109ca6200 <_Flutter_MMFoundation_BindContext+0x6181de4>
109ca61e0: 5280d255    	mov	w21, #0x692             ; =1682
109ca61e4: 14000014    	b	0x109ca6234 <_Flutter_MMFoundation_BindContext+0x6181e18>
109ca61e8: 52824da8    	mov	w8, #0x126d             ; =4717
109ca61ec: 6b0802bf    	cmp	w21, w8
109ca61f0: 54000220    	b.eq	0x109ca6234 <_Flutter_MMFoundation_BindContext+0x6181e18>
109ca61f4: 528261c8    	mov	w8, #0x130e             ; =4878
109ca61f8: 6b0802bf    	cmp	w21, w8
109ca61fc: 540001c0    	b.eq	0x109ca6234 <_Flutter_MMFoundation_BindContext+0x6181e18>
109ca6200: 5280c295    	mov	w21, #0x614             ; =1556
109ca6204: 1400000c    	b	0x109ca6234 <_Flutter_MMFoundation_BindContext+0x6181e18>
109ca6208: 5280c255    	mov	w21, #0x612             ; =1554
109ca620c: 1400000a    	b	0x109ca6234 <_Flutter_MMFoundation_BindContext+0x6181e18>
109ca6210: 5280c995    	mov	w21, #0x64c             ; =1612
109ca6214: 14000008    	b	0x109ca6234 <_Flutter_MMFoundation_BindContext+0x6181e18>
109ca6218: 5280d2b5    	mov	w21, #0x695             ; =1685
109ca621c: 14000006    	b	0x109ca6234 <_Flutter_MMFoundation_BindContext+0x6181e18>
109ca6220: 5280d095    	mov	w21, #0x684             ; =1668
109ca6224: 14000004    	b	0x109ca6234 <_Flutter_MMFoundation_BindContext+0x6181e18>
109ca6228: 52816215    	mov	w21, #0xb10             ; =2832
109ca622c: 14000002    	b	0x109ca6234 <_Flutter_MMFoundation_BindContext+0x6181e18>
109ca6230: 5280bd55    	mov	w21, #0x5ea             ; =1514
109ca6234: aa1303e0    	mov	x0, x19
109ca6238: aa1503e2    	mov	x2, x21
109ca623c: 956ed482    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ca6240: f00b0cc8    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
109ca6244: f946d901    	ldr	x1, [x8, #0xdb0] ; setM_uiRetryCount:
109ca6248: aa1303e0    	mov	x0, x19
109ca624c: 52800042    	mov	w2, #0x2                ; =2
109ca6250: 956ed47d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ca6254: f00b1028    	adrp	x8, 0x11fead000 <dyld_stub_binder+0x11fead000>
109ca6258: f9446101    	ldr	x1, [x8, #0x8c0] ; setM_newdnsBusinessType:
109ca625c: aa1303e0    	mov	x0, x19
109ca6260: 52800042    	mov	w2, #0x2                ; =2
109ca6264: 956ed478    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ca6268: b00b267b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
109ca626c: f945eb60    	ldr	x0, [x27, #0xbd0] ; ��d 
109ca6270: d00b22c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
109ca6274: f944e916    	ldr	x22, [x8, #0x9d0] ; currentContext
109ca6278: aa1603e1    	mov	x1, x22
109ca627c: 956ed472    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ca6280: aa1d03fd    	mov	x29, x29
109ca6284: 956ed473    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ca6288: aa0003f7    	mov	x23, x0
109ca628c: b00b2668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109ca6290: f9479d00    	ldr	x0, [x8, #0xf38] ;  �- 
109ca6294: b00b22c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
109ca6298: f947ad18    	ldr	x24, [x8, #0xf58] ; class
109ca629c: aa1803e1    	mov	x1, x24
109ca62a0: 956ed469    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ca62a4: aa0003e2    	mov	x2, x0
109ca62a8: f00b0c88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109ca62ac: f9464119    	ldr	x25, [x8, #0xc80] ; getService:
109ca62b0: aa1703e0    	mov	x0, x23
109ca62b4: aa1903e1    	mov	x1, x25
109ca62b8: 956ed463    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ca62bc: aa1d03fd    	mov	x29, x29
109ca62c0: 956ed464    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ca62c4: aa0003fa    	mov	x26, x0
109ca62c8: b00b0ca8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
109ca62cc: f9446d01    	ldr	x1, [x8, #0x8d8] ; CreateProtobufEvent:Flag:
109ca62d0: aa1303e2    	mov	x2, x19
109ca62d4: 528000a3    	mov	w3, #0x5                ; =5
109ca62d8: 956ed45b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ca62dc: aa0003f5    	mov	x21, x0
109ca62e0: aa1a03e0    	mov	x0, x26
109ca62e4: 956ed45e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ca62e8: aa1703e0    	mov	x0, x23
109ca62ec: 956ed45c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ca62f0: f945eb60    	ldr	x0, [x27, #0xbd0] ; ��d 
109ca62f4: aa1603e1    	mov	x1, x22
109ca62f8: 956ed453    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ca62fc: aa1d03fd    	mov	x29, x29
109ca6300: 956ed454    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ca6304: aa0003f6    	mov	x22, x0
109ca6308: b00b26e8    	adrp	x8, 0x120183000 <dyld_stub_binder+0x120183000>
109ca630c: f9456100    	ldr	x0, [x8, #0xac0]
109ca6310: aa1803e1    	mov	x1, x24
109ca6314: 956ed44c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ca6318: aa0003e2    	mov	x2, x0
109ca631c: aa1603e0    	mov	x0, x22
109ca6320: aa1903e1    	mov	x1, x25
109ca6324: 956ed448    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ca6328: aa1d03fd    	mov	x29, x29
109ca632c: 956ed449    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ca6330: aa0003f7    	mov	x23, x0
109ca6334: b00b1168    	adrp	x8, 0x11fed3000 <dyld_stub_binder+0x11fed3000>
109ca6338: f9456d01    	ldr	x1, [x8, #0xad8] ; reportStartCgiWrap:
109ca633c: aa1303e2    	mov	x2, x19
109ca6340: 956ed441    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ca6344: aa1703e0    	mov	x0, x23
109ca6348: 956ed445    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ca634c: aa1603e0    	mov	x0, x22
109ca6350: 956ed443    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ca6354: 34000515    	cbz	w21, 0x109ca63f4 <_Flutter_MMFoundation_BindContext+0x6181fd8>
109ca6358: b00b2668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109ca635c: f9464900    	ldr	x0, [x8, #0xc90] ; ��b 
109ca6360: b00b0ca8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
109ca6364: f9447101    	ldr	x1, [x8, #0x8e0] ; addPBEventObserverListItem:andValue:
109ca6368: aa1503e2    	mov	x2, x21
109ca636c: aa1403e3    	mov	x3, x20
109ca6370: 956ed435    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ca6374: d00b2e48    	adrp	x8, 0x120270000 <dyld_stub_binder+0x120270000>
109ca6378: b98a1d08    	ldrsw	x8, [x8, #0xa1c]
109ca637c: f8686a94    	ldr	x20, [x20, x8]
109ca6380: b00b2668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109ca6384: f9457100    	ldr	x0, [x8, #0xae0]
109ca6388: d00b22c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
109ca638c: f9460d01    	ldr	x1, [x8, #0xc18] ; date
109ca6390: 956ed42d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ca6394: aa1d03fd    	mov	x29, x29
109ca6398: 956ed42e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ca639c: aa0003f6    	mov	x22, x0
109ca63a0: b00b2668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109ca63a4: f9454500    	ldr	x0, [x8, #0xa88]
109ca63a8: 900b2328    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
109ca63ac: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
109ca63b0: f90003f5    	str	x21, [sp]
109ca63b4: f00a3fc2    	adrp	x2, 0x11e4a1000 <dyld_stub_binder+0x11e4a1000>
109ca63b8: 912a2042    	add	x2, x2, #0xa88 ; CFSTR %u
109ca63bc: 956ed422    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ca63c0: aa1d03fd    	mov	x29, x29
109ca63c4: 956ed423    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ca63c8: aa0003f5    	mov	x21, x0
109ca63cc: f00b0c88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109ca63d0: f942c901    	ldr	x1, [x8, #0x590] ; safeSetObject:forKey:
109ca63d4: aa1403e0    	mov	x0, x20
109ca63d8: aa1603e2    	mov	x2, x22
109ca63dc: aa1503e3    	mov	x3, x21
109ca63e0: 956ed419    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ca63e4: aa1503e0    	mov	x0, x21
109ca63e8: 956ed41d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ca63ec: aa1603e0    	mov	x0, x22
109ca63f0: 956ed41b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ca63f4: aa1303e0    	mov	x0, x19
109ca63f8: a9467bfd    	ldp	x29, x30, [sp, #0x60]
109ca63fc: a9454ff4    	ldp	x20, x19, [sp, #0x50]
109ca6400: a94457f6    	ldp	x22, x21, [sp, #0x40]
109ca6404: a9435ff8    	ldp	x24, x23, [sp, #0x30]
109ca6408: a94267fa    	ldp	x26, x25, [sp, #0x20]
109ca640c: a9416ffc    	ldp	x28, x27, [sp, #0x10]
109ca6410: 9101c3ff    	add	sp, sp, #0x70
109ca6414: 156ed412    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>