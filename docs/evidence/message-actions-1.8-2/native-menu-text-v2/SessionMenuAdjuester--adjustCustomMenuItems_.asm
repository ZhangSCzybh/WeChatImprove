
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1057cfbe4: d10243ff    	sub	sp, sp, #0x90
1057cfbe8: a9036ffc    	stp	x28, x27, [sp, #0x30]
1057cfbec: a90467fa    	stp	x26, x25, [sp, #0x40]
1057cfbf0: a9055ff8    	stp	x24, x23, [sp, #0x50]
1057cfbf4: a90657f6    	stp	x22, x21, [sp, #0x60]
1057cfbf8: a9074ff4    	stp	x20, x19, [sp, #0x70]
1057cfbfc: a9087bfd    	stp	x29, x30, [sp, #0x80]
1057cfc00: 910203fd    	add	x29, sp, #0x80
1057cfc04: aa0203f3    	mov	x19, x2
1057cfc08: f90003e0    	str	x0, [sp]
1057cfc0c: d00da388    	adrp	x8, 0x120c41000 <dyld_stub_binder+0x120c41000>
1057cfc10: 52800029    	mov	w9, #0x1                ; =1
1057cfc14: 39119d09    	strb	w9, [x8, #0x467]
1057cfc18: aa0203e0    	mov	x0, x2
1057cfc1c: 94915d47    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057cfc20: b00d49a8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1057cfc24: f9450901    	ldr	x1, [x8, #0xa10] ; mutableCopy
1057cfc28: f90007f3    	str	x19, [sp, #0x8]
1057cfc2c: aa1303e0    	mov	x0, x19
1057cfc30: 94915d43    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfc34: aa0003f4    	mov	x20, x0
1057cfc38: b00d4d28    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1057cfc3c: f946d100    	ldr	x0, [x8, #0xda0]
1057cfc40: b00d3388    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1057cfc44: f9469101    	ldr	x1, [x8, #0xd20] ; indexSet
1057cfc48: 94915d3d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfc4c: aa1d03fd    	mov	x29, x29
1057cfc50: 94915d3e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057cfc54: aa0003f6    	mov	x22, x0
1057cfc58: b00d4988    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1057cfc5c: f943511b    	ldr	x27, [x8, #0x6a0] ; count
1057cfc60: aa1403e0    	mov	x0, x20
1057cfc64: aa1b03e1    	mov	x1, x27
1057cfc68: 94915d35    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfc6c: b4000de0    	cbz	x0, 0x1057cfe28 <_Flutter_MMFoundation_BindContext+0x1caba0c>
1057cfc70: a901ffff    	stp	xzr, xzr, [sp, #0x18]
1057cfc74: d280001c    	mov	x28, #0x0               ; =0
1057cfc78: f90017ff    	str	xzr, [sp, #0x28]
1057cfc7c: f9000bff    	str	xzr, [sp, #0x10]
1057cfc80: f00d3348    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1057cfc84: f942c113    	ldr	x19, [x8, #0x580] ; safeObjectAtIndex:
1057cfc88: 900d4988    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1057cfc8c: f947ad15    	ldr	x21, [x8, #0xf58] ; class
1057cfc90: 900d49a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1057cfc94: f9442d17    	ldr	x23, [x8, #0x858] ; isKindOfClass:
1057cfc98: 900d3388    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1057cfc9c: f9436518    	ldr	x24, [x8, #0x6c8] ; menuType
1057cfca0: b00d3388    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1057cfca4: f9469519    	ldr	x25, [x8, #0xd28] ; addIndex:
1057cfca8: aa1403e0    	mov	x0, x20
1057cfcac: aa1303e1    	mov	x1, x19
1057cfcb0: aa1c03e2    	mov	x2, x28
1057cfcb4: 94915d22    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfcb8: aa1d03fd    	mov	x29, x29
1057cfcbc: 94915d23    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057cfcc0: aa0003fa    	mov	x26, x0
1057cfcc4: b00d4d28    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1057cfcc8: f9452900    	ldr	x0, [x8, #0xa50]
1057cfccc: aa1503e1    	mov	x1, x21
1057cfcd0: 94915d1b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfcd4: aa0003e2    	mov	x2, x0
1057cfcd8: aa1a03e0    	mov	x0, x26
1057cfcdc: aa1703e1    	mov	x1, x23
1057cfce0: 94915d17    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfce4: 34000900    	cbz	w0, 0x1057cfe04 <_Flutter_MMFoundation_BindContext+0x1cab9e8>
1057cfce8: aa1a03e0    	mov	x0, x26
1057cfcec: aa1803e1    	mov	x1, x24
1057cfcf0: 94915d13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfcf4: f100141f    	cmp	x0, #0x5
1057cfcf8: 54000141    	b.ne	0x1057cfd20 <_Flutter_MMFoundation_BindContext+0x1cab904>
1057cfcfc: aa1603e0    	mov	x0, x22
1057cfd00: aa1903e1    	mov	x1, x25
1057cfd04: aa1c03e2    	mov	x2, x28
1057cfd08: 94915d0d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfd0c: aa1a03e0    	mov	x0, x26
1057cfd10: 94915d0a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057cfd14: f94013e0    	ldr	x0, [sp, #0x20]
1057cfd18: 94915d0f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057cfd1c: f90013fa    	str	x26, [sp, #0x20]
1057cfd20: aa1a03e0    	mov	x0, x26
1057cfd24: aa1803e1    	mov	x1, x24
1057cfd28: 94915d05    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfd2c: f100101f    	cmp	x0, #0x4
1057cfd30: 54000141    	b.ne	0x1057cfd58 <_Flutter_MMFoundation_BindContext+0x1cab93c>
1057cfd34: aa1603e0    	mov	x0, x22
1057cfd38: aa1903e1    	mov	x1, x25
1057cfd3c: aa1c03e2    	mov	x2, x28
1057cfd40: 94915cff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfd44: aa1a03e0    	mov	x0, x26
1057cfd48: 94915cfc    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057cfd4c: f9400fe0    	ldr	x0, [sp, #0x18]
1057cfd50: 94915d01    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057cfd54: f9000ffa    	str	x26, [sp, #0x18]
1057cfd58: aa1a03e0    	mov	x0, x26
1057cfd5c: aa1803e1    	mov	x1, x24
1057cfd60: 94915cf7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfd64: f100201f    	cmp	x0, #0x8
1057cfd68: 54000141    	b.ne	0x1057cfd90 <_Flutter_MMFoundation_BindContext+0x1cab974>
1057cfd6c: aa1603e0    	mov	x0, x22
1057cfd70: aa1903e1    	mov	x1, x25
1057cfd74: aa1c03e2    	mov	x2, x28
1057cfd78: 94915cf1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfd7c: aa1a03e0    	mov	x0, x26
1057cfd80: 94915cee    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057cfd84: f9400be0    	ldr	x0, [sp, #0x10]
1057cfd88: 94915cf3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057cfd8c: f9000bfa    	str	x26, [sp, #0x10]
1057cfd90: aa1a03e0    	mov	x0, x26
1057cfd94: aa1803e1    	mov	x1, x24
1057cfd98: 94915ce9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfd9c: f100b81f    	cmp	x0, #0x2e
1057cfda0: 54000200    	b.eq	0x1057cfde0 <_Flutter_MMFoundation_BindContext+0x1cab9c4>
1057cfda4: aa1a03e0    	mov	x0, x26
1057cfda8: aa1803e1    	mov	x1, x24
1057cfdac: 94915ce4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfdb0: f100bc1f    	cmp	x0, #0x2f
1057cfdb4: 54000160    	b.eq	0x1057cfde0 <_Flutter_MMFoundation_BindContext+0x1cab9c4>
1057cfdb8: aa1a03e0    	mov	x0, x26
1057cfdbc: aa1803e1    	mov	x1, x24
1057cfdc0: 94915cdf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfdc4: f100e41f    	cmp	x0, #0x39
1057cfdc8: 540000c0    	b.eq	0x1057cfde0 <_Flutter_MMFoundation_BindContext+0x1cab9c4>
1057cfdcc: aa1a03e0    	mov	x0, x26
1057cfdd0: aa1803e1    	mov	x1, x24
1057cfdd4: 94915cda    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfdd8: f100e81f    	cmp	x0, #0x3a
1057cfddc: 54000141    	b.ne	0x1057cfe04 <_Flutter_MMFoundation_BindContext+0x1cab9e8>
1057cfde0: aa1603e0    	mov	x0, x22
1057cfde4: aa1903e1    	mov	x1, x25
1057cfde8: aa1c03e2    	mov	x2, x28
1057cfdec: 94915cd4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfdf0: aa1a03e0    	mov	x0, x26
1057cfdf4: 94915cd1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057cfdf8: f94017e0    	ldr	x0, [sp, #0x28]
1057cfdfc: 94915cd6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057cfe00: f90017fa    	str	x26, [sp, #0x28]
1057cfe04: aa1a03e0    	mov	x0, x26
1057cfe08: 94915cd3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057cfe0c: 9100079c    	add	x28, x28, #0x1
1057cfe10: aa1403e0    	mov	x0, x20
1057cfe14: aa1b03e1    	mov	x1, x27
1057cfe18: 94915cc9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfe1c: eb00039f    	cmp	x28, x0
1057cfe20: 54fff443    	b.lo	0x1057cfca8 <_Flutter_MMFoundation_BindContext+0x1cab88c>
1057cfe24: 14000003    	b	0x1057cfe30 <_Flutter_MMFoundation_BindContext+0x1caba14>
1057cfe28: a9017fff    	stp	xzr, xzr, [sp, #0x10]
1057cfe2c: a9027fff    	stp	xzr, xzr, [sp, #0x20]
1057cfe30: d00d3948    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1057cfe34: f9440d01    	ldr	x1, [x8, #0x818] ; lastIndex
1057cfe38: aa1603e0    	mov	x0, x22
1057cfe3c: 94915cc0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfe40: 92f00018    	mov	x24, #0x7fffffffffffffff ; =9223372036854775807
1057cfe44: eb18001f    	cmp	x0, x24
1057cfe48: 54000220    	b.eq	0x1057cfe8c <_Flutter_MMFoundation_BindContext+0x1caba70>
1057cfe4c: aa0003f3    	mov	x19, x0
1057cfe50: f00d3348    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1057cfe54: f9442d15    	ldr	x21, [x8, #0x858] ; safeRemoveObjectAtIndex:
1057cfe58: d00d3f08    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057cfe5c: f9421117    	ldr	x23, [x8, #0x420] ; indexLessThanIndex:
1057cfe60: aa1403e0    	mov	x0, x20
1057cfe64: aa1503e1    	mov	x1, x21
1057cfe68: aa1303e2    	mov	x2, x19
1057cfe6c: 94915cb4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfe70: aa1603e0    	mov	x0, x22
1057cfe74: aa1703e1    	mov	x1, x23
1057cfe78: aa1303e2    	mov	x2, x19
1057cfe7c: 94915cb0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfe80: aa0003f3    	mov	x19, x0
1057cfe84: eb18001f    	cmp	x0, x24
1057cfe88: 54fffec1    	b.ne	0x1057cfe60 <_Flutter_MMFoundation_BindContext+0x1caba44>
1057cfe8c: d00d3f08    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057cfe90: f9421513    	ldr	x19, [x8, #0x428] ; insert:toMenuItems:atIndex:
1057cfe94: f94003f5    	ldr	x21, [sp]
1057cfe98: aa1503e0    	mov	x0, x21
1057cfe9c: aa1303e1    	mov	x1, x19
1057cfea0: f9400bf8    	ldr	x24, [sp, #0x10]
1057cfea4: aa1803e2    	mov	x2, x24
1057cfea8: aa1403e3    	mov	x3, x20
1057cfeac: 52800064    	mov	w4, #0x3                ; =3
1057cfeb0: 94915ca3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfeb4: aa1503e0    	mov	x0, x21
1057cfeb8: aa1303e1    	mov	x1, x19
1057cfebc: f9400ff7    	ldr	x23, [sp, #0x18]
1057cfec0: aa1703e2    	mov	x2, x23
1057cfec4: aa1403e3    	mov	x3, x20
1057cfec8: 52800064    	mov	w4, #0x3                ; =3
1057cfecc: 94915c9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfed0: aa1503e0    	mov	x0, x21
1057cfed4: aa1303e1    	mov	x1, x19
1057cfed8: f94013f5    	ldr	x21, [sp, #0x20]
1057cfedc: aa1503e2    	mov	x2, x21
1057cfee0: aa1403e3    	mov	x3, x20
1057cfee4: 52800084    	mov	w4, #0x4                ; =4
1057cfee8: 94915c95    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cfeec: f00d3348    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1057cfef0: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1057cfef4: aa1403e0    	mov	x0, x20
1057cfef8: f94017f9    	ldr	x25, [sp, #0x28]
1057cfefc: aa1903e2    	mov	x2, x25
1057cff00: 94915c8f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cff04: b00d4988    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1057cff08: f9431501    	ldr	x1, [x8, #0x628] ; copy
1057cff0c: aa1403e0    	mov	x0, x20
1057cff10: 94915c8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057cff14: aa0003f3    	mov	x19, x0
1057cff18: aa1603e0    	mov	x0, x22
1057cff1c: 94915c8e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057cff20: aa1903e0    	mov	x0, x25
1057cff24: 94915c8c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057cff28: aa1803e0    	mov	x0, x24
1057cff2c: 94915c8a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057cff30: aa1703e0    	mov	x0, x23
1057cff34: 94915c88    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057cff38: aa1503e0    	mov	x0, x21
1057cff3c: 94915c86    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057cff40: aa1403e0    	mov	x0, x20
1057cff44: 94915c84    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057cff48: f94007e0    	ldr	x0, [sp, #0x8]
1057cff4c: 94915c82    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057cff50: aa1303e0    	mov	x0, x19
1057cff54: a9487bfd    	ldp	x29, x30, [sp, #0x80]
1057cff58: a9474ff4    	ldp	x20, x19, [sp, #0x70]
1057cff5c: a94657f6    	ldp	x22, x21, [sp, #0x60]
1057cff60: a9455ff8    	ldp	x24, x23, [sp, #0x50]
1057cff64: a94467fa    	ldp	x26, x25, [sp, #0x40]
1057cff68: a9436ffc    	ldp	x28, x27, [sp, #0x30]
1057cff6c: 910243ff    	add	sp, sp, #0x90
1057cff70: 14915c80    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>