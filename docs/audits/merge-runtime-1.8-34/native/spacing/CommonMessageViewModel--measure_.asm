
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f6b4f8: d10283ff    	sub	sp, sp, #0xa0
100f6b4fc: 6d022beb    	stp	d11, d10, [sp, #0x20]
100f6b500: 6d0323e9    	stp	d9, d8, [sp, #0x30]
100f6b504: a9046ffc    	stp	x28, x27, [sp, #0x40]
100f6b508: a90567fa    	stp	x26, x25, [sp, #0x50]
100f6b50c: a9065ff8    	stp	x24, x23, [sp, #0x60]
100f6b510: a90757f6    	stp	x22, x21, [sp, #0x70]
100f6b514: a9084ff4    	stp	x20, x19, [sp, #0x80]
100f6b518: a9097bfd    	stp	x29, x30, [sp, #0x90]
100f6b51c: 910243fd    	add	x29, sp, #0x90
100f6b520: 1e604028    	fmov	d8, d1
100f6b524: 1e604009    	fmov	d9, d0
100f6b528: aa0003f3    	mov	x19, x0
100f6b52c: b00fe628    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100f6b530: 52800029    	mov	w9, #0x1                ; =1
100f6b534: 39298909    	strb	w9, [x8, #0xa62]
100f6b538: 900f93a8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
100f6b53c: 910b7108    	add	x8, x8, #0x2dc
100f6b540: b9800108    	ldrsw	x8, [x8]
100f6b544: 8b080017    	add	x23, x0, x8
100f6b548: 6d4006e0    	ldp	d0, d1, [x23]
100f6b54c: d00e3408    	adrp	x8, 0x11d5ed000 <dyld_stub_binder+0x11d5ed000>
100f6b550: f9417908    	ldr	x8, [x8, #0x2f0]
100f6b554: 6d400d02    	ldp	d2, d3, [x8]
100f6b558: 1e622000    	fcmp	d0, d2
100f6b55c: 1e630420    	fccmp	d1, d3, #0x0, eq
100f6b560: 900f76b4    	adrp	x20, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100f6b564: 900f76b9    	adrp	x25, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100f6b568: 540018a1    	b.ne	0x100f6b87c <__text+0xf6387c>
100f6b56c: 900f93a8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
100f6b570: 910b4108    	add	x8, x8, #0x2d0
100f6b574: b9800108    	ldrsw	x8, [x8]
100f6b578: 38686a68    	ldrb	w8, [x19, x8]
100f6b57c: 7100051f    	cmp	w8, #0x1
100f6b580: 54001381    	b.ne	0x100f6b7f0 <__text+0xf637f0>
100f6b584: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6b588: f9463d18    	ldr	x24, [x8, #0xc78]
100f6b58c: 900f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6b590: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
100f6b594: b00f8ca8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100f6b598: f944e914    	ldr	x20, [x8, #0x9d0] ; currentContext
100f6b59c: aa1403e1    	mov	x1, x20
100f6b5a0: 95b2eee7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b5a4: aa1d03fd    	mov	x29, x29
100f6b5a8: 95b2eee8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b5ac: aa0003fc    	mov	x28, x0
100f6b5b0: 900f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6b5b4: f9462900    	ldr	x0, [x8, #0xc50]
100f6b5b8: 900f8ca8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f6b5bc: f947ad15    	ldr	x21, [x8, #0xf58] ; class
100f6b5c0: aa1503e1    	mov	x1, x21
100f6b5c4: 95b2eede    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b5c8: aa0003e2    	mov	x2, x0
100f6b5cc: d00f7668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f6b5d0: f9464116    	ldr	x22, [x8, #0xc80] ; getService:
100f6b5d4: aa1c03e0    	mov	x0, x28
100f6b5d8: aa1603e1    	mov	x1, x22
100f6b5dc: 95b2eed8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b5e0: aa1d03fd    	mov	x29, x29
100f6b5e4: 95b2eed9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b5e8: aa0003f9    	mov	x25, x0
100f6b5ec: d00f7668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f6b5f0: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
100f6b5f4: b00eae62    	adrp	x2, 0x11e538000 <dyld_stub_binder+0x11e538000>
100f6b5f8: 9133a042    	add	x2, x2, #0xce8
100f6b5fc: 95b2eed0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b600: aa1d03fd    	mov	x29, x29
100f6b604: 95b2eed1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b608: aa0003fa    	mov	x26, x0
100f6b60c: 900f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6b610: f9461900    	ldr	x0, [x8, #0xc30]
100f6b614: d00f7688    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
100f6b618: f9473101    	ldr	x1, [x8, #0xe60] ; systemFont
100f6b61c: 95b2eec8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b620: aa1d03fd    	mov	x29, x29
100f6b624: 95b2eec9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b628: aa0003fb    	mov	x27, x0
100f6b62c: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6b630: f9450100    	ldr	x0, [x8, #0xa00] ; 0�7 
100f6b634: b00f78c8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f6b638: f946c901    	ldr	x1, [x8, #0xd90] ; getTextMessageNodeWidth:
100f6b63c: aa1303e2    	mov	x2, x19
100f6b640: 95b2eebf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b644: d00f78c8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f6b648: f9415d01    	ldr	x1, [x8, #0x2b8] ; sizeForContent:font:width:parserType:delegate:
100f6b64c: aa1803e0    	mov	x0, x24
100f6b650: aa1a03e2    	mov	x2, x26
100f6b654: aa1b03e3    	mov	x3, x27
100f6b658: 52800024    	mov	w4, #0x1                ; =1
100f6b65c: d2800005    	mov	x5, #0x0                ; =0
100f6b660: 95b2eeb7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b664: 1e604008    	fmov	d8, d0
100f6b668: 1e604029    	fmov	d9, d1
100f6b66c: aa1b03e0    	mov	x0, x27
100f6b670: 95b2eeb9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b674: aa1a03e0    	mov	x0, x26
100f6b678: 95b2eeb7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b67c: aa1903e0    	mov	x0, x25
100f6b680: 95b2eeb5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b684: aa1c03e0    	mov	x0, x28
100f6b688: 95b2eeb3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b68c: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6b690: f9403d1a    	ldr	x26, [x8, #0x78] ; 8�6 
100f6b694: 900f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6b698: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
100f6b69c: aa1403e1    	mov	x1, x20
100f6b6a0: 95b2eea7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b6a4: aa1d03fd    	mov	x29, x29
100f6b6a8: 95b2eea8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b6ac: aa0003f8    	mov	x24, x0
100f6b6b0: f9000be0    	str	x0, [sp, #0x10]
100f6b6b4: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6b6b8: f9404100    	ldr	x0, [x8, #0x80]
100f6b6bc: aa1503e1    	mov	x1, x21
100f6b6c0: 95b2ee9f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b6c4: aa0003e2    	mov	x2, x0
100f6b6c8: aa1803e0    	mov	x0, x24
100f6b6cc: aa1603e1    	mov	x1, x22
100f6b6d0: 95b2ee9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b6d4: aa1d03fd    	mov	x29, x29
100f6b6d8: 95b2ee9c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b6dc: aa0003f8    	mov	x24, x0
100f6b6e0: 900f7688    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100f6b6e4: f947fd1b    	ldr	x27, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
100f6b6e8: d00ea9e2    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
100f6b6ec: 912ca042    	add	x2, x2, #0xb28
100f6b6f0: f00ea9c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
100f6b6f4: 9124a063    	add	x3, x3, #0x928
100f6b6f8: aa1b03e1    	mov	x1, x27
100f6b6fc: 95b2ee90    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b700: aa1d03fd    	mov	x29, x29
100f6b704: 95b2ee91    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b708: aa0003f9    	mov	x25, x0
100f6b70c: b00f7688    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100f6b710: f940011c    	ldr	x28, [x8]
100f6b714: aa1a03e0    	mov	x0, x26
100f6b718: aa1c03e1    	mov	x1, x28
100f6b71c: aa1903e2    	mov	x2, x25
100f6b720: 95b2ee87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b724: 1e602929    	fadd	d9, d9, d0
100f6b728: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6b72c: f9403d1a    	ldr	x26, [x8, #0x78] ; 8�6 
100f6b730: 900f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6b734: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
100f6b738: aa1403e1    	mov	x1, x20
100f6b73c: 95b2ee80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b740: aa1d03fd    	mov	x29, x29
100f6b744: 95b2ee81    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b748: aa0003f4    	mov	x20, x0
100f6b74c: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6b750: f9404100    	ldr	x0, [x8, #0x80]
100f6b754: aa1503e1    	mov	x1, x21
100f6b758: 95b2ee79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b75c: aa0003e2    	mov	x2, x0
100f6b760: aa1403e0    	mov	x0, x20
100f6b764: aa1603e1    	mov	x1, x22
100f6b768: 95b2ee75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b76c: aa1d03fd    	mov	x29, x29
100f6b770: 95b2ee76    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b774: aa0003f5    	mov	x21, x0
100f6b778: aa1b03e1    	mov	x1, x27
100f6b77c: d00ea9e2    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
100f6b780: 912ca042    	add	x2, x2, #0xb28
100f6b784: f00ea9c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
100f6b788: 9124a063    	add	x3, x3, #0x928
100f6b78c: 95b2ee6c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b790: aa1d03fd    	mov	x29, x29
100f6b794: 95b2ee6d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b798: aa0003f6    	mov	x22, x0
100f6b79c: aa1a03e0    	mov	x0, x26
100f6b7a0: aa1c03e1    	mov	x1, x28
100f6b7a4: aa1603e2    	mov	x2, x22
100f6b7a8: 95b2ee65    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b7ac: 1e602920    	fadd	d0, d9, d0
100f6b7b0: 6d0002e8    	stp	d8, d0, [x23]
100f6b7b4: aa1603e0    	mov	x0, x22
100f6b7b8: 95b2ee67    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b7bc: aa1503e0    	mov	x0, x21
100f6b7c0: 95b2ee65    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b7c4: aa1403e0    	mov	x0, x20
100f6b7c8: 900f76b4    	adrp	x20, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100f6b7cc: 95b2ee62    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b7d0: aa1903e0    	mov	x0, x25
100f6b7d4: 900f76b9    	adrp	x25, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100f6b7d8: 95b2ee5f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b7dc: aa1803e0    	mov	x0, x24
100f6b7e0: 95b2ee5d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b7e4: f9400be0    	ldr	x0, [sp, #0x10]
100f6b7e8: 95b2ee5b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b7ec: 14000010    	b	0x100f6b82c <__text+0xf6382c>
100f6b7f0: 900f93a8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
100f6b7f4: 910b3108    	add	x8, x8, #0x2cc
100f6b7f8: b9800108    	ldrsw	x8, [x8]
100f6b7fc: f8686a61    	ldr	x1, [x19, x8]
100f6b800: 910063e0    	add	x0, sp, #0x18
100f6b804: 95b28645    	bl	0x107c0d118 <_Flutter_MMFoundation_BindContext+0x40e8cfc>
100f6b808: f00f7688    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
100f6b80c: f9416901    	ldr	x1, [x8, #0x2d0] ; measureContentViewSize:
100f6b810: aa1303e0    	mov	x0, x19
100f6b814: 1e604120    	fmov	d0, d9
100f6b818: 1e604101    	fmov	d1, d8
100f6b81c: 95b2ee48    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b820: 6d0006e0    	stp	d0, d1, [x23]
100f6b824: 910063e0    	add	x0, sp, #0x18
100f6b828: 95b2863d    	bl	0x107c0d11c <_Flutter_MMFoundation_BindContext+0x40e8d00>
100f6b82c: f9415681    	ldr	x1, [x20, #0x2a8] ; isShowSourceView
100f6b830: aa1303e0    	mov	x0, x19
100f6b834: 95b2ee42    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b838: 34000220    	cbz	w0, 0x100f6b87c <__text+0xf6387c>
100f6b83c: f9415f21    	ldr	x1, [x25, #0x2b8] ; isTailPart
100f6b840: aa1303e0    	mov	x0, x19
100f6b844: 95b2ee3e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b848: 340001a0    	cbz	w0, 0x100f6b87c <__text+0xf6387c>
100f6b84c: 900f76a8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100f6b850: f9415101    	ldr	x1, [x8, #0x2a0] ; shouldShowSourceViewInContent
100f6b854: aa1303e0    	mov	x0, x19
100f6b858: 95b2ee39    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b85c: 34000100    	cbz	w0, 0x100f6b87c <__text+0xf6387c>
100f6b860: b00f78c8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f6b864: f9462901    	ldr	x1, [x8, #0xc50] ; sourceViewInsideHeight
100f6b868: aa1303e0    	mov	x0, x19
100f6b86c: 95b2ee34    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b870: fd4006e1    	ldr	d1, [x23, #0x8]
100f6b874: 1e612800    	fadd	d0, d0, d1
100f6b878: fd0006e0    	str	d0, [x23, #0x8]
100f6b87c: 6d4026e8    	ldp	d8, d9, [x23]
100f6b880: 900f7728    	adrp	x8, 0x11fe4f000 <dyld_stub_binder+0x11fe4f000>
100f6b884: f9459d1b    	ldr	x27, [x8, #0xb38] ; isHeadPart
100f6b888: aa1303e0    	mov	x0, x19
100f6b88c: aa1b03e1    	mov	x1, x27
100f6b890: 95b2ee2b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b894: d00f76ba    	adrp	x26, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100f6b898: 34000d60    	cbz	w0, 0x100f6ba44 <__text+0xf63a44>
100f6b89c: f9454b41    	ldr	x1, [x26, #0xa90] ; isRecordDetail
100f6b8a0: aa1303e0    	mov	x0, x19
100f6b8a4: 95b2ee26    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b8a8: 37000ce0    	tbnz	w0, #0x0, 0x100f6ba44 <__text+0xf63a44>
100f6b8ac: b00f78c8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f6b8b0: f9461901    	ldr	x1, [x8, #0xc30] ; isShareConfirm
100f6b8b4: aa1303e0    	mov	x0, x19
100f6b8b8: 95b2ee21    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b8bc: 37000c40    	tbnz	w0, #0x0, 0x100f6ba44 <__text+0xf63a44>
100f6b8c0: d00f7888    	adrp	x8, 0x11fe7d000 <dyld_stub_binder+0x11fe7d000>
100f6b8c4: f940dd01    	ldr	x1, [x8, #0x1b8] ; isShowChatRoomDisplayName
100f6b8c8: aa1303e0    	mov	x0, x19
100f6b8cc: 95b2ee1c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b8d0: 34000600    	cbz	w0, 0x100f6b990 <__text+0xf63990>
100f6b8d4: 900f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6b8d8: f9461900    	ldr	x0, [x8, #0xc30]
100f6b8dc: d00f7668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f6b8e0: f9463101    	ldr	x1, [x8, #0xc60] ; dynamicLength:
100f6b8e4: 1e661000    	fmov	d0, #16.00000000
100f6b8e8: 95b2ee15    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b8ec: 1e60400a    	fmov	d10, d0
100f6b8f0: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6b8f4: f9403d18    	ldr	x24, [x8, #0x78] ; 8�6 
100f6b8f8: 900f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6b8fc: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
100f6b900: b00f8ca8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100f6b904: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100f6b908: 95b2ee0d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b90c: aa1d03fd    	mov	x29, x29
100f6b910: 95b2ee0e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b914: aa0003f5    	mov	x21, x0
100f6b918: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6b91c: f9404100    	ldr	x0, [x8, #0x80]
100f6b920: 900f8ca8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f6b924: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100f6b928: 95b2ee05    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b92c: aa0003e2    	mov	x2, x0
100f6b930: d00f7668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f6b934: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100f6b938: aa1503e0    	mov	x0, x21
100f6b93c: 95b2ee00    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b940: aa1d03fd    	mov	x29, x29
100f6b944: 95b2ee01    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b948: aa0003f6    	mov	x22, x0
100f6b94c: 900f7688    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100f6b950: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
100f6b954: b00eaea2    	adrp	x2, 0x11e540000 <dyld_stub_binder+0x11e540000>
100f6b958: 9129a042    	add	x2, x2, #0xa68
100f6b95c: f00ea9c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
100f6b960: 9124a063    	add	x3, x3, #0x928
100f6b964: 95b2edf6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b968: aa1d03fd    	mov	x29, x29
100f6b96c: 95b2edf7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b970: aa0003f7    	mov	x23, x0
100f6b974: b00f7688    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100f6b978: f9400101    	ldr	x1, [x8]
100f6b97c: aa1803e0    	mov	x0, x24
100f6b980: aa1703e2    	mov	x2, x23
100f6b984: 95b2edee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b988: 1e602940    	fadd	d0, d10, d0
100f6b98c: 14000027    	b	0x100f6ba28 <__text+0xf63a28>
100f6b990: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6b994: f9403d18    	ldr	x24, [x8, #0x78] ; 8�6 
100f6b998: 900f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6b99c: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
100f6b9a0: b00f8ca8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100f6b9a4: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100f6b9a8: 95b2ede5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b9ac: aa1d03fd    	mov	x29, x29
100f6b9b0: 95b2ede6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b9b4: aa0003f5    	mov	x21, x0
100f6b9b8: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6b9bc: f9404100    	ldr	x0, [x8, #0x80]
100f6b9c0: 900f8ca8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f6b9c4: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100f6b9c8: 95b2eddd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b9cc: aa0003e2    	mov	x2, x0
100f6b9d0: d00f7668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f6b9d4: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100f6b9d8: aa1503e0    	mov	x0, x21
100f6b9dc: 95b2edd8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b9e0: aa1d03fd    	mov	x29, x29
100f6b9e4: 95b2edd9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b9e8: aa0003f6    	mov	x22, x0
100f6b9ec: 900f7688    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100f6b9f0: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
100f6b9f4: b00eaea2    	adrp	x2, 0x11e540000 <dyld_stub_binder+0x11e540000>
100f6b9f8: 9129a042    	add	x2, x2, #0xa68
100f6b9fc: f00ea9c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
100f6ba00: 9124a063    	add	x3, x3, #0x928
100f6ba04: 95b2edce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6ba08: aa1d03fd    	mov	x29, x29
100f6ba0c: 95b2edcf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6ba10: aa0003f7    	mov	x23, x0
100f6ba14: b00f7688    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100f6ba18: f9400101    	ldr	x1, [x8]
100f6ba1c: aa1803e0    	mov	x0, x24
100f6ba20: aa1703e2    	mov	x2, x23
100f6ba24: 95b2edc6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6ba28: 1e602929    	fadd	d9, d9, d0
100f6ba2c: aa1703e0    	mov	x0, x23
100f6ba30: 95b2edc9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6ba34: aa1603e0    	mov	x0, x22
100f6ba38: 95b2edc7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6ba3c: aa1503e0    	mov	x0, x21
100f6ba40: 95b2edc5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6ba44: b00f78c8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f6ba48: f9469515    	ldr	x21, [x8, #0xd28] ; replyTextSize
100f6ba4c: aa1303e0    	mov	x0, x19
100f6ba50: aa1503e1    	mov	x1, x21
100f6ba54: 95b2edba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6ba58: d00bf0a8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
100f6ba5c: fd42d100    	ldr	d0, [x8, #0x5a0]
100f6ba60: 1e602020    	fcmp	d1, d0
100f6ba64: 5400024d    	b.le	0x100f6baac <__text+0xf63aac>
100f6ba68: aa1303e0    	mov	x0, x19
100f6ba6c: aa1503e1    	mov	x1, x21
100f6ba70: 95b2edb3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6ba74: 1e60402a    	fmov	d10, d1
100f6ba78: b00f78c8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f6ba7c: f9468d15    	ldr	x21, [x8, #0xd18] ; replyTextInset
100f6ba80: aa1303e0    	mov	x0, x19
100f6ba84: aa1503e1    	mov	x1, x21
100f6ba88: 95b2edad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6ba8c: 1e60294a    	fadd	d10, d10, d0
100f6ba90: aa1303e0    	mov	x0, x19
100f6ba94: aa1503e1    	mov	x1, x21
100f6ba98: 95b2eda9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6ba9c: 1e622940    	fadd	d0, d10, d2
100f6baa0: 1e621001    	fmov	d1, #4.00000000
100f6baa4: 1e612800    	fadd	d0, d0, d1
100f6baa8: 1e602929    	fadd	d9, d9, d0
100f6baac: f00f7708    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
100f6bab0: f9471901    	ldr	x1, [x8, #0xe30] ; shouldShowRoomTodoView
100f6bab4: aa1303e0    	mov	x0, x19
100f6bab8: 95b2eda1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6babc: 36000660    	tbz	w0, #0x0, 0x100f6bb88 <__text+0xf63b88>
100f6bac0: b00f78c8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f6bac4: f947b501    	ldr	x1, [x8, #0xf68] ; hasCommonTail
100f6bac8: aa1303e0    	mov	x0, x19
100f6bacc: 95b2ed9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bad0: 34000820    	cbz	w0, 0x100f6bbd4 <__text+0xf63bd4>
100f6bad4: d00f78c8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f6bad8: f9416101    	ldr	x1, [x8, #0x2c0] ; commonTailSize
100f6badc: aa1303e0    	mov	x0, x19
100f6bae0: 95b2ed97    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bae4: 1e60402a    	fmov	d10, d1
100f6bae8: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6baec: f9403d18    	ldr	x24, [x8, #0x78] ; 8�6 
100f6baf0: 900f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6baf4: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
100f6baf8: b00f8ca8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100f6bafc: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100f6bb00: 95b2ed8f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bb04: aa1d03fd    	mov	x29, x29
100f6bb08: 95b2ed90    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6bb0c: aa0003f5    	mov	x21, x0
100f6bb10: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6bb14: f9404100    	ldr	x0, [x8, #0x80]
100f6bb18: 900f8ca8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f6bb1c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100f6bb20: 95b2ed87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bb24: aa0003e2    	mov	x2, x0
100f6bb28: d00f7668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f6bb2c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100f6bb30: aa1503e0    	mov	x0, x21
100f6bb34: 95b2ed82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bb38: aa1d03fd    	mov	x29, x29
100f6bb3c: 95b2ed83    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6bb40: aa0003f6    	mov	x22, x0
100f6bb44: 900f7688    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100f6bb48: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
100f6bb4c: d00eaea2    	adrp	x2, 0x11e541000 <dyld_stub_binder+0x11e541000>
100f6bb50: 910f2042    	add	x2, x2, #0x3c8
100f6bb54: f00ea9c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
100f6bb58: 9124a063    	add	x3, x3, #0x928
100f6bb5c: 95b2ed78    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bb60: aa1d03fd    	mov	x29, x29
100f6bb64: 95b2ed79    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6bb68: aa0003f7    	mov	x23, x0
100f6bb6c: b00f7688    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100f6bb70: f9400101    	ldr	x1, [x8]
100f6bb74: aa1803e0    	mov	x0, x24
100f6bb78: aa1703e2    	mov	x2, x23
100f6bb7c: 95b2ed70    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bb80: 1e60294a    	fadd	d10, d10, d0
100f6bb84: 14000074    	b	0x100f6bd54 <__text+0xf63d54>
100f6bb88: f9415681    	ldr	x1, [x20, #0x2a8] ; isShowSourceView
100f6bb8c: aa1303e0    	mov	x0, x19
100f6bb90: 95b2ed6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bb94: 34000ee0    	cbz	w0, 0x100f6bd70 <__text+0xf63d70>
100f6bb98: f9415f21    	ldr	x1, [x25, #0x2b8] ; isTailPart
100f6bb9c: aa1303e0    	mov	x0, x19
100f6bba0: 95b2ed67    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bba4: 34000e60    	cbz	w0, 0x100f6bd70 <__text+0xf63d70>
100f6bba8: 900f76a8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100f6bbac: f9415101    	ldr	x1, [x8, #0x2a0] ; shouldShowSourceViewInContent
100f6bbb0: aa1303e0    	mov	x0, x19
100f6bbb4: 95b2ed62    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bbb8: 37000dc0    	tbnz	w0, #0x0, 0x100f6bd70 <__text+0xf63d70>
100f6bbbc: b00f78c8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f6bbc0: f9461901    	ldr	x1, [x8, #0xc30] ; isShareConfirm
100f6bbc4: aa1303e0    	mov	x0, x19
100f6bbc8: 95b2ed5d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bbcc: 3607f7a0    	tbz	w0, #0x0, 0x100f6bac0 <__text+0xf63ac0>
100f6bbd0: 14000068    	b	0x100f6bd70 <__text+0xf63d70>
100f6bbd4: 900f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6bbd8: f9461908    	ldr	x8, [x8, #0xc30]
100f6bbdc: f90007e8    	str	x8, [sp, #0x8]
100f6bbe0: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6bbe4: f9403d1c    	ldr	x28, [x8, #0x78] ; 8�6 
100f6bbe8: 900f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6bbec: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
100f6bbf0: b00f8ca8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100f6bbf4: f944e918    	ldr	x24, [x8, #0x9d0] ; currentContext
100f6bbf8: aa1803e1    	mov	x1, x24
100f6bbfc: 95b2ed50    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bc00: aa1d03fd    	mov	x29, x29
100f6bc04: 95b2ed51    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6bc08: aa0003f5    	mov	x21, x0
100f6bc0c: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6bc10: f9404100    	ldr	x0, [x8, #0x80]
100f6bc14: 900f8ca8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f6bc18: f947ad19    	ldr	x25, [x8, #0xf58] ; class
100f6bc1c: aa1903e1    	mov	x1, x25
100f6bc20: 95b2ed47    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bc24: aa0003e2    	mov	x2, x0
100f6bc28: d00f7668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f6bc2c: f9000bfb    	str	x27, [sp, #0x10]
100f6bc30: f946411b    	ldr	x27, [x8, #0xc80] ; getService:
100f6bc34: aa1503e0    	mov	x0, x21
100f6bc38: aa1b03e1    	mov	x1, x27
100f6bc3c: 95b2ed40    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bc40: aa1d03fd    	mov	x29, x29
100f6bc44: 95b2ed41    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6bc48: aa0003f6    	mov	x22, x0
100f6bc4c: 900f7688    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100f6bc50: f947fd14    	ldr	x20, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
100f6bc54: b00eaac2    	adrp	x2, 0x11e4c4000 <dyld_stub_binder+0x11e4c4000>
100f6bc58: 91322042    	add	x2, x2, #0xc88
100f6bc5c: f00ea9c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
100f6bc60: 9124a063    	add	x3, x3, #0x928
100f6bc64: aa1403e1    	mov	x1, x20
100f6bc68: 95b2ed35    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bc6c: aa1d03fd    	mov	x29, x29
100f6bc70: 95b2ed36    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6bc74: aa0003f7    	mov	x23, x0
100f6bc78: b00f7688    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100f6bc7c: f940011a    	ldr	x26, [x8]
100f6bc80: aa1c03e0    	mov	x0, x28
100f6bc84: aa1a03e1    	mov	x1, x26
100f6bc88: aa1703e2    	mov	x2, x23
100f6bc8c: 95b2ed2c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bc90: d00f7668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f6bc94: f9463101    	ldr	x1, [x8, #0xc60] ; dynamicLength:
100f6bc98: f94007e0    	ldr	x0, [sp, #0x8]
100f6bc9c: 95b2ed28    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bca0: 1e631001    	fmov	d1, #6.00000000
100f6bca4: 1e61280a    	fadd	d10, d0, d1
100f6bca8: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6bcac: f9403d1c    	ldr	x28, [x8, #0x78] ; 8�6 
100f6bcb0: 900f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6bcb4: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
100f6bcb8: aa1803e1    	mov	x1, x24
100f6bcbc: 95b2ed20    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bcc0: aa1d03fd    	mov	x29, x29
100f6bcc4: 95b2ed21    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6bcc8: aa0003f8    	mov	x24, x0
100f6bccc: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6bcd0: f9404100    	ldr	x0, [x8, #0x80]
100f6bcd4: aa1903e1    	mov	x1, x25
100f6bcd8: 95b2ed19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bcdc: aa0003e2    	mov	x2, x0
100f6bce0: aa1803e0    	mov	x0, x24
100f6bce4: aa1b03e1    	mov	x1, x27
100f6bce8: f9400bfb    	ldr	x27, [sp, #0x10]
100f6bcec: 95b2ed14    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bcf0: aa1d03fd    	mov	x29, x29
100f6bcf4: 95b2ed15    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6bcf8: aa0003f9    	mov	x25, x0
100f6bcfc: d00eaea2    	adrp	x2, 0x11e541000 <dyld_stub_binder+0x11e541000>
100f6bd00: 910f2042    	add	x2, x2, #0x3c8
100f6bd04: aa1403e1    	mov	x1, x20
100f6bd08: f00ea9c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
100f6bd0c: 9124a063    	add	x3, x3, #0x928
100f6bd10: 95b2ed0b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bd14: aa1d03fd    	mov	x29, x29
100f6bd18: 95b2ed0c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6bd1c: aa0003f4    	mov	x20, x0
100f6bd20: aa1c03e0    	mov	x0, x28
100f6bd24: aa1a03e1    	mov	x1, x26
100f6bd28: d00f76ba    	adrp	x26, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100f6bd2c: aa1403e2    	mov	x2, x20
100f6bd30: 95b2ed03    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bd34: 1e60294a    	fadd	d10, d10, d0
100f6bd38: aa1403e0    	mov	x0, x20
100f6bd3c: 95b2ed06    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6bd40: aa1903e0    	mov	x0, x25
100f6bd44: 900f76b9    	adrp	x25, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100f6bd48: 95b2ed03    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6bd4c: aa1803e0    	mov	x0, x24
100f6bd50: 95b2ed01    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6bd54: 1e6a2929    	fadd	d9, d9, d10
100f6bd58: aa1703e0    	mov	x0, x23
100f6bd5c: 95b2ecfe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6bd60: aa1603e0    	mov	x0, x22
100f6bd64: 95b2ecfc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6bd68: aa1503e0    	mov	x0, x21
100f6bd6c: 95b2ecfa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6bd70: b00f78c8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f6bd74: f945f101    	ldr	x1, [x8, #0xbe0] ; isShowHeadImage
100f6bd78: aa1303e0    	mov	x0, x19
100f6bd7c: 95b2ecf0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bd80: 34000980    	cbz	w0, 0x100f6beb0 <__text+0xf63eb0>
100f6bd84: aa1303e0    	mov	x0, x19
100f6bd88: aa1b03e1    	mov	x1, x27
100f6bd8c: 95b2ecec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bd90: 34000900    	cbz	w0, 0x100f6beb0 <__text+0xf63eb0>
100f6bd94: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6bd98: f9403d15    	ldr	x21, [x8, #0x78] ; 8�6 
100f6bd9c: 900f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6bda0: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
100f6bda4: b00f8ca8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100f6bda8: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100f6bdac: 95b2ece4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bdb0: aa1d03fd    	mov	x29, x29
100f6bdb4: 95b2ece5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6bdb8: aa0003f4    	mov	x20, x0
100f6bdbc: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6bdc0: f9404100    	ldr	x0, [x8, #0x80]
100f6bdc4: 900f8ca8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f6bdc8: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100f6bdcc: 95b2ecdc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bdd0: aa0003e2    	mov	x2, x0
100f6bdd4: d00f7668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f6bdd8: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100f6bddc: aa1403e0    	mov	x0, x20
100f6bde0: 95b2ecd7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bde4: aa1d03fd    	mov	x29, x29
100f6bde8: 95b2ecd8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6bdec: aa0003f6    	mov	x22, x0
100f6bdf0: 900f7688    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100f6bdf4: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
100f6bdf8: d00ea9e2    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
100f6bdfc: 912ca042    	add	x2, x2, #0xb28
100f6be00: f00ea9c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
100f6be04: 9124a063    	add	x3, x3, #0x928
100f6be08: 95b2eccd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6be0c: aa1d03fd    	mov	x29, x29
100f6be10: 95b2ecce    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6be14: aa0003f7    	mov	x23, x0
100f6be18: b00f7688    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100f6be1c: f9400101    	ldr	x1, [x8]
100f6be20: aa1503e0    	mov	x0, x21
100f6be24: aa1703e2    	mov	x2, x23
100f6be28: 95b2ecc5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6be2c: 1e60400a    	fmov	d10, d0
100f6be30: 900f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6be34: f9461900    	ldr	x0, [x8, #0xc30]
100f6be38: d00f7688    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
100f6be3c: f9473101    	ldr	x1, [x8, #0xe60] ; systemFont
100f6be40: 95b2ecbf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6be44: aa1d03fd    	mov	x29, x29
100f6be48: 95b2ecc0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6be4c: aa0003f5    	mov	x21, x0
100f6be50: 900f7688    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100f6be54: f947ed01    	ldr	x1, [x8, #0xfd8] ; lineHeight
100f6be58: 95b2ecb9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6be5c: 1e64c000    	frintp	d0, d0
100f6be60: 1e601001    	fmov	d1, #2.00000000
100f6be64: 1f41014a    	fmadd	d10, d10, d1, d0
100f6be68: aa1503e0    	mov	x0, x21
100f6be6c: 95b2ecba    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6be70: aa1703e0    	mov	x0, x23
100f6be74: 95b2ecb8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6be78: aa1603e0    	mov	x0, x22
100f6be7c: 95b2ecb6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6be80: aa1403e0    	mov	x0, x20
100f6be84: 95b2ecb4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6be88: 1e6a2120    	fcmp	d9, d10
100f6be8c: 1e694d49    	fcsel	d9, d10, d9, mi
100f6be90: d00f7888    	adrp	x8, 0x11fe7d000 <dyld_stub_binder+0x11fe7d000>
100f6be94: f940dd01    	ldr	x1, [x8, #0x1b8] ; isShowChatRoomDisplayName
100f6be98: aa1303e0    	mov	x0, x19
100f6be9c: 95b2eca8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bea0: 1e611000    	fmov	d0, #3.00000000
100f6bea4: 1e602920    	fadd	d0, d9, d0
100f6bea8: 7100001f    	cmp	w0, #0x0
100f6beac: 1e601d29    	fcsel	d9, d9, d0, ne
100f6beb0: f9415f21    	ldr	x1, [x25, #0x2b8] ; isTailPart
100f6beb4: aa1303e0    	mov	x0, x19
100f6beb8: 95b2eca1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bebc: 340006e0    	cbz	w0, 0x100f6bf98 <__text+0xf63f98>
100f6bec0: f9454b41    	ldr	x1, [x26, #0xa90] ; isRecordDetail
100f6bec4: aa1303e0    	mov	x0, x19
100f6bec8: 95b2ec9d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6becc: 37000660    	tbnz	w0, #0x0, 0x100f6bf98 <__text+0xf63f98>
100f6bed0: b00f78c8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f6bed4: f9461901    	ldr	x1, [x8, #0xc30] ; isShareConfirm
100f6bed8: aa1303e0    	mov	x0, x19
100f6bedc: 95b2ec98    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bee0: 370005c0    	tbnz	w0, #0x0, 0x100f6bf98 <__text+0xf63f98>
100f6bee4: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6bee8: f9403d13    	ldr	x19, [x8, #0x78] ; 8�6 
100f6beec: 900f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6bef0: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
100f6bef4: b00f8ca8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100f6bef8: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100f6befc: 95b2ec90    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bf00: aa1d03fd    	mov	x29, x29
100f6bf04: 95b2ec91    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6bf08: aa0003f4    	mov	x20, x0
100f6bf0c: b00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6bf10: f9404100    	ldr	x0, [x8, #0x80]
100f6bf14: 900f8ca8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f6bf18: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100f6bf1c: 95b2ec88    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bf20: aa0003e2    	mov	x2, x0
100f6bf24: d00f7668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f6bf28: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100f6bf2c: aa1403e0    	mov	x0, x20
100f6bf30: 95b2ec83    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bf34: aa1d03fd    	mov	x29, x29
100f6bf38: 95b2ec84    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6bf3c: aa0003f5    	mov	x21, x0
100f6bf40: 900f7688    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100f6bf44: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
100f6bf48: d00ea9e2    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
100f6bf4c: 9123a042    	add	x2, x2, #0x8e8
100f6bf50: d00ea9e3    	adrp	x3, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
100f6bf54: 91242063    	add	x3, x3, #0x908
100f6bf58: 95b2ec79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bf5c: aa1d03fd    	mov	x29, x29
100f6bf60: 95b2ec7a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6bf64: aa0003f6    	mov	x22, x0
100f6bf68: b00f7688    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100f6bf6c: f9400101    	ldr	x1, [x8]
100f6bf70: aa1303e0    	mov	x0, x19
100f6bf74: aa1603e2    	mov	x2, x22
100f6bf78: 95b2ec71    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6bf7c: 1e602929    	fadd	d9, d9, d0
100f6bf80: aa1603e0    	mov	x0, x22
100f6bf84: 95b2ec74    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6bf88: aa1503e0    	mov	x0, x21
100f6bf8c: 95b2ec72    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6bf90: aa1403e0    	mov	x0, x20
100f6bf94: 95b2ec70    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6bf98: 1e604100    	fmov	d0, d8
100f6bf9c: 1e604121    	fmov	d1, d9
100f6bfa0: a9497bfd    	ldp	x29, x30, [sp, #0x90]
100f6bfa4: a9484ff4    	ldp	x20, x19, [sp, #0x80]
100f6bfa8: a94757f6    	ldp	x22, x21, [sp, #0x70]
100f6bfac: a9465ff8    	ldp	x24, x23, [sp, #0x60]
100f6bfb0: a94567fa    	ldp	x26, x25, [sp, #0x50]
100f6bfb4: a9446ffc    	ldp	x28, x27, [sp, #0x40]
100f6bfb8: 6d4323e9    	ldp	d9, d8, [sp, #0x30]
100f6bfbc: 6d422beb    	ldp	d11, d10, [sp, #0x20]
100f6bfc0: 910283ff    	add	sp, sp, #0xa0
100f6bfc4: d65f03c0    	ret