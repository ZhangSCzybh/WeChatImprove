
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10551481c: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
105514820: a9015ff8    	stp	x24, x23, [sp, #0x10]
105514824: a90257f6    	stp	x22, x21, [sp, #0x20]
105514828: a9034ff4    	stp	x20, x19, [sp, #0x30]
10551482c: a9047bfd    	stp	x29, x30, [sp, #0x40]
105514830: 910103fd    	add	x29, sp, #0x40
105514834: aa0003f3    	mov	x19, x0
105514838: 900db968    	adrp	x8, 0x120c40000 <dyld_stub_binder+0x120c40000>
10551483c: 52800029    	mov	w9, #0x1                ; =1
105514840: 3928a109    	strb	w9, [x8, #0xa28]
105514844: f00d5fa8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
105514848: f946d501    	ldr	x1, [x8, #0xda8] ; view
10551484c: aa0203e0    	mov	x0, x2
105514850: 949c4a3b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105514854: aa1d03fd    	mov	x29, x29
105514858: 949c4a3c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10551485c: aa0003f4    	mov	x20, x0
105514860: d00d5fa8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105514864: f947c101    	ldr	x1, [x8, #0xf80] ; tag
105514868: 949c4a35    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10551486c: aa0003f5    	mov	x21, x0
105514870: aa1403e0    	mov	x0, x20
105514874: 949c4a38    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105514878: 900d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
10551487c: b9852114    	ldrsw	x20, [x8, #0x520] ; ivar RecentForwardScrollView._iconViews
105514880: f8746a60    	ldr	x0, [x19, x20]
105514884: 900d5f68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105514888: f9435101    	ldr	x1, [x8, #0x6a0] ; count
10551488c: 949c4a2c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105514890: eb0002bf    	cmp	x21, x0
105514894: 54000422    	b.hs	0x105514918 <_Flutter_MMFoundation_BindContext+0x19f04fc>
105514898: f8746a60    	ldr	x0, [x19, x20]
10551489c: d00d4928    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1055148a0: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
1055148a4: aa1503e2    	mov	x2, x21
1055148a8: 949c4a25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055148ac: aa1d03fd    	mov	x29, x29
1055148b0: 949c4a26    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1055148b4: aa0003f6    	mov	x22, x0
1055148b8: f00d4be8    	adrp	x8, 0x11fe93000 <dyld_stub_binder+0x11fe93000>
1055148bc: f9428501    	ldr	x1, [x8, #0x508] ; oContact
1055148c0: 949c4a1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055148c4: aa1d03fd    	mov	x29, x29
1055148c8: 949c4a20    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1055148cc: aa0003f4    	mov	x20, x0
1055148d0: aa1603e0    	mov	x0, x22
1055148d4: 949c4a20    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1055148d8: 900d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
1055148dc: b9851d08    	ldrsw	x8, [x8, #0x51c] ; ivar RecentForwardScrollView.m_bStartNewEditModelIng
1055148e0: 38686a68    	ldrb	w8, [x19, x8]
1055148e4: 7100051f    	cmp	w8, #0x1
1055148e8: 54000241    	b.ne	0x105514930 <_Flutter_MMFoundation_BindContext+0x19f0514>
1055148ec: 900d54a8    	adrp	x8, 0x11ffa8000 <dyld_stub_binder+0x11ffa8000>
1055148f0: f9432501    	ldr	x1, [x8, #0x648] ; reportRemoveRecentFrowradChatsInNewEditModel:
1055148f4: aa1303e0    	mov	x0, x19
1055148f8: aa1403e2    	mov	x2, x20
1055148fc: 949c4a10    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105514900: 900d4b08    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
105514904: f9442101    	ldr	x1, [x8, #0x840] ; deleteContact:
105514908: aa1303e0    	mov	x0, x19
10551490c: aa1403e2    	mov	x2, x20
105514910: 949c4a0b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105514914: 14000034    	b	0x1055149e4 <_Flutter_MMFoundation_BindContext+0x19f05c8>
105514918: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10551491c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
105514920: a94257f6    	ldp	x22, x21, [sp, #0x20]
105514924: a9415ff8    	ldp	x24, x23, [sp, #0x10]
105514928: a8c567fa    	ldp	x26, x25, [sp], #0x50
10551492c: d65f03c0    	ret
105514930: 900d5f68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105514934: f946f116    	ldr	x22, [x8, #0xde0] ; delegate
105514938: aa1303e0    	mov	x0, x19
10551493c: aa1603e1    	mov	x1, x22
105514940: 949c49ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105514944: aa1d03fd    	mov	x29, x29
105514948: 949c4a00    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10551494c: aa0003f8    	mov	x24, x0
105514950: 900d54a8    	adrp	x8, 0x11ffa8000 <dyld_stub_binder+0x11ffa8000>
105514954: f9432917    	ldr	x23, [x8, #0x650] ; clickRFItemCallBack:
105514958: d00d5f88    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10551495c: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
105514960: aa1703e2    	mov	x2, x23
105514964: 949c49f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105514968: aa0003f9    	mov	x25, x0
10551496c: aa1803e0    	mov	x0, x24
105514970: 949c49f9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105514974: 34000399    	cbz	w25, 0x1055149e4 <_Flutter_MMFoundation_BindContext+0x19f05c8>
105514978: aa1303e0    	mov	x0, x19
10551497c: aa1603e1    	mov	x1, x22
105514980: 949c49ef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105514984: aa1d03fd    	mov	x29, x29
105514988: 949c49f0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10551498c: aa0003f6    	mov	x22, x0
105514990: aa1703e1    	mov	x1, x23
105514994: aa1403e2    	mov	x2, x20
105514998: 949c49e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10551499c: aa1603e0    	mov	x0, x22
1055149a0: 949c49ed    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1055149a4: 910006a8    	add	x8, x21, #0x1
1055149a8: 900d68c9    	adrp	x9, 0x12022c000 <dyld_stub_binder+0x12022c000>
1055149ac: b9852529    	ldrsw	x9, [x9, #0x524] ; ivar RecentForwardScrollView.m_toUserIndex
1055149b0: f8296a68    	str	x8, [x19, x9]
1055149b4: f00d4928    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1055149b8: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
1055149bc: aa1403e0    	mov	x0, x20
1055149c0: 949c49df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1055149c4: aa1d03fd    	mov	x29, x29
1055149c8: 949c49e0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1055149cc: 900d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
1055149d0: b9852909    	ldrsw	x9, [x8, #0x528] ; ivar RecentForwardScrollView.m_toUserName
1055149d4: f8696a68    	ldr	x8, [x19, x9]
1055149d8: f8296a60    	str	x0, [x19, x9]
1055149dc: aa0803e0    	mov	x0, x8
1055149e0: 949c49dd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1055149e4: aa1403e0    	mov	x0, x20
1055149e8: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1055149ec: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1055149f0: a94257f6    	ldp	x22, x21, [sp, #0x20]
1055149f4: a9415ff8    	ldp	x24, x23, [sp, #0x10]
1055149f8: a8c567fa    	ldp	x26, x25, [sp], #0x50
1055149fc: 149c49d6    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
