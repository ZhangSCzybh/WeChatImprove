
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1094243ec: d10543ff    	sub	sp, sp, #0x150
1094243f0: a90f6ffc    	stp	x28, x27, [sp, #0xf0]
1094243f4: a91067fa    	stp	x26, x25, [sp, #0x100]
1094243f8: a9115ff8    	stp	x24, x23, [sp, #0x110]
1094243fc: a91257f6    	stp	x22, x21, [sp, #0x120]
109424400: a9134ff4    	stp	x20, x19, [sp, #0x130]
109424404: a9147bfd    	stp	x29, x30, [sp, #0x140]
109424408: 910503fd    	add	x29, sp, #0x140
10942440c: aa0003f3    	mov	x19, x0
109424410: f00a0e48    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
109424414: f9405908    	ldr	x8, [x8, #0xb0]
109424418: f9400108    	ldr	x8, [x8]
10942441c: f81a03a8    	stur	x8, [x29, #-0x60]
109424420: d00bc148    	adrp	x8, 0x120c4e000 <dyld_stub_binder+0x120c4e000>
109424424: 52800029    	mov	w9, #0x1                ; =1
109424428: 3936a509    	strb	w9, [x8, #0xda9]
10942442c: 900b6c28    	adrp	x8, 0x1201a8000 <dyld_stub_binder+0x1201a8000>
109424430: f941d500    	ldr	x0, [x8, #0x3a8] ; p�D 
109424434: f00b66c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
109424438: f947ad14    	ldr	x20, [x8, #0xf58] ; class
10942443c: aa1403e1    	mov	x1, x20
109424440: 9590dc01    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109424444: aa0003e2    	mov	x2, x0
109424448: f00b66e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10942444c: f9442d15    	ldr	x21, [x8, #0x858] ; isKindOfClass:
109424450: aa1303e0    	mov	x0, x19
109424454: aa1503e1    	mov	x1, x21
109424458: 9590dbfb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10942445c: 37000140    	tbnz	w0, #0x0, 0x109424484 <_Flutter_MMFoundation_BindContext+0x5900068>
109424460: d00b6ba8    	adrp	x8, 0x12019a000 <dyld_stub_binder+0x12019a000>
109424464: f941e100    	ldr	x0, [x8, #0x3c0] ; �dD 
109424468: aa1403e1    	mov	x1, x20
10942446c: 9590dbf6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109424470: aa0003e2    	mov	x2, x0
109424474: aa1303e0    	mov	x0, x19
109424478: aa1503e1    	mov	x1, x21
10942447c: 9590dbf2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109424480: 34000a40    	cbz	w0, 0x1094245c8 <_Flutter_MMFoundation_BindContext+0x59001ac>
109424484: f9000bf3    	str	x19, [sp, #0x10]
109424488: 4f00e400    	movi.16b	v0, #0x0
10942448c: ad0203e0    	stp	q0, q0, [sp, #0x40]
109424490: ad0103e0    	stp	q0, q0, [sp, #0x20]
109424494: 900b6a88    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
109424498: f9402d00    	ldr	x0, [x8, #0x58] ; �= 
10942449c: 900b5e88    	adrp	x8, 0x11fff4000 <dyld_stub_binder+0x11fff4000>
1094244a0: f944c501    	ldr	x1, [x8, #0x988] ; GetWCBizMainWindow
1094244a4: 9590dbe8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1094244a8: aa1d03fd    	mov	x29, x29
1094244ac: 9590dbe9    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1094244b0: aa0003f7    	mov	x23, x0
1094244b4: d00b6728    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1094244b8: f9474901    	ldr	x1, [x8, #0xe90] ; subviews
1094244bc: 9590dbe2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1094244c0: aa1d03fd    	mov	x29, x29
1094244c4: 9590dbe3    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1094244c8: aa0003f6    	mov	x22, x0
1094244cc: aa1703e0    	mov	x0, x23
1094244d0: 9590dbe3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1094244d4: 900b66e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1094244d8: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1094244dc: 910083e2    	add	x2, sp, #0x20
1094244e0: 910183e3    	add	x3, sp, #0x60
1094244e4: aa1603e0    	mov	x0, x22
1094244e8: f9000fe1    	str	x1, [sp, #0x18]
1094244ec: 52800204    	mov	w4, #0x10               ; =16
1094244f0: 9590dbd5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1094244f4: b4000640    	cbz	x0, 0x1094245bc <_Flutter_MMFoundation_BindContext+0x59001a0>
1094244f8: aa0003f8    	mov	x24, x0
1094244fc: f9401be8    	ldr	x8, [sp, #0x30]
109424500: f940011b    	ldr	x27, [x8]
109424504: 900b6c33    	adrp	x19, 0x1201a8000 <dyld_stub_binder+0x1201a8000>
109424508: 900b6c3c    	adrp	x28, 0x1201a8000 <dyld_stub_binder+0x1201a8000>
10942450c: d2800017    	mov	x23, #0x0               ; =0
109424510: d00b6708    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
109424514: f940f919    	ldr	x25, [x8, #0x1f0] ; removeFromSuperview
109424518: f9401be8    	ldr	x8, [sp, #0x30]
10942451c: f9400108    	ldr	x8, [x8]
109424520: eb1b011f    	cmp	x8, x27
109424524: 54000060    	b.eq	0x109424530 <_Flutter_MMFoundation_BindContext+0x5900114>
109424528: aa1603e0    	mov	x0, x22
10942452c: 9590dbcb    	bl	0x10f85b458 <_UR_96F1_B25D+0x3a640c8>
109424530: f94017e8    	ldr	x8, [sp, #0x28]
109424534: f877791a    	ldr	x26, [x8, x23, lsl #3]
109424538: f941da60    	ldr	x0, [x19, #0x3b0] ; 0�D 
10942453c: aa1403e1    	mov	x1, x20
109424540: 9590dbc1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109424544: aa0003e2    	mov	x2, x0
109424548: aa1a03e0    	mov	x0, x26
10942454c: aa1503e1    	mov	x1, x21
109424550: 9590dbbd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109424554: 34000080    	cbz	w0, 0x109424564 <_Flutter_MMFoundation_BindContext+0x5900148>
109424558: aa1a03e0    	mov	x0, x26
10942455c: aa1903e1    	mov	x1, x25
109424560: 9590dbb9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109424564: f941df80    	ldr	x0, [x28, #0x3b8] ; ��C 
109424568: aa1403e1    	mov	x1, x20
10942456c: 9590dbb6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109424570: aa0003e2    	mov	x2, x0
109424574: aa1a03e0    	mov	x0, x26
109424578: aa1503e1    	mov	x1, x21
10942457c: 9590dbb2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109424580: 34000080    	cbz	w0, 0x109424590 <_Flutter_MMFoundation_BindContext+0x5900174>
109424584: aa1a03e0    	mov	x0, x26
109424588: aa1903e1    	mov	x1, x25
10942458c: 9590dbae    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109424590: 910006f7    	add	x23, x23, #0x1
109424594: eb17031f    	cmp	x24, x23
109424598: 54fffc01    	b.ne	0x109424518 <_Flutter_MMFoundation_BindContext+0x59000fc>
10942459c: 910083e2    	add	x2, sp, #0x20
1094245a0: 910183e3    	add	x3, sp, #0x60
1094245a4: aa1603e0    	mov	x0, x22
1094245a8: f9400fe1    	ldr	x1, [sp, #0x18]
1094245ac: 52800204    	mov	w4, #0x10               ; =16
1094245b0: 9590dba5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1094245b4: aa0003f8    	mov	x24, x0
1094245b8: b5fffaa0    	cbnz	x0, 0x10942450c <_Flutter_MMFoundation_BindContext+0x59000f0>
1094245bc: aa1603e0    	mov	x0, x22
1094245c0: 9590dba7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1094245c4: f9400bf3    	ldr	x19, [sp, #0x10]
1094245c8: f00b6a68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1094245cc: f9453515    	ldr	x21, [x8, #0xa68] ; �gH 
1094245d0: aa1303e0    	mov	x0, x19
1094245d4: aa1403e1    	mov	x1, x20
1094245d8: 9590db9b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1094245dc: b00b50a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1094245e0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1094245e4: f00aadc8    	adrp	x8, 0x11e9df000 <dyld_stub_binder+0x11e9df000>
1094245e8: 91332108    	add	x8, x8, #0xcc8 ; CFSTR WCPayControlLogic stop Logic : %@
1094245ec: a90003e8    	stp	x8, x0, [sp]
1094245f0: 9008f143    	adrp	x3, 0x11b24c000 <dyld_stub_binder+0x11b24c000>
1094245f4: 910fac63    	add	x3, x3, #0x3eb
1094245f8: b00941e5    	adrp	x5, 0x11bc61000 <dyld_stub_binder+0x11bc61000>
1094245fc: 912a68a5    	add	x5, x5, #0xa9a
109424600: b00941e7    	adrp	x7, 0x11bc61000 <dyld_stub_binder+0x11bc61000>
109424604: 912abce7    	add	x7, x7, #0xaaf
109424608: aa1503e0    	mov	x0, x21
10942460c: 52800042    	mov	w2, #0x2                ; =2
109424610: 52800004    	mov	w4, #0x0                ; =0
109424614: 52800b06    	mov	w6, #0x58               ; =88
109424618: 9590db8b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10942461c: d00b6728    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
109424620: f9460101    	ldr	x1, [x8, #0xc00] ; stopLoading
109424624: aa1303e0    	mov	x0, x19
109424628: 9590db87    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10942462c: f00b6a68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109424630: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
109424634: 900b66e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
109424638: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10942463c: 9590db82    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109424640: aa1d03fd    	mov	x29, x29
109424644: 9590db83    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109424648: aa0003f5    	mov	x21, x0
10942464c: b00b6a88    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
109424650: f940cd00    	ldr	x0, [x8, #0x198] ; �!D 
109424654: aa1403e1    	mov	x1, x20
109424658: 9590db7b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10942465c: aa0003e2    	mov	x2, x0
109424660: b00b50a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109424664: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
109424668: aa1503e0    	mov	x0, x21
10942466c: 9590db76    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109424670: aa1d03fd    	mov	x29, x29
109424674: 9590db77    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109424678: aa0003f4    	mov	x20, x0
10942467c: d00b70e8    	adrp	x8, 0x120242000 <dyld_stub_binder+0x120242000>
109424680: 910dd108    	add	x8, x8, #0x374
109424684: b9800108    	ldrsw	x8, [x8]
109424688: b8686a62    	ldr	w2, [x19, x8]
10942468c: 900b5a68    	adrp	x8, 0x11ff70000 <dyld_stub_binder+0x11ff70000>
109424690: f944d101    	ldr	x1, [x8, #0x9a0] ; stopLogic:
109424694: 9590db6c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109424698: aa1403e0    	mov	x0, x20
10942469c: 9590db70    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1094246a0: aa1503e0    	mov	x0, x21
1094246a4: 9590db6e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1094246a8: f85a03a8    	ldur	x8, [x29, #-0x60]
1094246ac: f00a0e49    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1094246b0: f9405929    	ldr	x9, [x9, #0xb0]
1094246b4: f9400129    	ldr	x9, [x9]
1094246b8: eb08013f    	cmp	x9, x8
1094246bc: 54000121    	b.ne	0x1094246e0 <_Flutter_MMFoundation_BindContext+0x59002c4>
1094246c0: a9547bfd    	ldp	x29, x30, [sp, #0x140]
1094246c4: a9534ff4    	ldp	x20, x19, [sp, #0x130]
1094246c8: a95257f6    	ldp	x22, x21, [sp, #0x120]
1094246cc: a9515ff8    	ldp	x24, x23, [sp, #0x110]
1094246d0: a95067fa    	ldp	x26, x25, [sp, #0x100]
1094246d4: a94f6ffc    	ldp	x28, x27, [sp, #0xf0]
1094246d8: 910543ff    	add	sp, sp, #0x150
1094246dc: d65f03c0    	ret
1094246e0: 9590db67    	bl	0x10f85b47c <_UR_96F1_B25D+0x3a640ec>