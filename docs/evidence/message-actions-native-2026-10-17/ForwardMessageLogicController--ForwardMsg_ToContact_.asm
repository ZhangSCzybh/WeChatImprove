
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101c377c0: d10203ff    	sub	sp, sp, #0x80
101c377c4: a9026ffc    	stp	x28, x27, [sp, #0x20]
101c377c8: a90367fa    	stp	x26, x25, [sp, #0x30]
101c377cc: a9045ff8    	stp	x24, x23, [sp, #0x40]
101c377d0: a90557f6    	stp	x22, x21, [sp, #0x50]
101c377d4: a9064ff4    	stp	x20, x19, [sp, #0x60]
101c377d8: a9077bfd    	stp	x29, x30, [sp, #0x70]
101c377dc: 9101c3fd    	add	x29, sp, #0x70
101c377e0: aa0303f3    	mov	x19, x3
101c377e4: aa0203f5    	mov	x21, x2
101c377e8: aa0003f4    	mov	x20, x0
101c377ec: 900f7fe8    	adrp	x8, 0x120c33000 <dyld_stub_binder+0x120c33000>
101c377f0: 52800029    	mov	w9, #0x1                ; =1
101c377f4: 39261d09    	strb	w9, [x8, #0x987]
101c377f8: aa0303e0    	mov	x0, x3
101c377fc: 957fbe4f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c37800: d00f1428    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c37804: f9401501    	ldr	x1, [x8, #0x28] ; checkMessageWrap:toContact:
101c37808: aa1403e0    	mov	x0, x20
101c3780c: aa1503e2    	mov	x2, x21
101c37810: aa1303e3    	mov	x3, x19
101c37814: 957fbe4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c37818: aa1d03fd    	mov	x29, x29
101c3781c: 957fbe4b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c37820: aa0003f5    	mov	x21, x0
101c37824: f00f29e8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
101c37828: f9412900    	ldr	x0, [x8, #0x250] ; ��- 
101c3782c: 900f2648    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101c37830: f947ad17    	ldr	x23, [x8, #0xf58] ; class
101c37834: aa1703e1    	mov	x1, x23
101c37838: 957fbe41    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3783c: aa0003e2    	mov	x2, x0
101c37840: 900f2668    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
101c37844: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
101c37848: aa1303e0    	mov	x0, x19
101c3784c: 957fbe3c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c37850: 340006a0    	cbz	w0, 0x101c37924 <_Flutter_Image_provideRelativePathByUrl+0x447d4>
101c37854: 900f29e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101c37858: f945e916    	ldr	x22, [x8, #0xbd0] ; ��d 
101c3785c: b00f2648    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101c37860: f944e918    	ldr	x24, [x8, #0x9d0] ; currentContext
101c37864: aa1303e0    	mov	x0, x19
101c37868: 957fbe34    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c3786c: aa1603e0    	mov	x0, x22
101c37870: aa1803e1    	mov	x1, x24
101c37874: 957fbe32    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c37878: aa1d03fd    	mov	x29, x29
101c3787c: 957fbe33    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c37880: aa0003f6    	mov	x22, x0
101c37884: d00f29e8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
101c37888: f942a100    	ldr	x0, [x8, #0x540] ; ��- 
101c3788c: aa1703e1    	mov	x1, x23
101c37890: 957fbe2b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c37894: aa0003e2    	mov	x2, x0
101c37898: d00f1008    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101c3789c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
101c378a0: aa1603e0    	mov	x0, x22
101c378a4: 957fbe26    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c378a8: aa1d03fd    	mov	x29, x29
101c378ac: 957fbe27    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c378b0: aa0003f7    	mov	x23, x0
101c378b4: 900f1028    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101c378b8: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
101c378bc: aa1303e0    	mov	x0, x19
101c378c0: 957fbe1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c378c4: aa1d03fd    	mov	x29, x29
101c378c8: 957fbe20    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c378cc: aa0003f8    	mov	x24, x0
101c378d0: f00f1048    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
101c378d4: f9423901    	ldr	x1, [x8, #0x470] ; m_nsBrandUserName
101c378d8: aa1303e0    	mov	x0, x19
101c378dc: 957fbe18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c378e0: aa1d03fd    	mov	x29, x29
101c378e4: 957fbe19    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c378e8: aa0003f9    	mov	x25, x0
101c378ec: aa1303e0    	mov	x0, x19
101c378f0: 957fbe19    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c378f4: b00f1428    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c378f8: f9468501    	ldr	x1, [x8, #0xd08] ; ForwardMsg:MsgWrap:Brand:
101c378fc: aa1703e0    	mov	x0, x23
101c37900: aa1803e2    	mov	x2, x24
101c37904: aa1503e3    	mov	x3, x21
101c37908: aa1903e4    	mov	x4, x25
101c3790c: 957fbe0c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c37910: aa1903e0    	mov	x0, x25
101c37914: 957fbe10    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c37918: aa1803e0    	mov	x0, x24
101c3791c: 957fbe0e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c37920: 1400005f    	b	0x101c37a9c <_Flutter_Image_provideRelativePathByUrl+0x4494c>
101c37924: b00f2de8    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c37928: b9891108    	ldrsw	x8, [x8, #0x910]
101c3792c: f8686a80    	ldr	x0, [x20, x8]
101c37930: b00f2648    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101c37934: f9435101    	ldr	x1, [x8, #0x6a0] ; count
101c37938: 957fbe01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3793c: b40000c0    	cbz	x0, 0x101c37954 <_Flutter_Image_provideRelativePathByUrl+0x44804>
101c37940: 900f10a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
101c37944: f941bd01    	ldr	x1, [x8, #0x378] ; setM_forwardType:
101c37948: aa1403e0    	mov	x0, x20
101c3794c: 52800022    	mov	w2, #0x1                ; =1
101c37950: 957fbdfb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c37954: b00f2de8    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c37958: b9892519    	ldrsw	x25, [x8, #0x924]
101c3795c: 8b190280    	add	x0, x20, x25
101c37960: 957fbe0b    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101c37964: aa0003f7    	mov	x23, x0
101c37968: b40002c0    	cbz	x0, 0x101c379c0 <_Flutter_Image_provideRelativePathByUrl+0x44870>
101c3796c: 8b190280    	add	x0, x20, x25
101c37970: 957fbe07    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101c37974: aa0003f8    	mov	x24, x0
101c37978: f00f12e8    	adrp	x8, 0x11fe96000 <dyld_stub_binder+0x11fe96000>
101c3797c: f9436d16    	ldr	x22, [x8, #0x6d8] ; getEditImageAttr
101c37980: f00f2668    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101c37984: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
101c37988: aa1603e2    	mov	x2, x22
101c3798c: 957fbdec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c37990: 340001c0    	cbz	w0, 0x101c379c8 <_Flutter_Image_provideRelativePathByUrl+0x44878>
101c37994: 8b190280    	add	x0, x20, x25
101c37998: 957fbdfd    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101c3799c: aa0003f9    	mov	x25, x0
101c379a0: aa1603e1    	mov	x1, x22
101c379a4: 957fbde6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c379a8: aa1d03fd    	mov	x29, x29
101c379ac: 957fbde7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c379b0: aa0003f6    	mov	x22, x0
101c379b4: aa1903e0    	mov	x0, x25
101c379b8: 957fbde7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c379bc: 14000004    	b	0x101c379cc <_Flutter_Image_provideRelativePathByUrl+0x4487c>
101c379c0: d2800016    	mov	x22, #0x0               ; =0
101c379c4: 14000004    	b	0x101c379d4 <_Flutter_Image_provideRelativePathByUrl+0x44884>
101c379c8: d2800016    	mov	x22, #0x0               ; =0
101c379cc: aa1803e0    	mov	x0, x24
101c379d0: 957fbde1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c379d4: aa1703e0    	mov	x0, x23
101c379d8: 957fbddf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c379dc: d00f29e8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
101c379e0: f946c918    	ldr	x24, [x8, #0xd90]
101c379e4: d00f1428    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c379e8: f9401901    	ldr	x1, [x8, #0x30] ; m_uiAppMsgScene
101c379ec: aa1403e0    	mov	x0, x20
101c379f0: 957fbdd3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c379f4: aa0003f9    	mov	x25, x0
101c379f8: f00f1208    	adrp	x8, 0x11fe7a000 <dyld_stub_binder+0x11fe7a000>
101c379fc: f9448501    	ldr	x1, [x8, #0x908] ; m_forwardType
101c37a00: aa1403e0    	mov	x0, x20
101c37a04: 957fbdce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c37a08: aa0003fa    	mov	x26, x0
101c37a0c: b00f1428    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c37a10: f9457101    	ldr	x1, [x8, #0xae0] ; m_uiIDKeyScene
101c37a14: aa1403e0    	mov	x0, x20
101c37a18: 957fbdc9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c37a1c: aa0003fb    	mov	x27, x0
101c37a20: b00f2de8    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c37a24: b9890517    	ldrsw	x23, [x8, #0x904]
101c37a28: f8776a80    	ldr	x0, [x20, x23]
101c37a2c: b00f1428    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c37a30: f9466501    	ldr	x1, [x8, #0xcc8] ; bGroupUndoneFlag
101c37a34: 957fbdc2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c37a38: aa0003fc    	mov	x28, x0
101c37a3c: f8776a80    	ldr	x0, [x20, x23]
101c37a40: f00f1108    	adrp	x8, 0x11fe5a000 <dyld_stub_binder+0x11fe5a000>
101c37a44: f946cd01    	ldr	x1, [x8, #0xd98] ; getInputText
101c37a48: 957fbdbd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c37a4c: aa1d03fd    	mov	x29, x29
101c37a50: 957fbdbe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c37a54: aa0003f7    	mov	x23, x0
101c37a58: b00f11e8    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
101c37a5c: f9466501    	ldr	x1, [x8, #0xcc8] ; m_commonSearchScene
101c37a60: aa1403e0    	mov	x0, x20
101c37a64: 957fbdb6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c37a68: d00f1428    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c37a6c: f9401d01    	ldr	x1, [x8, #0x38] ; ForwardMsg:ToContact:Scene:forwardType:uiIDKeyScene:editImageAttr:roomTodoFlag:inputText:searchScene:
101c37a70: b90013e0    	str	w0, [sp, #0x10]
101c37a74: f90007f7    	str	x23, [sp, #0x8]
101c37a78: 390003fc    	strb	w28, [sp]
101c37a7c: aa1803e0    	mov	x0, x24
101c37a80: aa1503e2    	mov	x2, x21
101c37a84: aa1303e3    	mov	x3, x19
101c37a88: aa1903e4    	mov	x4, x25
101c37a8c: aa1a03e5    	mov	x5, x26
101c37a90: aa1b03e6    	mov	x6, x27
101c37a94: aa1603e7    	mov	x7, x22
101c37a98: 957fbda9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c37a9c: aa1703e0    	mov	x0, x23
101c37aa0: 957fbdad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c37aa4: aa1603e0    	mov	x0, x22
101c37aa8: 957fbdab    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c37aac: b00f1428    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c37ab0: f9477d01    	ldr	x1, [x8, #0xef8] ; reportUrlMsgInfoWithMsgWrap:actionRet:
101c37ab4: aa1403e0    	mov	x0, x20
101c37ab8: aa1503e2    	mov	x2, x21
101c37abc: 52800023    	mov	w3, #0x1                ; =1
101c37ac0: 957fbd9f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c37ac4: d00f1428    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c37ac8: f9402101    	ldr	x1, [x8, #0x40] ; reportImageMsgInfoWithMsgWrap:
101c37acc: aa1403e0    	mov	x0, x20
101c37ad0: aa1503e2    	mov	x2, x21
101c37ad4: 957fbd9a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c37ad8: d00f1428    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c37adc: f9402501    	ldr	x1, [x8, #0x48] ; reportWeAppMsgInfoWithMsgWrap:toContacts:
101c37ae0: aa1403e0    	mov	x0, x20
101c37ae4: aa1503e2    	mov	x2, x21
101c37ae8: aa1303e3    	mov	x3, x19
101c37aec: 957fbd94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c37af0: aa1303e0    	mov	x0, x19
101c37af4: 957fbd98    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c37af8: aa1503e0    	mov	x0, x21
101c37afc: a9477bfd    	ldp	x29, x30, [sp, #0x70]
101c37b00: a9464ff4    	ldp	x20, x19, [sp, #0x60]
101c37b04: a94557f6    	ldp	x22, x21, [sp, #0x50]
101c37b08: a9445ff8    	ldp	x24, x23, [sp, #0x40]
101c37b0c: a94367fa    	ldp	x26, x25, [sp, #0x30]
101c37b10: a9426ffc    	ldp	x28, x27, [sp, #0x20]
101c37b14: 910203ff    	add	sp, sp, #0x80
101c37b18: 157fbd8f    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>