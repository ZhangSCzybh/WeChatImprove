
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104adcc4c: d10343ff    	sub	sp, sp, #0xd0
104adcc50: a9076ffc    	stp	x28, x27, [sp, #0x70]
104adcc54: a90867fa    	stp	x26, x25, [sp, #0x80]
104adcc58: a9095ff8    	stp	x24, x23, [sp, #0x90]
104adcc5c: a90a57f6    	stp	x22, x21, [sp, #0xa0]
104adcc60: a90b4ff4    	stp	x20, x19, [sp, #0xb0]
104adcc64: a90c7bfd    	stp	x29, x30, [sp, #0xc0]
104adcc68: 910303fd    	add	x29, sp, #0xc0
104adcc6c: aa0203f3    	mov	x19, x2
104adcc70: aa0003f5    	mov	x21, x0
104adcc74: f00c5888    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104adcc78: f9405908    	ldr	x8, [x8, #0xb0]
104adcc7c: f9400108    	ldr	x8, [x8]
104adcc80: f81a83a8    	stur	x8, [x29, #-0x58]
104adcc84: d00e0b08    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104adcc88: 52800029    	mov	w9, #0x1                ; =1
104adcc8c: 3910d509    	strb	w9, [x8, #0x435]
104adcc90: aa0203e0    	mov	x0, x2
104adcc94: 94c52929    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104adcc98: f00dba28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104adcc9c: b9869118    	ldrsw	x24, [x8, #0x690]
104adcca0: f8786aa0    	ldr	x0, [x21, x24]
104adcca4: f00d9ae8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104adcca8: f9459901    	ldr	x1, [x8, #0xb30] ; resultTableView
104adccac: 94c52924    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adccb0: aa1d03fd    	mov	x29, x29
104adccb4: 94c52925    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adccb8: aa0003f4    	mov	x20, x0
104adccbc: f8786aa0    	ldr	x0, [x21, x24]
104adccc0: b00d9be8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
104adccc4: f942e101    	ldr	x1, [x8, #0x5c0] ; arrResult
104adccc8: 94c5291d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adcccc: aa1d03fd    	mov	x29, x29
104adccd0: 94c5291e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adccd4: aa0003f7    	mov	x23, x0
104adccd8: d00db148    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104adccdc: f944091b    	ldr	x27, [x8, #0x810] ; row
104adcce0: aa1303e0    	mov	x0, x19
104adcce4: aa1b03e1    	mov	x1, x27
104adcce8: 94c52915    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adccec: aa0003e2    	mov	x2, x0
104adccf0: d00d9ae8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104adccf4: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
104adccf8: aa1703e0    	mov	x0, x23
104adccfc: 94c52910    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adcd00: aa1d03fd    	mov	x29, x29
104adcd04: 94c52911    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adcd08: aa0003f6    	mov	x22, x0
104adcd0c: aa1703e0    	mov	x0, x23
104adcd10: 94c52911    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adcd14: b4000ed6    	cbz	x22, 0x104adceec <_Flutter_MMFoundation_BindContext+0xfb8ad0>
104adcd18: 900db4c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104adcd1c: f00cce09    	adrp	x9, 0x11e49f000 <dyld_stub_binder+0x11e49f000>
104adcd20: 91122129    	add	x9, x9, #0x488
104adcd24: f9409908    	ldr	x8, [x8, #0x130]
104adcd28: f90003e8    	str	x8, [sp]
104adcd2c: f9000fe9    	str	x9, [sp, #0x18]
104adcd30: f8786aa0    	ldr	x0, [x21, x24]
104adcd34: f00d9ae8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104adcd38: f9478d01    	ldr	x1, [x8, #0xf18] ; searchBar
104adcd3c: 94c52900    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adcd40: aa1d03fd    	mov	x29, x29
104adcd44: 94c52901    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adcd48: f9000be0    	str	x0, [sp, #0x10]
104adcd4c: f00db168    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104adcd50: f9401501    	ldr	x1, [x8, #0x28] ; text
104adcd54: 94c528fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adcd58: aa1d03fd    	mov	x29, x29
104adcd5c: 94c528fb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adcd60: f90007e0    	str	x0, [sp, #0x8]
104adcd64: 900cce28    	adrp	x8, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
104adcd68: 912f2108    	add	x8, x8, #0xbc8
104adcd6c: f90023e0    	str	x0, [sp, #0x40]
104adcd70: f90013e8    	str	x8, [sp, #0x20]
104adcd74: f00db4b8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
104adcd78: f9458b00    	ldr	x0, [x24, #0xb10]
104adcd7c: 900db148    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104adcd80: f947c119    	ldr	x25, [x8, #0xf80] ; numberWithUnsignedInteger:
104adcd84: aa1903e1    	mov	x1, x25
104adcd88: 52800122    	mov	w2, #0x9                ; =9
104adcd8c: 94c528ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adcd90: aa1d03fd    	mov	x29, x29
104adcd94: 94c528ed    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adcd98: aa0003fa    	mov	x26, x0
104adcd9c: f90027e0    	str	x0, [sp, #0x48]
104adcda0: 900cce28    	adrp	x8, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
104adcda4: 912fa108    	add	x8, x8, #0xbe8
104adcda8: f90017e8    	str	x8, [sp, #0x28]
104adcdac: f9458b00    	ldr	x0, [x24, #0xb10]
104adcdb0: aa1903e1    	mov	x1, x25
104adcdb4: 52800062    	mov	w2, #0x3                ; =3
104adcdb8: 94c528e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adcdbc: aa1d03fd    	mov	x29, x29
104adcdc0: 94c528e2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adcdc4: aa0003fc    	mov	x28, x0
104adcdc8: f9002be0    	str	x0, [sp, #0x50]
104adcdcc: 900cce28    	adrp	x8, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
104adcdd0: 91302108    	add	x8, x8, #0xc08
104adcdd4: f9001be8    	str	x8, [sp, #0x30]
104adcdd8: f9458b17    	ldr	x23, [x24, #0xb10]
104adcddc: aa1303e0    	mov	x0, x19
104adcde0: aa1b03e1    	mov	x1, x27
104adcde4: 94c528d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adcde8: 900db148    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104adcdec: f947a901    	ldr	x1, [x8, #0xf50] ; numberWithInteger:
104adcdf0: 91000402    	add	x2, x0, #0x1
104adcdf4: aa1703e0    	mov	x0, x23
104adcdf8: 94c528d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adcdfc: aa1d03fd    	mov	x29, x29
104adce00: 94c528d2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adce04: aa0003f7    	mov	x23, x0
104adce08: f9002fe0    	str	x0, [sp, #0x58]
104adce0c: 900cce28    	adrp	x8, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
104adce10: 9130a108    	add	x8, x8, #0xc28
104adce14: f9001fe8    	str	x8, [sp, #0x38]
104adce18: f9458b00    	ldr	x0, [x24, #0xb10]
104adce1c: aa1903e1    	mov	x1, x25
104adce20: d2800002    	mov	x2, #0x0                ; =0
104adce24: 94c528c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adce28: aa1d03fd    	mov	x29, x29
104adce2c: 94c528c7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adce30: aa0003f9    	mov	x25, x0
104adce34: f90033e0    	str	x0, [sp, #0x60]
104adce38: f00db4a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104adce3c: f9457500    	ldr	x0, [x8, #0xae8]
104adce40: b00db128    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
104adce44: f9402901    	ldr	x1, [x8, #0x50] ; dictionaryWithObjects:forKeys:count:
104adce48: 910103e2    	add	x2, sp, #0x40
104adce4c: 910063e3    	add	x3, sp, #0x18
104adce50: 528000a4    	mov	w4, #0x5                ; =5
104adce54: 94c528ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adce58: aa1d03fd    	mov	x29, x29
104adce5c: 94c528bb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adce60: aa0003fb    	mov	x27, x0
104adce64: 900d9b08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104adce68: f9428101    	ldr	x1, [x8, #0x500] ; commonSearchClickReport:
104adce6c: f94003e0    	ldr	x0, [sp]
104adce70: aa1b03e2    	mov	x2, x27
104adce74: 94c528b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adce78: aa1b03e0    	mov	x0, x27
104adce7c: 94c528b6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adce80: aa1903e0    	mov	x0, x25
104adce84: 94c528b4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adce88: aa1703e0    	mov	x0, x23
104adce8c: 94c528b2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adce90: aa1c03e0    	mov	x0, x28
104adce94: 94c528b0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adce98: aa1a03e0    	mov	x0, x26
104adce9c: 94c528ae    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adcea0: f94007e0    	ldr	x0, [sp, #0x8]
104adcea4: 94c528ac    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adcea8: f9400be0    	ldr	x0, [sp, #0x10]
104adceac: 94c528aa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adceb0: d00d9d48    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
104adceb4: f9422501    	ldr	x1, [x8, #0x448] ; showContactInfoView:
104adceb8: aa1503e0    	mov	x0, x21
104adcebc: aa1603e2    	mov	x2, x22
104adcec0: 94c5289f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adcec4: 900d9b08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104adcec8: f947f901    	ldr	x1, [x8, #0xff0] ; deselectRowAtIndexPath:animated:
104adcecc: aa1403e0    	mov	x0, x20
104adced0: aa1303e2    	mov	x2, x19
104adced4: 52800023    	mov	w3, #0x1                ; =1
104adced8: 94c52899    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adcedc: d00db148    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104adcee0: f9404501    	ldr	x1, [x8, #0x88] ; reloadData
104adcee4: aa1403e0    	mov	x0, x20
104adcee8: 94c52895    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adceec: aa1603e0    	mov	x0, x22
104adcef0: 94c52899    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adcef4: aa1403e0    	mov	x0, x20
104adcef8: 94c52897    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adcefc: aa1303e0    	mov	x0, x19
104adcf00: 94c52895    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adcf04: f85a83a8    	ldur	x8, [x29, #-0x58]
104adcf08: f00c5889    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104adcf0c: f9405929    	ldr	x9, [x9, #0xb0]
104adcf10: f9400129    	ldr	x9, [x9]
104adcf14: eb08013f    	cmp	x9, x8
104adcf18: 54000121    	b.ne	0x104adcf3c <_Flutter_MMFoundation_BindContext+0xfb8b20>
104adcf1c: a94c7bfd    	ldp	x29, x30, [sp, #0xc0]
104adcf20: a94b4ff4    	ldp	x20, x19, [sp, #0xb0]
104adcf24: a94a57f6    	ldp	x22, x21, [sp, #0xa0]
104adcf28: a9495ff8    	ldp	x24, x23, [sp, #0x90]
104adcf2c: a94867fa    	ldp	x26, x25, [sp, #0x80]
104adcf30: a9476ffc    	ldp	x28, x27, [sp, #0x70]
104adcf34: 910343ff    	add	sp, sp, #0xd0
104adcf38: d65f03c0    	ret
104adcf3c: 94c5288e    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
