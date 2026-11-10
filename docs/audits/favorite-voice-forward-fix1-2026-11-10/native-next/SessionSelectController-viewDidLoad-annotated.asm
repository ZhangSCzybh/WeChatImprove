
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105ae5d98: d10183ff    	sub	sp, sp, #0x60
105ae5d9c: 6d0123e9    	stp	d9, d8, [sp, #0x10]
105ae5da0: a9025ff8    	stp	x24, x23, [sp, #0x20]
105ae5da4: a90357f6    	stp	x22, x21, [sp, #0x30]
105ae5da8: a9044ff4    	stp	x20, x19, [sp, #0x40]
105ae5dac: a9057bfd    	stp	x29, x30, [sp, #0x50]
105ae5db0: 910143fd    	add	x29, sp, #0x50
105ae5db4: aa0003f3    	mov	x19, x0
105ae5db8: f00ce368    	adrp	x8, 0x11f754000 <dyld_stub_binder+0x11f754000>
105ae5dbc: 52800029    	mov	w9, #0x1                ; =1
105ae5dc0: 39330109    	strb	w9, [x8, #0xcc0]
105ae5dc4: d00c9408    	adrp	x8, 0x11ed67000 <dyld_stub_binder+0x11ed67000>
105ae5dc8: f940e108    	ldr	x8, [x8, #0x1c0]
105ae5dcc: a90023e0    	stp	x0, x8, [sp]
105ae5dd0: f00c7728    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
105ae5dd4: f941a101    	ldr	x1, [x8, #0x340] ; selector: viewDidLoad
105ae5dd8: 910003e0    	mov	x0, sp
105ae5ddc: 948507a3    	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
105ae5de0: f00c7728    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
105ae5de4: f941a901    	ldr	x1, [x8, #0x350] ; selector: initData
105ae5de8: aa1303e0    	mov	x0, x19
105ae5dec: 9485079e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5df0: b00c77a8    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
105ae5df4: f945d501    	ldr	x1, [x8, #0xba8] ; selector: isInPageSheetMode
105ae5df8: aa1303e0    	mov	x0, x19
105ae5dfc: 9485079a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5e00: 900c8e57    	adrp	x23, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
105ae5e04: 34000600    	cbz	w0, 0x105ae5ec4 <_Flutter_MMFoundation_BindContext+0x1d6cb90>
105ae5e08: b00c77a8    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
105ae5e0c: f945d914    	ldr	x20, [x8, #0xbb0] ; selector: pageSheetAdapter
105ae5e10: aa1303e0    	mov	x0, x19
105ae5e14: aa1403e1    	mov	x1, x20
105ae5e18: 94850793    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5e1c: aa1d03fd    	mov	x29, x29
105ae5e20: 94850798    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae5e24: aa0003f5    	mov	x21, x0
105ae5e28: 94850792    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae5e2c: b40004d5    	cbz	x21, 0x105ae5ec4 <_Flutter_MMFoundation_BindContext+0x1d6cb90>
105ae5e30: aa1303e0    	mov	x0, x19
105ae5e34: aa1403e1    	mov	x1, x20
105ae5e38: 9485078b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5e3c: aa1d03fd    	mov	x29, x29
105ae5e40: 94850790    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae5e44: aa0003f5    	mov	x21, x0
105ae5e48: b00c77a8    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
105ae5e4c: f945dd01    	ldr	x1, [x8, #0xbb8] ; selector: pageSheetContentWidth
105ae5e50: 94850785    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5e54: 4ea01c08    	mov.16b	v8, v0
105ae5e58: aa1303e0    	mov	x0, x19
105ae5e5c: aa1403e1    	mov	x1, x20
105ae5e60: 94850781    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5e64: aa1d03fd    	mov	x29, x29
105ae5e68: 94850786    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae5e6c: aa0003f4    	mov	x20, x0
105ae5e70: b00c77a8    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
105ae5e74: f945f101    	ldr	x1, [x8, #0xbe0] ; selector: pageSheetContentHeight
105ae5e78: 9485077b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5e7c: 4ea01c09    	mov.16b	v9, v0
105ae5e80: f9472ae1    	ldr	x1, [x23, #0xe50] ; selector: view
105ae5e84: aa1303e0    	mov	x0, x19
105ae5e88: 94850777    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5e8c: aa1d03fd    	mov	x29, x29
105ae5e90: 9485077c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae5e94: aa0003f6    	mov	x22, x0
105ae5e98: d00c7728    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
105ae5e9c: f947f901    	ldr	x1, [x8, #0xff0] ; selector: setSize:
105ae5ea0: 4ea81d00    	mov.16b	v0, v8
105ae5ea4: 4ea91d21    	mov.16b	v1, v9
105ae5ea8: 9485076f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5eac: aa1603e0    	mov	x0, x22
105ae5eb0: 94850770    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae5eb4: aa1403e0    	mov	x0, x20
105ae5eb8: 9485076e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae5ebc: aa1503e0    	mov	x0, x21
105ae5ec0: 9485076c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae5ec4: 900c9768    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae5ec8: b9848516    	ldrsw	x22, [x8, #0x484] ; ivar: SessionSelectController.m_bMultiSelect offset=200
105ae5ecc: 38766a68    	ldrb	w8, [x19, x22]
105ae5ed0: 7100051f    	cmp	w8, #0x1
105ae5ed4: 54000101    	b.ne	0x105ae5ef4 <_Flutter_MMFoundation_BindContext+0x1d6cbc0>
105ae5ed8: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5edc: f9447d01    	ldr	x1, [x8, #0x8f8] ; selector: updateMultiSelectLeftBtn
105ae5ee0: aa1303e0    	mov	x0, x19
105ae5ee4: 94850760    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5ee8: f00c8354    	adrp	x20, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5eec: 91240294    	add	x20, x20, #0x900
105ae5ef0: 14000003    	b	0x105ae5efc <_Flutter_MMFoundation_BindContext+0x1d6cbc8>
105ae5ef4: f00c79d4    	adrp	x20, 0x11ea20000 <dyld_stub_binder+0x11ea20000>
105ae5ef8: 913f0294    	add	x20, x20, #0xfc0
105ae5efc: f00c7728    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
105ae5f00: f9443d01    	ldr	x1, [x8, #0x878] ; selector: initTitle
105ae5f04: aa1303e0    	mov	x0, x19
105ae5f08: 94850757    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5f0c: f9400281    	ldr	x1, [x20] ; selector: initBarItem
105ae5f10: aa1303e0    	mov	x0, x19
105ae5f14: 94850754    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5f18: b00c9168    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105ae5f1c: f9440500    	ldr	x0, [x8, #0x808]
105ae5f20: f00c7728    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
105ae5f24: f943e101    	ldr	x1, [x8, #0x7c0] ; selector: BG_2
105ae5f28: 9485074f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5f2c: aa1d03fd    	mov	x29, x29
105ae5f30: 94850754    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae5f34: aa0003f4    	mov	x20, x0
105ae5f38: f9472ae1    	ldr	x1, [x23, #0xe50] ; selector: view
105ae5f3c: aa1303e0    	mov	x0, x19
105ae5f40: 94850749    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5f44: aa1d03fd    	mov	x29, x29
105ae5f48: 9485074e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae5f4c: aa0003f5    	mov	x21, x0
105ae5f50: d00c8e28    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
105ae5f54: f9401d01    	ldr	x1, [x8, #0x38] ; selector: setBackgroundColor:
105ae5f58: aa1403e2    	mov	x2, x20
105ae5f5c: 94850742    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5f60: aa1503e0    	mov	x0, x21
105ae5f64: 94850743    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae5f68: aa1403e0    	mov	x0, x20
105ae5f6c: 94850741    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae5f70: f00c7728    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
105ae5f74: f941ad01    	ldr	x1, [x8, #0x358] ; selector: initView
105ae5f78: aa1303e0    	mov	x0, x19
105ae5f7c: 9485073a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5f80: 38766a68    	ldrb	w8, [x19, x22]
105ae5f84: 7100051f    	cmp	w8, #0x1
105ae5f88: 540001c1    	b.ne	0x105ae5fc0 <_Flutter_MMFoundation_BindContext+0x1d6cc8c>
105ae5f8c: 900c9768    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae5f90: b984a914    	ldrsw	x20, [x8, #0x4a8] ; ivar: SessionSelectController.m_selectedContacts offset=128
105ae5f94: f8746a60    	ldr	x0, [x19, x20]
105ae5f98: b00c8e08    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105ae5f9c: f9442901    	ldr	x1, [x8, #0x850] ; selector: count
105ae5fa0: 94850731    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5fa4: b40000e0    	cbz	x0, 0x105ae5fc0 <_Flutter_MMFoundation_BindContext+0x1d6cc8c>
105ae5fa8: f8746a62    	ldr	x2, [x19, x20]
105ae5fac: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5fb0: f944c901    	ldr	x1, [x8, #0x990] ; selector: addMultiSelectContacts:source:
105ae5fb4: aa1303e0    	mov	x0, x19
105ae5fb8: d2800003    	mov	x3, #0x0                ; =0
105ae5fbc: 9485072a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5fc0: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5fc4: f944cd01    	ldr	x1, [x8, #0x998] ; selector: m_bShowMultiSelectRightBtn
105ae5fc8: aa1303e0    	mov	x0, x19
105ae5fcc: 94850726    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5fd0: 7100001f    	cmp	w0, #0x0
105ae5fd4: 52800408    	mov	w8, #0x20               ; =32
105ae5fd8: 52800369    	mov	w9, #0x1b               ; =27
105ae5fdc: 1a881121    	csel	w1, w9, w8, ne
105ae5fe0: 52801920    	mov	w0, #0xc9               ; =201
105ae5fe4: 52800022    	mov	w2, #0x1                ; =1
105ae5fe8: 52800003    	mov	w3, #0x0                ; =0
105ae5fec: 52800004    	mov	w4, #0x0                ; =0
105ae5ff0: 97181087    	bl	0x1020ea20c <_Flutter_Image_provideRelativePathByUrl+0x372698>
105ae5ff4: a9457bfd    	ldp	x29, x30, [sp, #0x50]
105ae5ff8: a9444ff4    	ldp	x20, x19, [sp, #0x40]
105ae5ffc: a94357f6    	ldp	x22, x21, [sp, #0x30]
105ae6000: a9425ff8    	ldp	x24, x23, [sp, #0x20]
105ae6004: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
105ae6008: 910183ff    	add	sp, sp, #0x60
105ae600c: d65f03c0    	ret
