
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10901a628: d10283ff    	sub	sp, sp, #0xa0
10901a62c: a9046ffc    	stp	x28, x27, [sp, #0x40]
10901a630: a90567fa    	stp	x26, x25, [sp, #0x50]
10901a634: a9065ff8    	stp	x24, x23, [sp, #0x60]
10901a638: a90757f6    	stp	x22, x21, [sp, #0x70]
10901a63c: a9084ff4    	stp	x20, x19, [sp, #0x80]
10901a640: a9097bfd    	stp	x29, x30, [sp, #0x90]
10901a644: 910243fd    	add	x29, sp, #0x90
10901a648: b90017e2    	str	w2, [sp, #0x14]
10901a64c: aa0003f3    	mov	x19, x0
10901a650: f00be188    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
10901a654: 52800029    	mov	w9, #0x1                ; =1
10901a658: 393bed09    	strb	w9, [x8, #0xefb]
10901a65c: d00b9248    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
10901a660: b9864518    	ldrsw	x24, [x8, #0x644]
10901a664: f8786800    	ldr	x0, [x0, x24]
10901a668: 900b8768    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10901a66c: f9408101    	ldr	x1, [x8, #0x100] ; removeAllObjects
10901a670: f90007e1    	str	x1, [sp, #0x8]
10901a674: 95a10374    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a678: f8786a74    	ldr	x20, [x19, x24]
10901a67c: b00b8ac8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10901a680: f945e900    	ldr	x0, [x8, #0xbd0]
10901a684: d00b8728    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10901a688: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10901a68c: f9001fe1    	str	x1, [sp, #0x38]
10901a690: 95a1036d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a694: aa1d03fd    	mov	x29, x29
10901a698: 95a1036e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a69c: aa0003fc    	mov	x28, x0
10901a6a0: d00b8ac8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10901a6a4: f9428500    	ldr	x0, [x8, #0x508]
10901a6a8: b00b8728    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10901a6ac: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10901a6b0: f9001be1    	str	x1, [sp, #0x30]
10901a6b4: 95a10364    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a6b8: aa0003e2    	mov	x2, x0
10901a6bc: f00b70e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10901a6c0: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10901a6c4: aa1c03e0    	mov	x0, x28
10901a6c8: f90017e1    	str	x1, [sp, #0x28]
10901a6cc: 95a1035e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a6d0: aa1d03fd    	mov	x29, x29
10901a6d4: 95a1035f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a6d8: aa0003f5    	mov	x21, x0
10901a6dc: d00b9248    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
10901a6e0: b9863d08    	ldrsw	x8, [x8, #0x63c]
10901a6e4: f90013e8    	str	x8, [sp, #0x20]
10901a6e8: f8686a60    	ldr	x0, [x19, x8]
10901a6ec: b00b7108    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10901a6f0: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
10901a6f4: f9000fe1    	str	x1, [sp, #0x18]
10901a6f8: 95a10353    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a6fc: aa1d03fd    	mov	x29, x29
10901a700: 95a10354    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a704: aa0003f6    	mov	x22, x0
10901a708: 900b7ec8    	adrp	x8, 0x11fff2000 <dyld_stub_binder+0x11fff2000>
10901a70c: f9440919    	ldr	x25, [x8, #0x810] ; homepageType
10901a710: aa1303e0    	mov	x0, x19
10901a714: aa1903e1    	mov	x1, x25
10901a718: 95a1034b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a71c: aa0003e3    	mov	x3, x0
10901a720: 900b7f68    	adrp	x8, 0x120006000 <dyld_stub_binder+0x120006000>
10901a724: f940111a    	ldr	x26, [x8, #0x20] ; getHomepageData:type:
10901a728: aa1503e0    	mov	x0, x21
10901a72c: aa1a03e1    	mov	x1, x26
10901a730: aa1603e2    	mov	x2, x22
10901a734: 95a10344    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a738: aa1d03fd    	mov	x29, x29
10901a73c: 95a10345    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a740: aa0003f7    	mov	x23, x0
10901a744: 900b8728    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10901a748: f946f91b    	ldr	x27, [x8, #0xdf0] ; addObjectsFromArray:
10901a74c: aa1403e0    	mov	x0, x20
10901a750: aa1b03e1    	mov	x1, x27
10901a754: aa1703e2    	mov	x2, x23
10901a758: 95a1033b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a75c: aa1703e0    	mov	x0, x23
10901a760: 95a1033f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a764: aa1603e0    	mov	x0, x22
10901a768: 95a1033d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a76c: aa1503e0    	mov	x0, x21
10901a770: 95a1033b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a774: aa1c03e0    	mov	x0, x28
10901a778: 95a10339    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a77c: aa1303e0    	mov	x0, x19
10901a780: aa1903e1    	mov	x1, x25
10901a784: 95a10330    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a788: d00b9248    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
10901a78c: b986491c    	ldrsw	x28, [x8, #0x648]
10901a790: b5000620    	cbnz	x0, 0x10901a854 <_Flutter_MMFoundation_BindContext+0x54f6438>
10901a794: f87c6a60    	ldr	x0, [x19, x28]
10901a798: f94007e1    	ldr	x1, [sp, #0x8]
10901a79c: 95a1032a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a7a0: f87c6a74    	ldr	x20, [x19, x28]
10901a7a4: b00b8ac8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10901a7a8: f945e900    	ldr	x0, [x8, #0xbd0]
10901a7ac: f9401fe1    	ldr	x1, [sp, #0x38]
10901a7b0: 95a10325    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a7b4: aa1d03fd    	mov	x29, x29
10901a7b8: 95a10326    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a7bc: aa0003f5    	mov	x21, x0
10901a7c0: d00b8ac8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10901a7c4: f9428500    	ldr	x0, [x8, #0x508]
10901a7c8: f9401be1    	ldr	x1, [sp, #0x30]
10901a7cc: 95a1031e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a7d0: aa0003e2    	mov	x2, x0
10901a7d4: aa1503e0    	mov	x0, x21
10901a7d8: f94017e1    	ldr	x1, [sp, #0x28]
10901a7dc: 95a1031a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a7e0: aa1d03fd    	mov	x29, x29
10901a7e4: 95a1031b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a7e8: aa0003f6    	mov	x22, x0
10901a7ec: a941a3e1    	ldp	x1, x8, [sp, #0x18]
10901a7f0: f8686a60    	ldr	x0, [x19, x8]
10901a7f4: 95a10314    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a7f8: aa1d03fd    	mov	x29, x29
10901a7fc: 95a10315    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a800: aa0003f7    	mov	x23, x0
10901a804: aa1603e0    	mov	x0, x22
10901a808: aa1a03e1    	mov	x1, x26
10901a80c: aa1703e2    	mov	x2, x23
10901a810: 52800023    	mov	w3, #0x1                ; =1
10901a814: 95a1030c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a818: aa1d03fd    	mov	x29, x29
10901a81c: 95a1030d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a820: aa0003f9    	mov	x25, x0
10901a824: aa1403e0    	mov	x0, x20
10901a828: aa1b03e1    	mov	x1, x27
10901a82c: aa1903e2    	mov	x2, x25
10901a830: 95a10305    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a834: aa1903e0    	mov	x0, x25
10901a838: 95a10309    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a83c: aa1703e0    	mov	x0, x23
10901a840: 95a10307    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a844: aa1603e0    	mov	x0, x22
10901a848: 95a10305    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a84c: aa1503e0    	mov	x0, x21
10901a850: 95a10303    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a854: d00b9248    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
10901a858: b9864108    	ldrsw	x8, [x8, #0x640]
10901a85c: f8686a74    	ldr	x20, [x19, x8]
10901a860: f8786a75    	ldr	x21, [x19, x24]
10901a864: f87c6a76    	ldr	x22, [x19, x28]
10901a868: b00b8ac8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10901a86c: f945e900    	ldr	x0, [x8, #0xbd0]
10901a870: f9401fe1    	ldr	x1, [sp, #0x38]
10901a874: 95a102f4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a878: aa1d03fd    	mov	x29, x29
10901a87c: 95a102f5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a880: aa0003f7    	mov	x23, x0
10901a884: d00b8ac8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10901a888: f9428500    	ldr	x0, [x8, #0x508]
10901a88c: f9401be1    	ldr	x1, [sp, #0x30]
10901a890: 95a102ed    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a894: aa0003e2    	mov	x2, x0
10901a898: aa1703e0    	mov	x0, x23
10901a89c: f94017e1    	ldr	x1, [sp, #0x28]
10901a8a0: 95a102e9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a8a4: aa1d03fd    	mov	x29, x29
10901a8a8: 95a102ea    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a8ac: aa0003f9    	mov	x25, x0
10901a8b0: a941a3e1    	ldp	x1, x8, [sp, #0x18]
10901a8b4: f8686a60    	ldr	x0, [x19, x8]
10901a8b8: 95a102e3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a8bc: aa1d03fd    	mov	x29, x29
10901a8c0: 95a102e4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a8c4: aa0003f8    	mov	x24, x0
10901a8c8: 900b7ec8    	adrp	x8, 0x11fff2000 <dyld_stub_binder+0x11fff2000>
10901a8cc: f9458901    	ldr	x1, [x8, #0xb10] ; hompePageJumpState:
10901a8d0: aa1903e0    	mov	x0, x25
10901a8d4: aa1803e2    	mov	x2, x24
10901a8d8: 95a102db    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a8dc: aa0003e4    	mov	x4, x0
10901a8e0: b00b8268    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
10901a8e4: f9442d01    	ldr	x1, [x8, #0x858] ; shouldReloadData:starredDataItems:jumpState:prePage:
10901a8e8: aa1403e0    	mov	x0, x20
10901a8ec: aa1503e2    	mov	x2, x21
10901a8f0: aa1603e3    	mov	x3, x22
10901a8f4: b94017e5    	ldr	w5, [sp, #0x14]
10901a8f8: 95a102d3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a8fc: aa1803e0    	mov	x0, x24
10901a900: 95a102d7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a904: aa1903e0    	mov	x0, x25
10901a908: 95a102d5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a90c: aa1703e0    	mov	x0, x23
10901a910: 95a102d3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a914: b00b8268    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
10901a918: f9442501    	ldr	x1, [x8, #0x848] ; updateJumpState
10901a91c: aa1303e0    	mov	x0, x19
10901a920: a9497bfd    	ldp	x29, x30, [sp, #0x90]
10901a924: a9484ff4    	ldp	x20, x19, [sp, #0x80]
10901a928: a94757f6    	ldp	x22, x21, [sp, #0x70]
10901a92c: a9465ff8    	ldp	x24, x23, [sp, #0x60]
10901a930: a94567fa    	ldp	x26, x25, [sp, #0x50]
10901a934: a9446ffc    	ldp	x28, x27, [sp, #0x40]
10901a938: 910283ff    	add	sp, sp, #0xa0
10901a93c: 15a102c2    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
