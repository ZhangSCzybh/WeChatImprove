
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104adcb58: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
104adcb5c: a90157f6    	stp	x22, x21, [sp, #0x10]
104adcb60: a9024ff4    	stp	x20, x19, [sp, #0x20]
104adcb64: a9037bfd    	stp	x29, x30, [sp, #0x30]
104adcb68: 9100c3fd    	add	x29, sp, #0x30
104adcb6c: aa0303f4    	mov	x20, x3
104adcb70: aa0203f3    	mov	x19, x2
104adcb74: aa0003f5    	mov	x21, x0
104adcb78: aa0203e0    	mov	x0, x2
104adcb7c: 94c5296f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104adcb80: f00dba28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104adcb84: b9869108    	ldrsw	x8, [x8, #0x690]
104adcb88: f8686ab6    	ldr	x22, [x21, x8]
104adcb8c: b00d9be8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
104adcb90: f942e117    	ldr	x23, [x8, #0x5c0] ; arrResult
104adcb94: aa1403e0    	mov	x0, x20
104adcb98: 94c52968    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104adcb9c: aa1603e0    	mov	x0, x22
104adcba0: aa1703e1    	mov	x1, x23
104adcba4: 94c52966    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adcba8: aa1d03fd    	mov	x29, x29
104adcbac: 94c52967    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adcbb0: aa0003f6    	mov	x22, x0
104adcbb4: d00db148    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104adcbb8: f9440901    	ldr	x1, [x8, #0x810] ; row
104adcbbc: aa1403e0    	mov	x0, x20
104adcbc0: 94c5295f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adcbc4: aa0003f7    	mov	x23, x0
104adcbc8: aa1403e0    	mov	x0, x20
104adcbcc: 94c52962    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adcbd0: d00d9ae8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104adcbd4: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
104adcbd8: aa1603e0    	mov	x0, x22
104adcbdc: aa1703e2    	mov	x2, x23
104adcbe0: 94c52957    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adcbe4: aa1d03fd    	mov	x29, x29
104adcbe8: 94c52958    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adcbec: aa0003f4    	mov	x20, x0
104adcbf0: b00da548    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104adcbf4: f9451d01    	ldr	x1, [x8, #0xa38] ; makeResultCell:contact:
104adcbf8: aa1503e0    	mov	x0, x21
104adcbfc: aa1303e2    	mov	x2, x19
104adcc00: aa1403e3    	mov	x3, x20
104adcc04: 94c5294e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adcc08: aa1403e0    	mov	x0, x20
104adcc0c: 94c52952    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adcc10: aa1603e0    	mov	x0, x22
104adcc14: 94c52950    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adcc18: aa1303e0    	mov	x0, x19
104adcc1c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104adcc20: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104adcc24: a94157f6    	ldp	x22, x21, [sp, #0x10]
104adcc28: a8c45ff8    	ldp	x24, x23, [sp], #0x40
104adcc2c: 14c52951    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
