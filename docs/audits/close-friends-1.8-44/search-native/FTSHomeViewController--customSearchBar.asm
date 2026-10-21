
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101762aec: d103c3ff    	sub	sp, sp, #0xf0
101762af0: 6d0823e9    	stp	d9, d8, [sp, #0x80]
101762af4: a9096ffc    	stp	x28, x27, [sp, #0x90]
101762af8: a90a67fa    	stp	x26, x25, [sp, #0xa0]
101762afc: a90b5ff8    	stp	x24, x23, [sp, #0xb0]
101762b00: a90c57f6    	stp	x22, x21, [sp, #0xc0]
101762b04: a90d4ff4    	stp	x20, x19, [sp, #0xd0]
101762b08: a90e7bfd    	stp	x29, x30, [sp, #0xe0]
101762b0c: 910383fd    	add	x29, sp, #0xe0
101762b10: aa0003f4    	mov	x20, x0
101762b14: 900fa688    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
101762b18: 52800029    	mov	w9, #0x1                ; =1
101762b1c: 39229909    	strb	w9, [x8, #0x8a6]
101762b20: b00f50e8    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
101762b24: f9427100    	ldr	x0, [x8, #0x4e0]
101762b28: d00f4d08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101762b2c: f9461d01    	ldr	x1, [x8, #0xc38] ; new
101762b30: 95931183    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762b34: aa0003f3    	mov	x19, x0
101762b38: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762b3c: f940b915    	ldr	x21, [x8, #0x170] ; focusTexfieldWhenFirstShow
101762b40: aa1403e0    	mov	x0, x20
101762b44: aa1503e1    	mov	x1, x21
101762b48: 9593117d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762b4c: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762b50: f940bd01    	ldr	x1, [x8, #0x178] ; setSuppressAutoFocus:
101762b54: 52000002    	eor	w2, w0, #0x1
101762b58: aa1303e0    	mov	x0, x19
101762b5c: 95931178    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762b60: b00f5088    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101762b64: f9453516    	ldr	x22, [x8, #0xa68]
101762b68: aa1403e0    	mov	x0, x20
101762b6c: aa1503e1    	mov	x1, x21
101762b70: 95931173    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762b74: d00e69d5    	adrp	x21, 0x11e49c000 <dyld_stub_binder+0x11e49c000>
101762b78: 910022b5    	add	x21, x21, #0x8
101762b7c: b00e69d7    	adrp	x23, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
101762b80: 913fa2f7    	add	x23, x23, #0xfe8
101762b84: 7100001f    	cmp	w0, #0x0
101762b88: 9a9512f8    	csel	x24, x23, x21, ne
101762b8c: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762b90: f940c101    	ldr	x1, [x8, #0x180] ; suppressAutoFocus
101762b94: aa1303e0    	mov	x0, x19
101762b98: 95931169    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762b9c: 7100001f    	cmp	w0, #0x0
101762ba0: 9a9512e8    	csel	x8, x23, x21, ne
101762ba4: f00f36a9    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101762ba8: f942a921    	ldr	x1, [x9, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
101762bac: a900a3f8    	stp	x24, x8, [sp, #0x8]
101762bb0: 900e7188    	adrp	x8, 0x11e592000 <dyld_stub_binder+0x11e592000>
101762bb4: 913c2108    	add	x8, x8, #0xf08
101762bb8: f90003e8    	str	x8, [sp]
101762bbc: b00ce405    	adrp	x5, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
101762bc0: 911b74a5    	add	x5, x5, #0x6dd
101762bc4: b00ce407    	adrp	x7, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
101762bc8: 9129a8e7    	add	x7, x7, #0xa6a
101762bcc: aa1603e0    	mov	x0, x22
101762bd0: f90013e1    	str	x1, [sp, #0x20]
101762bd4: 52800042    	mov	w2, #0x2                ; =2
101762bd8: d2800003    	mov	x3, #0x0                ; =0
101762bdc: 52800004    	mov	w4, #0x0                ; =0
101762be0: 52805006    	mov	w6, #0x280              ; =640
101762be4: 95931156    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762be8: b00f5095    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
101762bec: f9475aa0    	ldr	x0, [x21, #0xeb0]
101762bf0: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762bf4: f940c501    	ldr	x1, [x8, #0x188] ; getWebSearchStyle
101762bf8: f9000fe1    	str	x1, [sp, #0x18]
101762bfc: 95931150    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762c00: f00f3a36    	adrp	x22, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762c04: 7100041f    	cmp	w0, #0x1
101762c08: 5400078b    	b.lt	0x101762cf8 <__text+0x175acf8>
101762c0c: b00f5088    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101762c10: f9461900    	ldr	x0, [x8, #0xc30]
101762c14: f00f36a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101762c18: f9463101    	ldr	x1, [x8, #0xc60] ; dynamicLength:
101762c1c: d2e809a8    	mov	x8, #0x404d000000000000 ; =4633359591634108416
101762c20: 9e670100    	fmov	d0, x8
101762c24: 95931146    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762c28: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762c2c: f940c901    	ldr	x1, [x8, #0x190] ; setExpectedHeight:
101762c30: aa1303e0    	mov	x0, x19
101762c34: 95931142    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762c38: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762c3c: f940cd01    	ldr	x1, [x8, #0x198] ; setEnableLargeInput:
101762c40: aa1303e0    	mov	x0, x19
101762c44: 52800022    	mov	w2, #0x1                ; =1
101762c48: 9593113d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762c4c: f940d2d7    	ldr	x23, [x22, #0x1a0] ; globalSearchInputConfig
101762c50: aa1403e0    	mov	x0, x20
101762c54: aa1703e1    	mov	x1, x23
101762c58: 95931139    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762c5c: aa1d03fd    	mov	x29, x29
101762c60: 9593113a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101762c64: aa0003f8    	mov	x24, x0
101762c68: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762c6c: f940d501    	ldr	x1, [x8, #0x1a8] ; checkBoxes
101762c70: 95931133    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762c74: aa1d03fd    	mov	x29, x29
101762c78: 95931134    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101762c7c: aa0003f9    	mov	x25, x0
101762c80: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762c84: f940d901    	ldr	x1, [x8, #0x1b0] ; setCheckBoxes:
101762c88: aa1303e0    	mov	x0, x19
101762c8c: aa1903e2    	mov	x2, x25
101762c90: 9593112b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762c94: aa1903e0    	mov	x0, x25
101762c98: 9593112f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101762c9c: aa1803e0    	mov	x0, x24
101762ca0: 9593112d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101762ca4: aa1403e0    	mov	x0, x20
101762ca8: aa1703e1    	mov	x1, x23
101762cac: 95931124    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762cb0: aa1d03fd    	mov	x29, x29
101762cb4: 95931125    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101762cb8: aa0003f7    	mov	x23, x0
101762cbc: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762cc0: f940dd01    	ldr	x1, [x8, #0x1b8] ; actionButtons
101762cc4: 9593111e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762cc8: aa1d03fd    	mov	x29, x29
101762ccc: 9593111f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101762cd0: aa0003f8    	mov	x24, x0
101762cd4: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762cd8: f940e101    	ldr	x1, [x8, #0x1c0] ; setActionButtons:
101762cdc: aa1303e0    	mov	x0, x19
101762ce0: aa1803e2    	mov	x2, x24
101762ce4: 95931116    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762ce8: aa1803e0    	mov	x0, x24
101762cec: 9593111a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101762cf0: aa1703e0    	mov	x0, x23
101762cf4: 95931118    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101762cf8: f9475aa0    	ldr	x0, [x21, #0xeb0]
101762cfc: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762d00: f940e501    	ldr	x1, [x8, #0x1c8] ; isRemoveEditingWords
101762d04: 9593110e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762d08: 340000c0    	cbz	w0, 0x101762d20 <__text+0x175ad20>
101762d0c: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762d10: f940e901    	ldr	x1, [x8, #0x1d0] ; setEnableRemoveEditingWords:
101762d14: aa1303e0    	mov	x0, x19
101762d18: 52800022    	mov	w2, #0x1                ; =1
101762d1c: 95931108    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762d20: b00f50e8    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
101762d24: f9427500    	ldr	x0, [x8, #0x4e8]
101762d28: 9593110e    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
101762d2c: 900f4d08    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
101762d30: f9475501    	ldr	x1, [x8, #0xea8] ; initWithConfig:
101762d34: aa1303e2    	mov	x2, x19
101762d38: 95931101    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762d3c: aa0003f7    	mov	x23, x0
101762d40: b00f5088    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101762d44: f945e900    	ldr	x0, [x8, #0xbd0]
101762d48: d00f4ce8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101762d4c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
101762d50: 959310fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762d54: aa1d03fd    	mov	x29, x29
101762d58: 959310fc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101762d5c: aa0003f8    	mov	x24, x0
101762d60: d00f5088    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
101762d64: f9404100    	ldr	x0, [x8, #0x80]
101762d68: b00f4ce8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101762d6c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
101762d70: 959310f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762d74: aa0003e2    	mov	x2, x0
101762d78: f00f36a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101762d7c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
101762d80: aa1803e0    	mov	x0, x24
101762d84: 959310ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762d88: aa1d03fd    	mov	x29, x29
101762d8c: 959310ef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101762d90: aa0003f9    	mov	x25, x0
101762d94: b00f5095    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
101762d98: f9458aa0    	ldr	x0, [x21, #0xb10]
101762d9c: d00f4d08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101762da0: f947a51b    	ldr	x27, [x8, #0xf48] ; numberWithInt:
101762da4: aa1b03e1    	mov	x1, x27
101762da8: 52800062    	mov	w2, #0x3                ; =3
101762dac: 959310e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762db0: aa1d03fd    	mov	x29, x29
101762db4: 959310e5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101762db8: aa0003fa    	mov	x26, x0
101762dbc: d00f3768    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
101762dc0: f941911c    	ldr	x28, [x8, #0x320] ; A
101762dc4: aa1c03e1    	mov	x1, x28
101762dc8: 959310dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762dcc: 1e604008    	fmov	d8, d0
101762dd0: f9458aa0    	ldr	x0, [x21, #0xb10]
101762dd4: aa1b03e1    	mov	x1, x27
101762dd8: 52800062    	mov	w2, #0x3                ; =3
101762ddc: 959310d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762de0: aa1d03fd    	mov	x29, x29
101762de4: 959310d9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101762de8: aa0003fb    	mov	x27, x0
101762dec: aa1c03e1    	mov	x1, x28
101762df0: 959310d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762df4: 1e604009    	fmov	d9, d0
101762df8: b00f5096    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
101762dfc: f9462ec0    	ldr	x0, [x22, #0xc58]
101762e00: 900f36e8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
101762e04: f9465101    	ldr	x1, [x8, #0xca0] ; FG_2
101762e08: 959310cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762e0c: aa1d03fd    	mov	x29, x29
101762e10: 959310ce    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101762e14: aa0003fc    	mov	x28, x0
101762e18: d00f36c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101762e1c: f9437901    	ldr	x1, [x8, #0x6f0] ; svgImageNamed:size:color:
101762e20: b00e6ae2    	adrp	x2, 0x11e4bf000 <dyld_stub_binder+0x11e4bf000>
101762e24: 9105a042    	add	x2, x2, #0x168
101762e28: aa1903e0    	mov	x0, x25
101762e2c: 1e604100    	fmov	d0, d8
101762e30: 1e604121    	fmov	d1, d9
101762e34: aa1c03e3    	mov	x3, x28
101762e38: 959310c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762e3c: aa1d03fd    	mov	x29, x29
101762e40: 959310c2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101762e44: aa0003f5    	mov	x21, x0
101762e48: 900f3908    	adrp	x8, 0x11fe82000 <dyld_stub_binder+0x11fe82000>
101762e4c: f942a501    	ldr	x1, [x8, #0x548] ; setLeftIconImage:
101762e50: aa1703e0    	mov	x0, x23
101762e54: aa1503e2    	mov	x2, x21
101762e58: 959310b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762e5c: aa1503e0    	mov	x0, x21
101762e60: 959310bd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101762e64: aa1c03e0    	mov	x0, x28
101762e68: 959310bb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101762e6c: aa1b03e0    	mov	x0, x27
101762e70: 959310b9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101762e74: aa1a03e0    	mov	x0, x26
101762e78: 959310b7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101762e7c: aa1903e0    	mov	x0, x25
101762e80: 959310b5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101762e84: aa1803e0    	mov	x0, x24
101762e88: 959310b3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101762e8c: b00f4d28    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
101762e90: f942c101    	ldr	x1, [x8, #0x580] ; setClearButtonMode:
101762e94: aa1703e0    	mov	x0, x23
101762e98: 52800042    	mov	w2, #0x2                ; =2
101762e9c: 959310a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762ea0: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762ea4: f9403101    	ldr	x1, [x8, #0x60] ; enableLargeInput
101762ea8: aa1703e0    	mov	x0, x23
101762eac: 959310a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762eb0: 34000240    	cbz	w0, 0x101762ef8 <__text+0x175aef8>
101762eb4: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762eb8: f940d101    	ldr	x1, [x8, #0x1a0] ; globalSearchInputConfig
101762ebc: aa1403e0    	mov	x0, x20
101762ec0: 9593109f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762ec4: aa1d03fd    	mov	x29, x29
101762ec8: 959310a0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101762ecc: aa0003f5    	mov	x21, x0
101762ed0: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762ed4: f940ed01    	ldr	x1, [x8, #0x1d8] ; useNewBtnMode
101762ed8: 95931099    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762edc: aa0003e2    	mov	x2, x0
101762ee0: b00f3948    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
101762ee4: f9422101    	ldr	x1, [x8, #0x440] ; setEnableNewBtnMode:
101762ee8: aa1703e0    	mov	x0, x23
101762eec: 95931094    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762ef0: aa1503e0    	mov	x0, x21
101762ef4: 95931098    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101762ef8: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762efc: f940f101    	ldr	x1, [x8, #0x1e0] ; setIsFTS:
101762f00: aa1703e0    	mov	x0, x23
101762f04: 52800022    	mov	w2, #0x1                ; =1
101762f08: 9593108d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762f0c: f9462ec0    	ldr	x0, [x22, #0xc58]
101762f10: b00f4ce8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101762f14: f942f101    	ldr	x1, [x8, #0x5e0] ; backgroundColor
101762f18: 95931089    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762f1c: aa1d03fd    	mov	x29, x29
101762f20: 9593108a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101762f24: aa0003f5    	mov	x21, x0
101762f28: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762f2c: f940f501    	ldr	x1, [x8, #0x1e8] ; setVoiceButtonBackgroundColor:
101762f30: aa1703e0    	mov	x0, x23
101762f34: aa1503e2    	mov	x2, x21
101762f38: 95931081    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762f3c: aa1503e0    	mov	x0, x21
101762f40: 95931085    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101762f44: d101a3a0    	sub	x0, x29, #0x68
101762f48: aa1403e1    	mov	x1, x20
101762f4c: 95931088    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
101762f50: 900df476    	adrp	x22, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
101762f54: f947e2d6    	ldr	x22, [x22, #0xfc0]
101762f58: f9002bf6    	str	x22, [sp, #0x50]
101762f5c: f00bb0e8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
101762f60: fd41c108    	ldr	d8, [x8, #0x380]
101762f64: b0000008    	adrp	x8, 0x101763000 <__text+0x175b000>
101762f68: 91031108    	add	x8, x8, #0xc4
101762f6c: fd002fe8    	str	d8, [sp, #0x58]
101762f70: b00df5b8    	adrp	x24, 0x11d617000 <dyld_stub_binder+0x11d617000>
101762f74: 91242318    	add	x24, x24, #0x908
101762f78: a90663e8    	stp	x8, x24, [sp, #0x60]
101762f7c: 910143f5    	add	x21, sp, #0x50
101762f80: 910082a0    	add	x0, x21, #0x20
101762f84: d101a3a1    	sub	x1, x29, #0x68
101762f88: 9593107c    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
101762f8c: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762f90: f940fd01    	ldr	x1, [x8, #0x1f8] ; addVoiceSearchRightOpAction:
101762f94: 910143e2    	add	x2, sp, #0x50
101762f98: aa1703e0    	mov	x0, x23
101762f9c: 95931068    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762fa0: f90017f6    	str	x22, [sp, #0x28]
101762fa4: fd001be8    	str	d8, [sp, #0x30]
101762fa8: b0000008    	adrp	x8, 0x101763000 <__text+0x175b000>
101762fac: 91052108    	add	x8, x8, #0x148
101762fb0: a903e3e8    	stp	x8, x24, [sp, #0x38]
101762fb4: 9100a3f6    	add	x22, sp, #0x28
101762fb8: 910082c0    	add	x0, x22, #0x20
101762fbc: d101a3a1    	sub	x1, x29, #0x68
101762fc0: 9593106e    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
101762fc4: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762fc8: f9410101    	ldr	x1, [x8, #0x200] ; addVoiceSearchBottomAction:
101762fcc: 9100a3e2    	add	x2, sp, #0x28
101762fd0: aa1703e0    	mov	x0, x23
101762fd4: 9593105a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762fd8: b00f3948    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
101762fdc: f9424901    	ldr	x1, [x8, #0x490] ; setSearchBarDelegate:
101762fe0: aa1703e0    	mov	x0, x23
101762fe4: aa1403e2    	mov	x2, x20
101762fe8: 95931055    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101762fec: b00f5098    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
101762ff0: f9475b00    	ldr	x0, [x24, #0xeb0]
101762ff4: f00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101762ff8: f9410501    	ldr	x1, [x8, #0x208] ; searchBarPlaceHolderText
101762ffc: 95931050    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101763000: aa1d03fd    	mov	x29, x29
101763004: 95931051    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101763008: aa0003f4    	mov	x20, x0
10176300c: b00f36c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101763010: f942b901    	ldr	x1, [x8, #0x570] ; setPlaceholder:
101763014: aa1703e0    	mov	x0, x23
101763018: aa1403e2    	mov	x2, x20
10176301c: 95931048    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101763020: aa1403e0    	mov	x0, x20
101763024: 9593104c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101763028: 900f5088    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10176302c: f9453514    	ldr	x20, [x8, #0xa68]
101763030: f9475b00    	ldr	x0, [x24, #0xeb0]
101763034: f9400fe1    	ldr	x1, [sp, #0x18]
101763038: 95931041    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10176303c: a900dfe0    	stp	x0, x23, [sp, #0x8]
101763040: f00e7168    	adrp	x8, 0x11e592000 <dyld_stub_binder+0x11e592000>
101763044: 913ca108    	add	x8, x8, #0xf28
101763048: f90003e8    	str	x8, [sp]
10176304c: b00cd883    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
101763050: 91388063    	add	x3, x3, #0xe20
101763054: 900ce405    	adrp	x5, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
101763058: 911b74a5    	add	x5, x5, #0x6dd
10176305c: 900ce407    	adrp	x7, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
101763060: 9129a8e7    	add	x7, x7, #0xa6a
101763064: aa1403e0    	mov	x0, x20
101763068: f94013e1    	ldr	x1, [sp, #0x20]
10176306c: 52800042    	mov	w2, #0x2                ; =2
101763070: 52800004    	mov	w4, #0x0                ; =0
101763074: 528054c6    	mov	w6, #0x2a6              ; =678
101763078: 95931031    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10176307c: 910082c0    	add	x0, x22, #0x20
101763080: 95931044    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
101763084: 910082a0    	add	x0, x21, #0x20
101763088: 95931042    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
10176308c: d101a3a0    	sub	x0, x29, #0x68
101763090: 95931040    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
101763094: aa1303e0    	mov	x0, x19
101763098: 9593102f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10176309c: aa1703e0    	mov	x0, x23
1017630a0: a94e7bfd    	ldp	x29, x30, [sp, #0xe0]
1017630a4: a94d4ff4    	ldp	x20, x19, [sp, #0xd0]
1017630a8: a94c57f6    	ldp	x22, x21, [sp, #0xc0]
1017630ac: a94b5ff8    	ldp	x24, x23, [sp, #0xb0]
1017630b0: a94a67fa    	ldp	x26, x25, [sp, #0xa0]
1017630b4: a9496ffc    	ldp	x28, x27, [sp, #0x90]
1017630b8: 6d4823e9    	ldp	d9, d8, [sp, #0x80]
1017630bc: 9103c3ff    	add	sp, sp, #0xf0
1017630c0: 1593102c    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
