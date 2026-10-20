
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100320c10: 6dbb23e9    	stp	d9, d8, [sp, #-0x50]!
100320c14: a9015ff8    	stp	x24, x23, [sp, #0x10]
100320c18: a90257f6    	stp	x22, x21, [sp, #0x20]
100320c1c: a9034ff4    	stp	x20, x19, [sp, #0x30]
100320c20: a9047bfd    	stp	x29, x30, [sp, #0x40]
100320c24: 910103fd    	add	x29, sp, #0x40
100320c28: aa0303f4    	mov	x20, x3
100320c2c: aa0203f3    	mov	x19, x2
100320c30: aa0003f5    	mov	x21, x0
100320c34: b0104868    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
100320c38: 52800029    	mov	w9, #0x1                ; =1
100320c3c: 3937a509    	strb	w9, [x8, #0xde9]
100320c40: aa0203e0    	mov	x0, x2
100320c44: 95e4193d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100320c48: aa1403e0    	mov	x0, x20
100320c4c: 95e4193b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100320c50: f00ff5e8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
100320c54: b9852508    	ldrsw	x8, [x8, #0x524]
100320c58: 8b0802b7    	add	x23, x21, x8
100320c5c: f94006e8    	ldr	x8, [x23, #0x8]
100320c60: 900fd8f6    	adrp	x22, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100320c64: b4000128    	cbz	x8, 0x100320c88 <__text+0x318c88>
100320c68: f9427ec1    	ldr	x1, [x22, #0x4f8] ; section
100320c6c: aa1403e0    	mov	x0, x20
100320c70: 95e41933    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320c74: a94026e8    	ldp	x8, x9, [x23]
100320c78: eb080008    	subs	x8, x0, x8
100320c7c: 9e6703e8    	fmov	d8, xzr
100320c80: fa492102    	ccmp	x8, x9, #0x2, hs
100320c84: 54000623    	b.lo	0x100320d48 <__text+0x318d48>
100320c88: f00ff5e8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
100320c8c: b9842918    	ldrsw	x24, [x8, #0x428]
100320c90: f8786aa0    	ldr	x0, [x21, x24]
100320c94: 9e6703e8    	fmov	d8, xzr
100320c98: b4000580    	cbz	x0, 0x100320d48 <__text+0x318d48>
100320c9c: 900fef08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100320ca0: f9435101    	ldr	x1, [x8, #0x6a0] ; count
100320ca4: 95e41926    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320ca8: aa0003f7    	mov	x23, x0
100320cac: f9427ed6    	ldr	x22, [x22, #0x4f8] ; section
100320cb0: aa1403e0    	mov	x0, x20
100320cb4: aa1603e1    	mov	x1, x22
100320cb8: 95e41921    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320cbc: eb0002ff    	cmp	x23, x0
100320cc0: 54000449    	b.ls	0x100320d48 <__text+0x318d48>
100320cc4: f8786ab5    	ldr	x21, [x21, x24]
100320cc8: aa1403e0    	mov	x0, x20
100320ccc: aa1603e1    	mov	x1, x22
100320cd0: 95e4191b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320cd4: aa0003e2    	mov	x2, x0
100320cd8: 900fef28    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100320cdc: f947e101    	ldr	x1, [x8, #0xfc0] ; objectAtIndexedSubscript:
100320ce0: aa1503e0    	mov	x0, x21
100320ce4: 95e41916    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320ce8: aa1d03fd    	mov	x29, x29
100320cec: 95e41917    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100320cf0: aa0003f5    	mov	x21, x0
100320cf4: b4000260    	cbz	x0, 0x100320d40 <__text+0x318d40>
100320cf8: d00fef28    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
100320cfc: f9440901    	ldr	x1, [x8, #0x810] ; row
100320d00: aa1403e0    	mov	x0, x20
100320d04: 95e4190e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320d08: aa0003e2    	mov	x2, x0
100320d0c: d00fd948    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
100320d10: f9409501    	ldr	x1, [x8, #0x128] ; cellDataForRow:
100320d14: aa1503e0    	mov	x0, x21
100320d18: 95e41909    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320d1c: aa1d03fd    	mov	x29, x29
100320d20: 95e4190a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100320d24: aa0003f6    	mov	x22, x0
100320d28: d00fd948    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
100320d2c: f9409901    	ldr	x1, [x8, #0x130] ; rowHeight
100320d30: 95e41903    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320d34: 1e604008    	fmov	d8, d0
100320d38: aa1603e0    	mov	x0, x22
100320d3c: 95e41906    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100320d40: aa1503e0    	mov	x0, x21
100320d44: 95e41904    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100320d48: aa1403e0    	mov	x0, x20
100320d4c: 95e41902    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100320d50: aa1303e0    	mov	x0, x19
100320d54: 95e41900    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100320d58: 1e604100    	fmov	d0, d8
100320d5c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
100320d60: a9434ff4    	ldp	x20, x19, [sp, #0x30]
100320d64: a94257f6    	ldp	x22, x21, [sp, #0x20]
100320d68: a9415ff8    	ldp	x24, x23, [sp, #0x10]
100320d6c: 6cc523e9    	ldp	d9, d8, [sp], #0x50
100320d70: d65f03c0    	ret