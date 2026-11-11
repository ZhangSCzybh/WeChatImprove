
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010b4b00: d10443ff    	sub	sp, sp, #0x110
1010b4b04: 6d0a23e9    	stp	d9, d8, [sp, #0xa0]
1010b4b08: a90b6ffc    	stp	x28, x27, [sp, #0xb0]
1010b4b0c: a90c67fa    	stp	x26, x25, [sp, #0xc0]
1010b4b10: a90d5ff8    	stp	x24, x23, [sp, #0xd0]
1010b4b14: a90e57f6    	stp	x22, x21, [sp, #0xe0]
1010b4b18: a90f4ff4    	stp	x20, x19, [sp, #0xf0]
1010b4b1c: a9107bfd    	stp	x29, x30, [sp, #0x100]
1010b4b20: 910403fd    	add	x29, sp, #0x100
1010b4b24: aa0203f3    	mov	x19, x2
1010b4b28: f00f3468    	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
1010b4b2c: 52800029    	mov	w9, #0x1                ; =1
1010b4b30: 392f2d09    	strb	w9, [x8, #0xbcb]
1010b4b34: aa0203e0    	mov	x0, x2
1010b4b38: 95adcc4f    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1010b4b3c: f00ec8a8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1010b4b40: f9431115    	ldr	x21, [x8, #0x620] ; selector: m_nsUsrName
1010b4b44: aa1303e0    	mov	x0, x19
1010b4b48: aa1503e1    	mov	x1, x21
1010b4b4c: 95adcc46    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b4b50: aa1d03fd    	mov	x29, x29
1010b4b54: 95adcc4b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010b4b58: b4001760    	cbz	x0, 0x1010b4e44 <__text+0x10ace44>
1010b4b5c: aa0003f4    	mov	x20, x0
1010b4b60: aa1303e0    	mov	x0, x19
1010b4b64: aa1503e1    	mov	x1, x21
1010b4b68: 95adcc3f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b4b6c: aa1d03fd    	mov	x29, x29
1010b4b70: 95adcc44    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010b4b74: aa0003f6    	mov	x22, x0
1010b4b78: 900edfa8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1010b4b7c: f9467517    	ldr	x23, [x8, #0xce8] ; selector: length
1010b4b80: aa1703e1    	mov	x1, x23
1010b4b84: 95adcc38    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b4b88: aa0003f8    	mov	x24, x0
1010b4b8c: aa1603e0    	mov	x0, x22
1010b4b90: 95adcc38    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010b4b94: aa1403e0    	mov	x0, x20
1010b4b98: 95adcc36    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010b4b9c: b4001558    	cbz	x24, 0x1010b4e44 <__text+0x10ace44>
1010b4ba0: d00ee2fa    	adrp	x26, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1010b4ba4: f943c340    	ldr	x0, [x26, #0x780]
1010b4ba8: b00ec8a8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1010b4bac: f9440116    	ldr	x22, [x8, #0x800] ; selector: currentContext
1010b4bb0: aa1603e1    	mov	x1, x22
1010b4bb4: 95adcc2c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b4bb8: aa1d03fd    	mov	x29, x29
1010b4bbc: 95adcc31    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010b4bc0: aa0003f8    	mov	x24, x0
1010b4bc4: f00ee2db    	adrp	x27, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
1010b4bc8: f942b779    	ldr	x25, [x27, #0x568]
1010b4bcc: d00ec9a8    	adrp	x8, 0x11e9ea000 <dyld_stub_binder+0x11e9ea000>
1010b4bd0: f946dd14    	ldr	x20, [x8, #0xdb8] ; selector: onModifyContact:
1010b4bd4: 900e34dc    	adrp	x28, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1010b4bd8: f9449b9c    	ldr	x28, [x28, #0x930]
1010b4bdc: f9003bfc    	str	x28, [sp, #0x70]
1010b4be0: f00b4088    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
1010b4be4: fd434108    	ldr	d8, [x8, #0x680] ; constant double=1.6080749353e-314
1010b4be8: fd003fe8    	str	d8, [sp, #0x78]
1010b4bec: 90000008    	adrp	x8, 0x1010b4000 <__text+0x10ac000>
1010b4bf0: 913ad108    	add	x8, x8, #0xeb4
1010b4bf4: 900d8e69    	adrp	x9, 0x11c280000 <dyld_stub_binder+0x11c280000>
1010b4bf8: 911f8129    	add	x9, x9, #0x7e0
1010b4bfc: a90827e8    	stp	x8, x9, [sp, #0x80]
1010b4c00: aa1303e0    	mov	x0, x19
1010b4c04: 95adcc1c    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1010b4c08: f9004bf3    	str	x19, [sp, #0x90]
1010b4c0c: b00ec8a8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1010b4c10: f9472d01    	ldr	x1, [x8, #0xe58] ; selector: callExtension:selector:block:
1010b4c14: 9101c3e4    	add	x4, sp, #0x70
1010b4c18: aa1803e0    	mov	x0, x24
1010b4c1c: aa1903e2    	mov	x2, x25
1010b4c20: aa1403e3    	mov	x3, x20
1010b4c24: 95adcc10    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b4c28: aa1803e0    	mov	x0, x24
1010b4c2c: 95adcc11    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010b4c30: f9404be0    	ldr	x0, [sp, #0x90]
1010b4c34: 95adcc0f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010b4c38: f943c340    	ldr	x0, [x26, #0x780]
1010b4c3c: f9000ff6    	str	x22, [sp, #0x18]
1010b4c40: aa1603e1    	mov	x1, x22
1010b4c44: 95adcc08    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b4c48: aa1d03fd    	mov	x29, x29
1010b4c4c: 95adcc0d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010b4c50: aa0003f9    	mov	x25, x0
1010b4c54: f942b77a    	ldr	x26, [x27, #0x568]
1010b4c58: aa1303e0    	mov	x0, x19
1010b4c5c: aa1503e1    	mov	x1, x21
1010b4c60: 95adcc01    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b4c64: aa1d03fd    	mov	x29, x29
1010b4c68: 95adcc06    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010b4c6c: aa0003fb    	mov	x27, x0
1010b4c70: f90027fc    	str	x28, [sp, #0x48]
1010b4c74: 900d8e7c    	adrp	x28, 0x11c280000 <dyld_stub_binder+0x11c280000>
1010b4c78: 911f839c    	add	x28, x28, #0x7e0
1010b4c7c: fd002be8    	str	d8, [sp, #0x50]
1010b4c80: 90000008    	adrp	x8, 0x1010b4000 <__text+0x10ac000>
1010b4c84: 913b3108    	add	x8, x8, #0xecc
1010b4c88: a905f3e8    	stp	x8, x28, [sp, #0x58]
1010b4c8c: aa1303e0    	mov	x0, x19
1010b4c90: 95adcbf9    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1010b4c94: f90037f3    	str	x19, [sp, #0x68]
1010b4c98: b00ec8c8    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
1010b4c9c: f9441d18    	ldr	x24, [x8, #0x838] ; selector: callKeyExtension:key:selector:block:
1010b4ca0: 910123e5    	add	x5, sp, #0x48
1010b4ca4: aa1903e0    	mov	x0, x25
1010b4ca8: aa1803e1    	mov	x1, x24
1010b4cac: aa1a03e2    	mov	x2, x26
1010b4cb0: aa1b03e3    	mov	x3, x27
1010b4cb4: aa1403e4    	mov	x4, x20
1010b4cb8: 95adcbeb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b4cbc: aa1b03e0    	mov	x0, x27
1010b4cc0: 95adcbec    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010b4cc4: aa1903e0    	mov	x0, x25
1010b4cc8: 95adcbea    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010b4ccc: f94037e0    	ldr	x0, [sp, #0x68]
1010b4cd0: 95adcbe8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010b4cd4: 900ec8c8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1010b4cd8: f947cd19    	ldr	x25, [x8, #0xf98] ; selector: m_nsEncodeUserName
1010b4cdc: aa1303e0    	mov	x0, x19
1010b4ce0: aa1903e1    	mov	x1, x25
1010b4ce4: 95adcbe0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b4ce8: aa1d03fd    	mov	x29, x29
1010b4cec: 95adcbe5    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010b4cf0: aa0003fa    	mov	x26, x0
1010b4cf4: aa1703e1    	mov	x1, x23
1010b4cf8: 95adcbdb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b4cfc: b40007e0    	cbz	x0, 0x1010b4df8 <__text+0x10acdf8>
1010b4d00: aa1303e0    	mov	x0, x19
1010b4d04: aa1903e1    	mov	x1, x25
1010b4d08: 95adcbd7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b4d0c: aa1d03fd    	mov	x29, x29
1010b4d10: 95adcbdc    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010b4d14: aa0003f7    	mov	x23, x0
1010b4d18: aa1303e0    	mov	x0, x19
1010b4d1c: aa1503e1    	mov	x1, x21
1010b4d20: 95adcbd1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b4d24: aa1d03fd    	mov	x29, x29
1010b4d28: 95adcbd6    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010b4d2c: aa0003f5    	mov	x21, x0
1010b4d30: 900edfa8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1010b4d34: f943dd01    	ldr	x1, [x8, #0x7b8] ; selector: isEqualToString:
1010b4d38: aa1703e0    	mov	x0, x23
1010b4d3c: aa1503e2    	mov	x2, x21
1010b4d40: 95adcbc9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b4d44: aa0003fb    	mov	x27, x0
1010b4d48: aa1503e0    	mov	x0, x21
1010b4d4c: 95adcbc9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010b4d50: aa1703e0    	mov	x0, x23
1010b4d54: 95adcbc7    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010b4d58: aa1a03e0    	mov	x0, x26
1010b4d5c: 95adcbc5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010b4d60: 3700051b    	tbnz	w27, #0x0, 0x1010b4e00 <__text+0x10ace00>
1010b4d64: d00ee2e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1010b4d68: f943c100    	ldr	x0, [x8, #0x780]
1010b4d6c: f9400fe1    	ldr	x1, [sp, #0x18]
1010b4d70: 95adcbbd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b4d74: aa1d03fd    	mov	x29, x29
1010b4d78: 95adcbc2    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010b4d7c: aa0003f5    	mov	x21, x0
1010b4d80: f00ee2c8    	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
1010b4d84: f942b516    	ldr	x22, [x8, #0x568]
1010b4d88: aa1303e0    	mov	x0, x19
1010b4d8c: aa1903e1    	mov	x1, x25
1010b4d90: 95adcbb5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b4d94: aa1d03fd    	mov	x29, x29
1010b4d98: 95adcbba    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010b4d9c: aa0003f7    	mov	x23, x0
1010b4da0: 900e34c8    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1010b4da4: f9449908    	ldr	x8, [x8, #0x930]
1010b4da8: f90013e8    	str	x8, [sp, #0x20]
1010b4dac: fd0017e8    	str	d8, [sp, #0x28]
1010b4db0: 90000008    	adrp	x8, 0x1010b4000 <__text+0x10ac000>
1010b4db4: 913b9108    	add	x8, x8, #0xee4
1010b4db8: a90373e8    	stp	x8, x28, [sp, #0x30]
1010b4dbc: aa1303e0    	mov	x0, x19
1010b4dc0: 95adcbad    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1010b4dc4: f90023f3    	str	x19, [sp, #0x40]
1010b4dc8: 910083e5    	add	x5, sp, #0x20
1010b4dcc: aa1503e0    	mov	x0, x21
1010b4dd0: aa1803e1    	mov	x1, x24
1010b4dd4: aa1603e2    	mov	x2, x22
1010b4dd8: aa1703e3    	mov	x3, x23
1010b4ddc: aa1403e4    	mov	x4, x20
1010b4de0: 95adcba1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b4de4: aa1703e0    	mov	x0, x23
1010b4de8: 95adcba2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010b4dec: aa1503e0    	mov	x0, x21
1010b4df0: 95adcba0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010b4df4: f94023fa    	ldr	x26, [sp, #0x40]
1010b4df8: aa1a03e0    	mov	x0, x26
1010b4dfc: 95adcb9d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010b4e00: d00ee2e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1010b4e04: f9430d00    	ldr	x0, [x8, #0x618]
1010b4e08: b00ec8a8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1010b4e0c: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
1010b4e10: b00dfce8    	adrp	x8, 0x11d051000 <dyld_stub_binder+0x11d051000>
1010b4e14: 9133e108    	add	x8, x8, #0xcf8 ; CFString: call ext IContactMgrExt:OnModifyContact %@
1010b4e18: a9004fe8    	stp	x8, x19, [sp]
1010b4e1c: 900c5723    	adrp	x3, 0x119b98000 <dyld_stub_binder+0x119b98000>
1010b4e20: 910fd063    	add	x3, x3, #0x3f4
1010b4e24: f00c6225    	adrp	x5, 0x119cfb000 <dyld_stub_binder+0x119cfb000>
1010b4e28: 913790a5    	add	x5, x5, #0xde4
1010b4e2c: 900c6247    	adrp	x7, 0x119cfc000 <dyld_stub_binder+0x119cfc000>
1010b4e30: 91098ce7    	add	x7, x7, #0x263
1010b4e34: 52800022    	mov	w2, #0x1                ; =1
1010b4e38: 52800004    	mov	w4, #0x0                ; =0
1010b4e3c: 52805866    	mov	w6, #0x2c3              ; =707
1010b4e40: 14000011    	b	0x1010b4e84 <__text+0x10ace84>
1010b4e44: d00ee2e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1010b4e48: f9430d00    	ldr	x0, [x8, #0x618]
1010b4e4c: b00ec8a8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1010b4e50: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
1010b4e54: b00dfce8    	adrp	x8, 0x11d051000 <dyld_stub_binder+0x11d051000>
1010b4e58: 91336108    	add	x8, x8, #0xcd8 ; CFString: empty contact: call ext IContactMgrExt:OnModifyContact %@
1010b4e5c: a9004fe8    	stp	x8, x19, [sp]
1010b4e60: 900c5723    	adrp	x3, 0x119b98000 <dyld_stub_binder+0x119b98000>
1010b4e64: 910fd063    	add	x3, x3, #0x3f4
1010b4e68: f00c6225    	adrp	x5, 0x119cfb000 <dyld_stub_binder+0x119cfb000>
1010b4e6c: 913790a5    	add	x5, x5, #0xde4
1010b4e70: 900c6247    	adrp	x7, 0x119cfc000 <dyld_stub_binder+0x119cfc000>
1010b4e74: 91098ce7    	add	x7, x7, #0x263
1010b4e78: 52800062    	mov	w2, #0x3                ; =3
1010b4e7c: 52800004    	mov	w4, #0x0                ; =0
1010b4e80: 52805746    	mov	w6, #0x2ba              ; =698
1010b4e84: 95adcb78    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b4e88: aa1303e0    	mov	x0, x19
1010b4e8c: 95adcb79    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010b4e90: a9507bfd    	ldp	x29, x30, [sp, #0x100]
1010b4e94: a94f4ff4    	ldp	x20, x19, [sp, #0xf0]
1010b4e98: a94e57f6    	ldp	x22, x21, [sp, #0xe0]
1010b4e9c: a94d5ff8    	ldp	x24, x23, [sp, #0xd0]
1010b4ea0: a94c67fa    	ldp	x26, x25, [sp, #0xc0]
1010b4ea4: a94b6ffc    	ldp	x28, x27, [sp, #0xb0]
1010b4ea8: 6d4a23e9    	ldp	d9, d8, [sp, #0xa0]
1010b4eac: 910443ff    	add	sp, sp, #0x110
1010b4eb0: d65f03c0    	ret
1010b4eb4: aa0103e8    	mov	x8, x1
1010b4eb8: f9401002    	ldr	x2, [x0, #0x20]
1010b4ebc: d00ec9a9    	adrp	x9, 0x11e9ea000 <dyld_stub_binder+0x11e9ea000>
1010b4ec0: f946dd21    	ldr	x1, [x9, #0xdb8] ; selector: onModifyContact:
1010b4ec4: aa0803e0    	mov	x0, x8
1010b4ec8: 15adcb67    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b4ecc: aa0103e8    	mov	x8, x1
1010b4ed0: f9401002    	ldr	x2, [x0, #0x20]
1010b4ed4: d00ec9a9    	adrp	x9, 0x11e9ea000 <dyld_stub_binder+0x11e9ea000>
1010b4ed8: f946dd21    	ldr	x1, [x9, #0xdb8] ; selector: onModifyContact:
1010b4edc: aa0803e0    	mov	x0, x8
1010b4ee0: 15adcb61    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b4ee4: aa0103e8    	mov	x8, x1
1010b4ee8: f9401002    	ldr	x2, [x0, #0x20]
1010b4eec: d00ec9a9    	adrp	x9, 0x11e9ea000 <dyld_stub_binder+0x11e9ea000>
1010b4ef0: f946dd21    	ldr	x1, [x9, #0xdb8] ; selector: onModifyContact:
1010b4ef4: aa0803e0    	mov	x0, x8
1010b4ef8: 15adcb5b    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
