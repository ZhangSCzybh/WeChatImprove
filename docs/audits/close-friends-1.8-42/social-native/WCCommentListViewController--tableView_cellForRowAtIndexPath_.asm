
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106ee2490: 6db923e9    	stp	d9, d8, [sp, #-0x70]!
106ee2494: a9016ffc    	stp	x28, x27, [sp, #0x10]
106ee2498: a90267fa    	stp	x26, x25, [sp, #0x20]
106ee249c: a9035ff8    	stp	x24, x23, [sp, #0x30]
106ee24a0: a90457f6    	stp	x22, x21, [sp, #0x40]
106ee24a4: a9054ff4    	stp	x20, x19, [sp, #0x50]
106ee24a8: a9067bfd    	stp	x29, x30, [sp, #0x60]
106ee24ac: 910183fd    	add	x29, sp, #0x60
106ee24b0: aa0303f3    	mov	x19, x3
106ee24b4: aa0203f4    	mov	x20, x2
106ee24b8: aa0003f5    	mov	x21, x0
106ee24bc: 900ceb28    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
106ee24c0: 52800029    	mov	w9, #0x1                ; =1
106ee24c4: 391fc109    	strb	w9, [x8, #0x7f0]
106ee24c8: aa0303e0    	mov	x0, x3
106ee24cc: 9435131b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106ee24d0: d00c90e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106ee24d4: f9477501    	ldr	x1, [x8, #0xee8] ; dequeueReusableCellWithIdentifier:
106ee24d8: 900bd062    	adrp	x2, 0x11e8ee000 <dyld_stub_binder+0x11e8ee000>
106ee24dc: 9123a042    	add	x2, x2, #0x8e8
106ee24e0: aa1403e0    	mov	x0, x20
106ee24e4: 94351316    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee24e8: aa1d03fd    	mov	x29, x29
106ee24ec: 94351317    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ee24f0: aa0003f4    	mov	x20, x0
106ee24f4: b00c9148    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
106ee24f8: f946d518    	ldr	x24, [x8, #0xda8] ; view
106ee24fc: aa1503e0    	mov	x0, x21
106ee2500: aa1803e1    	mov	x1, x24
106ee2504: 9435130e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2508: aa1d03fd    	mov	x29, x29
106ee250c: 9435130f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ee2510: aa0003f6    	mov	x22, x0
106ee2514: b00c9148    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
106ee2518: f947a517    	ldr	x23, [x8, #0xf48] ; width
106ee251c: aa1703e1    	mov	x1, x23
106ee2520: 94351307    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2524: 1e604002    	fmov	d2, d0
106ee2528: d00c9128    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
106ee252c: f9403519    	ldr	x25, [x8, #0x68] ; setFrame:
106ee2530: d2e80ac8    	mov	x8, #0x4056000000000000 ; =4635892866424504320
106ee2534: 9e670108    	fmov	d8, x8
106ee2538: 9e6703e0    	fmov	d0, xzr
106ee253c: 9e6703e1    	fmov	d1, xzr
106ee2540: aa1403e0    	mov	x0, x20
106ee2544: aa1903e1    	mov	x1, x25
106ee2548: 1e604103    	fmov	d3, d8
106ee254c: 943512fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2550: aa1603e0    	mov	x0, x22
106ee2554: 94351300    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ee2558: d00c90e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106ee255c: f9427516    	ldr	x22, [x8, #0x4e8] ; contentView
106ee2560: aa1403e0    	mov	x0, x20
106ee2564: aa1603e1    	mov	x1, x22
106ee2568: 943512f5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee256c: aa1d03fd    	mov	x29, x29
106ee2570: 943512f6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ee2574: aa0003fa    	mov	x26, x0
106ee2578: aa1503e0    	mov	x0, x21
106ee257c: aa1803e1    	mov	x1, x24
106ee2580: 943512ef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2584: aa1d03fd    	mov	x29, x29
106ee2588: 943512f0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ee258c: aa0003f8    	mov	x24, x0
106ee2590: aa1703e1    	mov	x1, x23
106ee2594: 943512ea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2598: 1e604002    	fmov	d2, d0
106ee259c: 9e6703e0    	fmov	d0, xzr
106ee25a0: 9e6703e1    	fmov	d1, xzr
106ee25a4: aa1a03e0    	mov	x0, x26
106ee25a8: aa1903e1    	mov	x1, x25
106ee25ac: 1e604103    	fmov	d3, d8
106ee25b0: 943512e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee25b4: aa1803e0    	mov	x0, x24
106ee25b8: 943512e7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ee25bc: aa1a03e0    	mov	x0, x26
106ee25c0: 943512e5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ee25c4: b4000174    	cbz	x20, 0x106ee25f0 <_Flutter_MMFoundation_BindContext+0x33be1d4>
106ee25c8: aa1403e0    	mov	x0, x20
106ee25cc: aa1603e1    	mov	x1, x22
106ee25d0: 943512db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee25d4: aa1d03fd    	mov	x29, x29
106ee25d8: 943512dc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ee25dc: aa0003f8    	mov	x24, x0
106ee25e0: b00c7ac8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106ee25e4: f947f901    	ldr	x1, [x8, #0xff0] ; removeAllSubViews
106ee25e8: 943512d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee25ec: 14000018    	b	0x106ee264c <_Flutter_MMFoundation_BindContext+0x33be230>
106ee25f0: 900c94c8    	adrp	x8, 0x12017a000 <dyld_stub_binder+0x12017a000>
106ee25f4: f9403900    	ldr	x0, [x8, #0x70]
106ee25f8: 943512da    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106ee25fc: f00c7aa8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106ee2600: f9463501    	ldr	x1, [x8, #0xc68] ; initWithStyle:reuseIdentifier:
106ee2604: 900bd063    	adrp	x3, 0x11e8ee000 <dyld_stub_binder+0x11e8ee000>
106ee2608: 9123a063    	add	x3, x3, #0x8e8
106ee260c: d2800002    	mov	x2, #0x0                ; =0
106ee2610: 943512cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2614: aa0003f4    	mov	x20, x0
106ee2618: b00c9488    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106ee261c: f9462d00    	ldr	x0, [x8, #0xc58]
106ee2620: d00c7ac8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106ee2624: f940a101    	ldr	x1, [x8, #0x140] ; cellBackgroundColor
106ee2628: 943512c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee262c: aa1d03fd    	mov	x29, x29
106ee2630: 943512c6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ee2634: aa0003f8    	mov	x24, x0
106ee2638: d00c7e08    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
106ee263c: f944e101    	ldr	x1, [x8, #0x9c0] ; setMenuBackgroundColor:
106ee2640: aa1403e0    	mov	x0, x20
106ee2644: aa1803e2    	mov	x2, x24
106ee2648: 943512bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee264c: aa1803e0    	mov	x0, x24
106ee2650: 943512c1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ee2654: 900c9128    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
106ee2658: f9440901    	ldr	x1, [x8, #0x810] ; row
106ee265c: aa1303e0    	mov	x0, x19
106ee2660: 943512b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2664: aa0003f8    	mov	x24, x0
106ee2668: d00c7ac8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106ee266c: f9427d01    	ldr	x1, [x8, #0x4f8] ; section
106ee2670: aa1303e0    	mov	x0, x19
106ee2674: 943512b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2678: aa0003e2    	mov	x2, x0
106ee267c: 900c8888    	adrp	x8, 0x11fff2000 <dyld_stub_binder+0x11fff2000>
106ee2680: f9479901    	ldr	x1, [x8, #0xf30] ; getWCCommentListCount:
106ee2684: aa1503e0    	mov	x0, x21
106ee2688: 943512ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee268c: eb00031f    	cmp	x24, x0
106ee2690: 54000f22    	b.hs	0x106ee2874 <_Flutter_MMFoundation_BindContext+0x33be458>
106ee2694: b00c88e8    	adrp	x8, 0x11ffff000 <dyld_stub_binder+0x11ffff000>
106ee2698: f9441901    	ldr	x1, [x8, #0x830] ; getWCMessagesWithDataArray:
106ee269c: aa1503e0    	mov	x0, x21
106ee26a0: aa1303e2    	mov	x2, x19
106ee26a4: 943512a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee26a8: aa1d03fd    	mov	x29, x29
106ee26ac: 943512a7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ee26b0: aa0003f8    	mov	x24, x0
106ee26b4: f00c9b08    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106ee26b8: b9897d08    	ldrsw	x8, [x8, #0x97c]
106ee26bc: f8686ab9    	ldr	x25, [x21, x8]
106ee26c0: b00c88e8    	adrp	x8, 0x11ffff000 <dyld_stub_binder+0x11ffff000>
106ee26c4: f9436d01    	ldr	x1, [x8, #0x6d8] ; getObjIDByWCMessage:
106ee26c8: aa1503e0    	mov	x0, x21
106ee26cc: aa1803e2    	mov	x2, x24
106ee26d0: 9435129b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee26d4: aa1d03fd    	mov	x29, x29
106ee26d8: 9435129c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ee26dc: aa0003fa    	mov	x26, x0
106ee26e0: d00c9108    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
106ee26e4: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
106ee26e8: aa1903e0    	mov	x0, x25
106ee26ec: aa1a03e2    	mov	x2, x26
106ee26f0: 94351293    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee26f4: aa1d03fd    	mov	x29, x29
106ee26f8: 94351294    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ee26fc: aa0003f9    	mov	x25, x0
106ee2700: aa1a03e0    	mov	x0, x26
106ee2704: 94351294    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ee2708: f00c95c8    	adrp	x8, 0x12019d000 <dyld_stub_binder+0x12019d000>
106ee270c: f944ed00    	ldr	x0, [x8, #0x9d8]
106ee2710: 94351292    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
106ee2714: aa0003fa    	mov	x26, x0
106ee2718: b00c9128    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
106ee271c: f9451501    	ldr	x1, [x8, #0xa28] ; setDelegate:
106ee2720: aa1503e2    	mov	x2, x21
106ee2724: 94351286    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2728: f00c8808    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
106ee272c: f9426d01    	ldr	x1, [x8, #0x4d8] ; pageContext
106ee2730: aa1503e0    	mov	x0, x21
106ee2734: 94351282    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2738: aa1d03fd    	mov	x29, x29
106ee273c: 94351283    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ee2740: aa0003fb    	mov	x27, x0
106ee2744: f00c88c8    	adrp	x8, 0x11fffd000 <dyld_stub_binder+0x11fffd000>
106ee2748: f947e501    	ldr	x1, [x8, #0xfc8] ; setPageContext:
106ee274c: aa1a03e0    	mov	x0, x26
106ee2750: aa1b03e2    	mov	x2, x27
106ee2754: 9435127a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2758: aa1b03e0    	mov	x0, x27
106ee275c: 9435127e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ee2760: aa1403e0    	mov	x0, x20
106ee2764: aa1603e1    	mov	x1, x22
106ee2768: 94351275    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee276c: aa1d03fd    	mov	x29, x29
106ee2770: 94351276    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ee2774: aa0003fb    	mov	x27, x0
106ee2778: aa1703e1    	mov	x1, x23
106ee277c: 94351270    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2780: b00c88e8    	adrp	x8, 0x11ffff000 <dyld_stub_binder+0x11ffff000>
106ee2784: f9442501    	ldr	x1, [x8, #0x848] ; config:dataItem:width:
106ee2788: aa1a03e0    	mov	x0, x26
106ee278c: aa1803e2    	mov	x2, x24
106ee2790: aa1903e3    	mov	x3, x25
106ee2794: 9435126a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2798: aa1b03e0    	mov	x0, x27
106ee279c: 9435126e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ee27a0: f00c9b08    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106ee27a4: b9897108    	ldrsw	x8, [x8, #0x970]
106ee27a8: f8686ab7    	ldr	x23, [x21, x8]
106ee27ac: f00c8748    	adrp	x8, 0x11ffcd000 <dyld_stub_binder+0x11ffcd000>
106ee27b0: f946e101    	ldr	x1, [x8, #0xdc0] ; msgID
106ee27b4: aa1803e0    	mov	x0, x24
106ee27b8: 94351261    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee27bc: aa1d03fd    	mov	x29, x29
106ee27c0: 94351262    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ee27c4: aa0003fb    	mov	x27, x0
106ee27c8: f00c7aa8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106ee27cc: f942c901    	ldr	x1, [x8, #0x590] ; safeSetObject:forKey:
106ee27d0: aa1703e0    	mov	x0, x23
106ee27d4: aa1a03e2    	mov	x2, x26
106ee27d8: aa1b03e3    	mov	x3, x27
106ee27dc: 94351258    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee27e0: aa1b03e0    	mov	x0, x27
106ee27e4: 9435125c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ee27e8: aa1403e0    	mov	x0, x20
106ee27ec: aa1603e1    	mov	x1, x22
106ee27f0: 94351253    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee27f4: aa1d03fd    	mov	x29, x29
106ee27f8: 94351254    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ee27fc: aa0003f6    	mov	x22, x0
106ee2800: 900c90e8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
106ee2804: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
106ee2808: aa1a03e2    	mov	x2, x26
106ee280c: 9435124c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2810: aa1603e0    	mov	x0, x22
106ee2814: 94351250    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ee2818: d00c7ac8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106ee281c: f9436501    	ldr	x1, [x8, #0x6c8] ; setSelectionStyle:
106ee2820: aa1403e0    	mov	x0, x20
106ee2824: 52800022    	mov	w2, #0x1                ; =1
106ee2828: 94351245    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee282c: b00c88e8    	adrp	x8, 0x11ffff000 <dyld_stub_binder+0x11ffff000>
106ee2830: f9442901    	ldr	x1, [x8, #0x850] ; updateEditInfo:indexPath:
106ee2834: aa1503e0    	mov	x0, x21
106ee2838: aa1403e2    	mov	x2, x20
106ee283c: aa1303e3    	mov	x3, x19
106ee2840: 9435123f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2844: b00c88e8    	adrp	x8, 0x11ffff000 <dyld_stub_binder+0x11ffff000>
106ee2848: f9442d01    	ldr	x1, [x8, #0x858] ; setupActionsForTargetView:
106ee284c: aa1a03e0    	mov	x0, x26
106ee2850: aa1403e2    	mov	x2, x20
106ee2854: 9435123a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2858: aa1403e0    	mov	x0, x20
106ee285c: 94351237    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106ee2860: aa1a03e0    	mov	x0, x26
106ee2864: 9435123c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ee2868: aa1903e0    	mov	x0, x25
106ee286c: 9435123a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ee2870: 1400001a    	b	0x106ee28d8 <_Flutter_MMFoundation_BindContext+0x33be4bc>
106ee2874: b00c88e8    	adrp	x8, 0x11ffff000 <dyld_stub_binder+0x11ffff000>
106ee2878: f9442101    	ldr	x1, [x8, #0x840] ; getLoadMoreCell
106ee287c: aa1503e0    	mov	x0, x21
106ee2880: 9435122f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2884: aa1d03fd    	mov	x29, x29
106ee2888: 94351230    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ee288c: aa0003f8    	mov	x24, x0
106ee2890: aa1403e0    	mov	x0, x20
106ee2894: aa1603e1    	mov	x1, x22
106ee2898: 94351229    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee289c: aa1d03fd    	mov	x29, x29
106ee28a0: 9435122a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ee28a4: aa0003f5    	mov	x21, x0
106ee28a8: 900c90e8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
106ee28ac: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
106ee28b0: aa1803e2    	mov	x2, x24
106ee28b4: 94351222    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee28b8: aa1503e0    	mov	x0, x21
106ee28bc: 94351226    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ee28c0: aa1403e0    	mov	x0, x20
106ee28c4: 9435121d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106ee28c8: f00c7bc8    	adrp	x8, 0x11fe5d000 <dyld_stub_binder+0x11fe5d000>
106ee28cc: f941b501    	ldr	x1, [x8, #0x368] ; setMenuItemsWithNoDeleteBtn:
106ee28d0: d2800002    	mov	x2, #0x0                ; =0
106ee28d4: 9435121a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee28d8: aa1803e0    	mov	x0, x24
106ee28dc: 9435121e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ee28e0: aa1403e0    	mov	x0, x20
106ee28e4: 9435121c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ee28e8: aa1303e0    	mov	x0, x19
106ee28ec: 9435121a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ee28f0: aa1403e0    	mov	x0, x20
106ee28f4: a9467bfd    	ldp	x29, x30, [sp, #0x60]
106ee28f8: a9454ff4    	ldp	x20, x19, [sp, #0x50]
106ee28fc: a94457f6    	ldp	x22, x21, [sp, #0x40]
106ee2900: a9435ff8    	ldp	x24, x23, [sp, #0x30]
106ee2904: a94267fa    	ldp	x26, x25, [sp, #0x20]
106ee2908: a9416ffc    	ldp	x28, x27, [sp, #0x10]
106ee290c: 6cc723e9    	ldp	d9, d8, [sp], #0x70
106ee2910: 14351218    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
