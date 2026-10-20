
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e46bc4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
100e46bc8: a9014ff4    	stp	x20, x19, [sp, #0x10]
100e46bcc: a9027bfd    	stp	x29, x30, [sp, #0x20]
100e46bd0: 910083fd    	add	x29, sp, #0x20
100e46bd4: d00f9d08    	adrp	x8, 0x1201e8000 <dyld_stub_binder+0x1201e8000>
100e46bd8: b9855d08    	ldrsw	x8, [x8, #0x55c]
100e46bdc: f8686800    	ldr	x0, [x0, x8]
100e46be0: 900f7fa8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
100e46be4: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
100e46be8: 95b78155    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e46bec: aa1d03fd    	mov	x29, x29
100e46bf0: 95b78156    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e46bf4: aa0003f3    	mov	x19, x0
100e46bf8: b00f9968    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e46bfc: f945e900    	ldr	x0, [x8, #0xbd0]
100e46c00: d00f95c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e46c04: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100e46c08: 95b7814d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e46c0c: aa1d03fd    	mov	x29, x29
100e46c10: 95b7814e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e46c14: aa0003f4    	mov	x20, x0
100e46c18: d00f9968    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100e46c1c: f9401d00    	ldr	x0, [x8, #0x38]
100e46c20: b00f95c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100e46c24: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100e46c28: 95b78145    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e46c2c: aa0003e2    	mov	x2, x0
100e46c30: f00f7f88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e46c34: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100e46c38: aa1403e0    	mov	x0, x20
100e46c3c: 95b78140    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e46c40: aa1d03fd    	mov	x29, x29
100e46c44: 95b78141    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e46c48: aa0003f5    	mov	x21, x0
100e46c4c: b00f80c8    	adrp	x8, 0x11fe5f000 <dyld_stub_binder+0x11fe5f000>
100e46c50: f945b101    	ldr	x1, [x8, #0xb60] ; SyncFulFillSession:
100e46c54: aa1303e2    	mov	x2, x19
100e46c58: 95b78139    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e46c5c: aa1503e0    	mov	x0, x21
100e46c60: 95b7813d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e46c64: aa1403e0    	mov	x0, x20
100e46c68: 95b7813b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e46c6c: aa1303e0    	mov	x0, x19
100e46c70: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100e46c74: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100e46c78: a8c357f6    	ldp	x22, x21, [sp], #0x30
100e46c7c: 15b7813d    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
