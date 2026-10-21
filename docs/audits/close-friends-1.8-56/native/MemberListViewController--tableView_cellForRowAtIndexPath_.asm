
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104adc6a0: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
104adc6a4: a9015ff8    	stp	x24, x23, [sp, #0x10]
104adc6a8: a90257f6    	stp	x22, x21, [sp, #0x20]
104adc6ac: a9034ff4    	stp	x20, x19, [sp, #0x30]
104adc6b0: a9047bfd    	stp	x29, x30, [sp, #0x40]
104adc6b4: 910103fd    	add	x29, sp, #0x40
104adc6b8: aa0303f4    	mov	x20, x3
104adc6bc: aa0003f5    	mov	x21, x0
104adc6c0: d00e0b08    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104adc6c4: 52800029    	mov	w9, #0x1                ; =1
104adc6c8: 3910cd09    	strb	w9, [x8, #0x433]
104adc6cc: f00db4e8    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
104adc6d0: f943bd13    	ldr	x19, [x8, #0x778]
104adc6d4: aa0303e0    	mov	x0, x3
104adc6d8: 94c52a98    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104adc6dc: aa1303e0    	mov	x0, x19
104adc6e0: 94c52a9e    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104adc6e4: aa0003f3    	mov	x19, x0
104adc6e8: f00dba28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104adc6ec: b9869508    	ldrsw	x8, [x8, #0x694]
104adc6f0: f8686ab6    	ldr	x22, [x21, x8]
104adc6f4: 900d9b08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104adc6f8: f9427d01    	ldr	x1, [x8, #0x4f8] ; section
104adc6fc: aa1403e0    	mov	x0, x20
104adc700: 94c52a8f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc704: aa0003f7    	mov	x23, x0
104adc708: d00db148    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104adc70c: f9440901    	ldr	x1, [x8, #0x810] ; row
104adc710: aa1403e0    	mov	x0, x20
104adc714: 94c52a8a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc718: aa0003e3    	mov	x3, x0
104adc71c: d00d9d28    	adrp	x8, 0x11fe82000 <dyld_stub_binder+0x11fe82000>
104adc720: f9479501    	ldr	x1, [x8, #0xf28] ; getItemInSection:atRow:
104adc724: aa1603e0    	mov	x0, x22
104adc728: aa1703e2    	mov	x2, x23
104adc72c: 94c52a84    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc730: aa1d03fd    	mov	x29, x29
104adc734: 94c52a85    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adc738: aa0003f6    	mov	x22, x0
104adc73c: f00d9b68    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104adc740: f9463101    	ldr	x1, [x8, #0xc60] ; updateWithContact:
104adc744: aa1303e0    	mov	x0, x19
104adc748: aa1603e2    	mov	x2, x22
104adc74c: 94c52a7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc750: aa1603e0    	mov	x0, x22
104adc754: 94c52a80    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adc758: b00da548    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104adc75c: f9451501    	ldr	x1, [x8, #0xa28] ; getEditingStyleForIndexPath:
104adc760: aa1503e0    	mov	x0, x21
104adc764: aa1403e2    	mov	x2, x20
104adc768: 94c52a75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc76c: aa0003f5    	mov	x21, x0
104adc770: aa1403e0    	mov	x0, x20
104adc774: 94c52a78    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adc778: b4000c15    	cbz	x21, 0x104adc8f8 <_Flutter_MMFoundation_BindContext+0xfb84dc>
104adc77c: f00db4a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104adc780: f9455500    	ldr	x0, [x8, #0xaa8]
104adc784: f00db108    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104adc788: f941b501    	ldr	x1, [x8, #0x368] ; arrayWithCapacity:
104adc78c: 52800022    	mov	w2, #0x1                ; =1
104adc790: 94c52a6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc794: aa1d03fd    	mov	x29, x29
104adc798: 94c52a6c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adc79c: aa0003f4    	mov	x20, x0
104adc7a0: f00db4a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104adc7a4: f9462d00    	ldr	x0, [x8, #0xc58]
104adc7a8: 900d9b68    	adrp	x8, 0x11fe48000 <dyld_stub_binder+0x11fe48000>
104adc7ac: f9418d01    	ldr	x1, [x8, #0x318] ; Red
104adc7b0: 94c52a63    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc7b4: aa1d03fd    	mov	x29, x29
104adc7b8: 94c52a64    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adc7bc: aa0003f5    	mov	x21, x0
104adc7c0: f00db4a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104adc7c4: f945e900    	ldr	x0, [x8, #0xbd0]
104adc7c8: 900db128    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104adc7cc: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104adc7d0: 94c52a5b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc7d4: aa1d03fd    	mov	x29, x29
104adc7d8: 94c52a5c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adc7dc: aa0003f6    	mov	x22, x0
104adc7e0: f00db4a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104adc7e4: f9462900    	ldr	x0, [x8, #0xc50]
104adc7e8: f00db108    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104adc7ec: f947ad01    	ldr	x1, [x8, #0xf58] ; class
104adc7f0: 94c52a53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc7f4: aa0003e2    	mov	x2, x0
104adc7f8: b00d9ae8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104adc7fc: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104adc800: aa1603e0    	mov	x0, x22
104adc804: 94c52a4e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc808: aa1d03fd    	mov	x29, x29
104adc80c: 94c52a4f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adc810: aa0003f7    	mov	x23, x0
104adc814: b00d9ae8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104adc818: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
104adc81c: 900ce622    	adrp	x2, 0x11e7a0000 <dyld_stub_binder+0x11e7a0000>
104adc820: 91192042    	add	x2, x2, #0x648
104adc824: 94c52a46    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc828: aa1d03fd    	mov	x29, x29
104adc82c: 94c52a47    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adc830: aa0003f8    	mov	x24, x0
104adc834: b00db4c8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
104adc838: f946c119    	ldr	x25, [x8, #0xd80]
104adc83c: 900db148    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104adc840: f9461d1a    	ldr	x26, [x8, #0xc38] ; new
104adc844: aa1503e0    	mov	x0, x21
104adc848: 94c52a3c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104adc84c: aa1903e0    	mov	x0, x25
104adc850: aa1a03e1    	mov	x1, x26
104adc854: 94c52a3a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc858: aa0003f9    	mov	x25, x0
104adc85c: 900d9b68    	adrp	x8, 0x11fe48000 <dyld_stub_binder+0x11fe48000>
104adc860: f941d501    	ldr	x1, [x8, #0x3a8] ; setEditingStyle:
104adc864: 52800022    	mov	w2, #0x1                ; =1
104adc868: 94c52a35    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc86c: f00db148    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
104adc870: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
104adc874: aa1903e0    	mov	x0, x25
104adc878: aa1503e2    	mov	x2, x21
104adc87c: 94c52a30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc880: aa1503e0    	mov	x0, x21
104adc884: 94c52a34    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adc888: 900d9b68    	adrp	x8, 0x11fe48000 <dyld_stub_binder+0x11fe48000>
104adc88c: f941d901    	ldr	x1, [x8, #0x3b0] ; setNsTitle:
104adc890: aa1903e0    	mov	x0, x25
104adc894: aa1803e2    	mov	x2, x24
104adc898: 94c52a29    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc89c: d00d9ae8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104adc8a0: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
104adc8a4: aa1403e0    	mov	x0, x20
104adc8a8: aa1903e2    	mov	x2, x25
104adc8ac: 94c52a24    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc8b0: aa1903e0    	mov	x0, x25
104adc8b4: 94c52a28    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adc8b8: aa1803e0    	mov	x0, x24
104adc8bc: 94c52a26    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adc8c0: aa1703e0    	mov	x0, x23
104adc8c4: 94c52a24    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adc8c8: aa1603e0    	mov	x0, x22
104adc8cc: 94c52a22    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adc8d0: aa1503e0    	mov	x0, x21
104adc8d4: 94c52a20    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adc8d8: b00d9c08    	adrp	x8, 0x11fe5d000 <dyld_stub_binder+0x11fe5d000>
104adc8dc: f941b501    	ldr	x1, [x8, #0x368] ; setMenuItemsWithNoDeleteBtn:
104adc8e0: aa1303e0    	mov	x0, x19
104adc8e4: aa1403e2    	mov	x2, x20
104adc8e8: 94c52a15    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc8ec: aa1403e0    	mov	x0, x20
104adc8f0: 94c52a19    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adc8f4: 14000006    	b	0x104adc90c <_Flutter_MMFoundation_BindContext+0xfb84f0>
104adc8f8: b00d9be8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
104adc8fc: f9428901    	ldr	x1, [x8, #0x510] ; setContextMenuEnabled:
104adc900: aa1303e0    	mov	x0, x19
104adc904: 52800002    	mov	w2, #0x0                ; =0
104adc908: 94c52a0d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adc90c: aa1303e0    	mov	x0, x19
104adc910: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104adc914: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104adc918: a94257f6    	ldp	x22, x21, [sp, #0x20]
104adc91c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
104adc920: a8c567fa    	ldp	x26, x25, [sp], #0x50
104adc924: 14c52a13    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
