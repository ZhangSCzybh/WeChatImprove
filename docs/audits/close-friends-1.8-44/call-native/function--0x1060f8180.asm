
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1060f8180: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
1060f8184: a90167fa    	stp	x26, x25, [sp, #0x10]
1060f8188: a9025ff8    	stp	x24, x23, [sp, #0x20]
1060f818c: a90357f6    	stp	x22, x21, [sp, #0x30]
1060f8190: a9044ff4    	stp	x20, x19, [sp, #0x40]
1060f8194: a9057bfd    	stp	x29, x30, [sp, #0x50]
1060f8198: 910143fd    	add	x29, sp, #0x50
1060f819c: d10983ff    	sub	sp, sp, #0x260
1060f81a0: aa0303f3    	mov	x19, x3
1060f81a4: aa0003f6    	mov	x22, x0
1060f81a8: f00ba7a8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1060f81ac: f9405908    	ldr	x8, [x8, #0xb0]
1060f81b0: f9400108    	ldr	x8, [x8]
1060f81b4: f81a03a8    	stur	x8, [x29, #-0x60]
1060f81b8: aa0303e0    	mov	x0, x3
1060f81bc: 946cbbdf    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1060f81c0: 9100c2c0    	add	x0, x22, #0x30
1060f81c4: 946cbbf2    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1060f81c8: aa0003fc    	mov	x28, x0
1060f81cc: b4005920    	cbz	x0, 0x1060f8cf0 <_Flutter_MMFoundation_BindContext+0x25d48d4>
1060f81d0: f9000ff3    	str	x19, [sp, #0x18]
1060f81d4: f94012c0    	ldr	x0, [x22, #0x20]
1060f81d8: f00ceb68    	adrp	x8, 0x11fe67000 <dyld_stub_binder+0x11fe67000>
1060f81dc: f9438518    	ldr	x24, [x8, #0x708] ; usernameList
1060f81e0: aa1803e1    	mov	x1, x24
1060f81e4: 946cbbd6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f81e8: aa1d03fd    	mov	x29, x29
1060f81ec: 946cbbd7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f81f0: aa0003f3    	mov	x19, x0
1060f81f4: 900d0048    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1060f81f8: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1060f81fc: 946cbbd0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8200: f00d09fb    	adrp	x27, 0x120237000 <dyld_stub_binder+0x120237000>
1060f8204: b00cebf9    	adrp	x25, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
1060f8208: f9004bf8    	str	x24, [sp, #0x90]
1060f820c: b40000c0    	cbz	x0, 0x1060f8224 <_Flutter_MMFoundation_BindContext+0x25d3e08>
1060f8210: aa1303e0    	mov	x0, x19
1060f8214: 946cbbd0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8218: d00ceaa8    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
1060f821c: f9450517    	ldr	x23, [x8, #0xa08] ; roomid
1060f8220: 14000019    	b	0x1060f8284 <_Flutter_MMFoundation_BindContext+0x25d3e68>
1060f8224: f00d04c8    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
1060f8228: f946d900    	ldr	x0, [x8, #0xdb0] ; p*;
1060f822c: d00d0088    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1060f8230: f9437d01    	ldr	x1, [x8, #0x6f8] ; sharedInstance
1060f8234: 946cbbc2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8238: aa1d03fd    	mov	x29, x29
1060f823c: 946cbbc3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f8240: aa0003f4    	mov	x20, x0
1060f8244: f94012c0    	ldr	x0, [x22, #0x20]
1060f8248: d00ceaa8    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
1060f824c: f9450517    	ldr	x23, [x8, #0xa08] ; roomid
1060f8250: aa1703e1    	mov	x1, x23
1060f8254: 946cbbba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8258: aa0003e2    	mov	x2, x0
1060f825c: f00cf6a8    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
1060f8260: f9417501    	ldr	x1, [x8, #0x2e8] ; isChangeToMultiTalkWithRoomID:
1060f8264: aa1403e0    	mov	x0, x20
1060f8268: 946cbbb5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f826c: aa0003f5    	mov	x21, x0
1060f8270: aa1403e0    	mov	x0, x20
1060f8274: 946cbbb8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8278: aa1303e0    	mov	x0, x19
1060f827c: 946cbbb6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8280: 34004f35    	cbz	w21, 0x1060f8c64 <_Flutter_MMFoundation_BindContext+0x25d4848>
1060f8284: f00d03c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060f8288: f9453500    	ldr	x0, [x8, #0xa68]
1060f828c: b00cea08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1060f8290: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1060f8294: d00c3ba8    	adrp	x8, 0x11e86e000 <dyld_stub_binder+0x11e86e000>
1060f8298: 913a2108    	add	x8, x8, #0xe88
1060f829c: f90003e8    	str	x8, [sp]
1060f82a0: b00a9c43    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
1060f82a4: 91056463    	add	x3, x3, #0x159
1060f82a8: 900ac465    	adrp	x5, 0x11b984000 <dyld_stub_binder+0x11b984000>
1060f82ac: 912838a5    	add	x5, x5, #0xa0e
1060f82b0: f00ac467    	adrp	x7, 0x11b987000 <dyld_stub_binder+0x11b987000>
1060f82b4: 911240e7    	add	x7, x7, #0x490
1060f82b8: 52800042    	mov	w2, #0x2                ; =2
1060f82bc: 52800004    	mov	w4, #0x0                ; =0
1060f82c0: 5281f3c6    	mov	w6, #0xf9e              ; =3998
1060f82c4: 946cbb9e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f82c8: b98a3b68    	ldrsw	x8, [x27, #0xa38]
1060f82cc: 8b080380    	add	x0, x28, x8
1060f82d0: 946cbbaf    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1060f82d4: aa0003f3    	mov	x19, x0
1060f82d8: f94012c0    	ldr	x0, [x22, #0x20]
1060f82dc: f9429321    	ldr	x1, [x25, #0x520] ; roomType
1060f82e0: 946cbb97    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f82e4: aa0003f4    	mov	x20, x0
1060f82e8: f94012c0    	ldr	x0, [x22, #0x20]
1060f82ec: aa1703e1    	mov	x1, x23
1060f82f0: 946cbb93    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f82f4: aa0003e3    	mov	x3, x0
1060f82f8: f00cf6a8    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
1060f82fc: f9417901    	ldr	x1, [x8, #0x2f0] ; readyJoinRoomForIlink:roomID:
1060f8300: aa1303e0    	mov	x0, x19
1060f8304: aa1403e2    	mov	x2, x20
1060f8308: 946cbb8d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f830c: aa1303e0    	mov	x0, x19
1060f8310: 946cbb91    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8314: 52800028    	mov	w8, #0x1                ; =1
1060f8318: b90027e8    	str	w8, [sp, #0x24]
1060f831c: f90033f6    	str	x22, [sp, #0x60]
1060f8320: f94016c0    	ldr	x0, [x22, #0x28]
1060f8324: aa1703e1    	mov	x1, x23
1060f8328: 946cbb85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f832c: aa0003e2    	mov	x2, x0
1060f8330: f00cf6a8    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
1060f8334: f9405501    	ldr	x1, [x8, #0xa8] ; setUpLongTermCallbackAfterJoin:
1060f8338: aa1c03e0    	mov	x0, x28
1060f833c: 946cbb80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8340: f00d03c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060f8344: f945e900    	ldr	x0, [x8, #0xbd0]
1060f8348: 900d0048    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1060f834c: f944e918    	ldr	x24, [x8, #0x9d0] ; currentContext
1060f8350: aa1803e1    	mov	x1, x24
1060f8354: 946cbb7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8358: aa1d03fd    	mov	x29, x29
1060f835c: 946cbb7b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f8360: aa0003f3    	mov	x19, x0
1060f8364: f00d0468    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
1060f8368: f943a500    	ldr	x0, [x8, #0x748]
1060f836c: f00d0028    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1060f8370: f947ad19    	ldr	x25, [x8, #0xf58] ; class
1060f8374: aa1903e1    	mov	x1, x25
1060f8378: 946cbb71    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f837c: aa0003e2    	mov	x2, x0
1060f8380: b00cea08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1060f8384: f946411a    	ldr	x26, [x8, #0xc80] ; getService:
1060f8388: aa1303e0    	mov	x0, x19
1060f838c: aa1a03e1    	mov	x1, x26
1060f8390: 946cbb6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8394: aa1d03fd    	mov	x29, x29
1060f8398: 946cbb6c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f839c: aa0003f4    	mov	x20, x0
1060f83a0: b00cefe8    	adrp	x8, 0x11fef5000 <dyld_stub_binder+0x11fef5000>
1060f83a4: f9472901    	ldr	x1, [x8, #0xe50] ; isPhoneCalling
1060f83a8: 946cbb65    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f83ac: 36000720    	tbz	w0, #0x0, 0x1060f8490 <_Flutter_MMFoundation_BindContext+0x25d4074>
1060f83b0: b98a3b76    	ldrsw	x22, [x27, #0xa38]
1060f83b4: 8b160380    	add	x0, x28, x22
1060f83b8: 946cbb75    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1060f83bc: aa0003f5    	mov	x21, x0
1060f83c0: d00cefe8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060f83c4: f9438d01    	ldr	x1, [x8, #0x718] ; getIfCallKitStatus
1060f83c8: 946cbb5d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f83cc: aa0003fb    	mov	x27, x0
1060f83d0: aa1503e0    	mov	x0, x21
1060f83d4: 946cbb60    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f83d8: aa1403e0    	mov	x0, x20
1060f83dc: 946cbb5e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f83e0: aa1303e0    	mov	x0, x19
1060f83e4: 946cbb5c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f83e8: 370005fb    	tbnz	w27, #0x0, 0x1060f84a4 <_Flutter_MMFoundation_BindContext+0x25d4088>
1060f83ec: f00d03c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060f83f0: f9453500    	ldr	x0, [x8, #0xa68]
1060f83f4: b00cea08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1060f83f8: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1060f83fc: d00c3ba8    	adrp	x8, 0x11e86e000 <dyld_stub_binder+0x11e86e000>
1060f8400: 913aa108    	add	x8, x8, #0xea8
1060f8404: f90003e8    	str	x8, [sp]
1060f8408: b00a9c43    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
1060f840c: 91056463    	add	x3, x3, #0x159
1060f8410: 900ac465    	adrp	x5, 0x11b984000 <dyld_stub_binder+0x11b984000>
1060f8414: 912838a5    	add	x5, x5, #0xa0e
1060f8418: f00ac467    	adrp	x7, 0x11b987000 <dyld_stub_binder+0x11b987000>
1060f841c: 911240e7    	add	x7, x7, #0x490
1060f8420: 52800042    	mov	w2, #0x2                ; =2
1060f8424: 52800004    	mov	w4, #0x0                ; =0
1060f8428: 5281f4c6    	mov	w6, #0xfa6              ; =4006
1060f842c: 946cbb44    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8430: f00d09e8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060f8434: b98a0908    	ldrsw	x8, [x8, #0xa08]
1060f8438: f8686b93    	ldr	x19, [x28, x8]
1060f843c: d00ba7a8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1060f8440: f947e108    	ldr	x8, [x8, #0xfc0]
1060f8444: f90097e8    	str	x8, [sp, #0x128]
1060f8448: b0096448    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1060f844c: fd41c100    	ldr	d0, [x8, #0x380]
1060f8450: 90000008    	adrp	x8, 0x1060f8000 <_Flutter_MMFoundation_BindContext+0x25d3be4>
1060f8454: 9134f108    	add	x8, x8, #0xd3c
1060f8458: fd009be0    	str	d0, [sp, #0x130]
1060f845c: d00ba7e9    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
1060f8460: 9115c129    	add	x9, x9, #0x570
1060f8464: a913a7e8    	stp	x8, x9, [sp, #0x138]
1060f8468: f94033e8    	ldr	x8, [sp, #0x60]
1060f846c: f9401100    	ldr	x0, [x8, #0x20]
1060f8470: 946cbb32    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1060f8474: f900a7e0    	str	x0, [sp, #0x148]
1060f8478: 9104a3e1    	add	x1, sp, #0x128
1060f847c: aa1303e0    	mov	x0, x19
1060f8480: 946c5368    	bl	0x107c0d220 <_Flutter_MMFoundation_BindContext+0x40e8e04>
1060f8484: f940a7f5    	ldr	x21, [sp, #0x148]
1060f8488: f9400ff3    	ldr	x19, [sp, #0x18]
1060f848c: 14000217    	b	0x1060f8ce8 <_Flutter_MMFoundation_BindContext+0x25d48cc>
1060f8490: aa1403e0    	mov	x0, x20
1060f8494: 946cbb30    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8498: aa1303e0    	mov	x0, x19
1060f849c: 946cbb2e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f84a0: b98a3b76    	ldrsw	x22, [x27, #0xa38]
1060f84a4: 8b160380    	add	x0, x28, x22
1060f84a8: 946cbb39    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1060f84ac: aa0003f3    	mov	x19, x0
1060f84b0: f94033f6    	ldr	x22, [sp, #0x60]
1060f84b4: a9420ec2    	ldp	x2, x3, [x22, #0x20]
1060f84b8: f00cf6a8    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
1060f84bc: f9417d01    	ldr	x1, [x8, #0x2f8] ; onStartRecvInvite:inviteMsg:
1060f84c0: 946cbb1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f84c4: aa1303e0    	mov	x0, x19
1060f84c8: 946cbb23    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f84cc: f94016c0    	ldr	x0, [x22, #0x28]
1060f84d0: aa1703e1    	mov	x1, x23
1060f84d4: 946cbb1a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f84d8: f00d09e8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060f84dc: b98a1508    	ldrsw	x8, [x8, #0xa14]
1060f84e0: f8286b80    	str	x0, [x28, x8]
1060f84e4: f94016c0    	ldr	x0, [x22, #0x28]
1060f84e8: 900cf4e8    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
1060f84ec: f946b101    	ldr	x1, [x8, #0xd60] ; wxGroupid
1060f84f0: 946cbb13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f84f4: aa1d03fd    	mov	x29, x29
1060f84f8: 946cbb14    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f84fc: f00d09e8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060f8500: b98a1913    	ldrsw	x19, [x8, #0xa18]
1060f8504: f8736b88    	ldr	x8, [x28, x19]
1060f8508: f8336b80    	str	x0, [x28, x19]
1060f850c: aa0803e0    	mov	x0, x8
1060f8510: 946cbb11    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8514: f94016c0    	ldr	x0, [x22, #0x28]
1060f8518: 900cf4e8    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
1060f851c: f946b501    	ldr	x1, [x8, #0xd68] ; sdkGroupid
1060f8520: 946cbb07    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8524: aa1d03fd    	mov	x29, x29
1060f8528: 946cbb08    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f852c: f00d09e8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060f8530: b98a1d14    	ldrsw	x20, [x8, #0xa1c]
1060f8534: f8746b88    	ldr	x8, [x28, x20]
1060f8538: f8346b80    	str	x0, [x28, x20]
1060f853c: aa0803e0    	mov	x0, x8
1060f8540: 946cbb05    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8544: f94016c0    	ldr	x0, [x22, #0x28]
1060f8548: 900cf4e8    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
1060f854c: f9470101    	ldr	x1, [x8, #0xe00] ; displayUserList
1060f8550: 946cbafb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8554: aa1d03fd    	mov	x29, x29
1060f8558: 946cbafc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f855c: f00d09e8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060f8560: b98b591b    	ldrsw	x27, [x8, #0xb58]
1060f8564: f87b6b88    	ldr	x8, [x28, x27]
1060f8568: f83b6b80    	str	x0, [x28, x27]
1060f856c: aa0803e0    	mov	x0, x8
1060f8570: 946cbaf9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8574: f00d09e8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060f8578: b989fd15    	ldrsw	x21, [x8, #0x9fc]
1060f857c: f8756b80    	ldr	x0, [x28, x21]
1060f8580: d00d0048    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1060f8584: f9468101    	ldr	x1, [x8, #0xd00] ; initData
1060f8588: 946cbaed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f858c: f8756b80    	ldr	x0, [x28, x21]
1060f8590: f8746b82    	ldr	x2, [x28, x20]
1060f8594: d00ceaa8    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
1060f8598: f9450101    	ldr	x1, [x8, #0xa00] ; setMSdkGroupId:
1060f859c: 946cbae8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f85a0: f8756b80    	ldr	x0, [x28, x21]
1060f85a4: f8736b82    	ldr	x2, [x28, x19]
1060f85a8: d00ceaa8    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
1060f85ac: f944f501    	ldr	x1, [x8, #0x9e8] ; setMMultiTalkGroupId:
1060f85b0: 946cbae3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f85b4: f8756b80    	ldr	x0, [x28, x21]
1060f85b8: f8736b82    	ldr	x2, [x28, x19]
1060f85bc: d00ceaa8    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
1060f85c0: f944f901    	ldr	x1, [x8, #0x9f0] ; setMWxGroupId:
1060f85c4: 946cbade    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f85c8: f9001bf5    	str	x21, [sp, #0x30]
1060f85cc: f8756b93    	ldr	x19, [x28, x21]
1060f85d0: f94012c0    	ldr	x0, [x22, #0x20]
1060f85d4: aa1703e1    	mov	x1, x23
1060f85d8: 946cbad9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f85dc: aa0003e2    	mov	x2, x0
1060f85e0: 900ceea8    	adrp	x8, 0x11fecc000 <dyld_stub_binder+0x11fecc000>
1060f85e4: f947c101    	ldr	x1, [x8, #0xf80] ; setMroomid:
1060f85e8: aa1303e0    	mov	x0, x19
1060f85ec: 946cbad4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f85f0: f94012c0    	ldr	x0, [x22, #0x20]
1060f85f4: b00cebe8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
1060f85f8: f9429101    	ldr	x1, [x8, #0x520] ; roomType
1060f85fc: 946cbad0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8600: f00d09e8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060f8604: b98a8508    	ldrsw	x8, [x8, #0xa84]
1060f8608: b8286b80    	str	w0, [x28, x8]
1060f860c: 7100041f    	cmp	w0, #0x1
1060f8610: 540000a1    	b.ne	0x1060f8624 <_Flutter_MMFoundation_BindContext+0x25d4208>
1060f8614: f00d09e8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060f8618: b98a6908    	ldrsw	x8, [x8, #0xa68]
1060f861c: 52800029    	mov	w9, #0x1                ; =1
1060f8620: 38286b89    	strb	w9, [x28, x8]
1060f8624: 900ceeb7    	adrp	x23, 0x11fecc000 <dyld_stub_binder+0x11fecc000>
1060f8628: f00d03c9    	adrp	x9, 0x120173000 <dyld_stub_binder+0x120173000>
1060f862c: f9004ffc    	str	x28, [sp, #0x98]
1060f8630: b94027e8    	ldr	w8, [sp, #0x24]
1060f8634: 36001428    	tbz	w8, #0x0, 0x1060f88b8 <_Flutter_MMFoundation_BindContext+0x25d449c>
1060f8638: f00d047c    	adrp	x28, 0x120187000 <dyld_stub_binder+0x120187000>
1060f863c: f943c780    	ldr	x0, [x28, #0x788]
1060f8640: 946cbac6    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1060f8644: aa0003f3    	mov	x19, x0
1060f8648: f94012c0    	ldr	x0, [x22, #0x20]
1060f864c: b00cebe8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
1060f8650: f9430d01    	ldr	x1, [x8, #0x618] ; callerUsername
1060f8654: 946cbaba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8658: aa1d03fd    	mov	x29, x29
1060f865c: 946cbabb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f8660: aa0003f4    	mov	x20, x0
1060f8664: b00cea28    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1060f8668: f9436515    	ldr	x21, [x8, #0x6c8] ; setUsername:
1060f866c: aa1303e0    	mov	x0, x19
1060f8670: aa1503e1    	mov	x1, x21
1060f8674: aa1403e2    	mov	x2, x20
1060f8678: 946cbab1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f867c: aa1403e0    	mov	x0, x20
1060f8680: 946cbab5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8684: f94012c0    	ldr	x0, [x22, #0x20]
1060f8688: f945b2e1    	ldr	x1, [x23, #0xb60] ; callerOpenid
1060f868c: 946cbaac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8690: aa1d03fd    	mov	x29, x29
1060f8694: 946cbaad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f8698: aa0003f4    	mov	x20, x0
1060f869c: d00cefe8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060f86a0: f9413901    	ldr	x1, [x8, #0x270] ; setVoipsdkUsername:
1060f86a4: aa1303e0    	mov	x0, x19
1060f86a8: aa1403e2    	mov	x2, x20
1060f86ac: 946cbaa4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f86b0: aa1403e0    	mov	x0, x20
1060f86b4: 946cbaa8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f86b8: f943c780    	ldr	x0, [x28, #0x788]
1060f86bc: 946cbaa7    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1060f86c0: aa0003f4    	mov	x20, x0
1060f86c4: f00d03c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060f86c8: f945e900    	ldr	x0, [x8, #0xbd0]
1060f86cc: aa1803e1    	mov	x1, x24
1060f86d0: 946cba9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f86d4: aa1d03fd    	mov	x29, x29
1060f86d8: 946cba9c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f86dc: aa0003f7    	mov	x23, x0
1060f86e0: 900d03e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1060f86e4: f9401500    	ldr	x0, [x8, #0x28] ; P;,
1060f86e8: aa1903e1    	mov	x1, x25
1060f86ec: 946cba94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f86f0: aa0003e2    	mov	x2, x0
1060f86f4: aa1703e0    	mov	x0, x23
1060f86f8: aa1a03e1    	mov	x1, x26
1060f86fc: 946cba90    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8700: aa1d03fd    	mov	x29, x29
1060f8704: 946cba91    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f8708: aa0003f8    	mov	x24, x0
1060f870c: f00cea08    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1060f8710: f9470d01    	ldr	x1, [x8, #0xe18] ; getSelfContact
1060f8714: 946cba8a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8718: aa1d03fd    	mov	x29, x29
1060f871c: 946cba8b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f8720: aa0003f9    	mov	x25, x0
1060f8724: f00cea08    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1060f8728: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
1060f872c: 946cba84    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8730: aa1d03fd    	mov	x29, x29
1060f8734: 946cba85    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f8738: aa0003fa    	mov	x26, x0
1060f873c: aa1403e0    	mov	x0, x20
1060f8740: aa1503e1    	mov	x1, x21
1060f8744: aa1a03e2    	mov	x2, x26
1060f8748: 946cba7d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f874c: aa1a03e0    	mov	x0, x26
1060f8750: 946cba81    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8754: aa1903e0    	mov	x0, x25
1060f8758: 946cba7f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f875c: aa1803e0    	mov	x0, x24
1060f8760: 946cba7d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8764: aa1703e0    	mov	x0, x23
1060f8768: 946cba7b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f876c: f00d03c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060f8770: f9455500    	ldr	x0, [x8, #0xaa8]
1060f8774: f00d0028    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1060f8778: f941c101    	ldr	x1, [x8, #0x380] ; arrayWithObjects:
1060f877c: a9007ff4    	stp	x20, xzr, [sp]
1060f8780: a9084ff4    	stp	x20, x19, [sp, #0x80]
1060f8784: aa1303e2    	mov	x2, x19
1060f8788: 946cba6d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f878c: aa1d03fd    	mov	x29, x29
1060f8790: 946cba6e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f8794: f9404fe9    	ldr	x9, [sp, #0x98]
1060f8798: f87b6928    	ldr	x8, [x9, x27]
1060f879c: f83b6920    	str	x0, [x9, x27]
1060f87a0: aa0803e0    	mov	x0, x8
1060f87a4: 946cba6c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f87a8: 4f00e400    	movi.16b	v0, #0x0
1060f87ac: ad0803e0    	stp	q0, q0, [sp, #0x100]
1060f87b0: ad0703e0    	stp	q0, q0, [sp, #0xe0]
1060f87b4: f94012c0    	ldr	x0, [x22, #0x20]
1060f87b8: f9404be1    	ldr	x1, [sp, #0x90]
1060f87bc: 946cba60    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f87c0: aa1d03fd    	mov	x29, x29
1060f87c4: 946cba61    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f87c8: aa0003f6    	mov	x22, x0
1060f87cc: 900d0048    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1060f87d0: f9435513    	ldr	x19, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1060f87d4: 910383e2    	add	x2, sp, #0xe0
1060f87d8: d10383a3    	sub	x3, x29, #0xe0
1060f87dc: aa1303e1    	mov	x1, x19
1060f87e0: 52800204    	mov	w4, #0x10               ; =16
1060f87e4: 946cba56    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f87e8: b4000520    	cbz	x0, 0x1060f888c <_Flutter_MMFoundation_BindContext+0x25d4470>
1060f87ec: aa0003f7    	mov	x23, x0
1060f87f0: f9407be8    	ldr	x8, [sp, #0xf0]
1060f87f4: f9400114    	ldr	x20, [x8]
1060f87f8: f90017f3    	str	x19, [sp, #0x28]
1060f87fc: d2800013    	mov	x19, #0x0               ; =0
1060f8800: d00cea08    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1060f8804: f943c518    	ldr	x24, [x8, #0x788] ; safeAddObject:
1060f8808: f9407be8    	ldr	x8, [sp, #0xf0]
1060f880c: f9400108    	ldr	x8, [x8]
1060f8810: eb14011f    	cmp	x8, x20
1060f8814: 54000060    	b.eq	0x1060f8820 <_Flutter_MMFoundation_BindContext+0x25d4404>
1060f8818: aa1603e0    	mov	x0, x22
1060f881c: 946cba4d    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1060f8820: f94077e8    	ldr	x8, [sp, #0xe8]
1060f8824: f8737919    	ldr	x25, [x8, x19, lsl #3]
1060f8828: f943c780    	ldr	x0, [x28, #0x788]
1060f882c: 946cba4b    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1060f8830: aa0003fa    	mov	x26, x0
1060f8834: aa1503e1    	mov	x1, x21
1060f8838: aa1903e2    	mov	x2, x25
1060f883c: 946cba40    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8840: f9404fe8    	ldr	x8, [sp, #0x98]
1060f8844: f87b6900    	ldr	x0, [x8, x27]
1060f8848: aa1803e1    	mov	x1, x24
1060f884c: aa1a03e2    	mov	x2, x26
1060f8850: 946cba3b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8854: aa1a03e0    	mov	x0, x26
1060f8858: 946cba3f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f885c: 91000673    	add	x19, x19, #0x1
1060f8860: eb1302ff    	cmp	x23, x19
1060f8864: 54fffd21    	b.ne	0x1060f8808 <_Flutter_MMFoundation_BindContext+0x25d43ec>
1060f8868: 910383e2    	add	x2, sp, #0xe0
1060f886c: d10383a3    	sub	x3, x29, #0xe0
1060f8870: aa1603e0    	mov	x0, x22
1060f8874: f94017f3    	ldr	x19, [sp, #0x28]
1060f8878: aa1303e1    	mov	x1, x19
1060f887c: 52800204    	mov	w4, #0x10               ; =16
1060f8880: 946cba2f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8884: aa0003f7    	mov	x23, x0
1060f8888: b5fffba0    	cbnz	x0, 0x1060f87fc <_Flutter_MMFoundation_BindContext+0x25d43e0>
1060f888c: aa1603e0    	mov	x0, x22
1060f8890: 946cba31    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8894: f94043e0    	ldr	x0, [sp, #0x80]
1060f8898: 946cba2f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f889c: f94047e0    	ldr	x0, [sp, #0x88]
1060f88a0: 946cba2d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f88a4: f9404ffc    	ldr	x28, [sp, #0x98]
1060f88a8: f94033f6    	ldr	x22, [sp, #0x60]
1060f88ac: 900ceeb7    	adrp	x23, 0x11fecc000 <dyld_stub_binder+0x11fecc000>
1060f88b0: f00d03c9    	adrp	x9, 0x120173000 <dyld_stub_binder+0x120173000>
1060f88b4: 14000003    	b	0x1060f88c0 <_Flutter_MMFoundation_BindContext+0x25d44a4>
1060f88b8: 900d0048    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1060f88bc: f9435513    	ldr	x19, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1060f88c0: f9455520    	ldr	x0, [x9, #0xaa8]
1060f88c4: 946cba25    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1060f88c8: f9002fe0    	str	x0, [sp, #0x58]
1060f88cc: 4f00e400    	movi.16b	v0, #0x0
1060f88d0: ad0503e0    	stp	q0, q0, [sp, #0xa0]
1060f88d4: ad0603e0    	stp	q0, q0, [sp, #0xc0]
1060f88d8: f87b6b94    	ldr	x20, [x28, x27]
1060f88dc: aa1403e0    	mov	x0, x20
1060f88e0: 946cba16    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1060f88e4: 910283e2    	add	x2, sp, #0xa0
1060f88e8: 910543e3    	add	x3, sp, #0x150
1060f88ec: aa1303e1    	mov	x1, x19
1060f88f0: 52800204    	mov	w4, #0x10               ; =16
1060f88f4: 946cba12    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f88f8: f9004be0    	str	x0, [sp, #0x90]
1060f88fc: b4001ac0    	cbz	x0, 0x1060f8c54 <_Flutter_MMFoundation_BindContext+0x25d4838>
1060f8900: f9405be8    	ldr	x8, [sp, #0xb0]
1060f8904: f9400108    	ldr	x8, [x8]
1060f8908: a904ffe8    	stp	x8, xzr, [sp, #0x48]
1060f890c: f90017f3    	str	x19, [sp, #0x28]
1060f8910: f90023f4    	str	x20, [sp, #0x40]
1060f8914: d2800018    	mov	x24, #0x0               ; =0
1060f8918: d00cefe8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060f891c: f9419916    	ldr	x22, [x8, #0x330] ; voipsdkUsername
1060f8920: b00cee08    	adrp	x8, 0x11feb9000 <dyld_stub_binder+0x11feb9000>
1060f8924: f9428909    	ldr	x9, [x8, #0x510] ; setOpenId:
1060f8928: 900cea28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1060f892c: f9471119    	ldr	x25, [x8, #0xe20] ; username
1060f8930: d00cefe8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060f8934: f9418908    	ldr	x8, [x8, #0x310] ; setMUserName:
1060f8938: a90827e8    	stp	x8, x9, [sp, #0x80]
1060f893c: b00cea08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1060f8940: f942a909    	ldr	x9, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1060f8944: f945b2e8    	ldr	x8, [x23, #0xb60] ; callerOpenid
1060f8948: a90727e8    	stp	x8, x9, [sp, #0x70]
1060f894c: f00d0048    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1060f8950: f943c917    	ldr	x23, [x8, #0x790] ; isEqualToString:
1060f8954: d00cefe8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060f8958: f9418508    	ldr	x8, [x8, #0x308] ; setMStatus:
1060f895c: f90037e8    	str	x8, [sp, #0x68]
1060f8960: 900ceea8    	adrp	x8, 0x11fecc000 <dyld_stub_binder+0x11fecc000>
1060f8964: f947c508    	ldr	x8, [x8, #0xf88] ; setMCreatedUserName:
1060f8968: f9001fe8    	str	x8, [sp, #0x38]
1060f896c: d00d0028    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1060f8970: f946f514    	ldr	x20, [x8, #0xde8] ; addObject:
1060f8974: f9405be8    	ldr	x8, [sp, #0xb0]
1060f8978: f9400108    	ldr	x8, [x8]
1060f897c: f94027e9    	ldr	x9, [sp, #0x48]
1060f8980: eb09011f    	cmp	x8, x9
1060f8984: 54000060    	b.eq	0x1060f8990 <_Flutter_MMFoundation_BindContext+0x25d4574>
1060f8988: f94023e0    	ldr	x0, [sp, #0x40]
1060f898c: 946cb9f1    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1060f8990: f94057e8    	ldr	x8, [sp, #0xa8]
1060f8994: f8787915    	ldr	x21, [x8, x24, lsl #3]
1060f8998: f00d0468    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
1060f899c: f943d500    	ldr	x0, [x8, #0x7a8]
1060f89a0: 946cb9ee    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1060f89a4: aa0003fa    	mov	x26, x0
1060f89a8: aa1503e0    	mov	x0, x21
1060f89ac: aa1603e1    	mov	x1, x22
1060f89b0: 946cb9e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f89b4: aa1d03fd    	mov	x29, x29
1060f89b8: 946cb9e4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f89bc: aa0003fb    	mov	x27, x0
1060f89c0: aa1a03e0    	mov	x0, x26
1060f89c4: f94047e1    	ldr	x1, [sp, #0x88]
1060f89c8: aa1b03e2    	mov	x2, x27
1060f89cc: 946cb9dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f89d0: aa1b03e0    	mov	x0, x27
1060f89d4: 946cb9e0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f89d8: aa1503e0    	mov	x0, x21
1060f89dc: aa1903e1    	mov	x1, x25
1060f89e0: 946cb9d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f89e4: aa1d03fd    	mov	x29, x29
1060f89e8: 946cb9d8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f89ec: aa0003fb    	mov	x27, x0
1060f89f0: aa1a03e0    	mov	x0, x26
1060f89f4: f94043e1    	ldr	x1, [sp, #0x80]
1060f89f8: aa1b03e2    	mov	x2, x27
1060f89fc: 946cb9d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8a00: aa1b03e0    	mov	x0, x27
1060f8a04: 946cb9d4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8a08: f00d03c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060f8a0c: f945351b    	ldr	x27, [x8, #0xa68]
1060f8a10: aa1503e0    	mov	x0, x21
1060f8a14: aa1903e1    	mov	x1, x25
1060f8a18: 946cb9c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8a1c: aa1d03fd    	mov	x29, x29
1060f8a20: 946cb9ca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f8a24: aa0003fc    	mov	x28, x0
1060f8a28: aa1503e0    	mov	x0, x21
1060f8a2c: aa1603e1    	mov	x1, x22
1060f8a30: 946cb9c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8a34: aa1d03fd    	mov	x29, x29
1060f8a38: 946cb9c4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f8a3c: aa0003f3    	mov	x19, x0
1060f8a40: a90083fc    	stp	x28, x0, [sp, #0x8]
1060f8a44: d00c3ba8    	adrp	x8, 0x11e86e000 <dyld_stub_binder+0x11e86e000>
1060f8a48: 913b2108    	add	x8, x8, #0xec8
1060f8a4c: f90003e8    	str	x8, [sp]
1060f8a50: aa1b03e0    	mov	x0, x27
1060f8a54: f9403fe1    	ldr	x1, [sp, #0x78]
1060f8a58: 52800042    	mov	w2, #0x2                ; =2
1060f8a5c: b00a9c43    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
1060f8a60: 91056463    	add	x3, x3, #0x159
1060f8a64: 52800004    	mov	w4, #0x0                ; =0
1060f8a68: 900ac465    	adrp	x5, 0x11b984000 <dyld_stub_binder+0x11b984000>
1060f8a6c: 912838a5    	add	x5, x5, #0xa0e
1060f8a70: 5281faa6    	mov	w6, #0xfd5              ; =4053
1060f8a74: f00ac467    	adrp	x7, 0x11b987000 <dyld_stub_binder+0x11b987000>
1060f8a78: 911240e7    	add	x7, x7, #0x490
1060f8a7c: 946cb9b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8a80: aa1303e0    	mov	x0, x19
1060f8a84: 946cb9b4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8a88: aa1c03e0    	mov	x0, x28
1060f8a8c: 946cb9b2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8a90: f94033e8    	ldr	x8, [sp, #0x60]
1060f8a94: f9401100    	ldr	x0, [x8, #0x20]
1060f8a98: f9403be1    	ldr	x1, [sp, #0x70]
1060f8a9c: 946cb9a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8aa0: aa1d03fd    	mov	x29, x29
1060f8aa4: 946cb9a9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f8aa8: aa0003f3    	mov	x19, x0
1060f8aac: aa1503e0    	mov	x0, x21
1060f8ab0: aa1603e1    	mov	x1, x22
1060f8ab4: 946cb9a2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8ab8: aa1d03fd    	mov	x29, x29
1060f8abc: 946cb9a3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f8ac0: aa0003fb    	mov	x27, x0
1060f8ac4: aa1303e0    	mov	x0, x19
1060f8ac8: aa1703e1    	mov	x1, x23
1060f8acc: aa1b03e2    	mov	x2, x27
1060f8ad0: 946cb99b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8ad4: aa0003fc    	mov	x28, x0
1060f8ad8: aa1b03e0    	mov	x0, x27
1060f8adc: 946cb99e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8ae0: aa1303e0    	mov	x0, x19
1060f8ae4: 946cb99c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8ae8: aa1a03e0    	mov	x0, x26
1060f8aec: 340003fc    	cbz	w28, 0x1060f8b68 <_Flutter_MMFoundation_BindContext+0x25d474c>
1060f8af0: f94037e1    	ldr	x1, [sp, #0x68]
1060f8af4: 52800022    	mov	w2, #0x1                ; =1
1060f8af8: 946cb991    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8afc: aa1503e0    	mov	x0, x21
1060f8b00: aa1903e1    	mov	x1, x25
1060f8b04: 946cb98e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8b08: aa1d03fd    	mov	x29, x29
1060f8b0c: 946cb98f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f8b10: f00d09e8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060f8b14: b98a4509    	ldrsw	x9, [x8, #0xa44]
1060f8b18: f9404ffc    	ldr	x28, [sp, #0x98]
1060f8b1c: f8696b88    	ldr	x8, [x28, x9]
1060f8b20: f8296b80    	str	x0, [x28, x9]
1060f8b24: aa0803e0    	mov	x0, x8
1060f8b28: 946cb98b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8b2c: f9401be8    	ldr	x8, [sp, #0x30]
1060f8b30: f8686b93    	ldr	x19, [x28, x8]
1060f8b34: aa1503e0    	mov	x0, x21
1060f8b38: aa1903e1    	mov	x1, x25
1060f8b3c: 946cb980    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8b40: aa1d03fd    	mov	x29, x29
1060f8b44: 946cb981    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f8b48: aa0003fb    	mov	x27, x0
1060f8b4c: aa1303e0    	mov	x0, x19
1060f8b50: f9401fe1    	ldr	x1, [sp, #0x38]
1060f8b54: aa1b03e2    	mov	x2, x27
1060f8b58: 946cb979    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8b5c: aa1b03e0    	mov	x0, x27
1060f8b60: 946cb97d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8b64: 14000005    	b	0x1060f8b78 <_Flutter_MMFoundation_BindContext+0x25d475c>
1060f8b68: f94037e1    	ldr	x1, [sp, #0x68]
1060f8b6c: 52800042    	mov	w2, #0x2                ; =2
1060f8b70: 946cb973    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8b74: f9404ffc    	ldr	x28, [sp, #0x98]
1060f8b78: aa1503e0    	mov	x0, x21
1060f8b7c: aa1903e1    	mov	x1, x25
1060f8b80: 946cb96f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8b84: aa1d03fd    	mov	x29, x29
1060f8b88: 946cb970    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f8b8c: aa0003f3    	mov	x19, x0
1060f8b90: f00d09e8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060f8b94: b98a0108    	ldrsw	x8, [x8, #0xa00]
1060f8b98: f8686b82    	ldr	x2, [x28, x8]
1060f8b9c: aa1703e1    	mov	x1, x23
1060f8ba0: 946cb967    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8ba4: aa0003f5    	mov	x21, x0
1060f8ba8: aa1303e0    	mov	x0, x19
1060f8bac: 946cb96a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8bb0: 340000d5    	cbz	w21, 0x1060f8bc8 <_Flutter_MMFoundation_BindContext+0x25d47ac>
1060f8bb4: aa1a03e0    	mov	x0, x26
1060f8bb8: 946cb960    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1060f8bbc: f9402be0    	ldr	x0, [sp, #0x50]
1060f8bc0: 946cb965    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8bc4: f9002bfa    	str	x26, [sp, #0x50]
1060f8bc8: f9402fe0    	ldr	x0, [sp, #0x58]
1060f8bcc: aa1403e1    	mov	x1, x20
1060f8bd0: aa1a03e2    	mov	x2, x26
1060f8bd4: 946cb95a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8bd8: aa1a03e0    	mov	x0, x26
1060f8bdc: 946cb95e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8be0: 91000718    	add	x24, x24, #0x1
1060f8be4: f9404be8    	ldr	x8, [sp, #0x90]
1060f8be8: eb18011f    	cmp	x8, x24
1060f8bec: 54ffec41    	b.ne	0x1060f8974 <_Flutter_MMFoundation_BindContext+0x25d4558>
1060f8bf0: 910283e2    	add	x2, sp, #0xa0
1060f8bf4: 910543e3    	add	x3, sp, #0x150
1060f8bf8: f94023f4    	ldr	x20, [sp, #0x40]
1060f8bfc: aa1403e0    	mov	x0, x20
1060f8c00: f94017e1    	ldr	x1, [sp, #0x28]
1060f8c04: 52800204    	mov	w4, #0x10               ; =16
1060f8c08: 946cb94d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8c0c: 900ceeb7    	adrp	x23, 0x11fecc000 <dyld_stub_binder+0x11fecc000>
1060f8c10: f9004be0    	str	x0, [sp, #0x90]
1060f8c14: b5ffe800    	cbnz	x0, 0x1060f8914 <_Flutter_MMFoundation_BindContext+0x25d44f8>
1060f8c18: aa1403e0    	mov	x0, x20
1060f8c1c: 946cb94e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8c20: f9402bf5    	ldr	x21, [sp, #0x50]
1060f8c24: b4000255    	cbz	x21, 0x1060f8c6c <_Flutter_MMFoundation_BindContext+0x25d4850>
1060f8c28: f00d09e8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060f8c2c: b98a4508    	ldrsw	x8, [x8, #0xa44]
1060f8c30: f8686b82    	ldr	x2, [x28, x8]
1060f8c34: f94033f6    	ldr	x22, [sp, #0x60]
1060f8c38: f9401bf4    	ldr	x20, [sp, #0x30]
1060f8c3c: b40001c2    	cbz	x2, 0x1060f8c74 <_Flutter_MMFoundation_BindContext+0x25d4858>
1060f8c40: d00cefe8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060f8c44: f9419501    	ldr	x1, [x8, #0x328] ; setMInviteUserName:
1060f8c48: aa1503e0    	mov	x0, x21
1060f8c4c: 946cb93c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8c50: 14000009    	b	0x1060f8c74 <_Flutter_MMFoundation_BindContext+0x25d4858>
1060f8c54: aa1403e0    	mov	x0, x20
1060f8c58: 946cb93f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8c5c: d2800015    	mov	x21, #0x0               ; =0
1060f8c60: 14000004    	b	0x1060f8c70 <_Flutter_MMFoundation_BindContext+0x25d4854>
1060f8c64: b90027ff    	str	wzr, [sp, #0x24]
1060f8c68: 17fffdad    	b	0x1060f831c <_Flutter_MMFoundation_BindContext+0x25d3f00>
1060f8c6c: f94033f6    	ldr	x22, [sp, #0x60]
1060f8c70: f9401bf4    	ldr	x20, [sp, #0x30]
1060f8c74: f8746b80    	ldr	x0, [x28, x20]
1060f8c78: d00cefe8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060f8c7c: f9417d01    	ldr	x1, [x8, #0x2f8] ; setMMutilTalkGroupMemberList:
1060f8c80: f9402fe2    	ldr	x2, [sp, #0x58]
1060f8c84: 946cb92e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8c88: b94027e8    	ldr	w8, [sp, #0x24]
1060f8c8c: 340001e8    	cbz	w8, 0x1060f8cc8 <_Flutter_MMFoundation_BindContext+0x25d48ac>
1060f8c90: f00cf6a8    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
1060f8c94: f9405901    	ldr	x1, [x8, #0xb0] ; ilinkApiDelegate
1060f8c98: aa1c03e0    	mov	x0, x28
1060f8c9c: 946cb928    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8ca0: aa1d03fd    	mov	x29, x29
1060f8ca4: 946cb929    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f8ca8: aa0003f3    	mov	x19, x0
1060f8cac: f8746b82    	ldr	x2, [x28, x20]
1060f8cb0: d00cefe8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060f8cb4: f9439101    	ldr	x1, [x8, #0x720] ; onAcceptSubCallMultiTalk:
1060f8cb8: 946cb921    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8cbc: aa1303e0    	mov	x0, x19
1060f8cc0: 946cb925    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8cc4: 14000006    	b	0x1060f8cdc <_Flutter_MMFoundation_BindContext+0x25d48c0>
1060f8cc8: 3940e2c2    	ldrb	w2, [x22, #0x38]
1060f8ccc: b00cec68    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
1060f8cd0: f945c901    	ldr	x1, [x8, #0xb90] ; accept:
1060f8cd4: aa1c03e0    	mov	x0, x28
1060f8cd8: 946cb919    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f8cdc: f9400ff3    	ldr	x19, [sp, #0x18]
1060f8ce0: f9402fe0    	ldr	x0, [sp, #0x58]
1060f8ce4: 946cb91c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8ce8: aa1503e0    	mov	x0, x21
1060f8cec: 946cb91a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8cf0: aa1c03e0    	mov	x0, x28
1060f8cf4: 946cb918    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8cf8: aa1303e0    	mov	x0, x19
1060f8cfc: 946cb916    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f8d00: f85a03a8    	ldur	x8, [x29, #-0x60]
1060f8d04: f00ba7a9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1060f8d08: f9405929    	ldr	x9, [x9, #0xb0]
1060f8d0c: f9400129    	ldr	x9, [x9]
1060f8d10: eb08013f    	cmp	x9, x8
1060f8d14: 54000121    	b.ne	0x1060f8d38 <_Flutter_MMFoundation_BindContext+0x25d491c>
1060f8d18: 910983ff    	add	sp, sp, #0x260
1060f8d1c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1060f8d20: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1060f8d24: a94357f6    	ldp	x22, x21, [sp, #0x30]
1060f8d28: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1060f8d2c: a94167fa    	ldp	x26, x25, [sp, #0x10]
1060f8d30: a8c66ffc    	ldp	x28, x27, [sp], #0x60
1060f8d34: d65f03c0    	ret
1060f8d38: 946cb90f    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
