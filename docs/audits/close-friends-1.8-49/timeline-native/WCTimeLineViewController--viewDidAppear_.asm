
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a0b747c: d10303ff    	sub	sp, sp, #0xc0
10a0b7480: a9066ffc    	stp	x28, x27, [sp, #0x60]
10a0b7484: a90767fa    	stp	x26, x25, [sp, #0x70]
10a0b7488: a9085ff8    	stp	x24, x23, [sp, #0x80]
10a0b748c: a90957f6    	stp	x22, x21, [sp, #0x90]
10a0b7490: a90a4ff4    	stp	x20, x19, [sp, #0xa0]
10a0b7494: a90b7bfd    	stp	x29, x30, [sp, #0xb0]
10a0b7498: 9102c3fd    	add	x29, sp, #0xb0
10a0b749c: aa0203f7    	mov	x23, x2
10a0b74a0: aa0003f3    	mov	x19, x0
10a0b74a4: 9009a9c8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10a0b74a8: f9405908    	ldr	x8, [x8, #0xb0]
10a0b74ac: f9400108    	ldr	x8, [x8]
10a0b74b0: f9002fe8    	str	x8, [sp, #0x58]
10a0b74b4: d00b5cc8    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a0b74b8: 52800029    	mov	w9, #0x1                ; =1
10a0b74bc: 3911b909    	strb	w9, [x8, #0x46e]
10a0b74c0: 900b05e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0b74c4: f9453500    	ldr	x0, [x8, #0xa68]
10a0b74c8: d00aec08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0b74cc: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a0b74d0: d00a2228    	adrp	x8, 0x11e4fd000 <dyld_stub_binder+0x11e4fd000>
10a0b74d4: 91072108    	add	x8, x8, #0x1c8
10a0b74d8: f90003e8    	str	x8, [sp]
10a0b74dc: b0088b23    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
10a0b74e0: 912b2863    	add	x3, x3, #0xaca
10a0b74e4: d008e265    	adrp	x5, 0x11bd05000 <dyld_stub_binder+0x11bd05000>
10a0b74e8: 912850a5    	add	x5, x5, #0xa14
10a0b74ec: d008e267    	adrp	x7, 0x11bd05000 <dyld_stub_binder+0x11bd05000>
10a0b74f0: 912f40e7    	add	x7, x7, #0xbd0
10a0b74f4: 52800042    	mov	w2, #0x2                ; =2
10a0b74f8: 52800004    	mov	w4, #0x0                ; =0
10a0b74fc: 52806fc6    	mov	w6, #0x37e              ; =894
10a0b7500: 955e8fd1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7504: 900b05fb    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
10a0b7508: f945eb60    	ldr	x0, [x27, #0xbd0]
10a0b750c: b00b0248    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a0b7510: f944e914    	ldr	x20, [x8, #0x9d0] ; currentContext
10a0b7514: aa1403e1    	mov	x1, x20
10a0b7518: 955e8fcb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b751c: aa1d03fd    	mov	x29, x29
10a0b7520: 955e8fcc    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b7524: aa0003f8    	mov	x24, x0
10a0b7528: b00b05fc    	adrp	x28, 0x120174000 <dyld_stub_binder+0x120174000>
10a0b752c: f9428780    	ldr	x0, [x28, #0x508]
10a0b7530: 900b0248    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a0b7534: f947ad15    	ldr	x21, [x8, #0xf58] ; class
10a0b7538: aa1503e1    	mov	x1, x21
10a0b753c: 955e8fc2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7540: aa0003e2    	mov	x2, x0
10a0b7544: d00aec08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0b7548: f9464116    	ldr	x22, [x8, #0xc80] ; getService:
10a0b754c: aa1803e0    	mov	x0, x24
10a0b7550: aa1603e1    	mov	x1, x22
10a0b7554: 955e8fbc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7558: aa1d03fd    	mov	x29, x29
10a0b755c: 955e8fbd    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b7560: aa0003f9    	mov	x25, x0
10a0b7564: 900af9c8    	adrp	x8, 0x11ffef000 <dyld_stub_binder+0x11ffef000>
10a0b7568: f9411901    	ldr	x1, [x8, #0x230] ; setDownloadScene:
10a0b756c: 52800042    	mov	w2, #0x2                ; =2
10a0b7570: 955e8fb5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7574: aa1903e0    	mov	x0, x25
10a0b7578: 955e8fb9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b757c: aa1803e0    	mov	x0, x24
10a0b7580: 955e8fb7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b7584: f945eb60    	ldr	x0, [x27, #0xbd0]
10a0b7588: aa1403e1    	mov	x1, x20
10a0b758c: 955e8fae    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7590: aa1d03fd    	mov	x29, x29
10a0b7594: 955e8faf    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b7598: aa0003f8    	mov	x24, x0
10a0b759c: f9428780    	ldr	x0, [x28, #0x508]
10a0b75a0: aa1503e1    	mov	x1, x21
10a0b75a4: 955e8fa8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b75a8: aa0003e2    	mov	x2, x0
10a0b75ac: aa1803e0    	mov	x0, x24
10a0b75b0: aa1603e1    	mov	x1, x22
10a0b75b4: 955e8fa4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b75b8: aa1d03fd    	mov	x29, x29
10a0b75bc: 955e8fa5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b75c0: aa0003f9    	mov	x25, x0
10a0b75c4: f00af9c8    	adrp	x8, 0x11fff2000 <dyld_stub_binder+0x11fff2000>
10a0b75c8: f943fd01    	ldr	x1, [x8, #0x7f8] ; updateCurrentPage:
10a0b75cc: 52800022    	mov	w2, #0x1                ; =1
10a0b75d0: 955e8f9d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b75d4: aa1903e0    	mov	x0, x25
10a0b75d8: 955e8fa1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b75dc: aa1803e0    	mov	x0, x24
10a0b75e0: 955e8f9f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b75e4: b00b08e8    	adrp	x8, 0x1201d4000 <dyld_stub_binder+0x1201d4000>
10a0b75e8: f9406908    	ldr	x8, [x8, #0xd0]
10a0b75ec: a903a3f3    	stp	x19, x8, [sp, #0x38]
10a0b75f0: b00aec28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a0b75f4: f941d901    	ldr	x1, [x8, #0x3b0] ; viewDidAppear:
10a0b75f8: 9100e3e0    	add	x0, sp, #0x38
10a0b75fc: aa1703e2    	mov	x2, x23
10a0b7600: 955e8f93    	bl	0x10f85b44c <_UR_96F1_B25D+0x3a640bc>
10a0b7604: 528000c0    	mov	w0, #0x6                ; =6
10a0b7608: 52800041    	mov	w1, #0x2                ; =2
10a0b760c: d2800002    	mov	x2, #0x0                ; =0
10a0b7610: 96949957    	bl	0x1045ddb6c <_Flutter_MMFoundation_BindContext+0xab9750>
10a0b7614: f945eb60    	ldr	x0, [x27, #0xbd0]
10a0b7618: aa1403e1    	mov	x1, x20
10a0b761c: 955e8f8a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7620: aa1d03fd    	mov	x29, x29
10a0b7624: 955e8f8b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b7628: aa0003f8    	mov	x24, x0
10a0b762c: f9428780    	ldr	x0, [x28, #0x508]
10a0b7630: aa1503e1    	mov	x1, x21
10a0b7634: 955e8f84    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7638: aa0003e2    	mov	x2, x0
10a0b763c: aa1803e0    	mov	x0, x24
10a0b7640: aa1603e1    	mov	x1, x22
10a0b7644: 955e8f80    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7648: aa1d03fd    	mov	x29, x29
10a0b764c: 955e8f81    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b7650: aa0003f9    	mov	x25, x0
10a0b7654: f00afa68    	adrp	x8, 0x120006000 <dyld_stub_binder+0x120006000>
10a0b7658: f942d901    	ldr	x1, [x8, #0x5b0] ; markTodayTimelineEntered
10a0b765c: 955e8f7a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7660: aa1903e0    	mov	x0, x25
10a0b7664: 955e8f7e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b7668: aa1803e0    	mov	x0, x24
10a0b766c: 955e8f7c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b7670: d00aff08    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0b7674: f9413901    	ldr	x1, [x8, #0x270] ; dealSecurityVerificationInSession
10a0b7678: aa1303e0    	mov	x0, x19
10a0b767c: 955e8f72    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7680: b00b0de8    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0b7684: b9820108    	ldrsw	x8, [x8, #0x200]
10a0b7688: f8686a60    	ldr	x0, [x19, x8]
10a0b768c: f00b0268    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10a0b7690: f9408101    	ldr	x1, [x8, #0x100] ; removeAllObjects
10a0b7694: 955e8f6c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7698: b00aec68    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a0b769c: f944d501    	ldr	x1, [x8, #0x9a8] ; setIsViewDidAppear:
10a0b76a0: aa1303e0    	mov	x0, x19
10a0b76a4: 52800022    	mov	w2, #0x1                ; =1
10a0b76a8: 955e8f67    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b76ac: b00aec68    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a0b76b0: f944d901    	ldr	x1, [x8, #0x9b0] ; autoplayVideoProcess
10a0b76b4: aa1303e0    	mov	x0, x19
10a0b76b8: 955e8f63    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b76bc: d00aff08    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0b76c0: f9413d01    	ldr	x1, [x8, #0x278] ; startAdOnTimelineReloaded
10a0b76c4: aa1303e0    	mov	x0, x19
10a0b76c8: 955e8f5f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b76cc: d00aff08    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0b76d0: f9414101    	ldr	x1, [x8, #0x280] ; startFPSMonitor
10a0b76d4: aa1303e0    	mov	x0, x19
10a0b76d8: 955e8f5b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b76dc: f945eb60    	ldr	x0, [x27, #0xbd0]
10a0b76e0: aa1403e1    	mov	x1, x20
10a0b76e4: 955e8f58    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b76e8: aa1d03fd    	mov	x29, x29
10a0b76ec: 955e8f59    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b76f0: aa0003f8    	mov	x24, x0
10a0b76f4: 900b05e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0b76f8: f946e100    	ldr	x0, [x8, #0xdc0]
10a0b76fc: aa1503e1    	mov	x1, x21
10a0b7700: 955e8f51    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7704: aa0003e2    	mov	x2, x0
10a0b7708: aa1803e0    	mov	x0, x24
10a0b770c: aa1603e1    	mov	x1, x22
10a0b7710: 955e8f4d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7714: aa1d03fd    	mov	x29, x29
10a0b7718: 955e8f4e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b771c: aa0003f9    	mov	x25, x0
10a0b7720: f00afae8    	adrp	x8, 0x120016000 <dyld_stub_binder+0x120016000>
10a0b7724: f9472501    	ldr	x1, [x8, #0xe48] ; startStatsReport
10a0b7728: 955e8f47    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b772c: aa1903e0    	mov	x0, x25
10a0b7730: 955e8f4b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b7734: aa1803e0    	mov	x0, x24
10a0b7738: 955e8f49    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b773c: f945eb60    	ldr	x0, [x27, #0xbd0]
10a0b7740: aa1403e1    	mov	x1, x20
10a0b7744: 955e8f40    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7748: aa1d03fd    	mov	x29, x29
10a0b774c: 955e8f41    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b7750: aa0003f8    	mov	x24, x0
10a0b7754: f00b05c8    	adrp	x8, 0x120172000 <dyld_stub_binder+0x120172000>
10a0b7758: f940cd02    	ldr	x2, [x8, #0x198]
10a0b775c: 900af608    	adrp	x8, 0x11ff77000 <dyld_stub_binder+0x11ff77000>
10a0b7760: f9472503    	ldr	x3, [x8, #0xe48] ; onViewDidAppear:withVC:
10a0b7764: f009a9a8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10a0b7768: f947e108    	ldr	x8, [x8, #0xfc0]
10a0b776c: f90007e8    	str	x8, [sp, #0x8]
10a0b7770: d0076648    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10a0b7774: fd41c100    	ldr	d0, [x8, #0x380]
10a0b7778: fd000be0    	str	d0, [sp, #0x10]
10a0b777c: 90000008    	adrp	x8, 0x10a0b7000 <_Flutter_MMFoundation_BindContext+0x6592be4>
10a0b7780: 912da108    	add	x8, x8, #0xb68
10a0b7784: 9009aa09    	adrp	x9, 0x11d5f7000 <dyld_stub_binder+0x11d5f7000>
10a0b7788: 912ee129    	add	x9, x9, #0xbb8
10a0b778c: a901a7e8    	stp	x8, x9, [sp, #0x18]
10a0b7790: 3900c3f7    	strb	w23, [sp, #0x30]
10a0b7794: f90017f3    	str	x19, [sp, #0x28]
10a0b7798: f00aec08    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10a0b779c: f9404901    	ldr	x1, [x8, #0x90] ; callExtension:selector:block:
10a0b77a0: 910023e4    	add	x4, sp, #0x8
10a0b77a4: 955e8f28    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b77a8: aa1803e0    	mov	x0, x24
10a0b77ac: 955e8f2c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b77b0: d00aff08    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0b77b4: f9414501    	ldr	x1, [x8, #0x288] ; reloadBadgeForRightBarButtonItem
10a0b77b8: aa1303e0    	mov	x0, x19
10a0b77bc: 955e8f22    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b77c0: d00aff08    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0b77c4: f9414901    	ldr	x1, [x8, #0x290] ; setUsingTemplateShareInfo:
10a0b77c8: aa1303e0    	mov	x0, x19
10a0b77cc: d2800002    	mov	x2, #0x0                ; =0
10a0b77d0: 955e8f1d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b77d4: b00b0de8    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0b77d8: b9823d19    	ldrsw	x25, [x8, #0x23c]
10a0b77dc: 38796a68    	ldrb	w8, [x19, x25]
10a0b77e0: 7100051f    	cmp	w8, #0x1
10a0b77e4: 54000301    	b.ne	0x10a0b7844 <_Flutter_MMFoundation_BindContext+0x6593428>
10a0b77e8: b00b0268    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10a0b77ec: f945e501    	ldr	x1, [x8, #0xbc8] ; navigationItem
10a0b77f0: aa1303e0    	mov	x0, x19
10a0b77f4: 955e8f14    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b77f8: aa1d03fd    	mov	x29, x29
10a0b77fc: 955e8f15    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b7800: aa0003f7    	mov	x23, x0
10a0b7804: 900aec28    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a0b7808: f945e901    	ldr	x1, [x8, #0xbd0] ; rightBarButtonItem
10a0b780c: 955e8f0e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7810: aa1d03fd    	mov	x29, x29
10a0b7814: 955e8f0f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b7818: aa0003f8    	mov	x24, x0
10a0b781c: 900afd88    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
10a0b7820: f941a101    	ldr	x1, [x8, #0x340] ; showUploadOption:
10a0b7824: aa1303e0    	mov	x0, x19
10a0b7828: aa1803e2    	mov	x2, x24
10a0b782c: 955e8f06    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7830: aa1803e0    	mov	x0, x24
10a0b7834: 955e8f0a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b7838: aa1703e0    	mov	x0, x23
10a0b783c: 955e8f08    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b7840: 38396a7f    	strb	wzr, [x19, x25]
10a0b7844: b00af828    	adrp	x8, 0x11ffbc000 <dyld_stub_binder+0x11ffbc000>
10a0b7848: f9467117    	ldr	x23, [x8, #0xce0] ; animateHelper
10a0b784c: aa1303e0    	mov	x0, x19
10a0b7850: aa1703e1    	mov	x1, x23
10a0b7854: 955e8efc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7858: aa1d03fd    	mov	x29, x29
10a0b785c: 955e8efd    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b7860: aa0003f8    	mov	x24, x0
10a0b7864: b00af828    	adrp	x8, 0x11ffbc000 <dyld_stub_binder+0x11ffbc000>
10a0b7868: f9458d01    	ldr	x1, [x8, #0xb18] ; isAtHoverState
10a0b786c: 955e8ef6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7870: aa0003f9    	mov	x25, x0
10a0b7874: aa1803e0    	mov	x0, x24
10a0b7878: 955e8ef9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b787c: 34000199    	cbz	w25, 0x10a0b78ac <_Flutter_MMFoundation_BindContext+0x6593490>
10a0b7880: aa1303e0    	mov	x0, x19
10a0b7884: aa1703e1    	mov	x1, x23
10a0b7888: 955e8eef    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b788c: aa1d03fd    	mov	x29, x29
10a0b7890: 955e8ef0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b7894: aa0003f7    	mov	x23, x0
10a0b7898: b00af828    	adrp	x8, 0x11ffbc000 <dyld_stub_binder+0x11ffbc000>
10a0b789c: f9457d01    	ldr	x1, [x8, #0xaf8] ; startMediaPlay
10a0b78a0: 955e8ee9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b78a4: aa1703e0    	mov	x0, x23
10a0b78a8: 955e8eed    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b78ac: b00b0de8    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0b78b0: b9824117    	ldrsw	x23, [x8, #0x240]
10a0b78b4: 38776a68    	ldrb	w8, [x19, x23]
10a0b78b8: 7100051f    	cmp	w8, #0x1
10a0b78bc: 540000c1    	b.ne	0x10a0b78d4 <_Flutter_MMFoundation_BindContext+0x65934b8>
10a0b78c0: d00aff08    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0b78c4: f9414d01    	ldr	x1, [x8, #0x298] ; openWriteTextViewController
10a0b78c8: aa1303e0    	mov	x0, x19
10a0b78cc: 955e8ede    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b78d0: 38376a7f    	strb	wzr, [x19, x23]
10a0b78d4: d00aff08    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0b78d8: f9412517    	ldr	x23, [x8, #0x248] ; headerPanGestureRecognizer
10a0b78dc: aa1303e0    	mov	x0, x19
10a0b78e0: aa1703e1    	mov	x1, x23
10a0b78e4: 955e8ed8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b78e8: aa1d03fd    	mov	x29, x29
10a0b78ec: 955e8ed9    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b78f0: b4000460    	cbz	x0, 0x10a0b797c <_Flutter_MMFoundation_BindContext+0x6593560>
10a0b78f4: aa0003f9    	mov	x25, x0
10a0b78f8: f00aee68    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
10a0b78fc: f9452118    	ldr	x24, [x8, #0xa40] ; getWCSplitNavBackPanGesture
10a0b7900: aa1303e0    	mov	x0, x19
10a0b7904: aa1803e1    	mov	x1, x24
10a0b7908: 955e8ecf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b790c: aa1d03fd    	mov	x29, x29
10a0b7910: 955e8ed0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b7914: aa0003fa    	mov	x26, x0
10a0b7918: 955e8ed1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b791c: aa1903e0    	mov	x0, x25
10a0b7920: 955e8ecf    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b7924: b40002da    	cbz	x26, 0x10a0b797c <_Flutter_MMFoundation_BindContext+0x6593560>
10a0b7928: aa1303e0    	mov	x0, x19
10a0b792c: aa1703e1    	mov	x1, x23
10a0b7930: 955e8ec5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7934: aa1d03fd    	mov	x29, x29
10a0b7938: 955e8ec6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b793c: aa0003f7    	mov	x23, x0
10a0b7940: aa1303e0    	mov	x0, x19
10a0b7944: aa1803e1    	mov	x1, x24
10a0b7948: 955e8ebf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b794c: aa1d03fd    	mov	x29, x29
10a0b7950: 955e8ec0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b7954: aa0003f8    	mov	x24, x0
10a0b7958: f00b0268    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10a0b795c: f942dd01    	ldr	x1, [x8, #0x5b8] ; requireGestureRecognizerToFail:
10a0b7960: aa1703e0    	mov	x0, x23
10a0b7964: aa1803e2    	mov	x2, x24
10a0b7968: 955e8eb7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b796c: aa1803e0    	mov	x0, x24
10a0b7970: 955e8ebb    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b7974: aa1703e0    	mov	x0, x23
10a0b7978: 955e8eb9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b797c: f945eb60    	ldr	x0, [x27, #0xbd0]
10a0b7980: aa1403e1    	mov	x1, x20
10a0b7984: 955e8eb0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7988: aa1d03fd    	mov	x29, x29
10a0b798c: 955e8eb1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b7990: aa0003f4    	mov	x20, x0
10a0b7994: f9428780    	ldr	x0, [x28, #0x508]
10a0b7998: aa1503e1    	mov	x1, x21
10a0b799c: 955e8eaa    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b79a0: aa0003e2    	mov	x2, x0
10a0b79a4: aa1403e0    	mov	x0, x20
10a0b79a8: aa1603e1    	mov	x1, x22
10a0b79ac: 955e8ea6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b79b0: aa1d03fd    	mov	x29, x29
10a0b79b4: 955e8ea7    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b79b8: aa0003f5    	mov	x21, x0
10a0b79bc: b00aef08    	adrp	x8, 0x11fe98000 <dyld_stub_binder+0x11fe98000>
10a0b79c0: f9439501    	ldr	x1, [x8, #0x728] ; dynamicConfig
10a0b79c4: 955e8ea0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b79c8: aa1d03fd    	mov	x29, x29
10a0b79cc: 955e8ea1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b79d0: aa0003f6    	mov	x22, x0
10a0b79d4: d00aff08    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0b79d8: f9415101    	ldr	x1, [x8, #0x2a0] ; Spring_logConfigurations
10a0b79dc: 955e8e9a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b79e0: aa1603e0    	mov	x0, x22
10a0b79e4: 955e8e9e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b79e8: aa1503e0    	mov	x0, x21
10a0b79ec: 955e8e9c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b79f0: aa1403e0    	mov	x0, x20
10a0b79f4: 955e8e9a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b79f8: d00aff08    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0b79fc: f9415501    	ldr	x1, [x8, #0x2a8] ; scrollViewMonitor
10a0b7a00: aa1303e0    	mov	x0, x19
10a0b7a04: 955e8e90    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7a08: aa1d03fd    	mov	x29, x29
10a0b7a0c: 955e8e91    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b7a10: aa0003f4    	mov	x20, x0
10a0b7a14: d00aff08    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0b7a18: f9415901    	ldr	x1, [x8, #0x2b0] ; checkScrollingToTop
10a0b7a1c: 955e8e8a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7a20: aa1403e0    	mov	x0, x20
10a0b7a24: 955e8e8e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b7a28: d00afda8    	adrp	x8, 0x12006d000 <dyld_stub_binder+0x12006d000>
10a0b7a2c: f9446914    	ldr	x20, [x8, #0x8d0] ; postingViewModel
10a0b7a30: aa1303e0    	mov	x0, x19
10a0b7a34: aa1403e1    	mov	x1, x20
10a0b7a38: 955e8e83    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7a3c: aa1d03fd    	mov	x29, x29
10a0b7a40: 955e8e84    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b7a44: aa0003f5    	mov	x21, x0
10a0b7a48: 955e8e85    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b7a4c: b4000715    	cbz	x21, 0x10a0b7b2c <_Flutter_MMFoundation_BindContext+0x6593710>
10a0b7a50: aa1303e0    	mov	x0, x19
10a0b7a54: aa1403e1    	mov	x1, x20
10a0b7a58: 955e8e7b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7a5c: aa1d03fd    	mov	x29, x29
10a0b7a60: 955e8e7c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b7a64: aa0003f4    	mov	x20, x0
10a0b7a68: d00afda8    	adrp	x8, 0x12006d000 <dyld_stub_binder+0x12006d000>
10a0b7a6c: f9446d01    	ldr	x1, [x8, #0x8d8] ; setPostingViewModel:
10a0b7a70: aa1303e0    	mov	x0, x19
10a0b7a74: d2800002    	mov	x2, #0x0                ; =0
10a0b7a78: 955e8e73    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7a7c: f00a4888    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
10a0b7a80: 9129a108    	add	x8, x8, #0xa68
10a0b7a84: f90027e8    	str	x8, [sp, #0x48]
10a0b7a88: 900b05e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0b7a8c: f9458900    	ldr	x0, [x8, #0xb10]
10a0b7a90: b00b0268    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10a0b7a94: f947a501    	ldr	x1, [x8, #0xf48] ; numberWithInt:
10a0b7a98: 52800062    	mov	w2, #0x3                ; =3
10a0b7a9c: 955e8e6a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7aa0: aa1d03fd    	mov	x29, x29
10a0b7aa4: 955e8e6b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b7aa8: aa0003f3    	mov	x19, x0
10a0b7aac: f9002be0    	str	x0, [sp, #0x50]
10a0b7ab0: 900b05e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0b7ab4: f9457500    	ldr	x0, [x8, #0xae8]
10a0b7ab8: d00b0248    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
10a0b7abc: f9402901    	ldr	x1, [x8, #0x50] ; dictionaryWithObjects:forKeys:count:
10a0b7ac0: 910143e2    	add	x2, sp, #0x50
10a0b7ac4: 910123e3    	add	x3, sp, #0x48
10a0b7ac8: 52800024    	mov	w4, #0x1                ; =1
10a0b7acc: 955e8e5e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7ad0: aa1d03fd    	mov	x29, x29
10a0b7ad4: 955e8e5f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b7ad8: aa0003f5    	mov	x21, x0
10a0b7adc: aa1303e0    	mov	x0, x19
10a0b7ae0: 955e8e5f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b7ae4: d00afda8    	adrp	x8, 0x12006d000 <dyld_stub_binder+0x12006d000>
10a0b7ae8: f9447501    	ldr	x1, [x8, #0x8e8] ; shareReporter
10a0b7aec: aa1403e0    	mov	x0, x20
10a0b7af0: 955e8e55    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7af4: aa1d03fd    	mov	x29, x29
10a0b7af8: 955e8e56    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b7afc: aa0003f3    	mov	x19, x0
10a0b7b00: d00afda8    	adrp	x8, 0x12006d000 <dyld_stub_binder+0x12006d000>
10a0b7b04: f9447901    	ldr	x1, [x8, #0x8f0] ; reportCustomWithAction:withCustomInfo:
10a0b7b08: 52800062    	mov	w2, #0x3                ; =3
10a0b7b0c: aa1503e3    	mov	x3, x21
10a0b7b10: 955e8e4d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b7b14: aa1303e0    	mov	x0, x19
10a0b7b18: 955e8e51    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b7b1c: aa1503e0    	mov	x0, x21
10a0b7b20: 955e8e4f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b7b24: aa1403e0    	mov	x0, x20
10a0b7b28: 955e8e4d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b7b2c: f9402fe8    	ldr	x8, [sp, #0x58]
10a0b7b30: 9009a9c9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10a0b7b34: f9405929    	ldr	x9, [x9, #0xb0]
10a0b7b38: f9400129    	ldr	x9, [x9]
10a0b7b3c: eb08013f    	cmp	x9, x8
10a0b7b40: 54000121    	b.ne	0x10a0b7b64 <_Flutter_MMFoundation_BindContext+0x6593748>
10a0b7b44: a94b7bfd    	ldp	x29, x30, [sp, #0xb0]
10a0b7b48: a94a4ff4    	ldp	x20, x19, [sp, #0xa0]
10a0b7b4c: a94957f6    	ldp	x22, x21, [sp, #0x90]
10a0b7b50: a9485ff8    	ldp	x24, x23, [sp, #0x80]
10a0b7b54: a94767fa    	ldp	x26, x25, [sp, #0x70]
10a0b7b58: a9466ffc    	ldp	x28, x27, [sp, #0x60]
10a0b7b5c: 910303ff    	add	sp, sp, #0xc0
10a0b7b60: d65f03c0    	ret
10a0b7b64: 955e8e46    	bl	0x10f85b47c <_UR_96F1_B25D+0x3a640ec>
