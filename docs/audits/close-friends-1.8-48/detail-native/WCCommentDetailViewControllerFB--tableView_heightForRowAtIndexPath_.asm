
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106e94674: d10203ff    	sub	sp, sp, #0x80
106e94678: 6d0123e9    	stp	d9, d8, [sp, #0x10]
106e9467c: a9026ffc    	stp	x28, x27, [sp, #0x20]
106e94680: a90367fa    	stp	x26, x25, [sp, #0x30]
106e94684: a9045ff8    	stp	x24, x23, [sp, #0x40]
106e94688: a90557f6    	stp	x22, x21, [sp, #0x50]
106e9468c: a9064ff4    	stp	x20, x19, [sp, #0x60]
106e94690: a9077bfd    	stp	x29, x30, [sp, #0x70]
106e94694: 9101c3fd    	add	x29, sp, #0x70
106e94698: aa0303f4    	mov	x20, x3
106e9469c: aa0203f5    	mov	x21, x2
106e946a0: aa0003f3    	mov	x19, x0
106e946a4: d00ced88    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
106e946a8: 52800029    	mov	w9, #0x1                ; =1
106e946ac: 391b2509    	strb	w9, [x8, #0x6c9]
106e946b0: d00c9388    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
106e946b4: f9440916    	ldr	x22, [x8, #0x810] ; row
106e946b8: aa0203e0    	mov	x0, x2
106e946bc: 94364a9f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e946c0: aa1403e0    	mov	x0, x20
106e946c4: aa1603e1    	mov	x1, x22
106e946c8: 94364a9d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e946cc: aa0003f6    	mov	x22, x0
106e946d0: 900c7e88    	adrp	x8, 0x11fe64000 <dyld_stub_binder+0x11fe64000>
106e946d4: f943a501    	ldr	x1, [x8, #0x748] ; tableView:numberOfRowsInSection:
106e946d8: aa1303e0    	mov	x0, x19
106e946dc: aa1503e2    	mov	x2, x21
106e946e0: d2800003    	mov	x3, #0x0                ; =0
106e946e4: 94364a96    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e946e8: aa0003f7    	mov	x23, x0
106e946ec: aa1503e0    	mov	x0, x21
106e946f0: 94364a99    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e946f4: b00c9d88    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e946f8: b984c508    	ldrsw	x8, [x8, #0x4c4]
106e946fc: f8686a60    	ldr	x0, [x19, x8]
106e94700: 900c9368    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106e94704: f9435114    	ldr	x20, [x8, #0x6a0] ; count
106e94708: aa1403e1    	mov	x1, x20
106e9470c: 94364a8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e94710: f100001f    	cmp	x0, #0x0
106e94714: 1a9f07e8    	cset	w8, ne
106e94718: 92800029    	mov	x9, #-0x2               ; =-2
106e9471c: 9a891529    	cinc	x9, x9, eq
106e94720: 8b170137    	add	x23, x9, x23
106e94724: cb0802d6    	sub	x22, x22, x8
106e94728: d00c8b48    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e9472c: f944fd01    	ldr	x1, [x8, #0x9f8] ; isAdFireworkCheerCommentStyle
106e94730: aa1303e0    	mov	x0, x19
106e94734: 94364a82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e94738: aa0003f5    	mov	x21, x0
106e9473c: eb1702df    	cmp	x22, x23
106e94740: 1a8013f7    	csel	w23, wzr, w0, ne
106e94744: d00c8b48    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e94748: f9450101    	ldr	x1, [x8, #0xa00] ; shouldShowReadCountRow
106e9474c: aa1303e0    	mov	x0, x19
106e94750: 94364a7b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e94754: 340001c0    	cbz	w0, 0x106e9478c <_Flutter_MMFoundation_BindContext+0x3370370>
106e94758: b00c9d88    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e9475c: b984c108    	ldrsw	x8, [x8, #0x4c0]
106e94760: f8686a60    	ldr	x0, [x19, x8]
106e94764: aa1403e1    	mov	x1, x20
106e94768: 94364a75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e9476c: 37000137    	tbnz	w23, #0x0, 0x106e94790 <_Flutter_MMFoundation_BindContext+0x3370374>
106e94770: eb0002df    	cmp	x22, x0
106e94774: 54000341    	b.ne	0x106e947dc <_Flutter_MMFoundation_BindContext+0x33703c0>
106e94778: d00c8b48    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e9477c: f9450501    	ldr	x1, [x8, #0xa08] ; readCountRowHeight
106e94780: aa1303e0    	mov	x0, x19
106e94784: 94364a6e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e94788: 1400000a    	b	0x106e947b0 <_Flutter_MMFoundation_BindContext+0x3370394>
106e9478c: 34000297    	cbz	w23, 0x106e947dc <_Flutter_MMFoundation_BindContext+0x33703c0>
106e94790: f00c96e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e94794: f9461900    	ldr	x0, [x8, #0xc30]
106e94798: f00c8248    	adrp	x8, 0x11fedf000 <dyld_stub_binder+0x11fedf000>
106e9479c: f944cd01    	ldr	x1, [x8, #0x998] ; dynamicLength:forModule:
106e947a0: 9008f7a8    	adrp	x8, 0x118d88000 <dyld_stub_binder+0x118d88000>
106e947a4: fd42d900    	ldr	d0, [x8, #0x5b0]
106e947a8: 52800022    	mov	w2, #0x1                ; =1
106e947ac: 94364a64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e947b0: 9e79001a    	fcvtzu	x26, d0
106e947b4: 9e630340    	ucvtf	d0, x26
106e947b8: a9477bfd    	ldp	x29, x30, [sp, #0x70]
106e947bc: a9464ff4    	ldp	x20, x19, [sp, #0x60]
106e947c0: a94557f6    	ldp	x22, x21, [sp, #0x50]
106e947c4: a9445ff8    	ldp	x24, x23, [sp, #0x40]
106e947c8: a94367fa    	ldp	x26, x25, [sp, #0x30]
106e947cc: a9426ffc    	ldp	x28, x27, [sp, #0x20]
106e947d0: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
106e947d4: 910203ff    	add	sp, sp, #0x80
106e947d8: d65f03c0    	ret
106e947dc: b7f806f6    	tbnz	x22, #0x3f, 0x106e948b8 <_Flutter_MMFoundation_BindContext+0x337049c>
106e947e0: b00c9d88    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e947e4: b984c115    	ldrsw	x21, [x8, #0x4c0]
106e947e8: f8756a60    	ldr	x0, [x19, x21]
106e947ec: aa1403e1    	mov	x1, x20
106e947f0: 94364a53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e947f4: eb0002df    	cmp	x22, x0
106e947f8: 54000822    	b.hs	0x106e948fc <_Flutter_MMFoundation_BindContext+0x33704e0>
106e947fc: f8756a60    	ldr	x0, [x19, x21]
106e94800: d00c7d28    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
106e94804: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
106e94808: aa1603e2    	mov	x2, x22
106e9480c: 94364a4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e94810: aa1d03fd    	mov	x29, x29
106e94814: 94364a4d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e94818: aa0003f4    	mov	x20, x0
106e9481c: d00c8b48    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e94820: f9450d01    	ldr	x1, [x8, #0xa18] ; FormCommentTipsView:
106e94824: aa1303e0    	mov	x0, x19
106e94828: aa1403e2    	mov	x2, x20
106e9482c: 94364a44    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e94830: aa1d03fd    	mov	x29, x29
106e94834: 94364a45    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e94838: aa0003f5    	mov	x21, x0
106e9483c: b00c8a88    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
106e94840: f9426d01    	ldr	x1, [x8, #0x4d8] ; pageContext
106e94844: aa1303e0    	mov	x0, x19
106e94848: 94364a3d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e9484c: aa1d03fd    	mov	x29, x29
106e94850: 94364a3e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e94854: aa0003f7    	mov	x23, x0
106e94858: d00c8b48    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e9485c: f9430101    	ldr	x1, [x8, #0x600] ; supportCommentEmoticonOrImageBrowse
106e94860: 94364a37    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e94864: aa0003f8    	mov	x24, x0
106e94868: aa1703e0    	mov	x0, x23
106e9486c: 94364a3a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e94870: 37000898    	tbnz	w24, #0x0, 0x106e94980 <_Flutter_MMFoundation_BindContext+0x3370564>
106e94874: b5000876    	cbnz	x22, 0x106e94980 <_Flutter_MMFoundation_BindContext+0x3370564>
106e94878: d00c8b48    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e9487c: f9429d01    	ldr	x1, [x8, #0x538] ; shouldShowRewardDetailView
106e94880: aa1303e0    	mov	x0, x19
106e94884: 94364a2e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e94888: aa0003f6    	mov	x22, x0
106e9488c: d00c9368    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106e94890: f9449d01    	ldr	x1, [x8, #0x938] ; height
106e94894: aa1503e0    	mov	x0, x21
106e94898: 94364a29    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e9489c: 1e64d001    	fmov	d1, #11.00000000
106e948a0: 1e612801    	fadd	d1, d0, d1
106e948a4: 1e601002    	fmov	d2, #2.00000000
106e948a8: 1e622800    	fadd	d0, d0, d2
106e948ac: 710002df    	cmp	w22, #0x0
106e948b0: 1e600c20    	fcsel	d0, d1, d0, eq
106e948b4: 14000039    	b	0x106e94998 <_Flutter_MMFoundation_BindContext+0x337057c>
106e948b8: b00c9d88    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e948bc: b985bd08    	ldrsw	x8, [x8, #0x5bc]
106e948c0: f8686a60    	ldr	x0, [x19, x8]
106e948c4: d00c9368    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106e948c8: f9449d01    	ldr	x1, [x8, #0x938] ; height
106e948cc: 94364a1c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e948d0: 1e604008    	fmov	d8, d0
106e948d4: 340003b5    	cbz	w21, 0x106e94948 <_Flutter_MMFoundation_BindContext+0x337052c>
106e948d8: b00c9848    	adrp	x8, 0x12019d000 <dyld_stub_binder+0x12019d000>
106e948dc: f9449500    	ldr	x0, [x8, #0x928]
106e948e0: d00c8a48    	adrp	x8, 0x11ffde000 <dyld_stub_binder+0x11ffde000>
106e948e4: f9421901    	ldr	x1, [x8, #0x430] ; topAreaHeight
106e948e8: 94364a15    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e948ec: 1e602900    	fadd	d0, d8, d0
106e948f0: 1e645001    	fmov	d1, #9.00000000
106e948f4: 1e612800    	fadd	d0, d0, d1
106e948f8: 14000016    	b	0x106e94950 <_Flutter_MMFoundation_BindContext+0x3370534>
106e948fc: f00c96e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e94900: f9453500    	ldr	x0, [x8, #0xa68]
106e94904: b00c7d28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e94908: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
106e9490c: 900bd2c8    	adrp	x8, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
106e94910: 913c2108    	add	x8, x8, #0xf08
106e94914: f90003e8    	str	x8, [sp]
106e94918: 900a1c43    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
106e9491c: 912b2863    	add	x3, x3, #0xaca
106e94920: 900a5e85    	adrp	x5, 0x11ba64000 <dyld_stub_binder+0x11ba64000>
106e94924: 910820a5    	add	x5, x5, #0x208
106e94928: b00a5e87    	adrp	x7, 0x11ba65000 <dyld_stub_binder+0x11ba65000>
106e9492c: 911020e7    	add	x7, x7, #0x408
106e94930: 52800082    	mov	w2, #0x4                ; =4
106e94934: 52800004    	mov	w4, #0x0                ; =0
106e94938: 52827a86    	mov	w6, #0x13d4             ; =5076
106e9493c: 94364a00    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e94940: 9e6703e0    	fmov	d0, xzr
106e94944: 17ffff9d    	b	0x106e947b8 <_Flutter_MMFoundation_BindContext+0x337039c>
106e94948: 1e669000    	fmov	d0, #20.00000000
106e9494c: 1e602900    	fadd	d0, d8, d0
106e94950: 9e79001a    	fcvtzu	x26, d0
106e94954: b00c9d88    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e94958: b9846508    	ldrsw	x8, [x8, #0x464]
106e9495c: 38686a68    	ldrb	w8, [x19, x8]
106e94960: 3707f2a8    	tbnz	w8, #0x0, 0x106e947b4 <_Flutter_MMFoundation_BindContext+0x3370398>
106e94964: 9e630340    	ucvtf	d0, x26
106e94968: b00c9d88    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e9496c: b9846108    	ldrsw	x8, [x8, #0x460]
106e94970: fc686a61    	ldr	d1, [x19, x8]
106e94974: 1e602820    	fadd	d0, d1, d0
106e94978: fc286a60    	str	d0, [x19, x8]
106e9497c: 17ffff8e    	b	0x106e947b4 <_Flutter_MMFoundation_BindContext+0x3370398>
106e94980: d00c9368    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106e94984: f9449d01    	ldr	x1, [x8, #0x938] ; height
106e94988: aa1503e0    	mov	x0, x21
106e9498c: 943649ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e94990: 1e601001    	fmov	d1, #2.00000000
106e94994: 1e612800    	fadd	d0, d0, d1
106e94998: 9e79001a    	fcvtzu	x26, d0
106e9499c: b00c9d88    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e949a0: b984651b    	ldrsw	x27, [x8, #0x464]
106e949a4: 387b6a68    	ldrb	w8, [x19, x27]
106e949a8: 370000e8    	tbnz	w8, #0x0, 0x106e949c4 <_Flutter_MMFoundation_BindContext+0x33705a8>
106e949ac: 9e630340    	ucvtf	d0, x26
106e949b0: b00c9d88    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e949b4: b9846108    	ldrsw	x8, [x8, #0x460]
106e949b8: fc686a61    	ldr	d1, [x19, x8]
106e949bc: 1e602820    	fadd	d0, d1, d0
106e949c0: fc286a60    	str	d0, [x19, x8]
106e949c4: d00c8128    	adrp	x8, 0x11feba000 <dyld_stub_binder+0x11feba000>
106e949c8: f942c116    	ldr	x22, [x8, #0x580] ; commentID
106e949cc: aa1403e0    	mov	x0, x20
106e949d0: aa1603e1    	mov	x1, x22
106e949d4: 943649da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e949d8: aa1d03fd    	mov	x29, x29
106e949dc: 943649db    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e949e0: aa0003f7    	mov	x23, x0
106e949e4: b00c9d88    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e949e8: b984fd1c    	ldrsw	x28, [x8, #0x4fc]
106e949ec: f87c6a60    	ldr	x0, [x19, x28]
106e949f0: aa1603e1    	mov	x1, x22
106e949f4: 943649d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e949f8: aa1d03fd    	mov	x29, x29
106e949fc: 943649d3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e94a00: aa0003f8    	mov	x24, x0
106e94a04: f00c9368    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106e94a08: f943c916    	ldr	x22, [x8, #0x790] ; isEqualToString:
106e94a0c: aa1703e0    	mov	x0, x23
106e94a10: aa1603e1    	mov	x1, x22
106e94a14: aa1803e2    	mov	x2, x24
106e94a18: 943649c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e94a1c: aa0003f9    	mov	x25, x0
106e94a20: aa1803e0    	mov	x0, x24
106e94a24: 943649cc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e94a28: aa1703e0    	mov	x0, x23
106e94a2c: 943649ca    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e94a30: 34000079    	cbz	w25, 0x106e94a3c <_Flutter_MMFoundation_BindContext+0x3370620>
106e94a34: 52800028    	mov	w8, #0x1                ; =1
106e94a38: 383b6a68    	strb	w8, [x19, x27]
106e94a3c: f00c8128    	adrp	x8, 0x11febb000 <dyld_stub_binder+0x11febb000>
106e94a40: f9475517    	ldr	x23, [x8, #0xea8] ; comment64ID
106e94a44: aa1403e0    	mov	x0, x20
106e94a48: aa1703e1    	mov	x1, x23
106e94a4c: 943649bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e94a50: aa1d03fd    	mov	x29, x29
106e94a54: 943649bd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e94a58: aa0003f8    	mov	x24, x0
106e94a5c: f87c6a60    	ldr	x0, [x19, x28]
106e94a60: aa1703e1    	mov	x1, x23
106e94a64: 943649b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e94a68: aa1d03fd    	mov	x29, x29
106e94a6c: 943649b7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e94a70: aa0003f7    	mov	x23, x0
106e94a74: aa1803e0    	mov	x0, x24
106e94a78: aa1603e1    	mov	x1, x22
106e94a7c: aa1703e2    	mov	x2, x23
106e94a80: 943649af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e94a84: aa0003f6    	mov	x22, x0
106e94a88: aa1703e0    	mov	x0, x23
106e94a8c: 943649b2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e94a90: aa1803e0    	mov	x0, x24
106e94a94: 943649b0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e94a98: 34000076    	cbz	w22, 0x106e94aa4 <_Flutter_MMFoundation_BindContext+0x3370688>
106e94a9c: 52800028    	mov	w8, #0x1                ; =1
106e94aa0: 383b6a68    	strb	w8, [x19, x27]
106e94aa4: aa1503e0    	mov	x0, x21
106e94aa8: 943649ab    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e94aac: aa1403e0    	mov	x0, x20
106e94ab0: 943649a9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e94ab4: 17ffff40    	b	0x106e947b4 <_Flutter_MMFoundation_BindContext+0x3370398>
