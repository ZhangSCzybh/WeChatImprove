
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101061ebc: d10143ff    	sub	sp, sp, #0x50
101061ec0: a9015ff8    	stp	x24, x23, [sp, #0x10]
101061ec4: a90257f6    	stp	x22, x21, [sp, #0x20]
101061ec8: a9034ff4    	stp	x20, x19, [sp, #0x30]
101061ecc: a9047bfd    	stp	x29, x30, [sp, #0x40]
101061ed0: 910103fd    	add	x29, sp, #0x40
101061ed4: aa0203f3    	mov	x19, x2
101061ed8: aa0003f4    	mov	x20, x0
101061edc: d00e2c68    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
101061ee0: f9405908    	ldr	x8, [x8, #0xb0]
101061ee4: f9400108    	ldr	x8, [x8]
101061ee8: f90007e8    	str	x8, [sp, #0x8]
101061eec: f00fde68    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
101061ef0: 52800029    	mov	w9, #0x1                ; =1
101061ef4: 39388d09    	strb	w9, [x8, #0xe23]
101061ef8: aa0203e0    	mov	x0, x2
101061efc: 95af148f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101061f00: b00f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
101061f04: b9838508    	ldrsw	x8, [x8, #0x384] ; ivar ContactTagNewDetailViewController._contactsKeyArray
101061f08: f8686a95    	ldr	x21, [x20, x8]
101061f0c: f00f6ec8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101061f10: f9427d01    	ldr	x1, [x8, #0x4f8] ; section
101061f14: aa1303e0    	mov	x0, x19
101061f18: 95af1489    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101061f1c: aa0003e2    	mov	x2, x0
101061f20: b00f6ec8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
101061f24: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
101061f28: aa1503e0    	mov	x0, x21
101061f2c: 95af1484    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101061f30: aa1d03fd    	mov	x29, x29
101061f34: 95af1485    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101061f38: aa0003f5    	mov	x21, x0
101061f3c: b00f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
101061f40: b9838908    	ldrsw	x8, [x8, #0x388] ; ivar ContactTagNewDetailViewController._contactsDict
101061f44: f8686a80    	ldr	x0, [x20, x8]
101061f48: f00f8508    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101061f4c: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
101061f50: aa1503e2    	mov	x2, x21
101061f54: 95af147a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101061f58: aa1d03fd    	mov	x29, x29
101061f5c: 95af147b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101061f60: aa0003f6    	mov	x22, x0
101061f64: b00f8528    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101061f68: f9440917    	ldr	x23, [x8, #0x810] ; row
101061f6c: aa1303e0    	mov	x0, x19
101061f70: aa1703e1    	mov	x1, x23
101061f74: 95af1472    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101061f78: aa0003f8    	mov	x24, x0
101061f7c: f00f84e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101061f80: f9435101    	ldr	x1, [x8, #0x6a0] ; count
101061f84: aa1603e0    	mov	x0, x22
101061f88: 95af146d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101061f8c: eb00031f    	cmp	x24, x0
101061f90: 54000402    	b.hs	0x101062010 <__text+0x105a010>
101061f94: aa1303e0    	mov	x0, x19
101061f98: aa1703e1    	mov	x1, x23
101061f9c: 95af1468    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101061fa0: aa0003e2    	mov	x2, x0
101061fa4: f00f8508    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101061fa8: f947e101    	ldr	x1, [x8, #0xfc0] ; objectAtIndexedSubscript:
101061fac: aa1603e0    	mov	x0, x22
101061fb0: 95af1463    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101061fb4: aa1d03fd    	mov	x29, x29
101061fb8: 95af1464    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101061fbc: aa0003f7    	mov	x23, x0
101061fc0: f90003e0    	str	x0, [sp]
101061fc4: d00f8888    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101061fc8: f9456d00    	ldr	x0, [x8, #0xad8]
101061fcc: d00f84e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101061fd0: f941c501    	ldr	x1, [x8, #0x388] ; arrayWithObjects:count:
101061fd4: 910003e2    	mov	x2, sp
101061fd8: 52800023    	mov	w3, #0x1                ; =1
101061fdc: 95af1458    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101061fe0: aa1d03fd    	mov	x29, x29
101061fe4: 95af1459    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101061fe8: aa0003f8    	mov	x24, x0
101061fec: 900f7148    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
101061ff0: f9433501    	ldr	x1, [x8, #0x668] ; doRemoveTagMembers:
101061ff4: aa1403e0    	mov	x0, x20
101061ff8: aa1803e2    	mov	x2, x24
101061ffc: 95af1450    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101062000: aa1803e0    	mov	x0, x24
101062004: 95af1454    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101062008: aa1703e0    	mov	x0, x23
10106200c: 95af1452    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101062010: aa1603e0    	mov	x0, x22
101062014: 95af1450    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101062018: aa1503e0    	mov	x0, x21
10106201c: 95af144e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101062020: aa1303e0    	mov	x0, x19
101062024: 95af144c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101062028: f94007e8    	ldr	x8, [sp, #0x8]
10106202c: b00e2c69    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
101062030: f9405929    	ldr	x9, [x9, #0xb0]
101062034: f9400129    	ldr	x9, [x9]
101062038: eb08013f    	cmp	x9, x8
10106203c: 540000e1    	b.ne	0x101062058 <__text+0x105a058>
101062040: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101062044: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101062048: a94257f6    	ldp	x22, x21, [sp, #0x20]
10106204c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101062050: 910143ff    	add	sp, sp, #0x50
101062054: d65f03c0    	ret
101062058: 95af1447    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
