
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101a32e28: d10443ff    	sub	sp, sp, #0x110
101a32e2c: a90b6ffc    	stp	x28, x27, [sp, #0xb0]
101a32e30: a90c67fa    	stp	x26, x25, [sp, #0xc0]
101a32e34: a90d5ff8    	stp	x24, x23, [sp, #0xd0]
101a32e38: a90e57f6    	stp	x22, x21, [sp, #0xe0]
101a32e3c: a90f4ff4    	stp	x20, x19, [sp, #0xf0]
101a32e40: a9107bfd    	stp	x29, x30, [sp, #0x100]
101a32e44: 910403fd    	add	x29, sp, #0x100
101a32e48: aa0303f9    	mov	x25, x3
101a32e4c: aa0203fc    	mov	x28, x2
101a32e50: aa0003f5    	mov	x21, x0
101a32e54: f00ee888    	adrp	x8, 0x11f745000 <dyld_stub_binder+0x11f745000>
101a32e58: 52800029    	mov	w9, #0x1                ; =1
101a32e5c: 393ced09    	strb	w9, [x8, #0xf3b]
101a32e60: aa0203e0    	mov	x0, x2
101a32e64: 9587d384    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101a32e68: aa1903e0    	mov	x0, x25
101a32e6c: 9587d382    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101a32e70: 900e9b08    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a32e74: b98df914    	ldrsw	x20, [x8, #0xdf8] ; ivar: FavBaseListViewController.m_checkFilterSearchKey offset=328
101a32e78: f8746aa2    	ldr	x2, [x21, x20]
101a32e7c: d00e93a8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
101a32e80: f943dd13    	ldr	x19, [x8, #0x7b8] ; selector: isEqualToString:
101a32e84: aa1303e1    	mov	x1, x19
101a32e88: 9587d377    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a32e8c: 340004c0    	cbz	w0, 0x101a32f24 <__text+0x1a2af24>
101a32e90: 900e9708    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a32e94: f943c100    	ldr	x0, [x8, #0x780]
101a32e98: f00e7ca8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a32e9c: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
101a32ea0: 9587d371    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a32ea4: aa1d03fd    	mov	x29, x29
101a32ea8: 9587d376    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a32eac: aa0003f3    	mov	x19, x0
101a32eb0: b00e9708    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a32eb4: f9448500    	ldr	x0, [x8, #0x908]
101a32eb8: 900e93a8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a32ebc: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
101a32ec0: 9587d369    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a32ec4: aa0003e2    	mov	x2, x0
101a32ec8: f00e7ca8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a32ecc: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
101a32ed0: aa1303e0    	mov	x0, x19
101a32ed4: 9587d364    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a32ed8: aa1d03fd    	mov	x29, x29
101a32edc: 9587d369    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a32ee0: aa0003f6    	mov	x22, x0
101a32ee4: f8746aa2    	ldr	x2, [x21, x20]
101a32ee8: 900e80a8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a32eec: f9417101    	ldr	x1, [x8, #0x2e0] ; selector: getTotalSearchCountForTaskKey:searchContent:
101a32ef0: d2800003    	mov	x3, #0x0                ; =0
101a32ef4: 9587d35c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a32ef8: aa0003f7    	mov	x23, x0
101a32efc: aa1603e0    	mov	x0, x22
101a32f00: 9587d35c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a32f04: aa1303e0    	mov	x0, x19
101a32f08: 9587d35a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a32f0c: 900e80a8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a32f10: f9424d01    	ldr	x1, [x8, #0x498] ; selector: onCheckTypeWithResultCount:
101a32f14: aa1503e0    	mov	x0, x21
101a32f18: aa1703e2    	mov	x2, x23
101a32f1c: 9587d352    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a32f20: 14000531    	b	0x101a343e4 <__text+0x1a2c3e4>
101a32f24: 900e9b08    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a32f28: b98dc517    	ldrsw	x23, [x8, #0xdc4] ; ivar: FavBaseListViewController.m_searchTaskKey offset=120
101a32f2c: f8776aa2    	ldr	x2, [x21, x23]
101a32f30: aa1903e0    	mov	x0, x25
101a32f34: aa1303e1    	mov	x1, x19
101a32f38: 9587d34b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a32f3c: 3400a540    	cbz	w0, 0x101a343e4 <__text+0x1a2c3e4>
101a32f40: f9002ff3    	str	x19, [sp, #0x58]
101a32f44: 900e9b08    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a32f48: b98dcd08    	ldrsw	x8, [x8, #0xdcc] ; ivar: FavBaseListViewController.m_bReceiveSearchResult offset=281
101a32f4c: 38686aa9    	ldrb	w9, [x21, x8]
101a32f50: 900e970b    	adrp	x11, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a32f54: b00e971b    	adrp	x27, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a32f58: 900e93ba    	adrp	x26, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a32f5c: f00e7cb4    	adrp	x20, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a32f60: 900e93aa    	adrp	x10, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a32f64: 7100053f    	cmp	w9, #0x1
101a32f68: f90043f9    	str	x25, [sp, #0x80]
101a32f6c: f81883b7    	stur	x23, [x29, #-0x78]
101a32f70: 54001681    	b.ne	0x101a33240 <__text+0x1a2b240>
101a32f74: f81a03bc    	stur	x28, [x29, #-0x60]
101a32f78: 38286abf    	strb	wzr, [x21, x8]
101a32f7c: f943c160    	ldr	x0, [x11, #0x780]
101a32f80: f00e7ca8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a32f84: f9440117    	ldr	x23, [x8, #0x800] ; selector: currentContext
101a32f88: aa1703e1    	mov	x1, x23
101a32f8c: 9587d336    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a32f90: aa1d03fd    	mov	x29, x29
101a32f94: 9587d33b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a32f98: aa0003f3    	mov	x19, x0
101a32f9c: f9448760    	ldr	x0, [x27, #0x908]
101a32fa0: f9428758    	ldr	x24, [x26, #0x508] ; selector: class
101a32fa4: aa1803e1    	mov	x1, x24
101a32fa8: 9587d32f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a32fac: aa0003e2    	mov	x2, x0
101a32fb0: f9452299    	ldr	x25, [x20, #0xa40] ; selector: getService:
101a32fb4: aa1303e0    	mov	x0, x19
101a32fb8: aa1903e1    	mov	x1, x25
101a32fbc: 9587d32a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a32fc0: aa1d03fd    	mov	x29, x29
101a32fc4: 9587d32f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a32fc8: aa0003f6    	mov	x22, x0
101a32fcc: 900e7d28    	adrp	x8, 0x11e9d6000 <dyld_stub_binder+0x11e9d6000>
101a32fd0: f942691a    	ldr	x26, [x8, #0x4d0] ; selector: reportLogic
101a32fd4: aa1a03e1    	mov	x1, x26
101a32fd8: 9587d323    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a32fdc: aa1d03fd    	mov	x29, x29
101a32fe0: 9587d328    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a32fe4: aa1b03fc    	mov	x28, x27
101a32fe8: aa0003fb    	mov	x27, x0
101a32fec: 900e80a8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a32ff0: f9425101    	ldr	x1, [x8, #0x4a0] ; selector: endSearch
101a32ff4: 9587d31c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a32ff8: aa1b03e0    	mov	x0, x27
101a32ffc: 9587d31d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33000: aa1603e0    	mov	x0, x22
101a33004: 9587d31b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33008: aa1303e0    	mov	x0, x19
101a3300c: 9587d319    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33010: f00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a33014: b98dbd08    	ldrsw	x8, [x8, #0xdbc] ; ivar: FavBaseListViewController.m_isServerSearch offset=424
101a33018: 38686aa8    	ldrb	w8, [x21, x8]
101a3301c: 7100051f    	cmp	w8, #0x1
101a33020: 54000121    	b.ne	0x101a33044 <__text+0x1a2b044>
101a33024: f00e9388    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a33028: f9442901    	ldr	x1, [x8, #0x850] ; selector: count
101a3302c: f85a03a0    	ldur	x0, [x29, #-0x60]
101a33030: 9587d30d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33034: f81903a0    	stur	x0, [x29, #-0x70]
101a33038: f00e9af4    	adrp	x20, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a3303c: f00e96f3    	adrp	x19, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a33040: 14000021    	b	0x101a330c4 <__text+0x1a2b0c4>
101a33044: f00e96fb    	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a33048: f943c360    	ldr	x0, [x27, #0x780]
101a3304c: aa1703e1    	mov	x1, x23
101a33050: 9587d305    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33054: aa1d03fd    	mov	x29, x29
101a33058: 9587d30a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a3305c: aa0003f3    	mov	x19, x0
101a33060: f9448780    	ldr	x0, [x28, #0x908]
101a33064: aa1803e1    	mov	x1, x24
101a33068: 9587d2ff    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a3306c: aa0003e2    	mov	x2, x0
101a33070: aa1303e0    	mov	x0, x19
101a33074: aa1903e1    	mov	x1, x25
101a33078: 9587d2fb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a3307c: aa1d03fd    	mov	x29, x29
101a33080: 9587d300    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33084: aa0003f6    	mov	x22, x0
101a33088: f85883a8    	ldur	x8, [x29, #-0x78]
101a3308c: f8686aa2    	ldr	x2, [x21, x8]
101a33090: f00e9af4    	adrp	x20, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a33094: b98dba88    	ldrsw	x8, [x20, #0xdb8] ; ivar: FavBaseListViewController._searchText offset=520
101a33098: f8686aa3    	ldr	x3, [x21, x8]
101a3309c: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a330a0: f9417101    	ldr	x1, [x8, #0x2e0] ; selector: getTotalSearchCountForTaskKey:searchContent:
101a330a4: 9587d2f0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a330a8: 2a0003e8    	mov	w8, w0
101a330ac: f81903a8    	stur	x8, [x29, #-0x70]
101a330b0: aa1603e0    	mov	x0, x22
101a330b4: 9587d2ef    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a330b8: aa1303e0    	mov	x0, x19
101a330bc: 9587d2ed    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a330c0: aa1b03f3    	mov	x19, x27
101a330c4: f943c260    	ldr	x0, [x19, #0x780]
101a330c8: aa1703e1    	mov	x1, x23
101a330cc: 9587d2e6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a330d0: aa1d03fd    	mov	x29, x29
101a330d4: 9587d2eb    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a330d8: aa0003f6    	mov	x22, x0
101a330dc: f81983a0    	stur	x0, [x29, #-0x68]
101a330e0: f9448780    	ldr	x0, [x28, #0x908]
101a330e4: aa1803e1    	mov	x1, x24
101a330e8: 9587d2df    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a330ec: aa0003e2    	mov	x2, x0
101a330f0: aa1603e0    	mov	x0, x22
101a330f4: aa1903e1    	mov	x1, x25
101a330f8: 9587d2db    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a330fc: aa1d03fd    	mov	x29, x29
101a33100: 9587d2e0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33104: f9003fe0    	str	x0, [sp, #0x78]
101a33108: aa1a03e1    	mov	x1, x26
101a3310c: 9587d2d6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33110: aa1d03fd    	mov	x29, x29
101a33114: 9587d2db    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33118: aa0003fb    	mov	x27, x0
101a3311c: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a33120: f9408501    	ldr	x1, [x8, #0x108] ; selector: getFavHomepageSessionId
101a33124: aa1503e0    	mov	x0, x21
101a33128: 9587d2cf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a3312c: aa1d03fd    	mov	x29, x29
101a33130: 9587d2d4    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33134: aa0003f6    	mov	x22, x0
101a33138: f943c260    	ldr	x0, [x19, #0x780]
101a3313c: aa1703e1    	mov	x1, x23
101a33140: 9587d2c9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33144: aa1d03fd    	mov	x29, x29
101a33148: 9587d2ce    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a3314c: aa0003f7    	mov	x23, x0
101a33150: f9448780    	ldr	x0, [x28, #0x908]
101a33154: aa1c03f3    	mov	x19, x28
101a33158: aa1803e1    	mov	x1, x24
101a3315c: 9587d2c2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33160: aa0003e2    	mov	x2, x0
101a33164: aa1703e0    	mov	x0, x23
101a33168: aa1903e1    	mov	x1, x25
101a3316c: 9587d2be    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33170: aa1d03fd    	mov	x29, x29
101a33174: 9587d2c3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33178: aa0003f8    	mov	x24, x0
101a3317c: aa1a03e1    	mov	x1, x26
101a33180: 9587d2b9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33184: aa1d03fd    	mov	x29, x29
101a33188: 9587d2be    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a3318c: aa0003f9    	mov	x25, x0
101a33190: 900e7cc8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
101a33194: f9422101    	ldr	x1, [x8, #0x440] ; selector: searchId
101a33198: 9587d2b3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a3319c: aa1d03fd    	mov	x29, x29
101a331a0: 9587d2b8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a331a4: aa0003fa    	mov	x26, x0
101a331a8: b98dba88    	ldrsw	x8, [x20, #0xdb8] ; ivar: FavBaseListViewController._searchText offset=520
101a331ac: f8686ab4    	ldr	x20, [x21, x8]
101a331b0: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a331b4: f9425501    	ldr	x1, [x8, #0x4a8] ; selector: getSearchMethodOnReport
101a331b8: aa1503e0    	mov	x0, x21
101a331bc: 9587d2aa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a331c0: aa0003e6    	mov	x6, x0
101a331c4: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a331c8: f9425901    	ldr	x1, [x8, #0x4b0] ; selector: reportSearchReturn:resultCount:queryId:queryWord:resMethod:
101a331cc: aa1b03e0    	mov	x0, x27
101a331d0: aa1603e2    	mov	x2, x22
101a331d4: f85903a3    	ldur	x3, [x29, #-0x70]
101a331d8: aa1a03e4    	mov	x4, x26
101a331dc: aa1403e5    	mov	x5, x20
101a331e0: 9587d2a1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a331e4: aa1a03e0    	mov	x0, x26
101a331e8: 9587d2a2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a331ec: aa1903e0    	mov	x0, x25
101a331f0: 9587d2a0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a331f4: aa1803e0    	mov	x0, x24
101a331f8: 9587d29e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a331fc: aa1703e0    	mov	x0, x23
101a33200: 9587d29c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33204: aa1603e0    	mov	x0, x22
101a33208: 9587d29a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a3320c: aa1b03e0    	mov	x0, x27
101a33210: 9587d298    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33214: f9403fe0    	ldr	x0, [sp, #0x78]
101a33218: 9587d296    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a3321c: f85983a0    	ldur	x0, [x29, #-0x68]
101a33220: 9587d294    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33224: f94043f9    	ldr	x25, [sp, #0x80]
101a33228: f85a03bc    	ldur	x28, [x29, #-0x60]
101a3322c: f85883b7    	ldur	x23, [x29, #-0x78]
101a33230: aa1303fb    	mov	x27, x19
101a33234: d00e7cb4    	adrp	x20, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a33238: f00e939a    	adrp	x26, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a3323c: f00e938a    	adrp	x10, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a33240: f00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a33244: b98dd918    	ldrsw	x24, [x8, #0xdd8] ; ivar: FavBaseListViewController.m_preResultCount offset=344
101a33248: b8b86ab3    	ldrsw	x19, [x21, x24]
101a3324c: f9442956    	ldr	x22, [x10, #0x850] ; selector: count
101a33250: aa1c03e0    	mov	x0, x28
101a33254: aa1603e1    	mov	x1, x22
101a33258: 9587d283    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a3325c: f9002bf3    	str	x19, [sp, #0x50]
101a33260: eb13001f    	cmp	x0, x19
101a33264: 54000303    	b.lo	0x101a332c4 <__text+0x1a2b2c4>
101a33268: b8b86ab3    	ldrsw	x19, [x21, x24]
101a3326c: aa1c03e0    	mov	x0, x28
101a33270: aa1603e1    	mov	x1, x22
101a33274: 9587d27c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33278: b8b86aa8    	ldrsw	x8, [x21, x24]
101a3327c: cb080003    	sub	x3, x0, x8
101a33280: d00e93c8    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
101a33284: f9430901    	ldr	x1, [x8, #0x610] ; selector: subarrayWithRange:
101a33288: aa1c03e0    	mov	x0, x28
101a3328c: aa1303e2    	mov	x2, x19
101a33290: 9587d275    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33294: aa1d03fd    	mov	x29, x29
101a33298: 9587d27a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a3329c: aa0003f3    	mov	x19, x0
101a332a0: aa1c03e0    	mov	x0, x28
101a332a4: 9587d273    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a332a8: aa1303e0    	mov	x0, x19
101a332ac: aa1603e1    	mov	x1, x22
101a332b0: 9587d26d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a332b4: b8786aa8    	ldr	w8, [x21, x24]
101a332b8: 0b000108    	add	w8, w8, w0
101a332bc: b8386aa8    	str	w8, [x21, x24]
101a332c0: aa1303fc    	mov	x28, x19
101a332c4: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a332c8: f9412501    	ldr	x1, [x8, #0x248] ; selector: applyStarTypeFilterForDisplay:
101a332cc: aa1503e0    	mov	x0, x21
101a332d0: aa1c03e2    	mov	x2, x28
101a332d4: 9587d264    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a332d8: aa1d03fd    	mov	x29, x29
101a332dc: 9587d269    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a332e0: f81a03a0    	stur	x0, [x29, #-0x60]
101a332e4: aa1c03e0    	mov	x0, x28
101a332e8: 9587d262    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a332ec: f00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a332f0: b98dbd08    	ldrsw	x8, [x8, #0xdbc] ; ivar: FavBaseListViewController.m_isServerSearch offset=424
101a332f4: f90027e8    	str	x8, [sp, #0x48]
101a332f8: 38686aa8    	ldrb	w8, [x21, x8]
101a332fc: d00e7ca9    	adrp	x9, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a33300: f9440121    	ldr	x1, [x9, #0x800] ; selector: currentContext
101a33304: 7100051f    	cmp	w8, #0x1
101a33308: a9395ba1    	stp	x1, x22, [x29, #-0x70]
101a3330c: 540000e1    	b.ne	0x101a33328 <__text+0x1a2b328>
101a33310: f9003bff    	str	xzr, [sp, #0x70]
101a33314: f942875c    	ldr	x28, [x26, #0x508] ; selector: class
101a33318: f9452293    	ldr	x19, [x20, #0xa40] ; selector: getService:
101a3331c: f00e96f4    	adrp	x20, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a33320: f00e9afa    	adrp	x26, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a33324: 14000024    	b	0x101a333b4 <__text+0x1a2b3b4>
101a33328: f00e96e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a3332c: f943c100    	ldr	x0, [x8, #0x780]
101a33330: 9587d24d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33334: aa1d03fd    	mov	x29, x29
101a33338: 9587d252    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a3333c: aa1903f6    	mov	x22, x25
101a33340: aa0003f9    	mov	x25, x0
101a33344: f9448760    	ldr	x0, [x27, #0x908]
101a33348: f942875c    	ldr	x28, [x26, #0x508]
101a3334c: aa1c03e1    	mov	x1, x28
101a33350: 9587d245    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33354: aa0003e2    	mov	x2, x0
101a33358: f9452293    	ldr	x19, [x20, #0xa40]
101a3335c: aa1903e0    	mov	x0, x25
101a33360: aa1303e1    	mov	x1, x19
101a33364: 9587d240    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33368: aa1d03fd    	mov	x29, x29
101a3336c: 9587d245    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33370: aa0003f4    	mov	x20, x0
101a33374: f8776aa2    	ldr	x2, [x21, x23]
101a33378: f00e9afa    	adrp	x26, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a3337c: b98dbb48    	ldrsw	x8, [x26, #0xdb8] ; ivar: FavBaseListViewController._searchText offset=520
101a33380: f8686aa3    	ldr	x3, [x21, x8]
101a33384: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a33388: f9425d01    	ldr	x1, [x8, #0x4b8] ; selector: hasSearchDoneForTaskKey:searchContent:
101a3338c: 9587d236    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33390: 52000008    	eor	w8, w0, #0x1
101a33394: f9003be8    	str	x8, [sp, #0x70]
101a33398: aa1403e0    	mov	x0, x20
101a3339c: f00e96f4    	adrp	x20, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a333a0: 9587d234    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a333a4: aa1903e0    	mov	x0, x25
101a333a8: aa1603f9    	mov	x25, x22
101a333ac: 9587d231    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a333b0: f85903a1    	ldur	x1, [x29, #-0x70]
101a333b4: f943c280    	ldr	x0, [x20, #0x780]
101a333b8: 9587d22b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a333bc: aa1d03fd    	mov	x29, x29
101a333c0: 9587d230    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a333c4: aa0003f4    	mov	x20, x0
101a333c8: f9448760    	ldr	x0, [x27, #0x908]
101a333cc: aa1c03e1    	mov	x1, x28
101a333d0: 9587d225    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a333d4: aa0003e2    	mov	x2, x0
101a333d8: aa1403e0    	mov	x0, x20
101a333dc: f9003ff3    	str	x19, [sp, #0x78]
101a333e0: aa1303e1    	mov	x1, x19
101a333e4: 9587d220    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a333e8: aa1d03fd    	mov	x29, x29
101a333ec: 9587d225    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a333f0: aa0003f6    	mov	x22, x0
101a333f4: f8776aa2    	ldr	x2, [x21, x23]
101a333f8: b98dbb48    	ldrsw	x8, [x26, #0xdb8] ; ivar: FavBaseListViewController._searchText offset=520
101a333fc: f90033e8    	str	x8, [sp, #0x60]
101a33400: f8686aa3    	ldr	x3, [x21, x8]
101a33404: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a33408: f941711b    	ldr	x27, [x8, #0x2e0] ; selector: getTotalSearchCountForTaskKey:searchContent:
101a3340c: aa1b03e1    	mov	x1, x27
101a33410: 9587d215    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33414: aa0003f3    	mov	x19, x0
101a33418: aa1603e0    	mov	x0, x22
101a3341c: 9587d215    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33420: aa1403e0    	mov	x0, x20
101a33424: 9587d213    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33428: d00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a3342c: f945a101    	ldr	x1, [x8, #0xb40] ; selector: usesFilterRedesignUI
101a33430: aa1503e0    	mov	x0, x21
101a33434: 9587d20c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33438: f90037fc    	str	x28, [sp, #0x68]
101a3343c: 34000740    	cbz	w0, 0x101a33524 <__text+0x1a2b524>
101a33440: f9402be8    	ldr	x8, [sp, #0x50]
101a33444: 7100011f    	cmp	w8, #0x0
101a33448: 1a9f07f6    	cset	w22, ne
101a3344c: 2a1303f9    	mov	w25, w19
101a33450: f00e96e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a33454: f9430d14    	ldr	x20, [x8, #0x618]
101a33458: a979f3a1    	ldp	x1, x28, [x29, #-0x68]
101a3345c: aa1c03e0    	mov	x0, x28
101a33460: 9587d201    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33464: aa0003f7    	mov	x23, x0
101a33468: d00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a3346c: f946c101    	ldr	x1, [x8, #0xd80] ; selector: recentUsedOnly
101a33470: aa1503e0    	mov	x0, x21
101a33474: 9587d1fc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33478: aa0003fb    	mov	x27, x0
101a3347c: d00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a33480: f9469913    	ldr	x19, [x8, #0xd30] ; selector: activeCategoryTypeBitForFilter
101a33484: aa1503e0    	mov	x0, x21
101a33488: aa1303e1    	mov	x1, x19
101a3348c: 9587d1f6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33490: d00e7ca8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a33494: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
101a33498: b8786aa8    	ldr	w8, [x21, x24]
101a3349c: a90323e0    	stp	x0, x8, [sp, #0x30]
101a334a0: 900db408    	adrp	x8, 0x11d0b3000 <dyld_stub_binder+0x11d0b3000>
101a334a4: 9134e108    	add	x8, x8, #0xd38 ; CFString: [FavFilter] OnSearch batch=%lu, total=%ld, hasMore=%d, append=%d, recentOnly=%d, displayType=%lld, preCount=%d
101a334a8: a9026ff6    	stp	x22, x27, [sp, #0x20]
101a334ac: d00c1b23    	adrp	x3, 0x119d99000 <dyld_stub_binder+0x119d99000>
101a334b0: 91225863    	add	x3, x3, #0x896
101a334b4: 900c1b45    	adrp	x5, 0x119d9b000 <dyld_stub_binder+0x119d9b000>
101a334b8: 9107f8a5    	add	x5, x5, #0x1fe
101a334bc: f9403bf8    	ldr	x24, [sp, #0x70]
101a334c0: a90163f9    	stp	x25, x24, [sp, #0x10]
101a334c4: b00c1b47    	adrp	x7, 0x119d9c000 <dyld_stub_binder+0x119d9c000>
101a334c8: 9109c8e7    	add	x7, x7, #0x272
101a334cc: a9005fe8    	stp	x8, x23, [sp]
101a334d0: aa1403e0    	mov	x0, x20
101a334d4: 52800042    	mov	w2, #0x2                ; =2
101a334d8: 52800004    	mov	w4, #0x0                ; =0
101a334dc: 52819286    	mov	w6, #0xc94              ; =3220
101a334e0: 9587d1e1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a334e4: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a334e8: f9417d01    	ldr	x1, [x8, #0x2f8] ; selector: presentFilteredItems:append:hasMoreData:
101a334ec: aa1503e0    	mov	x0, x21
101a334f0: aa1c03e2    	mov	x2, x28
101a334f4: aa1603e3    	mov	x3, x22
101a334f8: aa1803e4    	mov	x4, x24
101a334fc: 9587d1da    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33500: aa0003f4    	mov	x20, x0
101a33504: d00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a33508: f9478501    	ldr	x1, [x8, #0xf08] ; selector: schedulePreloadVisibleFavMPArticles
101a3350c: aa1503e0    	mov	x0, x21
101a33510: 9587d1d5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33514: 36001894    	tbz	w20, #0x0, 0x101a33824 <__text+0x1a2b824>
101a33518: f94043f9    	ldr	x25, [sp, #0x80]
101a3351c: f85a03bc    	ldur	x28, [x29, #-0x60]
101a33520: 140003b1    	b	0x101a343e4 <__text+0x1a2c3e4>
101a33524: aa1c03fa    	mov	x26, x28
101a33528: f00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a3352c: b98db518    	ldrsw	x24, [x8, #0xdb4] ; ivar: FavBaseListViewController._selectedType offset=504
101a33530: f8786aa4    	ldr	x4, [x21, x24]
101a33534: f101fc9f    	cmp	x4, #0x7f
101a33538: f85a03bc    	ldur	x28, [x29, #-0x60]
101a3353c: f9002bf8    	str	x24, [sp, #0x50]
101a33540: 540021ad    	b.le	0x101a33974 <__text+0x1a2b974>
101a33544: f148009f    	cmp	x4, #0x200, lsl #12     ; =0x200000
101a33548: f85983b6    	ldur	x22, [x29, #-0x68]
101a3354c: f00e96f4    	adrp	x20, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a33550: 54002c4a    	b.ge	0x101a33ad8 <__text+0x1a2bad8>
101a33554: f102009f    	cmp	x4, #0x80
101a33558: 540022e0    	b.eq	0x101a339b4 <__text+0x1a2b9b4>
101a3355c: 52880148    	mov	w8, #0x400a             ; =16394
101a33560: eb08009f    	cmp	x4, x8
101a33564: 54003481    	b.ne	0x101a33bf4 <__text+0x1a2bbf4>
101a33568: f00e9748    	adrp	x8, 0x11ed1e000 <dyld_stub_binder+0x11ed1e000>
101a3356c: f947e500    	ldr	x0, [x8, #0xfc8]
101a33570: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a33574: f9414501    	ldr	x1, [x8, #0x288] ; selector: aggregatePicSearchResult:
101a33578: aa1c03e2    	mov	x2, x28
101a3357c: 9587d1ba    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33580: aa1d03fd    	mov	x29, x29
101a33584: 9587d1bf    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33588: aa0003f3    	mov	x19, x0
101a3358c: f00e93a8    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
101a33590: f9443901    	ldr	x1, [x8, #0x870] ; selector: reverseObjectEnumerator
101a33594: 9587d1b4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33598: aa1d03fd    	mov	x29, x29
101a3359c: 9587d1b9    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a335a0: aa1403f7    	mov	x23, x20
101a335a4: aa0003f4    	mov	x20, x0
101a335a8: d00e9388    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
101a335ac: f945d501    	ldr	x1, [x8, #0xba8] ; selector: allObjects
101a335b0: 9587d1ad    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a335b4: aa1d03fd    	mov	x29, x29
101a335b8: 9587d1b2    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a335bc: aa0003f8    	mov	x24, x0
101a335c0: aa1303e0    	mov	x0, x19
101a335c4: 9587d1ab    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a335c8: aa1403e0    	mov	x0, x20
101a335cc: 9587d1a9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a335d0: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a335d4: aa1a03f9    	mov	x25, x26
101a335d8: f940511a    	ldr	x26, [x8, #0xa0] ; selector: arrImgInfo
101a335dc: aa1503e0    	mov	x0, x21
101a335e0: aa1a03e1    	mov	x1, x26
101a335e4: 9587d1a0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a335e8: aa1d03fd    	mov	x29, x29
101a335ec: 9587d1a5    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a335f0: aa0003f3    	mov	x19, x0
101a335f4: d00e9388    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
101a335f8: f9452101    	ldr	x1, [x8, #0xa40] ; selector: addObjectsFromArray:
101a335fc: f9003bf8    	str	x24, [sp, #0x70]
101a33600: aa1803e2    	mov	x2, x24
101a33604: 9587d198    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33608: aa1303e0    	mov	x0, x19
101a3360c: 9587d199    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33610: aa1503e0    	mov	x0, x21
101a33614: aa1a03e1    	mov	x1, x26
101a33618: 9587d193    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a3361c: aa1d03fd    	mov	x29, x29
101a33620: 9587d198    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33624: aa0003f3    	mov	x19, x0
101a33628: aa1603e1    	mov	x1, x22
101a3362c: 9587d18e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33630: aa0003f4    	mov	x20, x0
101a33634: f943c2e0    	ldr	x0, [x23, #0x780]
101a33638: f85903a1    	ldur	x1, [x29, #-0x70]
101a3363c: 9587d18a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33640: aa1d03fd    	mov	x29, x29
101a33644: 9587d18f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33648: aa1603f8    	mov	x24, x22
101a3364c: aa0003f6    	mov	x22, x0
101a33650: 900e9708    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a33654: f9448500    	ldr	x0, [x8, #0x908]
101a33658: aa1903e1    	mov	x1, x25
101a3365c: 9587d182    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33660: aa0003e2    	mov	x2, x0
101a33664: aa1603e0    	mov	x0, x22
101a33668: f9403fe1    	ldr	x1, [sp, #0x78]
101a3366c: 9587d17e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33670: aa1d03fd    	mov	x29, x29
101a33674: 9587d183    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33678: aa0003f7    	mov	x23, x0
101a3367c: f00e7d08    	adrp	x8, 0x11e9d6000 <dyld_stub_binder+0x11e9d6000>
101a33680: f9426901    	ldr	x1, [x8, #0x4d0] ; selector: reportLogic
101a33684: 9587d178    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33688: aa1d03fd    	mov	x29, x29
101a3368c: 9587d17d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33690: aa0003fb    	mov	x27, x0
101a33694: d00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a33698: f9467101    	ldr	x1, [x8, #0xce0] ; selector: setLocalResultNum:
101a3369c: aa1403e2    	mov	x2, x20
101a336a0: 9587d171    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a336a4: aa1b03e0    	mov	x0, x27
101a336a8: 9587d172    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a336ac: aa1703e0    	mov	x0, x23
101a336b0: 9587d170    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a336b4: aa1603e0    	mov	x0, x22
101a336b8: 9587d16e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a336bc: aa1303e0    	mov	x0, x19
101a336c0: 9587d16c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a336c4: d00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a336c8: f947451b    	ldr	x27, [x8, #0xe88] ; selector: favBrowseCollectionView
101a336cc: aa1503e0    	mov	x0, x21
101a336d0: aa1b03e1    	mov	x1, x27
101a336d4: 9587d164    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a336d8: aa1d03fd    	mov	x29, x29
101a336dc: 9587d169    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a336e0: aa0003f3    	mov	x19, x0
101a336e4: 9587d163    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a336e8: b50000b3    	cbnz	x19, 0x101a336fc <__text+0x1a2b6fc>
101a336ec: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a336f0: f9414901    	ldr	x1, [x8, #0x290] ; selector: initFastBrowserView
101a336f4: aa1503e0    	mov	x0, x21
101a336f8: 9587d15b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a336fc: aa1503e0    	mov	x0, x21
101a33700: aa1a03e1    	mov	x1, x26
101a33704: 9587d158    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33708: aa1d03fd    	mov	x29, x29
101a3370c: 9587d15d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33710: aa0003f3    	mov	x19, x0
101a33714: aa1803e1    	mov	x1, x24
101a33718: 9587d153    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a3371c: f100001f    	cmp	x0, #0x0
101a33720: 1a9f17f4    	cset	w20, eq
101a33724: aa1503e0    	mov	x0, x21
101a33728: aa1b03e1    	mov	x1, x27
101a3372c: 9587d14e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33730: aa1d03fd    	mov	x29, x29
101a33734: 9587d153    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33738: aa0003f6    	mov	x22, x0
101a3373c: d00e7ee8    	adrp	x8, 0x11ea11000 <dyld_stub_binder+0x11ea11000>
101a33740: f9414901    	ldr	x1, [x8, #0x290] ; selector: getFooterView
101a33744: 9587d148    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33748: aa1d03fd    	mov	x29, x29
101a3374c: 9587d14d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33750: aa0003f7    	mov	x23, x0
101a33754: 900e93c8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
101a33758: f9458d01    	ldr	x1, [x8, #0xb18] ; selector: setHidden:
101a3375c: aa1403e2    	mov	x2, x20
101a33760: 9587d141    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33764: aa1703e0    	mov	x0, x23
101a33768: 9587d142    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a3376c: aa1603e0    	mov	x0, x22
101a33770: 9587d140    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33774: aa1303e0    	mov	x0, x19
101a33778: 9587d13e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a3377c: aa1503e0    	mov	x0, x21
101a33780: aa1b03e1    	mov	x1, x27
101a33784: 9587d138    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33788: aa1d03fd    	mov	x29, x29
101a3378c: 9587d13d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33790: aa0003f3    	mov	x19, x0
101a33794: b00e7cc8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
101a33798: f9414901    	ldr	x1, [x8, #0x290] ; selector: reloadData
101a3379c: 9587d132    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a337a0: aa1303e0    	mov	x0, x19
101a337a4: 9587d133    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a337a8: f94027e8    	ldr	x8, [sp, #0x48]
101a337ac: 38686aa8    	ldrb	w8, [x21, x8]
101a337b0: f94043f9    	ldr	x25, [sp, #0x80]
101a337b4: 360062e8    	tbz	w8, #0x0, 0x101a34410 <__text+0x1a2c410>
101a337b8: aa1503e0    	mov	x0, x21
101a337bc: aa1b03e1    	mov	x1, x27
101a337c0: 9587d129    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a337c4: aa1d03fd    	mov	x29, x29
101a337c8: 9587d12e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a337cc: aa0003f3    	mov	x19, x0
101a337d0: f00e7ee8    	adrp	x8, 0x11ea12000 <dyld_stub_binder+0x11ea12000>
101a337d4: f9442d01    	ldr	x1, [x8, #0x858] ; selector: updatePreMore:NextMore:
101a337d8: 52800002    	mov	w2, #0x0                ; =0
101a337dc: 52800003    	mov	w3, #0x0                ; =0
101a337e0: 9587d121    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a337e4: aa1303e0    	mov	x0, x19
101a337e8: 9587d122    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a337ec: aa1503e0    	mov	x0, x21
101a337f0: aa1b03e1    	mov	x1, x27
101a337f4: 9587d11c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a337f8: aa1d03fd    	mov	x29, x29
101a337fc: 9587d121    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33800: aa0003f3    	mov	x19, x0
101a33804: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a33808: f9414d01    	ldr	x1, [x8, #0x298] ; selector: updateLoading:NextMore:
101a3380c: 52800002    	mov	w2, #0x0                ; =0
101a33810: 52800003    	mov	w3, #0x0                ; =0
101a33814: 9587d114    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33818: aa1303e0    	mov	x0, x19
101a3381c: 9587d115    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33820: 1400034a    	b	0x101a34548 <__text+0x1a2c548>
101a33824: f00e96e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a33828: f9444d00    	ldr	x0, [x8, #0x898]
101a3382c: d00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a33830: f946b503    	ldr	x3, [x8, #0xd68] ; selector: showSearchLoading
101a33834: d00e7ca8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a33838: f9476101    	ldr	x1, [x8, #0xec0] ; selector: safeCancelPreviousPerformRequestsWithTarget:selector:object:
101a3383c: aa1503e2    	mov	x2, x21
101a33840: d2800004    	mov	x4, #0x0                ; =0
101a33844: 9587d108    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33848: aa1503e0    	mov	x0, x21
101a3384c: aa1303e1    	mov	x1, x19
101a33850: 9587d105    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33854: f100801f    	cmp	x0, #0x20
101a33858: f94043f9    	ldr	x25, [sp, #0x80]
101a3385c: 54000381    	b.ne	0x101a338cc <__text+0x1a2b8cc>
101a33860: f00e96e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a33864: f943c100    	ldr	x0, [x8, #0x780]
101a33868: f85903a1    	ldur	x1, [x29, #-0x70]
101a3386c: 9587d0fe    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33870: aa1d03fd    	mov	x29, x29
101a33874: 9587d103    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33878: aa0003f3    	mov	x19, x0
101a3387c: 900e9708    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a33880: f9448500    	ldr	x0, [x8, #0x908]
101a33884: f94037e1    	ldr	x1, [sp, #0x68]
101a33888: 9587d0f7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a3388c: aa0003e2    	mov	x2, x0
101a33890: aa1303e0    	mov	x0, x19
101a33894: f9403fe1    	ldr	x1, [sp, #0x78]
101a33898: 9587d0f3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a3389c: aa1d03fd    	mov	x29, x29
101a338a0: 9587d0f8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a338a4: aa0003f4    	mov	x20, x0
101a338a8: d00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a338ac: f9465901    	ldr	x1, [x8, #0xcb0] ; selector: isFavFlatPOIEnabled
101a338b0: 9587d0ed    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a338b4: aa0003f6    	mov	x22, x0
101a338b8: aa1403e0    	mov	x0, x20
101a338bc: 9587d0ed    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a338c0: aa1303e0    	mov	x0, x19
101a338c4: 9587d0eb    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a338c8: 340000d6    	cbz	w22, 0x101a338e0 <__text+0x1a2b8e0>
101a338cc: d00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a338d0: f9467d01    	ldr	x1, [x8, #0xcf8] ; selector: setSearchLoading:
101a338d4: aa1503e0    	mov	x0, x21
101a338d8: 52800002    	mov	w2, #0x0                ; =0
101a338dc: 9587d0e2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a338e0: d00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a338e4: f947cd01    	ldr	x1, [x8, #0xf98] ; selector: updateTagSearchResult
101a338e8: aa1503e0    	mov	x0, x21
101a338ec: 9587d0de    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a338f0: f94033f4    	ldr	x20, [sp, #0x60]
101a338f4: f8746aa0    	ldr	x0, [x21, x20]
101a338f8: b00e93a8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
101a338fc: f9467513    	ldr	x19, [x8, #0xce8] ; selector: length
101a33900: aa1303e1    	mov	x1, x19
101a33904: 9587d0d8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33908: f85a03bc    	ldur	x28, [x29, #-0x60]
101a3390c: f9402fe1    	ldr	x1, [sp, #0x58]
101a33910: f85883a8    	ldur	x8, [x29, #-0x78]
101a33914: b4000420    	cbz	x0, 0x101a33998 <__text+0x1a2b998>
101a33918: f8686aa2    	ldr	x2, [x21, x8]
101a3391c: aa1903e0    	mov	x0, x25
101a33920: 9587d0d1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33924: 340003a0    	cbz	w0, 0x101a33998 <__text+0x1a2b998>
101a33928: f94027e8    	ldr	x8, [sp, #0x48]
101a3392c: 38686aa8    	ldrb	w8, [x21, x8]
101a33930: 7100051f    	cmp	w8, #0x1
101a33934: 54000321    	b.ne	0x101a33998 <__text+0x1a2b998>
101a33938: aa1c03e0    	mov	x0, x28
101a3393c: f85983a1    	ldur	x1, [x29, #-0x68]
101a33940: 9587d0c9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33944: aa0003e3    	mov	x3, x0
101a33948: f8746aa2    	ldr	x2, [x21, x20]
101a3394c: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a33950: f9426101    	ldr	x1, [x8, #0x4c0] ; selector: updateServerSearchHintWithQuery:resultCount:
101a33954: aa1503e0    	mov	x0, x21
101a33958: 9587d0c3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a3395c: f00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a33960: b98d7d08    	ldrsw	x8, [x8, #0xd7c] ; ivar: FavBaseListViewController.m_dataController offset=200
101a33964: f8686aa0    	ldr	x0, [x21, x8]
101a33968: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a3396c: f9426501    	ldr	x1, [x8, #0x4c8] ; selector: revealAISearchFeedbackFooter
101a33970: 1400029c    	b	0x101a343e0 <__text+0x1a2c3e0>
101a33974: f100409f    	cmp	x4, #0x10
101a33978: f85983b6    	ldur	x22, [x29, #-0x68]
101a3397c: f00e96f4    	adrp	x20, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a33980: 540001a0    	b.eq	0x101a339b4 <__text+0x1a2b9b4>
101a33984: f100809f    	cmp	x4, #0x20
101a33988: 54000160    	b.eq	0x101a339b4 <__text+0x1a2b9b4>
101a3398c: f101009f    	cmp	x4, #0x40
101a33990: 54000ac0    	b.eq	0x101a33ae8 <__text+0x1a2bae8>
101a33994: 14000098    	b	0x101a33bf4 <__text+0x1a2bbf4>
101a33998: f8746aa0    	ldr	x0, [x21, x20]
101a3399c: aa1303e1    	mov	x1, x19
101a339a0: 9587d0b1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a339a4: b5005200    	cbnz	x0, 0x101a343e4 <__text+0x1a2c3e4>
101a339a8: d00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a339ac: f946a101    	ldr	x1, [x8, #0xd40] ; selector: removeServerSearchHint
101a339b0: 1400028b    	b	0x101a343dc <__text+0x1a2c3dc>
101a339b4: f00e9748    	adrp	x8, 0x11ed1e000 <dyld_stub_binder+0x11ed1e000>
101a339b8: f947e500    	ldr	x0, [x8, #0xfc8]
101a339bc: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a339c0: f9413d01    	ldr	x1, [x8, #0x278] ; selector: filterAndAggregateSearchResult:withSearchText:withSearchType:withTagList:
101a339c4: 900dab43    	adrp	x3, 0x11cf9b000 <dyld_stub_binder+0x11cf9b000>
101a339c8: 91396063    	add	x3, x3, #0xe58 ; CFString: 
101a339cc: aa1c03e2    	mov	x2, x28
101a339d0: d2800005    	mov	x5, #0x0                ; =0
101a339d4: 9587d0a4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a339d8: aa1d03fd    	mov	x29, x29
101a339dc: 9587d0a9    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a339e0: aa0003fa    	mov	x26, x0
101a339e4: f8786aa8    	ldr	x8, [x21, x24]
101a339e8: f100811f    	cmp	x8, #0x20
101a339ec: 900e9718    	adrp	x24, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a339f0: 540034a1    	b.ne	0x101a34084 <__text+0x1a2c084>
101a339f4: f943c280    	ldr	x0, [x20, #0x780]
101a339f8: f85903a1    	ldur	x1, [x29, #-0x70]
101a339fc: 9587d09a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33a00: aa1d03fd    	mov	x29, x29
101a33a04: 9587d09f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33a08: aa0003f3    	mov	x19, x0
101a33a0c: f9448700    	ldr	x0, [x24, #0x908]
101a33a10: f94037e1    	ldr	x1, [sp, #0x68]
101a33a14: 9587d094    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33a18: aa0003e2    	mov	x2, x0
101a33a1c: aa1303e0    	mov	x0, x19
101a33a20: f9403fe1    	ldr	x1, [sp, #0x78]
101a33a24: 9587d090    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33a28: aa1d03fd    	mov	x29, x29
101a33a2c: 9587d095    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33a30: aa0003f4    	mov	x20, x0
101a33a34: d00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a33a38: f9465901    	ldr	x1, [x8, #0xcb0] ; selector: isFavFlatPOIEnabled
101a33a3c: 9587d08a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33a40: aa0003f6    	mov	x22, x0
101a33a44: aa1403e0    	mov	x0, x20
101a33a48: 9587d08a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33a4c: aa1303e0    	mov	x0, x19
101a33a50: 9587d088    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33a54: 34002dd6    	cbz	w22, 0x101a3400c <__text+0x1a2c00c>
101a33a58: f00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a33a5c: b98db113    	ldrsw	x19, [x8, #0xdb0] ; ivar: FavBaseListViewController.m_flatPOIDataWraps offset=448
101a33a60: f8736aa0    	ldr	x0, [x21, x19]
101a33a64: b50001a0    	cbnz	x0, 0x101a33a98 <__text+0x1a2ba98>
101a33a68: f00e96e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a33a6c: f9432d00    	ldr	x0, [x8, #0x658]
101a33a70: d00e9388    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
101a33a74: f946c501    	ldr	x1, [x8, #0xd88] ; selector: array
101a33a78: 9587d07b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33a7c: aa1d03fd    	mov	x29, x29
101a33a80: 9587d080    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33a84: f8736aa8    	ldr	x8, [x21, x19]
101a33a88: f8336aa0    	str	x0, [x21, x19]
101a33a8c: aa0803e0    	mov	x0, x8
101a33a90: 9587d078    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33a94: f8736aa0    	ldr	x0, [x21, x19]
101a33a98: d00e9388    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
101a33a9c: f9452101    	ldr	x1, [x8, #0xa40] ; selector: addObjectsFromArray:
101a33aa0: aa1a03e2    	mov	x2, x26
101a33aa4: 9587d070    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33aa8: f9403be8    	ldr	x8, [sp, #0x70]
101a33aac: 37002de8    	tbnz	w8, #0x0, 0x101a34068 <__text+0x1a2c068>
101a33ab0: f00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a33ab4: b98dad08    	ldrsw	x8, [x8, #0xdac] ; ivar: FavBaseListViewController.m_flatPOIDataComplete offset=472
101a33ab8: 52800029    	mov	w9, #0x1                ; =1
101a33abc: 38286aa9    	strb	w9, [x21, x8]
101a33ac0: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a33ac4: f9414101    	ldr	x1, [x8, #0x280] ; selector: reloadFlatPOIData
101a33ac8: aa1503e0    	mov	x0, x21
101a33acc: 9587d066    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33ad0: f00e96f4    	adrp	x20, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a33ad4: 140001aa    	b	0x101a3417c <__text+0x1a2c17c>
101a33ad8: 54001280    	b.eq	0x101a33d28 <__text+0x1a2bd28>
101a33adc: 52b00008    	mov	w8, #-0x80000000        ; =-2147483648
101a33ae0: eb08009f    	cmp	x4, x8
101a33ae4: 54000881    	b.ne	0x101a33bf4 <__text+0x1a2bbf4>
101a33ae8: f943c280    	ldr	x0, [x20, #0x780]
101a33aec: f85903a1    	ldur	x1, [x29, #-0x70]
101a33af0: 9587d05d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33af4: aa1d03fd    	mov	x29, x29
101a33af8: 9587d062    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33afc: aa0003f3    	mov	x19, x0
101a33b00: 900e9708    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a33b04: f9448500    	ldr	x0, [x8, #0x908]
101a33b08: aa1a03e1    	mov	x1, x26
101a33b0c: 9587d056    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33b10: aa0003e2    	mov	x2, x0
101a33b14: aa1303e0    	mov	x0, x19
101a33b18: f9403fe1    	ldr	x1, [sp, #0x78]
101a33b1c: 9587d052    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33b20: aa1d03fd    	mov	x29, x29
101a33b24: 9587d057    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33b28: aa0003f6    	mov	x22, x0
101a33b2c: d00e7d28    	adrp	x8, 0x11e9d9000 <dyld_stub_binder+0x11e9d9000>
101a33b30: f9463501    	ldr	x1, [x8, #0xc68] ; selector: setting
101a33b34: 9587d04c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33b38: aa1d03fd    	mov	x29, x29
101a33b3c: 9587d051    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33b40: aa0003f7    	mov	x23, x0
101a33b44: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a33b48: f9416901    	ldr	x1, [x8, #0x2d0] ; selector: enableMusicList
101a33b4c: 9587d046    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33b50: 340002c0    	cbz	w0, 0x101a33ba8 <__text+0x1a2bba8>
101a33b54: f8786aa8    	ldr	x8, [x21, x24]
101a33b58: f101011f    	cmp	x8, #0x40
101a33b5c: 54000261    	b.ne	0x101a33ba8 <__text+0x1a2bba8>
101a33b60: f00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a33b64: b98de508    	ldrsw	x8, [x8, #0xde4] ; ivar: FavBaseListViewController._selectedTags offset=512
101a33b68: f8686aa0    	ldr	x0, [x21, x8]
101a33b6c: f85983a1    	ldur	x1, [x29, #-0x68]
101a33b70: 9587d03d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33b74: aa0003f4    	mov	x20, x0
101a33b78: aa1703e0    	mov	x0, x23
101a33b7c: 9587d03d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33b80: aa1603e0    	mov	x0, x22
101a33b84: 9587d03b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33b88: aa1303e0    	mov	x0, x19
101a33b8c: 9587d039    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33b90: b5000194    	cbnz	x20, 0x101a33bc0 <__text+0x1a2bbc0>
101a33b94: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a33b98: f9416d01    	ldr	x1, [x8, #0x2d8] ; selector: initTingListenListBar
101a33b9c: aa1503e0    	mov	x0, x21
101a33ba0: 9587d031    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33ba4: 14000007    	b	0x101a33bc0 <__text+0x1a2bbc0>
101a33ba8: aa1703e0    	mov	x0, x23
101a33bac: 9587d031    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33bb0: aa1603e0    	mov	x0, x22
101a33bb4: 9587d02f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33bb8: aa1303e0    	mov	x0, x19
101a33bbc: 9587d02d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33bc0: f8786aa2    	ldr	x2, [x21, x24]
101a33bc4: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a33bc8: f9411501    	ldr	x1, [x8, #0x228] ; selector: filterMusicItemBySelectedType:resultArr:
101a33bcc: aa1503e0    	mov	x0, x21
101a33bd0: aa1c03e3    	mov	x3, x28
101a33bd4: 9587d024    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33bd8: aa1d03fd    	mov	x29, x29
101a33bdc: 9587d029    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33be0: aa0003f3    	mov	x19, x0
101a33be4: aa1c03e0    	mov	x0, x28
101a33be8: 9587d022    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33bec: aa1303fc    	mov	x28, x19
101a33bf0: f00e96f4    	adrp	x20, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a33bf4: f9403bf6    	ldr	x22, [sp, #0x70]
101a33bf8: f00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a33bfc: b98d7d13    	ldrsw	x19, [x8, #0xd7c] ; ivar: FavBaseListViewController.m_dataController offset=200
101a33c00: f8736aa0    	ldr	x0, [x21, x19]
101a33c04: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a33c08: f940fd01    	ldr	x1, [x8, #0x1f8] ; selector: addFavItemList:
101a33c0c: aa1c03e2    	mov	x2, x28
101a33c10: 9587d015    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33c14: f8736aa0    	ldr	x0, [x21, x19]
101a33c18: d00e7d28    	adrp	x8, 0x11e9d9000 <dyld_stub_binder+0x11e9d9000>
101a33c1c: f9417101    	ldr	x1, [x8, #0x2e0] ; selector: setHasMoreData:
101a33c20: aa1603e2    	mov	x2, x22
101a33c24: 9587d010    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33c28: f943c280    	ldr	x0, [x20, #0x780]
101a33c2c: f85903b6    	ldur	x22, [x29, #-0x70]
101a33c30: aa1603e1    	mov	x1, x22
101a33c34: 9587d00c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33c38: aa1d03fd    	mov	x29, x29
101a33c3c: 9587d011    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33c40: aa0003f3    	mov	x19, x0
101a33c44: f9003be0    	str	x0, [sp, #0x70]
101a33c48: 900e9718    	adrp	x24, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a33c4c: f9448700    	ldr	x0, [x24, #0x908]
101a33c50: aa1a03e1    	mov	x1, x26
101a33c54: 9587d004    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33c58: aa0003e2    	mov	x2, x0
101a33c5c: aa1303e0    	mov	x0, x19
101a33c60: f9403ff7    	ldr	x23, [sp, #0x78]
101a33c64: aa1703e1    	mov	x1, x23
101a33c68: 9587cfff    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33c6c: aa1d03fd    	mov	x29, x29
101a33c70: 9587d004    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33c74: f81a03a0    	stur	x0, [x29, #-0x60]
101a33c78: f85883b3    	ldur	x19, [x29, #-0x78]
101a33c7c: f8736aa2    	ldr	x2, [x21, x19]
101a33c80: aa1b03e1    	mov	x1, x27
101a33c84: d2800003    	mov	x3, #0x0                ; =0
101a33c88: 9587cff7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33c8c: 2a0003f4    	mov	w20, w0
101a33c90: f00e96e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a33c94: f943c100    	ldr	x0, [x8, #0x780]
101a33c98: aa1603e1    	mov	x1, x22
101a33c9c: 9587cff2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33ca0: aa1d03fd    	mov	x29, x29
101a33ca4: 9587cff7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33ca8: aa0003f6    	mov	x22, x0
101a33cac: f9448700    	ldr	x0, [x24, #0x908]
101a33cb0: aa1a03e1    	mov	x1, x26
101a33cb4: 9587cfec    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33cb8: aa0003e2    	mov	x2, x0
101a33cbc: aa1603e0    	mov	x0, x22
101a33cc0: aa1703e1    	mov	x1, x23
101a33cc4: 9587cfe8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33cc8: aa1d03fd    	mov	x29, x29
101a33ccc: 9587cfed    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33cd0: aa0003f7    	mov	x23, x0
101a33cd4: f00e7d08    	adrp	x8, 0x11e9d6000 <dyld_stub_binder+0x11e9d6000>
101a33cd8: f9426901    	ldr	x1, [x8, #0x4d0] ; selector: reportLogic
101a33cdc: 9587cfe2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33ce0: aa1d03fd    	mov	x29, x29
101a33ce4: 9587cfe7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33ce8: aa0003fb    	mov	x27, x0
101a33cec: d00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a33cf0: f9467101    	ldr	x1, [x8, #0xce0] ; selector: setLocalResultNum:
101a33cf4: aa1403e2    	mov	x2, x20
101a33cf8: f00e96f4    	adrp	x20, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a33cfc: 9587cfda    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33d00: aa1b03e0    	mov	x0, x27
101a33d04: 9587cfdb    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33d08: aa1703e0    	mov	x0, x23
101a33d0c: aa1303f7    	mov	x23, x19
101a33d10: f9403bfa    	ldr	x26, [sp, #0x70]
101a33d14: 9587cfd7    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33d18: aa1603e0    	mov	x0, x22
101a33d1c: 9587cfd5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33d20: f85a03a0    	ldur	x0, [x29, #-0x60]
101a33d24: 14000115    	b	0x101a34178 <__text+0x1a2c178>
101a33d28: aa1c03e0    	mov	x0, x28
101a33d2c: aa1603e1    	mov	x1, x22
101a33d30: 9587cfcd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33d34: b4004140    	cbz	x0, 0x101a3455c <__text+0x1a2c55c>
101a33d38: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a33d3c: f9415101    	ldr	x1, [x8, #0x2a0] ; selector: genFinderDataItemsWith:
101a33d40: aa1503e0    	mov	x0, x21
101a33d44: aa1c03e2    	mov	x2, x28
101a33d48: 9587cfc7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33d4c: aa1d03fd    	mov	x29, x29
101a33d50: 9587cfcc    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33d54: aa1a03f7    	mov	x23, x26
101a33d58: aa0003fa    	mov	x26, x0
101a33d5c: f00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a33d60: b98d8113    	ldrsw	x19, [x8, #0xd80] ; ivar: FavBaseListViewController.m_arrFinderItems offset=176
101a33d64: f8736aa0    	ldr	x0, [x21, x19]
101a33d68: d00e9388    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
101a33d6c: f9452101    	ldr	x1, [x8, #0xa40] ; selector: addObjectsFromArray:
101a33d70: aa1a03e2    	mov	x2, x26
101a33d74: 9587cfbc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33d78: f8736aa0    	ldr	x0, [x21, x19]
101a33d7c: aa1603e1    	mov	x1, x22
101a33d80: 9587cfb9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33d84: aa0003f3    	mov	x19, x0
101a33d88: f943c280    	ldr	x0, [x20, #0x780]
101a33d8c: f85903a1    	ldur	x1, [x29, #-0x70]
101a33d90: 9587cfb5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33d94: aa1d03fd    	mov	x29, x29
101a33d98: 9587cfba    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33d9c: aa0003f4    	mov	x20, x0
101a33da0: 900e9708    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a33da4: f9448500    	ldr	x0, [x8, #0x908]
101a33da8: aa1703fb    	mov	x27, x23
101a33dac: aa1703e1    	mov	x1, x23
101a33db0: 9587cfad    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33db4: aa0003e2    	mov	x2, x0
101a33db8: aa1403e0    	mov	x0, x20
101a33dbc: f9403fe1    	ldr	x1, [sp, #0x78]
101a33dc0: 9587cfa9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33dc4: aa1d03fd    	mov	x29, x29
101a33dc8: 9587cfae    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33dcc: aa0003f6    	mov	x22, x0
101a33dd0: f00e7d08    	adrp	x8, 0x11e9d6000 <dyld_stub_binder+0x11e9d6000>
101a33dd4: f9426901    	ldr	x1, [x8, #0x4d0] ; selector: reportLogic
101a33dd8: 9587cfa3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33ddc: aa1d03fd    	mov	x29, x29
101a33de0: 9587cfa8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33de4: aa0003f7    	mov	x23, x0
101a33de8: d00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a33dec: f9467101    	ldr	x1, [x8, #0xce0] ; selector: setLocalResultNum:
101a33df0: aa1303e2    	mov	x2, x19
101a33df4: 9587cf9c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33df8: aa1703e0    	mov	x0, x23
101a33dfc: 9587cf9d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33e00: aa1603e0    	mov	x0, x22
101a33e04: 9587cf9b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33e08: aa1403e0    	mov	x0, x20
101a33e0c: 9587cf99    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33e10: f00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a33e14: b98df116    	ldrsw	x22, [x8, #0xdf0] ; ivar: FavBaseListViewController.m_feedFlowView offset=168
101a33e18: f8766aa0    	ldr	x0, [x21, x22]
101a33e1c: b50000c0    	cbnz	x0, 0x101a33e34 <__text+0x1a2be34>
101a33e20: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a33e24: f9415501    	ldr	x1, [x8, #0x2a8] ; selector: initFeedFlowView
101a33e28: aa1503e0    	mov	x0, x21
101a33e2c: 9587cf8e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33e30: f8766aa0    	ldr	x0, [x21, x22]
101a33e34: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a33e38: f9415901    	ldr	x1, [x8, #0x2b0] ; selector: finderFeedFlowViewWillAppear
101a33e3c: 9587cf8a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33e40: f8766aa0    	ldr	x0, [x21, x22]
101a33e44: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a33e48: f9415d01    	ldr	x1, [x8, #0x2b8] ; selector: finderFeedFlowViewDidAppear
101a33e4c: 9587cf86    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33e50: f9403be8    	ldr	x8, [sp, #0x70]
101a33e54: 7100011f    	cmp	w8, #0x0
101a33e58: 528000a8    	mov	w8, #0x5                ; =5
101a33e5c: 9a9f0508    	csinc	x8, x8, xzr, eq
101a33e60: f00e9ae9    	adrp	x9, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a33e64: b98e2d29    	ldrsw	x9, [x9, #0xe2c] ; ivar: FavBaseListViewController.m_feedFlowViewState offset=184
101a33e68: f8296aa8    	str	x8, [x21, x9]
101a33e6c: f00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a33e70: b98e2914    	ldrsw	x20, [x8, #0xe28] ; ivar: FavBaseListViewController.m_feedDetailViewController offset=192
101a33e74: 8b1402a0    	add	x0, x21, x20
101a33e78: 9587cf79    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
101a33e7c: aa0003f3    	mov	x19, x0
101a33e80: 9587cf7c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33e84: b40002b3    	cbz	x19, 0x101a33ed8 <__text+0x1a2bed8>
101a33e88: 8b1402a0    	add	x0, x21, x20
101a33e8c: 9587cf74    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
101a33e90: aa0003f3    	mov	x19, x0
101a33e94: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a33e98: f9416101    	ldr	x1, [x8, #0x2c0] ; selector: convertFeedContentVMsToCustomBusinessFeedIDModels:
101a33e9c: aa1503e0    	mov	x0, x21
101a33ea0: aa1a03e2    	mov	x2, x26
101a33ea4: 9587cf70    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33ea8: aa1d03fd    	mov	x29, x29
101a33eac: 9587cf75    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33eb0: aa0003f4    	mov	x20, x0
101a33eb4: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a33eb8: f9416501    	ldr	x1, [x8, #0x2c8] ; selector: appendBusinessModelArray:
101a33ebc: aa1303e0    	mov	x0, x19
101a33ec0: aa1403e2    	mov	x2, x20
101a33ec4: 9587cf68    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33ec8: aa1403e0    	mov	x0, x20
101a33ecc: 9587cf69    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33ed0: aa1303e0    	mov	x0, x19
101a33ed4: 9587cf67    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33ed8: f8766aa0    	ldr	x0, [x21, x22]
101a33edc: b00e7cc8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
101a33ee0: f9414901    	ldr	x1, [x8, #0x290] ; selector: reloadData
101a33ee4: 9587cf60    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33ee8: f00e96e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a33eec: f9445100    	ldr	x0, [x8, #0x8a0]
101a33ef0: b00e7ce8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
101a33ef4: f9432501    	ldr	x1, [x8, #0x648] ; selector: genCurrentTimeInMsFrom1970
101a33ef8: 9587cf5b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33efc: f00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a33f00: b98e3113    	ldrsw	x19, [x8, #0xe30] ; ivar: FavBaseListViewController.showFinderTime offset=360
101a33f04: f8336aa0    	str	x0, [x21, x19]
101a33f08: b00e9708    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
101a33f0c: f944d508    	ldr	x8, [x8, #0x9a8]
101a33f10: f9003be8    	str	x8, [sp, #0x70]
101a33f14: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a33f18: f9413501    	ldr	x1, [x8, #0x268] ; selector: feedViewControllerScene
101a33f1c: aa1503e0    	mov	x0, x21
101a33f20: 9587cf51    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33f24: aa0003f6    	mov	x22, x0
101a33f28: f8736ab7    	ldr	x23, [x21, x19]
101a33f2c: f00e96f9    	adrp	x25, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a33f30: f943c320    	ldr	x0, [x25, #0x780]
101a33f34: f85903a1    	ldur	x1, [x29, #-0x70]
101a33f38: 9587cf4b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33f3c: aa1d03fd    	mov	x29, x29
101a33f40: 9587cf50    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33f44: aa0003f3    	mov	x19, x0
101a33f48: f00e96e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a33f4c: f944b900    	ldr	x0, [x8, #0x970]
101a33f50: aa1b03e1    	mov	x1, x27
101a33f54: 9587cf44    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33f58: aa0003e2    	mov	x2, x0
101a33f5c: aa1303e0    	mov	x0, x19
101a33f60: f9403fe1    	ldr	x1, [sp, #0x78]
101a33f64: 9587cf40    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33f68: aa1d03fd    	mov	x29, x29
101a33f6c: 9587cf45    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33f70: aa0003fb    	mov	x27, x0
101a33f74: 900e7cc8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
101a33f78: f946c901    	ldr	x1, [x8, #0xd90] ; selector: getSelfContact
101a33f7c: 9587cf3a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33f80: aa1d03fd    	mov	x29, x29
101a33f84: 9587cf3f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33f88: aa1a03f8    	mov	x24, x26
101a33f8c: aa0003fa    	mov	x26, x0
101a33f90: b00e7cc8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
101a33f94: f9472101    	ldr	x1, [x8, #0xe40] ; selector: username
101a33f98: 9587cf33    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33f9c: aa1d03fd    	mov	x29, x29
101a33fa0: 9587cf38    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a33fa4: aa0003f4    	mov	x20, x0
101a33fa8: f00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a33fac: f9413901    	ldr	x1, [x8, #0x270] ; selector: reportEnterPage:eventCode:eventTime:username:extInfo:refCommentScene:leaveTime:
101a33fb0: f90003ff    	str	xzr, [sp]
101a33fb4: f9403be0    	ldr	x0, [sp, #0x70]
101a33fb8: aa1603e2    	mov	x2, x22
101a33fbc: d2800003    	mov	x3, #0x0                ; =0
101a33fc0: aa1703e4    	mov	x4, x23
101a33fc4: aa1403e5    	mov	x5, x20
101a33fc8: d2800006    	mov	x6, #0x0                ; =0
101a33fcc: 52800007    	mov	w7, #0x0                ; =0
101a33fd0: 9587cf25    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a33fd4: aa1403e0    	mov	x0, x20
101a33fd8: aa1903f4    	mov	x20, x25
101a33fdc: 9587cf25    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33fe0: aa1a03e0    	mov	x0, x26
101a33fe4: aa1803fa    	mov	x26, x24
101a33fe8: 9587cf22    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33fec: aa1b03e0    	mov	x0, x27
101a33ff0: 9587cf20    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33ff4: aa1303e0    	mov	x0, x19
101a33ff8: 9587cf1e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a33ffc: f85883b7    	ldur	x23, [x29, #-0x78]
101a34000: f00e96f8    	adrp	x24, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a34004: f94043f9    	ldr	x25, [sp, #0x80]
101a34008: 1400005d    	b	0x101a3417c <__text+0x1a2c17c>
101a3400c: f9402be8    	ldr	x8, [sp, #0x50]
101a34010: f8686aa8    	ldr	x8, [x21, x8]
101a34014: f100811f    	cmp	x8, #0x20
101a34018: f85983b6    	ldur	x22, [x29, #-0x68]
101a3401c: 54000341    	b.ne	0x101a34084 <__text+0x1a2c084>
101a34020: d00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a34024: b98ddd16    	ldrsw	x22, [x8, #0xddc] ; ivar: FavBaseListViewController.m_addressDataController offset=208
101a34028: f8766aa0    	ldr	x0, [x21, x22]
101a3402c: b00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a34030: f9437d13    	ldr	x19, [x8, #0x6f8] ; selector: arrDataWraps
101a34034: aa1303e1    	mov	x1, x19
101a34038: 9587cf0b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a3403c: aa1d03fd    	mov	x29, x29
101a34040: 9587cf10    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a34044: aa0003f4    	mov	x20, x0
101a34048: b00e9388    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
101a3404c: f9452101    	ldr	x1, [x8, #0xa40] ; selector: addObjectsFromArray:
101a34050: aa1a03e2    	mov	x2, x26
101a34054: 9587cf04    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34058: aa1403e0    	mov	x0, x20
101a3405c: 9587cf05    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a34060: f9403be8    	ldr	x8, [sp, #0x70]
101a34064: 360029c8    	tbz	w8, #0x0, 0x101a3459c <__text+0x1a2c59c>
101a34068: d00e7e88    	adrp	x8, 0x11ea06000 <dyld_stub_binder+0x11ea06000>
101a3406c: f9415901    	ldr	x1, [x8, #0x2b0] ; selector: onLoadMore
101a34070: aa1503e0    	mov	x0, x21
101a34074: 9587cefc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34078: aa1a03e0    	mov	x0, x26
101a3407c: 9587cefd    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a34080: 140000d9    	b	0x101a343e4 <__text+0x1a2c3e4>
101a34084: d00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a34088: b98d7d13    	ldrsw	x19, [x8, #0xd7c] ; ivar: FavBaseListViewController.m_dataController offset=200
101a3408c: f8736aa0    	ldr	x0, [x21, x19]
101a34090: b00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a34094: f9466901    	ldr	x1, [x8, #0xcd0] ; selector: addFavDataWrapList:
101a34098: aa1a03e2    	mov	x2, x26
101a3409c: 9587cef2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a340a0: f8736aa0    	ldr	x0, [x21, x19]
101a340a4: b00e7d28    	adrp	x8, 0x11e9d9000 <dyld_stub_binder+0x11e9d9000>
101a340a8: f9417101    	ldr	x1, [x8, #0x2e0] ; selector: setHasMoreData:
101a340ac: f9403be2    	ldr	x2, [sp, #0x70]
101a340b0: 9587ceed    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a340b4: f8736aa0    	ldr	x0, [x21, x19]
101a340b8: b00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a340bc: f9466d01    	ldr	x1, [x8, #0xcd8] ; selector: arrFavDataWrap
101a340c0: 9587cee9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a340c4: aa1d03fd    	mov	x29, x29
101a340c8: 9587ceee    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a340cc: f9003be0    	str	x0, [sp, #0x70]
101a340d0: aa1603e1    	mov	x1, x22
101a340d4: 9587cee4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a340d8: aa0003f4    	mov	x20, x0
101a340dc: d00e96e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a340e0: f943c100    	ldr	x0, [x8, #0x780]
101a340e4: f85903a1    	ldur	x1, [x29, #-0x70]
101a340e8: 9587cedf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a340ec: aa1d03fd    	mov	x29, x29
101a340f0: 9587cee4    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a340f4: aa0003f6    	mov	x22, x0
101a340f8: f9448700    	ldr	x0, [x24, #0x908]
101a340fc: f94037e1    	ldr	x1, [sp, #0x68]
101a34100: 9587ced9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34104: aa0003e2    	mov	x2, x0
101a34108: aa1603e0    	mov	x0, x22
101a3410c: f9403fe1    	ldr	x1, [sp, #0x78]
101a34110: 9587ced5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34114: aa1d03fd    	mov	x29, x29
101a34118: 9587ceda    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a3411c: aa1a03f3    	mov	x19, x26
101a34120: aa1703fa    	mov	x26, x23
101a34124: aa0003f7    	mov	x23, x0
101a34128: d00e7d08    	adrp	x8, 0x11e9d6000 <dyld_stub_binder+0x11e9d6000>
101a3412c: f9426901    	ldr	x1, [x8, #0x4d0] ; selector: reportLogic
101a34130: 9587cecd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34134: aa1d03fd    	mov	x29, x29
101a34138: 9587ced2    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a3413c: aa0003fb    	mov	x27, x0
101a34140: b00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a34144: f9467101    	ldr	x1, [x8, #0xce0] ; selector: setLocalResultNum:
101a34148: aa1403e2    	mov	x2, x20
101a3414c: d00e96f4    	adrp	x20, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a34150: 9587cec5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34154: aa1b03e0    	mov	x0, x27
101a34158: 9587cec6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a3415c: aa1703e0    	mov	x0, x23
101a34160: aa1a03f7    	mov	x23, x26
101a34164: aa1303fa    	mov	x26, x19
101a34168: 9587cec2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a3416c: aa1603e0    	mov	x0, x22
101a34170: 9587cec0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a34174: f9403be0    	ldr	x0, [sp, #0x70]
101a34178: 9587cebe    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a3417c: aa1a03e0    	mov	x0, x26
101a34180: 9587cebc    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a34184: f94037fa    	ldr	x26, [sp, #0x68]
101a34188: d00e96e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a3418c: f9444d00    	ldr	x0, [x8, #0x898]
101a34190: b00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a34194: f946b503    	ldr	x3, [x8, #0xd68] ; selector: showSearchLoading
101a34198: b00e7ca8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a3419c: f9476101    	ldr	x1, [x8, #0xec0] ; selector: safeCancelPreviousPerformRequestsWithTarget:selector:object:
101a341a0: aa1503e2    	mov	x2, x21
101a341a4: d2800004    	mov	x4, #0x0                ; =0
101a341a8: 9587ceaf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a341ac: f9402be8    	ldr	x8, [sp, #0x50]
101a341b0: f8686aa8    	ldr	x8, [x21, x8]
101a341b4: f100811f    	cmp	x8, #0x20
101a341b8: 54000341    	b.ne	0x101a34220 <__text+0x1a2c220>
101a341bc: f943c280    	ldr	x0, [x20, #0x780]
101a341c0: f85903a1    	ldur	x1, [x29, #-0x70]
101a341c4: 9587cea8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a341c8: aa1d03fd    	mov	x29, x29
101a341cc: 9587cead    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a341d0: aa0003f3    	mov	x19, x0
101a341d4: f9448700    	ldr	x0, [x24, #0x908]
101a341d8: aa1a03e1    	mov	x1, x26
101a341dc: 9587cea2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a341e0: aa0003e2    	mov	x2, x0
101a341e4: aa1303e0    	mov	x0, x19
101a341e8: f9403fe1    	ldr	x1, [sp, #0x78]
101a341ec: 9587ce9e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a341f0: aa1d03fd    	mov	x29, x29
101a341f4: 9587cea3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a341f8: aa0003f4    	mov	x20, x0
101a341fc: b00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a34200: f9465901    	ldr	x1, [x8, #0xcb0] ; selector: isFavFlatPOIEnabled
101a34204: 9587ce98    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34208: aa0003f6    	mov	x22, x0
101a3420c: aa1403e0    	mov	x0, x20
101a34210: 9587ce98    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a34214: aa1303e0    	mov	x0, x19
101a34218: 9587ce96    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a3421c: 340000d6    	cbz	w22, 0x101a34234 <__text+0x1a2c234>
101a34220: b00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a34224: f9467d01    	ldr	x1, [x8, #0xcf8] ; selector: setSearchLoading:
101a34228: aa1503e0    	mov	x0, x21
101a3422c: 52800002    	mov	w2, #0x0                ; =0
101a34230: 9587ce8d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34234: b00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a34238: f947cd18    	ldr	x24, [x8, #0xf98] ; selector: updateTagSearchResult
101a3423c: aa1503e0    	mov	x0, x21
101a34240: aa1803e1    	mov	x1, x24
101a34244: 9587ce88    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34248: f85983b6    	ldur	x22, [x29, #-0x68]
101a3424c: 37000640    	tbnz	w0, #0x0, 0x101a34314 <__text+0x1a2c314>
101a34250: aa1903fa    	mov	x26, x25
101a34254: d00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a34258: f9405101    	ldr	x1, [x8, #0xa0] ; selector: arrImgInfo
101a3425c: aa1503e0    	mov	x0, x21
101a34260: 9587ce81    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34264: aa1d03fd    	mov	x29, x29
101a34268: 9587ce86    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a3426c: aa0003f9    	mov	x25, x0
101a34270: aa1603e1    	mov	x1, x22
101a34274: 9587ce7c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34278: b5000480    	cbnz	x0, 0x101a34308 <__text+0x1a2c308>
101a3427c: d00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a34280: b98d8108    	ldrsw	x8, [x8, #0xd80] ; ivar: FavBaseListViewController.m_arrFinderItems offset=176
101a34284: f8686aa0    	ldr	x0, [x21, x8]
101a34288: aa1603e1    	mov	x1, x22
101a3428c: 9587ce76    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34290: b50003c0    	cbnz	x0, 0x101a34308 <__text+0x1a2c308>
101a34294: d00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a34298: b98d7d14    	ldrsw	x20, [x8, #0xd7c] ; ivar: FavBaseListViewController.m_dataController offset=200
101a3429c: f8746aa0    	ldr	x0, [x21, x20]
101a342a0: b00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a342a4: f9475501    	ldr	x1, [x8, #0xea8] ; selector: arrFavItem
101a342a8: 9587ce6f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a342ac: aa1d03fd    	mov	x29, x29
101a342b0: 9587ce74    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a342b4: aa0003f3    	mov	x19, x0
101a342b8: aa1603e1    	mov	x1, x22
101a342bc: 9587ce6a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a342c0: b5000200    	cbnz	x0, 0x101a34300 <__text+0x1a2c300>
101a342c4: f8746aa0    	ldr	x0, [x21, x20]
101a342c8: b00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a342cc: f9466d01    	ldr	x1, [x8, #0xcd8] ; selector: arrFavDataWrap
101a342d0: 9587ce65    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a342d4: aa1d03fd    	mov	x29, x29
101a342d8: 9587ce6a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a342dc: aa1603f7    	mov	x23, x22
101a342e0: aa0003f6    	mov	x22, x0
101a342e4: aa1703e1    	mov	x1, x23
101a342e8: 9587ce5f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a342ec: b4001b60    	cbz	x0, 0x101a34658 <__text+0x1a2c658>
101a342f0: aa1603e0    	mov	x0, x22
101a342f4: 9587ce5f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a342f8: aa1703f6    	mov	x22, x23
101a342fc: f85883b7    	ldur	x23, [x29, #-0x78]
101a34300: aa1303e0    	mov	x0, x19
101a34304: 9587ce5b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a34308: aa1903e0    	mov	x0, x25
101a3430c: 9587ce59    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a34310: aa1a03f9    	mov	x25, x26
101a34314: 52800002    	mov	w2, #0x0                ; =0
101a34318: b00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a3431c: f9467501    	ldr	x1, [x8, #0xce8] ; selector: setSearchEmpty:
101a34320: aa1503e0    	mov	x0, x21
101a34324: 9587ce50    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34328: aa1503e0    	mov	x0, x21
101a3432c: aa1803e1    	mov	x1, x24
101a34330: 9587ce4d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34334: f94033f4    	ldr	x20, [sp, #0x60]
101a34338: f8746aa0    	ldr	x0, [x21, x20]
101a3433c: 900e93a8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
101a34340: f9467513    	ldr	x19, [x8, #0xce8] ; selector: length
101a34344: aa1303e1    	mov	x1, x19
101a34348: 9587ce47    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a3434c: b4000320    	cbz	x0, 0x101a343b0 <__text+0x1a2c3b0>
101a34350: f8776aa2    	ldr	x2, [x21, x23]
101a34354: aa1903e0    	mov	x0, x25
101a34358: f9402fe1    	ldr	x1, [sp, #0x58]
101a3435c: 9587ce42    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34360: 34000280    	cbz	w0, 0x101a343b0 <__text+0x1a2c3b0>
101a34364: f94027e8    	ldr	x8, [sp, #0x48]
101a34368: 38686aa8    	ldrb	w8, [x21, x8]
101a3436c: 7100051f    	cmp	w8, #0x1
101a34370: 54000201    	b.ne	0x101a343b0 <__text+0x1a2c3b0>
101a34374: aa1c03e0    	mov	x0, x28
101a34378: aa1603e1    	mov	x1, x22
101a3437c: 9587ce3a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34380: aa0003e3    	mov	x3, x0
101a34384: f8746aa2    	ldr	x2, [x21, x20]
101a34388: d00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a3438c: f9426101    	ldr	x1, [x8, #0x4c0] ; selector: updateServerSearchHintWithQuery:resultCount:
101a34390: aa1503e0    	mov	x0, x21
101a34394: 9587ce34    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34398: d00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a3439c: b98d7d08    	ldrsw	x8, [x8, #0xd7c] ; ivar: FavBaseListViewController.m_dataController offset=200
101a343a0: f8686aa0    	ldr	x0, [x21, x8]
101a343a4: d00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a343a8: 91132108    	add	x8, x8, #0x4c8
101a343ac: 14000008    	b	0x101a343cc <__text+0x1a2c3cc>
101a343b0: f8746aa0    	ldr	x0, [x21, x20]
101a343b4: aa1303e1    	mov	x1, x19
101a343b8: 9587ce2b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a343bc: b50000c0    	cbnz	x0, 0x101a343d4 <__text+0x1a2c3d4>
101a343c0: b00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a343c4: 91350108    	add	x8, x8, #0xd40
101a343c8: aa1503e0    	mov	x0, x21
101a343cc: f9400101    	ldr	x1, [x8] ; selector: removeServerSearchHint
101a343d0: 9587ce25    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a343d4: b00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a343d8: f9478501    	ldr	x1, [x8, #0xf08] ; selector: schedulePreloadVisibleFavMPArticles
101a343dc: aa1503e0    	mov	x0, x21
101a343e0: 9587ce21    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a343e4: aa1903e0    	mov	x0, x25
101a343e8: 9587ce22    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a343ec: aa1c03e0    	mov	x0, x28
101a343f0: a9507bfd    	ldp	x29, x30, [sp, #0x100]
101a343f4: a94f4ff4    	ldp	x20, x19, [sp, #0xf0]
101a343f8: a94e57f6    	ldp	x22, x21, [sp, #0xe0]
101a343fc: a94d5ff8    	ldp	x24, x23, [sp, #0xd0]
101a34400: a94c67fa    	ldp	x26, x25, [sp, #0xc0]
101a34404: a94b6ffc    	ldp	x28, x27, [sp, #0xb0]
101a34408: 910443ff    	add	sp, sp, #0x110
101a3440c: 1587ce19    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a34410: d00e96e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a34414: f943c100    	ldr	x0, [x8, #0x780]
101a34418: f85903a1    	ldur	x1, [x29, #-0x70]
101a3441c: 9587ce12    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34420: aa1d03fd    	mov	x29, x29
101a34424: 9587ce17    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a34428: aa0003f3    	mov	x19, x0
101a3442c: f00e96e8    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a34430: f9448500    	ldr	x0, [x8, #0x908]
101a34434: f94037e1    	ldr	x1, [sp, #0x68]
101a34438: 9587ce0b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a3443c: aa0003e2    	mov	x2, x0
101a34440: aa1303e0    	mov	x0, x19
101a34444: f9403fe1    	ldr	x1, [sp, #0x78]
101a34448: 9587ce07    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a3444c: aa1d03fd    	mov	x29, x29
101a34450: 9587ce0c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a34454: aa0003f4    	mov	x20, x0
101a34458: f85883a8    	ldur	x8, [x29, #-0x78]
101a3445c: f8686aa2    	ldr	x2, [x21, x8]
101a34460: f94033e8    	ldr	x8, [sp, #0x60]
101a34464: f8686aa3    	ldr	x3, [x21, x8]
101a34468: d00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a3446c: f9425d01    	ldr	x1, [x8, #0x4b8] ; selector: hasSearchDoneForTaskKey:searchContent:
101a34470: 9587cdfd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34474: aa0003f6    	mov	x22, x0
101a34478: aa1403e0    	mov	x0, x20
101a3447c: 9587cdfd    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a34480: aa1303e0    	mov	x0, x19
101a34484: 9587cdfb    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a34488: aa1503e0    	mov	x0, x21
101a3448c: aa1b03e1    	mov	x1, x27
101a34490: 9587cdf5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34494: aa1d03fd    	mov	x29, x29
101a34498: 9587cdfa    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a3449c: aa0003f3    	mov	x19, x0
101a344a0: d00e7ee8    	adrp	x8, 0x11ea12000 <dyld_stub_binder+0x11ea12000>
101a344a4: f9442d01    	ldr	x1, [x8, #0x858] ; selector: updatePreMore:NextMore:
101a344a8: 520002c3    	eor	w3, w22, #0x1
101a344ac: 52800002    	mov	w2, #0x0                ; =0
101a344b0: 9587cded    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a344b4: aa1303e0    	mov	x0, x19
101a344b8: 9587cdee    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a344bc: aa1503e0    	mov	x0, x21
101a344c0: aa1b03e1    	mov	x1, x27
101a344c4: 9587cde8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a344c8: aa1d03fd    	mov	x29, x29
101a344cc: 9587cded    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a344d0: aa0003f3    	mov	x19, x0
101a344d4: d00e8088    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a344d8: f9414d01    	ldr	x1, [x8, #0x298] ; selector: updateLoading:NextMore:
101a344dc: 52800002    	mov	w2, #0x0                ; =0
101a344e0: 52800003    	mov	w3, #0x0                ; =0
101a344e4: 9587cde0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a344e8: aa1303e0    	mov	x0, x19
101a344ec: 9587cde1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a344f0: 370002d6    	tbnz	w22, #0x0, 0x101a34548 <__text+0x1a2c548>
101a344f4: aa1503e0    	mov	x0, x21
101a344f8: aa1a03e1    	mov	x1, x26
101a344fc: 9587cdda    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34500: aa1d03fd    	mov	x29, x29
101a34504: 9587cddf    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a34508: aa0003f3    	mov	x19, x0
101a3450c: f85983a1    	ldur	x1, [x29, #-0x68]
101a34510: 9587cdd5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34514: aa0003f4    	mov	x20, x0
101a34518: aa1303e0    	mov	x0, x19
101a3451c: 9587cdd5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a34520: b4000154    	cbz	x20, 0x101a34548 <__text+0x1a2c548>
101a34524: b00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a34528: f9468102    	ldr	x2, [x8, #0xd00] ; selector: checkAndLoadMoreIfNeeded
101a3452c: b00e93a8    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
101a34530: f946f501    	ldr	x1, [x8, #0xde8] ; selector: performSelector:withObject:afterDelay:
101a34534: f00af488    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
101a34538: fd445d00    	ldr	d0, [x8, #0x8b8] ; constant double=0.1
101a3453c: aa1503e0    	mov	x0, x21
101a34540: d2800003    	mov	x3, #0x0                ; =0
101a34544: 9587cdc8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34548: f85883b7    	ldur	x23, [x29, #-0x78]
101a3454c: f00e96f8    	adrp	x24, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a34550: d00e96f4    	adrp	x20, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a34554: f9403bfa    	ldr	x26, [sp, #0x70]
101a34558: 17ffff09    	b	0x101a3417c <__text+0x1a2c17c>
101a3455c: d00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a34560: b98d8108    	ldrsw	x8, [x8, #0xd80] ; ivar: FavBaseListViewController.m_arrFinderItems offset=176
101a34564: f8686aa0    	ldr	x0, [x21, x8]
101a34568: aa1603e1    	mov	x1, x22
101a3456c: 9587cdbe    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34570: f00e96f8    	adrp	x24, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
101a34574: b5ffe0a0    	cbnz	x0, 0x101a34188 <__text+0x1a2c188>
101a34578: d00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a3457c: b98df113    	ldrsw	x19, [x8, #0xdf0] ; ivar: FavBaseListViewController.m_feedFlowView offset=168
101a34580: f8736aa0    	ldr	x0, [x21, x19]
101a34584: d00e93a8    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
101a34588: f9424901    	ldr	x1, [x8, #0x490] ; selector: removeFromSuperview
101a3458c: 9587cdb6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34590: f8736aba    	ldr	x26, [x21, x19]
101a34594: f8336abf    	str	xzr, [x21, x19]
101a34598: 17fffef9    	b	0x101a3417c <__text+0x1a2c17c>
101a3459c: f8766aa0    	ldr	x0, [x21, x22]
101a345a0: b00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a345a4: f9440901    	ldr	x1, [x8, #0x810] ; selector: markDataLoadComplete
101a345a8: 9587cdaf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a345ac: f8766aa0    	ldr	x0, [x21, x22]
101a345b0: aa1303e1    	mov	x1, x19
101a345b4: 9587cdac    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a345b8: aa1d03fd    	mov	x29, x29
101a345bc: 9587cdb1    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a345c0: f9003be0    	str	x0, [sp, #0x70]
101a345c4: f85983a1    	ldur	x1, [x29, #-0x68]
101a345c8: 9587cda7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a345cc: aa0003f4    	mov	x20, x0
101a345d0: d00e96e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a345d4: f943c100    	ldr	x0, [x8, #0x780]
101a345d8: f85903a1    	ldur	x1, [x29, #-0x70]
101a345dc: 9587cda2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a345e0: aa1d03fd    	mov	x29, x29
101a345e4: 9587cda7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a345e8: aa0003f6    	mov	x22, x0
101a345ec: f9448700    	ldr	x0, [x24, #0x908]
101a345f0: f94037e1    	ldr	x1, [sp, #0x68]
101a345f4: 9587cd9c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a345f8: aa0003e2    	mov	x2, x0
101a345fc: aa1603e0    	mov	x0, x22
101a34600: f9403fe1    	ldr	x1, [sp, #0x78]
101a34604: 9587cd98    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34608: aa1d03fd    	mov	x29, x29
101a3460c: 9587cd9d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a34610: aa1703f3    	mov	x19, x23
101a34614: aa0003f7    	mov	x23, x0
101a34618: d00e7d08    	adrp	x8, 0x11e9d6000 <dyld_stub_binder+0x11e9d6000>
101a3461c: f9426901    	ldr	x1, [x8, #0x4d0] ; selector: reportLogic
101a34620: 9587cd91    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34624: aa1d03fd    	mov	x29, x29
101a34628: 9587cd96    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a3462c: aa0003fb    	mov	x27, x0
101a34630: b00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a34634: f9467101    	ldr	x1, [x8, #0xce0] ; selector: setLocalResultNum:
101a34638: aa1403e2    	mov	x2, x20
101a3463c: d00e96f4    	adrp	x20, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a34640: 9587cd89    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34644: aa1b03e0    	mov	x0, x27
101a34648: 9587cd8a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a3464c: aa1703e0    	mov	x0, x23
101a34650: aa1303f7    	mov	x23, x19
101a34654: 17fffec5    	b	0x101a34168 <__text+0x1a2c168>
101a34658: d00e9ae8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a3465c: b98ddd08    	ldrsw	x8, [x8, #0xddc] ; ivar: FavBaseListViewController.m_addressDataController offset=208
101a34660: f8686aa0    	ldr	x0, [x21, x8]
101a34664: b00e8088    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a34668: f9437d01    	ldr	x1, [x8, #0x6f8] ; selector: arrDataWraps
101a3466c: 9587cd7e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34670: aa1d03fd    	mov	x29, x29
101a34674: 9587cd83    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a34678: aa0003f4    	mov	x20, x0
101a3467c: aa1703e1    	mov	x1, x23
101a34680: 9587cd79    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a34684: f81a03a0    	stur	x0, [x29, #-0x60]
101a34688: aa1403e0    	mov	x0, x20
101a3468c: 9587cd79    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a34690: aa1603e0    	mov	x0, x22
101a34694: 9587cd77    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a34698: aa1303e0    	mov	x0, x19
101a3469c: 9587cd75    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a346a0: aa1903e0    	mov	x0, x25
101a346a4: 9587cd73    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a346a8: aa1a03f9    	mov	x25, x26
101a346ac: aa1703f6    	mov	x22, x23
101a346b0: f85883b7    	ldur	x23, [x29, #-0x78]
101a346b4: f85a03a8    	ldur	x8, [x29, #-0x60]
101a346b8: b5ffe2e8    	cbnz	x8, 0x101a34314 <__text+0x1a2c314>
101a346bc: 52800022    	mov	w2, #0x1                ; =1
101a346c0: 17ffff16    	b	0x101a34318 <__text+0x1a2c318>
