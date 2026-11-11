
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010a1668:     	stp	x26, x25, [sp, #-0x50]!
1010a166c:     	stp	x24, x23, [sp, #0x10]
1010a1670:     	stp	x22, x21, [sp, #0x20]
1010a1674:     	stp	x20, x19, [sp, #0x30]
1010a1678:     	stp	x29, x30, [sp, #0x40]
1010a167c:     	add	x29, sp, #0x40
1010a1680:     	mov	x19, x2
1010a1684:     	mov	x20, x0
1010a1688:     	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
1010a168c:     	mov	w9, #0x1                ; =1
1010a1690:     	strb	w9, [x8, #0xb77]
1010a1694:     	mov	x0, x2
1010a1698:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1010a169c:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1010a16a0:     	ldr	x0, [x8, #0x780]
1010a16a4:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1010a16a8:     	ldr	x1, [x8, #0x800] ; selector: currentContext
1010a16ac:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010a16b0:     	mov	x29, x29
1010a16b4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010a16b8:     	mov	x22, x0
1010a16bc:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1010a16c0:     	ldr	x0, [x8, #0xbe8]
1010a16c4:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1010a16c8:     	ldr	x1, [x8, #0x508] ; selector: class
1010a16cc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010a16d0:     	mov	x2, x0
1010a16d4:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1010a16d8:     	ldr	x1, [x8, #0xa40] ; selector: getService:
1010a16dc:     	mov	x0, x22
1010a16e0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010a16e4:     	mov	x29, x29
1010a16e8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010a16ec:     	mov	x23, x0
1010a16f0:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1010a16f4:     	ldr	x21, [x8, #0x620] ; selector: m_nsUsrName
1010a16f8:     	mov	x0, x19
1010a16fc:     	mov	x1, x21
1010a1700:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010a1704:     	mov	x29, x29
1010a1708:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010a170c:     	mov	x24, x0
1010a1710:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1010a1714:     	ldr	x1, [x8, #0x150] ; selector: getContactByName:
1010a1718:     	mov	x0, x23
1010a171c:     	mov	x2, x24
1010a1720:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010a1724:     	mov	x29, x29
1010a1728:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010a172c:     	mov	x25, x0
1010a1730:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010a1734:     	mov	x0, x24
1010a1738:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010a173c:     	mov	x0, x23
1010a1740:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010a1744:     	mov	x0, x22
1010a1748:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010a174c:     	cmp	x19, x25
1010a1750:     	b.eq	0x1010a176c <__text+0x109976c>
1010a1754:     	adrp	x8, 0x11ed8a000 <dyld_stub_binder+0x11ed8a000>
1010a1758:     	ldrsw	x8, [x8, #0x5c]
1010a175c:     	add	x0, x20, x8
1010a1760:     	mov	x1, x19
1010a1764:     	bl	0x107c27c9c <_Flutter_MMFoundation_BindContext+0x3eae968>
1010a1768:     	b	0x1010a1810 <__text+0x1099810>
1010a176c:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1010a1770:     	ldr	x0, [x8, #0xac0]
1010a1774:     	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
1010a1778:     	adrp	x8, 0x11ed8a000 <dyld_stub_binder+0x11ed8a000>
1010a177c:     	ldrsw	x22, [x8, #0x5c]
1010a1780:     	ldr	x8, [x20, x22]
1010a1784:     	str	x0, [x20, x22]
1010a1788:     	mov	x0, x8
1010a178c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010a1790:     	mov	x0, x19
1010a1794:     	mov	x1, x21
1010a1798:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010a179c:     	mov	x29, x29
1010a17a0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010a17a4:     	mov	x21, x0
1010a17a8:     	ldr	x0, [x20, x22]
1010a17ac:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1010a17b0:     	ldr	x1, [x8, #0xc00] ; selector: setM_nsUsrName:
1010a17b4:     	mov	x2, x21
1010a17b8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010a17bc:     	mov	x0, x21
1010a17c0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010a17c4:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1010a17c8:     	ldr	x1, [x8, #0xf98] ; selector: m_nsEncodeUserName
1010a17cc:     	mov	x0, x19
1010a17d0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010a17d4:     	mov	x29, x29
1010a17d8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010a17dc:     	mov	x21, x0
1010a17e0:     	ldr	x0, [x20, x22]
1010a17e4:     	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
1010a17e8:     	ldr	x1, [x8, #0xd8] ; selector: setM_nsEncodeUserName:
1010a17ec:     	mov	x2, x21
1010a17f0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010a17f4:     	mov	x0, x21
1010a17f8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010a17fc:     	ldr	x0, [x20, x22]
1010a1800:     	adrp	x8, 0x11e9dd000 <dyld_stub_binder+0x11e9dd000>
1010a1804:     	ldr	x1, [x8, #0xb38] ; selector: copyFieldFromContact:
1010a1808:     	mov	x2, x19
1010a180c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010a1810:     	adrp	x8, 0x11ea1b000 <dyld_stub_binder+0x11ea1b000>
1010a1814:     	ldr	x1, [x8, #0xac8] ; selector: textStateAnimateHelper
1010a1818:     	mov	x0, x20
1010a181c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010a1820:     	mov	x29, x29
1010a1824:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010a1828:     	mov	x20, x0
1010a182c:     	adrp	x8, 0x11ea1b000 <dyld_stub_binder+0x11ea1b000>
1010a1830:     	ldr	x1, [x8, #0xad0] ; selector: updateMediaWithContact:
1010a1834:     	mov	x2, x19
1010a1838:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010a183c:     	mov	x0, x20
1010a1840:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010a1844:     	mov	x0, x19
1010a1848:     	ldp	x29, x30, [sp, #0x40]
1010a184c:     	ldp	x20, x19, [sp, #0x30]
1010a1850:     	ldp	x22, x21, [sp, #0x20]
1010a1854:     	ldp	x24, x23, [sp, #0x10]
1010a1858:     	ldp	x26, x25, [sp], #0x50
1010a185c:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
