
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010615b8: d10543ff    	sub	sp, sp, #0x150
1010615bc: a90f6ffc    	stp	x28, x27, [sp, #0xf0]
1010615c0: a91067fa    	stp	x26, x25, [sp, #0x100]
1010615c4: a9115ff8    	stp	x24, x23, [sp, #0x110]
1010615c8: a91257f6    	stp	x22, x21, [sp, #0x120]
1010615cc: a9134ff4    	stp	x20, x19, [sp, #0x130]
1010615d0: a9147bfd    	stp	x29, x30, [sp, #0x140]
1010615d4: 910503fd    	add	x29, sp, #0x140
1010615d8: aa0003f3    	mov	x19, x0
1010615dc: d00e2c68    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1010615e0: f9405908    	ldr	x8, [x8, #0xb0]
1010615e4: f9400108    	ldr	x8, [x8]
1010615e8: f81a03a8    	stur	x8, [x29, #-0x60]
1010615ec: f00fde68    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
1010615f0: 52800029    	mov	w9, #0x1                ; =1
1010615f4: 39388509    	strb	w9, [x8, #0xe21]
1010615f8: b00f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010615fc: b9838508    	ldrsw	x8, [x8, #0x384] ; ivar ContactTagNewDetailViewController._contactsKeyArray
101061600: f8686800    	ldr	x0, [x0, x8]
101061604: 900f6fc8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
101061608: f9425902    	ldr	x2, [x8, #0x4b0] ; compareByContactKey:
10106160c: b00f8548    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
101061610: f9448101    	ldr	x1, [x8, #0x900] ; sortUsingSelector:
101061614: f9000be1    	str	x1, [sp, #0x10]
101061618: 95af16c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10106161c: 4f00e400    	movi.16b	v0, #0x0
101061620: ad0203e0    	stp	q0, q0, [sp, #0x40]
101061624: ad0103e0    	stp	q0, q0, [sp, #0x20]
101061628: b00f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
10106162c: b9838908    	ldrsw	x8, [x8, #0x388] ; ivar ContactTagNewDetailViewController._contactsDict
101061630: f9000ff3    	str	x19, [sp, #0x18]
101061634: f90007e8    	str	x8, [sp, #0x8]
101061638: f8686a75    	ldr	x21, [x19, x8]
10106163c: aa1503e0    	mov	x0, x21
101061640: 95af16be    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101061644: f00f84e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101061648: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
10106164c: 910083e2    	add	x2, sp, #0x20
101061650: 910183e3    	add	x3, sp, #0x60
101061654: f90003e1    	str	x1, [sp]
101061658: 52800204    	mov	w4, #0x10               ; =16
10106165c: 95af16b8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101061660: b4000800    	cbz	x0, 0x101061760 <__text+0x1059760>
101061664: aa0003f7    	mov	x23, x0
101061668: f9401be8    	ldr	x8, [sp, #0x30]
10106166c: f9400114    	ldr	x20, [x8]
101061670: d00ea718    	adrp	x24, 0x11e543000 <dyld_stub_binder+0x11e543000>
101061674: 912a2318    	add	x24, x24, #0xa88
101061678: f00ea699    	adrp	x25, 0x11e534000 <dyld_stub_binder+0x11e534000>
10106167c: 913fa339    	add	x25, x25, #0xfe8
101061680: d280001a    	mov	x26, #0x0               ; =0
101061684: d00f8508    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
101061688: f943c91b    	ldr	x27, [x8, #0x790] ; isEqualToString:
10106168c: f00f8508    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101061690: f947f11c    	ldr	x28, [x8, #0xfe0] ; objectForKey:
101061694: f00f84e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101061698: f940b916    	ldr	x22, [x8, #0x170] ; compare:
10106169c: f9401be8    	ldr	x8, [sp, #0x30]
1010616a0: f9400108    	ldr	x8, [x8]
1010616a4: eb14011f    	cmp	x8, x20
1010616a8: 54000060    	b.eq	0x1010616b4 <__text+0x10596b4>
1010616ac: aa1503e0    	mov	x0, x21
1010616b0: 95af16a8    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1010616b4: f94017e8    	ldr	x8, [sp, #0x28]
1010616b8: f87a7913    	ldr	x19, [x8, x26, lsl #3]
1010616bc: aa1303e0    	mov	x0, x19
1010616c0: aa1b03e1    	mov	x1, x27
1010616c4: aa1803e2    	mov	x2, x24
1010616c8: 95af169d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010616cc: 37000340    	tbnz	w0, #0x0, 0x101061734 <__text+0x1059734>
1010616d0: aa1303e0    	mov	x0, x19
1010616d4: aa1b03e1    	mov	x1, x27
1010616d8: aa1903e2    	mov	x2, x25
1010616dc: 95af1698    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010616e0: 370002a0    	tbnz	w0, #0x0, 0x101061734 <__text+0x1059734>
1010616e4: aa1303e0    	mov	x0, x19
1010616e8: aa1b03e1    	mov	x1, x27
1010616ec: 900ea742    	adrp	x2, 0x11e549000 <dyld_stub_binder+0x11e549000>
1010616f0: 9116a042    	add	x2, x2, #0x5a8
1010616f4: 95af1692    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010616f8: 370001e0    	tbnz	w0, #0x0, 0x101061734 <__text+0x1059734>
1010616fc: f9400fe8    	ldr	x8, [sp, #0x18]
101061700: f94007e9    	ldr	x9, [sp, #0x8]
101061704: f8696900    	ldr	x0, [x8, x9]
101061708: aa1c03e1    	mov	x1, x28
10106170c: aa1303e2    	mov	x2, x19
101061710: 95af168b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101061714: aa1d03fd    	mov	x29, x29
101061718: 95af168c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10106171c: aa0003f3    	mov	x19, x0
101061720: f9400be1    	ldr	x1, [sp, #0x10]
101061724: aa1603e2    	mov	x2, x22
101061728: 95af1685    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10106172c: aa1303e0    	mov	x0, x19
101061730: 95af1689    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101061734: 9100075a    	add	x26, x26, #0x1
101061738: eb1a02ff    	cmp	x23, x26
10106173c: 54fffb01    	b.ne	0x10106169c <__text+0x105969c>
101061740: 910083e2    	add	x2, sp, #0x20
101061744: 910183e3    	add	x3, sp, #0x60
101061748: aa1503e0    	mov	x0, x21
10106174c: f94003e1    	ldr	x1, [sp]
101061750: 52800204    	mov	w4, #0x10               ; =16
101061754: 95af167a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101061758: aa0003f7    	mov	x23, x0
10106175c: b5fff920    	cbnz	x0, 0x101061680 <__text+0x1059680>
101061760: aa1503e0    	mov	x0, x21
101061764: 95af167c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101061768: f85a03a8    	ldur	x8, [x29, #-0x60]
10106176c: d00e2c69    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
101061770: f9405929    	ldr	x9, [x9, #0xb0]
101061774: f9400129    	ldr	x9, [x9]
101061778: eb08013f    	cmp	x9, x8
10106177c: 54000121    	b.ne	0x1010617a0 <__text+0x10597a0>
101061780: a9547bfd    	ldp	x29, x30, [sp, #0x140]
101061784: a9534ff4    	ldp	x20, x19, [sp, #0x130]
101061788: a95257f6    	ldp	x22, x21, [sp, #0x120]
10106178c: a9515ff8    	ldp	x24, x23, [sp, #0x110]
101061790: a95067fa    	ldp	x26, x25, [sp, #0x100]
101061794: a94f6ffc    	ldp	x28, x27, [sp, #0xf0]
101061798: 910543ff    	add	sp, sp, #0x150
10106179c: d65f03c0    	ret
1010617a0: 95af1675    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
