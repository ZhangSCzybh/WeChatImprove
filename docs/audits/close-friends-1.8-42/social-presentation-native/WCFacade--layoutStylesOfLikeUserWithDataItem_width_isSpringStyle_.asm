
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
107122e6c: d101c3ff    	sub	sp, sp, #0x70
107122e70: 6d0223e9    	stp	d9, d8, [sp, #0x20]
107122e74: a9035ff8    	stp	x24, x23, [sp, #0x30]
107122e78: a90457f6    	stp	x22, x21, [sp, #0x40]
107122e7c: a9054ff4    	stp	x20, x19, [sp, #0x50]
107122e80: a9067bfd    	stp	x29, x30, [sp, #0x60]
107122e84: 910183fd    	add	x29, sp, #0x60
107122e88: aa0303f5    	mov	x21, x3
107122e8c: 1e604008    	fmov	d8, d0
107122e90: aa0203f3    	mov	x19, x2
107122e94: aa0003f4    	mov	x20, x0
107122e98: 900cd928    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
107122e9c: 52800029    	mov	w9, #0x1                ; =1
107122ea0: 393ff509    	strb	w9, [x8, #0xffd]
107122ea4: aa0203e0    	mov	x0, x2
107122ea8: 942c10a4    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
107122eac: fd0007e8    	str	d8, [sp, #0x8]
107122eb0: b00c6a68    	adrp	x8, 0x11fe6f000 <dyld_stub_binder+0x11fe6f000>
107122eb4: f9425116    	ldr	x22, [x8, #0x4a0] ; itemID
107122eb8: aa1303e0    	mov	x0, x19
107122ebc: aa1603e1    	mov	x1, x22
107122ec0: 942c109f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
107122ec4: aa1d03fd    	mov	x29, x29
107122ec8: 942c10a0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
107122ecc: aa0003f7    	mov	x23, x0
107122ed0: 942c10a1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
107122ed4: b4000357    	cbz	x23, 0x107122f3c <_Flutter_MMFoundation_BindContext+0x35feb20>
107122ed8: b00c8928    	adrp	x8, 0x120247000 <dyld_stub_binder+0x120247000>
107122edc: 9124e108    	add	x8, x8, #0x938
107122ee0: b9800108    	ldrsw	x8, [x8]
107122ee4: f8686a94    	ldr	x20, [x20, x8]
107122ee8: aa1303e0    	mov	x0, x19
107122eec: aa1603e1    	mov	x1, x22
107122ef0: 942c1093    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
107122ef4: aa1d03fd    	mov	x29, x29
107122ef8: 942c1094    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
107122efc: aa0003f6    	mov	x22, x0
107122f00: d00c7f08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
107122f04: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
107122f08: aa1403e0    	mov	x0, x20
107122f0c: aa1603e2    	mov	x2, x22
107122f10: 942c108b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
107122f14: aa1d03fd    	mov	x29, x29
107122f18: 942c108c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
107122f1c: aa0003f4    	mov	x20, x0
107122f20: aa1603e0    	mov	x0, x22
107122f24: 942c108c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
107122f28: b40000f4    	cbz	x20, 0x107122f44 <_Flutter_MMFoundation_BindContext+0x35feb28>
107122f2c: 34000115    	cbz	w21, 0x107122f4c <_Flutter_MMFoundation_BindContext+0x35feb30>
107122f30: f00c7708    	adrp	x8, 0x120005000 <dyld_stub_binder+0x120005000>
107122f34: f946c901    	ldr	x1, [x8, #0xd90] ; springLikeUserLayoutStyles
107122f38: 14000007    	b	0x107122f54 <_Flutter_MMFoundation_BindContext+0x35feb38>
107122f3c: d2800015    	mov	x21, #0x0               ; =0
107122f40: 14000014    	b	0x107122f90 <_Flutter_MMFoundation_BindContext+0x35feb74>
107122f44: d2800015    	mov	x21, #0x0               ; =0
107122f48: 14000010    	b	0x107122f88 <_Flutter_MMFoundation_BindContext+0x35feb6c>
107122f4c: f00c7708    	adrp	x8, 0x120005000 <dyld_stub_binder+0x120005000>
107122f50: f946cd01    	ldr	x1, [x8, #0xd98] ; likeUserLayoutStyles
107122f54: aa1403e0    	mov	x0, x20
107122f58: 942c1079    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
107122f5c: 910023e8    	add	x8, sp, #0x8
107122f60: f9000fe8    	str	x8, [sp, #0x18]
107122f64: d0098a42    	adrp	x2, 0x11a26c000 <dyld_stub_binder+0x11a26c000>
107122f68: 91282842    	add	x2, x2, #0xa0a
107122f6c: 910023e1    	add	x1, sp, #0x8
107122f70: 910063e3    	add	x3, sp, #0x18
107122f74: 91005fe4    	add	x4, sp, #0x17
107122f78: 940009fa    	bl	0x107125760 <_Flutter_MMFoundation_BindContext+0x3601344>
107122f7c: f9400c15    	ldr	x21, [x0, #0x18]
107122f80: aa1503e0    	mov	x0, x21
107122f84: 942c106d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
107122f88: aa1403e0    	mov	x0, x20
107122f8c: 942c1072    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
107122f90: aa1303e0    	mov	x0, x19
107122f94: 942c1070    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
107122f98: aa1503e0    	mov	x0, x21
107122f9c: a9467bfd    	ldp	x29, x30, [sp, #0x60]
107122fa0: a9454ff4    	ldp	x20, x19, [sp, #0x50]
107122fa4: a94457f6    	ldp	x22, x21, [sp, #0x40]
107122fa8: a9435ff8    	ldp	x24, x23, [sp, #0x30]
107122fac: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
107122fb0: 9101c3ff    	add	sp, sp, #0x70
107122fb4: 142c106f    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
