
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104726534: d10183ff    	sub	sp, sp, #0x60
104726538: a9025ff8    	stp	x24, x23, [sp, #0x20]
10472653c: a90357f6    	stp	x22, x21, [sp, #0x30]
104726540: a9044ff4    	stp	x20, x19, [sp, #0x40]
104726544: a9057bfd    	stp	x29, x30, [sp, #0x50]
104726548: 910143fd    	add	x29, sp, #0x50
10472654c: aa0303f4    	mov	x20, x3
104726550: aa0203f3    	mov	x19, x2
104726554: aa0003f5    	mov	x21, x0
104726558: f00e28a8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
10472655c: 52800029    	mov	w9, #0x1                ; =1
104726560: 391a0109    	strb	w9, [x8, #0x680]
104726564: aa0203e0    	mov	x0, x2
104726568: 94d402f4    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10472656c: b00dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
104726570: b989ed08    	ldrsw	x8, [x8, #0x9ec]
104726574: f8686aa8    	ldr	x8, [x21, x8]
104726578: b00dd269    	adrp	x9, 0x120173000 <dyld_stub_binder+0x120173000>
10472657c: f9453520    	ldr	x0, [x9, #0xa68] ; class iConsole
104726580: f00db889    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104726584: f942a921    	ldr	x1, [x9, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104726588: eb14011f    	cmp	x8, x20
10472658c: 54000669    	b.ls	0x104726658 <_Flutter_MMFoundation_BindContext+0xc0223c>
104726590: a900cff4    	stp	x20, x19, [sp, #0x8]
104726594: b00d0228    	adrp	x8, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
104726598: 910e2108    	add	x8, x8, #0x388 ; CFString 'show in %lu string %@'
10472659c: f90003e8    	str	x8, [sp]
1047265a0: 900b5823    	adrp	x3, 0x11b22a000 <dyld_stub_binder+0x11b22a000>
1047265a4: 9114a863    	add	x3, x3, #0x52a ; string 'TabBar'
1047265a8: d00b8385    	adrp	x5, 0x11b798000 <dyld_stub_binder+0x11b798000>
1047265ac: 912d64a5    	add	x5, x5, #0xb59 ; string 'MMTabBarController.mm'
1047265b0: d00b8387    	adrp	x7, 0x11b798000 <dyld_stub_binder+0x11b798000>
1047265b4: 913a80e7    	add	x7, x7, #0xea0 ; string '-[MMTabBarController setTabBarBadgeString:forIndex:]'
1047265b8: 52800042    	mov	w2, #0x2                ; =2
1047265bc: 52800004    	mov	w4, #0x0                ; =0
1047265c0: 528042e6    	mov	w6, #0x217              ; =535
1047265c4: 94d402de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047265c8: f00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
1047265cc: f945f901    	ldr	x1, [x8, #0xbf0] ; selector customTabBar
1047265d0: aa1503e0    	mov	x0, x21
1047265d4: 94d402da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047265d8: aa1d03fd    	mov	x29, x29
1047265dc: 94d402db    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047265e0: aa0003f7    	mov	x23, x0
1047265e4: b00dbd08    	adrp	x8, 0x11fec7000 <dyld_stub_binder+0x11fec7000>
1047265e8: f9457101    	ldr	x1, [x8, #0xae0] ; selector tabBarItemViewAtIndex:
1047265ec: aa1403e2    	mov	x2, x20
1047265f0: 94d402d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047265f4: aa1d03fd    	mov	x29, x29
1047265f8: 94d402d4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047265fc: aa0003f6    	mov	x22, x0
104726600: aa1703e0    	mov	x0, x23
104726604: 94d402d4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104726608: f00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
10472660c: f9465501    	ldr	x1, [x8, #0xca8] ; selector getTabbarItemForIndex:
104726610: aa1503e0    	mov	x0, x21
104726614: aa1403e2    	mov	x2, x20
104726618: 94d402c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472661c: aa1d03fd    	mov	x29, x29
104726620: 94d402ca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104726624: aa0003f4    	mov	x20, x0
104726628: b00dcee8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10472662c: f946e901    	ldr	x1, [x8, #0xdd0] ; selector length
104726630: aa1303e0    	mov	x0, x19
104726634: 94d402c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726638: b40002c0    	cbz	x0, 0x104726690 <_Flutter_MMFoundation_BindContext+0xc02274>
10472663c: f00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104726640: f9465901    	ldr	x1, [x8, #0xcb0] ; selector setTabBarBadgeString:
104726644: aa1603e0    	mov	x0, x22
104726648: aa1303e2    	mov	x2, x19
10472664c: 94d402bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726650: aa1303e2    	mov	x2, x19
104726654: 14000015    	b	0x1047266a8 <_Flutter_MMFoundation_BindContext+0xc0228c>
104726658: b00d0228    	adrp	x8, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
10472665c: 910da108    	add	x8, x8, #0x368 ; CFString 'Index >= view controllers count!'
104726660: f90003e8    	str	x8, [sp]
104726664: 900b5823    	adrp	x3, 0x11b22a000 <dyld_stub_binder+0x11b22a000>
104726668: 9114a863    	add	x3, x3, #0x52a ; string 'TabBar'
10472666c: d00b8385    	adrp	x5, 0x11b798000 <dyld_stub_binder+0x11b798000>
104726670: 912d64a5    	add	x5, x5, #0xb59 ; string 'MMTabBarController.mm'
104726674: d00b8387    	adrp	x7, 0x11b798000 <dyld_stub_binder+0x11b798000>
104726678: 913a80e7    	add	x7, x7, #0xea0 ; string '-[MMTabBarController setTabBarBadgeString:forIndex:]'
10472667c: 52800062    	mov	w2, #0x3                ; =3
104726680: 52800004    	mov	w4, #0x0                ; =0
104726684: 52804286    	mov	w6, #0x214              ; =532
104726688: 94d402ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472668c: 1400000f    	b	0x1047266c8 <_Flutter_MMFoundation_BindContext+0xc022ac>
104726690: b00dbd08    	adrp	x8, 0x11fec7000 <dyld_stub_binder+0x11fec7000>
104726694: f9457901    	ldr	x1, [x8, #0xaf0] ; selector setBadgeViewHidden:
104726698: aa1603e0    	mov	x0, x22
10472669c: 52800022    	mov	w2, #0x1                ; =1
1047266a0: 94d402a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047266a4: d2800002    	mov	x2, #0x0                ; =0
1047266a8: b00db8c8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1047266ac: f947a501    	ldr	x1, [x8, #0xf48] ; selector setAccessibilityValue:
1047266b0: aa1403e0    	mov	x0, x20
1047266b4: 94d402a2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047266b8: aa1403e0    	mov	x0, x20
1047266bc: 94d402a6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047266c0: aa1603e0    	mov	x0, x22
1047266c4: 94d402a4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047266c8: aa1303e0    	mov	x0, x19
1047266cc: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1047266d0: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1047266d4: a94357f6    	ldp	x22, x21, [sp, #0x30]
1047266d8: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1047266dc: 910183ff    	add	sp, sp, #0x60
1047266e0: 14d4029d    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
