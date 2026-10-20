
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1060f62e4: d10283ff    	sub	sp, sp, #0xa0
1060f62e8: a90567fa    	stp	x26, x25, [sp, #0x50]
1060f62ec: a9065ff8    	stp	x24, x23, [sp, #0x60]
1060f62f0: a90757f6    	stp	x22, x21, [sp, #0x70]
1060f62f4: a9084ff4    	stp	x20, x19, [sp, #0x80]
1060f62f8: a9097bfd    	stp	x29, x30, [sp, #0x90]
1060f62fc: 910243fd    	add	x29, sp, #0x90
1060f6300: aa0303f3    	mov	x19, x3
1060f6304: aa0203f4    	mov	x20, x2
1060f6308: aa0003f5    	mov	x21, x0
1060f630c: b00d5a68    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
1060f6310: 52800029    	mov	w9, #0x1                ; =1
1060f6314: 39152509    	strb	w9, [x8, #0x549]
1060f6318: 52800040    	mov	w0, #0x2                ; =2
1060f631c: 946c5bc9    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
1060f6320: 34000840    	cbz	w0, 0x1060f6428 <_Flutter_MMFoundation_BindContext+0x25d200c>
1060f6324: 946cc39f    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
1060f6328: aa0003f6    	mov	x22, x0
1060f632c: b00d03f8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
1060f6330: f9454700    	ldr	x0, [x24, #0xa88]
1060f6334: 946cc38b    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1060f6338: aa0003f7    	mov	x23, x0
1060f633c: f9454718    	ldr	x24, [x24, #0xa88]
1060f6340: b00d03fa    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
1060f6344: f9458b40    	ldr	x0, [x26, #0xb10]
1060f6348: d00d0068    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1060f634c: f947bd01    	ldr	x1, [x8, #0xf78] ; selector=numberWithUnsignedInt:
1060f6350: aa1403e2    	mov	x2, x20
1060f6354: 946cc37a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f6358: aa1d03fd    	mov	x29, x29
1060f635c: 946cc37b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f6360: aa0003f9    	mov	x25, x0
1060f6364: f9458b40    	ldr	x0, [x26, #0xb10]
1060f6368: d00d0068    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1060f636c: f9479501    	ldr	x1, [x8, #0xf28] ; selector=numberWithBool:
1060f6370: aa1303e2    	mov	x2, x19
1060f6374: 946cc372    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f6378: aa1d03fd    	mov	x29, x29
1060f637c: 946cc373    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f6380: aa0003fa    	mov	x26, x0
1060f6384: 900d00a8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1060f6388: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
1060f638c: a900ffe0    	stp	x0, xzr, [sp, #0x8]
1060f6390: f90003f9    	str	x25, [sp]
1060f6394: b00c2b82    	adrp	x2, 0x11e667000 <dyld_stub_binder+0x11e667000>
1060f6398: 911a2042    	add	x2, x2, #0x688 ; cfstring='Prepare to hangup ... (%@, %@)'
1060f639c: aa1803e0    	mov	x0, x24
1060f63a0: 946cc367    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f63a4: aa1d03fd    	mov	x29, x29
1060f63a8: 946cc368    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060f63ac: aa0003f8    	mov	x24, x0
1060f63b0: 900d0068    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1060f63b4: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
1060f63b8: b00c1d28    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1060f63bc: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
1060f63c0: a90003e8    	stp	x8, x0, [sp]
1060f63c4: b00c1d22    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1060f63c8: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
1060f63cc: aa1703e0    	mov	x0, x23
1060f63d0: 946cc35b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060f63d4: aa0003f7    	mov	x23, x0
1060f63d8: aa1803e0    	mov	x0, x24
1060f63dc: 946cc35e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f63e0: aa1a03e0    	mov	x0, x26
1060f63e4: 946cc35c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f63e8: aa1903e0    	mov	x0, x25
1060f63ec: 946cc35a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f63f0: f00aba01    	adrp	x1, 0x11b839000 <dyld_stub_binder+0x11b839000>
1060f63f4: 9101bc21    	add	x1, x1, #0x6f ; cstring='VoIP|Ilink'
1060f63f8: d00ac462    	adrp	x2, 0x11b984000 <dyld_stub_binder+0x11b984000>
1060f63fc: 91283842    	add	x2, x2, #0xa0e ; cstring='VoIPConfSDKService.mm'
1060f6400: b00ac484    	adrp	x4, 0x11b987000 <dyld_stub_binder+0x11b987000>
1060f6404: 91038884    	add	x4, x4, #0xe2 ; cstring='-[VoIPConfSDKService hangup:isSubCall:]'
1060f6408: 52800040    	mov	w0, #0x2                ; =2
1060f640c: 5281d4c3    	mov	w3, #0xea6              ; =3750
1060f6410: aa1703e5    	mov	x5, x23
1060f6414: 946c5b8c    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
1060f6418: aa1703e0    	mov	x0, x23
1060f641c: 946cc34e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060f6420: aa1603e0    	mov	x0, x22
1060f6424: 946cc362    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
1060f6428: 910123e0    	add	x0, sp, #0x48
1060f642c: aa1503e1    	mov	x1, x21
1060f6430: 946cc34f    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
1060f6434: b00d0a08    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060f6438: b98a0908    	ldrsw	x8, [x8, #0xa08]
1060f643c: f8686ab5    	ldr	x21, [x21, x8]
1060f6440: 900ba7c8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1060f6444: f947e108    	ldr	x8, [x8, #0xfc0]
1060f6448: f9000fe8    	str	x8, [sp, #0x18]
1060f644c: f0096448    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1060f6450: fd41c100    	ldr	d0, [x8, #0x380]
1060f6454: 90000008    	adrp	x8, 0x1060f6000 <_Flutter_MMFoundation_BindContext+0x25d1be4>
1060f6458: 9112f108    	add	x8, x8, #0x4bc
1060f645c: fd0013e0    	str	d0, [sp, #0x20]
1060f6460: b00ba809    	adrp	x9, 0x11d5f7000 <dyld_stub_binder+0x11d5f7000>
1060f6464: 9118e129    	add	x9, x9, #0x638
1060f6468: a902a7e8    	stp	x8, x9, [sp, #0x28]
1060f646c: 910063f6    	add	x22, sp, #0x18
1060f6470: 910082c0    	add	x0, x22, #0x20
1060f6474: 910123e1    	add	x1, sp, #0x48
1060f6478: 946cc340    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
1060f647c: b90043f4    	str	w20, [sp, #0x40]
1060f6480: 390113f3    	strb	w19, [sp, #0x44]
1060f6484: 910063e1    	add	x1, sp, #0x18
1060f6488: aa1503e0    	mov	x0, x21
1060f648c: 946c5b65    	bl	0x107c0d220 <_Flutter_MMFoundation_BindContext+0x40e8e04>
1060f6490: 910082c0    	add	x0, x22, #0x20
1060f6494: 946cc33f    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
1060f6498: 910123e0    	add	x0, sp, #0x48
1060f649c: 946cc33d    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
1060f64a0: a9497bfd    	ldp	x29, x30, [sp, #0x90]
1060f64a4: a9484ff4    	ldp	x20, x19, [sp, #0x80]
1060f64a8: a94757f6    	ldp	x22, x21, [sp, #0x70]
1060f64ac: a9465ff8    	ldp	x24, x23, [sp, #0x60]
1060f64b0: a94567fa    	ldp	x26, x25, [sp, #0x50]
1060f64b4: 910283ff    	add	sp, sp, #0xa0
1060f64b8: d65f03c0    	ret
