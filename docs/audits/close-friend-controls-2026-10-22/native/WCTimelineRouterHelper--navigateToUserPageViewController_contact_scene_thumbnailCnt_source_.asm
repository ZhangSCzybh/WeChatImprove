
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a1658ec: d102c3ff    	sub	sp, sp, #0xb0
10a1658f0: 6d0423e9    	stp	d9, d8, [sp, #0x40]
10a1658f4: a9056ffc    	stp	x28, x27, [sp, #0x50]
10a1658f8: a90667fa    	stp	x26, x25, [sp, #0x60]
10a1658fc: a9075ff8    	stp	x24, x23, [sp, #0x70]
10a165900: a90857f6    	stp	x22, x21, [sp, #0x80]
10a165904: a9094ff4    	stp	x20, x19, [sp, #0x90]
10a165908: a90a7bfd    	stp	x29, x30, [sp, #0xa0]
10a16590c: 910283fd    	add	x29, sp, #0xa0
10a165910: aa0603f5    	mov	x21, x6
10a165914: aa0503f6    	mov	x22, x5
10a165918: aa0403f7    	mov	x23, x4
10a16591c: aa0303f4    	mov	x20, x3
10a165920: aa0203f3    	mov	x19, x2
10a165924: 900b5768    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a165928: 52800029    	mov	w9, #0x1                ; =1
10a16592c: 391c1109    	strb	w9, [x8, #0x704]
10a165930: aa0203e0    	mov	x0, x2
10a165934: 955bd6c3    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a165938: aa1403e0    	mov	x0, x20
10a16593c: 955bd6c1    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a165940: d00b0068    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a165944: f945e918    	ldr	x24, [x8, #0xbd0]
10a165948: f00afcc8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a16594c: f944e919    	ldr	x25, [x8, #0x9d0] ; currentContext
10a165950: aa1503e0    	mov	x0, x21
10a165954: 955bd6bb    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a165958: aa1803e0    	mov	x0, x24
10a16595c: aa1903e1    	mov	x1, x25
10a165960: 955bd6b9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165964: aa1d03fd    	mov	x29, x29
10a165968: 955bd6ba    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a16596c: aa0003f8    	mov	x24, x0
10a165970: b00b0088    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
10a165974: f946d100    	ldr	x0, [x8, #0xda0] ;  h>
10a165978: d00afcc8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a16597c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10a165980: 955bd6b1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165984: aa0003e2    	mov	x2, x0
10a165988: 900ae6a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a16598c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10a165990: aa1803e0    	mov	x0, x24
10a165994: 955bd6ac    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165998: aa1d03fd    	mov	x29, x29
10a16599c: 955bd6ad    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a1659a0: aa0003f9    	mov	x25, x0
10a1659a4: d00af4c8    	adrp	x8, 0x11ffff000 <dyld_stub_binder+0x11ffff000>
10a1659a8: f9443101    	ldr	x1, [x8, #0x860] ; Moments_enableFlutterUserPage
10a1659ac: 955bd6a6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1659b0: aa0003fa    	mov	x26, x0
10a1659b4: aa1903e0    	mov	x0, x25
10a1659b8: 955bd6a9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1659bc: aa1803e0    	mov	x0, x24
10a1659c0: 955bd6a7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1659c4: 340014fa    	cbz	w26, 0x10a165c60 <_Flutter_MMFoundation_BindContext+0x6641844>
10a1659c8: d00ae6a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a1659cc: f9434d16    	ldr	x22, [x8, #0x698] ; m_nsUsrName
10a1659d0: aa1403e0    	mov	x0, x20
10a1659d4: aa1603e1    	mov	x1, x22
10a1659d8: 955bd69b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1659dc: aa1d03fd    	mov	x29, x29
10a1659e0: 955bd69c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a1659e4: aa0003f7    	mov	x23, x0
10a1659e8: b00afce8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10a1659ec: f9445901    	ldr	x1, [x8, #0x8b0] ; hasSuffix:
10a1659f0: b00a2322    	adrp	x2, 0x11e5ca000 <dyld_stub_binder+0x11e5ca000>
10a1659f4: 9110a042    	add	x2, x2, #0x428
10a1659f8: 955bd693    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1659fc: aa0003f8    	mov	x24, x0
10a165a00: aa1703e0    	mov	x0, x23
10a165a04: 955bd696    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165a08: 34000358    	cbz	w24, 0x10a165a70 <_Flutter_MMFoundation_BindContext+0x6641654>
10a165a0c: 900b00e8    	adrp	x8, 0x120181000 <dyld_stub_binder+0x120181000>
10a165a10: f9420d17    	ldr	x23, [x8, #0x418]
10a165a14: d00ae6a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a165a18: f9435101    	ldr	x1, [x8, #0x6a0] ; m_nsNickName
10a165a1c: aa1403e0    	mov	x0, x20
10a165a20: 955bd689    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165a24: aa1d03fd    	mov	x29, x29
10a165a28: 955bd68a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a165a2c: aa0003f8    	mov	x24, x0
10a165a30: aa1403e0    	mov	x0, x20
10a165a34: aa1603e1    	mov	x1, x22
10a165a38: 955bd683    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165a3c: aa1d03fd    	mov	x29, x29
10a165a40: 955bd684    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a165a44: aa0003f6    	mov	x22, x0
10a165a48: d00af9a8    	adrp	x8, 0x12009b000 <dyld_stub_binder+0x12009b000>
10a165a4c: f941c901    	ldr	x1, [x8, #0x390] ; setNickname:forUsername:
10a165a50: aa1703e0    	mov	x0, x23
10a165a54: aa1803e2    	mov	x2, x24
10a165a58: aa1603e3    	mov	x3, x22
10a165a5c: 955bd67a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165a60: aa1603e0    	mov	x0, x22
10a165a64: 955bd67e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165a68: aa1803e0    	mov	x0, x24
10a165a6c: 955bd67c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165a70: 900b00e8    	adrp	x8, 0x120181000 <dyld_stub_binder+0x120181000>
10a165a74: f9414900    	ldr	x0, [x8, #0x290]
10a165a78: b00afd28    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10a165a7c: f9436d16    	ldr	x22, [x8, #0x6d8] ; shareInstance
10a165a80: aa1603e1    	mov	x1, x22
10a165a84: 955bd670    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165a88: aa1d03fd    	mov	x29, x29
10a165a8c: 955bd671    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a165a90: aa0003f7    	mov	x23, x0
10a165a94: d00b0068    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a165a98: f9471100    	ldr	x0, [x8, #0xe20]
10a165a9c: 900ae6c8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10a165aa0: f9459901    	ldr	x1, [x8, #0xb30] ; getCurUsrName
10a165aa4: 955bd668    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165aa8: aa1d03fd    	mov	x29, x29
10a165aac: 955bd669    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a165ab0: aa0003f8    	mov	x24, x0
10a165ab4: d00b007b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
10a165ab8: f946cf60    	ldr	x0, [x27, #0xd98]
10a165abc: b00af808    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
10a165ac0: f9401d01    	ldr	x1, [x8, #0x38] ; getUserWCDBRootDir
10a165ac4: 955bd660    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165ac8: aa1d03fd    	mov	x29, x29
10a165acc: 955bd661    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a165ad0: aa0003f9    	mov	x25, x0
10a165ad4: b00afd28    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10a165ad8: f9465101    	ldr	x1, [x8, #0xca0] ; stringByAppendingPathComponent:
10a165adc: f00a46e2    	adrp	x2, 0x11ea44000 <dyld_stub_binder+0x11ea44000>
10a165ae0: 91312042    	add	x2, x2, #0xc48
10a165ae4: 955bd658    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165ae8: aa1d03fd    	mov	x29, x29
10a165aec: 955bd659    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a165af0: aa0003fa    	mov	x26, x0
10a165af4: f946cf60    	ldr	x0, [x27, #0xd98]
10a165af8: f00aeaa8    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
10a165afc: f9426101    	ldr	x1, [x8, #0x4c0] ; getSnsFlutterPublishPath
10a165b00: 955bd651    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165b04: aa1d03fd    	mov	x29, x29
10a165b08: 955bd652    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a165b0c: aa0003fb    	mov	x27, x0
10a165b10: d00af9a8    	adrp	x8, 0x12009b000 <dyld_stub_binder+0x12009b000>
10a165b14: f941cd01    	ldr	x1, [x8, #0x398] ; setUp:dbPath:publishPath:
10a165b18: aa1703e0    	mov	x0, x23
10a165b1c: aa1803e2    	mov	x2, x24
10a165b20: aa1a03e3    	mov	x3, x26
10a165b24: aa1b03e4    	mov	x4, x27
10a165b28: 955bd647    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165b2c: aa1d03fd    	mov	x29, x29
10a165b30: 955bd64f    	bl	0x10f85b46c <_UR_96F1_B25D+0x3a640dc>
10a165b34: aa1b03e0    	mov	x0, x27
10a165b38: 955bd649    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165b3c: aa1a03e0    	mov	x0, x26
10a165b40: 955bd647    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165b44: aa1903e0    	mov	x0, x25
10a165b48: 955bd645    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165b4c: aa1803e0    	mov	x0, x24
10a165b50: 955bd643    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165b54: aa1703e0    	mov	x0, x23
10a165b58: 955bd641    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165b5c: f00b01a8    	adrp	x8, 0x12019c000 <dyld_stub_binder+0x12019c000>
10a165b60: f944f500    	ldr	x0, [x8, #0x9e8]
10a165b64: aa1603e1    	mov	x1, x22
10a165b68: 955bd637    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165b6c: aa1d03fd    	mov	x29, x29
10a165b70: 955bd638    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a165b74: aa0003f6    	mov	x22, x0
10a165b78: f00aeb08    	adrp	x8, 0x11fec8000 <dyld_stub_binder+0x11fec8000>
10a165b7c: f944d901    	ldr	x1, [x8, #0x9b0] ; setUp
10a165b80: 955bd631    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165b84: aa1603e0    	mov	x0, x22
10a165b88: 955bd635    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165b8c: 900b00e8    	adrp	x8, 0x120181000 <dyld_stub_binder+0x120181000>
10a165b90: f9415500    	ldr	x0, [x8, #0x2a8]
10a165b94: 955bd635    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
10a165b98: d00af9a8    	adrp	x8, 0x12009b000 <dyld_stub_binder+0x12009b000>
10a165b9c: f941d101    	ldr	x1, [x8, #0x3a0] ; initWithContact:source:
10a165ba0: aa1403e2    	mov	x2, x20
10a165ba4: aa1503e3    	mov	x3, x21
10a165ba8: 955bd627    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165bac: aa0003f6    	mov	x22, x0
10a165bb0: aa1503e0    	mov	x0, x21
10a165bb4: 955bd62a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165bb8: d00b0068    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a165bbc: f9457100    	ldr	x0, [x8, #0xae0]
10a165bc0: f00afcc8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a165bc4: f9460d01    	ldr	x1, [x8, #0xc18] ; date
10a165bc8: 955bd61f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165bcc: aa1d03fd    	mov	x29, x29
10a165bd0: 955bd620    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a165bd4: aa0003f5    	mov	x21, x0
10a165bd8: d00afd28    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10a165bdc: f940a901    	ldr	x1, [x8, #0x150] ; timeIntervalSince1970
10a165be0: 955bd619    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165be4: 1e604008    	fmov	d8, d0
10a165be8: aa1503e0    	mov	x0, x21
10a165bec: 955bd61c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165bf0: b009a448    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10a165bf4: f947e108    	ldr	x8, [x8, #0xfc0]
10a165bf8: f90007e8    	str	x8, [sp, #0x8]
10a165bfc: 900760e8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10a165c00: fd41c100    	ldr	d0, [x8, #0x380]
10a165c04: 90000008    	adrp	x8, 0x10a165000 <_Flutter_MMFoundation_BindContext+0x6640be4>
10a165c08: 9134e108    	add	x8, x8, #0xd38
10a165c0c: fd000be0    	str	d0, [sp, #0x10]
10a165c10: b009a489    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
10a165c14: 91338129    	add	x9, x9, #0xce0
10a165c18: a901a7e8    	stp	x8, x9, [sp, #0x18]
10a165c1c: fd001fe8    	str	d8, [sp, #0x38]
10a165c20: aa1303e0    	mov	x0, x19
10a165c24: 955bd607    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a165c28: a902dbf3    	stp	x19, x22, [sp, #0x28]
10a165c2c: b00ae708    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
10a165c30: f941f915    	ldr	x21, [x8, #0x3f0] ; requestPreRender:
10a165c34: aa1603e0    	mov	x0, x22
10a165c38: 955bd602    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a165c3c: 910023e2    	add	x2, sp, #0x8
10a165c40: aa1503e1    	mov	x1, x21
10a165c44: 955bd600    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165c48: f9401be0    	ldr	x0, [sp, #0x30]
10a165c4c: 955bd604    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165c50: f94017e0    	ldr	x0, [sp, #0x28]
10a165c54: 955bd602    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165c58: aa1603e0    	mov	x0, x22
10a165c5c: 14000029    	b	0x10a165d00 <_Flutter_MMFoundation_BindContext+0x66418e4>
10a165c60: d00b0168    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
10a165c64: f9439d00    	ldr	x0, [x8, #0x738]
10a165c68: 955bd5fe    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a165c6c: aa0003f8    	mov	x24, x0
10a165c70: d00ae6a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a165c74: f946dd01    	ldr	x1, [x8, #0xdb8] ; setM_contact:
10a165c78: aa1403e2    	mov	x2, x20
10a165c7c: 955bd5f2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165c80: 900ae828    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
10a165c84: f9405d01    	ldr	x1, [x8, #0xb8] ; setSourceScene:
10a165c88: aa1803e0    	mov	x0, x24
10a165c8c: aa1703e2    	mov	x2, x23
10a165c90: 955bd5ed    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165c94: d00af808    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
10a165c98: f9436901    	ldr	x1, [x8, #0x6d0] ; setAlbumEntranceThumbnailCnt:
10a165c9c: aa1803e0    	mov	x0, x24
10a165ca0: aa1603e2    	mov	x2, x22
10a165ca4: 955bd5e8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165ca8: d00af808    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
10a165cac: f9438101    	ldr	x1, [x8, #0x700] ; setSnsChannel:
10a165cb0: aa1803e0    	mov	x0, x24
10a165cb4: aa1503e2    	mov	x2, x21
10a165cb8: 955bd5e3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165cbc: aa1503e0    	mov	x0, x21
10a165cc0: 955bd5e7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165cc4: f00afce8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10a165cc8: f945dd01    	ldr	x1, [x8, #0xbb8] ; navigationController
10a165ccc: aa1303e0    	mov	x0, x19
10a165cd0: 955bd5dd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165cd4: aa1d03fd    	mov	x29, x29
10a165cd8: 955bd5de    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a165cdc: aa0003f5    	mov	x21, x0
10a165ce0: d00ae6a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a165ce4: f944e101    	ldr	x1, [x8, #0x9c0] ; PushViewController:animated:
10a165ce8: aa1803e2    	mov	x2, x24
10a165cec: 52800023    	mov	w3, #0x1                ; =1
10a165cf0: 955bd5d5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165cf4: aa1503e0    	mov	x0, x21
10a165cf8: 955bd5d9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165cfc: aa1803e0    	mov	x0, x24
10a165d00: 955bd5d7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165d04: aa1403e0    	mov	x0, x20
10a165d08: 955bd5d5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165d0c: aa1303e0    	mov	x0, x19
10a165d10: 955bd5d3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165d14: a94a7bfd    	ldp	x29, x30, [sp, #0xa0]
10a165d18: a9494ff4    	ldp	x20, x19, [sp, #0x90]
10a165d1c: a94857f6    	ldp	x22, x21, [sp, #0x80]
10a165d20: a9475ff8    	ldp	x24, x23, [sp, #0x70]
10a165d24: a94667fa    	ldp	x26, x25, [sp, #0x60]
10a165d28: a9456ffc    	ldp	x28, x27, [sp, #0x50]
10a165d2c: 6d4423e9    	ldp	d9, d8, [sp, #0x40]
10a165d30: 9102c3ff    	add	sp, sp, #0xb0
10a165d34: d65f03c0    	ret
