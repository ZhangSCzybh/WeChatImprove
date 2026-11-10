
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
1052a635c: d10503ff    	sub	sp, sp, #0x140
1052a6360: 6d0d23e9    	stp	d9, d8, [sp, #0xd0]
1052a6364: a90e6ffc    	stp	x28, x27, [sp, #0xe0]
1052a6368: a90f67fa    	stp	x26, x25, [sp, #0xf0]
1052a636c: a9105ff8    	stp	x24, x23, [sp, #0x100]
1052a6370: a91157f6    	stp	x22, x21, [sp, #0x110]
1052a6374: a9124ff4    	stp	x20, x19, [sp, #0x120]
1052a6378: a9137bfd    	stp	x29, x30, [sp, #0x130]
1052a637c: 9104c3fd    	add	x29, sp, #0x130
1052a6380: aa0303f3    	mov	x19, x3
1052a6384: aa0203f5    	mov	x21, x2
1052a6388: aa0003f4    	mov	x20, x0
1052a638c: d00c2528    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1052a6390: f9451908    	ldr	x8, [x8, #0xa30]
1052a6394: f9400108    	ldr	x8, [x8]
1052a6398: f81903a8    	stur	x8, [x29, #-0x70]
1052a639c: 900d2568    	adrp	x8, 0x11f752000 <dyld_stub_binder+0x11f752000>
1052a63a0: 52800029    	mov	w9, #0x1                ; =1
1052a63a4: 39363d09    	strb	w9, [x8, #0xd8f]
1052a63a8: aa0303e0    	mov	x0, x3
1052a63ac: 94a60632    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1052a63b0: 900cbd08    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a63b4: f943dd08    	ldr	x8, [x8, #0x7b8] ; selector: forwardAction:
1052a63b8: eb0802bf    	cmp	x21, x8
1052a63bc: 540008a0    	b.eq	0x1052a64d0 <_Flutter_MMFoundation_BindContext+0x152d19c>
1052a63c0: d00cbd08    	adrp	x8, 0x11ea48000 <dyld_stub_binder+0x11ea48000>
1052a63c4: f9442508    	ldr	x8, [x8, #0x848] ; selector: convertToNoteAction:
1052a63c8: eb0802bf    	cmp	x21, x8
1052a63cc: 54000fe0    	b.eq	0x1052a65c8 <_Flutter_MMFoundation_BindContext+0x152d294>
1052a63d0: 900cbd08    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a63d4: f943d108    	ldr	x8, [x8, #0x7a0] ; selector: deleteAction:
1052a63d8: eb0802bf    	cmp	x21, x8
1052a63dc: 54001360    	b.eq	0x1052a6648 <_Flutter_MMFoundation_BindContext+0x152d314>
1052a63e0: 900cbd08    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a63e4: f943d508    	ldr	x8, [x8, #0x7a8] ; selector: moreAction:
1052a63e8: eb0802bf    	cmp	x21, x8
1052a63ec: 54001b60    	b.eq	0x1052a6758 <_Flutter_MMFoundation_BindContext+0x152d424>
1052a63f0: 900cbd08    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a63f4: f943f108    	ldr	x8, [x8, #0x7e0] ; selector: showContentAction:
1052a63f8: eb0802bf    	cmp	x21, x8
1052a63fc: 54004020    	b.eq	0x1052a6c00 <_Flutter_MMFoundation_BindContext+0x152d8cc>
1052a6400: 900cbd08    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a6404: f943d908    	ldr	x8, [x8, #0x7b0] ; selector: editTagAction:
1052a6408: eb0802bf    	cmp	x21, x8
1052a640c: 540047c0    	b.eq	0x1052a6d04 <_Flutter_MMFoundation_BindContext+0x152d9d0>
1052a6410: 900cbd08    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a6414: f943e908    	ldr	x8, [x8, #0x7d0] ; selector: pinTopAction:
1052a6418: eb0802bf    	cmp	x21, x8
1052a641c: 54004ba0    	b.eq	0x1052a6d90 <_Flutter_MMFoundation_BindContext+0x152da5c>
1052a6420: 900cbd08    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a6424: f943ed08    	ldr	x8, [x8, #0x7d8] ; selector: unpinTopAction:
1052a6428: eb0802bf    	cmp	x21, x8
1052a642c: 540062a0    	b.eq	0x1052a7080 <_Flutter_MMFoundation_BindContext+0x152dd4c>
1052a6430: 900cbd08    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a6434: f943e108    	ldr	x8, [x8, #0x7c0] ; selector: starAction:
1052a6438: eb0802bf    	cmp	x21, x8
1052a643c: 54006840    	b.eq	0x1052a7144 <_Flutter_MMFoundation_BindContext+0x152de10>
1052a6440: 900cbd08    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a6444: f943e508    	ldr	x8, [x8, #0x7c8] ; selector: unstarAction:
1052a6448: eb0802bf    	cmp	x21, x8
1052a644c: 54005f81    	b.ne	0x1052a703c <_Flutter_MMFoundation_BindContext+0x152dd08>
1052a6450: d00cb928    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1052a6454: f9427501    	ldr	x1, [x8, #0x4e8] ; selector: section
1052a6458: aa1303e0    	mov	x0, x19
1052a645c: 94a60602    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6460: aa0003e2    	mov	x2, x0
1052a6464: 900cd768    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
1052a6468: 9135f108    	add	x8, x8, #0xd7c
1052a646c: b9800108    	ldrsw	x8, [x8] ; ivar: FavBaseListViewController.m_dataController offset=200
1052a6470: f8686a80    	ldr	x0, [x20, x8]
1052a6474: f00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a6478: f9478d01    	ldr	x1, [x8, #0xf18] ; selector: dataAtIndex:
1052a647c: 94a605fa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6480: aa1d03fd    	mov	x29, x29
1052a6484: 94a605ff    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6488: aa0003f4    	mov	x20, x0
1052a648c: b00cd368    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1052a6490: f944dd00    	ldr	x0, [x8, #0x9b8]
1052a6494: 900cd008    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1052a6498: f9428516    	ldr	x22, [x8, #0x508] ; selector: class
1052a649c: aa1603e1    	mov	x1, x22
1052a64a0: 94a605f1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a64a4: aa0003e2    	mov	x2, x0
1052a64a8: d00cd008    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1052a64ac: f9444915    	ldr	x21, [x8, #0x890] ; selector: isKindOfClass:
1052a64b0: aa1403e0    	mov	x0, x20
1052a64b4: aa1503e1    	mov	x1, x21
1052a64b8: 94a605eb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a64bc: 34008300    	cbz	w0, 0x1052a751c <_Flutter_MMFoundation_BindContext+0x152e1e8>
1052a64c0: aa1403e0    	mov	x0, x20
1052a64c4: 94a605ec    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1052a64c8: aa1403f5    	mov	x21, x20
1052a64cc: 14000424    	b	0x1052a755c <_Flutter_MMFoundation_BindContext+0x152e228>
1052a64d0: d00cb928    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1052a64d4: f9427501    	ldr	x1, [x8, #0x4e8] ; selector: section
1052a64d8: aa1303e0    	mov	x0, x19
1052a64dc: 94a605e2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a64e0: aa0003e2    	mov	x2, x0
1052a64e4: 900cd768    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
1052a64e8: 9135f108    	add	x8, x8, #0xd7c
1052a64ec: b9800108    	ldrsw	x8, [x8] ; ivar: FavBaseListViewController.m_dataController offset=200
1052a64f0: f8686a80    	ldr	x0, [x20, x8]
1052a64f4: f00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a64f8: f9478d01    	ldr	x1, [x8, #0xf18] ; selector: dataAtIndex:
1052a64fc: 94a605da    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6500: aa1d03fd    	mov	x29, x29
1052a6504: 94a605df    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6508: aa0003f5    	mov	x21, x0
1052a650c: 900cd368    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1052a6510: f943c100    	ldr	x0, [x8, #0x780]
1052a6514: f00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a6518: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
1052a651c: 94a605d2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6520: aa1d03fd    	mov	x29, x29
1052a6524: 94a605d7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6528: aa0003f6    	mov	x22, x0
1052a652c: b00cd368    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1052a6530: f9448500    	ldr	x0, [x8, #0x908]
1052a6534: 900cd008    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1052a6538: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
1052a653c: 94a605ca    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6540: aa0003e2    	mov	x2, x0
1052a6544: f00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a6548: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
1052a654c: aa1603e0    	mov	x0, x22
1052a6550: 94a605c5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6554: aa1d03fd    	mov	x29, x29
1052a6558: 94a605ca    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a655c: aa0003f7    	mov	x23, x0
1052a6560: 900cbd08    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a6564: f943b901    	ldr	x1, [x8, #0x770] ; selector: reportViewClick:itemOrDataWrap:
1052a6568: 52800042    	mov	w2, #0x2                ; =2
1052a656c: aa1503e3    	mov	x3, x21
1052a6570: 94a605bd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6574: aa1703e0    	mov	x0, x23
1052a6578: 94a605be    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a657c: aa1603e0    	mov	x0, x22
1052a6580: 94a605bc    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a6584: f81883b5    	stur	x21, [x29, #-0x78]
1052a6588: 900cd368    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1052a658c: f9434500    	ldr	x0, [x8, #0x688]
1052a6590: f00ccfe8    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
1052a6594: f946e101    	ldr	x1, [x8, #0xdc0] ; selector: arrayWithObjects:count:
1052a6598: d101e3a2    	sub	x2, x29, #0x78
1052a659c: 52800023    	mov	w3, #0x1                ; =1
1052a65a0: 94a605b1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a65a4: aa1d03fd    	mov	x29, x29
1052a65a8: 94a605b6    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a65ac: aa0003f6    	mov	x22, x0
1052a65b0: d00cc468    	adrp	x8, 0x11eb34000 <dyld_stub_binder+0x11eb34000>
1052a65b4: f9437901    	ldr	x1, [x8, #0x6f0] ; selector: forwardData:
1052a65b8: aa1403e0    	mov	x0, x20
1052a65bc: aa1603e2    	mov	x2, x22
1052a65c0: 94a605a9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a65c4: 1400029a    	b	0x1052a702c <_Flutter_MMFoundation_BindContext+0x152dcf8>
1052a65c8: d00cb928    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1052a65cc: f9427501    	ldr	x1, [x8, #0x4e8] ; selector: section
1052a65d0: aa1303e0    	mov	x0, x19
1052a65d4: 94a605a4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a65d8: aa0003e2    	mov	x2, x0
1052a65dc: 900cd768    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
1052a65e0: 9135f108    	add	x8, x8, #0xd7c
1052a65e4: b9800108    	ldrsw	x8, [x8] ; ivar: FavBaseListViewController.m_dataController offset=200
1052a65e8: f8686a80    	ldr	x0, [x20, x8]
1052a65ec: f00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a65f0: f9478d01    	ldr	x1, [x8, #0xf18] ; selector: dataAtIndex:
1052a65f4: 94a6059c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a65f8: aa1d03fd    	mov	x29, x29
1052a65fc: 94a605a1    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6600: aa0003f5    	mov	x21, x0
1052a6604: b00cd368    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1052a6608: f944dd00    	ldr	x0, [x8, #0x9b8]
1052a660c: 900cd008    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1052a6610: f9428519    	ldr	x25, [x8, #0x508] ; selector: class
1052a6614: aa1903e1    	mov	x1, x25
1052a6618: 94a60593    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a661c: aa0003e2    	mov	x2, x0
1052a6620: d00cd008    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1052a6624: f9444916    	ldr	x22, [x8, #0x890] ; selector: isKindOfClass:
1052a6628: aa1503e0    	mov	x0, x21
1052a662c: aa1603e1    	mov	x1, x22
1052a6630: 94a6058d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6634: 34000700    	cbz	w0, 0x1052a6714 <_Flutter_MMFoundation_BindContext+0x152d3e0>
1052a6638: aa1503e0    	mov	x0, x21
1052a663c: 94a6058e    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1052a6640: aa1503f6    	mov	x22, x21
1052a6644: 14000081    	b	0x1052a6848 <_Flutter_MMFoundation_BindContext+0x152d514>
1052a6648: d00cb928    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1052a664c: f9427501    	ldr	x1, [x8, #0x4e8] ; selector: section
1052a6650: aa1303e0    	mov	x0, x19
1052a6654: 94a60584    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6658: aa0003e2    	mov	x2, x0
1052a665c: 900cd768    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
1052a6660: 9135f108    	add	x8, x8, #0xd7c
1052a6664: b9800108    	ldrsw	x8, [x8] ; ivar: FavBaseListViewController.m_dataController offset=200
1052a6668: f8686a80    	ldr	x0, [x20, x8]
1052a666c: f00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a6670: f9478d01    	ldr	x1, [x8, #0xf18] ; selector: dataAtIndex:
1052a6674: 94a6057c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6678: aa1d03fd    	mov	x29, x29
1052a667c: 94a60581    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6680: aa0003f5    	mov	x21, x0
1052a6684: 900cd368    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1052a6688: f943c100    	ldr	x0, [x8, #0x780]
1052a668c: f00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a6690: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
1052a6694: 94a60574    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6698: aa1d03fd    	mov	x29, x29
1052a669c: 94a60579    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a66a0: aa0003f6    	mov	x22, x0
1052a66a4: b00cd368    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1052a66a8: f9448500    	ldr	x0, [x8, #0x908]
1052a66ac: 900cd008    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1052a66b0: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
1052a66b4: 94a6056c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a66b8: aa0003e2    	mov	x2, x0
1052a66bc: f00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a66c0: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
1052a66c4: aa1603e0    	mov	x0, x22
1052a66c8: 94a60567    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a66cc: aa1d03fd    	mov	x29, x29
1052a66d0: 94a6056c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a66d4: aa0003f7    	mov	x23, x0
1052a66d8: 900cbd08    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a66dc: f943b901    	ldr	x1, [x8, #0x770] ; selector: reportViewClick:itemOrDataWrap:
1052a66e0: 52800082    	mov	w2, #0x4                ; =4
1052a66e4: aa1503e3    	mov	x3, x21
1052a66e8: 94a6055f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a66ec: aa1703e0    	mov	x0, x23
1052a66f0: 94a60560    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a66f4: aa1603e0    	mov	x0, x22
1052a66f8: 94a6055e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a66fc: d00cc468    	adrp	x8, 0x11eb34000 <dyld_stub_binder+0x11eb34000>
1052a6700: f9458101    	ldr	x1, [x8, #0xb00] ; selector: deleteDataAtIndexPath:
1052a6704: aa1403e0    	mov	x0, x20
1052a6708: aa1303e2    	mov	x2, x19
1052a670c: 94a60556    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6710: 14000249    	b	0x1052a7034 <_Flutter_MMFoundation_BindContext+0x152dd00>
1052a6714: b00cd3c8    	adrp	x8, 0x11ed1f000 <dyld_stub_binder+0x11ed1f000>
1052a6718: f9407900    	ldr	x0, [x8, #0xf0]
1052a671c: aa1903e1    	mov	x1, x25
1052a6720: 94a60551    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6724: aa0003e2    	mov	x2, x0
1052a6728: aa1503e0    	mov	x0, x21
1052a672c: aa1603e1    	mov	x1, x22
1052a6730: 94a6054d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6734: 34000880    	cbz	w0, 0x1052a6844 <_Flutter_MMFoundation_BindContext+0x152d510>
1052a6738: d00cb9a8    	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
1052a673c: f942cd01    	ldr	x1, [x8, #0x598] ; selector: parent
1052a6740: aa1503e0    	mov	x0, x21
1052a6744: 94a60548    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6748: aa1d03fd    	mov	x29, x29
1052a674c: 94a6054d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6750: aa0003f6    	mov	x22, x0
1052a6754: 1400003d    	b	0x1052a6848 <_Flutter_MMFoundation_BindContext+0x152d514>
1052a6758: d00cb928    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1052a675c: f9427501    	ldr	x1, [x8, #0x4e8] ; selector: section
1052a6760: aa1303e0    	mov	x0, x19
1052a6764: 94a60540    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6768: aa0003e2    	mov	x2, x0
1052a676c: 900cd768    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
1052a6770: 9135f108    	add	x8, x8, #0xd7c
1052a6774: b9800108    	ldrsw	x8, [x8] ; ivar: FavBaseListViewController.m_dataController offset=200
1052a6778: f8686a80    	ldr	x0, [x20, x8]
1052a677c: f00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a6780: f9478d01    	ldr	x1, [x8, #0xf18] ; selector: dataAtIndex:
1052a6784: 94a60538    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6788: aa1d03fd    	mov	x29, x29
1052a678c: 94a6053d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6790: aa0003f5    	mov	x21, x0
1052a6794: 900cd368    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1052a6798: f943c100    	ldr	x0, [x8, #0x780]
1052a679c: f00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a67a0: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
1052a67a4: 94a60530    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a67a8: aa1d03fd    	mov	x29, x29
1052a67ac: 94a60535    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a67b0: aa0003f6    	mov	x22, x0
1052a67b4: b00cd368    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1052a67b8: f9448500    	ldr	x0, [x8, #0x908]
1052a67bc: 900cd008    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1052a67c0: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
1052a67c4: 94a60528    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a67c8: aa0003e2    	mov	x2, x0
1052a67cc: f00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a67d0: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
1052a67d4: aa1603e0    	mov	x0, x22
1052a67d8: 94a60523    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a67dc: aa1d03fd    	mov	x29, x29
1052a67e0: 94a60528    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a67e4: aa0003f7    	mov	x23, x0
1052a67e8: 900cbd08    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a67ec: f943b901    	ldr	x1, [x8, #0x770] ; selector: reportViewClick:itemOrDataWrap:
1052a67f0: 528000a2    	mov	w2, #0x5                ; =5
1052a67f4: aa1503e3    	mov	x3, x21
1052a67f8: 94a6051b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a67fc: aa1703e0    	mov	x0, x23
1052a6800: 94a6051c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a6804: aa1603e0    	mov	x0, x22
1052a6808: 94a6051a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a680c: 900cd768    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
1052a6810: 91368108    	add	x8, x8, #0xda0
1052a6814: b9800108    	ldrsw	x8, [x8] ; ivar: FavBaseListViewController.m_tableView offset=136
1052a6818: f8686a80    	ldr	x0, [x20, x8]
1052a681c: f00cb928    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
1052a6820: f9400d01    	ldr	x1, [x8, #0x18] ; selector: deselectRowAtIndexPath:animated:
1052a6824: aa1303e2    	mov	x2, x19
1052a6828: 52800003    	mov	w3, #0x0                ; =0
1052a682c: 94a6050e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6830: 900cbd08    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a6834: f943f901    	ldr	x1, [x8, #0x7f0] ; selector: onMultiSelect
1052a6838: aa1403e0    	mov	x0, x20
1052a683c: 94a6050a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6840: 140001fd    	b	0x1052a7034 <_Flutter_MMFoundation_BindContext+0x152dd00>
1052a6844: d2800016    	mov	x22, #0x0               ; =0
1052a6848: 900cd368    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1052a684c: f943c100    	ldr	x0, [x8, #0x780]
1052a6850: f00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a6854: f944011b    	ldr	x27, [x8, #0x800] ; selector: currentContext
1052a6858: aa1b03e1    	mov	x1, x27
1052a685c: 94a60502    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6860: aa1d03fd    	mov	x29, x29
1052a6864: 94a60507    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6868: aa0003f7    	mov	x23, x0
1052a686c: b00cd368    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1052a6870: f9448500    	ldr	x0, [x8, #0x908]
1052a6874: aa1903e1    	mov	x1, x25
1052a6878: 94a604fb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a687c: aa0003e2    	mov	x2, x0
1052a6880: f00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a6884: f945211c    	ldr	x28, [x8, #0xa40] ; selector: getService:
1052a6888: aa1703e0    	mov	x0, x23
1052a688c: aa1c03e1    	mov	x1, x28
1052a6890: 94a604f5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6894: aa1d03fd    	mov	x29, x29
1052a6898: 94a604fa    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a689c: aa0003f8    	mov	x24, x0
1052a68a0: f00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a68a4: f9457901    	ldr	x1, [x8, #0xaf0] ; selector: isFavTurnToNoteInLongClickEnabled
1052a68a8: 94a604ef    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a68ac: 34003b80    	cbz	w0, 0x1052a701c <_Flutter_MMFoundation_BindContext+0x152dce8>
1052a68b0: b00cd368    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1052a68b4: f9447d00    	ldr	x0, [x8, #0x8f8]
1052a68b8: f00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a68bc: f9456901    	ldr	x1, [x8, #0xad0] ; selector: canConvertToNoteFavItem:
1052a68c0: aa1603e2    	mov	x2, x22
1052a68c4: 94a604e8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a68c8: aa0003fa    	mov	x26, x0
1052a68cc: aa1803e0    	mov	x0, x24
1052a68d0: 94a604e8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a68d4: aa1703e0    	mov	x0, x23
1052a68d8: 94a604e6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a68dc: 36003a9a    	tbz	w26, #0x0, 0x1052a702c <_Flutter_MMFoundation_BindContext+0x152dcf8>
1052a68e0: f00cd008    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
1052a68e4: f941b101    	ldr	x1, [x8, #0x360] ; selector: navigationController
1052a68e8: aa1403e0    	mov	x0, x20
1052a68ec: 94a604de    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a68f0: aa1d03fd    	mov	x29, x29
1052a68f4: 94a604e3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a68f8: aa0003f7    	mov	x23, x0
1052a68fc: d10223a0    	sub	x0, x29, #0x88
1052a6900: aa1703e1    	mov	x1, x23
1052a6904: 94a604d5    	bl	0x107c27c58 <_Flutter_MMFoundation_BindContext+0x3eae924>
1052a6908: aa1703e0    	mov	x0, x23
1052a690c: 94a604d9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a6910: d10223a0    	sub	x0, x29, #0x88
1052a6914: 94a604d2    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1052a6918: aa0003f7    	mov	x23, x0
1052a691c: f00cd028    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1052a6920: f9448901    	ldr	x1, [x8, #0x910] ; selector: topViewController
1052a6924: 94a604d0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6928: aa1d03fd    	mov	x29, x29
1052a692c: 94a604d5    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6930: aa0003f8    	mov	x24, x0
1052a6934: d10243a0    	sub	x0, x29, #0x90
1052a6938: aa1803e1    	mov	x1, x24
1052a693c: 94a604c7    	bl	0x107c27c58 <_Flutter_MMFoundation_BindContext+0x3eae924>
1052a6940: aa1803e0    	mov	x0, x24
1052a6944: 94a604cb    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a6948: aa1703e0    	mov	x0, x23
1052a694c: 94a604c9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a6950: d00cbd08    	adrp	x8, 0x11ea48000 <dyld_stub_binder+0x11ea48000>
1052a6954: f9447901    	ldr	x1, [x8, #0x8f0] ; selector: beginLongPressNoteConversionSnapshot
1052a6958: aa1403e0    	mov	x0, x20
1052a695c: 94a604c2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6960: aa1d03fd    	mov	x29, x29
1052a6964: 94a604c7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6968: aa0003f7    	mov	x23, x0
1052a696c: 900cbd08    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a6970: f941051a    	ldr	x26, [x8, #0x208] ; selector: setSuppressNextConvertedNoteAutoScroll:
1052a6974: aa1403e0    	mov	x0, x20
1052a6978: aa1a03e1    	mov	x1, x26
1052a697c: 52800022    	mov	w2, #0x1                ; =1
1052a6980: 94a604b9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6984: b00cd368    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1052a6988: f9447d00    	ldr	x0, [x8, #0x8f8]
1052a698c: f00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a6990: f9456d01    	ldr	x1, [x8, #0xad8] ; selector: ConvertFavItemToNoteFavItem:
1052a6994: aa1603e2    	mov	x2, x22
1052a6998: 94a604b3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a699c: aa1d03fd    	mov	x29, x29
1052a69a0: 94a604b8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a69a4: aa0003f8    	mov	x24, x0
1052a69a8: aa1403e0    	mov	x0, x20
1052a69ac: aa1a03e1    	mov	x1, x26
1052a69b0: 52800002    	mov	w2, #0x0                ; =0
1052a69b4: 94a604ac    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a69b8: b40022d8    	cbz	x24, 0x1052a6e10 <_Flutter_MMFoundation_BindContext+0x152dadc>
1052a69bc: b00cd368    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1052a69c0: f946b900    	ldr	x0, [x8, #0xd70]
1052a69c4: 94a60492    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
1052a69c8: aa0003fa    	mov	x26, x0
1052a69cc: 900cb968    	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
1052a69d0: f943fd01    	ldr	x1, [x8, #0x7f8] ; selector: setFavItem:
1052a69d4: aa1803e2    	mov	x2, x24
1052a69d8: 94a604a3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a69dc: 900cb968    	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
1052a69e0: f9440101    	ldr	x1, [x8, #0x800] ; selector: setBEditable:
1052a69e4: aa1a03e0    	mov	x0, x26
1052a69e8: 52800022    	mov	w2, #0x1                ; =1
1052a69ec: 94a6049e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a69f0: b00cd3c8    	adrp	x8, 0x11ed1f000 <dyld_stub_binder+0x11ed1f000>
1052a69f4: f9402100    	ldr	x0, [x8, #0x40]
1052a69f8: f00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a69fc: f9457101    	ldr	x1, [x8, #0xae0] ; selector: creatDataWithItem:EntranceScene:EntranceIndex:SearchText:
1052a6a00: b00be7a5    	adrp	x5, 0x11cf9b000 <dyld_stub_binder+0x11cf9b000>
1052a6a04: 913960a5    	add	x5, x5, #0xe58 ; CFString: 
1052a6a08: aa1803e2    	mov	x2, x24
1052a6a0c: 52800183    	mov	w3, #0xc                ; =12
1052a6a10: 52800004    	mov	w4, #0x0                ; =0
1052a6a14: 94a60494    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6a18: aa1d03fd    	mov	x29, x29
1052a6a1c: 94a60499    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6a20: f90013f8    	str	x24, [sp, #0x20]
1052a6a24: aa0003f8    	mov	x24, x0
1052a6a28: 900cd368    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1052a6a2c: f943c100    	ldr	x0, [x8, #0x780]
1052a6a30: aa1b03e1    	mov	x1, x27
1052a6a34: 94a6048c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6a38: aa1d03fd    	mov	x29, x29
1052a6a3c: 94a60491    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6a40: aa0003fb    	mov	x27, x0
1052a6a44: b00cd3c8    	adrp	x8, 0x11ed1f000 <dyld_stub_binder+0x11ed1f000>
1052a6a48: f9402500    	ldr	x0, [x8, #0x48]
1052a6a4c: aa1903e1    	mov	x1, x25
1052a6a50: 94a60485    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6a54: aa0003e2    	mov	x2, x0
1052a6a58: aa1b03e0    	mov	x0, x27
1052a6a5c: aa1c03e1    	mov	x1, x28
1052a6a60: 94a60481    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6a64: aa1d03fd    	mov	x29, x29
1052a6a68: 94a60486    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6a6c: aa0003f9    	mov	x25, x0
1052a6a70: f00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a6a74: f9457501    	ldr	x1, [x8, #0xae8] ; selector: setCurrentBrowseData:
1052a6a78: aa1803e2    	mov	x2, x24
1052a6a7c: 94a6047a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6a80: aa1903e0    	mov	x0, x25
1052a6a84: 94a6047b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a6a88: aa1b03e0    	mov	x0, x27
1052a6a8c: 94a60479    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a6a90: aa1803e0    	mov	x0, x24
1052a6a94: 94a60477    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a6a98: d10223a0    	sub	x0, x29, #0x88
1052a6a9c: 94a60470    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1052a6aa0: aa0003f8    	mov	x24, x0
1052a6aa4: f00cb948    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
1052a6aa8: f9405501    	ldr	x1, [x8, #0xa8] ; selector: setNavigationController:
1052a6aac: aa1a03e0    	mov	x0, x26
1052a6ab0: aa1803e2    	mov	x2, x24
1052a6ab4: 94a6046c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6ab8: aa1803e0    	mov	x0, x24
1052a6abc: 94a6046d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a6ac0: 910263e0    	add	x0, sp, #0x98
1052a6ac4: aa1403e1    	mov	x1, x20
1052a6ac8: 94a60464    	bl	0x107c27c58 <_Flutter_MMFoundation_BindContext+0x3eae924>
1052a6acc: d00c2538    	adrp	x24, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1052a6ad0: f9449b18    	ldr	x24, [x24, #0x930]
1052a6ad4: f9002ff8    	str	x24, [sp, #0x58]
1052a6ad8: b0093108    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
1052a6adc: fd434108    	ldr	d8, [x8, #0x680] ; constant double=1.6080749353e-314
1052a6ae0: b0000008    	adrp	x8, 0x1052a7000 <_Flutter_MMFoundation_BindContext+0x152dccc>
1052a6ae4: 911cb108    	add	x8, x8, #0x72c
1052a6ae8: fd0033e8    	str	d8, [sp, #0x60]
1052a6aec: 900b8009    	adrp	x9, 0x11c2a6000 <dyld_stub_binder+0x11c2a6000>
1052a6af0: 9110a129    	add	x9, x9, #0x428
1052a6af4: a906a7e8    	stp	x8, x9, [sp, #0x68]
1052a6af8: 910163f4    	add	x20, sp, #0x58
1052a6afc: 9100a280    	add	x0, x20, #0x28
1052a6b00: 910263e1    	add	x1, sp, #0x98
1052a6b04: 94a6044b    	bl	0x107c27c30 <_Flutter_MMFoundation_BindContext+0x3eae8fc>
1052a6b08: 9100c280    	add	x0, x20, #0x30
1052a6b0c: d10223a1    	sub	x1, x29, #0x88
1052a6b10: 94a60448    	bl	0x107c27c30 <_Flutter_MMFoundation_BindContext+0x3eae8fc>
1052a6b14: 9100e280    	add	x0, x20, #0x38
1052a6b18: d10243a1    	sub	x1, x29, #0x90
1052a6b1c: 94a60445    	bl	0x107c27c30 <_Flutter_MMFoundation_BindContext+0x3eae8fc>
1052a6b20: aa1703e0    	mov	x0, x23
1052a6b24: 94a60454    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1052a6b28: f9003ff7    	str	x23, [sp, #0x78]
1052a6b2c: d00cbd08    	adrp	x8, 0x11ea48000 <dyld_stub_binder+0x11ea48000>
1052a6b30: f9447d01    	ldr	x1, [x8, #0x8f8] ; selector: setShouldPush:
1052a6b34: 910163e2    	add	x2, sp, #0x58
1052a6b38: aa1a03e0    	mov	x0, x26
1052a6b3c: 94a6044a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6b40: f90017f8    	str	x24, [sp, #0x28]
1052a6b44: b0000008    	adrp	x8, 0x1052a7000 <_Flutter_MMFoundation_BindContext+0x152dccc>
1052a6b48: 91239108    	add	x8, x8, #0x8e4
1052a6b4c: fd001be8    	str	d8, [sp, #0x30]
1052a6b50: b00b7ee9    	adrp	x9, 0x11c283000 <dyld_stub_binder+0x11c283000>
1052a6b54: 91164129    	add	x9, x9, #0x590
1052a6b58: a903a7e8    	stp	x8, x9, [sp, #0x38]
1052a6b5c: 9100a3f8    	add	x24, sp, #0x28
1052a6b60: 9100a300    	add	x0, x24, #0x28
1052a6b64: 910263e1    	add	x1, sp, #0x98
1052a6b68: 94a60432    	bl	0x107c27c30 <_Flutter_MMFoundation_BindContext+0x3eae8fc>
1052a6b6c: aa1703e0    	mov	x0, x23
1052a6b70: 94a60441    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1052a6b74: f90027f7    	str	x23, [sp, #0x48]
1052a6b78: d00cbd08    	adrp	x8, 0x11ea48000 <dyld_stub_binder+0x11ea48000>
1052a6b7c: f9448101    	ldr	x1, [x8, #0x900] ; selector: setPushTransitionCompletion:
1052a6b80: 9100a3e2    	add	x2, sp, #0x28
1052a6b84: aa1a03e0    	mov	x0, x26
1052a6b88: 94a60437    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6b8c: 900cb9c8    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
1052a6b90: f9459501    	ldr	x1, [x8, #0xb28] ; selector: setEnPushType:
1052a6b94: aa1a03e0    	mov	x0, x26
1052a6b98: d2800002    	mov	x2, #0x0                ; =0
1052a6b9c: 94a60432    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6ba0: b00cd368    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1052a6ba4: f946bd00    	ldr	x0, [x8, #0xd78]
1052a6ba8: 900cb968    	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
1052a6bac: f9440501    	ldr	x1, [x8, #0x808] ; selector: openWeNoteViewController:
1052a6bb0: aa1a03e2    	mov	x2, x26
1052a6bb4: 94a6042c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6bb8: f94027e0    	ldr	x0, [sp, #0x48]
1052a6bbc: 94a6042d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a6bc0: 9100a300    	add	x0, x24, #0x28
1052a6bc4: f94013f8    	ldr	x24, [sp, #0x20]
1052a6bc8: 94a6041b    	bl	0x107c27c34 <_Flutter_MMFoundation_BindContext+0x3eae900>
1052a6bcc: f9403fe0    	ldr	x0, [sp, #0x78]
1052a6bd0: 94a60428    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a6bd4: 9100e280    	add	x0, x20, #0x38
1052a6bd8: 94a60417    	bl	0x107c27c34 <_Flutter_MMFoundation_BindContext+0x3eae900>
1052a6bdc: 9100c280    	add	x0, x20, #0x30
1052a6be0: 94a60415    	bl	0x107c27c34 <_Flutter_MMFoundation_BindContext+0x3eae900>
1052a6be4: 9100a280    	add	x0, x20, #0x28
1052a6be8: 94a60413    	bl	0x107c27c34 <_Flutter_MMFoundation_BindContext+0x3eae900>
1052a6bec: 910263e0    	add	x0, sp, #0x98
1052a6bf0: 94a60411    	bl	0x107c27c34 <_Flutter_MMFoundation_BindContext+0x3eae900>
1052a6bf4: aa1a03e0    	mov	x0, x26
1052a6bf8: 94a6041e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a6bfc: 140000a7    	b	0x1052a6e98 <_Flutter_MMFoundation_BindContext+0x152db64>
1052a6c00: 900cd768    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
1052a6c04: 9135f108    	add	x8, x8, #0xd7c
1052a6c08: b9800108    	ldrsw	x8, [x8] ; ivar: FavBaseListViewController.m_dataController offset=200
1052a6c0c: f8686a95    	ldr	x21, [x20, x8]
1052a6c10: d00cb928    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1052a6c14: f9427516    	ldr	x22, [x8, #0x4e8] ; selector: section
1052a6c18: aa1303e0    	mov	x0, x19
1052a6c1c: aa1603e1    	mov	x1, x22
1052a6c20: 94a60411    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6c24: aa0003e2    	mov	x2, x0
1052a6c28: f00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a6c2c: f9478d01    	ldr	x1, [x8, #0xf18] ; selector: dataAtIndex:
1052a6c30: aa1503e0    	mov	x0, x21
1052a6c34: 94a6040c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6c38: aa1d03fd    	mov	x29, x29
1052a6c3c: 94a60411    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6c40: aa0003f5    	mov	x21, x0
1052a6c44: b00cd3c8    	adrp	x8, 0x11ed1f000 <dyld_stub_binder+0x11ed1f000>
1052a6c48: f9407900    	ldr	x0, [x8, #0xf0]
1052a6c4c: 900cd008    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1052a6c50: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
1052a6c54: 94a60404    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6c58: aa0003e2    	mov	x2, x0
1052a6c5c: d00cd008    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1052a6c60: f9444901    	ldr	x1, [x8, #0x890] ; selector: isKindOfClass:
1052a6c64: aa1503e0    	mov	x0, x21
1052a6c68: 94a603ff    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6c6c: 34001e40    	cbz	w0, 0x1052a7034 <_Flutter_MMFoundation_BindContext+0x152dd00>
1052a6c70: d00cb9a8    	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
1052a6c74: f942cd01    	ldr	x1, [x8, #0x598] ; selector: parent
1052a6c78: aa1503e0    	mov	x0, x21
1052a6c7c: 94a603fa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6c80: aa1d03fd    	mov	x29, x29
1052a6c84: 94a603ff    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6c88: aa0003f7    	mov	x23, x0
1052a6c8c: f00cb928    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
1052a6c90: f9440d01    	ldr	x1, [x8, #0x818] ; selector: dataItem
1052a6c94: aa1503e0    	mov	x0, x21
1052a6c98: 94a603f3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6c9c: aa1d03fd    	mov	x29, x29
1052a6ca0: 94a603f8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6ca4: aa0003f8    	mov	x24, x0
1052a6ca8: f00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a6cac: f946f501    	ldr	x1, [x8, #0xde8] ; selector: entranceScene
1052a6cb0: aa1403e0    	mov	x0, x20
1052a6cb4: 94a603ec    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6cb8: aa0003f9    	mov	x25, x0
1052a6cbc: aa1303e0    	mov	x0, x19
1052a6cc0: aa1603e1    	mov	x1, x22
1052a6cc4: 94a603e8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6cc8: 900cbd08    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a6ccc: f943f501    	ldr	x1, [x8, #0x7e8] ; selector: onShowFavContext:DataItem:NeedReport:FromScene:FavIndex:SearchText:
1052a6cd0: b00be7a7    	adrp	x7, 0x11cf9b000 <dyld_stub_binder+0x11cf9b000>
1052a6cd4: 913960e7    	add	x7, x7, #0xe58 ; CFString: 
1052a6cd8: 11000406    	add	w6, w0, #0x1
1052a6cdc: aa1403e0    	mov	x0, x20
1052a6ce0: aa1703e2    	mov	x2, x23
1052a6ce4: aa1803e3    	mov	x3, x24
1052a6ce8: 52800024    	mov	w4, #0x1                ; =1
1052a6cec: aa1903e5    	mov	x5, x25
1052a6cf0: 94a603dd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6cf4: aa1803e0    	mov	x0, x24
1052a6cf8: 94a603de    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a6cfc: aa1703e0    	mov	x0, x23
1052a6d00: 140000cc    	b	0x1052a7030 <_Flutter_MMFoundation_BindContext+0x152dcfc>
1052a6d04: d00cb928    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1052a6d08: f9427501    	ldr	x1, [x8, #0x4e8] ; selector: section
1052a6d0c: aa1303e0    	mov	x0, x19
1052a6d10: 94a603d5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6d14: aa0003e2    	mov	x2, x0
1052a6d18: 900cd768    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
1052a6d1c: 9135f108    	add	x8, x8, #0xd7c
1052a6d20: b9800108    	ldrsw	x8, [x8] ; ivar: FavBaseListViewController.m_dataController offset=200
1052a6d24: f8686a80    	ldr	x0, [x20, x8]
1052a6d28: f00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a6d2c: f9478d01    	ldr	x1, [x8, #0xf18] ; selector: dataAtIndex:
1052a6d30: 94a603cd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6d34: aa1d03fd    	mov	x29, x29
1052a6d38: 94a603d2    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6d3c: aa0003f5    	mov	x21, x0
1052a6d40: b00cd3c8    	adrp	x8, 0x11ed1f000 <dyld_stub_binder+0x11ed1f000>
1052a6d44: f9407900    	ldr	x0, [x8, #0xf0]
1052a6d48: 900cd008    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1052a6d4c: f9428517    	ldr	x23, [x8, #0x508] ; selector: class
1052a6d50: aa1703e1    	mov	x1, x23
1052a6d54: 94a603c4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6d58: aa0003e2    	mov	x2, x0
1052a6d5c: d00cd008    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1052a6d60: f9444901    	ldr	x1, [x8, #0x890] ; selector: isKindOfClass:
1052a6d64: aa1503e0    	mov	x0, x21
1052a6d68: 94a603bf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6d6c: 34000a80    	cbz	w0, 0x1052a6ebc <_Flutter_MMFoundation_BindContext+0x152db88>
1052a6d70: d00cb9a8    	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
1052a6d74: f942cd01    	ldr	x1, [x8, #0x598] ; selector: parent
1052a6d78: aa1503e0    	mov	x0, x21
1052a6d7c: 94a603ba    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6d80: aa1d03fd    	mov	x29, x29
1052a6d84: 94a603bf    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6d88: aa0003f6    	mov	x22, x0
1052a6d8c: 1400004f    	b	0x1052a6ec8 <_Flutter_MMFoundation_BindContext+0x152db94>
1052a6d90: d00cb928    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1052a6d94: f9427501    	ldr	x1, [x8, #0x4e8] ; selector: section
1052a6d98: aa1303e0    	mov	x0, x19
1052a6d9c: 94a603b2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6da0: aa0003e2    	mov	x2, x0
1052a6da4: 900cd768    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
1052a6da8: 9135f108    	add	x8, x8, #0xd7c
1052a6dac: b9800108    	ldrsw	x8, [x8] ; ivar: FavBaseListViewController.m_dataController offset=200
1052a6db0: f8686a80    	ldr	x0, [x20, x8]
1052a6db4: f00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a6db8: f9478d01    	ldr	x1, [x8, #0xf18] ; selector: dataAtIndex:
1052a6dbc: 94a603aa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6dc0: aa1d03fd    	mov	x29, x29
1052a6dc4: 94a603af    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6dc8: aa0003f4    	mov	x20, x0
1052a6dcc: b00cd368    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1052a6dd0: f944dd00    	ldr	x0, [x8, #0x9b8]
1052a6dd4: 900cd008    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1052a6dd8: f9428515    	ldr	x21, [x8, #0x508] ; selector: class
1052a6ddc: aa1503e1    	mov	x1, x21
1052a6de0: 94a603a1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6de4: aa0003e2    	mov	x2, x0
1052a6de8: d00cd008    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1052a6dec: f9444916    	ldr	x22, [x8, #0x890] ; selector: isKindOfClass:
1052a6df0: aa1403e0    	mov	x0, x20
1052a6df4: aa1603e1    	mov	x1, x22
1052a6df8: 94a6039b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6dfc: 34001820    	cbz	w0, 0x1052a7100 <_Flutter_MMFoundation_BindContext+0x152ddcc>
1052a6e00: aa1403e0    	mov	x0, x20
1052a6e04: 94a6039c    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1052a6e08: aa1403f6    	mov	x22, x20
1052a6e0c: 14000100    	b	0x1052a720c <_Flutter_MMFoundation_BindContext+0x152ded8>
1052a6e10: f00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a6e14: f9464d01    	ldr	x1, [x8, #0xc98] ; selector: finishLongPressNoteConversionSnapshot:completed:
1052a6e18: aa1403e0    	mov	x0, x20
1052a6e1c: aa1703e2    	mov	x2, x23
1052a6e20: 52800003    	mov	w3, #0x0                ; =0
1052a6e24: 94a60390    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6e28: 900cd368    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1052a6e2c: f9430d14    	ldr	x20, [x8, #0x618]
1052a6e30: f00cb968    	adrp	x8, 0x11e9d5000 <dyld_stub_binder+0x11e9d5000>
1052a6e34: f946e101    	ldr	x1, [x8, #0xdc0] ; selector: localId
1052a6e38: aa1603e0    	mov	x0, x22
1052a6e3c: 94a6038a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6e40: aa0003f9    	mov	x25, x0
1052a6e44: f00cd028    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1052a6e48: f9450101    	ldr	x1, [x8, #0xa00] ; selector: type
1052a6e4c: aa1603e0    	mov	x0, x22
1052a6e50: 94a60385    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6e54: f00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a6e58: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
1052a6e5c: a90083f9    	stp	x25, x0, [sp, #0x8]
1052a6e60: 900bf088    	adrp	x8, 0x11d0b6000 <dyld_stub_binder+0x11d0b6000>
1052a6e64: 9128e108    	add	x8, x8, #0xa38 ; CFString: convert favorite to note failed, localId:%u, type:%u
1052a6e68: f90003e8    	str	x8, [sp]
1052a6e6c: f00a5783    	adrp	x3, 0x119d99000 <dyld_stub_binder+0x119d99000>
1052a6e70: 91225863    	add	x3, x3, #0x896
1052a6e74: f00a7ac5    	adrp	x5, 0x11a201000 <dyld_stub_binder+0x11a201000>
1052a6e78: 912d64a5    	add	x5, x5, #0xb59
1052a6e7c: 900a7ae7    	adrp	x7, 0x11a202000 <dyld_stub_binder+0x11a202000>
1052a6e80: 911bc0e7    	add	x7, x7, #0x6f0
1052a6e84: aa1403e0    	mov	x0, x20
1052a6e88: 52800082    	mov	w2, #0x4                ; =4
1052a6e8c: 52800004    	mov	w4, #0x0                ; =0
1052a6e90: 52816b26    	mov	w6, #0xb59              ; =2905
1052a6e94: 94a60374    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6e98: aa1803e0    	mov	x0, x24
1052a6e9c: 94a60375    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a6ea0: aa1703e0    	mov	x0, x23
1052a6ea4: 94a60373    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a6ea8: d10243a0    	sub	x0, x29, #0x90
1052a6eac: 94a60362    	bl	0x107c27c34 <_Flutter_MMFoundation_BindContext+0x3eae900>
1052a6eb0: d10223a0    	sub	x0, x29, #0x88
1052a6eb4: 94a60360    	bl	0x107c27c34 <_Flutter_MMFoundation_BindContext+0x3eae900>
1052a6eb8: 1400005d    	b	0x1052a702c <_Flutter_MMFoundation_BindContext+0x152dcf8>
1052a6ebc: aa1503e0    	mov	x0, x21
1052a6ec0: 94a6036d    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1052a6ec4: aa1503f6    	mov	x22, x21
1052a6ec8: 900cd368    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1052a6ecc: f943c100    	ldr	x0, [x8, #0x780]
1052a6ed0: f00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a6ed4: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
1052a6ed8: 94a60363    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6edc: aa1d03fd    	mov	x29, x29
1052a6ee0: 94a60368    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6ee4: aa0003f8    	mov	x24, x0
1052a6ee8: b00cd368    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1052a6eec: f9448500    	ldr	x0, [x8, #0x908]
1052a6ef0: aa1703e1    	mov	x1, x23
1052a6ef4: 94a6035c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6ef8: aa0003e2    	mov	x2, x0
1052a6efc: f00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a6f00: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
1052a6f04: aa1803e0    	mov	x0, x24
1052a6f08: 94a60357    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6f0c: aa1d03fd    	mov	x29, x29
1052a6f10: 94a6035c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6f14: aa0003f7    	mov	x23, x0
1052a6f18: 900cbd08    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a6f1c: f943b901    	ldr	x1, [x8, #0x770] ; selector: reportViewClick:itemOrDataWrap:
1052a6f20: 52800062    	mov	w2, #0x3                ; =3
1052a6f24: aa1503e3    	mov	x3, x21
1052a6f28: 94a6034f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6f2c: aa1703e0    	mov	x0, x23
1052a6f30: 94a60350    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a6f34: aa1803e0    	mov	x0, x24
1052a6f38: 94a6034e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a6f3c: 900cd3c8    	adrp	x8, 0x11ed1e000 <dyld_stub_binder+0x11ed1e000>
1052a6f40: f947d500    	ldr	x0, [x8, #0xfa8]
1052a6f44: 94a60331    	bl	0x107c27c08 <_Flutter_MMFoundation_BindContext+0x3eae8d4>
1052a6f48: aa0003f7    	mov	x23, x0
1052a6f4c: f81803b6    	stur	x22, [x29, #-0x80]
1052a6f50: 900cd368    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1052a6f54: f9434500    	ldr	x0, [x8, #0x688]
1052a6f58: f00ccfe8    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
1052a6f5c: f946e101    	ldr	x1, [x8, #0xdc0] ; selector: arrayWithObjects:count:
1052a6f60: d10203a2    	sub	x2, x29, #0x80
1052a6f64: 52800023    	mov	w3, #0x1                ; =1
1052a6f68: 94a6033f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6f6c: aa1d03fd    	mov	x29, x29
1052a6f70: 94a60344    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a6f74: aa0003f8    	mov	x24, x0
1052a6f78: 900cbd08    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a6f7c: f9437501    	ldr	x1, [x8, #0x6e8] ; selector: initWithFavItems:
1052a6f80: aa1703e0    	mov	x0, x23
1052a6f84: aa1803e2    	mov	x2, x24
1052a6f88: 94a60337    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6f8c: aa0003f7    	mov	x23, x0
1052a6f90: aa1803e0    	mov	x0, x24
1052a6f94: 94a60337    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a6f98: f00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a6f9c: f945b501    	ldr	x1, [x8, #0xb68] ; selector: setM_delegate:
1052a6fa0: aa1703e0    	mov	x0, x23
1052a6fa4: aa1403e2    	mov	x2, x20
1052a6fa8: 94a6032f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6fac: f00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a6fb0: f9433901    	ldr	x1, [x8, #0x670] ; selector: setM_editSource:
1052a6fb4: aa1703e0    	mov	x0, x23
1052a6fb8: 52800102    	mov	w2, #0x8                ; =8
1052a6fbc: 94a6032a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6fc0: d00cc468    	adrp	x8, 0x11eb34000 <dyld_stub_binder+0x11eb34000>
1052a6fc4: f944c901    	ldr	x1, [x8, #0x990] ; selector: getListPageType
1052a6fc8: aa1403e0    	mov	x0, x20
1052a6fcc: 94a60326    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6fd0: aa0003e2    	mov	x2, x0
1052a6fd4: f00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a6fd8: f9433d01    	ldr	x1, [x8, #0x678] ; selector: setEditSourcePage:
1052a6fdc: aa1703e0    	mov	x0, x23
1052a6fe0: 94a60321    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a6fe4: 900cd368    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1052a6fe8: f945b500    	ldr	x0, [x8, #0xb68]
1052a6fec: 94a60307    	bl	0x107c27c08 <_Flutter_MMFoundation_BindContext+0x3eae8d4>
1052a6ff0: d00cd008    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1052a6ff4: f9423501    	ldr	x1, [x8, #0x468] ; selector: initWithRootViewController:
1052a6ff8: aa1703e2    	mov	x2, x23
1052a6ffc: 94a6031a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7000: aa0003f8    	mov	x24, x0
1052a7004: 900cb928    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1052a7008: f9459501    	ldr	x1, [x8, #0xb28] ; selector: PresentModalViewController:animated:
1052a700c: aa1403e0    	mov	x0, x20
1052a7010: aa1803e2    	mov	x2, x24
1052a7014: 52800023    	mov	w3, #0x1                ; =1
1052a7018: 94a60313    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a701c: aa1803e0    	mov	x0, x24
1052a7020: 94a60314    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a7024: aa1703e0    	mov	x0, x23
1052a7028: 94a60312    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a702c: aa1603e0    	mov	x0, x22
1052a7030: 94a60310    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a7034: aa1503e0    	mov	x0, x21
1052a7038: 94a6030e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a703c: aa1303e0    	mov	x0, x19
1052a7040: 94a6030c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a7044: f85903a8    	ldur	x8, [x29, #-0x70]
1052a7048: b00c2529    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1052a704c: f9451929    	ldr	x9, [x9, #0xa30]
1052a7050: f9400129    	ldr	x9, [x9]
1052a7054: eb08013f    	cmp	x9, x8
1052a7058: 54003681    	b.ne	0x1052a7728 <_Flutter_MMFoundation_BindContext+0x152e3f4>
1052a705c: a9537bfd    	ldp	x29, x30, [sp, #0x130]
1052a7060: a9524ff4    	ldp	x20, x19, [sp, #0x120]
1052a7064: a95157f6    	ldp	x22, x21, [sp, #0x110]
1052a7068: a9505ff8    	ldp	x24, x23, [sp, #0x100]
1052a706c: a94f67fa    	ldp	x26, x25, [sp, #0xf0]
1052a7070: a94e6ffc    	ldp	x28, x27, [sp, #0xe0]
1052a7074: 6d4d23e9    	ldp	d9, d8, [sp, #0xd0]
1052a7078: 910503ff    	add	sp, sp, #0x140
1052a707c: d65f03c0    	ret
1052a7080: b00cb928    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1052a7084: f9427501    	ldr	x1, [x8, #0x4e8] ; selector: section
1052a7088: aa1303e0    	mov	x0, x19
1052a708c: 94a602f6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7090: aa0003e2    	mov	x2, x0
1052a7094: f00cd748    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
1052a7098: 9135f108    	add	x8, x8, #0xd7c
1052a709c: b9800108    	ldrsw	x8, [x8] ; ivar: FavBaseListViewController.m_dataController offset=200
1052a70a0: f8686a80    	ldr	x0, [x20, x8]
1052a70a4: d00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a70a8: f9478d01    	ldr	x1, [x8, #0xf18] ; selector: dataAtIndex:
1052a70ac: 94a602ee    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a70b0: aa1d03fd    	mov	x29, x29
1052a70b4: 94a602f3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a70b8: aa0003f4    	mov	x20, x0
1052a70bc: 900cd368    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1052a70c0: f944dd00    	ldr	x0, [x8, #0x9b8]
1052a70c4: f00ccfe8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1052a70c8: f9428515    	ldr	x21, [x8, #0x508] ; selector: class
1052a70cc: aa1503e1    	mov	x1, x21
1052a70d0: 94a602e5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a70d4: aa0003e2    	mov	x2, x0
1052a70d8: b00cd008    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1052a70dc: f9444916    	ldr	x22, [x8, #0x890] ; selector: isKindOfClass:
1052a70e0: aa1403e0    	mov	x0, x20
1052a70e4: aa1603e1    	mov	x1, x22
1052a70e8: 94a602df    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a70ec: 340006c0    	cbz	w0, 0x1052a71c4 <_Flutter_MMFoundation_BindContext+0x152de90>
1052a70f0: aa1403e0    	mov	x0, x20
1052a70f4: 94a602e0    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1052a70f8: aa1403f6    	mov	x22, x20
1052a70fc: 140000cd    	b	0x1052a7430 <_Flutter_MMFoundation_BindContext+0x152e0fc>
1052a7100: 900cd3c8    	adrp	x8, 0x11ed1f000 <dyld_stub_binder+0x11ed1f000>
1052a7104: f9407900    	ldr	x0, [x8, #0xf0]
1052a7108: aa1503e1    	mov	x1, x21
1052a710c: 94a602d6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7110: aa0003e2    	mov	x2, x0
1052a7114: aa1403e0    	mov	x0, x20
1052a7118: aa1603e1    	mov	x1, x22
1052a711c: 94a602d2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7120: 34000740    	cbz	w0, 0x1052a7208 <_Flutter_MMFoundation_BindContext+0x152ded4>
1052a7124: b00cb9a8    	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
1052a7128: f942cd01    	ldr	x1, [x8, #0x598] ; selector: parent
1052a712c: aa1403e0    	mov	x0, x20
1052a7130: 94a602cd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7134: aa1d03fd    	mov	x29, x29
1052a7138: 94a602d2    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a713c: aa0003f6    	mov	x22, x0
1052a7140: 14000033    	b	0x1052a720c <_Flutter_MMFoundation_BindContext+0x152ded8>
1052a7144: b00cb928    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1052a7148: f9427501    	ldr	x1, [x8, #0x4e8] ; selector: section
1052a714c: aa1303e0    	mov	x0, x19
1052a7150: 94a602c5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7154: aa0003e2    	mov	x2, x0
1052a7158: f00cd748    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
1052a715c: 9135f108    	add	x8, x8, #0xd7c
1052a7160: b9800108    	ldrsw	x8, [x8] ; ivar: FavBaseListViewController.m_dataController offset=200
1052a7164: f8686a80    	ldr	x0, [x20, x8]
1052a7168: d00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a716c: f9478d01    	ldr	x1, [x8, #0xf18] ; selector: dataAtIndex:
1052a7170: 94a602bd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7174: aa1d03fd    	mov	x29, x29
1052a7178: 94a602c2    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a717c: aa0003f4    	mov	x20, x0
1052a7180: 900cd368    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1052a7184: f944dd00    	ldr	x0, [x8, #0x9b8]
1052a7188: f00ccfe8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1052a718c: f9428515    	ldr	x21, [x8, #0x508] ; selector: class
1052a7190: aa1503e1    	mov	x1, x21
1052a7194: 94a602b4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7198: aa0003e2    	mov	x2, x0
1052a719c: b00cd008    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1052a71a0: f9444916    	ldr	x22, [x8, #0x890] ; selector: isKindOfClass:
1052a71a4: aa1403e0    	mov	x0, x20
1052a71a8: aa1603e1    	mov	x1, x22
1052a71ac: 94a602ae    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a71b0: 34000920    	cbz	w0, 0x1052a72d4 <_Flutter_MMFoundation_BindContext+0x152dfa0>
1052a71b4: aa1403e0    	mov	x0, x20
1052a71b8: 94a602af    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1052a71bc: aa1403f6    	mov	x22, x20
1052a71c0: 14000055    	b	0x1052a7314 <_Flutter_MMFoundation_BindContext+0x152dfe0>
1052a71c4: 900cd3c8    	adrp	x8, 0x11ed1f000 <dyld_stub_binder+0x11ed1f000>
1052a71c8: f9407900    	ldr	x0, [x8, #0xf0]
1052a71cc: aa1503e1    	mov	x1, x21
1052a71d0: 94a602a5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a71d4: aa0003e2    	mov	x2, x0
1052a71d8: aa1403e0    	mov	x0, x20
1052a71dc: aa1603e1    	mov	x1, x22
1052a71e0: 94a602a1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a71e4: 34001240    	cbz	w0, 0x1052a742c <_Flutter_MMFoundation_BindContext+0x152e0f8>
1052a71e8: b00cb9a8    	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
1052a71ec: f942cd01    	ldr	x1, [x8, #0x598] ; selector: parent
1052a71f0: aa1403e0    	mov	x0, x20
1052a71f4: 94a6029c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a71f8: aa1d03fd    	mov	x29, x29
1052a71fc: 94a602a1    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a7200: aa0003f6    	mov	x22, x0
1052a7204: 1400008b    	b	0x1052a7430 <_Flutter_MMFoundation_BindContext+0x152e0fc>
1052a7208: d2800016    	mov	x22, #0x0               ; =0
1052a720c: f00cd35b    	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1052a7210: f943c360    	ldr	x0, [x27, #0x780]
1052a7214: d00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a7218: f9440117    	ldr	x23, [x8, #0x800] ; selector: currentContext
1052a721c: aa1703e1    	mov	x1, x23
1052a7220: 94a60291    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7224: aa1d03fd    	mov	x29, x29
1052a7228: 94a60296    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a722c: aa0003f8    	mov	x24, x0
1052a7230: 900cd37c    	adrp	x28, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1052a7234: f9448780    	ldr	x0, [x28, #0x908]
1052a7238: aa1503e1    	mov	x1, x21
1052a723c: 94a6028a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7240: aa0003e2    	mov	x2, x0
1052a7244: d00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a7248: f9452119    	ldr	x25, [x8, #0xa40] ; selector: getService:
1052a724c: aa1803e0    	mov	x0, x24
1052a7250: aa1903e1    	mov	x1, x25
1052a7254: 94a60284    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7258: aa1d03fd    	mov	x29, x29
1052a725c: 94a60289    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a7260: aa0003fa    	mov	x26, x0
1052a7264: f00cbce8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a7268: f943b901    	ldr	x1, [x8, #0x770] ; selector: reportViewClick:itemOrDataWrap:
1052a726c: 52800142    	mov	w2, #0xa                ; =10
1052a7270: aa1403e3    	mov	x3, x20
1052a7274: 94a6027c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7278: aa1a03e0    	mov	x0, x26
1052a727c: 94a6027d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a7280: aa1803e0    	mov	x0, x24
1052a7284: 94a6027b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a7288: f943c360    	ldr	x0, [x27, #0x780]
1052a728c: aa1703e1    	mov	x1, x23
1052a7290: 94a60275    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7294: aa1d03fd    	mov	x29, x29
1052a7298: 94a6027a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a729c: aa0003f7    	mov	x23, x0
1052a72a0: f9448780    	ldr	x0, [x28, #0x908]
1052a72a4: aa1503e1    	mov	x1, x21
1052a72a8: 94a6026f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a72ac: aa0003e2    	mov	x2, x0
1052a72b0: aa1703e0    	mov	x0, x23
1052a72b4: aa1903e1    	mov	x1, x25
1052a72b8: 94a6026b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a72bc: aa1d03fd    	mov	x29, x29
1052a72c0: 94a60270    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a72c4: aa0003f5    	mov	x21, x0
1052a72c8: f00cbce8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a72cc: f943c901    	ldr	x1, [x8, #0x790] ; selector: pinTopFavoritesItem:
1052a72d0: 14000089    	b	0x1052a74f4 <_Flutter_MMFoundation_BindContext+0x152e1c0>
1052a72d4: 900cd3c8    	adrp	x8, 0x11ed1f000 <dyld_stub_binder+0x11ed1f000>
1052a72d8: f9407900    	ldr	x0, [x8, #0xf0]
1052a72dc: aa1503e1    	mov	x1, x21
1052a72e0: 94a60261    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a72e4: aa0003e2    	mov	x2, x0
1052a72e8: aa1403e0    	mov	x0, x20
1052a72ec: aa1603e1    	mov	x1, x22
1052a72f0: 94a6025d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a72f4: 34002100    	cbz	w0, 0x1052a7714 <_Flutter_MMFoundation_BindContext+0x152e3e0>
1052a72f8: b00cb9a8    	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
1052a72fc: f942cd01    	ldr	x1, [x8, #0x598] ; selector: parent
1052a7300: aa1403e0    	mov	x0, x20
1052a7304: 94a60258    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7308: aa1d03fd    	mov	x29, x29
1052a730c: 94a6025d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a7310: aa0003f6    	mov	x22, x0
1052a7314: b4000fd6    	cbz	x22, 0x1052a750c <_Flutter_MMFoundation_BindContext+0x152e1d8>
1052a7318: f00cba48    	adrp	x8, 0x11e9f2000 <dyld_stub_binder+0x11e9f2000>
1052a731c: f945ed01    	ldr	x1, [x8, #0xbd8] ; selector: favId
1052a7320: aa1603e0    	mov	x0, x22
1052a7324: 94a60250    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7328: 34000f20    	cbz	w0, 0x1052a750c <_Flutter_MMFoundation_BindContext+0x152e1d8>
1052a732c: f00cd35b    	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1052a7330: f943c360    	ldr	x0, [x27, #0x780]
1052a7334: d00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a7338: f9440117    	ldr	x23, [x8, #0x800] ; selector: currentContext
1052a733c: aa1703e1    	mov	x1, x23
1052a7340: 94a60249    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7344: aa1d03fd    	mov	x29, x29
1052a7348: 94a6024e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a734c: aa0003f8    	mov	x24, x0
1052a7350: 900cd368    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1052a7354: f9448500    	ldr	x0, [x8, #0x908]
1052a7358: aa1503e1    	mov	x1, x21
1052a735c: 94a60242    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7360: aa0003e2    	mov	x2, x0
1052a7364: d00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a7368: f9452119    	ldr	x25, [x8, #0xa40] ; selector: getService:
1052a736c: aa1803e0    	mov	x0, x24
1052a7370: aa1903e1    	mov	x1, x25
1052a7374: 94a6023c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7378: aa1d03fd    	mov	x29, x29
1052a737c: 94a60241    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a7380: aa0003fa    	mov	x26, x0
1052a7384: f00cbce8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a7388: f943b901    	ldr	x1, [x8, #0x770] ; selector: reportViewClick:itemOrDataWrap:
1052a738c: 528001c2    	mov	w2, #0xe                ; =14
1052a7390: aa1403e3    	mov	x3, x20
1052a7394: 94a60234    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7398: aa1a03e0    	mov	x0, x26
1052a739c: 94a60235    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a73a0: aa1803e0    	mov	x0, x24
1052a73a4: 94a60233    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a73a8: f943c360    	ldr	x0, [x27, #0x780]
1052a73ac: aa1703e1    	mov	x1, x23
1052a73b0: 94a6022d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a73b4: aa1d03fd    	mov	x29, x29
1052a73b8: 94a60232    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a73bc: aa0003f7    	mov	x23, x0
1052a73c0: 900cd3c8    	adrp	x8, 0x11ed1f000 <dyld_stub_binder+0x11ed1f000>
1052a73c4: f9409900    	ldr	x0, [x8, #0x130]
1052a73c8: aa1503e1    	mov	x1, x21
1052a73cc: 94a60226    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a73d0: aa0003e2    	mov	x2, x0
1052a73d4: aa1703e0    	mov	x0, x23
1052a73d8: aa1903e1    	mov	x1, x25
1052a73dc: 94a60222    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a73e0: aa1d03fd    	mov	x29, x29
1052a73e4: 94a60227    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a73e8: aa0003f5    	mov	x21, x0
1052a73ec: f00cbce8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a73f0: f943fd01    	ldr	x1, [x8, #0x7f8] ; selector: starFavItem:completion:
1052a73f4: aa1603e2    	mov	x2, x22
1052a73f8: d2800003    	mov	x3, #0x0                ; =0
1052a73fc: 94a6021a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7400: aa1503e0    	mov	x0, x21
1052a7404: 94a6021b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a7408: aa1703e0    	mov	x0, x23
1052a740c: 94a60219    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a7410: f00cd388    	adrp	x8, 0x11ed1a000 <dyld_stub_binder+0x11ed1a000>
1052a7414: f9413d00    	ldr	x0, [x8, #0x278]
1052a7418: f00cbce8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a741c: f9440101    	ldr	x1, [x8, #0x800] ; selector: silentlyAddStarFromFavoritesItem:
1052a7420: aa1603e2    	mov	x2, x22
1052a7424: 94a60210    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7428: 14000039    	b	0x1052a750c <_Flutter_MMFoundation_BindContext+0x152e1d8>
1052a742c: d2800016    	mov	x22, #0x0               ; =0
1052a7430: f00cd35b    	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1052a7434: f943c360    	ldr	x0, [x27, #0x780]
1052a7438: d00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a743c: f9440117    	ldr	x23, [x8, #0x800] ; selector: currentContext
1052a7440: aa1703e1    	mov	x1, x23
1052a7444: 94a60208    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7448: aa1d03fd    	mov	x29, x29
1052a744c: 94a6020d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a7450: aa0003f8    	mov	x24, x0
1052a7454: 900cd37c    	adrp	x28, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1052a7458: f9448780    	ldr	x0, [x28, #0x908]
1052a745c: aa1503e1    	mov	x1, x21
1052a7460: 94a60201    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7464: aa0003e2    	mov	x2, x0
1052a7468: d00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a746c: f9452119    	ldr	x25, [x8, #0xa40] ; selector: getService:
1052a7470: aa1803e0    	mov	x0, x24
1052a7474: aa1903e1    	mov	x1, x25
1052a7478: 94a601fb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a747c: aa1d03fd    	mov	x29, x29
1052a7480: 94a60200    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a7484: aa0003fa    	mov	x26, x0
1052a7488: f00cbce8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a748c: f943b901    	ldr	x1, [x8, #0x770] ; selector: reportViewClick:itemOrDataWrap:
1052a7490: 52800182    	mov	w2, #0xc                ; =12
1052a7494: aa1403e3    	mov	x3, x20
1052a7498: 94a601f3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a749c: aa1a03e0    	mov	x0, x26
1052a74a0: 94a601f4    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a74a4: aa1803e0    	mov	x0, x24
1052a74a8: 94a601f2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a74ac: f943c360    	ldr	x0, [x27, #0x780]
1052a74b0: aa1703e1    	mov	x1, x23
1052a74b4: 94a601ec    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a74b8: aa1d03fd    	mov	x29, x29
1052a74bc: 94a601f1    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a74c0: aa0003f7    	mov	x23, x0
1052a74c4: f9448780    	ldr	x0, [x28, #0x908]
1052a74c8: aa1503e1    	mov	x1, x21
1052a74cc: 94a601e6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a74d0: aa0003e2    	mov	x2, x0
1052a74d4: aa1703e0    	mov	x0, x23
1052a74d8: aa1903e1    	mov	x1, x25
1052a74dc: 94a601e2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a74e0: aa1d03fd    	mov	x29, x29
1052a74e4: 94a601e7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a74e8: aa0003f5    	mov	x21, x0
1052a74ec: f00cbce8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a74f0: f943c501    	ldr	x1, [x8, #0x788] ; selector: cancelPinTopFavoritesItem:
1052a74f4: aa1603e2    	mov	x2, x22
1052a74f8: 94a601db    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a74fc: aa1503e0    	mov	x0, x21
1052a7500: 94a601dc    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a7504: aa1703e0    	mov	x0, x23
1052a7508: 94a601da    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a750c: aa1603e0    	mov	x0, x22
1052a7510: 94a601d8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a7514: aa1403e0    	mov	x0, x20
1052a7518: 17fffec8    	b	0x1052a7038 <_Flutter_MMFoundation_BindContext+0x152dd04>
1052a751c: 900cd3c8    	adrp	x8, 0x11ed1f000 <dyld_stub_binder+0x11ed1f000>
1052a7520: f9407900    	ldr	x0, [x8, #0xf0]
1052a7524: aa1603e1    	mov	x1, x22
1052a7528: 94a601cf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a752c: aa0003e2    	mov	x2, x0
1052a7530: aa1403e0    	mov	x0, x20
1052a7534: aa1503e1    	mov	x1, x21
1052a7538: 94a601cb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a753c: 34000f00    	cbz	w0, 0x1052a771c <_Flutter_MMFoundation_BindContext+0x152e3e8>
1052a7540: b00cb9a8    	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
1052a7544: f942cd01    	ldr	x1, [x8, #0x598] ; selector: parent
1052a7548: aa1403e0    	mov	x0, x20
1052a754c: 94a601c6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7550: aa1d03fd    	mov	x29, x29
1052a7554: 94a601cb    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a7558: aa0003f5    	mov	x21, x0
1052a755c: b4000e35    	cbz	x21, 0x1052a7720 <_Flutter_MMFoundation_BindContext+0x152e3ec>
1052a7560: f00cba48    	adrp	x8, 0x11e9f2000 <dyld_stub_binder+0x11e9f2000>
1052a7564: f945ed01    	ldr	x1, [x8, #0xbd8] ; selector: favId
1052a7568: aa1503e0    	mov	x0, x21
1052a756c: 94a601be    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7570: 34000d80    	cbz	w0, 0x1052a7720 <_Flutter_MMFoundation_BindContext+0x152e3ec>
1052a7574: f00cd35b    	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1052a7578: f943c360    	ldr	x0, [x27, #0x780]
1052a757c: d00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a7580: f9440117    	ldr	x23, [x8, #0x800] ; selector: currentContext
1052a7584: aa1703e1    	mov	x1, x23
1052a7588: 94a601b7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a758c: aa1d03fd    	mov	x29, x29
1052a7590: 94a601bc    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a7594: aa0003f9    	mov	x25, x0
1052a7598: 900cd368    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1052a759c: f9448500    	ldr	x0, [x8, #0x908]
1052a75a0: aa1603e1    	mov	x1, x22
1052a75a4: 94a601b0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a75a8: aa0003e2    	mov	x2, x0
1052a75ac: d00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a75b0: f9452118    	ldr	x24, [x8, #0xa40] ; selector: getService:
1052a75b4: aa1903e0    	mov	x0, x25
1052a75b8: aa1803e1    	mov	x1, x24
1052a75bc: 94a601aa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a75c0: aa1d03fd    	mov	x29, x29
1052a75c4: 94a601af    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a75c8: aa0003fa    	mov	x26, x0
1052a75cc: f00cbce8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a75d0: f943b901    	ldr	x1, [x8, #0x770] ; selector: reportViewClick:itemOrDataWrap:
1052a75d4: 528001e2    	mov	w2, #0xf                ; =15
1052a75d8: aa1403e3    	mov	x3, x20
1052a75dc: 94a601a2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a75e0: aa1a03e0    	mov	x0, x26
1052a75e4: 94a601a3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a75e8: aa1903e0    	mov	x0, x25
1052a75ec: 94a601a1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a75f0: f943c360    	ldr	x0, [x27, #0x780]
1052a75f4: aa1703e1    	mov	x1, x23
1052a75f8: 94a6019b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a75fc: aa1d03fd    	mov	x29, x29
1052a7600: 94a601a0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a7604: aa0003f9    	mov	x25, x0
1052a7608: 900cd3c8    	adrp	x8, 0x11ed1f000 <dyld_stub_binder+0x11ed1f000>
1052a760c: f9409900    	ldr	x0, [x8, #0x130]
1052a7610: aa1603e1    	mov	x1, x22
1052a7614: 94a60194    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7618: aa0003e2    	mov	x2, x0
1052a761c: aa1903e0    	mov	x0, x25
1052a7620: aa1803e1    	mov	x1, x24
1052a7624: 94a60190    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7628: aa1d03fd    	mov	x29, x29
1052a762c: 94a60195    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a7630: aa0003fa    	mov	x26, x0
1052a7634: f00cbce8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
1052a7638: f9440501    	ldr	x1, [x8, #0x808] ; selector: unstarFavItem:completion:
1052a763c: aa1503e2    	mov	x2, x21
1052a7640: d2800003    	mov	x3, #0x0                ; =0
1052a7644: 94a60188    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7648: aa1a03e0    	mov	x0, x26
1052a764c: 94a60189    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a7650: aa1903e0    	mov	x0, x25
1052a7654: 94a60187    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a7658: f00cd348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1052a765c: f9468100    	ldr	x0, [x8, #0xd00]
1052a7660: b00cb928    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1052a7664: f9425901    	ldr	x1, [x8, #0x4b0] ; selector: toast
1052a7668: 94a6017f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a766c: aa1d03fd    	mov	x29, x29
1052a7670: 94a60184    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a7674: aa0003f9    	mov	x25, x0
1052a7678: f943c360    	ldr	x0, [x27, #0x780]
1052a767c: aa1703e1    	mov	x1, x23
1052a7680: 94a60179    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7684: aa1d03fd    	mov	x29, x29
1052a7688: 94a6017e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a768c: aa0003f7    	mov	x23, x0
1052a7690: f00cd348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1052a7694: f9440100    	ldr	x0, [x8, #0x800]
1052a7698: aa1603e1    	mov	x1, x22
1052a769c: 94a60172    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a76a0: aa0003e2    	mov	x2, x0
1052a76a4: aa1703e0    	mov	x0, x23
1052a76a8: aa1803e1    	mov	x1, x24
1052a76ac: 94a6016e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a76b0: aa1d03fd    	mov	x29, x29
1052a76b4: 94a60173    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a76b8: aa0003f6    	mov	x22, x0
1052a76bc: d00cb908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1052a76c0: f9452501    	ldr	x1, [x8, #0xa48] ; selector: getStringForCurLanguage:
1052a76c4: b00bf062    	adrp	x2, 0x11d0b4000 <dyld_stub_binder+0x11d0b4000>
1052a76c8: 9104e042    	add	x2, x2, #0x138 ; CFString: Star_Migration_Unstar_Done
1052a76cc: 94a60166    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a76d0: aa1d03fd    	mov	x29, x29
1052a76d4: 94a6016b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a76d8: aa0003f8    	mov	x24, x0
1052a76dc: 900cb9a8    	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
1052a76e0: f9412101    	ldr	x1, [x8, #0x240] ; selector: showToastWithText:
1052a76e4: aa1903e0    	mov	x0, x25
1052a76e8: aa1803e2    	mov	x2, x24
1052a76ec: 94a6015e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a76f0: aa1803e0    	mov	x0, x24
1052a76f4: 94a6015f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a76f8: aa1603e0    	mov	x0, x22
1052a76fc: 94a6015d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a7700: aa1703e0    	mov	x0, x23
1052a7704: 94a6015b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a7708: aa1903e0    	mov	x0, x25
1052a770c: 94a60159    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a7710: 14000004    	b	0x1052a7720 <_Flutter_MMFoundation_BindContext+0x152e3ec>
1052a7714: d2800016    	mov	x22, #0x0               ; =0
1052a7718: 17ffff7d    	b	0x1052a750c <_Flutter_MMFoundation_BindContext+0x152e1d8>
1052a771c: d2800015    	mov	x21, #0x0               ; =0
1052a7720: aa1503e0    	mov	x0, x21
1052a7724: 17ffff7b    	b	0x1052a7510 <_Flutter_MMFoundation_BindContext+0x152e1dc>
1052a7728: 94a60002    	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
1052a772c: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
1052a7730: a90167fa    	stp	x26, x25, [sp, #0x10]
1052a7734: a9025ff8    	stp	x24, x23, [sp, #0x20]
1052a7738: a90357f6    	stp	x22, x21, [sp, #0x30]
1052a773c: a9044ff4    	stp	x20, x19, [sp, #0x40]
1052a7740: a9057bfd    	stp	x29, x30, [sp, #0x50]
1052a7744: 910143fd    	add	x29, sp, #0x50
1052a7748: aa0003f9    	mov	x25, x0
1052a774c: 9100a000    	add	x0, x0, #0x28
1052a7750: 94a60143    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1052a7754: aa0003f3    	mov	x19, x0
1052a7758: b40002a0    	cbz	x0, 0x1052a77ac <_Flutter_MMFoundation_BindContext+0x152e478>
1052a775c: 9100c320    	add	x0, x25, #0x30
1052a7760: 94a6013f    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1052a7764: aa0003f4    	mov	x20, x0
1052a7768: b4000260    	cbz	x0, 0x1052a77b4 <_Flutter_MMFoundation_BindContext+0x152e480>
1052a776c: 9100c320    	add	x0, x25, #0x30
1052a7770: 94a6013b    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1052a7774: aa0003f5    	mov	x21, x0
1052a7778: d00cd028    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1052a777c: f9448901    	ldr	x1, [x8, #0x910] ; selector: topViewController
1052a7780: 94a60139    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7784: aa1d03fd    	mov	x29, x29
1052a7788: 94a6013e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a778c: aa0003f6    	mov	x22, x0
1052a7790: 9100e320    	add	x0, x25, #0x38
1052a7794: 94a60132    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1052a7798: aa0003f7    	mov	x23, x0
1052a779c: eb0002df    	cmp	x22, x0
1052a77a0: 540000e0    	b.eq	0x1052a77bc <_Flutter_MMFoundation_BindContext+0x152e488>
1052a77a4: 52800019    	mov	w25, #0x0               ; =0
1052a77a8: 1400003d    	b	0x1052a789c <_Flutter_MMFoundation_BindContext+0x152e568>
1052a77ac: 52800019    	mov	w25, #0x0               ; =0
1052a77b0: 14000043    	b	0x1052a78bc <_Flutter_MMFoundation_BindContext+0x152e588>
1052a77b4: 52800019    	mov	w25, #0x0               ; =0
1052a77b8: 1400003f    	b	0x1052a78b4 <_Flutter_MMFoundation_BindContext+0x152e580>
1052a77bc: d00cb948    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
1052a77c0: f945151c    	ldr	x28, [x8, #0xa28] ; selector: viewIfLoaded
1052a77c4: aa1303e0    	mov	x0, x19
1052a77c8: aa1c03e1    	mov	x1, x28
1052a77cc: 94a60126    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a77d0: aa1d03fd    	mov	x29, x29
1052a77d4: 94a6012b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a77d8: aa0003f8    	mov	x24, x0
1052a77dc: d00cd028    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1052a77e0: f947e101    	ldr	x1, [x8, #0xfc0] ; selector: window
1052a77e4: 94a60120    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a77e8: aa1d03fd    	mov	x29, x29
1052a77ec: 94a60125    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a77f0: aa0003fa    	mov	x26, x0
1052a77f4: b40001a0    	cbz	x0, 0x1052a7828 <_Flutter_MMFoundation_BindContext+0x152e4f4>
1052a77f8: aa1303e0    	mov	x0, x19
1052a77fc: aa1c03e1    	mov	x1, x28
1052a7800: 94a60119    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7804: aa1d03fd    	mov	x29, x29
1052a7808: 94a6011e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a780c: aa0003fb    	mov	x27, x0
1052a7810: b00cd008    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1052a7814: f9441501    	ldr	x1, [x8, #0x828] ; selector: isHidden
1052a7818: 94a60113    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a781c: 360000a0    	tbz	w0, #0x0, 0x1052a7830 <_Flutter_MMFoundation_BindContext+0x152e4fc>
1052a7820: 52800019    	mov	w25, #0x0               ; =0
1052a7824: 14000018    	b	0x1052a7884 <_Flutter_MMFoundation_BindContext+0x152e550>
1052a7828: 52800019    	mov	w25, #0x0               ; =0
1052a782c: 14000018    	b	0x1052a788c <_Flutter_MMFoundation_BindContext+0x152e558>
1052a7830: f9401320    	ldr	x0, [x25, #0x20]
1052a7834: b4000260    	cbz	x0, 0x1052a7880 <_Flutter_MMFoundation_BindContext+0x152e54c>
1052a7838: d00cd028    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1052a783c: f9434501    	ldr	x1, [x8, #0x688] ; selector: superview
1052a7840: 94a60109    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a7844: aa1d03fd    	mov	x29, x29
1052a7848: 94a6010e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a784c: aa0003f9    	mov	x25, x0
1052a7850: aa1303e0    	mov	x0, x19
1052a7854: aa1c03e1    	mov	x1, x28
1052a7858: 94a60103    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a785c: aa1d03fd    	mov	x29, x29
1052a7860: 94a60108    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1052a7864: eb00033f    	cmp	x25, x0
1052a7868: aa1903fc    	mov	x28, x25
1052a786c: 1a9f17f9    	cset	w25, eq
1052a7870: 94a60100    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a7874: aa1c03e0    	mov	x0, x28
1052a7878: 94a600fe    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a787c: 14000002    	b	0x1052a7884 <_Flutter_MMFoundation_BindContext+0x152e550>
1052a7880: 52800039    	mov	w25, #0x1               ; =1
1052a7884: aa1b03e0    	mov	x0, x27
1052a7888: 94a600fa    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a788c: aa1a03e0    	mov	x0, x26
1052a7890: 94a600f8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a7894: aa1803e0    	mov	x0, x24
1052a7898: 94a600f6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a789c: aa1703e0    	mov	x0, x23
1052a78a0: 94a600f4    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a78a4: aa1603e0    	mov	x0, x22
1052a78a8: 94a600f2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a78ac: aa1503e0    	mov	x0, x21
1052a78b0: 94a600f0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a78b4: aa1403e0    	mov	x0, x20
1052a78b8: 94a600ee    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a78bc: aa1303e0    	mov	x0, x19
1052a78c0: 94a600ec    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1052a78c4: aa1903e0    	mov	x0, x25
1052a78c8: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1052a78cc: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1052a78d0: a94357f6    	ldp	x22, x21, [sp, #0x30]
1052a78d4: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1052a78d8: a94167fa    	ldp	x26, x25, [sp, #0x10]
1052a78dc: a8c66ffc    	ldp	x28, x27, [sp], #0x60
1052a78e0: d65f03c0    	ret
1052a78e4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1052a78e8: a9014ff4    	stp	x20, x19, [sp, #0x10]
1052a78ec: a9027bfd    	stp	x29, x30, [sp, #0x20]
1052a78f0: 910083fd    	add	x29, sp, #0x20
1052a78f4: aa0103f3    	mov	x19, x1
1052a78f8: aa0003f4    	mov	x20, x0
1052a78fc: 9100a000    	add	x0, x0, #0x28
1052a7900: 94a600d7    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1052a7904: aa0003f5    	mov	x21, x0
1052a7908: f9401282    	ldr	x2, [x20, #0x20]
1052a790c: d00cbce8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
1052a7910: f9464d01    	ldr	x1, [x8, #0xc98] ; selector: finishLongPressNoteConversionSnapshot:completed:
1052a7914: aa1303e3    	mov	x3, x19
1052a7918: 94a600d3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1052a791c: aa1503e0    	mov	x0, x21
1052a7920: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1052a7924: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1052a7928: a8c357f6    	ldp	x22, x21, [sp], #0x30
1052a792c: 14a600d1    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
