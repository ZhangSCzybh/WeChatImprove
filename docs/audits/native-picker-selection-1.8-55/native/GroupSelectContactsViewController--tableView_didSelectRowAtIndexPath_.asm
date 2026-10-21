
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101ece704: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
101ece708: a9015ff8    	stp	x24, x23, [sp, #0x10]
101ece70c: a90257f6    	stp	x22, x21, [sp, #0x20]
101ece710: a9034ff4    	stp	x20, x19, [sp, #0x30]
101ece714: a9047bfd    	stp	x29, x30, [sp, #0x40]
101ece718: 910103fd    	add	x29, sp, #0x40
101ece71c: aa0303f4    	mov	x20, x3
101ece720: aa0203f3    	mov	x19, x2
101ece724: aa0003f5    	mov	x21, x0
101ece728: d00f6b28    	adrp	x8, 0x120c34000 <dyld_stub_binder+0x120c34000>
101ece72c: 52800029    	mov	w9, #0x1                ; =1
101ece730: 390ec909    	strb	w9, [x8, #0x3b2]
101ece734: aa0203e0    	mov	x0, x2
101ece738: 95756280    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101ece73c: aa1403e0    	mov	x0, x20
101ece740: 9575627e    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101ece744: d00efb68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101ece748: f9427d01    	ldr	x1, [x8, #0x4f8] ; section
101ece74c: 9575627c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ece750: aa0003f6    	mov	x22, x0
101ece754: 900f11c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101ece758: f9440901    	ldr	x1, [x8, #0x810] ; row
101ece75c: aa1403e0    	mov	x0, x20
101ece760: 95756277    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ece764: aa0003f7    	mov	x23, x0
101ece768: b00f1948    	adrp	x8, 0x1201f7000 <dyld_stub_binder+0x1201f7000>
101ece76c: b987b11a    	ldrsw	x26, [x8, #0x7b0]
101ece770: f87a6aa0    	ldr	x0, [x21, x26]
101ece774: 900efc48    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
101ece778: f942d901    	ldr	x1, [x8, #0x5b0] ; getKeysArray
101ece77c: 95756270    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ece780: aa1d03fd    	mov	x29, x29
101ece784: 95756271    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101ece788: aa0003f8    	mov	x24, x0
101ece78c: 900efb68    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
101ece790: f942c119    	ldr	x25, [x8, #0x580] ; safeObjectAtIndex:
101ece794: aa1903e1    	mov	x1, x25
101ece798: aa1603e2    	mov	x2, x22
101ece79c: 95756268    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ece7a0: aa1d03fd    	mov	x29, x29
101ece7a4: 95756269    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101ece7a8: aa0003f6    	mov	x22, x0
101ece7ac: aa1803e0    	mov	x0, x24
101ece7b0: 95756269    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ece7b4: f87a6aa0    	ldr	x0, [x21, x26]
101ece7b8: 900efc48    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
101ece7bc: f9430901    	ldr	x1, [x8, #0x610] ; getContactsArrayWith:
101ece7c0: aa1603e2    	mov	x2, x22
101ece7c4: 9575625e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ece7c8: aa1d03fd    	mov	x29, x29
101ece7cc: 9575625f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101ece7d0: aa0003f8    	mov	x24, x0
101ece7d4: d00f1188    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101ece7d8: f9435101    	ldr	x1, [x8, #0x6a0] ; count
101ece7dc: 95756258    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ece7e0: eb0002ff    	cmp	x23, x0
101ece7e4: 540002c2    	b.hs	0x101ece83c <_Flutter_Image_provideRelativePathByUrl+0x2db6ec>
101ece7e8: aa1803e0    	mov	x0, x24
101ece7ec: aa1903e1    	mov	x1, x25
101ece7f0: aa1703e2    	mov	x2, x23
101ece7f4: 95756252    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ece7f8: aa1d03fd    	mov	x29, x29
101ece7fc: 95756253    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101ece800: b40001e0    	cbz	x0, 0x101ece83c <_Flutter_Image_provideRelativePathByUrl+0x2db6ec>
101ece804: aa0003f7    	mov	x23, x0
101ece808: d00efdc8    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
101ece80c: f9436101    	ldr	x1, [x8, #0x6c0] ; selectContact:
101ece810: aa1503e0    	mov	x0, x21
101ece814: aa1703e2    	mov	x2, x23
101ece818: 95756249    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ece81c: d00efb68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101ece820: f947f901    	ldr	x1, [x8, #0xff0] ; deselectRowAtIndexPath:animated:
101ece824: aa1303e0    	mov	x0, x19
101ece828: aa1403e2    	mov	x2, x20
101ece82c: 52800023    	mov	w3, #0x1                ; =1
101ece830: 95756243    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ece834: aa1703e0    	mov	x0, x23
101ece838: 95756247    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ece83c: aa1803e0    	mov	x0, x24
101ece840: 95756245    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ece844: aa1603e0    	mov	x0, x22
101ece848: 95756243    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ece84c: aa1403e0    	mov	x0, x20
101ece850: 95756241    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ece854: aa1303e0    	mov	x0, x19
101ece858: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101ece85c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101ece860: a94257f6    	ldp	x22, x21, [sp, #0x20]
101ece864: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101ece868: a8c567fa    	ldp	x26, x25, [sp], #0x50
101ece86c: 1575623a    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
