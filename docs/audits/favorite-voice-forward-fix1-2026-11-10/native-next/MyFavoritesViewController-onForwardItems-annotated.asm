
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
10529a684: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
10529a688: a90167fa    	stp	x26, x25, [sp, #0x10]
10529a68c: a9025ff8    	stp	x24, x23, [sp, #0x20]
10529a690: a90357f6    	stp	x22, x21, [sp, #0x30]
10529a694: a9044ff4    	stp	x20, x19, [sp, #0x40]
10529a698: a9057bfd    	stp	x29, x30, [sp, #0x50]
10529a69c: 910143fd    	add	x29, sp, #0x50
10529a6a0: d10783ff    	sub	sp, sp, #0x1e0
10529a6a4: aa0003f9    	mov	x25, x0
10529a6a8: d00c2588    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10529a6ac: f9451908    	ldr	x8, [x8, #0xa30]
10529a6b0: f9400108    	ldr	x8, [x8]
10529a6b4: f81a03a8    	stur	x8, [x29, #-0x60]
10529a6b8: 900d25c8    	adrp	x8, 0x11f752000 <dyld_stub_binder+0x11f752000>
10529a6bc: 52800029    	mov	w9, #0x1                ; =1
10529a6c0: 39358909    	strb	w9, [x8, #0xd62]
10529a6c4: 900cd3c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10529a6c8: 900cd7c9    	adrp	x9, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
10529a6cc: 9135f129    	add	x9, x9, #0xd7c
10529a6d0: f9431d14    	ldr	x20, [x8, #0x638]
10529a6d4: b9800136    	ldrsw	x22, [x9] ; ivar: FavBaseListViewController.m_dataController offset=200
10529a6d8: f8766800    	ldr	x0, [x0, x22]
10529a6dc: 900cbd68    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
10529a6e0: f941e113    	ldr	x19, [x8, #0x3c0] ; selector: selectedItemsDict
10529a6e4: aa1303e1    	mov	x1, x19
10529a6e8: 94a6355f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a6ec: aa1d03fd    	mov	x29, x29
10529a6f0: 94a63564    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529a6f4: aa0003f5    	mov	x21, x0
10529a6f8: 900cd068    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10529a6fc: f9442901    	ldr	x1, [x8, #0x850] ; selector: count
10529a700: 94a63559    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a704: f00cd088    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
10529a708: f942e501    	ldr	x1, [x8, #0x5c8] ; selector: stringWithFormat:
10529a70c: f90003e0    	str	x0, [sp]
10529a710: 900c0262    	adrp	x2, 0x11d2e6000 <dyld_stub_binder+0x11d2e6000>
10529a714: 9103e042    	add	x2, x2, #0xf8 ; CFString: %lu,1
10529a718: aa1403e0    	mov	x0, x20
10529a71c: 94a63552    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a720: aa1d03fd    	mov	x29, x29
10529a724: 94a63557    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529a728: aa0003f7    	mov	x23, x0
10529a72c: aa1503e0    	mov	x0, x21
10529a730: 94a63550    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529a734: d00cc4c8    	adrp	x8, 0x11eb34000 <dyld_stub_binder+0x11eb34000>
10529a738: f943a901    	ldr	x1, [x8, #0x750] ; selector: shouldEnableListScopeMultiSelect
10529a73c: aa1903e0    	mov	x0, x25
10529a740: 94a63549    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a744: 34000380    	cbz	w0, 0x10529a7b4 <_Flutter_MMFoundation_BindContext+0x1521480>
10529a748: 52856ea0    	mov	w0, #0x2b75             ; =11125
10529a74c: aa1703e1    	mov	x1, x23
10529a750: 52800002    	mov	w2, #0x0                ; =0
10529a754: 52800003    	mov	w3, #0x0                ; =0
10529a758: 9745fe5d    	bl	0x10241a0cc <_Flutter_Image_provideRelativePathByUrl+0x6a2558>
10529a75c: f8766b20    	ldr	x0, [x25, x22]
10529a760: aa1303e1    	mov	x1, x19
10529a764: 94a63540    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a768: aa1d03fd    	mov	x29, x29
10529a76c: 94a63545    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529a770: aa0003f3    	mov	x19, x0
10529a774: f00cd048    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
10529a778: f945ed01    	ldr	x1, [x8, #0xbd8] ; selector: allValues
10529a77c: 94a6353a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a780: aa1d03fd    	mov	x29, x29
10529a784: 94a6353f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529a788: aa0003f4    	mov	x20, x0
10529a78c: d00cc4c8    	adrp	x8, 0x11eb34000 <dyld_stub_binder+0x11eb34000>
10529a790: f9437901    	ldr	x1, [x8, #0x6f0] ; selector: forwardData:
10529a794: aa1903e0    	mov	x0, x25
10529a798: aa1403e2    	mov	x2, x20
10529a79c: 94a63532    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a7a0: aa1403e0    	mov	x0, x20
10529a7a4: 94a63533    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529a7a8: aa1303e0    	mov	x0, x19
10529a7ac: 94a63531    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529a7b0: 14000128    	b	0x10529ac50 <_Flutter_MMFoundation_BindContext+0x152191c>
10529a7b4: f00cbd48    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
10529a7b8: f946c914    	ldr	x20, [x8, #0xd90] ; selector: selectedType
10529a7bc: aa1903e0    	mov	x0, x25
10529a7c0: aa1403e1    	mov	x1, x20
10529a7c4: 94a63528    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a7c8: f148001f    	cmp	x0, #0x200, lsl #12     ; =0x200000
10529a7cc: f9001ff9    	str	x25, [sp, #0x38]
10529a7d0: 54000ba1    	b.ne	0x10529a944 <_Flutter_MMFoundation_BindContext+0x1521610>
10529a7d4: f90007f7    	str	x23, [sp, #0x8]
10529a7d8: 900cd3c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10529a7dc: f9432d00    	ldr	x0, [x8, #0x658]
10529a7e0: f00cd048    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
10529a7e4: f946c501    	ldr	x1, [x8, #0xd88] ; selector: array
10529a7e8: 94a6351f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a7ec: aa1d03fd    	mov	x29, x29
10529a7f0: 94a63524    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529a7f4: f90027e0    	str	x0, [sp, #0x48]
10529a7f8: 900cd7c8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
10529a7fc: 9137c108    	add	x8, x8, #0xdf0
10529a800: b9800108    	ldrsw	x8, [x8] ; ivar: FavBaseListViewController.m_feedFlowView offset=168
10529a804: f8686b20    	ldr	x0, [x25, x8]
10529a808: f00cbd68    	adrp	x8, 0x11ea49000 <dyld_stub_binder+0x11ea49000>
10529a80c: f9424101    	ldr	x1, [x8, #0x480] ; selector: getSelectedItems
10529a810: 94a63515    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a814: aa1d03fd    	mov	x29, x29
10529a818: 94a6351a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529a81c: aa0003f6    	mov	x22, x0
10529a820: 4f00e400    	movi.16b	v0, #0x0
10529a824: ad0483e0    	stp	q0, q0, [sp, #0x90]
10529a828: ad0583e0    	stp	q0, q0, [sp, #0xb0]
10529a82c: 900cd068    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10529a830: f9442d01    	ldr	x1, [x8, #0x858] ; selector: countByEnumeratingWithState:objects:count:
10529a834: 910243e2    	add	x2, sp, #0x90
10529a838: d10383a3    	sub	x3, x29, #0xe0
10529a83c: f90023e1    	str	x1, [sp, #0x40]
10529a840: 52800204    	mov	w4, #0x10               ; =16
10529a844: 94a63508    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a848: b4000700    	cbz	x0, 0x10529a928 <_Flutter_MMFoundation_BindContext+0x15215f4>
10529a84c: aa0003f3    	mov	x19, x0
10529a850: f94053e8    	ldr	x8, [sp, #0xa0]
10529a854: f9400117    	ldr	x23, [x8]
10529a858: b00bf0d4    	adrp	x20, 0x11d0b3000 <dyld_stub_binder+0x11d0b3000>
10529a85c: 9128e294    	add	x20, x20, #0xa38 ; CFString: FavAttachToFinderContentVMTag
10529a860: d2800015    	mov	x21, #0x0               ; =0
10529a864: 900cb988    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
10529a868: f9429d18    	ldr	x24, [x8, #0x538] ; selector: getAttachedObjectForKey:
10529a86c: 900cd068    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10529a870: f9428519    	ldr	x25, [x8, #0x508] ; selector: class
10529a874: d00cd068    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
10529a878: f944491a    	ldr	x26, [x8, #0x890] ; selector: isKindOfClass:
10529a87c: 900cb988    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
10529a880: f942c11b    	ldr	x27, [x8, #0x580] ; selector: safeAddObject:
10529a884: f94053e8    	ldr	x8, [sp, #0xa0]
10529a888: f9400108    	ldr	x8, [x8]
10529a88c: eb17011f    	cmp	x8, x23
10529a890: 54000060    	b.eq	0x10529a89c <_Flutter_MMFoundation_BindContext+0x1521568>
10529a894: aa1603e0    	mov	x0, x22
10529a898: 94a634e9    	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
10529a89c: f9404fe8    	ldr	x8, [sp, #0x98]
10529a8a0: f8757900    	ldr	x0, [x8, x21, lsl #3]
10529a8a4: aa1803e1    	mov	x1, x24
10529a8a8: aa1403e2    	mov	x2, x20
10529a8ac: 94a634ee    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a8b0: aa1d03fd    	mov	x29, x29
10529a8b4: 94a634f3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529a8b8: aa0003fc    	mov	x28, x0
10529a8bc: b40001c0    	cbz	x0, 0x10529a8f4 <_Flutter_MMFoundation_BindContext+0x15215c0>
10529a8c0: b00cd3c8    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
10529a8c4: f944dd00    	ldr	x0, [x8, #0x9b8]
10529a8c8: aa1903e1    	mov	x1, x25
10529a8cc: 94a634e6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a8d0: aa0003e2    	mov	x2, x0
10529a8d4: aa1c03e0    	mov	x0, x28
10529a8d8: aa1a03e1    	mov	x1, x26
10529a8dc: 94a634e2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a8e0: 340000a0    	cbz	w0, 0x10529a8f4 <_Flutter_MMFoundation_BindContext+0x15215c0>
10529a8e4: f94027e0    	ldr	x0, [sp, #0x48]
10529a8e8: aa1b03e1    	mov	x1, x27
10529a8ec: aa1c03e2    	mov	x2, x28
10529a8f0: 94a634dd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a8f4: aa1c03e0    	mov	x0, x28
10529a8f8: 94a634de    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529a8fc: 910006b5    	add	x21, x21, #0x1
10529a900: eb15027f    	cmp	x19, x21
10529a904: 54fffc01    	b.ne	0x10529a884 <_Flutter_MMFoundation_BindContext+0x1521550>
10529a908: 910243e2    	add	x2, sp, #0x90
10529a90c: d10383a3    	sub	x3, x29, #0xe0
10529a910: aa1603e0    	mov	x0, x22
10529a914: f94023e1    	ldr	x1, [sp, #0x40]
10529a918: 52800204    	mov	w4, #0x10               ; =16
10529a91c: 94a634d2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a920: aa0003f3    	mov	x19, x0
10529a924: b5fff9e0    	cbnz	x0, 0x10529a860 <_Flutter_MMFoundation_BindContext+0x152152c>
10529a928: d00cc4c8    	adrp	x8, 0x11eb34000 <dyld_stub_binder+0x11eb34000>
10529a92c: f9437901    	ldr	x1, [x8, #0x6f0] ; selector: forwardData:
10529a930: f9401fe0    	ldr	x0, [sp, #0x38]
10529a934: f94027f3    	ldr	x19, [sp, #0x48]
10529a938: aa1303e2    	mov	x2, x19
10529a93c: 94a634ca    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a940: 140000bf    	b	0x10529ac3c <_Flutter_MMFoundation_BindContext+0x1521908>
10529a944: aa1903e0    	mov	x0, x25
10529a948: aa1403e1    	mov	x1, x20
10529a94c: 94a634c6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a950: 52880148    	mov	w8, #0x400a             ; =16394
10529a954: eb08001f    	cmp	x0, x8
10529a958: 540019c1    	b.ne	0x10529ac90 <_Flutter_MMFoundation_BindContext+0x152195c>
10529a95c: f90007f7    	str	x23, [sp, #0x8]
10529a960: 900cd3d5    	adrp	x21, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10529a964: f9432ea0    	ldr	x0, [x21, #0x658]
10529a968: f00cd048    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
10529a96c: f946c513    	ldr	x19, [x8, #0xd88] ; selector: array
10529a970: aa1303e1    	mov	x1, x19
10529a974: 94a634bc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a978: aa1d03fd    	mov	x29, x29
10529a97c: 94a634c1    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529a980: f9001be0    	str	x0, [sp, #0x30]
10529a984: f00cbd48    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
10529a988: f9474501    	ldr	x1, [x8, #0xe88] ; selector: favBrowseCollectionView
10529a98c: aa1903e0    	mov	x0, x25
10529a990: 94a634b5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a994: aa1d03fd    	mov	x29, x29
10529a998: 94a634ba    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529a99c: aa0003f4    	mov	x20, x0
10529a9a0: d00cbd68    	adrp	x8, 0x11ea48000 <dyld_stub_binder+0x11ea48000>
10529a9a4: f9454d01    	ldr	x1, [x8, #0xa98] ; selector: getSelectedMessages
10529a9a8: 94a634af    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a9ac: aa1d03fd    	mov	x29, x29
10529a9b0: 94a634b4    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529a9b4: aa0003f6    	mov	x22, x0
10529a9b8: aa1403e0    	mov	x0, x20
10529a9bc: 94a634ad    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529a9c0: f9432ea0    	ldr	x0, [x21, #0x658]
10529a9c4: aa1303e1    	mov	x1, x19
10529a9c8: 94a634a7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529a9cc: aa1d03fd    	mov	x29, x29
10529a9d0: 94a634ac    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529a9d4: f90017e0    	str	x0, [sp, #0x28]
10529a9d8: 4f00e400    	movi.16b	v0, #0x0
10529a9dc: ad0283e0    	stp	q0, q0, [sp, #0x50]
10529a9e0: ad0383e0    	stp	q0, q0, [sp, #0x70]
10529a9e4: aa1603e0    	mov	x0, x22
10529a9e8: 94a634a3    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10529a9ec: 900cd068    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10529a9f0: f9442d01    	ldr	x1, [x8, #0x858] ; selector: countByEnumeratingWithState:objects:count:
10529a9f4: 910143e2    	add	x2, sp, #0x50
10529a9f8: 910343e3    	add	x3, sp, #0xd0
10529a9fc: a9015be1    	stp	x1, x22, [sp, #0x10]
10529aa00: 52800204    	mov	w4, #0x10               ; =16
10529aa04: 94a63498    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529aa08: f90027e0    	str	x0, [sp, #0x48]
10529aa0c: b4000b60    	cbz	x0, 0x10529ab78 <_Flutter_MMFoundation_BindContext+0x1521844>
10529aa10: f94033e8    	ldr	x8, [sp, #0x60]
10529aa14: f9400108    	ldr	x8, [x8]
10529aa18: f90013e8    	str	x8, [sp, #0x20]
10529aa1c: d280001a    	mov	x26, #0x0               ; =0
10529aa20: 900cbd68    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
10529aa24: f940c108    	ldr	x8, [x8, #0x180] ; selector: m_favItem
10529aa28: f90023e8    	str	x8, [sp, #0x40]
10529aa2c: 900cbd68    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
10529aa30: f941c11b    	ldr	x27, [x8, #0x380] ; selector: m_favData
10529aa34: 900cbd68    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
10529aa38: f945191c    	ldr	x28, [x8, #0xa30] ; selector: initWithParent:DataItem:Index:
10529aa3c: 900cb988    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
10529aa40: f942c113    	ldr	x19, [x8, #0x580] ; selector: safeAddObject:
10529aa44: d00cbd68    	adrp	x8, 0x11ea48000 <dyld_stub_binder+0x11ea48000>
10529aa48: f9457518    	ldr	x24, [x8, #0xae8] ; selector: getIndexOfImage:
10529aa4c: f00cd068    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
10529aa50: f942d514    	ldr	x20, [x8, #0x5a8] ; selector: numberWithInt:
10529aa54: f94033e8    	ldr	x8, [sp, #0x60]
10529aa58: f9400108    	ldr	x8, [x8]
10529aa5c: f94013e9    	ldr	x9, [sp, #0x20]
10529aa60: eb09011f    	cmp	x8, x9
10529aa64: 54000060    	b.eq	0x10529aa70 <_Flutter_MMFoundation_BindContext+0x152173c>
10529aa68: f9400fe0    	ldr	x0, [sp, #0x18]
10529aa6c: 94a63474    	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
10529aa70: f9402fe8    	ldr	x8, [sp, #0x58]
10529aa74: f87a7916    	ldr	x22, [x8, x26, lsl #3]
10529aa78: b00cd428    	adrp	x8, 0x11ed1f000 <dyld_stub_binder+0x11ed1f000>
10529aa7c: f9407900    	ldr	x0, [x8, #0xf0]
10529aa80: 94a63462    	bl	0x107c27c08 <_Flutter_MMFoundation_BindContext+0x3eae8d4>
10529aa84: aa0003f5    	mov	x21, x0
10529aa88: aa1603e0    	mov	x0, x22
10529aa8c: f94023e1    	ldr	x1, [sp, #0x40]
10529aa90: 94a63475    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529aa94: aa1d03fd    	mov	x29, x29
10529aa98: 94a6347a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529aa9c: aa0003f7    	mov	x23, x0
10529aaa0: aa1603e0    	mov	x0, x22
10529aaa4: aa1b03e1    	mov	x1, x27
10529aaa8: 94a6346f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529aaac: aa1d03fd    	mov	x29, x29
10529aab0: 94a63474    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529aab4: aa0003f9    	mov	x25, x0
10529aab8: aa1503e0    	mov	x0, x21
10529aabc: aa1c03e1    	mov	x1, x28
10529aac0: aa1703e2    	mov	x2, x23
10529aac4: aa1903e3    	mov	x3, x25
10529aac8: 52800004    	mov	w4, #0x0                ; =0
10529aacc: 94a63466    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529aad0: aa0003f5    	mov	x21, x0
10529aad4: f9401be0    	ldr	x0, [sp, #0x30]
10529aad8: aa1303e1    	mov	x1, x19
10529aadc: aa1503e2    	mov	x2, x21
10529aae0: 94a63461    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529aae4: aa1503e0    	mov	x0, x21
10529aae8: 94a63462    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529aaec: aa1903e0    	mov	x0, x25
10529aaf0: 94a63460    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529aaf4: aa1703e0    	mov	x0, x23
10529aaf8: 94a6345e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529aafc: 900cd3c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10529ab00: f9436115    	ldr	x21, [x8, #0x6c0]
10529ab04: f9401ff9    	ldr	x25, [sp, #0x38]
10529ab08: aa1903e0    	mov	x0, x25
10529ab0c: aa1803e1    	mov	x1, x24
10529ab10: aa1603e2    	mov	x2, x22
10529ab14: 94a63454    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529ab18: 11000402    	add	w2, w0, #0x1
10529ab1c: aa1503e0    	mov	x0, x21
10529ab20: aa1403e1    	mov	x1, x20
10529ab24: 94a63450    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529ab28: aa1d03fd    	mov	x29, x29
10529ab2c: 94a63455    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529ab30: aa0003f5    	mov	x21, x0
10529ab34: f94017e0    	ldr	x0, [sp, #0x28]
10529ab38: aa1303e1    	mov	x1, x19
10529ab3c: aa1503e2    	mov	x2, x21
10529ab40: 94a63449    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529ab44: aa1503e0    	mov	x0, x21
10529ab48: 94a6344a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529ab4c: 9100075a    	add	x26, x26, #0x1
10529ab50: f94027e8    	ldr	x8, [sp, #0x48]
10529ab54: eb1a011f    	cmp	x8, x26
10529ab58: 54fff7e1    	b.ne	0x10529aa54 <_Flutter_MMFoundation_BindContext+0x1521720>
10529ab5c: 910143e2    	add	x2, sp, #0x50
10529ab60: 910343e3    	add	x3, sp, #0xd0
10529ab64: a94103e1    	ldp	x1, x0, [sp, #0x10]
10529ab68: 52800204    	mov	w4, #0x10               ; =16
10529ab6c: 94a6343e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529ab70: f90027e0    	str	x0, [sp, #0x48]
10529ab74: b5fff540    	cbnz	x0, 0x10529aa1c <_Flutter_MMFoundation_BindContext+0x15216e8>
10529ab78: f9400ff6    	ldr	x22, [sp, #0x18]
10529ab7c: aa1603e0    	mov	x0, x22
10529ab80: 94a6343c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529ab84: 900cd3c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10529ab88: f943c100    	ldr	x0, [x8, #0x780]
10529ab8c: f00cb968    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10529ab90: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
10529ab94: 94a63434    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529ab98: aa1d03fd    	mov	x29, x29
10529ab9c: 94a63439    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529aba0: aa0003f3    	mov	x19, x0
10529aba4: b00cd3c8    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
10529aba8: f9448500    	ldr	x0, [x8, #0x908]
10529abac: 900cd068    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10529abb0: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
10529abb4: 94a6342c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529abb8: aa0003e2    	mov	x2, x0
10529abbc: f00cb968    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10529abc0: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
10529abc4: aa1303e0    	mov	x0, x19
10529abc8: 94a63427    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529abcc: aa1d03fd    	mov	x29, x29
10529abd0: 94a6342c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529abd4: aa0003f4    	mov	x20, x0
10529abd8: 900cb9e8    	adrp	x8, 0x11e9d6000 <dyld_stub_binder+0x11e9d6000>
10529abdc: f9426901    	ldr	x1, [x8, #0x4d0] ; selector: reportLogic
10529abe0: 94a63421    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529abe4: aa1d03fd    	mov	x29, x29
10529abe8: 94a63426    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529abec: aa0003f5    	mov	x21, x0
10529abf0: 900cbd68    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
10529abf4: f941dd01    	ldr	x1, [x8, #0x3b8] ; selector: setSelectedlocalPosition:
10529abf8: f94017f7    	ldr	x23, [sp, #0x28]
10529abfc: aa1703e2    	mov	x2, x23
10529ac00: 94a63419    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529ac04: aa1503e0    	mov	x0, x21
10529ac08: 94a6341a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529ac0c: aa1403e0    	mov	x0, x20
10529ac10: 94a63418    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529ac14: aa1303e0    	mov	x0, x19
10529ac18: 94a63416    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529ac1c: d00cc4c8    	adrp	x8, 0x11eb34000 <dyld_stub_binder+0x11eb34000>
10529ac20: f9437901    	ldr	x1, [x8, #0x6f0] ; selector: forwardData:
10529ac24: aa1903e0    	mov	x0, x25
10529ac28: f9401bf3    	ldr	x19, [sp, #0x30]
10529ac2c: aa1303e2    	mov	x2, x19
10529ac30: 94a6340d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529ac34: aa1703e0    	mov	x0, x23
10529ac38: 94a6340e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529ac3c: aa1603e0    	mov	x0, x22
10529ac40: 94a6340c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529ac44: aa1303e0    	mov	x0, x19
10529ac48: 94a6340a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529ac4c: f94007f7    	ldr	x23, [sp, #0x8]
10529ac50: aa1703e0    	mov	x0, x23
10529ac54: 94a63407    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529ac58: f85a03a8    	ldur	x8, [x29, #-0x60]
10529ac5c: d00c2589    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10529ac60: f9451929    	ldr	x9, [x9, #0xa30]
10529ac64: f9400129    	ldr	x9, [x9]
10529ac68: eb08013f    	cmp	x9, x8
10529ac6c: 54000521    	b.ne	0x10529ad10 <_Flutter_MMFoundation_BindContext+0x15219dc>
10529ac70: 910783ff    	add	sp, sp, #0x1e0
10529ac74: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10529ac78: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10529ac7c: a94357f6    	ldp	x22, x21, [sp, #0x30]
10529ac80: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10529ac84: a94167fa    	ldp	x26, x25, [sp, #0x10]
10529ac88: a8c66ffc    	ldp	x28, x27, [sp], #0x60
10529ac8c: d65f03c0    	ret
10529ac90: 52856ea0    	mov	w0, #0x2b75             ; =11125
10529ac94: aa1703e1    	mov	x1, x23
10529ac98: 52800002    	mov	w2, #0x0                ; =0
10529ac9c: 52800003    	mov	w3, #0x0                ; =0
10529aca0: 9745fd0b    	bl	0x10241a0cc <_Flutter_Image_provideRelativePathByUrl+0x6a2558>
10529aca4: f8766b20    	ldr	x0, [x25, x22]
10529aca8: aa1303e1    	mov	x1, x19
10529acac: 94a633ee    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529acb0: aa1d03fd    	mov	x29, x29
10529acb4: 94a633f3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529acb8: aa0003f3    	mov	x19, x0
10529acbc: f00cd048    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
10529acc0: f945ed01    	ldr	x1, [x8, #0xbd8] ; selector: allValues
10529acc4: 94a633e8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529acc8: aa1d03fd    	mov	x29, x29
10529accc: 94a633ed    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529acd0: aa0003f4    	mov	x20, x0
10529acd4: f00cd068    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
10529acd8: f9418d01    	ldr	x1, [x8, #0x318] ; selector: mutableCopy
10529acdc: 94a633e2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529ace0: aa0003f5    	mov	x21, x0
10529ace4: aa1403e0    	mov	x0, x20
10529ace8: 94a633e2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529acec: aa1303e0    	mov	x0, x19
10529acf0: 94a633e0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529acf4: d00cc4c8    	adrp	x8, 0x11eb34000 <dyld_stub_binder+0x11eb34000>
10529acf8: f9437901    	ldr	x1, [x8, #0x6f0] ; selector: forwardData:
10529acfc: aa1903e0    	mov	x0, x25
10529ad00: aa1503e2    	mov	x2, x21
10529ad04: 94a633d8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529ad08: aa1503e0    	mov	x0, x21
10529ad0c: 17fffea8    	b	0x10529a7ac <_Flutter_MMFoundation_BindContext+0x1521478>
10529ad10: 94a63288    	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
