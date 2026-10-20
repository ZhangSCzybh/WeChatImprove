
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100fb6b10: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
100fb6b14: a9014ff4    	stp	x20, x19, [sp, #0x10]
100fb6b18: a9027bfd    	stp	x29, x30, [sp, #0x20]
100fb6b1c: 910083fd    	add	x29, sp, #0x20
100fb6b20: aa0003f4    	mov	x20, x0
100fb6b24: d00fe3c8    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100fb6b28: 52800029    	mov	w9, #0x1                ; =1
100fb6b2c: 392e5509    	strb	w9, [x8, #0xb95]
100fb6b30: b00f8de8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100fb6b34: f945e900    	ldr	x0, [x8, #0xbd0]
100fb6b38: d00f8a48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100fb6b3c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100fb6b40: 95b1c17f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fb6b44: aa1d03fd    	mov	x29, x29
100fb6b48: 95b1c180    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fb6b4c: aa0003f5    	mov	x21, x0
100fb6b50: d00f8de8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100fb6b54: f9401500    	ldr	x0, [x8, #0x28] ; P;,
100fb6b58: b00f8a48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100fb6b5c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100fb6b60: 95b1c177    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fb6b64: aa0003e2    	mov	x2, x0
100fb6b68: f00f7408    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100fb6b6c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100fb6b70: aa1503e0    	mov	x0, x21
100fb6b74: 95b1c172    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fb6b78: aa1d03fd    	mov	x29, x29
100fb6b7c: 95b1c173    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fb6b80: aa0003f3    	mov	x19, x0
100fb6b84: aa1503e0    	mov	x0, x21
100fb6b88: 95b1c173    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fb6b8c: f00f9188    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100fb6b90: b98c0d08    	ldrsw	x8, [x8, #0xc0c] ; ivar ContactInfoViewController.m_contact
100fb6b94: f8686a80    	ldr	x0, [x20, x8]
100fb6b98: b00f7428    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100fb6b9c: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
100fb6ba0: 95b1c167    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fb6ba4: aa1d03fd    	mov	x29, x29
100fb6ba8: 95b1c168    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fb6bac: aa0003f5    	mov	x21, x0
100fb6bb0: d00f7428    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100fb6bb4: f940c901    	ldr	x1, [x8, #0x190] ; getContactByName:
100fb6bb8: aa1303e0    	mov	x0, x19
100fb6bbc: aa1503e2    	mov	x2, x21
100fb6bc0: 95b1c15f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fb6bc4: aa1d03fd    	mov	x29, x29
100fb6bc8: 95b1c160    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fb6bcc: aa0003f4    	mov	x20, x0
100fb6bd0: aa1503e0    	mov	x0, x21
100fb6bd4: 95b1c160    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fb6bd8: b40000f4    	cbz	x20, 0x100fb6bf4 <__text+0xfaebf4>
100fb6bdc: d00f7428    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100fb6be0: f940cd01    	ldr	x1, [x8, #0x198] ; isMMContact
100fb6be4: aa1403e0    	mov	x0, x20
100fb6be8: 95b1c155    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fb6bec: aa0003f5    	mov	x21, x0
100fb6bf0: 14000002    	b	0x100fb6bf8 <__text+0xfaebf8>
100fb6bf4: 52800015    	mov	w21, #0x0               ; =0
100fb6bf8: aa1403e0    	mov	x0, x20
100fb6bfc: 95b1c156    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fb6c00: aa1303e0    	mov	x0, x19
100fb6c04: 95b1c154    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fb6c08: aa1503e0    	mov	x0, x21
100fb6c0c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100fb6c10: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100fb6c14: a8c357f6    	ldp	x22, x21, [sp], #0x30
100fb6c18: d65f03c0    	ret
