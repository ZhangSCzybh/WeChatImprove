
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10625ec38: d10183ff    	sub	sp, sp, #0x60
10625ec3c: a90167fa    	stp	x26, x25, [sp, #0x10]
10625ec40: a9025ff8    	stp	x24, x23, [sp, #0x20]
10625ec44: a90357f6    	stp	x22, x21, [sp, #0x30]
10625ec48: a9044ff4    	stp	x20, x19, [sp, #0x40]
10625ec4c: a9057bfd    	stp	x29, x30, [sp, #0x50]
10625ec50: 910143fd    	add	x29, sp, #0x50
10625ec54: aa0303f4    	mov	x20, x3
10625ec58: aa0203f3    	mov	x19, x2
10625ec5c: aa0003f5    	mov	x21, x0
10625ec60: b00d4f28    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
10625ec64: 52800029    	mov	w9, #0x1                ; =1
10625ec68: 39266509    	strb	w9, [x8, #0x999]
10625ec6c: aa0203e0    	mov	x0, x2
10625ec70: 94672132    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10625ec74: aa1403e0    	mov	x0, x20
10625ec78: 94672130    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10625ec7c: 52800040    	mov	w0, #0x2                ; =2
10625ec80: 9466b970    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10625ec84: 34000560    	cbz	w0, 0x10625ed30 <_Flutter_MMFoundation_BindContext+0x273a914>
10625ec88: 94672146    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10625ec8c: aa0003f6    	mov	x22, x0
10625ec90: b00cf8b8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
10625ec94: f9454700    	ldr	x0, [x24, #0xa88]
10625ec98: 94672132    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10625ec9c: aa0003f7    	mov	x23, x0
10625eca0: f9454700    	ldr	x0, [x24, #0xa88]
10625eca4: 900cf568    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10625eca8: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
10625ecac: f90003ff    	str	xzr, [sp]
10625ecb0: f00c30c2    	adrp	x2, 0x11e879000 <dyld_stub_binder+0x11e879000>
10625ecb4: 91192042    	add	x2, x2, #0x648
10625ecb8: 94672121    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10625ecbc: aa1d03fd    	mov	x29, x29
10625ecc0: 94672122    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10625ecc4: aa0003f8    	mov	x24, x0
10625ecc8: 900cf528    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10625eccc: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
10625ecd0: b00c11e8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10625ecd4: 91352108    	add	x8, x8, #0xd48
10625ecd8: a90003e8    	stp	x8, x0, [sp]
10625ecdc: b00c11e2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10625ece0: 9134a042    	add	x2, x2, #0xd28
10625ece4: aa1703e0    	mov	x0, x23
10625ece8: 94672115    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10625ecec: aa0003f7    	mov	x23, x0
10625ecf0: aa1803e0    	mov	x0, x24
10625ecf4: 94672118    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10625ecf8: f00a7da1    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
10625ecfc: 9124e421    	add	x1, x1, #0x939
10625ed00: 900aba02    	adrp	x2, 0x11b99e000 <dyld_stub_binder+0x11b99e000>
10625ed04: 91112042    	add	x2, x2, #0x448
10625ed08: d00aba04    	adrp	x4, 0x11b9a0000 <dyld_stub_binder+0x11b9a0000>
10625ed0c: 91162484    	add	x4, x4, #0x589
10625ed10: 52800040    	mov	w0, #0x2                ; =2
10625ed14: 52814a03    	mov	w3, #0xa50              ; =2640
10625ed18: aa1703e5    	mov	x5, x23
10625ed1c: 9466b94a    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10625ed20: aa1703e0    	mov	x0, x23
10625ed24: 9467210c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10625ed28: aa1603e0    	mov	x0, x22
10625ed2c: 94672120    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10625ed30: 900cdee8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10625ed34: f947c101    	ldr	x1, [x8, #0xf80] ; setIsThisTalkIlink:
10625ed38: aa1503e0    	mov	x0, x21
10625ed3c: 52800022    	mov	w2, #0x1                ; =1
10625ed40: 946720ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10625ed44: f00ce0a8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
10625ed48: f9429101    	ldr	x1, [x8, #0x520] ; roomType
10625ed4c: aa1303e0    	mov	x0, x19
10625ed50: 946720fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10625ed54: 7100081f    	cmp	w0, #0x2
10625ed58: 1a9f07f6    	cset	w22, ne
10625ed5c: 1a9f17f7    	cset	w23, eq
10625ed60: 900ceba8    	adrp	x8, 0x11ffd2000 <dyld_stub_binder+0x11ffd2000>
10625ed64: f9418501    	ldr	x1, [x8, #0x308] ; setIsAudio:
10625ed68: aa1503e0    	mov	x0, x21
10625ed6c: aa1703e2    	mov	x2, x23
10625ed70: 946720f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10625ed74: b00cf8a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10625ed78: f945e900    	ldr	x0, [x8, #0xbd0]
10625ed7c: d00cf508    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10625ed80: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10625ed84: 946720ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10625ed88: aa1d03fd    	mov	x29, x29
10625ed8c: 946720ef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10625ed90: aa0003f8    	mov	x24, x0
10625ed94: b00cf8e8    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
10625ed98: f945c900    	ldr	x0, [x8, #0xb90]
10625ed9c: b00cf508    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10625eda0: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10625eda4: 946720e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10625eda8: aa0003e2    	mov	x2, x0
10625edac: f00cdec8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10625edb0: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10625edb4: aa1803e0    	mov	x0, x24
10625edb8: 946720e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10625edbc: aa1d03fd    	mov	x29, x29
10625edc0: 946720e2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10625edc4: aa0003f9    	mov	x25, x0
10625edc8: b00ceba8    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10625edcc: f942ad01    	ldr	x1, [x8, #0x558] ; setIsHandsFree:
10625edd0: aa1603e2    	mov	x2, x22
10625edd4: 946720da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10625edd8: aa1903e0    	mov	x0, x25
10625eddc: 946720de    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10625ede0: aa1803e0    	mov	x0, x24
10625ede4: 946720dc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10625ede8: d00cfec8    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
10625edec: b98b3d08    	ldrsw	x8, [x8, #0xb3c]
10625edf0: 38286ab7    	strb	w23, [x21, x8]
10625edf4: d00cfec8    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
10625edf8: b98b4108    	ldrsw	x8, [x8, #0xb40]
10625edfc: 38286ab7    	strb	w23, [x21, x8]
10625ee00: 900cdf88    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
10625ee04: f9450501    	ldr	x1, [x8, #0xa08] ; roomid
10625ee08: aa1303e0    	mov	x0, x19
10625ee0c: 946720cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10625ee10: aa0003e2    	mov	x2, x0
10625ee14: b00ceba8    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10625ee18: f942b101    	ldr	x1, [x8, #0x560] ; setMRoomId:
10625ee1c: aa1503e0    	mov	x0, x21
10625ee20: 946720c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10625ee24: d00ce9a8    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
10625ee28: f9446901    	ldr	x1, [x8, #0x8d0] ; setIsSpeakerOn:
10625ee2c: aa1503e0    	mov	x0, x21
10625ee30: aa1603e2    	mov	x2, x22
10625ee34: 946720c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10625ee38: aa1403e0    	mov	x0, x20
10625ee3c: 946720c6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10625ee40: aa1303e0    	mov	x0, x19
10625ee44: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10625ee48: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10625ee4c: a94357f6    	ldp	x22, x21, [sp, #0x30]
10625ee50: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10625ee54: a94167fa    	ldp	x26, x25, [sp, #0x10]
10625ee58: 910183ff    	add	sp, sp, #0x60
10625ee5c: 146720be    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
