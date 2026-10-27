
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e48574: d10303ff    	sub	sp, sp, #0xc0
100e48578: a9066ffc    	stp	x28, x27, [sp, #0x60]
100e4857c: a90767fa    	stp	x26, x25, [sp, #0x70]
100e48580: a9085ff8    	stp	x24, x23, [sp, #0x80]
100e48584: a90957f6    	stp	x22, x21, [sp, #0x90]
100e48588: a90a4ff4    	stp	x20, x19, [sp, #0xa0]
100e4858c: a90b7bfd    	stp	x29, x30, [sp, #0xb0]
100e48590: 9102c3fd    	add	x29, sp, #0xb0
100e48594: aa0403fb    	mov	x27, x4
100e48598: aa0303f9    	mov	x25, x3
100e4859c: aa0203f3    	mov	x19, x2
100e485a0: f90017e0    	str	x0, [sp, #0x28]
100e485a4: 900fef48    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100e485a8: 52800029    	mov	w9, #0x1                ; =1
100e485ac: 39187109    	strb	w9, [x8, #0x61c]
100e485b0: aa0203e0    	mov	x0, x2
100e485b4: 95b77ae1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100e485b8: f00f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e485bc: f9453514    	ldr	x20, [x8, #0xa68] ; iConsole
100e485c0: f00f9958    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
100e485c4: f9454700    	ldr	x0, [x24, #0xa88]
100e485c8: 900f7fa8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100e485cc: f947c91c    	ldr	x28, [x8, #0xf90] ; generatePrivacyString:
100e485d0: aa1c03e1    	mov	x1, x28
100e485d4: aa1303e2    	mov	x2, x19
100e485d8: 95b77ad9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e485dc: aa1d03fd    	mov	x29, x29
100e485e0: 95b77ada    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e485e4: aa0003f5    	mov	x21, x0
100e485e8: b00f7f88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e485ec: f942a91a    	ldr	x26, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
100e485f0: a900e7e0    	stp	x0, x25, [sp, #0x8]
100e485f4: d00eb748    	adrp	x8, 0x11e532000 <dyld_stub_binder+0x11e532000>
100e485f8: 91232108    	add	x8, x8, #0x8c8 ; CFString 'change chatbox session %@, %d'
100e485fc: f90003e8    	str	x8, [sp]
100e48600: b00d20a3    	adrp	x3, 0x11b25d000 <dyld_stub_binder+0x11b25d000>
100e48604: 911f2c63    	add	x3, x3, #0x7cb
100e48608: f00d2805    	adrp	x5, 0x11b34b000 <dyld_stub_binder+0x11b34b000>
100e4860c: 910c4ca5    	add	x5, x5, #0x313
100e48610: f00d2807    	adrp	x7, 0x11b34b000 <dyld_stub_binder+0x11b34b000>
100e48614: 911198e7    	add	x7, x7, #0x466
100e48618: aa1403e0    	mov	x0, x20
100e4861c: aa1a03e1    	mov	x1, x26
100e48620: 52800042    	mov	w2, #0x2                ; =2
100e48624: 52800004    	mov	w4, #0x0                ; =0
100e48628: 52802706    	mov	w6, #0x138              ; =312
100e4862c: 95b77ac4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48630: aa1503e0    	mov	x0, x21
100e48634: 95b77ac8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48638: f00f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e4863c: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
100e48640: 900f95c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e48644: f944e915    	ldr	x21, [x8, #0x9d0] ; currentContext
100e48648: aa1503e1    	mov	x1, x21
100e4864c: 95b77abc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48650: aa1d03fd    	mov	x29, x29
100e48654: 95b77abd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48658: aa0003f4    	mov	x20, x0
100e4865c: 900f9968    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100e48660: f9401d00    	ldr	x0, [x8, #0x38] ; MMNewSessionMgr
100e48664: f00f95a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100e48668: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100e4866c: f90013e1    	str	x1, [sp, #0x20]
100e48670: 95b77ab3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48674: aa0003e2    	mov	x2, x0
100e48678: b00f7f88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e4867c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100e48680: aa1403e0    	mov	x0, x20
100e48684: f9000fe1    	str	x1, [sp, #0x18]
100e48688: 95b77aad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4868c: aa1d03fd    	mov	x29, x29
100e48690: 95b77aae    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48694: aa0003f7    	mov	x23, x0
100e48698: b00f7fa8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
100e4869c: f942d901    	ldr	x1, [x8, #0x5b0] ; GetSessionByUserName:
100e486a0: aa1303e2    	mov	x2, x19
100e486a4: 95b77aa6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e486a8: aa1d03fd    	mov	x29, x29
100e486ac: 95b77aa7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e486b0: aa0003f6    	mov	x22, x0
100e486b4: aa1703e0    	mov	x0, x23
100e486b8: 95b77aa7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e486bc: aa1403e0    	mov	x0, x20
100e486c0: 95b77aa5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e486c4: b4000c36    	cbz	x22, 0x100e48848 <__text+0xe40848>
100e486c8: 34001099    	cbz	w25, 0x100e488d8 <__text+0xe408d8>
100e486cc: 900f9d08    	adrp	x8, 0x1201e8000 <dyld_stub_binder+0x1201e8000>
100e486d0: b985691b    	ldrsw	x27, [x8, #0x568]
100e486d4: f94017f7    	ldr	x23, [sp, #0x28]
100e486d8: f87b6ae8    	ldr	x8, [x23, x27]
100e486dc: f00f9958    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
100e486e0: 900f997c    	adrp	x28, 0x120174000 <dyld_stub_binder+0x120174000>
100e486e4: b5000348    	cbnz	x8, 0x100e4874c <__text+0xe4074c>
100e486e8: f00f95c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100e486ec: f943f901    	ldr	x1, [x8, #0x7f0] ; isHidden
100e486f0: aa1603e0    	mov	x0, x22
100e486f4: 95b77a92    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e486f8: 370002a0    	tbnz	w0, #0x0, 0x100e4874c <__text+0xe4074c>
100e486fc: f00f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e48700: f9453500    	ldr	x0, [x8, #0xa68] ; iConsole
100e48704: d00eb748    	adrp	x8, 0x11e532000 <dyld_stub_binder+0x11e532000>
100e48708: 9124a108    	add	x8, x8, #0x928 ; CFString 'gen chatbox session'
100e4870c: f90003e8    	str	x8, [sp]
100e48710: b00d20a3    	adrp	x3, 0x11b25d000 <dyld_stub_binder+0x11b25d000>
100e48714: 911f2c63    	add	x3, x3, #0x7cb
100e48718: f00d2805    	adrp	x5, 0x11b34b000 <dyld_stub_binder+0x11b34b000>
100e4871c: 910c4ca5    	add	x5, x5, #0x313
100e48720: f00d2807    	adrp	x7, 0x11b34b000 <dyld_stub_binder+0x11b34b000>
100e48724: 911198e7    	add	x7, x7, #0x466
100e48728: aa1a03e1    	mov	x1, x26
100e4872c: 52800042    	mov	w2, #0x2                ; =2
100e48730: 52800004    	mov	w4, #0x0                ; =0
100e48734: 528028a6    	mov	w6, #0x145              ; =325
100e48738: 95b77a81    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4873c: 900f81c8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e48740: f9434d01    	ldr	x1, [x8, #0x698] ; updateChatBoxSession
100e48744: aa1703e0    	mov	x0, x23
100e48748: 95b77a7d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4874c: b00f8008    	adrp	x8, 0x11fe49000 <dyld_stub_binder+0x11fe49000>
100e48750: f9462501    	ldr	x1, [x8, #0xc48] ; m_extendFields
100e48754: aa1603e0    	mov	x0, x22
100e48758: 95b77a79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4875c: aa1d03fd    	mov	x29, x29
100e48760: 95b77a7a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48764: aa0003f4    	mov	x20, x0
100e48768: 900f81c8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e4876c: f9438d01    	ldr	x1, [x8, #0x718] ; m_sessionState
100e48770: 95b77a73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48774: 900f81c8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e48778: f9439101    	ldr	x1, [x8, #0x720] ; setM_sessionState:
100e4877c: b27f0002    	orr	x2, x0, #0x2
100e48780: aa1403e0    	mov	x0, x20
100e48784: 95b77a6e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48788: aa1403e0    	mov	x0, x20
100e4878c: 95b77a72    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48790: f87b6ae8    	ldr	x8, [x23, x27]
100e48794: b4000e48    	cbz	x8, 0x100e4895c <__text+0xe4095c>
100e48798: b00f7fa8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
100e4879c: f9413514    	ldr	x20, [x8, #0x268] ; m_uLastTime
100e487a0: aa1603e0    	mov	x0, x22
100e487a4: aa1403e1    	mov	x1, x20
100e487a8: 95b77a65    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e487ac: aa0003f7    	mov	x23, x0
100e487b0: f94017e8    	ldr	x8, [sp, #0x28]
100e487b4: f87b6900    	ldr	x0, [x8, x27]
100e487b8: aa1403e1    	mov	x1, x20
100e487bc: 95b77a60    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e487c0: 6b0002ff    	cmp	w23, w0
100e487c4: f94017f7    	ldr	x23, [sp, #0x28]
100e487c8: 54000ca9    	b.ls	0x100e4895c <__text+0xe4095c>
100e487cc: aa1603e0    	mov	x0, x22
100e487d0: aa1403e1    	mov	x1, x20
100e487d4: 95b77a5a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e487d8: aa0003e2    	mov	x2, x0
100e487dc: f87b6ae0    	ldr	x0, [x23, x27]
100e487e0: d00f7fe8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
100e487e4: f9430d01    	ldr	x1, [x8, #0x618] ; setM_uLastTime:
100e487e8: 95b77a55    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e487ec: f945eb00    	ldr	x0, [x24, #0xbd0] ; MMContext
100e487f0: aa1503e1    	mov	x1, x21
100e487f4: 95b77a52    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e487f8: aa1d03fd    	mov	x29, x29
100e487fc: 95b77a53    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48800: aa0003fa    	mov	x26, x0
100e48804: f9401f80    	ldr	x0, [x28, #0x38] ; MMNewSessionMgr
100e48808: f94013e1    	ldr	x1, [sp, #0x20]
100e4880c: 95b77a4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48810: aa0003e2    	mov	x2, x0
100e48814: aa1a03e0    	mov	x0, x26
100e48818: f9400fe1    	ldr	x1, [sp, #0x18]
100e4881c: 95b77a48    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48820: aa1d03fd    	mov	x29, x29
100e48824: 95b77a49    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48828: aa0003f4    	mov	x20, x0
100e4882c: f87b6ae2    	ldr	x2, [x23, x27]
100e48830: 900f81c8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e48834: f9439501    	ldr	x1, [x8, #0x728] ; modifySessionWithoutNotify:
100e48838: 95b77a41    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4883c: aa1403e0    	mov	x0, x20
100e48840: 95b77a45    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48844: 14000044    	b	0x100e48954 <__text+0xe40954>
100e48848: f00f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e4884c: f9453514    	ldr	x20, [x8, #0xa68] ; iConsole
100e48850: f9454700    	ldr	x0, [x24, #0xa88]
100e48854: aa1c03e1    	mov	x1, x28
100e48858: aa1303e2    	mov	x2, x19
100e4885c: 95b77a38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48860: aa1d03fd    	mov	x29, x29
100e48864: 95b77a39    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48868: aa0003f6    	mov	x22, x0
100e4886c: 340010bb    	cbz	w27, 0x100e48a80 <__text+0xe40a80>
100e48870: d00eb748    	adrp	x8, 0x11e532000 <dyld_stub_binder+0x11e532000>
100e48874: 9123a108    	add	x8, x8, #0x8e8 ; CFString 'can not get session: %@, gen new'
100e48878: a9005be8    	stp	x8, x22, [sp]
100e4887c: b00d20a3    	adrp	x3, 0x11b25d000 <dyld_stub_binder+0x11b25d000>
100e48880: 911f2c63    	add	x3, x3, #0x7cb
100e48884: f00d2805    	adrp	x5, 0x11b34b000 <dyld_stub_binder+0x11b34b000>
100e48888: 910c4ca5    	add	x5, x5, #0x313
100e4888c: f00d2807    	adrp	x7, 0x11b34b000 <dyld_stub_binder+0x11b34b000>
100e48890: 911198e7    	add	x7, x7, #0x466
100e48894: aa1403e0    	mov	x0, x20
100e48898: aa1a03e1    	mov	x1, x26
100e4889c: 52800042    	mov	w2, #0x2                ; =2
100e488a0: 52800004    	mov	w4, #0x0                ; =0
100e488a4: 52802786    	mov	w6, #0x13c              ; =316
100e488a8: 95b77a25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e488ac: aa1603e0    	mov	x0, x22
100e488b0: 95b77a29    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e488b4: 900f81c8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e488b8: f9438501    	ldr	x1, [x8, #0x708] ; generateSessionForUsername:
100e488bc: f94017e0    	ldr	x0, [sp, #0x28]
100e488c0: aa1303e2    	mov	x2, x19
100e488c4: 95b77a1e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e488c8: aa1d03fd    	mov	x29, x29
100e488cc: 95b77a1f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e488d0: aa0003f6    	mov	x22, x0
100e488d4: 35ffefd9    	cbnz	w25, 0x100e486cc <__text+0xe406cc>
100e488d8: 900f9d08    	adrp	x8, 0x1201e8000 <dyld_stub_binder+0x1201e8000>
100e488dc: b9855908    	ldrsw	x8, [x8, #0x558]
100e488e0: f94017f4    	ldr	x20, [sp, #0x28]
100e488e4: f8686a80    	ldr	x0, [x20, x8]
100e488e8: 900f95c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e488ec: f9424d01    	ldr	x1, [x8, #0x498] ; containsObject:
100e488f0: aa1303e2    	mov	x2, x19
100e488f4: 95b77a12    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e488f8: f00f9958    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
100e488fc: 900f997c    	adrp	x28, 0x120174000 <dyld_stub_binder+0x120174000>
100e48900: 340000c0    	cbz	w0, 0x100e48918 <__text+0xe40918>
100e48904: 900f81c8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e48908: f9438901    	ldr	x1, [x8, #0x710] ; removeSessionWithUsername:
100e4890c: aa1403e0    	mov	x0, x20
100e48910: aa1303e2    	mov	x2, x19
100e48914: 95b77a0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48918: b00f8008    	adrp	x8, 0x11fe49000 <dyld_stub_binder+0x11fe49000>
100e4891c: f9462501    	ldr	x1, [x8, #0xc48] ; m_extendFields
100e48920: aa1603e0    	mov	x0, x22
100e48924: 95b77a06    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48928: aa1d03fd    	mov	x29, x29
100e4892c: 95b77a07    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48930: aa0003fa    	mov	x26, x0
100e48934: 900f81c8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e48938: f9438d01    	ldr	x1, [x8, #0x718] ; m_sessionState
100e4893c: 95b77a00    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48940: 900f81c8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e48944: f9439101    	ldr	x1, [x8, #0x720] ; setM_sessionState:
100e48948: 927ef802    	and	x2, x0, #0xfffffffffffffffd
100e4894c: aa1a03e0    	mov	x0, x26
100e48950: 95b779fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48954: aa1a03e0    	mov	x0, x26
100e48958: 95b779ff    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4895c: f945eb00    	ldr	x0, [x24, #0xbd0] ; MMContext
100e48960: aa1503e1    	mov	x1, x21
100e48964: 95b779f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48968: aa1d03fd    	mov	x29, x29
100e4896c: 95b779f7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48970: aa0003f4    	mov	x20, x0
100e48974: f9401f80    	ldr	x0, [x28, #0x38] ; MMNewSessionMgr
100e48978: f94013e1    	ldr	x1, [sp, #0x20]
100e4897c: 95b779f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48980: aa0003e2    	mov	x2, x0
100e48984: aa1403e0    	mov	x0, x20
100e48988: f9400fe1    	ldr	x1, [sp, #0x18]
100e4898c: 95b779ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48990: aa1d03fd    	mov	x29, x29
100e48994: 95b779ed    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48998: aa0003f7    	mov	x23, x0
100e4899c: d00f7fe8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
100e489a0: f9424901    	ldr	x1, [x8, #0x490] ; AddOrModifySession:withNotifyFlag:
100e489a4: aa1603e2    	mov	x2, x22
100e489a8: d2800003    	mov	x3, #0x0                ; =0
100e489ac: 95b779e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e489b0: aa1703e0    	mov	x0, x23
100e489b4: 95b779e8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e489b8: aa1403e0    	mov	x0, x20
100e489bc: 95b779e6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e489c0: f945eb00    	ldr	x0, [x24, #0xbd0] ; MMContext
100e489c4: aa1503e1    	mov	x1, x21
100e489c8: 95b779dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e489cc: aa1d03fd    	mov	x29, x29
100e489d0: 95b779de    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e489d4: aa0003f4    	mov	x20, x0
100e489d8: b00f9948    	adrp	x8, 0x120171000 <dyld_stub_binder+0x120171000>
100e489dc: f9407915    	ldr	x21, [x8, #0xf0]
100e489e0: 900f81c8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e489e4: f9439917    	ldr	x23, [x8, #0x730] ; onSessionChatBoxTypeChange:inChatBox:
100e489e8: d00e3d28    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
100e489ec: f947e108    	ldr	x8, [x8, #0xfc0]
100e489f0: f9001be8    	str	x8, [sp, #0x30]
100e489f4: b00bf9c8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
100e489f8: fd41c100    	ldr	d0, [x8, #0x380]
100e489fc: fd001fe0    	str	d0, [sp, #0x38]
100e48a00: 90000008    	adrp	x8, 0x100e48000 <__text+0xe40000>
100e48a04: 912b0108    	add	x8, x8, #0xac0
100e48a08: f00e3d69    	adrp	x9, 0x11d5f7000 <dyld_stub_binder+0x11d5f7000>
100e48a0c: 912ee129    	add	x9, x9, #0xbb8
100e48a10: a90427e8    	stp	x8, x9, [sp, #0x40]
100e48a14: aa1303e0    	mov	x0, x19
100e48a18: 95b779c8    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100e48a1c: f9002bf3    	str	x19, [sp, #0x50]
100e48a20: 390163f9    	strb	w25, [sp, #0x58]
100e48a24: d00f7f88    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
100e48a28: f9404901    	ldr	x1, [x8, #0x90] ; callExtension:selector:block:
100e48a2c: 9100c3e4    	add	x4, sp, #0x30
100e48a30: aa1403e0    	mov	x0, x20
100e48a34: aa1503e2    	mov	x2, x21
100e48a38: aa1703e3    	mov	x3, x23
100e48a3c: 95b779c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48a40: aa1403e0    	mov	x0, x20
100e48a44: 95b779c4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48a48: f9402be0    	ldr	x0, [sp, #0x50]
100e48a4c: 95b779c2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48a50: aa1603e0    	mov	x0, x22
100e48a54: 95b779c0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48a58: aa1303e0    	mov	x0, x19
100e48a5c: 95b779be    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48a60: a94b7bfd    	ldp	x29, x30, [sp, #0xb0]
100e48a64: a94a4ff4    	ldp	x20, x19, [sp, #0xa0]
100e48a68: a94957f6    	ldp	x22, x21, [sp, #0x90]
100e48a6c: a9485ff8    	ldp	x24, x23, [sp, #0x80]
100e48a70: a94767fa    	ldp	x26, x25, [sp, #0x70]
100e48a74: a9466ffc    	ldp	x28, x27, [sp, #0x60]
100e48a78: 910303ff    	add	sp, sp, #0xc0
100e48a7c: d65f03c0    	ret
100e48a80: d00eb748    	adrp	x8, 0x11e532000 <dyld_stub_binder+0x11e532000>
100e48a84: 91242108    	add	x8, x8, #0x908 ; CFString 'can not get session: %@, return'
100e48a88: a9005be8    	stp	x8, x22, [sp]
100e48a8c: b00d20a3    	adrp	x3, 0x11b25d000 <dyld_stub_binder+0x11b25d000>
100e48a90: 911f2c63    	add	x3, x3, #0x7cb
100e48a94: f00d2805    	adrp	x5, 0x11b34b000 <dyld_stub_binder+0x11b34b000>
100e48a98: 910c4ca5    	add	x5, x5, #0x313
100e48a9c: f00d2807    	adrp	x7, 0x11b34b000 <dyld_stub_binder+0x11b34b000>
100e48aa0: 911198e7    	add	x7, x7, #0x466
100e48aa4: aa1403e0    	mov	x0, x20
100e48aa8: aa1a03e1    	mov	x1, x26
100e48aac: 52800042    	mov	w2, #0x2                ; =2
100e48ab0: 52800004    	mov	w4, #0x0                ; =0
100e48ab4: 528027e6    	mov	w6, #0x13f              ; =319
100e48ab8: 95b779a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48abc: 17ffffe5    	b	0x100e48a50 <__text+0xe40a50>
