
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1017e16cc: d10143ff    	sub	sp, sp, #0x50
1017e16d0: a9015ff8    	stp	x24, x23, [sp, #0x10]
1017e16d4: a90257f6    	stp	x22, x21, [sp, #0x20]
1017e16d8: a9034ff4    	stp	x20, x19, [sp, #0x30]
1017e16dc: a9047bfd    	stp	x29, x30, [sp, #0x40]
1017e16e0: 910103fd    	add	x29, sp, #0x40
1017e16e4: aa0203f5    	mov	x21, x2
1017e16e8: aa0003f3    	mov	x19, x0
1017e16ec: d00df068    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1017e16f0: f9405908    	ldr	x8, [x8, #0xb0]
1017e16f4: f9400108    	ldr	x8, [x8]
1017e16f8: f90007e8    	str	x8, [sp, #0x8]
1017e16fc: b00fa288    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
1017e1700: 52800029    	mov	w9, #0x1                ; =1
1017e1704: 3929c109    	strb	w9, [x8, #0xa70]
1017e1708: b00f3628    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1017e170c: f943a114    	ldr	x20, [x8, #0x740] ; ftsTaskKey
1017e1710: aa0203e0    	mov	x0, x2
1017e1714: 95911689    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1017e1718: aa1303e0    	mov	x0, x19
1017e171c: aa1403e1    	mov	x1, x20
1017e1720: 95911687    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e1724: aa1d03fd    	mov	x29, x29
1017e1728: 95911688    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e172c: aa0003f6    	mov	x22, x0
1017e1730: d00f4908    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1017e1734: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
1017e1738: aa1503e0    	mov	x0, x21
1017e173c: aa1603e2    	mov	x2, x22
1017e1740: 9591167f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e1744: aa0003f7    	mov	x23, x0
1017e1748: aa1503e0    	mov	x0, x21
1017e174c: 95911682    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e1750: aa1603e0    	mov	x0, x22
1017e1754: 95911680    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e1758: 34000cd7    	cbz	w23, 0x1017e18f0 <__text+0x17d98f0>
1017e175c: d00f4c88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1017e1760: f945e900    	ldr	x0, [x8, #0xbd0]
1017e1764: f00f48e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1017e1768: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1017e176c: 95911674    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e1770: aa1d03fd    	mov	x29, x29
1017e1774: 95911675    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e1778: aa0003f5    	mov	x21, x0
1017e177c: d00f4c88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1017e1780: f9477100    	ldr	x0, [x8, #0xee0]
1017e1784: d00f48e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1017e1788: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1017e178c: 9591166c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e1790: aa0003e2    	mov	x2, x0
1017e1794: 900f32c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1017e1798: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
1017e179c: aa1503e0    	mov	x0, x21
1017e17a0: 95911667    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e17a4: aa1d03fd    	mov	x29, x29
1017e17a8: 95911668    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e17ac: aa0003f6    	mov	x22, x0
1017e17b0: d00f32c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1017e17b4: f9430d01    	ldr	x1, [x8, #0x618] ; ftsContactMgr
1017e17b8: 95911661    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e17bc: aa1d03fd    	mov	x29, x29
1017e17c0: 95911662    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e17c4: aa0003f7    	mov	x23, x0
1017e17c8: aa1303e0    	mov	x0, x19
1017e17cc: aa1403e1    	mov	x1, x20
1017e17d0: 9591165b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e17d4: aa1d03fd    	mov	x29, x29
1017e17d8: 9591165c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e17dc: aa0003f8    	mov	x24, x0
1017e17e0: b00f3548    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1017e17e4: f9429901    	ldr	x1, [x8, #0x530] ; getSingleContactsWithTaskKey:
1017e17e8: aa1703e0    	mov	x0, x23
1017e17ec: aa1803e2    	mov	x2, x24
1017e17f0: 95911653    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e17f4: aa1d03fd    	mov	x29, x29
1017e17f8: 95911654    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e17fc: aa0003f4    	mov	x20, x0
1017e1800: aa1803e0    	mov	x0, x24
1017e1804: 95911654    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e1808: aa1703e0    	mov	x0, x23
1017e180c: 95911652    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e1810: aa1603e0    	mov	x0, x22
1017e1814: 95911650    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e1818: aa1503e0    	mov	x0, x21
1017e181c: 9591164e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e1820: b00f4ce8    	adrp	x8, 0x12017e000 <dyld_stub_binder+0x12017e000>
1017e1824: f947f900    	ldr	x0, [x8, #0xff0]
1017e1828: 9591164e    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1017e182c: aa0003f5    	mov	x21, x0
1017e1830: b00f35c8    	adrp	x8, 0x11fe9a000 <dyld_stub_binder+0x11fe9a000>
1017e1834: f943ad01    	ldr	x1, [x8, #0x758] ; sectionType
1017e1838: aa1303e0    	mov	x0, x19
1017e183c: 95911640    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e1840: aa0003f6    	mov	x22, x0
1017e1844: b00f3628    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1017e1848: f9426101    	ldr	x1, [x8, #0x4c0] ; isDetailSearch
1017e184c: aa1303e0    	mov	x0, x19
1017e1850: 9591163b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e1854: aa0003e4    	mov	x4, x0
1017e1858: b00f3628    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1017e185c: f943e101    	ldr	x1, [x8, #0x7c0] ; initWithType:contacts:isDetailSearch:
1017e1860: aa1503e0    	mov	x0, x21
1017e1864: aa1603e2    	mov	x2, x22
1017e1868: aa1403e3    	mov	x3, x20
1017e186c: 95911634    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e1870: aa0003f5    	mov	x21, x0
1017e1874: b00f3628    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1017e1878: f942b501    	ldr	x1, [x8, #0x568] ; resultPage
1017e187c: aa1303e0    	mov	x0, x19
1017e1880: 9591162f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e1884: aa1d03fd    	mov	x29, x29
1017e1888: 95911630    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e188c: aa0003f3    	mov	x19, x0
1017e1890: f90003f5    	str	x21, [sp]
1017e1894: d00f4c88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1017e1898: f9456d00    	ldr	x0, [x8, #0xad8]
1017e189c: d00f48e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1017e18a0: f941c501    	ldr	x1, [x8, #0x388] ; arrayWithObjects:count:
1017e18a4: 910003e2    	mov	x2, sp
1017e18a8: 52800023    	mov	w3, #0x1                ; =1
1017e18ac: 95911624    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e18b0: aa1d03fd    	mov	x29, x29
1017e18b4: 95911625    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e18b8: aa0003f6    	mov	x22, x0
1017e18bc: b00f3628    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1017e18c0: f942b901    	ldr	x1, [x8, #0x570] ; reloadListWithDataUpdate:
1017e18c4: aa1303e0    	mov	x0, x19
1017e18c8: aa1603e2    	mov	x2, x22
1017e18cc: 9591161c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e18d0: aa1603e0    	mov	x0, x22
1017e18d4: 95911620    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e18d8: aa1303e0    	mov	x0, x19
1017e18dc: 9591161e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e18e0: aa1503e0    	mov	x0, x21
1017e18e4: 9591161c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e18e8: aa1403e0    	mov	x0, x20
1017e18ec: 9591161a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e18f0: f94007e8    	ldr	x8, [sp, #0x8]
1017e18f4: d00df069    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1017e18f8: f9405929    	ldr	x9, [x9, #0xb0]
1017e18fc: f9400129    	ldr	x9, [x9]
1017e1900: eb08013f    	cmp	x9, x8
1017e1904: 540000e1    	b.ne	0x1017e1920 <__text+0x17d9920>
1017e1908: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1017e190c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1017e1910: a94257f6    	ldp	x22, x21, [sp, #0x20]
1017e1914: a9415ff8    	ldp	x24, x23, [sp, #0x10]
1017e1918: 910143ff    	add	sp, sp, #0x50
1017e191c: d65f03c0    	ret
1017e1920: 95911615    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
