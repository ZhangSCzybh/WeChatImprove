
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105ae5974: 6dbb23e9    	stp	d9, d8, [sp, #-0x50]!
105ae5978: a9015ff8    	stp	x24, x23, [sp, #0x10]
105ae597c: a90257f6    	stp	x22, x21, [sp, #0x20]
105ae5980: a9034ff4    	stp	x20, x19, [sp, #0x30]
105ae5984: a9047bfd    	stp	x29, x30, [sp, #0x40]
105ae5988: 910103fd    	add	x29, sp, #0x40
105ae598c: aa0003f3    	mov	x19, x0
105ae5990: f00ce368    	adrp	x8, 0x11f754000 <dyld_stub_binder+0x11f754000>
105ae5994: 52800029    	mov	w9, #0x1                ; =1
105ae5998: 3932fd09    	strb	w9, [x8, #0xcbf]
105ae599c: b00c9288    	adrp	x8, 0x11ed36000 <dyld_stub_binder+0x11ed36000>
105ae59a0: f941e500    	ldr	x0, [x8, #0x3c8]
105ae59a4: 94850899    	bl	0x107c27c08 <_Flutter_MMFoundation_BindContext+0x3eae8d4>
105ae59a8: aa0003f5    	mov	x21, x0
105ae59ac: 900c8e48    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
105ae59b0: f9472914    	ldr	x20, [x8, #0xe50] ; selector: view
105ae59b4: aa1303e0    	mov	x0, x19
105ae59b8: aa1403e1    	mov	x1, x20
105ae59bc: 948508aa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae59c0: aa1d03fd    	mov	x29, x29
105ae59c4: 948508af    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae59c8: aa0003f6    	mov	x22, x0
105ae59cc: 900c8e48    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
105ae59d0: f947d501    	ldr	x1, [x8, #0xfa8] ; selector: width
105ae59d4: 948508a4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae59d8: 4ea01c08    	mov.16b	v8, v0
105ae59dc: f00c7728    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
105ae59e0: f9418501    	ldr	x1, [x8, #0x308] ; selector: getVisibleHeight
105ae59e4: aa1303e0    	mov	x0, x19
105ae59e8: 9485089f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae59ec: 4ea01c03    	mov.16b	v3, v0
105ae59f0: d00c78e8    	adrp	x8, 0x11ea03000 <dyld_stub_binder+0x11ea03000>
105ae59f4: f9435901    	ldr	x1, [x8, #0x6b0] ; selector: initWithFrame:delegate:
105ae59f8: 9e6703e0    	fmov	d0, xzr
105ae59fc: 9e6703e1    	fmov	d1, xzr
105ae5a00: aa1503e0    	mov	x0, x21
105ae5a04: 4ea81d02    	mov.16b	v2, v8
105ae5a08: aa1303e2    	mov	x2, x19
105ae5a0c: 94850896    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5a10: 900c9768    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae5a14: b984b517    	ldrsw	x23, [x8, #0x4b4] ; ivar: SessionSelectController.m_selectView offset=304
105ae5a18: f8776a68    	ldr	x8, [x19, x23]
105ae5a1c: f8376a60    	str	x0, [x19, x23]
105ae5a20: aa0803e0    	mov	x0, x8
105ae5a24: 94850893    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae5a28: aa1603e0    	mov	x0, x22
105ae5a2c: 94850891    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae5a30: 900c9768    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae5a34: b984d108    	ldrsw	x8, [x8, #0x4d0] ; ivar: SessionSelectController.m_commonSearchScene offset=184
105ae5a38: f8686a62    	ldr	x2, [x19, x8]
105ae5a3c: f8776a60    	ldr	x0, [x19, x23]
105ae5a40: d00c7728    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
105ae5a44: f946bd01    	ldr	x1, [x8, #0xd78] ; selector: setM_commonSearchScene:
105ae5a48: 94850887    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5a4c: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5a50: f9448501    	ldr	x1, [x8, #0x908] ; selector: m_alignsFilterRulesInSearchResult
105ae5a54: aa1303e0    	mov	x0, x19
105ae5a58: 94850883    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5a5c: aa0003e2    	mov	x2, x0
105ae5a60: f8776a60    	ldr	x0, [x19, x23]
105ae5a64: f00c7b68    	adrp	x8, 0x11ea54000 <dyld_stub_binder+0x11ea54000>
105ae5a68: f9474901    	ldr	x1, [x8, #0xe90] ; selector: setM_alignsFilterRulesInSearchResult:
105ae5a6c: 9485087e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5a70: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5a74: f9448901    	ldr	x1, [x8, #0x910] ; selector: m_bContainOpenIM
105ae5a78: aa1303e0    	mov	x0, x19
105ae5a7c: 9485087a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5a80: f8776a68    	ldr	x8, [x19, x23]
105ae5a84: f00c8349    	adrp	x9, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5a88: f9448d21    	ldr	x1, [x9, #0x918] ; selector: setM_bIgnoreOpenIM:
105ae5a8c: 52000002    	eor	w2, w0, #0x1
105ae5a90: aa0803e0    	mov	x0, x8
105ae5a94: 94850874    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5a98: f00c7b68    	adrp	x8, 0x11ea54000 <dyld_stub_binder+0x11ea54000>
105ae5a9c: f9474101    	ldr	x1, [x8, #0xe80] ; selector: m_bIgnoreChatRoom
105ae5aa0: aa1303e0    	mov	x0, x19
105ae5aa4: 94850870    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5aa8: aa0003e2    	mov	x2, x0
105ae5aac: f8776a60    	ldr	x0, [x19, x23]
105ae5ab0: f00c79e8    	adrp	x8, 0x11ea24000 <dyld_stub_binder+0x11ea24000>
105ae5ab4: f946ad01    	ldr	x1, [x8, #0xd58] ; selector: setM_bIgnoreChatRoom:
105ae5ab8: 9485086b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5abc: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5ac0: f9449101    	ldr	x1, [x8, #0x920] ; selector: m_onlySelectSingleWeixChat
105ae5ac4: aa1303e0    	mov	x0, x19
105ae5ac8: 94850867    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5acc: aa0003e2    	mov	x2, x0
105ae5ad0: f8776a60    	ldr	x0, [x19, x23]
105ae5ad4: f00c79e8    	adrp	x8, 0x11ea24000 <dyld_stub_binder+0x11ea24000>
105ae5ad8: f946b901    	ldr	x1, [x8, #0xd70] ; selector: setM_onlySelectSingleWeixChat:
105ae5adc: 94850862    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5ae0: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5ae4: f9449501    	ldr	x1, [x8, #0x928] ; selector: m_ignoresChatBox
105ae5ae8: aa1303e0    	mov	x0, x19
105ae5aec: 9485085e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5af0: aa0003e2    	mov	x2, x0
105ae5af4: f8776a60    	ldr	x0, [x19, x23]
105ae5af8: f00c79e8    	adrp	x8, 0x11ea24000 <dyld_stub_binder+0x11ea24000>
105ae5afc: f946c501    	ldr	x1, [x8, #0xd88] ; selector: setM_ignoresChatBox:
105ae5b00: 94850859    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5b04: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5b08: f9449901    	ldr	x1, [x8, #0x930] ; selector: m_ignoresFileTransfer
105ae5b0c: aa1303e0    	mov	x0, x19
105ae5b10: 94850855    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5b14: aa0003e2    	mov	x2, x0
105ae5b18: f8776a60    	ldr	x0, [x19, x23]
105ae5b1c: f00c79e8    	adrp	x8, 0x11ea24000 <dyld_stub_binder+0x11ea24000>
105ae5b20: f946c101    	ldr	x1, [x8, #0xd80] ; selector: setM_ignoresFileTransfer:
105ae5b24: 94850850    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5b28: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5b2c: f9449d01    	ldr	x1, [x8, #0x938] ; selector: m_ignoresChatBot
105ae5b30: aa1303e0    	mov	x0, x19
105ae5b34: 9485084c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5b38: aa0003e2    	mov	x2, x0
105ae5b3c: f8776a60    	ldr	x0, [x19, x23]
105ae5b40: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5b44: f944a101    	ldr	x1, [x8, #0x940] ; selector: setM_ignoresChatBotTransfer:
105ae5b48: 94850847    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5b4c: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5b50: f944a501    	ldr	x1, [x8, #0x948] ; selector: m_showsChatroomMembers
105ae5b54: aa1303e0    	mov	x0, x19
105ae5b58: 94850843    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5b5c: aa0003e2    	mov	x2, x0
105ae5b60: f8776a60    	ldr	x0, [x19, x23]
105ae5b64: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5b68: f944a901    	ldr	x1, [x8, #0x950] ; selector: setM_showsChatroomMembers:
105ae5b6c: 9485083e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5b70: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5b74: f944ad01    	ldr	x1, [x8, #0x958] ; selector: m_recentForwardHidden
105ae5b78: aa1303e0    	mov	x0, x19
105ae5b7c: 9485083a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5b80: aa0003e2    	mov	x2, x0
105ae5b84: f8776a60    	ldr	x0, [x19, x23]
105ae5b88: d00c7f88    	adrp	x8, 0x11ead7000 <dyld_stub_binder+0x11ead7000>
105ae5b8c: f9473101    	ldr	x1, [x8, #0xe60] ; selector: setM_recentForwardHidden:
105ae5b90: 94850835    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5b94: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5b98: f944b101    	ldr	x1, [x8, #0x960] ; selector: m_ignoredContacts
105ae5b9c: aa1303e0    	mov	x0, x19
105ae5ba0: 94850831    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5ba4: aa1d03fd    	mov	x29, x29
105ae5ba8: 94850836    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae5bac: aa0003f5    	mov	x21, x0
105ae5bb0: f8776a60    	ldr	x0, [x19, x23]
105ae5bb4: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5bb8: f944b501    	ldr	x1, [x8, #0x968] ; selector: setM_ignoredContacts:
105ae5bbc: aa1503e2    	mov	x2, x21
105ae5bc0: 94850829    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5bc4: aa1503e0    	mov	x0, x21
105ae5bc8: 9485082a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae5bcc: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5bd0: f944b901    	ldr	x1, [x8, #0x970] ; selector: m_disabledContacts
105ae5bd4: aa1303e0    	mov	x0, x19
105ae5bd8: 94850823    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5bdc: aa1d03fd    	mov	x29, x29
105ae5be0: 94850828    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae5be4: aa0003f5    	mov	x21, x0
105ae5be8: f8776a60    	ldr	x0, [x19, x23]
105ae5bec: f00c7f48    	adrp	x8, 0x11ead0000 <dyld_stub_binder+0x11ead0000>
105ae5bf0: f941d501    	ldr	x1, [x8, #0x3a8] ; selector: setM_disabledContacts:
105ae5bf4: aa1503e2    	mov	x2, x21
105ae5bf8: 9485081b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5bfc: aa1503e0    	mov	x0, x21
105ae5c00: 9485081c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae5c04: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5c08: f9445901    	ldr	x1, [x8, #0x8b0] ; selector: m_disableSearchBar
105ae5c0c: aa1303e0    	mov	x0, x19
105ae5c10: 94850815    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5c14: aa0003e2    	mov	x2, x0
105ae5c18: f8776a60    	ldr	x0, [x19, x23]
105ae5c1c: d00c7f88    	adrp	x8, 0x11ead7000 <dyld_stub_binder+0x11ead7000>
105ae5c20: f9472d01    	ldr	x1, [x8, #0xe58] ; selector: setM_disableSearchBar:
105ae5c24: 94850810    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5c28: 900c79c8    	adrp	x8, 0x11ea1d000 <dyld_stub_binder+0x11ea1d000>
105ae5c2c: f9453101    	ldr	x1, [x8, #0xa60] ; selector: brandColor
105ae5c30: aa1303e0    	mov	x0, x19
105ae5c34: 9485080c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5c38: aa1d03fd    	mov	x29, x29
105ae5c3c: 94850811    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae5c40: aa0003f5    	mov	x21, x0
105ae5c44: f8776a60    	ldr	x0, [x19, x23]
105ae5c48: 900c7d88    	adrp	x8, 0x11ea95000 <dyld_stub_binder+0x11ea95000>
105ae5c4c: f9474101    	ldr	x1, [x8, #0xe80] ; selector: setBrandColor:
105ae5c50: aa1503e2    	mov	x2, x21
105ae5c54: 94850804    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5c58: aa1503e0    	mov	x0, x21
105ae5c5c: 94850805    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae5c60: b00c7988    	adrp	x8, 0x11ea16000 <dyld_stub_binder+0x11ea16000>
105ae5c64: f9454501    	ldr	x1, [x8, #0xa88] ; selector: checkUseNewSearchBar
105ae5c68: aa1303e0    	mov	x0, x19
105ae5c6c: 948507fe    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5c70: aa0003e2    	mov	x2, x0
105ae5c74: f8776a60    	ldr	x0, [x19, x23]
105ae5c78: f00c7b68    	adrp	x8, 0x11ea54000 <dyld_stub_binder+0x11ea54000>
105ae5c7c: f9472501    	ldr	x1, [x8, #0xe48] ; selector: setUseNewSearchBar:
105ae5c80: 948507f9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5c84: f8776a60    	ldr	x0, [x19, x23]
105ae5c88: b00c8e28    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
105ae5c8c: f947a501    	ldr	x1, [x8, #0xf48] ; selector: setAutoresizingMask:
105ae5c90: 52800042    	mov	w2, #0x2                ; =2
105ae5c94: 948507f4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5c98: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5c9c: f944bd01    	ldr	x1, [x8, #0x978] ; selector: m_specificLogicScene
105ae5ca0: aa1303e0    	mov	x0, x19
105ae5ca4: 948507f0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5ca8: aa0003e2    	mov	x2, x0
105ae5cac: f8776a60    	ldr	x0, [x19, x23]
105ae5cb0: f00c79e8    	adrp	x8, 0x11ea24000 <dyld_stub_binder+0x11ea24000>
105ae5cb4: f946c901    	ldr	x1, [x8, #0xd90] ; selector: setM_specificLogicScene:
105ae5cb8: 948507eb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5cbc: 900c9768    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae5cc0: b984ad08    	ldrsw	x8, [x8, #0x4ac] ; ivar: SessionSelectController.m_dicRequiredContact offset=136
105ae5cc4: f8686a62    	ldr	x2, [x19, x8]
105ae5cc8: f8776a60    	ldr	x0, [x19, x23]
105ae5ccc: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5cd0: f944c101    	ldr	x1, [x8, #0x980] ; selector: setM_dicRequiredContact:
105ae5cd4: 948507e4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5cd8: 900c9768    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae5cdc: b984d508    	ldrsw	x8, [x8, #0x4d4] ; ivar: SessionSelectController.m_isSupportMultipleWordsSearchCreateGroup offset=326
105ae5ce0: 38686a62    	ldrb	w2, [x19, x8]
105ae5ce4: f8776a60    	ldr	x0, [x19, x23]
105ae5ce8: f00c7b68    	adrp	x8, 0x11ea54000 <dyld_stub_binder+0x11ea54000>
105ae5cec: f9472901    	ldr	x1, [x8, #0xe50] ; selector: setM_isSupportMultipleWordsSearchCreateGroup:
105ae5cf0: 948507dd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5cf4: f8776a60    	ldr	x0, [x19, x23]
105ae5cf8: f00c7728    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
105ae5cfc: f941a901    	ldr	x1, [x8, #0x350] ; selector: initData
105ae5d00: 948507d9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5d04: aa1303e0    	mov	x0, x19
105ae5d08: aa1403e1    	mov	x1, x20
105ae5d0c: 948507d6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5d10: aa1d03fd    	mov	x29, x29
105ae5d14: 948507db    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae5d18: aa0003f4    	mov	x20, x0
105ae5d1c: f8776a62    	ldr	x2, [x19, x23]
105ae5d20: 900c8e08    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
105ae5d24: f9456501    	ldr	x1, [x8, #0xac8] ; selector: addSubview:
105ae5d28: 948507cf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5d2c: aa1403e0    	mov	x0, x20
105ae5d30: 948507d0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae5d34: b00c7988    	adrp	x8, 0x11ea16000 <dyld_stub_binder+0x11ea16000>
105ae5d38: f9458101    	ldr	x1, [x8, #0xb00] ; selector: initPanelView
105ae5d3c: aa1303e0    	mov	x0, x19
105ae5d40: 948507c9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5d44: 900c77e8    	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
105ae5d48: f9446101    	ldr	x1, [x8, #0x8c0] ; selector: updateView
105ae5d4c: aa1303e0    	mov	x0, x19
105ae5d50: 948507c5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5d54: b00c7988    	adrp	x8, 0x11ea16000 <dyld_stub_binder+0x11ea16000>
105ae5d58: f9458d01    	ldr	x1, [x8, #0xb18] ; selector: finishHeadPanelViewAnimation
105ae5d5c: aa1303e0    	mov	x0, x19
105ae5d60: 948507c1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5d64: f00c8248    	adrp	x8, 0x11eb30000 <dyld_stub_binder+0x11eb30000>
105ae5d68: f940ad01    	ldr	x1, [x8, #0x158] ; selector: initContactSelectDropDownView
105ae5d6c: aa1303e0    	mov	x0, x19
105ae5d70: 948507bd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae5d74: f00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae5d78: f944c501    	ldr	x1, [x8, #0x988] ; selector: resetSelectViewContentInsetInNewSearchBar
105ae5d7c: aa1303e0    	mov	x0, x19
105ae5d80: a9447bfd    	ldp	x29, x30, [sp, #0x40]
105ae5d84: a9434ff4    	ldp	x20, x19, [sp, #0x30]
105ae5d88: a94257f6    	ldp	x22, x21, [sp, #0x20]
105ae5d8c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
105ae5d90: 6cc523e9    	ldp	d9, d8, [sp], #0x50
105ae5d94: 148507b4    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
