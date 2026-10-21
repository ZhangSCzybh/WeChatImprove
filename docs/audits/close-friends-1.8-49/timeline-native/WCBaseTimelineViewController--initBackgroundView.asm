
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106b58628: 6db92beb    	stp	d11, d10, [sp, #-0x70]!
106b5862c: 6d0123e9    	stp	d9, d8, [sp, #0x10]
106b58630: a90267fa    	stp	x26, x25, [sp, #0x20]
106b58634: a9035ff8    	stp	x24, x23, [sp, #0x30]
106b58638: a90457f6    	stp	x22, x21, [sp, #0x40]
106b5863c: a9054ff4    	stp	x20, x19, [sp, #0x50]
106b58640: a9067bfd    	stp	x29, x30, [sp, #0x60]
106b58644: 910183fd    	add	x29, sp, #0x60
106b58648: aa0003f3    	mov	x19, x0
106b5864c: b00d0768    	adrp	x8, 0x120c45000 <dyld_stub_binder+0x120c45000>
106b58650: 52800029    	mov	w9, #0x1                ; =1
106b58654: 3929a909    	strb	w9, [x8, #0xa6a]
106b58658: f00cad28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106b5865c: f942f914    	ldr	x20, [x8, #0x5f0] ; backgroundView
106b58660: aa1403e1    	mov	x1, x20
106b58664: 94433ab6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b58668: aa1d03fd    	mov	x29, x29
106b5866c: 94433ab7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106b58670: aa0003f5    	mov	x21, x0
106b58674: 94433ab8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106b58678: b4000135    	cbz	x21, 0x106b5869c <_Flutter_MMFoundation_BindContext+0x3034280>
106b5867c: a9467bfd    	ldp	x29, x30, [sp, #0x60]
106b58680: a9454ff4    	ldp	x20, x19, [sp, #0x50]
106b58684: a94457f6    	ldp	x22, x21, [sp, #0x40]
106b58688: a9435ff8    	ldp	x24, x23, [sp, #0x30]
106b5868c: a94267fa    	ldp	x26, x25, [sp, #0x20]
106b58690: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
106b58694: 6cc72beb    	ldp	d11, d10, [sp], #0x70
106b58698: d65f03c0    	ret
106b5869c: f00cb0c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106b586a0: f9474d00    	ldr	x0, [x8, #0xe98]
106b586a4: 94433aad    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
106b586a8: aa0003f5    	mov	x21, x0
106b586ac: f00c9888    	adrp	x8, 0x11fe6b000 <dyld_stub_binder+0x11fe6b000>
106b586b0: f9457d01    	ldr	x1, [x8, #0xaf8] ; setBackgroundView:
106b586b4: aa1303e0    	mov	x0, x19
106b586b8: aa1503e2    	mov	x2, x21
106b586bc: 94433aa0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b586c0: aa1503e0    	mov	x0, x21
106b586c4: 94433aa4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106b586c8: 900c9728    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106b586cc: f9419516    	ldr	x22, [x8, #0x328] ; getVisibleHeight
106b586d0: aa1303e0    	mov	x0, x19
106b586d4: aa1603e1    	mov	x1, x22
106b586d8: 94433a99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b586dc: 1e604008    	fmov	d8, d0
106b586e0: f00cad88    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
106b586e4: f946d515    	ldr	x21, [x8, #0xda8] ; view
106b586e8: aa1303e0    	mov	x0, x19
106b586ec: aa1503e1    	mov	x1, x21
106b586f0: 94433a93    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b586f4: aa1d03fd    	mov	x29, x29
106b586f8: 94433a94    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106b586fc: aa0003f7    	mov	x23, x0
106b58700: f00cad88    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
106b58704: f947a501    	ldr	x1, [x8, #0xf48] ; width
106b58708: 94433a8d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b5870c: 1e604009    	fmov	d9, d0
106b58710: aa1303e0    	mov	x0, x19
106b58714: aa1603e1    	mov	x1, x22
106b58718: 94433a89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b5871c: 1e60400a    	fmov	d10, d0
106b58720: aa1303e0    	mov	x0, x19
106b58724: aa1403e1    	mov	x1, x20
106b58728: 94433a85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b5872c: aa1d03fd    	mov	x29, x29
106b58730: 94433a86    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106b58734: aa0003f6    	mov	x22, x0
106b58738: 900cad88    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
106b5873c: f9403501    	ldr	x1, [x8, #0x68] ; setFrame:
106b58740: 9e6703e0    	fmov	d0, xzr
106b58744: 1e604101    	fmov	d1, d8
106b58748: 1e604122    	fmov	d2, d9
106b5874c: 1e604143    	fmov	d3, d10
106b58750: 94433a7b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b58754: aa1603e0    	mov	x0, x22
106b58758: 94433a7f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106b5875c: aa1703e0    	mov	x0, x23
106b58760: 94433a7d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106b58764: aa1303e0    	mov	x0, x19
106b58768: aa1403e1    	mov	x1, x20
106b5876c: 94433a74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b58770: aa1d03fd    	mov	x29, x29
106b58774: 94433a75    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106b58778: aa0003f6    	mov	x22, x0
106b5877c: f00cad68    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
106b58780: f9406501    	ldr	x1, [x8, #0xc8] ; setAutoresizingMask:
106b58784: 52800042    	mov	w2, #0x2                ; =2
106b58788: 94433a6d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b5878c: aa1603e0    	mov	x0, x22
106b58790: 94433a71    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106b58794: aa1303e0    	mov	x0, x19
106b58798: aa1403e1    	mov	x1, x20
106b5879c: 94433a68    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b587a0: aa1d03fd    	mov	x29, x29
106b587a4: 94433a69    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106b587a8: aa0003f6    	mov	x22, x0
106b587ac: f00cb0c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106b587b0: f9462d00    	ldr	x0, [x8, #0xc58]
106b587b4: d00c9a28    	adrp	x8, 0x11fe9e000 <dyld_stub_binder+0x11fe9e000>
106b587b8: f9402501    	ldr	x1, [x8, #0x48] ; toolBarBlur
106b587bc: 94433a60    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b587c0: aa1d03fd    	mov	x29, x29
106b587c4: 94433a61    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106b587c8: aa0003f7    	mov	x23, x0
106b587cc: f00c9768    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
106b587d0: f9452501    	ldr	x1, [x8, #0xa48] ; addBlurEffectWithColor:
106b587d4: aa1603e0    	mov	x0, x22
106b587d8: aa1703e2    	mov	x2, x23
106b587dc: 94433a58    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b587e0: aa1703e0    	mov	x0, x23
106b587e4: 94433a5c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106b587e8: aa1603e0    	mov	x0, x22
106b587ec: 94433a5a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106b587f0: aa1303e0    	mov	x0, x19
106b587f4: aa1403e1    	mov	x1, x20
106b587f8: 94433a51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b587fc: aa1d03fd    	mov	x29, x29
106b58800: 94433a52    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106b58804: aa0003f6    	mov	x22, x0
106b58808: 900cad88    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
106b5880c: f942f501    	ldr	x1, [x8, #0x5e8] ; setIsAccessibilityElement:
106b58810: 52800022    	mov	w2, #0x1                ; =1
106b58814: 94433a4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b58818: aa1603e0    	mov	x0, x22
106b5881c: 94433a4e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106b58820: f00cb0c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106b58824: f945e900    	ldr	x0, [x8, #0xbd0]
106b58828: 900cad48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106b5882c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
106b58830: 94433a43    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b58834: aa1d03fd    	mov	x29, x29
106b58838: 94433a44    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106b5883c: aa0003f6    	mov	x22, x0
106b58840: f00cb0c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106b58844: f9462900    	ldr	x0, [x8, #0xc50]
106b58848: f00cad28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106b5884c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
106b58850: 94433a3b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b58854: aa0003e2    	mov	x2, x0
106b58858: b00c9708    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106b5885c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
106b58860: aa1603e0    	mov	x0, x22
106b58864: 94433a36    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b58868: aa1d03fd    	mov	x29, x29
106b5886c: 94433a37    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106b58870: aa0003f7    	mov	x23, x0
106b58874: b00c9708    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106b58878: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
106b5887c: d00bd062    	adrp	x2, 0x11e566000 <dyld_stub_binder+0x11e566000>
106b58880: 9123a042    	add	x2, x2, #0x8e8
106b58884: 94433a2e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b58888: aa1d03fd    	mov	x29, x29
106b5888c: 94433a2f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106b58890: aa0003f8    	mov	x24, x0
106b58894: aa1303e0    	mov	x0, x19
106b58898: aa1403e1    	mov	x1, x20
106b5889c: 94433a28    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b588a0: aa1d03fd    	mov	x29, x29
106b588a4: 94433a29    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106b588a8: aa0003f9    	mov	x25, x0
106b588ac: d00cad68    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
106b588b0: f946bd01    	ldr	x1, [x8, #0xd78] ; setAccessibilityLabel:
106b588b4: aa1803e2    	mov	x2, x24
106b588b8: 94433a21    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b588bc: aa1903e0    	mov	x0, x25
106b588c0: 94433a25    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106b588c4: aa1803e0    	mov	x0, x24
106b588c8: 94433a23    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106b588cc: aa1703e0    	mov	x0, x23
106b588d0: 94433a21    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106b588d4: aa1603e0    	mov	x0, x22
106b588d8: 94433a1f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106b588dc: aa1303e0    	mov	x0, x19
106b588e0: aa1503e1    	mov	x1, x21
106b588e4: 94433a16    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b588e8: aa1d03fd    	mov	x29, x29
106b588ec: 94433a17    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106b588f0: aa0003f5    	mov	x21, x0
106b588f4: aa1303e0    	mov	x0, x19
106b588f8: aa1403e1    	mov	x1, x20
106b588fc: 94433a10    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b58900: aa1d03fd    	mov	x29, x29
106b58904: 94433a11    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106b58908: aa0003f4    	mov	x20, x0
106b5890c: d00cb748    	adrp	x8, 0x120242000 <dyld_stub_binder+0x120242000>
106b58910: b9849908    	ldrsw	x8, [x8, #0x498]
106b58914: f8686a63    	ldr	x3, [x19, x8]
106b58918: f00cad48    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106b5891c: f9422501    	ldr	x1, [x8, #0x448] ; insertSubview:belowSubview:
106b58920: aa1503e0    	mov	x0, x21
106b58924: aa1403e2    	mov	x2, x20
106b58928: 94433a05    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b5892c: aa1403e0    	mov	x0, x20
106b58930: 94433a09    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106b58934: aa1503e0    	mov	x0, x21
106b58938: a9467bfd    	ldp	x29, x30, [sp, #0x60]
106b5893c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
106b58940: a94457f6    	ldp	x22, x21, [sp, #0x40]
106b58944: a9435ff8    	ldp	x24, x23, [sp, #0x30]
106b58948: a94267fa    	ldp	x26, x25, [sp, #0x20]
106b5894c: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
106b58950: 6cc72beb    	ldp	d11, d10, [sp], #0x70
106b58954: 14433a00    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
