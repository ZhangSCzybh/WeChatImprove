
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ba1b9c: d101c3ff    	sub	sp, sp, #0x70
104ba1ba0: a9016ffc    	stp	x28, x27, [sp, #0x10]
104ba1ba4: a90267fa    	stp	x26, x25, [sp, #0x20]
104ba1ba8: a9035ff8    	stp	x24, x23, [sp, #0x30]
104ba1bac: a90457f6    	stp	x22, x21, [sp, #0x40]
104ba1bb0: a9054ff4    	stp	x20, x19, [sp, #0x50]
104ba1bb4: a9067bfd    	stp	x29, x30, [sp, #0x60]
104ba1bb8: 910183fd    	add	x29, sp, #0x60
104ba1bbc: aa0003f3    	mov	x19, x0
104ba1bc0: b00e04e8    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104ba1bc4: 52800029    	mov	w9, #0x1                ; =1
104ba1bc8: 391a5d09    	strb	w9, [x8, #0x697]
104ba1bcc: f00db408    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104ba1bd0: b982651a    	ldrsw	x26, [x8, #0x264]
104ba1bd4: f87a6802    	ldr	x2, [x0, x26]
104ba1bd8: f00db41b    	adrp	x27, 0x120224000 <dyld_stub_binder+0x120224000>
104ba1bdc: b40001e2    	cbz	x2, 0x104ba1c18 <_Flutter_MMFoundation_BindContext+0x107d7fc>
104ba1be0: b9829368    	ldrsw	x8, [x27, #0x290]
104ba1be4: f8686a60    	ldr	x0, [x19, x8]
104ba1be8: d00dab08    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104ba1bec: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
104ba1bf0: 94c21553    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1bf4: 36000120    	tbz	w0, #0x0, 0x104ba1c18 <_Flutter_MMFoundation_BindContext+0x107d7fc>
104ba1bf8: a9467bfd    	ldp	x29, x30, [sp, #0x60]
104ba1bfc: a9454ff4    	ldp	x20, x19, [sp, #0x50]
104ba1c00: a94457f6    	ldp	x22, x21, [sp, #0x40]
104ba1c04: a9435ff8    	ldp	x24, x23, [sp, #0x30]
104ba1c08: a94267fa    	ldp	x26, x25, [sp, #0x20]
104ba1c0c: a9416ffc    	ldp	x28, x27, [sp, #0x10]
104ba1c10: 9101c3ff    	add	sp, sp, #0x70
104ba1c14: d65f03c0    	ret
104ba1c18: f00db408    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104ba1c1c: b982ad16    	ldrsw	x22, [x8, #0x2ac]
104ba1c20: f8766a60    	ldr	x0, [x19, x22]
104ba1c24: d00d94e8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104ba1c28: f9465514    	ldr	x20, [x8, #0xca8] ; ChangeForDisplay
104ba1c2c: b00dab28    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104ba1c30: f9436115    	ldr	x21, [x8, #0x6c0] ; respondsToSelector:
104ba1c34: aa1503e1    	mov	x1, x21
104ba1c38: aa1403e2    	mov	x2, x20
104ba1c3c: 94c21540    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1c40: 34000080    	cbz	w0, 0x104ba1c50 <_Flutter_MMFoundation_BindContext+0x107d834>
104ba1c44: f8766a60    	ldr	x0, [x19, x22]
104ba1c48: aa1403e1    	mov	x1, x20
104ba1c4c: 94c2153c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1c50: f00db408    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104ba1c54: b982a516    	ldrsw	x22, [x8, #0x2a4]
104ba1c58: f8766a60    	ldr	x0, [x19, x22]
104ba1c5c: aa1503e1    	mov	x1, x21
104ba1c60: aa1403e2    	mov	x2, x20
104ba1c64: 94c21536    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1c68: 35000940    	cbnz	w0, 0x104ba1d90 <_Flutter_MMFoundation_BindContext+0x107d974>
104ba1c6c: f00dae99    	adrp	x25, 0x120174000 <dyld_stub_binder+0x120174000>
104ba1c70: f9400337    	ldr	x23, [x25]
104ba1c74: 900d94e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104ba1c78: f9429d18    	ldr	x24, [x8, #0x538] ; m_nsFromUsr
104ba1c7c: aa1303e0    	mov	x0, x19
104ba1c80: aa1803e1    	mov	x1, x24
104ba1c84: 94c2152e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1c88: aa1d03fd    	mov	x29, x29
104ba1c8c: 94c2152f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba1c90: aa0003f6    	mov	x22, x0
104ba1c94: f00d94e8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104ba1c98: f946c901    	ldr	x1, [x8, #0xd90] ; IsChatRoom:
104ba1c9c: aa1703e0    	mov	x0, x23
104ba1ca0: aa1603e2    	mov	x2, x22
104ba1ca4: 94c21526    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1ca8: 36000260    	tbz	w0, #0x0, 0x104ba1cf4 <_Flutter_MMFoundation_BindContext+0x107d8d8>
104ba1cac: b00d94e8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104ba1cb0: f9413d17    	ldr	x23, [x8, #0x278] ; m_uiMessageType
104ba1cb4: aa1303e0    	mov	x0, x19
104ba1cb8: aa1703e1    	mov	x1, x23
104ba1cbc: 94c21520    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1cc0: 5284e208    	mov	w8, #0x2710             ; =10000
104ba1cc4: 6b08001f    	cmp	w0, w8
104ba1cc8: 54000520    	b.eq	0x104ba1d6c <_Flutter_MMFoundation_BindContext+0x107d950>
104ba1ccc: aa1303e0    	mov	x0, x19
104ba1cd0: aa1703e1    	mov	x1, x23
104ba1cd4: 94c2151a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1cd8: aa0003f7    	mov	x23, x0
104ba1cdc: aa1603e0    	mov	x0, x22
104ba1ce0: 94c2151d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba1ce4: 5284e248    	mov	w8, #0x2712             ; =10002
104ba1ce8: 6b0802ff    	cmp	w23, w8
104ba1cec: 54000440    	b.eq	0x104ba1d74 <_Flutter_MMFoundation_BindContext+0x107d958>
104ba1cf0: 140000aa    	b	0x104ba1f98 <_Flutter_MMFoundation_BindContext+0x107db7c>
104ba1cf4: aa0003f7    	mov	x23, x0
104ba1cf8: f9400339    	ldr	x25, [x25]
104ba1cfc: aa1303e0    	mov	x0, x19
104ba1d00: aa1803e1    	mov	x1, x24
104ba1d04: 94c2150e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1d08: aa1d03fd    	mov	x29, x29
104ba1d0c: 94c2150f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba1d10: aa0003f8    	mov	x24, x0
104ba1d14: d00d9548    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104ba1d18: f942d101    	ldr	x1, [x8, #0x5a0] ; IsLbsRoom:
104ba1d1c: aa1903e0    	mov	x0, x25
104ba1d20: aa1803e2    	mov	x2, x24
104ba1d24: 94c21506    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1d28: 370000c0    	tbnz	w0, #0x0, 0x104ba1d40 <_Flutter_MMFoundation_BindContext+0x107d924>
104ba1d2c: b00d9548    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104ba1d30: f9466d01    	ldr	x1, [x8, #0xcd8] ; IsInviteShareMessage
104ba1d34: aa1303e0    	mov	x0, x19
104ba1d38: 94c21501    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1d3c: 34000140    	cbz	w0, 0x104ba1d64 <_Flutter_MMFoundation_BindContext+0x107d948>
104ba1d40: b00d94e8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104ba1d44: f9413d19    	ldr	x25, [x8, #0x278] ; m_uiMessageType
104ba1d48: aa1303e0    	mov	x0, x19
104ba1d4c: aa1903e1    	mov	x1, x25
104ba1d50: 94c214fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1d54: 5284e208    	mov	w8, #0x2710             ; =10000
104ba1d58: 6b08001f    	cmp	w0, w8
104ba1d5c: 54001061    	b.ne	0x104ba1f68 <_Flutter_MMFoundation_BindContext+0x107db4c>
104ba1d60: 37000077    	tbnz	w23, #0x0, 0x104ba1d6c <_Flutter_MMFoundation_BindContext+0x107d950>
104ba1d64: aa1803e0    	mov	x0, x24
104ba1d68: 94c214fb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba1d6c: aa1603e0    	mov	x0, x22
104ba1d70: 94c214f9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba1d74: f00db408    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104ba1d78: b982a916    	ldrsw	x22, [x8, #0x2a8]
104ba1d7c: f8766a60    	ldr	x0, [x19, x22]
104ba1d80: aa1503e1    	mov	x1, x21
104ba1d84: aa1403e2    	mov	x2, x20
104ba1d88: 94c214ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1d8c: 340006a0    	cbz	w0, 0x104ba1e60 <_Flutter_MMFoundation_BindContext+0x107da44>
104ba1d90: f8766a60    	ldr	x0, [x19, x22]
104ba1d94: aa1403e1    	mov	x1, x20
104ba1d98: 94c214e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1d9c: d00d94e8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104ba1da0: f941e914    	ldr	x20, [x8, #0x3d0] ; m_nsRealChatUsr
104ba1da4: aa1303e0    	mov	x0, x19
104ba1da8: aa1403e1    	mov	x1, x20
104ba1dac: 94c214e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1db0: aa1d03fd    	mov	x29, x29
104ba1db4: 94c214e5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba1db8: aa0003f6    	mov	x22, x0
104ba1dbc: d00dab08    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104ba1dc0: f946e915    	ldr	x21, [x8, #0xdd0] ; length
104ba1dc4: aa1503e1    	mov	x1, x21
104ba1dc8: 94c214dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1dcc: b5000b40    	cbnz	x0, 0x104ba1f34 <_Flutter_MMFoundation_BindContext+0x107db18>
104ba1dd0: f00dae9c    	adrp	x28, 0x120174000 <dyld_stub_binder+0x120174000>
104ba1dd4: f9400399    	ldr	x25, [x28]
104ba1dd8: 900d94e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104ba1ddc: f9429d18    	ldr	x24, [x8, #0x538] ; m_nsFromUsr
104ba1de0: aa1303e0    	mov	x0, x19
104ba1de4: aa1803e1    	mov	x1, x24
104ba1de8: 94c214d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1dec: aa1d03fd    	mov	x29, x29
104ba1df0: 94c214d6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba1df4: aa0003f7    	mov	x23, x0
104ba1df8: f00d94e8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104ba1dfc: f946c901    	ldr	x1, [x8, #0xd90] ; IsChatRoom:
104ba1e00: aa1903e0    	mov	x0, x25
104ba1e04: aa1703e2    	mov	x2, x23
104ba1e08: 94c214cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1e0c: 36000620    	tbz	w0, #0x0, 0x104ba1ed0 <_Flutter_MMFoundation_BindContext+0x107dab4>
104ba1e10: b00d94e8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104ba1e14: f9413d18    	ldr	x24, [x8, #0x278] ; m_uiMessageType
104ba1e18: aa1303e0    	mov	x0, x19
104ba1e1c: aa1803e1    	mov	x1, x24
104ba1e20: 94c214c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1e24: 5284e208    	mov	w8, #0x2710             ; =10000
104ba1e28: 6b08001f    	cmp	w0, w8
104ba1e2c: 54000800    	b.eq	0x104ba1f2c <_Flutter_MMFoundation_BindContext+0x107db10>
104ba1e30: aa1303e0    	mov	x0, x19
104ba1e34: aa1803e1    	mov	x1, x24
104ba1e38: 94c214c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1e3c: aa0003f8    	mov	x24, x0
104ba1e40: aa1703e0    	mov	x0, x23
104ba1e44: 94c214c4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba1e48: aa1603e0    	mov	x0, x22
104ba1e4c: 94c214c2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba1e50: 5284e248    	mov	w8, #0x2712             ; =10002
104ba1e54: 6b08031f    	cmp	w24, w8
104ba1e58: 54000720    	b.eq	0x104ba1f3c <_Flutter_MMFoundation_BindContext+0x107db20>
104ba1e5c: 14000069    	b	0x104ba2000 <_Flutter_MMFoundation_BindContext+0x107dbe4>
104ba1e60: 900d98e8    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
104ba1e64: f9418101    	ldr	x1, [x8, #0x300] ; m_ignoreSoftBank
104ba1e68: aa1303e0    	mov	x0, x19
104ba1e6c: 94c214b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1e70: 3707f960    	tbnz	w0, #0x0, 0x104ba1d9c <_Flutter_MMFoundation_BindContext+0x107d980>
104ba1e74: b00d94e8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104ba1e78: f9417101    	ldr	x1, [x8, #0x2e0] ; m_nsContent
104ba1e7c: aa1303e0    	mov	x0, x19
104ba1e80: 94c214af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1e84: aa1d03fd    	mov	x29, x29
104ba1e88: 94c214b0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba1e8c: aa0003f4    	mov	x20, x0
104ba1e90: 900d9728    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
104ba1e94: f9461101    	ldr	x1, [x8, #0xc20] ; emojiUnifiedString
104ba1e98: 94c214a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1e9c: aa1d03fd    	mov	x29, x29
104ba1ea0: 94c214aa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba1ea4: aa0003f5    	mov	x21, x0
104ba1ea8: f00d94c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104ba1eac: f9453d01    	ldr	x1, [x8, #0xa78] ; setM_nsContent:
104ba1eb0: aa1303e0    	mov	x0, x19
104ba1eb4: aa1503e2    	mov	x2, x21
104ba1eb8: 94c214a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1ebc: aa1503e0    	mov	x0, x21
104ba1ec0: 94c214a5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba1ec4: aa1403e0    	mov	x0, x20
104ba1ec8: 94c214a3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba1ecc: 17ffffb4    	b	0x104ba1d9c <_Flutter_MMFoundation_BindContext+0x107d980>
104ba1ed0: f9400399    	ldr	x25, [x28]
104ba1ed4: aa1303e0    	mov	x0, x19
104ba1ed8: aa1803e1    	mov	x1, x24
104ba1edc: 94c21498    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1ee0: aa1d03fd    	mov	x29, x29
104ba1ee4: 94c21499    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba1ee8: aa0003f8    	mov	x24, x0
104ba1eec: d00d9548    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104ba1ef0: f942d101    	ldr	x1, [x8, #0x5a0] ; IsLbsRoom:
104ba1ef4: aa1903e0    	mov	x0, x25
104ba1ef8: aa1803e2    	mov	x2, x24
104ba1efc: 94c21490    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1f00: 36000120    	tbz	w0, #0x0, 0x104ba1f24 <_Flutter_MMFoundation_BindContext+0x107db08>
104ba1f04: b00d94e8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104ba1f08: f9413d19    	ldr	x25, [x8, #0x278] ; m_uiMessageType
104ba1f0c: aa1303e0    	mov	x0, x19
104ba1f10: aa1903e1    	mov	x1, x25
104ba1f14: 94c2148a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1f18: 5284e208    	mov	w8, #0x2710             ; =10000
104ba1f1c: 6b08001f    	cmp	w0, w8
104ba1f20: 54000561    	b.ne	0x104ba1fcc <_Flutter_MMFoundation_BindContext+0x107dbb0>
104ba1f24: aa1803e0    	mov	x0, x24
104ba1f28: 94c2148b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba1f2c: aa1703e0    	mov	x0, x23
104ba1f30: 94c21489    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba1f34: aa1603e0    	mov	x0, x22
104ba1f38: 94c21487    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba1f3c: f87a6a61    	ldr	x1, [x19, x26]
104ba1f40: b9829368    	ldrsw	x8, [x27, #0x290]
104ba1f44: 8b080260    	add	x0, x19, x8
104ba1f48: a9467bfd    	ldp	x29, x30, [sp, #0x60]
104ba1f4c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
104ba1f50: a94457f6    	ldp	x22, x21, [sp, #0x40]
104ba1f54: a9435ff8    	ldp	x24, x23, [sp, #0x30]
104ba1f58: a94267fa    	ldp	x26, x25, [sp, #0x20]
104ba1f5c: a9416ffc    	ldp	x28, x27, [sp, #0x10]
104ba1f60: 9101c3ff    	add	sp, sp, #0x70
104ba1f64: 14c21477    	b	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
104ba1f68: aa1303e0    	mov	x0, x19
104ba1f6c: aa1903e1    	mov	x1, x25
104ba1f70: 94c21473    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1f74: aa0003f9    	mov	x25, x0
104ba1f78: 37000077    	tbnz	w23, #0x0, 0x104ba1f84 <_Flutter_MMFoundation_BindContext+0x107db68>
104ba1f7c: aa1803e0    	mov	x0, x24
104ba1f80: 94c21475    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba1f84: aa1603e0    	mov	x0, x22
104ba1f88: 94c21473    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba1f8c: 5284e248    	mov	w8, #0x2712             ; =10002
104ba1f90: 6b08033f    	cmp	w25, w8
104ba1f94: 54ffef00    	b.eq	0x104ba1d74 <_Flutter_MMFoundation_BindContext+0x107d958>
104ba1f98: d00d94e8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104ba1f9c: f9419901    	ldr	x1, [x8, #0x330] ; referHostMsg
104ba1fa0: aa1303e0    	mov	x0, x19
104ba1fa4: 94c21466    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1fa8: aa1d03fd    	mov	x29, x29
104ba1fac: 94c21467    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba1fb0: aa0003f4    	mov	x20, x0
104ba1fb4: 94c21468    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba1fb8: b5ffef34    	cbnz	x20, 0x104ba1d9c <_Flutter_MMFoundation_BindContext+0x107d980>
104ba1fbc: d00d9f28    	adrp	x8, 0x11ff87000 <dyld_stub_binder+0x11ff87000>
104ba1fc0: f9468d01    	ldr	x1, [x8, #0xd18] ; ChangeForChatRoom
104ba1fc4: aa1303e0    	mov	x0, x19
104ba1fc8: 17ffff74    	b	0x104ba1d98 <_Flutter_MMFoundation_BindContext+0x107d97c>
104ba1fcc: aa1303e0    	mov	x0, x19
104ba1fd0: aa1903e1    	mov	x1, x25
104ba1fd4: 94c2145a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba1fd8: aa0003f9    	mov	x25, x0
104ba1fdc: aa1803e0    	mov	x0, x24
104ba1fe0: 94c2145d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba1fe4: aa1703e0    	mov	x0, x23
104ba1fe8: 94c2145b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba1fec: aa1603e0    	mov	x0, x22
104ba1ff0: 94c21459    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba1ff4: 5284e248    	mov	w8, #0x2712             ; =10002
104ba1ff8: 6b08033f    	cmp	w25, w8
104ba1ffc: 54fffa00    	b.eq	0x104ba1f3c <_Flutter_MMFoundation_BindContext+0x107db20>
104ba2000: f87a6a60    	ldr	x0, [x19, x26]
104ba2004: f00dab08    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
104ba2008: f9466116    	ldr	x22, [x8, #0xcc0] ; rangeOfString:
104ba200c: 900cc8c2    	adrp	x2, 0x11e4ba000 <dyld_stub_binder+0x11e4ba000>
104ba2010: 9136a042    	add	x2, x2, #0xda8 ; CFString ':\n'
104ba2014: aa1603e1    	mov	x1, x22
104ba2018: 94c21449    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba201c: 92f00017    	mov	x23, #0x7fffffffffffffff ; =9223372036854775807
104ba2020: eb17001f    	cmp	x0, x23
104ba2024: 54000101    	b.ne	0x104ba2044 <_Flutter_MMFoundation_BindContext+0x107dc28>
104ba2028: f87a6a60    	ldr	x0, [x19, x26]
104ba202c: 900cc842    	adrp	x2, 0x11e4aa000 <dyld_stub_binder+0x11e4aa000>
104ba2030: 91032042    	add	x2, x2, #0xc8 ; CFString ':'
104ba2034: aa1603e1    	mov	x1, x22
104ba2038: 94c21441    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba203c: eb17001f    	cmp	x0, x23
104ba2040: 54000200    	b.eq	0x104ba2080 <_Flutter_MMFoundation_BindContext+0x107dc64>
104ba2044: aa0003e2    	mov	x2, x0
104ba2048: f87a6a60    	ldr	x0, [x19, x26]
104ba204c: 900dab48    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104ba2050: f9473101    	ldr	x1, [x8, #0xe60] ; substringToIndex:
104ba2054: 94c2143a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba2058: aa1d03fd    	mov	x29, x29
104ba205c: 94c2143b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba2060: aa0003f6    	mov	x22, x0
104ba2064: 900d9528    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
104ba2068: f9446501    	ldr	x1, [x8, #0x8c8] ; setM_nsRealChatUsr:
104ba206c: aa1303e0    	mov	x0, x19
104ba2070: aa1603e2    	mov	x2, x22
104ba2074: 94c21432    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba2078: aa1603e0    	mov	x0, x22
104ba207c: 94c21436    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba2080: aa1303e0    	mov	x0, x19
104ba2084: aa1403e1    	mov	x1, x20
104ba2088: 94c2142d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba208c: aa1d03fd    	mov	x29, x29
104ba2090: 94c2142e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba2094: aa0003f4    	mov	x20, x0
104ba2098: aa1503e1    	mov	x1, x21
104ba209c: 94c21428    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba20a0: aa0003f5    	mov	x21, x0
104ba20a4: aa1403e0    	mov	x0, x20
104ba20a8: 94c2142b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba20ac: b5fff495    	cbnz	x21, 0x104ba1f3c <_Flutter_MMFoundation_BindContext+0x107db20>
104ba20b0: b00dae88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104ba20b4: f9453500    	ldr	x0, [x8, #0xa68] ; iConsole
104ba20b8: f00d94a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104ba20bc: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104ba20c0: f00ce028    	adrp	x8, 0x11e7a9000 <dyld_stub_binder+0x11e7a9000>
104ba20c4: 9137a108    	add	x8, x8, #0xde8 ; CFString 'missing RealChatUsr'
104ba20c8: f90003e8    	str	x8, [sp]
104ba20cc: 900b6325    	adrp	x5, 0x11b806000 <dyld_stub_binder+0x11b806000>
104ba20d0: 9123a0a5    	add	x5, x5, #0x8e8
104ba20d4: b00b6327    	adrp	x7, 0x11b807000 <dyld_stub_binder+0x11b807000>
104ba20d8: 91011ce7    	add	x7, x7, #0x47
104ba20dc: 52800082    	mov	w2, #0x4                ; =4
104ba20e0: d2800003    	mov	x3, #0x0                ; =0
104ba20e4: 52800004    	mov	w4, #0x0                ; =0
104ba20e8: 5280c5a6    	mov	w6, #0x62d              ; =1581
104ba20ec: 94c21414    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba20f0: 17ffff93    	b	0x104ba1f3c <_Flutter_MMFoundation_BindContext+0x107db20>
