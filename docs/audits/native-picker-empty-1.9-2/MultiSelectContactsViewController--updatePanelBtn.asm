
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104e9f94c: d102c3ff    	sub	sp, sp, #0xb0
104e9f950: a9056ffc    	stp	x28, x27, [sp, #0x50]
104e9f954: a90667fa    	stp	x26, x25, [sp, #0x60]
104e9f958: a9075ff8    	stp	x24, x23, [sp, #0x70]
104e9f95c: a90857f6    	stp	x22, x21, [sp, #0x80]
104e9f960: a9094ff4    	stp	x20, x19, [sp, #0x90]
104e9f964: a90a7bfd    	stp	x29, x30, [sp, #0xa0]
104e9f968: 910283fd    	add	x29, sp, #0xa0
104e9f96c: aa0003f3    	mov	x19, x0
104e9f970: 900ded08    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
104e9f974: 52800029    	mov	w9, #0x1                ; =1
104e9f978: 39078509    	strb	w9, [x8, #0x1e1]
104e9f97c: d00d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104e9f980: f9469101    	ldr	x1, [x8, #0xd20] ; embeddedInContainer
104e9f984: 94b61dee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9f988: 340005e0    	cbz	w0, 0x104e9fa44 <_Flutter_MMFoundation_BindContext+0x137b628>
104e9f98c: d00d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104e9f990: f9469514    	ldr	x20, [x8, #0xd28] ; selectedContactsDidChangeBlock
104e9f994: aa1303e0    	mov	x0, x19
104e9f998: aa1403e1    	mov	x1, x20
104e9f99c: 94b61de8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9f9a0: aa1d03fd    	mov	x29, x29
104e9f9a4: 94b61de9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9f9a8: aa0003f5    	mov	x21, x0
104e9f9ac: 94b61dea    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9f9b0: b4000555    	cbz	x21, 0x104e9fa58 <_Flutter_MMFoundation_BindContext+0x137b63c>
104e9f9b4: f00d9c28    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9f9b8: b9885108    	ldrsw	x8, [x8, #0x850]
104e9f9bc: f8686a60    	ldr	x0, [x19, x8]
104e9f9c0: d00d7e48    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104e9f9c4: f9415501    	ldr	x1, [x8, #0x2a8] ; m_dicMultiSelect
104e9f9c8: 94b61ddd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9f9cc: aa1d03fd    	mov	x29, x29
104e9f9d0: 94b61dde    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9f9d4: aa0003f6    	mov	x22, x0
104e9f9d8: 900d9308    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104e9f9dc: f9401101    	ldr	x1, [x8, #0x20] ; allValues
104e9f9e0: 94b61dd7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9f9e4: aa1d03fd    	mov	x29, x29
104e9f9e8: 94b61dd8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9f9ec: aa0003f7    	mov	x23, x0
104e9f9f0: d00c3a88    	adrp	x8, 0x11d5f1000 <dyld_stub_binder+0x11d5f1000>
104e9f9f4: f940e108    	ldr	x8, [x8, #0x1c0]
104e9f9f8: f9400108    	ldr	x8, [x8]
104e9f9fc: f100001f    	cmp	x0, #0x0
104e9fa00: 9a800115    	csel	x21, x8, x0, eq
104e9fa04: aa1503e0    	mov	x0, x21
104e9fa08: 94b61dcc    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104e9fa0c: aa1703e0    	mov	x0, x23
104e9fa10: 94b61dd1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9fa14: aa1603e0    	mov	x0, x22
104e9fa18: 94b61dcf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9fa1c: aa1303e0    	mov	x0, x19
104e9fa20: aa1403e1    	mov	x1, x20
104e9fa24: 94b61dc6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fa28: aa1d03fd    	mov	x29, x29
104e9fa2c: 94b61dc7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9fa30: aa0003fa    	mov	x26, x0
104e9fa34: f9400808    	ldr	x8, [x0, #0x10]
104e9fa38: aa1503e1    	mov	x1, x21
104e9fa3c: d63f0100    	blr	x8
104e9fa40: 140002f4    	b	0x104ea0610 <_Flutter_MMFoundation_BindContext+0x137c1f4>
104e9fa44: d00d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104e9fa48: f9469901    	ldr	x1, [x8, #0xd30] ; m_bSearchSnsContact
104e9fa4c: aa1303e0    	mov	x0, x19
104e9fa50: 94b61dbb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fa54: 36000120    	tbz	w0, #0x0, 0x104e9fa78 <_Flutter_MMFoundation_BindContext+0x137b65c>
104e9fa58: a94a7bfd    	ldp	x29, x30, [sp, #0xa0]
104e9fa5c: a9494ff4    	ldp	x20, x19, [sp, #0x90]
104e9fa60: a94857f6    	ldp	x22, x21, [sp, #0x80]
104e9fa64: a9475ff8    	ldp	x24, x23, [sp, #0x70]
104e9fa68: a94667fa    	ldp	x26, x25, [sp, #0x60]
104e9fa6c: a9456ffc    	ldp	x28, x27, [sp, #0x50]
104e9fa70: 9102c3ff    	add	sp, sp, #0xb0
104e9fa74: d65f03c0    	ret
104e9fa78: 900d96a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104e9fa7c: f945e900    	ldr	x0, [x8, #0xbd0]
104e9fa80: b00d9308    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104e9fa84: f944e915    	ldr	x21, [x8, #0x9d0] ; currentContext
104e9fa88: aa1503e1    	mov	x1, x21
104e9fa8c: 94b61dac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fa90: aa1d03fd    	mov	x29, x29
104e9fa94: 94b61dad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9fa98: aa0003f9    	mov	x25, x0
104e9fa9c: 900d96b4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
104e9faa0: f9462a80    	ldr	x0, [x20, #0xc50]
104e9faa4: 900d9308    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104e9faa8: f947ad16    	ldr	x22, [x8, #0xf58] ; class
104e9faac: aa1603e1    	mov	x1, x22
104e9fab0: 94b61da3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fab4: aa0003e2    	mov	x2, x0
104e9fab8: d00d7cc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104e9fabc: f9464117    	ldr	x23, [x8, #0xc80] ; getService:
104e9fac0: aa1903e0    	mov	x0, x25
104e9fac4: aa1703e1    	mov	x1, x23
104e9fac8: 94b61d9d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9facc: aa1d03fd    	mov	x29, x29
104e9fad0: 94b61d9e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9fad4: aa0003fa    	mov	x26, x0
104e9fad8: d00d7cc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104e9fadc: f9464518    	ldr	x24, [x8, #0xc88] ; getStringForCurLanguage:
104e9fae0: b00cb002    	adrp	x2, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
104e9fae4: 91042042    	add	x2, x2, #0x108
104e9fae8: aa1803e1    	mov	x1, x24
104e9faec: 94b61d94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9faf0: aa1d03fd    	mov	x29, x29
104e9faf4: 94b61d95    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9faf8: aa0003fc    	mov	x28, x0
104e9fafc: aa1a03e0    	mov	x0, x26
104e9fb00: 94b61d95    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9fb04: aa1903e0    	mov	x0, x25
104e9fb08: 94b61d93    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9fb0c: f00d8148    	adrp	x8, 0x11feca000 <dyld_stub_binder+0x11feca000>
104e9fb10: f944c919    	ldr	x25, [x8, #0x990] ; m_rightBarButtonTitle
104e9fb14: aa1303e0    	mov	x0, x19
104e9fb18: aa1903e1    	mov	x1, x25
104e9fb1c: 94b61d88    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fb20: aa1d03fd    	mov	x29, x29
104e9fb24: 94b61d89    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9fb28: aa0003fa    	mov	x26, x0
104e9fb2c: 900d9328    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104e9fb30: f946e901    	ldr	x1, [x8, #0xdd0] ; length
104e9fb34: 94b61d82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fb38: aa0003fb    	mov	x27, x0
104e9fb3c: aa1a03e0    	mov	x0, x26
104e9fb40: 94b61d85    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9fb44: f00d7da8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
104e9fb48: b400013b    	cbz	x27, 0x104e9fb6c <_Flutter_MMFoundation_BindContext+0x137b750>
104e9fb4c: aa1303e0    	mov	x0, x19
104e9fb50: aa1903e1    	mov	x1, x25
104e9fb54: 94b61d7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fb58: aa1d03fd    	mov	x29, x29
104e9fb5c: 94b61d7b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9fb60: aa0003fb    	mov	x27, x0
104e9fb64: aa1c03e0    	mov	x0, x28
104e9fb68: 14000024    	b	0x104e9fbf8 <_Flutter_MMFoundation_BindContext+0x137b7dc>
104e9fb6c: aa1403fa    	mov	x26, x20
104e9fb70: 900d96b4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
104e9fb74: f942c101    	ldr	x1, [x8, #0x580] ; m_uiGroupScene
104e9fb78: aa1303e0    	mov	x0, x19
104e9fb7c: 94b61d70    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fb80: 7100641f    	cmp	w0, #0x19
104e9fb84: 54001aa1    	b.ne	0x104e9fed8 <_Flutter_MMFoundation_BindContext+0x137babc>
104e9fb88: f945ea80    	ldr	x0, [x20, #0xbd0]
104e9fb8c: aa1503e1    	mov	x1, x21
104e9fb90: 94b61d6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fb94: aa1d03fd    	mov	x29, x29
104e9fb98: 94b61d6c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9fb9c: aa0003f9    	mov	x25, x0
104e9fba0: f9462b40    	ldr	x0, [x26, #0xc50]
104e9fba4: aa1603e1    	mov	x1, x22
104e9fba8: 94b61d65    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fbac: aa0003e2    	mov	x2, x0
104e9fbb0: aa1903e0    	mov	x0, x25
104e9fbb4: aa1703e1    	mov	x1, x23
104e9fbb8: 94b61d61    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fbbc: aa1d03fd    	mov	x29, x29
104e9fbc0: 94b61d62    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9fbc4: aa0003f6    	mov	x22, x0
104e9fbc8: 900cb002    	adrp	x2, 0x11e49f000 <dyld_stub_binder+0x11e49f000>
104e9fbcc: 91292042    	add	x2, x2, #0xa48
104e9fbd0: aa1803e1    	mov	x1, x24
104e9fbd4: 94b61d5a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fbd8: aa1d03fd    	mov	x29, x29
104e9fbdc: 94b61d5b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9fbe0: aa0003fb    	mov	x27, x0
104e9fbe4: aa1c03e0    	mov	x0, x28
104e9fbe8: 94b61d5b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9fbec: aa1603e0    	mov	x0, x22
104e9fbf0: 94b61d59    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9fbf4: aa1903e0    	mov	x0, x25
104e9fbf8: 94b61d57    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9fbfc: d00d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104e9fc00: f9469d01    	ldr	x1, [x8, #0xd38] ; m_onlyChatRoom
104e9fc04: aa1303e0    	mov	x0, x19
104e9fc08: 94b61d4d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fc0c: aa0003f7    	mov	x23, x0
104e9fc10: f00d9c28    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9fc14: b988511a    	ldrsw	x26, [x8, #0x850]
104e9fc18: f87a6a60    	ldr	x0, [x19, x26]
104e9fc1c: d00d7e48    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104e9fc20: f9415515    	ldr	x21, [x8, #0x2a8] ; m_dicMultiSelect
104e9fc24: aa1503e1    	mov	x1, x21
104e9fc28: 94b61d45    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fc2c: aa1d03fd    	mov	x29, x29
104e9fc30: 94b61d46    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9fc34: aa0003f8    	mov	x24, x0
104e9fc38: b00d9308    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104e9fc3c: f9435116    	ldr	x22, [x8, #0x6a0] ; count
104e9fc40: aa1603e1    	mov	x1, x22
104e9fc44: 94b61d3e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fc48: aa0003f9    	mov	x25, x0
104e9fc4c: aa1803e0    	mov	x0, x24
104e9fc50: 94b61d41    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9fc54: eb37433f    	cmp	x25, w23, uxtw
104e9fc58: 54000629    	b.ls	0x104e9fd1c <_Flutter_MMFoundation_BindContext+0x137b900>
104e9fc5c: aa1b03e0    	mov	x0, x27
104e9fc60: 94b61d36    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104e9fc64: f00d7da8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
104e9fc68: f942b517    	ldr	x23, [x8, #0x568] ; m_memberCountLimit
104e9fc6c: aa1303e0    	mov	x0, x19
104e9fc70: aa1703e1    	mov	x1, x23
104e9fc74: 94b61d32    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fc78: d00d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104e9fc7c: f946a118    	ldr	x24, [x8, #0xd40] ; m_rightBarButtonSelectedStyle
104e9fc80: b4000a00    	cbz	x0, 0x104e9fdc0 <_Flutter_MMFoundation_BindContext+0x137b9a4>
104e9fc84: aa1303e0    	mov	x0, x19
104e9fc88: aa1803e1    	mov	x1, x24
104e9fc8c: 94b61d2c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fc90: f100081f    	cmp	x0, #0x2
104e9fc94: 540000e0    	b.eq	0x104e9fcb0 <_Flutter_MMFoundation_BindContext+0x137b894>
104e9fc98: f00d7da8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
104e9fc9c: f942c101    	ldr	x1, [x8, #0x580] ; m_uiGroupScene
104e9fca0: aa1303e0    	mov	x0, x19
104e9fca4: 94b61d26    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fca8: 7100581f    	cmp	w0, #0x16
104e9fcac: 540008a1    	b.ne	0x104e9fdc0 <_Flutter_MMFoundation_BindContext+0x137b9a4>
104e9fcb0: 900d96a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104e9fcb4: f9454518    	ldr	x24, [x8, #0xa88]
104e9fcb8: f87a6a60    	ldr	x0, [x19, x26]
104e9fcbc: aa1503e1    	mov	x1, x21
104e9fcc0: 94b61d1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fcc4: aa1d03fd    	mov	x29, x29
104e9fcc8: 94b61d20    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9fccc: aa0003f5    	mov	x21, x0
104e9fcd0: aa1603e1    	mov	x1, x22
104e9fcd4: 94b61d1a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fcd8: aa0003f6    	mov	x22, x0
104e9fcdc: aa1303e0    	mov	x0, x19
104e9fce0: aa1703e1    	mov	x1, x23
104e9fce4: 94b61d16    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fce8: f00d9348    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104e9fcec: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
104e9fcf0: a90083f6    	stp	x22, x0, [sp, #0x8]
104e9fcf4: f90003fb    	str	x27, [sp]
104e9fcf8: 900cb1a2    	adrp	x2, 0x11e4d3000 <dyld_stub_binder+0x11e4d3000>
104e9fcfc: 910d2042    	add	x2, x2, #0x348
104e9fd00: aa1803e0    	mov	x0, x24
104e9fd04: 94b61d0e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fd08: aa1d03fd    	mov	x29, x29
104e9fd0c: 94b61d0f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9fd10: aa0003f6    	mov	x22, x0
104e9fd14: aa1b03f8    	mov	x24, x27
104e9fd18: 1400006b    	b	0x104e9fec4 <_Flutter_MMFoundation_BindContext+0x137baa8>
104e9fd1c: 900d96a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104e9fd20: f947d915    	ldr	x21, [x8, #0xfb0]
104e9fd24: f00d7da8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
104e9fd28: f942b919    	ldr	x25, [x8, #0x570] ; onDone:
104e9fd2c: b00d7f48    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
104e9fd30: f940751a    	ldr	x26, [x8, #0xe8] ; colorProxy
104e9fd34: aa1303e0    	mov	x0, x19
104e9fd38: aa1a03e1    	mov	x1, x26
104e9fd3c: 94b61d00    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fd40: aa1d03fd    	mov	x29, x29
104e9fd44: 94b61d01    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9fd48: aa0003f6    	mov	x22, x0
104e9fd4c: b00d7ce8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104e9fd50: f9405901    	ldr	x1, [x8, #0xb0] ; Brand_100
104e9fd54: 94b61cfa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fd58: aa1d03fd    	mov	x29, x29
104e9fd5c: 94b61cfb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9fd60: aa0003f7    	mov	x23, x0
104e9fd64: b00d7d28    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104e9fd68: f940c101    	ldr	x1, [x8, #0x180] ; getBarButtonWithTitle:target:action:style:color:
104e9fd6c: aa1503e0    	mov	x0, x21
104e9fd70: aa1b03e2    	mov	x2, x27
104e9fd74: aa1303e3    	mov	x3, x19
104e9fd78: aa1903e4    	mov	x4, x25
104e9fd7c: 528000a5    	mov	w5, #0x5                ; =5
104e9fd80: aa1703e6    	mov	x6, x23
104e9fd84: 94b61cee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fd88: aa1d03fd    	mov	x29, x29
104e9fd8c: 94b61cef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9fd90: aa0003f5    	mov	x21, x0
104e9fd94: aa1703e0    	mov	x0, x23
104e9fd98: 94b61cef    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9fd9c: aa1603e0    	mov	x0, x22
104e9fda0: 94b61ced    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9fda4: 900d9348    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
104e9fda8: f946bd17    	ldr	x23, [x8, #0xd78] ; setEnabled:
104e9fdac: aa1503e0    	mov	x0, x21
104e9fdb0: aa1703e1    	mov	x1, x23
104e9fdb4: 52800002    	mov	w2, #0x0                ; =0
104e9fdb8: 94b61ce1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fdbc: 14000074    	b	0x104e9ff8c <_Flutter_MMFoundation_BindContext+0x137bb70>
104e9fdc0: aa1303e0    	mov	x0, x19
104e9fdc4: aa1803e1    	mov	x1, x24
104e9fdc8: 94b61cdd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fdcc: f100041f    	cmp	x0, #0x1
104e9fdd0: 54000881    	b.ne	0x104e9fee0 <_Flutter_MMFoundation_BindContext+0x137bac4>
104e9fdd4: 900d96b4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
104e9fdd8: f9454698    	ldr	x24, [x20, #0xa88]
104e9fddc: f87a6a60    	ldr	x0, [x19, x26]
104e9fde0: aa1503e1    	mov	x1, x21
104e9fde4: 94b61cd6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fde8: aa1d03fd    	mov	x29, x29
104e9fdec: 94b61cd7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9fdf0: aa0003f9    	mov	x25, x0
104e9fdf4: aa1603e1    	mov	x1, x22
104e9fdf8: 94b61cd1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fdfc: f00d9348    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104e9fe00: f946a517    	ldr	x23, [x8, #0xd48] ; stringWithFormat:
104e9fe04: a90003fb    	stp	x27, x0, [sp]
104e9fe08: f00cb202    	adrp	x2, 0x11e4e2000 <dyld_stub_binder+0x11e4e2000>
104e9fe0c: 91222042    	add	x2, x2, #0x888
104e9fe10: aa1803e0    	mov	x0, x24
104e9fe14: aa1703e1    	mov	x1, x23
104e9fe18: 94b61cc9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fe1c: aa1d03fd    	mov	x29, x29
104e9fe20: 94b61cca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9fe24: aa0003f6    	mov	x22, x0
104e9fe28: aa1b03e0    	mov	x0, x27
104e9fe2c: 94b61cca    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9fe30: aa1903e0    	mov	x0, x25
104e9fe34: 94b61cc8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9fe38: b00d7f48    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
104e9fe3c: f941b101    	ldr	x1, [x8, #0x360] ; m_onlyImportChatRoom
104e9fe40: aa1303e0    	mov	x0, x19
104e9fe44: 94b61cbe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fe48: 340004e0    	cbz	w0, 0x104e9fee4 <_Flutter_MMFoundation_BindContext+0x137bac8>
104e9fe4c: f9454699    	ldr	x25, [x20, #0xa88]
104e9fe50: f87a6a60    	ldr	x0, [x19, x26]
104e9fe54: aa1503e1    	mov	x1, x21
104e9fe58: 94b61cb9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fe5c: aa1d03fd    	mov	x29, x29
104e9fe60: 94b61cba    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9fe64: aa0003f5    	mov	x21, x0
104e9fe68: 900d9308    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104e9fe6c: f9401101    	ldr	x1, [x8, #0x20] ; allValues
104e9fe70: 94b61cb3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fe74: aa1d03fd    	mov	x29, x29
104e9fe78: 94b61cb4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9fe7c: aa0003f8    	mov	x24, x0
104e9fe80: d00d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104e9fe84: f946a501    	ldr	x1, [x8, #0xd48] ; getContactFromImportGroup:
104e9fe88: aa1303e0    	mov	x0, x19
104e9fe8c: aa1803e2    	mov	x2, x24
104e9fe90: 94b61cab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fe94: a90003fb    	stp	x27, x0, [sp]
104e9fe98: f00cb202    	adrp	x2, 0x11e4e2000 <dyld_stub_binder+0x11e4e2000>
104e9fe9c: 91222042    	add	x2, x2, #0x888
104e9fea0: aa1903e0    	mov	x0, x25
104e9fea4: aa1703e1    	mov	x1, x23
104e9fea8: 94b61ca5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9feac: aa1d03fd    	mov	x29, x29
104e9feb0: 94b61ca6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9feb4: aa0003f7    	mov	x23, x0
104e9feb8: aa1603e0    	mov	x0, x22
104e9febc: 94b61ca6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9fec0: aa1703f6    	mov	x22, x23
104e9fec4: aa1803e0    	mov	x0, x24
104e9fec8: 94b61ca3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9fecc: aa1503e0    	mov	x0, x21
104e9fed0: 94b61ca1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9fed4: 14000004    	b	0x104e9fee4 <_Flutter_MMFoundation_BindContext+0x137bac8>
104e9fed8: aa1c03fb    	mov	x27, x28
104e9fedc: 17ffff48    	b	0x104e9fbfc <_Flutter_MMFoundation_BindContext+0x137b7e0>
104e9fee0: aa1b03f6    	mov	x22, x27
104e9fee4: 900d96a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104e9fee8: f947d915    	ldr	x21, [x8, #0xfb0]
104e9feec: f00d7da8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
104e9fef0: f942b919    	ldr	x25, [x8, #0x570] ; onDone:
104e9fef4: b00d7f48    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
104e9fef8: f940751a    	ldr	x26, [x8, #0xe8] ; colorProxy
104e9fefc: aa1303e0    	mov	x0, x19
104e9ff00: aa1a03e1    	mov	x1, x26
104e9ff04: 94b61c8e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9ff08: aa1d03fd    	mov	x29, x29
104e9ff0c: 94b61c8f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9ff10: aa0003f7    	mov	x23, x0
104e9ff14: b00d7ce8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104e9ff18: f9405901    	ldr	x1, [x8, #0xb0] ; Brand_100
104e9ff1c: 94b61c88    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9ff20: aa1d03fd    	mov	x29, x29
104e9ff24: 94b61c89    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9ff28: aa0003f8    	mov	x24, x0
104e9ff2c: b00d7d28    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104e9ff30: f940c101    	ldr	x1, [x8, #0x180] ; getBarButtonWithTitle:target:action:style:color:
104e9ff34: aa1503e0    	mov	x0, x21
104e9ff38: aa1603e2    	mov	x2, x22
104e9ff3c: aa1303e3    	mov	x3, x19
104e9ff40: aa1903e4    	mov	x4, x25
104e9ff44: 528000a5    	mov	w5, #0x5                ; =5
104e9ff48: aa1803e6    	mov	x6, x24
104e9ff4c: 94b61c7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9ff50: aa1d03fd    	mov	x29, x29
104e9ff54: 94b61c7d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9ff58: aa0003f5    	mov	x21, x0
104e9ff5c: aa1803e0    	mov	x0, x24
104e9ff60: 94b61c7d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9ff64: aa1703e0    	mov	x0, x23
104e9ff68: 94b61c7b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9ff6c: 900d9348    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
104e9ff70: f946bd17    	ldr	x23, [x8, #0xd78] ; setEnabled:
104e9ff74: aa1503e0    	mov	x0, x21
104e9ff78: aa1703e1    	mov	x1, x23
104e9ff7c: 52800022    	mov	w2, #0x1                ; =1
104e9ff80: 94b61c6f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9ff84: aa1603e0    	mov	x0, x22
104e9ff88: 94b61c73    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9ff8c: f90027fb    	str	x27, [sp, #0x48]
104e9ff90: f00d7da8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
104e9ff94: f942c116    	ldr	x22, [x8, #0x580] ; m_uiGroupScene
104e9ff98: aa1303e0    	mov	x0, x19
104e9ff9c: aa1603e1    	mov	x1, x22
104e9ffa0: 94b61c67    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9ffa4: 7100a01f    	cmp	w0, #0x28
104e9ffa8: 540000c0    	b.eq	0x104e9ffc0 <_Flutter_MMFoundation_BindContext+0x137bba4>
104e9ffac: aa1303e0    	mov	x0, x19
104e9ffb0: aa1603e1    	mov	x1, x22
104e9ffb4: 94b61c62    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9ffb8: 7100541f    	cmp	w0, #0x15
104e9ffbc: 540001c1    	b.ne	0x104e9fff4 <_Flutter_MMFoundation_BindContext+0x137bbd8>
104e9ffc0: f00d7d48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104e9ffc4: f940cd01    	ldr	x1, [x8, #0x198] ; pageSheetAdapter
104e9ffc8: aa1303e0    	mov	x0, x19
104e9ffcc: 94b61c5c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9ffd0: aa1d03fd    	mov	x29, x29
104e9ffd4: 94b61c5d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9ffd8: aa0003f8    	mov	x24, x0
104e9ffdc: 94b61c5e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9ffe0: b50000b8    	cbnz	x24, 0x104e9fff4 <_Flutter_MMFoundation_BindContext+0x137bbd8>
104e9ffe4: aa1503e0    	mov	x0, x21
104e9ffe8: aa1703e1    	mov	x1, x23
104e9ffec: 52800022    	mov	w2, #0x1                ; =1
104e9fff0: 94b61c53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9fff4: f00d7da8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
104e9fff8: f942bd01    	ldr	x1, [x8, #0x578] ; setM_panelBtnItem:
104e9fffc: aa1303e0    	mov	x0, x19
104ea0000: f90023e1    	str	x1, [sp, #0x40]
104ea0004: aa1503e2    	mov	x2, x21
104ea0008: 94b61c4d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea000c: b00d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea0010: f946a91b    	ldr	x27, [x8, #0xd50] ; selectionPreviewViewController
104ea0014: aa1303e0    	mov	x0, x19
104ea0018: aa1b03e1    	mov	x1, x27
104ea001c: 94b61c48    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0020: aa1d03fd    	mov	x29, x29
104ea0024: 94b61c49    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea0028: aa0003fc    	mov	x28, x0
104ea002c: 94b61c4a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea0030: 900d9334    	adrp	x20, 0x120104000 <dyld_stub_binder+0x120104000>
104ea0034: b40001dc    	cbz	x28, 0x104ea006c <_Flutter_MMFoundation_BindContext+0x137bc50>
104ea0038: aa1303e0    	mov	x0, x19
104ea003c: aa1b03e1    	mov	x1, x27
104ea0040: 94b61c3f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0044: aa1d03fd    	mov	x29, x29
104ea0048: 94b61c40    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea004c: aa0003f9    	mov	x25, x0
104ea0050: b00d7e48    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104ea0054: f9417101    	ldr	x1, [x8, #0x2e0] ; updateWithCompleteBarButtonItem:
104ea0058: aa1503e2    	mov	x2, x21
104ea005c: 94b61c38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0060: aa1903e0    	mov	x0, x25
104ea0064: 94b61c3c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea0068: 140000e7    	b	0x104ea0404 <_Flutter_MMFoundation_BindContext+0x137bfe8>
104ea006c: d00d9c28    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea0070: b9886114    	ldrsw	x20, [x8, #0x860]
104ea0074: f8746a60    	ldr	x0, [x19, x20]
104ea0078: d00d9348    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104ea007c: f9475d01    	ldr	x1, [x8, #0xeb8] ; superview
104ea0080: 94b61c2f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0084: aa1d03fd    	mov	x29, x29
104ea0088: 94b61c30    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea008c: aa0003fb    	mov	x27, x0
104ea0090: 94b61c31    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea0094: b40000fb    	cbz	x27, 0x104ea00b0 <_Flutter_MMFoundation_BindContext+0x137bc94>
104ea0098: f8746a60    	ldr	x0, [x19, x20]
104ea009c: b00d7e48    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104ea00a0: f9417101    	ldr	x1, [x8, #0x2e0] ; updateWithCompleteBarButtonItem:
104ea00a4: aa1503e2    	mov	x2, x21
104ea00a8: 94b61c25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea00ac: 140000d5    	b	0x104ea0400 <_Flutter_MMFoundation_BindContext+0x137bfe4>
104ea00b0: d00d7d48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104ea00b4: f940cd14    	ldr	x20, [x8, #0x198] ; pageSheetAdapter
104ea00b8: aa1303e0    	mov	x0, x19
104ea00bc: aa1403e1    	mov	x1, x20
104ea00c0: 94b61c1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea00c4: aa1d03fd    	mov	x29, x29
104ea00c8: 94b61c20    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea00cc: aa0003fc    	mov	x28, x0
104ea00d0: 94b61c21    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea00d4: d00d9c28    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea00d8: b9886508    	ldrsw	x8, [x8, #0x864]
104ea00dc: f8686a7b    	ldr	x27, [x19, x8]
104ea00e0: b4002afc    	cbz	x28, 0x104ea063c <_Flutter_MMFoundation_BindContext+0x137c220>
104ea00e4: d00d7d08    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
104ea00e8: f9415d01    	ldr	x1, [x8, #0x2b8] ; m_btn
104ea00ec: aa1b03e0    	mov	x0, x27
104ea00f0: 94b61c13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea00f4: aa1d03fd    	mov	x29, x29
104ea00f8: 94b61c14    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea00fc: a902d3e0    	stp	x0, x20, [sp, #0x28]
104ea0100: 900d96a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104ea0104: f940b500    	ldr	x0, [x8, #0x168]
104ea0108: 94b61c14    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104ea010c: f00d9328    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
104ea0110: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
104ea0114: aa0003f4    	mov	x20, x0
104ea0118: f9001fe0    	str	x0, [sp, #0x38]
104ea011c: d2800002    	mov	x2, #0x0                ; =0
104ea0120: 94b61c07    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0124: aa1303e0    	mov	x0, x19
104ea0128: aa1a03e1    	mov	x1, x26
104ea012c: 94b61c04    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0130: aa1d03fd    	mov	x29, x29
104ea0134: 94b61c05    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea0138: aa0003fc    	mov	x28, x0
104ea013c: b00d7cc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104ea0140: f946491b    	ldr	x27, [x8, #0xc90] ; Link_100
104ea0144: aa1b03e1    	mov	x1, x27
104ea0148: f90013fb    	str	x27, [sp, #0x20]
104ea014c: 94b61bfc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0150: aa1d03fd    	mov	x29, x29
104ea0154: 94b61bfd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea0158: aa0003f8    	mov	x24, x0
104ea015c: b00d9348    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104ea0160: f9472901    	ldr	x1, [x8, #0xe50] ; setTitleColor:forState:
104ea0164: aa1403e0    	mov	x0, x20
104ea0168: aa0103f4    	mov	x20, x1
104ea016c: aa1803e2    	mov	x2, x24
104ea0170: d2800003    	mov	x3, #0x0                ; =0
104ea0174: 94b61bf2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0178: aa1803e0    	mov	x0, x24
104ea017c: 94b61bf6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea0180: aa1c03e0    	mov	x0, x28
104ea0184: 94b61bf4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea0188: aa1303e0    	mov	x0, x19
104ea018c: aa1a03e1    	mov	x1, x26
104ea0190: 94b61beb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0194: aa1d03fd    	mov	x29, x29
104ea0198: 94b61bec    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea019c: aa0003f8    	mov	x24, x0
104ea01a0: aa1b03e1    	mov	x1, x27
104ea01a4: 94b61be6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea01a8: aa1d03fd    	mov	x29, x29
104ea01ac: 94b61be7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea01b0: aa0003fc    	mov	x28, x0
104ea01b4: 900d7d08    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104ea01b8: f946f901    	ldr	x1, [x8, #0xdf0] ; Alpha0_6
104ea01bc: 94b61be0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea01c0: aa1d03fd    	mov	x29, x29
104ea01c4: 94b61be1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea01c8: aa0003fb    	mov	x27, x0
104ea01cc: f9401fe0    	ldr	x0, [sp, #0x38]
104ea01d0: aa1403e1    	mov	x1, x20
104ea01d4: aa1b03e2    	mov	x2, x27
104ea01d8: 52800023    	mov	w3, #0x1                ; =1
104ea01dc: 94b61bd8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea01e0: aa1b03e0    	mov	x0, x27
104ea01e4: 94b61bdc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea01e8: aa1c03e0    	mov	x0, x28
104ea01ec: 94b61bda    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea01f0: aa1803e0    	mov	x0, x24
104ea01f4: 94b61bd8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea01f8: aa1303e0    	mov	x0, x19
104ea01fc: aa1a03e1    	mov	x1, x26
104ea0200: 94b61bcf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0204: aa1d03fd    	mov	x29, x29
104ea0208: 94b61bd0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea020c: aa0003f8    	mov	x24, x0
104ea0210: f94013e1    	ldr	x1, [sp, #0x20]
104ea0214: 94b61bca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0218: aa1d03fd    	mov	x29, x29
104ea021c: 94b61bcb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea0220: aa0003fa    	mov	x26, x0
104ea0224: b00d7d88    	adrp	x8, 0x11fe51000 <dyld_stub_binder+0x11fe51000>
104ea0228: f9479101    	ldr	x1, [x8, #0xf20] ; Alpha0_3
104ea022c: 94b61bc4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0230: aa1d03fd    	mov	x29, x29
104ea0234: 94b61bc5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea0238: aa0003fb    	mov	x27, x0
104ea023c: f9401ffc    	ldr	x28, [sp, #0x38]
104ea0240: aa1c03e0    	mov	x0, x28
104ea0244: aa1403e1    	mov	x1, x20
104ea0248: aa1b03e2    	mov	x2, x27
104ea024c: 52800043    	mov	w3, #0x2                ; =2
104ea0250: 94b61bbb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0254: aa1b03e0    	mov	x0, x27
104ea0258: 94b61bbf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea025c: aa1a03e0    	mov	x0, x26
104ea0260: 94b61bbd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea0264: aa1803e0    	mov	x0, x24
104ea0268: 94b61bbb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea026c: f00d9328    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
104ea0270: f940ed18    	ldr	x24, [x8, #0x1d8] ; setBackgroundImage:forState:
104ea0274: aa1c03e0    	mov	x0, x28
104ea0278: aa1803e1    	mov	x1, x24
104ea027c: d2800002    	mov	x2, #0x0                ; =0
104ea0280: d2800003    	mov	x3, #0x0                ; =0
104ea0284: 94b61bae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0288: aa1c03e0    	mov	x0, x28
104ea028c: aa1803e1    	mov	x1, x24
104ea0290: d2800002    	mov	x2, #0x0                ; =0
104ea0294: 52800023    	mov	w3, #0x1                ; =1
104ea0298: 94b61ba9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea029c: b00d7d08    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
104ea02a0: f9431901    	ldr	x1, [x8, #0x630] ; isEnabled
104ea02a4: f94017f4    	ldr	x20, [sp, #0x28]
104ea02a8: aa1403e0    	mov	x0, x20
104ea02ac: 94b61ba4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea02b0: aa0003e2    	mov	x2, x0
104ea02b4: aa1c03e0    	mov	x0, x28
104ea02b8: aa1703e1    	mov	x1, x23
104ea02bc: 94b61ba0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea02c0: d00d92e8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
104ea02c4: f9477101    	ldr	x1, [x8, #0xee0] ; addTarget:action:forControlEvents:
104ea02c8: aa1c03e0    	mov	x0, x28
104ea02cc: aa1303e2    	mov	x2, x19
104ea02d0: aa1903e3    	mov	x3, x25
104ea02d4: 52800804    	mov	w4, #0x40               ; =64
104ea02d8: 94b61b99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea02dc: f00d9688    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104ea02e0: f9461918    	ldr	x24, [x8, #0xc30]
104ea02e4: d00d7e48    	adrp	x8, 0x11fe6a000 <dyld_stub_binder+0x11fe6a000>
104ea02e8: f9477501    	ldr	x1, [x8, #0xee8] ; dynamicFontSizeForNavigator:
104ea02ec: 1e661000    	fmov	d0, #16.00000000
104ea02f0: aa1803e0    	mov	x0, x24
104ea02f4: 94b61b92    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea02f8: d00d7d08    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
104ea02fc: f9460d01    	ldr	x1, [x8, #0xc18] ; mediumSystemFontOfSize:
104ea0300: aa1803e0    	mov	x0, x24
104ea0304: 94b61b8e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0308: aa1d03fd    	mov	x29, x29
104ea030c: 94b61b8f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea0310: aa0003f8    	mov	x24, x0
104ea0314: f00d9348    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104ea0318: f940d901    	ldr	x1, [x8, #0x1b0] ; titleLabel
104ea031c: aa1c03e0    	mov	x0, x28
104ea0320: 94b61b87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0324: aa1d03fd    	mov	x29, x29
104ea0328: 94b61b88    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea032c: aa0003f9    	mov	x25, x0
104ea0330: 900d9348    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104ea0334: f9400501    	ldr	x1, [x8, #0x8] ; setFont:
104ea0338: aa1803e2    	mov	x2, x24
104ea033c: 94b61b80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0340: aa1903e0    	mov	x0, x25
104ea0344: 94b61b84    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea0348: aa1803e0    	mov	x0, x24
104ea034c: 94b61b82    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea0350: d00d7d08    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
104ea0354: f9470501    	ldr	x1, [x8, #0xe08] ; titleForState:
104ea0358: aa1403e0    	mov	x0, x20
104ea035c: d2800002    	mov	x2, #0x0                ; =0
104ea0360: 94b61b77    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0364: aa1d03fd    	mov	x29, x29
104ea0368: 94b61b78    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea036c: aa0003f8    	mov	x24, x0
104ea0370: b00d9348    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104ea0374: f9472501    	ldr	x1, [x8, #0xe48] ; setTitle:forState:
104ea0378: aa1c03e0    	mov	x0, x28
104ea037c: aa1803e2    	mov	x2, x24
104ea0380: d2800003    	mov	x3, #0x0                ; =0
104ea0384: 94b61b6e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0388: aa1803e0    	mov	x0, x24
104ea038c: 94b61b72    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea0390: b00d7cc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104ea0394: f9465101    	ldr	x1, [x8, #0xca0] ; sizeToFit
104ea0398: aa1c03e0    	mov	x0, x28
104ea039c: 94b61b68    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea03a0: aa1303e0    	mov	x0, x19
104ea03a4: f9401be1    	ldr	x1, [sp, #0x30]
104ea03a8: 94b61b65    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea03ac: aa1d03fd    	mov	x29, x29
104ea03b0: 94b61b66    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea03b4: aa0003f8    	mov	x24, x0
104ea03b8: 900d7d68    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
104ea03bc: f943f901    	ldr	x1, [x8, #0x7f0] ; pageSheetConfig
104ea03c0: 94b61b5f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea03c4: aa1d03fd    	mov	x29, x29
104ea03c8: 94b61b60    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea03cc: aa0003f9    	mov	x25, x0
104ea03d0: f00d7da8    	adrp	x8, 0x11fe57000 <dyld_stub_binder+0x11fe57000>
104ea03d4: f9459501    	ldr	x1, [x8, #0xb28] ; setNavRightButton:
104ea03d8: aa1c03e2    	mov	x2, x28
104ea03dc: 94b61b58    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea03e0: aa1903e0    	mov	x0, x25
104ea03e4: 94b61b5c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea03e8: aa1803e0    	mov	x0, x24
104ea03ec: 94b61b5a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea03f0: aa1c03e0    	mov	x0, x28
104ea03f4: 94b61b58    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea03f8: aa1403e0    	mov	x0, x20
104ea03fc: 94b61b56    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea0400: 900d9334    	adrp	x20, 0x120104000 <dyld_stub_binder+0x120104000>
104ea0404: aa1303e0    	mov	x0, x19
104ea0408: aa1603e1    	mov	x1, x22
104ea040c: 94b61b4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0410: 7100581f    	cmp	w0, #0x16
104ea0414: f94027fa    	ldr	x26, [sp, #0x48]
104ea0418: 54000340    	b.eq	0x104ea0480 <_Flutter_MMFoundation_BindContext+0x137c064>
104ea041c: aa1303e0    	mov	x0, x19
104ea0420: aa1603e1    	mov	x1, x22
104ea0424: 94b61b46    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0428: 7100541f    	cmp	w0, #0x15
104ea042c: 540002a0    	b.eq	0x104ea0480 <_Flutter_MMFoundation_BindContext+0x137c064>
104ea0430: aa1303e0    	mov	x0, x19
104ea0434: aa1603e1    	mov	x1, x22
104ea0438: 94b61b41    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea043c: 7100601f    	cmp	w0, #0x18
104ea0440: 54000200    	b.eq	0x104ea0480 <_Flutter_MMFoundation_BindContext+0x137c064>
104ea0444: aa1303e0    	mov	x0, x19
104ea0448: aa1603e1    	mov	x1, x22
104ea044c: 94b61b3c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0450: 7100881f    	cmp	w0, #0x22
104ea0454: 54000160    	b.eq	0x104ea0480 <_Flutter_MMFoundation_BindContext+0x137c064>
104ea0458: aa1303e0    	mov	x0, x19
104ea045c: aa1603e1    	mov	x1, x22
104ea0460: 94b61b37    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0464: 7100941f    	cmp	w0, #0x25
104ea0468: 540000c0    	b.eq	0x104ea0480 <_Flutter_MMFoundation_BindContext+0x137c064>
104ea046c: aa1303e0    	mov	x0, x19
104ea0470: aa1603e1    	mov	x1, x22
104ea0474: 94b61b32    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0478: 71009c1f    	cmp	w0, #0x27
104ea047c: 54000281    	b.ne	0x104ea04cc <_Flutter_MMFoundation_BindContext+0x137c0b0>
104ea0480: f945e681    	ldr	x1, [x20, #0xbc8] ; navigationItem
104ea0484: aa1303e0    	mov	x0, x19
104ea0488: 94b61b2d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea048c: aa1d03fd    	mov	x29, x29
104ea0490: 94b61b2e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea0494: aa0003f8    	mov	x24, x0
104ea0498: f00d7cc8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104ea049c: f945e901    	ldr	x1, [x8, #0xbd0] ; rightBarButtonItem
104ea04a0: 94b61b27    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea04a4: aa1d03fd    	mov	x29, x29
104ea04a8: 94b61b28    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea04ac: aa0003f9    	mov	x25, x0
104ea04b0: aa1703e1    	mov	x1, x23
104ea04b4: 52800022    	mov	w2, #0x1                ; =1
104ea04b8: 94b61b21    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea04bc: aa1903e0    	mov	x0, x25
104ea04c0: 94b61b25    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea04c4: aa1803e0    	mov	x0, x24
104ea04c8: 94b61b23    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea04cc: d00d7d48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104ea04d0: f940c901    	ldr	x1, [x8, #0x190] ; isInPageSheetMode
104ea04d4: aa1303e0    	mov	x0, x19
104ea04d8: 94b61b19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea04dc: 340009a0    	cbz	w0, 0x104ea0610 <_Flutter_MMFoundation_BindContext+0x137c1f4>
104ea04e0: aa1403f8    	mov	x24, x20
104ea04e4: d00d9c28    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea04e8: b9886114    	ldrsw	x20, [x8, #0x860]
104ea04ec: f8746a60    	ldr	x0, [x19, x20]
104ea04f0: d00d9348    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104ea04f4: f9475d01    	ldr	x1, [x8, #0xeb8] ; superview
104ea04f8: 94b61b11    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea04fc: aa1d03fd    	mov	x29, x29
104ea0500: 94b61b12    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea0504: aa0003f7    	mov	x23, x0
104ea0508: 94b61b13    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea050c: b40000f7    	cbz	x23, 0x104ea0528 <_Flutter_MMFoundation_BindContext+0x137c10c>
104ea0510: f8746a60    	ldr	x0, [x19, x20]
104ea0514: b00d7e48    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104ea0518: f9417101    	ldr	x1, [x8, #0x2e0] ; updateWithCompleteBarButtonItem:
104ea051c: aa1503e2    	mov	x2, x21
104ea0520: 94b61b07    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0524: 14000018    	b	0x104ea0584 <_Flutter_MMFoundation_BindContext+0x137c168>
104ea0528: aa1303e0    	mov	x0, x19
104ea052c: f94023e1    	ldr	x1, [sp, #0x40]
104ea0530: aa1503e2    	mov	x2, x21
104ea0534: 94b61b02    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0538: d00d9c28    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea053c: b9886508    	ldrsw	x8, [x8, #0x864]
104ea0540: f8686a77    	ldr	x23, [x19, x8]
104ea0544: f945e701    	ldr	x1, [x24, #0xbc8]
104ea0548: aa1303e0    	mov	x0, x19
104ea054c: 94b61afc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0550: aa1d03fd    	mov	x29, x29
104ea0554: 94b61afd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea0558: aa0003f8    	mov	x24, x0
104ea055c: f00d7cc8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104ea0560: f945f101    	ldr	x1, [x8, #0xbe0] ; setRightBarButtonItem:
104ea0564: aa1703e2    	mov	x2, x23
104ea0568: 94b61af5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea056c: aa1803e0    	mov	x0, x24
104ea0570: 94b61af9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea0574: b00d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea0578: f946ad01    	ldr	x1, [x8, #0xd58] ; updateMultiSelectRightBarItemInPageSheetModeIfNeeded
104ea057c: aa1303e0    	mov	x0, x19
104ea0580: 94b61aef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0584: aa1303e0    	mov	x0, x19
104ea0588: aa1603e1    	mov	x1, x22
104ea058c: 94b61aec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0590: 7100581f    	cmp	w0, #0x16
104ea0594: 54000340    	b.eq	0x104ea05fc <_Flutter_MMFoundation_BindContext+0x137c1e0>
104ea0598: aa1303e0    	mov	x0, x19
104ea059c: aa1603e1    	mov	x1, x22
104ea05a0: 94b61ae7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea05a4: 7100541f    	cmp	w0, #0x15
104ea05a8: 540002a0    	b.eq	0x104ea05fc <_Flutter_MMFoundation_BindContext+0x137c1e0>
104ea05ac: aa1303e0    	mov	x0, x19
104ea05b0: aa1603e1    	mov	x1, x22
104ea05b4: 94b61ae2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea05b8: 7100601f    	cmp	w0, #0x18
104ea05bc: 54000200    	b.eq	0x104ea05fc <_Flutter_MMFoundation_BindContext+0x137c1e0>
104ea05c0: aa1303e0    	mov	x0, x19
104ea05c4: aa1603e1    	mov	x1, x22
104ea05c8: 94b61add    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea05cc: 7100881f    	cmp	w0, #0x22
104ea05d0: 54000160    	b.eq	0x104ea05fc <_Flutter_MMFoundation_BindContext+0x137c1e0>
104ea05d4: aa1303e0    	mov	x0, x19
104ea05d8: aa1603e1    	mov	x1, x22
104ea05dc: 94b61ad8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea05e0: 7100941f    	cmp	w0, #0x25
104ea05e4: 540000c0    	b.eq	0x104ea05fc <_Flutter_MMFoundation_BindContext+0x137c1e0>
104ea05e8: aa1303e0    	mov	x0, x19
104ea05ec: aa1603e1    	mov	x1, x22
104ea05f0: 94b61ad3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea05f4: 71009c1f    	cmp	w0, #0x27
104ea05f8: 540000c1    	b.ne	0x104ea0610 <_Flutter_MMFoundation_BindContext+0x137c1f4>
104ea05fc: b00d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea0600: f946b101    	ldr	x1, [x8, #0xd60] ; updateRightBarItemEnabled:
104ea0604: aa1303e0    	mov	x0, x19
104ea0608: 52800022    	mov	w2, #0x1                ; =1
104ea060c: 94b61acc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0610: aa1503e0    	mov	x0, x21
104ea0614: 94b61ad0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea0618: aa1a03e0    	mov	x0, x26
104ea061c: a94a7bfd    	ldp	x29, x30, [sp, #0xa0]
104ea0620: a9494ff4    	ldp	x20, x19, [sp, #0x90]
104ea0624: a94857f6    	ldp	x22, x21, [sp, #0x80]
104ea0628: a9475ff8    	ldp	x24, x23, [sp, #0x70]
104ea062c: a94667fa    	ldp	x26, x25, [sp, #0x60]
104ea0630: a9456ffc    	ldp	x28, x27, [sp, #0x50]
104ea0634: 9102c3ff    	add	sp, sp, #0xb0
104ea0638: 14b61ac7    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea063c: 900d9334    	adrp	x20, 0x120104000 <dyld_stub_binder+0x120104000>
104ea0640: f945e681    	ldr	x1, [x20, #0xbc8] ; navigationItem
104ea0644: aa1303e0    	mov	x0, x19
104ea0648: 94b61abd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea064c: aa1d03fd    	mov	x29, x29
104ea0650: 94b61abe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea0654: aa0003f8    	mov	x24, x0
104ea0658: f00d7cc8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104ea065c: f945f101    	ldr	x1, [x8, #0xbe0] ; setRightBarButtonItem:
104ea0660: aa1b03e2    	mov	x2, x27
104ea0664: 94b61ab6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0668: aa1803e0    	mov	x0, x24
104ea066c: 17fffe7e    	b	0x104ea0064 <_Flutter_MMFoundation_BindContext+0x137bc48>
