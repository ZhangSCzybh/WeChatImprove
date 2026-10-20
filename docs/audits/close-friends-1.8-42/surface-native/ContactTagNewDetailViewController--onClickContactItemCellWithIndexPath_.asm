
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101062cd8: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
101062cdc: a90157f6    	stp	x22, x21, [sp, #0x10]
101062ce0: a9024ff4    	stp	x20, x19, [sp, #0x20]
101062ce4: a9037bfd    	stp	x29, x30, [sp, #0x30]
101062ce8: 9100c3fd    	add	x29, sp, #0x30
101062cec: aa0203f3    	mov	x19, x2
101062cf0: aa0003f5    	mov	x21, x0
101062cf4: d00fde68    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
101062cf8: 52800029    	mov	w9, #0x1                ; =1
101062cfc: 3938a109    	strb	w9, [x8, #0xe28]
101062d00: aa0203e0    	mov	x0, x2
101062d04: 95af110d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101062d08: 900f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
101062d0c: b9838508    	ldrsw	x8, [x8, #0x384] ; ivar ContactTagNewDetailViewController._contactsKeyArray
101062d10: f8686ab4    	ldr	x20, [x21, x8]
101062d14: d00f6ec8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101062d18: f9427d01    	ldr	x1, [x8, #0x4f8] ; section
101062d1c: aa1303e0    	mov	x0, x19
101062d20: 95af1107    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101062d24: aa0003e2    	mov	x2, x0
101062d28: 900f6ec8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
101062d2c: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
101062d30: aa1403e0    	mov	x0, x20
101062d34: 95af1102    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101062d38: aa1d03fd    	mov	x29, x29
101062d3c: 95af1103    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101062d40: aa0003f4    	mov	x20, x0
101062d44: 900f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
101062d48: b9838908    	ldrsw	x8, [x8, #0x388] ; ivar ContactTagNewDetailViewController._contactsDict
101062d4c: f8686aa0    	ldr	x0, [x21, x8]
101062d50: d00f8508    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101062d54: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
101062d58: aa1403e2    	mov	x2, x20
101062d5c: 95af10f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101062d60: aa1d03fd    	mov	x29, x29
101062d64: 95af10f9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101062d68: aa0003f6    	mov	x22, x0
101062d6c: 900f8528    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101062d70: f9440917    	ldr	x23, [x8, #0x810] ; row
101062d74: aa1303e0    	mov	x0, x19
101062d78: aa1703e1    	mov	x1, x23
101062d7c: 95af10f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101062d80: aa0003f8    	mov	x24, x0
101062d84: d00f84e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101062d88: f9435101    	ldr	x1, [x8, #0x6a0] ; count
101062d8c: aa1603e0    	mov	x0, x22
101062d90: 95af10eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101062d94: eb00031f    	cmp	x24, x0
101062d98: 540001a2    	b.hs	0x101062dcc <__text+0x105adcc>
101062d9c: aa1303e0    	mov	x0, x19
101062da0: aa1703e1    	mov	x1, x23
101062da4: 95af10e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101062da8: aa0003e2    	mov	x2, x0
101062dac: d00f8508    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101062db0: f947e101    	ldr	x1, [x8, #0xfc0] ; objectAtIndexedSubscript:
101062db4: aa1603e0    	mov	x0, x22
101062db8: 95af10e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101062dbc: aa1d03fd    	mov	x29, x29
101062dc0: 95af10e2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101062dc4: aa0003f7    	mov	x23, x0
101062dc8: 14000002    	b	0x101062dd0 <__text+0x105add0>
101062dcc: d2800017    	mov	x23, #0x0               ; =0
101062dd0: d00f8888    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
101062dd4: f9400900    	ldr	x0, [x8, #0x10] ; `:,
101062dd8: 95af10e0    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
101062ddc: aa0003f8    	mov	x24, x0
101062de0: b00f6ec8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101062de4: f946dd01    	ldr	x1, [x8, #0xdb8] ; setM_contact:
101062de8: aa1703e2    	mov	x2, x23
101062dec: 95af10d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101062df0: d00f6ee8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
101062df4: f9433d01    	ldr	x1, [x8, #0x678] ; m_uiFromScene
101062df8: aa1503e0    	mov	x0, x21
101062dfc: 95af10d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101062e00: 71000c1f    	cmp	w0, #0x3
101062e04: 54000061    	b.ne	0x101062e10 <__text+0x105ae10>
101062e08: 52800bc2    	mov	w2, #0x5e               ; =94
101062e0c: 14000008    	b	0x101062e2c <__text+0x105ae2c>
101062e10: 900f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
101062e14: b9837d08    	ldrsw	x8, [x8, #0x37c] ; ivar ContactTagNewDetailViewController._curActionType
101062e18: f8686aa8    	ldr	x8, [x21, x8]
101062e1c: f100091f    	cmp	x8, #0x2
101062e20: 52800488    	mov	w8, #0x24               ; =36
101062e24: 52800449    	mov	w9, #0x22               ; =34
101062e28: 1a880122    	csel	w2, w9, w8, eq
101062e2c: b00f6ec8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101062e30: f946e901    	ldr	x1, [x8, #0xdd0] ; setM_uiFromScene:
101062e34: aa1803e0    	mov	x0, x24
101062e38: 95af10c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101062e3c: b00f6ec8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101062e40: f946e101    	ldr	x1, [x8, #0xdc0] ; setHidesBottomBarWhenPushed:
101062e44: aa1803e0    	mov	x0, x24
101062e48: 52800022    	mov	w2, #0x1                ; =1
101062e4c: 95af10bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101062e50: d00f8508    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101062e54: f945dd01    	ldr	x1, [x8, #0xbb8] ; navigationController
101062e58: aa1503e0    	mov	x0, x21
101062e5c: 95af10b8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101062e60: aa1d03fd    	mov	x29, x29
101062e64: 95af10b9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101062e68: aa0003f5    	mov	x21, x0
101062e6c: b00f6ec8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101062e70: f944e101    	ldr	x1, [x8, #0x9c0] ; PushViewController:animated:
101062e74: aa1803e2    	mov	x2, x24
101062e78: 52800023    	mov	w3, #0x1                ; =1
101062e7c: 95af10b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101062e80: aa1503e0    	mov	x0, x21
101062e84: 95af10b4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101062e88: aa1803e0    	mov	x0, x24
101062e8c: 95af10b2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101062e90: aa1703e0    	mov	x0, x23
101062e94: 95af10b0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101062e98: aa1603e0    	mov	x0, x22
101062e9c: 95af10ae    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101062ea0: aa1403e0    	mov	x0, x20
101062ea4: 95af10ac    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101062ea8: aa1303e0    	mov	x0, x19
101062eac: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101062eb0: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101062eb4: a94157f6    	ldp	x22, x21, [sp, #0x10]
101062eb8: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101062ebc: 15af10a6    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
