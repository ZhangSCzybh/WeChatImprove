
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100fbb230: d10603ff    	sub	sp, sp, #0x180
100fbb234: a9126ffc    	stp	x28, x27, [sp, #0x120]
100fbb238: a91367fa    	stp	x26, x25, [sp, #0x130]
100fbb23c: a9145ff8    	stp	x24, x23, [sp, #0x140]
100fbb240: a91557f6    	stp	x22, x21, [sp, #0x150]
100fbb244: a9164ff4    	stp	x20, x19, [sp, #0x160]
100fbb248: a9177bfd    	stp	x29, x30, [sp, #0x170]
100fbb24c: 9105c3fd    	add	x29, sp, #0x170
100fbb250: aa0303fb    	mov	x27, x3
100fbb254: aa0203f8    	mov	x24, x2
100fbb258: aa0003f7    	mov	x23, x0
100fbb25c: 900e31a8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
100fbb260: f9405908    	ldr	x8, [x8, #0xb0]
100fbb264: f9400108    	ldr	x8, [x8]
100fbb268: f81a03a8    	stur	x8, [x29, #-0x60]
100fbb26c: b00fe3a8    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100fbb270: 52800029    	mov	w9, #0x1                ; =1
100fbb274: 392e8d09    	strb	w9, [x8, #0xba3]
100fbb278: aa0203e0    	mov	x0, x2
100fbb27c: 95b1afaf    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100fbb280: aa1b03e0    	mov	x0, x27
100fbb284: 95b1afad    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100fbb288: 900f8dd3    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
100fbb28c: f9453660    	ldr	x0, [x19, #0xa68]
100fbb290: d00f73e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100fbb294: f942a914    	ldr	x20, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
100fbb298: b00eac48    	adrp	x8, 0x11e544000 <dyld_stub_binder+0x11e544000>
100fbb29c: 9114a108    	add	x8, x8, #0x528
100fbb2a0: f90003e8    	str	x8, [sp]
100fbb2a4: d00d1d55    	adrp	x21, 0x11b365000 <dyld_stub_binder+0x11b365000>
100fbb2a8: 91266ab5    	add	x21, x21, #0x99a
100fbb2ac: d00d1d56    	adrp	x22, 0x11b365000 <dyld_stub_binder+0x11b365000>
100fbb2b0: 912b46d6    	add	x22, x22, #0xad1
100fbb2b4: aa1403e1    	mov	x1, x20
100fbb2b8: 52800042    	mov	w2, #0x2                ; =2
100fbb2bc: d2800003    	mov	x3, #0x0                ; =0
100fbb2c0: 52800004    	mov	w4, #0x0                ; =0
100fbb2c4: aa1503e5    	mov	x5, x21
100fbb2c8: 52808326    	mov	w6, #0x419              ; =1049
100fbb2cc: aa1603e7    	mov	x7, x22
100fbb2d0: 95b1af9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb2d4: f9453660    	ldr	x0, [x19, #0xa68]
100fbb2d8: b00eac48    	adrp	x8, 0x11e544000 <dyld_stub_binder+0x11e544000>
100fbb2dc: 91152108    	add	x8, x8, #0x548
100fbb2e0: a90063e8    	stp	x8, x24, [sp]
100fbb2e4: aa1403e1    	mov	x1, x20
100fbb2e8: 52800022    	mov	w2, #0x1                ; =1
100fbb2ec: d2800003    	mov	x3, #0x0                ; =0
100fbb2f0: 52800004    	mov	w4, #0x0                ; =0
100fbb2f4: aa1503e5    	mov	x5, x21
100fbb2f8: aa1703f5    	mov	x21, x23
100fbb2fc: 52808346    	mov	w6, #0x41a              ; =1050
100fbb300: aa1603e7    	mov	x7, x22
100fbb304: 95b1af8e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb308: b00f8a48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100fbb30c: f945dd01    	ldr	x1, [x8, #0xbb8] ; navigationController
100fbb310: aa1703e0    	mov	x0, x23
100fbb314: f9001fe1    	str	x1, [sp, #0x38]
100fbb318: 95b1af89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb31c: aa1d03fd    	mov	x29, x29
100fbb320: 95b1af8a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb324: aa0003f6    	mov	x22, x0
100fbb328: 900f8a88    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
100fbb32c: f946e501    	ldr	x1, [x8, #0xdc8] ; viewControllers
100fbb330: f90023e1    	str	x1, [sp, #0x40]
100fbb334: 95b1af82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb338: aa1d03fd    	mov	x29, x29
100fbb33c: 95b1af83    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb340: aa0003fa    	mov	x26, x0
100fbb344: 4f00e400    	movi.16b	v0, #0x0
100fbb348: ad0283e0    	stp	q0, q0, [sp, #0x50]
100fbb34c: ad0383e0    	stp	q0, q0, [sp, #0x70]
100fbb350: 95b1af7a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100fbb354: b00f8a28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100fbb358: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
100fbb35c: 910143e2    	add	x2, sp, #0x50
100fbb360: 910243e3    	add	x3, sp, #0x90
100fbb364: f9001be1    	str	x1, [sp, #0x30]
100fbb368: 52800204    	mov	w4, #0x10               ; =16
100fbb36c: 95b1af74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb370: b40006a0    	cbz	x0, 0x100fbb444 <__text+0xfb3444>
100fbb374: aa0003fc    	mov	x28, x0
100fbb378: a901dbf5    	stp	x21, x22, [sp, #0x18]
100fbb37c: aa1a03f7    	mov	x23, x26
100fbb380: f90027fb    	str	x27, [sp, #0x48]
100fbb384: f90017f8    	str	x24, [sp, #0x28]
100fbb388: d280001b    	mov	x27, #0x0               ; =0
100fbb38c: f94033e8    	ldr	x8, [sp, #0x60]
100fbb390: f940011a    	ldr	x26, [x8]
100fbb394: 900f8a28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100fbb398: 900f8a49    	adrp	x9, 0x120103000 <dyld_stub_binder+0x120103000>
100fbb39c: b00f8dd8    	adrp	x24, 0x120174000 <dyld_stub_binder+0x120174000>
100fbb3a0: d2800016    	mov	x22, #0x0               ; =0
100fbb3a4: aa1b03f9    	mov	x25, x27
100fbb3a8: f947ad15    	ldr	x21, [x8, #0xf58] ; class
100fbb3ac: f9442d34    	ldr	x20, [x9, #0x858] ; isKindOfClass:
100fbb3b0: 8b1c037b    	add	x27, x27, x28
100fbb3b4: f94033e8    	ldr	x8, [sp, #0x60]
100fbb3b8: f9400108    	ldr	x8, [x8]
100fbb3bc: eb1a011f    	cmp	x8, x26
100fbb3c0: 54000060    	b.eq	0x100fbb3cc <__text+0xfb33cc>
100fbb3c4: aa1703e0    	mov	x0, x23
100fbb3c8: 95b1af62    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
100fbb3cc: f9402fe8    	ldr	x8, [sp, #0x58]
100fbb3d0: f8767913    	ldr	x19, [x8, x22, lsl #3]
100fbb3d4: f947e300    	ldr	x0, [x24, #0xfc0]
100fbb3d8: aa1503e1    	mov	x1, x21
100fbb3dc: 95b1af58    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb3e0: aa0003e2    	mov	x2, x0
100fbb3e4: aa1303e0    	mov	x0, x19
100fbb3e8: aa1403e1    	mov	x1, x20
100fbb3ec: 95b1af54    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb3f0: 37000200    	tbnz	w0, #0x0, 0x100fbb430 <__text+0xfb3430>
100fbb3f4: 91000739    	add	x25, x25, #0x1
100fbb3f8: 910006d6    	add	x22, x22, #0x1
100fbb3fc: eb16039f    	cmp	x28, x22
100fbb400: 54fffda1    	b.ne	0x100fbb3b4 <__text+0xfb33b4>
100fbb404: 910143e2    	add	x2, sp, #0x50
100fbb408: 910243e3    	add	x3, sp, #0x90
100fbb40c: aa1703e0    	mov	x0, x23
100fbb410: f9401be1    	ldr	x1, [sp, #0x30]
100fbb414: 52800204    	mov	w4, #0x10               ; =16
100fbb418: 95b1af49    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb41c: aa0003fc    	mov	x28, x0
100fbb420: 900f8a28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100fbb424: 900f8a49    	adrp	x9, 0x120103000 <dyld_stub_binder+0x120103000>
100fbb428: b5fffbc0    	cbnz	x0, 0x100fbb3a0 <__text+0xfb33a0>
100fbb42c: 92f00019    	mov	x25, #0x7fffffffffffffff ; =9223372036854775807
100fbb430: a94263f6    	ldp	x22, x24, [sp, #0x20]
100fbb434: f94027fb    	ldr	x27, [sp, #0x48]
100fbb438: aa1703fa    	mov	x26, x23
100fbb43c: f9400ff5    	ldr	x21, [sp, #0x18]
100fbb440: 14000002    	b	0x100fbb448 <__text+0xfb3448>
100fbb444: 92f00019    	mov	x25, #0x7fffffffffffffff ; =9223372036854775807
100fbb448: aa1a03e0    	mov	x0, x26
100fbb44c: 95b1af42    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb450: 900f8dc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100fbb454: f9454100    	ldr	x0, [x8, #0xa80]
100fbb458: 95b1af40    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
100fbb45c: aa0003f7    	mov	x23, x0
100fbb460: 900f8dd4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
100fbb464: f9458a80    	ldr	x0, [x20, #0xb10]
100fbb468: b00f8a48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100fbb46c: f947bd01    	ldr	x1, [x8, #0xf78] ; numberWithUnsignedInt:
100fbb470: 52800fc2    	mov	w2, #0x7e               ; =126
100fbb474: 95b1af32    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb478: aa1d03fd    	mov	x29, x29
100fbb47c: 95b1af33    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb480: aa0003f3    	mov	x19, x0
100fbb484: d00f73e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100fbb488: f942c91c    	ldr	x28, [x8, #0x590] ; safeSetObject:forKey:
100fbb48c: d00ea823    	adrp	x3, 0x11e4c1000 <dyld_stub_binder+0x11e4c1000>
100fbb490: 91012063    	add	x3, x3, #0x48
100fbb494: aa1703e0    	mov	x0, x23
100fbb498: aa1c03e1    	mov	x1, x28
100fbb49c: aa1303e2    	mov	x2, x19
100fbb4a0: 95b1af27    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb4a4: aa1303e0    	mov	x0, x19
100fbb4a8: 95b1af2b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb4ac: f9458a80    	ldr	x0, [x20, #0xb10]
100fbb4b0: b00f8a48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100fbb4b4: f947a901    	ldr	x1, [x8, #0xf50] ; numberWithInteger:
100fbb4b8: 528000a2    	mov	w2, #0x5                ; =5
100fbb4bc: 95b1af20    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb4c0: aa1d03fd    	mov	x29, x29
100fbb4c4: 95b1af21    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb4c8: aa0003f3    	mov	x19, x0
100fbb4cc: d00ea7a3    	adrp	x3, 0x11e4b1000 <dyld_stub_binder+0x11e4b1000>
100fbb4d0: 91262063    	add	x3, x3, #0x988
100fbb4d4: aa1703e0    	mov	x0, x23
100fbb4d8: aa1c03e1    	mov	x1, x28
100fbb4dc: aa1303e2    	mov	x2, x19
100fbb4e0: 95b1af17    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb4e4: aa1303e0    	mov	x0, x19
100fbb4e8: 95b1af1b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb4ec: f00f7468    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
100fbb4f0: f9411501    	ldr	x1, [x8, #0x228] ; getSearchClickId
100fbb4f4: aa1503e0    	mov	x0, x21
100fbb4f8: 95b1af11    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb4fc: aa1d03fd    	mov	x29, x29
100fbb500: 95b1af12    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb504: aa0003f3    	mov	x19, x0
100fbb508: 900ea8e3    	adrp	x3, 0x11e4d7000 <dyld_stub_binder+0x11e4d7000>
100fbb50c: 913a2063    	add	x3, x3, #0xe88
100fbb510: aa1703e0    	mov	x0, x23
100fbb514: aa1c03e1    	mov	x1, x28
100fbb518: aa1303e2    	mov	x2, x19
100fbb51c: 95b1af08    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb520: aa1303e0    	mov	x0, x19
100fbb524: 95b1af0c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb528: 92f00008    	mov	x8, #0x7fffffffffffffff ; =9223372036854775807
100fbb52c: eb08033f    	cmp	x25, x8
100fbb530: 540007e1    	b.ne	0x100fbb62c <__text+0xfb362c>
100fbb534: 900f7488    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
100fbb538: f9435901    	ldr	x1, [x8, #0x6b0] ; isEnterpriseBrand
100fbb53c: aa1803e0    	mov	x0, x24
100fbb540: 95b1aeff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb544: 37000160    	tbnz	w0, #0x0, 0x100fbb570 <__text+0xfb3570>
100fbb548: 900f7408    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100fbb54c: f947bd01    	ldr	x1, [x8, #0xf78] ; m_isPlugin
100fbb550: aa1803e0    	mov	x0, x24
100fbb554: 95b1aefa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb558: 370000c0    	tbnz	w0, #0x0, 0x100fbb570 <__text+0xfb3570>
100fbb55c: 900f7408    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100fbb560: f947c101    	ldr	x1, [x8, #0xf80] ; isHolderContact
100fbb564: aa1803e0    	mov	x0, x24
100fbb568: 95b1aef5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb56c: 36001f00    	tbz	w0, #0x0, 0x100fbb94c <__text+0xfb394c>
100fbb570: aa1503e0    	mov	x0, x21
100fbb574: f9401fe1    	ldr	x1, [sp, #0x38]
100fbb578: 95b1aef1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb57c: aa1d03fd    	mov	x29, x29
100fbb580: 95b1aef2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb584: aa0003f3    	mov	x19, x0
100fbb588: f94023e1    	ldr	x1, [sp, #0x40]
100fbb58c: 95b1aeec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb590: aa1d03fd    	mov	x29, x29
100fbb594: 95b1aeed    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb598: aa0003f4    	mov	x20, x0
100fbb59c: d00f8a28    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
100fbb5a0: f9452101    	ldr	x1, [x8, #0xa40] ; firstObject
100fbb5a4: 95b1aee6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb5a8: aa1d03fd    	mov	x29, x29
100fbb5ac: 95b1aee7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb5b0: aa1503e9    	mov	x9, x21
100fbb5b4: aa0003f5    	mov	x21, x0
100fbb5b8: f00f7648    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
100fbb5bc: f9457101    	ldr	x1, [x8, #0xae0] ; doReset:
100fbb5c0: aa0903e0    	mov	x0, x9
100fbb5c4: aa1503e2    	mov	x2, x21
100fbb5c8: 95b1aedd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb5cc: aa1503e0    	mov	x0, x21
100fbb5d0: 95b1aee1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb5d4: aa1403e0    	mov	x0, x20
100fbb5d8: 95b1aedf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb5dc: aa1303e0    	mov	x0, x19
100fbb5e0: 95b1aedd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb5e4: b00f8dc8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100fbb5e8: f9408d00    	ldr	x0, [x8, #0x118]
100fbb5ec: b00f7408    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100fbb5f0: f9423901    	ldr	x1, [x8, #0x470] ; getAppViewControllerManager
100fbb5f4: 95b1aed2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb5f8: aa1d03fd    	mov	x29, x29
100fbb5fc: 95b1aed3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb600: aa0003f9    	mov	x25, x0
100fbb604: f00f7648    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
100fbb608: f9456901    	ldr	x1, [x8, #0xad0] ; newMessageByContact:msgWrapToAdd:showMainView:animated:extraInfo:completion:
100fbb60c: aa1803e2    	mov	x2, x24
100fbb610: d2800003    	mov	x3, #0x0                ; =0
100fbb614: 52800024    	mov	w4, #0x1                ; =1
100fbb618: 52800025    	mov	w5, #0x1                ; =1
100fbb61c: aa1703e6    	mov	x6, x23
100fbb620: aa1b03e7    	mov	x7, x27
100fbb624: 95b1aec6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb628: 140000af    	b	0x100fbb8e4 <__text+0xfb38e4>
100fbb62c: aa1503fc    	mov	x28, x21
100fbb630: f00f73e8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
100fbb634: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
100fbb638: aa1a03e0    	mov	x0, x26
100fbb63c: aa1903e2    	mov	x2, x25
100fbb640: 95b1aebf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb644: aa1d03fd    	mov	x29, x29
100fbb648: 95b1aec0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb64c: aa0003f9    	mov	x25, x0
100fbb650: b00f7448    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
100fbb654: f944fd01    	ldr	x1, [x8, #0x9f8] ; GetContact
100fbb658: 95b1aeb9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb65c: aa1d03fd    	mov	x29, x29
100fbb660: 95b1aeba    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb664: 900f7408    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100fbb668: f9434d13    	ldr	x19, [x8, #0x698] ; m_nsUsrName
100fbb66c: f9001be0    	str	x0, [sp, #0x30]
100fbb670: aa1303e1    	mov	x1, x19
100fbb674: 95b1aeb2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb678: aa1d03fd    	mov	x29, x29
100fbb67c: 95b1aeb3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb680: aa0003f4    	mov	x20, x0
100fbb684: aa1803e0    	mov	x0, x24
100fbb688: aa1303e1    	mov	x1, x19
100fbb68c: 95b1aeac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb690: aa1d03fd    	mov	x29, x29
100fbb694: 95b1aead    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb698: aa0003f3    	mov	x19, x0
100fbb69c: 900f8a48    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100fbb6a0: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
100fbb6a4: aa1403e0    	mov	x0, x20
100fbb6a8: aa1303e2    	mov	x2, x19
100fbb6ac: 95b1aea4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb6b0: aa0003f5    	mov	x21, x0
100fbb6b4: aa1303e0    	mov	x0, x19
100fbb6b8: 95b1aea7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb6bc: aa1403e0    	mov	x0, x20
100fbb6c0: 95b1aea5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb6c4: 34000715    	cbz	w21, 0x100fbb7a4 <__text+0xfb37a4>
100fbb6c8: a9046ffa    	stp	x26, x27, [sp, #0x40]
100fbb6cc: aa1603fb    	mov	x27, x22
100fbb6d0: d00f9168    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100fbb6d4: b98c3916    	ldrsw	x22, [x8, #0xc38]
100fbb6d8: 8b160380    	add	x0, x28, x22
100fbb6dc: 95b1aeac    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
100fbb6e0: b4000320    	cbz	x0, 0x100fbb744 <__text+0xfb3744>
100fbb6e4: aa0003f5    	mov	x21, x0
100fbb6e8: 8b160380    	add	x0, x28, x22
100fbb6ec: 95b1aea8    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
100fbb6f0: aa0003f3    	mov	x19, x0
100fbb6f4: f00f7648    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
100fbb6f8: f9457514    	ldr	x20, [x8, #0xae8] ; newMessageFromContactInfo:
100fbb6fc: f00f8a48    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
100fbb700: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
100fbb704: aa1403e2    	mov	x2, x20
100fbb708: 95b1ae8d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb70c: aa0003fa    	mov	x26, x0
100fbb710: aa1303e0    	mov	x0, x19
100fbb714: 95b1ae90    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb718: aa1503e0    	mov	x0, x21
100fbb71c: 95b1ae8e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb720: 3400013a    	cbz	w26, 0x100fbb744 <__text+0xfb3744>
100fbb724: 8b160380    	add	x0, x28, x22
100fbb728: 95b1ae99    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
100fbb72c: aa0003f3    	mov	x19, x0
100fbb730: aa1403e1    	mov	x1, x20
100fbb734: aa1803e2    	mov	x2, x24
100fbb738: 95b1ae81    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb73c: aa1303e0    	mov	x0, x19
100fbb740: 95b1ae85    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb744: aa1b03f6    	mov	x22, x27
100fbb748: b40008db    	cbz	x27, 0x100fbb860 <__text+0xfb3860>
100fbb74c: 900f8a88    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
100fbb750: f9413501    	ldr	x1, [x8, #0x268] ; topViewController
100fbb754: aa1603e0    	mov	x0, x22
100fbb758: 95b1ae79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb75c: aa1d03fd    	mov	x29, x29
100fbb760: 95b1ae7a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb764: aa0003f3    	mov	x19, x0
100fbb768: 95b1ae7b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb76c: eb19027f    	cmp	x19, x25
100fbb770: 54000780    	b.eq	0x100fbb860 <__text+0xfb3860>
100fbb774: f00f7648    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
100fbb778: f9457901    	ldr	x1, [x8, #0xaf0] ; PopToViewController:animated:completion:
100fbb77c: aa1603e0    	mov	x0, x22
100fbb780: aa1903e2    	mov	x2, x25
100fbb784: 52800023    	mov	w3, #0x1                ; =1
100fbb788: f94027fb    	ldr	x27, [sp, #0x48]
100fbb78c: aa1b03e4    	mov	x4, x27
100fbb790: 95b1ae6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb794: aa1d03fd    	mov	x29, x29
100fbb798: 95b1ae73    	bl	0x107c27164 <_Flutter_MMFoundation_BindContext+0x4102d48>
100fbb79c: f94023fa    	ldr	x26, [sp, #0x40]
100fbb7a0: 1400004e    	b	0x100fbb8d8 <__text+0xfb38d8>
100fbb7a4: aa1c03e0    	mov	x0, x28
100fbb7a8: f9401fe1    	ldr	x1, [sp, #0x38]
100fbb7ac: 95b1ae64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb7b0: aa1d03fd    	mov	x29, x29
100fbb7b4: 95b1ae65    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb7b8: aa0003f3    	mov	x19, x0
100fbb7bc: f94023e1    	ldr	x1, [sp, #0x40]
100fbb7c0: 95b1ae5f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb7c4: aa1d03fd    	mov	x29, x29
100fbb7c8: 95b1ae60    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb7cc: aa0003f4    	mov	x20, x0
100fbb7d0: d00f8a28    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
100fbb7d4: f9452101    	ldr	x1, [x8, #0xa40] ; firstObject
100fbb7d8: 95b1ae59    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb7dc: aa1d03fd    	mov	x29, x29
100fbb7e0: 95b1ae5a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb7e4: aa0003f5    	mov	x21, x0
100fbb7e8: f00f7648    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
100fbb7ec: f9457101    	ldr	x1, [x8, #0xae0] ; doReset:
100fbb7f0: aa1c03e0    	mov	x0, x28
100fbb7f4: aa1503e2    	mov	x2, x21
100fbb7f8: 95b1ae51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb7fc: aa1503e0    	mov	x0, x21
100fbb800: 95b1ae55    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb804: aa1403e0    	mov	x0, x20
100fbb808: 95b1ae53    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb80c: aa1303e0    	mov	x0, x19
100fbb810: 95b1ae51    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb814: d00f9168    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100fbb818: b98bf508    	ldrsw	x8, [x8, #0xbf4]
100fbb81c: f8686b88    	ldr	x8, [x28, x8]
100fbb820: f100091f    	cmp	x8, #0x2
100fbb824: 540002c1    	b.ne	0x100fbb87c <__text+0xfb387c>
100fbb828: b00f8dc8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100fbb82c: f9408d00    	ldr	x0, [x8, #0x118]
100fbb830: b00f7408    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100fbb834: f9423901    	ldr	x1, [x8, #0x470] ; getAppViewControllerManager
100fbb838: 95b1ae41    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb83c: aa1d03fd    	mov	x29, x29
100fbb840: 95b1ae42    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb844: aa0003f3    	mov	x19, x0
100fbb848: f00f7648    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
100fbb84c: f9456901    	ldr	x1, [x8, #0xad0] ; newMessageByContact:msgWrapToAdd:showMainView:animated:extraInfo:completion:
100fbb850: aa1803e2    	mov	x2, x24
100fbb854: d2800003    	mov	x3, #0x0                ; =0
100fbb858: 52800024    	mov	w4, #0x1                ; =1
100fbb85c: 14000019    	b	0x100fbb8c0 <__text+0xfb38c0>
100fbb860: a9446ffa    	ldp	x26, x27, [sp, #0x40]
100fbb864: f9401bf3    	ldr	x19, [sp, #0x30]
100fbb868: b40003bb    	cbz	x27, 0x100fbb8dc <__text+0xfb38dc>
100fbb86c: f9400b68    	ldr	x8, [x27, #0x10]
100fbb870: aa1b03e0    	mov	x0, x27
100fbb874: d63f0100    	blr	x8
100fbb878: 14000019    	b	0x100fbb8dc <__text+0xfb38dc>
100fbb87c: b00f7408    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100fbb880: f9423101    	ldr	x1, [x8, #0x460] ; resetViewStatus
100fbb884: aa1903e0    	mov	x0, x25
100fbb888: 95b1ae2d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb88c: b00f8dc8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100fbb890: f9408d00    	ldr	x0, [x8, #0x118]
100fbb894: b00f7408    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100fbb898: f9423901    	ldr	x1, [x8, #0x470] ; getAppViewControllerManager
100fbb89c: 95b1ae28    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb8a0: aa1d03fd    	mov	x29, x29
100fbb8a4: 95b1ae29    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb8a8: aa0003f3    	mov	x19, x0
100fbb8ac: f00f7648    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
100fbb8b0: f9456901    	ldr	x1, [x8, #0xad0] ; newMessageByContact:msgWrapToAdd:showMainView:animated:extraInfo:completion:
100fbb8b4: aa1803e2    	mov	x2, x24
100fbb8b8: d2800003    	mov	x3, #0x0                ; =0
100fbb8bc: 52800004    	mov	w4, #0x0                ; =0
100fbb8c0: 52800025    	mov	w5, #0x1                ; =1
100fbb8c4: aa1703e6    	mov	x6, x23
100fbb8c8: aa1b03e7    	mov	x7, x27
100fbb8cc: 95b1ae1c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb8d0: aa1303e0    	mov	x0, x19
100fbb8d4: 95b1ae20    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb8d8: f9401bf3    	ldr	x19, [sp, #0x30]
100fbb8dc: aa1303e0    	mov	x0, x19
100fbb8e0: 95b1ae1d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb8e4: aa1903e0    	mov	x0, x25
100fbb8e8: 95b1ae1b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb8ec: aa1703e0    	mov	x0, x23
100fbb8f0: 95b1ae19    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb8f4: aa1a03e0    	mov	x0, x26
100fbb8f8: 95b1ae17    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb8fc: aa1603e0    	mov	x0, x22
100fbb900: 95b1ae15    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb904: aa1b03e0    	mov	x0, x27
100fbb908: 95b1ae13    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb90c: aa1803e0    	mov	x0, x24
100fbb910: 95b1ae11    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbb914: f85a03a8    	ldur	x8, [x29, #-0x60]
100fbb918: 900e31a9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
100fbb91c: f9405929    	ldr	x9, [x9, #0xb0]
100fbb920: f9400129    	ldr	x9, [x9]
100fbb924: eb08013f    	cmp	x9, x8
100fbb928: 540014e1    	b.ne	0x100fbbbc4 <__text+0xfb3bc4>
100fbb92c: a9577bfd    	ldp	x29, x30, [sp, #0x170]
100fbb930: a9564ff4    	ldp	x20, x19, [sp, #0x160]
100fbb934: a95557f6    	ldp	x22, x21, [sp, #0x150]
100fbb938: a9545ff8    	ldp	x24, x23, [sp, #0x140]
100fbb93c: a95367fa    	ldp	x26, x25, [sp, #0x130]
100fbb940: a9526ffc    	ldp	x28, x27, [sp, #0x120]
100fbb944: 910603ff    	add	sp, sp, #0x180
100fbb948: d65f03c0    	ret
100fbb94c: d00f9168    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100fbb950: b98bf108    	ldrsw	x8, [x8, #0xbf0]
100fbb954: b8686aa8    	ldr	w8, [x21, x8]
100fbb958: 7101851f    	cmp	w8, #0x61
100fbb95c: 540003a0    	b.eq	0x100fbb9d0 <__text+0xfb39d0>
100fbb960: 7100a11f    	cmp	w8, #0x28
100fbb964: 540001c0    	b.eq	0x100fbb99c <__text+0xfb399c>
100fbb968: 7100791f    	cmp	w8, #0x1e
100fbb96c: 54000541    	b.ne	0x100fbba14 <__text+0xfb3a14>
100fbb970: f9458a80    	ldr	x0, [x20, #0xb10]
100fbb974: b00f8a48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100fbb978: f9479501    	ldr	x1, [x8, #0xf28] ; numberWithBool:
100fbb97c: 52800022    	mov	w2, #0x1                ; =1
100fbb980: 95b1adef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb984: aa1d03fd    	mov	x29, x29
100fbb988: 95b1adf0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb98c: aa0003f4    	mov	x20, x0
100fbb990: f00ea803    	adrp	x3, 0x11e4be000 <dyld_stub_binder+0x11e4be000>
100fbb994: 91292063    	add	x3, x3, #0xa48
100fbb998: 1400000b    	b	0x100fbb9c4 <__text+0xfb39c4>
100fbb99c: f9458a80    	ldr	x0, [x20, #0xb10]
100fbb9a0: b00f8a48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100fbb9a4: f9479501    	ldr	x1, [x8, #0xf28] ; numberWithBool:
100fbb9a8: 52800022    	mov	w2, #0x1                ; =1
100fbb9ac: 95b1ade4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb9b0: aa1d03fd    	mov	x29, x29
100fbb9b4: 95b1ade5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb9b8: aa0003f4    	mov	x20, x0
100fbb9bc: f00ea803    	adrp	x3, 0x11e4be000 <dyld_stub_binder+0x11e4be000>
100fbb9c0: 912ba063    	add	x3, x3, #0xae8
100fbb9c4: aa1703e0    	mov	x0, x23
100fbb9c8: aa1c03e1    	mov	x1, x28
100fbb9cc: 1400000e    	b	0x100fbba04 <__text+0xfb3a04>
100fbb9d0: f9458a80    	ldr	x0, [x20, #0xb10]
100fbb9d4: b00f8a48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100fbb9d8: f9479501    	ldr	x1, [x8, #0xf28] ; numberWithBool:
100fbb9dc: 52800022    	mov	w2, #0x1                ; =1
100fbb9e0: 95b1add7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbb9e4: aa1d03fd    	mov	x29, x29
100fbb9e8: 95b1add8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbb9ec: aa0003f4    	mov	x20, x0
100fbb9f0: f00f73e8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
100fbb9f4: f943a501    	ldr	x1, [x8, #0x748] ; attachObject:forKey:
100fbb9f8: b00eac43    	adrp	x3, 0x11e544000 <dyld_stub_binder+0x11e544000>
100fbb9fc: 9115a063    	add	x3, x3, #0x568
100fbba00: aa1703e0    	mov	x0, x23
100fbba04: aa1403e2    	mov	x2, x20
100fbba08: 95b1adcd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbba0c: aa1403e0    	mov	x0, x20
100fbba10: 95b1add1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbba14: 900f8dc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100fbba18: f9468d00    	ldr	x0, [x8, #0xd18]
100fbba1c: b00f7408    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100fbba20: f9412501    	ldr	x1, [x8, #0x248] ; isVisionPro
100fbba24: 95b1adc6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbba28: 340006c0    	cbz	w0, 0x100fbbb00 <__text+0xfb3b00>
100fbba2c: 900f8dc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100fbba30: f945e900    	ldr	x0, [x8, #0xbd0]
100fbba34: b00f8a28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100fbba38: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100fbba3c: 95b1adc0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbba40: aa1d03fd    	mov	x29, x29
100fbba44: 95b1adc1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbba48: aa0003f3    	mov	x19, x0
100fbba4c: b00f8dc8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100fbba50: f9401d00    	ldr	x0, [x8, #0x38]
100fbba54: 900f8a28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100fbba58: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100fbba5c: 95b1adb8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbba60: aa0003e2    	mov	x2, x0
100fbba64: d00f73e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100fbba68: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100fbba6c: aa1303e0    	mov	x0, x19
100fbba70: 95b1adb3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbba74: aa1d03fd    	mov	x29, x29
100fbba78: 95b1adb4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbba7c: aa0003f4    	mov	x20, x0
100fbba80: 900f7408    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100fbba84: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
100fbba88: aa1803e0    	mov	x0, x24
100fbba8c: 95b1adac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbba90: aa1d03fd    	mov	x29, x29
100fbba94: 95b1adad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbba98: aa0003f5    	mov	x21, x0
100fbba9c: f00f7648    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
100fbbaa0: f9456501    	ldr	x1, [x8, #0xac8] ; updateTimeForSessionByUserName:
100fbbaa4: aa1403e0    	mov	x0, x20
100fbbaa8: aa1503e2    	mov	x2, x21
100fbbaac: 95b1ada4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbbab0: aa1503e0    	mov	x0, x21
100fbbab4: 95b1ada8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbbab8: aa1403e0    	mov	x0, x20
100fbbabc: 95b1ada6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbbac0: aa1303e0    	mov	x0, x19
100fbbac4: 95b1ada4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbbac8: b00f8dc8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100fbbacc: f9408d00    	ldr	x0, [x8, #0x118]
100fbbad0: b00f7408    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100fbbad4: f9423901    	ldr	x1, [x8, #0x470] ; getAppViewControllerManager
100fbbad8: 95b1ad99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbbadc: aa1d03fd    	mov	x29, x29
100fbbae0: 95b1ad9a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbbae4: aa0003f9    	mov	x25, x0
100fbbae8: f00f7648    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
100fbbaec: f9456901    	ldr	x1, [x8, #0xad0] ; newMessageByContact:msgWrapToAdd:showMainView:animated:extraInfo:completion:
100fbbaf0: aa1803e2    	mov	x2, x24
100fbbaf4: d2800003    	mov	x3, #0x0                ; =0
100fbbaf8: 52800004    	mov	w4, #0x0                ; =0
100fbbafc: 17fffec7    	b	0x100fbb618 <__text+0xfb3618>
100fbbb00: d00f7448    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
100fbbb04: f945b901    	ldr	x1, [x8, #0xb70] ; isWeixinCustomerHelperContact
100fbbb08: aa1803e0    	mov	x0, x24
100fbbb0c: 95b1ad8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbbb10: aa0003f3    	mov	x19, x0
100fbbb14: 900f8dc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100fbbb18: f945e900    	ldr	x0, [x8, #0xbd0]
100fbbb1c: b00f8a28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100fbbb20: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100fbbb24: 95b1ad86    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbbb28: aa1d03fd    	mov	x29, x29
100fbbb2c: 95b1ad87    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbbb30: aa0003f9    	mov	x25, x0
100fbbb34: b00f8dc8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100fbbb38: f940a100    	ldr	x0, [x8, #0x140]
100fbbb3c: 900f8a28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100fbbb40: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100fbbb44: 95b1ad7e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbbb48: aa0003e2    	mov	x2, x0
100fbbb4c: d00f73e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100fbbb50: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100fbbb54: aa1903e0    	mov	x0, x25
100fbbb58: 95b1ad79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbbb5c: aa1d03fd    	mov	x29, x29
100fbbb60: 95b1ad7a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbbb64: aa0003f4    	mov	x20, x0
100fbbb68: 34000173    	cbz	w19, 0x100fbbb94 <__text+0xfb3b94>
100fbbb6c: d00f7448    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
100fbbb70: f945bd01    	ldr	x1, [x8, #0xb78] ; PushOtherBaseMsgControllerByContact:navigationController:animated:extraInfo:customerHelperScene:
100fbbb74: aa1403e0    	mov	x0, x20
100fbbb78: aa1803e2    	mov	x2, x24
100fbbb7c: aa1603e3    	mov	x3, x22
100fbbb80: 52800024    	mov	w4, #0x1                ; =1
100fbbb84: aa1703e5    	mov	x5, x23
100fbbb88: 528000c6    	mov	w6, #0x6                ; =6
100fbbb8c: 95b1ad6c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbbb90: 1400000b    	b	0x100fbbbbc <__text+0xfb3bbc>
100fbbb94: f00f7648    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
100fbbb98: f9456d01    	ldr	x1, [x8, #0xad8] ; PushOtherBaseMsgControllerByContact:navigationController:animated:searchScene:extraInfo:completion:
100fbbb9c: aa1403e0    	mov	x0, x20
100fbbba0: aa1803e2    	mov	x2, x24
100fbbba4: aa1603e3    	mov	x3, x22
100fbbba8: 52800024    	mov	w4, #0x1                ; =1
100fbbbac: d2800005    	mov	x5, #0x0                ; =0
100fbbbb0: aa1703e6    	mov	x6, x23
100fbbbb4: aa1b03e7    	mov	x7, x27
100fbbbb8: 95b1ad61    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbbbbc: aa1403e0    	mov	x0, x20
100fbbbc0: 17ffff48    	b	0x100fbb8e0 <__text+0xfb38e0>
100fbbbc4: 95b1ad6c    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
