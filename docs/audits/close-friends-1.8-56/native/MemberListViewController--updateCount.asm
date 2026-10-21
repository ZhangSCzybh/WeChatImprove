
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104adb570: d10243ff    	sub	sp, sp, #0x90
104adb574: 6d0223e9    	stp	d9, d8, [sp, #0x20]
104adb578: a9036ffc    	stp	x28, x27, [sp, #0x30]
104adb57c: a90467fa    	stp	x26, x25, [sp, #0x40]
104adb580: a9055ff8    	stp	x24, x23, [sp, #0x50]
104adb584: a90657f6    	stp	x22, x21, [sp, #0x60]
104adb588: a9074ff4    	stp	x20, x19, [sp, #0x70]
104adb58c: a9087bfd    	stp	x29, x30, [sp, #0x80]
104adb590: 910203fd    	add	x29, sp, #0x80
104adb594: aa0003f3    	mov	x19, x0
104adb598: f00e0b08    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104adb59c: 52800029    	mov	w9, #0x1                ; =1
104adb5a0: 3910b909    	strb	w9, [x8, #0x42e]
104adb5a4: 900db4c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104adb5a8: f9454518    	ldr	x24, [x8, #0xa88]
104adb5ac: 900db4c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104adb5b0: f945e900    	ldr	x0, [x8, #0xbd0]
104adb5b4: b00db128    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104adb5b8: f944e916    	ldr	x22, [x8, #0x9d0] ; currentContext
104adb5bc: aa1603e1    	mov	x1, x22
104adb5c0: 94c52edf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb5c4: aa1d03fd    	mov	x29, x29
104adb5c8: 94c52ee0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb5cc: aa0003f9    	mov	x25, x0
104adb5d0: 900db4c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104adb5d4: f9462900    	ldr	x0, [x8, #0xc50]
104adb5d8: 900db128    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104adb5dc: f947ad15    	ldr	x21, [x8, #0xf58] ; class
104adb5e0: aa1503e1    	mov	x1, x21
104adb5e4: 94c52ed6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb5e8: aa0003e2    	mov	x2, x0
104adb5ec: d00d9ae8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104adb5f0: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104adb5f4: aa1903e0    	mov	x0, x25
104adb5f8: f9000be1    	str	x1, [sp, #0x10]
104adb5fc: 94c52ed0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb600: aa1d03fd    	mov	x29, x29
104adb604: 94c52ed1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb608: aa0003fa    	mov	x26, x0
104adb60c: d00d9ae8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104adb610: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
104adb614: b00ce622    	adrp	x2, 0x11e7a0000 <dyld_stub_binder+0x11e7a0000>
104adb618: 9115a042    	add	x2, x2, #0x568
104adb61c: f90007e1    	str	x1, [sp, #0x8]
104adb620: 94c52ec7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb624: aa1d03fd    	mov	x29, x29
104adb628: 94c52ec8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb62c: aa0003fb    	mov	x27, x0
104adb630: 900dba48    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104adb634: b9869514    	ldrsw	x20, [x8, #0x694]
104adb638: f8746a60    	ldr	x0, [x19, x20]
104adb63c: f00d9e48    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
104adb640: f945e91c    	ldr	x28, [x8, #0xbd0] ; getTotalCount
104adb644: aa1c03e1    	mov	x1, x28
104adb648: 94c52ebd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb64c: f00db168    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104adb650: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
104adb654: f90003e0    	str	x0, [sp]
104adb658: aa1803e0    	mov	x0, x24
104adb65c: aa1b03e2    	mov	x2, x27
104adb660: 94c52eb7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb664: aa1d03fd    	mov	x29, x29
104adb668: 94c52eb8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb66c: aa0003f7    	mov	x23, x0
104adb670: 900dba48    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104adb674: b9869908    	ldrsw	x8, [x8, #0x698]
104adb678: f9000fe8    	str	x8, [sp, #0x18]
104adb67c: f8686a60    	ldr	x0, [x19, x8]
104adb680: d00db168    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104adb684: f9468d18    	ldr	x24, [x8, #0xd18] ; setText:
104adb688: aa1803e1    	mov	x1, x24
104adb68c: aa1703e2    	mov	x2, x23
104adb690: 94c52eab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb694: aa1703e0    	mov	x0, x23
104adb698: 94c52eaf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb69c: aa1b03e0    	mov	x0, x27
104adb6a0: 94c52ead    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb6a4: aa1a03e0    	mov	x0, x26
104adb6a8: 94c52eab    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb6ac: aa1903e0    	mov	x0, x25
104adb6b0: 94c52ea9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb6b4: f8746a60    	ldr	x0, [x19, x20]
104adb6b8: aa1c03e1    	mov	x1, x28
104adb6bc: 94c52ea0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb6c0: b40011a0    	cbz	x0, 0x104adb8f4 <_Flutter_MMFoundation_BindContext+0xfb74d8>
104adb6c4: b00db4c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104adb6c8: f9403d17    	ldr	x23, [x8, #0x78]
104adb6cc: 900db4c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104adb6d0: f945e900    	ldr	x0, [x8, #0xbd0]
104adb6d4: aa1603e1    	mov	x1, x22
104adb6d8: 94c52e99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb6dc: aa1d03fd    	mov	x29, x29
104adb6e0: 94c52e9a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb6e4: aa0003f6    	mov	x22, x0
104adb6e8: b00db4c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104adb6ec: f9404100    	ldr	x0, [x8, #0x80]
104adb6f0: aa1503e1    	mov	x1, x21
104adb6f4: 94c52e92    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb6f8: aa0003e2    	mov	x2, x0
104adb6fc: aa1603e0    	mov	x0, x22
104adb700: f9400be1    	ldr	x1, [sp, #0x10]
104adb704: 94c52e8e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb708: aa1d03fd    	mov	x29, x29
104adb70c: 94c52e8f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb710: aa0003f4    	mov	x20, x0
104adb714: 900d9b08    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104adb718: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
104adb71c: b00ce622    	adrp	x2, 0x11e7a0000 <dyld_stub_binder+0x11e7a0000>
104adb720: 9116a042    	add	x2, x2, #0x5a8
104adb724: b00ce623    	adrp	x3, 0x11e7a0000 <dyld_stub_binder+0x11e7a0000>
104adb728: 91172063    	add	x3, x3, #0x5c8
104adb72c: 94c52e84    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb730: aa1d03fd    	mov	x29, x29
104adb734: 94c52e85    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb738: aa0003f5    	mov	x21, x0
104adb73c: d00d9b08    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104adb740: f9401501    	ldr	x1, [x8, #0x28] ; parseFontFromValues:
104adb744: aa1703e0    	mov	x0, x23
104adb748: aa1503e2    	mov	x2, x21
104adb74c: 94c52e7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb750: aa1d03fd    	mov	x29, x29
104adb754: 94c52e7d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb758: aa0003f7    	mov	x23, x0
104adb75c: f9400ff8    	ldr	x24, [sp, #0x18]
104adb760: f8786a60    	ldr	x0, [x19, x24]
104adb764: b00db168    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104adb768: f9400501    	ldr	x1, [x8, #0x8] ; setFont:
104adb76c: aa1703e2    	mov	x2, x23
104adb770: 94c52e73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb774: aa1703e0    	mov	x0, x23
104adb778: 94c52e77    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb77c: aa1503e0    	mov	x0, x21
104adb780: 94c52e75    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb784: aa1403e0    	mov	x0, x20
104adb788: 94c52e73    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb78c: aa1603e0    	mov	x0, x22
104adb790: 94c52e71    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb794: 900db4d5    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
104adb798: f9462ea0    	ldr	x0, [x21, #0xc58]
104adb79c: b00d9b08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104adb7a0: f9406501    	ldr	x1, [x8, #0xc8] ; secondaryLabelColor
104adb7a4: 94c52e66    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb7a8: aa1d03fd    	mov	x29, x29
104adb7ac: 94c52e67    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb7b0: aa0003f4    	mov	x20, x0
104adb7b4: f8786a60    	ldr	x0, [x19, x24]
104adb7b8: d00db168    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104adb7bc: f9469501    	ldr	x1, [x8, #0xd28] ; setTextColor:
104adb7c0: aa1403e2    	mov	x2, x20
104adb7c4: 94c52e5e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb7c8: aa1403e0    	mov	x0, x20
104adb7cc: 94c52e62    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb7d0: f9462ea0    	ldr	x0, [x21, #0xc58]
104adb7d4: b00d9b08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104adb7d8: f943d501    	ldr	x1, [x8, #0x7a8] ; BG_2
104adb7dc: 94c52e58    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb7e0: aa1d03fd    	mov	x29, x29
104adb7e4: 94c52e59    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb7e8: aa0003f4    	mov	x20, x0
104adb7ec: 900dba48    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104adb7f0: b986a116    	ldrsw	x22, [x8, #0x6a0]
104adb7f4: f8766a60    	ldr	x0, [x19, x22]
104adb7f8: 900db168    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
104adb7fc: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
104adb800: aa1403e2    	mov	x2, x20
104adb804: 94c52e4e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb808: aa1403e0    	mov	x0, x20
104adb80c: 94c52e52    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb810: f9462ea0    	ldr	x0, [x21, #0xc58]
104adb814: b00d9b08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104adb818: f9479d01    	ldr	x1, [x8, #0xf38] ; tableViewTailColor
104adb81c: 94c52e48    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb820: aa1d03fd    	mov	x29, x29
104adb824: 94c52e49    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb828: aa0003f4    	mov	x20, x0
104adb82c: 900dba48    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104adb830: b9869d15    	ldrsw	x21, [x8, #0x69c]
104adb834: f8756a60    	ldr	x0, [x19, x21]
104adb838: b00d9b08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104adb83c: f947a101    	ldr	x1, [x8, #0xf40] ; setTailColor:
104adb840: aa1403e2    	mov	x2, x20
104adb844: 94c52e3e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb848: aa1403e0    	mov	x0, x20
104adb84c: 94c52e42    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb850: f8756a60    	ldr	x0, [x19, x21]
104adb854: d00db168    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104adb858: f9441501    	ldr	x1, [x8, #0x828] ; setScrollEnabled:
104adb85c: 52800022    	mov	w2, #0x1                ; =1
104adb860: 94c52e37    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb864: f8766a60    	ldr	x0, [x19, x22]
104adb868: b00db168    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104adb86c: f9410914    	ldr	x20, [x8, #0x210] ; setHeight:
104adb870: d2e80928    	mov	x8, #0x4049000000000000 ; =4632233691727265792
104adb874: 9e670100    	fmov	d0, x8
104adb878: aa1403e1    	mov	x1, x20
104adb87c: 94c52e30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb880: f8786a60    	ldr	x0, [x19, x24]
104adb884: f00db168    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104adb888: f941d901    	ldr	x1, [x8, #0x3b0] ; setY:
104adb88c: 1e65d000    	fmov	d0, #15.00000000
104adb890: 94c52e2b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb894: f8786a60    	ldr	x0, [x19, x24]
104adb898: d00db128    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
104adb89c: f9456d01    	ldr	x1, [x8, #0xad8] ; font
104adb8a0: 94c52e27    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb8a4: aa1d03fd    	mov	x29, x29
104adb8a8: 94c52e28    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb8ac: aa0003f5    	mov	x21, x0
104adb8b0: 900d9b08    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104adb8b4: f947ed01    	ldr	x1, [x8, #0xfd8] ; lineHeight
104adb8b8: 94c52e21    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb8bc: 1e64c000    	frintp	d0, d0
104adb8c0: f8786a60    	ldr	x0, [x19, x24]
104adb8c4: aa1403e1    	mov	x1, x20
104adb8c8: 94c52e1d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb8cc: aa1503e0    	mov	x0, x21
104adb8d0: a9487bfd    	ldp	x29, x30, [sp, #0x80]
104adb8d4: a9474ff4    	ldp	x20, x19, [sp, #0x70]
104adb8d8: a94657f6    	ldp	x22, x21, [sp, #0x60]
104adb8dc: a9455ff8    	ldp	x24, x23, [sp, #0x50]
104adb8e0: a94467fa    	ldp	x26, x25, [sp, #0x40]
104adb8e4: a9436ffc    	ldp	x28, x27, [sp, #0x30]
104adb8e8: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
104adb8ec: 910243ff    	add	sp, sp, #0x90
104adb8f0: 14c52e19    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb8f4: 900db4c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104adb8f8: f9461900    	ldr	x0, [x8, #0xc30]
104adb8fc: d00d9ae8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104adb900: f9464d01    	ldr	x1, [x8, #0xc98] ; dynamicSystemFontOfSize:
104adb904: 1e659000    	fmov	d0, #14.00000000
104adb908: 94c52e0d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb90c: aa1d03fd    	mov	x29, x29
104adb910: 94c52e0e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb914: aa0003f7    	mov	x23, x0
104adb918: f9400ff9    	ldr	x25, [sp, #0x18]
104adb91c: f8796a60    	ldr	x0, [x19, x25]
104adb920: b00db168    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104adb924: f9400501    	ldr	x1, [x8, #0x8] ; setFont:
104adb928: aa1703e2    	mov	x2, x23
104adb92c: 94c52e04    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb930: aa1703e0    	mov	x0, x23
104adb934: 94c52e08    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb938: 900db4c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104adb93c: f9462d00    	ldr	x0, [x8, #0xc58]
104adb940: f00d9b08    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104adb944: f9465101    	ldr	x1, [x8, #0xca0] ; FG_2
104adb948: 94c52dfd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb94c: aa1d03fd    	mov	x29, x29
104adb950: 94c52dfe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb954: aa0003f7    	mov	x23, x0
104adb958: f8796a60    	ldr	x0, [x19, x25]
104adb95c: d00db168    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104adb960: f9469501    	ldr	x1, [x8, #0xd28] ; setTextColor:
104adb964: aa1703e2    	mov	x2, x23
104adb968: 94c52df5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb96c: aa1703e0    	mov	x0, x23
104adb970: 94c52df9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb974: 900db4c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104adb978: f945e900    	ldr	x0, [x8, #0xbd0]
104adb97c: aa1603e1    	mov	x1, x22
104adb980: 94c52def    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb984: aa1d03fd    	mov	x29, x29
104adb988: 94c52df0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb98c: aa0003f6    	mov	x22, x0
104adb990: 900db4c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104adb994: f9462900    	ldr	x0, [x8, #0xc50]
104adb998: aa1503e1    	mov	x1, x21
104adb99c: 94c52de8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb9a0: aa0003e2    	mov	x2, x0
104adb9a4: aa1603e0    	mov	x0, x22
104adb9a8: f9400be1    	ldr	x1, [sp, #0x10]
104adb9ac: 94c52de4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb9b0: aa1d03fd    	mov	x29, x29
104adb9b4: 94c52de5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb9b8: aa0003f4    	mov	x20, x0
104adb9bc: b00ce622    	adrp	x2, 0x11e7a0000 <dyld_stub_binder+0x11e7a0000>
104adb9c0: 91162042    	add	x2, x2, #0x588
104adb9c4: f94007e1    	ldr	x1, [sp, #0x8]
104adb9c8: 94c52ddd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb9cc: aa1d03fd    	mov	x29, x29
104adb9d0: 94c52dde    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adb9d4: aa0003f5    	mov	x21, x0
104adb9d8: f8796a60    	ldr	x0, [x19, x25]
104adb9dc: aa1803e1    	mov	x1, x24
104adb9e0: aa1503e2    	mov	x2, x21
104adb9e4: 94c52dd6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adb9e8: aa1503e0    	mov	x0, x21
104adb9ec: 94c52dda    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb9f0: aa1403e0    	mov	x0, x20
104adb9f4: 94c52dd8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adb9f8: aa1603e0    	mov	x0, x22
104adb9fc: 94c52dd6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adba00: f8796a74    	ldr	x20, [x19, x25]
104adba04: 900db4c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104adba08: f9470100    	ldr	x0, [x8, #0xe00]
104adba0c: b00d9b08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104adba10: f9419101    	ldr	x1, [x8, #0x320] ; pageScopeWidthFor:
104adba14: aa1303e2    	mov	x2, x19
104adba18: 94c52dc9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adba1c: d2f80908    	mov	x8, #-0x3fb8000000000000 ; =-4591419820104220672
104adba20: 9e670101    	fmov	d1, x8
104adba24: 1e612802    	fadd	d2, d0, d1
104adba28: b00db168    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104adba2c: f9403501    	ldr	x1, [x8, #0x68] ; setFrame:
104adba30: 1e671000    	fmov	d0, #24.00000000
104adba34: 1e65d001    	fmov	d1, #15.00000000
104adba38: 1e669003    	fmov	d3, #20.00000000
104adba3c: aa1403e0    	mov	x0, x20
104adba40: 94c52dbf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adba44: f8796a60    	ldr	x0, [x19, x25]
104adba48: b00db168    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104adba4c: f947f901    	ldr	x1, [x8, #0xff0] ; setNumberOfLines:
104adba50: d2800002    	mov	x2, #0x0                ; =0
104adba54: 94c52dba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adba58: b00db4c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104adba5c: f9404900    	ldr	x0, [x8, #0x90]
104adba60: f8796a62    	ldr	x2, [x19, x25]
104adba64: f00d9b28    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
104adba68: f9463101    	ldr	x1, [x8, #0xc60] ; labelHeight:
104adba6c: 94c52db4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adba70: 1e624000    	fcvt	s0, d0
104adba74: 1e22c000    	fcvt	d0, s0
104adba78: f8796a60    	ldr	x0, [x19, x25]
104adba7c: b00db168    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104adba80: f9410915    	ldr	x21, [x8, #0x210] ; setHeight:
104adba84: aa1503e1    	mov	x1, x21
104adba88: 94c52dad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adba8c: 900dba48    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104adba90: b9869d17    	ldrsw	x23, [x8, #0x69c]
104adba94: f8776a60    	ldr	x0, [x19, x23]
104adba98: f00db128    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104adba9c: f9449d14    	ldr	x20, [x8, #0x938] ; height
104adbaa0: aa1403e1    	mov	x1, x20
104adbaa4: 94c52da6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adbaa8: 1e604008    	fmov	d8, d0
104adbaac: f8776a60    	ldr	x0, [x19, x23]
104adbab0: f00db108    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
104adbab4: f947c116    	ldr	x22, [x8, #0xf80] ; adjustedContentInset
104adbab8: aa1603e1    	mov	x1, x22
104adbabc: 94c52da0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adbac0: 1e603908    	fsub	d8, d8, d0
104adbac4: f8776a60    	ldr	x0, [x19, x23]
104adbac8: aa1603e1    	mov	x1, x22
104adbacc: 94c52d9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adbad0: 1e623900    	fsub	d0, d8, d2
104adbad4: 900dba48    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104adbad8: b986a116    	ldrsw	x22, [x8, #0x6a0]
104adbadc: f8766a60    	ldr	x0, [x19, x22]
104adbae0: aa1503e1    	mov	x1, x21
104adbae4: 94c52d96    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adbae8: 900db4c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104adbaec: f9463100    	ldr	x0, [x8, #0xc60]
104adbaf0: 900db128    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104adbaf4: f947dd01    	ldr	x1, [x8, #0xfb8] ; clearColor
104adbaf8: 94c52d91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adbafc: aa1d03fd    	mov	x29, x29
104adbb00: 94c52d92    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adbb04: aa0003f5    	mov	x21, x0
104adbb08: f8766a60    	ldr	x0, [x19, x22]
104adbb0c: 900db168    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
104adbb10: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
104adbb14: aa1503e2    	mov	x2, x21
104adbb18: 94c52d89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adbb1c: aa1503e0    	mov	x0, x21
104adbb20: 94c52d8d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adbb24: f8776a60    	ldr	x0, [x19, x23]
104adbb28: b00d9b08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104adbb2c: f947a101    	ldr	x1, [x8, #0xf40] ; setTailColor:
104adbb30: d2800002    	mov	x2, #0x0                ; =0
104adbb34: 94c52d82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adbb38: f8766a60    	ldr	x0, [x19, x22]
104adbb3c: aa1403e1    	mov	x1, x20
104adbb40: 94c52d7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adbb44: d00a1528    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
104adbb48: fd42c101    	ldr	d1, [x8, #0x580]
104adbb4c: 1e610800    	fmul	d0, d0, d1
104adbb50: f8796a60    	ldr	x0, [x19, x25]
104adbb54: b00d9b08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104adbb58: f9401901    	ldr	x1, [x8, #0x30] ; setCenterY:
104adbb5c: 94c52d78    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adbb60: f8776a60    	ldr	x0, [x19, x23]
104adbb64: d00db168    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104adbb68: f9441501    	ldr	x1, [x8, #0x828] ; setScrollEnabled:
104adbb6c: 52800002    	mov	w2, #0x0                ; =0
104adbb70: 94c52d73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adbb74: f8776a60    	ldr	x0, [x19, x23]
104adbb78: b00d9b08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104adbb7c: f940d901    	ldr	x1, [x8, #0x1b0] ; setTableHeaderView:
104adbb80: d2800002    	mov	x2, #0x0                ; =0
104adbb84: a9487bfd    	ldp	x29, x30, [sp, #0x80]
104adbb88: a9474ff4    	ldp	x20, x19, [sp, #0x70]
104adbb8c: a94657f6    	ldp	x22, x21, [sp, #0x60]
104adbb90: a9455ff8    	ldp	x24, x23, [sp, #0x50]
104adbb94: a94467fa    	ldp	x26, x25, [sp, #0x40]
104adbb98: a9436ffc    	ldp	x28, x27, [sp, #0x30]
104adbb9c: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
104adbba0: 910243ff    	add	sp, sp, #0x90
104adbba4: 14c52d66    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
