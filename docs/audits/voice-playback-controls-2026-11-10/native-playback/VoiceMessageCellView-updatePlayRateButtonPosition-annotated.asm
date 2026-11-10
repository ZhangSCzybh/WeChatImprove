
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
106577924: 6dbb23e9    	stp	d9, d8, [sp, #-0x50]!
106577928: a9015ff8    	stp	x24, x23, [sp, #0x10]
10657792c: a90257f6    	stp	x22, x21, [sp, #0x20]
106577930: a9034ff4    	stp	x20, x19, [sp, #0x30]
106577934: a9047bfd    	stp	x29, x30, [sp, #0x40]
106577938: 910103fd    	add	x29, sp, #0x40
10657793c: aa0003f3    	mov	x19, x0
106577940: 900c8f08    	adrp	x8, 0x11f757000 <dyld_stub_binder+0x11f757000>
106577944: 52800029    	mov	w9, #0x1                ; =1
106577948: 3907b909    	strb	w9, [x8, #0x1ee]
10657794c: f00c22a8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
106577950: f941c101    	ldr	x1, [x8, #0x380] ; selector: viewModel
106577954: 945ac0c4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106577958: aa1d03fd    	mov	x29, x29
10657795c: 945ac0c9    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106577960: aa0003f4    	mov	x20, x0
106577964: 900c22c8    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
106577968: f941b101    	ldr	x1, [x8, #0x360] ; selector: isSender
10657796c: 945ac0be    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106577970: aa0003f5    	mov	x21, x0
106577974: aa1403e0    	mov	x0, x20
106577978: 945ac0be    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10657797c: d00c4088    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
106577980: 9122e108    	add	x8, x8, #0x8b8
106577984: b9800108    	ldrsw	x8, [x8]
106577988: 8b080268    	add	x8, x19, x8
10657798c: fd400100    	ldr	d0, [x8]
106577990: 34000195    	cbz	w21, 0x1065779c0 <_Flutter_MMFoundation_BindContext+0x27fe68c>
106577994: 1e741001    	fmov	d1, #-8.00000000
106577998: 1e612808    	fadd	d8, d0, d1
10657799c: f00c4308    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
1065779a0: b98c8908    	ldrsw	x8, [x8, #0xc88] ; ivar: VoiceMessageCellView.m_playRateButton offset=256
1065779a4: 8b080278    	add	x24, x19, x8
1065779a8: f9400300    	ldr	x0, [x24]
1065779ac: f00c3968    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1065779b0: f9409501    	ldr	x1, [x8, #0x128] ; selector: bounds
1065779b4: 945ac0ac    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065779b8: 1e7c1000    	fmov	d0, #-0.50000000
1065779bc: 1400000d    	b	0x1065779f0 <_Flutter_MMFoundation_BindContext+0x27fe6bc>
1065779c0: fd400901    	ldr	d1, [x8, #0x10] ; selector: becomeFirstResponder
1065779c4: 1e612800    	fadd	d0, d0, d1
1065779c8: 1e641001    	fmov	d1, #8.00000000
1065779cc: 1e612808    	fadd	d8, d0, d1
1065779d0: f00c4308    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
1065779d4: b98c8908    	ldrsw	x8, [x8, #0xc88] ; ivar: VoiceMessageCellView.m_playRateButton offset=256
1065779d8: 8b080278    	add	x24, x19, x8
1065779dc: f9400300    	ldr	x0, [x24]
1065779e0: f00c3968    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1065779e4: f9409501    	ldr	x1, [x8, #0x128] ; selector: bounds
1065779e8: 945ac09f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065779ec: 1e6c1000    	fmov	d0, #0.50000000
1065779f0: 1e600840    	fmul	d0, d2, d0
1065779f4: 1e602908    	fadd	d8, d8, d0
1065779f8: f00c3cc8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1065779fc: f9461d15    	ldr	x21, [x8, #0xc38]
106577a00: f00c3cc8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106577a04: f943c100    	ldr	x0, [x8, #0x780]
106577a08: d00c2288    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106577a0c: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
106577a10: 945ac095    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106577a14: aa1d03fd    	mov	x29, x29
106577a18: 945ac09a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106577a1c: aa0003f4    	mov	x20, x0
106577a20: f00c3cc8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106577a24: f9462100    	ldr	x0, [x8, #0xc40]
106577a28: f00c3968    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
106577a2c: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
106577a30: 945ac08d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106577a34: aa0003e2    	mov	x2, x0
106577a38: d00c2288    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106577a3c: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
106577a40: aa1403e0    	mov	x0, x20
106577a44: 945ac088    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106577a48: aa1d03fd    	mov	x29, x29
106577a4c: 945ac08d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106577a50: aa0003f6    	mov	x22, x0
106577a54: 900c22a8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
106577a58: f9477501    	ldr	x1, [x8, #0xee8] ; selector: getValueOfProperty:inRuleSet:
106577a5c: 900b51a2    	adrp	x2, 0x11cfab000 <dyld_stub_binder+0x11cfab000>
106577a60: 9107e042    	add	x2, x2, #0x1f8 ; CFString: text_message_margin_top
106577a64: 900b5183    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
106577a68: 9130e063    	add	x3, x3, #0xc38 ; CFString: #message_node_view
106577a6c: 945ac07e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106577a70: aa1d03fd    	mov	x29, x29
106577a74: 945ac083    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106577a78: aa0003f7    	mov	x23, x0
106577a7c: 900c22a8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
106577a80: f9477901    	ldr	x1, [x8, #0xef0] ; selector: parseFloatFromValues:
106577a84: aa1503e0    	mov	x0, x21
106577a88: aa1703e2    	mov	x2, x23
106577a8c: 945ac076    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106577a90: 4ea01c09    	mov.16b	v9, v0
106577a94: f00c3cc8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106577a98: f943f100    	ldr	x0, [x8, #0x7e0]
106577a9c: d00c22a8    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
106577aa0: f9478901    	ldr	x1, [x8, #0xf10] ; selector: systemFont
106577aa4: 945ac070    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106577aa8: aa1d03fd    	mov	x29, x29
106577aac: 945ac075    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106577ab0: aa0003f5    	mov	x21, x0
106577ab4: 900c22a8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
106577ab8: f947ed01    	ldr	x1, [x8, #0xfd8] ; selector: lineHeight
106577abc: 945ac06a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106577ac0: 1e64c000    	frintp	d0, d0
106577ac4: 1e601001    	fmov	d1, #2.00000000
106577ac8: 1f410120    	fmadd	d0, d9, d1, d0
106577acc: 1e6c1001    	fmov	d1, #0.50000000
106577ad0: 1e610809    	fmul	d9, d0, d1
106577ad4: aa1503e0    	mov	x0, x21
106577ad8: 945ac066    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106577adc: aa1703e0    	mov	x0, x23
106577ae0: 945ac064    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106577ae4: aa1603e0    	mov	x0, x22
106577ae8: 945ac062    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106577aec: aa1403e0    	mov	x0, x20
106577af0: 945ac060    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106577af4: f00c4028    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
106577af8: 912db108    	add	x8, x8, #0xb6c
106577afc: b9800108    	ldrsw	x8, [x8]
106577b00: f8686a60    	ldr	x0, [x19, x8]
106577b04: b00c22c8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
106577b08: f9406901    	ldr	x1, [x8, #0xd0] ; selector: convertPoint:toView:
106577b0c: 4ea81d00    	mov.16b	v0, v8
106577b10: 4ea91d21    	mov.16b	v1, v9
106577b14: aa1303e2    	mov	x2, x19
106577b18: 945ac053    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106577b1c: f9400300    	ldr	x0, [x24]
106577b20: 900c39a8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
106577b24: f9416d01    	ldr	x1, [x8, #0x2d8] ; selector: setCenter:
106577b28: a9447bfd    	ldp	x29, x30, [sp, #0x40]
106577b2c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
106577b30: a94257f6    	ldp	x22, x21, [sp, #0x20]
106577b34: a9415ff8    	ldp	x24, x23, [sp, #0x10]
106577b38: 6cc523e9    	ldp	d9, d8, [sp], #0x50
106577b3c: 145ac04a    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
