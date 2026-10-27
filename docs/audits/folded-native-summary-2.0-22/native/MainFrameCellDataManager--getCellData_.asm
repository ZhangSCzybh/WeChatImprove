
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a82bec: d10243ff    	sub	sp, sp, #0x90
104a82bf0: a9036ffc    	stp	x28, x27, [sp, #0x30]
104a82bf4: a90467fa    	stp	x26, x25, [sp, #0x40]
104a82bf8: a9055ff8    	stp	x24, x23, [sp, #0x50]
104a82bfc: a90657f6    	stp	x22, x21, [sp, #0x60]
104a82c00: a9074ff4    	stp	x20, x19, [sp, #0x70]
104a82c04: a9087bfd    	stp	x29, x30, [sp, #0x80]
104a82c08: 910203fd    	add	x29, sp, #0x80
104a82c0c: aa0203f3    	mov	x19, x2
104a82c10: aa0003f4    	mov	x20, x0
104a82c14: 900e0de8    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a82c18: 52800029    	mov	w9, #0x1                ; =1
104a82c1c: 390b9d09    	strb	w9, [x8, #0x2e7]
104a82c20: aa0203e0    	mov	x0, x2
104a82c24: 94c69145    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104a82c28: b00dbd08    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a82c2c: b981ad19    	ldrsw	x25, [x8, #0x1ac]
104a82c30: f8796a96    	ldr	x22, [x20, x25]
104a82c34: d00d9e08    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104a82c38: f947d915    	ldr	x21, [x8, #0xfb0] ; m_nsUserName
104a82c3c: aa1303e0    	mov	x0, x19
104a82c40: aa1503e1    	mov	x1, x21
104a82c44: 94c6913e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82c48: aa1d03fd    	mov	x29, x29
104a82c4c: 94c6913f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a82c50: aa0003f7    	mov	x23, x0
104a82c54: d00db408    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104a82c58: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
104a82c5c: aa1603e0    	mov	x0, x22
104a82c60: aa1703e2    	mov	x2, x23
104a82c64: 94c69136    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82c68: aa1d03fd    	mov	x29, x29
104a82c6c: 94c69137    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a82c70: aa0003f8    	mov	x24, x0
104a82c74: aa1703e0    	mov	x0, x23
104a82c78: 94c69137    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a82c7c: b5002038    	cbnz	x24, 0x104a83080 <_Flutter_MMFoundation_BindContext+0xf5ec64>
104a82c80: aa1303e0    	mov	x0, x19
104a82c84: aa1503e1    	mov	x1, x21
104a82c88: 94c6912d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82c8c: aa1d03fd    	mov	x29, x29
104a82c90: 94c6912e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a82c94: aa0003fc    	mov	x28, x0
104a82c98: b9002fff    	str	wzr, [sp, #0x2c]
104a82c9c: b00dbd08    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a82ca0: b981b116    	ldrsw	x22, [x8, #0x1b0]
104a82ca4: f8766a80    	ldr	x0, [x20, x22]
104a82ca8: d00da808    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a82cac: f9427101    	ldr	x1, [x8, #0x4e0] ; dataOfFile:modifyTimeInSeconds:
104a82cb0: 9100b3e3    	add	x3, sp, #0x2c
104a82cb4: aa1c03e2    	mov	x2, x28
104a82cb8: 94c69121    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82cbc: aa1d03fd    	mov	x29, x29
104a82cc0: 94c69122    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a82cc4: aa0003f7    	mov	x23, x0
104a82cc8: b00db408    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104a82ccc: f946e91a    	ldr	x26, [x8, #0xdd0] ; length
104a82cd0: aa1a03e1    	mov	x1, x26
104a82cd4: 94c6911a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82cd8: d00db7a8    	adrp	x8, 0x120178000 <dyld_stub_binder+0x120178000>
104a82cdc: b4000740    	cbz	x0, 0x104a82dc4 <_Flutter_MMFoundation_BindContext+0xf5e9a8>
104a82ce0: a901e7f6    	stp	x22, x25, [sp, #0x18]
104a82ce4: aa1c03f6    	mov	x22, x28
104a82ce8: b00db788    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a82cec: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
104a82cf0: d00db3e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a82cf4: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104a82cf8: 94c69111    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82cfc: aa1d03fd    	mov	x29, x29
104a82d00: 94c69112    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a82d04: aa0003f9    	mov	x25, x0
104a82d08: d00db788    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a82d0c: f9401d00    	ldr	x0, [x8, #0x38] ; MMNewSessionMgr
104a82d10: b00db3e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a82d14: f947ad18    	ldr	x24, [x8, #0xf58] ; class
104a82d18: aa1803e1    	mov	x1, x24
104a82d1c: 94c69108    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82d20: aa0003e2    	mov	x2, x0
104a82d24: f00d9da8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a82d28: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104a82d2c: aa1903e0    	mov	x0, x25
104a82d30: 94c69103    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82d34: aa1d03fd    	mov	x29, x29
104a82d38: 94c69104    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a82d3c: aa0003fa    	mov	x26, x0
104a82d40: aa1303e0    	mov	x0, x19
104a82d44: aa1503e1    	mov	x1, x21
104a82d48: 94c690fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82d4c: aa1d03fd    	mov	x29, x29
104a82d50: 94c690fe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a82d54: aa0003fb    	mov	x27, x0
104a82d58: 900da768    	adrp	x8, 0x11ff6e000 <dyld_stub_binder+0x11ff6e000>
104a82d5c: f941c101    	ldr	x1, [x8, #0x380] ; GetSessionModifyTimeInSeconds:
104a82d60: aa1a03e0    	mov	x0, x26
104a82d64: aa1b03e2    	mov	x2, x27
104a82d68: 94c690f5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82d6c: aa0003fc    	mov	x28, x0
104a82d70: aa1b03e0    	mov	x0, x27
104a82d74: 94c690f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a82d78: aa1a03e0    	mov	x0, x26
104a82d7c: 94c690f6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a82d80: aa1903e0    	mov	x0, x25
104a82d84: 94c690f4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a82d88: b9402fe8    	ldr	w8, [sp, #0x2c]
104a82d8c: 6b1c011f    	cmp	w8, w28
104a82d90: 54000b22    	b.hs	0x104a82ef4 <_Flutter_MMFoundation_BindContext+0xf5ead8>
104a82d94: aa1703e0    	mov	x0, x23
104a82d98: 94c690ef    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a82d9c: f9400fe8    	ldr	x8, [sp, #0x18]
104a82da0: f8686a80    	ldr	x0, [x20, x8]
104a82da4: b00da788    	adrp	x8, 0x11ff73000 <dyld_stub_binder+0x11ff73000>
104a82da8: f945d501    	ldr	x1, [x8, #0xba8] ; deleteDataOfFile:
104a82dac: aa1603fc    	mov	x28, x22
104a82db0: aa1603e2    	mov	x2, x22
104a82db4: 94c690e2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82db8: d2800017    	mov	x23, #0x0               ; =0
104a82dbc: f94013f9    	ldr	x25, [sp, #0x20]
104a82dc0: 1400007d    	b	0x104a82fb4 <_Flutter_MMFoundation_BindContext+0xf5eb98>
104a82dc4: f9415518    	ldr	x24, [x8, #0x2a8] ; controllerType
104a82dc8: aa1303e0    	mov	x0, x19
104a82dcc: aa1503e1    	mov	x1, x21
104a82dd0: 94c690db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82dd4: aa1d03fd    	mov	x29, x29
104a82dd8: 94c690dc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a82ddc: aa0003fb    	mov	x27, x0
104a82de0: d00da808    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a82de4: f9425901    	ldr	x1, [x8, #0x4b0] ; pathForCellData:
104a82de8: aa1803e0    	mov	x0, x24
104a82dec: aa1b03e2    	mov	x2, x27
104a82df0: 94c690d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82df4: aa1d03fd    	mov	x29, x29
104a82df8: 94c690d4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a82dfc: aa0003f8    	mov	x24, x0
104a82e00: aa1b03e0    	mov	x0, x27
104a82e04: 94c690d4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a82e08: b00db788    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a82e0c: f9463500    	ldr	x0, [x8, #0xc68] ; CBaseFile
104a82e10: f00d9fe8    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
104a82e14: f9429501    	ldr	x1, [x8, #0x528] ; GetFileModifyTime:
104a82e18: f9000bf8    	str	x24, [sp, #0x10]
104a82e1c: aa1803e2    	mov	x2, x24
104a82e20: 94c690c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82e24: f100001f    	cmp	x0, #0x0
104a82e28: 540006cd    	b.le	0x104a82f00 <_Flutter_MMFoundation_BindContext+0xf5eae4>
104a82e2c: aa0003fb    	mov	x27, x0
104a82e30: a901e7f6    	stp	x22, x25, [sp, #0x18]
104a82e34: f90007fc    	str	x28, [sp, #0x8]
104a82e38: b00db788    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a82e3c: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
104a82e40: d00db3e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a82e44: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104a82e48: 94c690bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82e4c: aa1d03fd    	mov	x29, x29
104a82e50: 94c690be    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a82e54: aa0003f6    	mov	x22, x0
104a82e58: f90003e0    	str	x0, [sp]
104a82e5c: d00db788    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a82e60: f9401d00    	ldr	x0, [x8, #0x38] ; MMNewSessionMgr
104a82e64: b00db3e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a82e68: f947ad18    	ldr	x24, [x8, #0xf58] ; class
104a82e6c: aa1803e1    	mov	x1, x24
104a82e70: 94c690b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82e74: aa0003e2    	mov	x2, x0
104a82e78: f00d9da8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a82e7c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104a82e80: aa1603e0    	mov	x0, x22
104a82e84: 94c690ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82e88: aa1d03fd    	mov	x29, x29
104a82e8c: 94c690af    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a82e90: aa0003f9    	mov	x25, x0
104a82e94: aa1303e0    	mov	x0, x19
104a82e98: aa1503e1    	mov	x1, x21
104a82e9c: 94c690a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82ea0: aa1d03fd    	mov	x29, x29
104a82ea4: 94c690a9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a82ea8: aa0003f6    	mov	x22, x0
104a82eac: 900da768    	adrp	x8, 0x11ff6e000 <dyld_stub_binder+0x11ff6e000>
104a82eb0: f941c101    	ldr	x1, [x8, #0x380] ; GetSessionModifyTimeInSeconds:
104a82eb4: aa1903e0    	mov	x0, x25
104a82eb8: aa1603e2    	mov	x2, x22
104a82ebc: 94c690a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82ec0: aa0003fc    	mov	x28, x0
104a82ec4: aa1603e0    	mov	x0, x22
104a82ec8: 94c690a3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a82ecc: aa1903e0    	mov	x0, x25
104a82ed0: 94c690a1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a82ed4: f94003e0    	ldr	x0, [sp]
104a82ed8: 94c6909f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a82edc: eb3c437f    	cmp	x27, w28, uxtw
104a82ee0: 54000162    	b.hs	0x104a82f0c <_Flutter_MMFoundation_BindContext+0xf5eaf0>
104a82ee4: aa1703fb    	mov	x27, x23
104a82ee8: f94013f9    	ldr	x25, [sp, #0x20]
104a82eec: f94007fc    	ldr	x28, [sp, #0x8]
104a82ef0: 1400001f    	b	0x104a82f6c <_Flutter_MMFoundation_BindContext+0xf5eb50>
104a82ef4: f94013f9    	ldr	x25, [sp, #0x20]
104a82ef8: aa1603fc    	mov	x28, x22
104a82efc: 1400002e    	b	0x104a82fb4 <_Flutter_MMFoundation_BindContext+0xf5eb98>
104a82f00: b00db3e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a82f04: f947ad18    	ldr	x24, [x8, #0xf58] ; class
104a82f08: 14000029    	b	0x104a82fac <_Flutter_MMFoundation_BindContext+0xf5eb90>
104a82f0c: b00db788    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a82f10: f9459500    	ldr	x0, [x8, #0xb28]
104a82f14: d00db3e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a82f18: f945f501    	ldr	x1, [x8, #0xbe8] ; dataWithContentsOfFile:
104a82f1c: f9400be2    	ldr	x2, [sp, #0x10]
104a82f20: 94c69087    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82f24: aa1d03fd    	mov	x29, x29
104a82f28: 94c69088    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a82f2c: aa0003fb    	mov	x27, x0
104a82f30: aa1703e0    	mov	x0, x23
104a82f34: 94c69088    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a82f38: aa1b03e0    	mov	x0, x27
104a82f3c: aa1a03e1    	mov	x1, x26
104a82f40: 94c6907f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82f44: f94007fc    	ldr	x28, [sp, #0x8]
104a82f48: b4000100    	cbz	x0, 0x104a82f68 <_Flutter_MMFoundation_BindContext+0xf5eb4c>
104a82f4c: f9400fe8    	ldr	x8, [sp, #0x18]
104a82f50: f8686a80    	ldr	x0, [x20, x8]
104a82f54: b00da788    	adrp	x8, 0x11ff73000 <dyld_stub_binder+0x11ff73000>
104a82f58: f945c501    	ldr	x1, [x8, #0xb88] ; writeData:toFile:
104a82f5c: aa1b03e2    	mov	x2, x27
104a82f60: aa1c03e3    	mov	x3, x28
104a82f64: 94c69076    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82f68: f94013f9    	ldr	x25, [sp, #0x20]
104a82f6c: d00db7a8    	adrp	x8, 0x120178000 <dyld_stub_binder+0x120178000>
104a82f70: f9415516    	ldr	x22, [x8, #0x2a8] ; MainFrameCellData
104a82f74: aa1303e0    	mov	x0, x19
104a82f78: aa1503e1    	mov	x1, x21
104a82f7c: 94c69070    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82f80: aa1d03fd    	mov	x29, x29
104a82f84: 94c69071    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a82f88: aa0003f7    	mov	x23, x0
104a82f8c: d00d9fe8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
104a82f90: f943b501    	ldr	x1, [x8, #0x768] ; deleteCellDataFromLocal:
104a82f94: aa1603e0    	mov	x0, x22
104a82f98: aa1703e2    	mov	x2, x23
104a82f9c: 94c69068    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82fa0: aa1703e0    	mov	x0, x23
104a82fa4: 94c6906c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a82fa8: aa1b03f7    	mov	x23, x27
104a82fac: f9400be0    	ldr	x0, [sp, #0x10]
104a82fb0: 94c69069    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a82fb4: d00db7ba    	adrp	x26, 0x120178000 <dyld_stub_binder+0x120178000>
104a82fb8: d00db788    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a82fbc: f9429916    	ldr	x22, [x8, #0x530] ; PBCoder
104a82fc0: f9415740    	ldr	x0, [x26, #0x2a8] ; MainFrameCellData
104a82fc4: aa1803e1    	mov	x1, x24
104a82fc8: 94c6905d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82fcc: aa0003e2    	mov	x2, x0
104a82fd0: d00d9e68    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
104a82fd4: f944c101    	ldr	x1, [x8, #0x980] ; decodeObjectOfClass:fromData:
104a82fd8: aa1603e0    	mov	x0, x22
104a82fdc: aa1703e3    	mov	x3, x23
104a82fe0: 94c69057    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a82fe4: aa1d03fd    	mov	x29, x29
104a82fe8: 94c69058    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a82fec: b40000c0    	cbz	x0, 0x104a83004 <_Flutter_MMFoundation_BindContext+0xf5ebe8>
104a82ff0: aa0003f8    	mov	x24, x0
104a82ff4: d00da808    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a82ff8: f9427501    	ldr	x1, [x8, #0x4e8] ; updateDataAfterPBDecode:
104a82ffc: aa1303e2    	mov	x2, x19
104a83000: 1400000c    	b	0x104a83030 <_Flutter_MMFoundation_BindContext+0xf5ec14>
104a83004: f9415740    	ldr	x0, [x26, #0x2a8] ; MainFrameCellData
104a83008: 94c69056    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104a8300c: 900da008    	adrp	x8, 0x11fe83000 <dyld_stub_binder+0x11fe83000>
104a83010: f9406501    	ldr	x1, [x8, #0xc8] ; initWithSessionInfo:
104a83014: aa1303e2    	mov	x2, x19
104a83018: 94c69049    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8301c: aa0003f8    	mov	x24, x0
104a83020: b00da808    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a83024: f9427901    	ldr	x1, [x8, #0x4f0] ; saveCellData:
104a83028: aa1403e0    	mov	x0, x20
104a8302c: aa1803e2    	mov	x2, x24
104a83030: 94c69043    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a83034: f8796a94    	ldr	x20, [x20, x25]
104a83038: aa1303e0    	mov	x0, x19
104a8303c: aa1503e1    	mov	x1, x21
104a83040: 94c6903f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a83044: aa1d03fd    	mov	x29, x29
104a83048: 94c69040    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8304c: aa0003f5    	mov	x21, x0
104a83050: d00d9da8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a83054: f942c901    	ldr	x1, [x8, #0x590] ; safeSetObject:forKey:
104a83058: aa1403e0    	mov	x0, x20
104a8305c: aa1803e2    	mov	x2, x24
104a83060: aa1503e3    	mov	x3, x21
104a83064: 94c69036    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a83068: aa1503e0    	mov	x0, x21
104a8306c: 94c6903a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a83070: aa1703e0    	mov	x0, x23
104a83074: 94c69038    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a83078: aa1c03e0    	mov	x0, x28
104a8307c: 94c69036    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a83080: f00da748    	adrp	x8, 0x11ff6e000 <dyld_stub_binder+0x11ff6e000>
104a83084: f942fd01    	ldr	x1, [x8, #0x5f8] ; m_hasMigrateRedTips
104a83088: aa1303e0    	mov	x0, x19
104a8308c: 94c6902c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a83090: 370007c0    	tbnz	w0, #0x0, 0x104a83188 <_Flutter_MMFoundation_BindContext+0xf5ed6c>
104a83094: 900db79b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
104a83098: f945eb60    	ldr	x0, [x27, #0xbd0] ; MMContext
104a8309c: b00db3e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a830a0: f944e914    	ldr	x20, [x8, #0x9d0] ; currentContext
104a830a4: aa1403e1    	mov	x1, x20
104a830a8: 94c69025    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a830ac: aa1d03fd    	mov	x29, x29
104a830b0: 94c69026    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a830b4: aa0003f7    	mov	x23, x0
104a830b8: f00db79c    	adrp	x28, 0x120176000 <dyld_stub_binder+0x120176000>
104a830bc: f945b780    	ldr	x0, [x28, #0xb68] ; MsgRedTipsMgr
104a830c0: 900db3e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a830c4: f947ad15    	ldr	x21, [x8, #0xf58] ; class
104a830c8: aa1503e1    	mov	x1, x21
104a830cc: 94c6901c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a830d0: aa0003e2    	mov	x2, x0
104a830d4: d00d9da8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a830d8: f9464116    	ldr	x22, [x8, #0xc80] ; getService:
104a830dc: aa1703e0    	mov	x0, x23
104a830e0: aa1603e1    	mov	x1, x22
104a830e4: 94c69016    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a830e8: aa1d03fd    	mov	x29, x29
104a830ec: 94c69017    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a830f0: aa0003f9    	mov	x25, x0
104a830f4: f00da748    	adrp	x8, 0x11ff6e000 <dyld_stub_binder+0x11ff6e000>
104a830f8: f9416d01    	ldr	x1, [x8, #0x2d8] ; isMultiRedTipsEnable
104a830fc: 94c69010    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a83100: aa0003fa    	mov	x26, x0
104a83104: aa1903e0    	mov	x0, x25
104a83108: 94c69013    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8310c: aa1703e0    	mov	x0, x23
104a83110: 94c69011    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a83114: 340003ba    	cbz	w26, 0x104a83188 <_Flutter_MMFoundation_BindContext+0xf5ed6c>
104a83118: f945eb60    	ldr	x0, [x27, #0xbd0] ; MMContext
104a8311c: aa1403e1    	mov	x1, x20
104a83120: 94c69007    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a83124: aa1d03fd    	mov	x29, x29
104a83128: 94c69008    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8312c: aa0003f4    	mov	x20, x0
104a83130: f945b780    	ldr	x0, [x28, #0xb68] ; MsgRedTipsMgr
104a83134: aa1503e1    	mov	x1, x21
104a83138: 94c69001    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8313c: aa0003e2    	mov	x2, x0
104a83140: aa1403e0    	mov	x0, x20
104a83144: aa1603e1    	mov	x1, x22
104a83148: 94c68ffd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8314c: aa1d03fd    	mov	x29, x29
104a83150: 94c68ffe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a83154: aa0003f5    	mov	x21, x0
104a83158: b00da808    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a8315c: f9427d01    	ldr	x1, [x8, #0x4f8] ; migrateRedTipsFromSession:
104a83160: aa1303e2    	mov	x2, x19
104a83164: 94c68ff6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a83168: aa1503e0    	mov	x0, x21
104a8316c: 94c68ffa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a83170: aa1403e0    	mov	x0, x20
104a83174: 94c68ff8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a83178: b00da808    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a8317c: f9418501    	ldr	x1, [x8, #0x308] ; updateRedTips
104a83180: aa1803e0    	mov	x0, x24
104a83184: 94c68fee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a83188: aa1303e0    	mov	x0, x19
104a8318c: 94c68ff2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a83190: aa1803e0    	mov	x0, x24
104a83194: a9487bfd    	ldp	x29, x30, [sp, #0x80]
104a83198: a9474ff4    	ldp	x20, x19, [sp, #0x70]
104a8319c: a94657f6    	ldp	x22, x21, [sp, #0x60]
104a831a0: a9455ff8    	ldp	x24, x23, [sp, #0x50]
104a831a4: a94467fa    	ldp	x26, x25, [sp, #0x40]
104a831a8: a9436ffc    	ldp	x28, x27, [sp, #0x30]
104a831ac: 910243ff    	add	sp, sp, #0x90
104a831b0: 14c68ff0    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
