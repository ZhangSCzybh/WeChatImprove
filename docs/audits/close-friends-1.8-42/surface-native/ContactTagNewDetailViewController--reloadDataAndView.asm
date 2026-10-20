
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10105f9ec: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
10105f9f0: a90167fa    	stp	x26, x25, [sp, #0x10]
10105f9f4: a9025ff8    	stp	x24, x23, [sp, #0x20]
10105f9f8: a90357f6    	stp	x22, x21, [sp, #0x30]
10105f9fc: a9044ff4    	stp	x20, x19, [sp, #0x40]
10105fa00: a9057bfd    	stp	x29, x30, [sp, #0x50]
10105fa04: 910143fd    	add	x29, sp, #0x50
10105fa08: d10783ff    	sub	sp, sp, #0x1e0
10105fa0c: aa0003f3    	mov	x19, x0
10105fa10: 900e2c88    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10105fa14: f9405908    	ldr	x8, [x8, #0xb0]
10105fa18: f9400108    	ldr	x8, [x8]
10105fa1c: f81a03a8    	stur	x8, [x29, #-0x60]
10105fa20: b00fde88    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
10105fa24: 52800029    	mov	w9, #0x1                ; =1
10105fa28: 39387109    	strb	w9, [x8, #0xe1c]
10105fa2c: f00f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
10105fa30: b9838508    	ldrsw	x8, [x8, #0x384] ; ivar ContactTagNewDetailViewController._contactsKeyArray
10105fa34: f8686800    	ldr	x0, [x0, x8]
10105fa38: f00f8528    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10105fa3c: f9408114    	ldr	x20, [x8, #0x100] ; removeAllObjects
10105fa40: aa1403e1    	mov	x1, x20
10105fa44: 95af1dbe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fa48: f00f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
10105fa4c: b9838908    	ldrsw	x8, [x8, #0x388] ; ivar ContactTagNewDetailViewController._contactsDict
10105fa50: f8686a60    	ldr	x0, [x19, x8]
10105fa54: aa1403e1    	mov	x1, x20
10105fa58: 95af1db9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fa5c: 900f88a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10105fa60: f9455500    	ldr	x0, [x8, #0xaa8]
10105fa64: 95af1dbd    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
10105fa68: f00f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
10105fa6c: b9838d09    	ldrsw	x9, [x8, #0x38c] ; ivar ContactTagNewDetailViewController._curMemberContactList
10105fa70: f8696a68    	ldr	x8, [x19, x9]
10105fa74: f9001fe9    	str	x9, [sp, #0x38]
10105fa78: f8296a60    	str	x0, [x19, x9]
10105fa7c: aa0803e0    	mov	x0, x8
10105fa80: 95af1db5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10105fa84: f00f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
10105fa88: b9837d08    	ldrsw	x8, [x8, #0x37c] ; ivar ContactTagNewDetailViewController._curActionType
10105fa8c: f8686a68    	ldr	x8, [x19, x8]
10105fa90: 900f88a9    	adrp	x9, 0x120173000 <dyld_stub_binder+0x120173000>
10105fa94: b00f851b    	adrp	x27, 0x120100000 <dyld_stub_binder+0x120100000>
10105fa98: 900f8515    	adrp	x21, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10105fa9c: d00f6ed6    	adrp	x22, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10105faa0: b00f8519    	adrp	x25, 0x120100000 <dyld_stub_binder+0x120100000>
10105faa4: f100091f    	cmp	x8, #0x2
10105faa8: 54000b21    	b.ne	0x10105fc0c <__text+0x1057c0c>
10105faac: f945e920    	ldr	x0, [x9, #0xbd0]
10105fab0: f944eb61    	ldr	x1, [x27, #0x9d0] ; currentContext
10105fab4: 95af1da2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fab8: aa1d03fd    	mov	x29, x29
10105fabc: 95af1da3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10105fac0: aa0003f4    	mov	x20, x0
10105fac4: d00f88a8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10105fac8: f942ed00    	ldr	x0, [x8, #0x5d8]
10105facc: f947aea1    	ldr	x1, [x21, #0xf58] ; class
10105fad0: 95af1d9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fad4: aa0003e2    	mov	x2, x0
10105fad8: f94642c1    	ldr	x1, [x22, #0xc80] ; getService:
10105fadc: aa1403e0    	mov	x0, x20
10105fae0: 95af1d97    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fae4: aa1d03fd    	mov	x29, x29
10105fae8: 95af1d98    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10105faec: aa0003f5    	mov	x21, x0
10105faf0: f00f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
10105faf4: b983911a    	ldrsw	x26, [x8, #0x390] ; ivar ContactTagNewDetailViewController._contactTagData
10105faf8: f87a6a60    	ldr	x0, [x19, x26]
10105fafc: f00f7128    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
10105fb00: f941f516    	ldr	x22, [x8, #0x3e8] ; m_nsName
10105fb04: aa1603e1    	mov	x1, x22
10105fb08: 95af1d8d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fb0c: aa1d03fd    	mov	x29, x29
10105fb10: 95af1d8e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10105fb14: aa0003f7    	mov	x23, x0
10105fb18: d00f7148    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
10105fb1c: f9417d01    	ldr	x1, [x8, #0x2f8] ; getContactsForTagName:
10105fb20: aa1503e0    	mov	x0, x21
10105fb24: aa1703e2    	mov	x2, x23
10105fb28: 95af1d85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fb2c: aa1d03fd    	mov	x29, x29
10105fb30: 95af1d86    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10105fb34: aa0003f8    	mov	x24, x0
10105fb38: f87a6a60    	ldr	x0, [x19, x26]
10105fb3c: b00f7148    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
10105fb40: f9474d01    	ldr	x1, [x8, #0xe98] ; setM_arrContactNameList:
10105fb44: aa1803e2    	mov	x2, x24
10105fb48: 95af1d7d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fb4c: aa1803e0    	mov	x0, x24
10105fb50: 95af1d81    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10105fb54: aa1703e0    	mov	x0, x23
10105fb58: 95af1d7f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10105fb5c: aa1503e0    	mov	x0, x21
10105fb60: 95af1d7d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10105fb64: aa1403e0    	mov	x0, x20
10105fb68: 95af1d7b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10105fb6c: 900f88a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10105fb70: f9454514    	ldr	x20, [x8, #0xa88]
10105fb74: f87a6a60    	ldr	x0, [x19, x26]
10105fb78: aa1603e1    	mov	x1, x22
10105fb7c: 95af1d70    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fb80: aa1d03fd    	mov	x29, x29
10105fb84: 95af1d71    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10105fb88: aa0003f5    	mov	x21, x0
10105fb8c: f87a6a60    	ldr	x0, [x19, x26]
10105fb90: f00f7128    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
10105fb94: f941ed17    	ldr	x23, [x8, #0x3d8] ; m_arrContactNameList
10105fb98: aa1703e1    	mov	x1, x23
10105fb9c: 95af1d68    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fba0: aa1d03fd    	mov	x29, x29
10105fba4: 95af1d69    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10105fba8: aa0003f6    	mov	x22, x0
10105fbac: f9435321    	ldr	x1, [x25, #0x6a0] ; count
10105fbb0: 95af1d63    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fbb4: f00f8548    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10105fbb8: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
10105fbbc: a90003f5    	stp	x21, x0, [sp]
10105fbc0: f00ea562    	adrp	x2, 0x11e50e000 <dyld_stub_binder+0x11e50e000>
10105fbc4: 910d2042    	add	x2, x2, #0x348
10105fbc8: aa1403e0    	mov	x0, x20
10105fbcc: 95af1d5c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fbd0: aa1d03fd    	mov	x29, x29
10105fbd4: 95af1d5d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10105fbd8: aa0003f4    	mov	x20, x0
10105fbdc: d00f8548    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
10105fbe0: f9472101    	ldr	x1, [x8, #0xe40] ; setTitle:
10105fbe4: aa1303e0    	mov	x0, x19
10105fbe8: aa1403e2    	mov	x2, x20
10105fbec: 95af1d54    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fbf0: aa1403e0    	mov	x0, x20
10105fbf4: 95af1d58    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10105fbf8: aa1603e0    	mov	x0, x22
10105fbfc: 95af1d56    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10105fc00: aa1503e0    	mov	x0, x21
10105fc04: 95af1d54    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10105fc08: 14000005    	b	0x10105fc1c <__text+0x1057c1c>
10105fc0c: f00f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
10105fc10: b983911a    	ldrsw	x26, [x8, #0x390] ; ivar ContactTagNewDetailViewController._contactTagData
10105fc14: f00f7128    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
10105fc18: f941ed17    	ldr	x23, [x8, #0x3d8] ; m_arrContactNameList
10105fc1c: 4f00e400    	movi.16b	v0, #0x0
10105fc20: ad0583e0    	stp	q0, q0, [sp, #0xb0]
10105fc24: ad0483e0    	stp	q0, q0, [sp, #0x90]
10105fc28: f90023f3    	str	x19, [sp, #0x40]
10105fc2c: a901ebf7    	stp	x23, x26, [sp, #0x18]
10105fc30: f87a6a60    	ldr	x0, [x19, x26]
10105fc34: aa1703e1    	mov	x1, x23
10105fc38: 95af1d41    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fc3c: aa1d03fd    	mov	x29, x29
10105fc40: 95af1d42    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10105fc44: b00f8508    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10105fc48: f943551c    	ldr	x28, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
10105fc4c: 910243e2    	add	x2, sp, #0x90
10105fc50: d10383a3    	sub	x3, x29, #0xe0
10105fc54: f9001be0    	str	x0, [sp, #0x30]
10105fc58: aa1c03e1    	mov	x1, x28
10105fc5c: 52800204    	mov	w4, #0x10               ; =16
10105fc60: 95af1d37    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fc64: b4000900    	cbz	x0, 0x10105fd84 <__text+0x1057d84>
10105fc68: aa0003f7    	mov	x23, x0
10105fc6c: f94053e8    	ldr	x8, [sp, #0xa0]
10105fc70: f9400116    	ldr	x22, [x8]
10105fc74: f90017fc    	str	x28, [sp, #0x28]
10105fc78: d280001c    	mov	x28, #0x0               ; =0
10105fc7c: f944eb78    	ldr	x24, [x27, #0x9d0] ; currentContext
10105fc80: 900f8508    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10105fc84: f947ad19    	ldr	x25, [x8, #0xf58] ; class
10105fc88: d00f6ec8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10105fc8c: f946411a    	ldr	x26, [x8, #0xc80] ; getService:
10105fc90: b00f6ee8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10105fc94: f940c91b    	ldr	x27, [x8, #0x190] ; getContactByName:
10105fc98: f00f6ec8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10105fc9c: f943c508    	ldr	x8, [x8, #0x788] ; safeAddObject:
10105fca0: f90027e8    	str	x8, [sp, #0x48]
10105fca4: f94053e8    	ldr	x8, [sp, #0xa0]
10105fca8: f9400108    	ldr	x8, [x8]
10105fcac: eb16011f    	cmp	x8, x22
10105fcb0: 54000060    	b.eq	0x10105fcbc <__text+0x1057cbc>
10105fcb4: f9401be0    	ldr	x0, [sp, #0x30]
10105fcb8: 95af1d26    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
10105fcbc: f9404fe8    	ldr	x8, [sp, #0x98]
10105fcc0: f87c7914    	ldr	x20, [x8, x28, lsl #3]
10105fcc4: 900f88a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10105fcc8: f945e900    	ldr	x0, [x8, #0xbd0]
10105fccc: aa1803e1    	mov	x1, x24
10105fcd0: 95af1d1b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fcd4: aa1d03fd    	mov	x29, x29
10105fcd8: 95af1d1c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10105fcdc: aa0003f5    	mov	x21, x0
10105fce0: b00f88a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10105fce4: f9401500    	ldr	x0, [x8, #0x28] ; P;,
10105fce8: aa1903e1    	mov	x1, x25
10105fcec: 95af1d14    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fcf0: aa0003e2    	mov	x2, x0
10105fcf4: aa1503e0    	mov	x0, x21
10105fcf8: aa1a03e1    	mov	x1, x26
10105fcfc: 95af1d10    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fd00: aa1d03fd    	mov	x29, x29
10105fd04: 95af1d11    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10105fd08: aa0003f3    	mov	x19, x0
10105fd0c: aa1b03e1    	mov	x1, x27
10105fd10: aa1403e2    	mov	x2, x20
10105fd14: 95af1d0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fd18: aa1d03fd    	mov	x29, x29
10105fd1c: 95af1d0b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10105fd20: aa0003f4    	mov	x20, x0
10105fd24: aa1303e0    	mov	x0, x19
10105fd28: 95af1d0b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10105fd2c: aa1503e0    	mov	x0, x21
10105fd30: 95af1d09    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10105fd34: b40000d4    	cbz	x20, 0x10105fd4c <__text+0x1057d4c>
10105fd38: a943a3e9    	ldp	x9, x8, [sp, #0x38]
10105fd3c: f8696900    	ldr	x0, [x8, x9]
10105fd40: f94027e1    	ldr	x1, [sp, #0x48]
10105fd44: aa1403e2    	mov	x2, x20
10105fd48: 95af1cfd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fd4c: aa1403e0    	mov	x0, x20
10105fd50: 95af1d01    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10105fd54: 9100079c    	add	x28, x28, #0x1
10105fd58: eb1c02ff    	cmp	x23, x28
10105fd5c: 54fffa41    	b.ne	0x10105fca4 <__text+0x1057ca4>
10105fd60: 910243e2    	add	x2, sp, #0x90
10105fd64: d10383a3    	sub	x3, x29, #0xe0
10105fd68: a94283fc    	ldp	x28, x0, [sp, #0x28]
10105fd6c: aa1c03e1    	mov	x1, x28
10105fd70: 52800204    	mov	w4, #0x10               ; =16
10105fd74: 95af1cf2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fd78: aa0003f7    	mov	x23, x0
10105fd7c: b00f851b    	adrp	x27, 0x120100000 <dyld_stub_binder+0x120100000>
10105fd80: b5fff7c0    	cbnz	x0, 0x10105fc78 <__text+0x1057c78>
10105fd84: f9401be0    	ldr	x0, [sp, #0x30]
10105fd88: 95af1cf3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10105fd8c: 4f00e400    	movi.16b	v0, #0x0
10105fd90: ad0383e0    	stp	q0, q0, [sp, #0x70]
10105fd94: ad0283e0    	stp	q0, q0, [sp, #0x50]
10105fd98: a943e7e8    	ldp	x8, x25, [sp, #0x38]
10105fd9c: f8686b36    	ldr	x22, [x25, x8]
10105fda0: aa1603e0    	mov	x0, x22
10105fda4: 95af1ce5    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10105fda8: 910143e2    	add	x2, sp, #0x50
10105fdac: 910343e3    	add	x3, sp, #0xd0
10105fdb0: aa1c03e1    	mov	x1, x28
10105fdb4: 52800204    	mov	w4, #0x10               ; =16
10105fdb8: 95af1ce1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fdbc: f94013fa    	ldr	x26, [sp, #0x20]
10105fdc0: b40003a0    	cbz	x0, 0x10105fe34 <__text+0x1057e34>
10105fdc4: aa0003f7    	mov	x23, x0
10105fdc8: f94033e8    	ldr	x8, [sp, #0x60]
10105fdcc: f9400113    	ldr	x19, [x8]
10105fdd0: d00f7154    	adrp	x20, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
10105fdd4: d2800015    	mov	x21, #0x0               ; =0
10105fdd8: f942f698    	ldr	x24, [x20, #0x5e8] ; processContactSectionData:
10105fddc: f94033e8    	ldr	x8, [sp, #0x60]
10105fde0: f9400108    	ldr	x8, [x8]
10105fde4: eb13011f    	cmp	x8, x19
10105fde8: 54000060    	b.eq	0x10105fdf4 <__text+0x1057df4>
10105fdec: aa1603e0    	mov	x0, x22
10105fdf0: 95af1cd8    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
10105fdf4: f9402fe8    	ldr	x8, [sp, #0x58]
10105fdf8: f8757902    	ldr	x2, [x8, x21, lsl #3]
10105fdfc: aa1903e0    	mov	x0, x25
10105fe00: aa1803e1    	mov	x1, x24
10105fe04: 95af1cce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fe08: 910006b5    	add	x21, x21, #0x1
10105fe0c: eb1502ff    	cmp	x23, x21
10105fe10: 54fffe61    	b.ne	0x10105fddc <__text+0x1057ddc>
10105fe14: 910143e2    	add	x2, sp, #0x50
10105fe18: 910343e3    	add	x3, sp, #0xd0
10105fe1c: aa1603e0    	mov	x0, x22
10105fe20: aa1c03e1    	mov	x1, x28
10105fe24: 52800204    	mov	w4, #0x10               ; =16
10105fe28: 95af1cc5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fe2c: aa0003f7    	mov	x23, x0
10105fe30: b5fffd20    	cbnz	x0, 0x10105fdd4 <__text+0x1057dd4>
10105fe34: aa1603e0    	mov	x0, x22
10105fe38: 95af1cc7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10105fe3c: b00f7148    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
10105fe40: f946c501    	ldr	x1, [x8, #0xd88] ; sortTagContacts
10105fe44: aa1903e0    	mov	x0, x25
10105fe48: 95af1cbd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fe4c: f00f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
10105fe50: b9838108    	ldrsw	x8, [x8, #0x380] ; ivar ContactTagNewDetailViewController._tableView
10105fe54: f8686b20    	ldr	x0, [x25, x8]
10105fe58: f00f8528    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10105fe5c: f9404501    	ldr	x1, [x8, #0x88] ; reloadData
10105fe60: 95af1cb7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fe64: f87a6b20    	ldr	x0, [x25, x26]
10105fe68: f9400fe1    	ldr	x1, [sp, #0x18]
10105fe6c: 95af1cb4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fe70: aa1d03fd    	mov	x29, x29
10105fe74: 95af1cb5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10105fe78: aa0003f3    	mov	x19, x0
10105fe7c: b00f8508    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10105fe80: f9435101    	ldr	x1, [x8, #0x6a0] ; count
10105fe84: 95af1cae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fe88: f100001f    	cmp	x0, #0x0
10105fe8c: 1a9f07f4    	cset	w20, ne
10105fe90: 1a9f17f5    	cset	w21, eq
10105fe94: aa1303e0    	mov	x0, x19
10105fe98: 95af1caf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10105fe9c: f00f8548    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10105fea0: f947bd01    	ldr	x1, [x8, #0xf78] ; tableView
10105fea4: aa1903e0    	mov	x0, x25
10105fea8: 95af1ca5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105feac: aa1d03fd    	mov	x29, x29
10105feb0: 95af1ca6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10105feb4: aa0003f3    	mov	x19, x0
10105feb8: b00f8548    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10105febc: f9411116    	ldr	x22, [x8, #0x220] ; setHidden:
10105fec0: aa1603e1    	mov	x1, x22
10105fec4: aa1503e2    	mov	x2, x21
10105fec8: 95af1c9d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fecc: aa1303e0    	mov	x0, x19
10105fed0: 95af1ca1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10105fed4: d00f7148    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
10105fed8: f9412501    	ldr	x1, [x8, #0x248] ; bottomBar
10105fedc: aa1903e0    	mov	x0, x25
10105fee0: 95af1c97    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fee4: aa1d03fd    	mov	x29, x29
10105fee8: 95af1c98    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10105feec: aa0003f3    	mov	x19, x0
10105fef0: aa1603e1    	mov	x1, x22
10105fef4: aa1503e2    	mov	x2, x21
10105fef8: 95af1c91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105fefc: aa1303e0    	mov	x0, x19
10105ff00: 95af1c95    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10105ff04: d00f7148    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
10105ff08: f942f901    	ldr	x1, [x8, #0x5f0] ; emptyView
10105ff0c: aa1903e0    	mov	x0, x25
10105ff10: 95af1c8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105ff14: aa1d03fd    	mov	x29, x29
10105ff18: 95af1c8c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10105ff1c: aa0003f3    	mov	x19, x0
10105ff20: aa1603e1    	mov	x1, x22
10105ff24: aa1403e2    	mov	x2, x20
10105ff28: 95af1c85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10105ff2c: aa1303e0    	mov	x0, x19
10105ff30: 95af1c89    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10105ff34: f85a03a8    	ldur	x8, [x29, #-0x60]
10105ff38: 900e2c89    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10105ff3c: f9405929    	ldr	x9, [x9, #0xb0]
10105ff40: f9400129    	ldr	x9, [x9]
10105ff44: eb08013f    	cmp	x9, x8
10105ff48: 54000121    	b.ne	0x10105ff6c <__text+0x1057f6c>
10105ff4c: 910783ff    	add	sp, sp, #0x1e0
10105ff50: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10105ff54: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10105ff58: a94357f6    	ldp	x22, x21, [sp, #0x30]
10105ff5c: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10105ff60: a94167fa    	ldp	x26, x25, [sp, #0x10]
10105ff64: a8c66ffc    	ldp	x28, x27, [sp], #0x60
10105ff68: d65f03c0    	ret
10105ff6c: 95af1c82    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
