
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106122b64: d10143ff    	sub	sp, sp, #0x50
106122b68: a9015ff8    	stp	x24, x23, [sp, #0x10]
106122b6c: a90257f6    	stp	x22, x21, [sp, #0x20]
106122b70: a9034ff4    	stp	x20, x19, [sp, #0x30]
106122b74: a9047bfd    	stp	x29, x30, [sp, #0x40]
106122b78: 910103fd    	add	x29, sp, #0x40
106122b7c: aa0203f4    	mov	x20, x2
106122b80: aa0003f3    	mov	x19, x0
106122b84: b00d5908    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
106122b88: 52800029    	mov	w9, #0x1                ; =1
106122b8c: 39178509    	strb	w9, [x8, #0x5e1]
106122b90: 52800040    	mov	w0, #0x2                ; =2
106122b94: 946ba9ab    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
106122b98: 340006e0    	cbz	w0, 0x106122c74 <_Flutter_MMFoundation_BindContext+0x25fe858>
106122b9c: 946c1181    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
106122ba0: aa0003f5    	mov	x21, x0
106122ba4: b00d0297    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
106122ba8: f94546e0    	ldr	x0, [x23, #0xa88]
106122bac: 946c116d    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106122bb0: aa0003f6    	mov	x22, x0
106122bb4: f94546f7    	ldr	x23, [x23, #0xa88]
106122bb8: b00d0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106122bbc: f9458900    	ldr	x0, [x8, #0xb10]
106122bc0: d00cff08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
106122bc4: f9479501    	ldr	x1, [x8, #0xf28] ; numberWithBool:
106122bc8: aa1403e2    	mov	x2, x20
106122bcc: 946c115c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122bd0: aa1d03fd    	mov	x29, x29
106122bd4: 946c115d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106122bd8: aa0003f8    	mov	x24, x0
106122bdc: 900cff48    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106122be0: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
106122be4: a9007fe0    	stp	x0, xzr, [sp]
106122be8: d00c3a62    	adrp	x2, 0x11e870000 <dyld_stub_binder+0x11e870000>
106122bec: 9125a042    	add	x2, x2, #0x968
106122bf0: aa1703e0    	mov	x0, x23
106122bf4: 946c1152    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122bf8: aa1d03fd    	mov	x29, x29
106122bfc: 946c1153    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106122c00: aa0003f7    	mov	x23, x0
106122c04: 900cff08    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106122c08: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
106122c0c: b00c1bc8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106122c10: 91352108    	add	x8, x8, #0xd48
106122c14: a90003e8    	stp	x8, x0, [sp]
106122c18: b00c1bc2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106122c1c: 9134a042    	add	x2, x2, #0xd28
106122c20: aa1603e0    	mov	x0, x22
106122c24: 946c1146    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122c28: aa0003f6    	mov	x22, x0
106122c2c: aa1703e0    	mov	x0, x23
106122c30: 946c1149    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106122c34: aa1803e0    	mov	x0, x24
106122c38: 946c1147    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106122c3c: f00a8781    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
106122c40: 9124e421    	add	x1, x1, #0x939
106122c44: b00ac342    	adrp	x2, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
106122c48: 91103c42    	add	x2, x2, #0x40f
106122c4c: b00ac344    	adrp	x4, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
106122c50: 91215884    	add	x4, x4, #0x856
106122c54: 52800040    	mov	w0, #0x2                ; =2
106122c58: 52802923    	mov	w3, #0x149              ; =329
106122c5c: aa1603e5    	mov	x5, x22
106122c60: 946ba979    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106122c64: aa1603e0    	mov	x0, x22
106122c68: 946c113b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106122c6c: aa1503e0    	mov	x0, x21
106122c70: 946c114f    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
106122c74: b00cecc8    	adrp	x8, 0x11febb000 <dyld_stub_binder+0x11febb000>
106122c78: f9410915    	ldr	x21, [x8, #0x210] ; tipsViewController
106122c7c: aa1303e0    	mov	x0, x19
106122c80: aa1503e1    	mov	x1, x21
106122c84: 946c112e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122c88: aa1d03fd    	mov	x29, x29
106122c8c: 946c112f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106122c90: aa0003f6    	mov	x22, x0
106122c94: 946c1130    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106122c98: b4000236    	cbz	x22, 0x106122cdc <_Flutter_MMFoundation_BindContext+0x25fe8c0>
106122c9c: aa1303e0    	mov	x0, x19
106122ca0: aa1503e1    	mov	x1, x21
106122ca4: 946c1126    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122ca8: aa1d03fd    	mov	x29, x29
106122cac: 946c1127    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106122cb0: aa0003f5    	mov	x21, x0
106122cb4: f00ced68    	adrp	x8, 0x11fed1000 <dyld_stub_binder+0x11fed1000>
106122cb8: f9400101    	ldr	x1, [x8]
106122cbc: 946c1120    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122cc0: aa1503e0    	mov	x0, x21
106122cc4: 946c1124    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106122cc8: b00cf568    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
106122ccc: f945d501    	ldr	x1, [x8, #0xba8] ; setTipsViewController:
106122cd0: aa1303e0    	mov	x0, x19
106122cd4: d2800002    	mov	x2, #0x0                ; =0
106122cd8: 946c1119    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122cdc: b00cff48    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
106122ce0: f946dd15    	ldr	x21, [x8, #0xdb8] ; viewController
106122ce4: aa1303e0    	mov	x0, x19
106122ce8: aa1503e1    	mov	x1, x21
106122cec: 946c1114    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122cf0: aa1d03fd    	mov	x29, x29
106122cf4: 946c1115    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106122cf8: aa0003f6    	mov	x22, x0
106122cfc: 946c1116    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106122d00: b40004f6    	cbz	x22, 0x106122d9c <_Flutter_MMFoundation_BindContext+0x25fe980>
106122d04: aa1303e0    	mov	x0, x19
106122d08: aa1503e1    	mov	x1, x21
106122d0c: 946c110c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122d10: aa1d03fd    	mov	x29, x29
106122d14: 946c110d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106122d18: aa0003f6    	mov	x22, x0
106122d1c: b00ce908    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
106122d20: f9422d01    	ldr	x1, [x8, #0x458] ; info
106122d24: 946c1106    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122d28: aa1d03fd    	mov	x29, x29
106122d2c: 946c1107    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106122d30: aa0003f7    	mov	x23, x0
106122d34: b00cf568    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
106122d38: f9460901    	ldr	x1, [x8, #0xc10] ; rejectInvitationWithInfo:
106122d3c: aa1303e0    	mov	x0, x19
106122d40: aa1703e2    	mov	x2, x23
106122d44: 946c10fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122d48: aa1703e0    	mov	x0, x23
106122d4c: 946c1102    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106122d50: aa1603e0    	mov	x0, x22
106122d54: 946c1100    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106122d58: aa1303e0    	mov	x0, x19
106122d5c: aa1503e1    	mov	x1, x21
106122d60: 946c10f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122d64: aa1d03fd    	mov	x29, x29
106122d68: 946c10f8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106122d6c: aa0003f5    	mov	x21, x0
106122d70: b00cf568    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
106122d74: f945d901    	ldr	x1, [x8, #0xbb0] ; clearIfNeedAnimation:
106122d78: aa1403e2    	mov	x2, x20
106122d7c: 946c10f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122d80: aa1503e0    	mov	x0, x21
106122d84: 946c10f4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106122d88: 900cff48    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106122d8c: f9412d01    	ldr	x1, [x8, #0x258] ; setViewController:
106122d90: aa1303e0    	mov	x0, x19
106122d94: d2800002    	mov	x2, #0x0                ; =0
106122d98: 946c10e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122d9c: 900cff28    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
106122da0: f942e101    	ldr	x1, [x8, #0x5c0] ; reset
106122da4: aa1303e0    	mov	x0, x19
106122da8: a9447bfd    	ldp	x29, x30, [sp, #0x40]
106122dac: a9434ff4    	ldp	x20, x19, [sp, #0x30]
106122db0: a94257f6    	ldp	x22, x21, [sp, #0x20]
106122db4: a9415ff8    	ldp	x24, x23, [sp, #0x10]
106122db8: 910143ff    	add	sp, sp, #0x50
106122dbc: 146c10e0    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
