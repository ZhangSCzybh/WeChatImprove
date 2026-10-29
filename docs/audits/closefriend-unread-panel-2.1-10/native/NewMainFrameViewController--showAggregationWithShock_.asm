
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1051126b8: d10583ff    	sub	sp, sp, #0x160
1051126bc: 6d0f23e9    	stp	d9, d8, [sp, #0xf0]
1051126c0: a9106ffc    	stp	x28, x27, [sp, #0x100]
1051126c4: a91167fa    	stp	x26, x25, [sp, #0x110]
1051126c8: a9125ff8    	stp	x24, x23, [sp, #0x120]
1051126cc: a91357f6    	stp	x22, x21, [sp, #0x130]
1051126d0: a9144ff4    	stp	x20, x19, [sp, #0x140]
1051126d4: a9157bfd    	stp	x29, x30, [sp, #0x150]
1051126d8: 910543fd    	add	x29, sp, #0x150
1051126dc: aa0003f3    	mov	x19, x0
1051126e0: b00c26e8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1051126e4: f9405908    	ldr	x8, [x8, #0xb0]
1051126e8: f9400108    	ldr	x8, [x8]
1051126ec: f81903a8    	stur	x8, [x29, #-0x70]
1051126f0: b00dd968    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
1051126f4: 52800029    	mov	w9, #0x1                ; =1
1051126f8: 392d4d09    	strb	w9, [x8, #0xb53]
1051126fc: 340000c2    	cbz	w2, 0x105112714 <_Flutter_MMFoundation_BindContext+0x15ee2f8>
105112700: b00d8348    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
105112704: f9452500    	ldr	x0, [x8, #0xa48] ; class WCStoryDragAnimationUtil
105112708: f00d6b88    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
10511270c: f9405501    	ldr	x1, [x8, #0xa8] ; selector lightShock
105112710: 94ac528b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112714: b00d8314    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
105112718: f9470280    	ldr	x0, [x20, #0xe00] ; class UiUtil
10511271c: d00d6988    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
105112720: f940f501    	ldr	x1, [x8, #0x1e8] ; selector statusBarHeight
105112724: 94ac5286    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112728: 1e604008    	fmov	d8, d0
10511272c: f9470280    	ldr	x0, [x20, #0xe00] ; class UiUtil
105112730: d00d6988    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
105112734: f9451d01    	ldr	x1, [x8, #0xa38] ; selector navigationBarHeight
105112738: 94ac5281    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511273c: 1e602908    	fadd	d8, d8, d0
105112740: 4f00e400    	movi.16b	v0, #0x0
105112744: ad0103e0    	stp	q0, q0, [sp, #0x20]
105112748: ad0203e0    	stp	q0, q0, [sp, #0x40]
10511274c: d00d88a8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105112750: b9831908    	ldrsw	x8, [x8, #0x318]
105112754: f9000fe8    	str	x8, [sp, #0x18]
105112758: f8686a60    	ldr	x0, [x19, x8]
10511275c: d00d6988    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
105112760: f9451501    	ldr	x1, [x8, #0xa28] ; selector visibleCells
105112764: a90087f3    	stp	x19, x1, [sp, #0x8]
105112768: 94ac5275    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511276c: aa1d03fd    	mov	x29, x29
105112770: 94ac5276    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112774: aa0003f5    	mov	x21, x0
105112778: d00d7f68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10511277c: f9435516    	ldr	x22, [x8, #0x6a8] ; selector countByEnumeratingWithState:objects:count:
105112780: 910083e2    	add	x2, sp, #0x20
105112784: 910183e3    	add	x3, sp, #0x60
105112788: aa1603e1    	mov	x1, x22
10511278c: 52800204    	mov	w4, #0x10               ; =16
105112790: 94ac526b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112794: b4000500    	cbz	x0, 0x105112834 <_Flutter_MMFoundation_BindContext+0x15ee418>
105112798: aa0003f8    	mov	x24, x0
10511279c: f9401be8    	ldr	x8, [sp, #0x30]
1051127a0: f940011c    	ldr	x28, [x8]
1051127a4: b00d7f69    	adrp	x9, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1051127a8: b00d7f88    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1051127ac: b00d8354    	adrp	x20, 0x12017b000 <dyld_stub_binder+0x12017b000>
1051127b0: d280001b    	mov	x27, #0x0               ; =0
1051127b4: f947ad39    	ldr	x25, [x9, #0xf58] ; selector class
1051127b8: aa0803f3    	mov	x19, x8
1051127bc: f9442d1a    	ldr	x26, [x8, #0x858] ; selector isKindOfClass:
1051127c0: f9401be8    	ldr	x8, [sp, #0x30]
1051127c4: f9400108    	ldr	x8, [x8]
1051127c8: eb1c011f    	cmp	x8, x28
1051127cc: 54000060    	b.eq	0x1051127d8 <_Flutter_MMFoundation_BindContext+0x15ee3bc>
1051127d0: aa1503e0    	mov	x0, x21
1051127d4: 94ac525f    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1051127d8: f94017e8    	ldr	x8, [sp, #0x28]
1051127dc: f87b7917    	ldr	x23, [x8, x27, lsl #3]
1051127e0: f9421280    	ldr	x0, [x20, #0x420] ; class NewMainFrameCell
1051127e4: aa1903e1    	mov	x1, x25
1051127e8: 94ac5255    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051127ec: aa0003e2    	mov	x2, x0
1051127f0: aa1703e0    	mov	x0, x23
1051127f4: aa1a03e1    	mov	x1, x26
1051127f8: 94ac5251    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051127fc: 37000220    	tbnz	w0, #0x0, 0x105112840 <_Flutter_MMFoundation_BindContext+0x15ee424>
105112800: 9100077b    	add	x27, x27, #0x1
105112804: eb1b031f    	cmp	x24, x27
105112808: 54fffdc1    	b.ne	0x1051127c0 <_Flutter_MMFoundation_BindContext+0x15ee3a4>
10511280c: 910083e2    	add	x2, sp, #0x20
105112810: 910183e3    	add	x3, sp, #0x60
105112814: aa1503e0    	mov	x0, x21
105112818: aa1603e1    	mov	x1, x22
10511281c: 52800204    	mov	w4, #0x10               ; =16
105112820: 94ac5247    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112824: aa0003f8    	mov	x24, x0
105112828: b00d7f69    	adrp	x9, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10511282c: aa1303e8    	mov	x8, x19
105112830: b5fffc00    	cbnz	x0, 0x1051127b0 <_Flutter_MMFoundation_BindContext+0x15ee394>
105112834: aa1503e0    	mov	x0, x21
105112838: 94ac5247    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511283c: 14000014    	b	0x10511288c <_Flutter_MMFoundation_BindContext+0x15ee470>
105112840: aa1703e0    	mov	x0, x23
105112844: 94ac523d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105112848: aa1503e0    	mov	x0, x21
10511284c: 94ac5242    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105112850: b40001f7    	cbz	x23, 0x10511288c <_Flutter_MMFoundation_BindContext+0x15ee470>
105112854: b00d7f68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105112858: f943d501    	ldr	x1, [x8, #0x7a8] ; selector bounds
10511285c: aa1703e0    	mov	x0, x23
105112860: 94ac5237    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112864: d00d7f68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105112868: f942e501    	ldr	x1, [x8, #0x5c8] ; selector convertRect:toView:
10511286c: aa1703e0    	mov	x0, x23
105112870: d2800002    	mov	x2, #0x0                ; =0
105112874: 94ac5232    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112878: 1e612100    	fcmp	d8, d1
10511287c: 1e684c28    	fcsel	d8, d1, d8, mi
105112880: a94153e1    	ldp	x1, x20, [sp, #0x10]
105112884: f94007f3    	ldr	x19, [sp, #0x8]
105112888: 14000012    	b	0x1051128d0 <_Flutter_MMFoundation_BindContext+0x15ee4b4>
10511288c: f9400ff4    	ldr	x20, [sp, #0x18]
105112890: f94007f3    	ldr	x19, [sp, #0x8]
105112894: f8746a60    	ldr	x0, [x19, x20]
105112898: d00d69c8    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
10511289c: f9456d01    	ldr	x1, [x8, #0xad8] ; selector tableHeaderView
1051128a0: 94ac5227    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051128a4: aa1d03fd    	mov	x29, x29
1051128a8: 94ac5228    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051128ac: aa0003f5    	mov	x21, x0
1051128b0: 900d7f88    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1051128b4: f9449d01    	ldr	x1, [x8, #0x938] ; selector height
1051128b8: 94ac5221    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051128bc: 1e602908    	fadd	d8, d8, d0
1051128c0: aa1503e0    	mov	x0, x21
1051128c4: 94ac5224    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051128c8: d2800017    	mov	x23, #0x0               ; =0
1051128cc: f9400be1    	ldr	x1, [sp, #0x10]
1051128d0: 900d8408    	adrp	x8, 0x120192000 <dyld_stub_binder+0x120192000>
1051128d4: f944bd15    	ldr	x21, [x8, #0x978] ; class MainFrameAggregationViewController
1051128d8: f8746a60    	ldr	x0, [x19, x20]
1051128dc: 94ac5218    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051128e0: aa1d03fd    	mov	x29, x29
1051128e4: 94ac5219    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051128e8: aa0003f4    	mov	x20, x0
1051128ec: 900d7448    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
1051128f0: f945e901    	ldr	x1, [x8, #0xbd0] ; selector showSessionAggregationFrom:visibleCells:headerHeight:delegate:
1051128f4: aa1503e0    	mov	x0, x21
1051128f8: aa1303e2    	mov	x2, x19
1051128fc: aa1403e3    	mov	x3, x20
105112900: 1e604100    	fmov	d0, d8
105112904: aa1303e4    	mov	x4, x19
105112908: 94ac520d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511290c: aa1403e0    	mov	x0, x20
105112910: 94ac5211    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105112914: aa1703e0    	mov	x0, x23
105112918: 94ac520f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511291c: f85903a8    	ldur	x8, [x29, #-0x70]
105112920: b00c26e9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
105112924: f9405929    	ldr	x9, [x9, #0xb0]
105112928: f9400129    	ldr	x9, [x9]
10511292c: eb08013f    	cmp	x9, x8
105112930: 54000141    	b.ne	0x105112958 <_Flutter_MMFoundation_BindContext+0x15ee53c>
105112934: a9557bfd    	ldp	x29, x30, [sp, #0x150]
105112938: a9544ff4    	ldp	x20, x19, [sp, #0x140]
10511293c: a95357f6    	ldp	x22, x21, [sp, #0x130]
105112940: a9525ff8    	ldp	x24, x23, [sp, #0x120]
105112944: a95167fa    	ldp	x26, x25, [sp, #0x110]
105112948: a9506ffc    	ldp	x28, x27, [sp, #0x100]
10511294c: 6d4f23e9    	ldp	d9, d8, [sp, #0xf0]
105112950: 910583ff    	add	sp, sp, #0x160
105112954: d65f03c0    	ret
105112958: 94ac5207    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
