
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002a4bd4: d10703ff    	sub	sp, sp, #0x1c0
1002a4bd8: 6d142beb    	stp	d11, d10, [sp, #0x140]
1002a4bdc: 6d1523e9    	stp	d9, d8, [sp, #0x150]
1002a4be0: a9166ffc    	stp	x28, x27, [sp, #0x160]
1002a4be4: a91767fa    	stp	x26, x25, [sp, #0x170]
1002a4be8: a9185ff8    	stp	x24, x23, [sp, #0x180]
1002a4bec: a91957f6    	stp	x22, x21, [sp, #0x190]
1002a4bf0: a91a4ff4    	stp	x20, x19, [sp, #0x1a0]
1002a4bf4: a91b7bfd    	stp	x29, x30, [sp, #0x1b0]
1002a4bf8: 9106c3fd    	add	x29, sp, #0x1b0
1002a4bfc: aa0003f7    	mov	x23, x0
1002a4c00: f00e9a48    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1002a4c04: f9405908    	ldr	x8, [x8, #0xb0]
1002a4c08: f9400108    	ldr	x8, [x8]
1002a4c0c: f81803a8    	stur	x8, [x29, #-0x80]
1002a4c10: b0104c48    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
1002a4c14: 52800029    	mov	w9, #0x1                ; =1
1002a4c18: 39311909    	strb	w9, [x8, #0xc46]
1002a4c1c: d00fdcc8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002a4c20: f9410916    	ldr	x22, [x8, #0x210] ; viewModel
1002a4c24: aa1603e1    	mov	x1, x22
1002a4c28: 95e60945    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4c2c: aa1d03fd    	mov	x29, x29
1002a4c30: 95e60946    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4c34: aa0003f3    	mov	x19, x0
1002a4c38: d00fdcc8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002a4c3c: f9410518    	ldr	x24, [x8, #0x208] ; messageWrap
1002a4c40: aa1803e1    	mov	x1, x24
1002a4c44: 95e6093e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4c48: aa1d03fd    	mov	x29, x29
1002a4c4c: 95e6093f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4c50: aa0003f4    	mov	x20, x0
1002a4c54: f00ff2c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002a4c58: f947ad19    	ldr	x25, [x8, #0xf58] ; class
1002a4c5c: aa1903e1    	mov	x1, x25
1002a4c60: 95e60937    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4c64: d00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a4c68: f9425101    	ldr	x1, [x8, #0x4a0] ; isPreViewMsg
1002a4c6c: 95e60934    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4c70: aa0003f5    	mov	x21, x0
1002a4c74: aa1403e0    	mov	x0, x20
1002a4c78: 95e60937    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4c7c: aa1303e0    	mov	x0, x19
1002a4c80: 95e60935    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4c84: 37003535    	tbnz	w21, #0x0, 0x1002a5328 <__text+0x29d328>
1002a4c88: aa1703e0    	mov	x0, x23
1002a4c8c: aa1603e1    	mov	x1, x22
1002a4c90: 95e6092b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4c94: aa1d03fd    	mov	x29, x29
1002a4c98: 95e6092c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4c9c: aa0003f3    	mov	x19, x0
1002a4ca0: 900ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a4ca4: f946f101    	ldr	x1, [x8, #0xde0] ; delegate
1002a4ca8: 95e60925    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4cac: aa1d03fd    	mov	x29, x29
1002a4cb0: 95e60926    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4cb4: aa0003f4    	mov	x20, x0
1002a4cb8: d00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a4cbc: f9425501    	ldr	x1, [x8, #0x4a8] ; canShowOperationMenu
1002a4cc0: 95e6091f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4cc4: aa0003f5    	mov	x21, x0
1002a4cc8: aa1403e0    	mov	x0, x20
1002a4ccc: 95e60922    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4cd0: aa1303e0    	mov	x0, x19
1002a4cd4: 95e60920    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4cd8: 34003295    	cbz	w21, 0x1002a5328 <__text+0x29d328>
1002a4cdc: f90017f6    	str	x22, [sp, #0x28]
1002a4ce0: d00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a4ce4: f9425901    	ldr	x1, [x8, #0x4b0] ; generateOperationMenu
1002a4ce8: aa1703e0    	mov	x0, x23
1002a4cec: 95e60914    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4cf0: aa1d03fd    	mov	x29, x29
1002a4cf4: 95e60915    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4cf8: aa0003f3    	mov	x19, x0
1002a4cfc: d00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a4d00: f9425d01    	ldr	x1, [x8, #0x4b8] ; uniqMenuItems:
1002a4d04: aa1703e0    	mov	x0, x23
1002a4d08: aa1303e2    	mov	x2, x19
1002a4d0c: 95e6090c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4d10: aa1d03fd    	mov	x29, x29
1002a4d14: 95e6090d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4d18: aa0003f4    	mov	x20, x0
1002a4d1c: aa1303e0    	mov	x0, x19
1002a4d20: 95e6090d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4d24: d00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a4d28: f9426101    	ldr	x1, [x8, #0x4c0] ; filteredMenuItems:
1002a4d2c: aa1703e0    	mov	x0, x23
1002a4d30: aa1403e2    	mov	x2, x20
1002a4d34: 95e60902    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4d38: aa1d03fd    	mov	x29, x29
1002a4d3c: 95e60903    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4d40: aa0003f3    	mov	x19, x0
1002a4d44: aa1403e0    	mov	x0, x20
1002a4d48: 95e60903    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4d4c: d00ff694    	adrp	x20, 0x120176000 <dyld_stub_binder+0x120176000>
1002a4d50: f940d280    	ldr	x0, [x20, #0x1a0] ; ��9 
1002a4d54: d00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a4d58: f9426501    	ldr	x1, [x8, #0x4c8] ; pinAskXiaoWeiMenuItemToEnd:
1002a4d5c: aa1303e2    	mov	x2, x19
1002a4d60: 95e608f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4d64: aa1d03fd    	mov	x29, x29
1002a4d68: 95e608f8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4d6c: aa0003f5    	mov	x21, x0
1002a4d70: aa1303e0    	mov	x0, x19
1002a4d74: 95e608f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4d78: f940d280    	ldr	x0, [x20, #0x1a0] ; ��9 
1002a4d7c: d00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a4d80: f9426901    	ldr	x1, [x8, #0x4d0] ; adjustCustomMenuItems:
1002a4d84: f90013f5    	str	x21, [sp, #0x20]
1002a4d88: aa1503e2    	mov	x2, x21
1002a4d8c: 95e608ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4d90: aa1d03fd    	mov	x29, x29
1002a4d94: 95e608ed    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4d98: f00ff9c8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
1002a4d9c: 910ab108    	add	x8, x8, #0x2ac
1002a4da0: b980011a    	ldrsw	x26, [x8]
1002a4da4: f87a6ae8    	ldr	x8, [x23, x26]
1002a4da8: f83a6ae0    	str	x0, [x23, x26]
1002a4dac: aa0803e0    	mov	x0, x8
1002a4db0: 95e608e9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4db4: f87a6ae0    	ldr	x0, [x23, x26]
1002a4db8: 900ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a4dbc: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1002a4dc0: 95e608df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4dc4: b5000920    	cbnz	x0, 0x1002a4ee8 <__text+0x29cee8>
1002a4dc8: 900ff688    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1002a4dcc: f9452900    	ldr	x0, [x8, #0xa50]
1002a4dd0: 95e608e2    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1002a4dd4: aa0003f6    	mov	x22, x0
1002a4dd8: f00ff668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a4ddc: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
1002a4de0: 900ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a4de4: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1002a4de8: 95e608d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4dec: aa1d03fd    	mov	x29, x29
1002a4df0: 95e608d6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4df4: aa0003f3    	mov	x19, x0
1002a4df8: f00ff668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a4dfc: f9462900    	ldr	x0, [x8, #0xc50]
1002a4e00: aa1903e1    	mov	x1, x25
1002a4e04: 95e608ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4e08: aa0003e2    	mov	x2, x0
1002a4e0c: b00fdca8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1002a4e10: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
1002a4e14: aa1303e0    	mov	x0, x19
1002a4e18: 95e608c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4e1c: aa1d03fd    	mov	x29, x29
1002a4e20: 95e608ca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4e24: aa0003f4    	mov	x20, x0
1002a4e28: b00fdca8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1002a4e2c: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
1002a4e30: f00f10a2    	adrp	x2, 0x11e4bb000 <dyld_stub_binder+0x11e4bb000>
1002a4e34: 912da042    	add	x2, x2, #0xb68
1002a4e38: 95e608c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4e3c: aa1d03fd    	mov	x29, x29
1002a4e40: 95e608c2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4e44: aa0003f5    	mov	x21, x0
1002a4e48: b00ff328    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1002a4e4c: f9472101    	ldr	x1, [x8, #0xe40] ; setTitle:
1002a4e50: aa1603e0    	mov	x0, x22
1002a4e54: aa1503e2    	mov	x2, x21
1002a4e58: 95e608b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4e5c: aa1503e0    	mov	x0, x21
1002a4e60: 95e608bd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4e64: aa1403e0    	mov	x0, x20
1002a4e68: 95e608bb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4e6c: aa1303e0    	mov	x0, x19
1002a4e70: 95e608b9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4e74: f00ff668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a4e78: f9462d00    	ldr	x0, [x8, #0xc58]
1002a4e7c: d00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a4e80: f9426d01    	ldr	x1, [x8, #0x4d8] ; Glyph_White_1
1002a4e84: 95e608ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4e88: aa1d03fd    	mov	x29, x29
1002a4e8c: 95e608af    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4e90: aa0003f3    	mov	x19, x0
1002a4e94: 900fdcc8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1002a4e98: f9415501    	ldr	x1, [x8, #0x2a8] ; setTitleColor:
1002a4e9c: aa1603e0    	mov	x0, x22
1002a4ea0: aa1303e2    	mov	x2, x19
1002a4ea4: 95e608a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4ea8: aa1303e0    	mov	x0, x19
1002a4eac: 95e608aa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4eb0: f00ff668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a4eb4: f9456d00    	ldr	x0, [x8, #0xad8]
1002a4eb8: f00ff2c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002a4ebc: f941bd01    	ldr	x1, [x8, #0x378] ; arrayWithObject:
1002a4ec0: aa1603e2    	mov	x2, x22
1002a4ec4: 95e6089e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4ec8: aa1d03fd    	mov	x29, x29
1002a4ecc: 95e6089f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4ed0: f87a6ae8    	ldr	x8, [x23, x26]
1002a4ed4: f83a6ae0    	str	x0, [x23, x26]
1002a4ed8: aa0803e0    	mov	x0, x8
1002a4edc: 95e6089e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4ee0: aa1603e0    	mov	x0, x22
1002a4ee4: 95e6089c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4ee8: a90167fa    	stp	x26, x25, [sp, #0x10]
1002a4eec: a90363f7    	stp	x23, x24, [sp, #0x30]
1002a4ef0: 4f00e400    	movi.16b	v0, #0x0
1002a4ef4: ad0403e0    	stp	q0, q0, [sp, #0x80]
1002a4ef8: ad0303e0    	stp	q0, q0, [sp, #0x60]
1002a4efc: f87a6ae0    	ldr	x0, [x23, x26]
1002a4f00: 95e6088e    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1002a4f04: 900ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a4f08: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1002a4f0c: 910183e2    	add	x2, sp, #0x60
1002a4f10: 9102c3e3    	add	x3, sp, #0xb0
1002a4f14: a90403e1    	stp	x1, x0, [sp, #0x40]
1002a4f18: 52800204    	mov	w4, #0x10               ; =16
1002a4f1c: 95e60888    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4f20: b4000980    	cbz	x0, 0x1002a5050 <__text+0x29d050>
1002a4f24: aa0003fb    	mov	x27, x0
1002a4f28: f9403be8    	ldr	x8, [sp, #0x70]
1002a4f2c: f9400108    	ldr	x8, [x8]
1002a4f30: f9002fe8    	str	x8, [sp, #0x58]
1002a4f34: f00f0fba    	adrp	x26, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1002a4f38: 9103235a    	add	x26, x26, #0xc8
1002a4f3c: d2800014    	mov	x20, #0x0               ; =0
1002a4f40: f00ff2e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1002a4f44: f946e916    	ldr	x22, [x8, #0xdd0] ; length
1002a4f48: f00fdcc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002a4f4c: f9436515    	ldr	x21, [x8, #0x6c8] ; menuType
1002a4f50: b00fdca8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1002a4f54: f942d117    	ldr	x23, [x8, #0x5a0] ; stringWithUInt64:
1002a4f58: d00ff328    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1002a4f5c: f946a508    	ldr	x8, [x8, #0xd48] ; stringWithFormat:
1002a4f60: f9002be8    	str	x8, [sp, #0x50]
1002a4f64: f9403be8    	ldr	x8, [sp, #0x70]
1002a4f68: f9400108    	ldr	x8, [x8]
1002a4f6c: f9402fe9    	ldr	x9, [sp, #0x58]
1002a4f70: eb09011f    	cmp	x8, x9
1002a4f74: 54000060    	b.eq	0x1002a4f80 <__text+0x29cf80>
1002a4f78: f94027e0    	ldr	x0, [sp, #0x48]
1002a4f7c: 95e60875    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1002a4f80: f94037e8    	ldr	x8, [sp, #0x68]
1002a4f84: f8747913    	ldr	x19, [x8, x20, lsl #3]
1002a4f88: aa1303e0    	mov	x0, x19
1002a4f8c: 95e6086b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1002a4f90: aa1a03e0    	mov	x0, x26
1002a4f94: aa1603e1    	mov	x1, x22
1002a4f98: 95e60869    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4f9c: aa0003f9    	mov	x25, x0
1002a4fa0: f00ff668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a4fa4: f945451c    	ldr	x28, [x8, #0xa88]
1002a4fa8: aa1303e0    	mov	x0, x19
1002a4fac: aa1503e1    	mov	x1, x21
1002a4fb0: 95e60863    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4fb4: aa0003e2    	mov	x2, x0
1002a4fb8: aa1c03e0    	mov	x0, x28
1002a4fbc: aa1703e1    	mov	x1, x23
1002a4fc0: 95e6085f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4fc4: aa1d03fd    	mov	x29, x29
1002a4fc8: 95e60860    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4fcc: aa0003f8    	mov	x24, x0
1002a4fd0: b4000219    	cbz	x25, 0x1002a5010 <__text+0x29d010>
1002a4fd4: a90063fa    	stp	x26, x24, [sp]
1002a4fd8: aa1c03e0    	mov	x0, x28
1002a4fdc: f9402be1    	ldr	x1, [sp, #0x50]
1002a4fe0: f00f10a2    	adrp	x2, 0x11e4bb000 <dyld_stub_binder+0x11e4bb000>
1002a4fe4: 912e2042    	add	x2, x2, #0xb88
1002a4fe8: 95e60855    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4fec: aa1d03fd    	mov	x29, x29
1002a4ff0: 95e60856    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4ff4: aa0003f9    	mov	x25, x0
1002a4ff8: aa1a03e0    	mov	x0, x26
1002a4ffc: 95e60856    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a5000: aa1303e0    	mov	x0, x19
1002a5004: aa1803f3    	mov	x19, x24
1002a5008: aa1903fa    	mov	x26, x25
1002a500c: 14000003    	b	0x1002a5018 <__text+0x29d018>
1002a5010: aa1a03e0    	mov	x0, x26
1002a5014: aa1803fa    	mov	x26, x24
1002a5018: 95e6084f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a501c: aa1303e0    	mov	x0, x19
1002a5020: 95e6084d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a5024: 91000694    	add	x20, x20, #0x1
1002a5028: eb14037f    	cmp	x27, x20
1002a502c: 54fff9c1    	b.ne	0x1002a4f64 <__text+0x29cf64>
1002a5030: 910183e2    	add	x2, sp, #0x60
1002a5034: 9102c3e3    	add	x3, sp, #0xb0
1002a5038: a94403e1    	ldp	x1, x0, [sp, #0x40]
1002a503c: 52800204    	mov	w4, #0x10               ; =16
1002a5040: 95e6083f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a5044: aa0003fb    	mov	x27, x0
1002a5048: b5fff7a0    	cbnz	x0, 0x1002a4f3c <__text+0x29cf3c>
1002a504c: 14000003    	b	0x1002a5058 <__text+0x29d058>
1002a5050: d00f0fba    	adrp	x26, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1002a5054: 9103235a    	add	x26, x26, #0xc8
1002a5058: f94027e0    	ldr	x0, [sp, #0x48]
1002a505c: 95e6083e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a5060: d00ff9c8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
1002a5064: 91086108    	add	x8, x8, #0x218
1002a5068: b9800117    	ldrsw	x23, [x8]
1002a506c: f9401bf8    	ldr	x24, [sp, #0x30]
1002a5070: 8b170300    	add	x0, x24, x23
1002a5074: 95e60846    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1002a5078: f94017fb    	ldr	x27, [sp, #0x28]
1002a507c: b4000580    	cbz	x0, 0x1002a512c <__text+0x29d12c>
1002a5080: aa0003f4    	mov	x20, x0
1002a5084: 8b170300    	add	x0, x24, x23
1002a5088: 95e60841    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1002a508c: aa0003f5    	mov	x21, x0
1002a5090: b00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a5094: f9427113    	ldr	x19, [x8, #0x4e0] ; willShowMenuController:inMsgWrap:menuSourceType:buttonList:
1002a5098: b00ff308    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1002a509c: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
1002a50a0: aa1303e2    	mov	x2, x19
1002a50a4: 95e60826    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a50a8: aa0003f6    	mov	x22, x0
1002a50ac: aa1503e0    	mov	x0, x21
1002a50b0: 95e60829    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a50b4: aa1403e0    	mov	x0, x20
1002a50b8: 95e60827    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a50bc: 34000396    	cbz	w22, 0x1002a512c <__text+0x29d12c>
1002a50c0: 8b170300    	add	x0, x24, x23
1002a50c4: 95e60832    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1002a50c8: aa0003f4    	mov	x20, x0
1002a50cc: aa1803e0    	mov	x0, x24
1002a50d0: aa1b03e1    	mov	x1, x27
1002a50d4: 95e6081a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a50d8: aa1d03fd    	mov	x29, x29
1002a50dc: 95e6081b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a50e0: aa0003f5    	mov	x21, x0
1002a50e4: f9401fe1    	ldr	x1, [sp, #0x38]
1002a50e8: 95e60815    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a50ec: aa1d03fd    	mov	x29, x29
1002a50f0: 95e60816    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a50f4: aa0003f6    	mov	x22, x0
1002a50f8: aa1403e0    	mov	x0, x20
1002a50fc: aa1303e1    	mov	x1, x19
1002a5100: aa1803e2    	mov	x2, x24
1002a5104: aa1603e3    	mov	x3, x22
1002a5108: 52800004    	mov	w4, #0x0                ; =0
1002a510c: aa1a03e5    	mov	x5, x26
1002a5110: 95e6080b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a5114: aa1603e0    	mov	x0, x22
1002a5118: 95e6080f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a511c: aa1503e0    	mov	x0, x21
1002a5120: 95e6080d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a5124: aa1403e0    	mov	x0, x20
1002a5128: 95e6080b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a512c: d00ff2c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002a5130: f9432901    	ldr	x1, [x8, #0x650] ; becomeFirstResponder
1002a5134: aa1803e0    	mov	x0, x24
1002a5138: 95e60801    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a513c: b00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a5140: f9427501    	ldr	x1, [x8, #0x4e8] ; targetRectForMenuController
1002a5144: aa1803e0    	mov	x0, x24
1002a5148: 95e607fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a514c: 1e604008    	fmov	d8, d0
1002a5150: 1e604029    	fmov	d9, d1
1002a5154: 1e60404a    	fmov	d10, d2
1002a5158: 1e60406b    	fmov	d11, d3
1002a515c: b00ff688    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
1002a5160: f940bd00    	ldr	x0, [x8, #0x178]
1002a5164: f9400fe1    	ldr	x1, [sp, #0x18]
1002a5168: 95e607f5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a516c: aa0003e2    	mov	x2, x0
1002a5170: b00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a5174: f9419101    	ldr	x1, [x8, #0x320] ; ancestorOrSelfWithClass:
1002a5178: aa1803e0    	mov	x0, x24
1002a517c: 95e607f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a5180: aa1d03fd    	mov	x29, x29
1002a5184: 95e607f1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a5188: aa0003f7    	mov	x23, x0
1002a518c: b00ff688    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
1002a5190: f940d500    	ldr	x0, [x8, #0x1a8]
1002a5194: b00ff328    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1002a5198: f9438501    	ldr	x1, [x8, #0x708] ; sharedMenuController
1002a519c: 95e607e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a51a0: aa1d03fd    	mov	x29, x29
1002a51a4: 95e607e9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a51a8: aa0003f9    	mov	x25, x0
1002a51ac: b00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a51b0: f9427901    	ldr	x1, [x8, #0x4f0] ; setTargetRect:inView:
1002a51b4: 1e604100    	fmov	d0, d8
1002a51b8: 1e604121    	fmov	d1, d9
1002a51bc: 1e604142    	fmov	d2, d10
1002a51c0: 1e604163    	fmov	d3, d11
1002a51c4: aa1703e2    	mov	x2, x23
1002a51c8: 95e607dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a51cc: f9400be8    	ldr	x8, [sp, #0x10]
1002a51d0: f8686b02    	ldr	x2, [x24, x8]
1002a51d4: b00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a51d8: f9427d01    	ldr	x1, [x8, #0x4f8] ; setMenuItems:
1002a51dc: aa1903e0    	mov	x0, x25
1002a51e0: 95e607d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a51e4: 900ff328    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1002a51e8: f943fd01    	ldr	x1, [x8, #0x7f8] ; setScene:
1002a51ec: aa1903e0    	mov	x0, x25
1002a51f0: 52800022    	mov	w2, #0x1                ; =1
1002a51f4: 95e607d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a51f8: d00f10a8    	adrp	x8, 0x11e4bb000 <dyld_stub_binder+0x11e4bb000>
1002a51fc: 912ea108    	add	x8, x8, #0xba8
1002a5200: f90053e8    	str	x8, [sp, #0xa0]
1002a5204: aa1803e0    	mov	x0, x24
1002a5208: aa1b03e1    	mov	x1, x27
1002a520c: 95e607cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a5210: aa1d03fd    	mov	x29, x29
1002a5214: 95e607cd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a5218: aa0003f3    	mov	x19, x0
1002a521c: f9401fe1    	ldr	x1, [sp, #0x38]
1002a5220: 95e607c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a5224: aa1d03fd    	mov	x29, x29
1002a5228: 95e607c8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a522c: aa0003f4    	mov	x20, x0
1002a5230: f90057e0    	str	x0, [sp, #0xa8]
1002a5234: d00ff668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a5238: f9457500    	ldr	x0, [x8, #0xae8]
1002a523c: 900ff2e8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
1002a5240: f9402901    	ldr	x1, [x8, #0x50] ; dictionaryWithObjects:forKeys:count:
1002a5244: 9102a3e2    	add	x2, sp, #0xa8
1002a5248: 910283e3    	add	x3, sp, #0xa0
1002a524c: 52800024    	mov	w4, #0x1                ; =1
1002a5250: 95e607bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a5254: aa1d03fd    	mov	x29, x29
1002a5258: 95e607bc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a525c: aa0003f5    	mov	x21, x0
1002a5260: b00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a5264: f9428101    	ldr	x1, [x8, #0x500] ; setMenuExtraInfo:
1002a5268: aa1903e0    	mov	x0, x25
1002a526c: aa1503e2    	mov	x2, x21
1002a5270: 95e607b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a5274: aa1503e0    	mov	x0, x21
1002a5278: 95e607b7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a527c: aa1403e0    	mov	x0, x20
1002a5280: 95e607b5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a5284: aa1303e0    	mov	x0, x19
1002a5288: 95e607b3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a528c: b00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a5290: f9428501    	ldr	x1, [x8, #0x508] ; setMenuVisible:responder:animated:
1002a5294: aa1903e0    	mov	x0, x25
1002a5298: 52800022    	mov	w2, #0x1                ; =1
1002a529c: aa1803e3    	mov	x3, x24
1002a52a0: 52800024    	mov	w4, #0x1                ; =1
1002a52a4: 95e607a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a52a8: d00ff668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a52ac: f9458d00    	ldr	x0, [x8, #0xb18]
1002a52b0: f00ff2c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a52b4: f946b101    	ldr	x1, [x8, #0xd60] ; defaultCenter
1002a52b8: 95e607a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a52bc: aa1d03fd    	mov	x29, x29
1002a52c0: 95e607a2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a52c4: aa0003f3    	mov	x19, x0
1002a52c8: b00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a52cc: f9428903    	ldr	x3, [x8, #0x510] ; handleMenuControllerWillHideMenuNotification:
1002a52d0: 900f06e8    	adrp	x8, 0x11e381000 <dyld_stub_binder+0x11e381000>
1002a52d4: 91040108    	add	x8, x8, #0x100
1002a52d8: f9400104    	ldr	x4, [x8]
1002a52dc: b00ff2c8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1002a52e0: f9470101    	ldr	x1, [x8, #0xe00] ; addObserver:selector:name:object:
1002a52e4: aa1803e2    	mov	x2, x24
1002a52e8: d2800005    	mov	x5, #0x0                ; =0
1002a52ec: 95e60794    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a52f0: aa1303e0    	mov	x0, x19
1002a52f4: 95e60798    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a52f8: d00fdcc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002a52fc: f9436101    	ldr	x1, [x8, #0x6c0] ; onShowOperationMenu
1002a5300: aa1803e0    	mov	x0, x24
1002a5304: 95e6078e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a5308: aa1903e0    	mov	x0, x25
1002a530c: 95e60792    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a5310: aa1703e0    	mov	x0, x23
1002a5314: 95e60790    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a5318: aa1a03e0    	mov	x0, x26
1002a531c: 95e6078e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a5320: f94013e0    	ldr	x0, [sp, #0x20]
1002a5324: 95e6078c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a5328: f85803a8    	ldur	x8, [x29, #-0x80]
1002a532c: d00e9a49    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1002a5330: f9405929    	ldr	x9, [x9, #0xb0]
1002a5334: f9400129    	ldr	x9, [x9]
1002a5338: eb08013f    	cmp	x9, x8
1002a533c: 54000161    	b.ne	0x1002a5368 <__text+0x29d368>
1002a5340: a95b7bfd    	ldp	x29, x30, [sp, #0x1b0]
1002a5344: a95a4ff4    	ldp	x20, x19, [sp, #0x1a0]
1002a5348: a95957f6    	ldp	x22, x21, [sp, #0x190]
1002a534c: a9585ff8    	ldp	x24, x23, [sp, #0x180]
1002a5350: a95767fa    	ldp	x26, x25, [sp, #0x170]
1002a5354: a9566ffc    	ldp	x28, x27, [sp, #0x160]
1002a5358: 6d5523e9    	ldp	d9, d8, [sp, #0x150]
1002a535c: 6d542beb    	ldp	d11, d10, [sp, #0x140]
1002a5360: 910703ff    	add	sp, sp, #0x1c0
1002a5364: d65f03c0    	ret
1002a5368: 95e60783    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>