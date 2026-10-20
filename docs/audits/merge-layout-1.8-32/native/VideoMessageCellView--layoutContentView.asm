
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10604b480: d10343ff    	sub	sp, sp, #0xd0
10604b484: 6d0623e9    	stp	d9, d8, [sp, #0x60]
10604b488: a9076ffc    	stp	x28, x27, [sp, #0x70]
10604b48c: a90867fa    	stp	x26, x25, [sp, #0x80]
10604b490: a9095ff8    	stp	x24, x23, [sp, #0x90]
10604b494: a90a57f6    	stp	x22, x21, [sp, #0xa0]
10604b498: a90b4ff4    	stp	x20, x19, [sp, #0xb0]
10604b49c: a90c7bfd    	stp	x29, x30, [sp, #0xc0]
10604b4a0: 910303fd    	add	x29, sp, #0xc0
10604b4a4: aa0003f3    	mov	x19, x0
10604b4a8: 900d5fc8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
10604b4ac: 52800029    	mov	w9, #0x1                ; =1
10604b4b0: 390cd509    	strb	w9, [x8, #0x335]
10604b4b4: f00cef88    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
10604b4b8: f9410901    	ldr	x1, [x8, #0x210] ; viewModel
10604b4bc: f9002fe1    	str	x1, [sp, #0x58]
10604b4c0: 946f6f1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b4c4: aa1d03fd    	mov	x29, x29
10604b4c8: 946f6f20    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604b4cc: aa0003f5    	mov	x21, x0
10604b4d0: 900cefa8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10604b4d4: f9405501    	ldr	x1, [x8, #0xa8] ; downloadThumbImageIfNeed
10604b4d8: 946f6f19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b4dc: aa1503e0    	mov	x0, x21
10604b4e0: 946f6f1d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604b4e4: 900cefa8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10604b4e8: f9468d01    	ldr	x1, [x8, #0xd18] ; initThumbImageView
10604b4ec: aa1303e0    	mov	x0, x19
10604b4f0: 946f6f13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b4f4: d00cfc08    	adrp	x8, 0x11ffcd000 <dyld_stub_binder+0x11ffcd000>
10604b4f8: f9409901    	ldr	x1, [x8, #0x130] ; initSightIconView
10604b4fc: aa1303e0    	mov	x0, x19
10604b500: 946f6f0f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b504: d00cfc08    	adrp	x8, 0x11ffcd000 <dyld_stub_binder+0x11ffcd000>
10604b508: f9409d01    	ldr	x1, [x8, #0x138] ; initVideoInfoView
10604b50c: aa1303e0    	mov	x0, x19
10604b510: 946f6f0b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b514: 900d0ca8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10604b518: 910a8108    	add	x8, x8, #0x2a0
10604b51c: b9800114    	ldrsw	x20, [x8]
10604b520: f8746a60    	ldr	x0, [x19, x20]
10604b524: f00d0f48    	adrp	x8, 0x120236000 <dyld_stub_binder+0x120236000>
10604b528: b98fdd19    	ldrsw	x25, [x8, #0xfdc]
10604b52c: f8796a62    	ldr	x2, [x19, x25]
10604b530: f00d0588    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10604b534: f9476d16    	ldr	x22, [x8, #0xed8] ; addSubview:
10604b538: aa1603e1    	mov	x1, x22
10604b53c: 946f6f00    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b540: f8746a60    	ldr	x0, [x19, x20]
10604b544: f00d0f48    	adrp	x8, 0x120236000 <dyld_stub_binder+0x120236000>
10604b548: b98fe108    	ldrsw	x8, [x8, #0xfe0]
10604b54c: f8686a62    	ldr	x2, [x19, x8]
10604b550: aa1603e1    	mov	x1, x22
10604b554: 946f6efa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b558: f8746a60    	ldr	x0, [x19, x20]
10604b55c: f00d0f48    	adrp	x8, 0x120236000 <dyld_stub_binder+0x120236000>
10604b560: b98fe51a    	ldrsw	x26, [x8, #0xfe4]
10604b564: f87a6a62    	ldr	x2, [x19, x26]
10604b568: aa1603e1    	mov	x1, x22
10604b56c: 946f6ef4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b570: f8746a60    	ldr	x0, [x19, x20]
10604b574: f00d0f48    	adrp	x8, 0x120236000 <dyld_stub_binder+0x120236000>
10604b578: b98fe91b    	ldrsw	x27, [x8, #0xfe8]
10604b57c: f87b6a62    	ldr	x2, [x19, x27]
10604b580: aa1603e1    	mov	x1, x22
10604b584: 946f6eee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b588: f8746a77    	ldr	x23, [x19, x20]
10604b58c: d00cfc08    	adrp	x8, 0x11ffcd000 <dyld_stub_binder+0x11ffcd000>
10604b590: f940a115    	ldr	x21, [x8, #0x140] ; iconClickBgButton
10604b594: aa1303e0    	mov	x0, x19
10604b598: aa1503e1    	mov	x1, x21
10604b59c: 946f6ee8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b5a0: aa1d03fd    	mov	x29, x29
10604b5a4: 946f6ee9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604b5a8: aa0003f8    	mov	x24, x0
10604b5ac: aa1703e0    	mov	x0, x23
10604b5b0: aa1603e1    	mov	x1, x22
10604b5b4: aa1803e2    	mov	x2, x24
10604b5b8: 946f6ee1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b5bc: aa1803e0    	mov	x0, x24
10604b5c0: 946f6ee5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604b5c4: 900d0948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10604b5c8: f9468d00    	ldr	x0, [x8, #0xd18]
10604b5cc: f00cf008    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
10604b5d0: f9473501    	ldr	x1, [x8, #0xe68] ; isSupportDragAndDrop
10604b5d4: 946f6eda    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b5d8: 340001a0    	cbz	w0, 0x10604b60c <_Flutter_MMFoundation_BindContext+0x25271f0>
10604b5dc: f8796a60    	ldr	x0, [x19, x25]
10604b5e0: f00d05e8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10604b5e4: f9406901    	ldr	x1, [x8, #0xd0] ; setUserInteractionEnabled:
10604b5e8: 52800022    	mov	w2, #0x1                ; =1
10604b5ec: 946f6ed4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b5f0: f8796a60    	ldr	x0, [x19, x25]
10604b5f4: f00d0f48    	adrp	x8, 0x120236000 <dyld_stub_binder+0x120236000>
10604b5f8: b98fd908    	ldrsw	x8, [x8, #0xfd8]
10604b5fc: f8686a62    	ldr	x2, [x19, x8]
10604b600: f00cf008    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
10604b604: f9473901    	ldr	x1, [x8, #0xe70] ; addInteraction:
10604b608: 946f6ecd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b60c: f8796a60    	ldr	x0, [x19, x25]
10604b610: 900d05a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10604b614: f9467917    	ldr	x23, [x8, #0xcf0] ; center
10604b618: aa1703e1    	mov	x1, x23
10604b61c: 946f6ec8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b620: f87a6a60    	ldr	x0, [x19, x26]
10604b624: 900d05e8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10604b628: f9425116    	ldr	x22, [x8, #0x4a0] ; setCenter:
10604b62c: aa1603e1    	mov	x1, x22
10604b630: 946f6ec3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b634: f87a6a60    	ldr	x0, [x19, x26]
10604b638: 900cefc8    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10604b63c: f9411d01    	ldr	x1, [x8, #0x238] ; centerX
10604b640: 946f6ebf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b644: f87b6a60    	ldr	x0, [x19, x27]
10604b648: b00cef88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10604b64c: f942dd01    	ldr	x1, [x8, #0x5b8] ; setCenterX:
10604b650: 946f6ebb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b654: f87a6a60    	ldr	x0, [x19, x26]
10604b658: b00cef88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10604b65c: f9432901    	ldr	x1, [x8, #0x650] ; bottom
10604b660: 946f6eb7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b664: 1e621001    	fmov	d1, #4.00000000
10604b668: 1e612800    	fadd	d0, d0, d1
10604b66c: f87b6a60    	ldr	x0, [x19, x27]
10604b670: b00cef88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10604b674: f9403d01    	ldr	x1, [x8, #0x78] ; setTop:
10604b678: 946f6eb1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b67c: f87a6a60    	ldr	x0, [x19, x26]
10604b680: aa1703e1    	mov	x1, x23
10604b684: 946f6eae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b688: 1e604008    	fmov	d8, d0
10604b68c: 1e604029    	fmov	d9, d1
10604b690: aa1303e0    	mov	x0, x19
10604b694: aa1503e1    	mov	x1, x21
10604b698: 946f6ea9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b69c: aa1d03fd    	mov	x29, x29
10604b6a0: 946f6eaa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604b6a4: aa0003f5    	mov	x21, x0
10604b6a8: aa1603e1    	mov	x1, x22
10604b6ac: 1e604100    	fmov	d0, d8
10604b6b0: 1e604121    	fmov	d1, d9
10604b6b4: 946f6ea2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b6b8: aa1503e0    	mov	x0, x21
10604b6bc: 946f6ea6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604b6c0: f8796a60    	ldr	x0, [x19, x25]
10604b6c4: 900d0608    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10604b6c8: f947a501    	ldr	x1, [x8, #0xf48] ; width
10604b6cc: 946f6e9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b6d0: 1e604008    	fmov	d8, d0
10604b6d4: f8796a60    	ldr	x0, [x19, x25]
10604b6d8: f00d05a8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10604b6dc: f9449d01    	ldr	x1, [x8, #0x938] ; height
10604b6e0: 946f6e97    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b6e4: 1e604001    	fmov	d1, d0
10604b6e8: f8746a60    	ldr	x0, [x19, x20]
10604b6ec: d00d05e8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
10604b6f0: f9453d01    	ldr	x1, [x8, #0xa78] ; setSize:
10604b6f4: 1e604100    	fmov	d0, d8
10604b6f8: 946f6e91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b6fc: f8796a60    	ldr	x0, [x19, x25]
10604b700: d00d05a8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
10604b704: f945a101    	ldr	x1, [x8, #0xb40] ; frame
10604b708: 946f6e8d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b70c: f00cef88    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
10604b710: f9412501    	ldr	x1, [x8, #0x248] ; setFrameForBgImageView:
10604b714: aa1303e0    	mov	x0, x19
10604b718: 946f6e89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b71c: f8746a60    	ldr	x0, [x19, x20]
10604b720: 900d05c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10604b724: f9469515    	ldr	x21, [x8, #0xd28] ; layer
10604b728: aa1503e1    	mov	x1, x21
10604b72c: 946f6e84    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b730: aa1d03fd    	mov	x29, x29
10604b734: 946f6e85    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604b738: aa0003f6    	mov	x22, x0
10604b73c: 900d05e8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10604b740: f943e901    	ldr	x1, [x8, #0x7d0] ; setCornerRadius:
10604b744: 1e621000    	fmov	d0, #4.00000000
10604b748: 946f6e7d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b74c: aa1603e0    	mov	x0, x22
10604b750: 946f6e81    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604b754: 900d0948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10604b758: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
10604b75c: b00d05a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10604b760: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10604b764: 946f6e76    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b768: aa1d03fd    	mov	x29, x29
10604b76c: 946f6e77    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604b770: aa0003f6    	mov	x22, x0
10604b774: b00d0948    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10604b778: f9404100    	ldr	x0, [x8, #0x80]
10604b77c: 900d05a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10604b780: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10604b784: 946f6e6e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b788: aa0003e2    	mov	x2, x0
10604b78c: d00cef68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10604b790: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10604b794: aa1603e0    	mov	x0, x22
10604b798: 946f6e69    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b79c: aa1d03fd    	mov	x29, x29
10604b7a0: 946f6e6a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604b7a4: aa0003f7    	mov	x23, x0
10604b7a8: b00cef88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10604b7ac: f9400501    	ldr	x1, [x8, #0x8] ; colorList
10604b7b0: 946f6e63    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b7b4: aa1d03fd    	mov	x29, x29
10604b7b8: 946f6e64    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604b7bc: aa0003f8    	mov	x24, x0
10604b7c0: b00cef88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10604b7c4: f9416901    	ldr	x1, [x8, #0x2d0] ; getColorByName:withAlpha:
10604b7c8: b00c22a2    	adrp	x2, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
10604b7cc: 9126a042    	add	x2, x2, #0x9a8
10604b7d0: d00969a8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10604b7d4: fd42d100    	ldr	d0, [x8, #0x5a0]
10604b7d8: 946f6e59    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b7dc: aa1d03fd    	mov	x29, x29
10604b7e0: 946f6e5a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604b7e4: aa0003f9    	mov	x25, x0
10604b7e8: 946f6e54    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10604b7ec: b40000a0    	cbz	x0, 0x10604b800 <_Flutter_MMFoundation_BindContext+0x25273e4>
10604b7f0: aa1903e0    	mov	x0, x25
10604b7f4: 946f6e51    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10604b7f8: aa1903fa    	mov	x26, x25
10604b7fc: 14000009    	b	0x10604b820 <_Flutter_MMFoundation_BindContext+0x2527404>
10604b800: 900d0948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10604b804: f9463100    	ldr	x0, [x8, #0xc60]
10604b808: 900d05a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10604b80c: f947dd01    	ldr	x1, [x8, #0xfb8] ; clearColor
10604b810: 946f6e4b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b814: aa1d03fd    	mov	x29, x29
10604b818: 946f6e4c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604b81c: aa0003fa    	mov	x26, x0
10604b820: aa1903e0    	mov	x0, x25
10604b824: 946f6e4c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604b828: aa1a03e0    	mov	x0, x26
10604b82c: 946f6e5f    	bl	0x107c271a8 <_Flutter_MMFoundation_BindContext+0x4102d8c>
10604b830: f00d0588    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10604b834: f942f501    	ldr	x1, [x8, #0x5e8] ; CGColor
10604b838: 946f6e41    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b83c: aa0003fb    	mov	x27, x0
10604b840: f8746a60    	ldr	x0, [x19, x20]
10604b844: aa1503e1    	mov	x1, x21
10604b848: 946f6e3d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b84c: aa1d03fd    	mov	x29, x29
10604b850: 946f6e3e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604b854: aa0003fc    	mov	x28, x0
10604b858: 900d05e8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10604b85c: f9416501    	ldr	x1, [x8, #0x2c8] ; setBorderColor:
10604b860: aa1b03e2    	mov	x2, x27
10604b864: 946f6e36    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b868: aa1c03e0    	mov	x0, x28
10604b86c: 946f6e3a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604b870: aa1a03e0    	mov	x0, x26
10604b874: 946f6e38    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604b878: aa1903e0    	mov	x0, x25
10604b87c: 946f6e36    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604b880: aa1803e0    	mov	x0, x24
10604b884: 946f6e34    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604b888: aa1703e0    	mov	x0, x23
10604b88c: 946f6e32    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604b890: aa1603e0    	mov	x0, x22
10604b894: 946f6e30    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604b898: b00d0948    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10604b89c: f9406100    	ldr	x0, [x8, #0xc0]
10604b8a0: b00d05c8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10604b8a4: f9413101    	ldr	x1, [x8, #0x260] ; mainScreen
10604b8a8: 946f6e25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b8ac: aa1d03fd    	mov	x29, x29
10604b8b0: 946f6e26    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604b8b4: aa0003f6    	mov	x22, x0
10604b8b8: f00d05c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10604b8bc: f944d901    	ldr	x1, [x8, #0x9b0] ; scale
10604b8c0: 946f6e1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b8c4: 1e6e1001    	fmov	d1, #1.00000000
10604b8c8: f8746a60    	ldr	x0, [x19, x20]
10604b8cc: 1e601828    	fdiv	d8, d1, d0
10604b8d0: aa1503e1    	mov	x1, x21
10604b8d4: 946f6e1a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b8d8: aa1d03fd    	mov	x29, x29
10604b8dc: 946f6e1b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604b8e0: aa0003f7    	mov	x23, x0
10604b8e4: 900d05e8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10604b8e8: f9416d01    	ldr	x1, [x8, #0x2d8] ; setBorderWidth:
10604b8ec: 1e604100    	fmov	d0, d8
10604b8f0: 946f6e13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b8f4: aa1703e0    	mov	x0, x23
10604b8f8: 946f6e17    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604b8fc: aa1603e0    	mov	x0, x22
10604b900: 946f6e15    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604b904: f8746a60    	ldr	x0, [x19, x20]
10604b908: aa1503e1    	mov	x1, x21
10604b90c: 946f6e0c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b910: aa1d03fd    	mov	x29, x29
10604b914: 946f6e0d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604b918: aa0003f5    	mov	x21, x0
10604b91c: b00d05e8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10604b920: f9462501    	ldr	x1, [x8, #0xc48] ; setMasksToBounds:
10604b924: 52800022    	mov	w2, #0x1                ; =1
10604b928: 946f6e05    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b92c: aa1503e0    	mov	x0, x21
10604b930: 946f6e09    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604b934: aa1303e0    	mov	x0, x19
10604b938: f9402ffb    	ldr	x27, [sp, #0x58]
10604b93c: aa1b03e1    	mov	x1, x27
10604b940: 946f6dff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b944: aa1d03fd    	mov	x29, x29
10604b948: 946f6e00    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604b94c: aa0003f5    	mov	x21, x0
10604b950: d00cf408    	adrp	x8, 0x11fecd000 <dyld_stub_binder+0x11fecd000>
10604b954: f943e501    	ldr	x1, [x8, #0x7c8] ; isComponentHidden
10604b958: 946f6df9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b95c: aa0003e2    	mov	x2, x0
10604b960: f8746a60    	ldr	x0, [x19, x20]
10604b964: b00d05e8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10604b968: f9411101    	ldr	x1, [x8, #0x220] ; setHidden:
10604b96c: 946f6df4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b970: aa1503e0    	mov	x0, x21
10604b974: 946f6df8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604b978: 900d0954    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
10604b97c: f9463697    	ldr	x23, [x20, #0xc68] ; 0�d 
10604b980: aa1303e0    	mov	x0, x19
10604b984: aa1b03e1    	mov	x1, x27
10604b988: 946f6ded    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b98c: aa1d03fd    	mov	x29, x29
10604b990: 946f6dee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604b994: aa0003f8    	mov	x24, x0
10604b998: f00cef88    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
10604b99c: f9410515    	ldr	x21, [x8, #0x208] ; messageWrap
10604b9a0: aa1503e1    	mov	x1, x21
10604b9a4: 946f6de6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b9a8: aa1d03fd    	mov	x29, x29
10604b9ac: 946f6de7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604b9b0: aa0003f9    	mov	x25, x0
10604b9b4: b00cf088    	adrp	x8, 0x11fe5c000 <dyld_stub_binder+0x11fe5c000>
10604b9b8: f9440901    	ldr	x1, [x8, #0x810] ; getFormatVideoPath
10604b9bc: 946f6de0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b9c0: aa1d03fd    	mov	x29, x29
10604b9c4: 946f6de1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604b9c8: aa0003fa    	mov	x26, x0
10604b9cc: d00cef68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10604b9d0: f9467916    	ldr	x22, [x8, #0xcf0] ; FileExist:
10604b9d4: aa1703e0    	mov	x0, x23
10604b9d8: aa1603e1    	mov	x1, x22
10604b9dc: aa1a03e2    	mov	x2, x26
10604b9e0: 946f6dd7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604b9e4: aa0003f7    	mov	x23, x0
10604b9e8: aa1a03e0    	mov	x0, x26
10604b9ec: 946f6dda    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604b9f0: aa1903e0    	mov	x0, x25
10604b9f4: 946f6dd8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604b9f8: aa1803e0    	mov	x0, x24
10604b9fc: 946f6dd6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604ba00: 340008f7    	cbz	w23, 0x10604bb1c <_Flutter_MMFoundation_BindContext+0x2527700>
10604ba04: aa1303e0    	mov	x0, x19
10604ba08: aa1b03e1    	mov	x1, x27
10604ba0c: 946f6dcc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604ba10: aa1d03fd    	mov	x29, x29
10604ba14: 946f6dcd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604ba18: aa0003f7    	mov	x23, x0
10604ba1c: aa1503e1    	mov	x1, x21
10604ba20: 946f6dc7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604ba24: aa1d03fd    	mov	x29, x29
10604ba28: 946f6dc8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604ba2c: aa0003f8    	mov	x24, x0
10604ba30: b00cf028    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
10604ba34: f9426501    	ldr	x1, [x8, #0x4c8] ; isRawVideo
10604ba38: 946f6dc1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604ba3c: aa0003f9    	mov	x25, x0
10604ba40: aa1803e0    	mov	x0, x24
10604ba44: 946f6dc4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604ba48: aa1703e0    	mov	x0, x23
10604ba4c: 946f6dc2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604ba50: 340003f9    	cbz	w25, 0x10604bacc <_Flutter_MMFoundation_BindContext+0x25276b0>
10604ba54: f9463697    	ldr	x23, [x20, #0xc68] ; 0�d 
10604ba58: aa1303e0    	mov	x0, x19
10604ba5c: aa1b03e1    	mov	x1, x27
10604ba60: 946f6db7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604ba64: aa1d03fd    	mov	x29, x29
10604ba68: 946f6db8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604ba6c: aa0003f8    	mov	x24, x0
10604ba70: aa1503e1    	mov	x1, x21
10604ba74: 946f6db2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604ba78: aa1d03fd    	mov	x29, x29
10604ba7c: 946f6db3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604ba80: aa0003f9    	mov	x25, x0
10604ba84: d00cf0a8    	adrp	x8, 0x11fe61000 <dyld_stub_binder+0x11fe61000>
10604ba88: f947b901    	ldr	x1, [x8, #0xf70] ; getRawFormatPath
10604ba8c: 946f6dac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604ba90: aa1d03fd    	mov	x29, x29
10604ba94: 946f6dad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604ba98: aa0003fa    	mov	x26, x0
10604ba9c: aa1703e0    	mov	x0, x23
10604baa0: aa1603e1    	mov	x1, x22
10604baa4: aa1a03e2    	mov	x2, x26
10604baa8: 946f6da5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604baac: aa0003f6    	mov	x22, x0
10604bab0: aa1a03e0    	mov	x0, x26
10604bab4: 946f6da8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604bab8: aa1903e0    	mov	x0, x25
10604babc: 946f6da6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604bac0: aa1803e0    	mov	x0, x24
10604bac4: 946f6da4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604bac8: 360002b6    	tbz	w22, #0x0, 0x10604bb1c <_Flutter_MMFoundation_BindContext+0x2527700>
10604bacc: aa1303e0    	mov	x0, x19
10604bad0: aa1b03e1    	mov	x1, x27
10604bad4: 946f6d9a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604bad8: aa1d03fd    	mov	x29, x29
10604badc: 946f6d9b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604bae0: aa0003f6    	mov	x22, x0
10604bae4: 900cefa8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10604bae8: f940d501    	ldr	x1, [x8, #0x1a8] ; isSender
10604baec: 946f6d94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604baf0: aa0003f7    	mov	x23, x0
10604baf4: aa1603e0    	mov	x0, x22
10604baf8: 946f6d97    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604bafc: f00d0f48    	adrp	x8, 0x120236000 <dyld_stub_binder+0x120236000>
10604bb00: b98fed14    	ldrsw	x20, [x8, #0xfec]
10604bb04: 340004d7    	cbz	w23, 0x10604bb9c <_Flutter_MMFoundation_BindContext+0x2527780>
10604bb08: 52800029    	mov	w9, #0x1                ; =1
10604bb0c: 52800028    	mov	w8, #0x1                ; =1
10604bb10: f9002be8    	str	x8, [sp, #0x50]
10604bb14: b8346a69    	str	w9, [x19, x20]
10604bb18: 1400003d    	b	0x10604bc0c <_Flutter_MMFoundation_BindContext+0x25277f0>
10604bb1c: aa1303e0    	mov	x0, x19
10604bb20: aa1b03e1    	mov	x1, x27
10604bb24: 946f6d86    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604bb28: aa1d03fd    	mov	x29, x29
10604bb2c: 946f6d87    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604bb30: aa0003f6    	mov	x22, x0
10604bb34: 900cefa8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10604bb38: f940d501    	ldr	x1, [x8, #0x1a8] ; isSender
10604bb3c: 946f6d80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604bb40: 340001e0    	cbz	w0, 0x10604bb7c <_Flutter_MMFoundation_BindContext+0x2527760>
10604bb44: aa1303e0    	mov	x0, x19
10604bb48: aa1b03e1    	mov	x1, x27
10604bb4c: 946f6d7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604bb50: aa1d03fd    	mov	x29, x29
10604bb54: 946f6d7d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604bb58: aa0003f7    	mov	x23, x0
10604bb5c: b00cf2c8    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
10604bb60: f9453518    	ldr	x24, [x8, #0xa68] ; msgStatus
10604bb64: aa1803e1    	mov	x1, x24
10604bb68: 946f6d75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604bb6c: 7100081f    	cmp	w0, #0x2
10604bb70: 54000221    	b.ne	0x10604bbb4 <_Flutter_MMFoundation_BindContext+0x2527798>
10604bb74: aa1703e0    	mov	x0, x23
10604bb78: 946f6d77    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604bb7c: aa1603e0    	mov	x0, x22
10604bb80: 946f6d75    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604bb84: f9002bff    	str	xzr, [sp, #0x50]
10604bb88: f00d0f48    	adrp	x8, 0x120236000 <dyld_stub_binder+0x120236000>
10604bb8c: b98fed14    	ldrsw	x20, [x8, #0xfec]
10604bb90: 52800048    	mov	w8, #0x2                ; =2
10604bb94: b8346a68    	str	w8, [x19, x20]
10604bb98: 14000004    	b	0x10604bba8 <_Flutter_MMFoundation_BindContext+0x252778c>
10604bb9c: b8346a7f    	str	wzr, [x19, x20]
10604bba0: 52800028    	mov	w8, #0x1                ; =1
10604bba4: f9002be8    	str	x8, [sp, #0x50]
10604bba8: 900c3628    	adrp	x8, 0x11e70f000 <dyld_stub_binder+0x11e70f000>
10604bbac: 91212108    	add	x8, x8, #0x848
10604bbb0: 14000019    	b	0x10604bc14 <_Flutter_MMFoundation_BindContext+0x25277f8>
10604bbb4: aa1303e0    	mov	x0, x19
10604bbb8: aa1b03e1    	mov	x1, x27
10604bbbc: 946f6d60    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604bbc0: aa1d03fd    	mov	x29, x29
10604bbc4: 946f6d61    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604bbc8: aa0003f9    	mov	x25, x0
10604bbcc: aa1803e1    	mov	x1, x24
10604bbd0: 946f6d5b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604bbd4: aa0003f8    	mov	x24, x0
10604bbd8: aa1903e0    	mov	x0, x25
10604bbdc: 946f6d5e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604bbe0: aa1703e0    	mov	x0, x23
10604bbe4: 946f6d5c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604bbe8: aa1603e0    	mov	x0, x22
10604bbec: 946f6d5a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604bbf0: 71000f1f    	cmp	w24, #0x3
10604bbf4: 54fffc80    	b.eq	0x10604bb84 <_Flutter_MMFoundation_BindContext+0x2527768>
10604bbf8: f9002bff    	str	xzr, [sp, #0x50]
10604bbfc: f00d0f48    	adrp	x8, 0x120236000 <dyld_stub_binder+0x120236000>
10604bc00: b98fed14    	ldrsw	x20, [x8, #0xfec]
10604bc04: 52800028    	mov	w8, #0x1                ; =1
10604bc08: b8346a68    	str	w8, [x19, x20]
10604bc0c: f00c3388    	adrp	x8, 0x11e6be000 <dyld_stub_binder+0x11e6be000>
10604bc10: 91372108    	add	x8, x8, #0xdc8
10604bc14: f90023e8    	str	x8, [sp, #0x40]
10604bc18: 900d0948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10604bc1c: f9453508    	ldr	x8, [x8, #0xa68] ; �gH 
10604bc20: f9001fe8    	str	x8, [sp, #0x38]
10604bc24: aa1303e0    	mov	x0, x19
10604bc28: aa1b03e1    	mov	x1, x27
10604bc2c: 946f6d44    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604bc30: aa1d03fd    	mov	x29, x29
10604bc34: 946f6d45    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604bc38: f90027e0    	str	x0, [sp, #0x48]
10604bc3c: aa1503e1    	mov	x1, x21
10604bc40: 946f6d3f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604bc44: aa1d03fd    	mov	x29, x29
10604bc48: 946f6d40    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604bc4c: aa0003f7    	mov	x23, x0
10604bc50: b00cef88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10604bc54: f947d101    	ldr	x1, [x8, #0xfa0] ; m_uiMesLocalID
10604bc58: 946f6d39    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604bc5c: aa0003f6    	mov	x22, x0
10604bc60: b8746a78    	ldr	w24, [x19, x20]
10604bc64: aa1303e0    	mov	x0, x19
10604bc68: aa1b03e1    	mov	x1, x27
10604bc6c: 946f6d34    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604bc70: aa1d03fd    	mov	x29, x29
10604bc74: 946f6d35    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604bc78: aa0003f9    	mov	x25, x0
10604bc7c: aa1503e1    	mov	x1, x21
10604bc80: 946f6d2f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604bc84: aa1d03fd    	mov	x29, x29
10604bc88: 946f6d30    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604bc8c: aa0003fa    	mov	x26, x0
10604bc90: 900cef88    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10604bc94: f9450101    	ldr	x1, [x8, #0xa00] ; m_uiStatus
10604bc98: 946f6d29    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604bc9c: aa0003fc    	mov	x28, x0
10604bca0: aa1303e0    	mov	x0, x19
10604bca4: aa1b03e1    	mov	x1, x27
10604bca8: 946f6d25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604bcac: aa1d03fd    	mov	x29, x29
10604bcb0: 946f6d26    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604bcb4: aa0003f4    	mov	x20, x0
10604bcb8: aa1503e1    	mov	x1, x21
10604bcbc: 946f6d20    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604bcc0: aa1d03fd    	mov	x29, x29
10604bcc4: 946f6d21    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10604bcc8: aa0003f5    	mov	x21, x0
10604bccc: 900cefa8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10604bcd0: f9411101    	ldr	x1, [x8, #0x220] ; m_uiDownloadStatus
10604bcd4: 946f6d1a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604bcd8: d00cef68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10604bcdc: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10604bce0: f9402be8    	ldr	x8, [sp, #0x50]
10604bce4: a902a3e0    	stp	x0, x8, [sp, #0x28]
10604bce8: a901f3f8    	stp	x24, x28, [sp, #0x18]
10604bcec: b00c40e8    	adrp	x8, 0x11e868000 <dyld_stub_binder+0x11e868000>
10604bcf0: 91102108    	add	x8, x8, #0x408
10604bcf4: 900ac965    	adrp	x5, 0x11b977000 <dyld_stub_binder+0x11b977000>
10604bcf8: 910388a5    	add	x5, x5, #0xe2
10604bcfc: a943a7e0    	ldp	x0, x9, [sp, #0x38]
10604bd00: a900a7f6    	stp	x22, x9, [sp, #0x8]
10604bd04: 900ac967    	adrp	x7, 0x11b977000 <dyld_stub_binder+0x11b977000>
10604bd08: 9103e8e7    	add	x7, x7, #0xfa
10604bd0c: f90003e8    	str	x8, [sp]
10604bd10: 52800022    	mov	w2, #0x1                ; =1
10604bd14: d2800003    	mov	x3, #0x0                ; =0
10604bd18: 52800004    	mov	w4, #0x0                ; =0
10604bd1c: 528019a6    	mov	w6, #0xcd               ; =205
10604bd20: 946f6d07    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10604bd24: aa1503e0    	mov	x0, x21
10604bd28: 946f6d0b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604bd2c: aa1403e0    	mov	x0, x20
10604bd30: 946f6d09    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604bd34: aa1a03e0    	mov	x0, x26
10604bd38: 946f6d07    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604bd3c: aa1903e0    	mov	x0, x25
10604bd40: 946f6d05    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604bd44: aa1703e0    	mov	x0, x23
10604bd48: 946f6d03    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604bd4c: f94027e0    	ldr	x0, [sp, #0x48]
10604bd50: 946f6d01    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10604bd54: d00cef68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10604bd58: f9467101    	ldr	x1, [x8, #0xce0] ; updateStatus
10604bd5c: aa1303e0    	mov	x0, x19
10604bd60: a94c7bfd    	ldp	x29, x30, [sp, #0xc0]
10604bd64: a94b4ff4    	ldp	x20, x19, [sp, #0xb0]
10604bd68: a94a57f6    	ldp	x22, x21, [sp, #0xa0]
10604bd6c: a9495ff8    	ldp	x24, x23, [sp, #0x90]
10604bd70: a94867fa    	ldp	x26, x25, [sp, #0x80]
10604bd74: a9476ffc    	ldp	x28, x27, [sp, #0x70]
10604bd78: 6d4623e9    	ldp	d9, d8, [sp, #0x60]
10604bd7c: 910343ff    	add	sp, sp, #0xd0
10604bd80: 146f6cef    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>