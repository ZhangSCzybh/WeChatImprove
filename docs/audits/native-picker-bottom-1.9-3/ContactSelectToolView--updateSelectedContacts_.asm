
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010079c8: d101c3ff    	sub	sp, sp, #0x70
1010079cc: a9016ffc    	stp	x28, x27, [sp, #0x10]
1010079d0: a90267fa    	stp	x26, x25, [sp, #0x20]
1010079d4: a9035ff8    	stp	x24, x23, [sp, #0x30]
1010079d8: a90457f6    	stp	x22, x21, [sp, #0x40]
1010079dc: a9054ff4    	stp	x20, x19, [sp, #0x50]
1010079e0: a9067bfd    	stp	x29, x30, [sp, #0x60]
1010079e4: 910183fd    	add	x29, sp, #0x60
1010079e8: aa0203f3    	mov	x19, x2
1010079ec: aa0003f4    	mov	x20, x0
1010079f0: b00fe148    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
1010079f4: 52800029    	mov	w9, #0x1                ; =1
1010079f8: 39330909    	strb	w9, [x8, #0xcc2]
1010079fc: aa0203e0    	mov	x0, x2
101007a00: 95b07dce    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101007a04: b00f87c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101007a08: f9435115    	ldr	x21, [x8, #0x6a0] ; count
101007a0c: aa1303e0    	mov	x0, x19
101007a10: aa1503e1    	mov	x1, x21
101007a14: 95b07dca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007a18: f100001f    	cmp	x0, #0x0
101007a1c: 1a9f17f6    	cset	w22, eq
101007a20: b00f73e8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
101007a24: f9477d01    	ldr	x1, [x8, #0xef8] ; foldButton
101007a28: aa1403e0    	mov	x0, x20
101007a2c: 95b07dc4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007a30: aa1d03fd    	mov	x29, x29
101007a34: 95b07dc5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101007a38: aa0003f7    	mov	x23, x0
101007a3c: b00f8808    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
101007a40: f9411101    	ldr	x1, [x8, #0x220] ; setHidden:
101007a44: aa1603e2    	mov	x2, x22
101007a48: 95b07dbd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007a4c: aa1703e0    	mov	x0, x23
101007a50: 95b07dc1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101007a54: d00f7308    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
101007a58: f9418116    	ldr	x22, [x8, #0x300] ; selectedContacts
101007a5c: aa1403e0    	mov	x0, x20
101007a60: aa1603e1    	mov	x1, x22
101007a64: 95b07db6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007a68: aa1d03fd    	mov	x29, x29
101007a6c: 95b07db7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101007a70: aa0003f7    	mov	x23, x0
101007a74: f90007f5    	str	x21, [sp, #0x8]
101007a78: aa1503e1    	mov	x1, x21
101007a7c: 95b07db0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007a80: aa0003f8    	mov	x24, x0
101007a84: aa1703e0    	mov	x0, x23
101007a88: 95b07db3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101007a8c: b4000778    	cbz	x24, 0x101007b78 <__text+0xfffb78>
101007a90: d280001a    	mov	x26, #0x0               ; =0
101007a94: 52800015    	mov	w21, #0x0               ; =0
101007a98: f00f7188    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
101007a9c: f942c117    	ldr	x23, [x8, #0x580] ; safeObjectAtIndex:
101007aa0: b00f87c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101007aa4: f9424d18    	ldr	x24, [x8, #0x498] ; containsObject:
101007aa8: f00f7188    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
101007aac: f9442d08    	ldr	x8, [x8, #0x858] ; safeRemoveObjectAtIndex:
101007ab0: f90003e8    	str	x8, [sp]
101007ab4: aa1403e0    	mov	x0, x20
101007ab8: aa1603e1    	mov	x1, x22
101007abc: 95b07da0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007ac0: aa1d03fd    	mov	x29, x29
101007ac4: 95b07da1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101007ac8: aa0003fb    	mov	x27, x0
101007acc: aa1703e1    	mov	x1, x23
101007ad0: aa1a03e2    	mov	x2, x26
101007ad4: 95b07d9a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007ad8: aa1d03fd    	mov	x29, x29
101007adc: 95b07d9b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101007ae0: aa0003fc    	mov	x28, x0
101007ae4: aa1303e0    	mov	x0, x19
101007ae8: aa1803e1    	mov	x1, x24
101007aec: aa1c03e2    	mov	x2, x28
101007af0: 95b07d93    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007af4: aa0003f9    	mov	x25, x0
101007af8: aa1c03e0    	mov	x0, x28
101007afc: 95b07d96    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101007b00: aa1b03e0    	mov	x0, x27
101007b04: 95b07d94    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101007b08: 370001b9    	tbnz	w25, #0x0, 0x101007b3c <__text+0xfffb3c>
101007b0c: aa1403e0    	mov	x0, x20
101007b10: aa1603e1    	mov	x1, x22
101007b14: 95b07d8a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007b18: aa1d03fd    	mov	x29, x29
101007b1c: 95b07d8b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101007b20: aa0003f9    	mov	x25, x0
101007b24: f94003e1    	ldr	x1, [sp]
101007b28: aa1a03e2    	mov	x2, x26
101007b2c: 95b07d84    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007b30: aa1903e0    	mov	x0, x25
101007b34: 95b07d88    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101007b38: 510006b5    	sub	w21, w21, #0x1
101007b3c: 110006b5    	add	w21, w21, #0x1
101007b40: 93407eba    	sxtw	x26, w21
101007b44: aa1403e0    	mov	x0, x20
101007b48: aa1603e1    	mov	x1, x22
101007b4c: 95b07d7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007b50: aa1d03fd    	mov	x29, x29
101007b54: 95b07d7d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101007b58: aa0003f9    	mov	x25, x0
101007b5c: f94007e1    	ldr	x1, [sp, #0x8]
101007b60: 95b07d77    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007b64: aa0003fb    	mov	x27, x0
101007b68: aa1903e0    	mov	x0, x25
101007b6c: 95b07d7a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101007b70: eb35c37f    	cmp	x27, w21, sxtw
101007b74: 54fffa08    	b.hi	0x101007ab4 <__text+0xfffab4>
101007b78: aa1303e0    	mov	x0, x19
101007b7c: f94007e1    	ldr	x1, [sp, #0x8]
101007b80: 95b07d6f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007b84: b4000740    	cbz	x0, 0x101007c6c <__text+0xfffc6c>
101007b88: d2800017    	mov	x23, #0x0               ; =0
101007b8c: f00f7188    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
101007b90: f942c118    	ldr	x24, [x8, #0x580] ; safeObjectAtIndex:
101007b94: b00f87c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101007b98: f9424d19    	ldr	x25, [x8, #0x498] ; containsObject:
101007b9c: f00f7188    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
101007ba0: f943c515    	ldr	x21, [x8, #0x788] ; safeAddObject:
101007ba4: aa1403e0    	mov	x0, x20
101007ba8: aa1603e1    	mov	x1, x22
101007bac: 95b07d64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007bb0: aa1d03fd    	mov	x29, x29
101007bb4: 95b07d65    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101007bb8: aa0003fb    	mov	x27, x0
101007bbc: aa1303e0    	mov	x0, x19
101007bc0: aa1803e1    	mov	x1, x24
101007bc4: aa1703e2    	mov	x2, x23
101007bc8: 95b07d5d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007bcc: aa1d03fd    	mov	x29, x29
101007bd0: 95b07d5e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101007bd4: aa0003fc    	mov	x28, x0
101007bd8: aa1b03e0    	mov	x0, x27
101007bdc: aa1903e1    	mov	x1, x25
101007be0: aa1c03e2    	mov	x2, x28
101007be4: 95b07d56    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007be8: aa0003fa    	mov	x26, x0
101007bec: aa1c03e0    	mov	x0, x28
101007bf0: 95b07d59    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101007bf4: aa1b03e0    	mov	x0, x27
101007bf8: 95b07d57    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101007bfc: 370002da    	tbnz	w26, #0x0, 0x101007c54 <__text+0xfffc54>
101007c00: aa1403e0    	mov	x0, x20
101007c04: aa1603e1    	mov	x1, x22
101007c08: 95b07d4d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007c0c: aa1d03fd    	mov	x29, x29
101007c10: 95b07d4e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101007c14: aa0003fa    	mov	x26, x0
101007c18: aa1303e0    	mov	x0, x19
101007c1c: aa1803e1    	mov	x1, x24
101007c20: aa1703e2    	mov	x2, x23
101007c24: 95b07d46    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007c28: aa1d03fd    	mov	x29, x29
101007c2c: 95b07d47    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101007c30: aa0003fb    	mov	x27, x0
101007c34: aa1a03e0    	mov	x0, x26
101007c38: aa1503e1    	mov	x1, x21
101007c3c: aa1b03e2    	mov	x2, x27
101007c40: 95b07d3f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007c44: aa1b03e0    	mov	x0, x27
101007c48: 95b07d43    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101007c4c: aa1a03e0    	mov	x0, x26
101007c50: 95b07d41    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101007c54: 910006f7    	add	x23, x23, #0x1
101007c58: aa1303e0    	mov	x0, x19
101007c5c: f94007e1    	ldr	x1, [sp, #0x8]
101007c60: 95b07d37    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007c64: eb17001f    	cmp	x0, x23
101007c68: 54fff9e8    	b.hi	0x101007ba4 <__text+0xfffba4>
101007c6c: 900f7408    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
101007c70: f947f501    	ldr	x1, [x8, #0xfe8] ; updateHeadImageViews
101007c74: aa1403e0    	mov	x0, x20
101007c78: 95b07d31    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101007c7c: aa1303e0    	mov	x0, x19
101007c80: a9467bfd    	ldp	x29, x30, [sp, #0x60]
101007c84: a9454ff4    	ldp	x20, x19, [sp, #0x50]
101007c88: a94457f6    	ldp	x22, x21, [sp, #0x40]
101007c8c: a9435ff8    	ldp	x24, x23, [sp, #0x30]
101007c90: a94267fa    	ldp	x26, x25, [sp, #0x20]
101007c94: a9416ffc    	ldp	x28, x27, [sp, #0x10]
101007c98: 9101c3ff    	add	sp, sp, #0x70
101007c9c: 15b07d2e    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
