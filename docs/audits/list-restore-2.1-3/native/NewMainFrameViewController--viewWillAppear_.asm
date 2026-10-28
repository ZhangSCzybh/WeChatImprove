
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105118b28: d101c3ff    	sub	sp, sp, #0x70
105118b2c: a9035ff8    	stp	x24, x23, [sp, #0x30]
105118b30: a90457f6    	stp	x22, x21, [sp, #0x40]
105118b34: a9054ff4    	stp	x20, x19, [sp, #0x50]
105118b38: a9067bfd    	stp	x29, x30, [sp, #0x60]
105118b3c: 910183fd    	add	x29, sp, #0x60
105118b40: aa0003f3    	mov	x19, x0
105118b44: f00c26a8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
105118b48: f9405908    	ldr	x8, [x8, #0xb0]
105118b4c: f9400108    	ldr	x8, [x8]
105118b50: f90017e8    	str	x8, [sp, #0x28]
105118b54: f00dd928    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
105118b58: 52800029    	mov	w9, #0x1                ; =1
105118b5c: 392dad09    	strb	w9, [x8, #0xb6b]
105118b60: d00d8568    	adrp	x8, 0x1201c6000 <dyld_stub_binder+0x1201c6000>
105118b64: f9406108    	ldr	x8, [x8, #0xc0] ; NewMainFrameViewController
105118b68: a900a3e0    	stp	x0, x8, [sp, #0x8]
105118b6c: 900d6928    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105118b70: f941d101    	ldr	x1, [x8, #0x3a0] ; viewWillAppear:
105118b74: 910023e0    	add	x0, sp, #0x8
105118b78: 94ac3973    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
105118b7c: 900d7068    	adrp	x8, 0x11ff24000 <dyld_stub_binder+0x11ff24000>
105118b80: f940dd01    	ldr	x1, [x8, #0x1b8] ; setIsAppear:
105118b84: aa1303e0    	mov	x0, x19
105118b88: 52800022    	mov	w2, #0x1                ; =1
105118b8c: 94ac396c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118b90: d00d7408    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
105118b94: f946cd01    	ldr	x1, [x8, #0xd98] ; startVoiceSearchRotationDetection
105118b98: aa1303e0    	mov	x0, x19
105118b9c: 94ac3968    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118ba0: b00d82e8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
105118ba4: f9467d00    	ldr	x0, [x8, #0xcf8] ; WCFinderKVReporter
105118ba8: f00d6b88    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
105118bac: f9437901    	ldr	x1, [x8, #0x6f0] ; pageSourceForTabWillAppear:
105118bb0: d2800002    	mov	x2, #0x0                ; =0
105118bb4: 94ac3962    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118bb8: aa0003e2    	mov	x2, x0
105118bbc: f00d6b88    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
105118bc0: f9437d01    	ldr	x1, [x8, #0x6f8] ; setCurTabPageSource:
105118bc4: aa1303e0    	mov	x0, x19
105118bc8: 94ac395d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118bcc: f00d82c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105118bd0: f9458d00    	ldr	x0, [x8, #0xb18]
105118bd4: 900d7f48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105118bd8: f946b101    	ldr	x1, [x8, #0xd60] ; defaultCenter
105118bdc: 94ac3958    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118be0: aa1d03fd    	mov	x29, x29
105118be4: 94ac3959    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105118be8: aa0003f4    	mov	x20, x0
105118bec: b00c9d48    	adrp	x8, 0x11e4c1000 <dyld_stub_binder+0x11e4c1000>
105118bf0: 912ea108    	add	x8, x8, #0xba8 ; CFString 'is'
105118bf4: f9000fe8    	str	x8, [sp, #0x18]
105118bf8: f00d82c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105118bfc: f9458900    	ldr	x0, [x8, #0xb10]
105118c00: 900d7f68    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
105118c04: f9479501    	ldr	x1, [x8, #0xf28] ; numberWithBool:
105118c08: 52800022    	mov	w2, #0x1                ; =1
105118c0c: 94ac394c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118c10: aa1d03fd    	mov	x29, x29
105118c14: 94ac394d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105118c18: aa0003f5    	mov	x21, x0
105118c1c: f90013e0    	str	x0, [sp, #0x20]
105118c20: f00d82c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105118c24: f9457500    	ldr	x0, [x8, #0xae8]
105118c28: b00d7f48    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
105118c2c: f9402901    	ldr	x1, [x8, #0x50] ; dictionaryWithObjects:forKeys:count:
105118c30: 910083e2    	add	x2, sp, #0x20
105118c34: 910063e3    	add	x3, sp, #0x18
105118c38: 52800024    	mov	w4, #0x1                ; =1
105118c3c: 94ac3940    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118c40: aa1d03fd    	mov	x29, x29
105118c44: 94ac3941    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105118c48: aa0003f6    	mov	x22, x0
105118c4c: b00d7f68    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
105118c50: f944d901    	ldr	x1, [x8, #0x9b0] ; postNotificationName:object:userInfo:
105118c54: b00c9d42    	adrp	x2, 0x11e4c1000 <dyld_stub_binder+0x11e4c1000>
105118c58: 912e2042    	add	x2, x2, #0xb88 ; CFString 'kMMLayoutSceneChatTypeChanged'
105118c5c: aa1403e0    	mov	x0, x20
105118c60: d2800003    	mov	x3, #0x0                ; =0
105118c64: aa1603e4    	mov	x4, x22
105118c68: 94ac3935    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118c6c: aa1603e0    	mov	x0, x22
105118c70: 94ac3939    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105118c74: aa1503e0    	mov	x0, x21
105118c78: 94ac3937    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105118c7c: aa1403e0    	mov	x0, x20
105118c80: 94ac3935    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105118c84: d00d7408    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
105118c88: f9472501    	ldr	x1, [x8, #0xe48] ; isTaskBarNeedHideTabBar
105118c8c: aa1303e0    	mov	x0, x19
105118c90: 94ac392b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118c94: 900d7f77    	adrp	x23, 0x120104000 <dyld_stub_binder+0x120104000>
105118c98: 36000080    	tbz	w0, #0x0, 0x105118ca8 <_Flutter_MMFoundation_BindContext+0x15f488c>
105118c9c: d00d7415    	adrp	x21, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
105118ca0: 913942b5    	add	x21, x21, #0xe50
105118ca4: 14000019    	b	0x105118d08 <_Flutter_MMFoundation_BindContext+0x15f48ec>
105118ca8: f945dee1    	ldr	x1, [x23, #0xbb8] ; navigationController
105118cac: aa1303e0    	mov	x0, x19
105118cb0: 94ac3923    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118cb4: aa1d03fd    	mov	x29, x29
105118cb8: 94ac3924    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105118cbc: aa0003f4    	mov	x20, x0
105118cc0: f00d7f88    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
105118cc4: f946e501    	ldr	x1, [x8, #0xdc8] ; viewControllers
105118cc8: 94ac391d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118ccc: aa1d03fd    	mov	x29, x29
105118cd0: 94ac391e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105118cd4: aa0003f5    	mov	x21, x0
105118cd8: 900d7f48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105118cdc: f9435101    	ldr	x1, [x8, #0x6a0] ; count
105118ce0: 94ac3917    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118ce4: aa0003f6    	mov	x22, x0
105118ce8: aa1503e0    	mov	x0, x21
105118cec: 94ac391a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105118cf0: aa1403e0    	mov	x0, x20
105118cf4: 94ac3918    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105118cf8: f10006df    	cmp	x22, #0x1
105118cfc: 54000208    	b.hi	0x105118d3c <_Flutter_MMFoundation_BindContext+0x15f4920>
105118d00: f00d6b95    	adrp	x21, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
105118d04: 911c02b5    	add	x21, x21, #0x700
105118d08: 900d82e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105118d0c: f9408d00    	ldr	x0, [x8, #0x118] ; CAppViewControllerManager
105118d10: d00d6948    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
105118d14: f942a901    	ldr	x1, [x8, #0x550] ; getTabBarController
105118d18: 94ac3909    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118d1c: aa1d03fd    	mov	x29, x29
105118d20: 94ac390a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105118d24: aa0003f4    	mov	x20, x0
105118d28: f94002a1    	ldr	x1, [x21]
105118d2c: d2800002    	mov	x2, #0x0                ; =0
105118d30: 94ac3903    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118d34: aa1403e0    	mov	x0, x20
105118d38: 94ac3907    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105118d3c: 900d8888    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105118d40: b9832908    	ldrsw	x8, [x8, #0x328]
105118d44: 38686a69    	ldrb	w9, [x19, x8]
105118d48: 7100053f    	cmp	w9, #0x1
105118d4c: 540000e1    	b.ne	0x105118d68 <_Flutter_MMFoundation_BindContext+0x15f494c>
105118d50: 38286a7f    	strb	wzr, [x19, x8]
105118d54: d00d7408    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
105118d58: f9472d01    	ldr	x1, [x8, #0xe58] ; resetTableViewOffset:
105118d5c: aa1303e0    	mov	x0, x19
105118d60: d2800002    	mov	x2, #0x0                ; =0
105118d64: 94ac38f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118d68: 900d7368    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
105118d6c: f9465d01    	ldr	x1, [x8, #0xcb8] ; cancelSelectedCell
105118d70: aa1303e0    	mov	x0, x19
105118d74: 94ac38f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118d78: f945dee1    	ldr	x1, [x23, #0xbb8] ; navigationController
105118d7c: aa1303e0    	mov	x0, x19
105118d80: 94ac38ef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118d84: aa1d03fd    	mov	x29, x29
105118d88: 94ac38f0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105118d8c: aa0003f4    	mov	x20, x0
105118d90: 900d6928    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105118d94: f941e901    	ldr	x1, [x8, #0x3d0] ; setNavigationBarHidden:
105118d98: 52800002    	mov	w2, #0x0                ; =0
105118d9c: 94ac38e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118da0: aa1403e0    	mov	x0, x20
105118da4: 94ac38ec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105118da8: 900d8888    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105118dac: b9836508    	ldrsw	x8, [x8, #0x364]
105118db0: f8686a75    	ldr	x21, [x19, x8]
105118db4: 900d8888    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105118db8: b9831514    	ldrsw	x20, [x8, #0x314]
105118dbc: f8746a60    	ldr	x0, [x19, x20]
105118dc0: b00d7188    	adrp	x8, 0x11ff49000 <dyld_stub_binder+0x11ff49000>
105118dc4: f9436d01    	ldr	x1, [x8, #0x6d8] ; getSessionCount
105118dc8: 94ac38dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118dcc: eb2042bf    	cmp	x21, w0, uxtw
105118dd0: 900d8895    	adrp	x21, 0x120228000 <dyld_stub_binder+0x120228000>
105118dd4: 540002c0    	b.eq	0x105118e2c <_Flutter_MMFoundation_BindContext+0x15f4a10>
105118dd8: f00d82c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105118ddc: f9453500    	ldr	x0, [x8, #0xa68] ; iConsole
105118de0: b00d6908    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105118de4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
105118de8: 900cb5e8    	adrp	x8, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
105118dec: 9122a108    	add	x8, x8, #0x8a8 ; CFString 'reload tableview on row num not matched'
105118df0: f90003e8    	str	x8, [sp]
105118df4: 900b3a05    	adrp	x5, 0x11b858000 <dyld_stub_binder+0x11b858000>
105118df8: 9122e0a5    	add	x5, x5, #0x8b8
105118dfc: b00b3a07    	adrp	x7, 0x11b859000 <dyld_stub_binder+0x11b859000>
105118e00: 9116f8e7    	add	x7, x7, #0x5be
105118e04: 52800042    	mov	w2, #0x2                ; =2
105118e08: d2800003    	mov	x3, #0x0                ; =0
105118e0c: 52800004    	mov	w4, #0x0                ; =0
105118e10: 5280bbc6    	mov	w6, #0x5de              ; =1502
105118e14: 94ac38ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118e18: b9831aa8    	ldrsw	x8, [x21, #0x318]
105118e1c: f8686a60    	ldr	x0, [x19, x8]
105118e20: d00d7f68    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
105118e24: f9404501    	ldr	x1, [x8, #0x88] ; reloadData
105118e28: 94ac38c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118e2c: d00d7408    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
105118e30: f9473101    	ldr	x1, [x8, #0xe60] ; notifyTaskBarOnViewWillAppear
105118e34: aa1303e0    	mov	x0, x19
105118e38: 94ac38c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118e3c: d00d7408    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
105118e40: f9473501    	ldr	x1, [x8, #0xe68] ; notifyMiniTaskEntryWhenViewWillAppear
105118e44: aa1303e0    	mov	x0, x19
105118e48: 94ac38bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118e4c: f8746a74    	ldr	x20, [x19, x20]
105118e50: b9831aa8    	ldrsw	x8, [x21, #0x318]
105118e54: f8686a60    	ldr	x0, [x19, x8]
105118e58: 900d6968    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
105118e5c: f9451101    	ldr	x1, [x8, #0xa20] ; indexPathsForVisibleRows
105118e60: 94ac38b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118e64: aa1d03fd    	mov	x29, x29
105118e68: 94ac38b8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105118e6c: aa0003f3    	mov	x19, x0
105118e70: d00d7408    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
105118e74: f9473901    	ldr	x1, [x8, #0xe70] ; onPageAppearWithVisibleCellsIndexPath:reason:
105118e78: aa1403e0    	mov	x0, x20
105118e7c: aa1303e2    	mov	x2, x19
105118e80: 52800023    	mov	w3, #0x1                ; =1
105118e84: 94ac38ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118e88: aa1303e0    	mov	x0, x19
105118e8c: 94ac38b2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105118e90: f94017e8    	ldr	x8, [sp, #0x28]
105118e94: f00c26a9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
105118e98: f9405929    	ldr	x9, [x9, #0xb0]
105118e9c: f9400129    	ldr	x9, [x9]
105118ea0: eb08013f    	cmp	x9, x8
105118ea4: 540000e1    	b.ne	0x105118ec0 <_Flutter_MMFoundation_BindContext+0x15f4aa4>
105118ea8: a9467bfd    	ldp	x29, x30, [sp, #0x60]
105118eac: a9454ff4    	ldp	x20, x19, [sp, #0x50]
105118eb0: a94457f6    	ldp	x22, x21, [sp, #0x40]
105118eb4: a9435ff8    	ldp	x24, x23, [sp, #0x30]
105118eb8: 9101c3ff    	add	sp, sp, #0x70
105118ebc: d65f03c0    	ret
105118ec0: 94ac38ad    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
