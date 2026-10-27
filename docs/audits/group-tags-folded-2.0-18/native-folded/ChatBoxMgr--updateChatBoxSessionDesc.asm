
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e49158: d10203ff    	sub	sp, sp, #0x80
100e4915c: a90367fa    	stp	x26, x25, [sp, #0x30]
100e49160: a9045ff8    	stp	x24, x23, [sp, #0x40]
100e49164: a90557f6    	stp	x22, x21, [sp, #0x50]
100e49168: a9064ff4    	stp	x20, x19, [sp, #0x60]
100e4916c: a9077bfd    	stp	x29, x30, [sp, #0x70]
100e49170: 9101c3fd    	add	x29, sp, #0x70
100e49174: f00fef28    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100e49178: 52800029    	mov	w9, #0x1                ; =1
100e4917c: 39187d09    	strb	w9, [x8, #0x61f]
100e49180: f00f9ce8    	adrp	x8, 0x1201e8000 <dyld_stub_binder+0x1201e8000>
100e49184: b9856918    	ldrsw	x24, [x8, #0x568]
100e49188: f8786808    	ldr	x8, [x0, x24]
100e4918c: b4000cc8    	cbz	x8, 0x100e49324 <__text+0xe41324>
100e49190: aa0003f4    	mov	x20, x0
100e49194: f00f81a8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e49198: f9439d01    	ldr	x1, [x8, #0x738] ; lastMsgForChatBoxSession
100e4919c: 95b777e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e491a0: aa1d03fd    	mov	x29, x29
100e491a4: 95b777e9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e491a8: aa0003f3    	mov	x19, x0
100e491ac: f8786a80    	ldr	x0, [x20, x24]
100e491b0: 900f7fe8    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
100e491b4: f944c501    	ldr	x1, [x8, #0x988] ; m_msgWrap
100e491b8: 95b777e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e491bc: aa1d03fd    	mov	x29, x29
100e491c0: 95b777e2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e491c4: aa0003f5    	mov	x21, x0
100e491c8: d00f7fa8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100e491cc: f9463901    	ldr	x1, [x8, #0xc70] ; IsSameMsg:
100e491d0: aa1303e0    	mov	x0, x19
100e491d4: aa1503e2    	mov	x2, x21
100e491d8: 95b777d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e491dc: aa0003f6    	mov	x22, x0
100e491e0: aa1503e0    	mov	x0, x21
100e491e4: 95b777dc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e491e8: 370009b6    	tbnz	w22, #0x0, 0x100e4931c <__text+0xe4131c>
100e491ec: f8786a80    	ldr	x0, [x20, x24]
100e491f0: b00f7fe8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
100e491f4: f942f901    	ldr	x1, [x8, #0x5f0] ; setM_msgWrap:
100e491f8: aa1303e2    	mov	x2, x19
100e491fc: 95b777d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49200: d00f9959    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
100e49204: f945eb20    	ldr	x0, [x25, #0xbd0] ; MMContext
100e49208: f00f95a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e4920c: f944e915    	ldr	x21, [x8, #0x9d0] ; currentContext
100e49210: aa1503e1    	mov	x1, x21
100e49214: 95b777ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49218: aa1d03fd    	mov	x29, x29
100e4921c: 95b777cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e49220: aa0003f6    	mov	x22, x0
100e49224: d00f9988    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
100e49228: f9420100    	ldr	x0, [x8, #0x400] ; MainFrameCellDataManager
100e4922c: d00f95a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100e49230: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100e49234: 95b777c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49238: aa0003e2    	mov	x2, x0
100e4923c: 900f7f88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e49240: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100e49244: aa1603e0    	mov	x0, x22
100e49248: 95b777bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4924c: aa1d03fd    	mov	x29, x29
100e49250: 95b777be    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e49254: aa0003f7    	mov	x23, x0
100e49258: f8786a82    	ldr	x2, [x20, x24]
100e4925c: f00f81a8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e49260: f943a901    	ldr	x1, [x8, #0x750] ; updateCellData:
100e49264: 95b777b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49268: aa1d03fd    	mov	x29, x29
100e4926c: 95b777b7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e49270: aa0003f4    	mov	x20, x0
100e49274: aa1703e0    	mov	x0, x23
100e49278: 95b777b7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4927c: aa1603e0    	mov	x0, x22
100e49280: 95b777b5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e49284: b4000494    	cbz	x20, 0x100e49314 <__text+0xe41314>
100e49288: f945eb20    	ldr	x0, [x25, #0xbd0] ; MMContext
100e4928c: aa1503e1    	mov	x1, x21
100e49290: 95b777ab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49294: aa1d03fd    	mov	x29, x29
100e49298: 95b777ac    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4929c: aa0003f5    	mov	x21, x0
100e492a0: 900f9948    	adrp	x8, 0x120171000 <dyld_stub_binder+0x120171000>
100e492a4: f9407d16    	ldr	x22, [x8, #0xf8]
100e492a8: f00f81a8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e492ac: f943ad17    	ldr	x23, [x8, #0x758] ; updateCellContent:withContact:
100e492b0: b00e3d28    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
100e492b4: f947e108    	ldr	x8, [x8, #0xfc0]
100e492b8: f90007e8    	str	x8, [sp, #0x8]
100e492bc: 900bf9c8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
100e492c0: fd41c100    	ldr	d0, [x8, #0x380]
100e492c4: fd000be0    	str	d0, [sp, #0x10]
100e492c8: 90000008    	adrp	x8, 0x100e49000 <__text+0xe41000>
100e492cc: 910d0108    	add	x8, x8, #0x340
100e492d0: b00e3d69    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
100e492d4: 91238129    	add	x9, x9, #0x8e0
100e492d8: a901a7e8    	stp	x8, x9, [sp, #0x18]
100e492dc: aa1403e0    	mov	x0, x20
100e492e0: 95b77796    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100e492e4: f90017f4    	str	x20, [sp, #0x28]
100e492e8: b00f7f88    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
100e492ec: f9404901    	ldr	x1, [x8, #0x90] ; callExtension:selector:block:
100e492f0: 910023e4    	add	x4, sp, #0x8
100e492f4: aa1503e0    	mov	x0, x21
100e492f8: aa1603e2    	mov	x2, x22
100e492fc: aa1703e3    	mov	x3, x23
100e49300: 95b7778f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49304: aa1503e0    	mov	x0, x21
100e49308: 95b77793    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4930c: f94017e0    	ldr	x0, [sp, #0x28]
100e49310: 95b77791    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e49314: aa1403e0    	mov	x0, x20
100e49318: 95b7778f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4931c: aa1303e0    	mov	x0, x19
100e49320: 95b7778d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e49324: a9477bfd    	ldp	x29, x30, [sp, #0x70]
100e49328: a9464ff4    	ldp	x20, x19, [sp, #0x60]
100e4932c: a94557f6    	ldp	x22, x21, [sp, #0x50]
100e49330: a9445ff8    	ldp	x24, x23, [sp, #0x40]
100e49334: a94367fa    	ldp	x26, x25, [sp, #0x30]
100e49338: 910203ff    	add	sp, sp, #0x80
100e4933c: d65f03c0    	ret
