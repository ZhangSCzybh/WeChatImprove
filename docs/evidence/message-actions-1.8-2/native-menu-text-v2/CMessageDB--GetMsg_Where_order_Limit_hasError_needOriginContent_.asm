
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104af7a40: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
104af7a44: a90167fa    	stp	x26, x25, [sp, #0x10]
104af7a48: a9025ff8    	stp	x24, x23, [sp, #0x20]
104af7a4c: a90357f6    	stp	x22, x21, [sp, #0x30]
104af7a50: a9044ff4    	stp	x20, x19, [sp, #0x40]
104af7a54: a9057bfd    	stp	x29, x30, [sp, #0x50]
104af7a58: 910143fd    	add	x29, sp, #0x50
104af7a5c: d10843ff    	sub	sp, sp, #0x210
104af7a60: b90087e7    	str	w7, [sp, #0x84]
104af7a64: aa0603f3    	mov	x19, x6
104af7a68: aa0503f4    	mov	x20, x5
104af7a6c: aa0403f5    	mov	x21, x4
104af7a70: aa0303f6    	mov	x22, x3
104af7a74: aa0203f9    	mov	x25, x2
104af7a78: aa0003f7    	mov	x23, x0
104af7a7c: 900c57c8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104af7a80: f9405908    	ldr	x8, [x8, #0xb0]
104af7a84: f9400108    	ldr	x8, [x8]
104af7a88: f81a03a8    	stur	x8, [x29, #-0x60]
104af7a8c: f00e0a28    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104af7a90: 52800029    	mov	w9, #0x1                ; =1
104af7a94: 39126509    	strb	w9, [x8, #0x499]
104af7a98: aa0203e0    	mov	x0, x2
104af7a9c: 94c4bda7    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104af7aa0: 900db3e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104af7aa4: f9455500    	ldr	x0, [x8, #0xaa8]
104af7aa8: 900db048    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104af7aac: f941a101    	ldr	x1, [x8, #0x340] ; array
104af7ab0: 94c4bda3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7ab4: aa1d03fd    	mov	x29, x29
104af7ab8: 94c4bda4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104af7abc: f90047e0    	str	x0, [sp, #0x88]
104af7ac0: aa1603e0    	mov	x0, x22
104af7ac4: 94c45424    	bl	0x107c0cb54 <_Flutter_MMFoundation_BindContext+0x40e8738>
104af7ac8: 39c3a008    	ldrsb	w8, [x0, #0xe8]
104af7acc: 900db3fa    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
104af7ad0: f90033f9    	str	x25, [sp, #0x60]
104af7ad4: 36f80408    	tbz	w8, #0x1f, 0x104af7b54 <_Flutter_MMFoundation_BindContext+0xfd3738>
104af7ad8: f9400ea8    	ldr	x8, [x21, #0x18]
104af7adc: b50003c8    	cbnz	x8, 0x104af7b54 <_Flutter_MMFoundation_BindContext+0xfd3738>
104af7ae0: f9453758    	ldr	x24, [x26, #0xa68] ; �gH 
104af7ae4: 900db3e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104af7ae8: f9454500    	ldr	x0, [x8, #0xa88]
104af7aec: b00d9a28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104af7af0: f947c901    	ldr	x1, [x8, #0xf90] ; generatePrivacyString:
104af7af4: aa1903e2    	mov	x2, x25
104af7af8: 94c4bd91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7afc: aa1d03fd    	mov	x29, x29
104af7b00: 94c4bd92    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104af7b04: aa0003f9    	mov	x25, x0
104af7b08: d00d9a08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104af7b0c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104af7b10: f00ce548    	adrp	x8, 0x11e7a2000 <dyld_stub_binder+0x11e7a2000>
104af7b14: 91102108    	add	x8, x8, #0x408
104af7b18: a90003e8    	stp	x8, x0, [sp]
104af7b1c: d00b3963    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104af7b20: 9107f063    	add	x3, x3, #0x1fc
104af7b24: b00b6805    	adrp	x5, 0x11b7f8000 <dyld_stub_binder+0x11b7f8000>
104af7b28: 91027ca5    	add	x5, x5, #0x9f
104af7b2c: b00b6807    	adrp	x7, 0x11b7f8000 <dyld_stub_binder+0x11b7f8000>
104af7b30: 9106f8e7    	add	x7, x7, #0x1be
104af7b34: aa1803e0    	mov	x0, x24
104af7b38: 52800062    	mov	w2, #0x3                ; =3
104af7b3c: 52800004    	mov	w4, #0x0                ; =0
104af7b40: 52802fa6    	mov	w6, #0x17d              ; =381
104af7b44: 94c4bd7e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7b48: aa1903e0    	mov	x0, x25
104af7b4c: f94033f9    	ldr	x25, [sp, #0x60]
104af7b50: 94c4bd81    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104af7b54: f94006f8    	ldr	x24, [x23, #0x8]
104af7b58: 900db448    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
104af7b5c: f9409d00    	ldr	x0, [x8, #0x138]
104af7b60: d00d9a08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104af7b64: f947d501    	ldr	x1, [x8, #0xfa8] ; allProperties
104af7b68: 94c4bd75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7b6c: aa0003e3    	mov	x3, x0
104af7b70: f00d9fe8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
104af7b74: f945dd01    	ldr	x1, [x8, #0xbb8] ; GetMessagesByChatName:onProperty:where:order:limit:hasError:
104af7b78: aa1803e0    	mov	x0, x24
104af7b7c: aa1903e2    	mov	x2, x25
104af7b80: aa1603e4    	mov	x4, x22
104af7b84: aa1503e5    	mov	x5, x21
104af7b88: aa1403e6    	mov	x6, x20
104af7b8c: aa1303e7    	mov	x7, x19
104af7b90: 94c4bd6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7b94: aa1d03fd    	mov	x29, x29
104af7b98: 94c4bd6c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104af7b9c: b00db048    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104af7ba0: f9435101    	ldr	x1, [x8, #0x6a0] ; count
104af7ba4: f9002fe0    	str	x0, [sp, #0x58]
104af7ba8: f90017e1    	str	x1, [sp, #0x28]
104af7bac: 94c4bd64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7bb0: b4000340    	cbz	x0, 0x104af7c18 <_Flutter_MMFoundation_BindContext+0xfd37fc>
104af7bb4: f94006e0    	ldr	x0, [x23, #0x8]
104af7bb8: f00d9fe8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
104af7bbc: f945f501    	ldr	x1, [x8, #0xbe8] ; GetMessageExtTable:
104af7bc0: aa1903e2    	mov	x2, x25
104af7bc4: 94c4bd5e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7bc8: aa1d03fd    	mov	x29, x29
104af7bcc: 94c4bd5f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104af7bd0: f9004be0    	str	x0, [sp, #0x90]
104af7bd4: b5000240    	cbnz	x0, 0x104af7c1c <_Flutter_MMFoundation_BindContext+0xfd3800>
104af7bd8: f9453740    	ldr	x0, [x26, #0xa68] ; �gH 
104af7bdc: d00d9a08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104af7be0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104af7be4: f00ce548    	adrp	x8, 0x11e7a2000 <dyld_stub_binder+0x11e7a2000>
104af7be8: 91112108    	add	x8, x8, #0x448
104af7bec: a90067e8    	stp	x8, x25, [sp]
104af7bf0: d00b3963    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104af7bf4: 9107f063    	add	x3, x3, #0x1fc
104af7bf8: b00b6805    	adrp	x5, 0x11b7f8000 <dyld_stub_binder+0x11b7f8000>
104af7bfc: 91027ca5    	add	x5, x5, #0x9f
104af7c00: b00b6807    	adrp	x7, 0x11b7f8000 <dyld_stub_binder+0x11b7f8000>
104af7c04: 9106f8e7    	add	x7, x7, #0x1be
104af7c08: 52800022    	mov	w2, #0x1                ; =1
104af7c0c: 52800004    	mov	w4, #0x0                ; =0
104af7c10: 52803186    	mov	w6, #0x18c              ; =396
104af7c14: 94c4bd4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7c18: f9004bff    	str	xzr, [sp, #0x90]
104af7c1c: 4f00e400    	movi.16b	v0, #0x0
104af7c20: ad0b03e0    	stp	q0, q0, [sp, #0x160]
104af7c24: ad0a03e0    	stp	q0, q0, [sp, #0x140]
104af7c28: f9402fe0    	ldr	x0, [sp, #0x58]
104af7c2c: 94c4bd43    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104af7c30: b00db048    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104af7c34: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
104af7c38: 910503e2    	add	x2, sp, #0x140
104af7c3c: d10383a3    	sub	x3, x29, #0xe0
104af7c40: f9001be1    	str	x1, [sp, #0x30]
104af7c44: 52800204    	mov	w4, #0x10               ; =16
104af7c48: 94c4bd3d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7c4c: f90097e0    	str	x0, [sp, #0x128]
104af7c50: b40020a0    	cbz	x0, 0x104af8064 <_Flutter_MMFoundation_BindContext+0xfd3c48>
104af7c54: 12800008    	mov	w8, #-0x1               ; =-1
104af7c58: a9137fe8    	stp	x8, xzr, [sp, #0x130]
104af7c5c: f940abe8    	ldr	x8, [sp, #0x150]
104af7c60: f9400108    	ldr	x8, [x8]
104af7c64: f9003fe8    	str	x8, [sp, #0x78]
104af7c68: d2800018    	mov	x24, #0x0               ; =0
104af7c6c: 900db0a8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104af7c70: f941c909    	ldr	x9, [x8, #0x390] ; type
104af7c74: b00d9a28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104af7c78: f9452d08    	ldr	x8, [x8, #0xa58] ; initWithMsgType:
104af7c7c: a911a7e8    	stp	x8, x9, [sp, #0x118]
104af7c80: d00d9a68    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
104af7c84: f9456109    	ldr	x9, [x8, #0xac0] ; msgLocalId
104af7c88: 900d9a68    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104af7c8c: f945c508    	ldr	x8, [x8, #0xb88] ; setM_uiMesLocalID:
104af7c90: a910a7e8    	stp	x8, x9, [sp, #0x108]
104af7c94: 900d9ae8    	adrp	x8, 0x11fe53000 <dyld_stub_binder+0x11fe53000>
104af7c98: f942c909    	ldr	x9, [x8, #0x590] ; msgServerId
104af7c9c: b00d9a48    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104af7ca0: f9436508    	ldr	x8, [x8, #0x6c8] ; setM_n64MesSvrID:
104af7ca4: a90fa7e8    	stp	x8, x9, [sp, #0xf8]
104af7ca8: b00db068    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104af7cac: f9440113    	ldr	x19, [x8, #0x800] ; message
104af7cb0: b00d9a28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104af7cb4: f9453d09    	ldr	x9, [x8, #0xa78] ; setM_nsContent:
104af7cb8: f00db088    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104af7cbc: f945b108    	ldr	x8, [x8, #0xb60] ; status
104af7cc0: a90ea7e8    	stp	x8, x9, [sp, #0xe8]
104af7cc4: b00d9a28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104af7cc8: f9454109    	ldr	x9, [x8, #0xa80] ; setM_uiStatus:
104af7ccc: b00d9a48    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104af7cd0: f9438108    	ldr	x8, [x8, #0x700] ; createTime
104af7cd4: a90da7e8    	stp	x8, x9, [sp, #0xd8]
104af7cd8: b00d9a28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104af7cdc: f9454909    	ldr	x9, [x8, #0xa90] ; setM_uiCreateTime:
104af7ce0: b00d9be8    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
104af7ce4: f9416d08    	ldr	x8, [x8, #0x2d8] ; imageStatus
104af7ce8: a90ca7e8    	stp	x8, x9, [sp, #0xc8]
104af7cec: 900d9aa8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104af7cf0: f9438909    	ldr	x9, [x8, #0x710] ; setM_uiImgStatus:
104af7cf4: f00da468    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104af7cf8: f940c10a    	ldr	x10, [x8, #0x180] ; setM_nsBeforeDisplayContent:
104af7cfc: f00d9ba8    	adrp	x8, 0x11fe6e000 <dyld_stub_binder+0x11fe6e000>
104af7d00: f9445908    	ldr	x8, [x8, #0x8b0] ; des
104af7d04: a90ba7e8    	stp	x8, x9, [sp, #0xb8]
104af7d08: f00d9a28    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104af7d0c: f9413d09    	ldr	x9, [x8, #0x278] ; m_uiMessageType
104af7d10: 900db0a8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104af7d14: f9467d08    	ldr	x8, [x8, #0xcf8] ; version
104af7d18: a904abe8    	stp	x8, x10, [sp, #0x48]
104af7d1c: f00d9aa8    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
104af7d20: f946950a    	ldr	x10, [x8, #0xd28] ; setM_uiVoipStatus:
104af7d24: b00d9a28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104af7d28: f947d115    	ldr	x21, [x8, #0xfa0] ; m_uiMesLocalID
104af7d2c: f00da468    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104af7d30: f940c508    	ldr	x8, [x8, #0x188] ; GetMsgExtInMessageExtWithTable:chatName:localId:
104af7d34: a90aa7e8    	stp	x8, x9, [sp, #0xa8]
104af7d38: b00d9a48    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104af7d3c: f9437d1c    	ldr	x28, [x8, #0x6f8] ; msgSource
104af7d40: 900d9a68    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104af7d44: f9455108    	ldr	x8, [x8, #0xaa0] ; setM_nsMsgSource:
104af7d48: a903abe8    	stp	x8, x10, [sp, #0x38]
104af7d4c: f00d9fe8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
104af7d50: f9460109    	ldr	x9, [x8, #0xc00] ; msgFlag
104af7d54: f00d9a48    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
104af7d58: f944f508    	ldr	x8, [x8, #0x9e8] ; setM_uiMsgFlag:
104af7d5c: a906a7e8    	stp	x8, x9, [sp, #0x68]
104af7d60: f00da468    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104af7d64: f940c909    	ldr	x9, [x8, #0x190] ; HandleMessage:ChatName:Des:
104af7d68: f00d9a08    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104af7d6c: f943c508    	ldr	x8, [x8, #0x788] ; safeAddObject:
104af7d70: a909a7e8    	stp	x8, x9, [sp, #0x98]
104af7d74: f940abe8    	ldr	x8, [sp, #0x150]
104af7d78: f9400108    	ldr	x8, [x8]
104af7d7c: f9403fe9    	ldr	x9, [sp, #0x78]
104af7d80: eb09011f    	cmp	x8, x9
104af7d84: 54000060    	b.eq	0x104af7d90 <_Flutter_MMFoundation_BindContext+0xfd3974>
104af7d88: f9402fe0    	ldr	x0, [sp, #0x58]
104af7d8c: 94c4bcf1    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
104af7d90: f940a7e8    	ldr	x8, [sp, #0x148]
104af7d94: f8787916    	ldr	x22, [x8, x24, lsl #3]
104af7d98: b00db3e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104af7d9c: f9411d00    	ldr	x0, [x8, #0x238] ; @�7 
104af7da0: 94c4bcf0    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104af7da4: aa0003f4    	mov	x20, x0
104af7da8: aa1603e0    	mov	x0, x22
104af7dac: f94093e1    	ldr	x1, [sp, #0x120]
104af7db0: 94c4bce3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7db4: 2a0003e2    	mov	w2, w0
104af7db8: aa1403e0    	mov	x0, x20
104af7dbc: f9408fe1    	ldr	x1, [sp, #0x118]
104af7dc0: 94c4bcdf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7dc4: aa0003fb    	mov	x27, x0
104af7dc8: aa1603e0    	mov	x0, x22
104af7dcc: f9408be1    	ldr	x1, [sp, #0x110]
104af7dd0: 94c4bcdb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7dd4: aa0003e2    	mov	x2, x0
104af7dd8: aa1b03e0    	mov	x0, x27
104af7ddc: f94087e1    	ldr	x1, [sp, #0x108]
104af7de0: 94c4bcd7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7de4: aa1603e0    	mov	x0, x22
104af7de8: f94083e1    	ldr	x1, [sp, #0x100]
104af7dec: 94c4bcd4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7df0: aa0003e2    	mov	x2, x0
104af7df4: aa1b03e0    	mov	x0, x27
104af7df8: f9407fe1    	ldr	x1, [sp, #0xf8]
104af7dfc: 94c4bcd0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7e00: aa1603e0    	mov	x0, x22
104af7e04: aa1303e1    	mov	x1, x19
104af7e08: 94c4bccd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7e0c: aa1d03fd    	mov	x29, x29
104af7e10: 94c4bcce    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104af7e14: aa0003f4    	mov	x20, x0
104af7e18: aa1b03e0    	mov	x0, x27
104af7e1c: f9407be1    	ldr	x1, [sp, #0xf0]
104af7e20: aa1403e2    	mov	x2, x20
104af7e24: 94c4bcc6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7e28: aa1403e0    	mov	x0, x20
104af7e2c: 94c4bcca    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104af7e30: aa1603e0    	mov	x0, x22
104af7e34: f94077e1    	ldr	x1, [sp, #0xe8]
104af7e38: 94c4bcc1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7e3c: aa0003e2    	mov	x2, x0
104af7e40: aa1b03e0    	mov	x0, x27
104af7e44: f94073e1    	ldr	x1, [sp, #0xe0]
104af7e48: 94c4bcbd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7e4c: aa1603e0    	mov	x0, x22
104af7e50: f9406fe1    	ldr	x1, [sp, #0xd8]
104af7e54: 94c4bcba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7e58: aa0003e2    	mov	x2, x0
104af7e5c: aa1b03e0    	mov	x0, x27
104af7e60: f9406be1    	ldr	x1, [sp, #0xd0]
104af7e64: 94c4bcb6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7e68: aa1603e0    	mov	x0, x22
104af7e6c: f94067e1    	ldr	x1, [sp, #0xc8]
104af7e70: 94c4bcb3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7e74: aa0003e2    	mov	x2, x0
104af7e78: aa1b03e0    	mov	x0, x27
104af7e7c: f94063e1    	ldr	x1, [sp, #0xc0]
104af7e80: 94c4bcaf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7e84: b94087e8    	ldr	w8, [sp, #0x84]
104af7e88: 340001a8    	cbz	w8, 0x104af7ebc <_Flutter_MMFoundation_BindContext+0xfd3aa0>
104af7e8c: aa1603e0    	mov	x0, x22
104af7e90: aa1303e1    	mov	x1, x19
104af7e94: 94c4bcaa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7e98: aa1d03fd    	mov	x29, x29
104af7e9c: 94c4bcab    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104af7ea0: aa0003f4    	mov	x20, x0
104af7ea4: aa1b03e0    	mov	x0, x27
104af7ea8: f9402be1    	ldr	x1, [sp, #0x50]
104af7eac: aa1403e2    	mov	x2, x20
104af7eb0: 94c4bca3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7eb4: aa1403e0    	mov	x0, x20
104af7eb8: 94c4bca7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104af7ebc: aa1603e0    	mov	x0, x22
104af7ec0: f9405fe1    	ldr	x1, [sp, #0xb8]
104af7ec4: 94c4bc9e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7ec8: aa0003f4    	mov	x20, x0
104af7ecc: aa1b03e0    	mov	x0, x27
104af7ed0: f9405be1    	ldr	x1, [sp, #0xb0]
104af7ed4: 94c4bc9a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7ed8: 7100c81f    	cmp	w0, #0x32
104af7edc: 54000101    	b.ne	0x104af7efc <_Flutter_MMFoundation_BindContext+0xfd3ae0>
104af7ee0: aa1603e0    	mov	x0, x22
104af7ee4: f94027e1    	ldr	x1, [sp, #0x48]
104af7ee8: 94c4bc95    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7eec: aa0003e2    	mov	x2, x0
104af7ef0: aa1b03e0    	mov	x0, x27
104af7ef4: f94023e1    	ldr	x1, [sp, #0x40]
104af7ef8: 94c4bc91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7efc: f94006f6    	ldr	x22, [x23, #0x8]
104af7f00: aa1b03e0    	mov	x0, x27
104af7f04: aa1503e1    	mov	x1, x21
104af7f08: 94c4bc8d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7f0c: aa0003e4    	mov	x4, x0
104af7f10: aa1603e0    	mov	x0, x22
104af7f14: f94057e1    	ldr	x1, [sp, #0xa8]
104af7f18: f9404be2    	ldr	x2, [sp, #0x90]
104af7f1c: aa1903e3    	mov	x3, x25
104af7f20: 94c4bc87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7f24: aa1d03fd    	mov	x29, x29
104af7f28: 94c4bc88    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104af7f2c: aa0003f6    	mov	x22, x0
104af7f30: b40003c0    	cbz	x0, 0x104af7fa8 <_Flutter_MMFoundation_BindContext+0xfd3b8c>
104af7f34: aa1603e0    	mov	x0, x22
104af7f38: aa1c03fa    	mov	x26, x28
104af7f3c: aa1c03e1    	mov	x1, x28
104af7f40: 94c4bc7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7f44: aa1d03fd    	mov	x29, x29
104af7f48: 94c4bc80    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104af7f4c: aa0003f9    	mov	x25, x0
104af7f50: 94c4bc81    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104af7f54: b40001b9    	cbz	x25, 0x104af7f88 <_Flutter_MMFoundation_BindContext+0xfd3b6c>
104af7f58: aa1603e0    	mov	x0, x22
104af7f5c: aa1a03e1    	mov	x1, x26
104af7f60: 94c4bc77    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7f64: aa1d03fd    	mov	x29, x29
104af7f68: 94c4bc78    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104af7f6c: aa0003f9    	mov	x25, x0
104af7f70: aa1b03e0    	mov	x0, x27
104af7f74: f9401fe1    	ldr	x1, [sp, #0x38]
104af7f78: aa1903e2    	mov	x2, x25
104af7f7c: 94c4bc70    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7f80: aa1903e0    	mov	x0, x25
104af7f84: 94c4bc74    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104af7f88: aa1603e0    	mov	x0, x22
104af7f8c: f9403be1    	ldr	x1, [sp, #0x70]
104af7f90: 94c4bc6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7f94: aa0003e2    	mov	x2, x0
104af7f98: aa1b03e0    	mov	x0, x27
104af7f9c: f94037e1    	ldr	x1, [sp, #0x68]
104af7fa0: 94c4bc67    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7fa4: f94033f9    	ldr	x25, [sp, #0x60]
104af7fa8: aa1603e0    	mov	x0, x22
104af7fac: 94c4bc6a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104af7fb0: aa1703e0    	mov	x0, x23
104af7fb4: f94053e1    	ldr	x1, [sp, #0xa0]
104af7fb8: aa1b03e2    	mov	x2, x27
104af7fbc: aa1903e3    	mov	x3, x25
104af7fc0: aa1403e4    	mov	x4, x20
104af7fc4: 94c4bc5e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7fc8: f94047e0    	ldr	x0, [sp, #0x88]
104af7fcc: f9404fe1    	ldr	x1, [sp, #0x98]
104af7fd0: aa1b03e2    	mov	x2, x27
104af7fd4: 94c4bc5a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7fd8: aa1b03e0    	mov	x0, x27
104af7fdc: aa1503e1    	mov	x1, x21
104af7fe0: 94c4bc57    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7fe4: f9409be8    	ldr	x8, [sp, #0x130]
104af7fe8: 6b08001f    	cmp	w0, w8
104af7fec: 540000a2    	b.hs	0x104af8000 <_Flutter_MMFoundation_BindContext+0xfd3be4>
104af7ff0: aa1b03e0    	mov	x0, x27
104af7ff4: aa1503e1    	mov	x1, x21
104af7ff8: 94c4bc51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af7ffc: f9009be0    	str	x0, [sp, #0x130]
104af8000: aa1b03e0    	mov	x0, x27
104af8004: aa1503e1    	mov	x1, x21
104af8008: 94c4bc4d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af800c: f9409fe8    	ldr	x8, [sp, #0x138]
104af8010: 6b08001f    	cmp	w0, w8
104af8014: 540000a9    	b.ls	0x104af8028 <_Flutter_MMFoundation_BindContext+0xfd3c0c>
104af8018: aa1b03e0    	mov	x0, x27
104af801c: aa1503e1    	mov	x1, x21
104af8020: 94c4bc47    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af8024: f9009fe0    	str	x0, [sp, #0x138]
104af8028: aa1b03e0    	mov	x0, x27
104af802c: 94c4bc4a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104af8030: 91000718    	add	x24, x24, #0x1
104af8034: f94097e8    	ldr	x8, [sp, #0x128]
104af8038: eb18011f    	cmp	x8, x24
104af803c: 54ffe9c1    	b.ne	0x104af7d74 <_Flutter_MMFoundation_BindContext+0xfd3958>
104af8040: 910503e2    	add	x2, sp, #0x140
104af8044: d10383a3    	sub	x3, x29, #0xe0
104af8048: f9402fe0    	ldr	x0, [sp, #0x58]
104af804c: f9401be1    	ldr	x1, [sp, #0x30]
104af8050: 52800204    	mov	w4, #0x10               ; =16
104af8054: 94c4bc3a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af8058: f90097e0    	str	x0, [sp, #0x128]
104af805c: b5ffe060    	cbnz	x0, 0x104af7c68 <_Flutter_MMFoundation_BindContext+0xfd384c>
104af8060: 14000003    	b	0x104af806c <_Flutter_MMFoundation_BindContext+0xfd3c50>
104af8064: 12800008    	mov	w8, #-0x1               ; =-1
104af8068: a9137fe8    	stp	x8, xzr, [sp, #0x130]
104af806c: f9402fe0    	ldr	x0, [sp, #0x58]
104af8070: 94c4bc39    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104af8074: f94047f5    	ldr	x21, [sp, #0x88]
104af8078: aa1503e0    	mov	x0, x21
104af807c: f94017f7    	ldr	x23, [sp, #0x28]
104af8080: aa1703e1    	mov	x1, x23
104af8084: 94c4bc2e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af8088: f11f401f    	cmp	x0, #0x7d0
104af808c: 540002e9    	b.ls	0x104af80e8 <_Flutter_MMFoundation_BindContext+0xfd3ccc>
104af8090: f00db3d6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104af8094: f94536d4    	ldr	x20, [x22, #0xa68] ; �gH 
104af8098: aa1503e0    	mov	x0, x21
104af809c: aa1703e1    	mov	x1, x23
104af80a0: 94c4bc27    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af80a4: b00d9a08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104af80a8: f942a913    	ldr	x19, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104af80ac: d00ce548    	adrp	x8, 0x11e7a2000 <dyld_stub_binder+0x11e7a2000>
104af80b0: 9111a108    	add	x8, x8, #0x468
104af80b4: a90003e8    	stp	x8, x0, [sp]
104af80b8: 900b6805    	adrp	x5, 0x11b7f8000 <dyld_stub_binder+0x11b7f8000>
104af80bc: 91027ca5    	add	x5, x5, #0x9f
104af80c0: 900b6807    	adrp	x7, 0x11b7f8000 <dyld_stub_binder+0x11b7f8000>
104af80c4: 9106f8e7    	add	x7, x7, #0x1be
104af80c8: aa1403e0    	mov	x0, x20
104af80cc: aa1303e1    	mov	x1, x19
104af80d0: 52800082    	mov	w2, #0x4                ; =4
104af80d4: d2800003    	mov	x3, #0x0                ; =0
104af80d8: 52800004    	mov	w4, #0x0                ; =0
104af80dc: 52803786    	mov	w6, #0x1bc              ; =444
104af80e0: 94c4bc17    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af80e4: 14000004    	b	0x104af80f4 <_Flutter_MMFoundation_BindContext+0xfd3cd8>
104af80e8: b00d9a08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104af80ec: f942a913    	ldr	x19, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104af80f0: f00db3d6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104af80f4: f94536d4    	ldr	x20, [x22, #0xa68] ; �gH 
104af80f8: aa1503e0    	mov	x0, x21
104af80fc: aa1703e1    	mov	x1, x23
104af8100: 94c4bc0f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af8104: a95323e9    	ldp	x9, x8, [sp, #0x130]
104af8108: a90103e8    	stp	x8, x0, [sp, #0x10]
104af810c: d00ce548    	adrp	x8, 0x11e7a2000 <dyld_stub_binder+0x11e7a2000>
104af8110: 9110a108    	add	x8, x8, #0x428
104af8114: a90027e8    	stp	x8, x9, [sp]
104af8118: 900b6805    	adrp	x5, 0x11b7f8000 <dyld_stub_binder+0x11b7f8000>
104af811c: 91027ca5    	add	x5, x5, #0x9f
104af8120: 900b6807    	adrp	x7, 0x11b7f8000 <dyld_stub_binder+0x11b7f8000>
104af8124: 9106f8e7    	add	x7, x7, #0x1be
104af8128: aa1403e0    	mov	x0, x20
104af812c: aa1303e1    	mov	x1, x19
104af8130: 52800022    	mov	w2, #0x1                ; =1
104af8134: d2800003    	mov	x3, #0x0                ; =0
104af8138: 52800004    	mov	w4, #0x0                ; =0
104af813c: 528037e6    	mov	w6, #0x1bf              ; =447
104af8140: 94c4bbff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af8144: f9404be0    	ldr	x0, [sp, #0x90]
104af8148: 94c4bc03    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104af814c: f9402fe0    	ldr	x0, [sp, #0x58]
104af8150: 94c4bc01    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104af8154: aa1903e0    	mov	x0, x25
104af8158: 94c4bbff    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104af815c: f85a03a8    	ldur	x8, [x29, #-0x60]
104af8160: f00c57a9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104af8164: f9405929    	ldr	x9, [x9, #0xb0]
104af8168: f9400129    	ldr	x9, [x9]
104af816c: eb08013f    	cmp	x9, x8
104af8170: 54000141    	b.ne	0x104af8198 <_Flutter_MMFoundation_BindContext+0xfd3d7c>
104af8174: aa1503e0    	mov	x0, x21
104af8178: 910843ff    	add	sp, sp, #0x210
104af817c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
104af8180: a9444ff4    	ldp	x20, x19, [sp, #0x40]
104af8184: a94357f6    	ldp	x22, x21, [sp, #0x30]
104af8188: a9425ff8    	ldp	x24, x23, [sp, #0x20]
104af818c: a94167fa    	ldp	x26, x25, [sp, #0x10]
104af8190: a8c66ffc    	ldp	x28, x27, [sp], #0x60
104af8194: 14c4bbf7    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
104af8198: 94c4bbf7    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>