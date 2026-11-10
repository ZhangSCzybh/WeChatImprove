
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
1097b7a54: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
1097b7a58: a9015ff8    	stp	x24, x23, [sp, #0x10]
1097b7a5c: a90257f6    	stp	x22, x21, [sp, #0x20]
1097b7a60: a9034ff4    	stp	x20, x19, [sp, #0x30]
1097b7a64: a9047bfd    	stp	x29, x30, [sp, #0x40]
1097b7a68: 910103fd    	add	x29, sp, #0x40
1097b7a6c: aa0003f3    	mov	x19, x0
1097b7a70: f00afd48    	adrp	x8, 0x11f762000 <dyld_stub_binder+0x11f762000>
1097b7a74: 52800029    	mov	w9, #0x1                ; =1
1097b7a78: 391fb509    	strb	w9, [x8, #0x7ed]
1097b7a7c: f00ab288    	adrp	x8, 0x11ee0a000 <dyld_stub_binder+0x11ee0a000>
1097b7a80: b98af919    	ldrsw	x25, [x8, #0xaf8]
1097b7a84: f8796808    	ldr	x8, [x0, x25]
1097b7a88: b5000f88    	cbnz	x8, 0x1097b7c78 <_Flutter_MMFoundation_BindContext+0x5a3e944>
1097b7a8c: f00aaac8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1097b7a90: f943fd00    	ldr	x0, [x8, #0x7f8]
1097b7a94: 9582a03b    	bl	0x10f85fb80 <_GetBoxIamBizTLRecFeedsDataUtil+0xdec64>
1097b7a98: f009fc88    	adrp	x8, 0x11d74a000 <dyld_stub_binder+0x11d74a000>
1097b7a9c: f9465508    	ldr	x8, [x8, #0xca8]
1097b7aa0: 6d400500    	ldp	d0, d1, [x8]
1097b7aa4: 6d410d02    	ldp	d2, d3, [x8, #0x10]
1097b7aa8: b00aa788    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1097b7aac: f9418501    	ldr	x1, [x8, #0x308]
1097b7ab0: 9582a04e    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7ab4: f8796a68    	ldr	x8, [x19, x25]
1097b7ab8: f8396a60    	str	x0, [x19, x25]
1097b7abc: aa0803e0    	mov	x0, x8
1097b7ac0: 9582a04e    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7ac4: f00aaac8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1097b7ac8: f943f115    	ldr	x21, [x8, #0x7e0]
1097b7acc: f00aaac8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1097b7ad0: f9461d16    	ldr	x22, [x8, #0xc38]
1097b7ad4: f00aaac8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1097b7ad8: f943c100    	ldr	x0, [x8, #0x780]
1097b7adc: d00a9088    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1097b7ae0: f9440101    	ldr	x1, [x8, #0x800]
1097b7ae4: 9582a041    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7ae8: aa1d03fd    	mov	x29, x29
1097b7aec: 9582a048    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7af0: aa0003f4    	mov	x20, x0
1097b7af4: f00aaac8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1097b7af8: f9462100    	ldr	x0, [x8, #0xc40]
1097b7afc: f00aa768    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1097b7b00: f9428501    	ldr	x1, [x8, #0x508]
1097b7b04: 9582a039    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7b08: aa0003e2    	mov	x2, x0
1097b7b0c: d00a9088    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1097b7b10: f9452101    	ldr	x1, [x8, #0xa40]
1097b7b14: aa1403e0    	mov	x0, x20
1097b7b18: 9582a034    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7b1c: aa1d03fd    	mov	x29, x29
1097b7b20: 9582a03b    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7b24: aa0003f7    	mov	x23, x0
1097b7b28: 900a90a8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1097b7b2c: f9477501    	ldr	x1, [x8, #0xee8]
1097b7b30: 9009bf82    	adrp	x2, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
1097b7b34: 9132e042    	add	x2, x2, #0xcb8
1097b7b38: 9009bf83    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
1097b7b3c: 9130e063    	add	x3, x3, #0xc38
1097b7b40: 9582a02a    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7b44: aa1d03fd    	mov	x29, x29
1097b7b48: 9582a031    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7b4c: aa0003f8    	mov	x24, x0
1097b7b50: 900a90a8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1097b7b54: f9477901    	ldr	x1, [x8, #0xef0]
1097b7b58: aa1603e0    	mov	x0, x22
1097b7b5c: aa1803e2    	mov	x2, x24
1097b7b60: 9582a022    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7b64: f00a90c8    	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
1097b7b68: f9473901    	ldr	x1, [x8, #0xe70]
1097b7b6c: aa1503e0    	mov	x0, x21
1097b7b70: 9582a01e    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7b74: aa1d03fd    	mov	x29, x29
1097b7b78: 9582a025    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7b7c: aa0003f5    	mov	x21, x0
1097b7b80: f8796a60    	ldr	x0, [x19, x25]
1097b7b84: 900aa7a8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
1097b7b88: f9450501    	ldr	x1, [x8, #0xa08]
1097b7b8c: aa1503e2    	mov	x2, x21
1097b7b90: 9582a016    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7b94: aa1503e0    	mov	x0, x21
1097b7b98: 9582a018    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7b9c: aa1803e0    	mov	x0, x24
1097b7ba0: 9582a016    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7ba4: aa1703e0    	mov	x0, x23
1097b7ba8: 9582a014    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7bac: aa1403e0    	mov	x0, x20
1097b7bb0: 9582a012    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7bb4: f00aaad7    	adrp	x23, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1097b7bb8: f9440af4    	ldr	x20, [x23, #0x810]
1097b7bbc: d00aa7a8    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1097b7bc0: f947c115    	ldr	x21, [x8, #0xf80]
1097b7bc4: aa1403e0    	mov	x0, x20
1097b7bc8: aa1503e1    	mov	x1, x21
1097b7bcc: 9582a007    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7bd0: aa1d03fd    	mov	x29, x29
1097b7bd4: 9582a00e    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7bd8: aa0003f6    	mov	x22, x0
1097b7bdc: f9440ae0    	ldr	x0, [x23, #0x810]
1097b7be0: aa1503e1    	mov	x1, x21
1097b7be4: 9582a001    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7be8: aa1d03fd    	mov	x29, x29
1097b7bec: 9582a008    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7bf0: aa0003f5    	mov	x21, x0
1097b7bf4: b00a90c8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
1097b7bf8: f940e501    	ldr	x1, [x8, #0x1c8]
1097b7bfc: 95829ffb    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7c00: aa1d03fd    	mov	x29, x29
1097b7c04: 9582a002    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7c08: aa0003f7    	mov	x23, x0
1097b7c0c: 900a90a8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1097b7c10: f9479501    	ldr	x1, [x8, #0xf28]
1097b7c14: aa1403e0    	mov	x0, x20
1097b7c18: aa1603e2    	mov	x2, x22
1097b7c1c: aa1703e3    	mov	x3, x23
1097b7c20: 95829ff2    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7c24: aa1d03fd    	mov	x29, x29
1097b7c28: 95829ff9    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7c2c: aa0003f4    	mov	x20, x0
1097b7c30: f8796a60    	ldr	x0, [x19, x25]
1097b7c34: b00aa7a8    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
1097b7c38: f9457501    	ldr	x1, [x8, #0xae8]
1097b7c3c: aa1403e2    	mov	x2, x20
1097b7c40: 95829fea    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7c44: aa1403e0    	mov	x0, x20
1097b7c48: 95829fec    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7c4c: aa1703e0    	mov	x0, x23
1097b7c50: 95829fea    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7c54: aa1503e0    	mov	x0, x21
1097b7c58: 95829fe8    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7c5c: aa1603e0    	mov	x0, x22
1097b7c60: 95829fe6    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7c64: f8796a60    	ldr	x0, [x19, x25]
1097b7c68: b00aa7a8    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
1097b7c6c: f9413d01    	ldr	x1, [x8, #0x278]
1097b7c70: 52800022    	mov	w2, #0x1                ; =1
1097b7c74: 95829fdd    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7c78: f00a90a8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1097b7c7c: f941c114    	ldr	x20, [x8, #0x380]
1097b7c80: aa1303e0    	mov	x0, x19
1097b7c84: aa1403e1    	mov	x1, x20
1097b7c88: 95829fd8    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7c8c: aa1d03fd    	mov	x29, x29
1097b7c90: 95829fdf    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7c94: aa0003f6    	mov	x22, x0
1097b7c98: f00a90a8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1097b7c9c: f941ad15    	ldr	x21, [x8, #0x358]
1097b7ca0: aa1503e1    	mov	x1, x21
1097b7ca4: 95829fd1    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7ca8: aa1d03fd    	mov	x29, x29
1097b7cac: 95829fd8    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7cb0: aa0003f7    	mov	x23, x0
1097b7cb4: b00aa788    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1097b7cb8: f943dd01    	ldr	x1, [x8, #0x7b8]
1097b7cbc: 9009ea82    	adrp	x2, 0x11d507000 <dyld_stub_binder+0x11d507000>
1097b7cc0: 9118e042    	add	x2, x2, #0x638
1097b7cc4: 95829fc9    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7cc8: aa0003f8    	mov	x24, x0
1097b7ccc: aa1703e0    	mov	x0, x23
1097b7cd0: 95829fca    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7cd4: aa1603e0    	mov	x0, x22
1097b7cd8: 95829fc8    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7cdc: 36000078    	tbz	w24, #0x0, 0x1097b7ce8 <_Flutter_MMFoundation_BindContext+0x5a3e9b4>
1097b7ce0: 52800022    	mov	w2, #0x1                ; =1
1097b7ce4: 14000006    	b	0x1097b7cfc <_Flutter_MMFoundation_BindContext+0x5a3e9c8>
1097b7ce8: b00aa308    	adrp	x8, 0x11ec18000 <dyld_stub_binder+0x11ec18000>
1097b7cec: f940b101    	ldr	x1, [x8, #0x160]
1097b7cf0: aa1303e0    	mov	x0, x19
1097b7cf4: 95829fbd    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7cf8: aa0003e2    	mov	x2, x0
1097b7cfc: f8796a60    	ldr	x0, [x19, x25]
1097b7d00: f00aa788    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
1097b7d04: f946bd01    	ldr	x1, [x8, #0xd78]
1097b7d08: 95829fb8    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7d0c: aa1303e0    	mov	x0, x19
1097b7d10: aa1403e1    	mov	x1, x20
1097b7d14: 95829fb5    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7d18: aa1d03fd    	mov	x29, x29
1097b7d1c: 95829fbc    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7d20: aa0003f4    	mov	x20, x0
1097b7d24: aa1503e1    	mov	x1, x21
1097b7d28: 95829fb0    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7d2c: aa1d03fd    	mov	x29, x29
1097b7d30: 95829fb7    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7d34: aa0003f5    	mov	x21, x0
1097b7d38: f8796a60    	ldr	x0, [x19, x25]
1097b7d3c: b00aa7a8    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
1097b7d40: f9456d01    	ldr	x1, [x8, #0xad8]
1097b7d44: aa1503e2    	mov	x2, x21
1097b7d48: 95829fa8    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7d4c: aa1503e0    	mov	x0, x21
1097b7d50: 95829faa    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7d54: aa1403e0    	mov	x0, x20
1097b7d58: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1097b7d5c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1097b7d60: a94257f6    	ldp	x22, x21, [sp, #0x20]
1097b7d64: a9415ff8    	ldp	x24, x23, [sp, #0x10]
1097b7d68: a8c567fa    	ldp	x26, x25, [sp], #0x50
1097b7d6c: 15829fa3    	b	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
