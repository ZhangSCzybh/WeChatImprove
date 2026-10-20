
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1091fc8d0: d10603ff    	sub	sp, sp, #0x180
1091fc8d4: a9126ffc    	stp	x28, x27, [sp, #0x120]
1091fc8d8: a91367fa    	stp	x26, x25, [sp, #0x130]
1091fc8dc: a9145ff8    	stp	x24, x23, [sp, #0x140]
1091fc8e0: a91557f6    	stp	x22, x21, [sp, #0x150]
1091fc8e4: a9164ff4    	stp	x20, x19, [sp, #0x160]
1091fc8e8: a9177bfd    	stp	x29, x30, [sp, #0x170]
1091fc8ec: 9105c3fd    	add	x29, sp, #0x170
1091fc8f0: aa0003f4    	mov	x20, x0
1091fc8f4: f00a1f88    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1091fc8f8: f9405908    	ldr	x8, [x8, #0xb0]
1091fc8fc: f9400108    	ldr	x8, [x8]
1091fc900: f81a03a8    	stur	x8, [x29, #-0x60]
1091fc904: d00bd288    	adrp	x8, 0x120c4e000 <dyld_stub_binder+0x120c4e000>
1091fc908: 52800029    	mov	w9, #0x1                ; =1
1091fc90c: 39188509    	strb	w9, [x8, #0x621]
1091fc910: b00b7848    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
1091fc914: f9434501    	ldr	x1, [x8, #0x688] ; params
1091fc918: 95997acb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fc91c: aa1d03fd    	mov	x29, x29
1091fc920: 95997acc    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091fc924: aa0003f5    	mov	x21, x0
1091fc928: b00b6748    	adrp	x8, 0x11fee5000 <dyld_stub_binder+0x11fee5000>
1091fc92c: f9473901    	ldr	x1, [x8, #0xe70] ; selectedItem
1091fc930: 95997ac5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fc934: aa1d03fd    	mov	x29, x29
1091fc938: 95997ac6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091fc93c: aa0003f3    	mov	x19, x0
1091fc940: aa1503e0    	mov	x0, x21
1091fc944: 95997ac6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091fc948: b00b62c8    	adrp	x8, 0x11fe55000 <dyld_stub_binder+0x11fe55000>
1091fc94c: f943cd16    	ldr	x22, [x8, #0x798] ; itemType
1091fc950: aa1303e0    	mov	x0, x19
1091fc954: aa1603e1    	mov	x1, x22
1091fc958: 95997abb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fc95c: f00b7ba8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1091fc960: f9453515    	ldr	x21, [x8, #0xa68]
1091fc964: f100041f    	cmp	x0, #0x1
1091fc968: 54001d21    	b.ne	0x1091fcd0c <_Flutter_MMFoundation_BindContext+0x56d88f0>
1091fc96c: f90023f4    	str	x20, [sp, #0x40]
1091fc970: b00b61e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1091fc974: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1091fc978: f00abe68    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1091fc97c: 9118a108    	add	x8, x8, #0x628
1091fc980: f90003e8    	str	x8, [sp]
1091fc984: 90090103    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
1091fc988: 912b2863    	add	x3, x3, #0xaca
1091fc98c: f0095225    	adrp	x5, 0x11bc43000 <dyld_stub_binder+0x11bc43000>
1091fc990: 9123f4a5    	add	x5, x5, #0x8fd
1091fc994: f0095227    	adrp	x7, 0x11bc43000 <dyld_stub_binder+0x11bc43000>
1091fc998: 9129ace7    	add	x7, x7, #0xa6b
1091fc99c: aa1503e0    	mov	x0, x21
1091fc9a0: 52800042    	mov	w2, #0x2                ; =2
1091fc9a4: 52800004    	mov	w4, #0x0                ; =0
1091fc9a8: 52804006    	mov	w6, #0x200              ; =512
1091fc9ac: 95997aa6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fc9b0: f00b7bb8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
1091fc9b4: f9454300    	ldr	x0, [x24, #0xa80]
1091fc9b8: b00b7828    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
1091fc9bc: f9400516    	ldr	x22, [x8, #0x8] ; dictionary
1091fc9c0: aa1603e1    	mov	x1, x22
1091fc9c4: 95997aa0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fc9c8: aa1d03fd    	mov	x29, x29
1091fc9cc: 95997aa1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091fc9d0: aa0003f4    	mov	x20, x0
1091fc9d4: f00b7ba8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1091fc9d8: f945e900    	ldr	x0, [x8, #0xbd0]
1091fc9dc: 900b7828    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1091fc9e0: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1091fc9e4: f90017e1    	str	x1, [sp, #0x28]
1091fc9e8: 95997a97    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fc9ec: aa1d03fd    	mov	x29, x29
1091fc9f0: 95997a98    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091fc9f4: aa0003f5    	mov	x21, x0
1091fc9f8: 900b7bc8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1091fc9fc: f9401500    	ldr	x0, [x8, #0x28] ; P;,
1091fca00: f00b7808    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1091fca04: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1091fca08: f90013e1    	str	x1, [sp, #0x20]
1091fca0c: 95997a8e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fca10: aa0003e2    	mov	x2, x0
1091fca14: b00b61e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1091fca18: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
1091fca1c: aa1503e0    	mov	x0, x21
1091fca20: f9000fe1    	str	x1, [sp, #0x18]
1091fca24: 95997a88    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fca28: aa1d03fd    	mov	x29, x29
1091fca2c: 95997a89    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091fca30: aa0003f7    	mov	x23, x0
1091fca34: f00b61e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1091fca38: f9470d01    	ldr	x1, [x8, #0xe18] ; getSelfContact
1091fca3c: 95997a82    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fca40: aa1d03fd    	mov	x29, x29
1091fca44: 95997a83    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091fca48: aa0003f9    	mov	x25, x0
1091fca4c: aa1703e0    	mov	x0, x23
1091fca50: 95997a83    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091fca54: aa1503e0    	mov	x0, x21
1091fca58: 95997a81    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091fca5c: f00b61e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1091fca60: f9434d1c    	ldr	x28, [x8, #0x698] ; m_nsUsrName
1091fca64: aa1903e0    	mov	x0, x25
1091fca68: aa1c03e1    	mov	x1, x28
1091fca6c: 95997a76    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fca70: aa1d03fd    	mov	x29, x29
1091fca74: 95997a77    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091fca78: aa0003f7    	mov	x23, x0
1091fca7c: b00b61e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1091fca80: f942c915    	ldr	x21, [x8, #0x590] ; safeSetObject:forKey:
1091fca84: a90353f9    	stp	x25, x20, [sp, #0x30]
1091fca88: aa1403e0    	mov	x0, x20
1091fca8c: aa1503e1    	mov	x1, x21
1091fca90: aa1903e2    	mov	x2, x25
1091fca94: aa1703e3    	mov	x3, x23
1091fca98: 95997a6b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fca9c: aa1703e0    	mov	x0, x23
1091fcaa0: 95997a6f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091fcaa4: f9454300    	ldr	x0, [x24, #0xa80]
1091fcaa8: aa1603e1    	mov	x1, x22
1091fcaac: 95997a66    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcab0: aa1d03fd    	mov	x29, x29
1091fcab4: 95997a67    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091fcab8: aa0003f7    	mov	x23, x0
1091fcabc: b00b6368    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
1091fcac0: f9418101    	ldr	x1, [x8, #0x300] ; selectedContacts
1091fcac4: f90027f3    	str	x19, [sp, #0x48]
1091fcac8: aa1303e0    	mov	x0, x19
1091fcacc: 95997a5e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcad0: aa1d03fd    	mov	x29, x29
1091fcad4: 95997a5f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091fcad8: aa0003f8    	mov	x24, x0
1091fcadc: 4f00e400    	movi.16b	v0, #0x0
1091fcae0: ad0283e0    	stp	q0, q0, [sp, #0x50]
1091fcae4: ad0383e0    	stp	q0, q0, [sp, #0x70]
1091fcae8: 900b7828    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1091fcaec: f9435516    	ldr	x22, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1091fcaf0: 910143e2    	add	x2, sp, #0x50
1091fcaf4: 910243e3    	add	x3, sp, #0x90
1091fcaf8: aa1603e1    	mov	x1, x22
1091fcafc: 52800204    	mov	w4, #0x10               ; =16
1091fcb00: 95997a51    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcb04: b40004a0    	cbz	x0, 0x1091fcb98 <_Flutter_MMFoundation_BindContext+0x56d877c>
1091fcb08: aa0003f9    	mov	x25, x0
1091fcb0c: f94033e8    	ldr	x8, [sp, #0x60]
1091fcb10: f9400113    	ldr	x19, [x8]
1091fcb14: d2800014    	mov	x20, #0x0               ; =0
1091fcb18: f94033e8    	ldr	x8, [sp, #0x60]
1091fcb1c: f9400108    	ldr	x8, [x8]
1091fcb20: eb13011f    	cmp	x8, x19
1091fcb24: 54000060    	b.eq	0x1091fcb30 <_Flutter_MMFoundation_BindContext+0x56d8714>
1091fcb28: aa1803e0    	mov	x0, x24
1091fcb2c: 95997a4b    	bl	0x10f85b458 <_UR_96F1_B25D+0x3a640c8>
1091fcb30: f9402fe8    	ldr	x8, [sp, #0x58]
1091fcb34: f874791a    	ldr	x26, [x8, x20, lsl #3]
1091fcb38: aa1a03e0    	mov	x0, x26
1091fcb3c: aa1c03e1    	mov	x1, x28
1091fcb40: 95997a41    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcb44: aa1d03fd    	mov	x29, x29
1091fcb48: 95997a42    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091fcb4c: aa0003fb    	mov	x27, x0
1091fcb50: aa1703e0    	mov	x0, x23
1091fcb54: aa1503e1    	mov	x1, x21
1091fcb58: aa1a03e2    	mov	x2, x26
1091fcb5c: aa1b03e3    	mov	x3, x27
1091fcb60: 95997a39    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcb64: aa1b03e0    	mov	x0, x27
1091fcb68: 95997a3d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091fcb6c: 91000694    	add	x20, x20, #0x1
1091fcb70: eb14033f    	cmp	x25, x20
1091fcb74: 54fffd21    	b.ne	0x1091fcb18 <_Flutter_MMFoundation_BindContext+0x56d86fc>
1091fcb78: 910143e2    	add	x2, sp, #0x50
1091fcb7c: 910243e3    	add	x3, sp, #0x90
1091fcb80: aa1803e0    	mov	x0, x24
1091fcb84: aa1603e1    	mov	x1, x22
1091fcb88: 52800204    	mov	w4, #0x10               ; =16
1091fcb8c: 95997a2e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcb90: aa0003f9    	mov	x25, x0
1091fcb94: b5fffc00    	cbnz	x0, 0x1091fcb14 <_Flutter_MMFoundation_BindContext+0x56d86f8>
1091fcb98: d00b7bc8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
1091fcb9c: f9463500    	ldr	x0, [x8, #0xc68]
1091fcba0: 95997a30    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
1091fcba4: aa0003fc    	mov	x28, x0
1091fcba8: b00b61e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1091fcbac: f946d101    	ldr	x1, [x8, #0xda0] ; setM_delegate:
1091fcbb0: f94023f4    	ldr	x20, [sp, #0x40]
1091fcbb4: aa1403e2    	mov	x2, x20
1091fcbb8: 95997a23    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcbbc: b00b6968    	adrp	x8, 0x11ff29000 <dyld_stub_binder+0x11ff29000>
1091fcbc0: f9444901    	ldr	x1, [x8, #0x890] ; setM_dicMultiSelect:
1091fcbc4: aa1c03e0    	mov	x0, x28
1091fcbc8: aa1703e2    	mov	x2, x23
1091fcbcc: 95997a1e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcbd0: f00b61e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1091fcbd4: f9471101    	ldr	x1, [x8, #0xe20] ; setM_dicIgnoreContact:
1091fcbd8: aa1c03e0    	mov	x0, x28
1091fcbdc: f9401ffa    	ldr	x26, [sp, #0x38]
1091fcbe0: aa1a03e2    	mov	x2, x26
1091fcbe4: 95997a18    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcbe8: f00b61e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1091fcbec: f946f501    	ldr	x1, [x8, #0xde8] ; setM_bShowHistoryGroup:
1091fcbf0: aa1c03e0    	mov	x0, x28
1091fcbf4: 52800022    	mov	w2, #0x1                ; =1
1091fcbf8: 95997a13    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcbfc: b00b6468    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
1091fcc00: f9433d01    	ldr	x1, [x8, #0x678] ; setM_bShowContactTag:
1091fcc04: aa1c03e0    	mov	x0, x28
1091fcc08: 52800022    	mov	w2, #0x1                ; =1
1091fcc0c: 95997a0e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcc10: f00b6428    	adrp	x8, 0x11fe83000 <dyld_stub_binder+0x11fe83000>
1091fcc14: f9435101    	ldr	x1, [x8, #0x6a0] ; setM_uiGroupScene:
1091fcc18: aa1c03e0    	mov	x0, x28
1091fcc1c: 52800502    	mov	w2, #0x28               ; =40
1091fcc20: 95997a09    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcc24: f00b61e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1091fcc28: f945d101    	ldr	x1, [x8, #0xba0] ; setM_scene:
1091fcc2c: aa1c03e0    	mov	x0, x28
1091fcc30: 52800042    	mov	w2, #0x2                ; =2
1091fcc34: 95997a04    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcc38: f00b61e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1091fcc3c: f9470101    	ldr	x1, [x8, #0xe00] ; setM_commonSearchScene:
1091fcc40: aa1c03e0    	mov	x0, x28
1091fcc44: 52800322    	mov	w2, #0x19               ; =25
1091fcc48: 959979ff    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcc4c: f00b7ba8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1091fcc50: f945e900    	ldr	x0, [x8, #0xbd0]
1091fcc54: f94017e1    	ldr	x1, [sp, #0x28]
1091fcc58: 959979fb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcc5c: aa1d03fd    	mov	x29, x29
1091fcc60: 959979fc    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091fcc64: aa0003f5    	mov	x21, x0
1091fcc68: f00b7ba8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1091fcc6c: f9462900    	ldr	x0, [x8, #0xc50]
1091fcc70: f94013e1    	ldr	x1, [sp, #0x20]
1091fcc74: 959979f4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcc78: aa0003e2    	mov	x2, x0
1091fcc7c: aa1503e0    	mov	x0, x21
1091fcc80: f9400fe1    	ldr	x1, [sp, #0x18]
1091fcc84: 959979f0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcc88: aa1d03fd    	mov	x29, x29
1091fcc8c: 959979f1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091fcc90: aa0003f6    	mov	x22, x0
1091fcc94: b00b61e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1091fcc98: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
1091fcc9c: f00a9a42    	adrp	x2, 0x11e547000 <dyld_stub_binder+0x11e547000>
1091fcca0: 911fa042    	add	x2, x2, #0x7e8
1091fcca4: 959979e8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcca8: aa1d03fd    	mov	x29, x29
1091fccac: 959979e9    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091fccb0: aa0003f9    	mov	x25, x0
1091fccb4: b00b6468    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
1091fccb8: f9434501    	ldr	x1, [x8, #0x688] ; setM_rightBarButtonTitle:
1091fccbc: aa1c03e0    	mov	x0, x28
1091fccc0: aa1903e2    	mov	x2, x25
1091fccc4: 959979e0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fccc8: aa1903e0    	mov	x0, x25
1091fcccc: 959979e4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091fccd0: aa1603e0    	mov	x0, x22
1091fccd4: 959979e2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091fccd8: aa1503e0    	mov	x0, x21
1091fccdc: 959979e0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091fcce0: b00b6de8    	adrp	x8, 0x11ffb9000 <dyld_stub_binder+0x11ffb9000>
1091fcce4: f946d915    	ldr	x21, [x8, #0xdb0] ; currentPrivacy
1091fcce8: aa1403e0    	mov	x0, x20
1091fccec: aa1503e1    	mov	x1, x21
1091fccf0: 959979d5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fccf4: f100101f    	cmp	x0, #0x4
1091fccf8: 54000321    	b.ne	0x1091fcd5c <_Flutter_MMFoundation_BindContext+0x56d8940>
1091fccfc: 528001a2    	mov	w2, #0xd                ; =13
1091fcd00: f94027f3    	ldr	x19, [sp, #0x48]
1091fcd04: f9401bf6    	ldr	x22, [sp, #0x30]
1091fcd08: 1400001d    	b	0x1091fcd7c <_Flutter_MMFoundation_BindContext+0x56d8960>
1091fcd0c: aa1303e0    	mov	x0, x19
1091fcd10: aa1603e1    	mov	x1, x22
1091fcd14: 959979cc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcd18: b00b61e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1091fcd1c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1091fcd20: f00abe68    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1091fcd24: 91172108    	add	x8, x8, #0x5c8
1091fcd28: a90003e8    	stp	x8, x0, [sp]
1091fcd2c: 90090103    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
1091fcd30: 912b2863    	add	x3, x3, #0xaca
1091fcd34: f0095225    	adrp	x5, 0x11bc43000 <dyld_stub_binder+0x11bc43000>
1091fcd38: 9123f4a5    	add	x5, x5, #0x8fd
1091fcd3c: f0095227    	adrp	x7, 0x11bc43000 <dyld_stub_binder+0x11bc43000>
1091fcd40: 9129ace7    	add	x7, x7, #0xa6b
1091fcd44: aa1503e0    	mov	x0, x21
1091fcd48: 52800082    	mov	w2, #0x4                ; =4
1091fcd4c: 52800004    	mov	w4, #0x0                ; =0
1091fcd50: 52803fa6    	mov	w6, #0x1fd              ; =509
1091fcd54: 959979bc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcd58: 14000034    	b	0x1091fce28 <_Flutter_MMFoundation_BindContext+0x56d8a0c>
1091fcd5c: aa1403e0    	mov	x0, x20
1091fcd60: aa1503e1    	mov	x1, x21
1091fcd64: 959979b8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcd68: f100141f    	cmp	x0, #0x5
1091fcd6c: f94027f3    	ldr	x19, [sp, #0x48]
1091fcd70: f9401bf6    	ldr	x22, [sp, #0x30]
1091fcd74: 540000c1    	b.ne	0x1091fcd8c <_Flutter_MMFoundation_BindContext+0x56d8970>
1091fcd78: 528001c2    	mov	w2, #0xe                ; =14
1091fcd7c: d00b62c8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
1091fcd80: f9429101    	ldr	x1, [x8, #0x520] ; setReportBizType:
1091fcd84: aa1c03e0    	mov	x0, x28
1091fcd88: 959979af    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcd8c: f00b7ba8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1091fcd90: f947d500    	ldr	x0, [x8, #0xfa8] ; (#c
1091fcd94: 959979b5    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
1091fcd98: f00b7828    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1091fcd9c: f940d901    	ldr	x1, [x8, #0x1b0] ; initWithRootViewController:
1091fcda0: aa1c03e2    	mov	x2, x28
1091fcda4: 959979a8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcda8: aa0003f5    	mov	x21, x0
1091fcdac: f00b61e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1091fcdb0: f945d901    	ldr	x1, [x8, #0xbb0] ; PresentModalViewController:animated:
1091fcdb4: aa1403e0    	mov	x0, x20
1091fcdb8: aa1503e2    	mov	x2, x21
1091fcdbc: 52800023    	mov	w3, #0x1                ; =1
1091fcdc0: 959979a1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcdc4: f00b7ca8    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
1091fcdc8: f945e500    	ldr	x0, [x8, #0xbc8]
1091fcdcc: d00b7868    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1091fcdd0: f9437d01    	ldr	x1, [x8, #0x6f8] ; sharedInstance
1091fcdd4: 9599799c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcdd8: aa1d03fd    	mov	x29, x29
1091fcddc: 9599799d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091fcde0: aa0003f4    	mov	x20, x0
1091fcde4: 900b7348    	adrp	x8, 0x120064000 <dyld_stub_binder+0x120064000>
1091fcde8: f9442901    	ldr	x1, [x8, #0x850] ; importFromContactClickCount
1091fcdec: 95997996    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091fcdf0: aa1403e0    	mov	x0, x20
1091fcdf4: 9599799a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091fcdf8: aa1503e0    	mov	x0, x21
1091fcdfc: 95997998    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091fce00: aa1c03e0    	mov	x0, x28
1091fce04: 95997996    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091fce08: aa1803e0    	mov	x0, x24
1091fce0c: 95997994    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091fce10: aa1703e0    	mov	x0, x23
1091fce14: 95997992    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091fce18: aa1603e0    	mov	x0, x22
1091fce1c: 95997990    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091fce20: aa1a03e0    	mov	x0, x26
1091fce24: 9599798e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091fce28: aa1303e0    	mov	x0, x19
1091fce2c: 9599798c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091fce30: f85a03a8    	ldur	x8, [x29, #-0x60]
1091fce34: f00a1f89    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1091fce38: f9405929    	ldr	x9, [x9, #0xb0]
1091fce3c: f9400129    	ldr	x9, [x9]
1091fce40: eb08013f    	cmp	x9, x8
1091fce44: 54000121    	b.ne	0x1091fce68 <_Flutter_MMFoundation_BindContext+0x56d8a4c>
1091fce48: a9577bfd    	ldp	x29, x30, [sp, #0x170]
1091fce4c: a9564ff4    	ldp	x20, x19, [sp, #0x160]
1091fce50: a95557f6    	ldp	x22, x21, [sp, #0x150]
1091fce54: a9545ff8    	ldp	x24, x23, [sp, #0x140]
1091fce58: a95367fa    	ldp	x26, x25, [sp, #0x130]
1091fce5c: a9526ffc    	ldp	x28, x27, [sp, #0x120]
1091fce60: 910603ff    	add	sp, sp, #0x180
1091fce64: d65f03c0    	ret
1091fce68: 95997985    	bl	0x10f85b47c <_UR_96F1_B25D+0x3a640ec>
