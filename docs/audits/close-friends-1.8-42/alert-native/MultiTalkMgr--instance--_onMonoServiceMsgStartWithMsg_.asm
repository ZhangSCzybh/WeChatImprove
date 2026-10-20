
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104f52754: d103c3ff    	sub	sp, sp, #0xf0
104f52758: a9096ffc    	stp	x28, x27, [sp, #0x90]
104f5275c: a90a67fa    	stp	x26, x25, [sp, #0xa0]
104f52760: a90b5ff8    	stp	x24, x23, [sp, #0xb0]
104f52764: a90c57f6    	stp	x22, x21, [sp, #0xc0]
104f52768: a90d4ff4    	stp	x20, x19, [sp, #0xd0]
104f5276c: a90e7bfd    	stp	x29, x30, [sp, #0xe0]
104f52770: 910383fd    	add	x29, sp, #0xe0
104f52774: aa0203f3    	mov	x19, x2
104f52778: aa0003f4    	mov	x20, x0
104f5277c: b00de768    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
104f52780: 52800029    	mov	w9, #0x1                ; =1
104f52784: 39114509    	strb	w9, [x8, #0x451]
104f52788: aa0203e0    	mov	x0, x2
104f5278c: 94b3526b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104f52790: b00d9208    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104f52794: f9467900    	ldr	x0, [x8, #0xcf0] ; class=MultiTalkMonoMsg
104f52798: b00d8d68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104f5279c: f947ad16    	ldr	x22, [x8, #0xf58] ; selector=class
104f527a0: aa1603e1    	mov	x1, x22
104f527a4: 94b35266    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f527a8: aa0003e2    	mov	x2, x0
104f527ac: b00d8d88    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104f527b0: f9442d01    	ldr	x1, [x8, #0x858] ; selector=isKindOfClass:
104f527b4: aa1303e0    	mov	x0, x19
104f527b8: 94b35261    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f527bc: 36000380    	tbz	w0, #0x0, 0x104f5282c <_Flutter_MMFoundation_BindContext+0x142e410>
104f527c0: d00d81c8    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104f527c4: f9446101    	ldr	x1, [x8, #0x8c0] ; selector=isCancelMsg
104f527c8: aa1303e0    	mov	x0, x19
104f527cc: 94b3525c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f527d0: 340005c0    	cbz	w0, 0x104f52888 <_Flutter_MMFoundation_BindContext+0x142e46c>
104f527d4: b00d9208    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104f527d8: f9469d00    	ldr	x0, [x8, #0xd38] ; class=MultiTalkMonoMsgIdKeyReport
104f527dc: f00d8208    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
104f527e0: f9405501    	ldr	x1, [x8, #0xa8] ; selector=logicStartErrorNotInviteMsg
104f527e4: 94b35256    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f527e8: b00d9108    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104f527ec: f9453500    	ldr	x0, [x8, #0xa68] ; class=iConsole
104f527f0: f00d7728    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104f527f4: f942a901    	ldr	x1, [x8, #0x550] ; selector=logWithLevel:module:errorCode:file:line:func:format:
104f527f8: b00cc388    	adrp	x8, 0x11e7c3000 <dyld_stub_binder+0x11e7c3000>
104f527fc: 913d2108    	add	x8, x8, #0xf48 ; cfstring='is cancel msg.'
104f52800: f90003e8    	str	x8, [sp]
104f52804: b00b4663    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104f52808: 911a5863    	add	x3, x3, #0x696 ; cstring='MonoMsg'
104f5280c: 900b4725    	adrp	x5, 0x11b836000 <dyld_stub_binder+0x11b836000>
104f52810: 912f08a5    	add	x5, x5, #0xbc2 ; cstring='MultiTalkMgr.mm'
104f52814: 900b4747    	adrp	x7, 0x11b83a000 <dyld_stub_binder+0x11b83a000>
104f52818: 912f3ce7    	add	x7, x7, #0xbcf ; cstring='-[MultiTalkMgr _onMonoServiceMsgStartWithMsg:]'
104f5281c: 52800082    	mov	w2, #0x4                ; =4
104f52820: 52800004    	mov	w4, #0x0                ; =0
104f52824: 52822326    	mov	w6, #0x1119             ; =4377
104f52828: 14000016    	b	0x104f52880 <_Flutter_MMFoundation_BindContext+0x142e464>
104f5282c: b00d9208    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104f52830: f9469d00    	ldr	x0, [x8, #0xd38] ; class=MultiTalkMonoMsgIdKeyReport
104f52834: f00d8208    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
104f52838: f9405101    	ldr	x1, [x8, #0xa0] ; selector=logicStartErrorMsgType
104f5283c: 94b35240    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52840: b00d9108    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104f52844: f9453500    	ldr	x0, [x8, #0xa68] ; class=iConsole
104f52848: f00d7728    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104f5284c: f942a901    	ldr	x1, [x8, #0x550] ; selector=logWithLevel:module:errorCode:file:line:func:format:
104f52850: b00cc388    	adrp	x8, 0x11e7c3000 <dyld_stub_binder+0x11e7c3000>
104f52854: 913ca108    	add	x8, x8, #0xf28 ; cfstring='msg not MultiTalkMonoMsg.'
104f52858: f90003e8    	str	x8, [sp]
104f5285c: b00b4663    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104f52860: 911a5863    	add	x3, x3, #0x696 ; cstring='MonoMsg'
104f52864: 900b4725    	adrp	x5, 0x11b836000 <dyld_stub_binder+0x11b836000>
104f52868: 912f08a5    	add	x5, x5, #0xbc2 ; cstring='MultiTalkMgr.mm'
104f5286c: 900b4747    	adrp	x7, 0x11b83a000 <dyld_stub_binder+0x11b83a000>
104f52870: 912f3ce7    	add	x7, x7, #0xbcf ; cstring='-[MultiTalkMgr _onMonoServiceMsgStartWithMsg:]'
104f52874: 52800082    	mov	w2, #0x4                ; =4
104f52878: 52800004    	mov	w4, #0x0                ; =0
104f5287c: 52822266    	mov	w6, #0x1113             ; =4371
104f52880: 94b3522f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52884: 1400030a    	b	0x104f534ac <_Flutter_MMFoundation_BindContext+0x142f090>
104f52888: aa1303e0    	mov	x0, x19
104f5288c: 94b3522b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104f52890: d00d81c8    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104f52894: f9446501    	ldr	x1, [x8, #0x8c8] ; selector=isParaVaild
104f52898: 94b35229    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f5289c: 36001a80    	tbz	w0, #0x0, 0x104f52bec <_Flutter_MMFoundation_BindContext+0x142e7d0>
104f528a0: b00d8208    	adrp	x8, 0x11ff93000 <dyld_stub_binder+0x11ff93000>
104f528a4: f9436501    	ldr	x1, [x8, #0x6c8] ; selector=m_group
104f528a8: aa1303e0    	mov	x0, x19
104f528ac: 94b35224    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f528b0: aa1d03fd    	mov	x29, x29
104f528b4: 94b35225    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f528b8: f90033e0    	str	x0, [sp, #0x60]
104f528bc: b00d911c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
104f528c0: f945eb80    	ldr	x0, [x28, #0xbd0] ; class=MMContext
104f528c4: d00d8d68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104f528c8: f944e918    	ldr	x24, [x8, #0x9d0] ; selector=currentContext
104f528cc: aa1803e1    	mov	x1, x24
104f528d0: 94b3521b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f528d4: aa1d03fd    	mov	x29, x29
104f528d8: 94b3521c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f528dc: aa0003f7    	mov	x23, x0
104f528e0: d00d90e8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
104f528e4: f9465102    	ldr	x2, [x8, #0xca0] ; protocol=MultiTalkMgrExt
104f528e8: d00d8208    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f528ec: f945e903    	ldr	x3, [x8, #0xbd0] ; selector=onBeginMultiTalk
104f528f0: 900d7748    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104f528f4: f940491a    	ldr	x26, [x8, #0x90] ; selector=callExtension:selector:block:
104f528f8: b00c38c4    	adrp	x4, 0x11d66b000 <dyld_stub_binder+0x11d66b000>
104f528fc: 91314084    	add	x4, x4, #0xc50
104f52900: aa1a03e1    	mov	x1, x26
104f52904: 94b3520e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52908: aa1703e0    	mov	x0, x23
104f5290c: 94b35212    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f52910: b00d9208    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104f52914: f9469d00    	ldr	x0, [x8, #0xd38] ; class=MultiTalkMonoMsgIdKeyReport
104f52918: f00d8208    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
104f5291c: f9405d01    	ldr	x1, [x8, #0xb8] ; selector=logicStartUIOk
104f52920: 94b35207    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52924: 52800040    	mov	w0, #0x2                ; =2
104f52928: 94b2ea46    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
104f5292c: 34000560    	cbz	w0, 0x104f529d8 <_Flutter_MMFoundation_BindContext+0x142e5bc>
104f52930: 94b3521c    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
104f52934: aa0003f7    	mov	x23, x0
104f52938: b00d9115    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
104f5293c: f94546a0    	ldr	x0, [x21, #0xa88]
104f52940: 94b35208    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104f52944: aa0003f9    	mov	x25, x0
104f52948: f94546a0    	ldr	x0, [x21, #0xa88]
104f5294c: 900d8dc8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104f52950: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
104f52954: f90003ff    	str	xzr, [sp]
104f52958: 900cc382    	adrp	x2, 0x11e7c2000 <dyld_stub_binder+0x11e7c2000>
104f5295c: 912e2042    	add	x2, x2, #0xb88 ; cfstring='start window.'
104f52960: 94b351f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52964: aa1d03fd    	mov	x29, x29
104f52968: 94b351f8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f5296c: aa0003fb    	mov	x27, x0
104f52970: 900d8d88    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104f52974: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
104f52978: b00caa48    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f5297c: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
104f52980: a90003e8    	stp	x8, x0, [sp]
104f52984: b00caa42    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f52988: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
104f5298c: aa1903e0    	mov	x0, x25
104f52990: 94b351eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52994: aa0003f9    	mov	x25, x0
104f52998: aa1b03e0    	mov	x0, x27
104f5299c: 94b351ee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f529a0: b00b4661    	adrp	x1, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104f529a4: 9124bc21    	add	x1, x1, #0x92f ; cstring='MultiTalk'
104f529a8: 900b4722    	adrp	x2, 0x11b836000 <dyld_stub_binder+0x11b836000>
104f529ac: 912f0842    	add	x2, x2, #0xbc2 ; cstring='MultiTalkMgr.mm'
104f529b0: 900b4744    	adrp	x4, 0x11b83a000 <dyld_stub_binder+0x11b83a000>
104f529b4: 912f3c84    	add	x4, x4, #0xbcf ; cstring='-[MultiTalkMgr _onMonoServiceMsgStartWithMsg:]'
104f529b8: 52800040    	mov	w0, #0x2                ; =2
104f529bc: 52822523    	mov	w3, #0x1129             ; =4393
104f529c0: aa1903e5    	mov	x5, x25
104f529c4: 94b2ea20    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
104f529c8: aa1903e0    	mov	x0, x25
104f529cc: 94b351e2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f529d0: aa1703e0    	mov	x0, x23
104f529d4: 94b351f6    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
104f529d8: b00d9208    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104f529dc: f9462d17    	ldr	x23, [x8, #0xc58] ; class=MultitalkKvReport
104f529e0: d00d7bc8    	adrp	x8, 0x11fecc000 <dyld_stub_binder+0x11fecc000>
104f529e4: f947f501    	ldr	x1, [x8, #0xfe8] ; selector=mMultiTalkGroupId
104f529e8: f94033e0    	ldr	x0, [sp, #0x60]
104f529ec: 94b351d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f529f0: aa1d03fd    	mov	x29, x29
104f529f4: 94b351d5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f529f8: aa0003f9    	mov	x25, x0
104f529fc: f00d8208    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
104f52a00: f9406101    	ldr	x1, [x8, #0xc0] ; selector=receiveReportWithResult:groupId:
104f52a04: aa1703e0    	mov	x0, x23
104f52a08: 52800022    	mov	w2, #0x1                ; =1
104f52a0c: aa1903e3    	mov	x3, x25
104f52a10: 94b351cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52a14: aa1903e0    	mov	x0, x25
104f52a18: 94b351cf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f52a1c: f945eb80    	ldr	x0, [x28, #0xbd0] ; class=MMContext
104f52a20: aa1803e1    	mov	x1, x24
104f52a24: 94b351c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52a28: aa1d03fd    	mov	x29, x29
104f52a2c: 94b351c7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f52a30: aa0003f7    	mov	x23, x0
104f52a34: f00d90e8    	adrp	x8, 0x120171000 <dyld_stub_binder+0x120171000>
104f52a38: f941b102    	ldr	x2, [x8, #0x360] ; protocol=MonoServiceLogicExt
104f52a3c: d00d8208    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f52a40: f9454503    	ldr	x3, [x8, #0xa88] ; selector=onMonoServiceMultitalkWillStart
104f52a44: b00c38c4    	adrp	x4, 0x11d66b000 <dyld_stub_binder+0x11d66b000>
104f52a48: 9131c084    	add	x4, x4, #0xc70
104f52a4c: f9001ffa    	str	x26, [sp, #0x38]
104f52a50: aa1a03e1    	mov	x1, x26
104f52a54: 94b351ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52a58: aa1703e0    	mov	x0, x23
104f52a5c: 94b351be    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f52a60: f945eb80    	ldr	x0, [x28, #0xbd0] ; class=MMContext
104f52a64: aa1803e1    	mov	x1, x24
104f52a68: 94b351b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52a6c: aa1d03fd    	mov	x29, x29
104f52a70: 94b351b6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f52a74: aa0003f7    	mov	x23, x0
104f52a78: f00d9108    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
104f52a7c: f943b500    	ldr	x0, [x8, #0x768] ; class=TXLiveBaseAdapter
104f52a80: aa1603e1    	mov	x1, x22
104f52a84: 94b351ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52a88: aa0003e2    	mov	x2, x0
104f52a8c: f00d7728    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104f52a90: f9464101    	ldr	x1, [x8, #0xc80] ; selector=getService:
104f52a94: f9002be1    	str	x1, [sp, #0x50]
104f52a98: aa1703e0    	mov	x0, x23
104f52a9c: 94b351a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52aa0: aa1d03fd    	mov	x29, x29
104f52aa4: 94b351a9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f52aa8: aa0003f9    	mov	x25, x0
104f52aac: d00d8128    	adrp	x8, 0x11ff78000 <dyld_stub_binder+0x11ff78000>
104f52ab0: f9453d01    	ldr	x1, [x8, #0xa78] ; selector=setIsInVoIP:
104f52ab4: 52800022    	mov	w2, #0x1                ; =1
104f52ab8: 94b351a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52abc: aa1903e0    	mov	x0, x25
104f52ac0: 94b351a5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f52ac4: aa1703e0    	mov	x0, x23
104f52ac8: 94b351a3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f52acc: d00d81c8    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104f52ad0: f9450901    	ldr	x1, [x8, #0xa10] ; selector=m_fromUser
104f52ad4: aa1303e0    	mov	x0, x19
104f52ad8: f90013e1    	str	x1, [sp, #0x20]
104f52adc: 94b35198    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52ae0: aa1d03fd    	mov	x29, x29
104f52ae4: 94b35199    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f52ae8: aa0003fa    	mov	x26, x0
104f52aec: b00d9215    	adrp	x21, 0x120193000 <dyld_stub_binder+0x120193000>
104f52af0: f94616a0    	ldr	x0, [x21, #0xc28] ; class=VoIPConfigUtils
104f52af4: 900d8208    	adrp	x8, 0x11ff92000 <dyld_stub_binder+0x11ff92000>
104f52af8: f9432d01    	ldr	x1, [x8, #0x658] ; selector=isCallCardSupportIgnore
104f52afc: 94b35190    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52b00: f90027fa    	str	x26, [sp, #0x48]
104f52b04: 34000a20    	cbz	w0, 0x104f52c48 <_Flutter_MMFoundation_BindContext+0x142e82c>
104f52b08: f94616a0    	ldr	x0, [x21, #0xc28] ; class=VoIPConfigUtils
104f52b0c: 900d8208    	adrp	x8, 0x11ff92000 <dyld_stub_binder+0x11ff92000>
104f52b10: f9435d01    	ldr	x1, [x8, #0x6b8] ; selector=isCallFullScreenSupportIgnore
104f52b14: 94b3518a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52b18: 34000980    	cbz	w0, 0x104f52c48 <_Flutter_MMFoundation_BindContext+0x142e82c>
104f52b1c: f00d8208    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
104f52b20: f9406501    	ldr	x1, [x8, #0xc8] ; selector=m_muteNotification
104f52b24: aa1303e0    	mov	x0, x19
104f52b28: 94b35185    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52b2c: 340008e0    	cbz	w0, 0x104f52c48 <_Flutter_MMFoundation_BindContext+0x142e82c>
104f52b30: 52800040    	mov	w0, #0x2                ; =2
104f52b34: 94b2e9c3    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
104f52b38: 34000560    	cbz	w0, 0x104f52be4 <_Flutter_MMFoundation_BindContext+0x142e7c8>
104f52b3c: 94b35199    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
104f52b40: aa0003f7    	mov	x23, x0
104f52b44: b00d9115    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
104f52b48: f94546a0    	ldr	x0, [x21, #0xa88]
104f52b4c: 94b35185    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104f52b50: aa0003f9    	mov	x25, x0
104f52b54: f94546a0    	ldr	x0, [x21, #0xa88]
104f52b58: 900d8dc8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104f52b5c: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
104f52b60: a9007ffa    	stp	x26, xzr, [sp]
104f52b64: b00cc382    	adrp	x2, 0x11e7c3000 <dyld_stub_binder+0x11e7c3000>
104f52b68: 913da042    	add	x2, x2, #0xf68 ; cfstring='auto ignore group call from %@, will collapse invitation card to SceneNone.'
104f52b6c: 94b35174    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52b70: aa1d03fd    	mov	x29, x29
104f52b74: 94b35175    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f52b78: aa0003fb    	mov	x27, x0
104f52b7c: 900d8d88    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104f52b80: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
104f52b84: b00caa48    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f52b88: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
104f52b8c: a90003e8    	stp	x8, x0, [sp]
104f52b90: b00caa42    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f52b94: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
104f52b98: aa1903e0    	mov	x0, x25
104f52b9c: 94b35168    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52ba0: aa0003f9    	mov	x25, x0
104f52ba4: aa1b03e0    	mov	x0, x27
104f52ba8: 94b3516b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f52bac: b00b4661    	adrp	x1, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104f52bb0: 9124bc21    	add	x1, x1, #0x92f ; cstring='MultiTalk'
104f52bb4: 900b4722    	adrp	x2, 0x11b836000 <dyld_stub_binder+0x11b836000>
104f52bb8: 912f0842    	add	x2, x2, #0xbc2 ; cstring='MultiTalkMgr.mm'
104f52bbc: 900b4744    	adrp	x4, 0x11b83a000 <dyld_stub_binder+0x11b83a000>
104f52bc0: 912f3c84    	add	x4, x4, #0xbcf ; cstring='-[MultiTalkMgr _onMonoServiceMsgStartWithMsg:]'
104f52bc4: 52800040    	mov	w0, #0x2                ; =2
104f52bc8: 52822683    	mov	w3, #0x1134             ; =4404
104f52bcc: aa1903e5    	mov	x5, x25
104f52bd0: 94b2e99d    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
104f52bd4: aa1903e0    	mov	x0, x25
104f52bd8: 94b3515f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f52bdc: aa1703e0    	mov	x0, x23
104f52be0: 94b35173    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
104f52be4: 52800039    	mov	w25, #0x1               ; =1
104f52be8: 14000019    	b	0x104f52c4c <_Flutter_MMFoundation_BindContext+0x142e830>
104f52bec: b00d9208    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104f52bf0: f9469d00    	ldr	x0, [x8, #0xd38] ; class=MultiTalkMonoMsgIdKeyReport
104f52bf4: f00d8208    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
104f52bf8: f9405901    	ldr	x1, [x8, #0xb0] ; selector=logicStartErrorMsgNotVaild
104f52bfc: 94b35150    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52c00: b00d9108    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104f52c04: f9453500    	ldr	x0, [x8, #0xa68] ; class=iConsole
104f52c08: f00d7728    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104f52c0c: f942a901    	ldr	x1, [x8, #0x550] ; selector=logWithLevel:module:errorCode:file:line:func:format:
104f52c10: f00cc308    	adrp	x8, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
104f52c14: 910e2108    	add	x8, x8, #0x388 ; cfstring='para error.'
104f52c18: f90003e8    	str	x8, [sp]
104f52c1c: b00b4663    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104f52c20: 911a5863    	add	x3, x3, #0x696 ; cstring='MonoMsg'
104f52c24: 900b4725    	adrp	x5, 0x11b836000 <dyld_stub_binder+0x11b836000>
104f52c28: 912f08a5    	add	x5, x5, #0xbc2 ; cstring='MultiTalkMgr.mm'
104f52c2c: 900b4747    	adrp	x7, 0x11b83a000 <dyld_stub_binder+0x11b83a000>
104f52c30: 912f3ce7    	add	x7, x7, #0xbcf ; cstring='-[MultiTalkMgr _onMonoServiceMsgStartWithMsg:]'
104f52c34: 52800082    	mov	w2, #0x4                ; =4
104f52c38: 52800004    	mov	w4, #0x0                ; =0
104f52c3c: 52822406    	mov	w6, #0x1120             ; =4384
104f52c40: 94b3513f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52c44: 14000218    	b	0x104f534a4 <_Flutter_MMFoundation_BindContext+0x142f088>
104f52c48: 52800019    	mov	w25, #0x0               ; =0
104f52c4c: b00d9208    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104f52c50: f942e500    	ldr	x0, [x8, #0x5c8] ; class=MultiTalkWindowV2
104f52c54: 94b35141    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104f52c58: aa0003f7    	mov	x23, x0
104f52c5c: d00d8208    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f52c60: f9454901    	ldr	x1, [x8, #0xa90] ; selector=setM_mainWindow:
104f52c64: aa1403e0    	mov	x0, x20
104f52c68: aa1703e2    	mov	x2, x23
104f52c6c: 94b35134    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52c70: aa1703e0    	mov	x0, x23
104f52c74: 94b35138    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f52c78: d00d8208    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f52c7c: f943fd01    	ldr	x1, [x8, #0x7f8] ; selector=m_mainWindow
104f52c80: aa1403e0    	mov	x0, x20
104f52c84: f9001be1    	str	x1, [sp, #0x30]
104f52c88: 94b3512d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52c8c: aa1d03fd    	mov	x29, x29
104f52c90: 94b3512e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f52c94: aa0003f7    	mov	x23, x0
104f52c98: f00d8208    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
104f52c9c: f9406901    	ldr	x1, [x8, #0xd0] ; selector=setM_monoMsg:
104f52ca0: aa1303e2    	mov	x2, x19
104f52ca4: 94b35126    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52ca8: aa1703e0    	mov	x0, x23
104f52cac: 94b3512a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f52cb0: b00d9208    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104f52cb4: f946b500    	ldr	x0, [x8, #0xd68] ; class=MultiTalkMainViewController
104f52cb8: 94b35128    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104f52cbc: aa0003f5    	mov	x21, x0
104f52cc0: b9005ff9    	str	w25, [sp, #0x5c]
104f52cc4: 340000d9    	cbz	w25, 0x104f52cdc <_Flutter_MMFoundation_BindContext+0x142e8c0>
104f52cc8: b00d8208    	adrp	x8, 0x11ff93000 <dyld_stub_binder+0x11ff93000>
104f52ccc: f9433d01    	ldr	x1, [x8, #0x678] ; selector=setFromIgnore:
104f52cd0: aa1503e0    	mov	x0, x21
104f52cd4: 52800022    	mov	w2, #0x1                ; =1
104f52cd8: 94b35119    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52cdc: aa1503f9    	mov	x25, x21
104f52ce0: f945eb80    	ldr	x0, [x28, #0xbd0] ; class=MMContext
104f52ce4: aa1803e1    	mov	x1, x24
104f52ce8: 94b35115    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52cec: aa1d03fd    	mov	x29, x29
104f52cf0: 94b35116    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f52cf4: aa0003f7    	mov	x23, x0
104f52cf8: b00d9155    	adrp	x21, 0x12017b000 <dyld_stub_binder+0x12017b000>
104f52cfc: f940fea0    	ldr	x0, [x21, #0x1f8] ; class=VoIPilinkMgr
104f52d00: aa1603e1    	mov	x1, x22
104f52d04: 94b3510e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52d08: aa0003e2    	mov	x2, x0
104f52d0c: aa1703e0    	mov	x0, x23
104f52d10: f9402bfb    	ldr	x27, [sp, #0x50]
104f52d14: aa1b03e1    	mov	x1, x27
104f52d18: 94b35109    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52d1c: aa1d03fd    	mov	x29, x29
104f52d20: 94b3510a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f52d24: aa1c03fa    	mov	x26, x28
104f52d28: aa0003fc    	mov	x28, x0
104f52d2c: f00d7988    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
104f52d30: f9458501    	ldr	x1, [x8, #0xb08] ; selector=getIfThisTalkIlink
104f52d34: 94b35102    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52d38: f90023f8    	str	x24, [sp, #0x40]
104f52d3c: 360003e0    	tbz	w0, #0x0, 0x104f52db8 <_Flutter_MMFoundation_BindContext+0x142e99c>
104f52d40: f945eb40    	ldr	x0, [x26, #0xbd0]
104f52d44: aa1803e1    	mov	x1, x24
104f52d48: 94b350fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52d4c: aa1d03fd    	mov	x29, x29
104f52d50: 94b350fe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f52d54: aa0003fa    	mov	x26, x0
104f52d58: f940fea0    	ldr	x0, [x21, #0x1f8] ; class=VoIPilinkMgr
104f52d5c: aa1603e1    	mov	x1, x22
104f52d60: 94b350f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52d64: aa0003e2    	mov	x2, x0
104f52d68: aa1a03e0    	mov	x0, x26
104f52d6c: aa1b03e1    	mov	x1, x27
104f52d70: 94b350f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52d74: aa1d03fd    	mov	x29, x29
104f52d78: 94b350f4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f52d7c: aa0003f5    	mov	x21, x0
104f52d80: 900d7d28    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
104f52d84: f9402d01    	ldr	x1, [x8, #0x58] ; selector=changeToMultiTalk
104f52d88: 94b350ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52d8c: aa0003e2    	mov	x2, x0
104f52d90: d00d8208    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f52d94: f945f101    	ldr	x1, [x8, #0xbe0] ; selector=setIsFromNewIlink:
104f52d98: aa1903fb    	mov	x27, x25
104f52d9c: aa1903e0    	mov	x0, x25
104f52da0: 94b350e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52da4: aa1503e0    	mov	x0, x21
104f52da8: 94b350eb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f52dac: aa1a03e0    	mov	x0, x26
104f52db0: 94b350e9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f52db4: 14000007    	b	0x104f52dd0 <_Flutter_MMFoundation_BindContext+0x142e9b4>
104f52db8: d00d8208    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f52dbc: f945f101    	ldr	x1, [x8, #0xbe0] ; selector=setIsFromNewIlink:
104f52dc0: aa1903fb    	mov	x27, x25
104f52dc4: aa1903e0    	mov	x0, x25
104f52dc8: 52800002    	mov	w2, #0x0                ; =0
104f52dcc: 94b350dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52dd0: aa1c03e0    	mov	x0, x28
104f52dd4: 94b350e0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f52dd8: aa1703e0    	mov	x0, x23
104f52ddc: 94b350de    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f52de0: d00d8208    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f52de4: f9454d01    	ldr	x1, [x8, #0xa98] ; selector=setMainViewController:
104f52de8: aa1403e0    	mov	x0, x20
104f52dec: aa1b03e2    	mov	x2, x27
104f52df0: 94b350d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52df4: f00d7948    	adrp	x8, 0x11fe7d000 <dyld_stub_binder+0x11fe7d000>
104f52df8: f9420515    	ldr	x21, [x8, #0x408] ; selector=setM_mainWindowDelegate:
104f52dfc: aa1b03e0    	mov	x0, x27
104f52e00: aa1503e1    	mov	x1, x21
104f52e04: aa1403e2    	mov	x2, x20
104f52e08: 94b350cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52e0c: aa1403e0    	mov	x0, x20
104f52e10: f9401bfc    	ldr	x28, [sp, #0x30]
104f52e14: aa1c03e1    	mov	x1, x28
104f52e18: 94b350c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52e1c: aa1d03fd    	mov	x29, x29
104f52e20: 94b350ca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f52e24: aa0003f7    	mov	x23, x0
104f52e28: aa1503e1    	mov	x1, x21
104f52e2c: aa1b03e2    	mov	x2, x27
104f52e30: 94b350c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52e34: aa1703e0    	mov	x0, x23
104f52e38: 94b350c7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f52e3c: d00d8208    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f52e40: f9455101    	ldr	x1, [x8, #0xaa0] ; selector=initVoipCheckAudioDeviceObj
104f52e44: aa1403e0    	mov	x0, x20
104f52e48: 94b350bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52e4c: 52800040    	mov	w0, #0x2                ; =2
104f52e50: 94b2e8fc    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
104f52e54: b9405ff9    	ldr	w25, [sp, #0x5c]
104f52e58: 34000560    	cbz	w0, 0x104f52f04 <_Flutter_MMFoundation_BindContext+0x142eae8>
104f52e5c: 94b350d1    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
104f52e60: aa0003f5    	mov	x21, x0
104f52e64: b00d911a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
104f52e68: f9454740    	ldr	x0, [x26, #0xa88]
104f52e6c: 94b350bd    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104f52e70: aa0003f7    	mov	x23, x0
104f52e74: f9454740    	ldr	x0, [x26, #0xa88]
104f52e78: 900d8dc8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104f52e7c: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
104f52e80: f90003ff    	str	xzr, [sp]
104f52e84: 900cc382    	adrp	x2, 0x11e7c2000 <dyld_stub_binder+0x11e7c2000>
104f52e88: 911aa042    	add	x2, x2, #0x6a8 ; cfstring='is ios9 plus'
104f52e8c: 94b350ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52e90: aa1d03fd    	mov	x29, x29
104f52e94: 94b350ad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f52e98: aa0003fa    	mov	x26, x0
104f52e9c: 900d8d88    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104f52ea0: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
104f52ea4: b00caa48    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f52ea8: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
104f52eac: a90003e8    	stp	x8, x0, [sp]
104f52eb0: b00caa42    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f52eb4: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
104f52eb8: aa1703e0    	mov	x0, x23
104f52ebc: 94b350a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52ec0: aa0003f7    	mov	x23, x0
104f52ec4: aa1a03e0    	mov	x0, x26
104f52ec8: 94b350a3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f52ecc: b00b4661    	adrp	x1, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104f52ed0: 9124bc21    	add	x1, x1, #0x92f ; cstring='MultiTalk'
104f52ed4: 900b4722    	adrp	x2, 0x11b836000 <dyld_stub_binder+0x11b836000>
104f52ed8: 912f0842    	add	x2, x2, #0xbc2 ; cstring='MultiTalkMgr.mm'
104f52edc: 900b4744    	adrp	x4, 0x11b83a000 <dyld_stub_binder+0x11b83a000>
104f52ee0: 912f3c84    	add	x4, x4, #0xbcf ; cstring='-[MultiTalkMgr _onMonoServiceMsgStartWithMsg:]'
104f52ee4: 52800040    	mov	w0, #0x2                ; =2
104f52ee8: 528228e3    	mov	w3, #0x1147             ; =4423
104f52eec: aa1703e5    	mov	x5, x23
104f52ef0: 94b2e8d5    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
104f52ef4: aa1703e0    	mov	x0, x23
104f52ef8: 94b35097    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f52efc: aa1503e0    	mov	x0, x21
104f52f00: 94b350ab    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
104f52f04: b00d9208    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104f52f08: f946d500    	ldr	x0, [x8, #0xda8] ; class=MultiTalkContainerViewController
104f52f0c: 94b35093    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104f52f10: aa0003f7    	mov	x23, x0
104f52f14: b00d9108    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104f52f18: f947d500    	ldr	x0, [x8, #0xfa8] ; class=MMUINavigationController
104f52f1c: 94b35091    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104f52f20: b00d8d88    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104f52f24: f940d901    	ldr	x1, [x8, #0x1b0] ; selector=initWithRootViewController:
104f52f28: aa1703e2    	mov	x2, x23
104f52f2c: 94b35084    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52f30: aa0003f8    	mov	x24, x0
104f52f34: aa1403e0    	mov	x0, x20
104f52f38: aa1c03e1    	mov	x1, x28
104f52f3c: 94b35080    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52f40: aa1d03fd    	mov	x29, x29
104f52f44: 94b35081    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f52f48: aa0003f5    	mov	x21, x0
104f52f4c: b00d7768    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104f52f50: f9456d01    	ldr	x1, [x8, #0xad8] ; selector=setRootViewController:
104f52f54: f90017f8    	str	x24, [sp, #0x28]
104f52f58: aa1803e2    	mov	x2, x24
104f52f5c: 94b35078    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52f60: aa1503e0    	mov	x0, x21
104f52f64: 94b3507c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f52f68: b00d7748    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104f52f6c: f945d901    	ldr	x1, [x8, #0xbb0] ; selector=PresentModalViewController:animated:
104f52f70: f9001bf7    	str	x23, [sp, #0x30]
104f52f74: aa1703e0    	mov	x0, x23
104f52f78: aa1b03e2    	mov	x2, x27
104f52f7c: 52800003    	mov	w3, #0x0                ; =0
104f52f80: 94b3506f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52f84: b00d8208    	adrp	x8, 0x11ff93000 <dyld_stub_binder+0x11ff93000>
104f52f88: f9447501    	ldr	x1, [x8, #0x8e8] ; selector=changeToReceiveACallLayout
104f52f8c: aa1b03e0    	mov	x0, x27
104f52f90: 94b3506b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52f94: 900d7968    	adrp	x8, 0x11fe7e000 <dyld_stub_binder+0x11fe7e000>
104f52f98: f940c501    	ldr	x1, [x8, #0x188] ; selector=updateGroupInfo:
104f52f9c: aa1b03e0    	mov	x0, x27
104f52fa0: f94033e2    	ldr	x2, [sp, #0x60]
104f52fa4: 94b35066    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52fa8: b00d8028    	adrp	x8, 0x11ff57000 <dyld_stub_binder+0x11ff57000>
104f52fac: f9441d01    	ldr	x1, [x8, #0x838] ; selector=setMinimizeTaskData:
104f52fb0: aa1403e0    	mov	x0, x20
104f52fb4: d2800002    	mov	x2, #0x0                ; =0
104f52fb8: 94b35061    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52fbc: d00d8208    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f52fc0: f9455501    	ldr	x1, [x8, #0xaa8] ; selector=setMinimizeView:
104f52fc4: aa1403e0    	mov	x0, x20
104f52fc8: d2800002    	mov	x2, #0x0                ; =0
104f52fcc: 94b3505c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52fd0: b00d8028    	adrp	x8, 0x11ff57000 <dyld_stub_binder+0x11ff57000>
104f52fd4: f9459101    	ldr	x1, [x8, #0xb20] ; selector=setIsMinimizeMode:
104f52fd8: aa1403e0    	mov	x0, x20
104f52fdc: 52800002    	mov	w2, #0x0                ; =0
104f52fe0: 94b35057    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52fe4: d00d8208    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f52fe8: f9455901    	ldr	x1, [x8, #0xab0] ; selector=createMinimizeView
104f52fec: aa1403e0    	mov	x0, x20
104f52ff0: 94b35053    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f52ff4: d00d8208    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f52ff8: f9445101    	ldr	x1, [x8, #0x8a0] ; selector=setM_isCalling:
104f52ffc: aa1403e0    	mov	x0, x20
104f53000: 52800002    	mov	w2, #0x0                ; =0
104f53004: 94b3504e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f53008: b00d8208    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f5300c: f9444501    	ldr	x1, [x8, #0x888] ; selector=setM_sdkCallEnded:
104f53010: aa1403e0    	mov	x0, x20
104f53014: 52800002    	mov	w2, #0x0                ; =0
104f53018: 94b35049    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f5301c: 900d911c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
104f53020: f00d7737    	adrp	x23, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104f53024: f94023f8    	ldr	x24, [sp, #0x40]
104f53028: 360000d9    	tbz	w25, #0x0, 0x104f53040 <_Flutter_MMFoundation_BindContext+0x142ec24>
104f5302c: d00d8208    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
104f53030: f9406d01    	ldr	x1, [x8, #0xd8] ; selector=collapseInvitationBreadthViewForAutoIgnore
104f53034: aa1b03e0    	mov	x0, x27
104f53038: 94b35041    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f5303c: 14000012    	b	0x104f53084 <_Flutter_MMFoundation_BindContext+0x142ec68>
104f53040: f9471380    	ldr	x0, [x28, #0xe20] ; class=SettingUtil
104f53044: f946f2e1    	ldr	x1, [x23, #0xde0] ; selector=getMainSetting
104f53048: 94b3503d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f5304c: aa1d03fd    	mov	x29, x29
104f53050: 94b3503e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f53054: aa0003f5    	mov	x21, x0
104f53058: 900d7788    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104f5305c: f942e501    	ldr	x1, [x8, #0x5c8] ; selector=m_bNewMsgVibration
104f53060: 94b35037    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f53064: aa0003e2    	mov	x2, x0
104f53068: b00d8208    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f5306c: f9458d01    	ldr	x1, [x8, #0xb18] ; selector=playRingSoundWithVibration:isCaller:
104f53070: aa1403e0    	mov	x0, x20
104f53074: 52800003    	mov	w3, #0x0                ; =0
104f53078: 94b35031    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f5307c: aa1503e0    	mov	x0, x21
104f53080: 94b35035    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f53084: b00d8208    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f53088: f9455d01    	ldr	x1, [x8, #0xab8] ; selector=clearVideoDevice
104f5308c: aa1403e0    	mov	x0, x20
104f53090: 94b3502b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f53094: b00d8208    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f53098: f9456101    	ldr	x1, [x8, #0xac0] ; selector=resetVideoDevice
104f5309c: aa1403e0    	mov	x0, x20
104f530a0: 94b35027    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f530a4: b00d8208    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f530a8: f9456501    	ldr	x1, [x8, #0xac8] ; selector=renewViewCapture
104f530ac: aa1403e0    	mov	x0, x20
104f530b0: 94b35023    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f530b4: b00d8208    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f530b8: f9459101    	ldr	x1, [x8, #0xb20] ; selector=updateNetworkTacticsWithNotify:
104f530bc: aa1403e0    	mov	x0, x20
104f530c0: 52800002    	mov	w2, #0x0                ; =0
104f530c4: 94b3501e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f530c8: 900d9108    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104f530cc: f945e900    	ldr	x0, [x8, #0xbd0] ; class=MMContext
104f530d0: aa1803e1    	mov	x1, x24
104f530d4: 94b3501a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f530d8: aa1d03fd    	mov	x29, x29
104f530dc: 94b3501b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f530e0: aa0003f5    	mov	x21, x0
104f530e4: b00d90e8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
104f530e8: f9465119    	ldr	x25, [x8, #0xca0] ; protocol=MultiTalkMgrExt
104f530ec: f00d7d08    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
104f530f0: f9439d1a    	ldr	x26, [x8, #0x738] ; selector=onInviteMultiTalk:
104f530f4: f00c34c8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
104f530f8: f947e108    	ldr	x8, [x8, #0xfc0]
104f530fc: f90037e8    	str	x8, [sp, #0x68]
104f53100: d009f168    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
104f53104: fd41c100    	ldr	d0, [x8, #0x380]
104f53108: fd003be0    	str	d0, [sp, #0x70]
104f5310c: 90000008    	adrp	x8, 0x104f53000 <_Flutter_MMFoundation_BindContext+0x142ebe4>
104f53110: 9113d108    	add	x8, x8, #0x4f4
104f53114: f00c3509    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
104f53118: 91238129    	add	x9, x9, #0x8e0
104f5311c: a907a7e8    	stp	x8, x9, [sp, #0x78]
104f53120: f94033e0    	ldr	x0, [sp, #0x60]
104f53124: 94b35005    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104f53128: f90047e0    	str	x0, [sp, #0x88]
104f5312c: 9101a3e4    	add	x4, sp, #0x68
104f53130: aa1503e0    	mov	x0, x21
104f53134: f9401fe1    	ldr	x1, [sp, #0x38]
104f53138: aa1903e2    	mov	x2, x25
104f5313c: aa1a03e3    	mov	x3, x26
104f53140: 94b34fff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f53144: aa1503e0    	mov	x0, x21
104f53148: 94b35003    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f5314c: f94047e0    	ldr	x0, [sp, #0x88]
104f53150: 94b35001    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f53154: 900d9208    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104f53158: f9469d00    	ldr	x0, [x8, #0xd38] ; class=MultiTalkMonoMsgIdKeyReport
104f5315c: d00d8208    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
104f53160: f9407101    	ldr	x1, [x8, #0xe0] ; selector=logicStartShowNotification
104f53164: 94b34ff6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f53168: 900d9108    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104f5316c: f9468d00    	ldr	x0, [x8, #0xd18] ; class=DeviceInfo
104f53170: 900d8d88    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104f53174: f9457d01    	ldr	x1, [x8, #0xaf8] ; selector=isiPad
104f53178: 94b34ff1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f5317c: aa0003f5    	mov	x21, x0
104f53180: f9471380    	ldr	x0, [x28, #0xe20] ; class=SettingUtil
104f53184: f946f2e1    	ldr	x1, [x23, #0xde0] ; selector=getMainSetting
104f53188: 94b34fed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f5318c: aa1d03fd    	mov	x29, x29
104f53190: 94b34fee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f53194: aa0003f9    	mov	x25, x0
104f53198: b00d7748    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104f5319c: f942d501    	ldr	x1, [x8, #0x5a8] ; selector=m_uiExtStatus
104f531a0: 94b34fe7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f531a4: aa0003fa    	mov	x26, x0
104f531a8: aa1903e0    	mov	x0, x25
104f531ac: 94b34fea    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f531b0: 710002bf    	cmp	w21, #0x0
104f531b4: 52820008    	mov	w8, #0x1000             ; =4096
104f531b8: 52840009    	mov	w9, #0x2000             ; =8192
104f531bc: 9a881128    	csel	x8, x9, x8, ne
104f531c0: 8a080357    	and	x23, x26, x8
104f531c4: 900d91b5    	adrp	x21, 0x120187000 <dyld_stub_binder+0x120187000>
104f531c8: f943aaa0    	ldr	x0, [x21, #0x750] ; class=VoIPPushKitNotifyService
104f531cc: d00d8208    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
104f531d0: f9407501    	ldr	x1, [x8, #0xe8] ; selector=isAppStateActive
104f531d4: 94b34fda    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f531d8: 37000120    	tbnz	w0, #0x0, 0x104f531fc <_Flutter_MMFoundation_BindContext+0x142ede0>
104f531dc: f943aaa0    	ldr	x0, [x21, #0x750] ; class=VoIPPushKitNotifyService
104f531e0: d00d8208    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
104f531e4: f9407901    	ldr	x1, [x8, #0xf0] ; selector=getIfCanUseCX:isMultiTalk:
104f531e8: 52800039    	mov	w25, #0x1               ; =1
104f531ec: 52800002    	mov	w2, #0x0                ; =0
104f531f0: 52800023    	mov	w3, #0x1                ; =1
104f531f4: 94b34fd2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f531f8: 370000c0    	tbnz	w0, #0x0, 0x104f53210 <_Flutter_MMFoundation_BindContext+0x142edf4>
104f531fc: f943aaa0    	ldr	x0, [x21, #0x750] ; class=VoIPPushKitNotifyService
104f53200: d00d7d08    	adrp	x8, 0x11fef5000 <dyld_stub_binder+0x11fef5000>
104f53204: f9476901    	ldr	x1, [x8, #0xed0] ; selector=getIfHaveAProcess
104f53208: 94b34fcd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f5320c: aa0003f9    	mov	x25, x0
104f53210: f10002ff    	cmp	x23, #0x0
104f53214: b9405fe8    	ldr	w8, [sp, #0x5c]
104f53218: 1a9f0508    	csinc	w8, w8, wzr, eq
104f5321c: 37000948    	tbnz	w8, #0x0, 0x104f53344 <_Flutter_MMFoundation_BindContext+0x142ef28>
104f53220: 900d9108    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104f53224: f9453500    	ldr	x0, [x8, #0xa68] ; class=iConsole
104f53228: d00d7728    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104f5322c: f942a901    	ldr	x1, [x8, #0x550] ; selector=logWithLevel:module:errorCode:file:line:func:format:
104f53230: 900cc388    	adrp	x8, 0x11e7c3000 <dyld_stub_binder+0x11e7c3000>
104f53234: 913e2108    	add	x8, x8, #0xf88 ; cfstring='isCallKit: %u'
104f53238: a90067e8    	stp	x8, x25, [sp]
104f5323c: 900b4663    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104f53240: 911a5863    	add	x3, x3, #0x696 ; cstring='MonoMsg'
104f53244: f00b4705    	adrp	x5, 0x11b836000 <dyld_stub_binder+0x11b836000>
104f53248: 912f08a5    	add	x5, x5, #0xbc2 ; cstring='MultiTalkMgr.mm'
104f5324c: f00b4727    	adrp	x7, 0x11b83a000 <dyld_stub_binder+0x11b83a000>
104f53250: 912f3ce7    	add	x7, x7, #0xbcf ; cstring='-[MultiTalkMgr _onMonoServiceMsgStartWithMsg:]'
104f53254: 52800042    	mov	w2, #0x2                ; =2
104f53258: 52800004    	mov	w4, #0x0                ; =0
104f5325c: 52822fa6    	mov	w6, #0x117d             ; =4477
104f53260: 94b34fb7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f53264: 900d9108    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104f53268: f945e900    	ldr	x0, [x8, #0xbd0] ; class=MMContext
104f5326c: aa1803e1    	mov	x1, x24
104f53270: 94b34fb3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f53274: aa1d03fd    	mov	x29, x29
104f53278: 94b34fb4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f5327c: aa0003f8    	mov	x24, x0
104f53280: 340003b9    	cbz	w25, 0x104f532f4 <_Flutter_MMFoundation_BindContext+0x142eed8>
104f53284: f943aaa0    	ldr	x0, [x21, #0x750] ; class=VoIPPushKitNotifyService
104f53288: aa1603e1    	mov	x1, x22
104f5328c: 94b34fac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f53290: aa0003e2    	mov	x2, x0
104f53294: aa1803e0    	mov	x0, x24
104f53298: f9402be1    	ldr	x1, [sp, #0x50]
104f5329c: 94b34fa8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f532a0: aa1d03fd    	mov	x29, x29
104f532a4: 94b34fa9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f532a8: aa0003f6    	mov	x22, x0
104f532ac: aa1303e0    	mov	x0, x19
104f532b0: f94013e1    	ldr	x1, [sp, #0x20]
104f532b4: 94b34fa2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f532b8: aa1d03fd    	mov	x29, x29
104f532bc: 94b34fa3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f532c0: aa0003f5    	mov	x21, x0
104f532c4: d00d8208    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
104f532c8: f9407d01    	ldr	x1, [x8, #0xf8] ; selector=reportIncomingCallFromUser:ofType:withMsg:isPushKit:isMultitalk:
104f532cc: aa1603e0    	mov	x0, x22
104f532d0: aa1503e2    	mov	x2, x21
104f532d4: 52800043    	mov	w3, #0x2                ; =2
104f532d8: aa1303e4    	mov	x4, x19
104f532dc: 52800005    	mov	w5, #0x0                ; =0
104f532e0: 52800026    	mov	w6, #0x1                ; =1
104f532e4: 94b34f96    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f532e8: aa1503e0    	mov	x0, x21
104f532ec: 94b34f9a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f532f0: 14000011    	b	0x104f53334 <_Flutter_MMFoundation_BindContext+0x142ef18>
104f532f4: 900d91e8    	adrp	x8, 0x12018f000 <dyld_stub_binder+0x12018f000>
104f532f8: f9473900    	ldr	x0, [x8, #0xe70] ; class=MonoServiceMsgMgr
104f532fc: aa1603e1    	mov	x1, x22
104f53300: 94b34f8f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f53304: aa0003e2    	mov	x2, x0
104f53308: aa1803e0    	mov	x0, x24
104f5330c: f9402be1    	ldr	x1, [sp, #0x50]
104f53310: 94b34f8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f53314: aa1d03fd    	mov	x29, x29
104f53318: 94b34f8c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f5331c: aa0003f6    	mov	x22, x0
104f53320: b00d81c8    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104f53324: f944cd01    	ldr	x1, [x8, #0x998] ; selector=showLocalNotificationWithMsg:repeatVibration:
104f53328: aa1303e2    	mov	x2, x19
104f5332c: 52800023    	mov	w3, #0x1                ; =1
104f53330: 94b34f83    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f53334: aa1603e0    	mov	x0, x22
104f53338: 94b34f87    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f5333c: aa1803e0    	mov	x0, x24
104f53340: 94b34f85    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f53344: d00d8208    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
104f53348: f9408116    	ldr	x22, [x8, #0x100] ; selector=waitForAcceptedRoomID
104f5334c: aa1403e0    	mov	x0, x20
104f53350: aa1603e1    	mov	x1, x22
104f53354: 94b34f7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f53358: b4000920    	cbz	x0, 0x104f5347c <_Flutter_MMFoundation_BindContext+0x142f060>
104f5335c: 900d77e8    	adrp	x8, 0x11fe4f000 <dyld_stub_binder+0x11fe4f000>
104f53360: f943b901    	ldr	x1, [x8, #0x770] ; selector=getCurrentRoomID
104f53364: aa1403e0    	mov	x0, x20
104f53368: 94b34f75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f5336c: aa0003f8    	mov	x24, x0
104f53370: 52800040    	mov	w0, #0x2                ; =2
104f53374: 94b2e7b3    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
104f53378: 34000600    	cbz	w0, 0x104f53438 <_Flutter_MMFoundation_BindContext+0x142f01c>
104f5337c: 94b34f89    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
104f53380: aa0003f9    	mov	x25, x0
104f53384: 900d9117    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
104f53388: f94546e0    	ldr	x0, [x23, #0xa88]
104f5338c: 94b34f75    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104f53390: aa0003f5    	mov	x21, x0
104f53394: f94546fa    	ldr	x26, [x23, #0xa88]
104f53398: aa1403e0    	mov	x0, x20
104f5339c: aa1603e1    	mov	x1, x22
104f533a0: 94b34f67    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f533a4: f00d8da8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104f533a8: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
104f533ac: a900fff8    	stp	x24, xzr, [sp, #0x8]
104f533b0: f90003e0    	str	x0, [sp]
104f533b4: 900cc382    	adrp	x2, 0x11e7c3000 <dyld_stub_binder+0x11e7c3000>
104f533b8: 913ea042    	add	x2, x2, #0xfa8 ; cfstring='waitForAcceptedRoomID:%llu curRoomID:%llu'
104f533bc: aa1a03e0    	mov	x0, x26
104f533c0: 94b34f5f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f533c4: aa1d03fd    	mov	x29, x29
104f533c8: 94b34f60    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f533cc: aa0003fa    	mov	x26, x0
104f533d0: f00d8d68    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104f533d4: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
104f533d8: 900caa48    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f533dc: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
104f533e0: a90003e8    	stp	x8, x0, [sp]
104f533e4: 900caa42    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f533e8: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
104f533ec: aa1503e0    	mov	x0, x21
104f533f0: 94b34f53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f533f4: aa0003f5    	mov	x21, x0
104f533f8: aa1a03e0    	mov	x0, x26
104f533fc: 94b34f56    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f53400: 900b4661    	adrp	x1, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104f53404: 9124bc21    	add	x1, x1, #0x92f ; cstring='MultiTalk'
104f53408: f00b4702    	adrp	x2, 0x11b836000 <dyld_stub_binder+0x11b836000>
104f5340c: 912f0842    	add	x2, x2, #0xbc2 ; cstring='MultiTalkMgr.mm'
104f53410: f00b4724    	adrp	x4, 0x11b83a000 <dyld_stub_binder+0x11b83a000>
104f53414: 912f3c84    	add	x4, x4, #0xbcf ; cstring='-[MultiTalkMgr _onMonoServiceMsgStartWithMsg:]'
104f53418: 52800040    	mov	w0, #0x2                ; =2
104f5341c: 52823163    	mov	w3, #0x118b             ; =4491
104f53420: aa1503e5    	mov	x5, x21
104f53424: 94b2e788    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
104f53428: aa1503e0    	mov	x0, x21
104f5342c: 94b34f4a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f53430: aa1903e0    	mov	x0, x25
104f53434: 94b34f5e    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
104f53438: aa1403e0    	mov	x0, x20
104f5343c: aa1603e1    	mov	x1, x22
104f53440: 94b34f3f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f53444: eb18001f    	cmp	x0, x24
104f53448: 540001a1    	b.ne	0x104f5347c <_Flutter_MMFoundation_BindContext+0x142f060>
104f5344c: b00d8208    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f53450: f943e101    	ldr	x1, [x8, #0x7c0] ; selector=mainViewController
104f53454: aa1403e0    	mov	x0, x20
104f53458: 94b34f39    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f5345c: aa1d03fd    	mov	x29, x29
104f53460: 94b34f3a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f53464: aa0003f4    	mov	x20, x0
104f53468: d00d7988    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
104f5346c: f945cd01    	ldr	x1, [x8, #0xb98] ; selector=accept
104f53470: 94b34f33    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f53474: aa1403e0    	mov	x0, x20
104f53478: 94b34f37    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f5347c: f94017e0    	ldr	x0, [sp, #0x28]
104f53480: 94b34f35    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f53484: f9401be0    	ldr	x0, [sp, #0x30]
104f53488: 94b34f33    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f5348c: aa1b03e0    	mov	x0, x27
104f53490: 94b34f31    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f53494: f94027e0    	ldr	x0, [sp, #0x48]
104f53498: 94b34f2f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f5349c: f94033e0    	ldr	x0, [sp, #0x60]
104f534a0: 94b34f2d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f534a4: aa1303e0    	mov	x0, x19
104f534a8: 94b34f2b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f534ac: aa1303e0    	mov	x0, x19
104f534b0: 94b34f29    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f534b4: a94e7bfd    	ldp	x29, x30, [sp, #0xe0]
104f534b8: a94d4ff4    	ldp	x20, x19, [sp, #0xd0]
104f534bc: a94c57f6    	ldp	x22, x21, [sp, #0xc0]
104f534c0: a94b5ff8    	ldp	x24, x23, [sp, #0xb0]
104f534c4: a94a67fa    	ldp	x26, x25, [sp, #0xa0]
104f534c8: a9496ffc    	ldp	x28, x27, [sp, #0x90]
104f534cc: 9103c3ff    	add	sp, sp, #0xf0
104f534d0: d65f03c0    	ret
