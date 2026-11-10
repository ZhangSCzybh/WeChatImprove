
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
103dd6a80: d101c3ff    	sub	sp, sp, #0x70
103dd6a84: a9016ffc    	stp	x28, x27, [sp, #0x10]
103dd6a88: a90267fa    	stp	x26, x25, [sp, #0x20]
103dd6a8c: a9035ff8    	stp	x24, x23, [sp, #0x30]
103dd6a90: a90457f6    	stp	x22, x21, [sp, #0x40]
103dd6a94: a9054ff4    	stp	x20, x19, [sp, #0x50]
103dd6a98: a9067bfd    	stp	x29, x30, [sp, #0x60]
103dd6a9c: 910183fd    	add	x29, sp, #0x60
103dd6aa0: aa0403f6    	mov	x22, x4
103dd6aa4: aa0303f4    	mov	x20, x3
103dd6aa8: aa0203f3    	mov	x19, x2
103dd6aac: aa0003f5    	mov	x21, x0
103dd6ab0: 900dcbc8    	adrp	x8, 0x11f74e000 <dyld_stub_binder+0x11f74e000>
103dd6ab4: 5280003a    	mov	w26, #0x1               ; =1
103dd6ab8: 3904b51a    	strb	w26, [x8, #0x12d]
103dd6abc: aa0203e0    	mov	x0, x2
103dd6ac0: 94f9446d    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
103dd6ac4: aa1403e0    	mov	x0, x20
103dd6ac8: 94f9446b    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
103dd6acc: 900d7c68    	adrp	x8, 0x11ed62000 <dyld_stub_binder+0x11ed62000>
103dd6ad0: f943b908    	ldr	x8, [x8, #0x770]
103dd6ad4: a90023f5    	stp	x21, x8, [sp]
103dd6ad8: d00d7688    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
103dd6adc: f9404d01    	ldr	x1, [x8, #0x98] ; selector: init
103dd6ae0: 910003e0    	mov	x0, sp
103dd6ae4: 94f94461    	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
103dd6ae8: aa0003f5    	mov	x21, x0
103dd6aec: b4001160    	cbz	x0, 0x103dd6d18 <_Flutter_MMFoundation_BindContext+0x5d9e4>
103dd6af0: d00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd6af4: b98f7108    	ldrsw	x8, [x8, #0xf70] ; ivar: MMHeadImageView._isHeadImgExistedLocal offset=130
103dd6af8: 38286abf    	strb	wzr, [x21, x8]
103dd6afc: d00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd6b00: b98f7508    	ldrsw	x8, [x8, #0xf74] ; ivar: MMHeadImageView._imageSize offset=160
103dd6b04: 900ccba9    	adrp	x9, 0x11d74a000 <dyld_stub_binder+0x11d74a000>
103dd6b08: f9466129    	ldr	x9, [x9, #0xcc0]
103dd6b0c: 3dc00120    	ldr	q0, [x9]
103dd6b10: 3ca86aa0    	str	q0, [x21, x8]
103dd6b14: d00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd6b18: b98f791b    	ldrsw	x27, [x8, #0xf78] ; ivar: MMHeadImageView._addBorder offset=56
103dd6b1c: 383b6abf    	strb	wzr, [x21, x27]
103dd6b20: d00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd6b24: b98f7d08    	ldrsw	x8, [x8, #0xf7c] ; ivar: MMHeadImageView._headCategory offset=129
103dd6b28: 38286abf    	strb	wzr, [x21, x8]
103dd6b2c: d00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd6b30: b98f8108    	ldrsw	x8, [x8, #0xf80] ; ivar: MMHeadImageView._headUseScene offset=128
103dd6b34: 52800149    	mov	w9, #0xa                ; =10
103dd6b38: 38286aa9    	strb	w9, [x21, x8]
103dd6b3c: d00d7aa8    	adrp	x8, 0x11ed2c000 <dyld_stub_binder+0x11ed2c000>
103dd6b40: f947e500    	ldr	x0, [x8, #0xfc8]
103dd6b44: 94f94432    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
103dd6b48: d00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd6b4c: b98f851c    	ldrsw	x28, [x8, #0xf84] ; ivar: MMHeadImageView._headImageView offset=144
103dd6b50: f87c6aa8    	ldr	x8, [x21, x28]
103dd6b54: f83c6aa0    	str	x0, [x21, x28]
103dd6b58: aa0803e0    	mov	x0, x8
103dd6b5c: 94f94445    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
103dd6b60: f87c6aa0    	ldr	x0, [x21, x28]
103dd6b64: f00d5f88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
103dd6b68: f945b501    	ldr	x1, [x8, #0xb68] ; selector: setM_delegate:
103dd6b6c: aa1503e2    	mov	x2, x21
103dd6b70: 94f9443d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6b74: f87c6aa0    	ldr	x0, [x21, x28]
103dd6b78: f00d6868    	adrp	x8, 0x11eae5000 <dyld_stub_binder+0x11eae5000>
103dd6b7c: f943c501    	ldr	x1, [x8, #0x788] ; selector: setContextString:
103dd6b80: aa1303e2    	mov	x2, x19
103dd6b84: 94f94438    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6b88: 900d79e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
103dd6b8c: f943c100    	ldr	x0, [x8, #0x780]
103dd6b90: f00d5f88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
103dd6b94: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
103dd6b98: 94f94433    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6b9c: aa1d03fd    	mov	x29, x29
103dd6ba0: 94f94438    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
103dd6ba4: aa0003f7    	mov	x23, x0
103dd6ba8: 900d79e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
103dd6bac: f9440100    	ldr	x0, [x8, #0x800]
103dd6bb0: 900d7688    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
103dd6bb4: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
103dd6bb8: 94f9442b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6bbc: aa0003e2    	mov	x2, x0
103dd6bc0: f00d5f88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
103dd6bc4: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
103dd6bc8: aa1703e0    	mov	x0, x23
103dd6bcc: 94f94426    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6bd0: aa1d03fd    	mov	x29, x29
103dd6bd4: 94f9442b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
103dd6bd8: aa0003f8    	mov	x24, x0
103dd6bdc: f00d5f88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
103dd6be0: f9452501    	ldr	x1, [x8, #0xa48] ; selector: getStringForCurLanguage:
103dd6be4: 900c9d02    	adrp	x2, 0x11d176000 <dyld_stub_binder+0x11d176000>
103dd6be8: 911e6042    	add	x2, x2, #0x798 ; CFString: VoiceOver_MoreViewControllerMyProfile_AccessibilityDescrible
103dd6bec: 94f9441e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6bf0: aa1d03fd    	mov	x29, x29
103dd6bf4: 94f94423    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
103dd6bf8: aa0003f9    	mov	x25, x0
103dd6bfc: f87c6aa0    	ldr	x0, [x21, x28]
103dd6c00: 900d76a8    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
103dd6c04: f9467101    	ldr	x1, [x8, #0xce0] ; selector: setAccessibilityLabel:
103dd6c08: aa1903e2    	mov	x2, x25
103dd6c0c: 94f94416    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6c10: aa1903e0    	mov	x0, x25
103dd6c14: 94f94417    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
103dd6c18: aa1803e0    	mov	x0, x24
103dd6c1c: 94f94415    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
103dd6c20: aa1703e0    	mov	x0, x23
103dd6c24: 94f94413    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
103dd6c28: 900d79e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
103dd6c2c: f9462500    	ldr	x0, [x8, #0xc48]
103dd6c30: 94f943f7    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
103dd6c34: d00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd6c38: b98f8918    	ldrsw	x24, [x8, #0xf88] ; ivar: MMHeadImageView._borderImageView offset=8
103dd6c3c: f8786aa8    	ldr	x8, [x21, x24]
103dd6c40: f8386aa0    	str	x0, [x21, x24]
103dd6c44: aa0803e0    	mov	x0, x8
103dd6c48: 94f9440a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
103dd6c4c: 387b6aa8    	ldrb	w8, [x21, x27]
103dd6c50: f8786aa0    	ldr	x0, [x21, x24]
103dd6c54: b00d76a9    	adrp	x9, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
103dd6c58: f9458d21    	ldr	x1, [x9, #0xb18] ; selector: setHidden:
103dd6c5c: 0a280342    	bic	w2, w26, w8
103dd6c60: 94f94401    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6c64: f87c6aa2    	ldr	x2, [x21, x28]
103dd6c68: f00d7668    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
103dd6c6c: f9456517    	ldr	x23, [x8, #0xac8] ; selector: addSubview:
103dd6c70: aa1503e0    	mov	x0, x21
103dd6c74: aa1703e1    	mov	x1, x23
103dd6c78: 94f943fb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6c7c: f8786aa2    	ldr	x2, [x21, x24]
103dd6c80: aa1503e0    	mov	x0, x21
103dd6c84: aa1703e1    	mov	x1, x23
103dd6c88: 94f943f7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6c8c: d00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd6c90: b98f8d08    	ldrsw	x8, [x8, #0xf8c] ; ivar: MMHeadImageView._conerSize offset=136
103dd6c94: b8286abf    	str	wzr, [x21, x8]
103dd6c98: d00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd6c9c: b98f9108    	ldrsw	x8, [x8, #0xf90] ; ivar: MMHeadImageView._bAutoUpdate offset=32
103dd6ca0: 38286ab6    	strb	w22, [x21, x8]
103dd6ca4: d00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd6ca8: b98f9508    	ldrsw	x8, [x8, #0xf94] ; ivar: MMHeadImageView._bRoundedCorner offset=57
103dd6cac: 38286aba    	strb	w26, [x21, x8]
103dd6cb0: f00d6368    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
103dd6cb4: f9406501    	ldr	x1, [x8, #0xc8] ; selector: getRealUserName:
103dd6cb8: aa1503e0    	mov	x0, x21
103dd6cbc: aa1303e2    	mov	x2, x19
103dd6cc0: 94f943e9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6cc4: aa1d03fd    	mov	x29, x29
103dd6cc8: 94f943ee    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
103dd6ccc: aa0003f6    	mov	x22, x0
103dd6cd0: d00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd6cd4: b98f9917    	ldrsw	x23, [x8, #0xf98] ; ivar: MMHeadImageView._nsUsrName offset=24
103dd6cd8: 8b1702a0    	add	x0, x21, x23
103dd6cdc: aa1603e1    	mov	x1, x22
103dd6ce0: 94f943ef    	bl	0x107c27c9c <_Flutter_MMFoundation_BindContext+0x3eae968>
103dd6ce4: d00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd6ce8: b98f9d08    	ldrsw	x8, [x8, #0xf9c] ; ivar: MMHeadImageView._nsHeadImgUrl offset=16
103dd6cec: 8b0802a0    	add	x0, x21, x8
103dd6cf0: aa1403e1    	mov	x1, x20
103dd6cf4: 94f943ea    	bl	0x107c27c9c <_Flutter_MMFoundation_BindContext+0x3eae968>
103dd6cf8: f8776aa8    	ldr	x8, [x21, x23]
103dd6cfc: b40000a8    	cbz	x8, 0x103dd6d10 <_Flutter_MMFoundation_BindContext+0x5d9dc>
103dd6d00: f00d6868    	adrp	x8, 0x11eae5000 <dyld_stub_binder+0x11eae5000>
103dd6d04: f943c901    	ldr	x1, [x8, #0x790] ; selector: updateExtensionRegister
103dd6d08: aa1503e0    	mov	x0, x21
103dd6d0c: 94f943d6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6d10: aa1603e0    	mov	x0, x22
103dd6d14: 94f943d7    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
103dd6d18: aa1403e0    	mov	x0, x20
103dd6d1c: 94f943d5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
103dd6d20: aa1303e0    	mov	x0, x19
103dd6d24: 94f943d3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
103dd6d28: aa1503e0    	mov	x0, x21
103dd6d2c: a9467bfd    	ldp	x29, x30, [sp, #0x60]
103dd6d30: a9454ff4    	ldp	x20, x19, [sp, #0x50]
103dd6d34: a94457f6    	ldp	x22, x21, [sp, #0x40]
103dd6d38: a9435ff8    	ldp	x24, x23, [sp, #0x30]
103dd6d3c: a94267fa    	ldp	x26, x25, [sp, #0x20]
103dd6d40: a9416ffc    	ldp	x28, x27, [sp, #0x10]
103dd6d44: 9101c3ff    	add	sp, sp, #0x70
103dd6d48: d65f03c0    	ret
