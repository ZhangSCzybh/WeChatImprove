
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a8f3ac: d10283ff    	sub	sp, sp, #0xa0
104a8f3b0: 6d0323e9    	stp	d9, d8, [sp, #0x30]
104a8f3b4: a9046ffc    	stp	x28, x27, [sp, #0x40]
104a8f3b8: a90567fa    	stp	x26, x25, [sp, #0x50]
104a8f3bc: a9065ff8    	stp	x24, x23, [sp, #0x60]
104a8f3c0: a90757f6    	stp	x22, x21, [sp, #0x70]
104a8f3c4: a9084ff4    	stp	x20, x19, [sp, #0x80]
104a8f3c8: a9097bfd    	stp	x29, x30, [sp, #0x90]
104a8f3cc: 910243fd    	add	x29, sp, #0x90
104a8f3d0: aa0003f3    	mov	x19, x0
104a8f3d4: f00e0d68    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a8f3d8: 52800029    	mov	w9, #0x1                ; =1
104a8f3dc: 390c8909    	strb	w9, [x8, #0x322]
104a8f3e0: 900dbca8    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a8f3e4: b9829117    	ldrsw	x23, [x8, #0x290]
104a8f3e8: f8776800    	ldr	x0, [x0, x23]
104a8f3ec: f00d9da8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
104a8f3f0: f9438d01    	ldr	x1, [x8, #0x718] ; m_sessionInfo
104a8f3f4: 94c65f52    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f3f8: aa1d03fd    	mov	x29, x29
104a8f3fc: 94c65f53    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8f400: aa0003f4    	mov	x20, x0
104a8f404: b00d9da8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104a8f408: f947d901    	ldr	x1, [x8, #0xfb0] ; m_nsUserName
104a8f40c: 94c65f4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f410: aa1d03fd    	mov	x29, x29
104a8f414: 94c65f4d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8f418: aa0003f5    	mov	x21, x0
104a8f41c: 900db3a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104a8f420: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
104a8f424: b00cd102    	adrp	x2, 0x11e4b0000 <dyld_stub_binder+0x11e4b0000>
104a8f428: 913aa042    	add	x2, x2, #0xea8 ; CFString 'chatroom_session_box'
104a8f42c: 94c65f44    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f430: aa0003f6    	mov	x22, x0
104a8f434: aa1503e0    	mov	x0, x21
104a8f438: 94c65f47    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8f43c: aa1403e0    	mov	x0, x20
104a8f440: 94c65f45    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8f444: 36000076    	tbz	w22, #0x0, 0x104a8f450 <_Flutter_MMFoundation_BindContext+0xf6b034>
104a8f448: d2800002    	mov	x2, #0x0                ; =0
104a8f44c: 14000008    	b	0x104a8f46c <_Flutter_MMFoundation_BindContext+0xf6b050>
104a8f450: f8776a60    	ldr	x0, [x19, x23]
104a8f454: 900d9fa8    	adrp	x8, 0x11fe83000 <dyld_stub_binder+0x11fe83000>
104a8f458: f9404501    	ldr	x1, [x8, #0x88] ; m_textForTimeLabel
104a8f45c: 94c65f38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f460: aa1d03fd    	mov	x29, x29
104a8f464: 94c65f39    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8f468: aa0003e2    	mov	x2, x0
104a8f46c: 900dbca8    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a8f470: b9829d1b    	ldrsw	x27, [x8, #0x29c]
104a8f474: f87b6a60    	ldr	x0, [x19, x27]
104a8f478: d00db3c8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104a8f47c: f9468d01    	ldr	x1, [x8, #0xd18] ; setText:
104a8f480: aa0203f4    	mov	x20, x2
104a8f484: f90017e2    	str	x2, [sp, #0x28]
104a8f488: 94c65f2d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f48c: b00db728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a8f490: f9404916    	ldr	x22, [x8, #0x90] ; CControlUtil
104a8f494: 900db728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a8f498: f9461900    	ldr	x0, [x8, #0xc30]
104a8f49c: d00d9d48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a8f4a0: f9463101    	ldr	x1, [x8, #0xc60] ; dynamicLength:
104a8f4a4: f90013e1    	str	x1, [sp, #0x20]
104a8f4a8: d2e80bc8    	mov	x8, #0x405e000000000000 ; =4638144666238189568
104a8f4ac: 9e670100    	fmov	d0, x8
104a8f4b0: 94c65f23    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f4b4: 1e604008    	fmov	d8, d0
104a8f4b8: f87b6a60    	ldr	x0, [x19, x27]
104a8f4bc: d00db388    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
104a8f4c0: f9456d17    	ldr	x23, [x8, #0xad8] ; font
104a8f4c4: aa1703e1    	mov	x1, x23
104a8f4c8: 94c65f1d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f4cc: aa1d03fd    	mov	x29, x29
104a8f4d0: 94c65f1e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8f4d4: aa0003f8    	mov	x24, x0
104a8f4d8: 900d9d88    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104a8f4dc: f941d501    	ldr	x1, [x8, #0x3a8] ; labelWidth:maxWidth:font:
104a8f4e0: aa1603e0    	mov	x0, x22
104a8f4e4: aa1403e2    	mov	x2, x20
104a8f4e8: 1e604100    	fmov	d0, d8
104a8f4ec: aa1803e3    	mov	x3, x24
104a8f4f0: 94c65f13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f4f4: f87b6a60    	ldr	x0, [x19, x27]
104a8f4f8: f00db3c8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104a8f4fc: f9418d01    	ldr	x1, [x8, #0x318] ; setWidth:
104a8f500: 94c65f0f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f504: aa1803e0    	mov	x0, x24
104a8f508: 94c65f13    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8f50c: f87b6a60    	ldr	x0, [x19, x27]
104a8f510: aa1703e1    	mov	x1, x23
104a8f514: 94c65f0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f518: aa1d03fd    	mov	x29, x29
104a8f51c: 94c65f0b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8f520: aa0003f6    	mov	x22, x0
104a8f524: 900d9d68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104a8f528: f947ed01    	ldr	x1, [x8, #0xfd8] ; lineHeight
104a8f52c: 94c65f04    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f530: f87b6a60    	ldr	x0, [x19, x27]
104a8f534: b00db3c8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104a8f538: f9410901    	ldr	x1, [x8, #0x210] ; setHeight:
104a8f53c: 94c65f00    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f540: aa1603e0    	mov	x0, x22
104a8f544: 94c65f04    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8f548: 900db3e8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104a8f54c: f947a519    	ldr	x25, [x8, #0xf48] ; width
104a8f550: aa1303e0    	mov	x0, x19
104a8f554: aa1903e1    	mov	x1, x25
104a8f558: 94c65ef9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f55c: 1e604008    	fmov	d8, d0
104a8f560: b00db728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a8f564: f9403d17    	ldr	x23, [x8, #0x78] ; MMThemeUtil
104a8f568: 900db728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a8f56c: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
104a8f570: b00db388    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a8f574: f944e91a    	ldr	x26, [x8, #0x9d0] ; currentContext
104a8f578: aa1a03e1    	mov	x1, x26
104a8f57c: 94c65ef0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f580: aa1d03fd    	mov	x29, x29
104a8f584: 94c65ef1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8f588: aa0003f5    	mov	x21, x0
104a8f58c: f9000fe0    	str	x0, [sp, #0x18]
104a8f590: b00db728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a8f594: f9404100    	ldr	x0, [x8, #0x80] ; MMThemeManager
104a8f598: 900db388    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a8f59c: f947ad1c    	ldr	x28, [x8, #0xf58] ; class
104a8f5a0: aa1c03e1    	mov	x1, x28
104a8f5a4: 94c65ee6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f5a8: aa0003e2    	mov	x2, x0
104a8f5ac: d00d9d48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a8f5b0: f9464114    	ldr	x20, [x8, #0xc80] ; getService:
104a8f5b4: aa1503e0    	mov	x0, x21
104a8f5b8: aa1403e1    	mov	x1, x20
104a8f5bc: 94c65ee0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f5c0: aa1d03fd    	mov	x29, x29
104a8f5c4: 94c65ee1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8f5c8: f9000be0    	str	x0, [sp, #0x10]
104a8f5cc: 900d9d68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104a8f5d0: f947fd16    	ldr	x22, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
104a8f5d4: b00cd782    	adrp	x2, 0x11e580000 <dyld_stub_binder+0x11e580000>
104a8f5d8: 9124a042    	add	x2, x2, #0x928 ; CFString 'cell_timelabel_right_margin'
104a8f5dc: d00cd143    	adrp	x3, 0x11e4b9000 <dyld_stub_binder+0x11e4b9000>
104a8f5e0: 9137a063    	add	x3, x3, #0xde8 ; CFString '#mainframe_table'
104a8f5e4: aa1603e1    	mov	x1, x22
104a8f5e8: 94c65ed5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f5ec: aa1d03fd    	mov	x29, x29
104a8f5f0: 94c65ed6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8f5f4: aa0003e2    	mov	x2, x0
104a8f5f8: f90007e0    	str	x0, [sp, #0x8]
104a8f5fc: b00d9d68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a8f600: f9400115    	ldr	x21, [x8]
104a8f604: aa1703e0    	mov	x0, x23
104a8f608: aa1503e1    	mov	x1, x21
104a8f60c: 94c65ecc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f610: 1e603908    	fsub	d8, d8, d0
104a8f614: f87b6a60    	ldr	x0, [x19, x27]
104a8f618: aa1903e1    	mov	x1, x25
104a8f61c: 94c65ec8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f620: 1e603908    	fsub	d8, d8, d0
104a8f624: 900db728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a8f628: f9461918    	ldr	x24, [x8, #0xc30]
104a8f62c: b00db728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a8f630: f9403d17    	ldr	x23, [x8, #0x78] ; MMThemeUtil
104a8f634: 900db728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a8f638: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
104a8f63c: aa1a03e1    	mov	x1, x26
104a8f640: 94c65ebf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f644: aa1d03fd    	mov	x29, x29
104a8f648: 94c65ec0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8f64c: aa0003f9    	mov	x25, x0
104a8f650: b00db728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a8f654: f9404100    	ldr	x0, [x8, #0x80] ; MMThemeManager
104a8f658: aa1c03e1    	mov	x1, x28
104a8f65c: 94c65eb8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f660: aa0003e2    	mov	x2, x0
104a8f664: aa1903e0    	mov	x0, x25
104a8f668: aa1403e1    	mov	x1, x20
104a8f66c: 94c65eb4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f670: aa1d03fd    	mov	x29, x29
104a8f674: 94c65eb5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8f678: aa0003f4    	mov	x20, x0
104a8f67c: b00cd782    	adrp	x2, 0x11e580000 <dyld_stub_binder+0x11e580000>
104a8f680: 91232042    	add	x2, x2, #0x8c8 ; CFString 'cell_msglabel_top_margin'
104a8f684: aa1603e1    	mov	x1, x22
104a8f688: d00cd143    	adrp	x3, 0x11e4b9000 <dyld_stub_binder+0x11e4b9000>
104a8f68c: 9137a063    	add	x3, x3, #0xde8 ; CFString '#mainframe_table'
104a8f690: 94c65eab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f694: aa1d03fd    	mov	x29, x29
104a8f698: 94c65eac    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8f69c: aa0003f6    	mov	x22, x0
104a8f6a0: aa1703e0    	mov	x0, x23
104a8f6a4: aa1503e1    	mov	x1, x21
104a8f6a8: aa1603e2    	mov	x2, x22
104a8f6ac: 94c65ea4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f6b0: aa1803e0    	mov	x0, x24
104a8f6b4: f94013f5    	ldr	x21, [sp, #0x20]
104a8f6b8: aa1503e1    	mov	x1, x21
104a8f6bc: 94c65ea0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f6c0: 1e604009    	fmov	d9, d0
104a8f6c4: 900db728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a8f6c8: f9461900    	ldr	x0, [x8, #0xc30]
104a8f6cc: 1e601000    	fmov	d0, #2.00000000
104a8f6d0: aa1503e1    	mov	x1, x21
104a8f6d4: 94c65e9a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f6d8: 1e602921    	fadd	d1, d9, d0
104a8f6dc: f87b6a60    	ldr	x0, [x19, x27]
104a8f6e0: d00d9d48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a8f6e4: f9465501    	ldr	x1, [x8, #0xca8] ; setWcOrigin:
104a8f6e8: 1e604100    	fmov	d0, d8
104a8f6ec: 94c65e94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f6f0: aa1603e0    	mov	x0, x22
104a8f6f4: 94c65e98    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8f6f8: aa1403e0    	mov	x0, x20
104a8f6fc: 94c65e96    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8f700: aa1903e0    	mov	x0, x25
104a8f704: 94c65e94    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8f708: f94007e0    	ldr	x0, [sp, #0x8]
104a8f70c: 94c65e92    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8f710: f9400be0    	ldr	x0, [sp, #0x10]
104a8f714: 94c65e90    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8f718: f9400fe0    	ldr	x0, [sp, #0x18]
104a8f71c: 94c65e8e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8f720: f94017e0    	ldr	x0, [sp, #0x28]
104a8f724: a9497bfd    	ldp	x29, x30, [sp, #0x90]
104a8f728: a9484ff4    	ldp	x20, x19, [sp, #0x80]
104a8f72c: a94757f6    	ldp	x22, x21, [sp, #0x70]
104a8f730: a9465ff8    	ldp	x24, x23, [sp, #0x60]
104a8f734: a94567fa    	ldp	x26, x25, [sp, #0x50]
104a8f738: a9446ffc    	ldp	x28, x27, [sp, #0x40]
104a8f73c: 6d4323e9    	ldp	d9, d8, [sp, #0x30]
104a8f740: 910283ff    	add	sp, sp, #0xa0
104a8f744: 14c65e84    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
