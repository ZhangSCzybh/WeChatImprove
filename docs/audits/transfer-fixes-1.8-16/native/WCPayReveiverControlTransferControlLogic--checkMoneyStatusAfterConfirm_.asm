
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10999a378: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
10999a37c: a90157f6    	stp	x22, x21, [sp, #0x10]
10999a380: a9024ff4    	stp	x20, x19, [sp, #0x20]
10999a384: a9037bfd    	stp	x29, x30, [sp, #0x30]
10999a388: 9100c3fd    	add	x29, sp, #0x30
10999a38c: aa0203f3    	mov	x19, x2
10999a390: aa0003f4    	mov	x20, x0
10999a394: b00b95a8    	adrp	x8, 0x120c4f000 <dyld_stub_binder+0x120c4f000>
10999a398: 52800029    	mov	w9, #0x1                ; =1
10999a39c: 39359509    	strb	w9, [x8, #0xd65]
10999a3a0: aa0203e0    	mov	x0, x2
10999a3a4: 957b0427    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10999a3a8: 900b3b88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10999a3ac: f9452101    	ldr	x1, [x8, #0xa40] ; startLoading
10999a3b0: aa1403e0    	mov	x0, x20
10999a3b4: 957b0424    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a3b8: d00b4677    	adrp	x23, 0x120268000 <dyld_stub_binder+0x120268000>
10999a3bc: 912642f7    	add	x23, x23, #0x990
10999a3c0: b4000473    	cbz	x19, 0x10999a44c <_Flutter_MMFoundation_BindContext+0x5e76030>
10999a3c4: b98002f8    	ldrsw	x24, [x23]
10999a3c8: f8786a80    	ldr	x0, [x20, x24]
10999a3cc: d00b32c8    	adrp	x8, 0x11fff4000 <dyld_stub_binder+0x11fff4000>
10999a3d0: f9456d15    	ldr	x21, [x8, #0xad8] ; m_structAuthenticationPayStatus
10999a3d4: aa1503e1    	mov	x1, x21
10999a3d8: 957b041b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a3dc: aa1d03fd    	mov	x29, x29
10999a3e0: 957b041c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10999a3e4: aa0003f6    	mov	x22, x0
10999a3e8: 957b041d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10999a3ec: b5000196    	cbnz	x22, 0x10999a41c <_Flutter_MMFoundation_BindContext+0x5e76000>
10999a3f0: f00b4068    	adrp	x8, 0x1201a9000 <dyld_stub_binder+0x1201a9000>
10999a3f4: f9422500    	ldr	x0, [x8, #0x448] ; ��D 
10999a3f8: 957b041a    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10999a3fc: aa0003f6    	mov	x22, x0
10999a400: f8786a80    	ldr	x0, [x20, x24]
10999a404: d00b3748    	adrp	x8, 0x120084000 <dyld_stub_binder+0x120084000>
10999a408: f943cd01    	ldr	x1, [x8, #0x798] ; setM_structAuthenticationPayStatus:
10999a40c: aa1603e2    	mov	x2, x22
10999a410: 957b040d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a414: aa1603e0    	mov	x0, x22
10999a418: 957b0411    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10999a41c: f8786a80    	ldr	x0, [x20, x24]
10999a420: aa1503e1    	mov	x1, x21
10999a424: 957b0408    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a428: aa1d03fd    	mov	x29, x29
10999a42c: 957b0409    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10999a430: aa0003f5    	mov	x21, x0
10999a434: 900b3368    	adrp	x8, 0x120006000 <dyld_stub_binder+0x120006000>
10999a438: f9478501    	ldr	x1, [x8, #0xf08] ; setRealnameGuideInfo:
10999a43c: aa1303e2    	mov	x2, x19
10999a440: 957b0401    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a444: aa1503e0    	mov	x0, x21
10999a448: 957b0405    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10999a44c: 900b3768    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
10999a450: f945b901    	ldr	x1, [x8, #0xb70] ; bIsOpenIM
10999a454: aa1403e0    	mov	x0, x20
10999a458: 957b03fb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a45c: 340007a0    	cbz	w0, 0x10999a550 <_Flutter_MMFoundation_BindContext+0x5e76134>
10999a460: f00b4068    	adrp	x8, 0x1201a9000 <dyld_stub_binder+0x1201a9000>
10999a464: f947f100    	ldr	x0, [x8, #0xfe0]
10999a468: 957b03fe    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10999a46c: aa0003f5    	mov	x21, x0
10999a470: b98002f7    	ldrsw	x23, [x23]
10999a474: f8776a80    	ldr	x0, [x20, x23]
10999a478: f00b2588    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
10999a47c: f9409901    	ldr	x1, [x8, #0x130] ; m_nsTransferID
10999a480: 957b03f1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a484: aa1d03fd    	mov	x29, x29
10999a488: 957b03f2    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10999a48c: aa0003f6    	mov	x22, x0
10999a490: 900b3728    	adrp	x8, 0x12007e000 <dyld_stub_binder+0x12007e000>
10999a494: f9478901    	ldr	x1, [x8, #0xf10] ; setTransferId:
10999a498: aa1503e0    	mov	x0, x21
10999a49c: aa1603e2    	mov	x2, x22
10999a4a0: 957b03e9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a4a4: aa1603e0    	mov	x0, x22
10999a4a8: 957b03ed    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10999a4ac: f8776a80    	ldr	x0, [x20, x23]
10999a4b0: f00b29a8    	adrp	x8, 0x11fed1000 <dyld_stub_binder+0x11fed1000>
10999a4b4: f941dd01    	ldr	x1, [x8, #0x3b8] ; selectedTransferChatroomUsername
10999a4b8: 957b03e3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a4bc: aa1d03fd    	mov	x29, x29
10999a4c0: 957b03e4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10999a4c4: aa0003f6    	mov	x22, x0
10999a4c8: f00b26c8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
10999a4cc: f942a901    	ldr	x1, [x8, #0x550] ; setRoomid:
10999a4d0: aa1503e0    	mov	x0, x21
10999a4d4: aa1603e2    	mov	x2, x22
10999a4d8: 957b03db    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a4dc: aa1603e0    	mov	x0, x22
10999a4e0: 957b03df    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10999a4e4: f00b4068    	adrp	x8, 0x1201a9000 <dyld_stub_binder+0x1201a9000>
10999a4e8: f947f500    	ldr	x0, [x8, #0xfe8] ; 0GE 
10999a4ec: 957b03df    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
10999a4f0: d00b2508    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10999a4f4: f942a101    	ldr	x1, [x8, #0x540] ; initWithDelegate:
10999a4f8: aa1403e2    	mov	x2, x20
10999a4fc: 957b03d2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a500: aa0003f6    	mov	x22, x0
10999a504: 900b3768    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
10999a508: f945bd01    	ldr	x1, [x8, #0xb78] ; setUnionQueryCgi:
10999a50c: aa1403e0    	mov	x0, x20
10999a510: aa1603e2    	mov	x2, x22
10999a514: 957b03cc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a518: aa1603e0    	mov	x0, x22
10999a51c: 957b03d0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10999a520: 900b3768    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
10999a524: f945c101    	ldr	x1, [x8, #0xb80] ; unionQueryCgi
10999a528: aa1403e0    	mov	x0, x20
10999a52c: 957b03c6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a530: aa1d03fd    	mov	x29, x29
10999a534: 957b03c7    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10999a538: aa0003f4    	mov	x20, x0
10999a53c: f00b2888    	adrp	x8, 0x11fead000 <dyld_stub_binder+0x11fead000>
10999a540: f946fd01    	ldr	x1, [x8, #0xdf8] ; startWithRequest:
10999a544: aa1503e2    	mov	x2, x21
10999a548: 957b03bf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a54c: 14000062    	b	0x10999a6d4 <_Flutter_MMFoundation_BindContext+0x5e762b8>
10999a550: f00b4068    	adrp	x8, 0x1201a9000 <dyld_stub_binder+0x1201a9000>
10999a554: f947f900    	ldr	x0, [x8, #0xff0] ; (�D 
10999a558: 957b03c2    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10999a55c: aa0003f5    	mov	x21, x0
10999a560: b98002f7    	ldrsw	x23, [x23]
10999a564: f8776a80    	ldr	x0, [x20, x23]
10999a568: f00b2588    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
10999a56c: f9409901    	ldr	x1, [x8, #0x130] ; m_nsTransferID
10999a570: 957b03b5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a574: aa1d03fd    	mov	x29, x29
10999a578: 957b03b6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10999a57c: aa0003f6    	mov	x22, x0
10999a580: f00b2588    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
10999a584: f9409d01    	ldr	x1, [x8, #0x138] ; setM_nsTransferID:
10999a588: aa1503e0    	mov	x0, x21
10999a58c: aa1603e2    	mov	x2, x22
10999a590: 957b03ad    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a594: aa1603e0    	mov	x0, x22
10999a598: 957b03b1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10999a59c: f8776a80    	ldr	x0, [x20, x23]
10999a5a0: 900b3768    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
10999a5a4: f9459d01    	ldr	x1, [x8, #0xb38] ; m_nsCurrentUserName
10999a5a8: 957b03a7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a5ac: aa1d03fd    	mov	x29, x29
10999a5b0: 957b03a8    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10999a5b4: aa0003f6    	mov	x22, x0
10999a5b8: b00b3308    	adrp	x8, 0x11fffb000 <dyld_stub_binder+0x11fffb000>
10999a5bc: f9426101    	ldr	x1, [x8, #0x4c0] ; setM_nsFromUserName:
10999a5c0: aa1503e0    	mov	x0, x21
10999a5c4: aa1603e2    	mov	x2, x22
10999a5c8: 957b039f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a5cc: aa1603e0    	mov	x0, x22
10999a5d0: 957b03a3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10999a5d4: f8776a80    	ldr	x0, [x20, x23]
10999a5d8: 900b3768    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
10999a5dc: f945a101    	ldr	x1, [x8, #0xb40] ; m_uiTransferInvalidTime
10999a5e0: 957b0399    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a5e4: aa0003e2    	mov	x2, x0
10999a5e8: 900b3708    	adrp	x8, 0x12007a000 <dyld_stub_binder+0x12007a000>
10999a5ec: f943c101    	ldr	x1, [x8, #0x780] ; setM_uiInvalidTime:
10999a5f0: aa1503e0    	mov	x0, x21
10999a5f4: 957b0394    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a5f8: f8776a80    	ldr	x0, [x20, x23]
10999a5fc: 900b3768    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
10999a600: f9459901    	ldr	x1, [x8, #0xb30] ; m_nsControlTransationID
10999a604: 957b0390    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a608: aa1d03fd    	mov	x29, x29
10999a60c: 957b0391    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10999a610: aa0003f6    	mov	x22, x0
10999a614: 900b3728    	adrp	x8, 0x12007e000 <dyld_stub_binder+0x12007e000>
10999a618: f9438d01    	ldr	x1, [x8, #0x718] ; setM_nsTransactionID:
10999a61c: aa1503e0    	mov	x0, x21
10999a620: aa1603e2    	mov	x2, x22
10999a624: 957b0388    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a628: aa1603e0    	mov	x0, x22
10999a62c: 957b038c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10999a630: f8776a80    	ldr	x0, [x20, x23]
10999a634: b00b3728    	adrp	x8, 0x12007f000 <dyld_stub_binder+0x12007f000>
10999a638: f9454901    	ldr	x1, [x8, #0xa90] ; m_nsTransferAttach
10999a63c: 957b0382    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a640: aa1d03fd    	mov	x29, x29
10999a644: 957b0383    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10999a648: aa0003f4    	mov	x20, x0
10999a64c: f00b2588    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
10999a650: f940e101    	ldr	x1, [x8, #0x1c0] ; setM_nsTransferAttach:
10999a654: aa1503e0    	mov	x0, x21
10999a658: aa1403e2    	mov	x2, x20
10999a65c: 957b037a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a660: aa1403e0    	mov	x0, x20
10999a664: 957b037e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10999a668: b00b3ec8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10999a66c: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
10999a670: d00b3b28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10999a674: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10999a678: 957b0373    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a67c: aa1d03fd    	mov	x29, x29
10999a680: 957b0374    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10999a684: aa0003f4    	mov	x20, x0
10999a688: 900b3ee8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
10999a68c: f943bd00    	ldr	x0, [x8, #0x778] ; ��D 
10999a690: b00b3b28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10999a694: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10999a698: 957b036b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a69c: aa0003e2    	mov	x2, x0
10999a6a0: f00b24e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10999a6a4: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10999a6a8: aa1403e0    	mov	x0, x20
10999a6ac: 957b0366    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a6b0: aa1d03fd    	mov	x29, x29
10999a6b4: 957b0367    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10999a6b8: aa0003f6    	mov	x22, x0
10999a6bc: 900b3768    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
10999a6c0: f945c901    	ldr	x1, [x8, #0xb90] ; CheckTransferMoneyStatus:
10999a6c4: aa1503e2    	mov	x2, x21
10999a6c8: 957b035f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999a6cc: aa1603e0    	mov	x0, x22
10999a6d0: 957b0363    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10999a6d4: aa1403e0    	mov	x0, x20
10999a6d8: 957b0361    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10999a6dc: aa1503e0    	mov	x0, x21
10999a6e0: 957b035f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10999a6e4: aa1303e0    	mov	x0, x19
10999a6e8: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10999a6ec: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10999a6f0: a94157f6    	ldp	x22, x21, [sp, #0x10]
10999a6f4: a8c45ff8    	ldp	x24, x23, [sp], #0x40
10999a6f8: 157b0359    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>