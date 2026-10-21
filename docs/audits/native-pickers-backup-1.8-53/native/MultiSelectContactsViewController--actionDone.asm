
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ea1644: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
104ea1648: a90167fa    	stp	x26, x25, [sp, #0x10]
104ea164c: a9025ff8    	stp	x24, x23, [sp, #0x20]
104ea1650: a90357f6    	stp	x22, x21, [sp, #0x30]
104ea1654: a9044ff4    	stp	x20, x19, [sp, #0x40]
104ea1658: a9057bfd    	stp	x29, x30, [sp, #0x50]
104ea165c: 910143fd    	add	x29, sp, #0x50
104ea1660: d106c3ff    	sub	sp, sp, #0x1b0
104ea1664: aa0003fc    	mov	x28, x0
104ea1668: d00c3a68    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104ea166c: f9405908    	ldr	x8, [x8, #0xb0]
104ea1670: f9400108    	ldr	x8, [x8]
104ea1674: f81a03a8    	stur	x8, [x29, #-0x60]
104ea1678: d00dece8    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
104ea167c: 52800029    	mov	w9, #0x1                ; =1
104ea1680: 39079909    	strb	w9, [x8, #0x1e6]
104ea1684: d00d9688    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104ea1688: f9455500    	ldr	x0, [x8, #0xaa8]
104ea168c: 94b616b3    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104ea1690: f9000fe0    	str	x0, [sp, #0x18]
104ea1694: f00d7e88    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
104ea1698: f9466513    	ldr	x19, [x8, #0xcc8] ; m_commonSearchScene
104ea169c: aa1c03e0    	mov	x0, x28
104ea16a0: aa1303e1    	mov	x1, x19
104ea16a4: 94b616a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea16a8: f1003c1f    	cmp	x0, #0xf
104ea16ac: aa1c03f5    	mov	x21, x28
104ea16b0: 54000200    	b.eq	0x104ea16f0 <_Flutter_MMFoundation_BindContext+0x137d2d4>
104ea16b4: aa1c03e0    	mov	x0, x28
104ea16b8: aa1303e1    	mov	x1, x19
104ea16bc: 94b616a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea16c0: f100481f    	cmp	x0, #0x12
104ea16c4: 54000160    	b.eq	0x104ea16f0 <_Flutter_MMFoundation_BindContext+0x137d2d4>
104ea16c8: aa1c03e0    	mov	x0, x28
104ea16cc: aa1303e1    	mov	x1, x19
104ea16d0: 94b6169b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea16d4: f100541f    	cmp	x0, #0x15
104ea16d8: 540000c0    	b.eq	0x104ea16f0 <_Flutter_MMFoundation_BindContext+0x137d2d4>
104ea16dc: aa1c03e0    	mov	x0, x28
104ea16e0: aa1303e1    	mov	x1, x19
104ea16e4: 94b61696    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea16e8: f100641f    	cmp	x0, #0x19
104ea16ec: 54002141    	b.ne	0x104ea1b14 <_Flutter_MMFoundation_BindContext+0x137d6f8>
104ea16f0: 4f00e400    	movi.16b	v0, #0x0
104ea16f4: ad0403e0    	stp	q0, q0, [sp, #0x80]
104ea16f8: ad0303e0    	stp	q0, q0, [sp, #0x60]
104ea16fc: b00d9c28    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea1700: b9485116    	ldr	w22, [x8, #0x850]
104ea1704: f876cb80    	ldr	x0, [x28, w22, sxtw]
104ea1708: f00d7f28    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
104ea170c: f940e901    	ldr	x1, [x8, #0x1d0] ; multiSelectOrderKey
104ea1710: 94b6168b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1714: aa1d03fd    	mov	x29, x29
104ea1718: 94b6168c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea171c: f00d92e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104ea1720: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
104ea1724: 910183e2    	add	x2, sp, #0x60
104ea1728: d10383a3    	sub	x3, x29, #0xe0
104ea172c: a90083e1    	stp	x1, x0, [sp, #0x8]
104ea1730: 52800204    	mov	w4, #0x10               ; =16
104ea1734: 94b61682    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1738: b4000640    	cbz	x0, 0x104ea1800 <_Flutter_MMFoundation_BindContext+0x137d3e4>
104ea173c: aa0003f7    	mov	x23, x0
104ea1740: f9403be8    	ldr	x8, [sp, #0x70]
104ea1744: f9400114    	ldr	x20, [x8]
104ea1748: d2800013    	mov	x19, #0x0               ; =0
104ea174c: 900d7e48    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104ea1750: f9415518    	ldr	x24, [x8, #0x2a8] ; m_dicMultiSelect
104ea1754: f00d9308    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104ea1758: f947f119    	ldr	x25, [x8, #0xfe0] ; objectForKey:
104ea175c: b00d7cc8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104ea1760: f943c51a    	ldr	x26, [x8, #0x788] ; safeAddObject:
104ea1764: f9403be8    	ldr	x8, [sp, #0x70]
104ea1768: f9400108    	ldr	x8, [x8]
104ea176c: eb14011f    	cmp	x8, x20
104ea1770: 54000060    	b.eq	0x104ea177c <_Flutter_MMFoundation_BindContext+0x137d360>
104ea1774: f9400be0    	ldr	x0, [sp, #0x10]
104ea1778: 94b61676    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
104ea177c: f94037e8    	ldr	x8, [sp, #0x68]
104ea1780: f873791b    	ldr	x27, [x8, x19, lsl #3]
104ea1784: f876cb80    	ldr	x0, [x28, w22, sxtw]
104ea1788: aa1803e1    	mov	x1, x24
104ea178c: 94b6166c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1790: aa1d03fd    	mov	x29, x29
104ea1794: 94b6166d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea1798: aa0003fc    	mov	x28, x0
104ea179c: aa1903e1    	mov	x1, x25
104ea17a0: aa1b03e2    	mov	x2, x27
104ea17a4: 94b61666    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea17a8: aa1d03fd    	mov	x29, x29
104ea17ac: 94b61667    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea17b0: aa0003fb    	mov	x27, x0
104ea17b4: f9400fe0    	ldr	x0, [sp, #0x18]
104ea17b8: aa1a03e1    	mov	x1, x26
104ea17bc: aa1b03e2    	mov	x2, x27
104ea17c0: 94b6165f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea17c4: aa1b03e0    	mov	x0, x27
104ea17c8: 94b61663    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea17cc: aa1c03e0    	mov	x0, x28
104ea17d0: aa1503fc    	mov	x28, x21
104ea17d4: 94b61660    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea17d8: 91000673    	add	x19, x19, #0x1
104ea17dc: eb1302ff    	cmp	x23, x19
104ea17e0: 54fffc21    	b.ne	0x104ea1764 <_Flutter_MMFoundation_BindContext+0x137d348>
104ea17e4: 910183e2    	add	x2, sp, #0x60
104ea17e8: d10383a3    	sub	x3, x29, #0xe0
104ea17ec: a94083e1    	ldp	x1, x0, [sp, #0x8]
104ea17f0: 52800204    	mov	w4, #0x10               ; =16
104ea17f4: 94b61652    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea17f8: aa0003f7    	mov	x23, x0
104ea17fc: b5fffa60    	cbnz	x0, 0x104ea1748 <_Flutter_MMFoundation_BindContext+0x137d32c>
104ea1800: aa1603f7    	mov	x23, x22
104ea1804: f9400be0    	ldr	x0, [sp, #0x10]
104ea1808: 94b61653    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea180c: b00d9c28    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea1810: b988591a    	ldrsw	x26, [x8, #0x858]
104ea1814: 8b1a0380    	add	x0, x28, x26
104ea1818: 94b6165d    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104ea181c: b00d933b    	adrp	x27, 0x120106000 <dyld_stub_binder+0x120106000>
104ea1820: b4000300    	cbz	x0, 0x104ea1880 <_Flutter_MMFoundation_BindContext+0x137d464>
104ea1824: aa0003f6    	mov	x22, x0
104ea1828: 8b1a0380    	add	x0, x28, x26
104ea182c: 94b61658    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104ea1830: aa0003f9    	mov	x25, x0
104ea1834: b00d7da8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
104ea1838: f942b115    	ldr	x21, [x8, #0x560] ; onMultiSelectContactReturn:
104ea183c: f9436361    	ldr	x1, [x27, #0x6c0] ; respondsToSelector:
104ea1840: aa1503e2    	mov	x2, x21
104ea1844: 94b6163e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1848: aa0003f8    	mov	x24, x0
104ea184c: aa1903e0    	mov	x0, x25
104ea1850: 94b61641    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea1854: aa1603e0    	mov	x0, x22
104ea1858: 94b6163f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea185c: 34000138    	cbz	w24, 0x104ea1880 <_Flutter_MMFoundation_BindContext+0x137d464>
104ea1860: 8b1a0380    	add	x0, x28, x26
104ea1864: 94b6164a    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104ea1868: aa0003f6    	mov	x22, x0
104ea186c: aa1503e1    	mov	x1, x21
104ea1870: f9400fe2    	ldr	x2, [sp, #0x18]
104ea1874: 94b61632    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1878: aa1603e0    	mov	x0, x22
104ea187c: 94b61636    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea1880: 8b1a0380    	add	x0, x28, x26
104ea1884: 94b61642    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104ea1888: b4000300    	cbz	x0, 0x104ea18e8 <_Flutter_MMFoundation_BindContext+0x137d4cc>
104ea188c: aa0003f6    	mov	x22, x0
104ea1890: 8b1a0380    	add	x0, x28, x26
104ea1894: 94b6163e    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104ea1898: aa0003f9    	mov	x25, x0
104ea189c: 900d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea18a0: f946f115    	ldr	x21, [x8, #0xde0] ; onMultiSelectContactReturnForSns:
104ea18a4: f9436361    	ldr	x1, [x27, #0x6c0] ; respondsToSelector:
104ea18a8: aa1503e2    	mov	x2, x21
104ea18ac: 94b61624    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea18b0: aa0003f8    	mov	x24, x0
104ea18b4: aa1903e0    	mov	x0, x25
104ea18b8: 94b61627    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea18bc: aa1603e0    	mov	x0, x22
104ea18c0: 94b61625    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea18c4: 34000138    	cbz	w24, 0x104ea18e8 <_Flutter_MMFoundation_BindContext+0x137d4cc>
104ea18c8: 8b1a0380    	add	x0, x28, x26
104ea18cc: 94b61630    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104ea18d0: aa0003f6    	mov	x22, x0
104ea18d4: aa1503e1    	mov	x1, x21
104ea18d8: f9400fe2    	ldr	x2, [sp, #0x18]
104ea18dc: 94b61618    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea18e0: aa1603e0    	mov	x0, x22
104ea18e4: 94b6161c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea18e8: 8b1a0380    	add	x0, x28, x26
104ea18ec: 94b61628    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104ea18f0: b40006c0    	cbz	x0, 0x104ea19c8 <_Flutter_MMFoundation_BindContext+0x137d5ac>
104ea18f4: aa0003f6    	mov	x22, x0
104ea18f8: 8b1a0380    	add	x0, x28, x26
104ea18fc: 94b61624    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104ea1900: aa0003f9    	mov	x25, x0
104ea1904: 900d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea1908: f946f515    	ldr	x21, [x8, #0xde8] ; onMultiSelectContactReturn:selectContactFromGroup:
104ea190c: f9436361    	ldr	x1, [x27, #0x6c0] ; respondsToSelector:
104ea1910: aa1503e2    	mov	x2, x21
104ea1914: 94b6160a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1918: aa0003f8    	mov	x24, x0
104ea191c: aa1903e0    	mov	x0, x25
104ea1920: 94b6160d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea1924: aa1603e0    	mov	x0, x22
104ea1928: 94b6160b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea192c: 340004f8    	cbz	w24, 0x104ea19c8 <_Flutter_MMFoundation_BindContext+0x137d5ac>
104ea1930: 8b1a0380    	add	x0, x28, x26
104ea1934: 94b61616    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104ea1938: aa0003f6    	mov	x22, x0
104ea193c: f877cb80    	ldr	x0, [x28, w23, sxtw]
104ea1940: 900d7e48    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104ea1944: f9415501    	ldr	x1, [x8, #0x2a8] ; m_dicMultiSelect
104ea1948: 94b615fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea194c: aa1d03fd    	mov	x29, x29
104ea1950: 94b615fe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea1954: aa0003fa    	mov	x26, x0
104ea1958: b00d92e8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
104ea195c: f947f518    	ldr	x24, [x8, #0xfe8] ; allKeys
104ea1960: aa1803e1    	mov	x1, x24
104ea1964: 94b615f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1968: aa1d03fd    	mov	x29, x29
104ea196c: 94b615f7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea1970: aa0003f9    	mov	x25, x0
104ea1974: b00d9c28    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea1978: b9883108    	ldrsw	x8, [x8, #0x830]
104ea197c: f8686b80    	ldr	x0, [x28, x8]
104ea1980: aa1803e1    	mov	x1, x24
104ea1984: 94b615ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1988: aa1d03fd    	mov	x29, x29
104ea198c: 94b615ef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea1990: aa0003f8    	mov	x24, x0
104ea1994: aa1603e0    	mov	x0, x22
104ea1998: aa1503e1    	mov	x1, x21
104ea199c: aa1903e2    	mov	x2, x25
104ea19a0: aa1803e3    	mov	x3, x24
104ea19a4: 94b615e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea19a8: aa1803e0    	mov	x0, x24
104ea19ac: 94b615ea    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea19b0: aa1903e0    	mov	x0, x25
104ea19b4: 94b615e8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea19b8: aa1a03e0    	mov	x0, x26
104ea19bc: 94b615e6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea19c0: aa1603e0    	mov	x0, x22
104ea19c4: 94b615e4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea19c8: f877cb80    	ldr	x0, [x28, w23, sxtw]
104ea19cc: f00d7f28    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
104ea19d0: f9404501    	ldr	x1, [x8, #0x88] ; m_bShowContactRecommend
104ea19d4: 94b615da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea19d8: 340000c0    	cbz	w0, 0x104ea19f0 <_Flutter_MMFoundation_BindContext+0x137d5d4>
104ea19dc: d00d7f28    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
104ea19e0: f9437d01    	ldr	x1, [x8, #0x6f8] ; reportRecommendInfo:
104ea19e4: aa1c03e0    	mov	x0, x28
104ea19e8: 52800042    	mov	w2, #0x2                ; =2
104ea19ec: 94b615d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea19f0: b00d7f48    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
104ea19f4: f9400d01    	ldr	x1, [x8, #0x18] ; reportBizType
104ea19f8: aa1c03e0    	mov	x0, x28
104ea19fc: 94b615d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1a00: b4000600    	cbz	x0, 0x104ea1ac0 <_Flutter_MMFoundation_BindContext+0x137d6a4>
104ea1a04: b00d7d48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104ea1a08: f940cd01    	ldr	x1, [x8, #0x198] ; pageSheetAdapter
104ea1a0c: aa1c03e0    	mov	x0, x28
104ea1a10: 94b615cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1a14: aa1d03fd    	mov	x29, x29
104ea1a18: 94b615cc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea1a1c: aa0003f5    	mov	x21, x0
104ea1a20: 94b615cd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea1a24: b50004f5    	cbnz	x21, 0x104ea1ac0 <_Flutter_MMFoundation_BindContext+0x137d6a4>
104ea1a28: b00d9c28    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea1a2c: b9881508    	ldrsw	x8, [x8, #0x814]
104ea1a30: f8686b80    	ldr	x0, [x28, x8]
104ea1a34: f00d92e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104ea1a38: f9435115    	ldr	x21, [x8, #0x6a0] ; count
104ea1a3c: aa1503e1    	mov	x1, x21
104ea1a40: 94b615bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1a44: aa0003f6    	mov	x22, x0
104ea1a48: 900d7f48    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
104ea1a4c: f9435901    	ldr	x1, [x8, #0x6b0] ; isRemovingMember
104ea1a50: aa1c03e0    	mov	x0, x28
104ea1a54: 94b615ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1a58: 340001c0    	cbz	w0, 0x104ea1a90 <_Flutter_MMFoundation_BindContext+0x137d674>
104ea1a5c: f877cb80    	ldr	x0, [x28, w23, sxtw]
104ea1a60: f00d7e88    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
104ea1a64: f946e101    	ldr	x1, [x8, #0xdc0] ; m_contactsDataLogic
104ea1a68: 94b615b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1a6c: aa1d03fd    	mov	x29, x29
104ea1a70: 94b615b6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea1a74: aa0003f7    	mov	x23, x0
104ea1a78: f00d7e88    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
104ea1a7c: f9444101    	ldr	x1, [x8, #0x880] ; getContactCount
104ea1a80: 94b615af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1a84: 2a0003f6    	mov	w22, w0
104ea1a88: aa1703e0    	mov	x0, x23
104ea1a8c: 94b615b2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea1a90: b00d9c28    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea1a94: b9882908    	ldrsw	x8, [x8, #0x828]
104ea1a98: f8686b80    	ldr	x0, [x28, x8]
104ea1a9c: aa1503e1    	mov	x1, x21
104ea1aa0: 94b615a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1aa4: aa0003e4    	mov	x4, x0
104ea1aa8: 900d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea1aac: f946e501    	ldr	x1, [x8, #0xdc8] ; endDataReportSessionWithDone:originCount:submitCount:
104ea1ab0: aa1c03e0    	mov	x0, x28
104ea1ab4: 52800022    	mov	w2, #0x1                ; =1
104ea1ab8: aa1603e3    	mov	x3, x22
104ea1abc: 94b615a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1ac0: 900d7f08    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
104ea1ac4: f946bd01    	ldr	x1, [x8, #0xd78] ; doMultiSelectContactsInChatRoomReportWithExitScene:
104ea1ac8: aa1c03e0    	mov	x0, x28
104ea1acc: 52800022    	mov	w2, #0x1                ; =1
104ea1ad0: 94b6159b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1ad4: f9400fe0    	ldr	x0, [sp, #0x18]
104ea1ad8: 94b6159f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea1adc: f85a03a8    	ldur	x8, [x29, #-0x60]
104ea1ae0: d00c3a69    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104ea1ae4: f9405929    	ldr	x9, [x9, #0xb0]
104ea1ae8: f9400129    	ldr	x9, [x9]
104ea1aec: eb08013f    	cmp	x9, x8
104ea1af0: 540009a1    	b.ne	0x104ea1c24 <_Flutter_MMFoundation_BindContext+0x137d808>
104ea1af4: 9106c3ff    	add	sp, sp, #0x1b0
104ea1af8: a9457bfd    	ldp	x29, x30, [sp, #0x50]
104ea1afc: a9444ff4    	ldp	x20, x19, [sp, #0x40]
104ea1b00: a94357f6    	ldp	x22, x21, [sp, #0x30]
104ea1b04: a9425ff8    	ldp	x24, x23, [sp, #0x20]
104ea1b08: a94167fa    	ldp	x26, x25, [sp, #0x10]
104ea1b0c: a8c66ffc    	ldp	x28, x27, [sp], #0x60
104ea1b10: d65f03c0    	ret
104ea1b14: 4f00e400    	movi.16b	v0, #0x0
104ea1b18: ad0203e0    	stp	q0, q0, [sp, #0x40]
104ea1b1c: ad0103e0    	stp	q0, q0, [sp, #0x20]
104ea1b20: b00d9c28    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea1b24: b9485117    	ldr	w23, [x8, #0x850]
104ea1b28: f877cb80    	ldr	x0, [x28, w23, sxtw]
104ea1b2c: 900d7e48    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104ea1b30: f9415516    	ldr	x22, [x8, #0x2a8] ; m_dicMultiSelect
104ea1b34: aa1603e1    	mov	x1, x22
104ea1b38: 94b61581    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1b3c: aa1d03fd    	mov	x29, x29
104ea1b40: 94b61582    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea1b44: f00d92e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104ea1b48: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
104ea1b4c: 910083e2    	add	x2, sp, #0x20
104ea1b50: 910283e3    	add	x3, sp, #0xa0
104ea1b54: a90083e1    	stp	x1, x0, [sp, #0x8]
104ea1b58: 52800204    	mov	w4, #0x10               ; =16
104ea1b5c: 94b61578    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1b60: b4ffe520    	cbz	x0, 0x104ea1804 <_Flutter_MMFoundation_BindContext+0x137d3e8>
104ea1b64: aa0003f8    	mov	x24, x0
104ea1b68: f9401be8    	ldr	x8, [sp, #0x30]
104ea1b6c: f9400114    	ldr	x20, [x8]
104ea1b70: d2800013    	mov	x19, #0x0               ; =0
104ea1b74: f00d9308    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104ea1b78: f947f119    	ldr	x25, [x8, #0xfe0] ; objectForKey:
104ea1b7c: b00d7cc8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104ea1b80: f943c51a    	ldr	x26, [x8, #0x788] ; safeAddObject:
104ea1b84: f9401be8    	ldr	x8, [sp, #0x30]
104ea1b88: f9400108    	ldr	x8, [x8]
104ea1b8c: eb14011f    	cmp	x8, x20
104ea1b90: 54000060    	b.eq	0x104ea1b9c <_Flutter_MMFoundation_BindContext+0x137d780>
104ea1b94: f9400be0    	ldr	x0, [sp, #0x10]
104ea1b98: 94b6156e    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
104ea1b9c: f94017e8    	ldr	x8, [sp, #0x28]
104ea1ba0: f873791b    	ldr	x27, [x8, x19, lsl #3]
104ea1ba4: f877cb80    	ldr	x0, [x28, w23, sxtw]
104ea1ba8: aa1603e1    	mov	x1, x22
104ea1bac: 94b61564    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1bb0: aa1d03fd    	mov	x29, x29
104ea1bb4: 94b61565    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea1bb8: aa0003fc    	mov	x28, x0
104ea1bbc: aa1903e1    	mov	x1, x25
104ea1bc0: aa1b03e2    	mov	x2, x27
104ea1bc4: 94b6155e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1bc8: aa1d03fd    	mov	x29, x29
104ea1bcc: 94b6155f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea1bd0: aa0003fb    	mov	x27, x0
104ea1bd4: f9400fe0    	ldr	x0, [sp, #0x18]
104ea1bd8: aa1a03e1    	mov	x1, x26
104ea1bdc: aa1b03e2    	mov	x2, x27
104ea1be0: 94b61557    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1be4: aa1b03e0    	mov	x0, x27
104ea1be8: 94b6155b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea1bec: aa1c03e0    	mov	x0, x28
104ea1bf0: aa1503fc    	mov	x28, x21
104ea1bf4: 94b61558    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea1bf8: 91000673    	add	x19, x19, #0x1
104ea1bfc: eb13031f    	cmp	x24, x19
104ea1c00: 54fffc21    	b.ne	0x104ea1b84 <_Flutter_MMFoundation_BindContext+0x137d768>
104ea1c04: 910083e2    	add	x2, sp, #0x20
104ea1c08: 910283e3    	add	x3, sp, #0xa0
104ea1c0c: a94083e1    	ldp	x1, x0, [sp, #0x8]
104ea1c10: 52800204    	mov	w4, #0x10               ; =16
104ea1c14: 94b6154a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1c18: aa0003f8    	mov	x24, x0
104ea1c1c: b5fffaa0    	cbnz	x0, 0x104ea1b70 <_Flutter_MMFoundation_BindContext+0x137d754>
104ea1c20: 17fffef9    	b	0x104ea1804 <_Flutter_MMFoundation_BindContext+0x137d3e8>
104ea1c24: 94b61554    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
