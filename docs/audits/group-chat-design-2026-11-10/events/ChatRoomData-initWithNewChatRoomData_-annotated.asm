
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f78900: d10643ff    	sub	sp, sp, #0x190
100f78904: a9136ffc    	stp	x28, x27, [sp, #0x130]
100f78908: a91467fa    	stp	x26, x25, [sp, #0x140]
100f7890c: a9155ff8    	stp	x24, x23, [sp, #0x150]
100f78910: a91657f6    	stp	x22, x21, [sp, #0x160]
100f78914: a9174ff4    	stp	x20, x19, [sp, #0x170]
100f78918: a9187bfd    	stp	x29, x30, [sp, #0x180]
100f7891c: 910603fd    	add	x29, sp, #0x180
100f78920: aa0003f4    	mov	x20, x0
100f78924: 900e3ea8    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
100f78928: f9451908    	ldr	x8, [x8, #0xa30]
100f7892c: f9400108    	ldr	x8, [x8]
100f78930: f81a03a8    	stur	x8, [x29, #-0x60]
100f78934: f00f3e48    	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
100f78938: 52800029    	mov	w9, #0x1                ; =1
100f7893c: 391ba109    	strb	w9, [x8, #0x6e8]
100f78940: f9001be2    	str	x2, [sp, #0x30]
100f78944: aa0203e0    	mov	x0, x2
100f78948: 95b2bccb    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100f7894c: b00eef08    	adrp	x8, 0x11ed59000 <dyld_stub_binder+0x11ed59000>
100f78950: f946cd08    	ldr	x8, [x8, #0xd98]
100f78954: a90923f4    	stp	x20, x8, [sp, #0x90]
100f78958: 900ee988    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
100f7895c: f9404d01    	ldr	x1, [x8, #0x98] ; selector: init
100f78960: 910243e0    	add	x0, sp, #0x90
100f78964: 95b2bcc1    	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
100f78968: f9001fe0    	str	x0, [sp, #0x38]
100f7896c: b40013c0    	cbz	x0, 0x100f78be4 <__text+0xf70be4>
100f78970: d00eecc8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f78974: f9432900    	ldr	x0, [x8, #0x650]
100f78978: 95b2bca5    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
100f7897c: f9401fe9    	ldr	x9, [sp, #0x38]
100f78980: f9401128    	ldr	x8, [x9, #0x20]
100f78984: f9001120    	str	x0, [x9, #0x20]
100f78988: aa0803e0    	mov	x0, x8
100f7898c: 95b2bcb9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f78990: 4f00e400    	movi.16b	v0, #0x0
100f78994: ad0383e0    	stp	q0, q0, [sp, #0x70]
100f78998: ad0283e0    	stp	q0, q0, [sp, #0x50]
100f7899c: d00ed4e8    	adrp	x8, 0x11ea16000 <dyld_stub_binder+0x11ea16000>
100f789a0: f9475d01    	ldr	x1, [x8, #0xeb8] ; selector: chatRoomMember
100f789a4: f9401be0    	ldr	x0, [sp, #0x30]
100f789a8: 95b2bcaf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f789ac: aa1d03fd    	mov	x29, x29
100f789b0: 95b2bcb4    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f789b4: d00ee968    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100f789b8: f9442d01    	ldr	x1, [x8, #0x858] ; selector: countByEnumeratingWithState:objects:count:
100f789bc: 910143e2    	add	x2, sp, #0x50
100f789c0: 910283e3    	add	x3, sp, #0xa0
100f789c4: f90013e0    	str	x0, [sp, #0x20]
100f789c8: f90003e1    	str	x1, [sp]
100f789cc: 52800204    	mov	w4, #0x10               ; =16
100f789d0: 95b2bca5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f789d4: b4001040    	cbz	x0, 0x100f78bdc <__text+0xf70bdc>
100f789d8: aa0003f7    	mov	x23, x0
100f789dc: f94033e8    	ldr	x8, [sp, #0x60]
100f789e0: f9400113    	ldr	x19, [x8]
100f789e4: d00e0656    	adrp	x22, 0x11d042000 <dyld_stub_binder+0x11d042000>
100f789e8: 912ee2d6    	add	x22, x22, #0xbb8 ; CFString: Flag
100f789ec: d280001b    	mov	x27, #0x0               ; =0
100f789f0: d00ed4e8    	adrp	x8, 0x11ea16000 <dyld_stub_binder+0x11ea16000>
100f789f4: f947611c    	ldr	x28, [x8, #0xec0] ; selector: infoMask
100f789f8: d00ed4e8    	adrp	x8, 0x11ea16000 <dyld_stub_binder+0x11ea16000>
100f789fc: f9476d08    	ldr	x8, [x8, #0xed8] ; selector: setIsSimplify:
100f78a00: f90017e8    	str	x8, [sp, #0x28]
100f78a04: 900ed2a8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
100f78a08: f9453909    	ldr	x9, [x8, #0xa70] ; selector: userName
100f78a0c: b00ee988    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
100f78a10: f942d518    	ldr	x24, [x8, #0x5a8] ; selector: numberWithInt:
100f78a14: d00ed4e8    	adrp	x8, 0x11ea16000 <dyld_stub_binder+0x11ea16000>
100f78a18: f9476508    	ldr	x8, [x8, #0xec8] ; selector: setDataForUserName:key:value:
100f78a1c: a90427e8    	stp	x8, x9, [sp, #0x40]
100f78a20: 900ed2c8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
100f78a24: f941e509    	ldr	x9, [x8, #0x3c8] ; selector: displayName
100f78a28: d00ed4e8    	adrp	x8, 0x11ea16000 <dyld_stub_binder+0x11ea16000>
100f78a2c: f9476908    	ldr	x8, [x8, #0xed0] ; selector: chatroomMemberFlag
100f78a30: a900a7e8    	stp	x8, x9, [sp, #0x8]
100f78a34: f9000ffc    	str	x28, [sp, #0x18]
100f78a38: f94033e8    	ldr	x8, [sp, #0x60]
100f78a3c: f9400108    	ldr	x8, [x8]
100f78a40: eb13011f    	cmp	x8, x19
100f78a44: 54000060    	b.eq	0x100f78a50 <__text+0xf70a50>
100f78a48: f94013e0    	ldr	x0, [sp, #0x20]
100f78a4c: 95b2bc7c    	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
100f78a50: f9402fe8    	ldr	x8, [sp, #0x58]
100f78a54: f87b7919    	ldr	x25, [x8, x27, lsl #3]
100f78a58: f9401be0    	ldr	x0, [sp, #0x30]
100f78a5c: aa1c03e1    	mov	x1, x28
100f78a60: 95b2bc81    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f78a64: 340002e0    	cbz	w0, 0x100f78ac0 <__text+0xf70ac0>
100f78a68: f9401ff4    	ldr	x20, [sp, #0x38]
100f78a6c: aa1403e0    	mov	x0, x20
100f78a70: f94017e1    	ldr	x1, [sp, #0x28]
100f78a74: 52800022    	mov	w2, #0x1                ; =1
100f78a78: 95b2bc7b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f78a7c: aa1903e0    	mov	x0, x25
100f78a80: f94027e1    	ldr	x1, [sp, #0x48]
100f78a84: 95b2bc78    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f78a88: aa1d03fd    	mov	x29, x29
100f78a8c: 95b2bc7d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f78a90: aa0003f5    	mov	x21, x0
100f78a94: d00eecc8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f78a98: f9436100    	ldr	x0, [x8, #0x6c0]
100f78a9c: aa1803e1    	mov	x1, x24
100f78aa0: 52800002    	mov	w2, #0x0                ; =0
100f78aa4: 95b2bc70    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f78aa8: aa1d03fd    	mov	x29, x29
100f78aac: 95b2bc75    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f78ab0: aa0003f9    	mov	x25, x0
100f78ab4: aa1403e0    	mov	x0, x20
100f78ab8: f94023e1    	ldr	x1, [sp, #0x40]
100f78abc: 14000035    	b	0x100f78b90 <__text+0xf70b90>
100f78ac0: aa1903e0    	mov	x0, x25
100f78ac4: aa1803f4    	mov	x20, x24
100f78ac8: f94027f8    	ldr	x24, [sp, #0x48]
100f78acc: aa1803e1    	mov	x1, x24
100f78ad0: 95b2bc65    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f78ad4: aa1d03fd    	mov	x29, x29
100f78ad8: 95b2bc6a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f78adc: aa0003f5    	mov	x21, x0
100f78ae0: aa1903e0    	mov	x0, x25
100f78ae4: f9400be1    	ldr	x1, [sp, #0x10]
100f78ae8: 95b2bc5f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f78aec: aa1d03fd    	mov	x29, x29
100f78af0: 95b2bc64    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f78af4: aa1303f6    	mov	x22, x19
100f78af8: aa0003f3    	mov	x19, x0
100f78afc: a943ebfc    	ldp	x28, x26, [sp, #0x38]
100f78b00: aa1c03e0    	mov	x0, x28
100f78b04: aa1a03e1    	mov	x1, x26
100f78b08: aa1503e2    	mov	x2, x21
100f78b0c: d00e0643    	adrp	x3, 0x11d042000 <dyld_stub_binder+0x11d042000>
100f78b10: 912e6063    	add	x3, x3, #0xb98 ; CFString: DisplayName
100f78b14: aa1303e4    	mov	x4, x19
100f78b18: 95b2bc53    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f78b1c: aa1303e0    	mov	x0, x19
100f78b20: 95b2bc54    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f78b24: aa1503e0    	mov	x0, x21
100f78b28: 95b2bc52    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f78b2c: aa1903e0    	mov	x0, x25
100f78b30: aa1803e1    	mov	x1, x24
100f78b34: aa1403f8    	mov	x24, x20
100f78b38: 95b2bc4b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f78b3c: aa1d03fd    	mov	x29, x29
100f78b40: 95b2bc50    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f78b44: aa0003f5    	mov	x21, x0
100f78b48: d00eecc8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f78b4c: f9436113    	ldr	x19, [x8, #0x6c0]
100f78b50: aa1903e0    	mov	x0, x25
100f78b54: f94007e1    	ldr	x1, [sp, #0x8]
100f78b58: 95b2bc43    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f78b5c: aa0003e2    	mov	x2, x0
100f78b60: aa1303e0    	mov	x0, x19
100f78b64: aa1603f3    	mov	x19, x22
100f78b68: d00e0656    	adrp	x22, 0x11d042000 <dyld_stub_binder+0x11d042000>
100f78b6c: 912ee2d6    	add	x22, x22, #0xbb8 ; CFString: Flag
100f78b70: aa1403e1    	mov	x1, x20
100f78b74: 95b2bc3c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f78b78: aa1d03fd    	mov	x29, x29
100f78b7c: 95b2bc41    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f78b80: aa0003f9    	mov	x25, x0
100f78b84: aa1c03e0    	mov	x0, x28
100f78b88: f9400ffc    	ldr	x28, [sp, #0x18]
100f78b8c: aa1a03e1    	mov	x1, x26
100f78b90: aa1503e2    	mov	x2, x21
100f78b94: aa1603e3    	mov	x3, x22
100f78b98: aa1903e4    	mov	x4, x25
100f78b9c: 95b2bc32    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f78ba0: aa1903e0    	mov	x0, x25
100f78ba4: 95b2bc33    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f78ba8: aa1503e0    	mov	x0, x21
100f78bac: 95b2bc31    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f78bb0: 9100077b    	add	x27, x27, #0x1
100f78bb4: eb1b02ff    	cmp	x23, x27
100f78bb8: 54fff401    	b.ne	0x100f78a38 <__text+0xf70a38>
100f78bbc: 910143e2    	add	x2, sp, #0x50
100f78bc0: 910283e3    	add	x3, sp, #0xa0
100f78bc4: f94013e0    	ldr	x0, [sp, #0x20]
100f78bc8: f94003e1    	ldr	x1, [sp]
100f78bcc: 52800204    	mov	w4, #0x10               ; =16
100f78bd0: 95b2bc25    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f78bd4: aa0003f7    	mov	x23, x0
100f78bd8: b5fff0a0    	cbnz	x0, 0x100f789ec <__text+0xf709ec>
100f78bdc: f94013e0    	ldr	x0, [sp, #0x20]
100f78be0: 95b2bc24    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f78be4: f9401be0    	ldr	x0, [sp, #0x30]
100f78be8: 95b2bc22    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f78bec: f85a03a8    	ldur	x8, [x29, #-0x60]
100f78bf0: 900e3ea9    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
100f78bf4: f9451929    	ldr	x9, [x9, #0xa30]
100f78bf8: f9400129    	ldr	x9, [x9]
100f78bfc: eb08013f    	cmp	x9, x8
100f78c00: 54000141    	b.ne	0x100f78c28 <__text+0xf70c28>
100f78c04: f9401fe0    	ldr	x0, [sp, #0x38]
100f78c08: a9587bfd    	ldp	x29, x30, [sp, #0x180]
100f78c0c: a9574ff4    	ldp	x20, x19, [sp, #0x170]
100f78c10: a95657f6    	ldp	x22, x21, [sp, #0x160]
100f78c14: a9555ff8    	ldp	x24, x23, [sp, #0x150]
100f78c18: a95467fa    	ldp	x26, x25, [sp, #0x140]
100f78c1c: a9536ffc    	ldp	x28, x27, [sp, #0x130]
100f78c20: 910643ff    	add	sp, sp, #0x190
100f78c24: d65f03c0    	ret
100f78c28: 95b2bac2    	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
