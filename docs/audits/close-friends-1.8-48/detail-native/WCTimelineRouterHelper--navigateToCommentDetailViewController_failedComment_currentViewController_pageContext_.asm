
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a1651a0: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
10a1651a4: a90157f6    	stp	x22, x21, [sp, #0x10]
10a1651a8: a9024ff4    	stp	x20, x19, [sp, #0x20]
10a1651ac: a9037bfd    	stp	x29, x30, [sp, #0x30]
10a1651b0: 9100c3fd    	add	x29, sp, #0x30
10a1651b4: aa0503f3    	mov	x19, x5
10a1651b8: aa0403f4    	mov	x20, x4
10a1651bc: aa0303f5    	mov	x21, x3
10a1651c0: aa0203f6    	mov	x22, x2
10a1651c4: aa0003f7    	mov	x23, x0
10a1651c8: 900b5768    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a1651cc: 52800029    	mov	w9, #0x1                ; =1
10a1651d0: 391c0509    	strb	w9, [x8, #0x701]
10a1651d4: aa0503e0    	mov	x0, x5
10a1651d8: 955bd89a    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a1651dc: d00afd28    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10a1651e0: f941c918    	ldr	x24, [x8, #0x390] ; type
10a1651e4: aa1403e0    	mov	x0, x20
10a1651e8: 955bd896    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a1651ec: aa1503e0    	mov	x0, x21
10a1651f0: 955bd894    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a1651f4: aa1603e0    	mov	x0, x22
10a1651f8: 955bd892    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a1651fc: aa1503e0    	mov	x0, x21
10a165200: aa1803e1    	mov	x1, x24
10a165204: 955bd890    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165208: 7100041f    	cmp	w0, #0x1
10a16520c: 52800048    	mov	w8, #0x2                ; =2
10a165210: 9a881518    	cinc	x24, x8, eq
10a165214: d00af4c8    	adrp	x8, 0x11ffff000 <dyld_stub_binder+0x11ffff000>
10a165218: f9445501    	ldr	x1, [x8, #0x8a8] ; isFlutterDetailEnabled
10a16521c: aa1703e0    	mov	x0, x23
10a165220: 955bd889    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165224: 34000240    	cbz	w0, 0x10a16526c <_Flutter_MMFoundation_BindContext+0x6640e50>
10a165228: d00aeaa8    	adrp	x8, 0x11febb000 <dyld_stub_binder+0x11febb000>
10a16522c: f9467101    	ldr	x1, [x8, #0xce0] ; isPrivate
10a165230: aa1603e0    	mov	x0, x22
10a165234: 955bd884    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165238: aa0003e4    	mov	x4, x0
10a16523c: d00af9a8    	adrp	x8, 0x12009b000 <dyld_stub_binder+0x12009b000>
10a165240: f941c501    	ldr	x1, [x8, #0x388] ; navigateToFlutterDetailViewController:currentViewController:forbidComment:tipType:failedComment:canShowInvisibleTipsView:
10a165244: aa1703e0    	mov	x0, x23
10a165248: aa1603e2    	mov	x2, x22
10a16524c: aa1403e3    	mov	x3, x20
10a165250: aa1803e5    	mov	x5, x24
10a165254: aa1503e6    	mov	x6, x21
10a165258: 52800027    	mov	w7, #0x1                ; =1
10a16525c: 955bd87a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165260: aa1403e0    	mov	x0, x20
10a165264: 955bd87e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165268: 14000036    	b	0x10a165340 <_Flutter_MMFoundation_BindContext+0x6640f24>
10a16526c: b00b0088    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
10a165270: f9441500    	ldr	x0, [x8, #0x828]
10a165274: 955bd87b    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a165278: aa0003f7    	mov	x23, x0
10a16527c: 900af4c8    	adrp	x8, 0x11fffd000 <dyld_stub_binder+0x11fffd000>
10a165280: f947e501    	ldr	x1, [x8, #0xfc8] ; setPageContext:
10a165284: aa1303e2    	mov	x2, x19
10a165288: 955bd86f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a16528c: d00ae708    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
10a165290: f9449d01    	ldr	x1, [x8, #0x938] ; setDataItem:
10a165294: aa1703e0    	mov	x0, x23
10a165298: aa1603e2    	mov	x2, x22
10a16529c: 955bd86a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1652a0: aa1603e0    	mov	x0, x22
10a1652a4: 955bd86e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1652a8: b00af9a8    	adrp	x8, 0x12009a000 <dyld_stub_binder+0x12009a000>
10a1652ac: f9431101    	ldr	x1, [x8, #0x620] ; setFailedComment:
10a1652b0: aa1703e0    	mov	x0, x23
10a1652b4: aa1503e2    	mov	x2, x21
10a1652b8: 955bd863    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1652bc: aa1503e0    	mov	x0, x21
10a1652c0: 955bd867    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1652c4: d00ae848    	adrp	x8, 0x11fe6f000 <dyld_stub_binder+0x11fe6f000>
10a1652c8: f943f501    	ldr	x1, [x8, #0x7e8] ; setTipType:
10a1652cc: aa1703e0    	mov	x0, x23
10a1652d0: aa1803e2    	mov	x2, x24
10a1652d4: 955bd85c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1652d8: d00ae848    	adrp	x8, 0x11fe6f000 <dyld_stub_binder+0x11fe6f000>
10a1652dc: f943f901    	ldr	x1, [x8, #0x7f0] ; setCanShowInvisibleTipsView:
10a1652e0: aa1703e0    	mov	x0, x23
10a1652e4: 52800022    	mov	w2, #0x1                ; =1
10a1652e8: 955bd857    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1652ec: 900ae6a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a1652f0: f946d101    	ldr	x1, [x8, #0xda0] ; setM_delegate:
10a1652f4: aa1703e0    	mov	x0, x23
10a1652f8: aa1403e2    	mov	x2, x20
10a1652fc: 955bd852    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165300: f00afce8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10a165304: f945dd01    	ldr	x1, [x8, #0xbb8] ; navigationController
10a165308: aa1403e0    	mov	x0, x20
10a16530c: 955bd84e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a165310: aa1d03fd    	mov	x29, x29
10a165314: 955bd84f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a165318: aa0003f5    	mov	x21, x0
10a16531c: aa1403e0    	mov	x0, x20
10a165320: 955bd84f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165324: d00ae6a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a165328: f944e101    	ldr	x1, [x8, #0x9c0] ; PushViewController:animated:
10a16532c: aa1503e0    	mov	x0, x21
10a165330: aa1703e2    	mov	x2, x23
10a165334: 52800023    	mov	w3, #0x1                ; =1
10a165338: 955bd843    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a16533c: aa1703f6    	mov	x22, x23
10a165340: aa1503e0    	mov	x0, x21
10a165344: 955bd846    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165348: aa1603e0    	mov	x0, x22
10a16534c: 955bd844    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a165350: aa1303e0    	mov	x0, x19
10a165354: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10a165358: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10a16535c: a94157f6    	ldp	x22, x21, [sp, #0x10]
10a165360: a8c45ff8    	ldp	x24, x23, [sp], #0x40
10a165364: 155bd83e    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
