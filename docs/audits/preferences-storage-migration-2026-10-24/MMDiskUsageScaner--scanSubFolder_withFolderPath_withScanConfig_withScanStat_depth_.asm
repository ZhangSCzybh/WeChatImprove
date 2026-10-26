
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029c2430: d10483ff    	sub	sp, sp, #0x120
1029c2434: 6d0b23e9    	stp	d9, d8, [sp, #0xb0]
1029c2438: a90c6ffc    	stp	x28, x27, [sp, #0xc0]
1029c243c: a90d67fa    	stp	x26, x25, [sp, #0xd0]
1029c2440: a90e5ff8    	stp	x24, x23, [sp, #0xe0]
1029c2444: a90f57f6    	stp	x22, x21, [sp, #0xf0]
1029c2448: a9104ff4    	stp	x20, x19, [sp, #0x100]
1029c244c: a9117bfd    	stp	x29, x30, [sp, #0x110]
1029c2450: 910443fd    	add	x29, sp, #0x110
1029c2454: b9004fe6    	str	w6, [sp, #0x4c]
1029c2458: aa0503f6    	mov	x22, x5
1029c245c: aa0403f5    	mov	x21, x4
1029c2460: aa0303f4    	mov	x20, x3
1029c2464: aa0203f3    	mov	x19, x2
1029c2468: aa0003f8    	mov	x24, x0
1029c246c: 900f13a8    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1029c2470: 52800029    	mov	w9, #0x1                ; =1
1029c2474: 3934e109    	strb	w9, [x8, #0xd38]
1029c2478: aa0203e0    	mov	x0, x2
1029c247c: 9549932f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c2480: aa1403e0    	mov	x0, x20
1029c2484: 9549932d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c2488: aa1503e0    	mov	x0, x21
1029c248c: 9549932b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c2490: aa1603e0    	mov	x0, x22
1029c2494: 95499329    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c2498: d00ea9a8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c249c: f942f519    	ldr	x25, [x8, #0x5e8] ; m_arrChildFolder
1029c24a0: aa1303e0    	mov	x0, x19
1029c24a4: aa1903e1    	mov	x1, x25
1029c24a8: 95499325    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c24ac: aa1d03fd    	mov	x29, x29
1029c24b0: 95499326    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c24b4: b40016c0    	cbz	x0, 0x1029c278c <_Flutter_Image_provideRelativePathByUrl+0xdcf63c>
1029c24b8: aa0003fa    	mov	x26, x0
1029c24bc: aa1303e0    	mov	x0, x19
1029c24c0: aa1903e1    	mov	x1, x25
1029c24c4: 9549931e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c24c8: aa1d03fd    	mov	x29, x29
1029c24cc: 9549931f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c24d0: aa0003fb    	mov	x27, x0
1029c24d4: d00eb9e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029c24d8: f9435117    	ldr	x23, [x8, #0x6a0] ; count
1029c24dc: aa1703e1    	mov	x1, x23
1029c24e0: 95499317    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c24e4: aa0003fc    	mov	x28, x0
1029c24e8: aa1b03e0    	mov	x0, x27
1029c24ec: 9549931a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c24f0: aa1a03e0    	mov	x0, x26
1029c24f4: 95499318    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c24f8: b40014bc    	cbz	x28, 0x1029c278c <_Flutter_Image_provideRelativePathByUrl+0xdcf63c>
1029c24fc: aa1303e0    	mov	x0, x19
1029c2500: aa1903e1    	mov	x1, x25
1029c2504: 9549930e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2508: aa1d03fd    	mov	x29, x29
1029c250c: 9549930f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c2510: aa0003fa    	mov	x26, x0
1029c2514: aa1703e1    	mov	x1, x23
1029c2518: 95499309    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c251c: aa0003f7    	mov	x23, x0
1029c2520: aa1a03e0    	mov	x0, x26
1029c2524: 9549930c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c2528: b4001297    	cbz	x23, 0x1029c2778 <_Flutter_Image_provideRelativePathByUrl+0xdcf628>
1029c252c: d280001a    	mov	x26, #0x0               ; =0
1029c2530: d00ea9a8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c2534: f9461509    	ldr	x9, [x8, #0xc28] ; scannerStatus
1029c2538: d00eba08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1029c253c: f947e108    	ldr	x8, [x8, #0xfc0] ; objectAtIndexedSubscript:
1029c2540: a903a7e8    	stp	x8, x9, [sp, #0x38]
1029c2544: f00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c2548: f9411d09    	ldr	x9, [x8, #0x238] ; m_subFolderNum
1029c254c: f00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c2550: f9412108    	ldr	x8, [x8, #0x240] ; setM_subFolderNum:
1029c2554: a902a7e8    	stp	x8, x9, [sp, #0x28]
1029c2558: f00ea648    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029c255c: f9476909    	ldr	x9, [x8, #0xed0] ; matchBizWithChildFolder:parentFolder:
1029c2560: d00ea988    	adrp	x8, 0x11fef4000 <dyld_stub_binder+0x11fef4000>
1029c2564: f945b908    	ldr	x8, [x8, #0xb70] ; workQueue
1029c2568: a901a7e8    	stp	x8, x9, [sp, #0x18]
1029c256c: f00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c2570: f9406908    	ldr	x8, [x8, #0xd0] ; slowDownCheckSubFileNum
1029c2574: f9002be8    	str	x8, [sp, #0x50]
1029c2578: d00ea9a8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c257c: f9477909    	ldr	x9, [x8, #0xef0] ; m_curScannedFolderNum
1029c2580: f00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c2584: f9406d08    	ldr	x8, [x8, #0xd8] ; slowDownSleepMillisecond
1029c2588: a90027e8    	stp	x8, x9, [sp]
1029c258c: f00b1de8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1029c2590: d00eb9e9    	adrp	x9, 0x120100000 <dyld_stub_binder+0x120100000>
1029c2594: f9435129    	ldr	x9, [x9, #0x6a0] ; count
1029c2598: f9000be9    	str	x9, [sp, #0x10]
1029c259c: fd41c508    	ldr	d8, [x8, #0x388]
1029c25a0: 95499300    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
1029c25a4: aa0003fb    	mov	x27, x0
1029c25a8: aa1803e0    	mov	x0, x24
1029c25ac: f94023e1    	ldr	x1, [sp, #0x40]
1029c25b0: 954992e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c25b4: 7100081f    	cmp	w0, #0x2
1029c25b8: 54000dc0    	b.eq	0x1029c2770 <_Flutter_Image_provideRelativePathByUrl+0xdcf620>
1029c25bc: aa1303e0    	mov	x0, x19
1029c25c0: aa1903e1    	mov	x1, x25
1029c25c4: 954992de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c25c8: aa1d03fd    	mov	x29, x29
1029c25cc: 954992df    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c25d0: aa0003fc    	mov	x28, x0
1029c25d4: f9401fe1    	ldr	x1, [sp, #0x38]
1029c25d8: aa1a03e2    	mov	x2, x26
1029c25dc: 954992d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c25e0: aa1d03fd    	mov	x29, x29
1029c25e4: 954992d9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c25e8: aa0003f7    	mov	x23, x0
1029c25ec: aa1c03e0    	mov	x0, x28
1029c25f0: 954992d9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c25f4: aa1303e0    	mov	x0, x19
1029c25f8: f9401be1    	ldr	x1, [sp, #0x30]
1029c25fc: 954992d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2600: 11000402    	add	w2, w0, #0x1
1029c2604: aa1303e0    	mov	x0, x19
1029c2608: f94017e1    	ldr	x1, [sp, #0x28]
1029c260c: 954992cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2610: d00ebdc8    	adrp	x8, 0x12017c000 <dyld_stub_binder+0x12017c000>
1029c2614: f943c500    	ldr	x0, [x8, #0x788]
1029c2618: f94013e1    	ldr	x1, [sp, #0x20]
1029c261c: aa1703e2    	mov	x2, x23
1029c2620: aa1303e3    	mov	x3, x19
1029c2624: 954992c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2628: aa1803e0    	mov	x0, x24
1029c262c: f9400fe1    	ldr	x1, [sp, #0x18]
1029c2630: 954992c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2634: aa1d03fd    	mov	x29, x29
1029c2638: 954992c4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c263c: aa0003fc    	mov	x28, x0
1029c2640: 900d6168    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1029c2644: f947dd08    	ldr	x8, [x8, #0xfb8]
1029c2648: f9002fe8    	str	x8, [sp, #0x58]
1029c264c: fd0033e8    	str	d8, [sp, #0x60]
1029c2650: 90000008    	adrp	x8, 0x1029c2000 <_Flutter_Image_provideRelativePathByUrl+0xdceeb0>
1029c2654: 911f3109    	add	x9, x8, #0x7cc
1029c2658: d00d63a8    	adrp	x8, 0x11d638000 <dyld_stub_binder+0x11d638000>
1029c265c: 9102a108    	add	x8, x8, #0xa8
1029c2660: a906a3e9    	stp	x9, x8, [sp, #0x68]
1029c2664: f9003ff8    	str	x24, [sp, #0x78]
1029c2668: aa1703e0    	mov	x0, x23
1029c266c: 954992b3    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c2670: f90043f7    	str	x23, [sp, #0x80]
1029c2674: aa1403e0    	mov	x0, x20
1029c2678: 954992b0    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c267c: f90047f4    	str	x20, [sp, #0x88]
1029c2680: aa1503e0    	mov	x0, x21
1029c2684: 954992ad    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c2688: f9004bf5    	str	x21, [sp, #0x90]
1029c268c: aa1603e0    	mov	x0, x22
1029c2690: 954992aa    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c2694: f9004ff6    	str	x22, [sp, #0x98]
1029c2698: b9404fe8    	ldr	w8, [sp, #0x4c]
1029c269c: b900a3e8    	str	w8, [sp, #0xa0]
1029c26a0: 910163e1    	add	x1, sp, #0x58
1029c26a4: aa1c03e0    	mov	x0, x28
1029c26a8: 954992cd    	bl	0x107c271dc <_Flutter_MMFoundation_BindContext+0x4102dc0>
1029c26ac: aa1c03e0    	mov	x0, x28
1029c26b0: 954992a9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c26b4: aa1803e0    	mov	x0, x24
1029c26b8: f9402be1    	ldr	x1, [sp, #0x50]
1029c26bc: 954992a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c26c0: 34000220    	cbz	w0, 0x1029c2704 <_Flutter_Image_provideRelativePathByUrl+0xdcf5b4>
1029c26c4: aa1603e0    	mov	x0, x22
1029c26c8: f94007e1    	ldr	x1, [sp, #0x8]
1029c26cc: 9549929c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c26d0: aa0003fc    	mov	x28, x0
1029c26d4: aa1803e0    	mov	x0, x24
1029c26d8: f9402be1    	ldr	x1, [sp, #0x50]
1029c26dc: 95499298    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c26e0: 1ac00b88    	udiv	w8, w28, w0
1029c26e4: 1b00f108    	msub	w8, w8, w0, w28
1029c26e8: 350000e8    	cbnz	w8, 0x1029c2704 <_Flutter_Image_provideRelativePathByUrl+0xdcf5b4>
1029c26ec: aa1803e0    	mov	x0, x24
1029c26f0: f94003e1    	ldr	x1, [sp]
1029c26f4: 95499292    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c26f8: 52807d08    	mov	w8, #0x3e8              ; =1000
1029c26fc: 1b087c00    	mul	w0, w0, w8
1029c2700: 95499480    	bl	0x107c27900 <_Flutter_MMFoundation_BindContext+0x41034e4>
1029c2704: f9404fe0    	ldr	x0, [sp, #0x98]
1029c2708: 95499293    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c270c: f9404be0    	ldr	x0, [sp, #0x90]
1029c2710: 95499291    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c2714: f94047e0    	ldr	x0, [sp, #0x88]
1029c2718: 9549928f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c271c: f94043e0    	ldr	x0, [sp, #0x80]
1029c2720: 9549928d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c2724: aa1703e0    	mov	x0, x23
1029c2728: 9549928b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c272c: aa1b03e0    	mov	x0, x27
1029c2730: 9549929f    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
1029c2734: 9100075a    	add	x26, x26, #0x1
1029c2738: aa1303e0    	mov	x0, x19
1029c273c: aa1903e1    	mov	x1, x25
1029c2740: 9549927f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2744: aa1d03fd    	mov	x29, x29
1029c2748: 95499280    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c274c: aa0003f7    	mov	x23, x0
1029c2750: f9400be1    	ldr	x1, [sp, #0x10]
1029c2754: 9549927a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2758: aa0003fb    	mov	x27, x0
1029c275c: aa1703e0    	mov	x0, x23
1029c2760: 9549927d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c2764: eb1b035f    	cmp	x26, x27
1029c2768: 54fff1c3    	b.lo	0x1029c25a0 <_Flutter_Image_provideRelativePathByUrl+0xdcf450>
1029c276c: 14000003    	b	0x1029c2778 <_Flutter_Image_provideRelativePathByUrl+0xdcf628>
1029c2770: aa1b03e0    	mov	x0, x27
1029c2774: 9549928e    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
1029c2778: d00ea9a8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c277c: f942ed01    	ldr	x1, [x8, #0x5d8] ; setM_arrChildFolder:
1029c2780: aa1303e0    	mov	x0, x19
1029c2784: d2800002    	mov	x2, #0x0                ; =0
1029c2788: 9549926d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c278c: aa1603e0    	mov	x0, x22
1029c2790: 95499271    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c2794: aa1503e0    	mov	x0, x21
1029c2798: 9549926f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c279c: aa1403e0    	mov	x0, x20
1029c27a0: 9549926d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c27a4: aa1303e0    	mov	x0, x19
1029c27a8: a9517bfd    	ldp	x29, x30, [sp, #0x110]
1029c27ac: a9504ff4    	ldp	x20, x19, [sp, #0x100]
1029c27b0: a94f57f6    	ldp	x22, x21, [sp, #0xf0]
1029c27b4: a94e5ff8    	ldp	x24, x23, [sp, #0xe0]
1029c27b8: a94d67fa    	ldp	x26, x25, [sp, #0xd0]
1029c27bc: a94c6ffc    	ldp	x28, x27, [sp, #0xc0]
1029c27c0: 6d4b23e9    	ldp	d9, d8, [sp, #0xb0]
1029c27c4: 910483ff    	add	sp, sp, #0x120
1029c27c8: 15499263    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
