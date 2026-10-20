
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10627c3d8: d10383ff    	sub	sp, sp, #0xe0
10627c3dc: 6d062beb    	stp	d11, d10, [sp, #0x60]
10627c3e0: 6d0723e9    	stp	d9, d8, [sp, #0x70]
10627c3e4: a9086ffc    	stp	x28, x27, [sp, #0x80]
10627c3e8: a90967fa    	stp	x26, x25, [sp, #0x90]
10627c3ec: a90a5ff8    	stp	x24, x23, [sp, #0xa0]
10627c3f0: a90b57f6    	stp	x22, x21, [sp, #0xb0]
10627c3f4: a90c4ff4    	stp	x20, x19, [sp, #0xc0]
10627c3f8: a90d7bfd    	stp	x29, x30, [sp, #0xd0]
10627c3fc: 910343fd    	add	x29, sp, #0xd0
10627c400: f9002fe0    	str	x0, [sp, #0x58]
10627c404: f00d4e28    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
10627c408: 52800029    	mov	w9, #0x1                ; =1
10627c40c: 3927f109    	strb	w9, [x8, #0x9fc]
10627c410: f00ceaa8    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10627c414: f946b101    	ldr	x1, [x8, #0xd60] ; createTranslateTextLabel
10627c418: 9466ab49    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c41c: aa1d03fd    	mov	x29, x29
10627c420: 9466ab4a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c424: 900cde28    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
10627c428: f9417101    	ldr	x1, [x8, #0x2e0] ; setContent:
10627c42c: f00c2a62    	adrp	x2, 0x11e7cb000 <dyld_stub_binder+0x11e7cb000>
10627c430: 9126a042    	add	x2, x2, #0x9a8
10627c434: aa0003f8    	mov	x24, x0
10627c438: f9002be0    	str	x0, [sp, #0x50]
10627c43c: 9466ab40    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c440: f00cf7a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10627c444: f9474d00    	ldr	x0, [x8, #0xe98]
10627c448: 9466ab46    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10627c44c: f9001fe0    	str	x0, [sp, #0x38]
10627c450: 900cf7c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10627c454: f9403d14    	ldr	x20, [x8, #0x78] ; 8�6 
10627c458: aa0803f9    	mov	x25, x8
10627c45c: f00cf7b7    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
10627c460: f945eae0    	ldr	x0, [x23, #0xbd0] ; ��d 
10627c464: 900cf428    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10627c468: f944e91b    	ldr	x27, [x8, #0x9d0] ; currentContext
10627c46c: aa1b03e1    	mov	x1, x27
10627c470: 9466ab33    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c474: aa1d03fd    	mov	x29, x29
10627c478: 9466ab34    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c47c: aa0003f5    	mov	x21, x0
10627c480: f90027e0    	str	x0, [sp, #0x48]
10627c484: 900cf7c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10627c488: f9404100    	ldr	x0, [x8, #0x80]
10627c48c: f00cf408    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10627c490: f947ad1c    	ldr	x28, [x8, #0xf58] ; class
10627c494: aa1c03e1    	mov	x1, x28
10627c498: 9466ab29    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c49c: aa0003e2    	mov	x2, x0
10627c4a0: b00cdde8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10627c4a4: f9464113    	ldr	x19, [x8, #0xc80] ; getService:
10627c4a8: aa1503e0    	mov	x0, x21
10627c4ac: aa1303e1    	mov	x1, x19
10627c4b0: 9466ab23    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c4b4: aa1d03fd    	mov	x29, x29
10627c4b8: 9466ab24    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c4bc: f90023e0    	str	x0, [sp, #0x40]
10627c4c0: f00cdde8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10627c4c4: f947fd16    	ldr	x22, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
10627c4c8: b00c1162    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
10627c4cc: 912ca042    	add	x2, x2, #0xb28
10627c4d0: d00c1143    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
10627c4d4: 9124a063    	add	x3, x3, #0x928
10627c4d8: aa1603e1    	mov	x1, x22
10627c4dc: 9466ab18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c4e0: aa1d03fd    	mov	x29, x29
10627c4e4: 9466ab19    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c4e8: aa0003e2    	mov	x2, x0
10627c4ec: f9001be0    	str	x0, [sp, #0x30]
10627c4f0: 900cde08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10627c4f4: f9400115    	ldr	x21, [x8]
10627c4f8: aa1403e0    	mov	x0, x20
10627c4fc: aa1503e1    	mov	x1, x21
10627c500: 9466ab0f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c504: 1e604008    	fmov	d8, d0
10627c508: f00cf7a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10627c50c: f9461900    	ldr	x0, [x8, #0xc30]
10627c510: b00cde08    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10627c514: f9473101    	ldr	x1, [x8, #0xe60] ; systemFont
10627c518: f9000fe1    	str	x1, [sp, #0x18]
10627c51c: 9466ab08    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c520: aa1d03fd    	mov	x29, x29
10627c524: 9466ab09    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c528: f90017e0    	str	x0, [sp, #0x28]
10627c52c: f00cdde8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10627c530: f947ed01    	ldr	x1, [x8, #0xfd8] ; lineHeight
10627c534: f9000be1    	str	x1, [sp, #0x10]
10627c538: 9466ab01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c53c: 1e64c000    	frintp	d0, d0
10627c540: 1e60100b    	fmov	d11, #2.00000000
10627c544: 1f4b0100    	fmadd	d0, d8, d11, d0
10627c548: 1e621001    	fmov	d1, #4.00000000
10627c54c: 1e612808    	fadd	d8, d0, d1
10627c550: f00cf468    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10627c554: f947a501    	ldr	x1, [x8, #0xf48] ; width
10627c558: aa1803e0    	mov	x0, x24
10627c55c: 9466aaf8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c560: 1e604009    	fmov	d9, d0
10627c564: f9403f3a    	ldr	x26, [x25, #0x78]
10627c568: f945eae0    	ldr	x0, [x23, #0xbd0] ; ��d 
10627c56c: aa1b03e1    	mov	x1, x27
10627c570: 9466aaf3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c574: aa1d03fd    	mov	x29, x29
10627c578: 9466aaf4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c57c: aa0003f8    	mov	x24, x0
10627c580: f90013e0    	str	x0, [sp, #0x20]
10627c584: 900cf7d4    	adrp	x20, 0x120174000 <dyld_stub_binder+0x120174000>
10627c588: f9404280    	ldr	x0, [x20, #0x80]
10627c58c: aa1c03e1    	mov	x1, x28
10627c590: 9466aaeb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c594: aa0003e2    	mov	x2, x0
10627c598: aa1803e0    	mov	x0, x24
10627c59c: aa1303e1    	mov	x1, x19
10627c5a0: 9466aae7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c5a4: aa1d03fd    	mov	x29, x29
10627c5a8: 9466aae8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c5ac: f90007e0    	str	x0, [sp, #0x8]
10627c5b0: d00c1142    	adrp	x2, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
10627c5b4: 91242042    	add	x2, x2, #0x908
10627c5b8: aa1603e1    	mov	x1, x22
10627c5bc: d00c1158    	adrp	x24, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
10627c5c0: 9124a318    	add	x24, x24, #0x928
10627c5c4: aa1803e3    	mov	x3, x24
10627c5c8: 9466aadd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c5cc: aa1d03fd    	mov	x29, x29
10627c5d0: 9466aade    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c5d4: aa0003f9    	mov	x25, x0
10627c5d8: aa1a03e0    	mov	x0, x26
10627c5dc: aa1503e1    	mov	x1, x21
10627c5e0: aa1903e2    	mov	x2, x25
10627c5e4: 9466aad6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c5e8: 1f4b2409    	fmadd	d9, d0, d11, d9
10627c5ec: 900cf7c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10627c5f0: f9403d1a    	ldr	x26, [x8, #0x78] ; 8�6 
10627c5f4: f945eae0    	ldr	x0, [x23, #0xbd0] ; ��d 
10627c5f8: aa1b03e1    	mov	x1, x27
10627c5fc: 9466aad0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c600: aa1d03fd    	mov	x29, x29
10627c604: 9466aad1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c608: aa0003fb    	mov	x27, x0
10627c60c: f9404280    	ldr	x0, [x20, #0x80]
10627c610: aa1c03e1    	mov	x1, x28
10627c614: 9466aaca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c618: aa0003e2    	mov	x2, x0
10627c61c: aa1b03e0    	mov	x0, x27
10627c620: aa1303e1    	mov	x1, x19
10627c624: 9466aac6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c628: aa1d03fd    	mov	x29, x29
10627c62c: 9466aac7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c630: aa0003f3    	mov	x19, x0
10627c634: aa1603e1    	mov	x1, x22
10627c638: b00c1162    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
10627c63c: 912ca042    	add	x2, x2, #0xb28
10627c640: aa1803e3    	mov	x3, x24
10627c644: 9466aabe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c648: aa1d03fd    	mov	x29, x29
10627c64c: 9466aabf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c650: aa0003fc    	mov	x28, x0
10627c654: aa1a03e0    	mov	x0, x26
10627c658: aa1503e1    	mov	x1, x21
10627c65c: aa1c03e2    	mov	x2, x28
10627c660: 9466aab7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c664: 1e60400a    	fmov	d10, d0
10627c668: f00cf7a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10627c66c: f9461900    	ldr	x0, [x8, #0xc30]
10627c670: f9400fe1    	ldr	x1, [sp, #0x18]
10627c674: 9466aab2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c678: aa1d03fd    	mov	x29, x29
10627c67c: 9466aab3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c680: aa0003f5    	mov	x21, x0
10627c684: f9400be1    	ldr	x1, [sp, #0x10]
10627c688: 9466aaad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c68c: 1e64c000    	frintp	d0, d0
10627c690: 1f4b0143    	fmadd	d3, d10, d11, d0
10627c694: d00cf428    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10627c698: f947d901    	ldr	x1, [x8, #0xfb0] ; initWithFrame:
10627c69c: 9e6703e0    	fmov	d0, xzr
10627c6a0: f9401fe0    	ldr	x0, [sp, #0x38]
10627c6a4: 1e604101    	fmov	d1, d8
10627c6a8: 1e604122    	fmov	d2, d9
10627c6ac: 9466aaa4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c6b0: aa0003f6    	mov	x22, x0
10627c6b4: aa1503e0    	mov	x0, x21
10627c6b8: 9466aaa7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c6bc: aa1c03e0    	mov	x0, x28
10627c6c0: 9466aaa5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c6c4: aa1303e0    	mov	x0, x19
10627c6c8: 9466aaa3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c6cc: aa1b03e0    	mov	x0, x27
10627c6d0: 9466aaa1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c6d4: aa1903e0    	mov	x0, x25
10627c6d8: 9466aa9f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c6dc: f94007e0    	ldr	x0, [sp, #0x8]
10627c6e0: 9466aa9d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c6e4: f94013e0    	ldr	x0, [sp, #0x20]
10627c6e8: 9466aa9b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c6ec: f94017e0    	ldr	x0, [sp, #0x28]
10627c6f0: 9466aa99    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c6f4: f9401be0    	ldr	x0, [sp, #0x30]
10627c6f8: 9466aa97    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c6fc: f94023e0    	ldr	x0, [sp, #0x40]
10627c700: 9466aa95    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c704: f94027e0    	ldr	x0, [sp, #0x48]
10627c708: 9466aa93    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c70c: f00cf7a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10627c710: f9462d00    	ldr	x0, [x8, #0xc58]
10627c714: f00cde08    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10627c718: f946ed01    	ldr	x1, [x8, #0xdd8] ; chatBubbleDefault
10627c71c: 9466aa88    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c720: aa1d03fd    	mov	x29, x29
10627c724: 9466aa89    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c728: aa0003f3    	mov	x19, x0
10627c72c: f00cf448    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10627c730: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
10627c734: aa1603e0    	mov	x0, x22
10627c738: aa1303e2    	mov	x2, x19
10627c73c: 9466aa80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c740: aa1303e0    	mov	x0, x19
10627c744: 9466aa84    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c748: f00cf428    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10627c74c: f9469501    	ldr	x1, [x8, #0xd28] ; layer
10627c750: aa1603e0    	mov	x0, x22
10627c754: 9466aa7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c758: aa1d03fd    	mov	x29, x29
10627c75c: 9466aa7b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c760: aa0003f3    	mov	x19, x0
10627c764: f00cf448    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10627c768: f943e901    	ldr	x1, [x8, #0x7d0] ; setCornerRadius:
10627c76c: 1e621000    	fmov	d0, #4.00000000
10627c770: 9466aa73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c774: aa1303e0    	mov	x0, x19
10627c778: 9466aa77    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c77c: d00cf448    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10627c780: f9476901    	ldr	x1, [x8, #0xed0] ; setAlpha:
10627c784: 9e6703e0    	fmov	d0, xzr
10627c788: aa1603e0    	mov	x0, x22
10627c78c: 9466aa6c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c790: f00cf448    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10627c794: f942e101    	ldr	x1, [x8, #0x5c0] ; setClipsToBounds:
10627c798: aa1603e0    	mov	x0, x22
10627c79c: 52800022    	mov	w2, #0x1                ; =1
10627c7a0: 9466aa67    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c7a4: 900cf7d8    	adrp	x24, 0x120174000 <dyld_stub_binder+0x120174000>
10627c7a8: f9414700    	ldr	x0, [x24, #0x288]
10627c7ac: 9466aa6d    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10627c7b0: b00cea08    	adrp	x8, 0x11ffbd000 <dyld_stub_binder+0x11ffbd000>
10627c7b4: f947c903    	ldr	x3, [x8, #0xf90] ; onDoubleTapTranslateView:
10627c7b8: f00cf428    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10627c7bc: f9413514    	ldr	x20, [x8, #0x268] ; initWithTarget:action:
10627c7c0: aa1403e1    	mov	x1, x20
10627c7c4: f9402ff9    	ldr	x25, [sp, #0x58]
10627c7c8: aa1903e2    	mov	x2, x25
10627c7cc: 9466aa5c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c7d0: aa0003f3    	mov	x19, x0
10627c7d4: 900cf468    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10627c7d8: f947fd01    	ldr	x1, [x8, #0xff8] ; setNumberOfTapsRequired:
10627c7dc: 52800042    	mov	w2, #0x2                ; =2
10627c7e0: 9466aa57    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c7e4: d00cf408    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10627c7e8: f946b515    	ldr	x21, [x8, #0xd68] ; addGestureRecognizer:
10627c7ec: aa1603e0    	mov	x0, x22
10627c7f0: aa1503e1    	mov	x1, x21
10627c7f4: aa1303e2    	mov	x2, x19
10627c7f8: 9466aa51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c7fc: b00cf7c8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10627c800: f945c500    	ldr	x0, [x8, #0xb88]
10627c804: 9466aa57    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10627c808: f00ceaa8    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10627c80c: f946b503    	ldr	x3, [x8, #0xd68] ; onLongPressTranslateView:
10627c810: aa1403e1    	mov	x1, x20
10627c814: aa1903e2    	mov	x2, x25
10627c818: 9466aa49    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c81c: aa0003f7    	mov	x23, x0
10627c820: 900cf468    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10627c824: f9470101    	ldr	x1, [x8, #0xe00] ; setMinimumPressDuration:
10627c828: b0095828    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10627c82c: fd42c100    	ldr	d0, [x8, #0x580]
10627c830: 9466aa43    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c834: aa1603e0    	mov	x0, x22
10627c838: aa1503e1    	mov	x1, x21
10627c83c: aa1703e2    	mov	x2, x23
10627c840: 9466aa3f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c844: f9414700    	ldr	x0, [x24, #0x288]
10627c848: 9466aa46    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10627c84c: f00ceaa8    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10627c850: f946b903    	ldr	x3, [x8, #0xd70] ; onTapTranslateView:
10627c854: aa1403e1    	mov	x1, x20
10627c858: aa1903e2    	mov	x2, x25
10627c85c: 9466aa38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c860: aa0003f4    	mov	x20, x0
10627c864: aa1603e0    	mov	x0, x22
10627c868: aa1503e1    	mov	x1, x21
10627c86c: aa1403e2    	mov	x2, x20
10627c870: 9466aa33    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c874: aa1403e0    	mov	x0, x20
10627c878: 9466aa37    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c87c: aa1703e0    	mov	x0, x23
10627c880: 9466aa35    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c884: aa1303e0    	mov	x0, x19
10627c888: 9466aa33    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c88c: f9402be0    	ldr	x0, [sp, #0x50]
10627c890: 9466aa31    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c894: aa1603e0    	mov	x0, x22
10627c898: a94d7bfd    	ldp	x29, x30, [sp, #0xd0]
10627c89c: a94c4ff4    	ldp	x20, x19, [sp, #0xc0]
10627c8a0: a94b57f6    	ldp	x22, x21, [sp, #0xb0]
10627c8a4: a94a5ff8    	ldp	x24, x23, [sp, #0xa0]
10627c8a8: a94967fa    	ldp	x26, x25, [sp, #0x90]
10627c8ac: a9486ffc    	ldp	x28, x27, [sp, #0x80]
10627c8b0: 6d4723e9    	ldp	d9, d8, [sp, #0x70]
10627c8b4: 6d462beb    	ldp	d11, d10, [sp, #0x60]
10627c8b8: 910383ff    	add	sp, sp, #0xe0
10627c8bc: 1466aa2d    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>