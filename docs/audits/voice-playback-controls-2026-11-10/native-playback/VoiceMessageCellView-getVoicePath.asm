
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
1065831c8: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
1065831cc: a90167fa    	stp	x26, x25, [sp, #0x10]
1065831d0: a9025ff8    	stp	x24, x23, [sp, #0x20]
1065831d4: a90357f6    	stp	x22, x21, [sp, #0x30]
1065831d8: a9044ff4    	stp	x20, x19, [sp, #0x40]
1065831dc: a9057bfd    	stp	x29, x30, [sp, #0x50]
1065831e0: 910143fd    	add	x29, sp, #0x50
1065831e4: aa0003f7    	mov	x23, x0
1065831e8: 900c8ea8    	adrp	x8, 0x11f757000 <dyld_stub_binder+0x11f757000>
1065831ec: 52800029    	mov	w9, #0x1                ; =1
1065831f0: 39085509    	strb	w9, [x8, #0x215]
1065831f4: f00c2248    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1065831f8: f941c118    	ldr	x24, [x8, #0x380]
1065831fc: aa1803e1    	mov	x1, x24
106583200: 945a9299    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106583204: aa1d03fd    	mov	x29, x29
106583208: 945a929e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658320c: aa0003f3    	mov	x19, x0
106583210: f00c2248    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
106583214: f941bd16    	ldr	x22, [x8, #0x378]
106583218: aa1603e1    	mov	x1, x22
10658321c: 945a9292    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106583220: aa1d03fd    	mov	x29, x29
106583224: 945a9297    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106583228: aa0003f4    	mov	x20, x0
10658322c: 900c2288    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
106583230: f9478101    	ldr	x1, [x8, #0xf00]
106583234: 945a928c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106583238: aa0003f5    	mov	x21, x0
10658323c: aa1403e0    	mov	x0, x20
106583240: 945a928c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106583244: aa1303e0    	mov	x0, x19
106583248: 945a928a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658324c: 36000a55    	tbz	w21, #0x0, 0x106583394 <_Flutter_MMFoundation_BindContext+0x280a060>
106583250: b00c3c99    	adrp	x25, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
106583254: f940b733    	ldr	x19, [x25, #0x168]
106583258: aa1703e0    	mov	x0, x23
10658325c: aa1803e1    	mov	x1, x24
106583260: 945a9281    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106583264: aa1d03fd    	mov	x29, x29
106583268: 945a9286    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658326c: aa0003f4    	mov	x20, x0
106583270: aa1603e1    	mov	x1, x22
106583274: 945a927c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106583278: aa1d03fd    	mov	x29, x29
10658327c: 945a9281    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106583280: aa0003f5    	mov	x21, x0
106583284: f00c25a8    	adrp	x8, 0x11ea3a000 <dyld_stub_binder+0x11ea3a000>
106583288: f9459d01    	ldr	x1, [x8, #0xb38]
10658328c: aa1303e0    	mov	x0, x19
106583290: aa1503e2    	mov	x2, x21
106583294: 945a9274    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106583298: aa1d03fd    	mov	x29, x29
10658329c: 945a9279    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065832a0: aa0003f3    	mov	x19, x0
1065832a4: aa1503e0    	mov	x0, x21
1065832a8: 945a9272    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065832ac: aa1403e0    	mov	x0, x20
1065832b0: 945a9270    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065832b4: b4000ff3    	cbz	x19, 0x1065834b0 <_Flutter_MMFoundation_BindContext+0x280a17c>
1065832b8: f940b73a    	ldr	x26, [x25, #0x168]
1065832bc: aa1703e0    	mov	x0, x23
1065832c0: aa1803e1    	mov	x1, x24
1065832c4: 945a9268    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065832c8: aa1d03fd    	mov	x29, x29
1065832cc: 945a926d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065832d0: aa0003f4    	mov	x20, x0
1065832d4: aa1603e1    	mov	x1, x22
1065832d8: 945a9263    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065832dc: aa1d03fd    	mov	x29, x29
1065832e0: 945a9268    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065832e4: aa0003f5    	mov	x21, x0
1065832e8: 900c2288    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
1065832ec: f947b501    	ldr	x1, [x8, #0xf68]
1065832f0: 945a925d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065832f4: aa1d03fd    	mov	x29, x29
1065832f8: 945a9262    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065832fc: aa0003f9    	mov	x25, x0
106583300: aa1703e0    	mov	x0, x23
106583304: aa1803e1    	mov	x1, x24
106583308: 945a9257    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658330c: aa1d03fd    	mov	x29, x29
106583310: 945a925c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106583314: aa0003f7    	mov	x23, x0
106583318: aa1603e1    	mov	x1, x22
10658331c: 945a9252    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106583320: aa1d03fd    	mov	x29, x29
106583324: 945a9257    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106583328: aa0003f6    	mov	x22, x0
10658332c: b00c2248    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
106583330: f947e501    	ldr	x1, [x8, #0xfc8]
106583334: 945a924c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106583338: aa0003f8    	mov	x24, x0
10658333c: f00c3c68    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106583340: f9445100    	ldr	x0, [x8, #0x8a0]
106583344: 900c2288    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
106583348: f9450101    	ldr	x1, [x8, #0xa00]
10658334c: 945a9246    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106583350: aa1d03fd    	mov	x29, x29
106583354: 945a924b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106583358: aa0003fb    	mov	x27, x0
10658335c: 900c2288    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
106583360: f947b901    	ldr	x1, [x8, #0xf70]
106583364: aa1a03e0    	mov	x0, x26
106583368: aa1903e2    	mov	x2, x25
10658336c: aa1803e3    	mov	x3, x24
106583370: aa1303e4    	mov	x4, x19
106583374: aa1b03e5    	mov	x5, x27
106583378: 945a923b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658337c: aa1d03fd    	mov	x29, x29
106583380: 945a9240    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106583384: aa0003f8    	mov	x24, x0
106583388: aa1b03e0    	mov	x0, x27
10658338c: 945a9239    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106583390: 14000034    	b	0x106583460 <_Flutter_MMFoundation_BindContext+0x280a12c>
106583394: f00c3c7b    	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106583398: f944537a    	ldr	x26, [x27, #0x8a0]
10658339c: aa1703e0    	mov	x0, x23
1065833a0: aa1803e1    	mov	x1, x24
1065833a4: 945a9230    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065833a8: aa1d03fd    	mov	x29, x29
1065833ac: 945a9235    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065833b0: aa0003f3    	mov	x19, x0
1065833b4: aa1603e1    	mov	x1, x22
1065833b8: 945a922b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065833bc: aa1d03fd    	mov	x29, x29
1065833c0: 945a9230    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065833c4: aa0003f4    	mov	x20, x0
1065833c8: f00c2248    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1065833cc: f9403901    	ldr	x1, [x8, #0x70]
1065833d0: 945a9225    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065833d4: aa1d03fd    	mov	x29, x29
1065833d8: 945a922a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065833dc: aa0003f5    	mov	x21, x0
1065833e0: aa1703e0    	mov	x0, x23
1065833e4: aa1803e1    	mov	x1, x24
1065833e8: 945a921f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065833ec: aa1d03fd    	mov	x29, x29
1065833f0: 945a9224    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065833f4: aa0003f9    	mov	x25, x0
1065833f8: aa1603e1    	mov	x1, x22
1065833fc: 945a921a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106583400: aa1d03fd    	mov	x29, x29
106583404: 945a921f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106583408: aa0003f7    	mov	x23, x0
10658340c: b00c2248    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
106583410: f947e501    	ldr	x1, [x8, #0xfc8]
106583414: 945a9214    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106583418: aa0003f8    	mov	x24, x0
10658341c: f9445360    	ldr	x0, [x27, #0x8a0]
106583420: 900c2288    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
106583424: f9450101    	ldr	x1, [x8, #0xa00]
106583428: 945a920f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658342c: aa1d03fd    	mov	x29, x29
106583430: 945a9214    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106583434: aa0003f6    	mov	x22, x0
106583438: 900c2288    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
10658343c: f9450501    	ldr	x1, [x8, #0xa08]
106583440: aa1a03e0    	mov	x0, x26
106583444: aa1503e2    	mov	x2, x21
106583448: aa1803e3    	mov	x3, x24
10658344c: aa1603e4    	mov	x4, x22
106583450: 945a9205    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106583454: aa1d03fd    	mov	x29, x29
106583458: 945a920a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658345c: aa0003f8    	mov	x24, x0
106583460: aa1603e0    	mov	x0, x22
106583464: 945a9203    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106583468: aa1703e0    	mov	x0, x23
10658346c: 945a9201    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106583470: aa1903e0    	mov	x0, x25
106583474: 945a91ff    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106583478: aa1503e0    	mov	x0, x21
10658347c: 945a91fd    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106583480: aa1403e0    	mov	x0, x20
106583484: 945a91fb    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106583488: aa1303e0    	mov	x0, x19
10658348c: 945a91f9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106583490: aa1803e0    	mov	x0, x24
106583494: a9457bfd    	ldp	x29, x30, [sp, #0x50]
106583498: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10658349c: a94357f6    	ldp	x22, x21, [sp, #0x30]
1065834a0: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1065834a4: a94167fa    	ldp	x26, x25, [sp, #0x10]
1065834a8: a8c66ffc    	ldp	x28, x27, [sp], #0x60
1065834ac: 145a91dd    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
1065834b0: d2800018    	mov	x24, #0x0               ; =0
1065834b4: 17fffff5    	b	0x106583488 <_Flutter_MMFoundation_BindContext+0x280a154>
