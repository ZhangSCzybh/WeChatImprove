
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10616c37c: d10303ff    	sub	sp, sp, #0xc0
10616c380: 6d0523e9    	stp	d9, d8, [sp, #0x50]
10616c384: a9066ffc    	stp	x28, x27, [sp, #0x60]
10616c388: a90767fa    	stp	x26, x25, [sp, #0x70]
10616c38c: a9085ff8    	stp	x24, x23, [sp, #0x80]
10616c390: a90957f6    	stp	x22, x21, [sp, #0x90]
10616c394: a90a4ff4    	stp	x20, x19, [sp, #0xa0]
10616c398: a90b7bfd    	stp	x29, x30, [sp, #0xb0]
10616c39c: 9102c3fd    	add	x29, sp, #0xb0
10616c3a0: aa0403f8    	mov	x24, x4
10616c3a4: aa0303f5    	mov	x21, x3
10616c3a8: aa0203f3    	mov	x19, x2
10616c3ac: aa0003f7    	mov	x23, x0
10616c3b0: f00d56a8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
10616c3b4: 52800029    	mov	w9, #0x1                ; =1
10616c3b8: 391bcd09    	strb	w9, [x8, #0x6f3]
10616c3bc: aa0203e0    	mov	x0, x2
10616c3c0: 946aeb5e    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10616c3c4: aa1303e0    	mov	x0, x19
10616c3c8: 946aeb5c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10616c3cc: d00d0068    	adrp	x8, 0x12017a000 <dyld_stub_binder+0x12017a000>
10616c3d0: f941e500    	ldr	x0, [x8, #0x3c8] ; class=VoipMonoMsg
10616c3d4: f00cfc88    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10616c3d8: f947ad16    	ldr	x22, [x8, #0xf58] ; selector=class
10616c3dc: aa1603e1    	mov	x1, x22
10616c3e0: 946aeb57    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c3e4: aa0003e2    	mov	x2, x0
10616c3e8: f00cfca8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10616c3ec: f9442d14    	ldr	x20, [x8, #0x858] ; selector=isKindOfClass:
10616c3f0: aa1303e0    	mov	x0, x19
10616c3f4: aa1403e1    	mov	x1, x20
10616c3f8: 946aeb51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c3fc: 34000ba0    	cbz	w0, 0x10616c570 <_Flutter_MMFoundation_BindContext+0x2648154>
10616c400: b90043f8    	str	w24, [sp, #0x40]
10616c404: f90027f5    	str	x21, [sp, #0x48]
10616c408: 52800040    	mov	w0, #0x2                ; =2
10616c40c: 946a838d    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616c410: 34000560    	cbz	w0, 0x10616c4bc <_Flutter_MMFoundation_BindContext+0x26480a0>
10616c414: 946aeb63    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616c418: aa0003f4    	mov	x20, x0
10616c41c: f00d0035    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
10616c420: f94546a0    	ldr	x0, [x21, #0xa88]
10616c424: 946aeb4f    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616c428: aa0003f7    	mov	x23, x0
10616c42c: f94546a0    	ldr	x0, [x21, #0xa88]
10616c430: d00cfce8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616c434: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616c438: f90003ff    	str	xzr, [sp]
10616c43c: 900c3842    	adrp	x2, 0x11e874000 <dyld_stub_binder+0x11e874000>
10616c440: 91062042    	add	x2, x2, #0x188 ; cfstring='It is voipmonomsg'
10616c444: 946aeb3e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c448: aa1d03fd    	mov	x29, x29
10616c44c: 946aeb3f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c450: aa0003f8    	mov	x24, x0
10616c454: d00cfca8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616c458: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616c45c: f00c1968    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616c460: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
10616c464: a90003e8    	stp	x8, x0, [sp]
10616c468: f00c1962    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616c46c: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616c470: aa1703e0    	mov	x0, x23
10616c474: 946aeb32    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c478: aa0003f7    	mov	x23, x0
10616c47c: aa1803e0    	mov	x0, x24
10616c480: 946aeb35    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616c484: f00ac0e1    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616c488: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616c48c: f00ac122    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616c490: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616c494: 900ac144    	adrp	x4, 0x11b994000 <dyld_stub_binder+0x11b994000>
10616c498: 9106c884    	add	x4, x4, #0x1b2 ; cstring='-[VoIPMPSubCallService genVoIPInvitationInfoWithMsg:Scene:NeedReport:]'
10616c49c: 52800040    	mov	w0, #0x2                ; =2
10616c4a0: 52804403    	mov	w3, #0x220              ; =544
10616c4a4: aa1703e5    	mov	x5, x23
10616c4a8: 946a8367    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10616c4ac: aa1703e0    	mov	x0, x23
10616c4b0: 946aeb29    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616c4b4: aa1403e0    	mov	x0, x20
10616c4b8: 946aeb3d    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10616c4bc: f00d0028    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10616c4c0: f945e900    	ldr	x0, [x8, #0xbd0] ; class=MMContext
10616c4c4: 900cfca8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10616c4c8: f944e918    	ldr	x24, [x8, #0x9d0] ; selector=currentContext
10616c4cc: aa1803e1    	mov	x1, x24
10616c4d0: 946aeb1b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c4d4: aa1d03fd    	mov	x29, x29
10616c4d8: 946aeb1c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c4dc: aa0003f4    	mov	x20, x0
10616c4e0: f00d0035    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
10616c4e4: f9467ea0    	ldr	x0, [x21, #0xcf8] ; class=VoipUIManager
10616c4e8: aa1603e1    	mov	x1, x22
10616c4ec: 946aeb14    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c4f0: aa0003e2    	mov	x2, x0
10616c4f4: b00ce668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10616c4f8: f9464119    	ldr	x25, [x8, #0xc80] ; selector=getService:
10616c4fc: aa1403e0    	mov	x0, x20
10616c500: aa1903e1    	mov	x1, x25
10616c504: 946aeb0e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c508: aa1d03fd    	mov	x29, x29
10616c50c: 946aeb0f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c510: aa0003fa    	mov	x26, x0
10616c514: 900cf1a8    	adrp	x8, 0x11ffa0000 <dyld_stub_binder+0x11ffa0000>
10616c518: f945e901    	ldr	x1, [x8, #0xbd0] ; selector=getRoomId
10616c51c: 946aeb08    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c520: aa0003fb    	mov	x27, x0
10616c524: 900cf108    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
10616c528: f9450d17    	ldr	x23, [x8, #0xa18] ; selector=m_roomId
10616c52c: aa1303e0    	mov	x0, x19
10616c530: aa1703e1    	mov	x1, x23
10616c534: 946aeb02    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c538: aa0003fc    	mov	x28, x0
10616c53c: aa1a03e0    	mov	x0, x26
10616c540: 946aeb05    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616c544: aa1403e0    	mov	x0, x20
10616c548: 946aeb03    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616c54c: eb1c037f    	cmp	x27, x28
10616c550: 54001741    	b.ne	0x10616c838 <_Flutter_MMFoundation_BindContext+0x264841c>
10616c554: 52800080    	mov	w0, #0x4                ; =4
10616c558: 946a833a    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616c55c: 36004220    	tbz	w0, #0x0, 0x10616cda0 <_Flutter_MMFoundation_BindContext+0x2648984>
10616c560: 52804474    	mov	w20, #0x223             ; =547
10616c564: 900c3855    	adrp	x21, 0x11e874000 <dyld_stub_binder+0x11e874000>
10616c568: 9106a2b5    	add	x21, x21, #0x1a8 ; cfstring='It is talking to this room! (%@)'
10616c56c: 140001e4    	b	0x10616ccfc <_Flutter_MMFoundation_BindContext+0x26488e0>
10616c570: aa1303e0    	mov	x0, x19
10616c574: 946aeaf1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10616c578: f00d0128    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
10616c57c: f9467900    	ldr	x0, [x8, #0xcf0] ; class=MultiTalkMonoMsg
10616c580: aa1603e1    	mov	x1, x22
10616c584: 946aeaee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c588: aa0003e2    	mov	x2, x0
10616c58c: aa1303e0    	mov	x0, x19
10616c590: aa1403e1    	mov	x1, x20
10616c594: 946aeaea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c598: 34002040    	cbz	w0, 0x10616c9a0 <_Flutter_MMFoundation_BindContext+0x2648584>
10616c59c: f90027f5    	str	x21, [sp, #0x48]
10616c5a0: 52800040    	mov	w0, #0x2                ; =2
10616c5a4: 946a8327    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616c5a8: 34000560    	cbz	w0, 0x10616c654 <_Flutter_MMFoundation_BindContext+0x2648238>
10616c5ac: 946aeafd    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616c5b0: aa0003f4    	mov	x20, x0
10616c5b4: f00d0038    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
10616c5b8: f9454700    	ldr	x0, [x24, #0xa88]
10616c5bc: 946aeae9    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616c5c0: aa0003f5    	mov	x21, x0
10616c5c4: f9454700    	ldr	x0, [x24, #0xa88]
10616c5c8: d00cfce8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616c5cc: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616c5d0: f90003ff    	str	xzr, [sp]
10616c5d4: 900c3842    	adrp	x2, 0x11e874000 <dyld_stub_binder+0x11e874000>
10616c5d8: 91072042    	add	x2, x2, #0x1c8 ; cfstring='It is multitalkmonomsg'
10616c5dc: 946aead8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c5e0: aa1d03fd    	mov	x29, x29
10616c5e4: 946aead9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c5e8: aa0003f8    	mov	x24, x0
10616c5ec: d00cfca8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616c5f0: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616c5f4: f00c1968    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616c5f8: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
10616c5fc: a90003e8    	stp	x8, x0, [sp]
10616c600: f00c1962    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616c604: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616c608: aa1503e0    	mov	x0, x21
10616c60c: 946aeacc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c610: aa0003f5    	mov	x21, x0
10616c614: aa1803e0    	mov	x0, x24
10616c618: 946aeacf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616c61c: f00ac0e1    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616c620: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616c624: f00ac122    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616c628: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616c62c: 900ac144    	adrp	x4, 0x11b994000 <dyld_stub_binder+0x11b994000>
10616c630: 9106c884    	add	x4, x4, #0x1b2 ; cstring='-[VoIPMPSubCallService genVoIPInvitationInfoWithMsg:Scene:NeedReport:]'
10616c634: 52800040    	mov	w0, #0x2                ; =2
10616c638: 52804b63    	mov	w3, #0x25b              ; =603
10616c63c: aa1503e5    	mov	x5, x21
10616c640: 946a8301    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10616c644: aa1503e0    	mov	x0, x21
10616c648: 946aeac3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616c64c: aa1403e0    	mov	x0, x20
10616c650: 946aead7    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10616c654: f00d0028    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10616c658: f945e900    	ldr	x0, [x8, #0xbd0] ; class=MMContext
10616c65c: 900cfca8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10616c660: f944e901    	ldr	x1, [x8, #0x9d0] ; selector=currentContext
10616c664: 946aeab6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c668: aa1d03fd    	mov	x29, x29
10616c66c: 946aeab7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c670: aa0003f5    	mov	x21, x0
10616c674: 900d0048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10616c678: f9401500    	ldr	x0, [x8, #0x28] ; class=CContactMgr
10616c67c: aa1603e1    	mov	x1, x22
10616c680: 946aeaaf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c684: aa0003e2    	mov	x2, x0
10616c688: b00ce668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10616c68c: f9464101    	ldr	x1, [x8, #0xc80] ; selector=getService:
10616c690: aa1503e0    	mov	x0, x21
10616c694: 946aeaaa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c698: aa1d03fd    	mov	x29, x29
10616c69c: 946aeaab    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c6a0: aa0003f6    	mov	x22, x0
10616c6a4: b00ce688    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10616c6a8: f9474d19    	ldr	x25, [x8, #0xe98] ; selector=cache
10616c6ac: aa1703e0    	mov	x0, x23
10616c6b0: aa1903e1    	mov	x1, x25
10616c6b4: 946aeaa2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c6b8: aa1d03fd    	mov	x29, x29
10616c6bc: 946aeaa3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c6c0: aa0003f8    	mov	x24, x0
10616c6c4: f00cf308    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
10616c6c8: f9459514    	ldr	x20, [x8, #0xb28] ; selector=inviteInfo
10616c6cc: aa1403e1    	mov	x1, x20
10616c6d0: 946aea9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c6d4: aa1d03fd    	mov	x29, x29
10616c6d8: 946aea9c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c6dc: aa0003fa    	mov	x26, x0
10616c6e0: b00ce848    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
10616c6e4: f9430d01    	ldr	x1, [x8, #0x618] ; selector=callerUsername
10616c6e8: 946aea95    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c6ec: aa1d03fd    	mov	x29, x29
10616c6f0: 946aea96    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c6f4: aa0003fb    	mov	x27, x0
10616c6f8: 900ce688    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10616c6fc: f940c901    	ldr	x1, [x8, #0x190] ; selector=getContactByName:
10616c700: aa1603e0    	mov	x0, x22
10616c704: aa1b03e2    	mov	x2, x27
10616c708: 946aea8d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c70c: aa1d03fd    	mov	x29, x29
10616c710: 946aea8e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c714: f90023e0    	str	x0, [sp, #0x40]
10616c718: aa1b03e0    	mov	x0, x27
10616c71c: 946aea8e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616c720: aa1a03e0    	mov	x0, x26
10616c724: 946aea8c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616c728: aa1803e0    	mov	x0, x24
10616c72c: 946aea8a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616c730: aa1603e0    	mov	x0, x22
10616c734: 946aea88    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616c738: aa1503e0    	mov	x0, x21
10616c73c: 946aea86    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616c740: f00d0128    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
10616c744: f9467d00    	ldr	x0, [x8, #0xcf8] ; class=VoIPInvitationInfo
10616c748: 946aea86    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616c74c: f9001be0    	str	x0, [sp, #0x30]
10616c750: aa1703e0    	mov	x0, x23
10616c754: aa1903e1    	mov	x1, x25
10616c758: 946aea79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c75c: aa1d03fd    	mov	x29, x29
10616c760: 946aea7a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c764: f9001fe0    	str	x0, [sp, #0x38]
10616c768: aa1403e1    	mov	x1, x20
10616c76c: 946aea74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c770: aa1d03fd    	mov	x29, x29
10616c774: 946aea75    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c778: aa0003f8    	mov	x24, x0
10616c77c: d00ce708    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
10616c780: f9450501    	ldr	x1, [x8, #0xa08] ; selector=roomid
10616c784: 946aea6e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c788: f90017e0    	str	x0, [sp, #0x28]
10616c78c: aa1703e0    	mov	x0, x23
10616c790: aa1903e1    	mov	x1, x25
10616c794: 946aea6a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c798: aa1d03fd    	mov	x29, x29
10616c79c: 946aea6b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c7a0: aa0003fa    	mov	x26, x0
10616c7a4: f00cf308    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
10616c7a8: f9459101    	ldr	x1, [x8, #0xb20] ; selector=inviteMsg
10616c7ac: 946aea64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c7b0: aa1d03fd    	mov	x29, x29
10616c7b4: 946aea65    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c7b8: aa0003fc    	mov	x28, x0
10616c7bc: aa1703e0    	mov	x0, x23
10616c7c0: aa1903e1    	mov	x1, x25
10616c7c4: 946aea5e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c7c8: aa1d03fd    	mov	x29, x29
10616c7cc: 946aea5f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c7d0: aa0003f5    	mov	x21, x0
10616c7d4: aa1403e1    	mov	x1, x20
10616c7d8: 946aea59    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c7dc: aa1d03fd    	mov	x29, x29
10616c7e0: 946aea5a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c7e4: aa0003fb    	mov	x27, x0
10616c7e8: d00d0128    	adrp	x8, 0x120192000 <dyld_stub_binder+0x120192000>
10616c7ec: f9463500    	ldr	x0, [x8, #0xc68] ; class=VOIPUIHelper
10616c7f0: d00cf128    	adrp	x8, 0x11ff92000 <dyld_stub_binder+0x11ff92000>
10616c7f4: f9459501    	ldr	x1, [x8, #0xb28] ; selector=shouldEnableMultiTalkInviteCardRevamp
10616c7f8: 946aea51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c7fc: aa0003f6    	mov	x22, x0
10616c800: 34002080    	cbz	w0, 0x10616cc10 <_Flutter_MMFoundation_BindContext+0x26487f4>
10616c804: aa1703e0    	mov	x0, x23
10616c808: aa1903e1    	mov	x1, x25
10616c80c: 946aea4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c810: aa1d03fd    	mov	x29, x29
10616c814: 946aea4d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c818: aa0003f7    	mov	x23, x0
10616c81c: f00cf308    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
10616c820: f9459901    	ldr	x1, [x8, #0xb30] ; selector=memberStatusMap
10616c824: 946aea46    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c828: aa1d03fd    	mov	x29, x29
10616c82c: 946aea47    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c830: aa0003f9    	mov	x25, x0
10616c834: 140000f8    	b	0x10616cc14 <_Flutter_MMFoundation_BindContext+0x26487f8>
10616c838: f9001ff7    	str	x23, [sp, #0x38]
10616c83c: f00d0028    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10616c840: f945e900    	ldr	x0, [x8, #0xbd0] ; class=MMContext
10616c844: aa1803e1    	mov	x1, x24
10616c848: 946aea3d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c84c: aa1d03fd    	mov	x29, x29
10616c850: 946aea3e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c854: aa0003f4    	mov	x20, x0
10616c858: f9467ea0    	ldr	x0, [x21, #0xcf8] ; cfstring=''
10616c85c: aa1603e1    	mov	x1, x22
10616c860: 946aea37    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c864: aa0003e2    	mov	x2, x0
10616c868: aa1403e0    	mov	x0, x20
10616c86c: aa1903e1    	mov	x1, x25
10616c870: 946aea33    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c874: aa1d03fd    	mov	x29, x29
10616c878: 946aea34    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c87c: aa0003fb    	mov	x27, x0
10616c880: b00cf328    	adrp	x8, 0x11ffd1000 <dyld_stub_binder+0x11ffd1000>
10616c884: f940d51a    	ldr	x26, [x8, #0x1a8] ; selector=currentRemoteContact
10616c888: aa1a03e1    	mov	x1, x26
10616c88c: 946aea2c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c890: aa1d03fd    	mov	x29, x29
10616c894: 946aea2d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c898: aa0003fc    	mov	x28, x0
10616c89c: 946aea2e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616c8a0: aa1b03e0    	mov	x0, x27
10616c8a4: 946aea2c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616c8a8: aa1403e0    	mov	x0, x20
10616c8ac: 946aea2a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616c8b0: b40007fc    	cbz	x28, 0x10616c9ac <_Flutter_MMFoundation_BindContext+0x2648590>
10616c8b4: f00d0028    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10616c8b8: f945e900    	ldr	x0, [x8, #0xbd0] ; class=MMContext
10616c8bc: aa1803e1    	mov	x1, x24
10616c8c0: 946aea1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c8c4: aa1d03fd    	mov	x29, x29
10616c8c8: 946aea20    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c8cc: aa0003f4    	mov	x20, x0
10616c8d0: f9467ea0    	ldr	x0, [x21, #0xcf8] ; cfstring=''
10616c8d4: aa1603e1    	mov	x1, x22
10616c8d8: 946aea19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c8dc: aa0003e2    	mov	x2, x0
10616c8e0: aa1403e0    	mov	x0, x20
10616c8e4: aa1903e1    	mov	x1, x25
10616c8e8: 946aea15    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c8ec: aa1d03fd    	mov	x29, x29
10616c8f0: 946aea16    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c8f4: aa0003fb    	mov	x27, x0
10616c8f8: aa1a03e1    	mov	x1, x26
10616c8fc: 946aea10    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c900: aa1d03fd    	mov	x29, x29
10616c904: 946aea11    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c908: aa0003fa    	mov	x26, x0
10616c90c: f00ce668    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10616c910: f9434d01    	ldr	x1, [x8, #0x698] ; selector=m_nsUsrName
10616c914: 946aea0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c918: aa1d03fd    	mov	x29, x29
10616c91c: 946aea0b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c920: aa0003fc    	mov	x28, x0
10616c924: 900cf108    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
10616c928: f9450901    	ldr	x1, [x8, #0xa10] ; selector=m_fromUser
10616c92c: aa1303e0    	mov	x0, x19
10616c930: 946aea03    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c934: aa1d03fd    	mov	x29, x29
10616c938: 946aea04    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c93c: aa0003f5    	mov	x21, x0
10616c940: f00cfca8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10616c944: f943c901    	ldr	x1, [x8, #0x790] ; selector=isEqualToString:
10616c948: aa1c03e0    	mov	x0, x28
10616c94c: aa1503e2    	mov	x2, x21
10616c950: 946ae9fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c954: aa0003f7    	mov	x23, x0
10616c958: aa1503e0    	mov	x0, x21
10616c95c: 946ae9fe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616c960: aa1c03e0    	mov	x0, x28
10616c964: 946ae9fc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616c968: aa1a03e0    	mov	x0, x26
10616c96c: 946ae9fa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616c970: aa1b03e0    	mov	x0, x27
10616c974: 946ae9f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616c978: aa1403e0    	mov	x0, x20
10616c97c: 946ae9f6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616c980: 34000177    	cbz	w23, 0x10616c9ac <_Flutter_MMFoundation_BindContext+0x2648590>
10616c984: 52800080    	mov	w0, #0x4                ; =4
10616c988: 946a822e    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616c98c: 360020a0    	tbz	w0, #0x0, 0x10616cda0 <_Flutter_MMFoundation_BindContext+0x2648984>
10616c990: 52804534    	mov	w20, #0x229             ; =553
10616c994: f00c3795    	adrp	x21, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
10616c998: 9113a2b5    	add	x21, x21, #0x4e8 ; cfstring='It is talking to this remote user! (%@)'
10616c99c: 140000d8    	b	0x10616ccfc <_Flutter_MMFoundation_BindContext+0x26488e0>
10616c9a0: 52800015    	mov	w21, #0x0               ; =0
10616c9a4: d2800014    	mov	x20, #0x0               ; =0
10616c9a8: 140000bc    	b	0x10616cc98 <_Flutter_MMFoundation_BindContext+0x264887c>
10616c9ac: f00d0034    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
10616c9b0: 900cf108    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
10616c9b4: f9446501    	ldr	x1, [x8, #0x8c8] ; selector=isParaVaild
10616c9b8: aa1303e0    	mov	x0, x19
10616c9bc: 946ae9e0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c9c0: 36001840    	tbz	w0, #0x0, 0x10616ccc8 <_Flutter_MMFoundation_BindContext+0x26488ac>
10616c9c4: f945ea80    	ldr	x0, [x20, #0xbd0] ; class=MMContext
10616c9c8: aa1803e1    	mov	x1, x24
10616c9cc: 946ae9dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c9d0: aa1d03fd    	mov	x29, x29
10616c9d4: 946ae9dd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616c9d8: aa0003f4    	mov	x20, x0
10616c9dc: 900d0048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10616c9e0: f9401500    	ldr	x0, [x8, #0x28] ; class=CContactMgr
10616c9e4: aa1603e1    	mov	x1, x22
10616c9e8: 946ae9d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c9ec: aa0003e2    	mov	x2, x0
10616c9f0: aa1403e0    	mov	x0, x20
10616c9f4: aa1903e1    	mov	x1, x25
10616c9f8: 946ae9d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616c9fc: aa1d03fd    	mov	x29, x29
10616ca00: 946ae9d2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616ca04: aa0003f5    	mov	x21, x0
10616ca08: 900cf108    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
10616ca0c: f9450901    	ldr	x1, [x8, #0xa10] ; selector=m_fromUser
10616ca10: aa1303e0    	mov	x0, x19
10616ca14: 946ae9ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ca18: aa1d03fd    	mov	x29, x29
10616ca1c: 946ae9cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616ca20: aa0003f7    	mov	x23, x0
10616ca24: 900ce688    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10616ca28: f940c901    	ldr	x1, [x8, #0x190] ; selector=getContactByName:
10616ca2c: aa1503e0    	mov	x0, x21
10616ca30: aa1703e2    	mov	x2, x23
10616ca34: 946ae9c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ca38: aa1d03fd    	mov	x29, x29
10616ca3c: 946ae9c3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616ca40: aa0003f6    	mov	x22, x0
10616ca44: aa1703e0    	mov	x0, x23
10616ca48: 946ae9c3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616ca4c: aa1503e0    	mov	x0, x21
10616ca50: 946ae9c1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616ca54: aa1403e0    	mov	x0, x20
10616ca58: 946ae9bf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616ca5c: b4001df6    	cbz	x22, 0x10616ce18 <_Flutter_MMFoundation_BindContext+0x26489fc>
10616ca60: f00d0028    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10616ca64: f9457100    	ldr	x0, [x8, #0xae0]
10616ca68: 900cfca8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10616ca6c: f9460d01    	ldr	x1, [x8, #0xc18] ; selector=date
10616ca70: 946ae9b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ca74: aa1d03fd    	mov	x29, x29
10616ca78: 946ae9b4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616ca7c: aa0003f4    	mov	x20, x0
10616ca80: f00cfce8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10616ca84: f940a901    	ldr	x1, [x8, #0x150] ; selector=timeIntervalSince1970
10616ca88: 946ae9ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ca8c: 1e604008    	fmov	d8, d0
10616ca90: aa1403e0    	mov	x0, x20
10616ca94: 946ae9b0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616ca98: 900cf108    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
10616ca9c: f944c918    	ldr	x24, [x8, #0x990] ; selector=m_mode
10616caa0: aa1303e0    	mov	x0, x19
10616caa4: aa1803e1    	mov	x1, x24
10616caa8: 946ae9a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616caac: 7100041f    	cmp	w0, #0x1
10616cab0: f9401ff7    	ldr	x23, [sp, #0x38]
10616cab4: 540019a0    	b.eq	0x10616cde8 <_Flutter_MMFoundation_BindContext+0x26489cc>
10616cab8: aa1303e0    	mov	x0, x19
10616cabc: aa1803e1    	mov	x1, x24
10616cac0: 946ae99f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616cac4: 34001920    	cbz	w0, 0x10616cde8 <_Flutter_MMFoundation_BindContext+0x26489cc>
10616cac8: 52800080    	mov	w0, #0x4                ; =4
10616cacc: 946a81dd    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616cad0: 34000620    	cbz	w0, 0x10616cb94 <_Flutter_MMFoundation_BindContext+0x2648778>
10616cad4: 946ae9b3    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616cad8: aa0003f4    	mov	x20, x0
10616cadc: f00d0037    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
10616cae0: f94546e0    	ldr	x0, [x23, #0xa88]
10616cae4: 946ae99f    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616cae8: aa0003f5    	mov	x21, x0
10616caec: f94546f7    	ldr	x23, [x23, #0xa88]
10616caf0: aa1303e0    	mov	x0, x19
10616caf4: aa1803e1    	mov	x1, x24
10616caf8: 946ae991    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616cafc: d00cfce8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616cb00: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616cb04: a900fff3    	stp	x19, xzr, [sp, #0x8]
10616cb08: f90003e0    	str	x0, [sp]
10616cb0c: f00c3782    	adrp	x2, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
10616cb10: 91152042    	add	x2, x2, #0x548 ; cfstring='inviteType == %d not exist. reject this call! (%@)'
10616cb14: aa1703e0    	mov	x0, x23
10616cb18: 946ae989    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616cb1c: aa1d03fd    	mov	x29, x29
10616cb20: 946ae98a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616cb24: aa0003f7    	mov	x23, x0
10616cb28: d00cfca8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616cb2c: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616cb30: f00c1968    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616cb34: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
10616cb38: a90003e8    	stp	x8, x0, [sp]
10616cb3c: f00c1962    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616cb40: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616cb44: aa1503e0    	mov	x0, x21
10616cb48: 946ae97d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616cb4c: aa0003f5    	mov	x21, x0
10616cb50: aa1703e0    	mov	x0, x23
10616cb54: f9401ff7    	ldr	x23, [sp, #0x38]
10616cb58: 946ae97f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616cb5c: f00ac0e1    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616cb60: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616cb64: f00ac122    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616cb68: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616cb6c: 900ac144    	adrp	x4, 0x11b994000 <dyld_stub_binder+0x11b994000>
10616cb70: 9106c884    	add	x4, x4, #0x1b2 ; cstring='-[VoIPMPSubCallService genVoIPInvitationInfoWithMsg:Scene:NeedReport:]'
10616cb74: 52800080    	mov	w0, #0x4                ; =4
10616cb78: 52804903    	mov	w3, #0x248              ; =584
10616cb7c: aa1503e5    	mov	x5, x21
10616cb80: 946a81b1    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10616cb84: aa1503e0    	mov	x0, x21
10616cb88: 946ae973    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616cb8c: aa1403e0    	mov	x0, x20
10616cb90: 946ae987    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10616cb94: b94043e8    	ldr	w8, [sp, #0x40]
10616cb98: 34001a88    	cbz	w8, 0x10616cee8 <_Flutter_MMFoundation_BindContext+0x2648acc>
10616cb9c: b00960a8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10616cba0: fd41cd00    	ldr	d0, [x8, #0x398]
10616cba4: 1e600900    	fmul	d0, d8, d0
10616cba8: 9e790014    	fcvtzu	x20, d0
10616cbac: d00d0048    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
10616cbb0: f9421515    	ldr	x21, [x8, #0x428] ; class=VOIPReportData
10616cbb4: aa1303e0    	mov	x0, x19
10616cbb8: aa1703e1    	mov	x1, x23
10616cbbc: 946ae960    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616cbc0: aa0003f7    	mov	x23, x0
10616cbc4: 900cf108    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
10616cbc8: f9451101    	ldr	x1, [x8, #0xa20] ; selector=m_roomKey
10616cbcc: aa1303e0    	mov	x0, x19
10616cbd0: 946ae95b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616cbd4: aa0003f9    	mov	x25, x0
10616cbd8: aa1303e0    	mov	x0, x19
10616cbdc: aa1803e1    	mov	x1, x24
10616cbe0: 946ae957    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616cbe4: aa0003e4    	mov	x4, x0
10616cbe8: d00cf2e8    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
10616cbec: f9415901    	ldr	x1, [x8, #0x2b0] ; selector=ReportPushUIReportWithRoomId:WithRoomKey:WithRoomType:WithAckStatus:WithNetType:WithTimeStamp:
10616cbf0: aa1503e0    	mov	x0, x21
10616cbf4: aa1703e2    	mov	x2, x23
10616cbf8: aa1903e3    	mov	x3, x25
10616cbfc: 52800085    	mov	w5, #0x4                ; =4
10616cc00: 52800006    	mov	w6, #0x0                ; =0
10616cc04: aa1403e7    	mov	x7, x20
10616cc08: 946ae94d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616cc0c: 140000b7    	b	0x10616cee8 <_Flutter_MMFoundation_BindContext+0x2648acc>
10616cc10: d2800019    	mov	x25, #0x0               ; =0
10616cc14: f00cf128    	adrp	x8, 0x11ff93000 <dyld_stub_binder+0x11ff93000>
10616cc18: f944b101    	ldr	x1, [x8, #0x960] ; selector=initWithMonoMsg:roomID:roomKey:roomType:contact:isFromIlink:receiveTime:inviteMsg:inviteInfo:scene:memberStatusMap:
10616cc1c: a94423e6    	ldp	x6, x8, [sp, #0x40]
10616cc20: a901e7e8    	stp	x8, x25, [sp, #0x18]
10616cc24: a900effc    	stp	x28, x27, [sp, #0x8]
10616cc28: b90003ff    	str	wzr, [sp]
10616cc2c: a94283e3    	ldp	x3, x0, [sp, #0x28]
10616cc30: aa1303e2    	mov	x2, x19
10616cc34: d2800004    	mov	x4, #0x0                ; =0
10616cc38: 52800065    	mov	w5, #0x3                ; =3
10616cc3c: 52800027    	mov	w7, #0x1                ; =1
10616cc40: 946ae93f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616cc44: aa0003f4    	mov	x20, x0
10616cc48: 340000b6    	cbz	w22, 0x10616cc5c <_Flutter_MMFoundation_BindContext+0x2648840>
10616cc4c: aa1903e0    	mov	x0, x25
10616cc50: 946ae941    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616cc54: aa1703e0    	mov	x0, x23
10616cc58: 946ae93f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616cc5c: aa1b03e0    	mov	x0, x27
10616cc60: 946ae93d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616cc64: aa1503e0    	mov	x0, x21
10616cc68: 946ae93b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616cc6c: aa1c03e0    	mov	x0, x28
10616cc70: 946ae939    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616cc74: aa1a03e0    	mov	x0, x26
10616cc78: 946ae937    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616cc7c: aa1803e0    	mov	x0, x24
10616cc80: 946ae935    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616cc84: f9401fe0    	ldr	x0, [sp, #0x38]
10616cc88: 946ae933    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616cc8c: f94023e0    	ldr	x0, [sp, #0x40]
10616cc90: 946ae931    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616cc94: 52800055    	mov	w21, #0x2               ; =2
10616cc98: aa1303f6    	mov	x22, x19
10616cc9c: aa1603e0    	mov	x0, x22
10616cca0: 946ae92d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616cca4: aa1303e0    	mov	x0, x19
10616cca8: 946ae92b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616ccac: 321f02a8    	orr	w8, w21, #0x2
10616ccb0: 7100091f    	cmp	w8, #0x2
10616ccb4: 540007c1    	b.ne	0x10616cdac <_Flutter_MMFoundation_BindContext+0x2648990>
10616ccb8: aa1403e0    	mov	x0, x20
10616ccbc: 946ae91f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10616ccc0: aa1403f5    	mov	x21, x20
10616ccc4: 1400003b    	b	0x10616cdb0 <_Flutter_MMFoundation_BindContext+0x2648994>
10616ccc8: b94043e8    	ldr	w8, [sp, #0x40]
10616cccc: 340000c8    	cbz	w8, 0x10616cce4 <_Flutter_MMFoundation_BindContext+0x26488c8>
10616ccd0: 900d0168    	adrp	x8, 0x120198000 <dyld_stub_binder+0x120198000>
10616ccd4: f9463100    	ldr	x0, [x8, #0xc60] ; class=VoipMonoMsgIdkeyReport
10616ccd8: d00cf2e8    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
10616ccdc: f941fd01    	ldr	x1, [x8, #0x3f8] ; selector=logicUiErrorMsgType
10616cce0: 946ae917    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616cce4: 52800080    	mov	w0, #0x4                ; =4
10616cce8: 946a8156    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616ccec: 360005a0    	tbz	w0, #0x0, 0x10616cda0 <_Flutter_MMFoundation_BindContext+0x2648984>
10616ccf0: 52804674    	mov	w20, #0x233             ; =563
10616ccf4: f00c3795    	adrp	x21, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
10616ccf8: 911422b5    	add	x21, x21, #0x508 ; cfstring='para error! (%@)'
10616ccfc: 946ae929    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616cd00: aa0003f6    	mov	x22, x0
10616cd04: f00d0038    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
10616cd08: f9454700    	ldr	x0, [x24, #0xa88]
10616cd0c: 946ae915    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616cd10: aa0003f7    	mov	x23, x0
10616cd14: f9454700    	ldr	x0, [x24, #0xa88]
10616cd18: d00cfce8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616cd1c: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616cd20: a9007ff3    	stp	x19, xzr, [sp]
10616cd24: aa1503e2    	mov	x2, x21
10616cd28: 946ae905    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616cd2c: aa1d03fd    	mov	x29, x29
10616cd30: 946ae906    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616cd34: aa0003f5    	mov	x21, x0
10616cd38: d00cfca8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616cd3c: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616cd40: f00c1968    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616cd44: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
10616cd48: a90003e8    	stp	x8, x0, [sp]
10616cd4c: f00c1962    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616cd50: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616cd54: aa1703e0    	mov	x0, x23
10616cd58: 946ae8f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616cd5c: aa0003f7    	mov	x23, x0
10616cd60: aa1503e0    	mov	x0, x21
10616cd64: 946ae8fc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616cd68: f00ac0e1    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616cd6c: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616cd70: f00ac122    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616cd74: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616cd78: 900ac144    	adrp	x4, 0x11b994000 <dyld_stub_binder+0x11b994000>
10616cd7c: 9106c884    	add	x4, x4, #0x1b2 ; cstring='-[VoIPMPSubCallService genVoIPInvitationInfoWithMsg:Scene:NeedReport:]'
10616cd80: 52800080    	mov	w0, #0x4                ; =4
10616cd84: aa1403e3    	mov	x3, x20
10616cd88: aa1703e5    	mov	x5, x23
10616cd8c: 946a812e    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10616cd90: aa1703e0    	mov	x0, x23
10616cd94: 946ae8f0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616cd98: aa1603e0    	mov	x0, x22
10616cd9c: 946ae904    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10616cda0: aa1303e0    	mov	x0, x19
10616cda4: 946ae8ec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616cda8: d2800014    	mov	x20, #0x0               ; =0
10616cdac: d2800015    	mov	x21, #0x0               ; =0
10616cdb0: aa1403e0    	mov	x0, x20
10616cdb4: 946ae8e8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616cdb8: aa1303e0    	mov	x0, x19
10616cdbc: 946ae8e6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616cdc0: aa1503e0    	mov	x0, x21
10616cdc4: a94b7bfd    	ldp	x29, x30, [sp, #0xb0]
10616cdc8: a94a4ff4    	ldp	x20, x19, [sp, #0xa0]
10616cdcc: a94957f6    	ldp	x22, x21, [sp, #0x90]
10616cdd0: a9485ff8    	ldp	x24, x23, [sp, #0x80]
10616cdd4: a94767fa    	ldp	x26, x25, [sp, #0x70]
10616cdd8: a9466ffc    	ldp	x28, x27, [sp, #0x60]
10616cddc: 6d4523e9    	ldp	d9, d8, [sp, #0x50]
10616cde0: 910303ff    	add	sp, sp, #0xc0
10616cde4: 146ae8e3    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
10616cde8: f00d0128    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
10616cdec: f9467d00    	ldr	x0, [x8, #0xcf8] ; class=VoIPInvitationInfo
10616cdf0: f00cf308    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
10616cdf4: f945c901    	ldr	x1, [x8, #0xb90] ; selector=infoWithVoipMonoMsg:scene:
10616cdf8: aa1303e2    	mov	x2, x19
10616cdfc: f94027e3    	ldr	x3, [sp, #0x48]
10616ce00: 946ae8cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ce04: aa1d03fd    	mov	x29, x29
10616ce08: 946ae8d0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616ce0c: aa0003f4    	mov	x20, x0
10616ce10: 52800055    	mov	w21, #0x2               ; =2
10616ce14: 17ffffa2    	b	0x10616cc9c <_Flutter_MMFoundation_BindContext+0x2648880>
10616ce18: b94043e8    	ldr	w8, [sp, #0x40]
10616ce1c: 340000c8    	cbz	w8, 0x10616ce34 <_Flutter_MMFoundation_BindContext+0x2648a18>
10616ce20: 900d0168    	adrp	x8, 0x120198000 <dyld_stub_binder+0x120198000>
10616ce24: f9463100    	ldr	x0, [x8, #0xc60] ; class=VoipMonoMsgIdkeyReport
10616ce28: d00cf2e8    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
10616ce2c: f9420101    	ldr	x1, [x8, #0x400] ; selector=logicUiErrorInviteUserNotExist
10616ce30: 946ae8c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ce34: 52800080    	mov	w0, #0x4                ; =4
10616ce38: 946a8102    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616ce3c: 34000560    	cbz	w0, 0x10616cee8 <_Flutter_MMFoundation_BindContext+0x2648acc>
10616ce40: 946ae8d8    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616ce44: aa0003f4    	mov	x20, x0
10616ce48: f00d0037    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
10616ce4c: f94546e0    	ldr	x0, [x23, #0xa88]
10616ce50: 946ae8c4    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616ce54: aa0003f5    	mov	x21, x0
10616ce58: f94546e0    	ldr	x0, [x23, #0xa88]
10616ce5c: d00cfce8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616ce60: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616ce64: a9007ff3    	stp	x19, xzr, [sp]
10616ce68: f00c3782    	adrp	x2, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
10616ce6c: 9114a042    	add	x2, x2, #0x528 ; cfstring='invalid username! (%@)'
10616ce70: 946ae8b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ce74: aa1d03fd    	mov	x29, x29
10616ce78: 946ae8b4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616ce7c: aa0003f7    	mov	x23, x0
10616ce80: d00cfca8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616ce84: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616ce88: f00c1968    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616ce8c: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
10616ce90: a90003e8    	stp	x8, x0, [sp]
10616ce94: f00c1962    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616ce98: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616ce9c: aa1503e0    	mov	x0, x21
10616cea0: 946ae8a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616cea4: aa0003f5    	mov	x21, x0
10616cea8: aa1703e0    	mov	x0, x23
10616ceac: 946ae8aa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616ceb0: f00ac0e1    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616ceb4: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616ceb8: f00ac122    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616cebc: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616cec0: 900ac144    	adrp	x4, 0x11b994000 <dyld_stub_binder+0x11b994000>
10616cec4: 9106c884    	add	x4, x4, #0x1b2 ; cstring='-[VoIPMPSubCallService genVoIPInvitationInfoWithMsg:Scene:NeedReport:]'
10616cec8: 52800080    	mov	w0, #0x4                ; =4
10616cecc: 52804763    	mov	w3, #0x23b              ; =571
10616ced0: aa1503e5    	mov	x5, x21
10616ced4: 946a80dc    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10616ced8: aa1503e0    	mov	x0, x21
10616cedc: 946ae89e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616cee0: aa1403e0    	mov	x0, x20
10616cee4: 946ae8b2    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10616cee8: d2800014    	mov	x20, #0x0               ; =0
10616ceec: 52800035    	mov	w21, #0x1               ; =1
10616cef0: 17ffff6b    	b	0x10616cc9c <_Flutter_MMFoundation_BindContext+0x2648880>
