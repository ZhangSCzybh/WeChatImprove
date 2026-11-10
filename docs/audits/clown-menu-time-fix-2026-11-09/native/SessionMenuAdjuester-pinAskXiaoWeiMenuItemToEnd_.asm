
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105ae1544: d10503ff    	sub	sp, sp, #0x140
105ae1548: a90e6ffc    	stp	x28, x27, [sp, #0xe0]
105ae154c: a90f67fa    	stp	x26, x25, [sp, #0xf0]
105ae1550: a9105ff8    	stp	x24, x23, [sp, #0x100]
105ae1554: a91157f6    	stp	x22, x21, [sp, #0x110]
105ae1558: a9124ff4    	stp	x20, x19, [sp, #0x120]
105ae155c: a9137bfd    	stp	x29, x30, [sp, #0x130]
105ae1560: 9104c3fd    	add	x29, sp, #0x130
105ae1564: aa0203f3    	mov	x19, x2
105ae1568: f00be348    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
105ae156c: f9451908    	ldr	x8, [x8, #0xa30]
105ae1570: f9400108    	ldr	x8, [x8]
105ae1574: f81a03a8    	stur	x8, [x29, #-0x60]
105ae1578: f00ce388    	adrp	x8, 0x11f754000 <dyld_stub_binder+0x11f754000>
105ae157c: 52800029    	mov	w9, #0x1                ; =1
105ae1580: 3932b509    	strb	w9, [x8, #0xcad]
105ae1584: aa0203e0    	mov	x0, x2
105ae1588: 948519bb    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105ae158c: b00c9188    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105ae1590: f943c100    	ldr	x0, [x8, #0x780]
105ae1594: 900c7748    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105ae1598: f9440101    	ldr	x1, [x8, #0x800]
105ae159c: 948519b2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae15a0: aa1d03fd    	mov	x29, x29
105ae15a4: 948519b7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae15a8: aa0003f4    	mov	x20, x0
105ae15ac: b00c9188    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105ae15b0: f9444900    	ldr	x0, [x8, #0x890]
105ae15b4: b00c8e28    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105ae15b8: f9428515    	ldr	x21, [x8, #0x508]
105ae15bc: aa1503e1    	mov	x1, x21
105ae15c0: 948519a9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae15c4: aa0003e2    	mov	x2, x0
105ae15c8: 900c7748    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105ae15cc: f9452101    	ldr	x1, [x8, #0xa40]
105ae15d0: aa1403e0    	mov	x0, x20
105ae15d4: 948519a4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae15d8: aa1d03fd    	mov	x29, x29
105ae15dc: 948519a9    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae15e0: aa0003f6    	mov	x22, x0
105ae15e4: 900c7748    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105ae15e8: f9472501    	ldr	x1, [x8, #0xe48]
105ae15ec: f00bc282    	adrp	x2, 0x11d334000 <dyld_stub_binder+0x11d334000>
105ae15f0: 9137e042    	add	x2, x2, #0xdf8
105ae15f4: 52800003    	mov	w3, #0x0                ; =0
105ae15f8: 9485199b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae15fc: aa0003f7    	mov	x23, x0
105ae1600: aa1603e0    	mov	x0, x22
105ae1604: 9485199b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae1608: aa1403e0    	mov	x0, x20
105ae160c: 94851999    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae1610: 36000c77    	tbz	w23, #0x0, 0x105ae179c <_Flutter_MMFoundation_BindContext+0x1d68468>
105ae1614: b00c9188    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105ae1618: f9432d00    	ldr	x0, [x8, #0x658]
105ae161c: 900c8e28    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
105ae1620: f946c501    	ldr	x1, [x8, #0xd88]
105ae1624: 94851990    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae1628: aa1d03fd    	mov	x29, x29
105ae162c: 94851995    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae1630: f90007e0    	str	x0, [sp, #0x8]
105ae1634: 4f00e400    	movi.16b	v0, #0x0
105ae1638: ad0083e0    	stp	q0, q0, [sp, #0x10]
105ae163c: ad0183e0    	stp	q0, q0, [sp, #0x30]
105ae1640: aa1303e0    	mov	x0, x19
105ae1644: 9485198c    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105ae1648: b00c8e28    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105ae164c: f9442d01    	ldr	x1, [x8, #0x858]
105ae1650: 910043e2    	add	x2, sp, #0x10
105ae1654: 910143e3    	add	x3, sp, #0x50
105ae1658: f90003e1    	str	x1, [sp]
105ae165c: 52800204    	mov	w4, #0x10               ; =16
105ae1660: 94851981    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae1664: b4000600    	cbz	x0, 0x105ae1724 <_Flutter_MMFoundation_BindContext+0x1d683f0>
105ae1668: aa0003f7    	mov	x23, x0
105ae166c: f94013e8    	ldr	x8, [sp, #0x20]
105ae1670: f940011c    	ldr	x28, [x8]
105ae1674: d00c9196    	adrp	x22, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
105ae1678: d2800014    	mov	x20, #0x0               ; =0
105ae167c: f00c8e28    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
105ae1680: f9444918    	ldr	x24, [x8, #0x890]
105ae1684: d00c7768    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
105ae1688: f9439519    	ldr	x25, [x8, #0x728]
105ae168c: 900c8e28    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
105ae1690: f9451d1a    	ldr	x26, [x8, #0xa38]
105ae1694: f94013e8    	ldr	x8, [sp, #0x20]
105ae1698: f9400108    	ldr	x8, [x8]
105ae169c: eb1c011f    	cmp	x8, x28
105ae16a0: 54000060    	b.eq	0x105ae16ac <_Flutter_MMFoundation_BindContext+0x1d68378>
105ae16a4: aa1303e0    	mov	x0, x19
105ae16a8: 94851965    	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
105ae16ac: f9400fe8    	ldr	x8, [sp, #0x18]
105ae16b0: f874791b    	ldr	x27, [x8, x20, lsl #3]
105ae16b4: f9431ec0    	ldr	x0, [x22, #0x638]
105ae16b8: aa1503e1    	mov	x1, x21
105ae16bc: 9485196a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae16c0: aa0003e2    	mov	x2, x0
105ae16c4: aa1b03e0    	mov	x0, x27
105ae16c8: aa1803e1    	mov	x1, x24
105ae16cc: 94851966    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae16d0: 34000140    	cbz	w0, 0x105ae16f8 <_Flutter_MMFoundation_BindContext+0x1d683c4>
105ae16d4: aa1b03e0    	mov	x0, x27
105ae16d8: aa1903e1    	mov	x1, x25
105ae16dc: 94851962    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae16e0: f100d81f    	cmp	x0, #0x36
105ae16e4: 540000a1    	b.ne	0x105ae16f8 <_Flutter_MMFoundation_BindContext+0x1d683c4>
105ae16e8: f94007e0    	ldr	x0, [sp, #0x8]
105ae16ec: aa1a03e1    	mov	x1, x26
105ae16f0: aa1b03e2    	mov	x2, x27
105ae16f4: 9485195c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae16f8: 91000694    	add	x20, x20, #0x1
105ae16fc: eb1402ff    	cmp	x23, x20
105ae1700: 54fffca1    	b.ne	0x105ae1694 <_Flutter_MMFoundation_BindContext+0x1d68360>
105ae1704: 910043e2    	add	x2, sp, #0x10
105ae1708: 910143e3    	add	x3, sp, #0x50
105ae170c: aa1303e0    	mov	x0, x19
105ae1710: f94003e1    	ldr	x1, [sp]
105ae1714: 52800204    	mov	w4, #0x10               ; =16
105ae1718: 94851953    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae171c: aa0003f7    	mov	x23, x0
105ae1720: b5fffac0    	cbnz	x0, 0x105ae1678 <_Flutter_MMFoundation_BindContext+0x1d68344>
105ae1724: aa1303e0    	mov	x0, x19
105ae1728: 94851952    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae172c: b00c8e28    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105ae1730: f9442901    	ldr	x1, [x8, #0x850]
105ae1734: f94007f4    	ldr	x20, [sp, #0x8]
105ae1738: aa1403e0    	mov	x0, x20
105ae173c: 9485194a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae1740: b4000360    	cbz	x0, 0x105ae17ac <_Flutter_MMFoundation_BindContext+0x1d68478>
105ae1744: 900c8e48    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
105ae1748: f9418d01    	ldr	x1, [x8, #0x318]
105ae174c: aa1303e0    	mov	x0, x19
105ae1750: 94851945    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae1754: aa0003f6    	mov	x22, x0
105ae1758: b00c8e48    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
105ae175c: f9427901    	ldr	x1, [x8, #0x4f0]
105ae1760: aa1403e2    	mov	x2, x20
105ae1764: 94851940    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae1768: 900c8e28    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
105ae176c: f9452101    	ldr	x1, [x8, #0xa40]
105ae1770: aa1603e0    	mov	x0, x22
105ae1774: aa1403e2    	mov	x2, x20
105ae1778: 9485193b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae177c: b00c8e28    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105ae1780: f9440d01    	ldr	x1, [x8, #0x818]
105ae1784: aa1603e0    	mov	x0, x22
105ae1788: 94851937    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae178c: aa0003f5    	mov	x21, x0
105ae1790: aa1603e0    	mov	x0, x22
105ae1794: 94851937    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae1798: 14000008    	b	0x105ae17b8 <_Flutter_MMFoundation_BindContext+0x1d68484>
105ae179c: aa1303e0    	mov	x0, x19
105ae17a0: 94851935    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105ae17a4: aa1303f5    	mov	x21, x19
105ae17a8: 14000006    	b	0x105ae17c0 <_Flutter_MMFoundation_BindContext+0x1d6848c>
105ae17ac: aa1303e0    	mov	x0, x19
105ae17b0: 94851931    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105ae17b4: aa1303f5    	mov	x21, x19
105ae17b8: aa1403e0    	mov	x0, x20
105ae17bc: 9485192d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae17c0: aa1303e0    	mov	x0, x19
105ae17c4: 9485192b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae17c8: f85a03a8    	ldur	x8, [x29, #-0x60]
105ae17cc: f00be349    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
105ae17d0: f9451929    	ldr	x9, [x9, #0xa30]
105ae17d4: f9400129    	ldr	x9, [x9]
105ae17d8: eb08013f    	cmp	x9, x8
105ae17dc: 54000141    	b.ne	0x105ae1804 <_Flutter_MMFoundation_BindContext+0x1d684d0>
105ae17e0: aa1503e0    	mov	x0, x21
105ae17e4: a9537bfd    	ldp	x29, x30, [sp, #0x130]
105ae17e8: a9524ff4    	ldp	x20, x19, [sp, #0x120]
105ae17ec: a95157f6    	ldp	x22, x21, [sp, #0x110]
105ae17f0: a9505ff8    	ldp	x24, x23, [sp, #0x100]
105ae17f4: a94f67fa    	ldp	x26, x25, [sp, #0xf0]
105ae17f8: a94e6ffc    	ldp	x28, x27, [sp, #0xe0]
105ae17fc: 910503ff    	add	sp, sp, #0x140
105ae1800: 14851908    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
105ae1804: 948517cb    	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
