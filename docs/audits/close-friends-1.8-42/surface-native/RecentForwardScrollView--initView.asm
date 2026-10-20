
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1055126e4: d105c3ff    	sub	sp, sp, #0x170
1055126e8: 6d0f2beb    	stp	d11, d10, [sp, #0xf0]
1055126ec: 6d1023e9    	stp	d9, d8, [sp, #0x100]
1055126f0: a9116ffc    	stp	x28, x27, [sp, #0x110]
1055126f4: a91267fa    	stp	x26, x25, [sp, #0x120]
1055126f8: a9135ff8    	stp	x24, x23, [sp, #0x130]
1055126fc: a91457f6    	stp	x22, x21, [sp, #0x140]
105512700: a9154ff4    	stp	x20, x19, [sp, #0x150]
105512704: a9167bfd    	stp	x29, x30, [sp, #0x160]
105512708: 910583fd    	add	x29, sp, #0x160
10551270c: aa0003f3    	mov	x19, x0
105512710: d00db968    	adrp	x8, 0x120c40000 <dyld_stub_binder+0x120c40000>
105512714: 52800029    	mov	w9, #0x1                ; =1
105512718: 39288509    	strb	w9, [x8, #0xa21]
10551271c: b00d6308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105512720: f945e900    	ldr	x0, [x8, #0xbd0]
105512724: d00d5f68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105512728: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10551272c: 949c5284    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512730: aa1d03fd    	mov	x29, x29
105512734: 949c5285    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105512738: aa0003f4    	mov	x20, x0
10551273c: f00d6368    	adrp	x8, 0x120181000 <dyld_stub_binder+0x120181000>
105512740: f9426500    	ldr	x0, [x8, #0x4c8]
105512744: b00d5f68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105512748: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10551274c: 949c527c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512750: aa0003e2    	mov	x2, x0
105512754: f00d4928    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105512758: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10551275c: aa1403e0    	mov	x0, x20
105512760: 949c5277    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512764: aa1d03fd    	mov	x29, x29
105512768: 949c5278    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10551276c: aa0003f5    	mov	x21, x0
105512770: d00d4ca8    	adrp	x8, 0x11fea8000 <dyld_stub_binder+0x11fea8000>
105512774: f942fd01    	ldr	x1, [x8, #0x5f8] ; currentSession
105512778: 949c5271    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10551277c: aa1d03fd    	mov	x29, x29
105512780: 949c5272    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105512784: aa0003fa    	mov	x26, x0
105512788: aa1503e0    	mov	x0, x21
10551278c: 949c5272    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105512790: aa1403e0    	mov	x0, x20
105512794: 949c5270    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105512798: b400011a    	cbz	x26, 0x1055127b8 <_Flutter_MMFoundation_BindContext+0x19ee39c>
10551279c: f00d4b48    	adrp	x8, 0x11fe7d000 <dyld_stub_binder+0x11fe7d000>
1055127a0: f9437101    	ldr	x1, [x8, #0x6e0] ; sessionID
1055127a4: aa1a03e0    	mov	x0, x26
1055127a8: 949c5265    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055127ac: aa1d03fd    	mov	x29, x29
1055127b0: 949c5266    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1055127b4: 14000011    	b	0x1055127f8 <_Flutter_MMFoundation_BindContext+0x19ee3dc>
1055127b8: b00d6308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1055127bc: f9454514    	ldr	x20, [x8, #0xa88]
1055127c0: b00d6308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1055127c4: f9467900    	ldr	x0, [x8, #0xcf0]
1055127c8: d00d4948    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1055127cc: f9403501    	ldr	x1, [x8, #0x68] ; genServerCurrentTime
1055127d0: 949c525b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055127d4: 900d5fc8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1055127d8: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
1055127dc: f90003e0    	str	x0, [sp]
1055127e0: f00c7c62    	adrp	x2, 0x11e4a1000 <dyld_stub_binder+0x11e4a1000>
1055127e4: 91082042    	add	x2, x2, #0x208
1055127e8: aa1403e0    	mov	x0, x20
1055127ec: 949c5254    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055127f0: aa1d03fd    	mov	x29, x29
1055127f4: 949c5255    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1055127f8: aa0003f4    	mov	x20, x0
1055127fc: d00d54a8    	adrp	x8, 0x11ffa8000 <dyld_stub_binder+0x11ffa8000>
105512800: f942cd01    	ldr	x1, [x8, #0x598] ; setForwardSessionId:
105512804: aa1303e0    	mov	x0, x19
105512808: aa1403e2    	mov	x2, x20
10551280c: 949c524c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512810: aa1403e0    	mov	x0, x20
105512814: 949c5250    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105512818: b00d4948    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10551281c: f947f901    	ldr	x1, [x8, #0xff0] ; removeAllSubViews
105512820: aa1303e0    	mov	x0, x19
105512824: 949c5246    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512828: b00d6308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10551282c: f9455500    	ldr	x0, [x8, #0xaa8]
105512830: b00d5f68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105512834: f941a101    	ldr	x1, [x8, #0x340] ; array
105512838: 949c5241    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10551283c: aa1d03fd    	mov	x29, x29
105512840: 949c5242    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105512844: aa0003f4    	mov	x20, x0
105512848: f00d4ac8    	adrp	x8, 0x11fe6d000 <dyld_stub_binder+0x11fe6d000>
10551284c: f944d501    	ldr	x1, [x8, #0x9a8] ; setIconViews:
105512850: aa1303e0    	mov	x0, x19
105512854: aa1403e2    	mov	x2, x20
105512858: 949c5239    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10551285c: aa1403e0    	mov	x0, x20
105512860: 949c523d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105512864: d00d54a8    	adrp	x8, 0x11ffa8000 <dyld_stub_binder+0x11ffa8000>
105512868: f942d101    	ldr	x1, [x8, #0x5a0] ; contactsForRecentForwardMenu
10551286c: aa1303e0    	mov	x0, x19
105512870: 949c5233    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512874: aa1d03fd    	mov	x29, x29
105512878: 949c5234    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10551287c: aa0003f6    	mov	x22, x0
105512880: b4005a40    	cbz	x0, 0x1055133c8 <_Flutter_MMFoundation_BindContext+0x19eefac>
105512884: d00d5f68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105512888: f9435101    	ldr	x1, [x8, #0x6a0] ; count
10551288c: aa1603e0    	mov	x0, x22
105512890: f81783a1    	stur	x1, [x29, #-0x88]
105512894: 949c522a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512898: b4005980    	cbz	x0, 0x1055133c8 <_Flutter_MMFoundation_BindContext+0x19eefac>
10551289c: d00d6308    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1055128a0: f9435d00    	ldr	x0, [x8, #0x6b8]
1055128a4: 949c522d    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1055128a8: aa0003f5    	mov	x21, x0
1055128ac: d00d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
1055128b0: b984e108    	ldrsw	x8, [x8, #0x4e0] ; ivar RecentForwardScrollView.m_title
1055128b4: f8686a62    	ldr	x2, [x19, x8]
1055128b8: f00d5fa8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1055128bc: f9468d01    	ldr	x1, [x8, #0xd18] ; setText:
1055128c0: 949c521f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055128c4: d00d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
1055128c8: b984ed08    	ldrsw	x8, [x8, #0x4ec] ; ivar RecentForwardScrollView.m_titleFont
1055128cc: f8686a62    	ldr	x2, [x19, x8]
1055128d0: d00d5fa8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
1055128d4: f9400501    	ldr	x1, [x8, #0x8] ; setFont:
1055128d8: aa1503e0    	mov	x0, x21
1055128dc: 949c5218    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055128e0: b00d6308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1055128e4: f9462d00    	ldr	x0, [x8, #0xc58]
1055128e8: b00d4968    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1055128ec: f947c901    	ldr	x1, [x8, #0xf90] ; FG_0
1055128f0: 949c5213    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055128f4: aa1d03fd    	mov	x29, x29
1055128f8: 949c5214    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1055128fc: aa0003f4    	mov	x20, x0
105512900: f00d5fa8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
105512904: f9469501    	ldr	x1, [x8, #0xd28] ; setTextColor:
105512908: aa1503e0    	mov	x0, x21
10551290c: aa1403e2    	mov	x2, x20
105512910: 949c520b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512914: aa1403e0    	mov	x0, x20
105512918: 949c520f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10551291c: f00d4928    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105512920: f9465101    	ldr	x1, [x8, #0xca0] ; sizeToFit
105512924: aa1503e0    	mov	x0, x21
105512928: 949c5205    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10551292c: d00d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
105512930: b984f108    	ldrsw	x8, [x8, #0x4f0] ; ivar RecentForwardScrollView.m_titleMarginLeft
105512934: fc686a60    	ldr	d0, [x19, x8]
105512938: d00d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
10551293c: b984f508    	ldrsw	x8, [x8, #0x4f4] ; ivar RecentForwardScrollView.m_titleMarginTop
105512940: fc686a61    	ldr	d1, [x19, x8]
105512944: f00d4928    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105512948: f9465514    	ldr	x20, [x8, #0xca8] ; setWcOrigin:
10551294c: aa1503e0    	mov	x0, x21
105512950: aa1403e1    	mov	x1, x20
105512954: 949c51fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512958: f00d5fa8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
10551295c: f9466501    	ldr	x1, [x8, #0xcc8] ; setTag:
105512960: aa1503e0    	mov	x0, x21
105512964: f81683a1    	stur	x1, [x29, #-0x98]
105512968: 52813262    	mov	w2, #0x993              ; =2451
10551296c: 949c51f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512970: 900d6388    	adrp	x8, 0x120182000 <dyld_stub_binder+0x120182000>
105512974: f946a500    	ldr	x0, [x8, #0xd48] ; X>c
105512978: 949c51f8    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
10551297c: aa0003f7    	mov	x23, x0
105512980: d00d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
105512984: b984f908    	ldrsw	x8, [x8, #0x4f8] ; ivar RecentForwardScrollView.m_titleLineHeight
105512988: f9000be8    	str	x8, [sp, #0x10]
10551298c: fc686a60    	ldr	d0, [x19, x8]
105512990: 1e741001    	fmov	d1, #-8.00000000
105512994: 1e612809    	fadd	d9, d0, d1
105512998: b00d6308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10551299c: f9468d00    	ldr	x0, [x8, #0xd18]
1055129a0: b00d4948    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1055129a4: f9400901    	ldr	x1, [x8, #0x10] ; isiPadUniversal
1055129a8: f90017e1    	str	x1, [sp, #0x28]
1055129ac: 949c51e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055129b0: 9009c388    	adrp	x8, 0x118d82000 <dyld_stub_binder+0x118d82000>
1055129b4: f9000ff4    	str	x20, [sp, #0x18]
1055129b8: 36000060    	tbz	w0, #0x0, 0x1055129c4 <_Flutter_MMFoundation_BindContext+0x19ee5a8>
1055129bc: fd40b502    	ldr	d2, [x8, #0x168]
1055129c0: 1400000f    	b	0x1055129fc <_Flutter_MMFoundation_BindContext+0x19ee5e0>
1055129c4: b00d6314    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
1055129c8: f9470280    	ldr	x0, [x20, #0xe00]
1055129cc: f00d4988    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
1055129d0: f9456501    	ldr	x1, [x8, #0xac8] ; pageScopeHeightWithWarningFor:
1055129d4: aa1303e2    	mov	x2, x19
1055129d8: 949c51d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055129dc: 1e604008    	fmov	d8, d0
1055129e0: f9470280    	ldr	x0, [x20, #0xe00]
1055129e4: b00d49a8    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
1055129e8: f947d901    	ldr	x1, [x8, #0xfb0] ; pageScopeWidthWithWarningFor:
1055129ec: aa1303e2    	mov	x2, x19
1055129f0: 949c51d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055129f4: 1e602100    	fcmp	d8, d0
1055129f8: 1e604d02    	fcsel	d2, d8, d0, mi
1055129fc: a9036bf5    	stp	x21, x26, [sp, #0x30]
105512a00: d00d5fa8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
105512a04: f9403501    	ldr	x1, [x8, #0x68] ; setFrame:
105512a08: 9e6703e8    	fmov	d8, xzr
105512a0c: 9e6703e0    	fmov	d0, xzr
105512a10: 9e6703e3    	fmov	d3, xzr
105512a14: aa1703e0    	mov	x0, x23
105512a18: f90023e1    	str	x1, [sp, #0x40]
105512a1c: 1e604121    	fmov	d1, d9
105512a20: 949c51c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512a24: d00d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
105512a28: b984fd08    	ldrsw	x8, [x8, #0x4fc] ; ivar RecentForwardScrollView.m_scrollViewMarginLeft
105512a2c: f90013e8    	str	x8, [sp, #0x20]
105512a30: fc686a61    	ldr	d1, [x19, x8]
105512a34: b00d5fa8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
105512a38: f9439501    	ldr	x1, [x8, #0x728] ; setContentInset:
105512a3c: 9e6703e0    	fmov	d0, xzr
105512a40: 9e6703e2    	fmov	d2, xzr
105512a44: aa1703e0    	mov	x0, x23
105512a48: 1e604023    	fmov	d3, d1
105512a4c: 949c51bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512a50: f00d5fa8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
105512a54: f9451101    	ldr	x1, [x8, #0xa20] ; setShowsHorizontalScrollIndicator:
105512a58: aa1703e0    	mov	x0, x23
105512a5c: 52800002    	mov	w2, #0x0                ; =0
105512a60: 949c51b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512a64: b00d4968    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
105512a68: f941b501    	ldr	x1, [x8, #0x368] ; setCanCancelContentTouches:
105512a6c: aa1703e0    	mov	x0, x23
105512a70: 52800022    	mov	w2, #0x1                ; =1
105512a74: 949c51b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512a78: b00d49a8    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
105512a7c: f946dd01    	ldr	x1, [x8, #0xdb8] ; setDelaysContentTouches:
105512a80: f81703b7    	stur	x23, [x29, #-0x90]
105512a84: aa1703e0    	mov	x0, x23
105512a88: 52800022    	mov	w2, #0x1                ; =1
105512a8c: 949c51ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512a90: aa1603e0    	mov	x0, x22
105512a94: f85783a1    	ldur	x1, [x29, #-0x88]
105512a98: 949c51a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512a9c: d00d5fa9    	adrp	x9, 0x120108000 <dyld_stub_binder+0x120108000>
105512aa0: 900d5f6a    	adrp	x10, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
105512aa4: b00d5fcb    	adrp	x11, 0x12010b000 <dyld_stub_binder+0x12010b000>
105512aa8: d00d494c    	adrp	x12, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105512aac: b4001d20    	cbz	x0, 0x105512e50 <_Flutter_MMFoundation_BindContext+0x19eea34>
105512ab0: d280001c    	mov	x28, #0x0               ; =0
105512ab4: d2800019    	mov	x25, #0x0               ; =0
105512ab8: d00d5f88    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
105512abc: f947e108    	ldr	x8, [x8, #0xfc0] ; objectAtIndexedSubscript:
105512ac0: f81603a8    	stur	x8, [x29, #-0xa0]
105512ac4: d00d54a8    	adrp	x8, 0x11ffa8000 <dyld_stub_binder+0x11ffa8000>
105512ac8: f942d508    	ldr	x8, [x8, #0x5a8] ; initWithContact:iconWidth:bottomPadding:titleFont:itemMarginLeft:
105512acc: f81583a8    	stur	x8, [x29, #-0xa8]
105512ad0: 900d5fc8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105512ad4: f941cd08    	ldr	x8, [x8, #0x398] ; setX:
105512ad8: f9005be8    	str	x8, [sp, #0xb0]
105512adc: 900d5f88    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105512ae0: f9449d08    	ldr	x8, [x8, #0x938] ; height
105512ae4: f90057e8    	str	x8, [sp, #0xa8]
105512ae8: b00d5fa8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
105512aec: f9451508    	ldr	x8, [x8, #0xa28] ; setDelegate:
105512af0: f90053e8    	str	x8, [sp, #0xa0]
105512af4: d00d54a8    	adrp	x8, 0x11ffa8000 <dyld_stub_binder+0x11ffa8000>
105512af8: f942ad1a    	ldr	x26, [x8, #0x558] ; smallDeleteButton
105512afc: f9431d88    	ldr	x8, [x12, #0x638] ; right
105512b00: f9004fe8    	str	x8, [sp, #0x98]
105512b04: f947a568    	ldr	x8, [x11, #0xf48] ; width
105512b08: f81803a8    	stur	x8, [x29, #-0x80]
105512b0c: d00d4948    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105512b10: f940450b    	ldr	x11, [x8, #0x88] ; left
105512b14: 900d5fc8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105512b18: f9418d08    	ldr	x8, [x8, #0x318] ; setWidth:
105512b1c: a9052fe8    	stp	x8, x11, [sp, #0x50]
105512b20: f9410928    	ldr	x8, [x9, #0x210] ; setHeight:
105512b24: f90027e8    	str	x8, [sp, #0x48]
105512b28: d00d4f08    	adrp	x8, 0x11fef4000 <dyld_stub_binder+0x11fef4000>
105512b2c: f9427509    	ldr	x9, [x8, #0x4e8] ; onItemClick:
105512b30: b00d5f88    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
105512b34: f9413508    	ldr	x8, [x8, #0x268] ; initWithTarget:action:
105512b38: a908a7e8    	stp	x8, x9, [sp, #0x88]
105512b3c: d00d54a8    	adrp	x8, 0x11ffa8000 <dyld_stub_binder+0x11ffa8000>
105512b40: f942d909    	ldr	x9, [x8, #0x5b0] ; onItemLongPress:
105512b44: b00d5fa8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
105512b48: f9422d08    	ldr	x8, [x8, #0x458] ; setCancelsTouchesInView:
105512b4c: a907a7e8    	stp	x8, x9, [sp, #0x78]
105512b50: 900d5f68    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
105512b54: f946b515    	ldr	x21, [x8, #0xd68] ; addGestureRecognizer:
105512b58: f00d4ac8    	adrp	x8, 0x11fe6d000 <dyld_stub_binder+0x11fe6d000>
105512b5c: 900d4949    	adrp	x9, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105512b60: f9476d4a    	ldr	x10, [x10, #0xed8] ; addSubview:
105512b64: f944e908    	ldr	x8, [x8, #0x9d0] ; iconViews
105512b68: a906abe8    	stp	x8, x10, [sp, #0x68]
105512b6c: 1e70100b    	fmov	d11, #-2.00000000
105512b70: f943c528    	ldr	x8, [x9, #0x788] ; safeAddObject:
105512b74: f90033e8    	str	x8, [sp, #0x60]
105512b78: aa1903fb    	mov	x27, x25
105512b7c: f00d6408    	adrp	x8, 0x120195000 <dyld_stub_binder+0x120195000>
105512b80: f945c900    	ldr	x0, [x8, #0xb90]
105512b84: 949c5177    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105512b88: aa0003f9    	mov	x25, x0
105512b8c: aa1603f7    	mov	x23, x22
105512b90: aa1603e0    	mov	x0, x22
105512b94: f85603a1    	ldur	x1, [x29, #-0xa0]
105512b98: aa1c03e2    	mov	x2, x28
105512b9c: 949c5168    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512ba0: aa1d03fd    	mov	x29, x29
105512ba4: 949c5169    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105512ba8: aa0003f4    	mov	x20, x0
105512bac: d00d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
105512bb0: b984e918    	ldrsw	x24, [x8, #0x4e8] ; ivar RecentForwardScrollView.m_headImgWidth
105512bb4: fc786a60    	ldr	d0, [x19, x24]
105512bb8: d00d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
105512bbc: b9850908    	ldrsw	x8, [x8, #0x508] ; ivar RecentForwardScrollView.m_bottomPadding
105512bc0: fc686a61    	ldr	d1, [x19, x8]
105512bc4: d00d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
105512bc8: b9850d08    	ldrsw	x8, [x8, #0x50c] ; ivar RecentForwardScrollView.m_nameLabelFont
105512bcc: f8686a63    	ldr	x3, [x19, x8]
105512bd0: d00d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
105512bd4: b9850116    	ldrsw	x22, [x8, #0x500] ; ivar RecentForwardScrollView.m_scrollItemMarginLeft
105512bd8: fc766a62    	ldr	d2, [x19, x22]
105512bdc: aa1903e0    	mov	x0, x25
105512be0: f85583a1    	ldur	x1, [x29, #-0xa8]
105512be4: aa1403e2    	mov	x2, x20
105512be8: 949c5155    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512bec: aa0003f9    	mov	x25, x0
105512bf0: aa1b03e0    	mov	x0, x27
105512bf4: 949c5158    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105512bf8: aa1403e0    	mov	x0, x20
105512bfc: 949c5156    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105512c00: aa1903e0    	mov	x0, x25
105512c04: f85683a1    	ldur	x1, [x29, #-0x98]
105512c08: aa1c03e2    	mov	x2, x28
105512c0c: 949c514c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512c10: fc786a60    	ldr	d0, [x19, x24]
105512c14: fc766a61    	ldr	d1, [x19, x22]
105512c18: 1e612800    	fadd	d0, d0, d1
105512c1c: 1e630381    	ucvtf	d1, w28
105512c20: 1e610800    	fmul	d0, d0, d1
105512c24: aa1903e0    	mov	x0, x25
105512c28: f9405be1    	ldr	x1, [sp, #0xb0]
105512c2c: 949c5144    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512c30: aa1903e0    	mov	x0, x25
105512c34: f94057e1    	ldr	x1, [sp, #0xa8]
105512c38: 949c5141    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512c3c: 1e602100    	fcmp	d8, d0
105512c40: 1e684c08    	fcsel	d8, d0, d8, mi
105512c44: aa1903e0    	mov	x0, x25
105512c48: f94053e1    	ldr	x1, [sp, #0xa0]
105512c4c: aa1303e2    	mov	x2, x19
105512c50: 949c513b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512c54: aa1903e0    	mov	x0, x25
105512c58: aa1a03e1    	mov	x1, x26
105512c5c: 949c5138    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512c60: aa1d03fd    	mov	x29, x29
105512c64: 949c5139    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105512c68: aa0003f4    	mov	x20, x0
105512c6c: f9404fe1    	ldr	x1, [sp, #0x98]
105512c70: 949c5133    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512c74: 1e604009    	fmov	d9, d0
105512c78: aa1903e0    	mov	x0, x25
105512c7c: f85803a1    	ldur	x1, [x29, #-0x80]
105512c80: 949c512f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512c84: 1e60400a    	fmov	d10, d0
105512c88: aa1403e0    	mov	x0, x20
105512c8c: 949c5132    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105512c90: 1e6a2120    	fcmp	d9, d10
105512c94: 5400066d    	b.le	0x105512d60 <_Flutter_MMFoundation_BindContext+0x19ee944>
105512c98: aa1903e0    	mov	x0, x25
105512c9c: f85803b6    	ldur	x22, [x29, #-0x80]
105512ca0: aa1603e1    	mov	x1, x22
105512ca4: 949c5126    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512ca8: 1e604009    	fmov	d9, d0
105512cac: aa1903e0    	mov	x0, x25
105512cb0: aa1a03e1    	mov	x1, x26
105512cb4: 949c5122    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512cb8: aa1d03fd    	mov	x29, x29
105512cbc: 949c5123    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105512cc0: aa0003f4    	mov	x20, x0
105512cc4: f9402fe1    	ldr	x1, [sp, #0x58]
105512cc8: 949c511d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512ccc: 1e603920    	fsub	d0, d9, d0
105512cd0: 1e6b2809    	fadd	d9, d0, d11
105512cd4: aa1903e0    	mov	x0, x25
105512cd8: aa1a03e1    	mov	x1, x26
105512cdc: 949c5118    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512ce0: aa1d03fd    	mov	x29, x29
105512ce4: 949c5119    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105512ce8: aa0003fb    	mov	x27, x0
105512cec: f9402be1    	ldr	x1, [sp, #0x50]
105512cf0: 1e604120    	fmov	d0, d9
105512cf4: 949c5112    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512cf8: aa1b03e0    	mov	x0, x27
105512cfc: 949c5116    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105512d00: aa1403e0    	mov	x0, x20
105512d04: 949c5114    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105512d08: aa1903e0    	mov	x0, x25
105512d0c: aa1a03e1    	mov	x1, x26
105512d10: 949c510b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512d14: aa1d03fd    	mov	x29, x29
105512d18: 949c510c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105512d1c: aa0003f4    	mov	x20, x0
105512d20: aa1603e1    	mov	x1, x22
105512d24: 949c5106    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512d28: 1e604009    	fmov	d9, d0
105512d2c: aa1903e0    	mov	x0, x25
105512d30: aa1a03e1    	mov	x1, x26
105512d34: 949c5102    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512d38: aa1d03fd    	mov	x29, x29
105512d3c: 949c5103    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105512d40: aa0003fb    	mov	x27, x0
105512d44: f94027e1    	ldr	x1, [sp, #0x48]
105512d48: 1e604120    	fmov	d0, d9
105512d4c: 949c50fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512d50: aa1b03e0    	mov	x0, x27
105512d54: 949c5100    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105512d58: aa1403e0    	mov	x0, x20
105512d5c: 949c50fe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105512d60: d00d6308    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105512d64: f9414500    	ldr	x0, [x8, #0x288]
105512d68: 949c50fe    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105512d6c: a9488ff4    	ldp	x20, x3, [sp, #0x88]
105512d70: aa1403e1    	mov	x1, x20
105512d74: aa1303e2    	mov	x2, x19
105512d78: 949c50f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512d7c: aa0003fb    	mov	x27, x0
105512d80: f00d6308    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
105512d84: f945c500    	ldr	x0, [x8, #0xb88]
105512d88: 949c50f6    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105512d8c: aa1403e1    	mov	x1, x20
105512d90: aa1303e2    	mov	x2, x19
105512d94: f94043e3    	ldr	x3, [sp, #0x80]
105512d98: 949c50e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512d9c: aa0003f4    	mov	x20, x0
105512da0: aa1b03e0    	mov	x0, x27
105512da4: f9403ff6    	ldr	x22, [sp, #0x78]
105512da8: aa1603e1    	mov	x1, x22
105512dac: 52800002    	mov	w2, #0x0                ; =0
105512db0: 949c50e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512db4: aa1403e0    	mov	x0, x20
105512db8: aa1603e1    	mov	x1, x22
105512dbc: 52800002    	mov	w2, #0x0                ; =0
105512dc0: 949c50df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512dc4: aa1903e0    	mov	x0, x25
105512dc8: aa1503e1    	mov	x1, x21
105512dcc: aa1b03e2    	mov	x2, x27
105512dd0: 949c50db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512dd4: aa1903e0    	mov	x0, x25
105512dd8: aa1503e1    	mov	x1, x21
105512ddc: aa1403e2    	mov	x2, x20
105512de0: 949c50d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512de4: f85703a0    	ldur	x0, [x29, #-0x90]
105512de8: f9403be1    	ldr	x1, [sp, #0x70]
105512dec: aa1903e2    	mov	x2, x25
105512df0: 949c50d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512df4: aa1303e0    	mov	x0, x19
105512df8: f94037e1    	ldr	x1, [sp, #0x68]
105512dfc: 949c50d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512e00: aa1d03fd    	mov	x29, x29
105512e04: 949c50d1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105512e08: aa0003f8    	mov	x24, x0
105512e0c: f94033e1    	ldr	x1, [sp, #0x60]
105512e10: aa1903e2    	mov	x2, x25
105512e14: 949c50ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512e18: aa1803e0    	mov	x0, x24
105512e1c: 949c50ce    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105512e20: aa1403e0    	mov	x0, x20
105512e24: 949c50cc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105512e28: aa1b03e0    	mov	x0, x27
105512e2c: 949c50ca    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105512e30: 9100079c    	add	x28, x28, #0x1
105512e34: aa1703f6    	mov	x22, x23
105512e38: aa1703e0    	mov	x0, x23
105512e3c: f85783a1    	ldur	x1, [x29, #-0x88]
105512e40: 949c50bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512e44: eb1c001f    	cmp	x0, x28
105512e48: 54ffe988    	b.hi	0x105512b78 <_Flutter_MMFoundation_BindContext+0x19ee75c>
105512e4c: 14000002    	b	0x105512e54 <_Flutter_MMFoundation_BindContext+0x19eea38>
105512e50: d2800019    	mov	x25, #0x0               ; =0
105512e54: d00d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
105512e58: b9851518    	ldrsw	x24, [x8, #0x514] ; ivar RecentForwardScrollView.m_bNewEditModel
105512e5c: 38786a68    	ldrb	w8, [x19, x24]
105512e60: 36000fa8    	tbz	w8, #0x0, 0x105513054 <_Flutter_MMFoundation_BindContext+0x19eec38>
105512e64: d00d54a8    	adrp	x8, 0x11ffa8000 <dyld_stub_binder+0x11ffa8000>
105512e68: f942dd01    	ldr	x1, [x8, #0x5b8] ; initDeleteForwardChatBtnInNewEditModel
105512e6c: aa1303e0    	mov	x0, x19
105512e70: 949c50b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512e74: d00d4948    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105512e78: f9431d15    	ldr	x21, [x8, #0x638] ; right
105512e7c: aa1903e0    	mov	x0, x25
105512e80: aa1503e1    	mov	x1, x21
105512e84: 949c50ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512e88: 1e604009    	fmov	d9, d0
105512e8c: d00d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
105512e90: b984e91a    	ldrsw	x26, [x8, #0x4e8] ; ivar RecentForwardScrollView.m_headImgWidth
105512e94: fc7a6a6a    	ldr	d10, [x19, x26]
105512e98: d00d54a8    	adrp	x8, 0x11ffa8000 <dyld_stub_binder+0x11ffa8000>
105512e9c: aa1603fb    	mov	x27, x22
105512ea0: f942e116    	ldr	x22, [x8, #0x5c0] ; deleteForwardChatBtnInNewEditModel
105512ea4: aa1303e0    	mov	x0, x19
105512ea8: aa1603e1    	mov	x1, x22
105512eac: 949c50a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512eb0: aa1d03fd    	mov	x29, x29
105512eb4: 949c50a5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105512eb8: aa0003f4    	mov	x20, x0
105512ebc: 9e6703e1    	fmov	d1, xzr
105512ec0: f94023e1    	ldr	x1, [sp, #0x40]
105512ec4: 1e604120    	fmov	d0, d9
105512ec8: 1e604142    	fmov	d2, d10
105512ecc: 1e604143    	fmov	d3, d10
105512ed0: 949c509b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512ed4: aa1403e0    	mov	x0, x20
105512ed8: 949c509f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105512edc: aa1303e0    	mov	x0, x19
105512ee0: aa1603e1    	mov	x1, x22
105512ee4: 949c5096    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512ee8: aa1d03fd    	mov	x29, x29
105512eec: 949c5097    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105512ef0: aa0003f7    	mov	x23, x0
105512ef4: 900d5f68    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
105512ef8: f9476d14    	ldr	x20, [x8, #0xed8] ; addSubview:
105512efc: f85703bc    	ldur	x28, [x29, #-0x90]
105512f00: aa1c03e0    	mov	x0, x28
105512f04: aa1403e1    	mov	x1, x20
105512f08: aa1703e2    	mov	x2, x23
105512f0c: 949c508c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512f10: aa1703e0    	mov	x0, x23
105512f14: 949c5090    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105512f18: fc7a6a60    	ldr	d0, [x19, x26]
105512f1c: 1e6c100a    	fmov	d10, #0.50000000
105512f20: 1e6a0800    	fmul	d0, d0, d10
105512f24: 1e64100b    	fmov	d11, #8.00000000
105512f28: 1e6b2809    	fadd	d9, d0, d11
105512f2c: aa1303e0    	mov	x0, x19
105512f30: aa1603e1    	mov	x1, x22
105512f34: 949c5082    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512f38: aa1d03fd    	mov	x29, x29
105512f3c: 949c5083    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105512f40: aa0003f6    	mov	x22, x0
105512f44: d00d4948    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105512f48: f9401917    	ldr	x23, [x8, #0x30] ; setCenterY:
105512f4c: aa1703e1    	mov	x1, x23
105512f50: 1e604120    	fmov	d0, d9
105512f54: 949c507a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512f58: aa1603e0    	mov	x0, x22
105512f5c: 949c507e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105512f60: d00d54a8    	adrp	x8, 0x11ffa8000 <dyld_stub_binder+0x11ffa8000>
105512f64: f942e501    	ldr	x1, [x8, #0x5c8] ; initFinishForwardChatBtnInNewEditModel
105512f68: aa1303e0    	mov	x0, x19
105512f6c: 949c5074    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512f70: aa1903e0    	mov	x0, x25
105512f74: aa1503e1    	mov	x1, x21
105512f78: 949c5071    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512f7c: 1e604009    	fmov	d9, d0
105512f80: d00d54a8    	adrp	x8, 0x11ffa8000 <dyld_stub_binder+0x11ffa8000>
105512f84: f942e915    	ldr	x21, [x8, #0x5d0] ; finishForwardChatBtnInNewEditModelView
105512f88: aa1303e0    	mov	x0, x19
105512f8c: aa1503e1    	mov	x1, x21
105512f90: 949c506b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512f94: aa1d03fd    	mov	x29, x29
105512f98: 949c506c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105512f9c: aa0003f6    	mov	x22, x0
105512fa0: d00d4948    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105512fa4: f9432101    	ldr	x1, [x8, #0x640] ; setLeft:
105512fa8: 1e604120    	fmov	d0, d9
105512fac: 949c5064    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512fb0: aa1603e0    	mov	x0, x22
105512fb4: 949c5068    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105512fb8: fc7a6a60    	ldr	d0, [x19, x26]
105512fbc: 1e6a0800    	fmul	d0, d0, d10
105512fc0: 1e6b2809    	fadd	d9, d0, d11
105512fc4: aa1303e0    	mov	x0, x19
105512fc8: aa1503e1    	mov	x1, x21
105512fcc: 949c505c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512fd0: aa1d03fd    	mov	x29, x29
105512fd4: 949c505d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105512fd8: aa0003f6    	mov	x22, x0
105512fdc: aa1703e1    	mov	x1, x23
105512fe0: 1e604120    	fmov	d0, d9
105512fe4: 949c5056    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512fe8: aa1603e0    	mov	x0, x22
105512fec: 949c505a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105512ff0: aa1303e0    	mov	x0, x19
105512ff4: aa1503e1    	mov	x1, x21
105512ff8: 949c5051    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105512ffc: aa1d03fd    	mov	x29, x29
105513000: 949c5052    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105513004: aa0003f6    	mov	x22, x0
105513008: b00d5fa8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10551300c: f9411101    	ldr	x1, [x8, #0x220] ; setHidden:
105513010: 52800022    	mov	w2, #0x1                ; =1
105513014: 949c504a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513018: aa1603e0    	mov	x0, x22
10551301c: aa1b03f6    	mov	x22, x27
105513020: 949c504d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105513024: aa1303e0    	mov	x0, x19
105513028: aa1503e1    	mov	x1, x21
10551302c: 949c5044    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513030: aa1d03fd    	mov	x29, x29
105513034: 949c5045    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105513038: aa0003f5    	mov	x21, x0
10551303c: aa1c03e0    	mov	x0, x28
105513040: aa1403e1    	mov	x1, x20
105513044: aa1503e2    	mov	x2, x21
105513048: 949c503d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10551304c: aa1503e0    	mov	x0, x21
105513050: 949c5041    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105513054: a94107e8    	ldp	x8, x1, [sp, #0x10]
105513058: fc686a60    	ldr	d0, [x19, x8]
10551305c: 1e741001    	fmov	d1, #-8.00000000
105513060: 1e612801    	fadd	d1, d0, d1
105513064: 9e6703e0    	fmov	d0, xzr
105513068: f85703bb    	ldur	x27, [x29, #-0x90]
10551306c: aa1b03e0    	mov	x0, x27
105513070: 949c5033    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513074: b00d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
105513078: b984e908    	ldrsw	x8, [x8, #0x4e8] ; ivar RecentForwardScrollView.m_headImgWidth
10551307c: fc686a60    	ldr	d0, [x19, x8]
105513080: b00d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
105513084: b9850114    	ldrsw	x20, [x8, #0x500] ; ivar RecentForwardScrollView.m_scrollItemMarginLeft
105513088: fc746a61    	ldr	d1, [x19, x20]
10551308c: 1e612809    	fadd	d9, d0, d1
105513090: aa1603e0    	mov	x0, x22
105513094: f85783a1    	ldur	x1, [x29, #-0x88]
105513098: 949c5029    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10551309c: 9e630000    	ucvtf	d0, x0
1055130a0: fc746a6a    	ldr	d10, [x19, x20]
1055130a4: 1f60a929    	fnmsub	d9, d9, d0, d10
1055130a8: 38786a68    	ldrb	w8, [x19, x24]
1055130ac: 7100051f    	cmp	w8, #0x1
1055130b0: f9401bfc    	ldr	x28, [sp, #0x30]
1055130b4: 540001e1    	b.ne	0x1055130f0 <_Flutter_MMFoundation_BindContext+0x19eecd4>
1055130b8: b00d54a8    	adrp	x8, 0x11ffa8000 <dyld_stub_binder+0x11ffa8000>
1055130bc: f942e101    	ldr	x1, [x8, #0x5c0] ; deleteForwardChatBtnInNewEditModel
1055130c0: aa1303e0    	mov	x0, x19
1055130c4: 949c501e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055130c8: aa1d03fd    	mov	x29, x29
1055130cc: 949c501f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1055130d0: aa0003f4    	mov	x20, x0
1055130d4: 900d5fc8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1055130d8: f947a501    	ldr	x1, [x8, #0xf48] ; width
1055130dc: 949c5018    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055130e0: 1e602940    	fadd	d0, d10, d0
1055130e4: 1e602929    	fadd	d9, d9, d0
1055130e8: aa1403e0    	mov	x0, x20
1055130ec: 949c501a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1055130f0: a943e3fa    	ldp	x26, x24, [sp, #0x38]
1055130f4: f94017f7    	ldr	x23, [sp, #0x28]
1055130f8: b00d5fb4    	adrp	x20, 0x120108000 <dyld_stub_binder+0x120108000>
1055130fc: 900d49a8    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
105513100: f9472d01    	ldr	x1, [x8, #0xe58] ; setContentSize:
105513104: aa1b03e0    	mov	x0, x27
105513108: 1e604120    	fmov	d0, d9
10551310c: 1e604101    	fmov	d1, d8
105513110: 949c500b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513114: f00d4968    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
105513118: f9442901    	ldr	x1, [x8, #0x850] ; contentSize
10551311c: aa1b03e0    	mov	x0, x27
105513120: 949c5007    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513124: 1e604020    	fmov	d0, d1
105513128: f9410a81    	ldr	x1, [x20, #0x210] ; setHeight:
10551312c: aa1b03e0    	mov	x0, x27
105513130: 949c5003    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513134: b00d54a8    	adrp	x8, 0x11ffa8000 <dyld_stub_binder+0x11ffa8000>
105513138: f942ed01    	ldr	x1, [x8, #0x5d8] ; setAScrollView:
10551313c: aa1303e0    	mov	x0, x19
105513140: aa1b03e2    	mov	x2, x27
105513144: 949c4ffe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513148: 900d6308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10551314c: f9468d00    	ldr	x0, [x8, #0xd18]
105513150: aa1703e1    	mov	x1, x23
105513154: 949c4ffa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513158: 36000080    	tbz	w0, #0x0, 0x105513168 <_Flutter_MMFoundation_BindContext+0x19eed4c>
10551315c: f009c368    	adrp	x8, 0x118d82000 <dyld_stub_binder+0x118d82000>
105513160: fd40b508    	ldr	d8, [x8, #0x168]
105513164: 1400000f    	b	0x1055131a0 <_Flutter_MMFoundation_BindContext+0x19eed84>
105513168: 900d6314    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
10551316c: f9470280    	ldr	x0, [x20, #0xe00]
105513170: d00d4988    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
105513174: f9456501    	ldr	x1, [x8, #0xac8] ; pageScopeHeightWithWarningFor:
105513178: aa1303e2    	mov	x2, x19
10551317c: 949c4ff0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513180: 1e604008    	fmov	d8, d0
105513184: f9470280    	ldr	x0, [x20, #0xe00]
105513188: 900d49a8    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
10551318c: f947d901    	ldr	x1, [x8, #0xfb0] ; pageScopeWidthWithWarningFor:
105513190: aa1303e2    	mov	x2, x19
105513194: 949c4fea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513198: 1e602100    	fcmp	d8, d0
10551319c: 1e604d08    	fcsel	d8, d8, d0, mi
1055131a0: f00d5f54    	adrp	x20, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1055131a4: b00d4948    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1055131a8: f9432915    	ldr	x21, [x8, #0x650] ; bottom
1055131ac: aa1b03e0    	mov	x0, x27
1055131b0: aa1503e1    	mov	x1, x21
1055131b4: 949c4fe2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055131b8: 1e604003    	fmov	d3, d0
1055131bc: 9e6703e0    	fmov	d0, xzr
1055131c0: 9e6703e1    	fmov	d1, xzr
1055131c4: aa1303e0    	mov	x0, x19
1055131c8: aa1803e1    	mov	x1, x24
1055131cc: 1e604102    	fmov	d2, d8
1055131d0: 949c4fdb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055131d4: f9476e94    	ldr	x20, [x20, #0xed8] ; addSubview:
1055131d8: aa1303e0    	mov	x0, x19
1055131dc: aa1403e1    	mov	x1, x20
1055131e0: aa1c03e2    	mov	x2, x28
1055131e4: 949c4fd6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055131e8: aa1303e0    	mov	x0, x19
1055131ec: aa1403e1    	mov	x1, x20
1055131f0: aa1b03e2    	mov	x2, x27
1055131f4: 949c4fd2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055131f8: b00d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
1055131fc: b9850508    	ldrsw	x8, [x8, #0x504] ; ivar RecentForwardScrollView.m_showSeperator
105513200: 38686a68    	ldrb	w8, [x19, x8]
105513204: 36000208    	tbz	w8, #0x0, 0x105513244 <_Flutter_MMFoundation_BindContext+0x19eee28>
105513208: aa1603fb    	mov	x27, x22
10551320c: 900d6308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105513210: f9474d00    	ldr	x0, [x8, #0xe98]
105513214: 949c4fd1    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
105513218: aa0003f6    	mov	x22, x0
10551321c: f94013e8    	ldr	x8, [sp, #0x20]
105513220: fc686a68    	ldr	d8, [x19, x8]
105513224: 900d6308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105513228: f9468d00    	ldr	x0, [x8, #0xd18]
10551322c: aa1703e1    	mov	x1, x23
105513230: 949c4fc3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513234: 360000e0    	tbz	w0, #0x0, 0x105513250 <_Flutter_MMFoundation_BindContext+0x19eee34>
105513238: f009c368    	adrp	x8, 0x118d82000 <dyld_stub_binder+0x118d82000>
10551323c: fd40b500    	ldr	d0, [x8, #0x168]
105513240: 14000012    	b	0x105513288 <_Flutter_MMFoundation_BindContext+0x19eee6c>
105513244: 900d5fa8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
105513248: f940e117    	ldr	x23, [x8, #0x1c0] ; setBackgroundColor:
10551324c: 14000053    	b	0x105513398 <_Flutter_MMFoundation_BindContext+0x19eef7c>
105513250: 900d6317    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
105513254: f94702e0    	ldr	x0, [x23, #0xe00]
105513258: d00d4988    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
10551325c: f9456501    	ldr	x1, [x8, #0xac8] ; pageScopeHeightWithWarningFor:
105513260: aa1303e2    	mov	x2, x19
105513264: 949c4fb6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513268: 1e604009    	fmov	d9, d0
10551326c: f94702e0    	ldr	x0, [x23, #0xe00]
105513270: 900d49a8    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
105513274: f947d901    	ldr	x1, [x8, #0xfb0] ; pageScopeWidthWithWarningFor:
105513278: aa1303e2    	mov	x2, x19
10551327c: 949c4fb0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513280: 1e602120    	fcmp	d9, d0
105513284: 1e604d20    	fcsel	d0, d9, d0, mi
105513288: f94013e8    	ldr	x8, [sp, #0x20]
10551328c: fc686a61    	ldr	d1, [x19, x8]
105513290: 1e613809    	fsub	d9, d0, d1
105513294: b00d6308    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105513298: f9406100    	ldr	x0, [x8, #0xc0]
10551329c: b00d5f88    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1055132a0: f9413101    	ldr	x1, [x8, #0x260] ; mainScreen
1055132a4: 949c4fa6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055132a8: aa1d03fd    	mov	x29, x29
1055132ac: 949c4fa7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1055132b0: aa0003f7    	mov	x23, x0
1055132b4: f00d5f88    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1055132b8: f944d901    	ldr	x1, [x8, #0x9b0] ; scale
1055132bc: 949c4fa0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055132c0: 1e6e1001    	fmov	d1, #1.00000000
1055132c4: 1e601823    	fdiv	d3, d1, d0
1055132c8: 9e6703e1    	fmov	d1, xzr
1055132cc: aa1603e0    	mov	x0, x22
1055132d0: aa1803e1    	mov	x1, x24
1055132d4: 1e604100    	fmov	d0, d8
1055132d8: 1e604122    	fmov	d2, d9
1055132dc: 949c4f98    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055132e0: aa1703e0    	mov	x0, x23
1055132e4: 949c4f9c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1055132e8: 900d6308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1055132ec: f9462d00    	ldr	x0, [x8, #0xc58]
1055132f0: b00d4948    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1055132f4: f940a501    	ldr	x1, [x8, #0x148] ; seperatorColor
1055132f8: 949c4f91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055132fc: aa1d03fd    	mov	x29, x29
105513300: 949c4f92    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105513304: aa0003f8    	mov	x24, x0
105513308: 900d5fa8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10551330c: f940e117    	ldr	x23, [x8, #0x1c0] ; setBackgroundColor:
105513310: aa1603e0    	mov	x0, x22
105513314: aa1703e1    	mov	x1, x23
105513318: aa1803e2    	mov	x2, x24
10551331c: 949c4f88    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513320: aa1803e0    	mov	x0, x24
105513324: 949c4f8c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105513328: f85703b8    	ldur	x24, [x29, #-0x90]
10551332c: aa1803e0    	mov	x0, x24
105513330: aa1503e1    	mov	x1, x21
105513334: 949c4f82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513338: 1e7e1001    	fmov	d1, #-1.00000000
10551333c: 1e612800    	fadd	d0, d0, d1
105513340: f00d5fa8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105513344: f941d901    	ldr	x1, [x8, #0x3b0] ; setY:
105513348: aa1603e0    	mov	x0, x22
10551334c: 949c4f7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513350: f00d5fa8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105513354: f9406901    	ldr	x1, [x8, #0xd0] ; setUserInteractionEnabled:
105513358: aa1603e0    	mov	x0, x22
10551335c: 52800002    	mov	w2, #0x0                ; =0
105513360: 949c4f77    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513364: aa1303e0    	mov	x0, x19
105513368: aa1403e1    	mov	x1, x20
10551336c: aa1603e2    	mov	x2, x22
105513370: 949c4f73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513374: f00d4ee8    	adrp	x8, 0x11fef2000 <dyld_stub_binder+0x11fef2000>
105513378: f947bd01    	ldr	x1, [x8, #0xf78] ; setSeperator:
10551337c: aa1303e0    	mov	x0, x19
105513380: aa1603e2    	mov	x2, x22
105513384: 949c4f6e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513388: aa1603e0    	mov	x0, x22
10551338c: 949c4f72    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105513390: aa1b03f6    	mov	x22, x27
105513394: aa1803fb    	mov	x27, x24
105513398: b00d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
10551339c: b984e508    	ldrsw	x8, [x8, #0x4e4] ; ivar RecentForwardScrollView.m_backgroundColor
1055133a0: f8686a62    	ldr	x2, [x19, x8]
1055133a4: aa1303e0    	mov	x0, x19
1055133a8: aa1703e1    	mov	x1, x23
1055133ac: 949c4f64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055133b0: aa1903e0    	mov	x0, x25
1055133b4: 949c4f68    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1055133b8: aa1b03e0    	mov	x0, x27
1055133bc: 949c4f66    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1055133c0: aa1c03e0    	mov	x0, x28
1055133c4: 949c4f64    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1055133c8: aa1603e0    	mov	x0, x22
1055133cc: 949c4f62    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1055133d0: aa1a03e0    	mov	x0, x26
1055133d4: a9567bfd    	ldp	x29, x30, [sp, #0x160]
1055133d8: a9554ff4    	ldp	x20, x19, [sp, #0x150]
1055133dc: a95457f6    	ldp	x22, x21, [sp, #0x140]
1055133e0: a9535ff8    	ldp	x24, x23, [sp, #0x130]
1055133e4: a95267fa    	ldp	x26, x25, [sp, #0x120]
1055133e8: a9516ffc    	ldp	x28, x27, [sp, #0x110]
1055133ec: 6d5023e9    	ldp	d9, d8, [sp, #0x100]
1055133f0: 6d4f2beb    	ldp	d11, d10, [sp, #0xf0]
1055133f4: 9105c3ff    	add	sp, sp, #0x170
1055133f8: 149c4f57    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
