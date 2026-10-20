
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1057f57d4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1057f57d8: a9014ff4    	stp	x20, x19, [sp, #0x10]
1057f57dc: a9027bfd    	stp	x29, x30, [sp, #0x20]
1057f57e0: 910083fd    	add	x29, sp, #0x20
1057f57e4: aa0303f3    	mov	x19, x3
1057f57e8: aa0003f4    	mov	x20, x0
1057f57ec: 900da268    	adrp	x8, 0x120c41000 <dyld_stub_binder+0x120c41000>
1057f57f0: 52800029    	mov	w9, #0x1                ; =1
1057f57f4: 3913f909    	strb	w9, [x8, #0x4fe]
1057f57f8: aa0303e0    	mov	x0, x3
1057f57fc: 9490c64f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057f5800: d00d3228    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057f5804: f947d101    	ldr	x1, [x8, #0xfa0] ; isChatroom
1057f5808: aa1303e0    	mov	x0, x19
1057f580c: 9490c64c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f5810: 340000c0    	cbz	w0, 0x1057f5828 <_Flutter_MMFoundation_BindContext+0x1cd140c>
1057f5814: d00d51c8    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057f5818: b983e908    	ldrsw	x8, [x8, #0x3e8] ; ivar SessionSelectView.m_bIgnoreChatRoom
1057f581c: 38686a88    	ldrb	w8, [x20, x8]
1057f5820: 52000114    	eor	w20, w8, #0x1
1057f5824: 14000022    	b	0x1057f58ac <_Flutter_MMFoundation_BindContext+0x1cd1490>
1057f5828: d00d51c8    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057f582c: b983ed08    	ldrsw	x8, [x8, #0x3ec] ; ivar SessionSelectView._chatRoomOnly
1057f5830: 38686a88    	ldrb	w8, [x20, x8]
1057f5834: 370003a8    	tbnz	w8, #0x0, 0x1057f58a8 <_Flutter_MMFoundation_BindContext+0x1cd148c>
1057f5838: f00d3228    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1057f583c: f940cd01    	ldr	x1, [x8, #0x198] ; isMMContact
1057f5840: aa1303e0    	mov	x0, x19
1057f5844: 9490c63e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f5848: 34000300    	cbz	w0, 0x1057f58a8 <_Flutter_MMFoundation_BindContext+0x1cd148c>
1057f584c: d00d4be8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057f5850: f9455500    	ldr	x0, [x8, #0xaa8]
1057f5854: d00d4848    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1057f5858: f941bd01    	ldr	x1, [x8, #0x378] ; arrayWithObject:
1057f585c: aa1303e2    	mov	x2, x19
1057f5860: 9490c637    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f5864: aa1d03fd    	mov	x29, x29
1057f5868: 9490c638    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057f586c: aa0003f5    	mov	x21, x0
1057f5870: b00d34a8    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1057f5874: f9427501    	ldr	x1, [x8, #0x4e8] ; FilterSearchResultOfNormalContacts:
1057f5878: aa1403e0    	mov	x0, x20
1057f587c: aa1503e2    	mov	x2, x21
1057f5880: 9490c62f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f5884: f00d4848    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1057f5888: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1057f588c: aa1503e0    	mov	x0, x21
1057f5890: 9490c62b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f5894: f100001f    	cmp	x0, #0x0
1057f5898: 1a9f07f4    	cset	w20, ne
1057f589c: aa1503e0    	mov	x0, x21
1057f58a0: 9490c62d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f58a4: 14000002    	b	0x1057f58ac <_Flutter_MMFoundation_BindContext+0x1cd1490>
1057f58a8: 52800014    	mov	w20, #0x0               ; =0
1057f58ac: aa1303e0    	mov	x0, x19
1057f58b0: 9490c629    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f58b4: 12000280    	and	w0, w20, #0x1
1057f58b8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1057f58bc: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1057f58c0: a8c357f6    	ldp	x22, x21, [sp], #0x30
1057f58c4: d65f03c0    	ret
