
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a0b9320: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
10a0b9324: a9015ff8    	stp	x24, x23, [sp, #0x10]
10a0b9328: a90257f6    	stp	x22, x21, [sp, #0x20]
10a0b932c: a9034ff4    	stp	x20, x19, [sp, #0x30]
10a0b9330: a9047bfd    	stp	x29, x30, [sp, #0x40]
10a0b9334: 910103fd    	add	x29, sp, #0x40
10a0b9338: aa0003f3    	mov	x19, x0
10a0b933c: 900b5cc8    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a0b9340: 52800029    	mov	w9, #0x1                ; =1
10a0b9344: 3911cd09    	strb	w9, [x8, #0x473]
10a0b9348: f00b05e8    	adrp	x8, 0x120178000 <dyld_stub_binder+0x120178000>
10a0b934c: f9416900    	ldr	x0, [x8, #0x2d0]
10a0b9350: 955e8846    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
10a0b9354: aa0003f4    	mov	x20, x0
10a0b9358: d00b05c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0b935c: f9470100    	ldr	x0, [x8, #0xe00]
10a0b9360: f00aec08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a0b9364: f9419101    	ldr	x1, [x8, #0x320] ; pageScopeWidthFor:
10a0b9368: aa1303e2    	mov	x2, x19
10a0b936c: 955e8836    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9370: 1e604002    	fmov	d2, d0
10a0b9374: b00b0248    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10a0b9378: f947d915    	ldr	x21, [x8, #0xfb0] ; initWithFrame:
10a0b937c: d2e80928    	mov	x8, #0x4049000000000000 ; =4632233691727265792
10a0b9380: 9e670103    	fmov	d3, x8
10a0b9384: 9e6703e0    	fmov	d0, xzr
10a0b9388: 9e6703e1    	fmov	d1, xzr
10a0b938c: aa1403e0    	mov	x0, x20
10a0b9390: aa1503e1    	mov	x1, x21
10a0b9394: 955e882c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9398: aa0003f4    	mov	x20, x0
10a0b939c: d00aee48    	adrp	x8, 0x11fe83000 <dyld_stub_binder+0x11fe83000>
10a0b93a0: f941c501    	ldr	x1, [x8, #0x388] ; setFooterView:
10a0b93a4: aa1303e0    	mov	x0, x19
10a0b93a8: aa1403e2    	mov	x2, x20
10a0b93ac: 955e8826    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b93b0: aa1403e0    	mov	x0, x20
10a0b93b4: 955e882a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b93b8: b00aecc8    	adrp	x8, 0x11fe52000 <dyld_stub_binder+0x11fe52000>
10a0b93bc: f9403114    	ldr	x20, [x8, #0x60] ; footerView
10a0b93c0: aa1303e0    	mov	x0, x19
10a0b93c4: aa1403e1    	mov	x1, x20
10a0b93c8: 955e881f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b93cc: aa1d03fd    	mov	x29, x29
10a0b93d0: 955e8820    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b93d4: aa0003f6    	mov	x22, x0
10a0b93d8: d00aeee8    	adrp	x8, 0x11fe97000 <dyld_stub_binder+0x11fe97000>
10a0b93dc: f9449d01    	ldr	x1, [x8, #0x938] ; useMMSettingStyle
10a0b93e0: 955e8819    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b93e4: aa1603e0    	mov	x0, x22
10a0b93e8: 955e881d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b93ec: aa1303e0    	mov	x0, x19
10a0b93f0: aa1403e1    	mov	x1, x20
10a0b93f4: 955e8814    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b93f8: aa1d03fd    	mov	x29, x29
10a0b93fc: 955e8815    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b9400: aa0003f6    	mov	x22, x0
10a0b9404: f00aed08    	adrp	x8, 0x11fe5c000 <dyld_stub_binder+0x11fe5c000>
10a0b9408: f946e901    	ldr	x1, [x8, #0xdd0] ; setM_centerAlignLabel:
10a0b940c: 52800022    	mov	w2, #0x1                ; =1
10a0b9410: 955e880d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9414: aa1603e0    	mov	x0, x22
10a0b9418: 955e8811    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b941c: aa1303e0    	mov	x0, x19
10a0b9420: aa1403e1    	mov	x1, x20
10a0b9424: 955e8808    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9428: aa1d03fd    	mov	x29, x29
10a0b942c: 955e8809    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b9430: aa0003f6    	mov	x22, x0
10a0b9434: 900aed28    	adrp	x8, 0x11fe5d000 <dyld_stub_binder+0x11fe5d000>
10a0b9438: f9425901    	ldr	x1, [x8, #0x4b0] ; setM_heightLimit:
10a0b943c: d2f80b28    	mov	x8, #-0x3fa7000000000000 ; =-4586634745500139520
10a0b9440: 9e670100    	fmov	d0, x8
10a0b9444: 955e8800    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9448: aa1603e0    	mov	x0, x22
10a0b944c: 955e8804    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b9450: d00b05c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0b9454: f9462d00    	ldr	x0, [x8, #0xc58]
10a0b9458: f00aec08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a0b945c: f940a101    	ldr	x1, [x8, #0x140] ; cellBackgroundColor
10a0b9460: 955e87f9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9464: aa1d03fd    	mov	x29, x29
10a0b9468: 955e87fa    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b946c: aa0003f6    	mov	x22, x0
10a0b9470: aa1303e0    	mov	x0, x19
10a0b9474: aa1403e1    	mov	x1, x20
10a0b9478: 955e87f3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b947c: aa1d03fd    	mov	x29, x29
10a0b9480: 955e87f4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b9484: aa0003f7    	mov	x23, x0
10a0b9488: d00b0268    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10a0b948c: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
10a0b9490: aa1603e2    	mov	x2, x22
10a0b9494: 955e87ec    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9498: aa1703e0    	mov	x0, x23
10a0b949c: 955e87f0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b94a0: aa1603e0    	mov	x0, x22
10a0b94a4: 955e87ee    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b94a8: d00b05c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0b94ac: f945e900    	ldr	x0, [x8, #0xbd0]
10a0b94b0: f00b0228    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a0b94b4: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10a0b94b8: 955e87e3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b94bc: aa1d03fd    	mov	x29, x29
10a0b94c0: 955e87e4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b94c4: aa0003f6    	mov	x22, x0
10a0b94c8: f00b05c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a0b94cc: f9428500    	ldr	x0, [x8, #0x508]
10a0b94d0: d00b0228    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a0b94d4: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10a0b94d8: 955e87db    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b94dc: aa0003e2    	mov	x2, x0
10a0b94e0: 900aec08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0b94e4: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10a0b94e8: aa1603e0    	mov	x0, x22
10a0b94ec: 955e87d6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b94f0: aa1d03fd    	mov	x29, x29
10a0b94f4: 955e87d7    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b94f8: aa0003f7    	mov	x23, x0
10a0b94fc: f00aeee8    	adrp	x8, 0x11fe98000 <dyld_stub_binder+0x11fe98000>
10a0b9500: f9439501    	ldr	x1, [x8, #0x728] ; dynamicConfig
10a0b9504: 955e87d0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9508: aa1d03fd    	mov	x29, x29
10a0b950c: 955e87d1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b9510: aa0003f8    	mov	x24, x0
10a0b9514: 900aff08    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0b9518: f941a901    	ldr	x1, [x8, #0x350] ; Post_usesNewPostGuide
10a0b951c: 955e87ca    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9520: aa0003f9    	mov	x25, x0
10a0b9524: aa1803e0    	mov	x0, x24
10a0b9528: 955e87cd    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b952c: aa1703e0    	mov	x0, x23
10a0b9530: 955e87cb    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b9534: aa1603e0    	mov	x0, x22
10a0b9538: 955e87c9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b953c: 34000459    	cbz	w25, 0x10a0b95c4 <_Flutter_MMFoundation_BindContext+0x65951a8>
10a0b9540: d00b0788    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a0b9544: f941f900    	ldr	x0, [x8, #0x3f0] ; ОC
10a0b9548: 955e87c8    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
10a0b954c: aa0003f6    	mov	x22, x0
10a0b9550: aa1303e0    	mov	x0, x19
10a0b9554: aa1403e1    	mov	x1, x20
10a0b9558: 955e87bb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b955c: aa1d03fd    	mov	x29, x29
10a0b9560: 955e87bc    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b9564: aa0003f7    	mov	x23, x0
10a0b9568: d00b0228    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a0b956c: f943d501    	ldr	x1, [x8, #0x7a8] ; bounds
10a0b9570: 955e87b5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9574: aa1603e0    	mov	x0, x22
10a0b9578: aa1503e1    	mov	x1, x21
10a0b957c: 955e87b2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9580: aa0003f5    	mov	x21, x0
10a0b9584: aa1703e0    	mov	x0, x23
10a0b9588: 955e87b5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b958c: aa1303e0    	mov	x0, x19
10a0b9590: aa1403e1    	mov	x1, x20
10a0b9594: 955e87ac    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9598: aa1d03fd    	mov	x29, x29
10a0b959c: 955e87ad    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b95a0: aa0003f6    	mov	x22, x0
10a0b95a4: 900aff08    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0b95a8: f941ad01    	ldr	x1, [x8, #0x358] ; setM_customizedBlankView:
10a0b95ac: aa1503e2    	mov	x2, x21
10a0b95b0: 955e87a5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b95b4: aa1603e0    	mov	x0, x22
10a0b95b8: 955e87a9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b95bc: aa1503e0    	mov	x0, x21
10a0b95c0: 955e87a7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b95c4: aa1303e0    	mov	x0, x19
10a0b95c8: aa1403e1    	mov	x1, x20
10a0b95cc: 955e879e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b95d0: aa1d03fd    	mov	x29, x29
10a0b95d4: 955e879f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b95d8: aa0003f5    	mov	x21, x0
10a0b95dc: 900aec08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0b95e0: f946d101    	ldr	x1, [x8, #0xda0] ; setM_delegate:
10a0b95e4: aa1303e2    	mov	x2, x19
10a0b95e8: 955e8797    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b95ec: aa1503e0    	mov	x0, x21
10a0b95f0: 955e879b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b95f4: aa1303e0    	mov	x0, x19
10a0b95f8: aa1403e1    	mov	x1, x20
10a0b95fc: 955e8792    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9600: aa1d03fd    	mov	x29, x29
10a0b9604: 955e8793    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b9608: aa0003f4    	mov	x20, x0
10a0b960c: b00b0288    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10a0b9610: f947bd01    	ldr	x1, [x8, #0xf78] ; tableView
10a0b9614: aa1303e0    	mov	x0, x19
10a0b9618: 955e878b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b961c: aa1d03fd    	mov	x29, x29
10a0b9620: 955e878c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b9624: aa0003f3    	mov	x19, x0
10a0b9628: b00aeca8    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
10a0b962c: f9406d01    	ldr	x1, [x8, #0xd8] ; setTableFooterView:
10a0b9630: aa1403e2    	mov	x2, x20
10a0b9634: 955e8784    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9638: aa1303e0    	mov	x0, x19
10a0b963c: 955e8788    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b9640: aa1403e0    	mov	x0, x20
10a0b9644: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10a0b9648: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10a0b964c: a94257f6    	ldp	x22, x21, [sp, #0x20]
10a0b9650: a9415ff8    	ldp	x24, x23, [sp, #0x10]
10a0b9654: a8c567fa    	ldp	x26, x25, [sp], #0x50
10a0b9658: 155e8781    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
