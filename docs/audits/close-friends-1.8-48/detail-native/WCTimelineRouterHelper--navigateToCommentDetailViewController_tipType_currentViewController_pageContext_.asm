
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a165368: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
10a16536c: a90157f6    	stp	x22, x21, [sp, #0x10]
10a165370: a9024ff4    	stp	x20, x19, [sp, #0x20]
10a165374: a9037bfd    	stp	x29, x30, [sp, #0x30]
10a165378: 9100c3fd    	add	x29, sp, #0x30
10a16537c: aa0503f3    	mov	x19, x5
10a165380: aa0403f4    	mov	x20, x4
10a165384: aa0303f6    	mov	x22, x3
10a165388: aa0203f5    	mov	x21, x2
10a16538c: aa0003f7    	mov	x23, x0
10a165390: 900b5768    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a165394: 52800029    	mov	w9, #0x1                ; =1
10a165398: 391c0909    	strb	w9, [x8, #0x702]
10a16539c: aa0503e0    	mov	x0, x5
10a1653a0: 955bd828    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a1653a4: d00af4c8    	adrp	x8, 0x11ffff000 <dyld_stub_binder+0x11ffff000>
10a1653a8: f9445518    	ldr	x24, [x8, #0x8a8] ; isFlutterDetailEnabled
10a1653ac: aa1403e0    	mov	x0, x20
10a1653b0: 955bd824    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a1653b4: aa1503e0    	mov	x0, x21
10a1653b8: 955bd822    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a1653bc: aa1703e0    	mov	x0, x23
10a1653c0: aa1803e1    	mov	x1, x24
10a1653c4: 955bd820    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1653c8: 34000200    	cbz	w0, 0x10a165408 <_Flutter_MMFoundation_BindContext+0x6640fec>
10a1653cc: d00aeaa8    	adrp	x8, 0x11febb000 <dyld_stub_binder+0x11febb000>
10a1653d0: f9467101    	ldr	x1, [x8, #0xce0] ; isPrivate
10a1653d4: aa1503e0    	mov	x0, x21
10a1653d8: 955bd81b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1653dc: aa0003e4    	mov	x4, x0
10a1653e0: d00af9a8    	adrp	x8, 0x12009b000 <dyld_stub_binder+0x12009b000>
10a1653e4: f941c501    	ldr	x1, [x8, #0x388] ; navigateToFlutterDetailViewController:currentViewController:forbidComment:tipType:failedComment:canShowInvisibleTipsView:
10a1653e8: aa1703e0    	mov	x0, x23
10a1653ec: aa1503e2    	mov	x2, x21
10a1653f0: aa1403e3    	mov	x3, x20
10a1653f4: aa1603e5    	mov	x5, x22
10a1653f8: d2800006    	mov	x6, #0x0                ; =0
10a1653fc: 52800007    	mov	w7, #0x0                ; =0
10a165400: 955bd811    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165404: 1400002b    	b	0x10a1654b0 <_Flutter_MMFoundation_BindContext+0x6641094>
10a165408: b00b0088    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
10a16540c: f9441500    	ldr	x0, [x8, #0x828]
10a165410: 955bd814    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a165414: aa0003f7    	mov	x23, x0
10a165418: 900af4c8    	adrp	x8, 0x11fffd000 <dyld_stub_binder+0x11fffd000>
10a16541c: f947e501    	ldr	x1, [x8, #0xfc8] ; setPageContext:
10a165420: aa1303e2    	mov	x2, x19
10a165424: 955bd808    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165428: d00ae708    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
10a16542c: f9449d01    	ldr	x1, [x8, #0x938] ; setDataItem:
10a165430: aa1703e0    	mov	x0, x23
10a165434: aa1503e2    	mov	x2, x21
10a165438: 955bd803    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a16543c: aa1503e0    	mov	x0, x21
10a165440: 955bd807    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165444: d00ae848    	adrp	x8, 0x11fe6f000 <dyld_stub_binder+0x11fe6f000>
10a165448: f943f501    	ldr	x1, [x8, #0x7e8] ; setTipType:
10a16544c: aa1703e0    	mov	x0, x23
10a165450: aa1603e2    	mov	x2, x22
10a165454: 955bd7fc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165458: 900ae6a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a16545c: f946d101    	ldr	x1, [x8, #0xda0] ; setM_delegate:
10a165460: aa1703e0    	mov	x0, x23
10a165464: aa1403e2    	mov	x2, x20
10a165468: 955bd7f7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a16546c: f00afce8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10a165470: f945dd01    	ldr	x1, [x8, #0xbb8] ; navigationController
10a165474: aa1403e0    	mov	x0, x20
10a165478: 955bd7f3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a16547c: aa1d03fd    	mov	x29, x29
10a165480: 955bd7f4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a165484: aa0003f5    	mov	x21, x0
10a165488: aa1403e0    	mov	x0, x20
10a16548c: 955bd7f4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165490: d00ae6a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a165494: f944e101    	ldr	x1, [x8, #0x9c0] ; PushViewController:animated:
10a165498: aa1503e0    	mov	x0, x21
10a16549c: aa1703e2    	mov	x2, x23
10a1654a0: 52800023    	mov	w3, #0x1                ; =1
10a1654a4: 955bd7e8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1654a8: aa1503f4    	mov	x20, x21
10a1654ac: aa1703f5    	mov	x21, x23
10a1654b0: aa1403e0    	mov	x0, x20
10a1654b4: 955bd7ea    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1654b8: aa1503e0    	mov	x0, x21
10a1654bc: 955bd7e8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1654c0: aa1303e0    	mov	x0, x19
10a1654c4: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10a1654c8: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10a1654cc: a94157f6    	ldp	x22, x21, [sp, #0x10]
10a1654d0: a8c45ff8    	ldp	x24, x23, [sp], #0x40
10a1654d4: 155bd7e2    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
