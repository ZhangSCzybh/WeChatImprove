
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106e79444: d10283ff    	sub	sp, sp, #0xa0
106e79448: 6d0323e9    	stp	d9, d8, [sp, #0x30]
106e7944c: a9046ffc    	stp	x28, x27, [sp, #0x40]
106e79450: a90567fa    	stp	x26, x25, [sp, #0x50]
106e79454: a9065ff8    	stp	x24, x23, [sp, #0x60]
106e79458: a90757f6    	stp	x22, x21, [sp, #0x70]
106e7945c: a9084ff4    	stp	x20, x19, [sp, #0x80]
106e79460: a9097bfd    	stp	x29, x30, [sp, #0x90]
106e79464: 910243fd    	add	x29, sp, #0x90
106e79468: aa0003fb    	mov	x27, x0
106e7946c: b00cee68    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
106e79470: 52800029    	mov	w9, #0x1                ; =1
106e79474: 3919c509    	strb	w9, [x8, #0x671]
106e79478: 900c8c28    	adrp	x8, 0x11fffd000 <dyld_stub_binder+0x11fffd000>
106e7947c: f947cd01    	ldr	x1, [x8, #0xf98] ; isSpringStyle
106e79480: 9436b72f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e79484: d00c97dc    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
106e79488: f00c97da    	adrp	x26, 0x120174000 <dyld_stub_binder+0x120174000>
106e7948c: 34000640    	cbz	w0, 0x106e79554 <_Flutter_MMFoundation_BindContext+0x3355138>
106e79490: f90017fb    	str	x27, [sp, #0x28]
106e79494: d00c97d8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
106e79498: f9463308    	ldr	x8, [x24, #0xc60]
106e7949c: f90003e8    	str	x8, [sp]
106e794a0: f945eb80    	ldr	x0, [x28, #0xbd0]
106e794a4: f00c9428    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106e794a8: f944e913    	ldr	x19, [x8, #0x9d0] ; currentContext
106e794ac: aa1303e1    	mov	x1, x19
106e794b0: 9436b723    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e794b4: aa1d03fd    	mov	x29, x29
106e794b8: 9436b724    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e794bc: aa0003f4    	mov	x20, x0
106e794c0: f9404340    	ldr	x0, [x26, #0x80]
106e794c4: d00c9428    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106e794c8: f947ad15    	ldr	x21, [x8, #0xf58] ; class
106e794cc: aa1503e1    	mov	x1, x21
106e794d0: 9436b71b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e794d4: aa0003e2    	mov	x2, x0
106e794d8: 900c7e08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e794dc: f9464116    	ldr	x22, [x8, #0xc80] ; getService:
106e794e0: f9000ff4    	str	x20, [sp, #0x18]
106e794e4: aa1403e0    	mov	x0, x20
106e794e8: aa1603e1    	mov	x1, x22
106e794ec: 9436b714    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e794f0: aa1d03fd    	mov	x29, x29
106e794f4: 9436b715    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e794f8: f00c7e08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e794fc: f9400517    	ldr	x23, [x8, #0x8] ; colorList
106e79500: f9000be0    	str	x0, [sp, #0x10]
106e79504: aa1703e1    	mov	x1, x23
106e79508: 9436b70d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e7950c: aa1d03fd    	mov	x29, x29
106e79510: 9436b70e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e79514: f00c7e08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e79518: f9400919    	ldr	x25, [x8, #0x10] ; getColorByName:
106e7951c: f00bd382    	adrp	x2, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
106e79520: 9110a042    	add	x2, x2, #0x428
106e79524: f90007e0    	str	x0, [sp, #0x8]
106e79528: aa1903e1    	mov	x1, x25
106e7952c: 9436b704    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e79530: aa1d03fd    	mov	x29, x29
106e79534: 9436b705    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e79538: aa0003fb    	mov	x27, x0
106e7953c: 9436b6ff    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e79540: b4000280    	cbz	x0, 0x106e79590 <_Flutter_MMFoundation_BindContext+0x3355174>
106e79544: aa1b03e0    	mov	x0, x27
106e79548: 9436b6fc    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e7954c: aa1b03fc    	mov	x28, x27
106e79550: 14000017    	b	0x106e795ac <_Flutter_MMFoundation_BindContext+0x3355190>
106e79554: d00c97c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e79558: f9462d00    	ldr	x0, [x8, #0xc58]
106e7955c: 900c7e08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e79560: f9464901    	ldr	x1, [x8, #0xc90] ; Link_100
106e79564: 9436b6f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e79568: aa1d03fd    	mov	x29, x29
106e7956c: 9436b6f7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e79570: aa0003f8    	mov	x24, x0
106e79574: f00c9428    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106e79578: f944e914    	ldr	x20, [x8, #0x9d0] ; currentContext
106e7957c: d00c9428    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106e79580: f947ad15    	ldr	x21, [x8, #0xf58] ; class
106e79584: 900c7e08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e79588: f9464116    	ldr	x22, [x8, #0xc80] ; getService:
106e7958c: 14000058    	b	0x106e796ec <_Flutter_MMFoundation_BindContext+0x33552d0>
106e79590: f9463300    	ldr	x0, [x24, #0xc60]
106e79594: d00c9428    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106e79598: f947dd01    	ldr	x1, [x8, #0xfb8] ; clearColor
106e7959c: 9436b6e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e795a0: aa1d03fd    	mov	x29, x29
106e795a4: 9436b6e9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e795a8: aa0003fc    	mov	x28, x0
106e795ac: aa1b03e0    	mov	x0, x27
106e795b0: 9436b6e9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e795b4: d00c97c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e795b8: f945e900    	ldr	x0, [x8, #0xbd0]
106e795bc: f90013f3    	str	x19, [sp, #0x20]
106e795c0: aa1303e1    	mov	x1, x19
106e795c4: 9436b6de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e795c8: aa1d03fd    	mov	x29, x29
106e795cc: 9436b6df    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e795d0: aa0003f4    	mov	x20, x0
106e795d4: f9404340    	ldr	x0, [x26, #0x80]
106e795d8: aa1503e1    	mov	x1, x21
106e795dc: 9436b6d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e795e0: aa0003e2    	mov	x2, x0
106e795e4: aa1403e0    	mov	x0, x20
106e795e8: aa1603e1    	mov	x1, x22
106e795ec: 9436b6d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e795f0: aa1d03fd    	mov	x29, x29
106e795f4: 9436b6d5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e795f8: aa0003f3    	mov	x19, x0
106e795fc: aa1703e1    	mov	x1, x23
106e79600: 9436b6cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e79604: aa1d03fd    	mov	x29, x29
106e79608: 9436b6d0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e7960c: aa0003fa    	mov	x26, x0
106e79610: f00bd382    	adrp	x2, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
106e79614: 91112042    	add	x2, x2, #0x448
106e79618: aa1903e1    	mov	x1, x25
106e7961c: 9436b6c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e79620: aa1d03fd    	mov	x29, x29
106e79624: 9436b6c9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e79628: aa0003f9    	mov	x25, x0
106e7962c: 9436b6c3    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e79630: b40000a0    	cbz	x0, 0x106e79644 <_Flutter_MMFoundation_BindContext+0x3355228>
106e79634: aa1903e0    	mov	x0, x25
106e79638: 9436b6c0    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e7963c: aa1903f7    	mov	x23, x25
106e79640: 14000009    	b	0x106e79664 <_Flutter_MMFoundation_BindContext+0x3355248>
106e79644: d00c97c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e79648: f9463100    	ldr	x0, [x8, #0xc60]
106e7964c: d00c9428    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106e79650: f947dd01    	ldr	x1, [x8, #0xfb8] ; clearColor
106e79654: 9436b6ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e79658: aa1d03fd    	mov	x29, x29
106e7965c: 9436b6bb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e79660: aa0003f7    	mov	x23, x0
106e79664: aa1903e0    	mov	x0, x25
106e79668: 9436b6bb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e7966c: d00c7e28    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
106e79670: f946bd01    	ldr	x1, [x8, #0xd78] ; colorInLightMode:DarkMode:
106e79674: f94003e0    	ldr	x0, [sp]
106e79678: aa1c03e2    	mov	x2, x28
106e7967c: aa1703e3    	mov	x3, x23
106e79680: 9436b6af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e79684: aa1d03fd    	mov	x29, x29
106e79688: 9436b6b0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e7968c: aa0003f8    	mov	x24, x0
106e79690: aa1703e0    	mov	x0, x23
106e79694: 9436b6b0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e79698: aa1903e0    	mov	x0, x25
106e7969c: 9436b6ae    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e796a0: aa1a03e0    	mov	x0, x26
106e796a4: 9436b6ac    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e796a8: aa1303e0    	mov	x0, x19
106e796ac: 9436b6aa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e796b0: aa1403e0    	mov	x0, x20
106e796b4: 9436b6a8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e796b8: aa1c03e0    	mov	x0, x28
106e796bc: 9436b6a6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e796c0: aa1b03e0    	mov	x0, x27
106e796c4: 9436b6a4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e796c8: f94007e0    	ldr	x0, [sp, #0x8]
106e796cc: 9436b6a2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e796d0: f9400be0    	ldr	x0, [sp, #0x10]
106e796d4: 9436b6a0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e796d8: f9400fe0    	ldr	x0, [sp, #0x18]
106e796dc: 9436b69e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e796e0: a9426ff4    	ldp	x20, x27, [sp, #0x20]
106e796e4: d00c97dc    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
106e796e8: f00c97da    	adrp	x26, 0x120174000 <dyld_stub_binder+0x120174000>
106e796ec: f945eb80    	ldr	x0, [x28, #0xbd0]
106e796f0: aa1403e1    	mov	x1, x20
106e796f4: 9436b692    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e796f8: aa1d03fd    	mov	x29, x29
106e796fc: 9436b693    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e79700: aa0003f9    	mov	x25, x0
106e79704: f9404340    	ldr	x0, [x26, #0x80]
106e79708: aa1503e1    	mov	x1, x21
106e7970c: 9436b68c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e79710: aa0003e2    	mov	x2, x0
106e79714: aa1903e0    	mov	x0, x25
106e79718: aa1603e1    	mov	x1, x22
106e7971c: 9436b688    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e79720: aa1d03fd    	mov	x29, x29
106e79724: 9436b689    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e79728: aa0003f7    	mov	x23, x0
106e7972c: d00c97da    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
106e79730: f9461b40    	ldr	x0, [x26, #0xc30]
106e79734: d00c8328    	adrp	x8, 0x11fedf000 <dyld_stub_binder+0x11fedf000>
106e79738: f944cd13    	ldr	x19, [x8, #0x998] ; dynamicLength:forModule:
106e7973c: 1e661000    	fmov	d0, #16.00000000
106e79740: aa1303e1    	mov	x1, x19
106e79744: 52800022    	mov	w2, #0x1                ; =1
106e79748: 9436b67d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e7974c: 1e604008    	fmov	d8, d0
106e79750: f9461b40    	ldr	x0, [x26, #0xc30]
106e79754: 1e661000    	fmov	d0, #16.00000000
106e79758: aa1303e1    	mov	x1, x19
106e7975c: 52800022    	mov	w2, #0x1                ; =1
106e79760: 9436b677    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e79764: 1e604001    	fmov	d1, d0
106e79768: f00c7e08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e7976c: f9437901    	ldr	x1, [x8, #0x6f0] ; svgImageNamed:size:color:
106e79770: d00bcac2    	adrp	x2, 0x11e7d3000 <dyld_stub_binder+0x11e7d3000>
106e79774: 91222042    	add	x2, x2, #0x888
106e79778: aa1703e0    	mov	x0, x23
106e7977c: 1e604100    	fmov	d0, d8
106e79780: f90017f8    	str	x24, [sp, #0x28]
106e79784: aa1803e3    	mov	x3, x24
106e79788: 9436b66d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e7978c: aa1d03fd    	mov	x29, x29
106e79790: 9436b66e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e79794: aa0003f8    	mov	x24, x0
106e79798: aa1703e0    	mov	x0, x23
106e7979c: 9436b66e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e797a0: aa1903e0    	mov	x0, x25
106e797a4: 9436b66c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e797a8: f00c97c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106e797ac: f9435900    	ldr	x0, [x8, #0x6b0]
106e797b0: 9436b66c    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106e797b4: aa0003f7    	mov	x23, x0
106e797b8: f9461b40    	ldr	x0, [x26, #0xc30]
106e797bc: 1e661000    	fmov	d0, #16.00000000
106e797c0: aa1303e1    	mov	x1, x19
106e797c4: 52800022    	mov	w2, #0x1                ; =1
106e797c8: 9436b65d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e797cc: 1e604008    	fmov	d8, d0
106e797d0: f9461b40    	ldr	x0, [x26, #0xc30]
106e797d4: 1e661000    	fmov	d0, #16.00000000
106e797d8: aa1303e1    	mov	x1, x19
106e797dc: 52800022    	mov	w2, #0x1                ; =1
106e797e0: 9436b657    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e797e4: 1e604003    	fmov	d3, d0
106e797e8: b00c9448    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106e797ec: f947d901    	ldr	x1, [x8, #0xfb0] ; initWithFrame:
106e797f0: 9e6703e0    	fmov	d0, xzr
106e797f4: 9e6703e1    	fmov	d1, xzr
106e797f8: aa1703e0    	mov	x0, x23
106e797fc: 1e604102    	fmov	d2, d8
106e79800: 9436b64f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e79804: aa0003f9    	mov	x25, x0
106e79808: f00c9468    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
106e7980c: f9418101    	ldr	x1, [x8, #0x300] ; setImage:forState:
106e79810: aa1803e2    	mov	x2, x24
106e79814: d2800003    	mov	x3, #0x0                ; =0
106e79818: 9436b649    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e7981c: 900c9e68    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e79820: b9844d08    	ldrsw	x8, [x8, #0x44c]
106e79824: f8686b60    	ldr	x0, [x27, x8]
106e79828: f00c7e08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e7982c: f9471101    	ldr	x1, [x8, #0xe20] ; username
106e79830: 9436b643    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e79834: aa1d03fd    	mov	x29, x29
106e79838: 9436b644    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e7983c: aa0003f3    	mov	x19, x0
106e79840: d00c97c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e79844: f9471100    	ldr	x0, [x8, #0xe20]
106e79848: 900c7e28    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
106e7984c: f9459901    	ldr	x1, [x8, #0xb30] ; getCurUsrName
106e79850: 9436b63b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e79854: aa1d03fd    	mov	x29, x29
106e79858: 9436b63c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e7985c: aa0003f7    	mov	x23, x0
106e79860: d00c9448    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106e79864: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
106e79868: aa1303e0    	mov	x0, x19
106e7986c: aa1703e2    	mov	x2, x23
106e79870: 9436b633    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e79874: aa0003fa    	mov	x26, x0
106e79878: aa1703e0    	mov	x0, x23
106e7987c: 9436b636    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e79880: aa1303e0    	mov	x0, x19
106e79884: 9436b634    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e79888: 3400013a    	cbz	w26, 0x106e798ac <_Flutter_MMFoundation_BindContext+0x3355490>
106e7988c: b00c8c28    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e79890: f9405103    	ldr	x3, [x8, #0xa0] ; onShowGroup
106e79894: b00c9428    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
106e79898: f9477101    	ldr	x1, [x8, #0xee0] ; addTarget:action:forControlEvents:
106e7989c: aa1903e0    	mov	x0, x25
106e798a0: aa1b03e2    	mov	x2, x27
106e798a4: 52800804    	mov	w4, #0x40               ; =64
106e798a8: 9436b625    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e798ac: f945eb80    	ldr	x0, [x28, #0xbd0]
106e798b0: aa1403e1    	mov	x1, x20
106e798b4: 9436b622    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e798b8: aa1d03fd    	mov	x29, x29
106e798bc: 9436b623    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e798c0: aa0003f3    	mov	x19, x0
106e798c4: d00c97c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e798c8: f9462900    	ldr	x0, [x8, #0xc50]
106e798cc: aa1503e1    	mov	x1, x21
106e798d0: 9436b61b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e798d4: aa0003e2    	mov	x2, x0
106e798d8: aa1303e0    	mov	x0, x19
106e798dc: aa1603e1    	mov	x1, x22
106e798e0: 9436b617    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e798e4: aa1d03fd    	mov	x29, x29
106e798e8: 9436b618    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e798ec: aa0003f4    	mov	x20, x0
106e798f0: 900c7e08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e798f4: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
106e798f8: b00bce62    	adrp	x2, 0x11e846000 <dyld_stub_binder+0x11e846000>
106e798fc: 91082042    	add	x2, x2, #0x208
106e79900: 9436b60f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e79904: aa1d03fd    	mov	x29, x29
106e79908: 9436b610    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e7990c: aa0003f5    	mov	x21, x0
106e79910: b00c9468    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
106e79914: f946bd01    	ldr	x1, [x8, #0xd78] ; setAccessibilityLabel:
106e79918: aa1903e0    	mov	x0, x25
106e7991c: aa1503e2    	mov	x2, x21
106e79920: 9436b607    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e79924: aa1503e0    	mov	x0, x21
106e79928: 9436b60b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e7992c: aa1403e0    	mov	x0, x20
106e79930: 9436b609    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e79934: aa1303e0    	mov	x0, x19
106e79938: 9436b607    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e7993c: f00c7e68    	adrp	x8, 0x11fe48000 <dyld_stub_binder+0x11fe48000>
106e79940: f941bd01    	ldr	x1, [x8, #0x378] ; setTouchInsets:
106e79944: 1e641000    	fmov	d0, #8.00000000
106e79948: 1e621001    	fmov	d1, #4.00000000
106e7994c: 1e641002    	fmov	d2, #8.00000000
106e79950: 1e621003    	fmov	d3, #4.00000000
106e79954: aa1903e0    	mov	x0, x25
106e79958: 9436b5f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e7995c: aa1803e0    	mov	x0, x24
106e79960: 9436b5fd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e79964: f94017e0    	ldr	x0, [sp, #0x28]
106e79968: 9436b5fb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e7996c: aa1903e0    	mov	x0, x25
106e79970: a9497bfd    	ldp	x29, x30, [sp, #0x90]
106e79974: a9484ff4    	ldp	x20, x19, [sp, #0x80]
106e79978: a94757f6    	ldp	x22, x21, [sp, #0x70]
106e7997c: a9465ff8    	ldp	x24, x23, [sp, #0x60]
106e79980: a94567fa    	ldp	x26, x25, [sp, #0x50]
106e79984: a9446ffc    	ldp	x28, x27, [sp, #0x40]
106e79988: 6d4323e9    	ldp	d9, d8, [sp, #0x30]
106e7998c: 910283ff    	add	sp, sp, #0xa0
106e79990: 1436b5f8    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
