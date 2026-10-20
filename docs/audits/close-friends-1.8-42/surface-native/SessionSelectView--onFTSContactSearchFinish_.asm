
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1057f26bc: d10743ff    	sub	sp, sp, #0x1d0
1057f26c0: a9176ffc    	stp	x28, x27, [sp, #0x170]
1057f26c4: a91867fa    	stp	x26, x25, [sp, #0x180]
1057f26c8: a9195ff8    	stp	x24, x23, [sp, #0x190]
1057f26cc: a91a57f6    	stp	x22, x21, [sp, #0x1a0]
1057f26d0: a91b4ff4    	stp	x20, x19, [sp, #0x1b0]
1057f26d4: a91c7bfd    	stp	x29, x30, [sp, #0x1c0]
1057f26d8: 910703fd    	add	x29, sp, #0x1c0
1057f26dc: aa0203e8    	mov	x8, x2
1057f26e0: aa0003f6    	mov	x22, x0
1057f26e4: b00befe9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1057f26e8: f9405929    	ldr	x9, [x9, #0xb0]
1057f26ec: f9400129    	ldr	x9, [x9]
1057f26f0: f81a03a9    	stur	x9, [x29, #-0x60]
1057f26f4: f00da269    	adrp	x9, 0x120c41000 <dyld_stub_binder+0x120c41000>
1057f26f8: 5280002a    	mov	w10, #0x1               ; =1
1057f26fc: 3913d92a    	strb	w10, [x9, #0x4f6]
1057f2700: b00d51e9    	adrp	x9, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057f2704: b983bd38    	ldrsw	x24, [x9, #0x3bc] ; ivar SessionSelectView._taskKey
1057f2708: f8786802    	ldr	x2, [x0, x24]
1057f270c: b00d4889    	adrp	x9, 0x120103000 <dyld_stub_binder+0x120103000>
1057f2710: f943c921    	ldr	x1, [x9, #0x790] ; isEqualToString:
1057f2714: aa0803e0    	mov	x0, x8
1057f2718: 9490d289    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f271c: 34007100    	cbz	w0, 0x1057f353c <_Flutter_MMFoundation_BindContext+0x1ccf120>
1057f2720: 900d34c8    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1057f2724: f9425901    	ldr	x1, [x8, #0x4b0] ; setContactSearchDidFinish:
1057f2728: aa1603e0    	mov	x0, x22
1057f272c: 52800022    	mov	w2, #0x1                ; =1
1057f2730: 9490d283    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2734: b00d51e8    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057f2738: b983fd1b    	ldrsw	x27, [x8, #0x3fc] ; ivar SessionSelectView.arrSearchResultOfContacts
1057f273c: f87b6ac0    	ldr	x0, [x22, x27]
1057f2740: f83b6adf    	str	xzr, [x22, x27]
1057f2744: 9490d284    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f2748: b00d51e8    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057f274c: b9840119    	ldrsw	x25, [x8, #0x400] ; ivar SessionSelectView.arrSearchResultOfGroup
1057f2750: f8796ac0    	ldr	x0, [x22, x25]
1057f2754: f8396adf    	str	xzr, [x22, x25]
1057f2758: 9490d27f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f275c: b00d4c08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057f2760: f9455514    	ldr	x20, [x8, #0xaa8]
1057f2764: b00d51e8    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057f2768: b983c108    	ldrsw	x8, [x8, #0x3c0] ; ivar SessionSelectView._ftsTopHitMgr
1057f276c: f8686ac0    	ldr	x0, [x22, x8]
1057f2770: 900d34c8    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1057f2774: f9427101    	ldr	x1, [x8, #0x4e0] ; getTopHitItems:
1057f2778: 52800062    	mov	w2, #0x3                ; =3
1057f277c: 9490d270    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2780: aa1d03fd    	mov	x29, x29
1057f2784: 9490d271    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f2788: aa0003f5    	mov	x21, x0
1057f278c: b00d4868    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1057f2790: f941b101    	ldr	x1, [x8, #0x360] ; arrayWithArray:
1057f2794: aa1403e0    	mov	x0, x20
1057f2798: aa1503e2    	mov	x2, x21
1057f279c: 9490d268    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f27a0: aa1d03fd    	mov	x29, x29
1057f27a4: 9490d269    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f27a8: b00d51e8    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057f27ac: b9843d09    	ldrsw	x9, [x8, #0x43c] ; ivar SessionSelectView.arrSearchResultOfTopHit
1057f27b0: f8696ac8    	ldr	x8, [x22, x9]
1057f27b4: f90023e9    	str	x9, [sp, #0x40]
1057f27b8: f8296ac0    	str	x0, [x22, x9]
1057f27bc: aa0803e0    	mov	x0, x8
1057f27c0: 9490d265    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f27c4: aa1503e0    	mov	x0, x21
1057f27c8: 9490d263    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f27cc: b00d51e8    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057f27d0: b983ed08    	ldrsw	x8, [x8, #0x3ec] ; ivar SessionSelectView._chatRoomOnly
1057f27d4: f90037e8    	str	x8, [sp, #0x68]
1057f27d8: 38686ac8    	ldrb	w8, [x22, x8]
1057f27dc: b00d4c17    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
1057f27e0: f00d323a    	adrp	x26, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1057f27e4: b00d3253    	adrp	x19, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057f27e8: f9003ff6    	str	x22, [sp, #0x78]
1057f27ec: 370005a8    	tbnz	w8, #0x0, 0x1057f28a0 <_Flutter_MMFoundation_BindContext+0x1cce484>
1057f27f0: b00d4c08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057f27f4: f945e900    	ldr	x0, [x8, #0xbd0]
1057f27f8: d00d4868    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1057f27fc: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1057f2800: 9490d24f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2804: aa1d03fd    	mov	x29, x29
1057f2808: 9490d250    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f280c: aa0003f4    	mov	x20, x0
1057f2810: f94772e0    	ldr	x0, [x23, #0xee0]
1057f2814: b00d4868    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1057f2818: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1057f281c: 9490d248    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2820: aa0003e2    	mov	x2, x0
1057f2824: f9464341    	ldr	x1, [x26, #0xc80] ; getService:
1057f2828: aa1403e0    	mov	x0, x20
1057f282c: 9490d244    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2830: aa1d03fd    	mov	x29, x29
1057f2834: 9490d245    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f2838: aa0003f5    	mov	x21, x0
1057f283c: f9430e61    	ldr	x1, [x19, #0x618] ; ftsContactMgr
1057f2840: 9490d23f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2844: aa1d03fd    	mov	x29, x29
1057f2848: 9490d240    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f284c: aa0003f6    	mov	x22, x0
1057f2850: f9403fe8    	ldr	x8, [sp, #0x78]
1057f2854: f8786902    	ldr	x2, [x8, x24]
1057f2858: 900d34c8    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1057f285c: f9429901    	ldr	x1, [x8, #0x530] ; getSingleContactsWithTaskKey:
1057f2860: 9490d237    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2864: aa1d03fd    	mov	x29, x29
1057f2868: 9490d238    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f286c: f9403fe8    	ldr	x8, [sp, #0x78]
1057f2870: f87b6908    	ldr	x8, [x8, x27]
1057f2874: f9403fe9    	ldr	x9, [sp, #0x78]
1057f2878: f83b6920    	str	x0, [x9, x27]
1057f287c: aa0803e0    	mov	x0, x8
1057f2880: 9490d235    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f2884: aa1603e0    	mov	x0, x22
1057f2888: 9490d233    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f288c: aa1503e0    	mov	x0, x21
1057f2890: 9490d231    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f2894: aa1403e0    	mov	x0, x20
1057f2898: 9490d22f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f289c: f9403ff6    	ldr	x22, [sp, #0x78]
1057f28a0: f00d3de8    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057f28a4: f942ad01    	ldr	x1, [x8, #0x558] ; m_alignsFilterRulesInSearchResult
1057f28a8: aa1603e0    	mov	x0, x22
1057f28ac: f9003be1    	str	x1, [sp, #0x70]
1057f28b0: 9490d223    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f28b4: 34000120    	cbz	w0, 0x1057f28d8 <_Flutter_MMFoundation_BindContext+0x1cce4bc>
1057f28b8: b00d51e8    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057f28bc: b983e908    	ldrsw	x8, [x8, #0x3e8] ; ivar SessionSelectView.m_bIgnoreChatRoom
1057f28c0: 38686ac8    	ldrb	w8, [x22, x8]
1057f28c4: 7100051f    	cmp	w8, #0x1
1057f28c8: 54000081    	b.ne	0x1057f28d8 <_Flutter_MMFoundation_BindContext+0x1cce4bc>
1057f28cc: f8796ad4    	ldr	x20, [x22, x25]
1057f28d0: f8396adf    	str	xzr, [x22, x25]
1057f28d4: 14000027    	b	0x1057f2970 <_Flutter_MMFoundation_BindContext+0x1cce554>
1057f28d8: b00d4c08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057f28dc: f945e900    	ldr	x0, [x8, #0xbd0]
1057f28e0: d00d4868    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1057f28e4: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1057f28e8: 9490d215    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f28ec: aa1d03fd    	mov	x29, x29
1057f28f0: 9490d216    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f28f4: aa0003f4    	mov	x20, x0
1057f28f8: f94772e0    	ldr	x0, [x23, #0xee0]
1057f28fc: b00d4868    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1057f2900: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1057f2904: 9490d20e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2908: aa0003e2    	mov	x2, x0
1057f290c: f9464341    	ldr	x1, [x26, #0xc80] ; getService:
1057f2910: aa1403e0    	mov	x0, x20
1057f2914: 9490d20a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2918: aa1d03fd    	mov	x29, x29
1057f291c: 9490d20b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f2920: aa0003f5    	mov	x21, x0
1057f2924: f9430e61    	ldr	x1, [x19, #0x618] ; ftsContactMgr
1057f2928: 9490d205    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f292c: aa1d03fd    	mov	x29, x29
1057f2930: 9490d206    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f2934: aa0003f7    	mov	x23, x0
1057f2938: f8786ac2    	ldr	x2, [x22, x24]
1057f293c: 900d34c8    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1057f2940: f9429d01    	ldr	x1, [x8, #0x538] ; getGroupContactsWithTaskKey:
1057f2944: 9490d1fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2948: aa1d03fd    	mov	x29, x29
1057f294c: 9490d1ff    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f2950: f8796ac8    	ldr	x8, [x22, x25]
1057f2954: f8396ac0    	str	x0, [x22, x25]
1057f2958: aa0803e0    	mov	x0, x8
1057f295c: 9490d1fe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f2960: aa1703e0    	mov	x0, x23
1057f2964: 9490d1fc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f2968: aa1503e0    	mov	x0, x21
1057f296c: 9490d1fa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f2970: aa1403e0    	mov	x0, x20
1057f2974: 9490d1f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f2978: f87b6ac2    	ldr	x2, [x22, x27]
1057f297c: 900d34c8    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1057f2980: f9427501    	ldr	x1, [x8, #0x4e8] ; FilterSearchResultOfNormalContacts:
1057f2984: aa1603e0    	mov	x0, x22
1057f2988: 9490d1ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f298c: b00d51e8    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057f2990: b9842d18    	ldrsw	x24, [x8, #0x42c] ; ivar SessionSelectView.arrSectionKey
1057f2994: f8786ac8    	ldr	x8, [x22, x24]
1057f2998: b00d487a    	adrp	x26, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1057f299c: b50001c8    	cbnz	x8, 0x1057f29d4 <_Flutter_MMFoundation_BindContext+0x1cce5b8>
1057f29a0: b00d4c08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057f29a4: f9455500    	ldr	x0, [x8, #0xaa8]
1057f29a8: f941a341    	ldr	x1, [x26, #0x340] ; array
1057f29ac: 9490d1e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f29b0: aa1d03fd    	mov	x29, x29
1057f29b4: 9490d1e5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f29b8: f9403fe8    	ldr	x8, [sp, #0x78]
1057f29bc: f8786908    	ldr	x8, [x8, x24]
1057f29c0: f9403fe9    	ldr	x9, [sp, #0x78]
1057f29c4: f8386920    	str	x0, [x9, x24]
1057f29c8: aa0803e0    	mov	x0, x8
1057f29cc: 9490d1e2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f29d0: f9403ff6    	ldr	x22, [sp, #0x78]
1057f29d4: b00d51e8    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057f29d8: b984311c    	ldrsw	x28, [x8, #0x430] ; ivar SessionSelectView.dicSearchResult
1057f29dc: f87c6ac8    	ldr	x8, [x22, x28]
1057f29e0: b50001e8    	cbnz	x8, 0x1057f2a1c <_Flutter_MMFoundation_BindContext+0x1cce600>
1057f29e4: b00d4c08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057f29e8: f9454100    	ldr	x0, [x8, #0xa80]
1057f29ec: f00d4868    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
1057f29f0: f9400501    	ldr	x1, [x8, #0x8] ; dictionary
1057f29f4: 9490d1d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f29f8: aa1d03fd    	mov	x29, x29
1057f29fc: 9490d1d3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f2a00: f9403fe8    	ldr	x8, [sp, #0x78]
1057f2a04: f87c6908    	ldr	x8, [x8, x28]
1057f2a08: f9403fe9    	ldr	x9, [sp, #0x78]
1057f2a0c: f83c6920    	str	x0, [x9, x28]
1057f2a10: aa0803e0    	mov	x0, x8
1057f2a14: 9490d1d0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f2a18: f9403ff6    	ldr	x22, [sp, #0x78]
1057f2a1c: f8786ac0    	ldr	x0, [x22, x24]
1057f2a20: 900d48a8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1057f2a24: f9408114    	ldr	x20, [x8, #0x100] ; removeAllObjects
1057f2a28: aa1603f3    	mov	x19, x22
1057f2a2c: aa1403e1    	mov	x1, x20
1057f2a30: 9490d1c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2a34: f87c6ac0    	ldr	x0, [x22, x28]
1057f2a38: aa1403e1    	mov	x1, x20
1057f2a3c: 9490d1c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2a40: b00d51e8    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057f2a44: b9840508    	ldrsw	x8, [x8, #0x404] ; ivar SessionSelectView._expandBitSet
1057f2a48: b8286adf    	str	wzr, [x22, x8]
1057f2a4c: b00d51e8    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057f2a50: b983b908    	ldrsw	x8, [x8, #0x3b8] ; ivar SessionSelectView._searcher
1057f2a54: f9000be8    	str	x8, [sp, #0x10]
1057f2a58: f8686ac0    	ldr	x0, [x22, x8]
1057f2a5c: b00d3248    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057f2a60: f9459901    	ldr	x1, [x8, #0xb30] ; resultTableView
1057f2a64: f90007e1    	str	x1, [sp, #0x8]
1057f2a68: 9490d1b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2a6c: aa1d03fd    	mov	x29, x29
1057f2a70: 9490d1b6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f2a74: aa0003f4    	mov	x20, x0
1057f2a78: b00d3248    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057f2a7c: f945b901    	ldr	x1, [x8, #0xb70] ; contentInset
1057f2a80: 9490d1af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2a84: 1e614001    	fneg	d1, d0
1057f2a88: b00d3248    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057f2a8c: f945b501    	ldr	x1, [x8, #0xb68] ; setContentOffset:animated:
1057f2a90: 9e6703e0    	fmov	d0, xzr
1057f2a94: f90017f4    	str	x20, [sp, #0x28]
1057f2a98: aa1403e0    	mov	x0, x20
1057f2a9c: 52800002    	mov	w2, #0x0                ; =0
1057f2aa0: 9490d1a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2aa4: f94023f5    	ldr	x21, [sp, #0x40]
1057f2aa8: f8756ac0    	ldr	x0, [x22, x21]
1057f2aac: d00d4868    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1057f2ab0: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1057f2ab4: f9002fe1    	str	x1, [sp, #0x58]
1057f2ab8: 9490d1a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2abc: f00d48b7    	adrp	x23, 0x120109000 <dyld_stub_binder+0x120109000>
1057f2ac0: a904eff8    	stp	x24, x27, [sp, #0x48]
1057f2ac4: a90367fc    	stp	x28, x25, [sp, #0x30]
1057f2ac8: b40010a0    	cbz	x0, 0x1057f2cdc <_Flutter_MMFoundation_BindContext+0x1cce8c0>
1057f2acc: b00d4c08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057f2ad0: f9455500    	ldr	x0, [x8, #0xaa8]
1057f2ad4: f941a341    	ldr	x1, [x26, #0x340] ; array
1057f2ad8: 9490d199    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2adc: aa1d03fd    	mov	x29, x29
1057f2ae0: 9490d19a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f2ae4: aa0003f4    	mov	x20, x0
1057f2ae8: 4f00e400    	movi.16b	v0, #0x0
1057f2aec: ad0503e0    	stp	q0, q0, [sp, #0xa0]
1057f2af0: ad0603e0    	stp	q0, q0, [sp, #0xc0]
1057f2af4: f8756a77    	ldr	x23, [x19, x21]
1057f2af8: aa1703e0    	mov	x0, x23
1057f2afc: 9490d18f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057f2b00: d00d4868    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1057f2b04: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1057f2b08: 910283e2    	add	x2, sp, #0xa0
1057f2b0c: 910383e3    	add	x3, sp, #0xe0
1057f2b10: f90033e1    	str	x1, [sp, #0x60]
1057f2b14: 52800204    	mov	w4, #0x10               ; =16
1057f2b18: 9490d189    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2b1c: b40009e0    	cbz	x0, 0x1057f2c58 <_Flutter_MMFoundation_BindContext+0x1cce83c>
1057f2b20: aa0003fa    	mov	x26, x0
1057f2b24: f9405be8    	ldr	x8, [sp, #0xb0]
1057f2b28: f9400113    	ldr	x19, [x8]
1057f2b2c: d2800016    	mov	x22, #0x0               ; =0
1057f2b30: 900d3328    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
1057f2b34: f942c51b    	ldr	x27, [x8, #0x588] ; isAccountDeleted
1057f2b38: 900d3248    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1057f2b3c: f943c51c    	ldr	x28, [x8, #0x788] ; safeAddObject:
1057f2b40: b00d32c8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
1057f2b44: f946e918    	ldr	x24, [x8, #0xdd0] ; isWeClawBot
1057f2b48: b00d3248    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057f2b4c: f947d115    	ldr	x21, [x8, #0xfa0] ; isChatroom
1057f2b50: f9405be8    	ldr	x8, [sp, #0xb0]
1057f2b54: f9400108    	ldr	x8, [x8]
1057f2b58: eb13011f    	cmp	x8, x19
1057f2b5c: 54000060    	b.eq	0x1057f2b68 <_Flutter_MMFoundation_BindContext+0x1cce74c>
1057f2b60: aa1703e0    	mov	x0, x23
1057f2b64: 9490d17b    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1057f2b68: f94057e8    	ldr	x8, [sp, #0xa8]
1057f2b6c: f8767919    	ldr	x25, [x8, x22, lsl #3]
1057f2b70: aa1903e0    	mov	x0, x25
1057f2b74: aa1b03e1    	mov	x1, x27
1057f2b78: 9490d171    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2b7c: 340000a0    	cbz	w0, 0x1057f2b90 <_Flutter_MMFoundation_BindContext+0x1cce774>
1057f2b80: aa1403e0    	mov	x0, x20
1057f2b84: aa1c03e1    	mov	x1, x28
1057f2b88: aa1903e2    	mov	x2, x25
1057f2b8c: 9490d16c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2b90: aa1903e0    	mov	x0, x25
1057f2b94: aa1803e1    	mov	x1, x24
1057f2b98: 9490d169    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2b9c: 340000a0    	cbz	w0, 0x1057f2bb0 <_Flutter_MMFoundation_BindContext+0x1cce794>
1057f2ba0: aa1403e0    	mov	x0, x20
1057f2ba4: aa1c03e1    	mov	x1, x28
1057f2ba8: aa1903e2    	mov	x2, x25
1057f2bac: 9490d164    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2bb0: a94703e1    	ldp	x1, x0, [sp, #0x70]
1057f2bb4: 9490d162    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2bb8: 340003a0    	cbz	w0, 0x1057f2c2c <_Flutter_MMFoundation_BindContext+0x1cce810>
1057f2bbc: b00d51e8    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057f2bc0: b983e908    	ldrsw	x8, [x8, #0x3e8] ; ivar SessionSelectView.m_bIgnoreChatRoom
1057f2bc4: f9403fe9    	ldr	x9, [sp, #0x78]
1057f2bc8: 38686928    	ldrb	w8, [x9, x8]
1057f2bcc: 7100051f    	cmp	w8, #0x1
1057f2bd0: 54000161    	b.ne	0x1057f2bfc <_Flutter_MMFoundation_BindContext+0x1cce7e0>
1057f2bd4: aa1903e0    	mov	x0, x25
1057f2bd8: aa1503e1    	mov	x1, x21
1057f2bdc: 9490d158    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2be0: f9403fe9    	ldr	x9, [sp, #0x78]
1057f2be4: 340000c0    	cbz	w0, 0x1057f2bfc <_Flutter_MMFoundation_BindContext+0x1cce7e0>
1057f2be8: aa1403e0    	mov	x0, x20
1057f2bec: aa1c03e1    	mov	x1, x28
1057f2bf0: aa1903e2    	mov	x2, x25
1057f2bf4: 9490d152    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2bf8: f9403fe9    	ldr	x9, [sp, #0x78]
1057f2bfc: f94037e8    	ldr	x8, [sp, #0x68]
1057f2c00: 38686928    	ldrb	w8, [x9, x8]
1057f2c04: 7100051f    	cmp	w8, #0x1
1057f2c08: 54000121    	b.ne	0x1057f2c2c <_Flutter_MMFoundation_BindContext+0x1cce810>
1057f2c0c: aa1903e0    	mov	x0, x25
1057f2c10: aa1503e1    	mov	x1, x21
1057f2c14: 9490d14a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2c18: 370000a0    	tbnz	w0, #0x0, 0x1057f2c2c <_Flutter_MMFoundation_BindContext+0x1cce810>
1057f2c1c: aa1403e0    	mov	x0, x20
1057f2c20: aa1c03e1    	mov	x1, x28
1057f2c24: aa1903e2    	mov	x2, x25
1057f2c28: 9490d145    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2c2c: 910006d6    	add	x22, x22, #0x1
1057f2c30: eb16035f    	cmp	x26, x22
1057f2c34: 54fff8e1    	b.ne	0x1057f2b50 <_Flutter_MMFoundation_BindContext+0x1cce734>
1057f2c38: 910283e2    	add	x2, sp, #0xa0
1057f2c3c: 910383e3    	add	x3, sp, #0xe0
1057f2c40: aa1703e0    	mov	x0, x23
1057f2c44: f94033e1    	ldr	x1, [sp, #0x60]
1057f2c48: 52800204    	mov	w4, #0x10               ; =16
1057f2c4c: 9490d13c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2c50: aa0003fa    	mov	x26, x0
1057f2c54: b5fff6c0    	cbnz	x0, 0x1057f2b2c <_Flutter_MMFoundation_BindContext+0x1cce710>
1057f2c58: aa1703e0    	mov	x0, x23
1057f2c5c: 9490d13e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f2c60: f9403ff3    	ldr	x19, [sp, #0x78]
1057f2c64: f94023f6    	ldr	x22, [sp, #0x40]
1057f2c68: f8766a60    	ldr	x0, [x19, x22]
1057f2c6c: 900d48a8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1057f2c70: f9415101    	ldr	x1, [x8, #0x2a0] ; removeObjectsInArray:
1057f2c74: aa1403e2    	mov	x2, x20
1057f2c78: 9490d131    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2c7c: f8766a60    	ldr	x0, [x19, x22]
1057f2c80: f9402fe1    	ldr	x1, [sp, #0x58]
1057f2c84: 9490d12e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2c88: f9401bfc    	ldr	x28, [sp, #0x30]
1057f2c8c: f00d48b7    	adrp	x23, 0x120109000 <dyld_stub_binder+0x120109000>
1057f2c90: f94027f8    	ldr	x24, [sp, #0x48]
1057f2c94: b40001a0    	cbz	x0, 0x1057f2cc8 <_Flutter_MMFoundation_BindContext+0x1cce8ac>
1057f2c98: f8786a60    	ldr	x0, [x19, x24]
1057f2c9c: 900d3248    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1057f2ca0: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1057f2ca4: b00c6ad5    	adrp	x21, 0x11e54b000 <dyld_stub_binder+0x11e54b000>
1057f2ca8: 912822b5    	add	x21, x21, #0xa08
1057f2cac: aa1503e2    	mov	x2, x21
1057f2cb0: 9490d123    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2cb4: f8766a62    	ldr	x2, [x19, x22]
1057f2cb8: f87c6a60    	ldr	x0, [x19, x28]
1057f2cbc: f94012e1    	ldr	x1, [x23, #0x20] ; setObject:forKeyedSubscript:
1057f2cc0: aa1503e3    	mov	x3, x21
1057f2cc4: 9490d11e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2cc8: aa1403e0    	mov	x0, x20
1057f2ccc: 9490d122    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f2cd0: f9401ff9    	ldr	x25, [sp, #0x38]
1057f2cd4: f9402bfb    	ldr	x27, [sp, #0x50]
1057f2cd8: b00d487a    	adrp	x26, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1057f2cdc: f87b6a60    	ldr	x0, [x19, x27]
1057f2ce0: f9402fe1    	ldr	x1, [sp, #0x58]
1057f2ce4: 9490d116    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2ce8: b40001a0    	cbz	x0, 0x1057f2d1c <_Flutter_MMFoundation_BindContext+0x1cce900>
1057f2cec: f8786a60    	ldr	x0, [x19, x24]
1057f2cf0: 900d3248    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1057f2cf4: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1057f2cf8: d00c6574    	adrp	x20, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
1057f2cfc: 91072294    	add	x20, x20, #0x1c8
1057f2d00: aa1403e2    	mov	x2, x20
1057f2d04: 9490d10e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2d08: f87b6a62    	ldr	x2, [x19, x27]
1057f2d0c: f87c6a60    	ldr	x0, [x19, x28]
1057f2d10: f94012e1    	ldr	x1, [x23, #0x20] ; setObject:forKeyedSubscript:
1057f2d14: aa1403e3    	mov	x3, x20
1057f2d18: 9490d109    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2d1c: d00d35a8    	adrp	x8, 0x11fea8000 <dyld_stub_binder+0x11fea8000>
1057f2d20: f9474d01    	ldr	x1, [x8, #0xe98] ; shouldDisplayChatRoomEntry
1057f2d24: aa1303e0    	mov	x0, x19
1057f2d28: f9000fe1    	str	x1, [sp, #0x18]
1057f2d2c: 9490d104    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2d30: 340002c0    	cbz	w0, 0x1057f2d88 <_Flutter_MMFoundation_BindContext+0x1cce96c>
1057f2d34: f8786a60    	ldr	x0, [x19, x24]
1057f2d38: 900d3248    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1057f2d3c: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1057f2d40: b00c8115    	adrp	x21, 0x11e813000 <dyld_stub_binder+0x11e813000>
1057f2d44: 913c22b5    	add	x21, x21, #0xf08
1057f2d48: aa1503e2    	mov	x2, x21
1057f2d4c: 9490d0fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2d50: b00d4c08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057f2d54: f9455500    	ldr	x0, [x8, #0xaa8]
1057f2d58: f941a341    	ldr	x1, [x26, #0x340] ; array
1057f2d5c: 9490d0f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2d60: aa1d03fd    	mov	x29, x29
1057f2d64: 9490d0f9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f2d68: aa0003f6    	mov	x22, x0
1057f2d6c: f87c6a60    	ldr	x0, [x19, x28]
1057f2d70: f94012e1    	ldr	x1, [x23, #0x20] ; setObject:forKeyedSubscript:
1057f2d74: aa1603e2    	mov	x2, x22
1057f2d78: aa1503e3    	mov	x3, x21
1057f2d7c: 9490d0f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2d80: aa1603e0    	mov	x0, x22
1057f2d84: 9490d0f4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f2d88: f8796a60    	ldr	x0, [x19, x25]
1057f2d8c: f9402fe1    	ldr	x1, [sp, #0x58]
1057f2d90: 9490d0eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2d94: b40001a0    	cbz	x0, 0x1057f2dc8 <_Flutter_MMFoundation_BindContext+0x1cce9ac>
1057f2d98: f8786a60    	ldr	x0, [x19, x24]
1057f2d9c: 900d3248    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1057f2da0: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1057f2da4: d00c6695    	adrp	x21, 0x11e4c4000 <dyld_stub_binder+0x11e4c4000>
1057f2da8: 910922b5    	add	x21, x21, #0x248
1057f2dac: aa1503e2    	mov	x2, x21
1057f2db0: 9490d0e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2db4: f8796a62    	ldr	x2, [x19, x25]
1057f2db8: f87c6a60    	ldr	x0, [x19, x28]
1057f2dbc: f94012e1    	ldr	x1, [x23, #0x20] ; setObject:forKeyedSubscript:
1057f2dc0: aa1503e3    	mov	x3, x21
1057f2dc4: 9490d0de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2dc8: f87b6a77    	ldr	x23, [x19, x27]
1057f2dcc: f8796a79    	ldr	x25, [x19, x25]
1057f2dd0: f94027e8    	ldr	x8, [sp, #0x48]
1057f2dd4: f8686a78    	ldr	x24, [x19, x8]
1057f2dd8: f87c6a75    	ldr	x21, [x19, x28]
1057f2ddc: 900d34c8    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1057f2de0: f9421514    	ldr	x20, [x8, #0x428] ; messageSearchLogic
1057f2de4: f9003bf4    	str	x20, [sp, #0x70]
1057f2de8: aa1503e0    	mov	x0, x21
1057f2dec: 9490d0d3    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057f2df0: aa1803e0    	mov	x0, x24
1057f2df4: 9490d0d1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057f2df8: aa1903e0    	mov	x0, x25
1057f2dfc: 9490d0cf    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057f2e00: aa1703e0    	mov	x0, x23
1057f2e04: 9490d0cd    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057f2e08: aa1303e0    	mov	x0, x19
1057f2e0c: aa1403e1    	mov	x1, x20
1057f2e10: 9490d0cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2e14: aa1d03fd    	mov	x29, x29
1057f2e18: 9490d0cc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f2e1c: aa1c03f6    	mov	x22, x28
1057f2e20: aa0003fc    	mov	x28, x0
1057f2e24: a9095ff9    	stp	x25, x23, [sp, #0x90]
1057f2e28: f94023fb    	ldr	x27, [sp, #0x40]
1057f2e2c: f87b6a64    	ldr	x4, [x19, x27]
1057f2e30: a90863f5    	stp	x21, x24, [sp, #0x80]
1057f2e34: f00d3de8    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057f2e38: f943f501    	ldr	x1, [x8, #0x7e8] ; mergeResultsIntoContacts:groups:topHitItems:sectionKeys:sectionResults:
1057f2e3c: 910263e2    	add	x2, sp, #0x98
1057f2e40: 910243e3    	add	x3, sp, #0x90
1057f2e44: 910223e5    	add	x5, sp, #0x88
1057f2e48: 910203e6    	add	x6, sp, #0x80
1057f2e4c: 9490d0bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2e50: f9404ff4    	ldr	x20, [sp, #0x98]
1057f2e54: aa1403e0    	mov	x0, x20
1057f2e58: 9490d0b8    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057f2e5c: aa1703e0    	mov	x0, x23
1057f2e60: 9490d0bd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f2e64: f9404bf7    	ldr	x23, [sp, #0x90]
1057f2e68: aa1703e0    	mov	x0, x23
1057f2e6c: 9490d0b3    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057f2e70: aa1903e0    	mov	x0, x25
1057f2e74: 9490d0b8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f2e78: f94047f9    	ldr	x25, [sp, #0x88]
1057f2e7c: aa1903e0    	mov	x0, x25
1057f2e80: 9490d0ae    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057f2e84: aa1803e0    	mov	x0, x24
1057f2e88: f94027f8    	ldr	x24, [sp, #0x48]
1057f2e8c: 9490d0b2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f2e90: f94043fa    	ldr	x26, [sp, #0x80]
1057f2e94: aa1a03e0    	mov	x0, x26
1057f2e98: 9490d0a8    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057f2e9c: aa1503e0    	mov	x0, x21
1057f2ea0: 9490d0ad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f2ea4: aa1c03e0    	mov	x0, x28
1057f2ea8: 9490d0ab    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f2eac: f9402be8    	ldr	x8, [sp, #0x50]
1057f2eb0: 8b080260    	add	x0, x19, x8
1057f2eb4: f90037f4    	str	x20, [sp, #0x68]
1057f2eb8: aa1403e1    	mov	x1, x20
1057f2ebc: f9401ff4    	ldr	x20, [sp, #0x38]
1057f2ec0: 9490d0a0    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
1057f2ec4: 8b140260    	add	x0, x19, x20
1057f2ec8: aa1703e1    	mov	x1, x23
1057f2ecc: 9490d09d    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
1057f2ed0: 8b180260    	add	x0, x19, x24
1057f2ed4: f90033f9    	str	x25, [sp, #0x60]
1057f2ed8: aa1903e1    	mov	x1, x25
1057f2edc: aa1a03f5    	mov	x21, x26
1057f2ee0: aa1b03fa    	mov	x26, x27
1057f2ee4: 9490d097    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
1057f2ee8: 8b160260    	add	x0, x19, x22
1057f2eec: f9403bf6    	ldr	x22, [sp, #0x70]
1057f2ef0: f90013f5    	str	x21, [sp, #0x20]
1057f2ef4: aa1503e1    	mov	x1, x21
1057f2ef8: 9490d092    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
1057f2efc: aa1303e0    	mov	x0, x19
1057f2f00: aa1603e1    	mov	x1, x22
1057f2f04: 9490d08e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2f08: aa1d03fd    	mov	x29, x29
1057f2f0c: 9490d08f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f2f10: b40003c0    	cbz	x0, 0x1057f2f88 <_Flutter_MMFoundation_BindContext+0x1cceb6c>
1057f2f14: aa0003f5    	mov	x21, x0
1057f2f18: aa1303e0    	mov	x0, x19
1057f2f1c: aa1603e1    	mov	x1, x22
1057f2f20: 9490d087    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2f24: aa1d03fd    	mov	x29, x29
1057f2f28: 9490d088    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f2f2c: aa0003f8    	mov	x24, x0
1057f2f30: f9402be8    	ldr	x8, [sp, #0x50]
1057f2f34: f8686a7b    	ldr	x27, [x19, x8]
1057f2f38: f8746a7c    	ldr	x28, [x19, x20]
1057f2f3c: f87a6a76    	ldr	x22, [x19, x26]
1057f2f40: aa1303e0    	mov	x0, x19
1057f2f44: f9400fe1    	ldr	x1, [sp, #0x18]
1057f2f48: 9490d07d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2f4c: aa0003e5    	mov	x5, x0
1057f2f50: f00d3de8    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057f2f54: f945a101    	ldr	x1, [x8, #0xb40] ; shouldNotifyContactSearchResultWithContacts:groups:topHitItems:hasAdditionalVisibleResult:
1057f2f58: aa1803e0    	mov	x0, x24
1057f2f5c: aa1b03e2    	mov	x2, x27
1057f2f60: aa1c03e3    	mov	x3, x28
1057f2f64: aa1603e4    	mov	x4, x22
1057f2f68: 9490d075    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2f6c: aa0003f6    	mov	x22, x0
1057f2f70: aa1803e0    	mov	x0, x24
1057f2f74: f94027f8    	ldr	x24, [sp, #0x48]
1057f2f78: 9490d077    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f2f7c: aa1503e0    	mov	x0, x21
1057f2f80: 9490d075    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f2f84: 34002c96    	cbz	w22, 0x1057f3514 <_Flutter_MMFoundation_BindContext+0x1ccf0f8>
1057f2f88: f90027f7    	str	x23, [sp, #0x48]
1057f2f8c: b00d4c08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057f2f90: f9455500    	ldr	x0, [x8, #0xaa8]
1057f2f94: b00d4868    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1057f2f98: f941a11c    	ldr	x28, [x8, #0x340] ; array
1057f2f9c: aa1c03e1    	mov	x1, x28
1057f2fa0: 9490d067    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2fa4: aa1d03fd    	mov	x29, x29
1057f2fa8: 9490d068    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f2fac: aa0003fb    	mov	x27, x0
1057f2fb0: f9402be8    	ldr	x8, [sp, #0x50]
1057f2fb4: f8686a62    	ldr	x2, [x19, x8]
1057f2fb8: 900d4868    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1057f2fbc: f946f915    	ldr	x21, [x8, #0xdf0] ; addObjectsFromArray:
1057f2fc0: aa1503e1    	mov	x1, x21
1057f2fc4: 9490d05e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2fc8: f8746a62    	ldr	x2, [x19, x20]
1057f2fcc: aa1b03e0    	mov	x0, x27
1057f2fd0: aa1503e1    	mov	x1, x21
1057f2fd4: 9490d05a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2fd8: f87a6a62    	ldr	x2, [x19, x26]
1057f2fdc: aa1b03e0    	mov	x0, x27
1057f2fe0: aa1503e1    	mov	x1, x21
1057f2fe4: 9490d056    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2fe8: f8786a60    	ldr	x0, [x19, x24]
1057f2fec: f9402fe1    	ldr	x1, [sp, #0x58]
1057f2ff0: 9490d053    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f2ff4: aa1a03f6    	mov	x22, x26
1057f2ff8: b5000220    	cbnz	x0, 0x1057f303c <_Flutter_MMFoundation_BindContext+0x1ccec20>
1057f2ffc: f8786a60    	ldr	x0, [x19, x24]
1057f3000: f00d3228    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1057f3004: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1057f3008: 900c6ab5    	adrp	x21, 0x11e547000 <dyld_stub_binder+0x11e547000>
1057f300c: 911ea2b5    	add	x21, x21, #0x7a8
1057f3010: aa1503e2    	mov	x2, x21
1057f3014: 9490d04a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3018: d00befe8    	adrp	x8, 0x11d5f1000 <dyld_stub_binder+0x11d5f1000>
1057f301c: f940e108    	ldr	x8, [x8, #0x1c0]
1057f3020: f9400102    	ldr	x2, [x8]
1057f3024: f9401be8    	ldr	x8, [sp, #0x30]
1057f3028: f8686a60    	ldr	x0, [x19, x8]
1057f302c: d00d48a8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1057f3030: f9401101    	ldr	x1, [x8, #0x20] ; setObject:forKeyedSubscript:
1057f3034: aa1503e3    	mov	x3, x21
1057f3038: 9490d041    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f303c: 900d51e8    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057f3040: b983c508    	ldrsw	x8, [x8, #0x3c4] ; ivar SessionSelectView.m_bMultiSelect
1057f3044: 38686a68    	ldrb	w8, [x19, x8]
1057f3048: d00d323a    	adrp	x26, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1057f304c: 370000c8    	tbnz	w8, #0x0, 0x1057f3064 <_Flutter_MMFoundation_BindContext+0x1ccec48>
1057f3050: b00d34a8    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
1057f3054: f9430d01    	ldr	x1, [x8, #0x618] ; useNewSearchBar
1057f3058: aa1303e0    	mov	x0, x19
1057f305c: 9490d038    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3060: 36002320    	tbz	w0, #0x0, 0x1057f34c4 <_Flutter_MMFoundation_BindContext+0x1ccf0a8>
1057f3064: 900d4c08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057f3068: f9455500    	ldr	x0, [x8, #0xaa8]
1057f306c: aa1c03e1    	mov	x1, x28
1057f3070: 9490d033    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3074: aa1d03fd    	mov	x29, x29
1057f3078: 9490d034    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f307c: aa0003f8    	mov	x24, x0
1057f3080: 900d4c08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057f3084: f9454100    	ldr	x0, [x8, #0xa80]
1057f3088: d00d4868    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
1057f308c: f9400501    	ldr	x1, [x8, #0x8] ; dictionary
1057f3090: 9490d02b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3094: aa1d03fd    	mov	x29, x29
1057f3098: 9490d02c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f309c: f9003be0    	str	x0, [sp, #0x70]
1057f30a0: d00d3de8    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057f30a4: f945a501    	ldr	x1, [x8, #0xb48] ; m_isSupportMultipleWordsSearchCreateGroup
1057f30a8: aa1303e0    	mov	x0, x19
1057f30ac: 9490d024    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f30b0: 340005a0    	cbz	w0, 0x1057f3164 <_Flutter_MMFoundation_BindContext+0x1cced48>
1057f30b4: aa1303e0    	mov	x0, x19
1057f30b8: f9400fe1    	ldr	x1, [sp, #0x18]
1057f30bc: 9490d020    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f30c0: 34000520    	cbz	w0, 0x1057f3164 <_Flutter_MMFoundation_BindContext+0x1cced48>
1057f30c4: f9401ff5    	ldr	x21, [sp, #0x38]
1057f30c8: f8756a60    	ldr	x0, [x19, x21]
1057f30cc: f9402fe1    	ldr	x1, [sp, #0x58]
1057f30d0: 9490d01b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f30d4: b5000260    	cbnz	x0, 0x1057f3120 <_Flutter_MMFoundation_BindContext+0x1cced04>
1057f30d8: 900d4c08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057f30dc: f9455500    	ldr	x0, [x8, #0xaa8]
1057f30e0: aa1c03e1    	mov	x1, x28
1057f30e4: 9490d016    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f30e8: aa1d03fd    	mov	x29, x29
1057f30ec: 9490d017    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f30f0: f8756a68    	ldr	x8, [x19, x21]
1057f30f4: f8356a60    	str	x0, [x19, x21]
1057f30f8: aa0803e0    	mov	x0, x8
1057f30fc: 9490d016    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f3100: f8756a62    	ldr	x2, [x19, x21]
1057f3104: f9401be8    	ldr	x8, [sp, #0x30]
1057f3108: f8686a60    	ldr	x0, [x19, x8]
1057f310c: d00d48a8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1057f3110: f9401101    	ldr	x1, [x8, #0x20] ; setObject:forKeyedSubscript:
1057f3114: b00c6683    	adrp	x3, 0x11e4c4000 <dyld_stub_binder+0x11e4c4000>
1057f3118: 91092063    	add	x3, x3, #0x248
1057f311c: 9490d008    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3120: 900d4c08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057f3124: f9478100    	ldr	x0, [x8, #0xf00] ;  /,
1057f3128: 9490d00c    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1057f312c: aa0003f4    	mov	x20, x0
1057f3130: b00d3248    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1057f3134: f945fd01    	ldr	x1, [x8, #0xbf8] ; setM_nsUsrName:
1057f3138: 900c8102    	adrp	x2, 0x11e813000 <dyld_stub_binder+0x11e813000>
1057f313c: 913c2042    	add	x2, x2, #0xf08
1057f3140: 9490cfff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3144: f8756a60    	ldr	x0, [x19, x21]
1057f3148: 900d3248    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057f314c: f945b101    	ldr	x1, [x8, #0xb60] ; safeInsertObject:atIndex:
1057f3150: aa1403e2    	mov	x2, x20
1057f3154: d2800003    	mov	x3, #0x0                ; =0
1057f3158: 9490cff9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f315c: aa1403e0    	mov	x0, x20
1057f3160: 9490cffd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f3164: f8766a60    	ldr	x0, [x19, x22]
1057f3168: f9402fe1    	ldr	x1, [sp, #0x58]
1057f316c: 9490cff4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3170: 900d4c16    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
1057f3174: d00d323c    	adrp	x28, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1057f3178: b4000680    	cbz	x0, 0x1057f3248 <_Flutter_MMFoundation_BindContext+0x1ccee2c>
1057f317c: f00d3228    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1057f3180: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1057f3184: 900c6ad4    	adrp	x20, 0x11e54b000 <dyld_stub_binder+0x11e54b000>
1057f3188: 91282294    	add	x20, x20, #0xa08
1057f318c: aa1803e0    	mov	x0, x24
1057f3190: aa1403e2    	mov	x2, x20
1057f3194: 9490cfea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3198: 900d4c08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057f319c: f945e900    	ldr	x0, [x8, #0xbd0]
1057f31a0: b00d4868    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1057f31a4: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1057f31a8: 9490cfe5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f31ac: aa1d03fd    	mov	x29, x29
1057f31b0: 9490cfe6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f31b4: aa0003f5    	mov	x21, x0
1057f31b8: f9462ac0    	ldr	x0, [x22, #0xc50]
1057f31bc: 900d4868    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1057f31c0: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1057f31c4: 9490cfde    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f31c8: aa0003e2    	mov	x2, x0
1057f31cc: f9464341    	ldr	x1, [x26, #0xc80] ; getService:
1057f31d0: aa1503e0    	mov	x0, x21
1057f31d4: 9490cfda    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f31d8: aa1d03fd    	mov	x29, x29
1057f31dc: 9490cfdb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f31e0: aa1a03f7    	mov	x23, x26
1057f31e4: aa1603fa    	mov	x26, x22
1057f31e8: aa0003f6    	mov	x22, x0
1057f31ec: f9464781    	ldr	x1, [x28, #0xc88] ; getStringForCurLanguage:
1057f31f0: 900c6ac2    	adrp	x2, 0x11e54b000 <dyld_stub_binder+0x11e54b000>
1057f31f4: 9128a042    	add	x2, x2, #0xa28
1057f31f8: 9490cfd1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f31fc: aa1d03fd    	mov	x29, x29
1057f3200: 9490cfd2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f3204: aa1c03f3    	mov	x19, x28
1057f3208: aa0003fc    	mov	x28, x0
1057f320c: d00d48a8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1057f3210: f9401101    	ldr	x1, [x8, #0x20] ; setObject:forKeyedSubscript:
1057f3214: f9403be0    	ldr	x0, [sp, #0x70]
1057f3218: aa1c03e2    	mov	x2, x28
1057f321c: aa1403e3    	mov	x3, x20
1057f3220: 9490cfc7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3224: aa1c03e0    	mov	x0, x28
1057f3228: aa1303fc    	mov	x28, x19
1057f322c: 9490cfca    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f3230: aa1603e0    	mov	x0, x22
1057f3234: aa1a03f6    	mov	x22, x26
1057f3238: aa1703fa    	mov	x26, x23
1057f323c: 9490cfc6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f3240: aa1503e0    	mov	x0, x21
1057f3244: 9490cfc4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f3248: f9403fe8    	ldr	x8, [sp, #0x78]
1057f324c: a94507e9    	ldp	x9, x1, [sp, #0x50]
1057f3250: f8696900    	ldr	x0, [x8, x9]
1057f3254: 9490cfba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3258: d00d48b9    	adrp	x25, 0x120109000 <dyld_stub_binder+0x120109000>
1057f325c: b4000660    	cbz	x0, 0x1057f3328 <_Flutter_MMFoundation_BindContext+0x1ccef0c>
1057f3260: f00d3228    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1057f3264: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1057f3268: b00c6574    	adrp	x20, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
1057f326c: 91072294    	add	x20, x20, #0x1c8
1057f3270: aa1803e0    	mov	x0, x24
1057f3274: aa1403e2    	mov	x2, x20
1057f3278: 9490cfb1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f327c: 900d4c08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057f3280: f945e900    	ldr	x0, [x8, #0xbd0]
1057f3284: b00d4868    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1057f3288: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1057f328c: 9490cfac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3290: aa1d03fd    	mov	x29, x29
1057f3294: 9490cfad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f3298: aa0003f5    	mov	x21, x0
1057f329c: f9462ac0    	ldr	x0, [x22, #0xc50]
1057f32a0: 900d4868    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1057f32a4: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1057f32a8: 9490cfa5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f32ac: aa0003e2    	mov	x2, x0
1057f32b0: f9464341    	ldr	x1, [x26, #0xc80] ; getService:
1057f32b4: aa1503e0    	mov	x0, x21
1057f32b8: 9490cfa1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f32bc: aa1d03fd    	mov	x29, x29
1057f32c0: 9490cfa2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f32c4: aa1a03f3    	mov	x19, x26
1057f32c8: aa1603fa    	mov	x26, x22
1057f32cc: aa0003f6    	mov	x22, x0
1057f32d0: f9464781    	ldr	x1, [x28, #0xc88] ; getStringForCurLanguage:
1057f32d4: 900c6ac2    	adrp	x2, 0x11e54b000 <dyld_stub_binder+0x11e54b000>
1057f32d8: 91292042    	add	x2, x2, #0xa48
1057f32dc: 9490cf98    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f32e0: aa1d03fd    	mov	x29, x29
1057f32e4: 9490cf99    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f32e8: aa1c03f7    	mov	x23, x28
1057f32ec: aa0003fc    	mov	x28, x0
1057f32f0: f9401321    	ldr	x1, [x25, #0x20] ; setObject:forKeyedSubscript:
1057f32f4: f9403be0    	ldr	x0, [sp, #0x70]
1057f32f8: aa1c03e2    	mov	x2, x28
1057f32fc: aa1403e3    	mov	x3, x20
1057f3300: 9490cf8f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3304: aa1c03e0    	mov	x0, x28
1057f3308: aa1703fc    	mov	x28, x23
1057f330c: 9490cf92    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f3310: aa1603e0    	mov	x0, x22
1057f3314: aa1a03f6    	mov	x22, x26
1057f3318: aa1303fa    	mov	x26, x19
1057f331c: 9490cf8e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f3320: aa1503e0    	mov	x0, x21
1057f3324: 9490cf8c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f3328: f9403fe8    	ldr	x8, [sp, #0x78]
1057f332c: f9401fe9    	ldr	x9, [sp, #0x38]
1057f3330: f8696900    	ldr	x0, [x8, x9]
1057f3334: f9402fe1    	ldr	x1, [sp, #0x58]
1057f3338: 9490cf81    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f333c: b40005a0    	cbz	x0, 0x1057f33f0 <_Flutter_MMFoundation_BindContext+0x1ccefd4>
1057f3340: f00d3228    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1057f3344: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1057f3348: b00c6694    	adrp	x20, 0x11e4c4000 <dyld_stub_binder+0x11e4c4000>
1057f334c: 91092294    	add	x20, x20, #0x248
1057f3350: aa1803e0    	mov	x0, x24
1057f3354: aa1403e2    	mov	x2, x20
1057f3358: 9490cf79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f335c: 900d4c08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057f3360: f945e900    	ldr	x0, [x8, #0xbd0]
1057f3364: b00d4868    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1057f3368: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1057f336c: 9490cf74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3370: aa1d03fd    	mov	x29, x29
1057f3374: 9490cf75    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f3378: aa0003f5    	mov	x21, x0
1057f337c: f9462ac0    	ldr	x0, [x22, #0xc50]
1057f3380: 900d4868    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1057f3384: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1057f3388: 9490cf6d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f338c: aa0003e2    	mov	x2, x0
1057f3390: f9464341    	ldr	x1, [x26, #0xc80] ; getService:
1057f3394: aa1503e0    	mov	x0, x21
1057f3398: 9490cf69    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f339c: aa1d03fd    	mov	x29, x29
1057f33a0: 9490cf6a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f33a4: aa0003f6    	mov	x22, x0
1057f33a8: f9464781    	ldr	x1, [x28, #0xc88] ; getStringForCurLanguage:
1057f33ac: 900c6ac2    	adrp	x2, 0x11e54b000 <dyld_stub_binder+0x11e54b000>
1057f33b0: 9129a042    	add	x2, x2, #0xa68
1057f33b4: 9490cf62    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f33b8: aa1d03fd    	mov	x29, x29
1057f33bc: 9490cf63    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f33c0: aa0003fc    	mov	x28, x0
1057f33c4: f9401321    	ldr	x1, [x25, #0x20] ; setObject:forKeyedSubscript:
1057f33c8: f9403be0    	ldr	x0, [sp, #0x70]
1057f33cc: aa1c03e2    	mov	x2, x28
1057f33d0: aa1403e3    	mov	x3, x20
1057f33d4: 9490cf5a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f33d8: aa1c03e0    	mov	x0, x28
1057f33dc: 9490cf5e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f33e0: aa1603e0    	mov	x0, x22
1057f33e4: 9490cf5c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f33e8: aa1503e0    	mov	x0, x21
1057f33ec: 9490cf5a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f33f0: aa1803e0    	mov	x0, x24
1057f33f4: f9402fe1    	ldr	x1, [sp, #0x58]
1057f33f8: 9490cf51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f33fc: b50001c0    	cbnz	x0, 0x1057f3434 <_Flutter_MMFoundation_BindContext+0x1ccf018>
1057f3400: f00d3228    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1057f3404: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1057f3408: 900c6aa2    	adrp	x2, 0x11e547000 <dyld_stub_binder+0x11e547000>
1057f340c: 911ea042    	add	x2, x2, #0x7a8
1057f3410: aa1803e0    	mov	x0, x24
1057f3414: 9490cf4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3418: f9401321    	ldr	x1, [x25, #0x20] ; setObject:forKeyedSubscript:
1057f341c: 900c6542    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1057f3420: 91032042    	add	x2, x2, #0xc8
1057f3424: b00c6683    	adrp	x3, 0x11e4c4000 <dyld_stub_binder+0x11e4c4000>
1057f3428: 91092063    	add	x3, x3, #0x248
1057f342c: f9403be0    	ldr	x0, [sp, #0x70]
1057f3430: 9490cf43    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3434: 900d51e8    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057f3438: b983e113    	ldrsw	x19, [x8, #0x3e0] ; ivar SessionSelectView.m_delegate
1057f343c: f9403ff7    	ldr	x23, [sp, #0x78]
1057f3440: 8b1302e0    	add	x0, x23, x19
1057f3444: 9490cf52    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1057f3448: b4000380    	cbz	x0, 0x1057f34b8 <_Flutter_MMFoundation_BindContext+0x1ccf09c>
1057f344c: aa0003f5    	mov	x21, x0
1057f3450: 8b1302e0    	add	x0, x23, x19
1057f3454: 9490cf4e    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1057f3458: aa0003f6    	mov	x22, x0
1057f345c: d00d3de8    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057f3460: f945a914    	ldr	x20, [x8, #0xb50] ; onSessionSelectSearchSessions:sectionTitles:sectionResults:
1057f3464: f00d4888    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1057f3468: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
1057f346c: aa1403e2    	mov	x2, x20
1057f3470: 9490cf33    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3474: aa0003fc    	mov	x28, x0
1057f3478: aa1603e0    	mov	x0, x22
1057f347c: 9490cf36    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f3480: aa1503e0    	mov	x0, x21
1057f3484: 9490cf34    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f3488: 3400019c    	cbz	w28, 0x1057f34b8 <_Flutter_MMFoundation_BindContext+0x1ccf09c>
1057f348c: 8b1302e0    	add	x0, x23, x19
1057f3490: 9490cf3f    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1057f3494: aa0003f5    	mov	x21, x0
1057f3498: f9401be8    	ldr	x8, [sp, #0x30]
1057f349c: f8686ae4    	ldr	x4, [x23, x8]
1057f34a0: aa1403e1    	mov	x1, x20
1057f34a4: aa1803e2    	mov	x2, x24
1057f34a8: f9403be3    	ldr	x3, [sp, #0x70]
1057f34ac: 9490cf24    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f34b0: aa1503e0    	mov	x0, x21
1057f34b4: 9490cf28    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f34b8: f9403be0    	ldr	x0, [sp, #0x70]
1057f34bc: 9490cf26    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f34c0: 14000010    	b	0x1057f3500 <_Flutter_MMFoundation_BindContext+0x1ccf0e4>
1057f34c4: f9400bf4    	ldr	x20, [sp, #0x10]
1057f34c8: f8746a60    	ldr	x0, [x19, x20]
1057f34cc: d00d3328    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
1057f34d0: f943c901    	ldr	x1, [x8, #0x790] ; setArrResult:
1057f34d4: aa1b03e2    	mov	x2, x27
1057f34d8: 9490cf19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f34dc: f8746a60    	ldr	x0, [x19, x20]
1057f34e0: f94007e1    	ldr	x1, [sp, #0x8]
1057f34e4: 9490cf16    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f34e8: aa1d03fd    	mov	x29, x29
1057f34ec: 9490cf17    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f34f0: aa0003f8    	mov	x24, x0
1057f34f4: f00d4888    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1057f34f8: f9404501    	ldr	x1, [x8, #0x88] ; reloadData
1057f34fc: 9490cf10    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3500: aa1803e0    	mov	x0, x24
1057f3504: 9490cf14    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f3508: aa1b03e0    	mov	x0, x27
1057f350c: 9490cf12    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f3510: f94027f7    	ldr	x23, [sp, #0x48]
1057f3514: f94013e0    	ldr	x0, [sp, #0x20]
1057f3518: 9490cf0f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f351c: f94033e0    	ldr	x0, [sp, #0x60]
1057f3520: 9490cf0d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f3524: aa1703e0    	mov	x0, x23
1057f3528: 9490cf0b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f352c: f94037e0    	ldr	x0, [sp, #0x68]
1057f3530: 9490cf09    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f3534: f94017e0    	ldr	x0, [sp, #0x28]
1057f3538: 9490cf07    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f353c: f85a03a8    	ldur	x8, [x29, #-0x60]
1057f3540: 900befe9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1057f3544: f9405929    	ldr	x9, [x9, #0xb0]
1057f3548: f9400129    	ldr	x9, [x9]
1057f354c: eb08013f    	cmp	x9, x8
1057f3550: 54000121    	b.ne	0x1057f3574 <_Flutter_MMFoundation_BindContext+0x1ccf158>
1057f3554: a95c7bfd    	ldp	x29, x30, [sp, #0x1c0]
1057f3558: a95b4ff4    	ldp	x20, x19, [sp, #0x1b0]
1057f355c: a95a57f6    	ldp	x22, x21, [sp, #0x1a0]
1057f3560: a9595ff8    	ldp	x24, x23, [sp, #0x190]
1057f3564: a95867fa    	ldp	x26, x25, [sp, #0x180]
1057f3568: a9576ffc    	ldp	x28, x27, [sp, #0x170]
1057f356c: 910743ff    	add	sp, sp, #0x1d0
1057f3570: d65f03c0    	ret
1057f3574: 9490cf00    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
