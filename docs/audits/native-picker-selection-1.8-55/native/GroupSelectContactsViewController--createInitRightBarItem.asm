
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101ecceec: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
101eccef0: a90157f6    	stp	x22, x21, [sp, #0x10]
101eccef4: a9024ff4    	stp	x20, x19, [sp, #0x20]
101eccef8: a9037bfd    	stp	x29, x30, [sp, #0x30]
101eccefc: 9100c3fd    	add	x29, sp, #0x30
101eccf00: 900f6b48    	adrp	x8, 0x120c34000 <dyld_stub_binder+0x120c34000>
101eccf04: 52800029    	mov	w9, #0x1                ; =1
101eccf08: 390ea509    	strb	w9, [x8, #0x3a9]
101eccf0c: f00f1948    	adrp	x8, 0x1201f7000 <dyld_stub_binder+0x1201f7000>
101eccf10: b987ad08    	ldrsw	x8, [x8, #0x7ac]
101eccf14: b8686808    	ldr	w8, [x0, x8]
101eccf18: 7100111f    	cmp	w8, #0x4
101eccf1c: 54000681    	b.ne	0x101eccfec <_Flutter_Image_provideRelativePathByUrl+0x2d9e9c>
101eccf20: aa0003f3    	mov	x19, x0
101eccf24: f00f1528    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101eccf28: f947d914    	ldr	x20, [x8, #0xfb0]
101eccf2c: f00f1528    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101eccf30: f945e900    	ldr	x0, [x8, #0xbd0]
101eccf34: 900f11a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101eccf38: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
101eccf3c: 95756880    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccf40: aa1d03fd    	mov	x29, x29
101eccf44: 95756881    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101eccf48: aa0003f5    	mov	x21, x0
101eccf4c: f00f1528    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101eccf50: f9462900    	ldr	x0, [x8, #0xc50]
101eccf54: f00f1188    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101eccf58: f947ad01    	ldr	x1, [x8, #0xf58] ; class
101eccf5c: 95756878    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccf60: aa0003e2    	mov	x2, x0
101eccf64: b00efb68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101eccf68: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
101eccf6c: aa1503e0    	mov	x0, x21
101eccf70: 95756873    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccf74: aa1d03fd    	mov	x29, x29
101eccf78: 95756874    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101eccf7c: aa0003f6    	mov	x22, x0
101eccf80: b00efb68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101eccf84: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
101eccf88: 900e2ea2    	adrp	x2, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
101eccf8c: 91042042    	add	x2, x2, #0x108
101eccf90: 9575686b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccf94: aa1d03fd    	mov	x29, x29
101eccf98: 9575686c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101eccf9c: aa0003f7    	mov	x23, x0
101eccfa0: b00efce8    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
101eccfa4: f9413904    	ldr	x4, [x8, #0x270] ; onDone
101eccfa8: f00efb68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101eccfac: f945e101    	ldr	x1, [x8, #0xbc0] ; getBarButtonWithTitle:target:action:style:
101eccfb0: aa1403e0    	mov	x0, x20
101eccfb4: aa1703e2    	mov	x2, x23
101eccfb8: aa1303e3    	mov	x3, x19
101eccfbc: 528000a5    	mov	w5, #0x5                ; =5
101eccfc0: 9575685f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccfc4: aa1d03fd    	mov	x29, x29
101eccfc8: 95756860    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101eccfcc: aa0003f3    	mov	x19, x0
101eccfd0: aa1703e0    	mov	x0, x23
101eccfd4: 95756860    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101eccfd8: aa1603e0    	mov	x0, x22
101eccfdc: 9575685e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101eccfe0: aa1503e0    	mov	x0, x21
101eccfe4: 9575685c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101eccfe8: 14000002    	b	0x101eccff0 <_Flutter_Image_provideRelativePathByUrl+0x2d9ea0>
101eccfec: d2800013    	mov	x19, #0x0               ; =0
101eccff0: aa1303e0    	mov	x0, x19
101eccff4: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101eccff8: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101eccffc: a94157f6    	ldp	x22, x21, [sp, #0x10]
101ecd000: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101ecd004: 1575685b    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
