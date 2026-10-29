
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1047266e4: d10143ff    	sub	sp, sp, #0x50
1047266e8: a9015ff8    	stp	x24, x23, [sp, #0x10]
1047266ec: a90257f6    	stp	x22, x21, [sp, #0x20]
1047266f0: a9034ff4    	stp	x20, x19, [sp, #0x30]
1047266f4: a9047bfd    	stp	x29, x30, [sp, #0x40]
1047266f8: 910103fd    	add	x29, sp, #0x40
1047266fc: aa0003f4    	mov	x20, x0
104726700: f00e28a8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
104726704: 52800029    	mov	w9, #0x1                ; =1
104726708: b00dd7ca    	adrp	x10, 0x12021f000 <dyld_stub_binder+0x12021f000>
10472670c: b989ed4a    	ldrsw	x10, [x10, #0x9ec]
104726710: f86a680a    	ldr	x10, [x0, x10]
104726714: 391a0509    	strb	w9, [x8, #0x681]
104726718: b00dd268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10472671c: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
104726720: f00db888    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104726724: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104726728: eb02015f    	cmp	x10, x2
10472672c: 54000c09    	b.ls	0x1047268ac <_Flutter_MMFoundation_BindContext+0xc02490>
104726730: aa0203f3    	mov	x19, x2
104726734: b00d0228    	adrp	x8, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
104726738: 910ea108    	add	x8, x8, #0x3a8 ; CFString 'show in %lu'
10472673c: a9000be8    	stp	x8, x2, [sp]
104726740: 900b5823    	adrp	x3, 0x11b22a000 <dyld_stub_binder+0x11b22a000>
104726744: 9114a863    	add	x3, x3, #0x52a ; string 'TabBar'
104726748: d00b8385    	adrp	x5, 0x11b798000 <dyld_stub_binder+0x11b798000>
10472674c: 912d64a5    	add	x5, x5, #0xb59 ; string 'MMTabBarController.mm'
104726750: d00b8387    	adrp	x7, 0x11b798000 <dyld_stub_binder+0x11b798000>
104726754: 913bace7    	add	x7, x7, #0xeeb ; string '-[MMTabBarController showRedDotOnTabBarItemAtIndex:]'
104726758: 52800042    	mov	w2, #0x2                ; =2
10472675c: 52800004    	mov	w4, #0x0                ; =0
104726760: 52804526    	mov	w6, #0x229              ; =553
104726764: 94d40276    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726768: f00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
10472676c: f9465501    	ldr	x1, [x8, #0xca8] ; selector getTabbarItemForIndex:
104726770: aa1403e0    	mov	x0, x20
104726774: aa1303e2    	mov	x2, x19
104726778: 94d40271    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472677c: aa1d03fd    	mov	x29, x29
104726780: 94d40272    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104726784: aa0003f5    	mov	x21, x0
104726788: b00dd268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10472678c: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
104726790: d00dcec8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104726794: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext
104726798: 94d40269    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472679c: aa1d03fd    	mov	x29, x29
1047267a0: 94d4026a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047267a4: aa0003f6    	mov	x22, x0
1047267a8: b00dd268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1047267ac: f9462900    	ldr	x0, [x8, #0xc50] ; class MMLanguageMgr
1047267b0: b00dcec8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1047267b4: f947ad01    	ldr	x1, [x8, #0xf58] ; selector class
1047267b8: 94d40261    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047267bc: aa0003e2    	mov	x2, x0
1047267c0: f00db888    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1047267c4: f9464101    	ldr	x1, [x8, #0xc80] ; selector getService:
1047267c8: aa1603e0    	mov	x0, x22
1047267cc: 94d4025c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047267d0: aa1d03fd    	mov	x29, x29
1047267d4: 94d4025d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047267d8: aa0003f7    	mov	x23, x0
1047267dc: f00db888    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1047267e0: f9464501    	ldr	x1, [x8, #0xc88] ; selector getStringForCurLanguage:
1047267e4: b00cf4c2    	adrp	x2, 0x11e5bf000 <dyld_stub_binder+0x11e5bf000>
1047267e8: 9124a042    	add	x2, x2, #0x928 ; CFString 'VoiceOver_Unread'
1047267ec: 94d40254    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047267f0: aa1d03fd    	mov	x29, x29
1047267f4: 94d40255    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047267f8: aa0003f8    	mov	x24, x0
1047267fc: b00db8c8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104726800: f947a501    	ldr	x1, [x8, #0xf48] ; selector setAccessibilityValue:
104726804: aa1503e0    	mov	x0, x21
104726808: aa1803e2    	mov	x2, x24
10472680c: 94d4024c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726810: aa1803e0    	mov	x0, x24
104726814: 94d40250    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104726818: aa1703e0    	mov	x0, x23
10472681c: 94d4024e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104726820: aa1603e0    	mov	x0, x22
104726824: 94d4024c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104726828: b00dbd08    	adrp	x8, 0x11fec7000 <dyld_stub_binder+0x11fec7000>
10472682c: f942f101    	ldr	x1, [x8, #0x5e0] ; selector setBadgeValue:
104726830: aa1503e0    	mov	x0, x21
104726834: d2800002    	mov	x2, #0x0                ; =0
104726838: 94d40241    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472683c: f00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104726840: f945f901    	ldr	x1, [x8, #0xbf0] ; selector customTabBar
104726844: aa1403e0    	mov	x0, x20
104726848: 94d4023d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472684c: aa1d03fd    	mov	x29, x29
104726850: 94d4023e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104726854: aa0003f4    	mov	x20, x0
104726858: b00dbd08    	adrp	x8, 0x11fec7000 <dyld_stub_binder+0x11fec7000>
10472685c: f9457101    	ldr	x1, [x8, #0xae0] ; selector tabBarItemViewAtIndex:
104726860: aa1303e2    	mov	x2, x19
104726864: 94d40236    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726868: aa1d03fd    	mov	x29, x29
10472686c: 94d40237    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104726870: aa0003f3    	mov	x19, x0
104726874: b00dbd08    	adrp	x8, 0x11fec7000 <dyld_stub_binder+0x11fec7000>
104726878: f9457d01    	ldr	x1, [x8, #0xaf8] ; selector showSmallRedDot
10472687c: 94d40230    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726880: aa1303e0    	mov	x0, x19
104726884: 94d40234    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104726888: aa1403e0    	mov	x0, x20
10472688c: 94d40232    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104726890: aa1503e0    	mov	x0, x21
104726894: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104726898: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10472689c: a94257f6    	ldp	x22, x21, [sp, #0x20]
1047268a0: a9415ff8    	ldp	x24, x23, [sp, #0x10]
1047268a4: 910143ff    	add	sp, sp, #0x50
1047268a8: 14d4022b    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047268ac: b00d0228    	adrp	x8, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
1047268b0: 910da108    	add	x8, x8, #0x368 ; CFString 'Index >= view controllers count!'
1047268b4: f90003e8    	str	x8, [sp]
1047268b8: 900b5823    	adrp	x3, 0x11b22a000 <dyld_stub_binder+0x11b22a000>
1047268bc: 9114a863    	add	x3, x3, #0x52a ; string 'TabBar'
1047268c0: d00b8385    	adrp	x5, 0x11b798000 <dyld_stub_binder+0x11b798000>
1047268c4: 912d64a5    	add	x5, x5, #0xb59 ; string 'MMTabBarController.mm'
1047268c8: d00b8387    	adrp	x7, 0x11b798000 <dyld_stub_binder+0x11b798000>
1047268cc: 913bace7    	add	x7, x7, #0xeeb ; string '-[MMTabBarController showRedDotOnTabBarItemAtIndex:]'
1047268d0: 52800062    	mov	w2, #0x3                ; =3
1047268d4: 52800004    	mov	w4, #0x0                ; =0
1047268d8: 528044c6    	mov	w6, #0x226              ; =550
1047268dc: 94d40218    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047268e0: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1047268e4: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1047268e8: a94257f6    	ldp	x22, x21, [sp, #0x20]
1047268ec: a9415ff8    	ldp	x24, x23, [sp, #0x10]
1047268f0: 910143ff    	add	sp, sp, #0x50
1047268f4: d65f03c0    	ret
