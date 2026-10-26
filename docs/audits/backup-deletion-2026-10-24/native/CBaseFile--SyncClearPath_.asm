
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1175f1ad4: d105c3ff    	sub	sp, sp, #0x170
1175f1ad8: a9116ffc    	stp	x28, x27, [sp, #0x110]
1175f1adc: a91267fa    	stp	x26, x25, [sp, #0x120]
1175f1ae0: a9135ff8    	stp	x24, x23, [sp, #0x130]
1175f1ae4: a91457f6    	stp	x22, x21, [sp, #0x140]
1175f1ae8: a9154ff4    	stp	x20, x19, [sp, #0x150]
1175f1aec: a9167bfd    	stp	x29, x30, [sp, #0x160]
1175f1af0: 910583fd    	add	x29, sp, #0x160
1175f1af4: aa0203f3    	mov	x19, x2
1175f1af8: d002ffe8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1175f1afc: f9405908    	ldr	x8, [x8, #0xb0]
1175f1b00: f9400108    	ldr	x8, [x8]
1175f1b04: f81a03a8    	stur	x8, [x29, #-0x60]
1175f1b08: aa0203e0    	mov	x0, x2
1175f1b0c: 9434e099    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1175f1b10: d0045888    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1175f1b14: f946e901    	ldr	x1, [x8, #0xdd0] ; length
1175f1b18: aa1303e0    	mov	x0, x19
1175f1b1c: 9434e074    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f1b20: b4001240    	cbz	x0, 0x1175f1d68 <_O266DecReleaseOutputPicture+0x43652b0>
1175f1b24: d0045c1c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
1175f1b28: f9463780    	ldr	x0, [x28, #0xc68]
1175f1b2c: 90044248    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1175f1b30: f9467901    	ldr	x1, [x8, #0xcf0] ; FileExist:
1175f1b34: aa1303e2    	mov	x2, x19
1175f1b38: 9434e06d    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f1b3c: 34001160    	cbz	w0, 0x1175f1d68 <_O266DecReleaseOutputPicture+0x43652b0>
1175f1b40: 90045c28    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
1175f1b44: f9420900    	ldr	x0, [x8, #0x410]
1175f1b48: f0045868    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1175f1b4c: f946dd01    	ldr	x1, [x8, #0xdb8] ; defaultManager
1175f1b50: 9434e067    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f1b54: aa1d03fd    	mov	x29, x29
1175f1b58: 9434e08f    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1175f1b5c: aa0003f4    	mov	x20, x0
1175f1b60: f9003fff    	str	xzr, [sp, #0x78]
1175f1b64: f0045868    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1175f1b68: f9428501    	ldr	x1, [x8, #0x508] ; contentsOfDirectoryAtPath:error:
1175f1b6c: 9101e3e3    	add	x3, sp, #0x78
1175f1b70: aa1303e2    	mov	x2, x19
1175f1b74: 9434e05e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f1b78: aa1d03fd    	mov	x29, x29
1175f1b7c: 9434e086    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1175f1b80: aa0003f6    	mov	x22, x0
1175f1b84: f9403fe0    	ldr	x0, [sp, #0x78]
1175f1b88: a90203f4    	stp	x20, x0, [sp, #0x20]
1175f1b8c: 9434e079    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1175f1b90: 4f00e400    	movi.16b	v0, #0x0
1175f1b94: ad0283e0    	stp	q0, q0, [sp, #0x50]
1175f1b98: ad0183e0    	stp	q0, q0, [sp, #0x30]
1175f1b9c: aa1603e0    	mov	x0, x22
1175f1ba0: 9434e074    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1175f1ba4: f0045868    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1175f1ba8: f9435517    	ldr	x23, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1175f1bac: 9100c3e2    	add	x2, sp, #0x30
1175f1bb0: 910203e3    	add	x3, sp, #0x80
1175f1bb4: aa1703e1    	mov	x1, x23
1175f1bb8: 52800204    	mov	w4, #0x10               ; =16
1175f1bbc: 9434e04c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f1bc0: aa0003f8    	mov	x24, x0
1175f1bc4: b40004e0    	cbz	x0, 0x1175f1c60 <_O266DecReleaseOutputPicture+0x43651a8>
1175f1bc8: f94023e8    	ldr	x8, [sp, #0x40]
1175f1bcc: f9400114    	ldr	x20, [x8]
1175f1bd0: d2800015    	mov	x21, #0x0               ; =0
1175f1bd4: b00458c8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1175f1bd8: f9465119    	ldr	x25, [x8, #0xca0] ; stringByAppendingPathComponent:
1175f1bdc: 90044248    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1175f1be0: f946f11a    	ldr	x26, [x8, #0xde0] ; RemoveFile:
1175f1be4: f94023e8    	ldr	x8, [sp, #0x40]
1175f1be8: f9400108    	ldr	x8, [x8]
1175f1bec: eb14011f    	cmp	x8, x20
1175f1bf0: 54000060    	b.eq	0x1175f1bfc <_O266DecReleaseOutputPicture+0x4365144>
1175f1bf4: aa1603e0    	mov	x0, x22
1175f1bf8: 9434e010    	bl	0x118329c38 <dyld_stub_binder+0x118329c38>
1175f1bfc: f9401fe8    	ldr	x8, [sp, #0x38]
1175f1c00: f8757902    	ldr	x2, [x8, x21, lsl #3]
1175f1c04: aa1303e0    	mov	x0, x19
1175f1c08: aa1903e1    	mov	x1, x25
1175f1c0c: 9434e038    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f1c10: aa1d03fd    	mov	x29, x29
1175f1c14: 9434e060    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1175f1c18: aa0003fb    	mov	x27, x0
1175f1c1c: f9463780    	ldr	x0, [x28, #0xc68]
1175f1c20: aa1a03e1    	mov	x1, x26
1175f1c24: aa1b03e2    	mov	x2, x27
1175f1c28: 9434e031    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f1c2c: aa1b03e0    	mov	x0, x27
1175f1c30: 9434e04a    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1c34: 910006b5    	add	x21, x21, #0x1
1175f1c38: eb15031f    	cmp	x24, x21
1175f1c3c: 54fffd41    	b.ne	0x1175f1be4 <_O266DecReleaseOutputPicture+0x436512c>
1175f1c40: 9100c3e2    	add	x2, sp, #0x30
1175f1c44: 910203e3    	add	x3, sp, #0x80
1175f1c48: aa1603e0    	mov	x0, x22
1175f1c4c: aa1703e1    	mov	x1, x23
1175f1c50: 52800204    	mov	w4, #0x10               ; =16
1175f1c54: 9434e026    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f1c58: aa0003f8    	mov	x24, x0
1175f1c5c: b5fffba0    	cbnz	x0, 0x1175f1bd0 <_O266DecReleaseOutputPicture+0x4365118>
1175f1c60: aa1603e0    	mov	x0, x22
1175f1c64: 9434e03d    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1c68: f94017f5    	ldr	x21, [sp, #0x28]
1175f1c6c: b4000735    	cbz	x21, 0x1175f1d50 <_O266DecReleaseOutputPicture+0x4365298>
1175f1c70: 52800080    	mov	w0, #0x4                ; =4
1175f1c74: 97fe341b    	bl	0x11757ece0 <_O266DecReleaseOutputPicture+0x42f2228>
1175f1c78: 340006c0    	cbz	w0, 0x1175f1d50 <_O266DecReleaseOutputPicture+0x4365298>
1175f1c7c: 9434dfd4    	bl	0x118329bcc <dyld_stub_binder+0x118329bcc>
1175f1c80: aa0003f7    	mov	x23, x0
1175f1c84: d0045c14    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
1175f1c88: f9454680    	ldr	x0, [x20, #0xa88]
1175f1c8c: 9434dfbb    	bl	0x118329b78 <dyld_stub_binder+0x118329b78>
1175f1c90: aa0003f9    	mov	x25, x0
1175f1c94: f945469a    	ldr	x26, [x20, #0xa88]
1175f1c98: d0045888    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1175f1c9c: f947f901    	ldr	x1, [x8, #0xff0] ; localizedDescription
1175f1ca0: aa1503e0    	mov	x0, x21
1175f1ca4: 9434e012    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f1ca8: aa1d03fd    	mov	x29, x29
1175f1cac: 9434e03a    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1175f1cb0: aa0003f8    	mov	x24, x0
1175f1cb4: b00458c8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1175f1cb8: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
1175f1cbc: a900ffe0    	stp	x0, xzr, [sp, #0x8]
1175f1cc0: f90003f3    	str	x19, [sp]
1175f1cc4: 9003acc2    	adrp	x2, 0x11eb89000 <dyld_stub_binder+0x11eb89000>
1175f1cc8: 911f2042    	add	x2, x2, #0x7c8
1175f1ccc: aa1a03e0    	mov	x0, x26
1175f1cd0: 9434e007    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f1cd4: aa1d03fd    	mov	x29, x29
1175f1cd8: 9434e02f    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1175f1cdc: aa0003fa    	mov	x26, x0
1175f1ce0: b0045888    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1175f1ce4: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
1175f1ce8: d0037548    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1175f1cec: 91362108    	add	x8, x8, #0xd88
1175f1cf0: a90003e8    	stp	x8, x0, [sp]
1175f1cf4: d0037542    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1175f1cf8: 9134a042    	add	x2, x2, #0xd28
1175f1cfc: aa1903e0    	mov	x0, x25
1175f1d00: 9434dffb    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f1d04: aa0003f9    	mov	x25, x0
1175f1d08: aa1a03e0    	mov	x0, x26
1175f1d0c: 9434e013    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1d10: aa1803e0    	mov	x0, x24
1175f1d14: 9434e011    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1d18: f001e821    	adrp	x1, 0x11b2f8000 <dyld_stub_binder+0x11b2f8000>
1175f1d1c: 911c9821    	add	x1, x1, #0x726
1175f1d20: d0029d42    	adrp	x2, 0x11c99b000 <dyld_stub_binder+0x11c99b000>
1175f1d24: 91230c42    	add	x2, x2, #0x8c3
1175f1d28: f0029d44    	adrp	x4, 0x11c99c000 <dyld_stub_binder+0x11c99c000>
1175f1d2c: 91069884    	add	x4, x4, #0x1a6
1175f1d30: 52800080    	mov	w0, #0x4                ; =4
1175f1d34: 5280a423    	mov	w3, #0x521              ; =1313
1175f1d38: aa1903e5    	mov	x5, x25
1175f1d3c: 97fe33f6    	bl	0x11757ed14 <_O266DecReleaseOutputPicture+0x42f225c>
1175f1d40: aa1903e0    	mov	x0, x25
1175f1d44: 9434e005    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1d48: aa1703e0    	mov	x0, x23
1175f1d4c: 9434df9d    	bl	0x118329bc0 <dyld_stub_binder+0x118329bc0>
1175f1d50: aa1603e0    	mov	x0, x22
1175f1d54: 9434e001    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1d58: aa1503e0    	mov	x0, x21
1175f1d5c: 9434dfff    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1d60: f94013e0    	ldr	x0, [sp, #0x20]
1175f1d64: 9434dffd    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1d68: aa1303e0    	mov	x0, x19
1175f1d6c: 9434dffb    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1d70: f85a03a8    	ldur	x8, [x29, #-0x60]
1175f1d74: d002ffe9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1175f1d78: f9405929    	ldr	x9, [x9, #0xb0]
1175f1d7c: f9400129    	ldr	x9, [x9]
1175f1d80: eb08013f    	cmp	x9, x8
1175f1d84: 54000121    	b.ne	0x1175f1da8 <_O266DecReleaseOutputPicture+0x43652f0>
1175f1d88: a9567bfd    	ldp	x29, x30, [sp, #0x160]
1175f1d8c: a9554ff4    	ldp	x20, x19, [sp, #0x150]
1175f1d90: a95457f6    	ldp	x22, x21, [sp, #0x140]
1175f1d94: a9535ff8    	ldp	x24, x23, [sp, #0x130]
1175f1d98: a95267fa    	ldp	x26, x25, [sp, #0x120]
1175f1d9c: a9516ffc    	ldp	x28, x27, [sp, #0x110]
1175f1da0: 9105c3ff    	add	sp, sp, #0x170
1175f1da4: d65f03c0    	ret
1175f1da8: 9434d2d5    	bl	0x1183268fc <dyld_stub_binder+0x1183268fc>
1175f1dac: aa0003f7    	mov	x23, x0
1175f1db0: aa1903e0    	mov	x0, x25
1175f1db4: 9434dfe9    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1db8: 1400000a    	b	0x1175f1de0 <_O266DecReleaseOutputPicture+0x4365328>
1175f1dbc: aa0003f7    	mov	x23, x0
1175f1dc0: aa1a03e0    	mov	x0, x26
1175f1dc4: 9434dfe5    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1dc8: 14000002    	b	0x1175f1dd0 <_O266DecReleaseOutputPicture+0x4365318>
1175f1dcc: aa0003f7    	mov	x23, x0
1175f1dd0: aa1803e0    	mov	x0, x24
1175f1dd4: 14000013    	b	0x1175f1e20 <_O266DecReleaseOutputPicture+0x4365368>
1175f1dd8: 14000001    	b	0x1175f1ddc <_O266DecReleaseOutputPicture+0x4365324>
1175f1ddc: aa0003f7    	mov	x23, x0
1175f1de0: f94013f4    	ldr	x20, [sp, #0x20]
1175f1de4: 14000011    	b	0x1175f1e28 <_O266DecReleaseOutputPicture+0x4365370>
1175f1de8: 14000008    	b	0x1175f1e08 <_O266DecReleaseOutputPicture+0x4365350>
1175f1dec: aa0003f7    	mov	x23, x0
1175f1df0: 14000012    	b	0x1175f1e38 <_O266DecReleaseOutputPicture+0x4365380>
1175f1df4: 14000001    	b	0x1175f1df8 <_O266DecReleaseOutputPicture+0x4365340>
1175f1df8: aa0003f7    	mov	x23, x0
1175f1dfc: 14000011    	b	0x1175f1e40 <_O266DecReleaseOutputPicture+0x4365388>
1175f1e00: 14000002    	b	0x1175f1e08 <_O266DecReleaseOutputPicture+0x4365350>
1175f1e04: 14000001    	b	0x1175f1e08 <_O266DecReleaseOutputPicture+0x4365350>
1175f1e08: aa0003f7    	mov	x23, x0
1175f1e0c: 14000004    	b	0x1175f1e1c <_O266DecReleaseOutputPicture+0x4365364>
1175f1e10: aa0003f7    	mov	x23, x0
1175f1e14: aa1b03e0    	mov	x0, x27
1175f1e18: 9434dfd0    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1e1c: aa1603e0    	mov	x0, x22
1175f1e20: 9434dfce    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1e24: a94257f4    	ldp	x20, x21, [sp, #0x20]
1175f1e28: aa1603e0    	mov	x0, x22
1175f1e2c: 9434dfcb    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1e30: aa1503e0    	mov	x0, x21
1175f1e34: 9434dfc9    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1e38: aa1403e0    	mov	x0, x20
1175f1e3c: 9434dfc7    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1e40: aa1303e0    	mov	x0, x19
1175f1e44: 9434dfc5    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1e48: aa1703e0    	mov	x0, x23
1175f1e4c: 9434c86e    	bl	0x118324004 <dyld_stub_binder+0x118324004>
