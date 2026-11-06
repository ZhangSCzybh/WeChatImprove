
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
115880930: d10283ff    	sub	sp, sp, #0xa0
115880934: a90567fa    	stp	x26, x25, [sp, #0x50]
115880938: a9065ff8    	stp	x24, x23, [sp, #0x60]
11588093c: a90757f6    	stp	x22, x21, [sp, #0x70]
115880940: a9084ff4    	stp	x20, x19, [sp, #0x80]
115880944: a9097bfd    	stp	x29, x30, [sp, #0x90]
115880948: 910243fd    	add	x29, sp, #0x90
11588094c: aa0203f4    	mov	x20, x2
115880950: aa0003f3    	mov	x19, x0
115880954: d004a659    	adrp	x25, 0x11ed4a000 <dyld_stub_binder+0x11ed4a000>
115880958: f9440f20    	ldr	x0, [x25, #0x818]
11588095c: b0048a68    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
115880960: f9411116    	ldr	x22, [x8, #0x220] ; selector: externalIMP
115880964: aa1603e1    	mov	x1, x22
115880968: 94576ef7    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11588096c: b0048a48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
115880970: f9418915    	ldr	x21, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
115880974: b003f108    	adrp	x8, 0x11d6a1000 <dyld_stub_binder+0x11d6a1000>
115880978: 911f6108    	add	x8, x8, #0x7d8 ; CFString: ================%@================ viewWillAppear
11588097c: a9004fe8    	stp	x8, x19, [sp]
115880980: b002c585    	adrp	x5, 0x11b131000 <dyld_stub_binder+0x11b131000>
115880984: 911d5ca5    	add	x5, x5, #0x757
115880988: d002c587    	adrp	x7, 0x11b132000 <dyld_stub_binder+0x11b132000>
11588098c: 910c40e7    	add	x7, x7, #0x310
115880990: aa1503e1    	mov	x1, x21
115880994: 52800042    	mov	w2, #0x2                ; =2
115880998: d2800003    	mov	x3, #0x0                ; =0
11588099c: 52800004    	mov	w4, #0x0                ; =0
1158809a0: 5280ec66    	mov	w6, #0x763              ; =1891
1158809a4: 94576ee8    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1158809a8: d004a7c8    	adrp	x8, 0x11ed7a000 <dyld_stub_binder+0x11ed7a000>
1158809ac: f941d508    	ldr	x8, [x8, #0x3a8]
1158809b0: a90423f3    	stp	x19, x8, [sp, #0x40]
1158809b4: 90048a68    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1158809b8: f941cd01    	ldr	x1, [x8, #0x398] ; selector: viewWillAppear:
1158809bc: 910103e0    	add	x0, sp, #0x40
1158809c0: aa1403e2    	mov	x2, x20
1158809c4: 94576ee3    	bl	0x116e5c550 <dyld_stub_binder+0x116e5c550>
1158809c8: d004a488    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1158809cc: f943c100    	ldr	x0, [x8, #0x780]
1158809d0: b0048a48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1158809d4: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
1158809d8: 94576edb    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1158809dc: aa1d03fd    	mov	x29, x29
1158809e0: 94576f06    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1158809e4: aa0003f7    	mov	x23, x0
1158809e8: f004a468    	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
1158809ec: f9438902    	ldr	x2, [x8, #0x710]
1158809f0: b004a0a8    	adrp	x8, 0x11ec95000 <dyld_stub_binder+0x11ec95000>
1158809f4: f9408503    	ldr	x3, [x8, #0x108] ; selector: MMUIViewControllerWillAppear:
1158809f8: 9003f668    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1158809fc: f9449908    	ldr	x8, [x8, #0x930]
115880a00: f9000fe8    	str	x8, [sp, #0x18]
115880a04: f0010228    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
115880a08: fd434100    	ldr	d0, [x8, #0x680] ; constant double=1.6080749353e-314
115880a0c: 90000008    	adrp	x8, 0x115880000 <_O266DecReleaseOutputPicture+0x3770a94>
115880a10: 9132e108    	add	x8, x8, #0xcb8
115880a14: d0035009    	adrp	x9, 0x11c282000 <dyld_stub_binder+0x11c282000>
115880a18: 910fe129    	add	x9, x9, #0x3f8
115880a1c: fd0013e0    	str	d0, [sp, #0x20]
115880a20: a902a7e8    	stp	x8, x9, [sp, #0x28]
115880a24: f9001ff3    	str	x19, [sp, #0x38]
115880a28: b0048a48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
115880a2c: f9472d01    	ldr	x1, [x8, #0xe58] ; selector: callExtension:selector:block:
115880a30: 910063e4    	add	x4, sp, #0x18
115880a34: 94576ec4    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880a38: aa1703e0    	mov	x0, x23
115880a3c: 94576ee0    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
115880a40: f004a4a8    	adrp	x8, 0x11ed17000 <dyld_stub_binder+0x11ed17000>
115880a44: f9409d00    	ldr	x0, [x8, #0x138]
115880a48: aa1603e1    	mov	x1, x22
115880a4c: 94576ebe    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880a50: aa1d03fd    	mov	x29, x29
115880a54: 94576ee9    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
115880a58: aa0003f7    	mov	x23, x0
115880a5c: f0048e48    	adrp	x8, 0x11ea4b000 <dyld_stub_binder+0x11ea4b000>
115880a60: f941a901    	ldr	x1, [x8, #0x350] ; selector: addViewController:
115880a64: aa1303e2    	mov	x2, x19
115880a68: 94576eb7    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880a6c: aa1703e0    	mov	x0, x23
115880a70: 94576ed3    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
115880a74: b004a0a8    	adrp	x8, 0x11ec95000 <dyld_stub_binder+0x11ec95000>
115880a78: f9408901    	ldr	x1, [x8, #0x110] ; selector: tryPerformStatusBarUpdateInTopWindow
115880a7c: aa1303e0    	mov	x0, x19
115880a80: 94576eb1    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880a84: d0049588    	adrp	x8, 0x11eb32000 <dyld_stub_binder+0x11eb32000>
115880a88: f9419501    	ldr	x1, [x8, #0x328] ; selector: updateStatusBarColor
115880a8c: aa1303e0    	mov	x0, x19
115880a90: 94576ead    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880a94: d0049648    	adrp	x8, 0x11eb4a000 <dyld_stub_binder+0x11eb4a000>
115880a98: f946c101    	ldr	x1, [x8, #0xd80] ; selector: useTransparentNavibar
115880a9c: aa1303e0    	mov	x0, x19
115880aa0: 94576ea9    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880aa4: 340000a0    	cbz	w0, 0x115880ab8 <_O266DecReleaseOutputPicture+0x377154c>
115880aa8: f0048ae8    	adrp	x8, 0x11e9df000 <dyld_stub_binder+0x11e9df000>
115880aac: f9440901    	ldr	x1, [x8, #0x810] ; selector: removeNavigationBarBkg
115880ab0: aa1303e0    	mov	x0, x19
115880ab4: 94576ea4    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880ab8: b004a0a8    	adrp	x8, 0x11ec95000 <dyld_stub_binder+0x11ec95000>
115880abc: f9404901    	ldr	x1, [x8, #0x90] ; selector: initNavHeaderIfNeed
115880ac0: aa1303e0    	mov	x0, x19
115880ac4: 94576ea0    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880ac8: f004ad88    	adrp	x8, 0x11ee33000 <dyld_stub_binder+0x11ee33000>
115880acc: b9800108    	ldrsw	x8, [x8] ; ivar: MMUIViewController.m_bAnimated offset=56
115880ad0: 52800029    	mov	w9, #0x1                ; =1
115880ad4: 38286a69    	strb	w9, [x19, x8]
115880ad8: d004ad88    	adrp	x8, 0x11ee32000 <dyld_stub_binder+0x11ee32000>
115880adc: b98f7508    	ldrsw	x8, [x8, #0xf74] ; ivar: MMUIViewController.m_bIsBeingPoped offset=57
115880ae0: 38286a7f    	strb	wzr, [x19, x8]
115880ae4: f004ad88    	adrp	x8, 0x11ee33000 <dyld_stub_binder+0x11ee33000>
115880ae8: b9800508    	ldrsw	x8, [x8, #0x4] ; ivar: MMUIViewController.m_bIsBeingInteractivePop offset=193
115880aec: 38286a7f    	strb	wzr, [x19, x8]
115880af0: 90048a68    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
115880af4: f941e101    	ldr	x1, [x8, #0x3c0] ; selector: isDuringInteractivePop
115880af8: aa1303e0    	mov	x0, x19
115880afc: 94576e92    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880b00: 370000a0    	tbnz	w0, #0x0, 0x115880b14 <_O266DecReleaseOutputPicture+0x37715a8>
115880b04: b004a0a8    	adrp	x8, 0x11ec95000 <dyld_stub_binder+0x11ec95000>
115880b08: f9408d01    	ldr	x1, [x8, #0x118] ; selector: deselectCellAlongsideTransition
115880b0c: aa1303e0    	mov	x0, x19
115880b10: 94576e8d    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880b14: d0049868    	adrp	x8, 0x11eb8e000 <dyld_stub_binder+0x11eb8e000>
115880b18: f9479501    	ldr	x1, [x8, #0xf28] ; selector: adjustView
115880b1c: aa1303e0    	mov	x0, x19
115880b20: 94576e89    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880b24: b004a148    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
115880b28: f941b101    	ldr	x1, [x8, #0x360] ; selector: navigationController
115880b2c: aa1303e0    	mov	x0, x19
115880b30: 94576e85    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880b34: aa1d03fd    	mov	x29, x29
115880b38: 94576eb0    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
115880b3c: aa0003f7    	mov	x23, x0
115880b40: 90048a68    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
115880b44: f9444918    	ldr	x24, [x8, #0x890] ; selector: isBeingPresented
115880b48: aa1803e1    	mov	x1, x24
115880b4c: 94576e7e    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880b50: d004ad9a    	adrp	x26, 0x11ee32000 <dyld_stub_binder+0x11ee32000>
115880b54: 36000080    	tbz	w0, #0x0, 0x115880b64 <_O266DecReleaseOutputPicture+0x37715f8>
115880b58: aa1703e0    	mov	x0, x23
115880b5c: 94576e98    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
115880b60: 14000008    	b	0x115880b80 <_O266DecReleaseOutputPicture+0x3771614>
115880b64: aa1303e0    	mov	x0, x19
115880b68: aa1803e1    	mov	x1, x24
115880b6c: 94576e76    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880b70: aa0003f8    	mov	x24, x0
115880b74: aa1703e0    	mov	x0, x23
115880b78: 94576e91    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
115880b7c: 36000578    	tbz	w24, #0x0, 0x115880c28 <_O266DecReleaseOutputPicture+0x37716bc>
115880b80: 90048b08    	adrp	x8, 0x11e9e0000 <dyld_stub_binder+0x11e9e0000>
115880b84: f9401101    	ldr	x1, [x8, #0x20] ; selector: viewWillBePresented:
115880b88: aa1303e0    	mov	x0, x19
115880b8c: aa1403e2    	mov	x2, x20
115880b90: 94576e6d    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880b94: b98f5f48    	ldrsw	x8, [x26, #0xf5c] ; ivar: MMUIViewController.m_hasAppear offset=192
115880b98: 38686a68    	ldrb	w8, [x19, x8]
115880b9c: b0048c89    	adrp	x9, 0x11ea11000 <dyld_stub_binder+0x11ea11000>
115880ba0: 910c2129    	add	x9, x9, #0x308
115880ba4: f0048aea    	adrp	x10, 0x11e9df000 <dyld_stub_binder+0x11e9df000>
115880ba8: 913e614a    	add	x10, x10, #0xf98
115880bac: 7100011f    	cmp	w8, #0x0
115880bb0: 9a8a1128    	csel	x8, x9, x10, ne
115880bb4: f9400101    	ldr	x1, [x8]
115880bb8: aa1303e0    	mov	x0, x19
115880bbc: aa1403e2    	mov	x2, x20
115880bc0: 94576e61    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880bc4: d0049948    	adrp	x8, 0x11ebaa000 <dyld_stub_binder+0x11ebaa000>
115880bc8: f9461501    	ldr	x1, [x8, #0xc28] ; selector: viewWillAppearInNavBar:
115880bcc: aa1303e0    	mov	x0, x19
115880bd0: aa1403e2    	mov	x2, x20
115880bd4: 94576e5c    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880bd8: b004a0a8    	adrp	x8, 0x11ec95000 <dyld_stub_binder+0x11ec95000>
115880bdc: f9409101    	ldr	x1, [x8, #0x120] ; selector: hostingController
115880be0: aa1303e0    	mov	x0, x19
115880be4: 94576e58    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880be8: aa1d03fd    	mov	x29, x29
115880bec: 94576e83    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
115880bf0: aa0003f7    	mov	x23, x0
115880bf4: b004a0a8    	adrp	x8, 0x11ec95000 <dyld_stub_binder+0x11ec95000>
115880bf8: f9409501    	ldr	x1, [x8, #0x128] ; selector: onViewWillAppearFor:
115880bfc: aa1303e2    	mov	x2, x19
115880c00: 94576e51    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880c04: aa1703e0    	mov	x0, x23
115880c08: 94576e6d    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
115880c0c: a9497bfd    	ldp	x29, x30, [sp, #0x90]
115880c10: a9484ff4    	ldp	x20, x19, [sp, #0x80]
115880c14: a94757f6    	ldp	x22, x21, [sp, #0x70]
115880c18: a9465ff8    	ldp	x24, x23, [sp, #0x60]
115880c1c: a94567fa    	ldp	x26, x25, [sp, #0x50]
115880c20: 910283ff    	add	sp, sp, #0xa0
115880c24: d65f03c0    	ret
115880c28: b0048e28    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
115880c2c: f9474d01    	ldr	x1, [x8, #0xe98] ; selector: isMovingToParentViewController
115880c30: aa1303e0    	mov	x0, x19
115880c34: 94576e44    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880c38: 34000080    	cbz	w0, 0x115880c48 <_O266DecReleaseOutputPicture+0x37716dc>
115880c3c: 90048aa8    	adrp	x8, 0x11e9d4000 <dyld_stub_binder+0x11e9d4000>
115880c40: f9478d01    	ldr	x1, [x8, #0xf18] ; selector: viewWillBePushed:
115880c44: 17ffffd1    	b	0x115880b88 <_O266DecReleaseOutputPicture+0x377161c>
115880c48: b98f5f48    	ldrsw	x8, [x26, #0xf5c]
115880c4c: 38686a68    	ldrb	w8, [x19, x8]
115880c50: 3707fa28    	tbnz	w8, #0x0, 0x115880b94 <_O266DecReleaseOutputPicture+0x3771628>
115880c54: f9440f20    	ldr	x0, [x25, #0x818]
115880c58: aa1603e1    	mov	x1, x22
115880c5c: 94576e3a    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880c60: b003f108    	adrp	x8, 0x11d6a1000 <dyld_stub_binder+0x11d6a1000>
115880c64: 911fe108    	add	x8, x8, #0x7f8 ; CFString: missing callback
115880c68: f90003e8    	str	x8, [sp]
115880c6c: b002c585    	adrp	x5, 0x11b131000 <dyld_stub_binder+0x11b131000>
115880c70: 911d5ca5    	add	x5, x5, #0x757
115880c74: d002c587    	adrp	x7, 0x11b132000 <dyld_stub_binder+0x11b132000>
115880c78: 910c40e7    	add	x7, x7, #0x310
115880c7c: aa1503e1    	mov	x1, x21
115880c80: 52800062    	mov	w2, #0x3                ; =3
115880c84: d2800003    	mov	x3, #0x0                ; =0
115880c88: 52800004    	mov	w4, #0x0                ; =0
115880c8c: 5280f006    	mov	w6, #0x780              ; =1920
115880c90: 94576e2d    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115880c94: 17ffffc0    	b	0x115880b94 <_O266DecReleaseOutputPicture+0x3771628>
115880c98: 14000003    	b	0x115880ca4 <_O266DecReleaseOutputPicture+0x3771738>
115880c9c: 14000002    	b	0x115880ca4 <_O266DecReleaseOutputPicture+0x3771738>
115880ca0: 14000001    	b	0x115880ca4 <_O266DecReleaseOutputPicture+0x3771738>
115880ca4: aa0003f3    	mov	x19, x0
115880ca8: aa1703e0    	mov	x0, x23
115880cac: 94576e44    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
115880cb0: aa1303e0    	mov	x0, x19
115880cb4: 9457480b    	bl	0x116e52ce0 <dyld_stub_binder+0x116e52ce0>
115880cb8: aa0103e8    	mov	x8, x1
115880cbc: f9401002    	ldr	x2, [x0, #0x20]
115880cc0: b004a0a9    	adrp	x9, 0x11ec95000 <dyld_stub_binder+0x11ec95000>
115880cc4: f9408521    	ldr	x1, [x9, #0x108] ; selector: MMUIViewControllerWillAppear:
115880cc8: aa0803e0    	mov	x0, x8
115880ccc: 14576e1e    	b	0x116e5c544 <dyld_stub_binder+0x116e5c544>
