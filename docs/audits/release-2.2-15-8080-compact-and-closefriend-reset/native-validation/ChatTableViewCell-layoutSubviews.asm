
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100fd9670: d10583ff    	sub	sp, sp, #0x160
100fd9674: 6d0f23e9    	stp	d9, d8, [sp, #0xf0]
100fd9678: a9106ffc    	stp	x28, x27, [sp, #0x100]
100fd967c: a91167fa    	stp	x26, x25, [sp, #0x110]
100fd9680: a9125ff8    	stp	x24, x23, [sp, #0x120]
100fd9684: a91357f6    	stp	x22, x21, [sp, #0x130]
100fd9688: a9144ff4    	stp	x20, x19, [sp, #0x140]
100fd968c: a9157bfd    	stp	x29, x30, [sp, #0x150]
100fd9690: 910543fd    	add	x29, sp, #0x150
100fd9694: aa0003f3    	mov	x19, x0
100fd9698: f00e3b88    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
100fd969c: f9451908    	ldr	x8, [x8, #0xa30]
100fd96a0: f9400108    	ldr	x8, [x8]
100fd96a4: f81903a8    	stur	x8, [x29, #-0x70]
100fd96a8: d00f3b48    	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
100fd96ac: 52800029    	mov	w9, #0x1                ; =1
100fd96b0: 39226909    	strb	w9, [x8, #0x89a]
100fd96b4: 900eec08    	adrp	x8, 0x11ed59000 <dyld_stub_binder+0x11ed59000>
100fd96b8: f9475908    	ldr	x8, [x8, #0xeb0]
100fd96bc: a90523e0    	stp	x0, x8, [sp, #0x50]
100fd96c0: b00ecfa8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
100fd96c4: f9415901    	ldr	x1, [x8, #0x2b0]
100fd96c8: 910143e0    	add	x0, sp, #0x50
100fd96cc: 95b13967    	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
100fd96d0: b00ee668    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100fd96d4: f9409501    	ldr	x1, [x8, #0x128]
100fd96d8: aa1303e0    	mov	x0, x19
100fd96dc: f90007e1    	str	x1, [sp, #0x8]
100fd96e0: 95b13961    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd96e4: 900eed88    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
100fd96e8: b9840508    	ldrsw	x8, [x8, #0x404]
100fd96ec: f8686a60    	ldr	x0, [x19, x8]
100fd96f0: d00ee688    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
100fd96f4: f9453115    	ldr	x21, [x8, #0xa60]
100fd96f8: aa1503e1    	mov	x1, x21
100fd96fc: 95b1395a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd9700: 4f00e400    	movi.16b	v0, #0x0
100fd9704: ad0183e0    	stp	q0, q0, [sp, #0x30]
100fd9708: ad0083e0    	stp	q0, q0, [sp, #0x10]
100fd970c: 900ecf88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100fd9710: f9453916    	ldr	x22, [x8, #0xa70]
100fd9714: aa1303e0    	mov	x0, x19
100fd9718: aa1603e1    	mov	x1, x22
100fd971c: 95b13952    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd9720: aa1d03fd    	mov	x29, x29
100fd9724: 95b13957    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd9728: aa0003f8    	mov	x24, x0
100fd972c: b00ecfc8    	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
100fd9730: f9456d01    	ldr	x1, [x8, #0xad8]
100fd9734: 95b1394c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd9738: aa1d03fd    	mov	x29, x29
100fd973c: 95b13951    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd9740: aa0003f7    	mov	x23, x0
100fd9744: aa1803e0    	mov	x0, x24
100fd9748: 95b1394a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd974c: b00ee668    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100fd9750: f9442d18    	ldr	x24, [x8, #0x858]
100fd9754: 910043e2    	add	x2, sp, #0x10
100fd9758: 910183e3    	add	x3, sp, #0x60
100fd975c: aa1703e0    	mov	x0, x23
100fd9760: aa1803e1    	mov	x1, x24
100fd9764: 52800204    	mov	w4, #0x10               ; =16
100fd9768: 95b1393f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd976c: b40003a0    	cbz	x0, 0x100fd97e0 <__text+0xfd17e0>
100fd9770: aa0003f9    	mov	x25, x0
100fd9774: f94013e8    	ldr	x8, [sp, #0x20]
100fd9778: f940011b    	ldr	x27, [x8]
100fd977c: f00ed01c    	adrp	x28, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
100fd9780: d2800014    	mov	x20, #0x0               ; =0
100fd9784: f9476b9a    	ldr	x26, [x28, #0xed0]
100fd9788: f94013e8    	ldr	x8, [sp, #0x20]
100fd978c: f9400108    	ldr	x8, [x8]
100fd9790: eb1b011f    	cmp	x8, x27
100fd9794: 54000060    	b.eq	0x100fd97a0 <__text+0xfd17a0>
100fd9798: aa1703e0    	mov	x0, x23
100fd979c: 95b13928    	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
100fd97a0: f9400fe8    	ldr	x8, [sp, #0x18]
100fd97a4: f8747900    	ldr	x0, [x8, x20, lsl #3]
100fd97a8: aa1a03e1    	mov	x1, x26
100fd97ac: 52800002    	mov	w2, #0x0                ; =0
100fd97b0: 95b1392d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd97b4: 91000694    	add	x20, x20, #0x1
100fd97b8: eb14033f    	cmp	x25, x20
100fd97bc: 54fffe61    	b.ne	0x100fd9788 <__text+0xfd1788>
100fd97c0: 910043e2    	add	x2, sp, #0x10
100fd97c4: 910183e3    	add	x3, sp, #0x60
100fd97c8: aa1703e0    	mov	x0, x23
100fd97cc: aa1803e1    	mov	x1, x24
100fd97d0: 52800204    	mov	w4, #0x10               ; =16
100fd97d4: 95b13924    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd97d8: aa0003f9    	mov	x25, x0
100fd97dc: b5fffd20    	cbnz	x0, 0x100fd9780 <__text+0xfd1780>
100fd97e0: aa1703e0    	mov	x0, x23
100fd97e4: 95b13923    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd97e8: aa1303e0    	mov	x0, x19
100fd97ec: aa1603e1    	mov	x1, x22
100fd97f0: 95b1391d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd97f4: aa1d03fd    	mov	x29, x29
100fd97f8: 95b13922    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd97fc: aa0003f7    	mov	x23, x0
100fd9800: 900ee6a8    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
100fd9804: f9407501    	ldr	x1, [x8, #0xe8]
100fd9808: 95b13917    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd980c: 4ea01c09    	mov.16b	v9, v0
100fd9810: 4ea11c28    	mov.16b	v8, v1
100fd9814: aa1703e0    	mov	x0, x23
100fd9818: 95b13916    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd981c: 1e602128    	fcmp	d9, #0.0
100fd9820: 540005cd    	b.le	0x100fd98d8 <__text+0xfd18d8>
100fd9824: 1e602108    	fcmp	d8, #0.0
100fd9828: 5400058d    	b.le	0x100fd98d8 <__text+0xfd18d8>
100fd982c: aa1303e0    	mov	x0, x19
100fd9830: aa1603e1    	mov	x1, x22
100fd9834: 95b1390c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd9838: aa1d03fd    	mov	x29, x29
100fd983c: 95b13911    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd9840: aa0003f6    	mov	x22, x0
100fd9844: f94007e1    	ldr	x1, [sp, #0x8]
100fd9848: 95b13907    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd984c: 900eed88    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
100fd9850: b9840114    	ldrsw	x20, [x8, #0x400]
100fd9854: f8746a60    	ldr	x0, [x19, x20]
100fd9858: aa1503e1    	mov	x1, x21
100fd985c: 95b13902    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd9860: aa1603e0    	mov	x0, x22
100fd9864: 95b13903    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd9868: f8746a60    	ldr	x0, [x19, x20]
100fd986c: f00ee688    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
100fd9870: f9411101    	ldr	x1, [x8, #0x220]
100fd9874: 95b138fc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd9878: f8746a60    	ldr	x0, [x19, x20]
100fd987c: f00ee668    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
100fd9880: f9465d01    	ldr	x1, [x8, #0xcb8]
100fd9884: 95b138f8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd9888: 900eed88    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
100fd988c: b983f908    	ldrsw	x8, [x8, #0x3f8]
100fd9890: 38686a69    	ldrb	w9, [x19, x8]
100fd9894: 7100053f    	cmp	w9, #0x1
100fd9898: 540000c1    	b.ne	0x100fd98b0 <__text+0xfd18b0>
100fd989c: 38286a7f    	strb	wzr, [x19, x8]
100fd98a0: f8746a60    	ldr	x0, [x19, x20]
100fd98a4: b00ecfa8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
100fd98a8: f941ed01    	ldr	x1, [x8, #0x3d8]
100fd98ac: 95b138ee    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd98b0: 900eed88    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
100fd98b4: b983fd08    	ldrsw	x8, [x8, #0x3fc]
100fd98b8: 38686a69    	ldrb	w9, [x19, x8]
100fd98bc: 7100053f    	cmp	w9, #0x1
100fd98c0: 540000c1    	b.ne	0x100fd98d8 <__text+0xfd18d8>
100fd98c4: 38286a7f    	strb	wzr, [x19, x8]
100fd98c8: f8746a60    	ldr	x0, [x19, x20]
100fd98cc: b00ed008    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
100fd98d0: f9407501    	ldr	x1, [x8, #0xe8]
100fd98d4: 95b138e4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd98d8: f85903a8    	ldur	x8, [x29, #-0x70]
100fd98dc: f00e3b89    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
100fd98e0: f9451929    	ldr	x9, [x9, #0xa30]
100fd98e4: f9400129    	ldr	x9, [x9]
100fd98e8: eb08013f    	cmp	x9, x8
100fd98ec: 54000141    	b.ne	0x100fd9914 <__text+0xfd1914>
100fd98f0: a9557bfd    	ldp	x29, x30, [sp, #0x150]
100fd98f4: a9544ff4    	ldp	x20, x19, [sp, #0x140]
100fd98f8: a95357f6    	ldp	x22, x21, [sp, #0x130]
100fd98fc: a9525ff8    	ldp	x24, x23, [sp, #0x120]
100fd9900: a95167fa    	ldp	x26, x25, [sp, #0x110]
100fd9904: a9506ffc    	ldp	x28, x27, [sp, #0x100]
100fd9908: 6d4f23e9    	ldp	d9, d8, [sp, #0xf0]
100fd990c: 910583ff    	add	sp, sp, #0x160
100fd9910: d65f03c0    	ret
100fd9914: 95b13787    	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
