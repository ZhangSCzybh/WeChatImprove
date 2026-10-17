
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b3a1f8: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
104b3a1fc: a90167fa    	stp	x26, x25, [sp, #0x10]
104b3a200: a9025ff8    	stp	x24, x23, [sp, #0x20]
104b3a204: a90357f6    	stp	x22, x21, [sp, #0x30]
104b3a208: a9044ff4    	stp	x20, x19, [sp, #0x40]
104b3a20c: a9057bfd    	stp	x29, x30, [sp, #0x50]
104b3a210: 910143fd    	add	x29, sp, #0x50
104b3a214: d10803ff    	sub	sp, sp, #0x200
104b3a218: aa0503fc    	mov	x28, x5
104b3a21c: aa0403f5    	mov	x21, x4
104b3a220: aa0303f4    	mov	x20, x3
104b3a224: aa0203f3    	mov	x19, x2
104b3a228: aa0003f7    	mov	x23, x0
104b3a22c: b00c55a8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104b3a230: f9405908    	ldr	x8, [x8, #0xb0]
104b3a234: f9400108    	ldr	x8, [x8]
104b3a238: f81a03a8    	stur	x8, [x29, #-0x60]
104b3a23c: 900e0828    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104b3a240: 52800029    	mov	w9, #0x1                ; =1
104b3a244: 3915c909    	strb	w9, [x8, #0x572]
104b3a248: aa0203e0    	mov	x0, x2
104b3a24c: 94c3b3bb    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b3a250: aa1403e0    	mov	x0, x20
104b3a254: 94c3b3b9    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b3a258: aa1503e0    	mov	x0, x21
104b3a25c: 94c3b3b7    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b3a260: b4000754    	cbz	x20, 0x104b3a348 <_Flutter_MMFoundation_BindContext+0x1015f2c>
104b3a264: b00dae48    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104b3a268: f946e918    	ldr	x24, [x8, #0xdd0] ; length
104b3a26c: aa1503e0    	mov	x0, x21
104b3a270: aa1803e1    	mov	x1, x24
104b3a274: 94c3b3b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a278: b00db1d6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104b3a27c: f00d97e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3a280: b4000200    	cbz	x0, 0x104b3a2c0 <_Flutter_MMFoundation_BindContext+0x1015ea4>
104b3a284: f94636c0    	ldr	x0, [x22, #0xc68]
104b3a288: f9467901    	ldr	x1, [x8, #0xcf0] ; FileExist:
104b3a28c: aa1503e2    	mov	x2, x21
104b3a290: 94c3b3ab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a294: 34000160    	cbz	w0, 0x104b3a2c0 <_Flutter_MMFoundation_BindContext+0x1015ea4>
104b3a298: f94636c0    	ldr	x0, [x22, #0xc68]
104b3a29c: b00d9808    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104b3a2a0: f9467101    	ldr	x1, [x8, #0xce0] ; GetFileSize:
104b3a2a4: aa1503e2    	mov	x2, x21
104b3a2a8: 94c3b3a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a2ac: 8aa0fc02    	bic	x2, x0, x0, asr #63
104b3a2b0: b00d9888    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b3a2b4: f9405901    	ldr	x1, [x8, #0xb0] ; setM_uiAppDataSize:
104b3a2b8: aa1403e0    	mov	x0, x20
104b3a2bc: 94c3b3a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a2c0: 900d9828    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104b3a2c4: f941411a    	ldr	x26, [x8, #0x280] ; m_uiAppMsgInnerType
104b3a2c8: aa1403e0    	mov	x0, x20
104b3a2cc: aa1a03e1    	mov	x1, x26
104b3a2d0: 94c3b39b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a2d4: 7100201f    	cmp	w0, #0x8
104b3a2d8: 54000d81    	b.ne	0x104b3a488 <_Flutter_MMFoundation_BindContext+0x101606c>
104b3a2dc: b00d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b3a2e0: f940b101    	ldr	x1, [x8, #0x160] ; m_nsEmoticonMD5
104b3a2e4: aa1403e0    	mov	x0, x20
104b3a2e8: 94c3b395    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a2ec: aa1d03fd    	mov	x29, x29
104b3a2f0: 94c3b396    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3a2f4: aa0003f9    	mov	x25, x0
104b3a2f8: aa1803e1    	mov	x1, x24
104b3a2fc: 94c3b390    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a300: aa0003fb    	mov	x27, x0
104b3a304: aa1903e0    	mov	x0, x25
104b3a308: 94c3b393    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3a30c: b5000bfb    	cbnz	x27, 0x104b3a488 <_Flutter_MMFoundation_BindContext+0x101606c>
104b3a310: aa1503e0    	mov	x0, x21
104b3a314: aa1803e1    	mov	x1, x24
104b3a318: 94c3b389    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a31c: b4000520    	cbz	x0, 0x104b3a3c0 <_Flutter_MMFoundation_BindContext+0x1015fa4>
104b3a320: b00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3a324: f9459500    	ldr	x0, [x8, #0xb28]
104b3a328: d00dae28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104b3a32c: f945f501    	ldr	x1, [x8, #0xbe8] ; dataWithContentsOfFile:
104b3a330: aa1503e2    	mov	x2, x21
104b3a334: 94c3b382    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a338: aa1d03fd    	mov	x29, x29
104b3a33c: 94c3b383    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3a340: aa0003f9    	mov	x25, x0
104b3a344: 14000020    	b	0x104b3a3c4 <_Flutter_MMFoundation_BindContext+0x1015fa8>
104b3a348: b00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3a34c: f9453516    	ldr	x22, [x8, #0xa68]
104b3a350: b00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3a354: f9454500    	ldr	x0, [x8, #0xa88]
104b3a358: d00d9808    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b3a35c: f947c901    	ldr	x1, [x8, #0xf90] ; generatePrivacyString:
104b3a360: aa1303e2    	mov	x2, x19
104b3a364: 94c3b376    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a368: aa1d03fd    	mov	x29, x29
104b3a36c: 94c3b377    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3a370: aa0003f7    	mov	x23, x0
104b3a374: f00d97e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3a378: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b3a37c: d00ce348    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b3a380: 913aa108    	add	x8, x8, #0xea8
104b3a384: a90003e8    	stp	x8, x0, [sp]
104b3a388: f00b3743    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b3a38c: 9107f063    	add	x3, x3, #0x1fc
104b3a390: d00b6605    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b3a394: 910cb4a5    	add	x5, x5, #0x32d
104b3a398: f00b6607    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b3a39c: 913edce7    	add	x7, x7, #0xfb7
104b3a3a0: aa1603e0    	mov	x0, x22
104b3a3a4: 52800082    	mov	w2, #0x4                ; =4
104b3a3a8: 52800004    	mov	w4, #0x0                ; =0
104b3a3ac: 5281a6c6    	mov	w6, #0xd36              ; =3382
104b3a3b0: 94c3b363    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a3b4: aa1703e0    	mov	x0, x23
104b3a3b8: 94c3b367    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3a3bc: 1400019d    	b	0x104b3aa30 <_Flutter_MMFoundation_BindContext+0x1016614>
104b3a3c0: d2800019    	mov	x25, #0x0               ; =0
104b3a3c4: a938ffbf    	stp	xzr, xzr, [x29, #-0x78]
104b3a3c8: f81983bf    	stur	xzr, [x29, #-0x68]
104b3a3cc: aa1903e0    	mov	x0, x25
104b3a3d0: 94c3b376    	bl	0x107c271a8 <_Flutter_MMFoundation_BindContext+0x4102d8c>
104b3a3d4: b00dae28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104b3a3d8: f9447501    	ldr	x1, [x8, #0x8e8] ; bytes
104b3a3dc: 94c3b358    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a3e0: aa0003fb    	mov	x27, x0
104b3a3e4: aa1903e0    	mov	x0, x25
104b3a3e8: aa1803e1    	mov	x1, x24
104b3a3ec: 94c3b354    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a3f0: aa0003e2    	mov	x2, x0
104b3a3f4: d101e3a0    	sub	x0, x29, #0x78
104b3a3f8: aa1b03e1    	mov	x1, x27
104b3a3fc: 94c34bda    	bl	0x107c0d364 <_Flutter_MMFoundation_BindContext+0x40e8f48>
104b3a400: b00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3a404: f945451b    	ldr	x27, [x8, #0xa88]
104b3a408: 910303f6    	add	x22, sp, #0xc0
104b3a40c: 910303e8    	add	x8, sp, #0xc0
104b3a410: d101e3a0    	sub	x0, x29, #0x78
104b3a414: 94c34bd2    	bl	0x107c0d35c <_Flutter_MMFoundation_BindContext+0x40e8f40>
104b3a418: 39c35fe8    	ldrsb	w8, [sp, #0xd7]
104b3a41c: f94063e9    	ldr	x9, [sp, #0xc0]
104b3a420: 7100011f    	cmp	w8, #0x0
104b3a424: 9a96b122    	csel	x2, x9, x22, lt
104b3a428: 900dae88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104b3a42c: f946ad01    	ldr	x1, [x8, #0xd58] ; stringWithUTF8String:
104b3a430: aa1b03e0    	mov	x0, x27
104b3a434: 94c3b342    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a438: aa1d03fd    	mov	x29, x29
104b3a43c: 94c3b343    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3a440: aa0003fb    	mov	x27, x0
104b3a444: d00d9b28    	adrp	x8, 0x11fea0000 <dyld_stub_binder+0x11fea0000>
104b3a448: f945ed01    	ldr	x1, [x8, #0xbd8] ; setM_nsEmoticonMD5:
104b3a44c: aa1403e0    	mov	x0, x20
104b3a450: aa1b03e2    	mov	x2, x27
104b3a454: 94c3b33a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a458: aa1b03e0    	mov	x0, x27
104b3a45c: 94c3b33e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3a460: 39c35fe8    	ldrsb	w8, [sp, #0xd7]
104b3a464: 36f800a8    	tbz	w8, #0x1f, 0x104b3a478 <_Flutter_MMFoundation_BindContext+0x101605c>
104b3a468: f94063e0    	ldr	x0, [sp, #0xc0]
104b3a46c: f9406be8    	ldr	x8, [sp, #0xd0]
104b3a470: 9240f901    	and	x1, x8, #0x7fffffffffffffff
104b3a474: 94c3b356    	bl	0x107c271cc <_Flutter_MMFoundation_BindContext+0x4102db0>
104b3a478: d101e3a0    	sub	x0, x29, #0x78
104b3a47c: 94c34bb7    	bl	0x107c0d358 <_Flutter_MMFoundation_BindContext+0x40e8f3c>
104b3a480: aa1903e0    	mov	x0, x25
104b3a484: 94c3b334    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3a488: f00db228    	adrp	x8, 0x120181000 <dyld_stub_binder+0x120181000>
104b3a48c: f9426900    	ldr	x0, [x8, #0x4d0]
104b3a490: 900da268    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b3a494: f9456101    	ldr	x1, [x8, #0xac0] ; checkConvertToLargeFileMsg:
104b3a498: aa1403e2    	mov	x2, x20
104b3a49c: 94c3b328    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a4a0: b00d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b3a4a4: f9467101    	ldr	x1, [x8, #0xce0] ; UpdateContent:
104b3a4a8: aa1403e0    	mov	x0, x20
104b3a4ac: d2800002    	mov	x2, #0x0                ; =0
104b3a4b0: 94c3b323    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a4b4: d00d9808    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b3a4b8: f9454d01    	ldr	x1, [x8, #0xa98] ; AddLocalMsg:MsgWrap:
104b3a4bc: aa1703e0    	mov	x0, x23
104b3a4c0: aa1303e2    	mov	x2, x19
104b3a4c4: aa1403e3    	mov	x3, x20
104b3a4c8: 94c3b31d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a4cc: d00d9808    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b3a4d0: f947d116    	ldr	x22, [x8, #0xfa0] ; m_uiMesLocalID
104b3a4d4: aa1403e0    	mov	x0, x20
104b3a4d8: aa1603e1    	mov	x1, x22
104b3a4dc: 94c3b318    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a4e0: 34000dc0    	cbz	w0, 0x104b3a698 <_Flutter_MMFoundation_BindContext+0x101627c>
104b3a4e4: f90013f6    	str	x22, [sp, #0x20]
104b3a4e8: aa1703f9    	mov	x25, x23
104b3a4ec: aa1c03f7    	mov	x23, x28
104b3a4f0: b00d9888    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b3a4f4: f940691b    	ldr	x27, [x8, #0xd0] ; revokeBatchId
104b3a4f8: aa1403e0    	mov	x0, x20
104b3a4fc: aa1b03e1    	mov	x1, x27
104b3a500: 94c3b30f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a504: aa1d03fd    	mov	x29, x29
104b3a508: 94c3b310    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3a50c: aa0003fc    	mov	x28, x0
104b3a510: aa1803e1    	mov	x1, x24
104b3a514: 94c3b30a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a518: aa0003f6    	mov	x22, x0
104b3a51c: aa1c03e0    	mov	x0, x28
104b3a520: 94c3b30d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3a524: b4000536    	cbz	x22, 0x104b3a5c8 <_Flutter_MMFoundation_BindContext+0x10161ac>
104b3a528: b00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3a52c: f945e900    	ldr	x0, [x8, #0xbd0]
104b3a530: d00dae28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104b3a534: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104b3a538: 94c3b301    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a53c: aa1d03fd    	mov	x29, x29
104b3a540: 94c3b302    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3a544: aa0003f6    	mov	x22, x0
104b3a548: 900db1e8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
104b3a54c: f940f500    	ldr	x0, [x8, #0x1e8] ; ا7 
104b3a550: b00dae28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104b3a554: f947ad01    	ldr	x1, [x8, #0xf58] ; class
104b3a558: 94c3b2f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a55c: aa0003e2    	mov	x2, x0
104b3a560: f00d97e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3a564: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104b3a568: aa1603e0    	mov	x0, x22
104b3a56c: 94c3b2f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a570: aa1d03fd    	mov	x29, x29
104b3a574: 94c3b2f5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3a578: aa0003fc    	mov	x28, x0
104b3a57c: aa1403e0    	mov	x0, x20
104b3a580: aa1b03e1    	mov	x1, x27
104b3a584: 94c3b2ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a588: aa1d03fd    	mov	x29, x29
104b3a58c: 94c3b2ef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3a590: aa0003fb    	mov	x27, x0
104b3a594: 900da268    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b3a598: f943dd01    	ldr	x1, [x8, #0x7b8] ; addBatchSendForUser:record:identifier:
104b3a59c: aa1c03e0    	mov	x0, x28
104b3a5a0: aa1303e2    	mov	x2, x19
104b3a5a4: aa1403e3    	mov	x3, x20
104b3a5a8: aa1b03e4    	mov	x4, x27
104b3a5ac: 94c3b2e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a5b0: aa1b03e0    	mov	x0, x27
104b3a5b4: 94c3b2e8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3a5b8: aa1c03e0    	mov	x0, x28
104b3a5bc: 94c3b2e6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3a5c0: aa1603e0    	mov	x0, x22
104b3a5c4: 94c3b2e4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3a5c8: d00db1c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b3a5cc: f9411d00    	ldr	x0, [x8, #0x238]
104b3a5d0: d00d9b48    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
104b3a5d4: f9423d01    	ldr	x1, [x8, #0x478] ; clearLocalImage:
104b3a5d8: aa1403e2    	mov	x2, x20
104b3a5dc: 94c3b2d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a5e0: aa1503e0    	mov	x0, x21
104b3a5e4: aa1803e1    	mov	x1, x24
104b3a5e8: 94c3b2d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a5ec: aa1703fc    	mov	x28, x23
104b3a5f0: aa1903f7    	mov	x23, x25
104b3a5f4: b4001340    	cbz	x0, 0x104b3a85c <_Flutter_MMFoundation_BindContext+0x1016440>
104b3a5f8: b00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3a5fc: f9463500    	ldr	x0, [x8, #0xc68]
104b3a600: f00d97e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3a604: f9467901    	ldr	x1, [x8, #0xcf0] ; FileExist:
104b3a608: aa1503e2    	mov	x2, x21
104b3a60c: 94c3b2cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a610: 34001260    	cbz	w0, 0x104b3a85c <_Flutter_MMFoundation_BindContext+0x1016440>
104b3a614: aa1403e0    	mov	x0, x20
104b3a618: aa1a03e1    	mov	x1, x26
104b3a61c: 94c3b2c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a620: 7100201f    	cmp	w0, #0x8
104b3a624: 540005e1    	b.ne	0x104b3a6e0 <_Flutter_MMFoundation_BindContext+0x10162c4>
104b3a628: b00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3a62c: f9459500    	ldr	x0, [x8, #0xb28]
104b3a630: d00dae28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104b3a634: f945f501    	ldr	x1, [x8, #0xbe8] ; dataWithContentsOfFile:
104b3a638: aa1503e2    	mov	x2, x21
104b3a63c: 94c3b2c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a640: aa1d03fd    	mov	x29, x29
104b3a644: 94c3b2c1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3a648: aa0003fa    	mov	x26, x0
104b3a64c: d00db1c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b3a650: f9452d16    	ldr	x22, [x8, #0xa58]
104b3a654: b00d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b3a658: f940b101    	ldr	x1, [x8, #0x160] ; m_nsEmoticonMD5
104b3a65c: aa1403e0    	mov	x0, x20
104b3a660: 94c3b2b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a664: aa1d03fd    	mov	x29, x29
104b3a668: 94c3b2b8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3a66c: aa0003fb    	mov	x27, x0
104b3a670: 900d9968    	adrp	x8, 0x11fe66000 <dyld_stub_binder+0x11fe66000>
104b3a674: f9461501    	ldr	x1, [x8, #0xc28] ; saveEmoticonToEmoticonDirForMd5:data:isCleanable:
104b3a678: aa1603e0    	mov	x0, x22
104b3a67c: aa1b03e2    	mov	x2, x27
104b3a680: aa1a03e3    	mov	x3, x26
104b3a684: 52800024    	mov	w4, #0x1                ; =1
104b3a688: 94c3b2ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a68c: aa1b03e0    	mov	x0, x27
104b3a690: 94c3b2b1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3a694: 14000070    	b	0x104b3a854 <_Flutter_MMFoundation_BindContext+0x1016438>
104b3a698: b00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3a69c: f9453500    	ldr	x0, [x8, #0xa68]
104b3a6a0: f00d97e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3a6a4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b3a6a8: d00ce348    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b3a6ac: 913b2108    	add	x8, x8, #0xec8
104b3a6b0: a90053e8    	stp	x8, x20, [sp]
104b3a6b4: f00b3743    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b3a6b8: 9107f063    	add	x3, x3, #0x1fc
104b3a6bc: d00b6605    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b3a6c0: 910cb4a5    	add	x5, x5, #0x32d
104b3a6c4: f00b6607    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b3a6c8: 913edce7    	add	x7, x7, #0xfb7
104b3a6cc: 52800082    	mov	w2, #0x4                ; =4
104b3a6d0: 52800004    	mov	w4, #0x0                ; =0
104b3a6d4: 5281a986    	mov	w6, #0xd4c              ; =3404
104b3a6d8: 94c3b299    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a6dc: 140000d5    	b	0x104b3aa30 <_Flutter_MMFoundation_BindContext+0x1016614>
104b3a6e0: d00db1c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b3a6e4: f9451500    	ldr	x0, [x8, #0xa28]
104b3a6e8: 900dae88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104b3a6ec: f9437d01    	ldr	x1, [x8, #0x6f8] ; sharedInstance
104b3a6f0: 94c3b293    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a6f4: aa1d03fd    	mov	x29, x29
104b3a6f8: 94c3b294    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3a6fc: aa0003f6    	mov	x22, x0
104b3a700: d00db1a8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
104b3a704: f9456902    	ldr	x2, [x8, #0xad0]
104b3a708: b00d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b3a70c: f944c91a    	ldr	x26, [x8, #0x990] ; GetPathOfAppDataByUserName:andMessageWrap:retStrPath:
104b3a710: b00d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b3a714: f9403101    	ldr	x1, [x8, #0x60] ; getClsMethodObservers:selector:
104b3a718: aa1a03e3    	mov	x3, x26
104b3a71c: 94c3b288    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a720: aa1d03fd    	mov	x29, x29
104b3a724: 94c3b289    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3a728: aa0003fb    	mov	x27, x0
104b3a72c: aa1603e0    	mov	x0, x22
104b3a730: 94c3b289    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3a734: 4f00e400    	movi.16b	v0, #0x0
104b3a738: ad0503e0    	stp	q0, q0, [sp, #0xa0]
104b3a73c: ad0403e0    	stp	q0, q0, [sp, #0x80]
104b3a740: d00dae28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104b3a744: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
104b3a748: 910203e2    	add	x2, sp, #0x80
104b3a74c: d103e3a3    	sub	x3, x29, #0xf8
104b3a750: aa1b03e0    	mov	x0, x27
104b3a754: 52800204    	mov	w4, #0x10               ; =16
104b3a758: 94c3b279    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a75c: b40001a0    	cbz	x0, 0x104b3a790 <_Flutter_MMFoundation_BindContext+0x1016374>
104b3a760: f94047e8    	ldr	x8, [sp, #0x88]
104b3a764: f9400100    	ldr	x0, [x8]
104b3a768: f9003fff    	str	xzr, [sp, #0x78]
104b3a76c: 9101e3e4    	add	x4, sp, #0x78
104b3a770: aa1a03e1    	mov	x1, x26
104b3a774: aa1303e2    	mov	x2, x19
104b3a778: aa1403e3    	mov	x3, x20
104b3a77c: 94c3b270    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a780: f9403ffa    	ldr	x26, [sp, #0x78]
104b3a784: aa1a03e0    	mov	x0, x26
104b3a788: 94c3b26c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b3a78c: 14000002    	b	0x104b3a794 <_Flutter_MMFoundation_BindContext+0x1016378>
104b3a790: d280001a    	mov	x26, #0x0               ; =0
104b3a794: b00db1d6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104b3a798: aa1b03e0    	mov	x0, x27
104b3a79c: 94c3b26e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3a7a0: f94636c0    	ldr	x0, [x22, #0xc68]
104b3a7a4: f00d97e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3a7a8: f946f101    	ldr	x1, [x8, #0xde0] ; RemoveFile:
104b3a7ac: aa1a03e2    	mov	x2, x26
104b3a7b0: 94c3b263    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a7b4: f94636c0    	ldr	x0, [x22, #0xc68]
104b3a7b8: d00d9968    	adrp	x8, 0x11fe68000 <dyld_stub_binder+0x11fe68000>
104b3a7bc: f9443501    	ldr	x1, [x8, #0x868] ; HardLinkFile:To:
104b3a7c0: aa1503e2    	mov	x2, x21
104b3a7c4: aa1a03e3    	mov	x3, x26
104b3a7c8: 94c3b25d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a7cc: aa0003e8    	mov	x8, x0
104b3a7d0: b00db1c9    	adrp	x9, 0x120173000 <dyld_stub_binder+0x120173000>
104b3a7d4: f9453520    	ldr	x0, [x9, #0xa68]
104b3a7d8: f00d97e9    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3a7dc: f942a921    	ldr	x1, [x9, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b3a7e0: 340001e8    	cbz	w8, 0x104b3a81c <_Flutter_MMFoundation_BindContext+0x1016400>
104b3a7e4: a900ebf5    	stp	x21, x26, [sp, #0x8]
104b3a7e8: d00ce348    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b3a7ec: 913ba108    	add	x8, x8, #0xee8
104b3a7f0: f90003e8    	str	x8, [sp]
104b3a7f4: f00b3743    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b3a7f8: 9107f063    	add	x3, x3, #0x1fc
104b3a7fc: d00b6605    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b3a800: 910cb4a5    	add	x5, x5, #0x32d
104b3a804: f00b6607    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b3a808: 913edce7    	add	x7, x7, #0xfb7
104b3a80c: 52800042    	mov	w2, #0x2                ; =2
104b3a810: 52800004    	mov	w4, #0x0                ; =0
104b3a814: 5281ac86    	mov	w6, #0xd64              ; =3428
104b3a818: 1400000e    	b	0x104b3a850 <_Flutter_MMFoundation_BindContext+0x1016434>
104b3a81c: a900ebf5    	stp	x21, x26, [sp, #0x8]
104b3a820: d00ce348    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b3a824: 913c2108    	add	x8, x8, #0xf08
104b3a828: f90003e8    	str	x8, [sp]
104b3a82c: f00b3743    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b3a830: 9107f063    	add	x3, x3, #0x1fc
104b3a834: d00b6605    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b3a838: 910cb4a5    	add	x5, x5, #0x32d
104b3a83c: f00b6607    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b3a840: 913edce7    	add	x7, x7, #0xfb7
104b3a844: 52800082    	mov	w2, #0x4                ; =4
104b3a848: 52800004    	mov	w4, #0x0                ; =0
104b3a84c: 5281acc6    	mov	w6, #0xd66              ; =3430
104b3a850: 94c3b23b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a854: aa1a03e0    	mov	x0, x26
104b3a858: 94c3b23f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3a85c: b00d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b3a860: f940291a    	ldr	x26, [x8, #0x50] ; m_dtThumbnail
104b3a864: aa1403e0    	mov	x0, x20
104b3a868: aa1a03e1    	mov	x1, x26
104b3a86c: 94c3b234    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a870: aa1d03fd    	mov	x29, x29
104b3a874: 94c3b235    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3a878: aa0003f6    	mov	x22, x0
104b3a87c: aa1803e1    	mov	x1, x24
104b3a880: 94c3b22f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a884: aa0003f8    	mov	x24, x0
104b3a888: aa1603e0    	mov	x0, x22
104b3a88c: 94c3b232    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3a890: b4000c38    	cbz	x24, 0x104b3aa14 <_Flutter_MMFoundation_BindContext+0x10165f8>
104b3a894: d00db1c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b3a898: f9451500    	ldr	x0, [x8, #0xa28]
104b3a89c: 900dae88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104b3a8a0: f9437d01    	ldr	x1, [x8, #0x6f8] ; sharedInstance
104b3a8a4: 94c3b226    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a8a8: aa1d03fd    	mov	x29, x29
104b3a8ac: 94c3b227    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3a8b0: aa0003f6    	mov	x22, x0
104b3a8b4: d00db1a8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
104b3a8b8: f9456902    	ldr	x2, [x8, #0xad0]
104b3a8bc: b00d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b3a8c0: f9402d18    	ldr	x24, [x8, #0x58] ; GetPathOfAppThumb:LocalID:retStrPath:
104b3a8c4: b00d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b3a8c8: f9403101    	ldr	x1, [x8, #0x60] ; getClsMethodObservers:selector:
104b3a8cc: aa1803e3    	mov	x3, x24
104b3a8d0: 94c3b21b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a8d4: aa1d03fd    	mov	x29, x29
104b3a8d8: 94c3b21c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3a8dc: aa0003fb    	mov	x27, x0
104b3a8e0: aa1603e0    	mov	x0, x22
104b3a8e4: 94c3b21c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3a8e8: 4f00e400    	movi.16b	v0, #0x0
104b3a8ec: ad0283e0    	stp	q0, q0, [sp, #0x50]
104b3a8f0: ad0183e0    	stp	q0, q0, [sp, #0x30]
104b3a8f4: d00dae28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104b3a8f8: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
104b3a8fc: 9100c3e2    	add	x2, sp, #0x30
104b3a900: 910363e3    	add	x3, sp, #0xd8
104b3a904: aa1b03e0    	mov	x0, x27
104b3a908: 52800204    	mov	w4, #0x10               ; =16
104b3a90c: 94c3b20c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a910: b4000220    	cbz	x0, 0x104b3a954 <_Flutter_MMFoundation_BindContext+0x1016538>
104b3a914: f9401fe8    	ldr	x8, [sp, #0x38]
104b3a918: f9400116    	ldr	x22, [x8]
104b3a91c: aa1403e0    	mov	x0, x20
104b3a920: f94013e1    	ldr	x1, [sp, #0x20]
104b3a924: 94c3b206    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a928: aa0003e3    	mov	x3, x0
104b3a92c: f90017ff    	str	xzr, [sp, #0x28]
104b3a930: 9100a3e4    	add	x4, sp, #0x28
104b3a934: aa1603e0    	mov	x0, x22
104b3a938: aa1803e1    	mov	x1, x24
104b3a93c: aa1303e2    	mov	x2, x19
104b3a940: 94c3b1ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a944: f94017f8    	ldr	x24, [sp, #0x28]
104b3a948: aa1803e0    	mov	x0, x24
104b3a94c: 94c3b1fb    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b3a950: 14000002    	b	0x104b3a958 <_Flutter_MMFoundation_BindContext+0x101653c>
104b3a954: d2800018    	mov	x24, #0x0               ; =0
104b3a958: aa1b03e0    	mov	x0, x27
104b3a95c: 94c3b1fe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3a960: b00db1d6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104b3a964: f94636c0    	ldr	x0, [x22, #0xc68]
104b3a968: f00d97e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3a96c: f946f101    	ldr	x1, [x8, #0xde0] ; RemoveFile:
104b3a970: aa1803e2    	mov	x2, x24
104b3a974: 94c3b1f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a978: f94636c0    	ldr	x0, [x22, #0xc68]
104b3a97c: 900d9828    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104b3a980: f9409101    	ldr	x1, [x8, #0x120] ; CreateFile:
104b3a984: aa1803e2    	mov	x2, x24
104b3a988: 94c3b1ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a98c: aa1403e0    	mov	x0, x20
104b3a990: aa1a03e1    	mov	x1, x26
104b3a994: 94c3b1ea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a998: aa1d03fd    	mov	x29, x29
104b3a99c: 94c3b1eb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3a9a0: aa0003f6    	mov	x22, x0
104b3a9a4: d00dae88    	adrp	x8, 0x12010c000 <dyld_stub_binder+0x12010c000>
104b3a9a8: f9401501    	ldr	x1, [x8, #0x28] ; writeToFile:atomically:
104b3a9ac: aa1803e2    	mov	x2, x24
104b3a9b0: 52800003    	mov	w3, #0x0                ; =0
104b3a9b4: 94c3b1e2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3a9b8: aa0003f9    	mov	x25, x0
104b3a9bc: aa1603e0    	mov	x0, x22
104b3a9c0: 94c3b1e5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3a9c4: 37000259    	tbnz	w25, #0x0, 0x104b3aa0c <_Flutter_MMFoundation_BindContext+0x10165f0>
104b3a9c8: b00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3a9cc: f9453500    	ldr	x0, [x8, #0xa68]
104b3a9d0: f00d97e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3a9d4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b3a9d8: d00cd228    	adrp	x8, 0x11e580000 <dyld_stub_binder+0x11e580000>
104b3a9dc: 910ea108    	add	x8, x8, #0x3a8
104b3a9e0: a90063e8    	stp	x8, x24, [sp]
104b3a9e4: f00b3743    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b3a9e8: 9107f063    	add	x3, x3, #0x1fc
104b3a9ec: d00b6605    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b3a9f0: 910cb4a5    	add	x5, x5, #0x32d
104b3a9f4: f00b6607    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b3a9f8: 913edce7    	add	x7, x7, #0xfb7
104b3a9fc: 52800062    	mov	w2, #0x3                ; =3
104b3aa00: 52800004    	mov	w4, #0x0                ; =0
104b3aa04: 5281ae66    	mov	w6, #0xd73              ; =3443
104b3aa08: 94c3b1cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3aa0c: aa1803e0    	mov	x0, x24
104b3aa10: 94c3b1d1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3aa14: f00d9888    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
104b3aa18: f9448901    	ldr	x1, [x8, #0x910] ; StartUploadAppMsg:MsgWrap:Scene:
104b3aa1c: aa1703e0    	mov	x0, x23
104b3aa20: aa1303e2    	mov	x2, x19
104b3aa24: aa1403e3    	mov	x3, x20
104b3aa28: aa1c03e4    	mov	x4, x28
104b3aa2c: 94c3b1c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3aa30: aa1503e0    	mov	x0, x21
104b3aa34: 94c3b1c8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3aa38: aa1403e0    	mov	x0, x20
104b3aa3c: 94c3b1c6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3aa40: aa1303e0    	mov	x0, x19
104b3aa44: 94c3b1c4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3aa48: f85a03a8    	ldur	x8, [x29, #-0x60]
104b3aa4c: b00c55a9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104b3aa50: f9405929    	ldr	x9, [x9, #0xb0]
104b3aa54: f9400129    	ldr	x9, [x9]
104b3aa58: eb08013f    	cmp	x9, x8
104b3aa5c: 54000121    	b.ne	0x104b3aa80 <_Flutter_MMFoundation_BindContext+0x1016664>
104b3aa60: 910803ff    	add	sp, sp, #0x200
104b3aa64: a9457bfd    	ldp	x29, x30, [sp, #0x50]
104b3aa68: a9444ff4    	ldp	x20, x19, [sp, #0x40]
104b3aa6c: a94357f6    	ldp	x22, x21, [sp, #0x30]
104b3aa70: a9425ff8    	ldp	x24, x23, [sp, #0x20]
104b3aa74: a94167fa    	ldp	x26, x25, [sp, #0x10]
104b3aa78: a8c66ffc    	ldp	x28, x27, [sp], #0x60
104b3aa7c: d65f03c0    	ret
104b3aa80: 94c3b1bd    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>