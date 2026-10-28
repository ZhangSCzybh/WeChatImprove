
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ba84f4: d10483ff    	sub	sp, sp, #0x120
104ba84f8: a90e5ff8    	stp	x24, x23, [sp, #0xe0]
104ba84fc: a90f57f6    	stp	x22, x21, [sp, #0xf0]
104ba8500: a9104ff4    	stp	x20, x19, [sp, #0x100]
104ba8504: a9117bfd    	stp	x29, x30, [sp, #0x110]
104ba8508: 910443fd    	add	x29, sp, #0x110
104ba850c: aa0203f3    	mov	x19, x2
104ba8510: f00c5228    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104ba8514: f9405908    	ldr	x8, [x8, #0xb0]
104ba8518: f9400108    	ldr	x8, [x8]
104ba851c: f81c83a8    	stur	x8, [x29, #-0x38]
104ba8520: d00e04a8    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104ba8524: 52800029    	mov	w9, #0x1                ; =1
104ba8528: 391ab509    	strb	w9, [x8, #0x6ad]
104ba852c: aa0203e0    	mov	x0, x2
104ba8530: 94c1fb02    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104ba8534: d00d94a8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104ba8538: f9413d01    	ldr	x1, [x8, #0x278] ; m_uiMessageType
104ba853c: aa1303e0    	mov	x0, x19
104ba8540: 94c1faff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba8544: 7100c41f    	cmp	w0, #0x31
104ba8548: 540006e1    	b.ne	0x104ba8624 <_Flutter_MMFoundation_BindContext+0x1084208>
104ba854c: 900dae68    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104ba8550: f9451500    	ldr	x0, [x8, #0xa28] ; ClassMethodDispatchCenter
104ba8554: d00dab08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104ba8558: f9437d01    	ldr	x1, [x8, #0x6f8] ; sharedInstance
104ba855c: 94c1faf8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba8560: aa1d03fd    	mov	x29, x29
104ba8564: 94c1faf9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba8568: aa0003f6    	mov	x22, x0
104ba856c: 900dae48    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
104ba8570: f9456902    	ldr	x2, [x8, #0xad0]
104ba8574: f00d94a8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104ba8578: f944c915    	ldr	x21, [x8, #0x990] ; GetPathOfAppDataByUserName:andMessageWrap:retStrPath:
104ba857c: f00d94a8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104ba8580: f9403101    	ldr	x1, [x8, #0x60] ; getClsMethodObservers:selector:
104ba8584: aa1503e3    	mov	x3, x21
104ba8588: 94c1faed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba858c: aa1d03fd    	mov	x29, x29
104ba8590: 94c1faee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba8594: aa0003f4    	mov	x20, x0
104ba8598: aa1603e0    	mov	x0, x22
104ba859c: 94c1faee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba85a0: 4f00e400    	movi.16b	v0, #0x0
104ba85a4: ad0183e0    	stp	q0, q0, [sp, #0x30]
104ba85a8: ad0083e0    	stp	q0, q0, [sp, #0x10]
104ba85ac: 900daac8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104ba85b0: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
104ba85b4: 910043e2    	add	x2, sp, #0x10
104ba85b8: 910163e3    	add	x3, sp, #0x58
104ba85bc: aa1403e0    	mov	x0, x20
104ba85c0: 52800204    	mov	w4, #0x10               ; =16
104ba85c4: 94c1fade    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba85c8: b4000740    	cbz	x0, 0x104ba86b0 <_Flutter_MMFoundation_BindContext+0x1084294>
104ba85cc: f9400fe8    	ldr	x8, [sp, #0x18]
104ba85d0: f9400116    	ldr	x22, [x8]
104ba85d4: b00d94a8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104ba85d8: f9479d01    	ldr	x1, [x8, #0xf38] ; GetChatName
104ba85dc: aa1303e0    	mov	x0, x19
104ba85e0: 94c1fad7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba85e4: aa1d03fd    	mov	x29, x29
104ba85e8: 94c1fad8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba85ec: aa0003f7    	mov	x23, x0
104ba85f0: f90007ff    	str	xzr, [sp, #0x8]
104ba85f4: 910023e4    	add	x4, sp, #0x8
104ba85f8: aa1603e0    	mov	x0, x22
104ba85fc: aa1503e1    	mov	x1, x21
104ba8600: aa1703e2    	mov	x2, x23
104ba8604: aa1303e3    	mov	x3, x19
104ba8608: 94c1facd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba860c: f94007f5    	ldr	x21, [sp, #0x8]
104ba8610: aa1503e0    	mov	x0, x21
104ba8614: 94c1fac9    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104ba8618: aa1703e0    	mov	x0, x23
104ba861c: 94c1face    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba8620: 14000025    	b	0x104ba86b4 <_Flutter_MMFoundation_BindContext+0x1084298>
104ba8624: b00d95c8    	adrp	x8, 0x11fe61000 <dyld_stub_binder+0x11fe61000>
104ba8628: f944cd01    	ldr	x1, [x8, #0x998] ; IsHDImg
104ba862c: aa1303e0    	mov	x0, x19
104ba8630: 94c1fac3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba8634: 900dae74    	adrp	x20, 0x120174000 <dyld_stub_binder+0x120174000>
104ba8638: 34000220    	cbz	w0, 0x104ba867c <_Flutter_MMFoundation_BindContext+0x1084260>
104ba863c: f9411e80    	ldr	x0, [x20, #0x238] ; CMessageWrap
104ba8640: d00d9688    	adrp	x8, 0x11fe7a000 <dyld_stub_binder+0x11fe7a000>
104ba8644: f944e501    	ldr	x1, [x8, #0x9c8] ; getJpgPathOfMsgHDImg:
104ba8648: aa1303e2    	mov	x2, x19
104ba864c: 94c1fabc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba8650: aa1d03fd    	mov	x29, x29
104ba8654: 94c1fabd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba8658: aa0003f5    	mov	x21, x0
104ba865c: f00dae48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104ba8660: f9463500    	ldr	x0, [x8, #0xc68] ; CBaseFile
104ba8664: b00d9488    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104ba8668: f9467901    	ldr	x1, [x8, #0xcf0] ; FileExist:
104ba866c: aa1503e2    	mov	x2, x21
104ba8670: 94c1fab3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba8674: 36000060    	tbz	w0, #0x0, 0x104ba8680 <_Flutter_MMFoundation_BindContext+0x1084264>
104ba8678: 14000011    	b	0x104ba86bc <_Flutter_MMFoundation_BindContext+0x10842a0>
104ba867c: d2800015    	mov	x21, #0x0               ; =0
104ba8680: f9411e80    	ldr	x0, [x20, #0x238] ; CMessageWrap
104ba8684: d00d9508    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104ba8688: f9438501    	ldr	x1, [x8, #0x708] ; getJpgPathOfMsgMiddleImg:
104ba868c: aa1303e2    	mov	x2, x19
104ba8690: 94c1faab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba8694: aa1d03fd    	mov	x29, x29
104ba8698: 94c1faac    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba869c: aa0003f4    	mov	x20, x0
104ba86a0: aa1503e0    	mov	x0, x21
104ba86a4: 94c1faac    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba86a8: aa1403f5    	mov	x21, x20
104ba86ac: 14000004    	b	0x104ba86bc <_Flutter_MMFoundation_BindContext+0x10842a0>
104ba86b0: d2800015    	mov	x21, #0x0               ; =0
104ba86b4: aa1403e0    	mov	x0, x20
104ba86b8: 94c1faa7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba86bc: aa1503e0    	mov	x0, x21
104ba86c0: 94c1faa3    	bl	0x107c2714c <_Flutter_MMFoundation_BindContext+0x4102d30>
104ba86c4: 94c1faa4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba86c8: aa1303e0    	mov	x0, x19
104ba86cc: 94c1faa2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba86d0: f85c83a8    	ldur	x8, [x29, #-0x38]
104ba86d4: f00c5229    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104ba86d8: f9405929    	ldr	x9, [x9, #0xb0]
104ba86dc: f9400129    	ldr	x9, [x9]
104ba86e0: eb08013f    	cmp	x9, x8
104ba86e4: 54000101    	b.ne	0x104ba8704 <_Flutter_MMFoundation_BindContext+0x10842e8>
104ba86e8: aa1503e0    	mov	x0, x21
104ba86ec: a9517bfd    	ldp	x29, x30, [sp, #0x110]
104ba86f0: a9504ff4    	ldp	x20, x19, [sp, #0x100]
104ba86f4: a94f57f6    	ldp	x22, x21, [sp, #0xf0]
104ba86f8: a94e5ff8    	ldp	x24, x23, [sp, #0xe0]
104ba86fc: 910483ff    	add	sp, sp, #0x120
104ba8700: d65f03c0    	ret
104ba8704: 94c1fa9c    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
