
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
1049b39ec: d10303ff    	sub	sp, sp, #0xc0
1049b39f0: a9066ffc    	stp	x28, x27, [sp, #0x60]
1049b39f4: a90767fa    	stp	x26, x25, [sp, #0x70]
1049b39f8: a9085ff8    	stp	x24, x23, [sp, #0x80]
1049b39fc: a90957f6    	stp	x22, x21, [sp, #0x90]
1049b3a00: a90a4ff4    	stp	x20, x19, [sp, #0xa0]
1049b3a04: a90b7bfd    	stp	x29, x30, [sp, #0xb0]
1049b3a08: 9102c3fd    	add	x29, sp, #0xb0
1049b3a0c: aa0603f3    	mov	x19, x6
1049b3a10: aa0503f6    	mov	x22, x5
1049b3a14: aa0403f7    	mov	x23, x4
1049b3a18: aa0303f8    	mov	x24, x3
1049b3a1c: aa0203f4    	mov	x20, x2
1049b3a20: aa0003f9    	mov	x25, x0
1049b3a24: b00d6ce8    	adrp	x8, 0x11f750000 <dyld_stub_binder+0x11f750000>
1049b3a28: 52800029    	mov	w9, #0x1                ; =1
1049b3a2c: 39332909    	strb	w9, [x8, #0xcca]
1049b3a30: aa0203e0    	mov	x0, x2
1049b3a34: 94c9d090    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1049b3a38: aa1303e0    	mov	x0, x19
1049b3a3c: 94c9d08e    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1049b3a40: f00d0ae8    	adrp	x8, 0x11eb12000 <dyld_stub_binder+0x11eb12000>
1049b3a44: f9464101    	ldr	x1, [x8, #0xc80]
1049b3a48: aa1903e0    	mov	x0, x25
1049b3a4c: 94c9d086    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1049b3a50: aa1d03fd    	mov	x29, x29
1049b3a54: 94c9d08b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1049b3a58: aa0003f5    	mov	x21, x0
1049b3a5c: 910163e0    	add	x0, sp, #0x58
1049b3a60: aa1903e1    	mov	x1, x25
1049b3a64: 94c9d07d    	bl	0x107c27c58 <_Flutter_MMFoundation_BindContext+0x3eae924>
1049b3a68: b00c6cc8    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1049b3a6c: f9449908    	ldr	x8, [x8, #0x930]
1049b3a70: f9000be8    	str	x8, [sp, #0x10]
1049b3a74: 900978a8    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
1049b3a78: fd434100    	ldr	d0, [x8, #0x680]
1049b3a7c: 90000008    	adrp	x8, 0x1049b3000 <_Flutter_MMFoundation_BindContext+0xc39ccc>
1049b3a80: 912db108    	add	x8, x8, #0xb6c
1049b3a84: fd000fe0    	str	d0, [sp, #0x18]
1049b3a88: d00bc6c9    	adrp	x9, 0x11c28d000 <dyld_stub_binder+0x11c28d000>
1049b3a8c: 91372129    	add	x9, x9, #0xdc8
1049b3a90: a90227e8    	stp	x8, x9, [sp, #0x20]
1049b3a94: 910043fb    	add	x27, sp, #0x10
1049b3a98: 9100e360    	add	x0, x27, #0x38
1049b3a9c: 910163e1    	add	x1, sp, #0x58
1049b3aa0: 94c9d064    	bl	0x107c27c30 <_Flutter_MMFoundation_BindContext+0x3eae8fc>
1049b3aa4: a903cff5    	stp	x21, x19, [sp, #0x38]
1049b3aa8: 390143f8    	strb	w24, [sp, #0x50]
1049b3aac: f9001bf4    	str	x20, [sp, #0x30]
1049b3ab0: aa1503e0    	mov	x0, x21
1049b3ab4: 94c9d070    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1049b3ab8: aa1403e0    	mov	x0, x20
1049b3abc: 94c9d06e    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1049b3ac0: aa1303e0    	mov	x0, x19
1049b3ac4: 94c9d06c    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1049b3ac8: 910043e0    	add	x0, sp, #0x10
1049b3acc: 94c9d06e    	bl	0x107c27c84 <_Flutter_MMFoundation_BindContext+0x3eae950>
1049b3ad0: aa0003fa    	mov	x26, x0
1049b3ad4: b00d1d88    	adrp	x8, 0x11ed64000 <dyld_stub_binder+0x11ed64000>
1049b3ad8: f944c508    	ldr	x8, [x8, #0x988]
1049b3adc: a90023f9    	stp	x25, x8, [sp]
1049b3ae0: 900d04e8    	adrp	x8, 0x11ea4f000 <dyld_stub_binder+0x11ea4f000>
1049b3ae4: f943c501    	ldr	x1, [x8, #0x788]
1049b3ae8: 910003e0    	mov	x0, sp
1049b3aec: aa1403e2    	mov	x2, x20
1049b3af0: aa1803e3    	mov	x3, x24
1049b3af4: aa1703e4    	mov	x4, x23
1049b3af8: aa1603e5    	mov	x5, x22
1049b3afc: aa1a03e6    	mov	x6, x26
1049b3b00: 94c9d05a    	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
1049b3b04: aa1a03e0    	mov	x0, x26
1049b3b08: 94c9d05a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1049b3b0c: f9401fe0    	ldr	x0, [sp, #0x38]
1049b3b10: 94c9d058    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1049b3b14: f9401be0    	ldr	x0, [sp, #0x30]
1049b3b18: 94c9d056    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1049b3b1c: f94023e0    	ldr	x0, [sp, #0x40]
1049b3b20: 94c9d054    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1049b3b24: aa1503e0    	mov	x0, x21
1049b3b28: 94c9d052    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1049b3b2c: aa1403e0    	mov	x0, x20
1049b3b30: 94c9d050    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1049b3b34: aa1303e0    	mov	x0, x19
1049b3b38: 94c9d04e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1049b3b3c: 9100e360    	add	x0, x27, #0x38
1049b3b40: 94c9d03d    	bl	0x107c27c34 <_Flutter_MMFoundation_BindContext+0x3eae900>
1049b3b44: 910163e0    	add	x0, sp, #0x58
1049b3b48: 94c9d03b    	bl	0x107c27c34 <_Flutter_MMFoundation_BindContext+0x3eae900>
1049b3b4c: a94b7bfd    	ldp	x29, x30, [sp, #0xb0]
1049b3b50: a94a4ff4    	ldp	x20, x19, [sp, #0xa0]
1049b3b54: a94957f6    	ldp	x22, x21, [sp, #0x90]
1049b3b58: a9485ff8    	ldp	x24, x23, [sp, #0x80]
1049b3b5c: a94767fa    	ldp	x26, x25, [sp, #0x70]
1049b3b60: a9466ffc    	ldp	x28, x27, [sp, #0x60]
1049b3b64: 910303ff    	add	sp, sp, #0xc0
1049b3b68: d65f03c0    	ret
1049b3b6c: d101c3ff    	sub	sp, sp, #0x70
1049b3b70: a90457f6    	stp	x22, x21, [sp, #0x40]
1049b3b74: a9054ff4    	stp	x20, x19, [sp, #0x50]
1049b3b78: a9067bfd    	stp	x29, x30, [sp, #0x60]
1049b3b7c: 910183fd    	add	x29, sp, #0x60
1049b3b80: aa0003f4    	mov	x20, x0
1049b3b84: 9100e000    	add	x0, x0, #0x38
1049b3b88: 94c9d035    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1049b3b8c: aa0003f3    	mov	x19, x0
1049b3b90: f9401a80    	ldr	x0, [x20, #0x30]
1049b3b94: b4000060    	cbz	x0, 0x1049b3ba0 <_Flutter_MMFoundation_BindContext+0xc3a86c>
1049b3b98: f9400808    	ldr	x8, [x0, #0x10]
1049b3b9c: d63f0100    	blr	x8
1049b3ba0: 39410288    	ldrb	w8, [x20, #0x40]
1049b3ba4: 7100051f    	cmp	w8, #0x1
1049b3ba8: 540005c1    	b.ne	0x1049b3c60 <_Flutter_MMFoundation_BindContext+0xc3a92c>
1049b3bac: f00d1ae8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1049b3bb0: f9431d00    	ldr	x0, [x8, #0x638]
1049b3bb4: f9401288    	ldr	x8, [x20, #0x20]
1049b3bb8: d00d17c9    	adrp	x9, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1049b3bbc: f942e521    	ldr	x1, [x9, #0x5c8]
1049b3bc0: f90003e8    	str	x8, [sp]
1049b3bc4: d00c2f42    	adrp	x2, 0x11cf9d000 <dyld_stub_binder+0x11cf9d000>
1049b3bc8: 911b6042    	add	x2, x2, #0x6d8
1049b3bcc: 94c9d026    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1049b3bd0: aa1d03fd    	mov	x29, x29
1049b3bd4: 94c9d02b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1049b3bd8: aa0003f5    	mov	x21, x0
1049b3bdc: d2800000    	mov	x0, #0x0                ; =0
1049b3be0: 529c2001    	mov	w1, #0xe100             ; =57600
1049b3be4: 72a0bea1    	movk	w1, #0x5f5, lsl #16
1049b3be8: 94c9cf45    	bl	0x107c278fc <_Flutter_MMFoundation_BindContext+0x3eae5c8>
1049b3bec: aa0003f6    	mov	x22, x0
1049b3bf0: b00c6cc8    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1049b3bf4: f9449908    	ldr	x8, [x8, #0x930]
1049b3bf8: f90007e8    	str	x8, [sp, #0x8]
1049b3bfc: 900978a8    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
1049b3c00: fd434100    	ldr	d0, [x8, #0x680]
1049b3c04: 90000008    	adrp	x8, 0x1049b3000 <_Flutter_MMFoundation_BindContext+0xc39ccc>
1049b3c08: 9131f108    	add	x8, x8, #0xc7c
1049b3c0c: fd000be0    	str	d0, [sp, #0x10]
1049b3c10: b00bc669    	adrp	x9, 0x11c280000 <dyld_stub_binder+0x11c280000>
1049b3c14: 91000129    	add	x9, x9, #0x0
1049b3c18: a901a7e8    	stp	x8, x9, [sp, #0x18]
1049b3c1c: f9401680    	ldr	x0, [x20, #0x28]
1049b3c20: 94c9d015    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1049b3c24: a902cfe0    	stp	x0, x19, [sp, #0x28]
1049b3c28: f9001ff5    	str	x21, [sp, #0x38]
1049b3c2c: aa1503e0    	mov	x0, x21
1049b3c30: 94c9d011    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1049b3c34: b00c6cc1    	adrp	x1, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1049b3c38: f9454c21    	ldr	x1, [x1, #0xa98]
1049b3c3c: 910023e2    	add	x2, sp, #0x8
1049b3c40: aa1603e0    	mov	x0, x22
1049b3c44: 94c963d8    	bl	0x107c0cba4 <_Flutter_MMFoundation_BindContext+0x3e93870>
1049b3c48: f9401fe0    	ldr	x0, [sp, #0x38]
1049b3c4c: 94c9d009    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1049b3c50: f94017e0    	ldr	x0, [sp, #0x28]
1049b3c54: 94c9d007    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1049b3c58: aa1503e0    	mov	x0, x21
1049b3c5c: 94c9d005    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1049b3c60: aa1303e0    	mov	x0, x19
1049b3c64: 94c9d003    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1049b3c68: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1049b3c6c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1049b3c70: a94457f6    	ldp	x22, x21, [sp, #0x40]
1049b3c74: 9101c3ff    	add	sp, sp, #0x70
1049b3c78: d65f03c0    	ret
1049b3c7c: d10183ff    	sub	sp, sp, #0x60
1049b3c80: a9025ff8    	stp	x24, x23, [sp, #0x20]
1049b3c84: a90357f6    	stp	x22, x21, [sp, #0x30]
1049b3c88: a9044ff4    	stp	x20, x19, [sp, #0x40]
1049b3c8c: a9057bfd    	stp	x29, x30, [sp, #0x50]
1049b3c90: 910143fd    	add	x29, sp, #0x50
1049b3c94: aa0003f3    	mov	x19, x0
1049b3c98: a9420014    	ldp	x20, x0, [x0, #0x20]
1049b3c9c: f00d0ae8    	adrp	x8, 0x11eb12000 <dyld_stub_binder+0x11eb12000>
1049b3ca0: f9464101    	ldr	x1, [x8, #0xc80]
1049b3ca4: 94c9cff0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1049b3ca8: aa1d03fd    	mov	x29, x29
1049b3cac: 94c9cff5    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1049b3cb0: aa0003f5    	mov	x21, x0
1049b3cb4: b00d17a8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1049b3cb8: f943dd01    	ldr	x1, [x8, #0x7b8]
1049b3cbc: aa1403e0    	mov	x0, x20
1049b3cc0: aa1503e2    	mov	x2, x21
1049b3cc4: 94c9cfe8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1049b3cc8: 36000de0    	tbz	w0, #0x0, 0x1049b3e84 <_Flutter_MMFoundation_BindContext+0xc3ab50>
1049b3ccc: f9401660    	ldr	x0, [x19, #0x28]
1049b3cd0: d00d17c8    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1049b3cd4: f9473514    	ldr	x20, [x8, #0xe68]
1049b3cd8: aa1403e1    	mov	x1, x20
1049b3cdc: 94c9cfe2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1049b3ce0: aa1d03fd    	mov	x29, x29
1049b3ce4: 94c9cfe7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1049b3ce8: aa0003f6    	mov	x22, x0
1049b3cec: f00d1788    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1049b3cf0: f9442901    	ldr	x1, [x8, #0x850]
1049b3cf4: 94c9cfdc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1049b3cf8: aa0003f7    	mov	x23, x0
1049b3cfc: aa1603e0    	mov	x0, x22
1049b3d00: 94c9cfdc    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1049b3d04: aa1503e0    	mov	x0, x21
1049b3d08: 94c9cfda    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1049b3d0c: f10006ff    	cmp	x23, #0x1
1049b3d10: 54000c81    	b.ne	0x1049b3ea0 <_Flutter_MMFoundation_BindContext+0xc3ab6c>
1049b3d14: 52800720    	mov	w0, #0x39               ; =57
1049b3d18: 528002e1    	mov	w1, #0x17               ; =23
1049b3d1c: 52800022    	mov	w2, #0x1                ; =1
1049b3d20: 52800003    	mov	w3, #0x0                ; =0
1049b3d24: 52800004    	mov	w4, #0x0                ; =0
1049b3d28: 975cd939    	bl	0x1020ea20c <_Flutter_Image_provideRelativePathByUrl+0x372698>
1049b3d2c: f00d1ae8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1049b3d30: f9430d15    	ldr	x21, [x8, #0x618]
1049b3d34: f9401676    	ldr	x22, [x19, #0x28]
1049b3d38: aa1603e0    	mov	x0, x22
1049b3d3c: aa1403e1    	mov	x1, x20
1049b3d40: 94c9cfc9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1049b3d44: aa1d03fd    	mov	x29, x29
1049b3d48: 94c9cfce    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1049b3d4c: aa0003f4    	mov	x20, x0
1049b3d50: f9401a68    	ldr	x8, [x19, #0x30]
1049b3d54: d00d00a9    	adrp	x9, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1049b3d58: f9418921    	ldr	x1, [x9, #0x310]
1049b3d5c: a90123e0    	stp	x0, x8, [sp, #0x10]
1049b3d60: f00c4688    	adrp	x8, 0x11d286000 <dyld_stub_binder+0x11d286000>
1049b3d64: 913ae108    	add	x8, x8, #0xeb8
1049b3d68: a9005be8    	stp	x8, x22, [sp]
1049b3d6c: f00abce5    	adrp	x5, 0x11a152000 <dyld_stub_binder+0x11a152000>
1049b3d70: 912e7ca5    	add	x5, x5, #0xb9f
1049b3d74: f00abce7    	adrp	x7, 0x11a152000 <dyld_stub_binder+0x11a152000>
1049b3d78: 912f0ce7    	add	x7, x7, #0xbc3
1049b3d7c: aa1503e0    	mov	x0, x21
1049b3d80: 52800062    	mov	w2, #0x3                ; =3
1049b3d84: d2800003    	mov	x3, #0x0                ; =0
1049b3d88: 52800004    	mov	w4, #0x0                ; =0
1049b3d8c: 52800626    	mov	w6, #0x31               ; =49
1049b3d90: 94c9cfb5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1049b3d94: aa1403e0    	mov	x0, x20
1049b3d98: 94c9cfb6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1049b3d9c: f9401660    	ldr	x0, [x19, #0x28]
1049b3da0: f00d0ae8    	adrp	x8, 0x11eb12000 <dyld_stub_binder+0x11eb12000>
1049b3da4: f9464501    	ldr	x1, [x8, #0xc88]
1049b3da8: 94c9cfaf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1049b3dac: 370007a0    	tbnz	w0, #0x0, 0x1049b3ea0 <_Flutter_MMFoundation_BindContext+0xc3ab6c>
1049b3db0: f00d1ae8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1049b3db4: f943c100    	ldr	x0, [x8, #0x780]
1049b3db8: d00d00a8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1049b3dbc: f9440101    	ldr	x1, [x8, #0x800]
1049b3dc0: 94c9cfa9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1049b3dc4: aa1d03fd    	mov	x29, x29
1049b3dc8: 94c9cfae    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1049b3dcc: aa0003f4    	mov	x20, x0
1049b3dd0: f00d1ae8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1049b3dd4: f9444900    	ldr	x0, [x8, #0x890]
1049b3dd8: f00d1788    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1049b3ddc: f9428501    	ldr	x1, [x8, #0x508]
1049b3de0: 94c9cfa1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1049b3de4: aa0003e2    	mov	x2, x0
1049b3de8: d00d00a8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1049b3dec: f9452101    	ldr	x1, [x8, #0xa40]
1049b3df0: aa1403e0    	mov	x0, x20
1049b3df4: 94c9cf9c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1049b3df8: aa1d03fd    	mov	x29, x29
1049b3dfc: 94c9cfa1    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1049b3e00: aa0003f5    	mov	x21, x0
1049b3e04: d00d00a8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1049b3e08: f9472501    	ldr	x1, [x8, #0xe48]
1049b3e0c: f00c4682    	adrp	x2, 0x11d286000 <dyld_stub_binder+0x11d286000>
1049b3e10: 913b6042    	add	x2, x2, #0xed8
1049b3e14: 52800003    	mov	w3, #0x0                ; =0
1049b3e18: 94c9cf93    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1049b3e1c: aa0003f6    	mov	x22, x0
1049b3e20: aa1503e0    	mov	x0, x21
1049b3e24: 94c9cf93    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1049b3e28: aa1403e0    	mov	x0, x20
1049b3e2c: 94c9cf91    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1049b3e30: 34000396    	cbz	w22, 0x1049b3ea0 <_Flutter_MMFoundation_BindContext+0xc3ab6c>
1049b3e34: f9401660    	ldr	x0, [x19, #0x28]
1049b3e38: f00d0ae8    	adrp	x8, 0x11eb12000 <dyld_stub_binder+0x11eb12000>
1049b3e3c: f9464901    	ldr	x1, [x8, #0xc90]
1049b3e40: 94c9cf89    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1049b3e44: f9401660    	ldr	x0, [x19, #0x28]
1049b3e48: f00d0ae8    	adrp	x8, 0x11eb12000 <dyld_stub_binder+0x11eb12000>
1049b3e4c: f9464d01    	ldr	x1, [x8, #0xc98]
1049b3e50: 52800022    	mov	w2, #0x1                ; =1
1049b3e54: 94c9cf84    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1049b3e58: 52800720    	mov	w0, #0x39               ; =57
1049b3e5c: 52800301    	mov	w1, #0x18               ; =24
1049b3e60: 52800022    	mov	w2, #0x1                ; =1
1049b3e64: 52800003    	mov	w3, #0x0                ; =0
1049b3e68: 52800004    	mov	w4, #0x0                ; =0
1049b3e6c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1049b3e70: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1049b3e74: a94357f6    	ldp	x22, x21, [sp, #0x30]
1049b3e78: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1049b3e7c: 910183ff    	add	sp, sp, #0x60
1049b3e80: 175cd8e3    	b	0x1020ea20c <_Flutter_Image_provideRelativePathByUrl+0x372698>
1049b3e84: aa1503e0    	mov	x0, x21
1049b3e88: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1049b3e8c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1049b3e90: a94357f6    	ldp	x22, x21, [sp, #0x30]
1049b3e94: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1049b3e98: 910183ff    	add	sp, sp, #0x60
1049b3e9c: 14c9cf75    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1049b3ea0: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1049b3ea4: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1049b3ea8: a94357f6    	ldp	x22, x21, [sp, #0x30]
1049b3eac: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1049b3eb0: 910183ff    	add	sp, sp, #0x60
1049b3eb4: d65f03c0    	ret
