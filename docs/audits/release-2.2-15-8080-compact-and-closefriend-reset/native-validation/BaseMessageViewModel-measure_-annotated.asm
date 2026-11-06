
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002c0d98: 6dbc23e9    	stp	d9, d8, [sp, #-0x40]!
1002c0d9c: a90157f6    	stp	x22, x21, [sp, #0x10]
1002c0da0: a9024ff4    	stp	x20, x19, [sp, #0x20]
1002c0da4: a9037bfd    	stp	x29, x30, [sp, #0x30]
1002c0da8: 9100c3fd    	add	x29, sp, #0x30
1002c0dac: aa0003f3    	mov	x19, x0
1002c0db0: 900fa408    	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
1002c0db4: 52800029    	mov	w9, #0x1                ; =1
1002c0db8: 39255109    	strb	w9, [x8, #0x954]
1002c0dbc: d00f55e8    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
1002c0dc0: b98ba908    	ldrsw	x8, [x8, #0xba8] ; ivar: BaseMessageViewModel.m_contentViewSize offset=56
1002c0dc4: 8b080014    	add	x20, x0, x8
1002c0dc8: 6d402688    	ldp	d8, d9, [x20]
1002c0dcc: d00ea448    	adrp	x8, 0x11d74a000 <dyld_stub_binder+0x11d74a000>
1002c0dd0: f9466108    	ldr	x8, [x8, #0xcc0]
1002c0dd4: 6d400d02    	ldp	d2, d3, [x8]
1002c0dd8: 1e622100    	fcmp	d8, d2
1002c0ddc: 1e630520    	fccmp	d9, d3, #0x0, eq
1002c0de0: 54000101    	b.ne	0x1002c0e00 <__text+0x2b8e00>
1002c0de4: d00f3868    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1002c0de8: f9422501    	ldr	x1, [x8, #0x448] ; selector: measureContentViewSize:
1002c0dec: aa1303e0    	mov	x0, x19
1002c0df0: 95e59b9d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002c0df4: 4ea01c08    	mov.16b	v8, v0
1002c0df8: 4ea11c29    	mov.16b	v9, v1
1002c0dfc: 6d000680    	stp	d0, d1, [x20]
1002c0e00: f00f3868    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
1002c0e04: f9423d01    	ldr	x1, [x8, #0x478] ; selector: isTailPart
1002c0e08: aa1303e0    	mov	x0, x19
1002c0e0c: 95e59b96    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002c0e10: 340005c0    	cbz	w0, 0x1002c0ec8 <__text+0x2b8ec8>
1002c0e14: d00f5288    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002c0e18: f9461d13    	ldr	x19, [x8, #0xc38]
1002c0e1c: d00f5288    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002c0e20: f943c100    	ldr	x0, [x8, #0x780]
1002c0e24: b00f3848    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002c0e28: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
1002c0e2c: 95e59b8e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002c0e30: aa1d03fd    	mov	x29, x29
1002c0e34: 95e59b93    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002c0e38: aa0003f4    	mov	x20, x0
1002c0e3c: d00f5288    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002c0e40: f9462100    	ldr	x0, [x8, #0xc40]
1002c0e44: d00f4f28    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1002c0e48: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
1002c0e4c: 95e59b86    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002c0e50: aa0003e2    	mov	x2, x0
1002c0e54: b00f3848    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002c0e58: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
1002c0e5c: aa1403e0    	mov	x0, x20
1002c0e60: 95e59b81    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002c0e64: aa1d03fd    	mov	x29, x29
1002c0e68: 95e59b86    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002c0e6c: aa0003f5    	mov	x21, x0
1002c0e70: f00f3848    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1002c0e74: f9477501    	ldr	x1, [x8, #0xee8] ; selector: getValueOfProperty:inRuleSet:
1002c0e78: d00e6742    	adrp	x2, 0x11cfaa000 <dyld_stub_binder+0x11cfaa000>
1002c0e7c: 912e6042    	add	x2, x2, #0xb98 ; CFString: content_sepm_margin
1002c0e80: d00e6743    	adrp	x3, 0x11cfaa000 <dyld_stub_binder+0x11cfaa000>
1002c0e84: 912ee063    	add	x3, x3, #0xbb8 ; CFString: #message_content_viewController
1002c0e88: 95e59b77    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002c0e8c: aa1d03fd    	mov	x29, x29
1002c0e90: 95e59b7c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002c0e94: aa0003f6    	mov	x22, x0
1002c0e98: f00f3848    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1002c0e9c: f9477901    	ldr	x1, [x8, #0xef0] ; selector: parseFloatFromValues:
1002c0ea0: aa1303e0    	mov	x0, x19
1002c0ea4: aa1603e2    	mov	x2, x22
1002c0ea8: 95e59b6f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002c0eac: 1e602929    	fadd	d9, d9, d0
1002c0eb0: aa1603e0    	mov	x0, x22
1002c0eb4: 95e59b6f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002c0eb8: aa1503e0    	mov	x0, x21
1002c0ebc: 95e59b6d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002c0ec0: aa1403e0    	mov	x0, x20
1002c0ec4: 95e59b6b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002c0ec8: 4ea81d00    	mov.16b	v0, v8
1002c0ecc: 4ea91d21    	mov.16b	v1, v9
1002c0ed0: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1002c0ed4: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1002c0ed8: a94157f6    	ldp	x22, x21, [sp, #0x10]
1002c0edc: 6cc423e9    	ldp	d9, d8, [sp], #0x40
1002c0ee0: d65f03c0    	ret
