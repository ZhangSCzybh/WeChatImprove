
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106ee2c18: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
106ee2c1c: a9014ff4    	stp	x20, x19, [sp, #0x10]
106ee2c20: a9027bfd    	stp	x29, x30, [sp, #0x20]
106ee2c24: 910083fd    	add	x29, sp, #0x20
106ee2c28: aa0303e2    	mov	x2, x3
106ee2c2c: aa0003f3    	mov	x19, x0
106ee2c30: 900ceb28    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
106ee2c34: 52800029    	mov	w9, #0x1                ; =1
106ee2c38: 391fc909    	strb	w9, [x8, #0x7f2]
106ee2c3c: f00c9b08    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106ee2c40: b9896908    	ldrsw	x8, [x8, #0x968]
106ee2c44: 38686808    	ldrb	w8, [x0, x8]
106ee2c48: 7100051f    	cmp	w8, #0x1
106ee2c4c: 54000181    	b.ne	0x106ee2c7c <_Flutter_MMFoundation_BindContext+0x33be860>
106ee2c50: f00c9b08    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106ee2c54: b9896508    	ldrsw	x8, [x8, #0x964]
106ee2c58: 38686a68    	ldrb	w8, [x19, x8]
106ee2c5c: 7100051f    	cmp	w8, #0x1
106ee2c60: 540000e1    	b.ne	0x106ee2c7c <_Flutter_MMFoundation_BindContext+0x33be860>
106ee2c64: 900c8888    	adrp	x8, 0x11fff2000 <dyld_stub_binder+0x11fff2000>
106ee2c68: f9479901    	ldr	x1, [x8, #0xf30] ; getWCCommentListCount:
106ee2c6c: aa1303e0    	mov	x0, x19
106ee2c70: 94351133    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2c74: 91000414    	add	x20, x0, #0x1
106ee2c78: 14000006    	b	0x106ee2c90 <_Flutter_MMFoundation_BindContext+0x33be874>
106ee2c7c: 900c8888    	adrp	x8, 0x11fff2000 <dyld_stub_binder+0x11fff2000>
106ee2c80: f9479901    	ldr	x1, [x8, #0xf30] ; getWCCommentListCount:
106ee2c84: aa1303e0    	mov	x0, x19
106ee2c88: 9435112d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2c8c: aa0003f4    	mov	x20, x0
106ee2c90: f100029f    	cmp	x20, #0x0
106ee2c94: 1a9fd7f5    	cset	w21, gt
106ee2c98: d00c9108    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
106ee2c9c: f945e501    	ldr	x1, [x8, #0xbc8] ; navigationItem
106ee2ca0: aa1303e0    	mov	x0, x19
106ee2ca4: 94351126    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2ca8: aa1d03fd    	mov	x29, x29
106ee2cac: 94351127    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ee2cb0: aa0003f3    	mov	x19, x0
106ee2cb4: b00c7ac8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106ee2cb8: f945e901    	ldr	x1, [x8, #0xbd0] ; rightBarButtonItem
106ee2cbc: 94351120    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2cc0: aa1d03fd    	mov	x29, x29
106ee2cc4: 94351121    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ee2cc8: aa0003f6    	mov	x22, x0
106ee2ccc: b00c9128    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
106ee2cd0: f946bd01    	ldr	x1, [x8, #0xd78] ; setEnabled:
106ee2cd4: aa1503e2    	mov	x2, x21
106ee2cd8: 94351119    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ee2cdc: aa1603e0    	mov	x0, x22
106ee2ce0: 9435111d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ee2ce4: aa1303e0    	mov	x0, x19
106ee2ce8: 9435111b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ee2cec: aa1403e0    	mov	x0, x20
106ee2cf0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
106ee2cf4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106ee2cf8: a8c357f6    	ldp	x22, x21, [sp], #0x30
106ee2cfc: d65f03c0    	ret
