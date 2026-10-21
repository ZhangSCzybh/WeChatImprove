
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101ecca3c: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
101ecca40: a90157f6    	stp	x22, x21, [sp, #0x10]
101ecca44: a9024ff4    	stp	x20, x19, [sp, #0x20]
101ecca48: a9037bfd    	stp	x29, x30, [sp, #0x30]
101ecca4c: 9100c3fd    	add	x29, sp, #0x30
101ecca50: aa0003f3    	mov	x19, x0
101ecca54: f00f1948    	adrp	x8, 0x1201f7000 <dyld_stub_binder+0x1201f7000>
101ecca58: b987b918    	ldrsw	x24, [x8, #0x7b8]
101ecca5c: 8b180000    	add	x0, x0, x24
101ecca60: 957569cb    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101ecca64: b4000520    	cbz	x0, 0x101eccb08 <_Flutter_Image_provideRelativePathByUrl+0x2d99b8>
101ecca68: aa0003f5    	mov	x21, x0
101ecca6c: 8b180260    	add	x0, x19, x24
101ecca70: 957569c7    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101ecca74: aa0003f6    	mov	x22, x0
101ecca78: d00effe8    	adrp	x8, 0x11feca000 <dyld_stub_binder+0x11feca000>
101ecca7c: f944b914    	ldr	x20, [x8, #0x970] ; onGroupMultiSelectContactReturn:
101ecca80: d00f11c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101ecca84: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
101ecca88: aa1403e2    	mov	x2, x20
101ecca8c: 957569ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecca90: aa0003f7    	mov	x23, x0
101ecca94: aa1603e0    	mov	x0, x22
101ecca98: 957569af    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecca9c: aa1503e0    	mov	x0, x21
101eccaa0: 957569ad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101eccaa4: 34000337    	cbz	w23, 0x101eccb08 <_Flutter_Image_provideRelativePathByUrl+0x2d99b8>
101eccaa8: 8b180260    	add	x0, x19, x24
101eccaac: 957569b8    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101eccab0: aa0003f5    	mov	x21, x0
101eccab4: f00f1948    	adrp	x8, 0x1201f7000 <dyld_stub_binder+0x1201f7000>
101eccab8: b987b508    	ldrsw	x8, [x8, #0x7b4]
101eccabc: f8686a60    	ldr	x0, [x19, x8]
101eccac0: f00f1188    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101eccac4: f9401101    	ldr	x1, [x8, #0x20] ; allValues
101eccac8: 9575699d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccacc: aa1d03fd    	mov	x29, x29
101eccad0: 9575699e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101eccad4: aa0003f3    	mov	x19, x0
101eccad8: aa1503e0    	mov	x0, x21
101eccadc: aa1403e1    	mov	x1, x20
101eccae0: aa1303e2    	mov	x2, x19
101eccae4: 95756996    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccae8: aa1303e0    	mov	x0, x19
101eccaec: 9575699a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101eccaf0: aa1503e0    	mov	x0, x21
101eccaf4: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101eccaf8: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101eccafc: a94157f6    	ldp	x22, x21, [sp, #0x10]
101eccb00: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101eccb04: 15756994    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101eccb08: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101eccb0c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101eccb10: a94157f6    	ldp	x22, x21, [sp, #0x10]
101eccb14: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101eccb18: d65f03c0    	ret
