
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106120688: d102c3ff    	sub	sp, sp, #0xb0
10612068c: a9056ffc    	stp	x28, x27, [sp, #0x50]
106120690: a90667fa    	stp	x26, x25, [sp, #0x60]
106120694: a9075ff8    	stp	x24, x23, [sp, #0x70]
106120698: a90857f6    	stp	x22, x21, [sp, #0x80]
10612069c: a9094ff4    	stp	x20, x19, [sp, #0x90]
1061206a0: a90a7bfd    	stp	x29, x30, [sp, #0xa0]
1061206a4: 910283fd    	add	x29, sp, #0xa0
1061206a8: aa0403f7    	mov	x23, x4
1061206ac: aa0303fb    	mov	x27, x3
1061206b0: aa0203f3    	mov	x19, x2
1061206b4: aa0003f5    	mov	x21, x0
1061206b8: f00d5908    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
1061206bc: 52800029    	mov	w9, #0x1                ; =1
1061206c0: 39176d09    	strb	w9, [x8, #0x5db]
1061206c4: aa0203e0    	mov	x0, x2
1061206c8: 946c1a9c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1061206cc: f00cff48    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1061206d0: f946dd16    	ldr	x22, [x8, #0xdb8] ; selector=viewController
1061206d4: aa1503e0    	mov	x0, x21
1061206d8: aa1603e1    	mov	x1, x22
1061206dc: 946c1a98    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1061206e0: aa1d03fd    	mov	x29, x29
1061206e4: 946c1a99    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1061206e8: aa0003f8    	mov	x24, x0
1061206ec: f100001f    	cmp	x0, #0x0
1061206f0: 1a9f17f4    	cset	w20, eq
1061206f4: 946c1a98    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1061206f8: b4000638    	cbz	x24, 0x1061207bc <_Flutter_MMFoundation_BindContext+0x25fc3a0>
1061206fc: b9004ff4    	str	w20, [sp, #0x4c]
106120700: 52800040    	mov	w0, #0x2                ; =2
106120704: 946bb2cf    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
106120708: f00d0294    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
10612070c: 360010e0    	tbz	w0, #0x0, 0x106120928 <_Flutter_MMFoundation_BindContext+0x25fc50c>
106120710: 946c1aa4    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
106120714: aa0003f8    	mov	x24, x0
106120718: f9454680    	ldr	x0, [x20, #0xa88]
10612071c: 946c1a91    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106120720: aa0003f9    	mov	x25, x0
106120724: f9454680    	ldr	x0, [x20, #0xa88]
106120728: d00cff48    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10612072c: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
106120730: a9007ff3    	stp	x19, xzr, [sp]
106120734: 900c3a82    	adrp	x2, 0x11e870000 <dyld_stub_binder+0x11e870000>
106120738: 911d2042    	add	x2, x2, #0x748 ; cfstring='Just support only one invitation! (%@)'
10612073c: f90023e1    	str	x1, [sp, #0x40]
106120740: 946c1a7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120744: aa1d03fd    	mov	x29, x29
106120748: 946c1a80    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10612074c: aa0003fa    	mov	x26, x0
106120750: d00cff08    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106120754: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
106120758: f00c1bc8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10612075c: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
106120760: a90003e8    	stp	x8, x0, [sp]
106120764: f00c1bc2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106120768: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10612076c: aa1903e0    	mov	x0, x25
106120770: 946c1a73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120774: aa0003f9    	mov	x25, x0
106120778: aa1a03e0    	mov	x0, x26
10612077c: 946c1a76    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120780: b00a87a1    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
106120784: 9124e421    	add	x1, x1, #0x939 ; cstring='VoIP'
106120788: f00ac342    	adrp	x2, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10612078c: 91103c42    	add	x2, x2, #0x40f ; cstring='VoIPInvitationService.mm'
106120790: f00ac344    	adrp	x4, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
106120794: 9111b884    	add	x4, x4, #0x46e ; cstring='-[VoIPInvitationService handleInvitationInfo:withTalkingRoomID:talkingRoomKey:]'
106120798: 52800040    	mov	w0, #0x2                ; =2
10612079c: 528008a3    	mov	w3, #0x45               ; =69
1061207a0: aa1903e5    	mov	x5, x25
1061207a4: 946bb2a8    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
1061207a8: aa1903e0    	mov	x0, x25
1061207ac: 946c1a6a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1061207b0: aa1803e0    	mov	x0, x24
1061207b4: 946c1a7e    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
1061207b8: 1400005f    	b	0x106120934 <_Flutter_MMFoundation_BindContext+0x25fc518>
1061207bc: b4001793    	cbz	x19, 0x106120aac <_Flutter_MMFoundation_BindContext+0x25fc690>
1061207c0: b9004ff4    	str	w20, [sp, #0x4c]
1061207c4: f00d0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1061207c8: f945e900    	ldr	x0, [x8, #0xbd0] ; class=MMContext
1061207cc: 900cff08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1061207d0: f944e901    	ldr	x1, [x8, #0x9d0] ; selector=currentContext
1061207d4: f9001fe1    	str	x1, [sp, #0x38]
1061207d8: 946c1a59    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1061207dc: aa1d03fd    	mov	x29, x29
1061207e0: 946c1a5a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1061207e4: aa0003f4    	mov	x20, x0
1061207e8: f00d0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1061207ec: f9468100    	ldr	x0, [x8, #0xd00] ; class=MultiTalkMgr
1061207f0: f00cfee8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1061207f4: f947ad19    	ldr	x25, [x8, #0xf58] ; selector=class
1061207f8: aa1903e1    	mov	x1, x25
1061207fc: 946c1a50    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120800: aa0003e2    	mov	x2, x0
106120804: b00ce8c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106120808: f9464101    	ldr	x1, [x8, #0xc80] ; selector=getService:
10612080c: aa1403e0    	mov	x0, x20
106120810: f9001be1    	str	x1, [sp, #0x30]
106120814: 946c1a4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120818: aa1d03fd    	mov	x29, x29
10612081c: 946c1a4b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120820: aa0003f8    	mov	x24, x0
106120824: d00ce8c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
106120828: f940cd01    	ldr	x1, [x8, #0x198] ; selector=isMultiTalkConnected
10612082c: 946c1a44    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120830: aa0003fa    	mov	x26, x0
106120834: aa1803e0    	mov	x0, x24
106120838: 946c1a47    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10612083c: aa1403e0    	mov	x0, x20
106120840: 946c1a45    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120844: b00d03c8    	adrp	x8, 0x120199000 <dyld_stub_binder+0x120199000>
106120848: f9409d00    	ldr	x0, [x8, #0x138] ; class=VoIPInvitationViewController
10612084c: 946c1a45    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106120850: f00cf568    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
106120854: f945b501    	ldr	x1, [x8, #0xb68] ; selector=initWithInfo:talkingRoomID:talkingRoomKey:isMultiTalking:
106120858: aa1303e2    	mov	x2, x19
10612085c: aa1b03e3    	mov	x3, x27
106120860: aa1703e4    	mov	x4, x23
106120864: aa1a03e5    	mov	x5, x26
106120868: 946c1a35    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10612086c: aa0003f4    	mov	x20, x0
106120870: d00cff48    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106120874: f9412d01    	ldr	x1, [x8, #0x258] ; selector=setViewController:
106120878: aa1503e0    	mov	x0, x21
10612087c: aa1403e2    	mov	x2, x20
106120880: 946c1a2f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120884: aa1403e0    	mov	x0, x20
106120888: 946c1a33    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10612088c: aa1503e0    	mov	x0, x21
106120890: aa1603e1    	mov	x1, x22
106120894: 946c1a2a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120898: aa1d03fd    	mov	x29, x29
10612089c: 946c1a2b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1061208a0: aa0003f4    	mov	x20, x0
1061208a4: f00cff28    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
1061208a8: f9451501    	ldr	x1, [x8, #0xa28] ; selector=setDelegate:
1061208ac: aa1503e2    	mov	x2, x21
1061208b0: 946c1a23    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1061208b4: aa1403e0    	mov	x0, x20
1061208b8: 946c1a27    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1061208bc: d00cf548    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
1061208c0: f9426d17    	ldr	x23, [x8, #0x4d8] ; selector=monoMsg
1061208c4: aa1303e0    	mov	x0, x19
1061208c8: aa1703e1    	mov	x1, x23
1061208cc: 946c1a1c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1061208d0: aa1d03fd    	mov	x29, x29
1061208d4: 946c1a1d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1061208d8: aa0003f8    	mov	x24, x0
1061208dc: d00d02c8    	adrp	x8, 0x12017a000 <dyld_stub_binder+0x12017a000>
1061208e0: f941e500    	ldr	x0, [x8, #0x3c8] ; class=VoipMonoMsg
1061208e4: aa1903e1    	mov	x1, x25
1061208e8: 946c1a15    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1061208ec: aa0003e2    	mov	x2, x0
1061208f0: f00cff08    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1061208f4: f9442d1c    	ldr	x28, [x8, #0x858] ; selector=isKindOfClass:
1061208f8: aa1803e0    	mov	x0, x24
1061208fc: aa1c03e1    	mov	x1, x28
106120900: 946c1a0f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120904: f90023f3    	str	x19, [sp, #0x40]
106120908: 34000d60    	cbz	w0, 0x106120ab4 <_Flutter_MMFoundation_BindContext+0x25fc698>
10612090c: aa1303e0    	mov	x0, x19
106120910: aa1703e1    	mov	x1, x23
106120914: 946c1a0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120918: aa1d03fd    	mov	x29, x29
10612091c: 946c1a0b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120920: aa0003fb    	mov	x27, x0
106120924: 14000065    	b	0x106120ab8 <_Flutter_MMFoundation_BindContext+0x25fc69c>
106120928: d00cff48    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10612092c: f946a508    	ldr	x8, [x8, #0xd48] ; selector=stringWithFormat:
106120930: f90023e8    	str	x8, [sp, #0x40]
106120934: aa1303f7    	mov	x23, x19
106120938: f9454699    	ldr	x25, [x20, #0xa88]
10612093c: f00d0293    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
106120940: f9458a7a    	ldr	x26, [x19, #0xb10]
106120944: aa1503e0    	mov	x0, x21
106120948: aa1603e1    	mov	x1, x22
10612094c: 946c19fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120950: aa1d03fd    	mov	x29, x29
106120954: 946c19fd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120958: aa0003f8    	mov	x24, x0
10612095c: f00cf568    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
106120960: f945ad01    	ldr	x1, [x8, #0xb58] ; selector=talkingRoomID
106120964: 946c19f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120968: aa0003e2    	mov	x2, x0
10612096c: 900cff28    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
106120970: f947c91b    	ldr	x27, [x8, #0xf90] ; selector=numberWithUnsignedLongLong:
106120974: aa1a03e0    	mov	x0, x26
106120978: aa1b03e1    	mov	x1, x27
10612097c: 946c19f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120980: aa1d03fd    	mov	x29, x29
106120984: 946c19f1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120988: aa0003fa    	mov	x26, x0
10612098c: f9458a7c    	ldr	x28, [x19, #0xb10]
106120990: aa1503e0    	mov	x0, x21
106120994: aa1603e1    	mov	x1, x22
106120998: 946c19e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10612099c: aa1d03fd    	mov	x29, x29
1061209a0: 946c19ea    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1061209a4: aa0003f5    	mov	x21, x0
1061209a8: f00cf568    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
1061209ac: f945b101    	ldr	x1, [x8, #0xb60] ; selector=talkingRoomKey
1061209b0: 946c19e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1061209b4: aa0003e2    	mov	x2, x0
1061209b8: 900cff28    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1061209bc: f947b116    	ldr	x22, [x8, #0xf60] ; selector=numberWithLongLong:
1061209c0: aa1c03e0    	mov	x0, x28
1061209c4: aa1603e1    	mov	x1, x22
1061209c8: 946c19dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1061209cc: aa1d03fd    	mov	x29, x29
1061209d0: 946c19de    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1061209d4: aa0003fc    	mov	x28, x0
1061209d8: f9458a74    	ldr	x20, [x19, #0xb10]
1061209dc: d00ce8c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1061209e0: f9406101    	ldr	x1, [x8, #0xc0] ; selector=roomID
1061209e4: aa1703e0    	mov	x0, x23
1061209e8: 946c19d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1061209ec: aa0003e2    	mov	x2, x0
1061209f0: aa1403e0    	mov	x0, x20
1061209f4: aa1b03e1    	mov	x1, x27
1061209f8: 946c19d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1061209fc: aa1d03fd    	mov	x29, x29
106120a00: 946c19d2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120a04: aa0003f4    	mov	x20, x0
106120a08: f9458a7b    	ldr	x27, [x19, #0xb10]
106120a0c: d00ce8c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
106120a10: f9406501    	ldr	x1, [x8, #0xc8] ; selector=roomKey
106120a14: aa1703e0    	mov	x0, x23
106120a18: 946c19c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120a1c: aa0003e2    	mov	x2, x0
106120a20: aa1b03e0    	mov	x0, x27
106120a24: aa1603e1    	mov	x1, x22
106120a28: 946c19c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120a2c: aa1d03fd    	mov	x29, x29
106120a30: 946c19c6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120a34: aa0003f6    	mov	x22, x0
106120a38: a90103f4    	stp	x20, x0, [sp, #0x10]
106120a3c: a90073fa    	stp	x26, x28, [sp]
106120a40: 900c3a82    	adrp	x2, 0x11e870000 <dyld_stub_binder+0x11e870000>
106120a44: 911da042    	add	x2, x2, #0x768 ; cfstring='%@,%@,%@,%@,9'
106120a48: aa1903e0    	mov	x0, x25
106120a4c: f94023e1    	ldr	x1, [sp, #0x40]
106120a50: 946c19bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120a54: aa1d03fd    	mov	x29, x29
106120a58: 946c19bc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120a5c: aa0003fb    	mov	x27, x0
106120a60: aa1603e0    	mov	x0, x22
106120a64: 946c19bc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120a68: aa1403e0    	mov	x0, x20
106120a6c: 946c19ba    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120a70: aa1c03e0    	mov	x0, x28
106120a74: 946c19b8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120a78: aa1503e0    	mov	x0, x21
106120a7c: 946c19b6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120a80: aa1a03e0    	mov	x0, x26
106120a84: 946c19b4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120a88: aa1803e0    	mov	x0, x24
106120a8c: 946c19b2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120a90: 528d8ea0    	mov	w0, #0x6c75             ; =27765
106120a94: aa1b03e1    	mov	x1, x27
106120a98: 52800002    	mov	w2, #0x0                ; =0
106120a9c: 52800003    	mov	w3, #0x0                ; =0
106120aa0: 97053090    	bl	0x10226cce0 <_Flutter_Image_provideRelativePathByUrl+0x679b90>
106120aa4: aa1703f3    	mov	x19, x23
106120aa8: 1400013d    	b	0x106120f9c <_Flutter_MMFoundation_BindContext+0x25fcb80>
106120aac: 52800014    	mov	w20, #0x0               ; =0
106120ab0: 1400013e    	b	0x106120fa8 <_Flutter_MMFoundation_BindContext+0x25fcb8c>
106120ab4: d280001b    	mov	x27, #0x0               ; =0
106120ab8: aa1803e0    	mov	x0, x24
106120abc: 946c19a6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120ac0: b00cf3a8    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
106120ac4: f9406501    	ldr	x1, [x8, #0xc8] ; selector=m_muteNotification
106120ac8: aa1b03e0    	mov	x0, x27
106120acc: 946c199c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120ad0: 340005c0    	cbz	w0, 0x106120b88 <_Flutter_MMFoundation_BindContext+0x25fc76c>
106120ad4: f00d0393    	adrp	x19, 0x120193000 <dyld_stub_binder+0x120193000>
106120ad8: f9461660    	ldr	x0, [x19, #0xc28] ; class=VoIPConfigUtils
106120adc: d00cf388    	adrp	x8, 0x11ff92000 <dyld_stub_binder+0x11ff92000>
106120ae0: f9432d01    	ldr	x1, [x8, #0x658] ; selector=isCallCardSupportIgnore
106120ae4: 946c1996    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120ae8: 34000500    	cbz	w0, 0x106120b88 <_Flutter_MMFoundation_BindContext+0x25fc76c>
106120aec: f9461660    	ldr	x0, [x19, #0xc28] ; class=VoIPConfigUtils
106120af0: d00cf388    	adrp	x8, 0x11ff92000 <dyld_stub_binder+0x11ff92000>
106120af4: f9435d01    	ldr	x1, [x8, #0x6b8] ; selector=isCallFullScreenSupportIgnore
106120af8: 946c1991    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120afc: 34000460    	cbz	w0, 0x106120b88 <_Flutter_MMFoundation_BindContext+0x25fc76c>
106120b00: aa1503e0    	mov	x0, x21
106120b04: aa1603e1    	mov	x1, x22
106120b08: 946c198d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120b0c: aa1d03fd    	mov	x29, x29
106120b10: 946c198e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120b14: aa0003f4    	mov	x20, x0
106120b18: f00cf388    	adrp	x8, 0x11ff93000 <dyld_stub_binder+0x11ff93000>
106120b1c: f9433d01    	ldr	x1, [x8, #0x678] ; selector=setFromIgnore:
106120b20: 52800022    	mov	w2, #0x1                ; =1
106120b24: 946c1986    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120b28: aa1403e0    	mov	x0, x20
106120b2c: 946c198a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120b30: aa1503e0    	mov	x0, x21
106120b34: aa1603e1    	mov	x1, x22
106120b38: 946c1981    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120b3c: aa1d03fd    	mov	x29, x29
106120b40: 946c1982    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120b44: aa0003f4    	mov	x20, x0
106120b48: f00cf568    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
106120b4c: f945b901    	ldr	x1, [x8, #0xb70] ; selector=showInWindow
106120b50: 946c197b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120b54: aa1403e0    	mov	x0, x20
106120b58: 946c197f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120b5c: aa1503e0    	mov	x0, x21
106120b60: aa1603e1    	mov	x1, x22
106120b64: 946c1976    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120b68: aa1d03fd    	mov	x29, x29
106120b6c: 946c1977    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120b70: aa0003f8    	mov	x24, x0
106120b74: f00cf568    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
106120b78: f945bd01    	ldr	x1, [x8, #0xb78] ; selector=enterFloatWindowDirectly
106120b7c: 946c1970    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120b80: f94023f3    	ldr	x19, [sp, #0x40]
106120b84: 14000054    	b	0x106120cd4 <_Flutter_MMFoundation_BindContext+0x25fc8b8>
106120b88: aa1503e0    	mov	x0, x21
106120b8c: aa1603e1    	mov	x1, x22
106120b90: 946c196b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120b94: aa1d03fd    	mov	x29, x29
106120b98: 946c196c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120b9c: aa0003f4    	mov	x20, x0
106120ba0: f00cf568    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
106120ba4: f945b901    	ldr	x1, [x8, #0xb70] ; selector=showInWindow
106120ba8: 946c1965    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120bac: aa1403e0    	mov	x0, x20
106120bb0: 946c1969    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120bb4: aa1503e0    	mov	x0, x21
106120bb8: aa1603e1    	mov	x1, x22
106120bbc: 946c1960    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120bc0: aa1d03fd    	mov	x29, x29
106120bc4: 946c1961    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120bc8: aa0003f4    	mov	x20, x0
106120bcc: b00cf3a8    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
106120bd0: f941b101    	ldr	x1, [x8, #0x360] ; selector=scrollIn
106120bd4: 946c195a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120bd8: aa1403e0    	mov	x0, x20
106120bdc: 946c195e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120be0: f00d0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106120be4: f9468d00    	ldr	x0, [x8, #0xd18] ; class=DeviceInfo
106120be8: f00cff08    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106120bec: f9457d01    	ldr	x1, [x8, #0xaf8] ; selector=isiPad
106120bf0: 946c1953    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120bf4: aa0003f4    	mov	x20, x0
106120bf8: f00d0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106120bfc: f9471100    	ldr	x0, [x8, #0xe20] ; class=SettingUtil
106120c00: d00ce8c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
106120c04: f946f101    	ldr	x1, [x8, #0xde0] ; selector=getMainSetting
106120c08: 946c194d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120c0c: aa1d03fd    	mov	x29, x29
106120c10: 946c194e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120c14: aa0003fa    	mov	x26, x0
106120c18: 900ce8e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106120c1c: f942d501    	ldr	x1, [x8, #0x5a8] ; selector=m_uiExtStatus
106120c20: 946c1947    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120c24: aa0003f8    	mov	x24, x0
106120c28: aa1a03e0    	mov	x0, x26
106120c2c: 946c194a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120c30: 34000094    	cbz	w20, 0x106120c40 <_Flutter_MMFoundation_BindContext+0x25fc824>
106120c34: f94023f3    	ldr	x19, [sp, #0x40]
106120c38: 36680098    	tbz	w24, #0xd, 0x106120c48 <_Flutter_MMFoundation_BindContext+0x25fc82c>
106120c3c: 14000028    	b	0x106120cdc <_Flutter_MMFoundation_BindContext+0x25fc8c0>
106120c40: f94023f3    	ldr	x19, [sp, #0x40]
106120c44: 376004d8    	tbnz	w24, #0xc, 0x106120cdc <_Flutter_MMFoundation_BindContext+0x25fc8c0>
106120c48: f00d0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106120c4c: f945e900    	ldr	x0, [x8, #0xbd0] ; class=MMContext
106120c50: f9401fe1    	ldr	x1, [sp, #0x38]
106120c54: 946c193a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120c58: aa1d03fd    	mov	x29, x29
106120c5c: 946c193b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120c60: aa0003f8    	mov	x24, x0
106120c64: f00d0368    	adrp	x8, 0x12018f000 <dyld_stub_binder+0x12018f000>
106120c68: f9473900    	ldr	x0, [x8, #0xe70] ; class=MonoServiceMsgMgr
106120c6c: aa1903e1    	mov	x1, x25
106120c70: 946c1933    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120c74: aa0003e2    	mov	x2, x0
106120c78: aa1803e0    	mov	x0, x24
106120c7c: f9401be1    	ldr	x1, [sp, #0x30]
106120c80: 946c192f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120c84: aa1d03fd    	mov	x29, x29
106120c88: 946c1930    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120c8c: aa0003f4    	mov	x20, x0
106120c90: aa1303e0    	mov	x0, x19
106120c94: aa1703e1    	mov	x1, x23
106120c98: 946c1929    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120c9c: aa1d03fd    	mov	x29, x29
106120ca0: 946c192a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120ca4: aa0003fa    	mov	x26, x0
106120ca8: 900cf368    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
106120cac: f944c501    	ldr	x1, [x8, #0x988] ; selector=showLocalNotificationWithMsg:repeatVibration:silently:
106120cb0: aa1403e0    	mov	x0, x20
106120cb4: aa1a03e2    	mov	x2, x26
106120cb8: 52800003    	mov	w3, #0x0                ; =0
106120cbc: 52800024    	mov	w4, #0x1                ; =1
106120cc0: 946c191f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120cc4: aa1a03e0    	mov	x0, x26
106120cc8: 946c1923    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120ccc: aa1403e0    	mov	x0, x20
106120cd0: 946c1921    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120cd4: aa1803e0    	mov	x0, x24
106120cd8: 946c191f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120cdc: aa1303e0    	mov	x0, x19
106120ce0: aa1703e1    	mov	x1, x23
106120ce4: 946c1916    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120ce8: aa1d03fd    	mov	x29, x29
106120cec: 946c1917    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120cf0: aa0003f7    	mov	x23, x0
106120cf4: d00d02c8    	adrp	x8, 0x12017a000 <dyld_stub_binder+0x12017a000>
106120cf8: f941e500    	ldr	x0, [x8, #0x3c8] ; class=VoipMonoMsg
106120cfc: aa1903e1    	mov	x1, x25
106120d00: 946c190f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120d04: aa0003e2    	mov	x2, x0
106120d08: aa1703e0    	mov	x0, x23
106120d0c: aa1c03e1    	mov	x1, x28
106120d10: 946c190b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120d14: 34000e40    	cbz	w0, 0x106120edc <_Flutter_MMFoundation_BindContext+0x25fcac0>
106120d18: f00d0298    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
106120d1c: f945eb00    	ldr	x0, [x24, #0xbd0] ; class=MMContext
106120d20: f9401ff4    	ldr	x20, [sp, #0x38]
106120d24: aa1403e1    	mov	x1, x20
106120d28: 946c1905    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120d2c: aa1d03fd    	mov	x29, x29
106120d30: 946c1906    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120d34: aa0003fa    	mov	x26, x0
106120d38: f90017e0    	str	x0, [sp, #0x28]
106120d3c: f00d0388    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
106120d40: f9463500    	ldr	x0, [x8, #0xc68] ; class=_TtC6WeChat14CarPlayVoIPMgr
106120d44: aa1903e1    	mov	x1, x25
106120d48: 946c18fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120d4c: aa0003e2    	mov	x2, x0
106120d50: aa1a03e0    	mov	x0, x26
106120d54: f9401bfc    	ldr	x28, [sp, #0x30]
106120d58: aa1c03e1    	mov	x1, x28
106120d5c: 946c18f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120d60: aa1d03fd    	mov	x29, x29
106120d64: 946c18f9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120d68: aa0003fa    	mov	x26, x0
106120d6c: f945eb00    	ldr	x0, [x24, #0xbd0] ; class=MMContext
106120d70: aa1403e1    	mov	x1, x20
106120d74: 946c18f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120d78: aa1d03fd    	mov	x29, x29
106120d7c: 946c18f3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120d80: aa0003f4    	mov	x20, x0
106120d84: f9001fe0    	str	x0, [sp, #0x38]
106120d88: 900d02a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106120d8c: f9401500    	ldr	x0, [x8, #0x28] ; class=CContactMgr
106120d90: aa1903e1    	mov	x1, x25
106120d94: 946c18ea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120d98: aa0003e2    	mov	x2, x0
106120d9c: aa1403e0    	mov	x0, x20
106120da0: aa1c03e1    	mov	x1, x28
106120da4: 946c18e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120da8: aa1d03fd    	mov	x29, x29
106120dac: 946c18e7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120db0: aa0003f4    	mov	x20, x0
106120db4: 900cf368    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
106120db8: f9450901    	ldr	x1, [x8, #0xa10] ; selector=m_fromUser
106120dbc: aa1703e0    	mov	x0, x23
106120dc0: 946c18df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120dc4: aa1d03fd    	mov	x29, x29
106120dc8: 946c18e0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120dcc: aa0003fc    	mov	x28, x0
106120dd0: 900ce8e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106120dd4: f940c901    	ldr	x1, [x8, #0x190] ; selector=getContactByName:
106120dd8: aa1403e0    	mov	x0, x20
106120ddc: aa1c03e2    	mov	x2, x28
106120de0: 946c18d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120de4: aa1d03fd    	mov	x29, x29
106120de8: 946c18d8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120dec: aa0003f8    	mov	x24, x0
106120df0: 900cf368    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
106120df4: f944c901    	ldr	x1, [x8, #0x990] ; selector=m_mode
106120df8: aa1703e0    	mov	x0, x23
106120dfc: 946c18d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120e00: 7100001f    	cmp	w0, #0x0
106120e04: 1a9f17e4    	cset	w4, eq
106120e08: f00cf568    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
106120e0c: f945c101    	ldr	x1, [x8, #0xb80] ; selector=openExtraRecieveControllerWithContact:toast:isVideo:
106120e10: f00c1bc3    	adrp	x3, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106120e14: 91032063    	add	x3, x3, #0xc8 ; cfstring=''
106120e18: aa1a03e0    	mov	x0, x26
106120e1c: aa1803e2    	mov	x2, x24
106120e20: 946c18c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120e24: aa1d03fd    	mov	x29, x29
106120e28: 946c18c8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120e2c: aa0003f9    	mov	x25, x0
106120e30: aa1803e0    	mov	x0, x24
106120e34: 946c18c8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120e38: aa1c03e0    	mov	x0, x28
106120e3c: 946c18c6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120e40: aa1403e0    	mov	x0, x20
106120e44: 946c18c4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120e48: f9401fe0    	ldr	x0, [sp, #0x38]
106120e4c: 946c18c2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120e50: aa1a03e0    	mov	x0, x26
106120e54: 946c18c0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120e58: f94017e0    	ldr	x0, [sp, #0x28]
106120e5c: 946c18be    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120e60: b40003b9    	cbz	x25, 0x106120ed4 <_Flutter_MMFoundation_BindContext+0x25fcab8>
106120e64: 900cf368    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
106120e68: f9450d01    	ldr	x1, [x8, #0xa18] ; selector=m_roomId
106120e6c: aa1703e0    	mov	x0, x23
106120e70: 946c18b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120e74: aa0003f4    	mov	x20, x0
106120e78: 900cf368    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
106120e7c: f9451101    	ldr	x1, [x8, #0xa20] ; selector=m_roomKey
106120e80: aa1703e0    	mov	x0, x23
106120e84: 946c18ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120e88: aa0003e3    	mov	x3, x0
106120e8c: d00cf548    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
106120e90: f945f501    	ldr	x1, [x8, #0xbe8] ; selector=setRoomInfoWithRoomID:roomKey:
106120e94: aa1903e0    	mov	x0, x25
106120e98: aa1403e2    	mov	x2, x20
106120e9c: 946c18a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120ea0: aa1503e0    	mov	x0, x21
106120ea4: aa1603e1    	mov	x1, x22
106120ea8: 946c18a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120eac: aa1d03fd    	mov	x29, x29
106120eb0: 946c18a6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120eb4: aa0003f4    	mov	x20, x0
106120eb8: f00cf568    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
106120ebc: f945c501    	ldr	x1, [x8, #0xb88] ; selector=safeSetDelegateWithDelegate:
106120ec0: aa1903e0    	mov	x0, x25
106120ec4: aa1403e2    	mov	x2, x20
106120ec8: 946c189d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120ecc: aa1403e0    	mov	x0, x20
106120ed0: 946c18a1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120ed4: aa1903e0    	mov	x0, x25
106120ed8: 946c189f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120edc: 52800040    	mov	w0, #0x2                ; =2
106120ee0: 946bb0d8    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
106120ee4: 34000580    	cbz	w0, 0x106120f94 <_Flutter_MMFoundation_BindContext+0x25fcb78>
106120ee8: 946c18ae    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
106120eec: aa0003f5    	mov	x21, x0
106120ef0: f00d0293    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
106120ef4: f9454660    	ldr	x0, [x19, #0xa88]
106120ef8: 946c189a    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106120efc: aa0003f4    	mov	x20, x0
106120f00: f9454660    	ldr	x0, [x19, #0xa88]
106120f04: f94023f3    	ldr	x19, [sp, #0x40]
106120f08: d00cff48    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106120f0c: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
106120f10: a9007ff3    	stp	x19, xzr, [sp]
106120f14: 900c3a82    	adrp	x2, 0x11e870000 <dyld_stub_binder+0x11e870000>
106120f18: 911e2042    	add	x2, x2, #0x788 ; cfstring='Service handle invite info! (%@)'
106120f1c: 946c1888    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120f20: aa1d03fd    	mov	x29, x29
106120f24: 946c1889    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106120f28: aa0003f6    	mov	x22, x0
106120f2c: d00cff08    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106120f30: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
106120f34: f00c1bc8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106120f38: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
106120f3c: a90003e8    	stp	x8, x0, [sp]
106120f40: f00c1bc2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106120f44: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
106120f48: aa1403e0    	mov	x0, x20
106120f4c: 946c187c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106120f50: aa0003f4    	mov	x20, x0
106120f54: aa1603e0    	mov	x0, x22
106120f58: 946c187f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120f5c: b00a87a1    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
106120f60: 9124e421    	add	x1, x1, #0x939 ; cstring='VoIP'
106120f64: f00ac342    	adrp	x2, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
106120f68: 91103c42    	add	x2, x2, #0x40f ; cstring='VoIPInvitationService.mm'
106120f6c: f00ac344    	adrp	x4, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
106120f70: 9111b884    	add	x4, x4, #0x46e ; cstring='-[VoIPInvitationService handleInvitationInfo:withTalkingRoomID:talkingRoomKey:]'
106120f74: 52800040    	mov	w0, #0x2                ; =2
106120f78: 52801243    	mov	w3, #0x92               ; =146
106120f7c: aa1403e5    	mov	x5, x20
106120f80: 946bb0b1    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106120f84: aa1403e0    	mov	x0, x20
106120f88: 946c1873    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120f8c: aa1503e0    	mov	x0, x21
106120f90: 946c1887    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
106120f94: aa1703e0    	mov	x0, x23
106120f98: 946c186f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120f9c: aa1b03e0    	mov	x0, x27
106120fa0: 946c186d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120fa4: b9404ff4    	ldr	w20, [sp, #0x4c]
106120fa8: aa1303e0    	mov	x0, x19
106120fac: 946c186a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106120fb0: aa1403e0    	mov	x0, x20
106120fb4: a94a7bfd    	ldp	x29, x30, [sp, #0xa0]
106120fb8: a9494ff4    	ldp	x20, x19, [sp, #0x90]
106120fbc: a94857f6    	ldp	x22, x21, [sp, #0x80]
106120fc0: a9475ff8    	ldp	x24, x23, [sp, #0x70]
106120fc4: a94667fa    	ldp	x26, x25, [sp, #0x60]
106120fc8: a9456ffc    	ldp	x28, x27, [sp, #0x50]
106120fcc: 9102c3ff    	add	sp, sp, #0xb0
106120fd0: d65f03c0    	ret
