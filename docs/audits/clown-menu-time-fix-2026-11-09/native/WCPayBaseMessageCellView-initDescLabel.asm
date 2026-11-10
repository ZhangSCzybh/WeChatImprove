
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
1097b7d70: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
1097b7d74: a9015ff8    	stp	x24, x23, [sp, #0x10]
1097b7d78: a90257f6    	stp	x22, x21, [sp, #0x20]
1097b7d7c: a9034ff4    	stp	x20, x19, [sp, #0x30]
1097b7d80: a9047bfd    	stp	x29, x30, [sp, #0x40]
1097b7d84: 910103fd    	add	x29, sp, #0x40
1097b7d88: aa0003f3    	mov	x19, x0
1097b7d8c: f00afd48    	adrp	x8, 0x11f762000 <dyld_stub_binder+0x11f762000>
1097b7d90: 52800029    	mov	w9, #0x1                ; =1
1097b7d94: 391fb909    	strb	w9, [x8, #0x7ee]
1097b7d98: f00ab288    	adrp	x8, 0x11ee0a000 <dyld_stub_binder+0x11ee0a000>
1097b7d9c: b98afd19    	ldrsw	x25, [x8, #0xafc]
1097b7da0: f8796808    	ldr	x8, [x0, x25]
1097b7da4: b5000f88    	cbnz	x8, 0x1097b7f94 <_Flutter_MMFoundation_BindContext+0x5a3ec60>
1097b7da8: f00aaac8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1097b7dac: f943fd00    	ldr	x0, [x8, #0x7f8]
1097b7db0: 95829f74    	bl	0x10f85fb80 <_GetBoxIamBizTLRecFeedsDataUtil+0xdec64>
1097b7db4: f009fc88    	adrp	x8, 0x11d74a000 <dyld_stub_binder+0x11d74a000>
1097b7db8: f9465508    	ldr	x8, [x8, #0xca8]
1097b7dbc: 6d400500    	ldp	d0, d1, [x8]
1097b7dc0: 6d410d02    	ldp	d2, d3, [x8, #0x10]
1097b7dc4: b00aa788    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1097b7dc8: f9418501    	ldr	x1, [x8, #0x308]
1097b7dcc: 95829f87    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7dd0: f8796a68    	ldr	x8, [x19, x25]
1097b7dd4: f8396a60    	str	x0, [x19, x25]
1097b7dd8: aa0803e0    	mov	x0, x8
1097b7ddc: 95829f87    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7de0: f00aaac8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1097b7de4: f943f115    	ldr	x21, [x8, #0x7e0]
1097b7de8: f00aaac8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1097b7dec: f9461d16    	ldr	x22, [x8, #0xc38]
1097b7df0: f00aaac8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1097b7df4: f943c100    	ldr	x0, [x8, #0x780]
1097b7df8: d00a9088    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1097b7dfc: f9440101    	ldr	x1, [x8, #0x800]
1097b7e00: 95829f7a    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7e04: aa1d03fd    	mov	x29, x29
1097b7e08: 95829f81    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7e0c: aa0003f4    	mov	x20, x0
1097b7e10: f00aaac8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1097b7e14: f9462100    	ldr	x0, [x8, #0xc40]
1097b7e18: f00aa768    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1097b7e1c: f9428501    	ldr	x1, [x8, #0x508]
1097b7e20: 95829f72    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7e24: aa0003e2    	mov	x2, x0
1097b7e28: d00a9088    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1097b7e2c: f9452101    	ldr	x1, [x8, #0xa40]
1097b7e30: aa1403e0    	mov	x0, x20
1097b7e34: 95829f6d    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7e38: aa1d03fd    	mov	x29, x29
1097b7e3c: 95829f74    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7e40: aa0003f7    	mov	x23, x0
1097b7e44: 900a90a8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1097b7e48: f9477501    	ldr	x1, [x8, #0xee8]
1097b7e4c: 9009bf82    	adrp	x2, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
1097b7e50: 91336042    	add	x2, x2, #0xcd8
1097b7e54: 9009bf83    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
1097b7e58: 9130e063    	add	x3, x3, #0xc38
1097b7e5c: 95829f63    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7e60: aa1d03fd    	mov	x29, x29
1097b7e64: 95829f6a    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7e68: aa0003f8    	mov	x24, x0
1097b7e6c: 900a90a8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1097b7e70: f9477901    	ldr	x1, [x8, #0xef0]
1097b7e74: aa1603e0    	mov	x0, x22
1097b7e78: aa1803e2    	mov	x2, x24
1097b7e7c: 95829f5b    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7e80: d00aa7a8    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1097b7e84: f9436901    	ldr	x1, [x8, #0x6d0]
1097b7e88: aa1503e0    	mov	x0, x21
1097b7e8c: 95829f57    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7e90: aa1d03fd    	mov	x29, x29
1097b7e94: 95829f5e    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7e98: aa0003f5    	mov	x21, x0
1097b7e9c: f8796a60    	ldr	x0, [x19, x25]
1097b7ea0: 900aa7a8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
1097b7ea4: f9450501    	ldr	x1, [x8, #0xa08]
1097b7ea8: aa1503e2    	mov	x2, x21
1097b7eac: 95829f4f    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7eb0: aa1503e0    	mov	x0, x21
1097b7eb4: 95829f51    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7eb8: aa1803e0    	mov	x0, x24
1097b7ebc: 95829f4f    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7ec0: aa1703e0    	mov	x0, x23
1097b7ec4: 95829f4d    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7ec8: aa1403e0    	mov	x0, x20
1097b7ecc: 95829f4b    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7ed0: f00aaad7    	adrp	x23, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1097b7ed4: f9440af4    	ldr	x20, [x23, #0x810]
1097b7ed8: d00aa7a8    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1097b7edc: f947c115    	ldr	x21, [x8, #0xf80]
1097b7ee0: aa1403e0    	mov	x0, x20
1097b7ee4: aa1503e1    	mov	x1, x21
1097b7ee8: 95829f40    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7eec: aa1d03fd    	mov	x29, x29
1097b7ef0: 95829f47    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7ef4: aa0003f6    	mov	x22, x0
1097b7ef8: f9440ae0    	ldr	x0, [x23, #0x810]
1097b7efc: aa1503e1    	mov	x1, x21
1097b7f00: 95829f3a    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7f04: aa1d03fd    	mov	x29, x29
1097b7f08: 95829f41    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7f0c: aa0003f5    	mov	x21, x0
1097b7f10: b00a90c8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
1097b7f14: f940e501    	ldr	x1, [x8, #0x1c8]
1097b7f18: 95829f34    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7f1c: aa1d03fd    	mov	x29, x29
1097b7f20: 95829f3b    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7f24: aa0003f7    	mov	x23, x0
1097b7f28: 900a90a8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1097b7f2c: f9479501    	ldr	x1, [x8, #0xf28]
1097b7f30: aa1403e0    	mov	x0, x20
1097b7f34: aa1603e2    	mov	x2, x22
1097b7f38: aa1703e3    	mov	x3, x23
1097b7f3c: 95829f2b    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7f40: aa1d03fd    	mov	x29, x29
1097b7f44: 95829f32    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7f48: aa0003f4    	mov	x20, x0
1097b7f4c: f8796a60    	ldr	x0, [x19, x25]
1097b7f50: b00aa7a8    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
1097b7f54: f9457501    	ldr	x1, [x8, #0xae8]
1097b7f58: aa1403e2    	mov	x2, x20
1097b7f5c: 95829f23    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7f60: aa1403e0    	mov	x0, x20
1097b7f64: 95829f25    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7f68: aa1703e0    	mov	x0, x23
1097b7f6c: 95829f23    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7f70: aa1503e0    	mov	x0, x21
1097b7f74: 95829f21    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7f78: aa1603e0    	mov	x0, x22
1097b7f7c: 95829f1f    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7f80: f8796a60    	ldr	x0, [x19, x25]
1097b7f84: b00aa7a8    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
1097b7f88: f9413d01    	ldr	x1, [x8, #0x278]
1097b7f8c: 52800022    	mov	w2, #0x1                ; =1
1097b7f90: 95829f16    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7f94: f00a90a8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1097b7f98: f941c101    	ldr	x1, [x8, #0x380]
1097b7f9c: aa1303e0    	mov	x0, x19
1097b7fa0: 95829f12    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7fa4: aa1d03fd    	mov	x29, x29
1097b7fa8: 95829f19    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7fac: aa0003f4    	mov	x20, x0
1097b7fb0: b00a9248    	adrp	x8, 0x11ea00000 <dyld_stub_binder+0x11ea00000>
1097b7fb4: f9461901    	ldr	x1, [x8, #0xc30]
1097b7fb8: 95829f0c    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7fbc: aa1d03fd    	mov	x29, x29
1097b7fc0: 95829f13    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
1097b7fc4: aa0003f5    	mov	x21, x0
1097b7fc8: f8796a60    	ldr	x0, [x19, x25]
1097b7fcc: b00aa7a8    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
1097b7fd0: f9456d01    	ldr	x1, [x8, #0xad8]
1097b7fd4: aa1503e2    	mov	x2, x21
1097b7fd8: 95829f04    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
1097b7fdc: aa1503e0    	mov	x0, x21
1097b7fe0: 95829f06    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
1097b7fe4: aa1403e0    	mov	x0, x20
1097b7fe8: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1097b7fec: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1097b7ff0: a94257f6    	ldp	x22, x21, [sp, #0x20]
1097b7ff4: a9415ff8    	ldp	x24, x23, [sp, #0x10]
1097b7ff8: a8c567fa    	ldp	x26, x25, [sp], #0x50
1097b7ffc: 15829eff    	b	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
