
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1047263ac: d10143ff    	sub	sp, sp, #0x50
1047263b0: a9015ff8    	stp	x24, x23, [sp, #0x10]
1047263b4: a90257f6    	stp	x22, x21, [sp, #0x20]
1047263b8: a9034ff4    	stp	x20, x19, [sp, #0x30]
1047263bc: a9047bfd    	stp	x29, x30, [sp, #0x40]
1047263c0: 910103fd    	add	x29, sp, #0x40
1047263c4: f00e28a8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
1047263c8: 52800029    	mov	w9, #0x1                ; =1
1047263cc: 3919fd09    	strb	w9, [x8, #0x67f]
1047263d0: b00dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
1047263d4: b989ed08    	ldrsw	x8, [x8, #0x9ec]
1047263d8: f8686808    	ldr	x8, [x0, x8]
1047263dc: eb03011f    	cmp	x8, x3
1047263e0: 54000229    	b.ls	0x104726424 <_Flutter_MMFoundation_BindContext+0xc02008>
1047263e4: aa0303f3    	mov	x19, x3
1047263e8: aa0203f5    	mov	x21, x2
1047263ec: aa0003f4    	mov	x20, x0
1047263f0: b4000482    	cbz	x2, 0x104726480 <_Flutter_MMFoundation_BindContext+0xc02064>
1047263f4: b00dd268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1047263f8: f9454500    	ldr	x0, [x8, #0xa88] ; class NSString
1047263fc: 900dcf28    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104726400: f946a501    	ldr	x1, [x8, #0xd48] ; selector stringWithFormat:
104726404: f90003f5    	str	x21, [sp]
104726408: 900cece2    	adrp	x2, 0x11e4c2000 <dyld_stub_binder+0x11e4c2000>
10472640c: 913d2042    	add	x2, x2, #0xf48 ; CFString '%ld'
104726410: 94d4034b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726414: aa1d03fd    	mov	x29, x29
104726418: 94d4034c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10472641c: aa0003f6    	mov	x22, x0
104726420: 14000019    	b	0x104726484 <_Flutter_MMFoundation_BindContext+0xc02068>
104726424: b00dd268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104726428: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
10472642c: f00db888    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104726430: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104726434: b00d0228    	adrp	x8, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
104726438: 910da108    	add	x8, x8, #0x368 ; CFString 'Index >= view controllers count!'
10472643c: f90003e8    	str	x8, [sp]
104726440: 900b5823    	adrp	x3, 0x11b22a000 <dyld_stub_binder+0x11b22a000>
104726444: 9114a863    	add	x3, x3, #0x52a ; string 'TabBar'
104726448: d00b8385    	adrp	x5, 0x11b798000 <dyld_stub_binder+0x11b798000>
10472644c: 912d64a5    	add	x5, x5, #0xb59 ; string 'MMTabBarController.mm'
104726450: d00b8387    	adrp	x7, 0x11b798000 <dyld_stub_binder+0x11b798000>
104726454: 91392ce7    	add	x7, x7, #0xe4b ; string '-[MMTabBarController setTabBarBadgeValue:forIndex:]'
104726458: 52800062    	mov	w2, #0x3                ; =3
10472645c: 52800004    	mov	w4, #0x0                ; =0
104726460: 52804026    	mov	w6, #0x201              ; =513
104726464: 94d40336    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726468: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10472646c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104726470: a94257f6    	ldp	x22, x21, [sp, #0x20]
104726474: a9415ff8    	ldp	x24, x23, [sp, #0x10]
104726478: 910143ff    	add	sp, sp, #0x50
10472647c: d65f03c0    	ret
104726480: d2800016    	mov	x22, #0x0               ; =0
104726484: f00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104726488: f945f901    	ldr	x1, [x8, #0xbf0] ; selector customTabBar
10472648c: aa1403e0    	mov	x0, x20
104726490: 94d4032b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726494: aa1d03fd    	mov	x29, x29
104726498: 94d4032c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10472649c: aa0003f7    	mov	x23, x0
1047264a0: b00dbd08    	adrp	x8, 0x11fec7000 <dyld_stub_binder+0x11fec7000>
1047264a4: f9457101    	ldr	x1, [x8, #0xae0] ; selector tabBarItemViewAtIndex:
1047264a8: aa1303e2    	mov	x2, x19
1047264ac: 94d40324    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047264b0: aa1d03fd    	mov	x29, x29
1047264b4: 94d40325    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047264b8: aa0003f8    	mov	x24, x0
1047264bc: aa1703e0    	mov	x0, x23
1047264c0: 94d40325    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047264c4: b00dbd08    	adrp	x8, 0x11fec7000 <dyld_stub_binder+0x11fec7000>
1047264c8: f9457501    	ldr	x1, [x8, #0xae8] ; selector setTabBarBadgeValue:
1047264cc: aa1803e0    	mov	x0, x24
1047264d0: aa1503e2    	mov	x2, x21
1047264d4: 94d4031a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047264d8: f00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
1047264dc: f9465501    	ldr	x1, [x8, #0xca8] ; selector getTabbarItemForIndex:
1047264e0: aa1403e0    	mov	x0, x20
1047264e4: aa1303e2    	mov	x2, x19
1047264e8: 94d40315    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047264ec: aa1d03fd    	mov	x29, x29
1047264f0: 94d40316    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047264f4: aa0003f3    	mov	x19, x0
1047264f8: b00db8c8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1047264fc: f947a501    	ldr	x1, [x8, #0xf48] ; selector setAccessibilityValue:
104726500: aa1603e2    	mov	x2, x22
104726504: 94d4030e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726508: aa1303e0    	mov	x0, x19
10472650c: 94d40312    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104726510: aa1803e0    	mov	x0, x24
104726514: 94d40310    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104726518: aa1603e0    	mov	x0, x22
10472651c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104726520: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104726524: a94257f6    	ldp	x22, x21, [sp, #0x20]
104726528: a9415ff8    	ldp	x24, x23, [sp, #0x10]
10472652c: 910143ff    	add	sp, sp, #0x50
104726530: 14d40309    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
