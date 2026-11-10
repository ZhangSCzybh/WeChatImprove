
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101a2d028: d10283ff    	sub	sp, sp, #0xa0
101a2d02c: a9046ffc    	stp	x28, x27, [sp, #0x40]
101a2d030: a90567fa    	stp	x26, x25, [sp, #0x50]
101a2d034: a9065ff8    	stp	x24, x23, [sp, #0x60]
101a2d038: a90757f6    	stp	x22, x21, [sp, #0x70]
101a2d03c: a9084ff4    	stp	x20, x19, [sp, #0x80]
101a2d040: a9097bfd    	stp	x29, x30, [sp, #0x90]
101a2d044: 910243fd    	add	x29, sp, #0x90
101a2d048: aa0403f5    	mov	x21, x4
101a2d04c: aa0303f6    	mov	x22, x3
101a2d050: aa0203f3    	mov	x19, x2
101a2d054: aa0003f4    	mov	x20, x0
101a2d058: 900ee8c8    	adrp	x8, 0x11f745000 <dyld_stub_binder+0x11f745000>
101a2d05c: 52800029    	mov	w9, #0x1                ; =1
101a2d060: 393c8109    	strb	w9, [x8, #0xf20]
101a2d064: aa0203e0    	mov	x0, x2
101a2d068: 9587eb03    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101a2d06c: 900e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2d070: f9469901    	ldr	x1, [x8, #0xd30] ; selector: activeCategoryTypeBitForFilter
101a2d074: aa1403e0    	mov	x0, x20
101a2d078: 9587eafb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d07c: aa0003f7    	mov	x23, x0
101a2d080: f101fc1f    	cmp	x0, #0x7f
101a2d084: 5400012d    	b.le	0x101a2d0a8 <__text+0x1a250a8>
101a2d088: f14802ff    	cmp	x23, #0x200, lsl #12    ; =0x200000
101a2d08c: 54001600    	b.eq	0x101a2d34c <__text+0x1a2534c>
101a2d090: 52880148    	mov	w8, #0x400a             ; =16394
101a2d094: eb0802ff    	cmp	x23, x8
101a2d098: 54001880    	b.eq	0x101a2d3a8 <__text+0x1a253a8>
101a2d09c: f10202ff    	cmp	x23, #0x80
101a2d0a0: 540000c0    	b.eq	0x101a2d0b8 <__text+0x1a250b8>
101a2d0a4: 140000eb    	b	0x101a2d450 <__text+0x1a25450>
101a2d0a8: f10042ff    	cmp	x23, #0x10
101a2d0ac: 54000060    	b.eq	0x101a2d0b8 <__text+0x1a250b8>
101a2d0b0: f10082ff    	cmp	x23, #0x20
101a2d0b4: 54001ce1    	b.ne	0x101a2d450 <__text+0x1a25450>
101a2d0b8: b00e9788    	adrp	x8, 0x11ed1e000 <dyld_stub_binder+0x11ed1e000>
101a2d0bc: f947e500    	ldr	x0, [x8, #0xfc8]
101a2d0c0: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2d0c4: f9413d01    	ldr	x1, [x8, #0x278] ; selector: filterAndAggregateSearchResult:withSearchText:withSearchType:withTagList:
101a2d0c8: d00dab63    	adrp	x3, 0x11cf9b000 <dyld_stub_binder+0x11cf9b000>
101a2d0cc: 91396063    	add	x3, x3, #0xe58 ; CFString: 
101a2d0d0: aa1303e2    	mov	x2, x19
101a2d0d4: aa1703e4    	mov	x4, x23
101a2d0d8: d2800005    	mov	x5, #0x0                ; =0
101a2d0dc: 9587eae2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d0e0: aa1d03fd    	mov	x29, x29
101a2d0e4: 9587eae7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d0e8: aa0003f6    	mov	x22, x0
101a2d0ec: f10082ff    	cmp	x23, #0x20
101a2d0f0: 54000841    	b.ne	0x101a2d1f8 <__text+0x1a251f8>
101a2d0f4: b00e9728    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a2d0f8: f943c100    	ldr	x0, [x8, #0x780]
101a2d0fc: 900e7ce8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a2d100: f9440117    	ldr	x23, [x8, #0x800] ; selector: currentContext
101a2d104: aa1703e1    	mov	x1, x23
101a2d108: 9587ead7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d10c: aa1d03fd    	mov	x29, x29
101a2d110: 9587eadc    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d114: aa0003fa    	mov	x26, x0
101a2d118: d00e9728    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a2d11c: f9448500    	ldr	x0, [x8, #0x908]
101a2d120: b00e93c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a2d124: f9428518    	ldr	x24, [x8, #0x508] ; selector: class
101a2d128: aa1803e1    	mov	x1, x24
101a2d12c: 9587eace    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d130: aa0003e2    	mov	x2, x0
101a2d134: 900e7ce8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a2d138: f9452119    	ldr	x25, [x8, #0xa40] ; selector: getService:
101a2d13c: aa1a03e0    	mov	x0, x26
101a2d140: aa1903e1    	mov	x1, x25
101a2d144: 9587eac8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d148: aa1d03fd    	mov	x29, x29
101a2d14c: 9587eacd    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d150: aa0003fb    	mov	x27, x0
101a2d154: 900e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2d158: f9465901    	ldr	x1, [x8, #0xcb0] ; selector: isFavFlatPOIEnabled
101a2d15c: 9587eac2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d160: aa0003fc    	mov	x28, x0
101a2d164: aa1b03e0    	mov	x0, x27
101a2d168: 9587eac2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d16c: aa1a03e0    	mov	x0, x26
101a2d170: 9587eac0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d174: 34001e5c    	cbz	w28, 0x101a2d53c <__text+0x1a2553c>
101a2d178: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2d17c: b98db117    	ldrsw	x23, [x8, #0xdb0] ; ivar: FavBaseListViewController.m_flatPOIDataWraps offset=448
101a2d180: f8776a80    	ldr	x0, [x20, x23]
101a2d184: b50001a0    	cbnz	x0, 0x101a2d1b8 <__text+0x1a251b8>
101a2d188: b00e9728    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a2d18c: f9432d00    	ldr	x0, [x8, #0x658]
101a2d190: 900e93c8    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
101a2d194: f946c501    	ldr	x1, [x8, #0xd88] ; selector: array
101a2d198: 9587eab3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d19c: aa1d03fd    	mov	x29, x29
101a2d1a0: 9587eab8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d1a4: f8776a88    	ldr	x8, [x20, x23]
101a2d1a8: f8376a80    	str	x0, [x20, x23]
101a2d1ac: aa0803e0    	mov	x0, x8
101a2d1b0: 9587eab0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d1b4: f8776a80    	ldr	x0, [x20, x23]
101a2d1b8: 900e93c8    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
101a2d1bc: f9452101    	ldr	x1, [x8, #0xa40] ; selector: addObjectsFromArray:
101a2d1c0: aa1603e2    	mov	x2, x22
101a2d1c4: 9587eaa8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d1c8: 37001f95    	tbnz	w21, #0x0, 0x101a2d5b8 <__text+0x1a255b8>
101a2d1cc: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2d1d0: b98dad08    	ldrsw	x8, [x8, #0xdac] ; ivar: FavBaseListViewController.m_flatPOIDataComplete offset=472
101a2d1d4: 52800029    	mov	w9, #0x1                ; =1
101a2d1d8: 38286a89    	strb	w9, [x20, x8]
101a2d1dc: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2d1e0: f9414101    	ldr	x1, [x8, #0x280] ; selector: reloadFlatPOIData
101a2d1e4: aa1403e0    	mov	x0, x20
101a2d1e8: 9587ea9f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d1ec: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2d1f0: b98da11b    	ldrsw	x27, [x8, #0xda0] ; ivar: FavBaseListViewController.m_tableView offset=136
101a2d1f4: 14000050    	b	0x101a2d334 <__text+0x1a25334>
101a2d1f8: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2d1fc: b98d7d17    	ldrsw	x23, [x8, #0xd7c] ; ivar: FavBaseListViewController.m_dataController offset=200
101a2d200: f8776a80    	ldr	x0, [x20, x23]
101a2d204: 900e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2d208: f9466901    	ldr	x1, [x8, #0xcd0] ; selector: addFavDataWrapList:
101a2d20c: aa1603e2    	mov	x2, x22
101a2d210: 9587ea95    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d214: f8776a80    	ldr	x0, [x20, x23]
101a2d218: 900e7d68    	adrp	x8, 0x11e9d9000 <dyld_stub_binder+0x11e9d9000>
101a2d21c: f9417101    	ldr	x1, [x8, #0x2e0] ; selector: setHasMoreData:
101a2d220: aa1503e2    	mov	x2, x21
101a2d224: 9587ea90    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d228: f8776a82    	ldr	x2, [x20, x23]
101a2d22c: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2d230: b98da11b    	ldrsw	x27, [x8, #0xda0] ; ivar: FavBaseListViewController.m_tableView offset=136
101a2d234: f87b6a80    	ldr	x0, [x20, x27]
101a2d238: f00e7ce8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
101a2d23c: f947a901    	ldr	x1, [x8, #0xf50] ; selector: setDataSource:
101a2d240: 9587ea89    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d244: f8776a82    	ldr	x2, [x20, x23]
101a2d248: f87b6a80    	ldr	x0, [x20, x27]
101a2d24c: d00e93e8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
101a2d250: f9430d01    	ldr	x1, [x8, #0x618] ; selector: setDelegate:
101a2d254: 9587ea84    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d258: f87b6a82    	ldr	x2, [x20, x27]
101a2d25c: f8776a80    	ldr	x0, [x20, x23]
101a2d260: d00e7dc8    	adrp	x8, 0x11e9e7000 <dyld_stub_binder+0x11e9e7000>
101a2d264: f9421901    	ldr	x1, [x8, #0x430] ; selector: setTableView:
101a2d268: 9587ea7f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d26c: f8776a80    	ldr	x0, [x20, x23]
101a2d270: 900e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2d274: f9466d01    	ldr	x1, [x8, #0xcd8] ; selector: arrFavDataWrap
101a2d278: 9587ea7b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d27c: aa1d03fd    	mov	x29, x29
101a2d280: 9587ea80    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d284: aa0003f5    	mov	x21, x0
101a2d288: b00e93c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a2d28c: f9442901    	ldr	x1, [x8, #0x850] ; selector: count
101a2d290: 9587ea75    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d294: aa0003f7    	mov	x23, x0
101a2d298: b00e9728    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a2d29c: f943c100    	ldr	x0, [x8, #0x780]
101a2d2a0: 900e7ce8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a2d2a4: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
101a2d2a8: 9587ea6f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d2ac: aa1d03fd    	mov	x29, x29
101a2d2b0: 9587ea74    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d2b4: aa0003f8    	mov	x24, x0
101a2d2b8: d00e9728    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a2d2bc: f9448500    	ldr	x0, [x8, #0x908]
101a2d2c0: b00e93c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a2d2c4: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
101a2d2c8: 9587ea67    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d2cc: aa0003e2    	mov	x2, x0
101a2d2d0: 900e7ce8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a2d2d4: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
101a2d2d8: aa1803e0    	mov	x0, x24
101a2d2dc: 9587ea62    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d2e0: aa1d03fd    	mov	x29, x29
101a2d2e4: 9587ea67    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d2e8: aa0003f9    	mov	x25, x0
101a2d2ec: b00e7d48    	adrp	x8, 0x11e9d6000 <dyld_stub_binder+0x11e9d6000>
101a2d2f0: f9426901    	ldr	x1, [x8, #0x4d0] ; selector: reportLogic
101a2d2f4: 9587ea5c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d2f8: aa1d03fd    	mov	x29, x29
101a2d2fc: 9587ea61    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d300: aa0003fa    	mov	x26, x0
101a2d304: 900e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2d308: f9467101    	ldr	x1, [x8, #0xce0] ; selector: setLocalResultNum:
101a2d30c: aa1703e2    	mov	x2, x23
101a2d310: 9587ea55    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d314: aa1a03e0    	mov	x0, x26
101a2d318: 9587ea56    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d31c: aa1903e0    	mov	x0, x25
101a2d320: 9587ea54    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d324: aa1803e0    	mov	x0, x24
101a2d328: 9587ea52    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d32c: aa1503e0    	mov	x0, x21
101a2d330: 9587ea50    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d334: f87b6a80    	ldr	x0, [x20, x27]
101a2d338: f00e7ce8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
101a2d33c: f9414901    	ldr	x1, [x8, #0x290] ; selector: reloadData
101a2d340: 9587ea49    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d344: aa1603e0    	mov	x0, x22
101a2d348: 1400027a    	b	0x101a2dd30 <__text+0x1a25d30>
101a2d34c: b00e93c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a2d350: f9442918    	ldr	x24, [x8, #0x850] ; selector: count
101a2d354: aa1303e0    	mov	x0, x19
101a2d358: aa1803e1    	mov	x1, x24
101a2d35c: 9587ea42    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d360: b4003020    	cbz	x0, 0x101a2d964 <__text+0x1a25964>
101a2d364: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2d368: f9415101    	ldr	x1, [x8, #0x2a0] ; selector: genFinderDataItemsWith:
101a2d36c: aa1403e0    	mov	x0, x20
101a2d370: aa1303e2    	mov	x2, x19
101a2d374: 9587ea3c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d378: aa1d03fd    	mov	x29, x29
101a2d37c: 9587ea41    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d380: aa0003e2    	mov	x2, x0
101a2d384: f9001fe0    	str	x0, [sp, #0x38]
101a2d388: 34004f76    	cbz	w22, 0x101a2dd74 <__text+0x1a25d74>
101a2d38c: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2d390: b98d8116    	ldrsw	x22, [x8, #0xd80] ; ivar: FavBaseListViewController.m_arrFinderItems offset=176
101a2d394: f8766a80    	ldr	x0, [x20, x22]
101a2d398: 900e93c8    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
101a2d39c: f9452101    	ldr	x1, [x8, #0xa40] ; selector: addObjectsFromArray:
101a2d3a0: 9587ea31    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d3a4: 1400027e    	b	0x101a2dd9c <__text+0x1a25d9c>
101a2d3a8: b00e9788    	adrp	x8, 0x11ed1e000 <dyld_stub_binder+0x11ed1e000>
101a2d3ac: f947e500    	ldr	x0, [x8, #0xfc8]
101a2d3b0: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2d3b4: f9414501    	ldr	x1, [x8, #0x288] ; selector: aggregatePicSearchResult:
101a2d3b8: aa1303e2    	mov	x2, x19
101a2d3bc: 9587ea2a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d3c0: aa1d03fd    	mov	x29, x29
101a2d3c4: 9587ea2f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d3c8: aa0003f8    	mov	x24, x0
101a2d3cc: b00e93e8    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
101a2d3d0: f9443901    	ldr	x1, [x8, #0x870] ; selector: reverseObjectEnumerator
101a2d3d4: 9587ea24    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d3d8: aa1d03fd    	mov	x29, x29
101a2d3dc: 9587ea29    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d3e0: aa0003f9    	mov	x25, x0
101a2d3e4: 900e93c8    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
101a2d3e8: f945d501    	ldr	x1, [x8, #0xba8] ; selector: allObjects
101a2d3ec: 9587ea1e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d3f0: aa1d03fd    	mov	x29, x29
101a2d3f4: 9587ea23    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d3f8: aa0003f7    	mov	x23, x0
101a2d3fc: aa1803e0    	mov	x0, x24
101a2d400: 9587ea1c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d404: aa1903e0    	mov	x0, x25
101a2d408: 9587ea1a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d40c: f9001ff7    	str	x23, [sp, #0x38]
101a2d410: 34000e56    	cbz	w22, 0x101a2d5d8 <__text+0x1a255d8>
101a2d414: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2d418: f9405118    	ldr	x24, [x8, #0xa0] ; selector: arrImgInfo
101a2d41c: aa1403e0    	mov	x0, x20
101a2d420: aa1803e1    	mov	x1, x24
101a2d424: 9587ea10    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d428: aa1d03fd    	mov	x29, x29
101a2d42c: 9587ea15    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d430: aa0003f9    	mov	x25, x0
101a2d434: 900e93c8    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
101a2d438: f9452101    	ldr	x1, [x8, #0xa40] ; selector: addObjectsFromArray:
101a2d43c: aa1703e2    	mov	x2, x23
101a2d440: 9587ea09    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d444: aa1903e0    	mov	x0, x25
101a2d448: 9587ea0a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d44c: 14000075    	b	0x101a2d620 <__text+0x1a25620>
101a2d450: aa1303e0    	mov	x0, x19
101a2d454: 9587ea08    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101a2d458: 52b00008    	mov	w8, #-0x80000000        ; =-2147483648
101a2d45c: eb0802ff    	cmp	x23, x8
101a2d460: 54000060    	b.eq	0x101a2d46c <__text+0x1a2546c>
101a2d464: f10102ff    	cmp	x23, #0x40
101a2d468: 54003461    	b.ne	0x101a2daf4 <__text+0x1a25af4>
101a2d46c: b00e9728    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a2d470: f943c100    	ldr	x0, [x8, #0x780]
101a2d474: 900e7ce8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a2d478: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
101a2d47c: 9587e9fa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d480: aa1d03fd    	mov	x29, x29
101a2d484: 9587e9ff    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d488: aa0003f8    	mov	x24, x0
101a2d48c: d00e9728    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a2d490: f9448500    	ldr	x0, [x8, #0x908]
101a2d494: b00e93c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a2d498: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
101a2d49c: 9587e9f2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d4a0: aa0003e2    	mov	x2, x0
101a2d4a4: 900e7ce8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a2d4a8: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
101a2d4ac: aa1803e0    	mov	x0, x24
101a2d4b0: 9587e9ed    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d4b4: aa1d03fd    	mov	x29, x29
101a2d4b8: 9587e9f2    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d4bc: aa0003f9    	mov	x25, x0
101a2d4c0: 900e7d68    	adrp	x8, 0x11e9d9000 <dyld_stub_binder+0x11e9d9000>
101a2d4c4: f9463501    	ldr	x1, [x8, #0xc68] ; selector: setting
101a2d4c8: 9587e9e7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d4cc: aa1d03fd    	mov	x29, x29
101a2d4d0: 9587e9ec    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d4d4: aa0003fa    	mov	x26, x0
101a2d4d8: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2d4dc: f9416901    	ldr	x1, [x8, #0x2d0] ; selector: enableMusicList
101a2d4e0: 9587e9e1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d4e4: f10102ff    	cmp	x23, #0x40
101a2d4e8: 54002e21    	b.ne	0x101a2daac <__text+0x1a25aac>
101a2d4ec: 34002e00    	cbz	w0, 0x101a2daac <__text+0x1a25aac>
101a2d4f0: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2d4f4: b98de508    	ldrsw	x8, [x8, #0xde4] ; ivar: FavBaseListViewController._selectedTags offset=512
101a2d4f8: f8686a80    	ldr	x0, [x20, x8]
101a2d4fc: b00e93c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a2d500: f9442901    	ldr	x1, [x8, #0x850] ; selector: count
101a2d504: 9587e9d8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d508: aa0003fb    	mov	x27, x0
101a2d50c: aa1a03e0    	mov	x0, x26
101a2d510: 9587e9d8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d514: aa1903e0    	mov	x0, x25
101a2d518: 9587e9d6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d51c: aa1803e0    	mov	x0, x24
101a2d520: 9587e9d4    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d524: b5002d1b    	cbnz	x27, 0x101a2dac4 <__text+0x1a25ac4>
101a2d528: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2d52c: f9416d01    	ldr	x1, [x8, #0x2d8] ; selector: initTingListenListBar
101a2d530: aa1403e0    	mov	x0, x20
101a2d534: 9587e9cc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d538: 14000163    	b	0x101a2dac4 <__text+0x1a25ac4>
101a2d53c: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2d540: b98ddd1c    	ldrsw	x28, [x8, #0xddc] ; ivar: FavBaseListViewController.m_addressDataController offset=208
101a2d544: f87c6a80    	ldr	x0, [x20, x28]
101a2d548: b50001c0    	cbnz	x0, 0x101a2d580 <__text+0x1a25580>
101a2d54c: d00e9788    	adrp	x8, 0x11ed1f000 <dyld_stub_binder+0x11ed1f000>
101a2d550: f9402d00    	ldr	x0, [x8, #0x58]
101a2d554: 9587e9ae    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
101a2d558: f87c6a88    	ldr	x8, [x20, x28]
101a2d55c: f83c6a80    	str	x0, [x20, x28]
101a2d560: aa0803e0    	mov	x0, x8
101a2d564: 9587e9c3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d568: f87c6a80    	ldr	x0, [x20, x28]
101a2d56c: d00e93e8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
101a2d570: f9430d01    	ldr	x1, [x8, #0x618] ; selector: setDelegate:
101a2d574: aa1403e2    	mov	x2, x20
101a2d578: 9587e9bb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d57c: f87c6a80    	ldr	x0, [x20, x28]
101a2d580: 900e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2d584: f9437d1a    	ldr	x26, [x8, #0x6f8] ; selector: arrDataWraps
101a2d588: aa1a03e1    	mov	x1, x26
101a2d58c: 9587e9b6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d590: aa1d03fd    	mov	x29, x29
101a2d594: 9587e9bb    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d598: aa0003fb    	mov	x27, x0
101a2d59c: 900e93c8    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
101a2d5a0: f9452101    	ldr	x1, [x8, #0xa40] ; selector: addObjectsFromArray:
101a2d5a4: aa1603e2    	mov	x2, x22
101a2d5a8: 9587e9af    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d5ac: aa1b03e0    	mov	x0, x27
101a2d5b0: 9587e9b0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d5b4: 36001f75    	tbz	w21, #0x0, 0x101a2d9a0 <__text+0x1a259a0>
101a2d5b8: b00e7ec8    	adrp	x8, 0x11ea06000 <dyld_stub_binder+0x11ea06000>
101a2d5bc: f9415901    	ldr	x1, [x8, #0x2b0] ; selector: onLoadMore
101a2d5c0: aa1403e0    	mov	x0, x20
101a2d5c4: 9587e9a8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d5c8: aa1603e0    	mov	x0, x22
101a2d5cc: 9587e9a9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d5d0: 52800034    	mov	w20, #0x1               ; =1
101a2d5d4: 140001dd    	b	0x101a2dd48 <__text+0x1a25d48>
101a2d5d8: b00e9728    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a2d5dc: f9432d00    	ldr	x0, [x8, #0x658]
101a2d5e0: 900e93c8    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
101a2d5e4: f946d101    	ldr	x1, [x8, #0xda0] ; selector: arrayWithArray:
101a2d5e8: aa1703e2    	mov	x2, x23
101a2d5ec: 9587e99e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d5f0: aa1d03fd    	mov	x29, x29
101a2d5f4: 9587e9a3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d5f8: aa0003f8    	mov	x24, x0
101a2d5fc: 900e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2d600: f9461d01    	ldr	x1, [x8, #0xc38] ; selector: setArrImgInfo:
101a2d604: aa1403e0    	mov	x0, x20
101a2d608: aa1803e2    	mov	x2, x24
101a2d60c: 9587e996    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d610: aa1803e0    	mov	x0, x24
101a2d614: 9587e997    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d618: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2d61c: f9405118    	ldr	x24, [x8, #0xa0] ; selector: arrImgInfo
101a2d620: b00e9728    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a2d624: f9430d1a    	ldr	x26, [x8, #0x618]
101a2d628: b00e93c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a2d62c: f9442919    	ldr	x25, [x8, #0x850] ; selector: count
101a2d630: aa1303e0    	mov	x0, x19
101a2d634: aa1903e1    	mov	x1, x25
101a2d638: 9587e98b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d63c: aa0003fb    	mov	x27, x0
101a2d640: aa1403e0    	mov	x0, x20
101a2d644: aa1803e1    	mov	x1, x24
101a2d648: 9587e987    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d64c: aa1d03fd    	mov	x29, x29
101a2d650: 9587e98c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d654: aa0003fc    	mov	x28, x0
101a2d658: aa1903e1    	mov	x1, x25
101a2d65c: 9587e982    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d660: aa0003f7    	mov	x23, x0
101a2d664: 900e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2d668: f946c101    	ldr	x1, [x8, #0xd80] ; selector: recentUsedOnly
101a2d66c: aa1403e0    	mov	x0, x20
101a2d670: 9587e97d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d674: 900e7ce8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a2d678: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
101a2d67c: a90203f5    	stp	x21, x0, [sp, #0x20]
101a2d680: a9015bf7    	stp	x23, x22, [sp, #0x10]
101a2d684: d00db428    	adrp	x8, 0x11d0b3000 <dyld_stub_binder+0x11d0b3000>
101a2d688: 912a6108    	add	x8, x8, #0xa98 ; CFString: [FavFilter] present IMG: favBatch=%lu, imgTiles=%lu, append=%d, hasMore=%d, recentOnly=%d
101a2d68c: a9006fe8    	stp	x8, x27, [sp]
101a2d690: 900c1b63    	adrp	x3, 0x119d99000 <dyld_stub_binder+0x119d99000>
101a2d694: 91225863    	add	x3, x3, #0x896
101a2d698: d00c1b65    	adrp	x5, 0x119d9b000 <dyld_stub_binder+0x119d9b000>
101a2d69c: 9107f8a5    	add	x5, x5, #0x1fe
101a2d6a0: d00c1b67    	adrp	x7, 0x119d9b000 <dyld_stub_binder+0x119d9b000>
101a2d6a4: 91285ce7    	add	x7, x7, #0xa17
101a2d6a8: aa1a03e0    	mov	x0, x26
101a2d6ac: 52800042    	mov	w2, #0x2                ; =2
101a2d6b0: 52800004    	mov	w4, #0x0                ; =0
101a2d6b4: 52811fe6    	mov	w6, #0x8ff              ; =2303
101a2d6b8: 9587e96b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d6bc: aa1c03e0    	mov	x0, x28
101a2d6c0: 9587e96c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d6c4: aa1403e0    	mov	x0, x20
101a2d6c8: aa1803e1    	mov	x1, x24
101a2d6cc: 9587e966    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d6d0: aa1d03fd    	mov	x29, x29
101a2d6d4: 9587e96b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d6d8: aa0003f6    	mov	x22, x0
101a2d6dc: aa1903e1    	mov	x1, x25
101a2d6e0: 9587e961    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d6e4: aa0003f7    	mov	x23, x0
101a2d6e8: b00e9728    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a2d6ec: f943c100    	ldr	x0, [x8, #0x780]
101a2d6f0: 900e7ce8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a2d6f4: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
101a2d6f8: 9587e95b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d6fc: aa1d03fd    	mov	x29, x29
101a2d700: 9587e960    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d704: aa0003fa    	mov	x26, x0
101a2d708: d00e9728    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a2d70c: f9448500    	ldr	x0, [x8, #0x908]
101a2d710: b00e93c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a2d714: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
101a2d718: 9587e953    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d71c: aa0003e2    	mov	x2, x0
101a2d720: 900e7ce8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a2d724: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
101a2d728: aa1a03e0    	mov	x0, x26
101a2d72c: 9587e94e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d730: aa1d03fd    	mov	x29, x29
101a2d734: 9587e953    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d738: aa0003fb    	mov	x27, x0
101a2d73c: b00e7d48    	adrp	x8, 0x11e9d6000 <dyld_stub_binder+0x11e9d6000>
101a2d740: f9426901    	ldr	x1, [x8, #0x4d0] ; selector: reportLogic
101a2d744: 9587e948    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d748: aa1d03fd    	mov	x29, x29
101a2d74c: 9587e94d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d750: aa0003fc    	mov	x28, x0
101a2d754: 900e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2d758: f9467101    	ldr	x1, [x8, #0xce0] ; selector: setLocalResultNum:
101a2d75c: aa1703e2    	mov	x2, x23
101a2d760: 9587e941    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d764: aa1c03e0    	mov	x0, x28
101a2d768: 9587e942    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d76c: aa1b03e0    	mov	x0, x27
101a2d770: 9587e940    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d774: aa1a03e0    	mov	x0, x26
101a2d778: 9587e93e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d77c: aa1603e0    	mov	x0, x22
101a2d780: 9587e93c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d784: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2d788: b98d7d08    	ldrsw	x8, [x8, #0xd7c] ; ivar: FavBaseListViewController.m_dataController offset=200
101a2d78c: f8686a80    	ldr	x0, [x20, x8]
101a2d790: 900e7d68    	adrp	x8, 0x11e9d9000 <dyld_stub_binder+0x11e9d9000>
101a2d794: f9417101    	ldr	x1, [x8, #0x2e0] ; selector: setHasMoreData:
101a2d798: 52800002    	mov	w2, #0x0                ; =0
101a2d79c: 9587e932    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d7a0: 900e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2d7a4: f9474516    	ldr	x22, [x8, #0xe88] ; selector: favBrowseCollectionView
101a2d7a8: aa1403e0    	mov	x0, x20
101a2d7ac: aa1603e1    	mov	x1, x22
101a2d7b0: 9587e92d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d7b4: aa1d03fd    	mov	x29, x29
101a2d7b8: 9587e932    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d7bc: aa0003f7    	mov	x23, x0
101a2d7c0: 9587e92c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d7c4: b50000b7    	cbnz	x23, 0x101a2d7d8 <__text+0x1a257d8>
101a2d7c8: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2d7cc: f9414901    	ldr	x1, [x8, #0x290] ; selector: initFastBrowserView
101a2d7d0: aa1403e0    	mov	x0, x20
101a2d7d4: 9587e924    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d7d8: aa1403e0    	mov	x0, x20
101a2d7dc: aa1803e1    	mov	x1, x24
101a2d7e0: 9587e921    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d7e4: aa1d03fd    	mov	x29, x29
101a2d7e8: 9587e926    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d7ec: aa0003f7    	mov	x23, x0
101a2d7f0: aa1903e1    	mov	x1, x25
101a2d7f4: 9587e91c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d7f8: f100001f    	cmp	x0, #0x0
101a2d7fc: 1a9f17fa    	cset	w26, eq
101a2d800: aa1403e0    	mov	x0, x20
101a2d804: aa1603e1    	mov	x1, x22
101a2d808: 9587e917    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d80c: aa1d03fd    	mov	x29, x29
101a2d810: 9587e91c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d814: aa0003fb    	mov	x27, x0
101a2d818: 900e7f28    	adrp	x8, 0x11ea11000 <dyld_stub_binder+0x11ea11000>
101a2d81c: f9414901    	ldr	x1, [x8, #0x290] ; selector: getFooterView
101a2d820: 9587e911    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d824: aa1d03fd    	mov	x29, x29
101a2d828: 9587e916    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d82c: aa0003fc    	mov	x28, x0
101a2d830: d00e93e8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
101a2d834: f9458d01    	ldr	x1, [x8, #0xb18] ; selector: setHidden:
101a2d838: aa1a03e2    	mov	x2, x26
101a2d83c: 9587e90a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d840: aa1c03e0    	mov	x0, x28
101a2d844: 9587e90b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d848: aa1b03e0    	mov	x0, x27
101a2d84c: 9587e909    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d850: aa1703e0    	mov	x0, x23
101a2d854: 9587e907    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d858: aa1403e0    	mov	x0, x20
101a2d85c: aa1603e1    	mov	x1, x22
101a2d860: 9587e901    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d864: aa1d03fd    	mov	x29, x29
101a2d868: 9587e906    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d86c: aa0003f7    	mov	x23, x0
101a2d870: f00e7ce8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
101a2d874: f941491a    	ldr	x26, [x8, #0x290] ; selector: reloadData
101a2d878: aa1a03e1    	mov	x1, x26
101a2d87c: 9587e8fa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d880: aa1703e0    	mov	x0, x23
101a2d884: 9587e8fb    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d888: aa1403e0    	mov	x0, x20
101a2d88c: aa1603e1    	mov	x1, x22
101a2d890: 9587e8f5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d894: aa1d03fd    	mov	x29, x29
101a2d898: 9587e8fa    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d89c: aa0003f7    	mov	x23, x0
101a2d8a0: b00e7f28    	adrp	x8, 0x11ea12000 <dyld_stub_binder+0x11ea12000>
101a2d8a4: f9442d01    	ldr	x1, [x8, #0x858] ; selector: updatePreMore:NextMore:
101a2d8a8: 52800002    	mov	w2, #0x0                ; =0
101a2d8ac: aa1503e3    	mov	x3, x21
101a2d8b0: 9587e8ed    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d8b4: aa1703e0    	mov	x0, x23
101a2d8b8: 9587e8ee    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d8bc: aa1403e0    	mov	x0, x20
101a2d8c0: aa1603e1    	mov	x1, x22
101a2d8c4: 9587e8e8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d8c8: aa1d03fd    	mov	x29, x29
101a2d8cc: 9587e8ed    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d8d0: aa0003f6    	mov	x22, x0
101a2d8d4: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2d8d8: f9414d01    	ldr	x1, [x8, #0x298] ; selector: updateLoading:NextMore:
101a2d8dc: 52800002    	mov	w2, #0x0                ; =0
101a2d8e0: 52800003    	mov	w3, #0x0                ; =0
101a2d8e4: 9587e8e0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d8e8: aa1603e0    	mov	x0, x22
101a2d8ec: 9587e8e1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d8f0: 340002d5    	cbz	w21, 0x101a2d948 <__text+0x1a25948>
101a2d8f4: aa1403e0    	mov	x0, x20
101a2d8f8: aa1803e1    	mov	x1, x24
101a2d8fc: 9587e8da    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d900: aa1d03fd    	mov	x29, x29
101a2d904: 9587e8df    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2d908: aa0003f5    	mov	x21, x0
101a2d90c: aa1903e1    	mov	x1, x25
101a2d910: 9587e8d5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d914: aa0003f6    	mov	x22, x0
101a2d918: aa1503e0    	mov	x0, x21
101a2d91c: 9587e8d5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2d920: b4000156    	cbz	x22, 0x101a2d948 <__text+0x1a25948>
101a2d924: 900e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2d928: f9468102    	ldr	x2, [x8, #0xd00] ; selector: checkAndLoadMoreIfNeeded
101a2d92c: 900e93e8    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
101a2d930: f946f501    	ldr	x1, [x8, #0xde8] ; selector: performSelector:withObject:afterDelay:
101a2d934: d00af4c8    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
101a2d938: fd445d00    	ldr	d0, [x8, #0x8b8] ; constant double=0.1
101a2d93c: aa1403e0    	mov	x0, x20
101a2d940: d2800003    	mov	x3, #0x0                ; =0
101a2d944: 9587e8c8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d948: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2d94c: b98da108    	ldrsw	x8, [x8, #0xda0] ; ivar: FavBaseListViewController.m_tableView offset=136
101a2d950: f8686a80    	ldr	x0, [x20, x8]
101a2d954: aa1a03e1    	mov	x1, x26
101a2d958: 9587e8c3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d95c: f9401fe0    	ldr	x0, [sp, #0x38]
101a2d960: 140000f4    	b	0x101a2dd30 <__text+0x1a25d30>
101a2d964: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2d968: b98d8108    	ldrsw	x8, [x8, #0xd80] ; ivar: FavBaseListViewController.m_arrFinderItems offset=176
101a2d96c: f8686a80    	ldr	x0, [x20, x8]
101a2d970: aa1803e1    	mov	x1, x24
101a2d974: 9587e8bc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d978: b50035c0    	cbnz	x0, 0x101a2e030 <__text+0x1a26030>
101a2d97c: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2d980: b98df115    	ldrsw	x21, [x8, #0xdf0] ; ivar: FavBaseListViewController.m_feedFlowView offset=168
101a2d984: f8756a80    	ldr	x0, [x20, x21]
101a2d988: b00e93e8    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
101a2d98c: f9424901    	ldr	x1, [x8, #0x490] ; selector: removeFromSuperview
101a2d990: 9587e8b5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d994: f8756a9c    	ldr	x28, [x20, x21]
101a2d998: f8356a9f    	str	xzr, [x20, x21]
101a2d99c: 140001a3    	b	0x101a2e028 <__text+0x1a26028>
101a2d9a0: f87c6a80    	ldr	x0, [x20, x28]
101a2d9a4: 900e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2d9a8: f9440901    	ldr	x1, [x8, #0x810] ; selector: markDataLoadComplete
101a2d9ac: 9587e8ae    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d9b0: f87c6a82    	ldr	x2, [x20, x28]
101a2d9b4: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2d9b8: b98da11b    	ldrsw	x27, [x8, #0xda0] ; ivar: FavBaseListViewController.m_tableView offset=136
101a2d9bc: f87b6a80    	ldr	x0, [x20, x27]
101a2d9c0: f00e7ce8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
101a2d9c4: f947a901    	ldr	x1, [x8, #0xf50] ; selector: setDataSource:
101a2d9c8: 9587e8a7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d9cc: f87c6a82    	ldr	x2, [x20, x28]
101a2d9d0: f87b6a80    	ldr	x0, [x20, x27]
101a2d9d4: d00e93e8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
101a2d9d8: f9430d01    	ldr	x1, [x8, #0x618] ; selector: setDelegate:
101a2d9dc: 9587e8a2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d9e0: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2d9e4: b98d7d08    	ldrsw	x8, [x8, #0xd7c] ; ivar: FavBaseListViewController.m_dataController offset=200
101a2d9e8: f8686a80    	ldr	x0, [x20, x8]
101a2d9ec: d00e7dc8    	adrp	x8, 0x11e9e7000 <dyld_stub_binder+0x11e9e7000>
101a2d9f0: f9421901    	ldr	x1, [x8, #0x430] ; selector: setTableView:
101a2d9f4: d2800002    	mov	x2, #0x0                ; =0
101a2d9f8: 9587e89b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2d9fc: f87c6a80    	ldr	x0, [x20, x28]
101a2da00: aa1a03e1    	mov	x1, x26
101a2da04: 9587e898    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2da08: aa1d03fd    	mov	x29, x29
101a2da0c: 9587e89d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2da10: aa0003f5    	mov	x21, x0
101a2da14: b00e93c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a2da18: f9442901    	ldr	x1, [x8, #0x850] ; selector: count
101a2da1c: 9587e892    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2da20: aa0003fa    	mov	x26, x0
101a2da24: b00e9728    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a2da28: f943c100    	ldr	x0, [x8, #0x780]
101a2da2c: aa1703e1    	mov	x1, x23
101a2da30: 9587e88d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2da34: aa1d03fd    	mov	x29, x29
101a2da38: 9587e892    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2da3c: aa0003f7    	mov	x23, x0
101a2da40: d00e9728    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a2da44: f9448500    	ldr	x0, [x8, #0x908]
101a2da48: aa1803e1    	mov	x1, x24
101a2da4c: 9587e886    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2da50: aa0003e2    	mov	x2, x0
101a2da54: aa1703e0    	mov	x0, x23
101a2da58: aa1903e1    	mov	x1, x25
101a2da5c: 9587e882    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2da60: aa1d03fd    	mov	x29, x29
101a2da64: 9587e887    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2da68: aa0003f8    	mov	x24, x0
101a2da6c: b00e7d48    	adrp	x8, 0x11e9d6000 <dyld_stub_binder+0x11e9d6000>
101a2da70: f9426901    	ldr	x1, [x8, #0x4d0] ; selector: reportLogic
101a2da74: 9587e87c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2da78: aa1d03fd    	mov	x29, x29
101a2da7c: 9587e881    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2da80: aa0003f9    	mov	x25, x0
101a2da84: 900e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2da88: f9467101    	ldr	x1, [x8, #0xce0] ; selector: setLocalResultNum:
101a2da8c: aa1a03e2    	mov	x2, x26
101a2da90: 9587e875    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2da94: aa1903e0    	mov	x0, x25
101a2da98: 9587e876    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2da9c: aa1803e0    	mov	x0, x24
101a2daa0: 9587e874    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2daa4: aa1703e0    	mov	x0, x23
101a2daa8: 17fffe20    	b	0x101a2d328 <__text+0x1a25328>
101a2daac: aa1a03e0    	mov	x0, x26
101a2dab0: 9587e870    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2dab4: aa1903e0    	mov	x0, x25
101a2dab8: 9587e86e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2dabc: aa1803e0    	mov	x0, x24
101a2dac0: 9587e86c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2dac4: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2dac8: f9411501    	ldr	x1, [x8, #0x228] ; selector: filterMusicItemBySelectedType:resultArr:
101a2dacc: aa1403e0    	mov	x0, x20
101a2dad0: aa1703e2    	mov	x2, x23
101a2dad4: aa1303e3    	mov	x3, x19
101a2dad8: 9587e863    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dadc: aa1d03fd    	mov	x29, x29
101a2dae0: 9587e868    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2dae4: aa0003f7    	mov	x23, x0
101a2dae8: aa1303e0    	mov	x0, x19
101a2daec: 9587e861    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2daf0: 14000002    	b	0x101a2daf8 <__text+0x1a25af8>
101a2daf4: aa1303f7    	mov	x23, x19
101a2daf8: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2dafc: b98d7d18    	ldrsw	x24, [x8, #0xd7c] ; ivar: FavBaseListViewController.m_dataController offset=200
101a2db00: f8786a80    	ldr	x0, [x20, x24]
101a2db04: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2db08: f940fd01    	ldr	x1, [x8, #0x1f8] ; selector: addFavItemList:
101a2db0c: aa1703e2    	mov	x2, x23
101a2db10: 9587e855    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2db14: f8786a80    	ldr	x0, [x20, x24]
101a2db18: 900e7d68    	adrp	x8, 0x11e9d9000 <dyld_stub_binder+0x11e9d9000>
101a2db1c: f9417101    	ldr	x1, [x8, #0x2e0] ; selector: setHasMoreData:
101a2db20: aa1503e2    	mov	x2, x21
101a2db24: 9587e850    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2db28: f8786a82    	ldr	x2, [x20, x24]
101a2db2c: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2db30: b98da11c    	ldrsw	x28, [x8, #0xda0] ; ivar: FavBaseListViewController.m_tableView offset=136
101a2db34: f87c6a80    	ldr	x0, [x20, x28]
101a2db38: f00e7ce8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
101a2db3c: f947a901    	ldr	x1, [x8, #0xf50] ; selector: setDataSource:
101a2db40: 9587e849    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2db44: f8786a82    	ldr	x2, [x20, x24]
101a2db48: f87c6a80    	ldr	x0, [x20, x28]
101a2db4c: d00e93e8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
101a2db50: f9430d01    	ldr	x1, [x8, #0x618] ; selector: setDelegate:
101a2db54: 9587e844    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2db58: f87c6a82    	ldr	x2, [x20, x28]
101a2db5c: f8786a80    	ldr	x0, [x20, x24]
101a2db60: d00e7dc8    	adrp	x8, 0x11e9e7000 <dyld_stub_binder+0x11e9e7000>
101a2db64: f9421901    	ldr	x1, [x8, #0x430] ; selector: setTableView:
101a2db68: 9587e83f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2db6c: 34000856    	cbz	w22, 0x101a2dc74 <__text+0x1a25c74>
101a2db70: b00e9728    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a2db74: f943c100    	ldr	x0, [x8, #0x780]
101a2db78: 900e7ce8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a2db7c: f9440118    	ldr	x24, [x8, #0x800] ; selector: currentContext
101a2db80: aa1803e1    	mov	x1, x24
101a2db84: 9587e838    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2db88: aa1d03fd    	mov	x29, x29
101a2db8c: 9587e83d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2db90: aa0003f5    	mov	x21, x0
101a2db94: d00e9728    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a2db98: f9448500    	ldr	x0, [x8, #0x908]
101a2db9c: b00e93c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a2dba0: f9428519    	ldr	x25, [x8, #0x508] ; selector: class
101a2dba4: aa1903e1    	mov	x1, x25
101a2dba8: 9587e82f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dbac: aa0003e2    	mov	x2, x0
101a2dbb0: 900e7ce8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a2dbb4: f945211a    	ldr	x26, [x8, #0xa40] ; selector: getService:
101a2dbb8: aa1503e0    	mov	x0, x21
101a2dbbc: aa1a03e1    	mov	x1, x26
101a2dbc0: 9587e829    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dbc4: aa1d03fd    	mov	x29, x29
101a2dbc8: 9587e82e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2dbcc: aa0003f6    	mov	x22, x0
101a2dbd0: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2dbd4: b98dc508    	ldrsw	x8, [x8, #0xdc4] ; ivar: FavBaseListViewController.m_searchTaskKey offset=120
101a2dbd8: f8686a82    	ldr	x2, [x20, x8]
101a2dbdc: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2dbe0: f9417101    	ldr	x1, [x8, #0x2e0] ; selector: getTotalSearchCountForTaskKey:searchContent:
101a2dbe4: d2800003    	mov	x3, #0x0                ; =0
101a2dbe8: 9587e81f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dbec: 2a0003fb    	mov	w27, w0
101a2dbf0: b00e9728    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a2dbf4: f943c100    	ldr	x0, [x8, #0x780]
101a2dbf8: aa1803e1    	mov	x1, x24
101a2dbfc: 9587e81a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dc00: aa1d03fd    	mov	x29, x29
101a2dc04: 9587e81f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2dc08: aa0003f8    	mov	x24, x0
101a2dc0c: d00e9728    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a2dc10: f9448500    	ldr	x0, [x8, #0x908]
101a2dc14: aa1903e1    	mov	x1, x25
101a2dc18: 9587e813    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dc1c: aa0003e2    	mov	x2, x0
101a2dc20: aa1803e0    	mov	x0, x24
101a2dc24: aa1a03e1    	mov	x1, x26
101a2dc28: 9587e80f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dc2c: aa1d03fd    	mov	x29, x29
101a2dc30: 9587e814    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2dc34: aa0003f9    	mov	x25, x0
101a2dc38: b00e7d48    	adrp	x8, 0x11e9d6000 <dyld_stub_binder+0x11e9d6000>
101a2dc3c: f9426901    	ldr	x1, [x8, #0x4d0] ; selector: reportLogic
101a2dc40: 9587e809    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dc44: aa1d03fd    	mov	x29, x29
101a2dc48: 9587e80e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2dc4c: aa0003fa    	mov	x26, x0
101a2dc50: 900e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2dc54: f9467101    	ldr	x1, [x8, #0xce0] ; selector: setLocalResultNum:
101a2dc58: aa1b03e2    	mov	x2, x27
101a2dc5c: 9587e802    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dc60: aa1a03e0    	mov	x0, x26
101a2dc64: 9587e803    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2dc68: aa1903e0    	mov	x0, x25
101a2dc6c: 9587e801    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2dc70: 14000025    	b	0x101a2dd04 <__text+0x1a25d04>
101a2dc74: b00e93c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a2dc78: f9442901    	ldr	x1, [x8, #0x850] ; selector: count
101a2dc7c: aa1703e0    	mov	x0, x23
101a2dc80: 9587e7f9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dc84: aa0003f9    	mov	x25, x0
101a2dc88: b00e9728    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a2dc8c: f943c100    	ldr	x0, [x8, #0x780]
101a2dc90: 900e7ce8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a2dc94: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
101a2dc98: 9587e7f3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dc9c: aa1d03fd    	mov	x29, x29
101a2dca0: 9587e7f8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2dca4: aa0003f5    	mov	x21, x0
101a2dca8: d00e9728    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a2dcac: f9448500    	ldr	x0, [x8, #0x908]
101a2dcb0: b00e93c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a2dcb4: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
101a2dcb8: 9587e7eb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dcbc: aa0003e2    	mov	x2, x0
101a2dcc0: 900e7ce8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a2dcc4: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
101a2dcc8: aa1503e0    	mov	x0, x21
101a2dccc: 9587e7e6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dcd0: aa1d03fd    	mov	x29, x29
101a2dcd4: 9587e7eb    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2dcd8: aa0003f6    	mov	x22, x0
101a2dcdc: b00e7d48    	adrp	x8, 0x11e9d6000 <dyld_stub_binder+0x11e9d6000>
101a2dce0: f9426901    	ldr	x1, [x8, #0x4d0] ; selector: reportLogic
101a2dce4: 9587e7e0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dce8: aa1d03fd    	mov	x29, x29
101a2dcec: 9587e7e5    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2dcf0: aa0003f8    	mov	x24, x0
101a2dcf4: 900e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2dcf8: f9467101    	ldr	x1, [x8, #0xce0] ; selector: setLocalResultNum:
101a2dcfc: aa1903e2    	mov	x2, x25
101a2dd00: 9587e7d9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dd04: aa1803e0    	mov	x0, x24
101a2dd08: 9587e7da    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2dd0c: aa1603e0    	mov	x0, x22
101a2dd10: 9587e7d8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2dd14: aa1503e0    	mov	x0, x21
101a2dd18: 9587e7d6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2dd1c: f87c6a80    	ldr	x0, [x20, x28]
101a2dd20: f00e7ce8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
101a2dd24: f9414901    	ldr	x1, [x8, #0x290] ; selector: reloadData
101a2dd28: 9587e7cf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dd2c: aa1703e0    	mov	x0, x23
101a2dd30: 9587e7d0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2dd34: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2dd38: f9417501    	ldr	x1, [x8, #0x2e8] ; selector: updateSearchEmptyStateAfterPresentingResults
101a2dd3c: aa1403e0    	mov	x0, x20
101a2dd40: 9587e7c9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dd44: 52800014    	mov	w20, #0x0               ; =0
101a2dd48: aa1303e0    	mov	x0, x19
101a2dd4c: 9587e7c9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2dd50: aa1403e0    	mov	x0, x20
101a2dd54: a9497bfd    	ldp	x29, x30, [sp, #0x90]
101a2dd58: a9484ff4    	ldp	x20, x19, [sp, #0x80]
101a2dd5c: a94757f6    	ldp	x22, x21, [sp, #0x70]
101a2dd60: a9465ff8    	ldp	x24, x23, [sp, #0x60]
101a2dd64: a94567fa    	ldp	x26, x25, [sp, #0x50]
101a2dd68: a9446ffc    	ldp	x28, x27, [sp, #0x40]
101a2dd6c: 910283ff    	add	sp, sp, #0xa0
101a2dd70: d65f03c0    	ret
101a2dd74: 900e93e8    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
101a2dd78: f9418d01    	ldr	x1, [x8, #0x318] ; selector: mutableCopy
101a2dd7c: aa0203e0    	mov	x0, x2
101a2dd80: 9587e7b9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dd84: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2dd88: b98d8116    	ldrsw	x22, [x8, #0xd80] ; ivar: FavBaseListViewController.m_arrFinderItems offset=176
101a2dd8c: f8766a88    	ldr	x8, [x20, x22]
101a2dd90: f8366a80    	str	x0, [x20, x22]
101a2dd94: aa0803e0    	mov	x0, x8
101a2dd98: 9587e7b6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2dd9c: f8766a80    	ldr	x0, [x20, x22]
101a2dda0: aa1803e1    	mov	x1, x24
101a2dda4: 9587e7b0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dda8: aa0003fa    	mov	x26, x0
101a2ddac: b00e9728    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a2ddb0: f943c100    	ldr	x0, [x8, #0x780]
101a2ddb4: 900e7ce8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a2ddb8: f9440116    	ldr	x22, [x8, #0x800] ; selector: currentContext
101a2ddbc: aa1603e1    	mov	x1, x22
101a2ddc0: 9587e7a9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2ddc4: aa1d03fd    	mov	x29, x29
101a2ddc8: 9587e7ae    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2ddcc: aa0003fb    	mov	x27, x0
101a2ddd0: d00e9728    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a2ddd4: f9448500    	ldr	x0, [x8, #0x908]
101a2ddd8: b00e93c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a2dddc: f9428518    	ldr	x24, [x8, #0x508] ; selector: class
101a2dde0: aa1803e1    	mov	x1, x24
101a2dde4: 9587e7a0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dde8: aa0003e2    	mov	x2, x0
101a2ddec: 900e7ce8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a2ddf0: f9452119    	ldr	x25, [x8, #0xa40] ; selector: getService:
101a2ddf4: aa1b03e0    	mov	x0, x27
101a2ddf8: aa1903e1    	mov	x1, x25
101a2ddfc: 9587e79a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2de00: aa1d03fd    	mov	x29, x29
101a2de04: 9587e79f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2de08: aa0003fc    	mov	x28, x0
101a2de0c: b00e7d48    	adrp	x8, 0x11e9d6000 <dyld_stub_binder+0x11e9d6000>
101a2de10: f9426901    	ldr	x1, [x8, #0x4d0] ; selector: reportLogic
101a2de14: 9587e794    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2de18: aa1d03fd    	mov	x29, x29
101a2de1c: 9587e799    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2de20: aa0003f7    	mov	x23, x0
101a2de24: 900e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2de28: f9467101    	ldr	x1, [x8, #0xce0] ; selector: setLocalResultNum:
101a2de2c: aa1a03e2    	mov	x2, x26
101a2de30: 9587e78d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2de34: aa1703e0    	mov	x0, x23
101a2de38: 9587e78e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2de3c: aa1c03e0    	mov	x0, x28
101a2de40: 9587e78c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2de44: aa1b03e0    	mov	x0, x27
101a2de48: 9587e78a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2de4c: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2de50: b98df11a    	ldrsw	x26, [x8, #0xdf0] ; ivar: FavBaseListViewController.m_feedFlowView offset=168
101a2de54: f87a6a80    	ldr	x0, [x20, x26]
101a2de58: b50000c0    	cbnz	x0, 0x101a2de70 <__text+0x1a25e70>
101a2de5c: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2de60: f9415501    	ldr	x1, [x8, #0x2a8] ; selector: initFeedFlowView
101a2de64: aa1403e0    	mov	x0, x20
101a2de68: 9587e77f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2de6c: f87a6a80    	ldr	x0, [x20, x26]
101a2de70: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2de74: f9415901    	ldr	x1, [x8, #0x2b0] ; selector: finderFeedFlowViewWillAppear
101a2de78: 9587e77b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2de7c: f87a6a80    	ldr	x0, [x20, x26]
101a2de80: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2de84: f9415d01    	ldr	x1, [x8, #0x2b8] ; selector: finderFeedFlowViewDidAppear
101a2de88: 9587e777    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2de8c: 710002bf    	cmp	w21, #0x0
101a2de90: 528000a8    	mov	w8, #0x5                ; =5
101a2de94: 9a9f0508    	csinc	x8, x8, xzr, eq
101a2de98: b00e9b29    	adrp	x9, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2de9c: b98e2d29    	ldrsw	x9, [x9, #0xe2c] ; ivar: FavBaseListViewController.m_feedFlowViewState offset=184
101a2dea0: f8296a88    	str	x8, [x20, x9]
101a2dea4: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2dea8: b98e2917    	ldrsw	x23, [x8, #0xe28] ; ivar: FavBaseListViewController.m_feedDetailViewController offset=192
101a2deac: 8b170280    	add	x0, x20, x23
101a2deb0: 9587e76b    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
101a2deb4: aa0003f5    	mov	x21, x0
101a2deb8: 9587e76e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2debc: f9401ffc    	ldr	x28, [sp, #0x38]
101a2dec0: b40002b5    	cbz	x21, 0x101a2df14 <__text+0x1a25f14>
101a2dec4: 8b170280    	add	x0, x20, x23
101a2dec8: 9587e765    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
101a2decc: aa0003f5    	mov	x21, x0
101a2ded0: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2ded4: f9416101    	ldr	x1, [x8, #0x2c0] ; selector: convertFeedContentVMsToCustomBusinessFeedIDModels:
101a2ded8: aa1403e0    	mov	x0, x20
101a2dedc: aa1c03e2    	mov	x2, x28
101a2dee0: 9587e761    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dee4: aa1d03fd    	mov	x29, x29
101a2dee8: 9587e766    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2deec: aa0003f7    	mov	x23, x0
101a2def0: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2def4: f9416501    	ldr	x1, [x8, #0x2c8] ; selector: appendBusinessModelArray:
101a2def8: aa1503e0    	mov	x0, x21
101a2defc: aa1703e2    	mov	x2, x23
101a2df00: 9587e759    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2df04: aa1703e0    	mov	x0, x23
101a2df08: 9587e75a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2df0c: aa1503e0    	mov	x0, x21
101a2df10: 9587e758    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2df14: f87a6a80    	ldr	x0, [x20, x26]
101a2df18: f00e7ce8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
101a2df1c: f9414901    	ldr	x1, [x8, #0x290] ; selector: reloadData
101a2df20: 9587e751    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2df24: b00e9728    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a2df28: f9445100    	ldr	x0, [x8, #0x8a0]
101a2df2c: f00e7d08    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
101a2df30: f9432501    	ldr	x1, [x8, #0x648] ; selector: genCurrentTimeInMsFrom1970
101a2df34: 9587e74c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2df38: b00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2df3c: b98e3115    	ldrsw	x21, [x8, #0xe30] ; ivar: FavBaseListViewController.showFinderTime offset=360
101a2df40: f8356a80    	str	x0, [x20, x21]
101a2df44: f00e9728    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
101a2df48: f944d517    	ldr	x23, [x8, #0x9a8]
101a2df4c: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2df50: f9413501    	ldr	x1, [x8, #0x268] ; selector: feedViewControllerScene
101a2df54: aa1403e0    	mov	x0, x20
101a2df58: 9587e743    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2df5c: aa0003fa    	mov	x26, x0
101a2df60: f8756a9b    	ldr	x27, [x20, x21]
101a2df64: b00e9728    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a2df68: f943c100    	ldr	x0, [x8, #0x780]
101a2df6c: aa1603e1    	mov	x1, x22
101a2df70: 9587e73d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2df74: aa1d03fd    	mov	x29, x29
101a2df78: 9587e742    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2df7c: aa0003f5    	mov	x21, x0
101a2df80: b00e9728    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a2df84: f944b900    	ldr	x0, [x8, #0x970]
101a2df88: aa1803e1    	mov	x1, x24
101a2df8c: 9587e736    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2df90: aa0003e2    	mov	x2, x0
101a2df94: aa1503e0    	mov	x0, x21
101a2df98: aa1903e1    	mov	x1, x25
101a2df9c: 9587e732    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dfa0: aa1d03fd    	mov	x29, x29
101a2dfa4: 9587e737    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2dfa8: aa0003f6    	mov	x22, x0
101a2dfac: d00e7ce8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
101a2dfb0: f946c901    	ldr	x1, [x8, #0xd90] ; selector: getSelfContact
101a2dfb4: 9587e72c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dfb8: aa1d03fd    	mov	x29, x29
101a2dfbc: 9587e731    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2dfc0: aa0003f8    	mov	x24, x0
101a2dfc4: f00e7ce8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
101a2dfc8: f9472101    	ldr	x1, [x8, #0xe40] ; selector: username
101a2dfcc: 9587e726    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2dfd0: aa1d03fd    	mov	x29, x29
101a2dfd4: 9587e72b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2dfd8: aa0003f9    	mov	x25, x0
101a2dfdc: b00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2dfe0: f9413901    	ldr	x1, [x8, #0x270] ; selector: reportEnterPage:eventCode:eventTime:username:extInfo:refCommentScene:leaveTime:
101a2dfe4: f90003ff    	str	xzr, [sp]
101a2dfe8: aa1703e0    	mov	x0, x23
101a2dfec: aa1a03e2    	mov	x2, x26
101a2dff0: d2800003    	mov	x3, #0x0                ; =0
101a2dff4: aa1b03e4    	mov	x4, x27
101a2dff8: aa1903e5    	mov	x5, x25
101a2dffc: d2800006    	mov	x6, #0x0                ; =0
101a2e000: 52800007    	mov	w7, #0x0                ; =0
101a2e004: 9587e718    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2e008: aa1903e0    	mov	x0, x25
101a2e00c: 9587e719    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2e010: aa1803e0    	mov	x0, x24
101a2e014: 9587e717    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2e018: aa1603e0    	mov	x0, x22
101a2e01c: 9587e715    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2e020: aa1503e0    	mov	x0, x21
101a2e024: 9587e713    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2e028: aa1c03e0    	mov	x0, x28
101a2e02c: 9587e711    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2e030: 900e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2e034: b98da108    	ldrsw	x8, [x8, #0xda0] ; ivar: FavBaseListViewController.m_tableView offset=136
101a2e038: f8686a80    	ldr	x0, [x20, x8]
101a2e03c: d00e7ce8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
101a2e040: f9414901    	ldr	x1, [x8, #0x290] ; selector: reloadData
101a2e044: 9587e708    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2e048: 17ffff3b    	b	0x101a2dd34 <__text+0x1a25d34>
