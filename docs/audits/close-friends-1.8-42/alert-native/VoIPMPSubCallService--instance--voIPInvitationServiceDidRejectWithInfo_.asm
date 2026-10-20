
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106171484: d10243ff    	sub	sp, sp, #0x90
106171488: a9036ffc    	stp	x28, x27, [sp, #0x30]
10617148c: a90467fa    	stp	x26, x25, [sp, #0x40]
106171490: a9055ff8    	stp	x24, x23, [sp, #0x50]
106171494: a90657f6    	stp	x22, x21, [sp, #0x60]
106171498: a9074ff4    	stp	x20, x19, [sp, #0x70]
10617149c: a9087bfd    	stp	x29, x30, [sp, #0x80]
1061714a0: 910203fd    	add	x29, sp, #0x80
1061714a4: aa0203f3    	mov	x19, x2
1061714a8: aa0003f4    	mov	x20, x0
1061714ac: d00d5688    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
1061714b0: 52800029    	mov	w9, #0x1                ; =1
1061714b4: 391c0509    	strb	w9, [x8, #0x701]
1061714b8: aa0203e0    	mov	x0, x2
1061714bc: 946ad71f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1061714c0: 52800040    	mov	w0, #0x2                ; =2
1061714c4: 946a6f5f    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
1061714c8: 34000560    	cbz	w0, 0x106171574 <_Flutter_MMFoundation_BindContext+0x264d158>
1061714cc: 946ad735    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
1061714d0: aa0003f5    	mov	x21, x0
1061714d4: d00d0017    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
1061714d8: f94546e0    	ldr	x0, [x23, #0xa88]
1061714dc: 946ad721    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1061714e0: aa0003f6    	mov	x22, x0
1061714e4: f94546e0    	ldr	x0, [x23, #0xa88]
1061714e8: b00cfcc8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1061714ec: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
1061714f0: f90003ff    	str	xzr, [sp]
1061714f4: f00c3802    	adrp	x2, 0x11e874000 <dyld_stub_binder+0x11e874000>
1061714f8: 9114a042    	add	x2, x2, #0x528 ; cfstring='Prepare to handle reject event from invitation service ...'
1061714fc: 946ad710    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106171500: aa1d03fd    	mov	x29, x29
106171504: 946ad711    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106171508: aa0003f7    	mov	x23, x0
10617150c: b00cfc88    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106171510: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
106171514: d00c1948    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106171518: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
10617151c: a90003e8    	stp	x8, x0, [sp]
106171520: d00c1942    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106171524: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
106171528: aa1603e0    	mov	x0, x22
10617152c: 946ad704    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106171530: aa0003f6    	mov	x22, x0
106171534: aa1703e0    	mov	x0, x23
106171538: 946ad707    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10617153c: d00ac0c1    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
106171540: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
106171544: d00ac102    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
106171548: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10617154c: f00ac104    	adrp	x4, 0x11b994000 <dyld_stub_binder+0x11b994000>
106171550: 9125a484    	add	x4, x4, #0x969 ; cstring='-[VoIPMPSubCallService voIPInvitationServiceDidRejectWithInfo:]'
106171554: 52800040    	mov	w0, #0x2                ; =2
106171558: 52808463    	mov	w3, #0x423              ; =1059
10617155c: aa1603e5    	mov	x5, x22
106171560: 946a6f39    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106171564: aa1603e0    	mov	x0, x22
106171568: 946ad6fb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10617156c: aa1503e0    	mov	x0, x21
106171570: 946ad70f    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
106171574: 900ce668    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
106171578: f9474d16    	ldr	x22, [x8, #0xe98] ; selector=cache
10617157c: aa1403e0    	mov	x0, x20
106171580: aa1603e1    	mov	x1, x22
106171584: 946ad6ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106171588: aa1d03fd    	mov	x29, x29
10617158c: 946ad6ef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106171590: aa0003f5    	mov	x21, x0
106171594: d00cf2e8    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
106171598: f9459517    	ldr	x23, [x8, #0xb28] ; selector=inviteInfo
10617159c: aa1703e1    	mov	x1, x23
1061715a0: 946ad6e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1061715a4: aa1d03fd    	mov	x29, x29
1061715a8: 946ad6e8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1061715ac: aa0003f8    	mov	x24, x0
1061715b0: 946ad6e9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1061715b4: aa1503e0    	mov	x0, x21
1061715b8: 946ad6e7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1061715bc: b4000f98    	cbz	x24, 0x1061717ac <_Flutter_MMFoundation_BindContext+0x264d390>
1061715c0: b00ce648    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1061715c4: f9406118    	ldr	x24, [x8, #0xc0] ; selector=roomID
1061715c8: aa1303e0    	mov	x0, x19
1061715cc: aa1803e1    	mov	x1, x24
1061715d0: 946ad6db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1061715d4: aa0003f5    	mov	x21, x0
1061715d8: aa1403e0    	mov	x0, x20
1061715dc: aa1603e1    	mov	x1, x22
1061715e0: 946ad6d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1061715e4: aa1d03fd    	mov	x29, x29
1061715e8: 946ad6d8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1061715ec: aa0003fa    	mov	x26, x0
1061715f0: aa1703e1    	mov	x1, x23
1061715f4: 946ad6d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1061715f8: aa1d03fd    	mov	x29, x29
1061715fc: 946ad6d3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106171600: aa0003fb    	mov	x27, x0
106171604: b00ce6e8    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
106171608: f9450519    	ldr	x25, [x8, #0xa08] ; selector=roomid
10617160c: aa1903e1    	mov	x1, x25
106171610: 946ad6cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106171614: aa0003fc    	mov	x28, x0
106171618: aa1b03e0    	mov	x0, x27
10617161c: 946ad6ce    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106171620: aa1a03e0    	mov	x0, x26
106171624: 946ad6cc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106171628: eb1c02bf    	cmp	x21, x28
10617162c: 540000c1    	b.ne	0x106171644 <_Flutter_MMFoundation_BindContext+0x264d228>
106171630: 900cf308    	adrp	x8, 0x11ffd1000 <dyld_stub_binder+0x11ffd1000>
106171634: f940f101    	ldr	x1, [x8, #0x1e0] ; selector=reject
106171638: aa1403e0    	mov	x0, x20
10617163c: 946ad6c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106171640: 1400005b    	b	0x1061717ac <_Flutter_MMFoundation_BindContext+0x264d390>
106171644: 52800040    	mov	w0, #0x2                ; =2
106171648: 946a6efe    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10617164c: 34000b00    	cbz	w0, 0x1061717ac <_Flutter_MMFoundation_BindContext+0x264d390>
106171650: 946ad6d4    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
106171654: f90017e0    	str	x0, [sp, #0x28]
106171658: d00d0015    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
10617165c: f94546a0    	ldr	x0, [x21, #0xa88]
106171660: 946ad6c0    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106171664: f90013e0    	str	x0, [sp, #0x20]
106171668: f94546bb    	ldr	x27, [x21, #0xa88]
10617166c: d00d001a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
106171670: f9458b5c    	ldr	x28, [x26, #0xb10]
106171674: aa1303e0    	mov	x0, x19
106171678: aa1803e1    	mov	x1, x24
10617167c: 946ad6b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106171680: aa0003e2    	mov	x2, x0
106171684: f00cfc88    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
106171688: f947c915    	ldr	x21, [x8, #0xf90] ; selector=numberWithUnsignedLongLong:
10617168c: aa1c03e0    	mov	x0, x28
106171690: aa1503e1    	mov	x1, x21
106171694: 946ad6aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106171698: aa1d03fd    	mov	x29, x29
10617169c: 946ad6ab    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1061716a0: aa0003f8    	mov	x24, x0
1061716a4: f9458b5c    	ldr	x28, [x26, #0xb10]
1061716a8: aa1403e0    	mov	x0, x20
1061716ac: aa1603e1    	mov	x1, x22
1061716b0: 946ad6a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1061716b4: aa1d03fd    	mov	x29, x29
1061716b8: 946ad6a4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1061716bc: aa0003f4    	mov	x20, x0
1061716c0: aa1703e1    	mov	x1, x23
1061716c4: 946ad69e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1061716c8: aa1d03fd    	mov	x29, x29
1061716cc: 946ad69f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1061716d0: aa0003f6    	mov	x22, x0
1061716d4: aa1903e1    	mov	x1, x25
1061716d8: 946ad699    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1061716dc: aa0003e2    	mov	x2, x0
1061716e0: aa1c03e0    	mov	x0, x28
1061716e4: aa1503e1    	mov	x1, x21
1061716e8: 946ad695    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1061716ec: aa1d03fd    	mov	x29, x29
1061716f0: 946ad696    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1061716f4: aa0003f5    	mov	x21, x0
1061716f8: b00cfcc8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1061716fc: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
106171700: a900ffe0    	stp	x0, xzr, [sp, #0x8]
106171704: f90003f8    	str	x24, [sp]
106171708: d00c3802    	adrp	x2, 0x11e873000 <dyld_stub_binder+0x11e873000>
10617170c: 91392042    	add	x2, x2, #0xe48 ; cfstring='It is not the same roomID! (%@, %@)'
106171710: aa1b03e0    	mov	x0, x27
106171714: 946ad68a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106171718: aa1d03fd    	mov	x29, x29
10617171c: 946ad68b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106171720: aa0003f7    	mov	x23, x0
106171724: b00cfc88    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106171728: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10617172c: d00c1948    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106171730: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
106171734: a90003e8    	stp	x8, x0, [sp]
106171738: d00c1942    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10617173c: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
106171740: f94013e0    	ldr	x0, [sp, #0x20]
106171744: 946ad67e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106171748: aa0003f9    	mov	x25, x0
10617174c: aa1703e0    	mov	x0, x23
106171750: 946ad681    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106171754: aa1503e0    	mov	x0, x21
106171758: 946ad67f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10617175c: aa1603e0    	mov	x0, x22
106171760: 946ad67d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106171764: aa1403e0    	mov	x0, x20
106171768: 946ad67b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10617176c: aa1803e0    	mov	x0, x24
106171770: 946ad679    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106171774: d00ac0c1    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
106171778: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10617177c: d00ac102    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
106171780: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
106171784: f00ac104    	adrp	x4, 0x11b994000 <dyld_stub_binder+0x11b994000>
106171788: 9125a484    	add	x4, x4, #0x969 ; cstring='-[VoIPMPSubCallService voIPInvitationServiceDidRejectWithInfo:]'
10617178c: 52800040    	mov	w0, #0x2                ; =2
106171790: 52808523    	mov	w3, #0x429              ; =1065
106171794: aa1903e5    	mov	x5, x25
106171798: 946a6eab    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10617179c: aa1903e0    	mov	x0, x25
1061717a0: 946ad66d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1061717a4: f94017e0    	ldr	x0, [sp, #0x28]
1061717a8: 946ad681    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
1061717ac: aa1303e0    	mov	x0, x19
1061717b0: a9487bfd    	ldp	x29, x30, [sp, #0x80]
1061717b4: a9474ff4    	ldp	x20, x19, [sp, #0x70]
1061717b8: a94657f6    	ldp	x22, x21, [sp, #0x60]
1061717bc: a9455ff8    	ldp	x24, x23, [sp, #0x50]
1061717c0: a94467fa    	ldp	x26, x25, [sp, #0x40]
1061717c4: a9436ffc    	ldp	x28, x27, [sp, #0x30]
1061717c8: 910243ff    	add	sp, sp, #0x90
1061717cc: 146ad662    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
