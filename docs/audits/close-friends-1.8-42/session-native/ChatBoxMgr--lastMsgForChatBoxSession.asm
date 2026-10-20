
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e4942c: d105c3ff    	sub	sp, sp, #0x170
100e49430: a9116ffc    	stp	x28, x27, [sp, #0x110]
100e49434: a91267fa    	stp	x26, x25, [sp, #0x120]
100e49438: a9135ff8    	stp	x24, x23, [sp, #0x130]
100e4943c: a91457f6    	stp	x22, x21, [sp, #0x140]
100e49440: a9154ff4    	stp	x20, x19, [sp, #0x150]
100e49444: a9167bfd    	stp	x29, x30, [sp, #0x160]
100e49448: 910583fd    	add	x29, sp, #0x160
100e4944c: d00e3d28    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
100e49450: f9405908    	ldr	x8, [x8, #0xb0]
100e49454: f9400108    	ldr	x8, [x8]
100e49458: f81a03a8    	stur	x8, [x29, #-0x60]
100e4945c: f00fef28    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100e49460: 52800029    	mov	w9, #0x1                ; =1
100e49464: 39188109    	strb	w9, [x8, #0x620]
100e49468: 4f00e400    	movi.16b	v0, #0x0
100e4946c: ad0203e0    	stp	q0, q0, [sp, #0x40]
100e49470: ad0303e0    	stp	q0, q0, [sp, #0x60]
100e49474: f00f81a8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e49478: f9433901    	ldr	x1, [x8, #0x670] ; chatBoxSessions
100e4947c: 95b77730    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49480: aa1d03fd    	mov	x29, x29
100e49484: 95b77731    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e49488: f00f95a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e4948c: f9435513    	ldr	x19, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
100e49490: 910103e2    	add	x2, sp, #0x40
100e49494: 910203e3    	add	x3, sp, #0x80
100e49498: f9000be0    	str	x0, [sp, #0x10]
100e4949c: aa1303e1    	mov	x1, x19
100e494a0: 52800204    	mov	w4, #0x10               ; =16
100e494a4: 95b77726    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e494a8: f90013e0    	str	x0, [sp, #0x20]
100e494ac: b4000f60    	cbz	x0, 0x100e49698 <__text+0xe41698>
100e494b0: f9402be8    	ldr	x8, [sp, #0x50]
100e494b4: 900f7fe9    	adrp	x9, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
100e494b8: b00f7faa    	adrp	x10, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
100e494bc: d00f95cb    	adrp	x11, 0x120103000 <dyld_stub_binder+0x120103000>
100e494c0: f00f95ac    	adrp	x12, 0x120100000 <dyld_stub_binder+0x120100000>
100e494c4: f9400108    	ldr	x8, [x8]
100e494c8: f9000fe8    	str	x8, [sp, #0x18]
100e494cc: d00f95ad    	adrp	x13, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100e494d0: 900f7f8e    	adrp	x14, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e494d4: f00f7fcf    	adrp	x15, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
100e494d8: f00f7fb0    	adrp	x16, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
100e494dc: f90007f3    	str	x19, [sp, #0x8]
100e494e0: d2800018    	mov	x24, #0x0               ; =0
100e494e4: f944c539    	ldr	x25, [x9, #0x988] ; m_msgWrap
100e494e8: f941715a    	ldr	x26, [x10, #0x2e0] ; m_nsContent
100e494ec: f946e97b    	ldr	x27, [x11, #0xdd0] ; length
100e494f0: f944e989    	ldr	x9, [x12, #0x9d0] ; currentContext
100e494f4: f947ada8    	ldr	x8, [x13, #0xf58] ; class
100e494f8: a902a3e9    	stp	x9, x8, [sp, #0x28]
100e494fc: f94641c8    	ldr	x8, [x14, #0xc80] ; getService:
100e49500: f9001fe8    	str	x8, [sp, #0x38]
100e49504: f947d9fc    	ldr	x28, [x15, #0xfb0] ; m_nsUserName
100e49508: f9472217    	ldr	x23, [x16, #0xe40] ; GetLastMsg:
100e4950c: f9402be8    	ldr	x8, [sp, #0x50]
100e49510: f9400108    	ldr	x8, [x8]
100e49514: f9400fe9    	ldr	x9, [sp, #0x18]
100e49518: eb09011f    	cmp	x8, x9
100e4951c: 54000060    	b.eq	0x100e49528 <__text+0xe41528>
100e49520: f9400be0    	ldr	x0, [sp, #0x10]
100e49524: 95b7770b    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
100e49528: f94027e8    	ldr	x8, [sp, #0x48]
100e4952c: f8787913    	ldr	x19, [x8, x24, lsl #3]
100e49530: aa1303e0    	mov	x0, x19
100e49534: aa1903e1    	mov	x1, x25
100e49538: 95b77701    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4953c: aa1d03fd    	mov	x29, x29
100e49540: 95b77702    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e49544: aa0003f4    	mov	x20, x0
100e49548: aa1a03e1    	mov	x1, x26
100e4954c: 95b776fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49550: aa1d03fd    	mov	x29, x29
100e49554: 95b776fd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e49558: aa0003f5    	mov	x21, x0
100e4955c: aa1b03e1    	mov	x1, x27
100e49560: 95b776f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49564: aa0003f6    	mov	x22, x0
100e49568: aa1503e0    	mov	x0, x21
100e4956c: 95b776fa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e49570: aa1403e0    	mov	x0, x20
100e49574: 95b776f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e49578: b5000a76    	cbnz	x22, 0x100e496c4 <__text+0xe416c4>
100e4957c: d00f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e49580: f945e900    	ldr	x0, [x8, #0xbd0]
100e49584: f94017e1    	ldr	x1, [sp, #0x28]
100e49588: 95b776ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4958c: aa1d03fd    	mov	x29, x29
100e49590: 95b776ee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e49594: aa0003f4    	mov	x20, x0
100e49598: f00f9948    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100e4959c: f9403100    	ldr	x0, [x8, #0x60]
100e495a0: f9401be1    	ldr	x1, [sp, #0x30]
100e495a4: 95b776e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e495a8: aa0003e2    	mov	x2, x0
100e495ac: aa1403e0    	mov	x0, x20
100e495b0: f9401fe1    	ldr	x1, [sp, #0x38]
100e495b4: 95b776e2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e495b8: aa1d03fd    	mov	x29, x29
100e495bc: 95b776e3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e495c0: aa0003f5    	mov	x21, x0
100e495c4: aa1303e0    	mov	x0, x19
100e495c8: aa1c03e1    	mov	x1, x28
100e495cc: 95b776dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e495d0: aa1d03fd    	mov	x29, x29
100e495d4: 95b776dd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e495d8: aa0003f6    	mov	x22, x0
100e495dc: aa1503e0    	mov	x0, x21
100e495e0: aa1703e1    	mov	x1, x23
100e495e4: aa1603e2    	mov	x2, x22
100e495e8: 95b776d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e495ec: aa1d03fd    	mov	x29, x29
100e495f0: 95b776d6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e495f4: aa0003f3    	mov	x19, x0
100e495f8: aa1603e0    	mov	x0, x22
100e495fc: 95b776d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e49600: aa1503e0    	mov	x0, x21
100e49604: 95b776d4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e49608: aa1403e0    	mov	x0, x20
100e4960c: 95b776d2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e49610: aa1303e0    	mov	x0, x19
100e49614: aa1a03e1    	mov	x1, x26
100e49618: 95b776c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4961c: aa1d03fd    	mov	x29, x29
100e49620: 95b776ca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e49624: aa0003f4    	mov	x20, x0
100e49628: aa1b03e1    	mov	x1, x27
100e4962c: 95b776c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49630: aa0003f5    	mov	x21, x0
100e49634: aa1403e0    	mov	x0, x20
100e49638: 95b776c7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4963c: b5000515    	cbnz	x21, 0x100e496dc <__text+0xe416dc>
100e49640: aa1303e0    	mov	x0, x19
100e49644: 95b776c4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e49648: 91000718    	add	x24, x24, #0x1
100e4964c: f94013e8    	ldr	x8, [sp, #0x20]
100e49650: eb18011f    	cmp	x8, x24
100e49654: 54fff5c1    	b.ne	0x100e4950c <__text+0xe4150c>
100e49658: 910103e2    	add	x2, sp, #0x40
100e4965c: 910203e3    	add	x3, sp, #0x80
100e49660: a94083e1    	ldp	x1, x0, [sp, #0x8]
100e49664: 52800204    	mov	w4, #0x10               ; =16
100e49668: 95b776b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4966c: 900f7fe9    	adrp	x9, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
100e49670: b00f7faa    	adrp	x10, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
100e49674: d00f95cb    	adrp	x11, 0x120103000 <dyld_stub_binder+0x120103000>
100e49678: f90013e0    	str	x0, [sp, #0x20]
100e4967c: f00f95ac    	adrp	x12, 0x120100000 <dyld_stub_binder+0x120100000>
100e49680: d00f95ad    	adrp	x13, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100e49684: 900f7f8e    	adrp	x14, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e49688: f00f7fcf    	adrp	x15, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
100e4968c: f00f7fb0    	adrp	x16, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
100e49690: b5fff280    	cbnz	x0, 0x100e494e0 <__text+0xe414e0>
100e49694: 14000009    	b	0x100e496b8 <__text+0xe416b8>
100e49698: f00f95a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e4969c: f944e909    	ldr	x9, [x8, #0x9d0] ; currentContext
100e496a0: d00f95a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100e496a4: f947ad08    	ldr	x8, [x8, #0xf58] ; class
100e496a8: a902a3e9    	stp	x9, x8, [sp, #0x28]
100e496ac: 900f7f88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e496b0: f9464108    	ldr	x8, [x8, #0xc80] ; getService:
100e496b4: f9001fe8    	str	x8, [sp, #0x38]
100e496b8: f9400be0    	ldr	x0, [sp, #0x10]
100e496bc: 95b776a6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e496c0: 1400000a    	b	0x100e496e8 <__text+0xe416e8>
100e496c4: aa1303e0    	mov	x0, x19
100e496c8: aa1903e1    	mov	x1, x25
100e496cc: 95b7769c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e496d0: aa1d03fd    	mov	x29, x29
100e496d4: 95b7769d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e496d8: aa0003f3    	mov	x19, x0
100e496dc: f9400be0    	ldr	x0, [sp, #0x10]
100e496e0: 95b7769d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e496e4: b50005d3    	cbnz	x19, 0x100e4979c <__text+0xe4179c>
100e496e8: f00f9948    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100e496ec: f9411d00    	ldr	x0, [x8, #0x238]
100e496f0: 95b7769c    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
100e496f4: f00f7f88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100e496f8: f9452d01    	ldr	x1, [x8, #0xa58] ; initWithMsgType:
100e496fc: 52800022    	mov	w2, #0x1                ; =1
100e49700: 95b7768f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49704: aa0003f3    	mov	x19, x0
100e49708: d00f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e4970c: f945e900    	ldr	x0, [x8, #0xbd0]
100e49710: f94017e1    	ldr	x1, [sp, #0x28]
100e49714: 95b7768a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49718: aa1d03fd    	mov	x29, x29
100e4971c: 95b7768b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e49720: aa0003f4    	mov	x20, x0
100e49724: d00f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e49728: f9462900    	ldr	x0, [x8, #0xc50]
100e4972c: f9401be1    	ldr	x1, [sp, #0x30]
100e49730: 95b77683    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49734: aa0003e2    	mov	x2, x0
100e49738: aa1403e0    	mov	x0, x20
100e4973c: f9401fe1    	ldr	x1, [sp, #0x38]
100e49740: 95b7767f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49744: aa1d03fd    	mov	x29, x29
100e49748: 95b77680    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4974c: aa0003f5    	mov	x21, x0
100e49750: 900f7f88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e49754: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
100e49758: b00eb742    	adrp	x2, 0x11e532000 <dyld_stub_binder+0x11e532000>
100e4975c: 9125a042    	add	x2, x2, #0x968
100e49760: 95b77677    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49764: aa1d03fd    	mov	x29, x29
100e49768: 95b77678    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4976c: aa0003f6    	mov	x22, x0
100e49770: f00f7f88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100e49774: f9453d01    	ldr	x1, [x8, #0xa78] ; setM_nsContent:
100e49778: aa1303e0    	mov	x0, x19
100e4977c: aa1603e2    	mov	x2, x22
100e49780: 95b7766f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49784: aa1603e0    	mov	x0, x22
100e49788: 95b77673    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4978c: aa1503e0    	mov	x0, x21
100e49790: 95b77671    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e49794: aa1403e0    	mov	x0, x20
100e49798: 95b7766f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4979c: f85a03a8    	ldur	x8, [x29, #-0x60]
100e497a0: d00e3d29    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
100e497a4: f9405929    	ldr	x9, [x9, #0xb0]
100e497a8: f9400129    	ldr	x9, [x9]
100e497ac: eb08013f    	cmp	x9, x8
100e497b0: 54000141    	b.ne	0x100e497d8 <__text+0xe417d8>
100e497b4: aa1303e0    	mov	x0, x19
100e497b8: a9567bfd    	ldp	x29, x30, [sp, #0x160]
100e497bc: a9554ff4    	ldp	x20, x19, [sp, #0x150]
100e497c0: a95457f6    	ldp	x22, x21, [sp, #0x140]
100e497c4: a9535ff8    	ldp	x24, x23, [sp, #0x130]
100e497c8: a95267fa    	ldp	x26, x25, [sp, #0x120]
100e497cc: a9516ffc    	ldp	x28, x27, [sp, #0x110]
100e497d0: 9105c3ff    	add	sp, sp, #0x170
100e497d4: 15b77667    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
100e497d8: 95b77667    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
