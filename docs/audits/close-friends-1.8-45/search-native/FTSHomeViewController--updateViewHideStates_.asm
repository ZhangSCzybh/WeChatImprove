
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10176628c: d10203ff    	sub	sp, sp, #0x80
101766290: a9026ffc    	stp	x28, x27, [sp, #0x20]
101766294: a90367fa    	stp	x26, x25, [sp, #0x30]
101766298: a9045ff8    	stp	x24, x23, [sp, #0x40]
10176629c: a90557f6    	stp	x22, x21, [sp, #0x50]
1017662a0: a9064ff4    	stp	x20, x19, [sp, #0x60]
1017662a4: a9077bfd    	stp	x29, x30, [sp, #0x70]
1017662a8: 9101c3fd    	add	x29, sp, #0x70
1017662ac: aa0203f6    	mov	x22, x2
1017662b0: aa0003f3    	mov	x19, x0
1017662b4: 900fa668    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
1017662b8: 52800029    	mov	w9, #0x1                ; =1
1017662bc: 3922d109    	strb	w9, [x8, #0x8b4]
1017662c0: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017662c4: f941c101    	ldr	x1, [x8, #0x380] ; setIsSearchBarHasText:
1017662c8: 52000042    	eor	w2, w2, #0x1
1017662cc: 9593039c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017662d0: b00f507b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
1017662d4: f9453774    	ldr	x20, [x27, #0xa68]
1017662d8: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017662dc: f941c515    	ldr	x21, [x8, #0x388] ; isSearchBarHasText
1017662e0: aa1303e0    	mov	x0, x19
1017662e4: aa1503e1    	mov	x1, x21
1017662e8: 95930395    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017662ec: f00f3688    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1017662f0: f942a917    	ldr	x23, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1017662f4: a90083f6    	stp	x22, x0, [sp, #0x8]
1017662f8: b00e7168    	adrp	x8, 0x11e593000 <dyld_stub_binder+0x11e593000>
1017662fc: 910a2108    	add	x8, x8, #0x288
101766300: f90003e8    	str	x8, [sp]
101766304: d00ce363    	adrp	x3, 0x11b3d4000 <dyld_stub_binder+0x11b3d4000>
101766308: 91212063    	add	x3, x3, #0x848
10176630c: b00ce3e5    	adrp	x5, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
101766310: 911b74a5    	add	x5, x5, #0x6dd
101766314: d00ce3e7    	adrp	x7, 0x11b3e4000 <dyld_stub_binder+0x11b3e4000>
101766318: 910ba8e7    	add	x7, x7, #0x2ea
10176631c: aa1403e0    	mov	x0, x20
101766320: aa1703e1    	mov	x1, x23
101766324: 52800042    	mov	w2, #0x2                ; =2
101766328: 52800004    	mov	w4, #0x0                ; =0
10176632c: 52809006    	mov	w6, #0x480              ; =1152
101766330: 95930383    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766334: d00f5448    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
101766338: b98db108    	ldrsw	x8, [x8, #0xdb0]
10176633c: f8686a60    	ldr	x0, [x19, x8]
101766340: 900f4d28    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
101766344: f947bd01    	ldr	x1, [x8, #0xf78] ; tableView
101766348: 9593037d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10176634c: aa1d03fd    	mov	x29, x29
101766350: 9593037e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766354: aa0003f8    	mov	x24, x0
101766358: d00f4d08    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10176635c: f9411114    	ldr	x20, [x8, #0x220] ; setHidden:
101766360: aa1403e1    	mov	x1, x20
101766364: aa1603e2    	mov	x2, x22
101766368: 95930375    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10176636c: aa1803e0    	mov	x0, x24
101766370: 95930379    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766374: aa1303e0    	mov	x0, x19
101766378: aa1503e1    	mov	x1, x21
10176637c: 95930370    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766380: 52800016    	mov	w22, #0x0               ; =0
101766384: 370000c0    	tbnz	w0, #0x0, 0x10176639c <__text+0x175e39c>
101766388: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
10176638c: f941c901    	ldr	x1, [x8, #0x390] ; isCurrentInDeepThinking
101766390: aa1303e0    	mov	x0, x19
101766394: 9593036a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766398: 52000016    	eor	w22, w0, #0x1
10176639c: f9453760    	ldr	x0, [x27, #0xa68]
1017663a0: b00e7168    	adrp	x8, 0x11e593000 <dyld_stub_binder+0x11e593000>
1017663a4: 910aa108    	add	x8, x8, #0x2a8
1017663a8: a9005be8    	stp	x8, x22, [sp]
1017663ac: d00ce379    	adrp	x25, 0x11b3d4000 <dyld_stub_binder+0x11b3d4000>
1017663b0: 91212339    	add	x25, x25, #0x848
1017663b4: b00ce3fa    	adrp	x26, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
1017663b8: 911b775a    	add	x26, x26, #0x6dd
1017663bc: d00ce3f8    	adrp	x24, 0x11b3e4000 <dyld_stub_binder+0x11b3e4000>
1017663c0: 910bab18    	add	x24, x24, #0x2ea
1017663c4: aa1703e1    	mov	x1, x23
1017663c8: 52800042    	mov	w2, #0x2                ; =2
1017663cc: aa1903e3    	mov	x3, x25
1017663d0: 52800004    	mov	w4, #0x0                ; =0
1017663d4: aa1a03e5    	mov	x5, x26
1017663d8: 528090a6    	mov	w6, #0x485              ; =1157
1017663dc: aa1803e7    	mov	x7, x24
1017663e0: 95930357    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017663e4: d00f5448    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1017663e8: b98db908    	ldrsw	x8, [x8, #0xdb8]
1017663ec: f8686a60    	ldr	x0, [x19, x8]
1017663f0: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017663f4: f941cd01    	ldr	x1, [x8, #0x398] ; setIsVisable:
1017663f8: aa1603e2    	mov	x2, x22
1017663fc: 95930350    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766400: aa1303e0    	mov	x0, x19
101766404: aa1503e1    	mov	x1, x21
101766408: 9593034d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10176640c: aa0003e3    	mov	x3, x0
101766410: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101766414: f941d101    	ldr	x1, [x8, #0x3a0] ; updateCheckBoxHidden:sugTableShowed:
101766418: aa1303e0    	mov	x0, x19
10176641c: aa1603e2    	mov	x2, x22
101766420: 95930347    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766424: f945377b    	ldr	x27, [x27, #0xa68]
101766428: aa1303e0    	mov	x0, x19
10176642c: aa1503e1    	mov	x1, x21
101766430: 95930343    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766434: 52000008    	eor	w8, w0, #0x1
101766438: b00e7169    	adrp	x9, 0x11e593000 <dyld_stub_binder+0x11e593000>
10176643c: 910b2129    	add	x9, x9, #0x2c8
101766440: a90023e9    	stp	x9, x8, [sp]
101766444: aa1b03e0    	mov	x0, x27
101766448: aa1703e1    	mov	x1, x23
10176644c: 52800042    	mov	w2, #0x2                ; =2
101766450: aa1903e3    	mov	x3, x25
101766454: 52800004    	mov	w4, #0x0                ; =0
101766458: aa1a03e5    	mov	x5, x26
10176645c: 52809106    	mov	w6, #0x488              ; =1160
101766460: aa1803e7    	mov	x7, x24
101766464: 95930336    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766468: aa1303e0    	mov	x0, x19
10176646c: aa1503e1    	mov	x1, x21
101766470: 95930333    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766474: aa0003f5    	mov	x21, x0
101766478: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
10176647c: f9403d17    	ldr	x23, [x8, #0x78] ; floatingVoiceInputView
101766480: aa1303e0    	mov	x0, x19
101766484: aa1703e1    	mov	x1, x23
101766488: 9593032d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10176648c: aa1d03fd    	mov	x29, x29
101766490: 9593032e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766494: aa0003f8    	mov	x24, x0
101766498: aa1403e1    	mov	x1, x20
10176649c: aa1503e2    	mov	x2, x21
1017664a0: 95930327    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017664a4: aa1803e0    	mov	x0, x24
1017664a8: 9593032b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017664ac: aa1303e0    	mov	x0, x19
1017664b0: aa1703e1    	mov	x1, x23
1017664b4: 95930322    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017664b8: aa1d03fd    	mov	x29, x29
1017664bc: 95930323    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017664c0: aa0003f5    	mov	x21, x0
1017664c4: b00f4ce8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1017664c8: f943f901    	ldr	x1, [x8, #0x7f0] ; isHidden
1017664cc: 9593031c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017664d0: aa0003f7    	mov	x23, x0
1017664d4: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017664d8: f941d501    	ldr	x1, [x8, #0x3a8] ; aiTipsView
1017664dc: aa1303e0    	mov	x0, x19
1017664e0: 95930317    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017664e4: aa1d03fd    	mov	x29, x29
1017664e8: 95930318    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017664ec: aa0003f8    	mov	x24, x0
1017664f0: aa1403e1    	mov	x1, x20
1017664f4: aa1703e2    	mov	x2, x23
1017664f8: 95930311    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017664fc: aa1803e0    	mov	x0, x24
101766500: 95930315    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766504: aa1503e0    	mov	x0, x21
101766508: 95930313    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10176650c: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101766510: f9404101    	ldr	x1, [x8, #0x80] ; settingButton
101766514: aa1303e0    	mov	x0, x19
101766518: 95930309    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10176651c: aa1d03fd    	mov	x29, x29
101766520: 9593030a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766524: aa0003f3    	mov	x19, x0
101766528: 520002c2    	eor	w2, w22, #0x1
10176652c: aa1403e1    	mov	x1, x20
101766530: 95930303    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766534: aa1303e0    	mov	x0, x19
101766538: a9477bfd    	ldp	x29, x30, [sp, #0x70]
10176653c: a9464ff4    	ldp	x20, x19, [sp, #0x60]
101766540: a94557f6    	ldp	x22, x21, [sp, #0x50]
101766544: a9445ff8    	ldp	x24, x23, [sp, #0x40]
101766548: a94367fa    	ldp	x26, x25, [sp, #0x30]
10176654c: a9426ffc    	ldp	x28, x27, [sp, #0x20]
101766550: 910203ff    	add	sp, sp, #0x80
101766554: 15930300    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
