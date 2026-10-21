
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010a4cd8: d10143ff    	sub	sp, sp, #0x50
1010a4cdc: a9015ff8    	stp	x24, x23, [sp, #0x10]
1010a4ce0: a90257f6    	stp	x22, x21, [sp, #0x20]
1010a4ce4: a9034ff4    	stp	x20, x19, [sp, #0x30]
1010a4ce8: a9047bfd    	stp	x29, x30, [sp, #0x40]
1010a4cec: 910103fd    	add	x29, sp, #0x40
1010a4cf0: aa0503f5    	mov	x21, x5
1010a4cf4: aa0403f7    	mov	x23, x4
1010a4cf8: aa0303f3    	mov	x19, x3
1010a4cfc: aa0203f6    	mov	x22, x2
1010a4d00: aa0003f4    	mov	x20, x0
1010a4d04: 900fdc68    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
1010a4d08: 52800038    	mov	w24, #0x1               ; =1
1010a4d0c: 393ce918    	strb	w24, [x8, #0xf3a]
1010a4d10: aa0303e0    	mov	x0, x3
1010a4d14: 95ae0909    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1010a4d18: d00f88a8    	adrp	x8, 0x1201ba000 <dyld_stub_binder+0x1201ba000>
1010a4d1c: f943c908    	ldr	x8, [x8, #0x790]
1010a4d20: a90023f4    	stp	x20, x8, [sp]
1010a4d24: d00f82e8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1010a4d28: f9466901    	ldr	x1, [x8, #0xcd0] ; init
1010a4d2c: 910003e0    	mov	x0, sp
1010a4d30: 95ae0905    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
1010a4d34: aa0003f4    	mov	x20, x0
1010a4d38: b4000ea0    	cbz	x0, 0x1010a4f0c <__text+0x109cf0c>
1010a4d3c: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a4d40: b9863908    	ldrsw	x8, [x8, #0x638]
1010a4d44: 38286a97    	strb	w23, [x20, x8]
1010a4d48: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a4d4c: b9860908    	ldrsw	x8, [x8, #0x608]
1010a4d50: 8b080280    	add	x0, x20, x8
1010a4d54: aa1303e1    	mov	x1, x19
1010a4d58: 95ae090f    	bl	0x107c27194 <_Flutter_MMFoundation_BindContext+0x4102d78>
1010a4d5c: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a4d60: b9863508    	ldrsw	x8, [x8, #0x634]
1010a4d64: b8286a96    	str	w22, [x20, x8]
1010a4d68: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a4d6c: b9860508    	ldrsw	x8, [x8, #0x604]
1010a4d70: 38286a98    	strb	w24, [x20, x8]
1010a4d74: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a4d78: b9862d08    	ldrsw	x8, [x8, #0x62c]
1010a4d7c: 38286a95    	strb	w21, [x20, x8]
1010a4d80: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a4d84: b9863d08    	ldrsw	x8, [x8, #0x63c]
1010a4d88: f8686a80    	ldr	x0, [x20, x8]
1010a4d8c: f8286a9f    	str	xzr, [x20, x8]
1010a4d90: 95ae08f1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4d94: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a4d98: b9864108    	ldrsw	x8, [x8, #0x640]
1010a4d9c: f8686a80    	ldr	x0, [x20, x8]
1010a4da0: f8286a9f    	str	xzr, [x20, x8]
1010a4da4: 95ae08ec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4da8: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a4dac: b9864508    	ldrsw	x8, [x8, #0x644]
1010a4db0: f8286a98    	str	x24, [x20, x8]
1010a4db4: b00f6da8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
1010a4db8: f9425101    	ldr	x1, [x8, #0x4a0] ; setM_eFTSSearchType:
1010a4dbc: aa1403e0    	mov	x0, x20
1010a4dc0: 12bfe002    	mov	w2, #0xffffff           ; =16777215
1010a4dc4: 95ae08de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4dc8: 900f6f28    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
1010a4dcc: f942d501    	ldr	x1, [x8, #0x5a8] ; reloadContacts
1010a4dd0: aa1403e0    	mov	x0, x20
1010a4dd4: 95ae08da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4dd8: f00f8668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1010a4ddc: f9458d00    	ldr	x0, [x8, #0xb18]
1010a4de0: 900f82e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1010a4de4: f946b101    	ldr	x1, [x8, #0xd60] ; defaultCenter
1010a4de8: 95ae08d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4dec: aa1d03fd    	mov	x29, x29
1010a4df0: 95ae08d6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a4df4: aa0003f5    	mov	x21, x0
1010a4df8: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a4dfc: f9420d03    	ldr	x3, [x8, #0x418] ; pluginsChanged
1010a4e00: 900e2dc8    	adrp	x8, 0x11d65c000 <dyld_stub_binder+0x11d65c000>
1010a4e04: 91394108    	add	x8, x8, #0xe50
1010a4e08: f9400104    	ldr	x4, [x8]
1010a4e0c: d00f82c8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1010a4e10: f9470101    	ldr	x1, [x8, #0xe00] ; addObserver:selector:name:object:
1010a4e14: aa1403e2    	mov	x2, x20
1010a4e18: d2800005    	mov	x5, #0x0                ; =0
1010a4e1c: 95ae08c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4e20: aa1503e0    	mov	x0, x21
1010a4e24: 95ae08cc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4e28: f00f8678    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
1010a4e2c: f945eb00    	ldr	x0, [x24, #0xbd0]
1010a4e30: 900f82e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1010a4e34: f944e915    	ldr	x21, [x8, #0x9d0] ; currentContext
1010a4e38: aa1503e1    	mov	x1, x21
1010a4e3c: 95ae08c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4e40: aa1d03fd    	mov	x29, x29
1010a4e44: 95ae08c1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a4e48: aa0003f7    	mov	x23, x0
1010a4e4c: 900f8668    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
1010a4e50: f9452902    	ldr	x2, [x8, #0xa50]
1010a4e54: d00f6ca8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1010a4e58: f940a116    	ldr	x22, [x8, #0x140] ; registerExtension:withTarget:
1010a4e5c: aa1603e1    	mov	x1, x22
1010a4e60: aa1403e3    	mov	x3, x20
1010a4e64: 95ae08b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4e68: aa1703e0    	mov	x0, x23
1010a4e6c: 95ae08ba    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4e70: f945eb00    	ldr	x0, [x24, #0xbd0]
1010a4e74: aa1503e1    	mov	x1, x21
1010a4e78: 95ae08b1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4e7c: aa1d03fd    	mov	x29, x29
1010a4e80: 95ae08b2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a4e84: aa0003f7    	mov	x23, x0
1010a4e88: b00f8668    	adrp	x8, 0x120171000 <dyld_stub_binder+0x120171000>
1010a4e8c: f940f902    	ldr	x2, [x8, #0x1f0]
1010a4e90: aa1603e1    	mov	x1, x22
1010a4e94: aa1403e3    	mov	x3, x20
1010a4e98: 95ae08a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4e9c: aa1703e0    	mov	x0, x23
1010a4ea0: 95ae08ad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4ea4: f945eb00    	ldr	x0, [x24, #0xbd0]
1010a4ea8: aa1503e1    	mov	x1, x21
1010a4eac: 95ae08a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4eb0: aa1d03fd    	mov	x29, x29
1010a4eb4: 95ae08a5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a4eb8: aa0003f7    	mov	x23, x0
1010a4ebc: b00f8668    	adrp	x8, 0x120171000 <dyld_stub_binder+0x120171000>
1010a4ec0: f940cd02    	ldr	x2, [x8, #0x198]
1010a4ec4: aa1603e1    	mov	x1, x22
1010a4ec8: aa1403e3    	mov	x3, x20
1010a4ecc: 95ae089c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4ed0: aa1703e0    	mov	x0, x23
1010a4ed4: 95ae08a0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4ed8: f945eb00    	ldr	x0, [x24, #0xbd0]
1010a4edc: aa1503e1    	mov	x1, x21
1010a4ee0: 95ae0897    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4ee4: aa1d03fd    	mov	x29, x29
1010a4ee8: 95ae0898    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a4eec: aa0003f5    	mov	x21, x0
1010a4ef0: b00f8668    	adrp	x8, 0x120171000 <dyld_stub_binder+0x120171000>
1010a4ef4: f940e902    	ldr	x2, [x8, #0x1d0]
1010a4ef8: aa1603e1    	mov	x1, x22
1010a4efc: aa1403e3    	mov	x3, x20
1010a4f00: 95ae088f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4f04: aa1503e0    	mov	x0, x21
1010a4f08: 95ae0893    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4f0c: aa1303e0    	mov	x0, x19
1010a4f10: 95ae0891    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a4f14: aa1403e0    	mov	x0, x20
1010a4f18: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1010a4f1c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1010a4f20: a94257f6    	ldp	x22, x21, [sp, #0x20]
1010a4f24: a9415ff8    	ldp	x24, x23, [sp, #0x10]
1010a4f28: 910143ff    	add	sp, sp, #0x50
1010a4f2c: d65f03c0    	ret
