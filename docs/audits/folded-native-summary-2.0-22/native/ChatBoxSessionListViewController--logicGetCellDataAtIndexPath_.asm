
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e4b3fc: d10183ff    	sub	sp, sp, #0x60
100e4b400: a9025ff8    	stp	x24, x23, [sp, #0x20]
100e4b404: a90357f6    	stp	x22, x21, [sp, #0x30]
100e4b408: a9044ff4    	stp	x20, x19, [sp, #0x40]
100e4b40c: a9057bfd    	stp	x29, x30, [sp, #0x50]
100e4b410: 910143fd    	add	x29, sp, #0x50
100e4b414: aa0203f3    	mov	x19, x2
100e4b418: aa0003f4    	mov	x20, x0
100e4b41c: b00fef28    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100e4b420: 52800029    	mov	w9, #0x1                ; =1
100e4b424: 3918a909    	strb	w9, [x8, #0x62a]
100e4b428: aa0203e0    	mov	x0, x2
100e4b42c: 95b76f43    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100e4b430: d00f7f88    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
100e4b434: f9413101    	ldr	x1, [x8, #0x260] ; logicGetSessionAtIndexPath:
100e4b438: aa1403e0    	mov	x0, x20
100e4b43c: aa1303e2    	mov	x2, x19
100e4b440: 95b76f3f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b444: aa1d03fd    	mov	x29, x29
100e4b448: 95b76f40    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4b44c: aa0003f4    	mov	x20, x0
100e4b450: b4000440    	cbz	x0, 0x100e4b4d8 <__text+0xe434d8>
100e4b454: 900f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e4b458: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
100e4b45c: b00f95a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e4b460: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100e4b464: 95b76f36    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b468: aa1d03fd    	mov	x29, x29
100e4b46c: 95b76f37    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4b470: aa0003f6    	mov	x22, x0
100e4b474: 900f9988    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
100e4b478: f9420100    	ldr	x0, [x8, #0x400] ; MainFrameCellDataManager
100e4b47c: 900f95a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100e4b480: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100e4b484: 95b76f2e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b488: aa0003e2    	mov	x2, x0
100e4b48c: d00f7f68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e4b490: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100e4b494: aa1603e0    	mov	x0, x22
100e4b498: 95b76f29    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b49c: aa1d03fd    	mov	x29, x29
100e4b4a0: 95b76f2a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4b4a4: aa0003f7    	mov	x23, x0
100e4b4a8: b00f81a8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e4b4ac: f943ed01    	ldr	x1, [x8, #0x7d8] ; getCellData:
100e4b4b0: aa1403e2    	mov	x2, x20
100e4b4b4: 95b76f22    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b4b8: aa1d03fd    	mov	x29, x29
100e4b4bc: 95b76f23    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4b4c0: aa0003f5    	mov	x21, x0
100e4b4c4: aa1703e0    	mov	x0, x23
100e4b4c8: 95b76f23    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4b4cc: aa1603e0    	mov	x0, x22
100e4b4d0: 95b76f21    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4b4d4: 1400001e    	b	0x100e4b54c <__text+0xe4354c>
100e4b4d8: 900f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e4b4dc: f9453515    	ldr	x21, [x8, #0xa68] ; iConsole
100e4b4e0: b00f7f88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100e4b4e4: f9427d01    	ldr	x1, [x8, #0x4f8] ; section
100e4b4e8: aa1303e0    	mov	x0, x19
100e4b4ec: 95b76f14    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b4f0: aa0003f6    	mov	x22, x0
100e4b4f4: f00f95c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
100e4b4f8: f9440901    	ldr	x1, [x8, #0x810] ; row
100e4b4fc: aa1303e0    	mov	x0, x19
100e4b500: 95b76f0f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b504: d00f7f68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e4b508: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
100e4b50c: a90083f6    	stp	x22, x0, [sp, #0x8]
100e4b510: f00eb728    	adrp	x8, 0x11e532000 <dyld_stub_binder+0x11e532000>
100e4b514: 912a2108    	add	x8, x8, #0xa88 ; CFString 'session not found at index: %ld, %ld'
100e4b518: f90003e8    	str	x8, [sp]
100e4b51c: d00d2083    	adrp	x3, 0x11b25d000 <dyld_stub_binder+0x11b25d000>
100e4b520: 911f2c63    	add	x3, x3, #0x7cb
100e4b524: 900d2805    	adrp	x5, 0x11b34b000 <dyld_stub_binder+0x11b34b000>
100e4b528: 9119b8a5    	add	x5, x5, #0x66e
100e4b52c: 900d2807    	adrp	x7, 0x11b34b000 <dyld_stub_binder+0x11b34b000>
100e4b530: 911a48e7    	add	x7, x7, #0x692
100e4b534: aa1503e0    	mov	x0, x21
100e4b538: 52800082    	mov	w2, #0x4                ; =4
100e4b53c: 52800004    	mov	w4, #0x0                ; =0
100e4b540: 52801a06    	mov	w6, #0xd0               ; =208
100e4b544: 95b76efe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b548: d2800015    	mov	x21, #0x0               ; =0
100e4b54c: aa1403e0    	mov	x0, x20
100e4b550: 95b76f01    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4b554: aa1303e0    	mov	x0, x19
100e4b558: 95b76eff    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4b55c: aa1503e0    	mov	x0, x21
100e4b560: a9457bfd    	ldp	x29, x30, [sp, #0x50]
100e4b564: a9444ff4    	ldp	x20, x19, [sp, #0x40]
100e4b568: a94357f6    	ldp	x22, x21, [sp, #0x30]
100e4b56c: a9425ff8    	ldp	x24, x23, [sp, #0x20]
100e4b570: 910183ff    	add	sp, sp, #0x60
100e4b574: 15b76eff    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
