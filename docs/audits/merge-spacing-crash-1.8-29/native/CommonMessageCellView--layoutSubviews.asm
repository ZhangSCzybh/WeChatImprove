
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f537b4: d10143ff    	sub	sp, sp, #0x50
100f537b8: a9015ff8    	stp	x24, x23, [sp, #0x10]
100f537bc: a90257f6    	stp	x22, x21, [sp, #0x20]
100f537c0: a9034ff4    	stp	x20, x19, [sp, #0x30]
100f537c4: a9047bfd    	stp	x29, x30, [sp, #0x40]
100f537c8: 910103fd    	add	x29, sp, #0x40
100f537cc: aa0003f3    	mov	x19, x0
100f537d0: b00fe6e8    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100f537d4: 52800029    	mov	w9, #0x1                ; =1
100f537d8: 39283509    	strb	w9, [x8, #0xa0d]
100f537dc: f00f9328    	adrp	x8, 0x1201ba000 <dyld_stub_binder+0x1201ba000>
100f537e0: f9427908    	ldr	x8, [x8, #0x4f0] ; �%, 
100f537e4: a90023e0    	stp	x0, x8, [sp]
100f537e8: f00f7748    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
100f537ec: f940a901    	ldr	x1, [x8, #0x150] ; layoutSubviews
100f537f0: 910003e0    	mov	x0, sp
100f537f4: 95b34e54    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
100f537f8: f00f7748    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
100f537fc: f9410914    	ldr	x20, [x8, #0x210] ; viewModel
100f53800: aa1303e0    	mov	x0, x19
100f53804: aa1403e1    	mov	x1, x20
100f53808: 95b34e4d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5380c: aa1d03fd    	mov	x29, x29
100f53810: 95b34e4e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f53814: aa0003f5    	mov	x21, x0
100f53818: d00f7948    	adrp	x8, 0x11fe7d000 <dyld_stub_binder+0x11fe7d000>
100f5381c: f940dd01    	ldr	x1, [x8, #0x1b8] ; isShowChatRoomDisplayName
100f53820: 95b34e47    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f53824: 36000580    	tbz	w0, #0x0, 0x100f538d4 <__text+0xf4b8d4>
100f53828: aa1303e0    	mov	x0, x19
100f5382c: aa1403e1    	mov	x1, x20
100f53830: 95b34e43    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f53834: aa1d03fd    	mov	x29, x29
100f53838: 95b34e44    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f5383c: aa0003f6    	mov	x22, x0
100f53840: 900f77e8    	adrp	x8, 0x11fe4f000 <dyld_stub_binder+0x11fe4f000>
100f53844: f9459d01    	ldr	x1, [x8, #0xb38] ; isHeadPart
100f53848: 95b34e3d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5384c: aa0003f7    	mov	x23, x0
100f53850: aa1603e0    	mov	x0, x22
100f53854: 95b34e40    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f53858: aa1503e0    	mov	x0, x21
100f5385c: 95b34e3e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f53860: 340003f7    	cbz	w23, 0x100f538dc <__text+0xf4b8dc>
100f53864: b00f7988    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f53868: f945e501    	ldr	x1, [x8, #0xbc8] ; didChatroomInDarkBkg
100f5386c: aa1303e0    	mov	x0, x19
100f53870: 95b34e33    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f53874: aa0003f5    	mov	x21, x0
100f53878: aa1303e0    	mov	x0, x19
100f5387c: aa1403e1    	mov	x1, x20
100f53880: 95b34e2f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f53884: aa1d03fd    	mov	x29, x29
100f53888: 95b34e30    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f5388c: aa0003f4    	mov	x20, x0
100f53890: f00f77a8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
100f53894: f940c101    	ldr	x1, [x8, #0x180] ; isChatroomInDarkBkg
100f53898: 95b34e29    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5389c: aa0003f6    	mov	x22, x0
100f538a0: aa1403e0    	mov	x0, x20
100f538a4: 95b34e2c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f538a8: 6b1602bf    	cmp	w21, w22
100f538ac: 54000180    	b.eq	0x100f538dc <__text+0xf4b8dc>
100f538b0: b00f7988    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f538b4: f945e901    	ldr	x1, [x8, #0xbd0] ; setChatRoomNameLabelTextColor
100f538b8: aa1303e0    	mov	x0, x19
100f538bc: 95b34e20    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f538c0: b00f7988    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f538c4: f945ed01    	ldr	x1, [x8, #0xbd8] ; setChatRoomTextStateEmojiColor
100f538c8: aa1303e0    	mov	x0, x19
100f538cc: 95b34e1c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f538d0: 14000003    	b	0x100f538dc <__text+0xf4b8dc>
100f538d4: aa1503e0    	mov	x0, x21
100f538d8: 95b34e1f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f538dc: b00f7988    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f538e0: f945d901    	ldr	x1, [x8, #0xbb0] ; refreshPatRevokeTipsView
100f538e4: aa1303e0    	mov	x0, x19
100f538e8: 95b34e15    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f538ec: a9447bfd    	ldp	x29, x30, [sp, #0x40]
100f538f0: a9434ff4    	ldp	x20, x19, [sp, #0x30]
100f538f4: a94257f6    	ldp	x22, x21, [sp, #0x20]
100f538f8: a9415ff8    	ldp	x24, x23, [sp, #0x10]
100f538fc: 910143ff    	add	sp, sp, #0x50
100f53900: d65f03c0    	ret