
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106262774: d10183ff    	sub	sp, sp, #0x60
106262778: a9025ff8    	stp	x24, x23, [sp, #0x20]
10626277c: a90357f6    	stp	x22, x21, [sp, #0x30]
106262780: a9044ff4    	stp	x20, x19, [sp, #0x40]
106262784: a9057bfd    	stp	x29, x30, [sp, #0x50]
106262788: 910143fd    	add	x29, sp, #0x50
10626278c: aa0303f5    	mov	x21, x3
106262790: aa0203f3    	mov	x19, x2
106262794: aa0003f4    	mov	x20, x0
106262798: b00d4f08    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
10626279c: 52800029    	mov	w9, #0x1                ; =1
1062627a0: 39269109    	strb	w9, [x8, #0x9a4]
1062627a4: aa0203e0    	mov	x0, x2
1062627a8: 94671264    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1062627ac: 52800040    	mov	w0, #0x2                ; =2
1062627b0: 9466aaa4    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
1062627b4: 34000620    	cbz	w0, 0x106262878 <_Flutter_MMFoundation_BindContext+0x273e45c>
1062627b8: 9467127a    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
1062627bc: aa0003f6    	mov	x22, x0
1062627c0: b00cf898    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
1062627c4: f9454700    	ldr	x0, [x24, #0xa88]
1062627c8: 94671266    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1062627cc: aa0003f7    	mov	x23, x0
1062627d0: f9454718    	ldr	x24, [x24, #0xa88]
1062627d4: 900cdf68    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
1062627d8: f9450501    	ldr	x1, [x8, #0xa08] ; roomid
1062627dc: aa1303e0    	mov	x0, x19
1062627e0: 94671257    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062627e4: 900cf548    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1062627e8: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
1062627ec: a900fff5    	stp	x21, xzr, [sp, #0x8]
1062627f0: f90003e0    	str	x0, [sp]
1062627f4: f00c30a2    	adrp	x2, 0x11e879000 <dyld_stub_binder+0x11e879000>
1062627f8: 9124a042    	add	x2, x2, #0x928
1062627fc: aa1803e0    	mov	x0, x24
106262800: 9467124f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262804: aa1d03fd    	mov	x29, x29
106262808: 94671250    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10626280c: aa0003f8    	mov	x24, x0
106262810: 900cf508    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106262814: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
106262818: b00c11c8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10626281c: 91352108    	add	x8, x8, #0xd48
106262820: a90003e8    	stp	x8, x0, [sp]
106262824: b00c11c2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106262828: 9134a042    	add	x2, x2, #0xd28
10626282c: aa1703e0    	mov	x0, x23
106262830: 94671243    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262834: aa0003f7    	mov	x23, x0
106262838: aa1803e0    	mov	x0, x24
10626283c: 94671246    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106262840: f00a7d81    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
106262844: 9124e421    	add	x1, x1, #0x939
106262848: 900ab9e2    	adrp	x2, 0x11b99e000 <dyld_stub_binder+0x11b99e000>
10626284c: 91112042    	add	x2, x2, #0x448
106262850: d00ab9e4    	adrp	x4, 0x11b9a0000 <dyld_stub_binder+0x11b9a0000>
106262854: 9131e884    	add	x4, x4, #0xc7a
106262858: 52800040    	mov	w0, #0x2                ; =2
10626285c: 52818a43    	mov	w3, #0xc52              ; =3154
106262860: aa1703e5    	mov	x5, x23
106262864: 9466aa78    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106262868: aa1703e0    	mov	x0, x23
10626286c: 9467123a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106262870: aa1603e0    	mov	x0, x22
106262874: 9467124e    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
106262878: 900ce2a8    	adrp	x8, 0x11feb6000 <dyld_stub_binder+0x11feb6000>
10626287c: f946e101    	ldr	x1, [x8, #0xdc0] ; setIsActived:
106262880: aa1403e0    	mov	x0, x20
106262884: 52800022    	mov	w2, #0x1                ; =1
106262888: 9467122d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10626288c: 900cdec8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
106262890: f947c101    	ldr	x1, [x8, #0xf80] ; setIsThisTalkIlink:
106262894: aa1403e0    	mov	x0, x20
106262898: 52800022    	mov	w2, #0x1                ; =1
10626289c: 94671228    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062628a0: d00ceb48    	adrp	x8, 0x11ffcc000 <dyld_stub_binder+0x11ffcc000>
1062628a4: f943d501    	ldr	x1, [x8, #0x7a8] ; notificationPushType
1062628a8: aa1403e0    	mov	x0, x20
1062628ac: 94671224    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062628b0: 7100081f    	cmp	w0, #0x2
1062628b4: 52800068    	mov	w8, #0x3                ; =3
1062628b8: 1a9f0102    	csel	w2, w8, wzr, eq
1062628bc: b00ceb88    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
1062628c0: f944c501    	ldr	x1, [x8, #0x988] ; inviteVoIPMonoMsg:
1062628c4: aa1303e0    	mov	x0, x19
1062628c8: 9467121d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062628cc: aa1d03fd    	mov	x29, x29
1062628d0: 9467121e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062628d4: aa0003f6    	mov	x22, x0
1062628d8: d00ce988    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
1062628dc: f945e101    	ldr	x1, [x8, #0xbc0] ; setM_muteNotification:
1062628e0: aa1503e2    	mov	x2, x21
1062628e4: 94671216    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062628e8: f00cdea8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1062628ec: f946d101    	ldr	x1, [x8, #0xda0] ; setM_delegate:
1062628f0: aa1603e0    	mov	x0, x22
1062628f4: aa1403e2    	mov	x2, x20
1062628f8: 94671211    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062628fc: b00cf888    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106262900: f945e900    	ldr	x0, [x8, #0xbd0]
106262904: d00cf4e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106262908: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10626290c: 9467120c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262910: aa1d03fd    	mov	x29, x29
106262914: 9467120d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106262918: aa0003f4    	mov	x20, x0
10626291c: b00cf968    	adrp	x8, 0x12018f000 <dyld_stub_binder+0x12018f000>
106262920: f9473900    	ldr	x0, [x8, #0xe70]
106262924: b00cf4e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106262928: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10626292c: 94671204    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262930: aa0003e2    	mov	x2, x0
106262934: f00cdea8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106262938: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10626293c: aa1403e0    	mov	x0, x20
106262940: 946711ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262944: aa1d03fd    	mov	x29, x29
106262948: 94671200    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10626294c: aa0003f5    	mov	x21, x0
106262950: d00ce988    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
106262954: f945e501    	ldr	x1, [x8, #0xbc8] ; inQueueMsg:
106262958: aa1603e2    	mov	x2, x22
10626295c: 946711f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262960: aa1503e0    	mov	x0, x21
106262964: 946711fc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106262968: aa1403e0    	mov	x0, x20
10626296c: 946711fa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106262970: aa1603e0    	mov	x0, x22
106262974: 946711f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106262978: aa1303e0    	mov	x0, x19
10626297c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
106262980: a9444ff4    	ldp	x20, x19, [sp, #0x40]
106262984: a94357f6    	ldp	x22, x21, [sp, #0x30]
106262988: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10626298c: 910183ff    	add	sp, sp, #0x60
106262990: 146711f1    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
