
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105122c24: d10183ff    	sub	sp, sp, #0x60
105122c28: a90357f6    	stp	x22, x21, [sp, #0x30]
105122c2c: a9044ff4    	stp	x20, x19, [sp, #0x40]
105122c30: a9057bfd    	stp	x29, x30, [sp, #0x50]
105122c34: 910143fd    	add	x29, sp, #0x50
105122c38: b00dd8e8    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
105122c3c: 52800029    	mov	w9, #0x1                ; =1
105122c40: 392e5109    	strb	w9, [x8, #0xb94]
105122c44: d00d8828    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105122c48: b9831508    	ldrsw	x8, [x8, #0x314]
105122c4c: f8686800    	ldr	x0, [x0, x8]
105122c50: d00d6ae8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
105122c54: f943a901    	ldr	x1, [x8, #0x750] ; selector updateCellData:
105122c58: 94ac1139    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105122c5c: aa1d03fd    	mov	x29, x29
105122c60: 94ac113a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105122c64: aa0003f3    	mov	x19, x0
105122c68: b40004c0    	cbz	x0, 0x105122d00 <_Flutter_MMFoundation_BindContext+0x15fe8e4>
105122c6c: b00d8288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105122c70: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
105122c74: d00d7ee8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105122c78: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext
105122c7c: 94ac1130    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105122c80: aa1d03fd    	mov	x29, x29
105122c84: 94ac1131    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105122c88: aa0003f4    	mov	x20, x0
105122c8c: f00d8268    	adrp	x8, 0x120171000 <dyld_stub_binder+0x120171000>
105122c90: f9407d15    	ldr	x21, [x8, #0xf8]
105122c94: d00d6ae8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
105122c98: f943ad16    	ldr	x22, [x8, #0x758] ; selector updateCellContent:withContact:
105122c9c: 900c2668    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
105122ca0: f947e108    	ldr	x8, [x8, #0xfc0]
105122ca4: f90007e8    	str	x8, [sp, #0x8]
105122ca8: f009e2e8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
105122cac: fd41c100    	ldr	d0, [x8, #0x380]
105122cb0: fd000be0    	str	d0, [sp, #0x10]
105122cb4: 90000008    	adrp	x8, 0x105122000 <_Flutter_MMFoundation_BindContext+0x15fdbe4>
105122cb8: 91347108    	add	x8, x8, #0xd1c
105122cbc: 900c26a9    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
105122cc0: 91238129    	add	x9, x9, #0x8e0
105122cc4: a901a7e8    	stp	x8, x9, [sp, #0x18]
105122cc8: aa1303e0    	mov	x0, x19
105122ccc: 94ac111b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105122cd0: f90017f3    	str	x19, [sp, #0x28]
105122cd4: 900d68c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105122cd8: f9404901    	ldr	x1, [x8, #0x90] ; selector callExtension:selector:block:
105122cdc: 910023e4    	add	x4, sp, #0x8
105122ce0: aa1403e0    	mov	x0, x20
105122ce4: aa1503e2    	mov	x2, x21
105122ce8: aa1603e3    	mov	x3, x22
105122cec: 94ac1114    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105122cf0: aa1403e0    	mov	x0, x20
105122cf4: 94ac1118    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105122cf8: f94017e0    	ldr	x0, [sp, #0x28]
105122cfc: 94ac1116    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105122d00: aa1303e0    	mov	x0, x19
105122d04: 94ac1114    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105122d08: a9457bfd    	ldp	x29, x30, [sp, #0x50]
105122d0c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
105122d10: a94357f6    	ldp	x22, x21, [sp, #0x30]
105122d14: 910183ff    	add	sp, sp, #0x60
105122d18: d65f03c0    	ret
