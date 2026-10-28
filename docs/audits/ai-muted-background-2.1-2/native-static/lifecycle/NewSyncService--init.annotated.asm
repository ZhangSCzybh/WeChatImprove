
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105180644: d10103ff    	sub	sp, sp, #0x40
105180648: a90157f6    	stp	x22, x21, [sp, #0x10]
10518064c: a9024ff4    	stp	x20, x19, [sp, #0x20]
105180650: a9037bfd    	stp	x29, x30, [sp, #0x30]
105180654: 9100c3fd    	add	x29, sp, #0x30
105180658: f00dd5e8    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
10518065c: 52800035    	mov	w21, #0x1               ; =1
105180660: 39335515    	strb	w21, [x8, #0xcd5]
105180664: d00d8228    	adrp	x8, 0x1201c6000 <dyld_stub_binder+0x1201c6000>
105180668: f940ad08    	ldr	x8, [x8, #0x158] ; class NewSyncService @ 0x1201c6158
10518066c: a90023e0    	stp	x0, x8, [sp]
105180670: d00d7c08    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105180674: f9466901    	ldr	x1, [x8, #0xcd0] ; selector init @ 0x120102cd0
105180678: 910003e0    	mov	x0, sp
10518067c: 94aa9ab2    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
105180680: aa0003f3    	mov	x19, x0
105180684: b4000ce0    	cbz	x0, 0x105180820 <_Flutter_MMFoundation_BindContext+0x165c404>
105180688: 900d8548    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10518068c: b9890908    	ldrsw	x8, [x8, #0x908] ; ivar m_bNeedSync offset 87 @ 0x120228908
105180690: 38286a7f    	strb	wzr, [x19, x8]
105180694: f00d6608    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
105180698: f9474901    	ldr	x1, [x8, #0xe90] ; selector setM_bHasSync: @ 0x11fe43e90
10518069c: aa1303e0    	mov	x0, x19
1051806a0: 52800002    	mov	w2, #0x0                ; =0
1051806a4: 94aa9aa6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051806a8: 900d8548    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051806ac: b9890d08    	ldrsw	x8, [x8, #0x90c] ; ivar m_bHasInit offset 8 @ 0x12022890c
1051806b0: 38286a7f    	strb	wzr, [x19, x8]
1051806b4: 900d8548    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051806b8: b9891108    	ldrsw	x8, [x8, #0x910] ; ivar m_bNeedSyncOplog offset 72 @ 0x120228910
1051806bc: 38286a7f    	strb	wzr, [x19, x8]
1051806c0: 900d8548    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051806c4: b9891508    	ldrsw	x8, [x8, #0x914] ; ivar m_bSyncOplog offset 73 @ 0x120228914
1051806c8: 38286a7f    	strb	wzr, [x19, x8]
1051806cc: 900d8548    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051806d0: b9891908    	ldrsw	x8, [x8, #0x918] ; ivar m_bIsSyncPause offset 84 @ 0x120228918
1051806d4: 38286a7f    	strb	wzr, [x19, x8]
1051806d8: 900d8548    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051806dc: b9891d08    	ldrsw	x8, [x8, #0x91c] ; ivar m_syncEventID offset 80 @ 0x12022891c
1051806e0: b8286a7f    	str	wzr, [x19, x8]
1051806e4: 900d70e8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
1051806e8: f9423101    	ldr	x1, [x8, #0x460] ; selector resetGettingData @ 0x11ff9c460
1051806ec: aa1303e0    	mov	x0, x19
1051806f0: 94aa9a93    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051806f4: 900d8548    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051806f8: b9892108    	ldrsw	x8, [x8, #0x920] ; ivar m_lastSyncFinishCallingExtension offset 76 @ 0x120228920
1051806fc: 38286a75    	strb	w21, [x19, x8]
105180700: 900d8548    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105180704: b9892508    	ldrsw	x8, [x8, #0x924] ; ivar m_uiSelector offset 12 @ 0x120228924
105180708: b8286a7f    	str	wzr, [x19, x8]
10518070c: 900d8548    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105180710: b9892908    	ldrsw	x8, [x8, #0x928] ; ivar m_uiSyncScene offset 16 @ 0x120228928
105180714: 528000e9    	mov	w9, #0x7                ; =7
105180718: b8286a69    	str	w9, [x19, x8]
10518071c: 900d8548    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105180720: b9892d08    	ldrsw	x8, [x8, #0x92c] ; ivar m_uiSyncContinueCount offset 20 @ 0x12022892c
105180724: b8286a7f    	str	wzr, [x19, x8]
105180728: 900d8548    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10518072c: b9893108    	ldrsw	x8, [x8, #0x930] ; ivar m_tLastNotify offset 32 @ 0x120228930
105180730: f8686a60    	ldr	x0, [x19, x8]
105180734: f8286a7f    	str	xzr, [x19, x8]
105180738: 94aa9a87    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10518073c: 900d8548    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105180740: b9893508    	ldrsw	x8, [x8, #0x934] ; ivar m_tLastLongConnDisconnect offset 40 @ 0x120228934
105180744: f8686a60    	ldr	x0, [x19, x8]
105180748: f8286a7f    	str	xzr, [x19, x8]
10518074c: 94aa9a82    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105180750: 900d8548    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105180754: b9893908    	ldrsw	x8, [x8, #0x938] ; ivar m_oMMDB offset 48 @ 0x120228938
105180758: f8686a60    	ldr	x0, [x19, x8]
10518075c: f8286a7f    	str	xzr, [x19, x8]
105180760: 94aa9a7d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105180764: 900d8548    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105180768: b9893d08    	ldrsw	x8, [x8, #0x93c] ; ivar m_oLock offset 56 @ 0x12022893c
10518076c: f8686a60    	ldr	x0, [x19, x8]
105180770: f8286a7f    	str	xzr, [x19, x8]
105180774: 94aa9a78    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105180778: f00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10518077c: f9458d00    	ldr	x0, [x8, #0xb18] ; bound-class ordinal 8764 @ 0x120173b18
105180780: 900d7c08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105180784: f946b101    	ldr	x1, [x8, #0xd60] ; selector defaultCenter @ 0x120100d60
105180788: 94aa9a6d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10518078c: aa1d03fd    	mov	x29, x29
105180790: 94aa9a6e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105180794: aa0003f4    	mov	x20, x0
105180798: 900d70e8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
10518079c: f942a103    	ldr	x3, [x8, #0x540] ; selector onWillSuspend @ 0x11ff9c540
1051807a0: 900c26e8    	adrp	x8, 0x11d65c000 <dyld_stub_binder+0x11d65c000>
1051807a4: 913a0108    	add	x8, x8, #0xe80
1051807a8: f9400104    	ldr	x4, [x8]
1051807ac: d00d7be8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1051807b0: f9470101    	ldr	x1, [x8, #0xe00] ; selector addObserver:selector:name:object: @ 0x1200fee00
1051807b4: aa1303e2    	mov	x2, x19
1051807b8: d2800005    	mov	x5, #0x0                ; =0
1051807bc: 94aa9a60    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051807c0: aa1403e0    	mov	x0, x20
1051807c4: 94aa9a64    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051807c8: 900d8548    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051807cc: b9894108    	ldrsw	x8, [x8, #0x940] ; ivar m_bSyncOpError offset 74 @ 0x120228940
1051807d0: 38286a7f    	strb	wzr, [x19, x8]
1051807d4: 900d8548    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051807d8: b9894508    	ldrsw	x8, [x8, #0x944] ; ivar m_bFirstSyncAfterBgfgChange offset 86 @ 0x120228944
1051807dc: 38286a75    	strb	w21, [x19, x8]
1051807e0: f00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1051807e4: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext @ 0x120173bd0
1051807e8: 900d7c08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1051807ec: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext @ 0x1201009d0
1051807f0: 94aa9a53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051807f4: aa1d03fd    	mov	x29, x29
1051807f8: 94aa9a54    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051807fc: aa0003f4    	mov	x20, x0
105180800: 900d7f88    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
105180804: f9462502    	ldr	x2, [x8, #0xc48]
105180808: d00d65c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10518080c: f940a101    	ldr	x1, [x8, #0x140] ; selector registerExtension:withTarget: @ 0x11fe3a140
105180810: aa1303e3    	mov	x3, x19
105180814: 94aa9a4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180818: aa1403e0    	mov	x0, x20
10518081c: 94aa9a4e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105180820: aa1303e0    	mov	x0, x19
105180824: a9437bfd    	ldp	x29, x30, [sp, #0x30]
105180828: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10518082c: a94157f6    	ldp	x22, x21, [sp, #0x10]
105180830: 910103ff    	add	sp, sp, #0x40
105180834: d65f03c0    	ret
