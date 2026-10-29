
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a73c38: d10183ff    	sub	sp, sp, #0x60
104a73c3c: a90167fa    	stp	x26, x25, [sp, #0x10]
104a73c40: a9025ff8    	stp	x24, x23, [sp, #0x20]
104a73c44: a90357f6    	stp	x22, x21, [sp, #0x30]
104a73c48: a9044ff4    	stp	x20, x19, [sp, #0x40]
104a73c4c: a9057bfd    	stp	x29, x30, [sp, #0x50]
104a73c50: 910143fd    	add	x29, sp, #0x50
104a73c54: aa0003f3    	mov	x19, x0
104a73c58: f00e0e48    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a73c5c: 52800029    	mov	w9, #0x1                ; =1
104a73c60: 390b0109    	strb	w9, [x8, #0x2c0]
104a73c64: 900dbd88    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a73c68: b980d919    	ldrsw	x25, [x8, #0xd8]
104a73c6c: f8796800    	ldr	x0, [x0, x25]
104a73c70: b00da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a73c74: f9412115    	ldr	x21, [x8, #0x240] ; selector notifySessionCount
104a73c78: aa1503e1    	mov	x1, x21
104a73c7c: 94c6cd30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a73c80: aa0003e8    	mov	x8, x0
104a73c84: 900db809    	adrp	x9, 0x120173000 <dyld_stub_binder+0x120173000>
104a73c88: f9462d20    	ldr	x0, [x9, #0xc58] ; class WCColor
104a73c8c: b4000868    	cbz	x8, 0x104a73d98 <_Flutter_MMFoundation_BindContext+0xf4f97c>
104a73c90: b00d9e68    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104a73c94: f9401501    	ldr	x1, [x8, #0x28] ; selector Brand
104a73c98: 94c6cd29    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a73c9c: aa1d03fd    	mov	x29, x29
104a73ca0: 94c6cd2a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a73ca4: aa0003f4    	mov	x20, x0
104a73ca8: 900dbd88    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a73cac: b981051a    	ldrsw	x26, [x8, #0x104]
104a73cb0: f87a6a60    	ldr	x0, [x19, x26]
104a73cb4: d00db4a8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104a73cb8: f9469501    	ldr	x1, [x8, #0xd28] ; selector setTextColor:
104a73cbc: aa1403e2    	mov	x2, x20
104a73cc0: 94c6cd1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a73cc4: aa1403e0    	mov	x0, x20
104a73cc8: 94c6cd23    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a73ccc: 900db808    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a73cd0: f9454518    	ldr	x24, [x8, #0xa88] ; class NSString
104a73cd4: 900db808    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a73cd8: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
104a73cdc: b00db468    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a73ce0: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext
104a73ce4: 94c6cd16    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a73ce8: aa1d03fd    	mov	x29, x29
104a73cec: 94c6cd17    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a73cf0: aa0003f4    	mov	x20, x0
104a73cf4: 900db808    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a73cf8: f9462900    	ldr	x0, [x8, #0xc50] ; class MMLanguageMgr
104a73cfc: 900db468    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a73d00: f947ad01    	ldr	x1, [x8, #0xf58] ; selector class
104a73d04: 94c6cd0e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a73d08: aa0003e2    	mov	x2, x0
104a73d0c: d00d9e28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a73d10: f9464101    	ldr	x1, [x8, #0xc80] ; selector getService:
104a73d14: aa1403e0    	mov	x0, x20
104a73d18: 94c6cd09    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a73d1c: aa1d03fd    	mov	x29, x29
104a73d20: 94c6cd0a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a73d24: aa0003f6    	mov	x22, x0
104a73d28: d00d9e28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a73d2c: f9464501    	ldr	x1, [x8, #0xc88] ; selector getStringForCurLanguage:
104a73d30: b00ce942    	adrp	x2, 0x11e79c000 <dyld_stub_binder+0x11e79c000>
104a73d34: 9127a042    	add	x2, x2, #0x9e8 ; CFString 'MainFrame_Aggregation_Title'
104a73d38: 94c6cd01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a73d3c: aa1d03fd    	mov	x29, x29
104a73d40: 94c6cd02    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a73d44: aa0003f7    	mov	x23, x0
104a73d48: f8796a60    	ldr	x0, [x19, x25]
104a73d4c: aa1503e1    	mov	x1, x21
104a73d50: 94c6ccfb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a73d54: f00db4a8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104a73d58: f946a501    	ldr	x1, [x8, #0xd48] ; selector stringWithFormat:
104a73d5c: f90003e0    	str	x0, [sp]
104a73d60: aa1803e0    	mov	x0, x24
104a73d64: aa1703e2    	mov	x2, x23
104a73d68: 94c6ccf5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a73d6c: aa1d03fd    	mov	x29, x29
104a73d70: 94c6ccf6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a73d74: aa0003f5    	mov	x21, x0
104a73d78: f87a6a60    	ldr	x0, [x19, x26]
104a73d7c: d00db4a8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104a73d80: f9468d01    	ldr	x1, [x8, #0xd18] ; selector setText:
104a73d84: aa1503e2    	mov	x2, x21
104a73d88: 94c6cced    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a73d8c: aa1503e0    	mov	x0, x21
104a73d90: 94c6ccf1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a73d94: 14000032    	b	0x104a73e5c <_Flutter_MMFoundation_BindContext+0xf4fa40>
104a73d98: f00d9e48    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104a73d9c: f9465101    	ldr	x1, [x8, #0xca0] ; selector FG_2
104a73da0: 94c6cce7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a73da4: aa1d03fd    	mov	x29, x29
104a73da8: 94c6cce8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a73dac: aa0003f4    	mov	x20, x0
104a73db0: 900dbd88    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a73db4: b9810515    	ldrsw	x21, [x8, #0x104]
104a73db8: f8756a60    	ldr	x0, [x19, x21]
104a73dbc: d00db4a8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104a73dc0: f9469501    	ldr	x1, [x8, #0xd28] ; selector setTextColor:
104a73dc4: aa1403e2    	mov	x2, x20
104a73dc8: 94c6ccdd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a73dcc: aa1403e0    	mov	x0, x20
104a73dd0: 94c6cce1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a73dd4: 900db808    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a73dd8: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
104a73ddc: b00db468    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a73de0: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext
104a73de4: 94c6ccd6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a73de8: aa1d03fd    	mov	x29, x29
104a73dec: 94c6ccd7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a73df0: aa0003f4    	mov	x20, x0
104a73df4: 900db808    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a73df8: f9462900    	ldr	x0, [x8, #0xc50] ; class MMLanguageMgr
104a73dfc: 900db468    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a73e00: f947ad01    	ldr	x1, [x8, #0xf58] ; selector class
104a73e04: 94c6ccce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a73e08: aa0003e2    	mov	x2, x0
104a73e0c: d00d9e28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a73e10: f9464101    	ldr	x1, [x8, #0xc80] ; selector getService:
104a73e14: aa1403e0    	mov	x0, x20
104a73e18: 94c6ccc9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a73e1c: aa1d03fd    	mov	x29, x29
104a73e20: 94c6ccca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a73e24: aa0003f6    	mov	x22, x0
104a73e28: d00d9e28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a73e2c: f9464501    	ldr	x1, [x8, #0xc88] ; selector getStringForCurLanguage:
104a73e30: b00ce942    	adrp	x2, 0x11e79c000 <dyld_stub_binder+0x11e79c000>
104a73e34: 91272042    	add	x2, x2, #0x9c8 ; CFString 'MainFrame_Aggregation_Empty'
104a73e38: 94c6ccc1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a73e3c: aa1d03fd    	mov	x29, x29
104a73e40: 94c6ccc2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a73e44: aa0003f7    	mov	x23, x0
104a73e48: f8756a60    	ldr	x0, [x19, x21]
104a73e4c: d00db4a8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104a73e50: f9468d01    	ldr	x1, [x8, #0xd18] ; selector setText:
104a73e54: aa1703e2    	mov	x2, x23
104a73e58: 94c6ccb9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a73e5c: aa1703e0    	mov	x0, x23
104a73e60: 94c6ccbd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a73e64: aa1603e0    	mov	x0, x22
104a73e68: 94c6ccbb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a73e6c: aa1403e0    	mov	x0, x20
104a73e70: a9457bfd    	ldp	x29, x30, [sp, #0x50]
104a73e74: a9444ff4    	ldp	x20, x19, [sp, #0x40]
104a73e78: a94357f6    	ldp	x22, x21, [sp, #0x30]
104a73e7c: a9425ff8    	ldp	x24, x23, [sp, #0x20]
104a73e80: a94167fa    	ldp	x26, x25, [sp, #0x10]
104a73e84: 910183ff    	add	sp, sp, #0x60
104a73e88: 14c6ccb3    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
