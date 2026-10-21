
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106e9062c: d10243ff    	sub	sp, sp, #0x90
106e90630: a9036ffc    	stp	x28, x27, [sp, #0x30]
106e90634: a90467fa    	stp	x26, x25, [sp, #0x40]
106e90638: a9055ff8    	stp	x24, x23, [sp, #0x50]
106e9063c: a90657f6    	stp	x22, x21, [sp, #0x60]
106e90640: a9074ff4    	stp	x20, x19, [sp, #0x70]
106e90644: a9087bfd    	stp	x29, x30, [sp, #0x80]
106e90648: 910203fd    	add	x29, sp, #0x80
106e9064c: aa0503f7    	mov	x23, x5
106e90650: aa0403f6    	mov	x22, x4
106e90654: aa0303f4    	mov	x20, x3
106e90658: aa0203fa    	mov	x26, x2
106e9065c: aa0003f5    	mov	x21, x0
106e90660: d00ceda8    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
106e90664: 52800029    	mov	w9, #0x1                ; =1
106e90668: 391aed09    	strb	w9, [x8, #0x6bb]
106e9066c: aa0203e0    	mov	x0, x2
106e90670: 94365ab2    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e90674: aa1403e0    	mov	x0, x20
106e90678: 94365ab0    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e9067c: 34000bd7    	cbz	w23, 0x106e907f4 <_Flutter_MMFoundation_BindContext+0x336c3d8>
106e90680: f90017fa    	str	x26, [sp, #0x28]
106e90684: b00c9da8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e90688: b985c513    	ldrsw	x19, [x8, #0x5c4]
106e9068c: f8736aa0    	ldr	x0, [x21, x19]
106e90690: d00c8148    	adrp	x8, 0x11feba000 <dyld_stub_binder+0x11feba000>
106e90694: f942c118    	ldr	x24, [x8, #0x580] ; commentID
106e90698: aa1803e1    	mov	x1, x24
106e9069c: 94365aa8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e906a0: aa1d03fd    	mov	x29, x29
106e906a4: 94365aa9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e906a8: aa0003f7    	mov	x23, x0
106e906ac: aa1403e0    	mov	x0, x20
106e906b0: aa1803e1    	mov	x1, x24
106e906b4: 94365aa2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e906b8: aa1d03fd    	mov	x29, x29
106e906bc: 94365aa3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e906c0: aa0003f8    	mov	x24, x0
106e906c4: f00c9388    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106e906c8: f943c91c    	ldr	x28, [x8, #0x790] ; isEqualToString:
106e906cc: aa1703e0    	mov	x0, x23
106e906d0: aa1c03e1    	mov	x1, x28
106e906d4: aa1803e2    	mov	x2, x24
106e906d8: 94365a99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e906dc: aa0003fa    	mov	x26, x0
106e906e0: 34000960    	cbz	w0, 0x106e9080c <_Flutter_MMFoundation_BindContext+0x336c3f0>
106e906e4: f8736aa0    	ldr	x0, [x21, x19]
106e906e8: f00c8148    	adrp	x8, 0x11febb000 <dyld_stub_binder+0x11febb000>
106e906ec: f947551b    	ldr	x27, [x8, #0xea8] ; comment64ID
106e906f0: aa1b03e1    	mov	x1, x27
106e906f4: 94365a92    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e906f8: aa1d03fd    	mov	x29, x29
106e906fc: 94365a93    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90700: aa0003f9    	mov	x25, x0
106e90704: aa1403e0    	mov	x0, x20
106e90708: aa1b03e1    	mov	x1, x27
106e9070c: 94365a8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90710: aa1d03fd    	mov	x29, x29
106e90714: 94365a8d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90718: aa0003fb    	mov	x27, x0
106e9071c: aa1903e0    	mov	x0, x25
106e90720: aa1c03e1    	mov	x1, x28
106e90724: aa1b03e2    	mov	x2, x27
106e90728: 94365a85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e9072c: 36000700    	tbz	w0, #0x0, 0x106e9080c <_Flutter_MMFoundation_BindContext+0x336c3f0>
106e90730: aa1b03e0    	mov	x0, x27
106e90734: 94365a88    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90738: aa1903e0    	mov	x0, x25
106e9073c: 94365a86    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90740: aa1803e0    	mov	x0, x24
106e90744: 94365a84    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90748: aa1703e0    	mov	x0, x23
106e9074c: 94365a82    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90750: 8b1302a0    	add	x0, x21, x19
106e90754: aa1403e1    	mov	x1, x20
106e90758: 94365a7a    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
106e9075c: d00c8b68    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e90760: f9448901    	ldr	x1, [x8, #0x910] ; becomeInput
106e90764: aa1503e0    	mov	x0, x21
106e90768: 94365a75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e9076c: f00c9708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e90770: f945e900    	ldr	x0, [x8, #0xbd0]
106e90774: 900c9388    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106e90778: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
106e9077c: 94365a70    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90780: aa1d03fd    	mov	x29, x29
106e90784: 94365a71    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90788: aa0003f6    	mov	x22, x0
106e9078c: 900c9728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106e90790: f9428500    	ldr	x0, [x8, #0x508]
106e90794: f00c9368    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106e90798: f947ad01    	ldr	x1, [x8, #0xf58] ; class
106e9079c: 94365a68    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e907a0: aa0003e2    	mov	x2, x0
106e907a4: b00c7d48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e907a8: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
106e907ac: aa1603e0    	mov	x0, x22
106e907b0: 94365a63    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e907b4: aa1d03fd    	mov	x29, x29
106e907b8: 94365a64    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e907bc: aa0003f7    	mov	x23, x0
106e907c0: b00c9da8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e907c4: b9844d08    	ldrsw	x8, [x8, #0x44c]
106e907c8: f8686aa2    	ldr	x2, [x21, x8]
106e907cc: f8736aa3    	ldr	x3, [x21, x19]
106e907d0: d00c8b68    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e907d4: f9448d01    	ldr	x1, [x8, #0x918] ; logStartRefCommentFeed:refComment:
106e907d8: 94365a59    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e907dc: aa1703e0    	mov	x0, x23
106e907e0: 94365a5d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e907e4: aa1603e0    	mov	x0, x22
106e907e8: 94365a5b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e907ec: f94017fa    	ldr	x26, [sp, #0x28]
106e907f0: 140000ce    	b	0x106e90b28 <_Flutter_MMFoundation_BindContext+0x336c70c>
106e907f4: d00c8b68    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e907f8: f9448101    	ldr	x1, [x8, #0x900] ; showConfirmDeleteAlert:
106e907fc: aa1503e0    	mov	x0, x21
106e90800: aa1603e2    	mov	x2, x22
106e90804: 94365a4e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90808: 140000c8    	b	0x106e90b28 <_Flutter_MMFoundation_BindContext+0x336c70c>
106e9080c: b00c9da8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e90810: b985b108    	ldrsw	x8, [x8, #0x5b0]
106e90814: f8686aa0    	ldr	x0, [x21, x8]
106e90818: f00c93c8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
106e9081c: f9401501    	ldr	x1, [x8, #0x28] ; text
106e90820: 94365a47    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90824: aa1d03fd    	mov	x29, x29
106e90828: 94365a48    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e9082c: aa0003fc    	mov	x28, x0
106e90830: f00c9388    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106e90834: f946e901    	ldr	x1, [x8, #0xdd0] ; length
106e90838: 94365a41    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e9083c: b5000120    	cbnz	x0, 0x106e90860 <_Flutter_MMFoundation_BindContext+0x336c444>
106e90840: d00c86c8    	adrp	x8, 0x11ff6a000 <dyld_stub_binder+0x11ff6a000>
106e90844: f947e501    	ldr	x1, [x8, #0xfc8] ; selectedImage
106e90848: aa1503e0    	mov	x0, x21
106e9084c: 94365a3c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90850: aa1d03fd    	mov	x29, x29
106e90854: 94365a3d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90858: b40017e0    	cbz	x0, 0x106e90b54 <_Flutter_MMFoundation_BindContext+0x336c738>
106e9085c: 94365a3e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90860: aa1c03e0    	mov	x0, x28
106e90864: 94365a3c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90868: 360000ba    	tbz	w26, #0x0, 0x106e9087c <_Flutter_MMFoundation_BindContext+0x336c460>
106e9086c: aa1b03e0    	mov	x0, x27
106e90870: 94365a39    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90874: aa1903e0    	mov	x0, x25
106e90878: 94365a37    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e9087c: aa1803e0    	mov	x0, x24
106e90880: 94365a35    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90884: aa1703e0    	mov	x0, x23
106e90888: 94365a33    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e9088c: b00c9da8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e90890: b9847d0a    	ldrsw	x10, [x8, #0x47c]
106e90894: 386a6aa8    	ldrb	w8, [x21, x10]
106e90898: 900c9389    	adrp	x9, 0x120100000 <dyld_stub_binder+0x120100000>
106e9089c: f944e93c    	ldr	x28, [x9, #0x9d0] ; currentContext
106e908a0: f00c9709    	adrp	x9, 0x120173000 <dyld_stub_binder+0x120173000>
106e908a4: 7100051f    	cmp	w8, #0x1
106e908a8: 540000e1    	b.ne	0x106e908c4 <_Flutter_MMFoundation_BindContext+0x336c4a8>
106e908ac: f00c9368    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106e908b0: f947ad18    	ldr	x24, [x8, #0xf58] ; class
106e908b4: b00c7d48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e908b8: f9464119    	ldr	x25, [x8, #0xc80] ; getService:
106e908bc: f94017fa    	ldr	x26, [sp, #0x28]
106e908c0: 1400007f    	b	0x106e90abc <_Flutter_MMFoundation_BindContext+0x336c6a0>
106e908c4: f00c9708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e908c8: f9454513    	ldr	x19, [x8, #0xa88]
106e908cc: f945e920    	ldr	x0, [x9, #0xbd0]
106e908d0: aa1c03e1    	mov	x1, x28
106e908d4: f9000bea    	str	x10, [sp, #0x10]
106e908d8: 94365a19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e908dc: aa1d03fd    	mov	x29, x29
106e908e0: 94365a1a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e908e4: f90013fc    	str	x28, [sp, #0x20]
106e908e8: aa0003fc    	mov	x28, x0
106e908ec: f00c9708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e908f0: f9462900    	ldr	x0, [x8, #0xc50]
106e908f4: f00c9368    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106e908f8: f947ad18    	ldr	x24, [x8, #0xf58] ; class
106e908fc: aa1803e1    	mov	x1, x24
106e90900: 94365a0f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90904: aa0003e2    	mov	x2, x0
106e90908: b00c7d48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e9090c: f9464119    	ldr	x25, [x8, #0xc80] ; getService:
106e90910: aa1c03e0    	mov	x0, x28
106e90914: aa1903e1    	mov	x1, x25
106e90918: 94365a09    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e9091c: aa1d03fd    	mov	x29, x29
106e90920: 94365a0a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90924: f9000ff6    	str	x22, [sp, #0x18]
106e90928: aa0003f6    	mov	x22, x0
106e9092c: b00c7d48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e90930: f946451b    	ldr	x27, [x8, #0xc88] ; getStringForCurLanguage:
106e90934: 900bd2e2    	adrp	x2, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
106e90938: 9135a042    	add	x2, x2, #0xd68
106e9093c: aa1b03e1    	mov	x1, x27
106e90940: 943659ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90944: aa1d03fd    	mov	x29, x29
106e90948: 94365a00    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e9094c: aa0003fa    	mov	x26, x0
106e90950: d00c8b68    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e90954: f943c501    	ldr	x1, [x8, #0x788] ; getReplyNickNameFromComment:
106e90958: aa1503e0    	mov	x0, x21
106e9095c: aa1403e2    	mov	x2, x20
106e90960: 943659f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90964: aa1d03fd    	mov	x29, x29
106e90968: 943659f8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e9096c: aa0003f7    	mov	x23, x0
106e90970: d00c93c8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106e90974: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
106e90978: f90003e0    	str	x0, [sp]
106e9097c: aa1303e0    	mov	x0, x19
106e90980: aa1a03e2    	mov	x2, x26
106e90984: 943659ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90988: aa1d03fd    	mov	x29, x29
106e9098c: 943659ef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90990: aa0003f3    	mov	x19, x0
106e90994: aa1703e0    	mov	x0, x23
106e90998: 943659ef    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e9099c: aa1a03e0    	mov	x0, x26
106e909a0: 943659ed    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e909a4: aa1603e0    	mov	x0, x22
106e909a8: 943659eb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e909ac: aa1c03e0    	mov	x0, x28
106e909b0: f94013fc    	ldr	x28, [sp, #0x20]
106e909b4: 943659e8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e909b8: 900c9728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106e909bc: f9405100    	ldr	x0, [x8, #0xa0]
106e909c0: 943659e8    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106e909c4: aa0003f6    	mov	x22, x0
106e909c8: f00c9708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e909cc: f945e900    	ldr	x0, [x8, #0xbd0]
106e909d0: aa1c03e1    	mov	x1, x28
106e909d4: 943659da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e909d8: aa1d03fd    	mov	x29, x29
106e909dc: 943659db    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e909e0: aa0003f7    	mov	x23, x0
106e909e4: f00c9708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e909e8: f9462900    	ldr	x0, [x8, #0xc50]
106e909ec: aa1803e1    	mov	x1, x24
106e909f0: 943659d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e909f4: aa0003e2    	mov	x2, x0
106e909f8: aa1703e0    	mov	x0, x23
106e909fc: aa1903e1    	mov	x1, x25
106e90a00: 943659cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90a04: aa1d03fd    	mov	x29, x29
106e90a08: 943659d0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90a0c: aa0003fa    	mov	x26, x0
106e90a10: f00bb062    	adrp	x2, 0x11e49f000 <dyld_stub_binder+0x11e49f000>
106e90a14: 9128a042    	add	x2, x2, #0xa28
106e90a18: aa1b03e1    	mov	x1, x27
106e90a1c: 943659c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90a20: aa1d03fd    	mov	x29, x29
106e90a24: 943659c9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90a28: aa0003fb    	mov	x27, x0
106e90a2c: 900c7d68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e90a30: f9406901    	ldr	x1, [x8, #0xd0] ; initWithTitle:delegate:cancelButtonTitle:destructiveButtonTitle:otherButtonTitles:
106e90a34: f90003ff    	str	xzr, [sp]
106e90a38: aa1603e0    	mov	x0, x22
106e90a3c: d2800002    	mov	x2, #0x0                ; =0
106e90a40: aa1503e3    	mov	x3, x21
106e90a44: aa1b03e4    	mov	x4, x27
106e90a48: d2800005    	mov	x5, #0x0                ; =0
106e90a4c: aa1303e6    	mov	x6, x19
106e90a50: 943659bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90a54: aa0003f6    	mov	x22, x0
106e90a58: aa1b03e0    	mov	x0, x27
106e90a5c: 943659be    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90a60: aa1a03e0    	mov	x0, x26
106e90a64: 943659bc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90a68: aa1703e0    	mov	x0, x23
106e90a6c: 943659ba    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90a70: b00c93c8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
106e90a74: f9466501    	ldr	x1, [x8, #0xcc8] ; setTag:
106e90a78: aa1603e0    	mov	x0, x22
106e90a7c: f9400fe2    	ldr	x2, [sp, #0x18]
106e90a80: 943659af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90a84: 900c7d68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e90a88: f9407101    	ldr	x1, [x8, #0xe0] ; showInView:
106e90a8c: aa1603e0    	mov	x0, x22
106e90a90: f94017fa    	ldr	x26, [sp, #0x28]
106e90a94: aa1a03e2    	mov	x2, x26
106e90a98: 943659a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90a9c: 52800028    	mov	w8, #0x1                ; =1
106e90aa0: f9400be9    	ldr	x9, [sp, #0x10]
106e90aa4: 38296aa8    	strb	w8, [x21, x9]
106e90aa8: aa1603e0    	mov	x0, x22
106e90aac: 943659aa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90ab0: aa1303e0    	mov	x0, x19
106e90ab4: 943659a8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90ab8: f00c9709    	adrp	x9, 0x120173000 <dyld_stub_binder+0x120173000>
106e90abc: f945e920    	ldr	x0, [x9, #0xbd0]
106e90ac0: aa1c03e1    	mov	x1, x28
106e90ac4: 9436599e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90ac8: aa1d03fd    	mov	x29, x29
106e90acc: 9436599f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90ad0: aa0003f6    	mov	x22, x0
106e90ad4: 900c9728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106e90ad8: f9428500    	ldr	x0, [x8, #0x508]
106e90adc: aa1803e1    	mov	x1, x24
106e90ae0: 94365997    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90ae4: aa0003e2    	mov	x2, x0
106e90ae8: aa1603e0    	mov	x0, x22
106e90aec: aa1903e1    	mov	x1, x25
106e90af0: 94365993    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90af4: aa1d03fd    	mov	x29, x29
106e90af8: 94365994    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90afc: aa0003f7    	mov	x23, x0
106e90b00: b00c9da8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e90b04: b9844d08    	ldrsw	x8, [x8, #0x44c]
106e90b08: f8686aa2    	ldr	x2, [x21, x8]
106e90b0c: d00c8b68    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e90b10: f9448501    	ldr	x1, [x8, #0x908] ; logStartCommentFeed:
106e90b14: 9436598a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90b18: aa1703e0    	mov	x0, x23
106e90b1c: 9436598e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90b20: aa1603e0    	mov	x0, x22
106e90b24: 9436598c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90b28: aa1403e0    	mov	x0, x20
106e90b2c: 9436598a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90b30: aa1a03e0    	mov	x0, x26
106e90b34: a9487bfd    	ldp	x29, x30, [sp, #0x80]
106e90b38: a9474ff4    	ldp	x20, x19, [sp, #0x70]
106e90b3c: a94657f6    	ldp	x22, x21, [sp, #0x60]
106e90b40: a9455ff8    	ldp	x24, x23, [sp, #0x50]
106e90b44: a94467fa    	ldp	x26, x25, [sp, #0x40]
106e90b48: a9436ffc    	ldp	x28, x27, [sp, #0x30]
106e90b4c: 910243ff    	add	sp, sp, #0x90
106e90b50: 14365981    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90b54: f00c7d68    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
106e90b58: f9408901    	ldr	x1, [x8, #0x110] ; emoticonWrap
106e90b5c: aa1503e0    	mov	x0, x21
106e90b60: 94365977    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90b64: aa1d03fd    	mov	x29, x29
106e90b68: 94365978    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90b6c: f90013e0    	str	x0, [sp, #0x20]
106e90b70: 94365979    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90b74: aa1c03e0    	mov	x0, x28
106e90b78: 94365977    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90b7c: 360000ba    	tbz	w26, #0x0, 0x106e90b90 <_Flutter_MMFoundation_BindContext+0x336c774>
106e90b80: aa1b03e0    	mov	x0, x27
106e90b84: 94365974    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90b88: aa1903e0    	mov	x0, x25
106e90b8c: 94365972    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90b90: aa1803e0    	mov	x0, x24
106e90b94: 94365970    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90b98: aa1703e0    	mov	x0, x23
106e90b9c: 9436596e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90ba0: f94013e8    	ldr	x8, [sp, #0x20]
106e90ba4: b5ffe748    	cbnz	x8, 0x106e9088c <_Flutter_MMFoundation_BindContext+0x336c470>
106e90ba8: 17fffeea    	b	0x106e90750 <_Flutter_MMFoundation_BindContext+0x336c334>
