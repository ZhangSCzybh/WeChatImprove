
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101a2bb88: d10603ff    	sub	sp, sp, #0x180
101a2bb8c: 6d1123e9    	stp	d9, d8, [sp, #0x110]
101a2bb90: a9126ffc    	stp	x28, x27, [sp, #0x120]
101a2bb94: a91367fa    	stp	x26, x25, [sp, #0x130]
101a2bb98: a9145ff8    	stp	x24, x23, [sp, #0x140]
101a2bb9c: a91557f6    	stp	x22, x21, [sp, #0x150]
101a2bba0: a9164ff4    	stp	x20, x19, [sp, #0x160]
101a2bba4: a9177bfd    	stp	x29, x30, [sp, #0x170]
101a2bba8: 9105c3fd    	add	x29, sp, #0x170
101a2bbac: aa0303f4    	mov	x20, x3
101a2bbb0: aa0003f3    	mov	x19, x0
101a2bbb4: b00de908    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
101a2bbb8: f9451908    	ldr	x8, [x8, #0xa30]
101a2bbbc: f9400108    	ldr	x8, [x8]
101a2bbc0: f81903a8    	stur	x8, [x29, #-0x70]
101a2bbc4: d00ee8c8    	adrp	x8, 0x11f745000 <dyld_stub_binder+0x11f745000>
101a2bbc8: 52800029    	mov	w9, #0x1                ; =1
101a2bbcc: 393c6109    	strb	w9, [x8, #0xf18]
101a2bbd0: f00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2bbd4: f940e901    	ldr	x1, [x8, #0x1d0] ; selector: filterItemListByTabMode:
101a2bbd8: 9587f023    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bbdc: aa1d03fd    	mov	x29, x29
101a2bbe0: 9587f028    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2bbe4: aa0003fc    	mov	x28, x0
101a2bbe8: f00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2bbec: f940ed01    	ldr	x1, [x8, #0x1d8] ; selector: suppressNextConvertedNoteAutoScroll
101a2bbf0: f9001ff3    	str	x19, [sp, #0x38]
101a2bbf4: aa1303e0    	mov	x0, x19
101a2bbf8: 9587f01b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bbfc: f00e93c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a2bc00: f9442915    	ldr	x21, [x8, #0x850] ; selector: count
101a2bc04: 340002e0    	cbz	w0, 0x101a2bc60 <__text+0x1a23c60>
101a2bc08: aa1c03e0    	mov	x0, x28
101a2bc0c: aa1503e1    	mov	x1, x21
101a2bc10: 9587f015    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bc14: f100041f    	cmp	x0, #0x1
101a2bc18: 54000241    	b.ne	0x101a2bc60 <__text+0x1a23c60>
101a2bc1c: 900e93e8    	adrp	x8, 0x11eca7000 <dyld_stub_binder+0x11eca7000>
101a2bc20: f942cd01    	ldr	x1, [x8, #0x598] ; selector: firstObject
101a2bc24: aa1c03e0    	mov	x0, x28
101a2bc28: 9587f00f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bc2c: aa1d03fd    	mov	x29, x29
101a2bc30: 9587f014    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a2bc34: aa0003f6    	mov	x22, x0
101a2bc38: d00e7e68    	adrp	x8, 0x11e9f9000 <dyld_stub_binder+0x11e9f9000>
101a2bc3c: f9434501    	ldr	x1, [x8, #0x688] ; selector: sourceType
101a2bc40: 9587f009    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bc44: aa0003f7    	mov	x23, x0
101a2bc48: aa1603e0    	mov	x0, x22
101a2bc4c: 9587f009    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2bc50: 71007aff    	cmp	w23, #0x1e
101a2bc54: 1a9f17f3    	cset	w19, eq
101a2bc58: 1a9403f4    	csel	w20, wzr, w20, eq
101a2bc5c: 14000002    	b	0x101a2bc64 <__text+0x1a23c64>
101a2bc60: 52800013    	mov	w19, #0x0               ; =0
101a2bc64: aa1c03e0    	mov	x0, x28
101a2bc68: aa1503e1    	mov	x1, x21
101a2bc6c: 9587effe    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bc70: b4000e20    	cbz	x0, 0x101a2be34 <__text+0x1a23e34>
101a2bc74: 290353f3    	stp	w19, w20, [sp, #0x18]
101a2bc78: 4f00e400    	movi.16b	v0, #0x0
101a2bc7c: ad0303e0    	stp	q0, q0, [sp, #0x60]
101a2bc80: ad0203e0    	stp	q0, q0, [sp, #0x40]
101a2bc84: aa1c03e0    	mov	x0, x28
101a2bc88: 9587effb    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101a2bc8c: f00e93c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a2bc90: f9442d01    	ldr	x1, [x8, #0x858] ; selector: countByEnumeratingWithState:objects:count:
101a2bc94: 910103e2    	add	x2, sp, #0x40
101a2bc98: 910203e3    	add	x3, sp, #0x80
101a2bc9c: f90013e1    	str	x1, [sp, #0x20]
101a2bca0: 52800204    	mov	w4, #0x10               ; =16
101a2bca4: 9587eff0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bca8: b4000f20    	cbz	x0, 0x101a2be8c <__text+0x1a23e8c>
101a2bcac: aa0003f7    	mov	x23, x0
101a2bcb0: f9402be8    	ldr	x8, [sp, #0x50]
101a2bcb4: f9400116    	ldr	x22, [x8]
101a2bcb8: d2800013    	mov	x19, #0x0               ; =0
101a2bcbc: f00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2bcc0: f940f119    	ldr	x25, [x8, #0x1e0] ; selector: isUploading
101a2bcc4: b00e7d08    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
101a2bcc8: f946191a    	ldr	x26, [x8, #0xc30] ; selector: isUploadFail
101a2bccc: d00e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2bcd0: f946a509    	ldr	x9, [x8, #0xd48] ; selector: isPinTopConfigEnable
101a2bcd4: 900e7dc8    	adrp	x8, 0x11e9e3000 <dyld_stub_binder+0x11e9e3000>
101a2bcd8: f945111b    	ldr	x27, [x8, #0xa20] ; selector: updateTime
101a2bcdc: f00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2bce0: f940f508    	ldr	x8, [x8, #0x1e8] ; selector: pinTopTimestamp
101a2bce4: a902a3e9    	stp	x9, x8, [sp, #0x28]
101a2bce8: f9402be8    	ldr	x8, [sp, #0x50]
101a2bcec: f9400108    	ldr	x8, [x8]
101a2bcf0: eb16011f    	cmp	x8, x22
101a2bcf4: 54000060    	b.eq	0x101a2bd00 <__text+0x1a23d00>
101a2bcf8: aa1c03e0    	mov	x0, x28
101a2bcfc: 9587efd0    	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
101a2bd00: f94027e8    	ldr	x8, [sp, #0x48]
101a2bd04: f8737915    	ldr	x21, [x8, x19, lsl #3]
101a2bd08: aa1503e0    	mov	x0, x21
101a2bd0c: aa1903e1    	mov	x1, x25
101a2bd10: 9587efd5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bd14: 37000780    	tbnz	w0, #0x0, 0x101a2be04 <__text+0x1a23e04>
101a2bd18: aa1503e0    	mov	x0, x21
101a2bd1c: aa1a03e1    	mov	x1, x26
101a2bd20: 9587efd1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bd24: 37000700    	tbnz	w0, #0x0, 0x101a2be04 <__text+0x1a23e04>
101a2bd28: aa1c03f4    	mov	x20, x28
101a2bd2c: f00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2bd30: b98d7d08    	ldrsw	x8, [x8, #0xd7c] ; ivar: FavBaseListViewController.m_dataController offset=200
101a2bd34: f9401ffc    	ldr	x28, [sp, #0x38]
101a2bd38: f8686b80    	ldr	x0, [x28, x8]
101a2bd3c: f94017e1    	ldr	x1, [sp, #0x28]
101a2bd40: 9587efc9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bd44: 340003e0    	cbz	w0, 0x101a2bdc0 <__text+0x1a23dc0>
101a2bd48: f00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2bd4c: b98dd518    	ldrsw	x24, [x8, #0xdd4] ; ivar: FavBaseListViewController.m_curMinItemPinTopTime offset=116
101a2bd50: a94323e1    	ldp	x1, x8, [sp, #0x30]
101a2bd54: b878691c    	ldr	w28, [x8, x24]
101a2bd58: aa1503e0    	mov	x0, x21
101a2bd5c: 9587efc2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bd60: 6b00039f    	cmp	w28, w0
101a2bd64: f9401ffc    	ldr	x28, [sp, #0x38]
101a2bd68: 540000a9    	b.ls	0x101a2bd7c <__text+0x1a23d7c>
101a2bd6c: aa1503e0    	mov	x0, x21
101a2bd70: f9401be1    	ldr	x1, [sp, #0x30]
101a2bd74: 9587efbc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bd78: b8386b80    	str	w0, [x28, x24]
101a2bd7c: f00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2bd80: b98dd118    	ldrsw	x24, [x8, #0xdd0] ; ivar: FavBaseListViewController.m_curMinItemUpdateTime offset=112
101a2bd84: b8786b9c    	ldr	w28, [x28, x24]
101a2bd88: aa1503e0    	mov	x0, x21
101a2bd8c: aa1b03e1    	mov	x1, x27
101a2bd90: 9587efb5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bd94: 6b00039f    	cmp	w28, w0
101a2bd98: aa1403fc    	mov	x28, x20
101a2bd9c: 54000088    	b.hi	0x101a2bdac <__text+0x1a23dac>
101a2bda0: f9401fe8    	ldr	x8, [sp, #0x38]
101a2bda4: b8786908    	ldr	w8, [x8, x24]
101a2bda8: 350002e8    	cbnz	w8, 0x101a2be04 <__text+0x1a23e04>
101a2bdac: aa1503e0    	mov	x0, x21
101a2bdb0: f9401be1    	ldr	x1, [sp, #0x30]
101a2bdb4: 9587efac    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bdb8: 340001c0    	cbz	w0, 0x101a2bdf0 <__text+0x1a23df0>
101a2bdbc: 14000012    	b	0x101a2be04 <__text+0x1a23e04>
101a2bdc0: f00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2bdc4: b98dd118    	ldrsw	x24, [x8, #0xdd0] ; ivar: FavBaseListViewController.m_curMinItemUpdateTime offset=112
101a2bdc8: b8786b9c    	ldr	w28, [x28, x24]
101a2bdcc: aa1503e0    	mov	x0, x21
101a2bdd0: aa1b03e1    	mov	x1, x27
101a2bdd4: 9587efa4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bdd8: 6b00039f    	cmp	w28, w0
101a2bddc: aa1403fc    	mov	x28, x20
101a2bde0: 54000088    	b.hi	0x101a2bdf0 <__text+0x1a23df0>
101a2bde4: f9401fe8    	ldr	x8, [sp, #0x38]
101a2bde8: b8786908    	ldr	w8, [x8, x24]
101a2bdec: 350000c8    	cbnz	w8, 0x101a2be04 <__text+0x1a23e04>
101a2bdf0: aa1503e0    	mov	x0, x21
101a2bdf4: aa1b03e1    	mov	x1, x27
101a2bdf8: 9587ef9b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bdfc: f9401fe8    	ldr	x8, [sp, #0x38]
101a2be00: b8386900    	str	w0, [x8, x24]
101a2be04: 91000673    	add	x19, x19, #0x1
101a2be08: eb1302ff    	cmp	x23, x19
101a2be0c: 54fff6e1    	b.ne	0x101a2bce8 <__text+0x1a23ce8>
101a2be10: 910103e2    	add	x2, sp, #0x40
101a2be14: 910203e3    	add	x3, sp, #0x80
101a2be18: aa1c03e0    	mov	x0, x28
101a2be1c: f94013e1    	ldr	x1, [sp, #0x20]
101a2be20: 52800204    	mov	w4, #0x10               ; =16
101a2be24: 9587ef90    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2be28: aa0003f7    	mov	x23, x0
101a2be2c: b5fff460    	cbnz	x0, 0x101a2bcb8 <__text+0x1a23cb8>
101a2be30: 1400001a    	b	0x101a2be98 <__text+0x1a23e98>
101a2be34: f00e9728    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a2be38: f9430d15    	ldr	x21, [x8, #0x618]
101a2be3c: d00e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2be40: f9461501    	ldr	x1, [x8, #0xc28] ; selector: tabMode
101a2be44: f9401fe0    	ldr	x0, [sp, #0x38]
101a2be48: 9587ef87    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2be4c: d00e7ce8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a2be50: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
101a2be54: 900db448    	adrp	x8, 0x11d0b3000 <dyld_stub_binder+0x11d0b3000>
101a2be58: 91296108    	add	x8, x8, #0xa58 ; CFString: [FavBaseList] addItemList: filteredList is empty after tabMode filter, skip. tabMode=%ld
101a2be5c: a90003e8    	stp	x8, x0, [sp]
101a2be60: 900c1b85    	adrp	x5, 0x119d9b000 <dyld_stub_binder+0x119d9b000>
101a2be64: 9107f8a5    	add	x5, x5, #0x1fe
101a2be68: 900c1b87    	adrp	x7, 0x119d9b000 <dyld_stub_binder+0x119d9b000>
101a2be6c: 9123b4e7    	add	x7, x7, #0x8ed
101a2be70: aa1503e0    	mov	x0, x21
101a2be74: 52800042    	mov	w2, #0x2                ; =2
101a2be78: d2800003    	mov	x3, #0x0                ; =0
101a2be7c: 52800004    	mov	w4, #0x0                ; =0
101a2be80: 5280fde6    	mov	w6, #0x7ef              ; =2031
101a2be84: 9587ef78    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2be88: 14000045    	b	0x101a2bf9c <__text+0x1a23f9c>
101a2be8c: d00e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2be90: f946a508    	ldr	x8, [x8, #0xd48] ; selector: isPinTopConfigEnable
101a2be94: f90017e8    	str	x8, [sp, #0x28]
101a2be98: aa1c03e0    	mov	x0, x28
101a2be9c: 9587ef75    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2bea0: f00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2bea4: b98d7d13    	ldrsw	x19, [x8, #0xd7c] ; ivar: FavBaseListViewController.m_dataController offset=200
101a2bea8: f9401ff4    	ldr	x20, [sp, #0x38]
101a2beac: f8736a80    	ldr	x0, [x20, x19]
101a2beb0: f94017e1    	ldr	x1, [sp, #0x28]
101a2beb4: 9587ef6c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2beb8: 34000100    	cbz	w0, 0x101a2bed8 <__text+0x1a23ed8>
101a2bebc: f00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2bec0: b98dd508    	ldrsw	x8, [x8, #0xdd4] ; ivar: FavBaseListViewController.m_curMinItemPinTopTime offset=116
101a2bec4: b8686a88    	ldr	w8, [x20, x8]
101a2bec8: 34000088    	cbz	w8, 0x101a2bed8 <__text+0x1a23ed8>
101a2becc: f00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2bed0: b98dd108    	ldrsw	x8, [x8, #0xdd0] ; ivar: FavBaseListViewController.m_curMinItemUpdateTime offset=112
101a2bed4: b8286a9f    	str	wzr, [x20, x8]
101a2bed8: f00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2bedc: f940f901    	ldr	x1, [x8, #0x1f0] ; selector: getContentOffsetAfterAdd:
101a2bee0: aa1403e0    	mov	x0, x20
101a2bee4: aa1c03e2    	mov	x2, x28
101a2bee8: 9587ef5f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2beec: 4ea01c08    	mov.16b	v8, v0
101a2bef0: f8736a80    	ldr	x0, [x20, x19]
101a2bef4: f00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2bef8: f940fd01    	ldr	x1, [x8, #0x1f8] ; selector: addFavItemList:
101a2befc: aa1c03e2    	mov	x2, x28
101a2bf00: 9587ef59    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bf04: f00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2bf08: f9410101    	ldr	x1, [x8, #0x200] ; selector: reloadContent
101a2bf0c: aa1403e0    	mov	x0, x20
101a2bf10: 9587ef55    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bf14: 1e602108    	fcmp	d8, #0.0
101a2bf18: b9401fe8    	ldr	w8, [sp, #0x1c]
101a2bf1c: 52000108    	eor	w8, w8, #0x1
101a2bf20: 1a9fc508    	csinc	w8, w8, wzr, gt
101a2bf24: 370002e8    	tbnz	w8, #0x0, 0x101a2bf80 <__text+0x1a23f80>
101a2bf28: f00e9b28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a2bf2c: b98da113    	ldrsw	x19, [x8, #0xda0] ; ivar: FavBaseListViewController.m_tableView offset=136
101a2bf30: f9401ff4    	ldr	x20, [sp, #0x38]
101a2bf34: f8736a95    	ldr	x21, [x20, x19]
101a2bf38: f00e93c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a2bf3c: f943a501    	ldr	x1, [x8, #0x748] ; selector: contentOffset
101a2bf40: aa1503e0    	mov	x0, x21
101a2bf44: 9587ef48    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bf48: 1e683828    	fsub	d8, d1, d8
101a2bf4c: f8736a80    	ldr	x0, [x20, x19]
101a2bf50: 900e7d08    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
101a2bf54: f9457501    	ldr	x1, [x8, #0xae8] ; selector: contentInset
101a2bf58: 9587ef43    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bf5c: 1e614000    	fneg	d0, d0
101a2bf60: 1e602100    	fcmp	d8, d0
101a2bf64: 1e684c01    	fcsel	d1, d0, d8, mi
101a2bf68: 900e7d08    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
101a2bf6c: f9457101    	ldr	x1, [x8, #0xae0] ; selector: setContentOffset:animated:
101a2bf70: 9e6703e0    	fmov	d0, xzr
101a2bf74: aa1503e0    	mov	x0, x21
101a2bf78: 52800022    	mov	w2, #0x1                ; =1
101a2bf7c: 9587ef3a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bf80: b9401be8    	ldr	w8, [sp, #0x18]
101a2bf84: 340000c8    	cbz	w8, 0x101a2bf9c <__text+0x1a23f9c>
101a2bf88: f00e80c8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a2bf8c: f9410501    	ldr	x1, [x8, #0x208] ; selector: setSuppressNextConvertedNoteAutoScroll:
101a2bf90: f9401fe0    	ldr	x0, [sp, #0x38]
101a2bf94: 52800002    	mov	w2, #0x0                ; =0
101a2bf98: 9587ef33    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2bf9c: aa1c03e0    	mov	x0, x28
101a2bfa0: 9587ef34    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2bfa4: f85903a8    	ldur	x8, [x29, #-0x70]
101a2bfa8: b00de909    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
101a2bfac: f9451929    	ldr	x9, [x9, #0xa30]
101a2bfb0: f9400129    	ldr	x9, [x9]
101a2bfb4: eb08013f    	cmp	x9, x8
101a2bfb8: 54000141    	b.ne	0x101a2bfe0 <__text+0x1a23fe0>
101a2bfbc: a9577bfd    	ldp	x29, x30, [sp, #0x170]
101a2bfc0: a9564ff4    	ldp	x20, x19, [sp, #0x160]
101a2bfc4: a95557f6    	ldp	x22, x21, [sp, #0x150]
101a2bfc8: a9545ff8    	ldp	x24, x23, [sp, #0x140]
101a2bfcc: a95367fa    	ldp	x26, x25, [sp, #0x130]
101a2bfd0: a9526ffc    	ldp	x28, x27, [sp, #0x120]
101a2bfd4: 6d5123e9    	ldp	d9, d8, [sp, #0x110]
101a2bfd8: 910603ff    	add	sp, sp, #0x180
101a2bfdc: d65f03c0    	ret
101a2bfe0: 9587edd4    	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
