
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100fd9228: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
100fd922c: a90167fa    	stp	x26, x25, [sp, #0x10]
100fd9230: a9025ff8    	stp	x24, x23, [sp, #0x20]
100fd9234: a90357f6    	stp	x22, x21, [sp, #0x30]
100fd9238: a9044ff4    	stp	x20, x19, [sp, #0x40]
100fd923c: a9057bfd    	stp	x29, x30, [sp, #0x50]
100fd9240: 910143fd    	add	x29, sp, #0x50
100fd9244: aa0203f3    	mov	x19, x2
100fd9248: aa0003f4    	mov	x20, x0
100fd924c: d00f3b48    	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
100fd9250: 52800029    	mov	w9, #0x1                ; =1
100fd9254: 39226509    	strb	w9, [x8, #0x899]
100fd9258: aa0203e0    	mov	x0, x2
100fd925c: 95b13a86    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100fd9260: 900eed88    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
100fd9264: b983f908    	ldrsw	x8, [x8, #0x3f8]
100fd9268: 38286a9f    	strb	wzr, [x20, x8]
100fd926c: 900eed88    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
100fd9270: b983fd08    	ldrsw	x8, [x8, #0x3fc]
100fd9274: 38286a9f    	strb	wzr, [x20, x8]
100fd9278: 900eed88    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
100fd927c: b9840118    	ldrsw	x24, [x8, #0x400]
100fd9280: f8786a80    	ldr	x0, [x20, x24]
100fd9284: d00ecfbb    	adrp	x27, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
100fd9288: b00ecfba    	adrp	x26, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
100fd928c: d00ecff9    	adrp	x25, 0x11e9d7000 <dyld_stub_binder+0x11e9d7000>
100fd9290: b4000740    	cbz	x0, 0x100fd9378 <__text+0xfd1378>
100fd9294: f941c355    	ldr	x21, [x26, #0x380]
100fd9298: aa1503e1    	mov	x1, x21
100fd929c: 95b13a72    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd92a0: aa1d03fd    	mov	x29, x29
100fd92a4: 95b13a77    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd92a8: aa0003f6    	mov	x22, x0
100fd92ac: 95b13a71    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd92b0: f8786a80    	ldr	x0, [x20, x24]
100fd92b4: eb1302df    	cmp	x22, x19
100fd92b8: 54000560    	b.eq	0x100fd9364 <__text+0xfd1364>
100fd92bc: b40005e0    	cbz	x0, 0x100fd9378 <__text+0xfd1378>
100fd92c0: f00ed1e8    	adrp	x8, 0x11ea18000 <dyld_stub_binder+0x11ea18000>
100fd92c4: f9429101    	ldr	x1, [x8, #0x520]
100fd92c8: 95b13a67    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd92cc: 36000540    	tbz	w0, #0x0, 0x100fd9374 <__text+0xfd1374>
100fd92d0: 95b13685    	bl	0x107c26ce4 <_Flutter_MMFoundation_BindContext+0x3ead9b0>
100fd92d4: aa0003e8    	mov	x8, x0
100fd92d8: f8786a80    	ldr	x0, [x20, x24]
100fd92dc: 350004e8    	cbnz	w8, 0x100fd9378 <__text+0xfd1378>
100fd92e0: aa1503e1    	mov	x1, x21
100fd92e4: 95b13a60    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd92e8: aa1d03fd    	mov	x29, x29
100fd92ec: 95b13a65    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd92f0: aa0003f6    	mov	x22, x0
100fd92f4: f9410361    	ldr	x1, [x27, #0x200]
100fd92f8: 95b13a5b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd92fc: aa1d03fd    	mov	x29, x29
100fd9300: 95b13a60    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd9304: aa0003f7    	mov	x23, x0
100fd9308: f8786a9c    	ldr	x28, [x20, x24]
100fd930c: 95b13a59    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd9310: aa1603e0    	mov	x0, x22
100fd9314: 95b13a57    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd9318: eb1c02ff    	cmp	x23, x28
100fd931c: 54000181    	b.ne	0x100fd934c <__text+0xfd134c>
100fd9320: f8786a80    	ldr	x0, [x20, x24]
100fd9324: aa1503e1    	mov	x1, x21
100fd9328: 95b13a4f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd932c: aa1d03fd    	mov	x29, x29
100fd9330: 95b13a54    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd9334: aa0003f5    	mov	x21, x0
100fd9338: f9451b21    	ldr	x1, [x25, #0xa30]
100fd933c: d2800002    	mov	x2, #0x0                ; =0
100fd9340: 95b13a49    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd9344: aa1503e0    	mov	x0, x21
100fd9348: 95b13a4a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd934c: f8786a80    	ldr	x0, [x20, x24]
100fd9350: f00ecfa8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
100fd9354: f9407d01    	ldr	x1, [x8, #0xf8]
100fd9358: aa1303e2    	mov	x2, x19
100fd935c: 95b13a42    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd9360: 14000029    	b	0x100fd9404 <__text+0xfd1404>
100fd9364: f00ee688    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
100fd9368: f9411101    	ldr	x1, [x8, #0x220]
100fd936c: 95b13a3e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd9370: 14000018    	b	0x100fd93d0 <__text+0xfd13d0>
100fd9374: f8786a80    	ldr	x0, [x20, x24]
100fd9378: b00ee688    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
100fd937c: f9424901    	ldr	x1, [x8, #0x490]
100fd9380: 95b13a39    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd9384: b00ed008    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
100fd9388: f945a901    	ldr	x1, [x8, #0xb50]
100fd938c: aa1303e0    	mov	x0, x19
100fd9390: 95b13a35    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd9394: aa1d03fd    	mov	x29, x29
100fd9398: 95b13a3a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd939c: aa0003f5    	mov	x21, x0
100fd93a0: 95b135fe    	bl	0x107c26b98 <_Flutter_MMFoundation_BindContext+0x3ead864>
100fd93a4: 95b13a19    	bl	0x107c27c08 <_Flutter_MMFoundation_BindContext+0x3eae8d4>
100fd93a8: d00ecfa8    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
100fd93ac: f9410d01    	ldr	x1, [x8, #0x218]
100fd93b0: aa1303e2    	mov	x2, x19
100fd93b4: 95b13a2c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd93b8: f8786a88    	ldr	x8, [x20, x24]
100fd93bc: f8386a80    	str	x0, [x20, x24]
100fd93c0: aa0803e0    	mov	x0, x8
100fd93c4: 95b13a2b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd93c8: aa1503e0    	mov	x0, x21
100fd93cc: 95b13a29    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd93d0: 900ecf88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100fd93d4: f9453901    	ldr	x1, [x8, #0xa70]
100fd93d8: aa1403e0    	mov	x0, x20
100fd93dc: 95b13a22    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd93e0: aa1d03fd    	mov	x29, x29
100fd93e4: 95b13a27    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd93e8: aa0003f5    	mov	x21, x0
100fd93ec: f8786a82    	ldr	x2, [x20, x24]
100fd93f0: 900ee668    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
100fd93f4: f9456501    	ldr	x1, [x8, #0xac8]
100fd93f8: 95b13a1b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd93fc: aa1503e0    	mov	x0, x21
100fd9400: 95b13a1c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd9404: f9410361    	ldr	x1, [x27, #0x200]
100fd9408: aa1303e0    	mov	x0, x19
100fd940c: 95b13a16    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd9410: aa1d03fd    	mov	x29, x29
100fd9414: 95b13a1b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd9418: aa0003f5    	mov	x21, x0
100fd941c: f8786a88    	ldr	x8, [x20, x24]
100fd9420: eb08001f    	cmp	x0, x8
100fd9424: 540001e0    	b.eq	0x100fd9460 <__text+0xfd1460>
100fd9428: f941c341    	ldr	x1, [x26, #0x380]
100fd942c: aa1503e0    	mov	x0, x21
100fd9430: 95b13a0d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd9434: aa1d03fd    	mov	x29, x29
100fd9438: 95b13a12    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd943c: aa0003f6    	mov	x22, x0
100fd9440: 95b13a0c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd9444: eb1302df    	cmp	x22, x19
100fd9448: 540000c1    	b.ne	0x100fd9460 <__text+0xfd1460>
100fd944c: f00ecfa8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
100fd9450: f9407d01    	ldr	x1, [x8, #0xf8]
100fd9454: aa1503e0    	mov	x0, x21
100fd9458: d2800002    	mov	x2, #0x0                ; =0
100fd945c: 95b13a02    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd9460: f8786a82    	ldr	x2, [x20, x24]
100fd9464: f9451b21    	ldr	x1, [x25, #0xa30]
100fd9468: aa1303e0    	mov	x0, x19
100fd946c: 95b139fe    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd9470: aa1503e0    	mov	x0, x21
100fd9474: 95b139ff    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd9478: aa1303e0    	mov	x0, x19
100fd947c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
100fd9480: a9444ff4    	ldp	x20, x19, [sp, #0x40]
100fd9484: a94357f6    	ldp	x22, x21, [sp, #0x30]
100fd9488: a9425ff8    	ldp	x24, x23, [sp, #0x20]
100fd948c: a94167fa    	ldp	x26, x25, [sp, #0x10]
100fd9490: a8c66ffc    	ldp	x28, x27, [sp], #0x60
100fd9494: 15b139f7    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
