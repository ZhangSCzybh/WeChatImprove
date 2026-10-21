
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10901a1c0: d10283ff    	sub	sp, sp, #0xa0
10901a1c4: a9046ffc    	stp	x28, x27, [sp, #0x40]
10901a1c8: a90567fa    	stp	x26, x25, [sp, #0x50]
10901a1cc: a9065ff8    	stp	x24, x23, [sp, #0x60]
10901a1d0: a90757f6    	stp	x22, x21, [sp, #0x70]
10901a1d4: a9084ff4    	stp	x20, x19, [sp, #0x80]
10901a1d8: a9097bfd    	stp	x29, x30, [sp, #0x90]
10901a1dc: 910243fd    	add	x29, sp, #0x90
10901a1e0: b90027e2    	str	w2, [sp, #0x24]
10901a1e4: aa0003f3    	mov	x19, x0
10901a1e8: f00be188    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
10901a1ec: 52800029    	mov	w9, #0x1                ; =1
10901a1f0: 393be909    	strb	w9, [x8, #0xefa]
10901a1f4: d00b9248    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
10901a1f8: b9864d08    	ldrsw	x8, [x8, #0x64c]
10901a1fc: 3828681f    	strb	wzr, [x0, x8]
10901a200: d00b9248    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
10901a204: b9864514    	ldrsw	x20, [x8, #0x644]
10901a208: f8746800    	ldr	x0, [x0, x20]
10901a20c: b5000120    	cbnz	x0, 0x10901a230 <_Flutter_MMFoundation_BindContext+0x54f5e14>
10901a210: b00b8ac8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10901a214: f9455500    	ldr	x0, [x8, #0xaa8]
10901a218: 95a10492    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10901a21c: f8746a68    	ldr	x8, [x19, x20]
10901a220: f8346a60    	str	x0, [x19, x20]
10901a224: aa0803e0    	mov	x0, x8
10901a228: 95a1048d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a22c: f8746a60    	ldr	x0, [x19, x20]
10901a230: 900b8768    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10901a234: f940811a    	ldr	x26, [x8, #0x100] ; removeAllObjects
10901a238: aa1a03e1    	mov	x1, x26
10901a23c: 95a10482    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a240: f9000ff4    	str	x20, [sp, #0x18]
10901a244: f8746a75    	ldr	x21, [x19, x20]
10901a248: b00b8ac8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10901a24c: f945e900    	ldr	x0, [x8, #0xbd0]
10901a250: d00b8728    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10901a254: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10901a258: f9001fe1    	str	x1, [sp, #0x38]
10901a25c: 95a1047a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a260: aa1d03fd    	mov	x29, x29
10901a264: 95a1047b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a268: aa0003f4    	mov	x20, x0
10901a26c: d00b8ac8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10901a270: f9428500    	ldr	x0, [x8, #0x508]
10901a274: b00b8728    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10901a278: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10901a27c: f9001be1    	str	x1, [sp, #0x30]
10901a280: 95a10471    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a284: aa0003e2    	mov	x2, x0
10901a288: f00b70e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10901a28c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10901a290: aa1403e0    	mov	x0, x20
10901a294: f90017e1    	str	x1, [sp, #0x28]
10901a298: 95a1046b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a29c: aa1d03fd    	mov	x29, x29
10901a2a0: 95a1046c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a2a4: aa0003f6    	mov	x22, x0
10901a2a8: d00b9248    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
10901a2ac: b9863d08    	ldrsw	x8, [x8, #0x63c]
10901a2b0: f9000be8    	str	x8, [sp, #0x10]
10901a2b4: f8686a60    	ldr	x0, [x19, x8]
10901a2b8: b00b7108    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10901a2bc: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
10901a2c0: f90007e1    	str	x1, [sp, #0x8]
10901a2c4: 95a10460    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a2c8: aa1d03fd    	mov	x29, x29
10901a2cc: 95a10461    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a2d0: aa0003f7    	mov	x23, x0
10901a2d4: 900b7ec8    	adrp	x8, 0x11fff2000 <dyld_stub_binder+0x11fff2000>
10901a2d8: f9440919    	ldr	x25, [x8, #0x810] ; homepageType
10901a2dc: aa1303e0    	mov	x0, x19
10901a2e0: aa1903e1    	mov	x1, x25
10901a2e4: 95a10458    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a2e8: aa0003e3    	mov	x3, x0
10901a2ec: 900b7f68    	adrp	x8, 0x120006000 <dyld_stub_binder+0x120006000>
10901a2f0: f940111b    	ldr	x27, [x8, #0x20] ; getHomepageData:type:
10901a2f4: aa1603e0    	mov	x0, x22
10901a2f8: aa1b03e1    	mov	x1, x27
10901a2fc: aa1703e2    	mov	x2, x23
10901a300: 95a10451    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a304: aa1d03fd    	mov	x29, x29
10901a308: 95a10452    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a30c: aa0003f8    	mov	x24, x0
10901a310: 900b8728    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10901a314: f946f91c    	ldr	x28, [x8, #0xdf0] ; addObjectsFromArray:
10901a318: aa1503e0    	mov	x0, x21
10901a31c: aa1c03e1    	mov	x1, x28
10901a320: aa1803e2    	mov	x2, x24
10901a324: 95a10448    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a328: aa1803e0    	mov	x0, x24
10901a32c: 95a1044c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a330: aa1703e0    	mov	x0, x23
10901a334: 95a1044a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a338: aa1603e0    	mov	x0, x22
10901a33c: 95a10448    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a340: aa1403e0    	mov	x0, x20
10901a344: 95a10446    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a348: b00b8268    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
10901a34c: f9442501    	ldr	x1, [x8, #0x848] ; updateJumpState
10901a350: aa1303e0    	mov	x0, x19
10901a354: 95a1043c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a358: aa1303e0    	mov	x0, x19
10901a35c: aa1903e1    	mov	x1, x25
10901a360: 95a10439    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a364: b5000780    	cbnz	x0, 0x10901a454 <_Flutter_MMFoundation_BindContext+0x54f6038>
10901a368: d00b9248    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
10901a36c: b9864914    	ldrsw	x20, [x8, #0x648]
10901a370: f8746a60    	ldr	x0, [x19, x20]
10901a374: b5000120    	cbnz	x0, 0x10901a398 <_Flutter_MMFoundation_BindContext+0x54f5f7c>
10901a378: b00b8ac8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10901a37c: f9455500    	ldr	x0, [x8, #0xaa8]
10901a380: 95a10438    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10901a384: f8746a68    	ldr	x8, [x19, x20]
10901a388: f8346a60    	str	x0, [x19, x20]
10901a38c: aa0803e0    	mov	x0, x8
10901a390: 95a10433    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a394: f8746a60    	ldr	x0, [x19, x20]
10901a398: aa1a03e1    	mov	x1, x26
10901a39c: 95a1042a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a3a0: f8746a74    	ldr	x20, [x19, x20]
10901a3a4: b00b8ac8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10901a3a8: f945e900    	ldr	x0, [x8, #0xbd0]
10901a3ac: f9401fe1    	ldr	x1, [sp, #0x38]
10901a3b0: 95a10425    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a3b4: aa1d03fd    	mov	x29, x29
10901a3b8: 95a10426    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a3bc: aa0003f5    	mov	x21, x0
10901a3c0: d00b8ac8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10901a3c4: f9428500    	ldr	x0, [x8, #0x508]
10901a3c8: f9401be1    	ldr	x1, [sp, #0x30]
10901a3cc: 95a1041e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a3d0: aa0003e2    	mov	x2, x0
10901a3d4: aa1503e0    	mov	x0, x21
10901a3d8: f94017e1    	ldr	x1, [sp, #0x28]
10901a3dc: 95a1041a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a3e0: aa1d03fd    	mov	x29, x29
10901a3e4: 95a1041b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a3e8: aa0003f6    	mov	x22, x0
10901a3ec: a940a3e1    	ldp	x1, x8, [sp, #0x8]
10901a3f0: f8686a60    	ldr	x0, [x19, x8]
10901a3f4: 95a10414    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a3f8: aa1d03fd    	mov	x29, x29
10901a3fc: 95a10415    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a400: aa0003f7    	mov	x23, x0
10901a404: aa1603e0    	mov	x0, x22
10901a408: aa1b03e1    	mov	x1, x27
10901a40c: aa1703e2    	mov	x2, x23
10901a410: 52800023    	mov	w3, #0x1                ; =1
10901a414: 95a1040c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a418: aa1d03fd    	mov	x29, x29
10901a41c: 95a1040d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a420: aa0003f8    	mov	x24, x0
10901a424: aa1403e0    	mov	x0, x20
10901a428: aa1c03e1    	mov	x1, x28
10901a42c: aa1803e2    	mov	x2, x24
10901a430: 95a10405    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a434: aa1803e0    	mov	x0, x24
10901a438: 95a10409    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a43c: aa1703e0    	mov	x0, x23
10901a440: 95a10407    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a444: aa1603e0    	mov	x0, x22
10901a448: 95a10405    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a44c: aa1503e0    	mov	x0, x21
10901a450: 95a10403    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a454: b94027f8    	ldr	w24, [sp, #0x24]
10901a458: 340005d8    	cbz	w24, 0x10901a510 <_Flutter_MMFoundation_BindContext+0x54f60f4>
10901a45c: b00b8ac8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10901a460: f945e900    	ldr	x0, [x8, #0xbd0]
10901a464: f9401fe1    	ldr	x1, [sp, #0x38]
10901a468: 95a103f7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a46c: aa1d03fd    	mov	x29, x29
10901a470: 95a103f8    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a474: aa0003f4    	mov	x20, x0
10901a478: d00b8ac8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10901a47c: f9428500    	ldr	x0, [x8, #0x508]
10901a480: f9401be1    	ldr	x1, [sp, #0x30]
10901a484: 95a103f0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a488: aa0003e2    	mov	x2, x0
10901a48c: aa1403e0    	mov	x0, x20
10901a490: f94017e1    	ldr	x1, [sp, #0x28]
10901a494: 95a103ec    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a498: aa1d03fd    	mov	x29, x29
10901a49c: 95a103ed    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a4a0: aa0003f5    	mov	x21, x0
10901a4a4: a940efe1    	ldp	x1, x27, [sp, #0x8]
10901a4a8: f87b6a60    	ldr	x0, [x19, x27]
10901a4ac: 95a103e6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a4b0: aa1d03fd    	mov	x29, x29
10901a4b4: 95a103e7    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a4b8: aa0003f6    	mov	x22, x0
10901a4bc: aa1303e0    	mov	x0, x19
10901a4c0: aa1903e1    	mov	x1, x25
10901a4c4: 95a103e0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a4c8: aa0003f7    	mov	x23, x0
10901a4cc: f87b6a60    	ldr	x0, [x19, x27]
10901a4d0: 900b7188    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
10901a4d4: f9410901    	ldr	x1, [x8, #0x210] ; m_uiFriendScene
10901a4d8: 95a103db    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a4dc: 2a0003e4    	mov	w4, w0
10901a4e0: 900b7f68    	adrp	x8, 0x120006000 <dyld_stub_binder+0x120006000>
10901a4e4: f9401901    	ldr	x1, [x8, #0x30] ; updateHomepageHead:type:source:
10901a4e8: aa1503e0    	mov	x0, x21
10901a4ec: aa1603e2    	mov	x2, x22
10901a4f0: aa1703e3    	mov	x3, x23
10901a4f4: 95a103d4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a4f8: aa1603e0    	mov	x0, x22
10901a4fc: 95a103d8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a500: aa1503e0    	mov	x0, x21
10901a504: 95a103d6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a508: aa1403e0    	mov	x0, x20
10901a50c: 95a103d4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a510: f9400fe8    	ldr	x8, [sp, #0x18]
10901a514: f8686a60    	ldr	x0, [x19, x8]
10901a518: d00b8728    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10901a51c: f9435101    	ldr	x1, [x8, #0x6a0] ; count
10901a520: 95a103c9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a524: b50006a0    	cbnz	x0, 0x10901a5f8 <_Flutter_MMFoundation_BindContext+0x54f61dc>
10901a528: 34000698    	cbz	w24, 0x10901a5f8 <_Flutter_MMFoundation_BindContext+0x54f61dc>
10901a52c: 900b7108    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10901a530: f9402901    	ldr	x1, [x8, #0x50] ; startLoadingNonBlock
10901a534: aa1303e0    	mov	x0, x19
10901a538: 95a103c3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a53c: b00b8ac8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10901a540: f945e900    	ldr	x0, [x8, #0xbd0]
10901a544: f9401fe1    	ldr	x1, [sp, #0x38]
10901a548: 95a103bf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a54c: aa1d03fd    	mov	x29, x29
10901a550: 95a103c0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a554: aa0003f4    	mov	x20, x0
10901a558: b00b8ac8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10901a55c: f9462900    	ldr	x0, [x8, #0xc50]
10901a560: f9401be1    	ldr	x1, [sp, #0x30]
10901a564: 95a103b8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a568: aa0003e2    	mov	x2, x0
10901a56c: aa1403e0    	mov	x0, x20
10901a570: f94017e1    	ldr	x1, [sp, #0x28]
10901a574: 95a103b4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a578: aa1d03fd    	mov	x29, x29
10901a57c: 95a103b5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a580: aa0003f5    	mov	x21, x0
10901a584: f00b70e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10901a588: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
10901a58c: 900aa542    	adrp	x2, 0x11e4c2000 <dyld_stub_binder+0x11e4c2000>
10901a590: 91082042    	add	x2, x2, #0x208
10901a594: 95a103ac    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a598: aa1d03fd    	mov	x29, x29
10901a59c: 95a103ad    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901a5a0: aa0003f6    	mov	x22, x0
10901a5a4: d00b93a8    	adrp	x8, 0x120290000 <dyld_stub_binder+0x120290000>
10901a5a8: 910dc108    	add	x8, x8, #0x370
10901a5ac: b9800108    	ldrsw	x8, [x8]
10901a5b0: f8686a60    	ldr	x0, [x19, x8]
10901a5b4: f00b8768    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
10901a5b8: f9468d01    	ldr	x1, [x8, #0xd18] ; setText:
10901a5bc: aa1603e2    	mov	x2, x22
10901a5c0: 95a103a1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901a5c4: aa1603e0    	mov	x0, x22
10901a5c8: 95a103a5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a5cc: aa1503e0    	mov	x0, x21
10901a5d0: 95a103a3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a5d4: aa1403e0    	mov	x0, x20
10901a5d8: a9497bfd    	ldp	x29, x30, [sp, #0x90]
10901a5dc: a9484ff4    	ldp	x20, x19, [sp, #0x80]
10901a5e0: a94757f6    	ldp	x22, x21, [sp, #0x70]
10901a5e4: a9465ff8    	ldp	x24, x23, [sp, #0x60]
10901a5e8: a94567fa    	ldp	x26, x25, [sp, #0x50]
10901a5ec: a9446ffc    	ldp	x28, x27, [sp, #0x40]
10901a5f0: 910283ff    	add	sp, sp, #0xa0
10901a5f4: 15a1039a    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901a5f8: a9497bfd    	ldp	x29, x30, [sp, #0x90]
10901a5fc: a9484ff4    	ldp	x20, x19, [sp, #0x80]
10901a600: a94757f6    	ldp	x22, x21, [sp, #0x70]
10901a604: a9465ff8    	ldp	x24, x23, [sp, #0x60]
10901a608: a94567fa    	ldp	x26, x25, [sp, #0x50]
10901a60c: a9446ffc    	ldp	x28, x27, [sp, #0x40]
10901a610: 910283ff    	add	sp, sp, #0xa0
10901a614: d65f03c0    	ret
