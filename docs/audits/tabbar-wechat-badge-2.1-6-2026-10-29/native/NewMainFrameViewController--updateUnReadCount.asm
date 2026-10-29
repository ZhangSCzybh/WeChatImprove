
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1051129d4: d101c3ff    	sub	sp, sp, #0x70
1051129d8: a9016ffc    	stp	x28, x27, [sp, #0x10]
1051129dc: a90267fa    	stp	x26, x25, [sp, #0x20]
1051129e0: a9035ff8    	stp	x24, x23, [sp, #0x30]
1051129e4: a90457f6    	stp	x22, x21, [sp, #0x40]
1051129e8: a9054ff4    	stp	x20, x19, [sp, #0x50]
1051129ec: a9067bfd    	stp	x29, x30, [sp, #0x60]
1051129f0: 910183fd    	add	x29, sp, #0x60
1051129f4: aa0003f4    	mov	x20, x0
1051129f8: b00dd968    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
1051129fc: 52800029    	mov	w9, #0x1                ; =1
105112a00: 392d5109    	strb	w9, [x8, #0xb54]
105112a04: d00d88a8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105112a08: b9831508    	ldrsw	x8, [x8, #0x314]
105112a0c: f8686800    	ldr	x0, [x0, x8]
105112a10: d00d6988    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
105112a14: f945dd01    	ldr	x1, [x8, #0xbb8] ; selector getTotalUnreadCount
105112a18: 94ac51c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112a1c: aa0003f5    	mov	x21, x0
105112a20: b00d8313    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
105112a24: b00d831c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
105112a28: 34000620    	cbz	w0, 0x105112aec <_Flutter_MMFoundation_BindContext+0x15ee6d0>
105112a2c: b00d8308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105112a30: f9454519    	ldr	x25, [x8, #0xa88] ; class NSString
105112a34: f945ea60    	ldr	x0, [x19, #0xbd0] ; class MMContext
105112a38: d00d7f68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105112a3c: f944e916    	ldr	x22, [x8, #0x9d0] ; selector currentContext
105112a40: aa1603e1    	mov	x1, x22
105112a44: 94ac51be    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112a48: aa1d03fd    	mov	x29, x29
105112a4c: 94ac51bf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112a50: aa0003fa    	mov	x26, x0
105112a54: f9462b80    	ldr	x0, [x28, #0xc50] ; class MMLanguageMgr
105112a58: b00d7f68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105112a5c: f947ad01    	ldr	x1, [x8, #0xf58] ; selector class
105112a60: f90007e1    	str	x1, [sp, #0x8]
105112a64: 94ac51b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112a68: aa0003e2    	mov	x2, x0
105112a6c: f00d6928    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105112a70: f9464117    	ldr	x23, [x8, #0xc80] ; selector getService:
105112a74: aa1a03e0    	mov	x0, x26
105112a78: aa1703e1    	mov	x1, x23
105112a7c: 94ac51b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112a80: aa1d03fd    	mov	x29, x29
105112a84: 94ac51b1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112a88: aa0003fb    	mov	x27, x0
105112a8c: f00d6928    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105112a90: f9464518    	ldr	x24, [x8, #0xc88] ; selector getStringForCurLanguage:
105112a94: d00cb602    	adrp	x2, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
105112a98: 91142042    	add	x2, x2, #0x508 ; CFString 'MainFrame_TitleFormat'
105112a9c: aa1803e1    	mov	x1, x24
105112aa0: 94ac51a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112aa4: aa1d03fd    	mov	x29, x29
105112aa8: 94ac51a8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112aac: aa1c03f3    	mov	x19, x28
105112ab0: aa0003fc    	mov	x28, x0
105112ab4: 900d7fc8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105112ab8: f946a501    	ldr	x1, [x8, #0xd48] ; selector stringWithFormat:
105112abc: f90003f5    	str	x21, [sp]
105112ac0: aa1903e0    	mov	x0, x25
105112ac4: aa1c03e2    	mov	x2, x28
105112ac8: 94ac519d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112acc: aa1d03fd    	mov	x29, x29
105112ad0: 94ac519e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112ad4: aa0003f9    	mov	x25, x0
105112ad8: aa1c03e0    	mov	x0, x28
105112adc: aa1303fc    	mov	x28, x19
105112ae0: b00d8313    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
105112ae4: 94ac519c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105112ae8: 14000020    	b	0x105112b68 <_Flutter_MMFoundation_BindContext+0x15ee74c>
105112aec: f945ea60    	ldr	x0, [x19, #0xbd0] ; class MMContext
105112af0: d00d7f68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105112af4: f944e916    	ldr	x22, [x8, #0x9d0] ; selector currentContext
105112af8: aa1603e1    	mov	x1, x22
105112afc: 94ac5190    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112b00: aa1d03fd    	mov	x29, x29
105112b04: 94ac5191    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112b08: aa0003fa    	mov	x26, x0
105112b0c: f9462b80    	ldr	x0, [x28, #0xc50]
105112b10: b00d7f68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105112b14: f947ad01    	ldr	x1, [x8, #0xf58] ; selector class
105112b18: f90007e1    	str	x1, [sp, #0x8]
105112b1c: 94ac5188    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112b20: aa0003e2    	mov	x2, x0
105112b24: f00d6928    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105112b28: f9464117    	ldr	x23, [x8, #0xc80] ; selector getService:
105112b2c: aa1a03e0    	mov	x0, x26
105112b30: aa1703e1    	mov	x1, x23
105112b34: 94ac5182    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112b38: aa1d03fd    	mov	x29, x29
105112b3c: 94ac5183    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112b40: aa0003fb    	mov	x27, x0
105112b44: f00d6928    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105112b48: f9464518    	ldr	x24, [x8, #0xc88] ; selector getStringForCurLanguage:
105112b4c: b00cb1e2    	adrp	x2, 0x11e74f000 <dyld_stub_binder+0x11e74f000>
105112b50: 910b2042    	add	x2, x2, #0x2c8 ; CFString 'MainFrame_Title'
105112b54: aa1803e1    	mov	x1, x24
105112b58: 94ac5179    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112b5c: aa1d03fd    	mov	x29, x29
105112b60: 94ac517a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112b64: aa0003f9    	mov	x25, x0
105112b68: aa1b03e0    	mov	x0, x27
105112b6c: 94ac517a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105112b70: aa1a03e0    	mov	x0, x26
105112b74: 94ac5178    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105112b78: b00d6968    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
105112b7c: f9463d01    	ldr	x1, [x8, #0xc78] ; selector setM_nsTitle:
105112b80: aa1403e0    	mov	x0, x20
105112b84: aa1903e2    	mov	x2, x25
105112b88: 94ac516d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112b8c: f00d6be8    	adrp	x8, 0x11fe91000 <dyld_stub_binder+0x11fe91000>
105112b90: f9472101    	ldr	x1, [x8, #0xe40] ; selector setTitleOnly:
105112b94: aa1403e0    	mov	x0, x20
105112b98: aa1903e2    	mov	x2, x25
105112b9c: 94ac5168    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112ba0: 900d6a68    	adrp	x8, 0x11fe5e000 <dyld_stub_binder+0x11fe5e000>
105112ba4: f9416d01    	ldr	x1, [x8, #0x2d8] ; selector updateTitleView
105112ba8: aa1403e0    	mov	x0, x20
105112bac: 94ac5164    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112bb0: d00d831b    	adrp	x27, 0x120174000 <dyld_stub_binder+0x120174000>
105112bb4: f9408f60    	ldr	x0, [x27, #0x118] ; class CAppViewControllerManager
105112bb8: 900d6988    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
105112bbc: f942a914    	ldr	x20, [x8, #0x550] ; selector getTabBarController
105112bc0: aa1403e1    	mov	x1, x20
105112bc4: 94ac515e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112bc8: aa1d03fd    	mov	x29, x29
105112bcc: 94ac515f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112bd0: aa0003fa    	mov	x26, x0
105112bd4: 2a1503e2    	mov	w2, w21
105112bd8: b00d6bc8    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
105112bdc: f9451101    	ldr	x1, [x8, #0xa20] ; selector setTabBarBadgeValue:forIndex:
105112be0: d2800003    	mov	x3, #0x0                ; =0
105112be4: 94ac5156    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112be8: aa1a03e0    	mov	x0, x26
105112bec: 94ac515a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105112bf0: f9408f60    	ldr	x0, [x27, #0x118] ; class CAppViewControllerManager
105112bf4: aa1403e1    	mov	x1, x20
105112bf8: 94ac5151    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112bfc: aa1d03fd    	mov	x29, x29
105112c00: 94ac5152    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112c04: aa0003f4    	mov	x20, x0
105112c08: f945ea60    	ldr	x0, [x19, #0xbd0] ; class MMContext
105112c0c: aa1603e1    	mov	x1, x22
105112c10: 94ac514b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112c14: aa1d03fd    	mov	x29, x29
105112c18: 94ac514c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112c1c: aa0003f3    	mov	x19, x0
105112c20: f9462b80    	ldr	x0, [x28, #0xc50]
105112c24: f94007e1    	ldr	x1, [sp, #0x8]
105112c28: 94ac5145    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112c2c: aa0003e2    	mov	x2, x0
105112c30: aa1303e0    	mov	x0, x19
105112c34: aa1703e1    	mov	x1, x23
105112c38: 94ac5141    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112c3c: aa1d03fd    	mov	x29, x29
105112c40: 94ac5142    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112c44: aa0003f5    	mov	x21, x0
105112c48: b00cb462    	adrp	x2, 0x11e79f000 <dyld_stub_binder+0x11e79f000>
105112c4c: 910a2042    	add	x2, x2, #0x288 ; CFString 'TabBar_MainFrameTitle'
105112c50: aa1803e1    	mov	x1, x24
105112c54: 94ac513a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112c58: aa1d03fd    	mov	x29, x29
105112c5c: 94ac513b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112c60: aa0003f6    	mov	x22, x0
105112c64: 900d7448    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
105112c68: f945ed01    	ldr	x1, [x8, #0xbd8] ; selector setTabBarItemTitle:forIndex:
105112c6c: aa1403e0    	mov	x0, x20
105112c70: aa1603e2    	mov	x2, x22
105112c74: d2800003    	mov	x3, #0x0                ; =0
105112c78: 94ac5131    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112c7c: aa1603e0    	mov	x0, x22
105112c80: 94ac5135    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105112c84: aa1503e0    	mov	x0, x21
105112c88: 94ac5133    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105112c8c: aa1303e0    	mov	x0, x19
105112c90: 94ac5131    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105112c94: aa1403e0    	mov	x0, x20
105112c98: 94ac512f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105112c9c: aa1903e0    	mov	x0, x25
105112ca0: a9467bfd    	ldp	x29, x30, [sp, #0x60]
105112ca4: a9454ff4    	ldp	x20, x19, [sp, #0x50]
105112ca8: a94457f6    	ldp	x22, x21, [sp, #0x40]
105112cac: a9435ff8    	ldp	x24, x23, [sp, #0x30]
105112cb0: a94267fa    	ldp	x26, x25, [sp, #0x20]
105112cb4: a9416ffc    	ldp	x28, x27, [sp, #0x10]
105112cb8: 9101c3ff    	add	sp, sp, #0x70
105112cbc: 14ac5126    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
