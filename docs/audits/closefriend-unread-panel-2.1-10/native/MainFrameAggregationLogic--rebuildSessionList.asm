
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a6f304: d10583ff    	sub	sp, sp, #0x160
104a6f308: a9106ffc    	stp	x28, x27, [sp, #0x100]
104a6f30c: a91167fa    	stp	x26, x25, [sp, #0x110]
104a6f310: a9125ff8    	stp	x24, x23, [sp, #0x120]
104a6f314: a91357f6    	stp	x22, x21, [sp, #0x130]
104a6f318: a9144ff4    	stp	x20, x19, [sp, #0x140]
104a6f31c: a9157bfd    	stp	x29, x30, [sp, #0x150]
104a6f320: 910543fd    	add	x29, sp, #0x150
104a6f324: aa0003f3    	mov	x19, x0
104a6f328: 900c5c08    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104a6f32c: f9405908    	ldr	x8, [x8, #0xb0]
104a6f330: f9400108    	ldr	x8, [x8]
104a6f334: f81a03a8    	stur	x8, [x29, #-0x60]
104a6f338: f00e0e68    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a6f33c: 52800029    	mov	w9, #0x1                ; =1
104a6f340: 390acd09    	strb	w9, [x8, #0x2b3]
104a6f344: 900db828    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a6f348: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
104a6f34c: d00d9e48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a6f350: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104a6f354: b00ce968    	adrp	x8, 0x11e79c000 <dyld_stub_binder+0x11e79c000>
104a6f358: 91212108    	add	x8, x8, #0x848 ; CFString 'build session list'
104a6f35c: f90003e8    	str	x8, [sp]
104a6f360: 900b6c05    	adrp	x5, 0x11b7ef000 <dyld_stub_binder+0x11b7ef000>
104a6f364: 910ec8a5    	add	x5, x5, #0x3b2 ; string 'MainFrameAggregationLogic.mm'
104a6f368: 900b6c07    	adrp	x7, 0x11b7ef000 <dyld_stub_binder+0x11b7ef000>
104a6f36c: 910f3ce7    	add	x7, x7, #0x3cf ; string '-[MainFrameAggregationLogic rebuildSessionList]'
104a6f370: 52800042    	mov	w2, #0x2                ; =2
104a6f374: d2800003    	mov	x3, #0x0                ; =0
104a6f378: 52800004    	mov	w4, #0x0                ; =0
104a6f37c: 52801186    	mov	w6, #0x8c               ; =140
104a6f380: 94c6df6f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f384: 900db828    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a6f388: f9455500    	ldr	x0, [x8, #0xaa8] ; class NSMutableArray
104a6f38c: 94c6df73    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104a6f390: f9401268    	ldr	x8, [x19, #0x20]
104a6f394: f9001260    	str	x0, [x19, #0x20]
104a6f398: aa0803e0    	mov	x0, x8
104a6f39c: 94c6df6e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6f3a0: 4f00e400    	movi.16b	v0, #0x0
104a6f3a4: ad0283e0    	stp	q0, q0, [sp, #0x50]
104a6f3a8: ad0183e0    	stp	q0, q0, [sp, #0x30]
104a6f3ac: 900db828    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a6f3b0: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
104a6f3b4: b00db488    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a6f3b8: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext
104a6f3bc: 94c6df60    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f3c0: aa1d03fd    	mov	x29, x29
104a6f3c4: 94c6df61    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6f3c8: aa0003f5    	mov	x21, x0
104a6f3cc: b00db828    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a6f3d0: f941bd00    	ldr	x0, [x8, #0x378] ; class MainSessionMgr
104a6f3d4: 900db488    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a6f3d8: f947ad01    	ldr	x1, [x8, #0xf58] ; selector class
104a6f3dc: 94c6df58    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f3e0: aa0003e2    	mov	x2, x0
104a6f3e4: d00d9e48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a6f3e8: f9464101    	ldr	x1, [x8, #0xc80] ; selector getService:
104a6f3ec: aa1503e0    	mov	x0, x21
104a6f3f0: 94c6df53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f3f4: aa1d03fd    	mov	x29, x29
104a6f3f8: 94c6df54    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6f3fc: aa0003f6    	mov	x22, x0
104a6f400: d00d9e68    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104a6f404: f9413d01    	ldr	x1, [x8, #0x278] ; selector visibleSessionEnumerator
104a6f408: 94c6df4d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f40c: aa1d03fd    	mov	x29, x29
104a6f410: 94c6df4e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6f414: aa0003f4    	mov	x20, x0
104a6f418: aa1603e0    	mov	x0, x22
104a6f41c: 94c6df4e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6f420: aa1503e0    	mov	x0, x21
104a6f424: 94c6df4c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6f428: b00db488    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a6f42c: f9435501    	ldr	x1, [x8, #0x6a8] ; selector countByEnumeratingWithState:objects:count:
104a6f430: 9100c3e2    	add	x2, sp, #0x30
104a6f434: 9101c3e3    	add	x3, sp, #0x70
104a6f438: f90017f4    	str	x20, [sp, #0x28]
104a6f43c: aa1403e0    	mov	x0, x20
104a6f440: f9000be1    	str	x1, [sp, #0x10]
104a6f444: 52800204    	mov	w4, #0x10               ; =16
104a6f448: 94c6df3d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f44c: b40007c0    	cbz	x0, 0x104a6f544 <_Flutter_MMFoundation_BindContext+0xf4b128>
104a6f450: aa0003f7    	mov	x23, x0
104a6f454: d2800015    	mov	x21, #0x0               ; =0
104a6f458: f94023e8    	ldr	x8, [sp, #0x40]
104a6f45c: f9400119    	ldr	x25, [x8]
104a6f460: d280001b    	mov	x27, #0x0               ; =0
104a6f464: b00da8a8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a6f468: f9406518    	ldr	x24, [x8, #0xc8] ; selector canShowSession:
104a6f46c: b00d9ea8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104a6f470: f947d909    	ldr	x9, [x8, #0xfb0] ; selector m_nsUserName
104a6f474: f00d9e48    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104a6f478: f943c51a    	ldr	x26, [x8, #0x788] ; selector safeAddObject:
104a6f47c: d00d9e68    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104a6f480: f942e508    	ldr	x8, [x8, #0x5c8] ; selector m_uUnReadCount
104a6f484: a901a7e8    	stp	x8, x9, [sp, #0x18]
104a6f488: f94023e8    	ldr	x8, [sp, #0x40]
104a6f48c: f9400108    	ldr	x8, [x8]
104a6f490: eb19011f    	cmp	x8, x25
104a6f494: 54000060    	b.eq	0x104a6f4a0 <_Flutter_MMFoundation_BindContext+0xf4b084>
104a6f498: f94017e0    	ldr	x0, [sp, #0x28]
104a6f49c: 94c6df2d    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
104a6f4a0: f9401fe8    	ldr	x8, [sp, #0x38]
104a6f4a4: f87b791c    	ldr	x28, [x8, x27, lsl #3]
104a6f4a8: aa1303e0    	mov	x0, x19
104a6f4ac: aa1803e1    	mov	x1, x24
104a6f4b0: aa1c03e2    	mov	x2, x28
104a6f4b4: 94c6df22    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f4b8: 340002e0    	cbz	w0, 0x104a6f514 <_Flutter_MMFoundation_BindContext+0xf4b0f8>
104a6f4bc: f9401a76    	ldr	x22, [x19, #0x30]
104a6f4c0: aa1c03e0    	mov	x0, x28
104a6f4c4: f94013e1    	ldr	x1, [sp, #0x20]
104a6f4c8: 94c6df1d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f4cc: aa1d03fd    	mov	x29, x29
104a6f4d0: 94c6df1e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6f4d4: aa0003f4    	mov	x20, x0
104a6f4d8: aa1603e0    	mov	x0, x22
104a6f4dc: aa1a03e1    	mov	x1, x26
104a6f4e0: aa1403e2    	mov	x2, x20
104a6f4e4: 94c6df16    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f4e8: aa1403e0    	mov	x0, x20
104a6f4ec: 94c6df1a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6f4f0: f9401260    	ldr	x0, [x19, #0x20]
104a6f4f4: aa1a03e1    	mov	x1, x26
104a6f4f8: aa1c03e2    	mov	x2, x28
104a6f4fc: 94c6df10    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f500: aa1c03e0    	mov	x0, x28
104a6f504: f9400fe1    	ldr	x1, [sp, #0x18]
104a6f508: 94c6df0d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f50c: 7100001f    	cmp	w0, #0x0
104a6f510: 9a9506b5    	cinc	x21, x21, ne
104a6f514: 9100077b    	add	x27, x27, #0x1
104a6f518: eb1b02ff    	cmp	x23, x27
104a6f51c: 54fffb61    	b.ne	0x104a6f488 <_Flutter_MMFoundation_BindContext+0xf4b06c>
104a6f520: 9100c3e2    	add	x2, sp, #0x30
104a6f524: 9101c3e3    	add	x3, sp, #0x70
104a6f528: f94017e0    	ldr	x0, [sp, #0x28]
104a6f52c: f9400be1    	ldr	x1, [sp, #0x10]
104a6f530: 52800204    	mov	w4, #0x10               ; =16
104a6f534: 94c6df02    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f538: aa0003f7    	mov	x23, x0
104a6f53c: b5fff920    	cbnz	x0, 0x104a6f460 <_Flutter_MMFoundation_BindContext+0xf4b044>
104a6f540: 14000002    	b	0x104a6f548 <_Flutter_MMFoundation_BindContext+0xf4b12c>
104a6f544: d2800015    	mov	x21, #0x0               ; =0
104a6f548: f94017e0    	ldr	x0, [sp, #0x28]
104a6f54c: 94c6df02    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6f550: f9401a60    	ldr	x0, [x19, #0x30]
104a6f554: b00db488    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a6f558: f9431501    	ldr	x1, [x8, #0x628] ; selector copy
104a6f55c: 94c6def8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f560: f9401e68    	ldr	x8, [x19, #0x38]
104a6f564: f9001e60    	str	x0, [x19, #0x38]
104a6f568: aa0803e0    	mov	x0, x8
104a6f56c: 94c6defa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6f570: b00da8a8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a6f574: f9406901    	ldr	x1, [x8, #0xd0] ; selector setInitialNotifySessionCount:
104a6f578: aa1303e0    	mov	x0, x19
104a6f57c: aa1503e2    	mov	x2, x21
104a6f580: 94c6deef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f584: f9401260    	ldr	x0, [x19, #0x20]
104a6f588: b00da068    	adrp	x8, 0x11fe7c000 <dyld_stub_binder+0x11fe7c000>
104a6f58c: f9415901    	ldr	x1, [x8, #0x2b0] ; selector sortUsingFunction:context:
104a6f590: 90000002    	adrp	x2, 0x104a6f000 <_Flutter_MMFoundation_BindContext+0xf4abe4>
104a6f594: 91177042    	add	x2, x2, #0x5dc
104a6f598: d2800003    	mov	x3, #0x0                ; =0
104a6f59c: 94c6dee8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f5a0: f85a03a8    	ldur	x8, [x29, #-0x60]
104a6f5a4: 900c5c09    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104a6f5a8: f9405929    	ldr	x9, [x9, #0xb0]
104a6f5ac: f9400129    	ldr	x9, [x9]
104a6f5b0: eb08013f    	cmp	x9, x8
104a6f5b4: 54000121    	b.ne	0x104a6f5d8 <_Flutter_MMFoundation_BindContext+0xf4b1bc>
104a6f5b8: a9557bfd    	ldp	x29, x30, [sp, #0x150]
104a6f5bc: a9544ff4    	ldp	x20, x19, [sp, #0x140]
104a6f5c0: a95357f6    	ldp	x22, x21, [sp, #0x130]
104a6f5c4: a9525ff8    	ldp	x24, x23, [sp, #0x120]
104a6f5c8: a95167fa    	ldp	x26, x25, [sp, #0x110]
104a6f5cc: a9506ffc    	ldp	x28, x27, [sp, #0x100]
104a6f5d0: 910583ff    	add	sp, sp, #0x160
104a6f5d4: d65f03c0    	ret
104a6f5d8: 94c6dee7    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
