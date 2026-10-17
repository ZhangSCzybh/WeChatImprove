
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101c35880: d104c3ff    	sub	sp, sp, #0x130
101c35884: a90d6ffc    	stp	x28, x27, [sp, #0xd0]
101c35888: a90e67fa    	stp	x26, x25, [sp, #0xe0]
101c3588c: a90f5ff8    	stp	x24, x23, [sp, #0xf0]
101c35890: a91057f6    	stp	x22, x21, [sp, #0x100]
101c35894: a9114ff4    	stp	x20, x19, [sp, #0x110]
101c35898: a9127bfd    	stp	x29, x30, [sp, #0x120]
101c3589c: 910483fd    	add	x29, sp, #0x120
101c358a0: aa0003f3    	mov	x19, x0
101c358a4: d00dcdc8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
101c358a8: f9405908    	ldr	x8, [x8, #0xb0]
101c358ac: f9400108    	ldr	x8, [x8]
101c358b0: f81a03a8    	stur	x8, [x29, #-0x60]
101c358b4: d00f7fe8    	adrp	x8, 0x120c33000 <dyld_stub_binder+0x120c33000>
101c358b8: 52800029    	mov	w9, #0x1                ; =1
101c358bc: 39260d09    	strb	w9, [x8, #0x983]
101c358c0: d00f29fb    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
101c358c4: f945eb60    	ldr	x0, [x27, #0xbd0] ; ��d 
101c358c8: f00f2648    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101c358cc: f944e914    	ldr	x20, [x8, #0x9d0] ; currentContext
101c358d0: aa1403e1    	mov	x1, x20
101c358d4: 957fc61a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c358d8: aa1d03fd    	mov	x29, x29
101c358dc: 957fc61b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c358e0: aa0003f5    	mov	x21, x0
101c358e4: f00f29c8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
101c358e8: f9457102    	ldr	x2, [x8, #0xae0]
101c358ec: b00f1028    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
101c358f0: f944a101    	ldr	x1, [x8, #0x940] ; unRegisterExtension:withTarget:
101c358f4: aa1303e3    	mov	x3, x19
101c358f8: 957fc611    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c358fc: aa1503e0    	mov	x0, x21
101c35900: 957fc615    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c35904: f00f1428    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c35908: f946c101    	ldr	x1, [x8, #0xd80] ; restoreMsgListsFromConvertBackupIfNeeded
101c3590c: aa1303e0    	mov	x0, x19
101c35910: 957fc60b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c35914: 4f00e400    	movi.16b	v0, #0x0
101c35918: ad0103e0    	stp	q0, q0, [sp, #0x20]
101c3591c: ad0003e0    	stp	q0, q0, [sp]
101c35920: f00f2de8    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c35924: b988f908    	ldrsw	x8, [x8, #0x8f8]
101c35928: f8686a75    	ldr	x21, [x19, x8]
101c3592c: aa1503e0    	mov	x0, x21
101c35930: 957fc602    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c35934: f00f2648    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101c35938: f9435516    	ldr	x22, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
101c3593c: 910003e2    	mov	x2, sp
101c35940: 910103e3    	add	x3, sp, #0x40
101c35944: aa1603e1    	mov	x1, x22
101c35948: 52800204    	mov	w4, #0x10               ; =16
101c3594c: 957fc5fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c35950: b40003c0    	cbz	x0, 0x101c359c8 <_Flutter_Image_provideRelativePathByUrl+0x42878>
101c35954: aa0003f7    	mov	x23, x0
101c35958: f9400be8    	ldr	x8, [sp, #0x10]
101c3595c: f9400119    	ldr	x25, [x8]
101c35960: f00f143a    	adrp	x26, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c35964: d280001c    	mov	x28, #0x0               ; =0
101c35968: f9477f58    	ldr	x24, [x26, #0xef8] ; reportUrlMsgInfoWithMsgWrap:actionRet:
101c3596c: f9400be8    	ldr	x8, [sp, #0x10]
101c35970: f9400108    	ldr	x8, [x8]
101c35974: eb19011f    	cmp	x8, x25
101c35978: 54000060    	b.eq	0x101c35984 <_Flutter_Image_provideRelativePathByUrl+0x42834>
101c3597c: aa1503e0    	mov	x0, x21
101c35980: 957fc5f4    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
101c35984: f94007e8    	ldr	x8, [sp, #0x8]
101c35988: f87c7902    	ldr	x2, [x8, x28, lsl #3]
101c3598c: aa1303e0    	mov	x0, x19
101c35990: aa1803e1    	mov	x1, x24
101c35994: 52800003    	mov	w3, #0x0                ; =0
101c35998: 957fc5e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3599c: 9100079c    	add	x28, x28, #0x1
101c359a0: eb1c02ff    	cmp	x23, x28
101c359a4: 54fffe41    	b.ne	0x101c3596c <_Flutter_Image_provideRelativePathByUrl+0x4281c>
101c359a8: 910003e2    	mov	x2, sp
101c359ac: 910103e3    	add	x3, sp, #0x40
101c359b0: aa1503e0    	mov	x0, x21
101c359b4: aa1603e1    	mov	x1, x22
101c359b8: 52800204    	mov	w4, #0x10               ; =16
101c359bc: 957fc5e0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c359c0: aa0003f7    	mov	x23, x0
101c359c4: b5fffd00    	cbnz	x0, 0x101c35964 <_Flutter_Image_provideRelativePathByUrl+0x42814>
101c359c8: aa1503e0    	mov	x0, x21
101c359cc: 957fc5e2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c359d0: f945eb60    	ldr	x0, [x27, #0xbd0] ; ��d 
101c359d4: aa1403e1    	mov	x1, x20
101c359d8: 957fc5d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c359dc: aa1d03fd    	mov	x29, x29
101c359e0: 957fc5da    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c359e4: aa0003f7    	mov	x23, x0
101c359e8: 900f2a68    	adrp	x8, 0x120181000 <dyld_stub_binder+0x120181000>
101c359ec: f9426500    	ldr	x0, [x8, #0x4c8] ; �}. 
101c359f0: d00f2648    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101c359f4: f947ad15    	ldr	x21, [x8, #0xf58] ; class
101c359f8: aa1503e1    	mov	x1, x21
101c359fc: 957fc5d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c35a00: aa0003e2    	mov	x2, x0
101c35a04: 900f1028    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101c35a08: f9464116    	ldr	x22, [x8, #0xc80] ; getService:
101c35a0c: aa1703e0    	mov	x0, x23
101c35a10: aa1603e1    	mov	x1, x22
101c35a14: 957fc5ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c35a18: aa1d03fd    	mov	x29, x29
101c35a1c: 957fc5cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c35a20: aa0003f8    	mov	x24, x0
101c35a24: f00f1428    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c35a28: f946a901    	ldr	x1, [x8, #0xd50] ; popSession
101c35a2c: 957fc5c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c35a30: aa1d03fd    	mov	x29, x29
101c35a34: 957fc5cc    	bl	0x107c27164 <_Flutter_MMFoundation_BindContext+0x4102d48>
101c35a38: aa1803e0    	mov	x0, x24
101c35a3c: 957fc5c6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c35a40: aa1703e0    	mov	x0, x23
101c35a44: 957fc5c4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c35a48: f945eb60    	ldr	x0, [x27, #0xbd0] ; ��d 
101c35a4c: aa1403e1    	mov	x1, x20
101c35a50: 957fc5bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c35a54: aa1d03fd    	mov	x29, x29
101c35a58: 957fc5bc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c35a5c: aa0003f7    	mov	x23, x0
101c35a60: d00f2a48    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
101c35a64: f9464500    	ldr	x0, [x8, #0xc88] ; h67 
101c35a68: aa1503e1    	mov	x1, x21
101c35a6c: 957fc5b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c35a70: aa0003e2    	mov	x2, x0
101c35a74: aa1703e0    	mov	x0, x23
101c35a78: aa1603e1    	mov	x1, x22
101c35a7c: 957fc5b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c35a80: aa1d03fd    	mov	x29, x29
101c35a84: 957fc5b1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c35a88: aa0003f8    	mov	x24, x0
101c35a8c: f00f1428    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c35a90: f9478101    	ldr	x1, [x8, #0xf00] ; setM_iMenuActionRet:
101c35a94: 52800062    	mov	w2, #0x3                ; =3
101c35a98: 957fc5a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c35a9c: aa1803e0    	mov	x0, x24
101c35aa0: 957fc5ad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c35aa4: aa1703e0    	mov	x0, x23
101c35aa8: 957fc5ab    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c35aac: f00f2de8    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c35ab0: b989251c    	ldrsw	x28, [x8, #0x924]
101c35ab4: 8b1c0260    	add	x0, x19, x28
101c35ab8: 957fc5b5    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101c35abc: b4000340    	cbz	x0, 0x101c35b24 <_Flutter_Image_provideRelativePathByUrl+0x429d4>
101c35ac0: aa0003f8    	mov	x24, x0
101c35ac4: 8b1c0260    	add	x0, x19, x28
101c35ac8: 957fc5b1    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101c35acc: aa0003f9    	mov	x25, x0
101c35ad0: f00f1428    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c35ad4: f9478517    	ldr	x23, [x8, #0xf08] ; OnForwardMessageCancel:
101c35ad8: b00f2688    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101c35adc: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
101c35ae0: aa1703e2    	mov	x2, x23
101c35ae4: 957fc596    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c35ae8: aa0003fa    	mov	x26, x0
101c35aec: aa1903e0    	mov	x0, x25
101c35af0: 957fc599    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c35af4: aa1803e0    	mov	x0, x24
101c35af8: 957fc597    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c35afc: 3400015a    	cbz	w26, 0x101c35b24 <_Flutter_Image_provideRelativePathByUrl+0x429d4>
101c35b00: 8b1c0260    	add	x0, x19, x28
101c35b04: 957fc5a2    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101c35b08: aa0003f8    	mov	x24, x0
101c35b0c: aa1703e1    	mov	x1, x23
101c35b10: aa1303e2    	mov	x2, x19
101c35b14: 957fc58a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c35b18: aa1803e0    	mov	x0, x24
101c35b1c: 957fc58e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c35b20: 14000005    	b	0x101c35b34 <_Flutter_Image_provideRelativePathByUrl+0x429e4>
101c35b24: 900f1088    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
101c35b28: f9455901    	ldr	x1, [x8, #0xab0] ; clearData
101c35b2c: aa1303e0    	mov	x0, x19
101c35b30: 957fc583    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c35b34: f00f2de8    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c35b38: b9891508    	ldrsw	x8, [x8, #0x914]
101c35b3c: f8686a60    	ldr	x0, [x19, x8]
101c35b40: f8286a7f    	str	xzr, [x19, x8]
101c35b44: 957fc584    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c35b48: f945eb60    	ldr	x0, [x27, #0xbd0] ; ��d 
101c35b4c: aa1403e1    	mov	x1, x20
101c35b50: 957fc57b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c35b54: aa1d03fd    	mov	x29, x29
101c35b58: 957fc57c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c35b5c: aa0003f3    	mov	x19, x0
101c35b60: 900f2a68    	adrp	x8, 0x120181000 <dyld_stub_binder+0x120181000>
101c35b64: f9427d00    	ldr	x0, [x8, #0x4f8] ; H�E 
101c35b68: aa1503e1    	mov	x1, x21
101c35b6c: 957fc574    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c35b70: aa0003e2    	mov	x2, x0
101c35b74: aa1303e0    	mov	x0, x19
101c35b78: aa1603e1    	mov	x1, x22
101c35b7c: 957fc570    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c35b80: aa1d03fd    	mov	x29, x29
101c35b84: 957fc571    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c35b88: aa0003f4    	mov	x20, x0
101c35b8c: f00f1428    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c35b90: f946f101    	ldr	x1, [x8, #0xde0] ; resetMagicAdInfo
101c35b94: 957fc56a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c35b98: aa1403e0    	mov	x0, x20
101c35b9c: 957fc56e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c35ba0: aa1303e0    	mov	x0, x19
101c35ba4: 957fc56c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c35ba8: f85a03a8    	ldur	x8, [x29, #-0x60]
101c35bac: d00dcdc9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
101c35bb0: f9405929    	ldr	x9, [x9, #0xb0]
101c35bb4: f9400129    	ldr	x9, [x9]
101c35bb8: eb08013f    	cmp	x9, x8
101c35bbc: 54000121    	b.ne	0x101c35be0 <_Flutter_Image_provideRelativePathByUrl+0x42a90>
101c35bc0: a9527bfd    	ldp	x29, x30, [sp, #0x120]
101c35bc4: a9514ff4    	ldp	x20, x19, [sp, #0x110]
101c35bc8: a95057f6    	ldp	x22, x21, [sp, #0x100]
101c35bcc: a94f5ff8    	ldp	x24, x23, [sp, #0xf0]
101c35bd0: a94e67fa    	ldp	x26, x25, [sp, #0xe0]
101c35bd4: a94d6ffc    	ldp	x28, x27, [sp, #0xd0]
101c35bd8: 9104c3ff    	add	sp, sp, #0x130
101c35bdc: d65f03c0    	ret
101c35be0: 957fc565    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>