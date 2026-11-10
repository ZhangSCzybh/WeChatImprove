
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
106588abc: d10143ff    	sub	sp, sp, #0x50
106588ac0: a9015ff8    	stp	x24, x23, [sp, #0x10]
106588ac4: a90257f6    	stp	x22, x21, [sp, #0x20]
106588ac8: a9034ff4    	stp	x20, x19, [sp, #0x30]
106588acc: a9047bfd    	stp	x29, x30, [sp, #0x40]
106588ad0: 910103fd    	add	x29, sp, #0x40
106588ad4: f00c8e68    	adrp	x8, 0x11f757000 <dyld_stub_binder+0x11f757000>
106588ad8: 52800029    	mov	w9, #0x1                ; =1
106588adc: 3908b509    	strb	w9, [x8, #0x22d]
106588ae0: 900c3f08    	adrp	x8, 0x11ed68000 <dyld_stub_binder+0x11ed68000>
106588ae4: f9470508    	ldr	x8, [x8, #0xe08]
106588ae8: a90023e0    	stp	x0, x8, [sp]
106588aec: f00c2228    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
106588af0: f9420901    	ldr	x1, [x8, #0x410] ; selector: initWithMessageWrap:contact:chatContact:
106588af4: 910003e0    	mov	x0, sp
106588af8: 945a7c5c    	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
106588afc: aa0003f3    	mov	x19, x0
106588b00: b4000b40    	cbz	x0, 0x106588c68 <_Flutter_MMFoundation_BindContext+0x280f934>
106588b04: d00c2228    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
106588b08: f941bd15    	ldr	x21, [x8, #0x378] ; selector: messageWrap
106588b0c: aa1303e0    	mov	x0, x19
106588b10: aa1503e1    	mov	x1, x21
106588b14: 945a7c54    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588b18: aa1d03fd    	mov	x29, x29
106588b1c: 945a7c59    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106588b20: aa0003f6    	mov	x22, x0
106588b24: d00c2228    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
106588b28: f9403901    	ldr	x1, [x8, #0x70] ; selector: GetChatName
106588b2c: 945a7c4e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588b30: aa1d03fd    	mov	x29, x29
106588b34: 945a7c53    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106588b38: aa0003f4    	mov	x20, x0
106588b3c: aa1603e0    	mov	x0, x22
106588b40: 945a7c4c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106588b44: 900c3908    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
106588b48: f9467501    	ldr	x1, [x8, #0xce8] ; selector: length
106588b4c: aa1403e0    	mov	x0, x20
106588b50: 945a7c45    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588b54: b00c2208    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106588b58: f9440116    	ldr	x22, [x8, #0x800] ; selector: currentContext
106588b5c: d00c3c58    	adrp	x24, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106588b60: b4000200    	cbz	x0, 0x106588ba0 <_Flutter_MMFoundation_BindContext+0x280f86c>
106588b64: f943c300    	ldr	x0, [x24, #0x780]
106588b68: aa1603e1    	mov	x1, x22
106588b6c: 945a7c3e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588b70: aa1d03fd    	mov	x29, x29
106588b74: 945a7c43    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106588b78: aa0003f7    	mov	x23, x0
106588b7c: f00c3c28    	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
106588b80: f9435102    	ldr	x2, [x8, #0x6a0]
106588b84: 900c2228    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
106588b88: f943d101    	ldr	x1, [x8, #0x7a0] ; selector: registerExtension:withKey:withTarget:
106588b8c: aa1403e3    	mov	x3, x20
106588b90: aa1303e4    	mov	x4, x19
106588b94: 945a7c34    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588b98: aa1703e0    	mov	x0, x23
106588b9c: 945a7c35    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106588ba0: f943c300    	ldr	x0, [x24, #0x780]
106588ba4: aa1603e1    	mov	x1, x22
106588ba8: 945a7c2f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588bac: aa1d03fd    	mov	x29, x29
106588bb0: 945a7c34    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106588bb4: aa0003f6    	mov	x22, x0
106588bb8: 900c3c48    	adrp	x8, 0x11ed10000 <dyld_stub_binder+0x11ed10000>
106588bbc: f9400102    	ldr	x2, [x8]
106588bc0: b00c2208    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106588bc4: f9478501    	ldr	x1, [x8, #0xf08] ; selector: registerExtension:withTarget:
106588bc8: aa1303e3    	mov	x3, x19
106588bcc: 945a7c26    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588bd0: aa1603e0    	mov	x0, x22
106588bd4: 945a7c27    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106588bd8: f00c2f48    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106588bdc: f941b901    	ldr	x1, [x8, #0x370] ; selector: textTranslateInfo
106588be0: aa1303e0    	mov	x0, x19
106588be4: 945a7c20    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588be8: aa1d03fd    	mov	x29, x29
106588bec: 945a7c25    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106588bf0: aa0003f6    	mov	x22, x0
106588bf4: b00c2ea8    	adrp	x8, 0x11eb5d000 <dyld_stub_binder+0x11eb5d000>
106588bf8: f9450901    	ldr	x1, [x8, #0xa10] ; selector: setShowOriginTextNow:
106588bfc: 52800022    	mov	w2, #0x1                ; =1
106588c00: 945a7c19    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588c04: aa1603e0    	mov	x0, x22
106588c08: 945a7c1a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106588c0c: aa1303e0    	mov	x0, x19
106588c10: aa1503e1    	mov	x1, x21
106588c14: 945a7c14    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588c18: aa1d03fd    	mov	x29, x29
106588c1c: 945a7c19    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106588c20: aa0003f5    	mov	x21, x0
106588c24: 900c2268    	adrp	x8, 0x11e9d4000 <dyld_stub_binder+0x11e9d4000>
106588c28: f9453d01    	ldr	x1, [x8, #0xa78] ; selector: IsUnPlayed
106588c2c: 945a7c0e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588c30: d00c4288    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106588c34: b98d1108    	ldrsw	x8, [x8, #0xd10] ; ivar: VoiceMessageViewModel.m_isLastStatusUnPlay offset=112
106588c38: 38286a60    	strb	w0, [x19, x8]
106588c3c: aa1503e0    	mov	x0, x21
106588c40: 945a7c0c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106588c44: d00c4288    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106588c48: b98d1508    	ldrsw	x8, [x8, #0xd14] ; ivar: VoiceMessageViewModel.m_startPlayCount offset=116
106588c4c: b8286a7f    	str	wzr, [x19, x8]
106588c50: d00c4288    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106588c54: b98d1908    	ldrsw	x8, [x8, #0xd18] ; ivar: VoiceMessageViewModel.m_currentPlayRate offset=128
106588c58: d2e7fe09    	mov	x9, #0x3ff0000000000000 ; =4607182418800017408
106588c5c: f8286a69    	str	x9, [x19, x8]
106588c60: aa1403e0    	mov	x0, x20
106588c64: 945a7c03    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106588c68: aa1303e0    	mov	x0, x19
106588c6c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
106588c70: a9434ff4    	ldp	x20, x19, [sp, #0x30]
106588c74: a94257f6    	ldp	x22, x21, [sp, #0x20]
106588c78: a9415ff8    	ldp	x24, x23, [sp, #0x10]
106588c7c: 910143ff    	add	sp, sp, #0x50
106588c80: d65f03c0    	ret
