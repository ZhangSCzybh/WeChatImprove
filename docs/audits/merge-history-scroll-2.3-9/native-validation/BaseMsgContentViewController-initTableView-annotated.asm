
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10032f3d0: d10203ff    	sub	sp, sp, #0x80
10032f3d4: 6d0123e9    	stp	d9, d8, [sp, #0x10]
10032f3d8: a9026ffc    	stp	x28, x27, [sp, #0x20]
10032f3dc: a90367fa    	stp	x26, x25, [sp, #0x30]
10032f3e0: a9045ff8    	stp	x24, x23, [sp, #0x40]
10032f3e4: a90557f6    	stp	x22, x21, [sp, #0x50]
10032f3e8: a9064ff4    	stp	x20, x19, [sp, #0x60]
10032f3ec: a9077bfd    	stp	x29, x30, [sp, #0x70]
10032f3f0: 9101c3fd    	add	x29, sp, #0x70
10032f3f4: aa0003f3    	mov	x19, x0
10032f3f8: b00fa088    	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
10032f3fc: 52800029    	mov	w9, #0x1                ; =1
10032f400: 392ac909    	strb	w9, [x8, #0xab2]
10032f404: f00f4f08    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10032f408: f9430d00    	ldr	x0, [x8, #0x618]
10032f40c: d00f34c8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10032f410: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10032f414: 900e64a8    	adrp	x8, 0x11cfc3000 <dyld_stub_binder+0x11cfc3000>
10032f418: 9126e108    	add	x8, x8, #0x9b8 ; CFString: init tableview
10032f41c: f90003e8    	str	x8, [sp]
10032f420: b00cc4c5    	adrp	x5, 0x119bc8000 <dyld_stub_binder+0x119bc8000>
10032f424: 9100f4a5    	add	x5, x5, #0x3d
10032f428: f00cc4c7    	adrp	x7, 0x119bca000 <dyld_stub_binder+0x119bca000>
10032f42c: 911a84e7    	add	x7, x7, #0x6a1
10032f430: 52800042    	mov	w2, #0x2                ; =2
10032f434: d2800003    	mov	x3, #0x0                ; =0
10032f438: 52800004    	mov	w4, #0x0                ; =0
10032f43c: 528386e6    	mov	w6, #0x1c37             ; =7223
10032f440: 95e3e209    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f444: f00f5268    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10032f448: b98cfd1a    	ldrsw	x26, [x8, #0xcfc] ; ivar: BaseMsgContentViewController.m_tableView offset=176
10032f44c: f87a6a68    	ldr	x8, [x19, x26]
10032f450: d00f4bfb    	adrp	x27, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
10032f454: b5000448    	cbnz	x8, 0x10032f4dc <__text+0x3274dc>
10032f458: f00f4f08    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10032f45c: f9474d00    	ldr	x0, [x8, #0xe98]
10032f460: 95e3e1ea    	bl	0x107c27c08 <_Flutter_MMFoundation_BindContext+0x3eae8d4>
10032f464: aa0003f4    	mov	x20, x0
10032f468: f9472b61    	ldr	x1, [x27, #0xe50] ; selector: view
10032f46c: aa1303e0    	mov	x0, x19
10032f470: 95e3e1fd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f474: aa1d03fd    	mov	x29, x29
10032f478: 95e3e202    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10032f47c: aa0003f5    	mov	x21, x0
10032f480: d00f4be8    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
10032f484: f947d501    	ldr	x1, [x8, #0xfa8] ; selector: width
10032f488: 95e3e1f7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f48c: 4ea01c08    	mov.16b	v8, v0
10032f490: d00f3568    	adrp	x8, 0x11e9dd000 <dyld_stub_binder+0x11e9dd000>
10032f494: f943b901    	ldr	x1, [x8, #0x770] ; selector: tableViewHeight
10032f498: aa1303e0    	mov	x0, x19
10032f49c: 95e3e1f2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f4a0: 4ea01c03    	mov.16b	v3, v0
10032f4a4: b00f34e8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10032f4a8: f9418901    	ldr	x1, [x8, #0x310] ; selector: initWithFrame:style:
10032f4ac: 9e6703e0    	fmov	d0, xzr
10032f4b0: 9e6703e1    	fmov	d1, xzr
10032f4b4: aa1403e0    	mov	x0, x20
10032f4b8: 4ea81d02    	mov.16b	v2, v8
10032f4bc: d2800002    	mov	x2, #0x0                ; =0
10032f4c0: 95e3e1e9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f4c4: f87a6a68    	ldr	x8, [x19, x26]
10032f4c8: f83a6a60    	str	x0, [x19, x26]
10032f4cc: aa0803e0    	mov	x0, x8
10032f4d0: 95e3e1e8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032f4d4: aa1503e0    	mov	x0, x21
10032f4d8: 95e3e1e6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032f4dc: f00f5268    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10032f4e0: b98cf119    	ldrsw	x25, [x8, #0xcf0] ; ivar: BaseMsgContentViewController.m_delegate offset=152
10032f4e4: 8b190260    	add	x0, x19, x25
10032f4e8: 95e3e1dd    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
10032f4ec: aa0003f4    	mov	x20, x0
10032f4f0: 900f3568    	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
10032f4f4: f943e501    	ldr	x1, [x8, #0x7c8] ; selector: isInForwardMsgPreView
10032f4f8: 95e3e1db    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f4fc: 34000080    	cbz	w0, 0x10032f50c <__text+0x32750c>
10032f500: aa1403e0    	mov	x0, x20
10032f504: 95e3e1db    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032f508: 1400000d    	b	0x10032f53c <__text+0x32753c>
10032f50c: 8b190260    	add	x0, x19, x25
10032f510: 95e3e1d3    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
10032f514: aa0003f5    	mov	x21, x0
10032f518: 900f3568    	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
10032f51c: f943ed01    	ldr	x1, [x8, #0x7d8] ; selector: isInMultiSelectMsg
10032f520: 95e3e1d1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f524: aa0003f6    	mov	x22, x0
10032f528: aa1503e0    	mov	x0, x21
10032f52c: 95e3e1d1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032f530: aa1403e0    	mov	x0, x20
10032f534: 95e3e1cf    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032f538: 340000d6    	cbz	w22, 0x10032f550 <__text+0x327550>
10032f53c: f87a6a60    	ldr	x0, [x19, x26]
10032f540: f00f4bc8    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
10032f544: f947a501    	ldr	x1, [x8, #0xf48] ; selector: setAutoresizingMask:
10032f548: 52800242    	mov	w2, #0x12               ; =18
10032f54c: 95e3e1c6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f550: f87a6a60    	ldr	x0, [x19, x26]
10032f554: 900f4be8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
10032f558: f9430d01    	ldr	x1, [x8, #0x618] ; selector: setDelegate:
10032f55c: aa1303e2    	mov	x2, x19
10032f560: 95e3e1c1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f564: f87a6a60    	ldr	x0, [x19, x26]
10032f568: b00f34e8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10032f56c: f947a901    	ldr	x1, [x8, #0xf50] ; selector: setDataSource:
10032f570: aa1303e2    	mov	x2, x19
10032f574: 95e3e1bc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f578: f87a6a60    	ldr	x0, [x19, x26]
10032f57c: d00f34e8    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
10032f580: f9473d01    	ldr	x1, [x8, #0xe78] ; selector: setScrollEnabled:
10032f584: 52800022    	mov	w2, #0x1                ; =1
10032f588: 95e3e1b7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f58c: f87a6a60    	ldr	x0, [x19, x26]
10032f590: b00f3548    	adrp	x8, 0x11e9d8000 <dyld_stub_binder+0x11e9d8000>
10032f594: f9433501    	ldr	x1, [x8, #0x668] ; selector: setScrollsToTop:
10032f598: 52800022    	mov	w2, #0x1                ; =1
10032f59c: 95e3e1b2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f5a0: f87a6a60    	ldr	x0, [x19, x26]
10032f5a4: d00f34c8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10032f5a8: f945b501    	ldr	x1, [x8, #0xb68] ; selector: setM_delegate:
10032f5ac: aa1303e2    	mov	x2, x19
10032f5b0: 95e3e1ad    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f5b4: f87a6a60    	ldr	x0, [x19, x26]
10032f5b8: d00f3548    	adrp	x8, 0x11e9d9000 <dyld_stub_binder+0x11e9d9000>
10032f5bc: f9479d01    	ldr	x1, [x8, #0xf38] ; selector: setPrefetchingEnabled:
10032f5c0: 52800002    	mov	w2, #0x0                ; =0
10032f5c4: 95e3e1a8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f5c8: f87a6a60    	ldr	x0, [x19, x26]
10032f5cc: f00f3568    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
10032f5d0: f9470901    	ldr	x1, [x8, #0xe10] ; selector: panGestureRecognizer
10032f5d4: 95e3e1a4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f5d8: aa1d03fd    	mov	x29, x29
10032f5dc: 95e3e1a9    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10032f5e0: aa0003f4    	mov	x20, x0
10032f5e4: f00f3568    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
10032f5e8: f9470d03    	ldr	x3, [x8, #0xe18] ; selector: onPan:
10032f5ec: b00f3528    	adrp	x8, 0x11e9d4000 <dyld_stub_binder+0x11e9d4000>
10032f5f0: f942e101    	ldr	x1, [x8, #0x5c0] ; selector: addTarget:action:
10032f5f4: aa1303e2    	mov	x2, x19
10032f5f8: 95e3e19b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f5fc: aa1403e0    	mov	x0, x20
10032f600: 95e3e19c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032f604: f00f5268    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10032f608: b98d4108    	ldrsw	x8, [x8, #0xd40] ; ivar: BaseMsgContentViewController.m_backgroundView offset=208
10032f60c: f8686a68    	ldr	x8, [x19, x8]
10032f610: b4000548    	cbz	x8, 0x10032f6b8 <__text+0x3276b8>
10032f614: f00f4f08    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10032f618: f943c100    	ldr	x0, [x8, #0x780]
10032f61c: d00f34c8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10032f620: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
10032f624: 95e3e190    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f628: aa1d03fd    	mov	x29, x29
10032f62c: 95e3e195    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10032f630: aa0003f4    	mov	x20, x0
10032f634: f00f4f08    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10032f638: f9462100    	ldr	x0, [x8, #0xc40]
10032f63c: f00f4ba8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10032f640: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
10032f644: 95e3e188    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f648: aa0003e2    	mov	x2, x0
10032f64c: d00f34c8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10032f650: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
10032f654: aa1403e0    	mov	x0, x20
10032f658: 95e3e183    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f65c: aa1d03fd    	mov	x29, x29
10032f660: 95e3e188    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10032f664: aa0003f5    	mov	x21, x0
10032f668: 900f34e8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10032f66c: f9478101    	ldr	x1, [x8, #0xf00] ; selector: colorList
10032f670: 95e3e17d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f674: aa1d03fd    	mov	x29, x29
10032f678: 95e3e182    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10032f67c: aa0003f6    	mov	x22, x0
10032f680: 900f34e8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10032f684: f9478501    	ldr	x1, [x8, #0xf08] ; selector: getColorByName:
10032f688: d00e6382    	adrp	x2, 0x11cfa1000 <dyld_stub_binder+0x11cfa1000>
10032f68c: 911d6042    	add	x2, x2, #0x758 ; CFString: clear
10032f690: 95e3e175    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f694: aa1d03fd    	mov	x29, x29
10032f698: 95e3e17a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10032f69c: aa0003f7    	mov	x23, x0
10032f6a0: 95e3e175    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10032f6a4: b4000260    	cbz	x0, 0x10032f6f0 <__text+0x3276f0>
10032f6a8: aa1703e0    	mov	x0, x23
10032f6ac: 95e3e172    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10032f6b0: aa1703f8    	mov	x24, x23
10032f6b4: 14000017    	b	0x10032f710 <__text+0x327710>
10032f6b8: f00f4f08    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10032f6bc: f9440500    	ldr	x0, [x8, #0x808]
10032f6c0: f00f3568    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
10032f6c4: f9471101    	ldr	x1, [x8, #0xe20] ; selector: chatBgColor
10032f6c8: 95e3e167    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f6cc: aa1d03fd    	mov	x29, x29
10032f6d0: 95e3e16c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10032f6d4: aa0003f4    	mov	x20, x0
10032f6d8: f87a6a60    	ldr	x0, [x19, x26]
10032f6dc: 900f4be8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
10032f6e0: f9401d01    	ldr	x1, [x8, #0x38] ; selector: setBackgroundColor:
10032f6e4: aa1403e2    	mov	x2, x20
10032f6e8: 95e3e15f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f6ec: 14000018    	b	0x10032f74c <__text+0x32774c>
10032f6f0: f00f4f08    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10032f6f4: f9440900    	ldr	x0, [x8, #0x810]
10032f6f8: f00f4ba8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10032f6fc: f942a901    	ldr	x1, [x8, #0x550] ; selector: clearColor
10032f700: 95e3e159    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f704: aa1d03fd    	mov	x29, x29
10032f708: 95e3e15e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10032f70c: aa0003f8    	mov	x24, x0
10032f710: aa1703e0    	mov	x0, x23
10032f714: 95e3e157    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032f718: f87a6a60    	ldr	x0, [x19, x26]
10032f71c: 900f4be8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
10032f720: f9401d01    	ldr	x1, [x8, #0x38] ; selector: setBackgroundColor:
10032f724: aa1803e2    	mov	x2, x24
10032f728: 95e3e14f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f72c: aa1803e0    	mov	x0, x24
10032f730: 95e3e150    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032f734: aa1703e0    	mov	x0, x23
10032f738: 95e3e14e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032f73c: aa1603e0    	mov	x0, x22
10032f740: 95e3e14c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032f744: aa1503e0    	mov	x0, x21
10032f748: 95e3e14a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032f74c: aa1403e0    	mov	x0, x20
10032f750: 95e3e148    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032f754: f87a6a60    	ldr	x0, [x19, x26]
10032f758: b00f34e8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10032f75c: f947b501    	ldr	x1, [x8, #0xf68] ; selector: setSeparatorStyle:
10032f760: d2800002    	mov	x2, #0x0                ; =0
10032f764: 95e3e140    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f768: f87a6a60    	ldr	x0, [x19, x26]
10032f76c: f00f3568    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
10032f770: f9471501    	ldr	x1, [x8, #0xe28] ; selector: setAllowsSelectionDuringEditing:
10032f774: 52800022    	mov	w2, #0x1                ; =1
10032f778: 95e3e13b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f77c: f87a6a60    	ldr	x0, [x19, x26]
10032f780: f00f3568    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
10032f784: f9471901    	ldr	x1, [x8, #0xe30] ; selector: setCancelButtonTouchsTrack:
10032f788: 52800022    	mov	w2, #0x1                ; =1
10032f78c: 95e3e136    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f790: f87a6a60    	ldr	x0, [x19, x26]
10032f794: f00f3568    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
10032f798: f9471d01    	ldr	x1, [x8, #0xe38] ; selector: setEditing:animated:
10032f79c: 52800002    	mov	w2, #0x0                ; =0
10032f7a0: 52800023    	mov	w3, #0x1                ; =1
10032f7a4: 95e3e130    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f7a8: f9472b61    	ldr	x1, [x27, #0xe50] ; selector: view
10032f7ac: aa1303e0    	mov	x0, x19
10032f7b0: 95e3e12d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f7b4: aa1d03fd    	mov	x29, x29
10032f7b8: 95e3e132    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10032f7bc: aa0003f4    	mov	x20, x0
10032f7c0: f87a6a62    	ldr	x2, [x19, x26]
10032f7c4: d00f4ba8    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
10032f7c8: f9456501    	ldr	x1, [x8, #0xac8] ; selector: addSubview:
10032f7cc: 95e3e126    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f7d0: aa1403e0    	mov	x0, x20
10032f7d4: 95e3e127    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032f7d8: 900f3568    	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
10032f7dc: f9436101    	ldr	x1, [x8, #0x6c0] ; selector: m_badRoomLogicController
10032f7e0: aa1303e0    	mov	x0, x19
10032f7e4: 95e3e120    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f7e8: aa1d03fd    	mov	x29, x29
10032f7ec: 95e3e125    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10032f7f0: aa0003f4    	mov	x20, x0
10032f7f4: f00f3568    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
10032f7f8: f9472101    	ldr	x1, [x8, #0xe40] ; selector: hasBadRoomUnread
10032f7fc: 95e3e11a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f800: aa0003f5    	mov	x21, x0
10032f804: aa1403e0    	mov	x0, x20
10032f808: 95e3e11a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032f80c: 340000d5    	cbz	w21, 0x10032f824 <__text+0x327824>
10032f810: f00f3568    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
10032f814: f946a901    	ldr	x1, [x8, #0xd50] ; selector: setTableFooterView:
10032f818: aa1303e0    	mov	x0, x19
10032f81c: 52800022    	mov	w2, #0x1                ; =1
10032f820: 95e3e111    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f824: 900f34e8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10032f828: f9470101    	ldr	x1, [x8, #0xe00] ; selector: reloadTableData
10032f82c: aa1303e0    	mov	x0, x19
10032f830: 95e3e10d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f834: f00f5268    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10032f838: b98d0108    	ldrsw	x8, [x8, #0xd00] ; ivar: BaseMsgContentViewController.m_uiInterfaceOrientation offset=320
10032f83c: f8686a62    	ldr	x2, [x19, x8]
10032f840: f00f3568    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
10032f844: f9472501    	ldr	x1, [x8, #0xe48] ; selector: updateTableLayoutAnimateDuration:Orientation:
10032f848: 9e6703e0    	fmov	d0, xzr
10032f84c: aa1303e0    	mov	x0, x19
10032f850: 95e3e105    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f854: d00f3568    	adrp	x8, 0x11e9dd000 <dyld_stub_binder+0x11e9dd000>
10032f858: f943b101    	ldr	x1, [x8, #0x760] ; selector: scrollTableToBottomAnimated:init:
10032f85c: aa1303e0    	mov	x0, x19
10032f860: 52800002    	mov	w2, #0x0                ; =0
10032f864: 52800023    	mov	w3, #0x1                ; =1
10032f868: 95e3e0ff    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f86c: 8b190260    	add	x0, x19, x25
10032f870: 95e3e0fb    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
10032f874: aa0003f4    	mov	x20, x0
10032f878: d00f3568    	adrp	x8, 0x11e9dd000 <dyld_stub_binder+0x11e9dd000>
10032f87c: f9417d01    	ldr	x1, [x8, #0x2f8] ; selector: ShouldShowMultiSelectMode
10032f880: 95e3e0f9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f884: aa0003f5    	mov	x21, x0
10032f888: aa1403e0    	mov	x0, x20
10032f88c: 95e3e0f9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032f890: 340001d5    	cbz	w21, 0x10032f8c8 <__text+0x3278c8>
10032f894: b00f3568    	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
10032f898: f9457101    	ldr	x1, [x8, #0xae0] ; selector: onEditMessage:
10032f89c: aa1303e0    	mov	x0, x19
10032f8a0: d2800002    	mov	x2, #0x0                ; =0
10032f8a4: a9477bfd    	ldp	x29, x30, [sp, #0x70]
10032f8a8: a9464ff4    	ldp	x20, x19, [sp, #0x60]
10032f8ac: a94557f6    	ldp	x22, x21, [sp, #0x50]
10032f8b0: a9445ff8    	ldp	x24, x23, [sp, #0x40]
10032f8b4: a94367fa    	ldp	x26, x25, [sp, #0x30]
10032f8b8: a9426ffc    	ldp	x28, x27, [sp, #0x20]
10032f8bc: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
10032f8c0: 910203ff    	add	sp, sp, #0x80
10032f8c4: 15e3e0e8    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032f8c8: a9477bfd    	ldp	x29, x30, [sp, #0x70]
10032f8cc: a9464ff4    	ldp	x20, x19, [sp, #0x60]
10032f8d0: a94557f6    	ldp	x22, x21, [sp, #0x50]
10032f8d4: a9445ff8    	ldp	x24, x23, [sp, #0x40]
10032f8d8: a94367fa    	ldp	x26, x25, [sp, #0x30]
10032f8dc: a9426ffc    	ldp	x28, x27, [sp, #0x20]
10032f8e0: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
10032f8e4: 910203ff    	add	sp, sp, #0x80
10032f8e8: d65f03c0    	ret
