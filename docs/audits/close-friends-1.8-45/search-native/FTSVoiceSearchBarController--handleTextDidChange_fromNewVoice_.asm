
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10182a438: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
10182a43c: a9015ff8    	stp	x24, x23, [sp, #0x10]
10182a440: a90257f6    	stp	x22, x21, [sp, #0x20]
10182a444: a9034ff4    	stp	x20, x19, [sp, #0x30]
10182a448: a9047bfd    	stp	x29, x30, [sp, #0x40]
10182a44c: 910103fd    	add	x29, sp, #0x40
10182a450: aa0303f7    	mov	x23, x3
10182a454: aa0203f3    	mov	x19, x2
10182a458: aa0003f5    	mov	x21, x0
10182a45c: 900fa048    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
10182a460: 52800029    	mov	w9, #0x1                ; =1
10182a464: 392ce509    	strb	w9, [x8, #0xb39]
10182a468: aa0203e0    	mov	x0, x2
10182a46c: 958ff333    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10182a470: aa1503f8    	mov	x24, x21
10182a474: f8440f14    	ldr	x20, [x24, #0x40]!
10182a478: aa1403e0    	mov	x0, x20
10182a47c: 958ff32f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10182a480: b00f46c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10182a484: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
10182a488: aa1303e0    	mov	x0, x19
10182a48c: aa1403e2    	mov	x2, x20
10182a490: 958ff32b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a494: 37001040    	tbnz	w0, #0x0, 0x10182a69c <__text+0x182269c>
10182a498: b00f3408    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10182a49c: f943e501    	ldr	x1, [x8, #0x7c8] ; searchIntentionController
10182a4a0: aa1503e0    	mov	x0, x21
10182a4a4: 958ff326    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a4a8: aa1d03fd    	mov	x29, x29
10182a4ac: 958ff327    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a4b0: aa0003f6    	mov	x22, x0
10182a4b4: b00f3408    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10182a4b8: f9459d01    	ldr	x1, [x8, #0xb38] ; insertSearchTextInputWithPrefix:
10182a4bc: aa1303e2    	mov	x2, x19
10182a4c0: 958ff31f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a4c4: aa1603e0    	mov	x0, x22
10182a4c8: 958ff323    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a4cc: b00f46c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10182a4d0: f946e916    	ldr	x22, [x8, #0xdd0] ; length
10182a4d4: aa1303e0    	mov	x0, x19
10182a4d8: aa1603e1    	mov	x1, x22
10182a4dc: 958ff318    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a4e0: b4000080    	cbz	x0, 0x10182a4f0 <__text+0x18224f0>
10182a4e4: aa1803e0    	mov	x0, x24
10182a4e8: aa1303e1    	mov	x1, x19
10182a4ec: 958ff315    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
10182a4f0: b00f3408    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10182a4f4: f945a101    	ldr	x1, [x8, #0xb40] ; resetDataSource
10182a4f8: aa1503e0    	mov	x0, x21
10182a4fc: 958ff310    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a500: aa1303e0    	mov	x0, x19
10182a504: aa1603e1    	mov	x1, x22
10182a508: 958ff30d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a50c: b4000620    	cbz	x0, 0x10182a5d0 <__text+0x18225d0>
10182a510: 370000d7    	tbnz	w23, #0x0, 0x10182a528 <__text+0x1822528>
10182a514: f00f33e8    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
10182a518: f9426101    	ldr	x1, [x8, #0x4c0] ; setIsFromNewVoice:
10182a51c: aa1503e0    	mov	x0, x21
10182a520: 52800002    	mov	w2, #0x0                ; =0
10182a524: 958ff306    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a528: aa1403e0    	mov	x0, x20
10182a52c: aa1603e1    	mov	x1, x22
10182a530: 958ff303    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a534: aa0003f7    	mov	x23, x0
10182a538: aa1303e0    	mov	x0, x19
10182a53c: aa1603e1    	mov	x1, x22
10182a540: 958ff2ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a544: aa0003f8    	mov	x24, x0
10182a548: b00f4a48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10182a54c: f945e900    	ldr	x0, [x8, #0xbd0]
10182a550: d00f46a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10182a554: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10182a558: 958ff2f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a55c: aa1d03fd    	mov	x29, x29
10182a560: 958ff2fa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a564: aa0003f9    	mov	x25, x0
10182a568: b00f4a48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10182a56c: f9477100    	ldr	x0, [x8, #0xee0]
10182a570: b00f46a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10182a574: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10182a578: 958ff2f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a57c: aa0003e2    	mov	x2, x0
10182a580: f00f3068    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10182a584: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10182a588: aa1903e0    	mov	x0, x25
10182a58c: 958ff2ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a590: aa1d03fd    	mov	x29, x29
10182a594: 958ff2ed    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a598: aa0003fa    	mov	x26, x0
10182a59c: b00f3408    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10182a5a0: f945a501    	ldr	x1, [x8, #0xb48] ; updateNewestHomePageSearchText:
10182a5a4: aa1303e2    	mov	x2, x19
10182a5a8: 958ff2e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a5ac: aa1a03e0    	mov	x0, x26
10182a5b0: 958ff2e9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a5b4: aa1903e0    	mov	x0, x25
10182a5b8: 958ff2e7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a5bc: eb1802ff    	cmp	x23, x24
10182a5c0: 540004c9    	b.ls	0x10182a658 <__text+0x1822658>
10182a5c4: f00f32e8    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
10182a5c8: f9445901    	ldr	x1, [x8, #0x8b0] ; delaySearch:slowMode:
10182a5cc: 14000029    	b	0x10182a670 <__text+0x1822670>
10182a5d0: b00f4a48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10182a5d4: f945e900    	ldr	x0, [x8, #0xbd0]
10182a5d8: d00f46a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10182a5dc: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10182a5e0: 958ff2d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a5e4: aa1d03fd    	mov	x29, x29
10182a5e8: 958ff2d8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a5ec: aa0003f6    	mov	x22, x0
10182a5f0: b00f4a48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10182a5f4: f9477100    	ldr	x0, [x8, #0xee0]
10182a5f8: b00f46a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10182a5fc: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10182a600: 958ff2cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a604: aa0003e2    	mov	x2, x0
10182a608: f00f3068    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10182a60c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10182a610: aa1603e0    	mov	x0, x22
10182a614: 958ff2ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a618: aa1d03fd    	mov	x29, x29
10182a61c: 958ff2cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a620: aa0003f7    	mov	x23, x0
10182a624: b00f3408    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10182a628: f945a501    	ldr	x1, [x8, #0xb48] ; updateNewestHomePageSearchText:
10182a62c: d2800002    	mov	x2, #0x0                ; =0
10182a630: 958ff2c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a634: aa1703e0    	mov	x0, x23
10182a638: 958ff2c7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a63c: aa1603e0    	mov	x0, x22
10182a640: 958ff2c5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a644: b00f3408    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10182a648: f9459501    	ldr	x1, [x8, #0xb28] ; cancelFTSSearch
10182a64c: aa1503e0    	mov	x0, x21
10182a650: 958ff2bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a654: 14000012    	b	0x10182a69c <__text+0x182269c>
10182a658: aa1403e0    	mov	x0, x20
10182a65c: aa1603e1    	mov	x1, x22
10182a660: 958ff2b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a664: f00f32e8    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
10182a668: f9445901    	ldr	x1, [x8, #0x8b0] ; delaySearch:slowMode:
10182a66c: b40002a0    	cbz	x0, 0x10182a6c0 <__text+0x18226c0>
10182a670: aa1503e0    	mov	x0, x21
10182a674: aa1303e2    	mov	x2, x19
10182a678: 52800023    	mov	w3, #0x1                ; =1
10182a67c: 958ff2b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a680: eb1802ff    	cmp	x23, x24
10182a684: 1a9f97e3    	cset	w3, hi
10182a688: f00f3168    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
10182a68c: f9435d01    	ldr	x1, [x8, #0x6b8] ; delayPardusSearch:slowMode:
10182a690: aa1503e0    	mov	x0, x21
10182a694: aa1303e2    	mov	x2, x19
10182a698: 958ff2a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a69c: aa1403e0    	mov	x0, x20
10182a6a0: 958ff2ad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a6a4: aa1303e0    	mov	x0, x19
10182a6a8: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10182a6ac: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10182a6b0: a94257f6    	ldp	x22, x21, [sp, #0x20]
10182a6b4: a9415ff8    	ldp	x24, x23, [sp, #0x10]
10182a6b8: a8c567fa    	ldp	x26, x25, [sp], #0x50
10182a6bc: 158ff2a6    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a6c0: aa1503e0    	mov	x0, x21
10182a6c4: aa1303e2    	mov	x2, x19
10182a6c8: 52800003    	mov	w3, #0x0                ; =0
10182a6cc: 17ffffec    	b	0x10182a67c <__text+0x182267c>
