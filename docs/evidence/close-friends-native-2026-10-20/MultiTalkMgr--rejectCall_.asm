
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104f38c58: d10103ff    	sub	sp, sp, #0x40
104f38c5c: a90157f6    	stp	x22, x21, [sp, #0x10]
104f38c60: a9024ff4    	stp	x20, x19, [sp, #0x20]
104f38c64: a9037bfd    	stp	x29, x30, [sp, #0x30]
104f38c68: 9100c3fd    	add	x29, sp, #0x30
104f38c6c: aa0203f3    	mov	x19, x2
104f38c70: f00de828    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
104f38c74: 52800029    	mov	w9, #0x1                ; =1
104f38c78: 39102509    	strb	w9, [x8, #0x409]
104f38c7c: aa0203e0    	mov	x0, x2
104f38c80: 94b3b92e    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104f38c84: 52800040    	mov	w0, #0x2                ; =2
104f38c88: 94b3516e    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
104f38c8c: 34000560    	cbz	w0, 0x104f38d38 <_Flutter_MMFoundation_BindContext+0x141491c>
104f38c90: 94b3b944    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
104f38c94: aa0003f4    	mov	x20, x0
104f38c98: f00d91d6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104f38c9c: f94546c0    	ldr	x0, [x22, #0xa88]
104f38ca0: 94b3b930    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104f38ca4: aa0003f5    	mov	x21, x0
104f38ca8: f94546c0    	ldr	x0, [x22, #0xa88]
104f38cac: d00d8e88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104f38cb0: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
104f38cb4: f90003ff    	str	xzr, [sp]
104f38cb8: d00cc442    	adrp	x2, 0x11e7c2000 <dyld_stub_binder+0x11e7c2000>
104f38cbc: 9126a042    	add	x2, x2, #0x9a8
104f38cc0: 94b3b91f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f38cc4: aa1d03fd    	mov	x29, x29
104f38cc8: 94b3b920    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f38ccc: aa0003f6    	mov	x22, x0
104f38cd0: d00d8e48    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104f38cd4: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
104f38cd8: f00cab08    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f38cdc: 91352108    	add	x8, x8, #0xd48
104f38ce0: a90003e8    	stp	x8, x0, [sp]
104f38ce4: f00cab02    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f38ce8: 9134a042    	add	x2, x2, #0xd28
104f38cec: aa1503e0    	mov	x0, x21
104f38cf0: 94b3b913    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f38cf4: aa0003f5    	mov	x21, x0
104f38cf8: aa1603e0    	mov	x0, x22
104f38cfc: 94b3b916    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f38d00: f00b4721    	adrp	x1, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104f38d04: 9124bc21    	add	x1, x1, #0x92f
104f38d08: d00b47e2    	adrp	x2, 0x11b836000 <dyld_stub_binder+0x11b836000>
104f38d0c: 912f0842    	add	x2, x2, #0xbc2
104f38d10: f00b47e4    	adrp	x4, 0x11b837000 <dyld_stub_binder+0x11b837000>
104f38d14: 912c3c84    	add	x4, x4, #0xb0f
104f38d18: 52800040    	mov	w0, #0x2                ; =2
104f38d1c: 5280bd83    	mov	w3, #0x5ec              ; =1516
104f38d20: aa1503e5    	mov	x5, x21
104f38d24: 94b35148    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
104f38d28: aa1503e0    	mov	x0, x21
104f38d2c: 94b3b90a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f38d30: aa1403e0    	mov	x0, x20
104f38d34: 94b3b91e    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
104f38d38: f00d91c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104f38d3c: f945e900    	ldr	x0, [x8, #0xbd0]
104f38d40: 900d8e48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104f38d44: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104f38d48: 94b3b8fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f38d4c: aa1d03fd    	mov	x29, x29
104f38d50: 94b3b8fe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f38d54: aa0003f4    	mov	x20, x0
104f38d58: f00d9208    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
104f38d5c: f945cd00    	ldr	x0, [x8, #0xb98]
104f38d60: f00d8e28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104f38d64: f947ad01    	ldr	x1, [x8, #0xf58] ; class
104f38d68: 94b3b8f5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f38d6c: aa0003e2    	mov	x2, x0
104f38d70: b00d7808    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104f38d74: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104f38d78: aa1403e0    	mov	x0, x20
104f38d7c: 94b3b8f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f38d80: aa1d03fd    	mov	x29, x29
104f38d84: 94b3b8f1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f38d88: aa0003f5    	mov	x21, x0
104f38d8c: b00d7a68    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
104f38d90: f945c101    	ldr	x1, [x8, #0xb80] ; hangup:
104f38d94: 52800022    	mov	w2, #0x1                ; =1
104f38d98: 94b3b8e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f38d9c: aa1503e0    	mov	x0, x21
104f38da0: 94b3b8ed    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f38da4: aa1403e0    	mov	x0, x20
104f38da8: 94b3b8eb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f38dac: aa1303e0    	mov	x0, x19
104f38db0: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104f38db4: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104f38db8: a94157f6    	ldp	x22, x21, [sp, #0x10]
104f38dbc: 910103ff    	add	sp, sp, #0x40
104f38dc0: 14b3b8e5    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
