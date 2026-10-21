
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101763ca8: d10143ff    	sub	sp, sp, #0x50
101763cac: a9015ff8    	stp	x24, x23, [sp, #0x10]
101763cb0: a90257f6    	stp	x22, x21, [sp, #0x20]
101763cb4: a9034ff4    	stp	x20, x19, [sp, #0x30]
101763cb8: a9047bfd    	stp	x29, x30, [sp, #0x40]
101763cbc: 910103fd    	add	x29, sp, #0x40
101763cc0: aa0003f4    	mov	x20, x0
101763cc4: f00fa668    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
101763cc8: 52800029    	mov	w9, #0x1                ; =1
101763ccc: 3922a909    	strb	w9, [x8, #0x8aa]
101763cd0: 900f5088    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101763cd4: f9453500    	ldr	x0, [x8, #0xa68]
101763cd8: d00f36a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101763cdc: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
101763ce0: f00e7168    	adrp	x8, 0x11e592000 <dyld_stub_binder+0x11e592000>
101763ce4: 913ea108    	add	x8, x8, #0xfa8
101763ce8: f90003e8    	str	x8, [sp]
101763cec: b00cd883    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
101763cf0: 91388063    	add	x3, x3, #0xe20
101763cf4: 900ce405    	adrp	x5, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
101763cf8: 911b74a5    	add	x5, x5, #0x6dd
101763cfc: 900ce407    	adrp	x7, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
101763d00: 9130e0e7    	add	x7, x7, #0xc38
101763d04: 52800042    	mov	w2, #0x2                ; =2
101763d08: 52800004    	mov	w4, #0x0                ; =0
101763d0c: 52805e66    	mov	w6, #0x2f3              ; =755
101763d10: 95930d0b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101763d14: 900f5088    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101763d18: f945e900    	ldr	x0, [x8, #0xbd0]
101763d1c: b00f4ce8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101763d20: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
101763d24: 95930d06    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101763d28: aa1d03fd    	mov	x29, x29
101763d2c: 95930d07    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101763d30: aa0003f3    	mov	x19, x0
101763d34: 900f5088    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101763d38: f9477100    	ldr	x0, [x8, #0xee0]
101763d3c: 900f4ce8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101763d40: f947ad01    	ldr	x1, [x8, #0xf58] ; class
101763d44: 95930cfe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101763d48: aa0003e2    	mov	x2, x0
101763d4c: d00f36a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101763d50: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
101763d54: aa1303e0    	mov	x0, x19
101763d58: 95930cf9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101763d5c: aa1d03fd    	mov	x29, x29
101763d60: 95930cfa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101763d64: aa0003f5    	mov	x21, x0
101763d68: f00f3908    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
101763d6c: f9454d01    	ldr	x1, [x8, #0xa98] ; ftsReportMgr
101763d70: 95930cf3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101763d74: aa1d03fd    	mov	x29, x29
101763d78: 95930cf4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101763d7c: aa0003f6    	mov	x22, x0
101763d80: b00f3828    	adrp	x8, 0x11fe68000 <dyld_stub_binder+0x11fe68000>
101763d84: f946f101    	ldr	x1, [x8, #0xde0] ; presenter
101763d88: aa1403e0    	mov	x0, x20
101763d8c: 95930cec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101763d90: aa1d03fd    	mov	x29, x29
101763d94: 95930ced    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101763d98: aa0003f4    	mov	x20, x0
101763d9c: d00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101763da0: f9411101    	ldr	x1, [x8, #0x220] ; getExtInfo
101763da4: 95930ce6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101763da8: aa1d03fd    	mov	x29, x29
101763dac: 95930ce7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101763db0: aa0003f7    	mov	x23, x0
101763db4: 900f36c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101763db8: f943ad01    	ldr	x1, [x8, #0x758] ; JSONRepresentation
101763dbc: 95930ce0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101763dc0: aa1d03fd    	mov	x29, x29
101763dc4: 95930ce1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101763dc8: aa0003f8    	mov	x24, x0
101763dcc: d00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101763dd0: f9412901    	ldr	x1, [x8, #0x250] ; newCTREndSearch:force:
101763dd4: aa1603e0    	mov	x0, x22
101763dd8: aa1803e2    	mov	x2, x24
101763ddc: 52800023    	mov	w3, #0x1                ; =1
101763de0: 95930cd7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101763de4: aa1803e0    	mov	x0, x24
101763de8: 95930cdb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101763dec: aa1703e0    	mov	x0, x23
101763df0: 95930cd9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101763df4: aa1403e0    	mov	x0, x20
101763df8: 95930cd7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101763dfc: aa1603e0    	mov	x0, x22
101763e00: 95930cd5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101763e04: aa1503e0    	mov	x0, x21
101763e08: 95930cd3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101763e0c: aa1303e0    	mov	x0, x19
101763e10: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101763e14: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101763e18: a94257f6    	ldp	x22, x21, [sp, #0x20]
101763e1c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101763e20: 910143ff    	add	sp, sp, #0x50
101763e24: 15930ccc    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
