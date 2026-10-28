
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105127290: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
105127294: a9014ff4    	stp	x20, x19, [sp, #0x10]
105127298: a9027bfd    	stp	x29, x30, [sp, #0x20]
10512729c: 910083fd    	add	x29, sp, #0x20
1051272a0: aa0003f4    	mov	x20, x0
1051272a4: b00d8268    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1051272a8: f9408d00    	ldr	x0, [x8, #0x118] ; CAppViewControllerManager
1051272ac: b00d68a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1051272b0: f9423901    	ldr	x1, [x8, #0x470] ; getAppViewControllerManager
1051272b4: 94abffa2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051272b8: aa1d03fd    	mov	x29, x29
1051272bc: 94abffa3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051272c0: aa0003f5    	mov	x21, x0
1051272c4: b00d68a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1051272c8: f9455501    	ldr	x1, [x8, #0xaa8] ; getTopViewController
1051272cc: 94abff9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051272d0: aa1d03fd    	mov	x29, x29
1051272d4: 94abff9d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051272d8: aa0003f3    	mov	x19, x0
1051272dc: aa1503e0    	mov	x0, x21
1051272e0: 94abff9d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051272e4: eb14027f    	cmp	x19, x20
1051272e8: 540002a1    	b.ne	0x10512733c <_Flutter_MMFoundation_BindContext+0x1602f20>
1051272ec: b00d8808    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051272f0: b9831508    	ldrsw	x8, [x8, #0x314]
1051272f4: f8686a95    	ldr	x21, [x20, x8]
1051272f8: b00d8808    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051272fc: b9831908    	ldrsw	x8, [x8, #0x318]
105127300: f8686a80    	ldr	x0, [x20, x8]
105127304: b00d68e8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
105127308: f9451101    	ldr	x1, [x8, #0xa20] ; indexPathsForVisibleRows
10512730c: 94abff8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105127310: aa1d03fd    	mov	x29, x29
105127314: 94abff8d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105127318: aa0003f4    	mov	x20, x0
10512731c: f00d7388    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
105127320: f9473901    	ldr	x1, [x8, #0xe70] ; onPageAppearWithVisibleCellsIndexPath:reason:
105127324: aa1503e0    	mov	x0, x21
105127328: aa1403e2    	mov	x2, x20
10512732c: 52800043    	mov	w3, #0x2                ; =2
105127330: 94abff83    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105127334: aa1403e0    	mov	x0, x20
105127338: 94abff87    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10512733c: aa1303e0    	mov	x0, x19
105127340: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105127344: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105127348: a8c357f6    	ldp	x22, x21, [sp], #0x30
10512734c: 14abff82    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
