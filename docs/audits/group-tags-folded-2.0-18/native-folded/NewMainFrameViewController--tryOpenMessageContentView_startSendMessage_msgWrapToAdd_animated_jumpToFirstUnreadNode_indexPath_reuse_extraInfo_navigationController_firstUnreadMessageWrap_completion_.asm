
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10511deac: d102c3ff    	sub	sp, sp, #0xb0
10511deb0: a9056ffc    	stp	x28, x27, [sp, #0x50]
10511deb4: a90667fa    	stp	x26, x25, [sp, #0x60]
10511deb8: a9075ff8    	stp	x24, x23, [sp, #0x70]
10511debc: a90857f6    	stp	x22, x21, [sp, #0x80]
10511dec0: a9094ff4    	stp	x20, x19, [sp, #0x90]
10511dec4: a90a7bfd    	stp	x29, x30, [sp, #0xa0]
10511dec8: 910283fd    	add	x29, sp, #0xa0
10511decc: aa0703f4    	mov	x20, x7
10511ded0: aa0503f7    	mov	x23, x5
10511ded4: aa0303fc    	mov	x28, x3
10511ded8: aa0203f3    	mov	x19, x2
10511dedc: aa0003fb    	mov	x27, x0
10511dee0: 394043a8    	ldrb	w8, [x29, #0x10]
10511dee4: b9003fe8    	str	w8, [sp, #0x3c]
10511dee8: a942e3b6    	ldp	x22, x24, [x29, #0x28]
10511deec: a941ebb9    	ldp	x25, x26, [x29, #0x18]
10511def0: d00dd908    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
10511def4: 52800029    	mov	w9, #0x1                ; =1
10511def8: 392dfd09    	strb	w9, [x8, #0xb7f]
10511defc: aa0203e0    	mov	x0, x2
10511df00: 94ac248e    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511df04: aa1403e0    	mov	x0, x20
10511df08: 94ac248c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511df0c: f90023f9    	str	x25, [sp, #0x40]
10511df10: aa1903e0    	mov	x0, x25
10511df14: 94ac2489    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511df18: aa1a03f5    	mov	x21, x26
10511df1c: aa1a03e0    	mov	x0, x26
10511df20: 94ac2486    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511df24: f90027f6    	str	x22, [sp, #0x48]
10511df28: aa1603e0    	mov	x0, x22
10511df2c: 94ac2483    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511df30: aa1803e0    	mov	x0, x24
10511df34: 94ac2481    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511df38: d00d68e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10511df3c: f947d919    	ldr	x25, [x8, #0xfb0] ; m_contact
10511df40: aa1303e0    	mov	x0, x19
10511df44: aa1903e1    	mov	x1, x25
10511df48: 94ac247d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511df4c: aa1d03fd    	mov	x29, x29
10511df50: 94ac247e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511df54: aa0003f6    	mov	x22, x0
10511df58: f00d6a08    	adrp	x8, 0x11fe60000 <dyld_stub_binder+0x11fe60000>
10511df5c: f9468d01    	ldr	x1, [x8, #0xd18] ; isEnterpriseChatSubBrand
10511df60: 94ac2477    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511df64: aa0003fa    	mov	x26, x0
10511df68: aa1603e0    	mov	x0, x22
10511df6c: 94ac247a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511df70: 3400027a    	cbz	w26, 0x10511dfbc <_Flutter_MMFoundation_BindContext+0x15f9ba0>
10511df74: b00d73e8    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
10511df78: f947ed01    	ldr	x1, [x8, #0xfd8] ; tryMoveToMainFrameTab
10511df7c: aa1b03e0    	mov	x0, x27
10511df80: 94ac246f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511df84: aa1303e0    	mov	x0, x19
10511df88: aa1903e1    	mov	x1, x25
10511df8c: 94ac246c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511df90: aa1d03fd    	mov	x29, x29
10511df94: 94ac246d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511df98: aa0003fc    	mov	x28, x0
10511df9c: d00d73e8    	adrp	x8, 0x11ff9b000 <dyld_stub_binder+0x11ff9b000>
10511dfa0: f9401501    	ldr	x1, [x8, #0x28] ; openEnterpriseChatSessionListView:animated:completion:
10511dfa4: aa1b03e0    	mov	x0, x27
10511dfa8: aa1c03e2    	mov	x2, x28
10511dfac: aa1703e3    	mov	x3, x23
10511dfb0: aa1803e4    	mov	x4, x24
10511dfb4: 94ac2462    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511dfb8: 14000044    	b	0x10511e0c8 <_Flutter_MMFoundation_BindContext+0x15f9cac>
10511dfbc: 29055ffc    	stp	w28, w23, [sp, #0x28]
10511dfc0: aa1b03fc    	mov	x28, x27
10511dfc4: aa1303e0    	mov	x0, x19
10511dfc8: aa1903e1    	mov	x1, x25
10511dfcc: 94ac245c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511dfd0: aa1d03fd    	mov	x29, x29
10511dfd4: 94ac245d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511dfd8: aa0003f6    	mov	x22, x0
10511dfdc: f00d6a08    	adrp	x8, 0x11fe60000 <dyld_stub_binder+0x11fe60000>
10511dfe0: f9472901    	ldr	x1, [x8, #0xe50] ; isEnterpriseWebSubBrand
10511dfe4: 94ac2456    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511dfe8: aa0003fa    	mov	x26, x0
10511dfec: aa1603e0    	mov	x0, x22
10511dff0: 94ac2459    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511dff4: 3400099a    	cbz	w26, 0x10511e124 <_Flutter_MMFoundation_BindContext+0x15f9d08>
10511dff8: b00d73e8    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
10511dffc: f947ed01    	ldr	x1, [x8, #0xfd8] ; tryMoveToMainFrameTab
10511e000: aa1c03e0    	mov	x0, x28
10511e004: 94ac244e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e008: b00d82a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10511e00c: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
10511e010: d00d7f08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10511e014: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10511e018: 94ac2449    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e01c: aa1d03fd    	mov	x29, x29
10511e020: 94ac244a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e024: aa0003fc    	mov	x28, x0
10511e028: 900d82c8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
10511e02c: f942bd00    	ldr	x0, [x8, #0x578] ; MMEnterpriseBrandSessionMgr
10511e030: b00d7f08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10511e034: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10511e038: 94ac2441    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e03c: aa0003e2    	mov	x2, x0
10511e040: f00d68c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10511e044: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10511e048: aa1c03e0    	mov	x0, x28
10511e04c: 94ac243c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e050: aa1d03fd    	mov	x29, x29
10511e054: 94ac243d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e058: aa0003f6    	mov	x22, x0
10511e05c: aa1303e0    	mov	x0, x19
10511e060: aa1903e1    	mov	x1, x25
10511e064: 94ac2436    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e068: aa1d03fd    	mov	x29, x29
10511e06c: 94ac2437    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e070: aa0003f9    	mov	x25, x0
10511e074: d00d82a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10511e078: f9408d00    	ldr	x0, [x8, #0x118] ; CAppViewControllerManager
10511e07c: f00d68e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10511e080: f9442901    	ldr	x1, [x8, #0x850] ; getCurrentNavigationController
10511e084: 94ac242e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e088: aa1d03fd    	mov	x29, x29
10511e08c: 94ac242f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e090: aa0003fa    	mov	x26, x0
10511e094: 900d6ee8    	adrp	x8, 0x11fefa000 <dyld_stub_binder+0x11fefa000>
10511e098: f947a101    	ldr	x1, [x8, #0xf40] ; openEnterpriseWebSubBrand:navigationController:completion:
10511e09c: aa1603e0    	mov	x0, x22
10511e0a0: aa1903e2    	mov	x2, x25
10511e0a4: aa1a03e3    	mov	x3, x26
10511e0a8: aa1803e4    	mov	x4, x24
10511e0ac: 94ac2424    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e0b0: aa1a03e0    	mov	x0, x26
10511e0b4: 94ac2428    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e0b8: aa1903e0    	mov	x0, x25
10511e0bc: 94ac2426    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e0c0: aa1603e0    	mov	x0, x22
10511e0c4: 94ac2424    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e0c8: f94023f7    	ldr	x23, [sp, #0x40]
10511e0cc: aa1503fb    	mov	x27, x21
10511e0d0: aa1c03e0    	mov	x0, x28
10511e0d4: 94ac2420    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e0d8: aa1803e0    	mov	x0, x24
10511e0dc: 94ac241e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e0e0: f94027e0    	ldr	x0, [sp, #0x48]
10511e0e4: 94ac241c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e0e8: aa1b03e0    	mov	x0, x27
10511e0ec: 94ac241a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e0f0: aa1703e0    	mov	x0, x23
10511e0f4: 94ac2418    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e0f8: aa1403e0    	mov	x0, x20
10511e0fc: 94ac2416    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e100: aa1303e0    	mov	x0, x19
10511e104: a94a7bfd    	ldp	x29, x30, [sp, #0xa0]
10511e108: a9494ff4    	ldp	x20, x19, [sp, #0x90]
10511e10c: a94857f6    	ldp	x22, x21, [sp, #0x80]
10511e110: a9475ff8    	ldp	x24, x23, [sp, #0x70]
10511e114: a94667fa    	ldp	x26, x25, [sp, #0x60]
10511e118: a9456ffc    	ldp	x28, x27, [sp, #0x50]
10511e11c: 9102c3ff    	add	sp, sp, #0xb0
10511e120: 14ac240d    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e124: a901d7f3    	stp	x19, x21, [sp, #0x18]
10511e128: f9001bf4    	str	x20, [sp, #0x30]
10511e12c: aa1303e0    	mov	x0, x19
10511e130: aa1903e1    	mov	x1, x25
10511e134: 94ac2402    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e138: aa1d03fd    	mov	x29, x29
10511e13c: 94ac2403    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e140: aa0003f6    	mov	x22, x0
10511e144: b00d68e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10511e148: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
10511e14c: f9000be1    	str	x1, [sp, #0x10]
10511e150: 94ac23fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e154: aa1d03fd    	mov	x29, x29
10511e158: 94ac23fc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e15c: aa0003f4    	mov	x20, x0
10511e160: b00d7f28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10511e164: f943c91a    	ldr	x26, [x8, #0x790] ; isEqualToString:
10511e168: d00c9c82    	adrp	x2, 0x11e4b0000 <dyld_stub_binder+0x11e4b0000>
10511e16c: 913aa042    	add	x2, x2, #0xea8 ; CFString 'chatroom_session_box'
10511e170: aa1a03e1    	mov	x1, x26
10511e174: 94ac23f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e178: aa0003fb    	mov	x27, x0
10511e17c: aa1403e0    	mov	x0, x20
10511e180: 94ac23f5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e184: aa1603e0    	mov	x0, x22
10511e188: 94ac23f3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e18c: f94023f7    	ldr	x23, [sp, #0x40]
10511e190: 340007fb    	cbz	w27, 0x10511e28c <_Flutter_MMFoundation_BindContext+0x15f9e70>
10511e194: 900d73e8    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
10511e198: f947ed01    	ldr	x1, [x8, #0xfd8] ; tryMoveToMainFrameTab
10511e19c: aa1c03f3    	mov	x19, x28
10511e1a0: aa1c03e0    	mov	x0, x28
10511e1a4: 94ac23e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e1a8: d00d82a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10511e1ac: f9402100    	ldr	x0, [x8, #0x40] ; ChatBoxReporter
10511e1b0: b00d73e8    	adrp	x8, 0x11ff9b000 <dyld_stub_binder+0x11ff9b000>
10511e1b4: f9401901    	ldr	x1, [x8, #0x30] ; reportEnterChatBox
10511e1b8: 94ac23e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e1bc: 900d82c8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
10511e1c0: f9451d00    	ldr	x0, [x8, #0xa38] ; ChatBoxSessionListViewController
10511e1c4: 94ac23e5    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
10511e1c8: aa0003fc    	mov	x28, x0
10511e1cc: b00d82b6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
10511e1d0: f9468ec0    	ldr	x0, [x22, #0xd18] ; DeviceInfo
10511e1d4: d00d68e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10511e1d8: f9412514    	ldr	x20, [x8, #0x248] ; isVisionPro
10511e1dc: aa1403e1    	mov	x1, x20
10511e1e0: 94ac23d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e1e4: b00d68e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10511e1e8: f946e101    	ldr	x1, [x8, #0xdc0] ; setHidesBottomBarWhenPushed:
10511e1ec: 52000002    	eor	w2, w0, #0x1
10511e1f0: aa1c03e0    	mov	x0, x28
10511e1f4: 94ac23d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e1f8: d00d8848    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10511e1fc: b9831508    	ldrsw	x8, [x8, #0x314]
10511e200: f8686a60    	ldr	x0, [x19, x8]
10511e204: b00d73e8    	adrp	x8, 0x11ff9b000 <dyld_stub_binder+0x11ff9b000>
10511e208: f9401d01    	ldr	x1, [x8, #0x38] ; lastEnterMainTabTime
10511e20c: 94ac23cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e210: aa0003e2    	mov	x2, x0
10511e214: b00d73e8    	adrp	x8, 0x11ff9b000 <dyld_stub_binder+0x11ff9b000>
10511e218: f9402101    	ldr	x1, [x8, #0x40] ; setLastEnterMainTabTime:
10511e21c: aa1c03e0    	mov	x0, x28
10511e220: 94ac23c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e224: f9468ec0    	ldr	x0, [x22, #0xd18] ; DeviceInfo
10511e228: aa1403e1    	mov	x1, x20
10511e22c: 94ac23c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e230: aa0003e2    	mov	x2, x0
10511e234: b00d73e8    	adrp	x8, 0x11ff9b000 <dyld_stub_binder+0x11ff9b000>
10511e238: f9402501    	ldr	x1, [x8, #0x48] ; setIsForceShowToPrimaryViewController:
10511e23c: aa1c03e0    	mov	x0, x28
10511e240: 94ac23bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e244: d00d7f28    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10511e248: f945dd01    	ldr	x1, [x8, #0xbb8] ; navigationController
10511e24c: aa1303e0    	mov	x0, x19
10511e250: 94ac23bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e254: aa1d03fd    	mov	x29, x29
10511e258: 94ac23bc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e25c: aa0003f4    	mov	x20, x0
10511e260: d00d6928    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10511e264: f9438901    	ldr	x1, [x8, #0x710] ; PushViewController:animated:completion:
10511e268: aa1c03e2    	mov	x2, x28
10511e26c: 52800023    	mov	w3, #0x1                ; =1
10511e270: aa1803e4    	mov	x4, x24
10511e274: 94ac23b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e278: aa1403e0    	mov	x0, x20
10511e27c: 94ac23b6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e280: f9401bf4    	ldr	x20, [sp, #0x30]
10511e284: a941eff3    	ldp	x19, x27, [sp, #0x18]
10511e288: 17ffff92    	b	0x10511e0d0 <_Flutter_MMFoundation_BindContext+0x15f9cb4>
10511e28c: b50000b7    	cbnz	x23, 0x10511e2a0 <_Flutter_MMFoundation_BindContext+0x15f9e84>
10511e290: b00d82a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10511e294: f9454100    	ldr	x0, [x8, #0xa80]
10511e298: 94ac23b0    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
10511e29c: aa0003f7    	mov	x23, x0
10511e2a0: b00d82a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10511e2a4: f9458914    	ldr	x20, [x8, #0xb10]
10511e2a8: f00d68e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10511e2ac: f942e501    	ldr	x1, [x8, #0x5c8] ; m_uUnReadCount
10511e2b0: f9400ff3    	ldr	x19, [sp, #0x18]
10511e2b4: aa1303e0    	mov	x0, x19
10511e2b8: 94ac23a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e2bc: 2a0003e2    	mov	w2, w0
10511e2c0: d00d7f28    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10511e2c4: f947c101    	ldr	x1, [x8, #0xf80] ; numberWithUnsignedInteger:
10511e2c8: aa1403e0    	mov	x0, x20
10511e2cc: f90023e1    	str	x1, [sp, #0x40]
10511e2d0: 94ac239b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e2d4: aa1d03fd    	mov	x29, x29
10511e2d8: 94ac239c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e2dc: aa0003f4    	mov	x20, x0
10511e2e0: f00d68c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10511e2e4: f942c915    	ldr	x21, [x8, #0x590] ; safeSetObject:forKey:
10511e2e8: f00c9c83    	adrp	x3, 0x11e4b1000 <dyld_stub_binder+0x11e4b1000>
10511e2ec: 912ca063    	add	x3, x3, #0xb28 ; CFString 'AllUnReadCount'
10511e2f0: aa1703e0    	mov	x0, x23
10511e2f4: aa1503e1    	mov	x1, x21
10511e2f8: aa1403e2    	mov	x2, x20
10511e2fc: 94ac2390    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e300: aa1403e0    	mov	x0, x20
10511e304: 94ac2394    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e308: aa1303e0    	mov	x0, x19
10511e30c: aa1903e1    	mov	x1, x25
10511e310: 94ac238b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e314: aa1d03fd    	mov	x29, x29
10511e318: 94ac238c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e31c: aa0003f6    	mov	x22, x0
10511e320: b00d68e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10511e324: f947b51b    	ldr	x27, [x8, #0xf68] ; isBrandContact
10511e328: aa1b03e1    	mov	x1, x27
10511e32c: 94ac2384    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e330: 34000080    	cbz	w0, 0x10511e340 <_Flutter_MMFoundation_BindContext+0x15f9f24>
10511e334: aa1603e0    	mov	x0, x22
10511e338: 94ac2387    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e33c: 1400001e    	b	0x10511e3b4 <_Flutter_MMFoundation_BindContext+0x15f9f98>
10511e340: aa1303e0    	mov	x0, x19
10511e344: aa1903e1    	mov	x1, x25
10511e348: 94ac237d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e34c: aa1d03fd    	mov	x29, x29
10511e350: 94ac237e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e354: aa0003f4    	mov	x20, x0
10511e358: f9400be1    	ldr	x1, [sp, #0x10]
10511e35c: 94ac2378    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e360: aa1d03fd    	mov	x29, x29
10511e364: 94ac2379    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e368: f90007f8    	str	x24, [sp, #0x8]
10511e36c: aa1c03f8    	mov	x24, x28
10511e370: aa1b03fc    	mov	x28, x27
10511e374: aa0003fb    	mov	x27, x0
10511e378: f00c9c62    	adrp	x2, 0x11e4ad000 <dyld_stub_binder+0x11e4ad000>
10511e37c: 910c2042    	add	x2, x2, #0x308 ; CFString 'notification_messages'
10511e380: aa1a03e1    	mov	x1, x26
10511e384: 94ac236e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e388: aa0003fa    	mov	x26, x0
10511e38c: aa1b03e0    	mov	x0, x27
10511e390: aa1c03fb    	mov	x27, x28
10511e394: aa1803fc    	mov	x28, x24
10511e398: f94007f8    	ldr	x24, [sp, #0x8]
10511e39c: 94ac236e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e3a0: aa1403e0    	mov	x0, x20
10511e3a4: 94ac236c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e3a8: aa1603e0    	mov	x0, x22
10511e3ac: 94ac236a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e3b0: 3400023a    	cbz	w26, 0x10511e3f4 <_Flutter_MMFoundation_BindContext+0x15f9fd8>
10511e3b4: b00d82a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10511e3b8: f9458900    	ldr	x0, [x8, #0xb10]
10511e3bc: f94023e1    	ldr	x1, [sp, #0x40]
10511e3c0: 528000a2    	mov	w2, #0x5                ; =5
10511e3c4: 94ac235e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e3c8: aa1d03fd    	mov	x29, x29
10511e3cc: 94ac235f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e3d0: aa0003f4    	mov	x20, x0
10511e3d4: f00c9c83    	adrp	x3, 0x11e4b1000 <dyld_stub_binder+0x11e4b1000>
10511e3d8: 912d2063    	add	x3, x3, #0xb48 ; CFString 'MinUnReadCountToShowTips'
10511e3dc: aa1703e0    	mov	x0, x23
10511e3e0: aa1503e1    	mov	x1, x21
10511e3e4: aa1403e2    	mov	x2, x20
10511e3e8: 94ac2355    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e3ec: aa1403e0    	mov	x0, x20
10511e3f0: 94ac2359    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e3f4: aa1503fa    	mov	x26, x21
10511e3f8: f00d7f55    	adrp	x21, 0x120109000 <dyld_stub_binder+0x120109000>
10511e3fc: b9402be8    	ldr	w8, [sp, #0x28]
10511e400: 37000248    	tbnz	w8, #0x0, 0x10511e448 <_Flutter_MMFoundation_BindContext+0x15fa02c>
10511e404: b00d82a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10511e408: f9458900    	ldr	x0, [x8, #0xb10]
10511e40c: d00d7f28    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10511e410: f9479501    	ldr	x1, [x8, #0xf28] ; numberWithBool:
10511e414: 52800022    	mov	w2, #0x1                ; =1
10511e418: 94ac2349    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e41c: aa1d03fd    	mov	x29, x29
10511e420: 94ac234a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e424: aa0003f4    	mov	x20, x0
10511e428: f9400aa1    	ldr	x1, [x21, #0x10] ; setObject:forKey:
10511e42c: 900c9d03    	adrp	x3, 0x11e4be000 <dyld_stub_binder+0x11e4be000>
10511e430: 9128a063    	add	x3, x3, #0xa28 ; CFString 'JumpFromMainFrameSelect'
10511e434: aa1703e0    	mov	x0, x23
10511e438: aa1403e2    	mov	x2, x20
10511e43c: 94ac2340    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e440: aa1403e0    	mov	x0, x20
10511e444: 94ac2344    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e448: aa1303e0    	mov	x0, x19
10511e44c: aa1903e1    	mov	x1, x25
10511e450: 94ac233b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e454: aa1d03fd    	mov	x29, x29
10511e458: 94ac233c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e45c: aa0003f4    	mov	x20, x0
10511e460: aa1b03e1    	mov	x1, x27
10511e464: 94ac2336    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e468: aa0003f5    	mov	x21, x0
10511e46c: aa1403e0    	mov	x0, x20
10511e470: 94ac2339    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e474: d00d7f36    	adrp	x22, 0x120104000 <dyld_stub_binder+0x120104000>
10511e478: 34000395    	cbz	w21, 0x10511e4e8 <_Flutter_MMFoundation_BindContext+0x15fa0cc>
10511e47c: d00d7f28    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10511e480: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
10511e484: f00c9c82    	adrp	x2, 0x11e4b1000 <dyld_stub_binder+0x11e4b1000>
10511e488: 91262042    	add	x2, x2, #0x988 ; CFString 'BizChatRoomEnterSubScene'
10511e48c: aa1703e0    	mov	x0, x23
10511e490: 94ac232b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e494: aa1d03fd    	mov	x29, x29
10511e498: 94ac232c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e49c: aa0003f4    	mov	x20, x0
10511e4a0: 94ac232d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e4a4: b5000234    	cbnz	x20, 0x10511e4e8 <_Flutter_MMFoundation_BindContext+0x15fa0cc>
10511e4a8: b00d82a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10511e4ac: f9458900    	ldr	x0, [x8, #0xb10]
10511e4b0: f947aac1    	ldr	x1, [x22, #0xf50] ; numberWithInteger:
10511e4b4: 528000e2    	mov	w2, #0x7                ; =7
10511e4b8: 94ac2321    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e4bc: aa1d03fd    	mov	x29, x29
10511e4c0: 94ac2322    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e4c4: aa0003f4    	mov	x20, x0
10511e4c8: f00c9c83    	adrp	x3, 0x11e4b1000 <dyld_stub_binder+0x11e4b1000>
10511e4cc: 91262063    	add	x3, x3, #0x988 ; CFString 'BizChatRoomEnterSubScene'
10511e4d0: aa1703e0    	mov	x0, x23
10511e4d4: aa1a03e1    	mov	x1, x26
10511e4d8: aa1403e2    	mov	x2, x20
10511e4dc: 94ac2318    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e4e0: aa1403e0    	mov	x0, x20
10511e4e4: 94ac231c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e4e8: b00d7f14    	adrp	x20, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10511e4ec: f9401bfb    	ldr	x27, [sp, #0x30]
10511e4f0: b40004fb    	cbz	x27, 0x10511e58c <_Flutter_MMFoundation_BindContext+0x15fa170>
10511e4f4: d00d8848    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10511e4f8: b9831908    	ldrsw	x8, [x8, #0x318]
10511e4fc: f8686b80    	ldr	x0, [x28, x8]
10511e500: d00d68e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10511e504: f9416101    	ldr	x1, [x8, #0x2c0] ; cellForRowAtIndexPath:
10511e508: aa1b03e2    	mov	x2, x27
10511e50c: 94ac230c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e510: aa1d03fd    	mov	x29, x29
10511e514: 94ac230d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e518: aa0003f5    	mov	x21, x0
10511e51c: b00d82e8    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
10511e520: f9421100    	ldr	x0, [x8, #0x420] ; NewMainFrameCell
10511e524: f947ae81    	ldr	x1, [x20, #0xf58] ; class
10511e528: 94ac2305    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e52c: aa0003e2    	mov	x2, x0
10511e530: b00d7f28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10511e534: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
10511e538: aa1503e0    	mov	x0, x21
10511e53c: 94ac2300    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e540: 34000220    	cbz	w0, 0x10511e584 <_Flutter_MMFoundation_BindContext+0x15fa168>
10511e544: d00d6b08    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
10511e548: f9440d01    	ldr	x1, [x8, #0x818] ; getGreenLabelText
10511e54c: aa1503e0    	mov	x0, x21
10511e550: 94ac22fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e554: aa1d03fd    	mov	x29, x29
10511e558: 94ac22fc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e55c: aa0003f4    	mov	x20, x0
10511e560: 900ca0a3    	adrp	x3, 0x11e532000 <dyld_stub_binder+0x11e532000>
10511e564: 912aa063    	add	x3, x3, #0xaa8 ; CFString 'redLabelValue'
10511e568: aa1703e0    	mov	x0, x23
10511e56c: aa1a03e1    	mov	x1, x26
10511e570: aa1403e2    	mov	x2, x20
10511e574: 94ac22f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e578: aa1403e0    	mov	x0, x20
10511e57c: f9401bfb    	ldr	x27, [sp, #0x30]
10511e580: 94ac22f5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e584: aa1503e0    	mov	x0, x21
10511e588: 94ac22f3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e58c: b00d82b6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
10511e590: f9458ad4    	ldr	x20, [x22, #0xb10]
10511e594: b00d82b5    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
10511e598: f9467aa0    	ldr	x0, [x21, #0xcf0] ; CUtility
10511e59c: d00d6908    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
10511e5a0: f942c501    	ldr	x1, [x8, #0x588] ; genCurrentTimeInMsFrom1970
10511e5a4: 94ac22e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e5a8: aa0003e2    	mov	x2, x0
10511e5ac: d00d7f28    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10511e5b0: f947c901    	ldr	x1, [x8, #0xf90] ; numberWithUnsignedLongLong:
10511e5b4: aa1403e0    	mov	x0, x20
10511e5b8: 94ac22e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e5bc: aa1d03fd    	mov	x29, x29
10511e5c0: 94ac22e2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e5c4: aa0003f4    	mov	x20, x0
10511e5c8: f00d7f48    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
10511e5cc: f9400901    	ldr	x1, [x8, #0x10] ; setObject:forKey:
10511e5d0: f00c9ce3    	adrp	x3, 0x11e4bd000 <dyld_stub_binder+0x11e4bd000>
10511e5d4: 91392063    	add	x3, x3, #0xe48 ; CFString 'EnterTime'
10511e5d8: aa1703e0    	mov	x0, x23
10511e5dc: aa1403e2    	mov	x2, x20
10511e5e0: 94ac22d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e5e4: aa1403e0    	mov	x0, x20
10511e5e8: 94ac22db    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e5ec: f9458ad4    	ldr	x20, [x22, #0xb10]
10511e5f0: f9467aa0    	ldr	x0, [x21, #0xcf0] ; CUtility
10511e5f4: b00d68e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10511e5f8: f9457101    	ldr	x1, [x8, #0xae0] ; genCurrentTime
10511e5fc: 94ac22d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e600: aa0003e2    	mov	x2, x0
10511e604: d00d7f28    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10511e608: f947bd01    	ldr	x1, [x8, #0xf78] ; numberWithUnsignedInt:
10511e60c: aa1403e0    	mov	x0, x20
10511e610: f90023e1    	str	x1, [sp, #0x40]
10511e614: 94ac22ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e618: aa1d03fd    	mov	x29, x29
10511e61c: 94ac22cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e620: aa0003f4    	mov	x20, x0
10511e624: b00c9c83    	adrp	x3, 0x11e4af000 <dyld_stub_binder+0x11e4af000>
10511e628: 912aa063    	add	x3, x3, #0xaa8 ; CFString 'SessionId'
10511e62c: aa1703e0    	mov	x0, x23
10511e630: aa1a03e1    	mov	x1, x26
10511e634: aa1403e2    	mov	x2, x20
10511e638: 94ac22c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e63c: aa1403e0    	mov	x0, x20
10511e640: 94ac22c5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e644: f9458ad4    	ldr	x20, [x22, #0xb10]
10511e648: f00d68e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10511e64c: f9412901    	ldr	x1, [x8, #0x250] ; indexInAllVisibleSessions:
10511e650: aa1c03e0    	mov	x0, x28
10511e654: aa1b03e2    	mov	x2, x27
10511e658: 94ac22b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e65c: aa0003e2    	mov	x2, x0
10511e660: d00d7f28    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10511e664: f947a901    	ldr	x1, [x8, #0xf50] ; numberWithInteger:
10511e668: aa1403e0    	mov	x0, x20
10511e66c: 94ac22b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e670: aa1d03fd    	mov	x29, x29
10511e674: 94ac22b5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e678: aa0003f4    	mov	x20, x0
10511e67c: f00c9ce3    	adrp	x3, 0x11e4bd000 <dyld_stub_binder+0x11e4bd000>
10511e680: 913a2063    	add	x3, x3, #0xe88 ; CFString 'IndexInMainSessionList'
10511e684: aa1703e0    	mov	x0, x23
10511e688: aa1a03e1    	mov	x1, x26
10511e68c: aa1403e2    	mov	x2, x20
10511e690: 94ac22ab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e694: aa1403e0    	mov	x0, x20
10511e698: 94ac22af    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e69c: f94013fb    	ldr	x27, [sp, #0x20]
10511e6a0: b40000db    	cbz	x27, 0x10511e6b8 <_Flutter_MMFoundation_BindContext+0x15fa29c>
10511e6a4: aa1b03e0    	mov	x0, x27
10511e6a8: 94ac22a4    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511e6ac: aa1b03fc    	mov	x28, x27
10511e6b0: f94027fa    	ldr	x26, [sp, #0x48]
10511e6b4: 14000014    	b	0x10511e704 <_Flutter_MMFoundation_BindContext+0x15fa2e8>
10511e6b8: b00d82a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10511e6bc: f9468d00    	ldr	x0, [x8, #0xd18] ; DeviceInfo
10511e6c0: b00d7f28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10511e6c4: f9457d01    	ldr	x1, [x8, #0xaf8] ; isiPad
10511e6c8: 94ac229d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e6cc: f94027fa    	ldr	x26, [sp, #0x48]
10511e6d0: 340000a0    	cbz	w0, 0x10511e6e4 <_Flutter_MMFoundation_BindContext+0x15fa2c8>
10511e6d4: d00d7f28    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10511e6d8: f945dd01    	ldr	x1, [x8, #0xbb8] ; navigationController
10511e6dc: aa1c03e0    	mov	x0, x28
10511e6e0: 14000005    	b	0x10511e6f4 <_Flutter_MMFoundation_BindContext+0x15fa2d8>
10511e6e4: d00d82a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10511e6e8: f9408d00    	ldr	x0, [x8, #0x118] ; CAppViewControllerManager
10511e6ec: f00d68e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10511e6f0: f9442901    	ldr	x1, [x8, #0x850] ; getCurrentNavigationController
10511e6f4: 94ac2292    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e6f8: aa1d03fd    	mov	x29, x29
10511e6fc: 94ac2293    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e700: aa0003fc    	mov	x28, x0
10511e704: aa1a03e0    	mov	x0, x26
10511e708: 94ac228c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511e70c: d00d7f28    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10511e710: f947f916    	ldr	x22, [x8, #0xff0] ; objectForKeyedSubscript:
10511e714: f00c9c82    	adrp	x2, 0x11e4b1000 <dyld_stub_binder+0x11e4b1000>
10511e718: 9126a042    	add	x2, x2, #0x9a8 ; CFString 'EntryJumpToMsg'
10511e71c: aa1703e0    	mov	x0, x23
10511e720: aa1603e1    	mov	x1, x22
10511e724: 94ac2286    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e728: aa1d03fd    	mov	x29, x29
10511e72c: 94ac2287    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e730: aa0003f4    	mov	x20, x0
10511e734: 94ac2288    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e738: b4000194    	cbz	x20, 0x10511e768 <_Flutter_MMFoundation_BindContext+0x15fa34c>
10511e73c: f00c9c82    	adrp	x2, 0x11e4b1000 <dyld_stub_binder+0x11e4b1000>
10511e740: 9126a042    	add	x2, x2, #0x9a8 ; CFString 'EntryJumpToMsg'
10511e744: aa1703e0    	mov	x0, x23
10511e748: aa1603e1    	mov	x1, x22
10511e74c: 94ac227c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e750: aa1d03fd    	mov	x29, x29
10511e754: 94ac227d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e758: aa0003f5    	mov	x21, x0
10511e75c: aa1a03e0    	mov	x0, x26
10511e760: 94ac227d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e764: 14000002    	b	0x10511e76c <_Flutter_MMFoundation_BindContext+0x15fa350>
10511e768: aa1a03f5    	mov	x21, x26
10511e76c: aa1303e0    	mov	x0, x19
10511e770: aa1903e1    	mov	x1, x25
10511e774: 94ac2272    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e778: aa1d03fd    	mov	x29, x29
10511e77c: 94ac2273    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e780: aa0003fa    	mov	x26, x0
10511e784: b00d68e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10511e788: f947c901    	ldr	x1, [x8, #0xf90] ; isChatBot
10511e78c: 94ac226c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e790: 34000580    	cbz	w0, 0x10511e840 <_Flutter_MMFoundation_BindContext+0x15fa424>
10511e794: aa1303e0    	mov	x0, x19
10511e798: aa1903e1    	mov	x1, x25
10511e79c: 94ac2268    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e7a0: aa1d03fd    	mov	x29, x29
10511e7a4: 94ac2269    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e7a8: aa0003f4    	mov	x20, x0
10511e7ac: 900d68e8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10511e7b0: f943a101    	ldr	x1, [x8, #0x740] ; getAttachedObjectForKey:
10511e7b4: b00c9d02    	adrp	x2, 0x11e4bf000 <dyld_stub_binder+0x11e4bf000>
10511e7b8: 912aa042    	add	x2, x2, #0xaa8 ; CFString 'enter_type'
10511e7bc: 94ac2260    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e7c0: aa1d03fd    	mov	x29, x29
10511e7c4: 94ac2261    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e7c8: aa0003f6    	mov	x22, x0
10511e7cc: 94ac2262    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e7d0: aa1403e0    	mov	x0, x20
10511e7d4: 94ac2260    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e7d8: aa1a03e0    	mov	x0, x26
10511e7dc: 94ac225e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e7e0: b5000356    	cbnz	x22, 0x10511e848 <_Flutter_MMFoundation_BindContext+0x15fa42c>
10511e7e4: aa1303e0    	mov	x0, x19
10511e7e8: aa1903e1    	mov	x1, x25
10511e7ec: 94ac2254    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e7f0: aa1d03fd    	mov	x29, x29
10511e7f4: 94ac2255    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e7f8: aa0003fa    	mov	x26, x0
10511e7fc: b00d82a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10511e800: f9458900    	ldr	x0, [x8, #0xb10]
10511e804: f94023e1    	ldr	x1, [sp, #0x40]
10511e808: 52800042    	mov	w2, #0x2                ; =2
10511e80c: 94ac224c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e810: aa1d03fd    	mov	x29, x29
10511e814: 94ac224d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e818: aa0003f4    	mov	x20, x0
10511e81c: 900d68e8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10511e820: f943a501    	ldr	x1, [x8, #0x748] ; attachObject:forKey:
10511e824: b00c9d03    	adrp	x3, 0x11e4bf000 <dyld_stub_binder+0x11e4bf000>
10511e828: 912aa063    	add	x3, x3, #0xaa8 ; CFString 'enter_type'
10511e82c: aa1a03e0    	mov	x0, x26
10511e830: aa1403e2    	mov	x2, x20
10511e834: 94ac2242    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e838: aa1403e0    	mov	x0, x20
10511e83c: 94ac2246    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e840: aa1a03e0    	mov	x0, x26
10511e844: 94ac2244    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e848: b00d82a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10511e84c: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
10511e850: d00d7f08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10511e854: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10511e858: 94ac2239    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e85c: aa1d03fd    	mov	x29, x29
10511e860: 94ac223a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e864: aa0003f4    	mov	x20, x0
10511e868: d00d82a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10511e86c: f940a100    	ldr	x0, [x8, #0x140] ; MMMsgLogicManager
10511e870: b00d7f08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10511e874: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10511e878: 94ac2231    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e87c: aa0003e2    	mov	x2, x0
10511e880: f00d68c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10511e884: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10511e888: aa1403e0    	mov	x0, x20
10511e88c: 94ac222c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e890: aa1d03fd    	mov	x29, x29
10511e894: 94ac222d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e898: aa0003f6    	mov	x22, x0
10511e89c: aa1303e0    	mov	x0, x19
10511e8a0: aa1903e1    	mov	x1, x25
10511e8a4: 94ac2226    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e8a8: aa1d03fd    	mov	x29, x29
10511e8ac: 94ac2227    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e8b0: aa0003fa    	mov	x26, x0
10511e8b4: d00d6b08    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
10511e8b8: f9441501    	ldr	x1, [x8, #0x828] ; PushLogicControllerByContact:navigationController:animated:jumpToLocationNode:reuse:extraInfo:completion:
10511e8bc: f90003f8    	str	x24, [sp]
10511e8c0: aa1603e0    	mov	x0, x22
10511e8c4: aa1a03e2    	mov	x2, x26
10511e8c8: aa1c03e3    	mov	x3, x28
10511e8cc: b9402fe4    	ldr	w4, [sp, #0x2c]
10511e8d0: aa1503e5    	mov	x5, x21
10511e8d4: b9403fe6    	ldr	w6, [sp, #0x3c]
10511e8d8: aa1703e7    	mov	x7, x23
10511e8dc: 94ac2218    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e8e0: aa1a03e0    	mov	x0, x26
10511e8e4: 94ac221c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e8e8: aa1603e0    	mov	x0, x22
10511e8ec: 94ac221a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e8f0: aa1403e0    	mov	x0, x20
10511e8f4: 94ac2218    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e8f8: 900d82c8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
10511e8fc: f9428514    	ldr	x20, [x8, #0x508] ; MsgPlayingFacade
10511e900: aa1303e0    	mov	x0, x19
10511e904: aa1903e1    	mov	x1, x25
10511e908: 94ac220d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e90c: aa1d03fd    	mov	x29, x29
10511e910: 94ac220e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e914: aa0003f6    	mov	x22, x0
10511e918: f9400be1    	ldr	x1, [sp, #0x10]
10511e91c: 94ac2208    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e920: aa1d03fd    	mov	x29, x29
10511e924: 94ac2209    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511e928: aa0003f9    	mov	x25, x0
10511e92c: b00d73e8    	adrp	x8, 0x11ff9b000 <dyld_stub_binder+0x11ff9b000>
10511e930: f9402901    	ldr	x1, [x8, #0x50] ; tryReportEnterSession:info:
10511e934: aa1403e0    	mov	x0, x20
10511e938: aa1903e2    	mov	x2, x25
10511e93c: 52800043    	mov	w3, #0x2                ; =2
10511e940: d2800004    	mov	x4, #0x0                ; =0
10511e944: 94ac21fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511e948: aa1903e0    	mov	x0, x25
10511e94c: 94ac2202    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e950: aa1603e0    	mov	x0, x22
10511e954: 94ac2200    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e958: aa1503e0    	mov	x0, x21
10511e95c: 94ac21fe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511e960: f9401bf4    	ldr	x20, [sp, #0x30]
10511e964: 17fffddb    	b	0x10511e0d0 <_Flutter_MMFoundation_BindContext+0x15f9cb4>
