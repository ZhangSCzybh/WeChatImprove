
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1091f7260: d10443ff    	sub	sp, sp, #0x110
1091f7264: 6d0a23e9    	stp	d9, d8, [sp, #0xa0]
1091f7268: a90b6ffc    	stp	x28, x27, [sp, #0xb0]
1091f726c: a90c67fa    	stp	x26, x25, [sp, #0xc0]
1091f7270: a90d5ff8    	stp	x24, x23, [sp, #0xd0]
1091f7274: a90e57f6    	stp	x22, x21, [sp, #0xe0]
1091f7278: a90f4ff4    	stp	x20, x19, [sp, #0xf0]
1091f727c: a9107bfd    	stp	x29, x30, [sp, #0x100]
1091f7280: 910403fd    	add	x29, sp, #0x100
1091f7284: aa0203f3    	mov	x19, x2
1091f7288: aa0003f5    	mov	x21, x0
1091f728c: f00bd2a8    	adrp	x8, 0x120c4e000 <dyld_stub_binder+0x120c4e000>
1091f7290: 52800029    	mov	w9, #0x1                ; =1
1091f7294: 39183509    	strb	w9, [x8, #0x60d]
1091f7298: aa0203e0    	mov	x0, x2
1091f729c: 95999069    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
1091f72a0: b00b7848    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1091f72a4: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1091f72a8: aa1303e0    	mov	x0, x19
1091f72ac: 95999066    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f72b0: b4001600    	cbz	x0, 0x1091f7570 <_Flutter_MMFoundation_BindContext+0x56d3154>
1091f72b4: f00b7888    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1091f72b8: f9448501    	ldr	x1, [x8, #0x908] ; sortedArrayUsingComparator:
1091f72bc: b00a2662    	adrp	x2, 0x11d6c4000 <dyld_stub_binder+0x11d6c4000>
1091f72c0: 9121e042    	add	x2, x2, #0x878
1091f72c4: aa1303e0    	mov	x0, x19
1091f72c8: 9599905f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f72cc: aa1d03fd    	mov	x29, x29
1091f72d0: 95999060    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091f72d4: aa0003e2    	mov	x2, x0
1091f72d8: f9001be0    	str	x0, [sp, #0x30]
1091f72dc: b00b7be8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1091f72e0: f9434100    	ldr	x0, [x8, #0x680]
1091f72e4: f00b7888    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1091f72e8: f9419101    	ldr	x1, [x8, #0x320] ; setWithArray:
1091f72ec: 95999056    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f72f0: aa1d03fd    	mov	x29, x29
1091f72f4: 95999057    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091f72f8: aa0003f4    	mov	x20, x0
1091f72fc: d00b73a8    	adrp	x8, 0x12006d000 <dyld_stub_binder+0x12006d000>
1091f7300: f9476d01    	ldr	x1, [x8, #0xed8] ; setUndeterminedContactSet:
1091f7304: aa1503e0    	mov	x0, x21
1091f7308: aa1403e2    	mov	x2, x20
1091f730c: 9599904e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f7310: aa1403e0    	mov	x0, x20
1091f7314: 95999052    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091f7318: 900b7be8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1091f731c: f9469508    	ldr	x8, [x8, #0xd28] ; x<c
1091f7320: f9000fe8    	str	x8, [sp, #0x18]
1091f7324: 900b7be8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1091f7328: f945e900    	ldr	x0, [x8, #0xbd0]
1091f732c: aa0803f9    	mov	x25, x8
1091f7330: b00b7848    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1091f7334: f944e918    	ldr	x24, [x8, #0x9d0] ; currentContext
1091f7338: aa1803e1    	mov	x1, x24
1091f733c: 95999042    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f7340: aa1d03fd    	mov	x29, x29
1091f7344: 95999043    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091f7348: aa0003f7    	mov	x23, x0
1091f734c: f90017e0    	str	x0, [sp, #0x28]
1091f7350: 900b7be8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1091f7354: f9462900    	ldr	x0, [x8, #0xc50]
1091f7358: aa0803fa    	mov	x26, x8
1091f735c: 900b7848    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1091f7360: f947ad14    	ldr	x20, [x8, #0xf58] ; class
1091f7364: aa1403e1    	mov	x1, x20
1091f7368: 95999037    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f736c: aa0003e2    	mov	x2, x0
1091f7370: d00b6208    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1091f7374: f9464116    	ldr	x22, [x8, #0xc80] ; getService:
1091f7378: aa1703e0    	mov	x0, x23
1091f737c: aa1603e1    	mov	x1, x22
1091f7380: 95999031    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f7384: aa1d03fd    	mov	x29, x29
1091f7388: 95999032    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091f738c: f90013e0    	str	x0, [sp, #0x20]
1091f7390: d00b6208    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1091f7394: f9464517    	ldr	x23, [x8, #0xc88] ; getStringForCurLanguage:
1091f7398: f00ab562    	adrp	x2, 0x11e8a6000 <dyld_stub_binder+0x11e8a6000>
1091f739c: 9118a042    	add	x2, x2, #0x628
1091f73a0: aa1703e1    	mov	x1, x23
1091f73a4: 95999028    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f73a8: aa1d03fd    	mov	x29, x29
1091f73ac: 95999029    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091f73b0: f90007e0    	str	x0, [sp, #0x8]
1091f73b4: f945eb20    	ldr	x0, [x25, #0xbd0]
1091f73b8: aa1803e1    	mov	x1, x24
1091f73bc: 95999022    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f73c0: aa1d03fd    	mov	x29, x29
1091f73c4: 95999023    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091f73c8: aa0003f9    	mov	x25, x0
1091f73cc: f9000be0    	str	x0, [sp, #0x10]
1091f73d0: f9462b40    	ldr	x0, [x26, #0xc50]
1091f73d4: aa1403e1    	mov	x1, x20
1091f73d8: 9599901b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f73dc: aa0003e2    	mov	x2, x0
1091f73e0: aa1903e0    	mov	x0, x25
1091f73e4: aa1603e1    	mov	x1, x22
1091f73e8: 95999017    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f73ec: aa1d03fd    	mov	x29, x29
1091f73f0: 95999018    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091f73f4: aa0003fb    	mov	x27, x0
1091f73f8: f00ab562    	adrp	x2, 0x11e8a6000 <dyld_stub_binder+0x11e8a6000>
1091f73fc: 91192042    	add	x2, x2, #0x648
1091f7400: aa1703e1    	mov	x1, x23
1091f7404: 95999010    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f7408: aa1d03fd    	mov	x29, x29
1091f740c: 95999011    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091f7410: aa0003fc    	mov	x28, x0
1091f7414: f00a1fb9    	adrp	x25, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1091f7418: f947e339    	ldr	x25, [x25, #0xfc0]
1091f741c: f90037f9    	str	x25, [sp, #0x68]
1091f7420: d007dc48    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1091f7424: fd41c108    	ldr	d8, [x8, #0x380]
1091f7428: 90000008    	adrp	x8, 0x1091f7000 <_Flutter_MMFoundation_BindContext+0x56d2be4>
1091f742c: 91199108    	add	x8, x8, #0x664
1091f7430: fd003be8    	str	d8, [sp, #0x70]
1091f7434: 900a201a    	adrp	x26, 0x11d5f7000 <dyld_stub_binder+0x11d5f7000>
1091f7438: 9104435a    	add	x26, x26, #0x110
1091f743c: a907ebe8    	stp	x8, x26, [sp, #0x78]
1091f7440: f90047f5    	str	x21, [sp, #0x88]
1091f7444: aa1303e0    	mov	x0, x19
1091f7448: 95998ffe    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
1091f744c: f9004bf3    	str	x19, [sp, #0x90]
1091f7450: 900b7be8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1091f7454: f945e900    	ldr	x0, [x8, #0xbd0]
1091f7458: aa1803e1    	mov	x1, x24
1091f745c: 95998ffa    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f7460: aa1d03fd    	mov	x29, x29
1091f7464: 95998ffb    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091f7468: aa0003f8    	mov	x24, x0
1091f746c: 900b7be8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1091f7470: f9462900    	ldr	x0, [x8, #0xc50]
1091f7474: aa1403e1    	mov	x1, x20
1091f7478: 95998ff3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f747c: aa0003e2    	mov	x2, x0
1091f7480: aa1803e0    	mov	x0, x24
1091f7484: aa1603e1    	mov	x1, x22
1091f7488: 95998fef    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f748c: aa1d03fd    	mov	x29, x29
1091f7490: 95998ff0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091f7494: aa0003f4    	mov	x20, x0
1091f7498: f00ab562    	adrp	x2, 0x11e8a6000 <dyld_stub_binder+0x11e8a6000>
1091f749c: 9119a042    	add	x2, x2, #0x668
1091f74a0: aa1703e1    	mov	x1, x23
1091f74a4: 95998fe8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f74a8: aa1d03fd    	mov	x29, x29
1091f74ac: 95998fe9    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091f74b0: aa0003f6    	mov	x22, x0
1091f74b4: f9001ff9    	str	x25, [sp, #0x38]
1091f74b8: fd0023e8    	str	d8, [sp, #0x40]
1091f74bc: 90000008    	adrp	x8, 0x1091f7000 <_Flutter_MMFoundation_BindContext+0x56d2be4>
1091f74c0: 911ad108    	add	x8, x8, #0x6b4
1091f74c4: a904ebe8    	stp	x8, x26, [sp, #0x48]
1091f74c8: f9002ff5    	str	x21, [sp, #0x58]
1091f74cc: aa1303e0    	mov	x0, x19
1091f74d0: 95998fdc    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
1091f74d4: f90033f3    	str	x19, [sp, #0x60]
1091f74d8: b00b6228    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1091f74dc: f9425501    	ldr	x1, [x8, #0x4a8] ; showAlertWithTitle:message:btnTitle:handler:btnTitle:handler:
1091f74e0: 9101a3e5    	add	x5, sp, #0x68
1091f74e4: 9100e3e7    	add	x7, sp, #0x38
1091f74e8: f9400fe0    	ldr	x0, [sp, #0x18]
1091f74ec: d2800002    	mov	x2, #0x0                ; =0
1091f74f0: f94007f5    	ldr	x21, [sp, #0x8]
1091f74f4: aa1503e3    	mov	x3, x21
1091f74f8: aa1c03e4    	mov	x4, x28
1091f74fc: aa1603e6    	mov	x6, x22
1091f7500: 95998fd1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f7504: aa1d03fd    	mov	x29, x29
1091f7508: 95998fd9    	bl	0x10f85b46c <_UR_96F1_B25D+0x3a640dc>
1091f750c: aa1603e0    	mov	x0, x22
1091f7510: 95998fd3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091f7514: aa1403e0    	mov	x0, x20
1091f7518: 95998fd1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091f751c: aa1803e0    	mov	x0, x24
1091f7520: 95998fcf    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091f7524: aa1c03e0    	mov	x0, x28
1091f7528: 95998fcd    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091f752c: aa1b03e0    	mov	x0, x27
1091f7530: 95998fcb    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091f7534: f9400be0    	ldr	x0, [sp, #0x10]
1091f7538: 95998fc9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091f753c: aa1503e0    	mov	x0, x21
1091f7540: 95998fc7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091f7544: f94013e0    	ldr	x0, [sp, #0x20]
1091f7548: 95998fc5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091f754c: f94017e0    	ldr	x0, [sp, #0x28]
1091f7550: 95998fc3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091f7554: f94033e0    	ldr	x0, [sp, #0x60]
1091f7558: 95998fc1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091f755c: f9404be0    	ldr	x0, [sp, #0x90]
1091f7560: 95998fbf    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091f7564: f9401be0    	ldr	x0, [sp, #0x30]
1091f7568: 95998fbd    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091f756c: 1400000b    	b	0x1091f7598 <_Flutter_MMFoundation_BindContext+0x56d317c>
1091f7570: d00b73a8    	adrp	x8, 0x12006d000 <dyld_stub_binder+0x12006d000>
1091f7574: f9476901    	ldr	x1, [x8, #0xed0] ; updateWithSelectedContactSet:
1091f7578: aa1503e0    	mov	x0, x21
1091f757c: d2800002    	mov	x2, #0x0                ; =0
1091f7580: 95998fb1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f7584: 900b6228    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1091f7588: f945f501    	ldr	x1, [x8, #0xbe8] ; DismissModalViewControllerAnimated:
1091f758c: aa1503e0    	mov	x0, x21
1091f7590: 52800022    	mov	w2, #0x1                ; =1
1091f7594: 95998fac    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f7598: aa1303e0    	mov	x0, x19
1091f759c: 95998fb0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091f75a0: a9507bfd    	ldp	x29, x30, [sp, #0x100]
1091f75a4: a94f4ff4    	ldp	x20, x19, [sp, #0xf0]
1091f75a8: a94e57f6    	ldp	x22, x21, [sp, #0xe0]
1091f75ac: a94d5ff8    	ldp	x24, x23, [sp, #0xd0]
1091f75b0: a94c67fa    	ldp	x26, x25, [sp, #0xc0]
1091f75b4: a94b6ffc    	ldp	x28, x27, [sp, #0xb0]
1091f75b8: 6d4a23e9    	ldp	d9, d8, [sp, #0xa0]
1091f75bc: 910443ff    	add	sp, sp, #0x110
1091f75c0: d65f03c0    	ret
