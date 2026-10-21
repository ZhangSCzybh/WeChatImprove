
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101ecea8c: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
101ecea90: a90157f6    	stp	x22, x21, [sp, #0x10]
101ecea94: a9024ff4    	stp	x20, x19, [sp, #0x20]
101ecea98: a9037bfd    	stp	x29, x30, [sp, #0x30]
101ecea9c: 9100c3fd    	add	x29, sp, #0x30
101eceaa0: aa0203f3    	mov	x19, x2
101eceaa4: aa0003f5    	mov	x21, x0
101eceaa8: d00f6b28    	adrp	x8, 0x120c34000 <dyld_stub_binder+0x120c34000>
101eceaac: 52800029    	mov	w9, #0x1                ; =1
101eceab0: 390ecd09    	strb	w9, [x8, #0x3b3]
101eceab4: aa0203e0    	mov	x0, x2
101eceab8: 957561a0    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101eceabc: b00f1948    	adrp	x8, 0x1201f7000 <dyld_stub_binder+0x1201f7000>
101eceac0: b987c116    	ldrsw	x22, [x8, #0x7c0]
101eceac4: f8766aa0    	ldr	x0, [x21, x22]
101eceac8: b00efb68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101eceacc: f9459901    	ldr	x1, [x8, #0xb30] ; resultTableView
101ecead0: 9575619b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecead4: aa1d03fd    	mov	x29, x29
101ecead8: 9575619c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101eceadc: aa0003f4    	mov	x20, x0
101eceae0: f8766aa0    	ldr	x0, [x21, x22]
101eceae4: f00efc48    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
101eceae8: f942e101    	ldr	x1, [x8, #0x5c0] ; arrResult
101eceaec: 95756194    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eceaf0: aa1d03fd    	mov	x29, x29
101eceaf4: 95756195    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101eceaf8: aa0003f7    	mov	x23, x0
101eceafc: 900f11c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101eceb00: f9440901    	ldr	x1, [x8, #0x810] ; row
101eceb04: aa1303e0    	mov	x0, x19
101eceb08: 9575618d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eceb0c: aa0003e2    	mov	x2, x0
101eceb10: 900efb68    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
101eceb14: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
101eceb18: aa1703e0    	mov	x0, x23
101eceb1c: 95756188    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eceb20: aa1d03fd    	mov	x29, x29
101eceb24: 95756189    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101eceb28: aa0003f6    	mov	x22, x0
101eceb2c: aa1703e0    	mov	x0, x23
101eceb30: 95756189    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101eceb34: b4000216    	cbz	x22, 0x101eceb74 <_Flutter_Image_provideRelativePathByUrl+0x2dba24>
101eceb38: d00efdc8    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
101eceb3c: f9436101    	ldr	x1, [x8, #0x6c0] ; selectContact:
101eceb40: aa1503e0    	mov	x0, x21
101eceb44: aa1603e2    	mov	x2, x22
101eceb48: 9575617d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eceb4c: d00efb68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101eceb50: f947f901    	ldr	x1, [x8, #0xff0] ; deselectRowAtIndexPath:animated:
101eceb54: aa1403e0    	mov	x0, x20
101eceb58: aa1303e2    	mov	x2, x19
101eceb5c: 52800023    	mov	w3, #0x1                ; =1
101eceb60: 95756177    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eceb64: 900f11c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101eceb68: f9404501    	ldr	x1, [x8, #0x88] ; reloadData
101eceb6c: aa1403e0    	mov	x0, x20
101eceb70: 95756173    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eceb74: aa1603e0    	mov	x0, x22
101eceb78: 95756177    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101eceb7c: aa1403e0    	mov	x0, x20
101eceb80: 95756175    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101eceb84: aa1303e0    	mov	x0, x19
101eceb88: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101eceb8c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101eceb90: a94157f6    	ldp	x22, x21, [sp, #0x10]
101eceb94: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101eceb98: 1575616f    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
