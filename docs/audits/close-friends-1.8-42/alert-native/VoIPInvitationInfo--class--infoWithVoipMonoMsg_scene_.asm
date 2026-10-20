
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10611f8cc: d10243ff    	sub	sp, sp, #0x90
10611f8d0: a9036ffc    	stp	x28, x27, [sp, #0x30]
10611f8d4: a90467fa    	stp	x26, x25, [sp, #0x40]
10611f8d8: a9055ff8    	stp	x24, x23, [sp, #0x50]
10611f8dc: a90657f6    	stp	x22, x21, [sp, #0x60]
10611f8e0: a9074ff4    	stp	x20, x19, [sp, #0x70]
10611f8e4: a9087bfd    	stp	x29, x30, [sp, #0x80]
10611f8e8: 910203fd    	add	x29, sp, #0x80
10611f8ec: aa0303f4    	mov	x20, x3
10611f8f0: aa0203f3    	mov	x19, x2
10611f8f4: aa0003f6    	mov	x22, x0
10611f8f8: 900d5928    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
10611f8fc: 52800029    	mov	w9, #0x1                ; =1
10611f900: 39175d09    	strb	w9, [x8, #0x5d7]
10611f904: aa0203e0    	mov	x0, x2
10611f908: 946c1e0c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10611f90c: f00cf548    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
10611f910: f9426901    	ldr	x1, [x8, #0x4d0] ; selector=isInvite
10611f914: aa1303e0    	mov	x0, x19
10611f918: 946c1e09    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611f91c: 36000dc0    	tbz	w0, #0x0, 0x10611fad4 <_Flutter_MMFoundation_BindContext+0x25fb6b8>
10611f920: b00cf368    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
10611f924: f9450d17    	ldr	x23, [x8, #0xa18] ; selector=m_roomId
10611f928: aa1303e0    	mov	x0, x19
10611f92c: aa1703e1    	mov	x1, x23
10611f930: 946c1e03    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611f934: b4001200    	cbz	x0, 0x10611fb74 <_Flutter_MMFoundation_BindContext+0x25fb758>
10611f938: b00cf368    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
10611f93c: f9451118    	ldr	x24, [x8, #0xa20] ; selector=m_roomKey
10611f940: aa1303e0    	mov	x0, x19
10611f944: aa1803e1    	mov	x1, x24
10611f948: 946c1dfd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611f94c: b4001640    	cbz	x0, 0x10611fc14 <_Flutter_MMFoundation_BindContext+0x25fb7f8>
10611f950: b00cf368    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
10611f954: f9450915    	ldr	x21, [x8, #0xa10] ; selector=m_fromUser
10611f958: aa1303e0    	mov	x0, x19
10611f95c: aa1503e1    	mov	x1, x21
10611f960: 946c1df7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611f964: aa1d03fd    	mov	x29, x29
10611f968: 946c1df8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10611f96c: aa0003f9    	mov	x25, x0
10611f970: 946c1df9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10611f974: b4001a19    	cbz	x25, 0x10611fcb4 <_Flutter_MMFoundation_BindContext+0x25fb898>
10611f978: 900d02a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10611f97c: f945e900    	ldr	x0, [x8, #0xbd0] ; class=MMContext
10611f980: b00cff08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10611f984: f944e901    	ldr	x1, [x8, #0x9d0] ; selector=currentContext
10611f988: 946c1ded    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611f98c: aa1d03fd    	mov	x29, x29
10611f990: 946c1dee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10611f994: aa0003fa    	mov	x26, x0
10611f998: b00d02a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10611f99c: f9401500    	ldr	x0, [x8, #0x28] ; class=CContactMgr
10611f9a0: 900cff08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10611f9a4: f947ad19    	ldr	x25, [x8, #0xf58] ; selector=class
10611f9a8: aa1903e1    	mov	x1, x25
10611f9ac: 946c1de4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611f9b0: aa0003e2    	mov	x2, x0
10611f9b4: d00ce8c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10611f9b8: f9464101    	ldr	x1, [x8, #0xc80] ; selector=getService:
10611f9bc: aa1a03e0    	mov	x0, x26
10611f9c0: 946c1ddf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611f9c4: aa1d03fd    	mov	x29, x29
10611f9c8: 946c1de0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10611f9cc: aa0003fb    	mov	x27, x0
10611f9d0: aa1303e0    	mov	x0, x19
10611f9d4: aa1503e1    	mov	x1, x21
10611f9d8: 946c1dd9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611f9dc: aa1d03fd    	mov	x29, x29
10611f9e0: 946c1dda    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10611f9e4: aa0003fc    	mov	x28, x0
10611f9e8: b00ce8e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10611f9ec: f940c901    	ldr	x1, [x8, #0x190] ; selector=getContactByName:
10611f9f0: aa1b03e0    	mov	x0, x27
10611f9f4: aa1c03e2    	mov	x2, x28
10611f9f8: 946c1dd1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611f9fc: aa1d03fd    	mov	x29, x29
10611fa00: 946c1dd2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10611fa04: aa0003f5    	mov	x21, x0
10611fa08: aa1c03e0    	mov	x0, x28
10611fa0c: 946c1dd2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10611fa10: aa1b03e0    	mov	x0, x27
10611fa14: 946c1dd0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10611fa18: aa1a03e0    	mov	x0, x26
10611fa1c: 946c1dce    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10611fa20: b4001bd5    	cbz	x21, 0x10611fd98 <_Flutter_MMFoundation_BindContext+0x25fb97c>
10611fa24: aa1603e0    	mov	x0, x22
10611fa28: aa1903e1    	mov	x1, x25
10611fa2c: 946c1dc4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611fa30: 946c1dcc    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10611fa34: aa0003f6    	mov	x22, x0
10611fa38: aa1303e0    	mov	x0, x19
10611fa3c: aa1703e1    	mov	x1, x23
10611fa40: 946c1dbf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611fa44: aa0003f7    	mov	x23, x0
10611fa48: aa1303e0    	mov	x0, x19
10611fa4c: aa1803e1    	mov	x1, x24
10611fa50: 946c1dbb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611fa54: aa0003f8    	mov	x24, x0
10611fa58: 900ce908    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10611fa5c: f9464d01    	ldr	x1, [x8, #0xc98] ; selector=isVideo
10611fa60: aa1303e0    	mov	x0, x19
10611fa64: 946c1db6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611fa68: 7100001f    	cmp	w0, #0x0
10611fa6c: 52800028    	mov	w8, #0x1                ; =1
10611fa70: 9a880519    	cinc	x25, x8, ne
10611fa74: f00cf548    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
10611fa78: f940f501    	ldr	x1, [x8, #0x1e8] ; selector=isFromIlink
10611fa7c: aa1303e0    	mov	x0, x19
10611fa80: 946c1daf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611fa84: aa0003fa    	mov	x26, x0
10611fa88: f00cf548    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
10611fa8c: f9418501    	ldr	x1, [x8, #0x308] ; selector=m_receiveTime
10611fa90: aa1303e0    	mov	x0, x19
10611fa94: 946c1daa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611fa98: 900cf3a8    	adrp	x8, 0x11ff93000 <dyld_stub_binder+0x11ff93000>
10611fa9c: f944b101    	ldr	x1, [x8, #0x960] ; selector=initWithMonoMsg:roomID:roomKey:roomType:contact:isFromIlink:receiveTime:inviteMsg:inviteInfo:scene:memberStatusMap:
10611faa0: a900ffff    	stp	xzr, xzr, [sp, #0x8]
10611faa4: a901fff4    	stp	x20, xzr, [sp, #0x18]
10611faa8: b90003e0    	str	w0, [sp]
10611faac: aa1603e0    	mov	x0, x22
10611fab0: aa1303e2    	mov	x2, x19
10611fab4: aa1703e3    	mov	x3, x23
10611fab8: aa1803e4    	mov	x4, x24
10611fabc: aa1903e5    	mov	x5, x25
10611fac0: aa1503e6    	mov	x6, x21
10611fac4: aa1a03e7    	mov	x7, x26
10611fac8: 946c1d9d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611facc: aa0003f4    	mov	x20, x0
10611fad0: 140000e0    	b	0x10611fe50 <_Flutter_MMFoundation_BindContext+0x25fba34>
10611fad4: 52800080    	mov	w0, #0x4                ; =4
10611fad8: 946bb5da    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10611fadc: 34001460    	cbz	w0, 0x10611fd68 <_Flutter_MMFoundation_BindContext+0x25fb94c>
10611fae0: 946c1db0    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10611fae4: aa0003f4    	mov	x20, x0
10611fae8: 900d02b6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
10611faec: f94546c0    	ldr	x0, [x22, #0xa88]
10611faf0: 946c1d9c    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10611faf4: aa0003f5    	mov	x21, x0
10611faf8: f94546c0    	ldr	x0, [x22, #0xa88]
10611fafc: f00cff48    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10611fb00: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10611fb04: a9007ff3    	stp	x19, xzr, [sp]
10611fb08: b00c3a82    	adrp	x2, 0x11e870000 <dyld_stub_binder+0x11e870000>
10611fb0c: 911a2042    	add	x2, x2, #0x688 ; cfstring='Failed to create info because it is not invite monomsg! (%@)'
10611fb10: 946c1d8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611fb14: aa1d03fd    	mov	x29, x29
10611fb18: 946c1d8c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10611fb1c: aa0003f6    	mov	x22, x0
10611fb20: f00cff08    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10611fb24: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10611fb28: 900c1be8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10611fb2c: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
10611fb30: a90003e8    	stp	x8, x0, [sp]
10611fb34: 900c1be2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10611fb38: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10611fb3c: aa1503e0    	mov	x0, x21
10611fb40: 946c1d7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611fb44: aa0003f5    	mov	x21, x0
10611fb48: aa1603e0    	mov	x0, x22
10611fb4c: 946c1d82    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10611fb50: d00a87a1    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
10611fb54: 9124e421    	add	x1, x1, #0x939 ; cstring='VoIP'
10611fb58: 900ac362    	adrp	x2, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10611fb5c: 9109a842    	add	x2, x2, #0x26a ; cstring='VoIPInvitationInfo.mm'
10611fb60: 900ac364    	adrp	x4, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10611fb64: 910bf484    	add	x4, x4, #0x2fd ; cstring='+[VoIPInvitationInfo infoWithVoipMonoMsg:scene:]'
10611fb68: 52800080    	mov	w0, #0x4                ; =4
10611fb6c: 52800ca3    	mov	w3, #0x65               ; =101
10611fb70: 14000078    	b	0x10611fd50 <_Flutter_MMFoundation_BindContext+0x25fb934>
10611fb74: 52800080    	mov	w0, #0x4                ; =4
10611fb78: 946bb5b2    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10611fb7c: 34000f60    	cbz	w0, 0x10611fd68 <_Flutter_MMFoundation_BindContext+0x25fb94c>
10611fb80: 946c1d88    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10611fb84: aa0003f4    	mov	x20, x0
10611fb88: 900d02b6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
10611fb8c: f94546c0    	ldr	x0, [x22, #0xa88]
10611fb90: 946c1d74    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10611fb94: aa0003f5    	mov	x21, x0
10611fb98: f94546c0    	ldr	x0, [x22, #0xa88]
10611fb9c: f00cff48    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10611fba0: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10611fba4: a9007ff3    	stp	x19, xzr, [sp]
10611fba8: b00c3a82    	adrp	x2, 0x11e870000 <dyld_stub_binder+0x11e870000>
10611fbac: 911aa042    	add	x2, x2, #0x6a8 ; cfstring='Failed to create info because of nil roomID! (%@)'
10611fbb0: 946c1d63    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611fbb4: aa1d03fd    	mov	x29, x29
10611fbb8: 946c1d64    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10611fbbc: aa0003f6    	mov	x22, x0
10611fbc0: f00cff08    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10611fbc4: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10611fbc8: 900c1be8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10611fbcc: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
10611fbd0: a90003e8    	stp	x8, x0, [sp]
10611fbd4: 900c1be2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10611fbd8: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10611fbdc: aa1503e0    	mov	x0, x21
10611fbe0: 946c1d57    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611fbe4: aa0003f5    	mov	x21, x0
10611fbe8: aa1603e0    	mov	x0, x22
10611fbec: 946c1d5a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10611fbf0: d00a87a1    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
10611fbf4: 9124e421    	add	x1, x1, #0x939 ; cstring='VoIP'
10611fbf8: 900ac362    	adrp	x2, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10611fbfc: 9109a842    	add	x2, x2, #0x26a ; cstring='VoIPInvitationInfo.mm'
10611fc00: 900ac364    	adrp	x4, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10611fc04: 910bf484    	add	x4, x4, #0x2fd ; cstring='+[VoIPInvitationInfo infoWithVoipMonoMsg:scene:]'
10611fc08: 52800080    	mov	w0, #0x4                ; =4
10611fc0c: 52800d43    	mov	w3, #0x6a               ; =106
10611fc10: 14000050    	b	0x10611fd50 <_Flutter_MMFoundation_BindContext+0x25fb934>
10611fc14: 52800080    	mov	w0, #0x4                ; =4
10611fc18: 946bb58a    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10611fc1c: 34000a60    	cbz	w0, 0x10611fd68 <_Flutter_MMFoundation_BindContext+0x25fb94c>
10611fc20: 946c1d60    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10611fc24: aa0003f4    	mov	x20, x0
10611fc28: 900d02b6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
10611fc2c: f94546c0    	ldr	x0, [x22, #0xa88]
10611fc30: 946c1d4c    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10611fc34: aa0003f5    	mov	x21, x0
10611fc38: f94546c0    	ldr	x0, [x22, #0xa88]
10611fc3c: f00cff48    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10611fc40: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10611fc44: a9007ff3    	stp	x19, xzr, [sp]
10611fc48: b00c3a82    	adrp	x2, 0x11e870000 <dyld_stub_binder+0x11e870000>
10611fc4c: 911b2042    	add	x2, x2, #0x6c8 ; cfstring='Failed to create info because of nil roomKey! (%@)'
10611fc50: 946c1d3b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611fc54: aa1d03fd    	mov	x29, x29
10611fc58: 946c1d3c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10611fc5c: aa0003f6    	mov	x22, x0
10611fc60: f00cff08    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10611fc64: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10611fc68: 900c1be8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10611fc6c: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
10611fc70: a90003e8    	stp	x8, x0, [sp]
10611fc74: 900c1be2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10611fc78: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10611fc7c: aa1503e0    	mov	x0, x21
10611fc80: 946c1d2f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611fc84: aa0003f5    	mov	x21, x0
10611fc88: aa1603e0    	mov	x0, x22
10611fc8c: 946c1d32    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10611fc90: d00a87a1    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
10611fc94: 9124e421    	add	x1, x1, #0x939 ; cstring='VoIP'
10611fc98: 900ac362    	adrp	x2, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10611fc9c: 9109a842    	add	x2, x2, #0x26a ; cstring='VoIPInvitationInfo.mm'
10611fca0: 900ac364    	adrp	x4, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10611fca4: 910bf484    	add	x4, x4, #0x2fd ; cstring='+[VoIPInvitationInfo infoWithVoipMonoMsg:scene:]'
10611fca8: 52800080    	mov	w0, #0x4                ; =4
10611fcac: 52800de3    	mov	w3, #0x6f               ; =111
10611fcb0: 14000028    	b	0x10611fd50 <_Flutter_MMFoundation_BindContext+0x25fb934>
10611fcb4: 52800080    	mov	w0, #0x4                ; =4
10611fcb8: 946bb562    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10611fcbc: 34000560    	cbz	w0, 0x10611fd68 <_Flutter_MMFoundation_BindContext+0x25fb94c>
10611fcc0: 946c1d38    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10611fcc4: aa0003f4    	mov	x20, x0
10611fcc8: 900d02b6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
10611fccc: f94546c0    	ldr	x0, [x22, #0xa88]
10611fcd0: 946c1d24    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10611fcd4: aa0003f5    	mov	x21, x0
10611fcd8: f94546c0    	ldr	x0, [x22, #0xa88]
10611fcdc: f00cff48    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10611fce0: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10611fce4: a9007ff3    	stp	x19, xzr, [sp]
10611fce8: b00c3a82    	adrp	x2, 0x11e870000 <dyld_stub_binder+0x11e870000>
10611fcec: 911ba042    	add	x2, x2, #0x6e8 ; cfstring='Failed to create info because of nil fromUser! (%@)'
10611fcf0: 946c1d13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611fcf4: aa1d03fd    	mov	x29, x29
10611fcf8: 946c1d14    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10611fcfc: aa0003f6    	mov	x22, x0
10611fd00: f00cff08    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10611fd04: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10611fd08: 900c1be8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10611fd0c: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
10611fd10: a90003e8    	stp	x8, x0, [sp]
10611fd14: 900c1be2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10611fd18: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10611fd1c: aa1503e0    	mov	x0, x21
10611fd20: 946c1d07    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611fd24: aa0003f5    	mov	x21, x0
10611fd28: aa1603e0    	mov	x0, x22
10611fd2c: 946c1d0a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10611fd30: d00a87a1    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
10611fd34: 9124e421    	add	x1, x1, #0x939 ; cstring='VoIP'
10611fd38: 900ac362    	adrp	x2, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10611fd3c: 9109a842    	add	x2, x2, #0x26a ; cstring='VoIPInvitationInfo.mm'
10611fd40: 900ac364    	adrp	x4, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10611fd44: 910bf484    	add	x4, x4, #0x2fd ; cstring='+[VoIPInvitationInfo infoWithVoipMonoMsg:scene:]'
10611fd48: 52800080    	mov	w0, #0x4                ; =4
10611fd4c: 52800e83    	mov	w3, #0x74               ; =116
10611fd50: aa1503e5    	mov	x5, x21
10611fd54: 946bb53c    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10611fd58: aa1503e0    	mov	x0, x21
10611fd5c: 946c1cfe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10611fd60: aa1403e0    	mov	x0, x20
10611fd64: 946c1d12    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10611fd68: d2800014    	mov	x20, #0x0               ; =0
10611fd6c: aa1303e0    	mov	x0, x19
10611fd70: 946c1cf9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10611fd74: aa1403e0    	mov	x0, x20
10611fd78: a9487bfd    	ldp	x29, x30, [sp, #0x80]
10611fd7c: a9474ff4    	ldp	x20, x19, [sp, #0x70]
10611fd80: a94657f6    	ldp	x22, x21, [sp, #0x60]
10611fd84: a9455ff8    	ldp	x24, x23, [sp, #0x50]
10611fd88: a94467fa    	ldp	x26, x25, [sp, #0x40]
10611fd8c: a9436ffc    	ldp	x28, x27, [sp, #0x30]
10611fd90: 910243ff    	add	sp, sp, #0x90
10611fd94: 146c1cf7    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
10611fd98: 52800080    	mov	w0, #0x4                ; =4
10611fd9c: 946bb529    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10611fda0: 34000560    	cbz	w0, 0x10611fe4c <_Flutter_MMFoundation_BindContext+0x25fba30>
10611fda4: 946c1cff    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10611fda8: aa0003f4    	mov	x20, x0
10611fdac: 900d02b7    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
10611fdb0: f94546e0    	ldr	x0, [x23, #0xa88]
10611fdb4: 946c1ceb    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10611fdb8: aa0003f6    	mov	x22, x0
10611fdbc: f94546e0    	ldr	x0, [x23, #0xa88]
10611fdc0: f00cff48    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10611fdc4: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10611fdc8: a9007ff3    	stp	x19, xzr, [sp]
10611fdcc: b00c3a82    	adrp	x2, 0x11e870000 <dyld_stub_binder+0x11e870000>
10611fdd0: 911c2042    	add	x2, x2, #0x708 ; cfstring='Failed to create info because of nil contact! (%@)'
10611fdd4: 946c1cda    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611fdd8: aa1d03fd    	mov	x29, x29
10611fddc: 946c1cdb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10611fde0: aa0003f7    	mov	x23, x0
10611fde4: f00cff08    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10611fde8: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10611fdec: 900c1be8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10611fdf0: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
10611fdf4: a90003e8    	stp	x8, x0, [sp]
10611fdf8: 900c1be2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10611fdfc: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10611fe00: aa1603e0    	mov	x0, x22
10611fe04: 946c1cce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10611fe08: aa0003f6    	mov	x22, x0
10611fe0c: aa1703e0    	mov	x0, x23
10611fe10: 946c1cd1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10611fe14: d00a87a1    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
10611fe18: 9124e421    	add	x1, x1, #0x939 ; cstring='VoIP'
10611fe1c: 900ac362    	adrp	x2, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10611fe20: 9109a842    	add	x2, x2, #0x26a ; cstring='VoIPInvitationInfo.mm'
10611fe24: 900ac364    	adrp	x4, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10611fe28: 910bf484    	add	x4, x4, #0x2fd ; cstring='+[VoIPInvitationInfo infoWithVoipMonoMsg:scene:]'
10611fe2c: 52800080    	mov	w0, #0x4                ; =4
10611fe30: 52800f83    	mov	w3, #0x7c               ; =124
10611fe34: aa1603e5    	mov	x5, x22
10611fe38: 946bb503    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10611fe3c: aa1603e0    	mov	x0, x22
10611fe40: 946c1cc5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10611fe44: aa1403e0    	mov	x0, x20
10611fe48: 946c1cd9    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10611fe4c: d2800014    	mov	x20, #0x0               ; =0
10611fe50: aa1503e0    	mov	x0, x21
10611fe54: 946c1cc0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10611fe58: 17ffffc5    	b	0x10611fd6c <_Flutter_MMFoundation_BindContext+0x25fb950>
