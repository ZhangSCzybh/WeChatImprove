
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101829e20: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
101829e24: a90167fa    	stp	x26, x25, [sp, #0x10]
101829e28: a9025ff8    	stp	x24, x23, [sp, #0x20]
101829e2c: a90357f6    	stp	x22, x21, [sp, #0x30]
101829e30: a9044ff4    	stp	x20, x19, [sp, #0x40]
101829e34: a9057bfd    	stp	x29, x30, [sp, #0x50]
101829e38: 910143fd    	add	x29, sp, #0x50
101829e3c: aa0003f3    	mov	x19, x0
101829e40: b00fa048    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
101829e44: 52800029    	mov	w9, #0x1                ; =1
101829e48: 392cdd09    	strb	w9, [x8, #0xb37]
101829e4c: d00f4a48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101829e50: f945e900    	ldr	x0, [x8, #0xbd0]
101829e54: f00f46a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101829e58: f944e914    	ldr	x20, [x8, #0x9d0] ; currentContext
101829e5c: aa1403e1    	mov	x1, x20
101829e60: 958ff4b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101829e64: aa1d03fd    	mov	x29, x29
101829e68: 958ff4b8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101829e6c: aa0003f7    	mov	x23, x0
101829e70: d00f4a5c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
101829e74: f9477380    	ldr	x0, [x28, #0xee0]
101829e78: d00f46a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101829e7c: f947ad15    	ldr	x21, [x8, #0xf58] ; class
101829e80: aa1503e1    	mov	x1, x21
101829e84: 958ff4ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101829e88: aa0003e2    	mov	x2, x0
101829e8c: 900f3088    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101829e90: f9464116    	ldr	x22, [x8, #0xc80] ; getService:
101829e94: aa1703e0    	mov	x0, x23
101829e98: aa1603e1    	mov	x1, x22
101829e9c: 958ff4a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101829ea0: aa1d03fd    	mov	x29, x29
101829ea4: 958ff4a9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101829ea8: aa0003f8    	mov	x24, x0
101829eac: b00f32e8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
101829eb0: f9454d01    	ldr	x1, [x8, #0xa98] ; ftsReportMgr
101829eb4: 958ff4a2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101829eb8: aa1d03fd    	mov	x29, x29
101829ebc: 958ff4a3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101829ec0: aa0003f9    	mov	x25, x0
101829ec4: 900f3408    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101829ec8: f9411101    	ldr	x1, [x8, #0x220] ; getExtInfo
101829ecc: aa1303e0    	mov	x0, x19
101829ed0: 958ff49b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101829ed4: aa1d03fd    	mov	x29, x29
101829ed8: 958ff49c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101829edc: aa0003fa    	mov	x26, x0
101829ee0: d00f3088    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101829ee4: f943ad01    	ldr	x1, [x8, #0x758] ; JSONRepresentation
101829ee8: 958ff495    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101829eec: aa1d03fd    	mov	x29, x29
101829ef0: 958ff496    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101829ef4: aa0003fb    	mov	x27, x0
101829ef8: 900f3408    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101829efc: f9412901    	ldr	x1, [x8, #0x250] ; newCTREndSearch:force:
101829f00: aa1903e0    	mov	x0, x25
101829f04: aa1b03e2    	mov	x2, x27
101829f08: 52800003    	mov	w3, #0x0                ; =0
101829f0c: 958ff48c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101829f10: aa1b03e0    	mov	x0, x27
101829f14: 958ff490    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101829f18: aa1a03e0    	mov	x0, x26
101829f1c: 958ff48e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101829f20: aa1903e0    	mov	x0, x25
101829f24: 958ff48c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101829f28: aa1803e0    	mov	x0, x24
101829f2c: 958ff48a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101829f30: aa1703e0    	mov	x0, x23
101829f34: 958ff488    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101829f38: f9402a60    	ldr	x0, [x19, #0x50]
101829f3c: b00f46e8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101829f40: f9408117    	ldr	x23, [x8, #0x100] ; removeAllObjects
101829f44: aa1703e1    	mov	x1, x23
101829f48: 958ff47d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101829f4c: f9405660    	ldr	x0, [x19, #0xa8]
101829f50: aa1703e1    	mov	x1, x23
101829f54: 958ff47a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101829f58: f9402e60    	ldr	x0, [x19, #0x58]
101829f5c: f9002e7f    	str	xzr, [x19, #0x58]
101829f60: 958ff47d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101829f64: f9402260    	ldr	x0, [x19, #0x40]
101829f68: f900227f    	str	xzr, [x19, #0x40]
101829f6c: 958ff47a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101829f70: d00f4a48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101829f74: f945e900    	ldr	x0, [x8, #0xbd0]
101829f78: aa1403e1    	mov	x1, x20
101829f7c: 958ff470    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101829f80: aa1d03fd    	mov	x29, x29
101829f84: 958ff471    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101829f88: aa0003f4    	mov	x20, x0
101829f8c: f9477380    	ldr	x0, [x28, #0xee0]
101829f90: aa1503e1    	mov	x1, x21
101829f94: 958ff46a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101829f98: aa0003e2    	mov	x2, x0
101829f9c: aa1403e0    	mov	x0, x20
101829fa0: aa1603e1    	mov	x1, x22
101829fa4: 958ff466    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101829fa8: aa1d03fd    	mov	x29, x29
101829fac: 958ff467    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101829fb0: aa0003f5    	mov	x21, x0
101829fb4: d00f3308    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
101829fb8: f944d901    	ldr	x1, [x8, #0x9b0] ; cancelSearchForHomePage
101829fbc: 958ff460    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101829fc0: aa1503e0    	mov	x0, x21
101829fc4: 958ff464    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101829fc8: aa1403e0    	mov	x0, x20
101829fcc: 958ff462    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101829fd0: d00f3408    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
101829fd4: f944c501    	ldr	x1, [x8, #0x988] ; resetSearchSectionType
101829fd8: aa1303e0    	mov	x0, x19
101829fdc: 958ff458    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101829fe0: b00f33e8    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101829fe4: f942fd01    	ldr	x1, [x8, #0x5f8] ; reloadSearchData
101829fe8: aa1303e0    	mov	x0, x19
101829fec: a9457bfd    	ldp	x29, x30, [sp, #0x50]
101829ff0: a9444ff4    	ldp	x20, x19, [sp, #0x40]
101829ff4: a94357f6    	ldp	x22, x21, [sp, #0x30]
101829ff8: a9425ff8    	ldp	x24, x23, [sp, #0x20]
101829ffc: a94167fa    	ldp	x26, x25, [sp, #0x10]
10182a000: a8c66ffc    	ldp	x28, x27, [sp], #0x60
10182a004: 158ff44e    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
