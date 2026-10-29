
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a741ac: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
104a741b0: a9015ff8    	stp	x24, x23, [sp, #0x10]
104a741b4: a90257f6    	stp	x22, x21, [sp, #0x20]
104a741b8: a9034ff4    	stp	x20, x19, [sp, #0x30]
104a741bc: a9047bfd    	stp	x29, x30, [sp, #0x40]
104a741c0: 910103fd    	add	x29, sp, #0x40
104a741c4: aa0303f5    	mov	x21, x3
104a741c8: aa0203f4    	mov	x20, x2
104a741cc: aa0003f3    	mov	x19, x0
104a741d0: d00e0e48    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a741d4: 52800029    	mov	w9, #0x1                ; =1
104a741d8: 390b0909    	strb	w9, [x8, #0x2c2]
104a741dc: 900d9e48    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a741e0: f947f916    	ldr	x22, [x8, #0xff0] ; selector deselectRowAtIndexPath:animated:
104a741e4: aa0303e0    	mov	x0, x3
104a741e8: 94c6cbd4    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104a741ec: aa1403e0    	mov	x0, x20
104a741f0: aa1603e1    	mov	x1, x22
104a741f4: aa1503e2    	mov	x2, x21
104a741f8: 52800023    	mov	w3, #0x1                ; =1
104a741fc: 94c6cbd0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a74200: f00dbd68    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a74204: b980d918    	ldrsw	x24, [x8, #0xd8]
104a74208: f8786a74    	ldr	x20, [x19, x24]
104a7420c: d00db488    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104a74210: f9440916    	ldr	x22, [x8, #0x810] ; selector row
104a74214: aa1503e0    	mov	x0, x21
104a74218: aa1603e1    	mov	x1, x22
104a7421c: 94c6cbc8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a74220: aa0003e2    	mov	x2, x0
104a74224: f00d9f28    	adrp	x8, 0x11fe5b000 <dyld_stub_binder+0x11fe5b000>
104a74228: f9427d01    	ldr	x1, [x8, #0x4f8] ; selector sessionAtIndex:
104a7422c: aa1403e0    	mov	x0, x20
104a74230: 94c6cbc3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a74234: aa1d03fd    	mov	x29, x29
104a74238: 94c6cbc4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a7423c: aa0003f4    	mov	x20, x0
104a74240: f00dbd68    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a74244: b980dd08    	ldrsw	x8, [x8, #0xdc]
104a74248: f8686a77    	ldr	x23, [x19, x8]
104a7424c: aa1503e0    	mov	x0, x21
104a74250: aa1603e1    	mov	x1, x22
104a74254: 94c6cbba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a74258: aa0003f6    	mov	x22, x0
104a7425c: aa1503e0    	mov	x0, x21
104a74260: 94c6cbbd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a74264: f8786a60    	ldr	x0, [x19, x24]
104a74268: 900da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a7426c: f9407d01    	ldr	x1, [x8, #0xf8] ; selector isSessionInInitalList:
104a74270: aa1403e2    	mov	x2, x20
104a74274: 94c6cbb2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a74278: aa0003e5    	mov	x5, x0
104a7427c: 900da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a74280: f9412d01    	ldr	x1, [x8, #0x258] ; selector reportClickSession:status:index:inUnreadGroup:
104a74284: aa1703e0    	mov	x0, x23
104a74288: aa1403e2    	mov	x2, x20
104a7428c: d2800003    	mov	x3, #0x0                ; =0
104a74290: aa1603e4    	mov	x4, x22
104a74294: 94c6cbaa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a74298: 900da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a7429c: f940f901    	ldr	x1, [x8, #0x1f0] ; selector setHasOpenedSession:
104a742a0: aa1303e0    	mov	x0, x19
104a742a4: 52800022    	mov	w2, #0x1                ; =1
104a742a8: 94c6cba5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a742ac: 900db468    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a742b0: f946f115    	ldr	x21, [x8, #0xde0] ; selector delegate
104a742b4: aa1303e0    	mov	x0, x19
104a742b8: aa1503e1    	mov	x1, x21
104a742bc: 94c6cba0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a742c0: aa1d03fd    	mov	x29, x29
104a742c4: 94c6cba1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a742c8: b4000400    	cbz	x0, 0x104a74348 <_Flutter_MMFoundation_BindContext+0xf4ff2c>
104a742cc: aa0003f7    	mov	x23, x0
104a742d0: aa1303e0    	mov	x0, x19
104a742d4: aa1503e1    	mov	x1, x21
104a742d8: 94c6cb99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a742dc: aa1d03fd    	mov	x29, x29
104a742e0: 94c6cb9a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a742e4: aa0003f8    	mov	x24, x0
104a742e8: 900da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a742ec: f9413116    	ldr	x22, [x8, #0x260] ; selector onAggregation:openSession:
104a742f0: d00db488    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104a742f4: f9436101    	ldr	x1, [x8, #0x6c0] ; selector respondsToSelector:
104a742f8: aa1603e2    	mov	x2, x22
104a742fc: 94c6cb90    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a74300: aa0003f9    	mov	x25, x0
104a74304: aa1803e0    	mov	x0, x24
104a74308: 94c6cb93    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a7430c: aa1703e0    	mov	x0, x23
104a74310: 94c6cb91    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a74314: 340001b9    	cbz	w25, 0x104a74348 <_Flutter_MMFoundation_BindContext+0xf4ff2c>
104a74318: aa1303e0    	mov	x0, x19
104a7431c: aa1503e1    	mov	x1, x21
104a74320: 94c6cb87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a74324: aa1d03fd    	mov	x29, x29
104a74328: 94c6cb88    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a7432c: aa0003f5    	mov	x21, x0
104a74330: aa1603e1    	mov	x1, x22
104a74334: aa1303e2    	mov	x2, x19
104a74338: aa1403e3    	mov	x3, x20
104a7433c: 94c6cb80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a74340: aa1503e0    	mov	x0, x21
104a74344: 94c6cb84    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a74348: aa1403e0    	mov	x0, x20
104a7434c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104a74350: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104a74354: a94257f6    	ldp	x22, x21, [sp, #0x20]
104a74358: a9415ff8    	ldp	x24, x23, [sp, #0x10]
104a7435c: a8c567fa    	ldp	x26, x25, [sp], #0x50
104a74360: 14c6cb7d    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
