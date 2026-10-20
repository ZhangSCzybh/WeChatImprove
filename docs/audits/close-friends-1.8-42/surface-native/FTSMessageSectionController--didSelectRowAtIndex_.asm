
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101796178: d10543ff    	sub	sp, sp, #0x150
10179617c: a90f6ffc    	stp	x28, x27, [sp, #0xf0]
101796180: a91067fa    	stp	x26, x25, [sp, #0x100]
101796184: a9115ff8    	stp	x24, x23, [sp, #0x110]
101796188: a91257f6    	stp	x22, x21, [sp, #0x120]
10179618c: a9134ff4    	stp	x20, x19, [sp, #0x130]
101796190: a9147bfd    	stp	x29, x30, [sp, #0x140]
101796194: 910503fd    	add	x29, sp, #0x140
101796198: aa0203f9    	mov	x25, x2
10179619c: aa0003f4    	mov	x20, x0
1017961a0: b00df2c8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1017961a4: f9405908    	ldr	x8, [x8, #0xb0]
1017961a8: f9400108    	ldr	x8, [x8]
1017961ac: f81a03a8    	stur	x8, [x29, #-0x60]
1017961b0: 900fa4e8    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
1017961b4: 52800029    	mov	w9, #0x1                ; =1
1017961b8: 3925a909    	strb	w9, [x8, #0x96a]
1017961bc: 900f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1017961c0: f9426101    	ldr	x1, [x8, #0x4c0] ; isDetailSearch
1017961c4: 959243de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017961c8: 36002620    	tbz	w0, #0x0, 0x10179668c <__text+0x178e68c>
1017961cc: 900f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1017961d0: f9424913    	ldr	x19, [x8, #0x490] ; tableViewContext
1017961d4: aa1403e0    	mov	x0, x20
1017961d8: aa1303e1    	mov	x1, x19
1017961dc: 959243d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017961e0: aa1d03fd    	mov	x29, x29
1017961e4: 959243d9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017961e8: aa0003f5    	mov	x21, x0
1017961ec: 900f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1017961f0: f942e901    	ldr	x1, [x8, #0x5d0] ; deselectRowAtIndex:sectionController:animated:
1017961f4: aa1903e2    	mov	x2, x25
1017961f8: aa1403e3    	mov	x3, x20
1017961fc: 52800024    	mov	w4, #0x1                ; =1
101796200: 959243cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796204: aa1503e0    	mov	x0, x21
101796208: 959243d3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10179620c: aa1403e0    	mov	x0, x20
101796210: aa1303e1    	mov	x1, x19
101796214: 959243ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796218: aa1d03fd    	mov	x29, x29
10179621c: 959243cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796220: aa0003f3    	mov	x19, x0
101796224: 900f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101796228: f942f101    	ldr	x1, [x8, #0x5e0] ; cellForItemAtIndex:sectionController:
10179622c: aa1903e2    	mov	x2, x25
101796230: aa1403e3    	mov	x3, x20
101796234: 959243c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796238: aa1d03fd    	mov	x29, x29
10179623c: 959243c3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796240: aa0003f6    	mov	x22, x0
101796244: aa1303e0    	mov	x0, x19
101796248: 959243c3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10179624c: b00f4f48    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
101796250: f942e100    	ldr	x0, [x8, #0x5c0]
101796254: b00f4b48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101796258: f947ad15    	ldr	x21, [x8, #0xf58] ; class
10179625c: aa1503e1    	mov	x1, x21
101796260: 959243b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796264: aa0003e2    	mov	x2, x0
101796268: b00f4b68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10179626c: f9442d13    	ldr	x19, [x8, #0x858] ; isKindOfClass:
101796270: aa1603e0    	mov	x0, x22
101796274: aa1303e1    	mov	x1, x19
101796278: 959243b1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10179627c: 340021a0    	cbz	w0, 0x1017966b0 <__text+0x178e6b0>
101796280: b00f4f48    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
101796284: f9413900    	ldr	x0, [x8, #0x270]
101796288: 959243b6    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10179628c: aa0003f3    	mov	x19, x0
101796290: 900f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101796294: f942b518    	ldr	x24, [x8, #0x568] ; resultPage
101796298: aa1403e0    	mov	x0, x20
10179629c: aa1803e1    	mov	x1, x24
1017962a0: 959243a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017962a4: aa1d03fd    	mov	x29, x29
1017962a8: 959243a8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017962ac: aa0003f7    	mov	x23, x0
1017962b0: 900f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1017962b4: f9430519    	ldr	x25, [x8, #0x608] ; getFTSContext
1017962b8: aa1903e1    	mov	x1, x25
1017962bc: 959243a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017962c0: aa1d03fd    	mov	x29, x29
1017962c4: 959243a1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017962c8: aa0003fa    	mov	x26, x0
1017962cc: 900f4b68    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1017962d0: f9476501    	ldr	x1, [x8, #0xec8] ; initWithContext:
1017962d4: aa1303e0    	mov	x0, x19
1017962d8: aa1a03e2    	mov	x2, x26
1017962dc: 95924398    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017962e0: aa0003f3    	mov	x19, x0
1017962e4: aa1a03e0    	mov	x0, x26
1017962e8: 9592439b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017962ec: aa1703e0    	mov	x0, x23
1017962f0: 95924399    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017962f4: d00f35a8    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
1017962f8: f9463d01    	ldr	x1, [x8, #0xc78] ; loadViewIfNeeded
1017962fc: f9002bf3    	str	x19, [sp, #0x50]
101796300: aa1303e0    	mov	x0, x19
101796304: 9592438e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796308: b00f3888    	adrp	x8, 0x11fea7000 <dyld_stub_binder+0x11fea7000>
10179630c: f9458d01    	ldr	x1, [x8, #0xb18] ; msgScopeView
101796310: aa1303e0    	mov	x0, x19
101796314: 9592438a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796318: aa1d03fd    	mov	x29, x29
10179631c: 9592438b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796320: aa0003f7    	mov	x23, x0
101796324: aa1403e0    	mov	x0, x20
101796328: aa1803e1    	mov	x1, x24
10179632c: 95924384    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796330: aa1d03fd    	mov	x29, x29
101796334: 95924385    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796338: aa0003f3    	mov	x19, x0
10179633c: aa1903e1    	mov	x1, x25
101796340: 9592437f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796344: aa1d03fd    	mov	x29, x29
101796348: 95924380    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10179634c: aa0003f8    	mov	x24, x0
101796350: f00f3608    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
101796354: f9422501    	ldr	x1, [x8, #0x448] ; searchScene
101796358: 95924379    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10179635c: aa0003e2    	mov	x2, x0
101796360: d00f3528    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101796364: f943bd01    	ldr	x1, [x8, #0x778] ; setSearchScene:
101796368: aa1703e0    	mov	x0, x23
10179636c: 95924374    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796370: aa1803e0    	mov	x0, x24
101796374: 95924378    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796378: aa1303e0    	mov	x0, x19
10179637c: 95924376    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796380: b00f4ba8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
101796384: f946dd01    	ldr	x1, [x8, #0xdb8] ; viewController
101796388: f90027e1    	str	x1, [sp, #0x48]
10179638c: aa1403e0    	mov	x0, x20
101796390: 9592436b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796394: aa1d03fd    	mov	x29, x29
101796398: 9592436c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10179639c: aa0003f3    	mov	x19, x0
1017963a0: 900f4ba8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1017963a4: f9412d01    	ldr	x1, [x8, #0x258] ; setViewController:
1017963a8: aa1703e0    	mov	x0, x23
1017963ac: aa1303e2    	mov	x2, x19
1017963b0: 95924363    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017963b4: aa1303e0    	mov	x0, x19
1017963b8: 95924367    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017963bc: b00f4ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1017963c0: f945e900    	ldr	x0, [x8, #0xbd0]
1017963c4: d00f4b48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1017963c8: f944e91c    	ldr	x28, [x8, #0x9d0] ; currentContext
1017963cc: aa1c03e1    	mov	x1, x28
1017963d0: 9592435b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017963d4: aa1d03fd    	mov	x29, x29
1017963d8: 9592435c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017963dc: aa0003fa    	mov	x26, x0
1017963e0: b00f4ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1017963e4: f9477100    	ldr	x0, [x8, #0xee0]
1017963e8: aa1503e1    	mov	x1, x21
1017963ec: 95924354    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017963f0: aa0003e2    	mov	x2, x0
1017963f4: f00f3508    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1017963f8: f9464113    	ldr	x19, [x8, #0xc80] ; getService:
1017963fc: aa1a03e0    	mov	x0, x26
101796400: aa1303e1    	mov	x1, x19
101796404: 9592434e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796408: aa1d03fd    	mov	x29, x29
10179640c: 9592434f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796410: aa0003fb    	mov	x27, x0
101796414: f00f35a8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
101796418: f9472d01    	ldr	x1, [x8, #0xe58] ; ftsMessageMgr
10179641c: 95924348    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796420: aa1d03fd    	mov	x29, x29
101796424: 95924349    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796428: aa0003f8    	mov	x24, x0
10179642c: 900f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101796430: f943a101    	ldr	x1, [x8, #0x740] ; ftsTaskKey
101796434: aa1403e0    	mov	x0, x20
101796438: 95924341    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10179643c: aa1d03fd    	mov	x29, x29
101796440: 95924342    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796444: f9002ff6    	str	x22, [sp, #0x58]
101796448: aa0003f6    	mov	x22, x0
10179644c: f00f3888    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101796450: f943a101    	ldr	x1, [x8, #0x740] ; getTaskForkey:
101796454: aa1803e0    	mov	x0, x24
101796458: aa1603e2    	mov	x2, x22
10179645c: 95924338    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796460: aa1d03fd    	mov	x29, x29
101796464: 95924339    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796468: aa0003f9    	mov	x25, x0
10179646c: aa1603e0    	mov	x0, x22
101796470: 95924339    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796474: aa1803e0    	mov	x0, x24
101796478: 95924337    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10179647c: aa1b03e0    	mov	x0, x27
101796480: 95924335    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796484: aa1a03e0    	mov	x0, x26
101796488: 95924333    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10179648c: 900f38a8    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
101796490: f9401101    	ldr	x1, [x8, #0x20] ; parsedTalkerFromQuery
101796494: aa1903e0    	mov	x0, x25
101796498: 95924329    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10179649c: aa1d03fd    	mov	x29, x29
1017964a0: 9592432a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017964a4: aa0003fa    	mov	x26, x0
1017964a8: 900f38a8    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
1017964ac: f9401501    	ldr	x1, [x8, #0x28] ; parsedQueryFromQuery
1017964b0: aa1903e0    	mov	x0, x25
1017964b4: 95924322    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017964b8: aa1d03fd    	mov	x29, x29
1017964bc: 95924323    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017964c0: aa0003fb    	mov	x27, x0
1017964c4: b00f4ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1017964c8: f9453500    	ldr	x0, [x8, #0xa68]
1017964cc: f00f3508    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1017964d0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1017964d4: a900effa    	stp	x26, x27, [sp, #0x8]
1017964d8: f00e6fe8    	adrp	x8, 0x11e595000 <dyld_stub_binder+0x11e595000>
1017964dc: 91132108    	add	x8, x8, #0x4c8
1017964e0: f90003e8    	str	x8, [sp]
1017964e4: d00cd6e3    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
1017964e8: 91388063    	add	x3, x3, #0xe20
1017964ec: d00ce285    	adrp	x5, 0x11b3e8000 <dyld_stub_binder+0x11b3e8000>
1017964f0: 913834a5    	add	x5, x5, #0xe0d
1017964f4: d00ce287    	adrp	x7, 0x11b3e8000 <dyld_stub_binder+0x11b3e8000>
1017964f8: 9138b0e7    	add	x7, x7, #0xe2c
1017964fc: 52800042    	mov	w2, #0x2                ; =2
101796500: 52800004    	mov	w4, #0x0                ; =0
101796504: 52801446    	mov	w6, #0xa2               ; =162
101796508: 9592430d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10179650c: b00f3888    	adrp	x8, 0x11fea7000 <dyld_stub_binder+0x11fea7000>
101796510: f9459101    	ldr	x1, [x8, #0xb20] ; configTagSearchLogicForSession:asCluster:andSessionResult:andTalkerContact:andTalkerMatchTip:andTalkerQuery:andSearchText:bSessionFirst:
101796514: 52800028    	mov	w8, #0x1                ; =1
101796518: 390023e8    	strb	w8, [sp, #0x8]
10179651c: f90003fb    	str	x27, [sp]
101796520: aa1703e0    	mov	x0, x23
101796524: d2800002    	mov	x2, #0x0                ; =0
101796528: 52800003    	mov	w3, #0x0                ; =0
10179652c: d2800004    	mov	x4, #0x0                ; =0
101796530: d2800005    	mov	x5, #0x0                ; =0
101796534: d2800006    	mov	x6, #0x0                ; =0
101796538: aa1a03e7    	mov	x7, x26
10179653c: 95924300    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796540: 900f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101796544: f9436901    	ldr	x1, [x8, #0x6d0] ; searchBarText
101796548: aa1703e0    	mov	x0, x23
10179654c: 959242fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796550: aa1d03fd    	mov	x29, x29
101796554: 959242fd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796558: aa0003f6    	mov	x22, x0
10179655c: b00f3888    	adrp	x8, 0x11fea7000 <dyld_stub_binder+0x11fea7000>
101796560: f9459501    	ldr	x1, [x8, #0xb28] ; setDefaultKeyWord:
101796564: aa1703e0    	mov	x0, x23
101796568: aa1603e2    	mov	x2, x22
10179656c: 959242f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796570: aa1603e0    	mov	x0, x22
101796574: 959242f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796578: b00f4ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10179657c: f945e900    	ldr	x0, [x8, #0xbd0]
101796580: aa1c03e1    	mov	x1, x28
101796584: 959242ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796588: aa1d03fd    	mov	x29, x29
10179658c: 959242ef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796590: aa0003f6    	mov	x22, x0
101796594: b00f4ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101796598: f9477100    	ldr	x0, [x8, #0xee0]
10179659c: aa1503e1    	mov	x1, x21
1017965a0: 959242e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017965a4: aa0003e2    	mov	x2, x0
1017965a8: aa1603e0    	mov	x0, x22
1017965ac: aa1303e1    	mov	x1, x19
1017965b0: 959242e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017965b4: aa1d03fd    	mov	x29, x29
1017965b8: 959242e4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017965bc: aa0003f3    	mov	x19, x0
1017965c0: 900f3788    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
1017965c4: f9454d01    	ldr	x1, [x8, #0xa98] ; ftsReportMgr
1017965c8: 959242dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017965cc: aa1d03fd    	mov	x29, x29
1017965d0: 959242de    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017965d4: aa0003f5    	mov	x21, x0
1017965d8: 900f38a8    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
1017965dc: f9409501    	ldr	x1, [x8, #0x128] ; reportKVMsgResultClickType:pageType:showTalkerEntry:
1017965e0: 52800042    	mov	w2, #0x2                ; =2
1017965e4: 52800043    	mov	w3, #0x2                ; =2
1017965e8: 52800024    	mov	w4, #0x1                ; =1
1017965ec: 959242d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017965f0: aa1503e0    	mov	x0, x21
1017965f4: 959242d8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017965f8: aa1303e0    	mov	x0, x19
1017965fc: 959242d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796600: aa1603e0    	mov	x0, x22
101796604: f9402ff6    	ldr	x22, [sp, #0x58]
101796608: 959242d3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10179660c: aa1403e0    	mov	x0, x20
101796610: f94027e1    	ldr	x1, [sp, #0x48]
101796614: 959242ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796618: aa1d03fd    	mov	x29, x29
10179661c: 959242cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796620: aa0003f3    	mov	x19, x0
101796624: d00f4b68    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101796628: f945dd01    	ldr	x1, [x8, #0xbb8] ; navigationController
10179662c: 959242c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796630: aa1d03fd    	mov	x29, x29
101796634: 959242c5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796638: aa0003f4    	mov	x20, x0
10179663c: b00f3528    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101796640: f944e101    	ldr	x1, [x8, #0x9c0] ; PushViewController:animated:
101796644: f9402bf5    	ldr	x21, [sp, #0x50]
101796648: aa1503e2    	mov	x2, x21
10179664c: 52800023    	mov	w3, #0x1                ; =1
101796650: 959242bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796654: aa1403e0    	mov	x0, x20
101796658: 959242bf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10179665c: aa1303e0    	mov	x0, x19
101796660: 959242bd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796664: aa1b03e0    	mov	x0, x27
101796668: 959242bb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10179666c: aa1a03e0    	mov	x0, x26
101796670: 959242b9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796674: aa1903e0    	mov	x0, x25
101796678: 959242b7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10179667c: aa1703e0    	mov	x0, x23
101796680: 959242b5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796684: aa1503e0    	mov	x0, x21
101796688: 14000192    	b	0x101796cd0 <__text+0x178ecd0>
10179668c: b00f5128    	adrp	x8, 0x1201bb000 <dyld_stub_binder+0x1201bb000>
101796690: f9469d08    	ldr	x8, [x8, #0xd38]
101796694: a90623f4    	stp	x20, x8, [sp, #0x60]
101796698: 900f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
10179669c: f9427901    	ldr	x1, [x8, #0x4f0] ; didSelectRowAtIndex:
1017966a0: 910183e0    	add	x0, sp, #0x60
1017966a4: aa1903e2    	mov	x2, x25
1017966a8: 959242a7    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
1017966ac: 1400018c    	b	0x101796cdc <__text+0x178ecdc>
1017966b0: b00f4f48    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
1017966b4: f942e500    	ldr	x0, [x8, #0x5c8]
1017966b8: aa1503e1    	mov	x1, x21
1017966bc: 959242a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017966c0: aa0003e2    	mov	x2, x0
1017966c4: aa1603e0    	mov	x0, x22
1017966c8: aa1303e1    	mov	x1, x19
1017966cc: 9592429c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017966d0: 34002d40    	cbz	w0, 0x101796c78 <__text+0x178ec78>
1017966d4: f9002ff6    	str	x22, [sp, #0x58]
1017966d8: b00f4ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1017966dc: f945e900    	ldr	x0, [x8, #0xbd0]
1017966e0: d00f4b48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1017966e4: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1017966e8: aa0103fc    	mov	x28, x1
1017966ec: 95924294    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017966f0: aa1d03fd    	mov	x29, x29
1017966f4: 95924295    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017966f8: aa0003f6    	mov	x22, x0
1017966fc: b00f4ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101796700: f9477100    	ldr	x0, [x8, #0xee0]
101796704: aa1503e1    	mov	x1, x21
101796708: 9592428d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10179670c: aa0003e2    	mov	x2, x0
101796710: f00f3508    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101796714: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
101796718: f9001be1    	str	x1, [sp, #0x30]
10179671c: aa1603e0    	mov	x0, x22
101796720: 95924287    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796724: aa1d03fd    	mov	x29, x29
101796728: 95924288    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10179672c: aa0003f7    	mov	x23, x0
101796730: f00f35a8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
101796734: f9472d13    	ldr	x19, [x8, #0xe58] ; ftsMessageMgr
101796738: aa1303e1    	mov	x1, x19
10179673c: 95924280    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796740: aa1d03fd    	mov	x29, x29
101796744: 95924281    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796748: aa0003f8    	mov	x24, x0
10179674c: 900f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101796750: f943a11a    	ldr	x26, [x8, #0x740] ; ftsTaskKey
101796754: aa1403e0    	mov	x0, x20
101796758: aa1a03e1    	mov	x1, x26
10179675c: 95924278    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796760: aa1d03fd    	mov	x29, x29
101796764: 95924279    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796768: aa0003fb    	mov	x27, x0
10179676c: b00f3888    	adrp	x8, 0x11fea7000 <dyld_stub_binder+0x11fea7000>
101796770: f9457d01    	ldr	x1, [x8, #0xaf8] ; getLastQueryText:
101796774: aa1803e0    	mov	x0, x24
101796778: aa1b03e2    	mov	x2, x27
10179677c: 95924270    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796780: aa1d03fd    	mov	x29, x29
101796784: 95924271    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796788: f9002be0    	str	x0, [sp, #0x50]
10179678c: aa1b03e0    	mov	x0, x27
101796790: 95924271    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796794: aa1803e0    	mov	x0, x24
101796798: 9592426f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10179679c: aa1703e0    	mov	x0, x23
1017967a0: 9592426d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017967a4: aa1603e0    	mov	x0, x22
1017967a8: 9592426b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017967ac: d1000722    	sub	x2, x25, #0x1
1017967b0: 900f38a8    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
1017967b4: f9408101    	ldr	x1, [x8, #0x100] ; sessionMsgItemsForDisplayedItemRow:
1017967b8: aa1403e0    	mov	x0, x20
1017967bc: f9000fe2    	str	x2, [sp, #0x18]
1017967c0: 9592425f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017967c4: aa1d03fd    	mov	x29, x29
1017967c8: 95924260    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017967cc: aa0003f6    	mov	x22, x0
1017967d0: f00df2c8    	adrp	x8, 0x11d5f1000 <dyld_stub_binder+0x11d5f1000>
1017967d4: f940e108    	ldr	x8, [x8, #0x1c0]
1017967d8: f9400108    	ldr	x8, [x8]
1017967dc: f100001f    	cmp	x0, #0x0
1017967e0: 9a800100    	csel	x0, x8, x0, eq
1017967e4: f90023e0    	str	x0, [sp, #0x40]
1017967e8: 95924254    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1017967ec: aa1603e0    	mov	x0, x22
1017967f0: 95924259    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017967f4: b00f4ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1017967f8: f945e900    	ldr	x0, [x8, #0xbd0]
1017967fc: aa1c03fb    	mov	x27, x28
101796800: aa1c03e1    	mov	x1, x28
101796804: 9592424e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796808: aa1d03fd    	mov	x29, x29
10179680c: 9592424f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796810: aa0003f6    	mov	x22, x0
101796814: b00f4ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101796818: f9477100    	ldr	x0, [x8, #0xee0]
10179681c: aa1503e1    	mov	x1, x21
101796820: 95924247    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796824: aa0003e2    	mov	x2, x0
101796828: aa1603e0    	mov	x0, x22
10179682c: f9401bfc    	ldr	x28, [sp, #0x30]
101796830: aa1c03e1    	mov	x1, x28
101796834: 95924242    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796838: aa1d03fd    	mov	x29, x29
10179683c: 95924243    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796840: aa0003f7    	mov	x23, x0
101796844: aa1303e1    	mov	x1, x19
101796848: 9592423d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10179684c: aa1d03fd    	mov	x29, x29
101796850: 9592423e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796854: aa0003f3    	mov	x19, x0
101796858: aa1403e0    	mov	x0, x20
10179685c: f90027fa    	str	x26, [sp, #0x48]
101796860: aa1a03e1    	mov	x1, x26
101796864: 95924236    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796868: aa1d03fd    	mov	x29, x29
10179686c: 95924237    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796870: aa0003f8    	mov	x24, x0
101796874: 900f38a8    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
101796878: f9409901    	ldr	x1, [x8, #0x130] ; getTotalMsgItemsCountForQuery:taskKey:
10179687c: aa1303e0    	mov	x0, x19
101796880: f9402be2    	ldr	x2, [sp, #0x50]
101796884: aa1803e3    	mov	x3, x24
101796888: 9592422d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10179688c: aa0003fa    	mov	x26, x0
101796890: aa1803e0    	mov	x0, x24
101796894: 95924230    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796898: aa1303e0    	mov	x0, x19
10179689c: 9592422e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017968a0: aa1703e0    	mov	x0, x23
1017968a4: 9592422c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017968a8: aa1603e0    	mov	x0, x22
1017968ac: 9592422a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017968b0: b00f4ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1017968b4: f945e900    	ldr	x0, [x8, #0xbd0]
1017968b8: aa1b03e1    	mov	x1, x27
1017968bc: 95924220    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017968c0: aa1d03fd    	mov	x29, x29
1017968c4: 95924221    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017968c8: aa0003f3    	mov	x19, x0
1017968cc: f9001fe0    	str	x0, [sp, #0x38]
1017968d0: b00f4ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1017968d4: f9477100    	ldr	x0, [x8, #0xee0]
1017968d8: aa1503e1    	mov	x1, x21
1017968dc: 95924218    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017968e0: aa0003e2    	mov	x2, x0
1017968e4: aa1303e0    	mov	x0, x19
1017968e8: aa1c03e1    	mov	x1, x28
1017968ec: 95924214    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017968f0: aa1d03fd    	mov	x29, x29
1017968f4: 95924215    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017968f8: f9001be0    	str	x0, [sp, #0x30]
1017968fc: 900f3788    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
101796900: f9454d01    	ldr	x1, [x8, #0xa98] ; ftsReportMgr
101796904: 9592420e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796908: aa1d03fd    	mov	x29, x29
10179690c: 9592420f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796910: f90013e0    	str	x0, [sp, #0x20]
101796914: d00e6848    	adrp	x8, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
101796918: 912f2108    	add	x8, x8, #0xbc8
10179691c: f9003be8    	str	x8, [sp, #0x70]
101796920: b00f4efc    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
101796924: f9458b96    	ldr	x22, [x28, #0xb10]
101796928: 900f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
10179692c: f942b501    	ldr	x1, [x8, #0x568] ; resultPage
101796930: aa1403e0    	mov	x0, x20
101796934: 95924202    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796938: aa1d03fd    	mov	x29, x29
10179693c: 95924203    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796940: f90017e0    	str	x0, [sp, #0x28]
101796944: 900f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101796948: f9430501    	ldr	x1, [x8, #0x608] ; getFTSContext
10179694c: 959241fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796950: aa1d03fd    	mov	x29, x29
101796954: 959241fd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796958: aa0003f3    	mov	x19, x0
10179695c: f00f3608    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
101796960: f9422501    	ldr	x1, [x8, #0x448] ; searchScene
101796964: 959241f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796968: aa0003e2    	mov	x2, x0
10179696c: d00f4b68    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101796970: f947c11b    	ldr	x27, [x8, #0xf80] ; numberWithUnsignedInteger:
101796974: aa1603e0    	mov	x0, x22
101796978: aa1b03e1    	mov	x1, x27
10179697c: 959241f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796980: aa1d03fd    	mov	x29, x29
101796984: 959241f1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796988: aa0003f6    	mov	x22, x0
10179698c: f81683a0    	stur	x0, [x29, #-0x98]
101796990: d00e6848    	adrp	x8, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
101796994: 912fa108    	add	x8, x8, #0xbe8
101796998: f9003fe8    	str	x8, [sp, #0x78]
10179699c: f9458b80    	ldr	x0, [x28, #0xb10]
1017969a0: aa1b03e1    	mov	x1, x27
1017969a4: 52800162    	mov	w2, #0xb                ; =11
1017969a8: 959241e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017969ac: aa1d03fd    	mov	x29, x29
1017969b0: 959241e6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017969b4: aa0003f8    	mov	x24, x0
1017969b8: f81703a0    	stur	x0, [x29, #-0x90]
1017969bc: b00e6fa8    	adrp	x8, 0x11e58b000 <dyld_stub_binder+0x11e58b000>
1017969c0: 9101a108    	add	x8, x8, #0x68
1017969c4: f90043e8    	str	x8, [sp, #0x80]
1017969c8: f9458b80    	ldr	x0, [x28, #0xb10]
1017969cc: d00f4b68    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1017969d0: f947a915    	ldr	x21, [x8, #0xf50] ; numberWithInteger:
1017969d4: aa1503e1    	mov	x1, x21
1017969d8: aa1903e2    	mov	x2, x25
1017969dc: 959241d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017969e0: aa1d03fd    	mov	x29, x29
1017969e4: 959241d9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017969e8: aa0003f7    	mov	x23, x0
1017969ec: f81783a0    	stur	x0, [x29, #-0x88]
1017969f0: d00e6848    	adrp	x8, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
1017969f4: 91302108    	add	x8, x8, #0xc08
1017969f8: f90047e8    	str	x8, [sp, #0x88]
1017969fc: f9458b80    	ldr	x0, [x28, #0xb10]
101796a00: aa1503e1    	mov	x1, x21
101796a04: aa1903e2    	mov	x2, x25
101796a08: 959241cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796a0c: aa1d03fd    	mov	x29, x29
101796a10: 959241ce    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796a14: aa0003f9    	mov	x25, x0
101796a18: f81803a0    	stur	x0, [x29, #-0x80]
101796a1c: d00e6848    	adrp	x8, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
101796a20: 9130a108    	add	x8, x8, #0xc28
101796a24: f9004be8    	str	x8, [sp, #0x90]
101796a28: f9458b80    	ldr	x0, [x28, #0xb10]
101796a2c: aa1b03e1    	mov	x1, x27
101796a30: 52800222    	mov	w2, #0x11               ; =17
101796a34: 959241c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796a38: aa1d03fd    	mov	x29, x29
101796a3c: 959241c3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796a40: aa0003f5    	mov	x21, x0
101796a44: f81883a0    	stur	x0, [x29, #-0x78]
101796a48: b00e6fa8    	adrp	x8, 0x11e58b000 <dyld_stub_binder+0x11e58b000>
101796a4c: 9108a108    	add	x8, x8, #0x228
101796a50: f9004fe8    	str	x8, [sp, #0x98]
101796a54: f9458b80    	ldr	x0, [x28, #0xb10]
101796a58: aa1b03e1    	mov	x1, x27
101796a5c: aa1a03e2    	mov	x2, x26
101796a60: 959241b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796a64: aa1d03fd    	mov	x29, x29
101796a68: 959241b8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796a6c: aa0003fb    	mov	x27, x0
101796a70: b00e6848    	adrp	x8, 0x11e49f000 <dyld_stub_binder+0x11e49f000>
101796a74: 91122108    	add	x8, x8, #0x488
101796a78: f90053e8    	str	x8, [sp, #0xa0]
101796a7c: b00e6828    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
101796a80: 91032108    	add	x8, x8, #0xc8
101796a84: f9402be9    	ldr	x9, [sp, #0x50]
101796a88: f100013f    	cmp	x9, #0x0
101796a8c: 9a890108    	csel	x8, x8, x9, eq
101796a90: a93923a0    	stp	x0, x8, [x29, #-0x70]
101796a94: b00f4ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101796a98: f9457500    	ldr	x0, [x8, #0xae8]
101796a9c: f00f4b48    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
101796aa0: f9402901    	ldr	x1, [x8, #0x50] ; dictionaryWithObjects:forKeys:count:
101796aa4: d10263a2    	sub	x2, x29, #0x98
101796aa8: 9101c3e3    	add	x3, sp, #0x70
101796aac: 528000e4    	mov	w4, #0x7                ; =7
101796ab0: 959241a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796ab4: aa1d03fd    	mov	x29, x29
101796ab8: 959241a4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796abc: aa0003fc    	mov	x28, x0
101796ac0: 900f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101796ac4: f9433d01    	ldr	x1, [x8, #0x678] ; addSubSearchFTSLog:
101796ac8: f94013fa    	ldr	x26, [sp, #0x20]
101796acc: aa1a03e0    	mov	x0, x26
101796ad0: aa1c03e2    	mov	x2, x28
101796ad4: 9592419a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796ad8: aa1c03e0    	mov	x0, x28
101796adc: 9592419e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796ae0: aa1b03e0    	mov	x0, x27
101796ae4: 9592419c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796ae8: aa1503e0    	mov	x0, x21
101796aec: 9592419a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796af0: aa1903e0    	mov	x0, x25
101796af4: 95924198    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796af8: aa1703e0    	mov	x0, x23
101796afc: f94023f7    	ldr	x23, [sp, #0x40]
101796b00: 95924195    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796b04: aa1803e0    	mov	x0, x24
101796b08: 95924193    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796b0c: aa1603e0    	mov	x0, x22
101796b10: 95924191    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796b14: aa1303e0    	mov	x0, x19
101796b18: 9592418f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796b1c: f94017e0    	ldr	x0, [sp, #0x28]
101796b20: 9592418d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796b24: aa1a03e0    	mov	x0, x26
101796b28: 9592418b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796b2c: f9401be0    	ldr	x0, [sp, #0x30]
101796b30: 95924189    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796b34: f9401fe0    	ldr	x0, [sp, #0x38]
101796b38: 95924187    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796b3c: d00f4b48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101796b40: f9435113    	ldr	x19, [x8, #0x6a0] ; count
101796b44: aa1703e0    	mov	x0, x23
101796b48: aa1303e1    	mov	x1, x19
101796b4c: 9592417c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796b50: f100041f    	cmp	x0, #0x1
101796b54: 54000381    	b.ne	0x101796bc4 <__text+0x178ebc4>
101796b58: f00f35c8    	adrp	x8, 0x11fe51000 <dyld_stub_binder+0x11fe51000>
101796b5c: f940d901    	ldr	x1, [x8, #0x1b0] ; router
101796b60: aa1403e0    	mov	x0, x20
101796b64: 95924176    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796b68: aa1d03fd    	mov	x29, x29
101796b6c: 95924177    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796b70: aa0003f3    	mov	x19, x0
101796b74: f00f4b48    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
101796b78: f9452101    	ldr	x1, [x8, #0xa40] ; firstObject
101796b7c: aa1703e0    	mov	x0, x23
101796b80: 9592416f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796b84: aa1d03fd    	mov	x29, x29
101796b88: 95924170    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796b8c: aa0003f5    	mov	x21, x0
101796b90: aa1403e0    	mov	x0, x20
101796b94: f94027e1    	ldr	x1, [sp, #0x48]
101796b98: 95924169    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796b9c: aa1d03fd    	mov	x29, x29
101796ba0: 9592416a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796ba4: aa0003f6    	mov	x22, x0
101796ba8: 900f38a8    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
101796bac: f9409d01    	ldr	x1, [x8, #0x138] ; selectMsgItem:searchTaskKey:
101796bb0: aa1303e0    	mov	x0, x19
101796bb4: aa1503e2    	mov	x2, x21
101796bb8: aa1603e3    	mov	x3, x22
101796bbc: 95924160    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796bc0: 14000023    	b	0x101796c4c <__text+0x178ec4c>
101796bc4: f94027f6    	ldr	x22, [sp, #0x48]
101796bc8: aa1703e0    	mov	x0, x23
101796bcc: aa1303e1    	mov	x1, x19
101796bd0: 9592415b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796bd4: f100081f    	cmp	x0, #0x2
101796bd8: 54000463    	b.lo	0x101796c64 <__text+0x178ec64>
101796bdc: 900f38a8    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
101796be0: f9408501    	ldr	x1, [x8, #0x108] ; sessionUsernameForDisplayedItemRow:
101796be4: aa1403e0    	mov	x0, x20
101796be8: f9400fe2    	ldr	x2, [sp, #0x18]
101796bec: 95924154    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796bf0: aa1d03fd    	mov	x29, x29
101796bf4: 95924155    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796bf8: aa0003f3    	mov	x19, x0
101796bfc: f00f35c8    	adrp	x8, 0x11fe51000 <dyld_stub_binder+0x11fe51000>
101796c00: f940d901    	ldr	x1, [x8, #0x1b0] ; router
101796c04: aa1403e0    	mov	x0, x20
101796c08: 9592414d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796c0c: aa1d03fd    	mov	x29, x29
101796c10: 9592414e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796c14: aa0003f5    	mov	x21, x0
101796c18: aa1403e0    	mov	x0, x20
101796c1c: aa1603e1    	mov	x1, x22
101796c20: 95924147    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796c24: aa1d03fd    	mov	x29, x29
101796c28: 95924148    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796c2c: aa0003f6    	mov	x22, x0
101796c30: 900f38a8    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
101796c34: f940a101    	ldr	x1, [x8, #0x140] ; selectMsgItems:withSessionUsername:searchTaskKey:
101796c38: aa1503e0    	mov	x0, x21
101796c3c: aa1703e2    	mov	x2, x23
101796c40: aa1303e3    	mov	x3, x19
101796c44: aa1603e4    	mov	x4, x22
101796c48: 9592413d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796c4c: aa1603e0    	mov	x0, x22
101796c50: 95924141    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796c54: aa1503e0    	mov	x0, x21
101796c58: 9592413f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796c5c: aa1303e0    	mov	x0, x19
101796c60: 9592413d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796c64: aa1703e0    	mov	x0, x23
101796c68: 9592413b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796c6c: f9402be0    	ldr	x0, [sp, #0x50]
101796c70: 95924139    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796c74: f9402ff6    	ldr	x22, [sp, #0x58]
101796c78: 900f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101796c7c: f942f901    	ldr	x1, [x8, #0x5f0] ; ftsPresenter
101796c80: aa1403e0    	mov	x0, x20
101796c84: 9592412e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796c88: aa1d03fd    	mov	x29, x29
101796c8c: 9592412f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796c90: aa0003f3    	mov	x19, x0
101796c94: 900f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101796c98: f9431901    	ldr	x1, [x8, #0x630] ; curSearchText
101796c9c: aa1403e0    	mov	x0, x20
101796ca0: 95924127    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796ca4: aa1d03fd    	mov	x29, x29
101796ca8: 95924128    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101796cac: aa0003f4    	mov	x20, x0
101796cb0: 900f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101796cb4: f9434501    	ldr	x1, [x8, #0x688] ; recordLocalSearchHistory:
101796cb8: aa1303e0    	mov	x0, x19
101796cbc: aa1403e2    	mov	x2, x20
101796cc0: 9592411f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101796cc4: aa1403e0    	mov	x0, x20
101796cc8: 95924123    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796ccc: aa1303e0    	mov	x0, x19
101796cd0: 95924121    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796cd4: aa1603e0    	mov	x0, x22
101796cd8: 9592411f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101796cdc: f85a03a8    	ldur	x8, [x29, #-0x60]
101796ce0: b00df2c9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
101796ce4: f9405929    	ldr	x9, [x9, #0xb0]
101796ce8: f9400129    	ldr	x9, [x9]
101796cec: eb08013f    	cmp	x9, x8
101796cf0: 54000121    	b.ne	0x101796d14 <__text+0x178ed14>
101796cf4: a9547bfd    	ldp	x29, x30, [sp, #0x140]
101796cf8: a9534ff4    	ldp	x20, x19, [sp, #0x130]
101796cfc: a95257f6    	ldp	x22, x21, [sp, #0x120]
101796d00: a9515ff8    	ldp	x24, x23, [sp, #0x110]
101796d04: a95067fa    	ldp	x26, x25, [sp, #0x100]
101796d08: a94f6ffc    	ldp	x28, x27, [sp, #0xf0]
101796d0c: 910543ff    	add	sp, sp, #0x150
101796d10: d65f03c0    	ret
101796d14: 95924118    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
