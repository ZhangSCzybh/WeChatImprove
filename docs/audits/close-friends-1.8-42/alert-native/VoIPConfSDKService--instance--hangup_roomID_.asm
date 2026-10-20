
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1060f6538: d102c3ff    	sub	sp, sp, #0xb0
1060f653c: a90667fa    	stp	x26, x25, [sp, #0x60]
1060f6540: a9075ff8    	stp	x24, x23, [sp, #0x70]
1060f6544: a90857f6    	stp	x22, x21, [sp, #0x80]
1060f6548: a9094ff4    	stp	x20, x19, [sp, #0x90]
1060f654c: a90a7bfd    	stp	x29, x30, [sp, #0xa0]
1060f6550: 910283fd    	add	x29, sp, #0xa0
1060f6554: aa0303f3    	mov	x19, x3
1060f6558: aa0203f4    	mov	x20, x2
1060f655c: aa0003f5    	mov	x21, x0
1060f6560: b00d5a68    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
1060f6564: 52800029    	mov	w9, #0x1                ; =1
1060f6568: 39152909    	strb	w9, [x8, #0x54a]
1060f656c: 52800040    	mov	w0, #0x2                ; =2
1060f6570: 946c5b34    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
1060f6574: 34000840    	cbz	w0, 0x1060f667c <_Flutter_MMFoundation_BindContext+0x25d2260>
1060f6578: 946cc30a    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
1060f657c: aa0003f6    	mov	x22, x0
1060f6580: b00d03f8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
1060f6584: f9454700    	ldr	x0, [x24, #0xa88]
1060f6588: 946cc2f6    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1060f658c: aa0003f7    	mov	x23, x0
1060f6590: f9454718    	ldr	x24, [x24, #0xa88]
1060f6594: b00d03fa    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
1060f6598: f9458b40    	ldr	x0, [x26, #0xb10]
1060f659c: d00d0068    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1060f65a0: f947bd01    	ldr	x1, [x8, #0xf78] ; selector=numberWithUnsignedInt:
1060f65a4: aa1403e2    	mov	x2, x20
1060f65a8: 946cc2e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f65ac: aa1d03fd    	mov	x29, x29
1060f65b0: 946cc2e6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f65b4: aa0003f9    	mov	x25, x0
1060f65b8: f9458b40    	ldr	x0, [x26, #0xb10]
1060f65bc: d00d0068    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1060f65c0: f947c901    	ldr	x1, [x8, #0xf90] ; selector=numberWithUnsignedLongLong:
1060f65c4: aa1303e2    	mov	x2, x19
1060f65c8: 946cc2dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f65cc: aa1d03fd    	mov	x29, x29
1060f65d0: 946cc2de    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f65d4: aa0003fa    	mov	x26, x0
1060f65d8: 900d00a8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1060f65dc: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
1060f65e0: a900ffe0    	stp	x0, xzr, [sp, #0x8]
1060f65e4: f90003f9    	str	x25, [sp]
1060f65e8: b00c2b82    	adrp	x2, 0x11e667000 <dyld_stub_binder+0x11e667000>
1060f65ec: 911a2042    	add	x2, x2, #0x688 ; cfstring='Prepare to hangup ... (%@, %@)'
1060f65f0: aa1803e0    	mov	x0, x24
1060f65f4: 946cc2d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f65f8: aa1d03fd    	mov	x29, x29
1060f65fc: 946cc2d3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f6600: aa0003f8    	mov	x24, x0
1060f6604: 900d0068    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1060f6608: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
1060f660c: b00c1d28    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1060f6610: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
1060f6614: a90003e8    	stp	x8, x0, [sp]
1060f6618: b00c1d22    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1060f661c: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
1060f6620: aa1703e0    	mov	x0, x23
1060f6624: 946cc2c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f6628: aa0003f7    	mov	x23, x0
1060f662c: aa1803e0    	mov	x0, x24
1060f6630: 946cc2c9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f6634: aa1a03e0    	mov	x0, x26
1060f6638: 946cc2c7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f663c: aa1903e0    	mov	x0, x25
1060f6640: 946cc2c5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f6644: f00aba01    	adrp	x1, 0x11b839000 <dyld_stub_binder+0x11b839000>
1060f6648: 9101bc21    	add	x1, x1, #0x6f ; cstring='VoIP|Ilink'
1060f664c: d00ac462    	adrp	x2, 0x11b984000 <dyld_stub_binder+0x11b984000>
1060f6650: 91283842    	add	x2, x2, #0xa0e ; cstring='VoIPConfSDKService.mm'
1060f6654: b00ac484    	adrp	x4, 0x11b987000 <dyld_stub_binder+0x11b987000>
1060f6658: 91042884    	add	x4, x4, #0x10a ; cstring='-[VoIPConfSDKService hangup:roomID:]'
1060f665c: 52800040    	mov	w0, #0x2                ; =2
1060f6660: 5281d763    	mov	w3, #0xebb              ; =3771
1060f6664: aa1703e5    	mov	x5, x23
1060f6668: 946c5af7    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
1060f666c: aa1703e0    	mov	x0, x23
1060f6670: 946cc2b9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f6674: aa1603e0    	mov	x0, x22
1060f6678: 946cc2cd    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
1060f667c: d10123a0    	sub	x0, x29, #0x48
1060f6680: aa1503e1    	mov	x1, x21
1060f6684: 946cc2ba    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
1060f6688: b00d0a08    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060f668c: b98a0908    	ldrsw	x8, [x8, #0xa08]
1060f6690: f8686ab5    	ldr	x21, [x21, x8]
1060f6694: 900ba7c8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1060f6698: f947e108    	ldr	x8, [x8, #0xfc0]
1060f669c: f90013e8    	str	x8, [sp, #0x20]
1060f66a0: f0096448    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1060f66a4: fd41c100    	ldr	d0, [x8, #0x380]
1060f66a8: 90000008    	adrp	x8, 0x1060f6000 <_Flutter_MMFoundation_BindContext+0x25d1be4>
1060f66ac: 911c4108    	add	x8, x8, #0x710
1060f66b0: fd0017e0    	str	d0, [sp, #0x28]
1060f66b4: 900ba989    	adrp	x9, 0x11d626000 <dyld_stub_binder+0x11d626000>
1060f66b8: 913f0129    	add	x9, x9, #0xfc0
1060f66bc: a90327e8    	stp	x8, x9, [sp, #0x30]
1060f66c0: 910083f6    	add	x22, sp, #0x20
1060f66c4: 910082c0    	add	x0, x22, #0x20
1060f66c8: d10123a1    	sub	x1, x29, #0x48
1060f66cc: 946cc2ab    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
1060f66d0: b90053f4    	str	w20, [sp, #0x50]
1060f66d4: f90027f3    	str	x19, [sp, #0x48]
1060f66d8: 910083e1    	add	x1, sp, #0x20
1060f66dc: aa1503e0    	mov	x0, x21
1060f66e0: 946c5ad0    	bl	0x107c0d220 <_Flutter_MMFoundation_BindContext+0x40e8e04>
1060f66e4: 910082c0    	add	x0, x22, #0x20
1060f66e8: 946cc2aa    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
1060f66ec: d10123a0    	sub	x0, x29, #0x48
1060f66f0: 946cc2a8    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
1060f66f4: a94a7bfd    	ldp	x29, x30, [sp, #0xa0]
1060f66f8: a9494ff4    	ldp	x20, x19, [sp, #0x90]
1060f66fc: a94857f6    	ldp	x22, x21, [sp, #0x80]
1060f6700: a9475ff8    	ldp	x24, x23, [sp, #0x70]
1060f6704: a94667fa    	ldp	x26, x25, [sp, #0x60]
1060f6708: 9102c3ff    	add	sp, sp, #0xb0
1060f670c: d65f03c0    	ret
