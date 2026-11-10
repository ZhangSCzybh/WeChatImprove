
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105ae2d3c: d100c3ff    	sub	sp, sp, #0x30
105ae2d40: a9014ff4    	stp	x20, x19, [sp, #0x10]
105ae2d44: a9027bfd    	stp	x29, x30, [sp, #0x20]
105ae2d48: 910083fd    	add	x29, sp, #0x20
105ae2d4c: d00ce388    	adrp	x8, 0x11f754000 <dyld_stub_binder+0x11f754000>
105ae2d50: 52800034    	mov	w20, #0x1               ; =1
105ae2d54: 3932d514    	strb	w20, [x8, #0xcb5]
105ae2d58: b00c9428    	adrp	x8, 0x11ed67000 <dyld_stub_binder+0x11ed67000>
105ae2d5c: f940e108    	ldr	x8, [x8, #0x1c0]
105ae2d60: a90023e0    	stp	x0, x8, [sp]
105ae2d64: d00c8e28    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
105ae2d68: f9404d01    	ldr	x1, [x8, #0x98] ; selector: init
105ae2d6c: 910003e0    	mov	x0, sp
105ae2d70: 948513be    	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
105ae2d74: aa0003f3    	mov	x19, x0
105ae2d78: b4000920    	cbz	x0, 0x105ae2e9c <_Flutter_MMFoundation_BindContext+0x1d69b68>
105ae2d7c: f00c9768    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae2d80: b9848508    	ldrsw	x8, [x8, #0x484] ; ivar: SessionSelectController.m_bMultiSelect offset=200
105ae2d84: 38286a7f    	strb	wzr, [x19, x8]
105ae2d88: f00c9768    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae2d8c: b9848908    	ldrsw	x8, [x8, #0x488] ; ivar: SessionSelectController.m_bShowEnterpriseChat offset=320
105ae2d90: 38286a7f    	strb	wzr, [x19, x8]
105ae2d94: f00c9768    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae2d98: b9848d08    	ldrsw	x8, [x8, #0x48c] ; ivar: SessionSelectController.m_bShowNewSession offset=321
105ae2d9c: 38286a74    	strb	w20, [x19, x8]
105ae2da0: d00c7b88    	adrp	x8, 0x11ea54000 <dyld_stub_binder+0x11ea54000>
105ae2da4: f9475101    	ldr	x1, [x8, #0xea0] ; selector: setAllowForwardToEnterpriseChat:
105ae2da8: aa1303e0    	mov	x0, x19
105ae2dac: 52800002    	mov	w2, #0x0                ; =0
105ae2db0: 948513ad    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae2db4: f00c9768    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae2db8: b9849108    	ldrsw	x8, [x8, #0x490] ; ivar: SessionSelectController.m_bFilterMyContact offset=322
105ae2dbc: 38286a7f    	strb	wzr, [x19, x8]
105ae2dc0: f00c9768    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae2dc4: b9849508    	ldrsw	x8, [x8, #0x494] ; ivar: SessionSelectController.m_confirmType offset=144
105ae2dc8: f8286a74    	str	x20, [x19, x8]
105ae2dcc: f00c9768    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae2dd0: b9849908    	ldrsw	x8, [x8, #0x498] ; ivar: SessionSelectController.m_barTitleType offset=152
105ae2dd4: f8286a7f    	str	xzr, [x19, x8]
105ae2dd8: f00c9768    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae2ddc: b9849d08    	ldrsw	x8, [x8, #0x49c] ; ivar: SessionSelectController.m_showsChatroomMembers offset=325
105ae2de0: 38286a7f    	strb	wzr, [x19, x8]
105ae2de4: f00c9768    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae2de8: b984a108    	ldrsw	x8, [x8, #0x4a0] ; ivar: SessionSelectController._maxSelectionCount offset=424
105ae2dec: 52800129    	mov	w9, #0x9                ; =9
105ae2df0: f8286a69    	str	x9, [x19, x8]
105ae2df4: f00c79e8    	adrp	x8, 0x11ea21000 <dyld_stub_binder+0x11ea21000>
105ae2df8: f9421d01    	ldr	x1, [x8, #0x438] ; selector: setM_bKeepCurViewAfterSelect:
105ae2dfc: aa1303e0    	mov	x0, x19
105ae2e00: 52800002    	mov	w2, #0x0                ; =0
105ae2e04: 94851398    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae2e08: d00c7a08    	adrp	x8, 0x11ea24000 <dyld_stub_binder+0x11ea24000>
105ae2e0c: f946b501    	ldr	x1, [x8, #0xd68] ; selector: setM_bShowMultiSelectRightBtn:
105ae2e10: aa1303e0    	mov	x0, x19
105ae2e14: 52800002    	mov	w2, #0x0                ; =0
105ae2e18: 94851393    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae2e1c: d00c7a08    	adrp	x8, 0x11ea24000 <dyld_stub_binder+0x11ea24000>
105ae2e20: f946bd01    	ldr	x1, [x8, #0xd78] ; selector: setShouldSelfClose:
105ae2e24: aa1303e0    	mov	x0, x19
105ae2e28: 52800022    	mov	w2, #0x1                ; =1
105ae2e2c: 9485138e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae2e30: f00c9768    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae2e34: b984a508    	ldrsw	x8, [x8, #0x4a4] ; ivar: SessionSelectController.m_UIEdgeInsets offset=208
105ae2e38: 8b080268    	add	x8, x19, x8
105ae2e3c: f00be329    	adrp	x9, 0x11d749000 <dyld_stub_binder+0x11d749000>
105ae2e40: f945dd29    	ldr	x9, [x9, #0xbb8]
105ae2e44: ad400121    	ldp	q1, q0, [x9]
105ae2e48: ad000101    	stp	q1, q0, [x8]
105ae2e4c: 900c9188    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105ae2e50: f9440500    	ldr	x0, [x8, #0x808]
105ae2e54: d00c7768    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
105ae2e58: f9405501    	ldr	x1, [x8, #0xa8] ; selector: Brand
105ae2e5c: 94851382    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae2e60: aa1d03fd    	mov	x29, x29
105ae2e64: 94851387    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae2e68: aa0003f4    	mov	x20, x0
105ae2e6c: f00c7d88    	adrp	x8, 0x11ea95000 <dyld_stub_binder+0x11ea95000>
105ae2e70: f9474101    	ldr	x1, [x8, #0xe80] ; selector: setBrandColor:
105ae2e74: aa1303e0    	mov	x0, x19
105ae2e78: aa1403e2    	mov	x2, x20
105ae2e7c: 9485137a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae2e80: aa1403e0    	mov	x0, x20
105ae2e84: 9485137b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae2e88: d00c8368    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae2e8c: f9442d01    	ldr	x1, [x8, #0x858] ; selector: setForwardState:
105ae2e90: aa1303e0    	mov	x0, x19
105ae2e94: 52800062    	mov	w2, #0x3                ; =3
105ae2e98: 94851373    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae2e9c: aa1303e0    	mov	x0, x19
105ae2ea0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105ae2ea4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105ae2ea8: 9100c3ff    	add	sp, sp, #0x30
105ae2eac: d65f03c0    	ret
