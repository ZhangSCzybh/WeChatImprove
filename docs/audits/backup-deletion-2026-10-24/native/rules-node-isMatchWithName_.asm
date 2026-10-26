
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
10299d5f0: d10503ff    	sub	sp, sp, #0x140
10299d5f4: a90e6ffc    	stp	x28, x27, [sp, #0xe0]
10299d5f8: a90f67fa    	stp	x26, x25, [sp, #0xf0]
10299d5fc: a9105ff8    	stp	x24, x23, [sp, #0x100]
10299d600: a91157f6    	stp	x22, x21, [sp, #0x110]
10299d604: a9124ff4    	stp	x20, x19, [sp, #0x120]
10299d608: a9137bfd    	stp	x29, x30, [sp, #0x130]
10299d60c: 9104c3fd    	add	x29, sp, #0x130
10299d610: aa0203f3    	mov	x19, x2
10299d614: aa0003f5    	mov	x21, x0
10299d618: d00d6288    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10299d61c: f9405908    	ldr	x8, [x8, #0xb0]
10299d620: f9400108    	ldr	x8, [x8]
10299d624: f81a83a8    	stur	x8, [x29, #-0x58]
10299d628: b00f14c8    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
10299d62c: 52800029    	mov	w9, #0x1                ; =1
10299d630: 3933a109    	strb	w9, [x8, #0xce8]
10299d634: aa0203e0    	mov	x0, x2
10299d638: 954a26c0    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10299d63c: d00ebb28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10299d640: f946e914    	ldr	x20, [x8, #0xdd0] ; length
10299d644: aa1303e0    	mov	x0, x19
10299d648: aa1403e1    	mov	x1, x20
10299d64c: 954a26bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d650: b4000240    	cbz	x0, 0x10299d698 <_Flutter_Image_provideRelativePathByUrl+0xdaa548>
10299d654: f9400ea0    	ldr	x0, [x21, #0x18]
10299d658: aa1403e1    	mov	x1, x20
10299d65c: 954a26b8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d660: b40001c0    	cbz	x0, 0x10299d698 <_Flutter_Image_provideRelativePathByUrl+0xdaa548>
10299d664: f9400aa8    	ldr	x8, [x21, #0x10]
10299d668: f100091f    	cmp	x8, #0x2
10299d66c: 540005e0    	b.eq	0x10299d728 <_Flutter_Image_provideRelativePathByUrl+0xdaa5d8>
10299d670: f100051f    	cmp	x8, #0x1
10299d674: 54000360    	b.eq	0x10299d6e0 <_Flutter_Image_provideRelativePathByUrl+0xdaa590>
10299d678: b5000108    	cbnz	x8, 0x10299d698 <_Flutter_Image_provideRelativePathByUrl+0xdaa548>
10299d67c: f9400ea2    	ldr	x2, [x21, #0x18]
10299d680: d00ebb28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10299d684: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
10299d688: aa1303e0    	mov	x0, x19
10299d68c: 954a26ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d690: aa0003f5    	mov	x21, x0
10299d694: 14000002    	b	0x10299d69c <_Flutter_Image_provideRelativePathByUrl+0xdaa54c>
10299d698: 52800015    	mov	w21, #0x0               ; =0
10299d69c: aa1303e0    	mov	x0, x19
10299d6a0: 954a26ad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10299d6a4: f85a83a8    	ldur	x8, [x29, #-0x58]
10299d6a8: d00d6289    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10299d6ac: f9405929    	ldr	x9, [x9, #0xb0]
10299d6b0: f9400129    	ldr	x9, [x9]
10299d6b4: eb08013f    	cmp	x9, x8
10299d6b8: 54001b61    	b.ne	0x10299da24 <_Flutter_Image_provideRelativePathByUrl+0xdaa8d4>
10299d6bc: aa1503e0    	mov	x0, x21
10299d6c0: a9537bfd    	ldp	x29, x30, [sp, #0x130]
10299d6c4: a9524ff4    	ldp	x20, x19, [sp, #0x120]
10299d6c8: a95157f6    	ldp	x22, x21, [sp, #0x110]
10299d6cc: a9505ff8    	ldp	x24, x23, [sp, #0x100]
10299d6d0: a94f67fa    	ldp	x26, x25, [sp, #0xf0]
10299d6d4: a94e6ffc    	ldp	x28, x27, [sp, #0xe0]
10299d6d8: 910503ff    	add	sp, sp, #0x140
10299d6dc: d65f03c0    	ret
10299d6e0: aa1303e0    	mov	x0, x19
10299d6e4: aa1403e1    	mov	x1, x20
10299d6e8: 954a2695    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d6ec: aa0003f4    	mov	x20, x0
10299d6f0: f9400ea2    	ldr	x2, [x21, #0x18]
10299d6f4: d00ea6a8    	adrp	x8, 0x11fe73000 <dyld_stub_binder+0x11fe73000>
10299d6f8: f943f901    	ldr	x1, [x8, #0x7f0] ; rangeOfRegex:options:inRange:capture:error:
10299d6fc: aa1303e0    	mov	x0, x19
10299d700: 52800043    	mov	w3, #0x2                ; =2
10299d704: d2800004    	mov	x4, #0x0                ; =0
10299d708: aa1403e5    	mov	x5, x20
10299d70c: d2800006    	mov	x6, #0x0                ; =0
10299d710: d2800007    	mov	x7, #0x0                ; =0
10299d714: 954a268a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d718: f100001f    	cmp	x0, #0x0
10299d71c: fa410280    	ccmp	x20, x1, #0x0, eq
10299d720: 1a9f17f5    	cset	w21, eq
10299d724: 17ffffde    	b	0x10299d69c <_Flutter_Image_provideRelativePathByUrl+0xdaa54c>
10299d728: d00ebea8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10299d72c: f9455500    	ldr	x0, [x8, #0xaa8]
10299d730: 954a268c    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10299d734: b00ebb28    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10299d738: f9473501    	ldr	x1, [x8, #0xe68] ; initWithCapacity:
10299d73c: 528000e2    	mov	w2, #0x7                ; =7
10299d740: 954a267f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d744: aa0003f4    	mov	x20, x0
10299d748: d00ebeb9    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
10299d74c: f9454720    	ldr	x0, [x25, #0xa88]
10299d750: f9400ea8    	ldr	x8, [x21, #0x18]
10299d754: b00ebb69    	adrp	x9, 0x12010a000 <dyld_stub_binder+0x12010a000>
10299d758: f946a536    	ldr	x22, [x9, #0xd48] ; stringWithFormat:
10299d75c: f90003e8    	str	x8, [sp]
10299d760: f00dd7e2    	adrp	x2, 0x11e49c000 <dyld_stub_binder+0x11e49c000>
10299d764: 9122a042    	add	x2, x2, #0x8a8
10299d768: aa1603e1    	mov	x1, x22
10299d76c: 954a2674    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d770: aa1d03fd    	mov	x29, x29
10299d774: 954a2675    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10299d778: aa0003f8    	mov	x24, x0
10299d77c: b00ea4e8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10299d780: f943c517    	ldr	x23, [x8, #0x788] ; safeAddObject:
10299d784: aa1403e0    	mov	x0, x20
10299d788: aa1703e1    	mov	x1, x23
10299d78c: aa1803e2    	mov	x2, x24
10299d790: 954a266b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d794: aa1803e0    	mov	x0, x24
10299d798: 954a266f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10299d79c: f9454720    	ldr	x0, [x25, #0xa88]
10299d7a0: f9400ea8    	ldr	x8, [x21, #0x18]
10299d7a4: f90003e8    	str	x8, [sp]
10299d7a8: 900de682    	adrp	x2, 0x11e66d000 <dyld_stub_binder+0x11e66d000>
10299d7ac: 91242042    	add	x2, x2, #0x908
10299d7b0: aa1603e1    	mov	x1, x22
10299d7b4: 954a2662    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d7b8: aa1d03fd    	mov	x29, x29
10299d7bc: 954a2663    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10299d7c0: aa0003f8    	mov	x24, x0
10299d7c4: aa1403e0    	mov	x0, x20
10299d7c8: aa1703e1    	mov	x1, x23
10299d7cc: aa1803e2    	mov	x2, x24
10299d7d0: 954a265b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d7d4: aa1803e0    	mov	x0, x24
10299d7d8: 954a265f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10299d7dc: f9454720    	ldr	x0, [x25, #0xa88]
10299d7e0: f9400ea8    	ldr	x8, [x21, #0x18]
10299d7e4: f90003e8    	str	x8, [sp]
10299d7e8: 900de682    	adrp	x2, 0x11e66d000 <dyld_stub_binder+0x11e66d000>
10299d7ec: 9124a042    	add	x2, x2, #0x928
10299d7f0: aa1603e1    	mov	x1, x22
10299d7f4: 954a2652    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d7f8: aa1d03fd    	mov	x29, x29
10299d7fc: 954a2653    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10299d800: aa0003f8    	mov	x24, x0
10299d804: aa1403e0    	mov	x0, x20
10299d808: aa1703e1    	mov	x1, x23
10299d80c: aa1803e2    	mov	x2, x24
10299d810: 954a264b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d814: aa1803e0    	mov	x0, x24
10299d818: 954a264f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10299d81c: f9454720    	ldr	x0, [x25, #0xa88]
10299d820: f9400ea8    	ldr	x8, [x21, #0x18]
10299d824: f90003e8    	str	x8, [sp]
10299d828: 900de682    	adrp	x2, 0x11e66d000 <dyld_stub_binder+0x11e66d000>
10299d82c: 91252042    	add	x2, x2, #0x948
10299d830: aa1603e1    	mov	x1, x22
10299d834: 954a2642    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d838: aa1d03fd    	mov	x29, x29
10299d83c: 954a2643    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10299d840: aa0003f8    	mov	x24, x0
10299d844: aa1403e0    	mov	x0, x20
10299d848: aa1703e1    	mov	x1, x23
10299d84c: aa1803e2    	mov	x2, x24
10299d850: 954a263b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d854: aa1803e0    	mov	x0, x24
10299d858: 954a263f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10299d85c: f9454720    	ldr	x0, [x25, #0xa88]
10299d860: f9400ea8    	ldr	x8, [x21, #0x18]
10299d864: f90003e8    	str	x8, [sp]
10299d868: 900de682    	adrp	x2, 0x11e66d000 <dyld_stub_binder+0x11e66d000>
10299d86c: 9125a042    	add	x2, x2, #0x968
10299d870: aa1603e1    	mov	x1, x22
10299d874: 954a2632    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d878: aa1d03fd    	mov	x29, x29
10299d87c: 954a2633    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10299d880: aa0003f8    	mov	x24, x0
10299d884: aa1403e0    	mov	x0, x20
10299d888: aa1703e1    	mov	x1, x23
10299d88c: aa1803e2    	mov	x2, x24
10299d890: 954a262b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d894: aa1803e0    	mov	x0, x24
10299d898: 954a262f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10299d89c: f9454720    	ldr	x0, [x25, #0xa88]
10299d8a0: f9400ea8    	ldr	x8, [x21, #0x18]
10299d8a4: f90003e8    	str	x8, [sp]
10299d8a8: 900de682    	adrp	x2, 0x11e66d000 <dyld_stub_binder+0x11e66d000>
10299d8ac: 91262042    	add	x2, x2, #0x988
10299d8b0: aa1603e1    	mov	x1, x22
10299d8b4: 954a2622    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d8b8: aa1d03fd    	mov	x29, x29
10299d8bc: 954a2623    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10299d8c0: aa0003f8    	mov	x24, x0
10299d8c4: aa1403e0    	mov	x0, x20
10299d8c8: aa1703e1    	mov	x1, x23
10299d8cc: aa1803e2    	mov	x2, x24
10299d8d0: 954a261b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d8d4: aa1803e0    	mov	x0, x24
10299d8d8: 954a261f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10299d8dc: f9454720    	ldr	x0, [x25, #0xa88]
10299d8e0: f9400ea8    	ldr	x8, [x21, #0x18]
10299d8e4: f90003e8    	str	x8, [sp]
10299d8e8: 900de682    	adrp	x2, 0x11e66d000 <dyld_stub_binder+0x11e66d000>
10299d8ec: 9126a042    	add	x2, x2, #0x9a8
10299d8f0: aa1603e1    	mov	x1, x22
10299d8f4: 954a2612    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d8f8: aa1d03fd    	mov	x29, x29
10299d8fc: 954a2613    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10299d900: aa0003f8    	mov	x24, x0
10299d904: aa1403e0    	mov	x0, x20
10299d908: aa1703e1    	mov	x1, x23
10299d90c: aa1803e2    	mov	x2, x24
10299d910: 954a260b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d914: aa1803e0    	mov	x0, x24
10299d918: 954a260f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10299d91c: f9454720    	ldr	x0, [x25, #0xa88]
10299d920: f9400ea8    	ldr	x8, [x21, #0x18]
10299d924: f90003e8    	str	x8, [sp]
10299d928: 900de682    	adrp	x2, 0x11e66d000 <dyld_stub_binder+0x11e66d000>
10299d92c: 91272042    	add	x2, x2, #0x9c8
10299d930: aa1603e1    	mov	x1, x22
10299d934: 954a2602    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d938: aa1d03fd    	mov	x29, x29
10299d93c: 954a2603    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10299d940: aa0003f5    	mov	x21, x0
10299d944: aa1403e0    	mov	x0, x20
10299d948: aa1703e1    	mov	x1, x23
10299d94c: aa1503e2    	mov	x2, x21
10299d950: 954a25fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d954: aa1503e0    	mov	x0, x21
10299d958: 954a25ff    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10299d95c: 4f00e400    	movi.16b	v0, #0x0
10299d960: ad0183e0    	stp	q0, q0, [sp, #0x30]
10299d964: ad0083e0    	stp	q0, q0, [sp, #0x10]
10299d968: aa1403e0    	mov	x0, x20
10299d96c: 954a25f3    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10299d970: f00ebb08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10299d974: f9435515    	ldr	x21, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
10299d978: 910043e2    	add	x2, sp, #0x10
10299d97c: 910163e3    	add	x3, sp, #0x58
10299d980: aa1503e1    	mov	x1, x21
10299d984: 52800204    	mov	w4, #0x10               ; =16
10299d988: 954a25ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d98c: b40003c0    	cbz	x0, 0x10299da04 <_Flutter_Image_provideRelativePathByUrl+0xdaa8b4>
10299d990: aa0003f6    	mov	x22, x0
10299d994: f94013e8    	ldr	x8, [sp, #0x20]
10299d998: f9400118    	ldr	x24, [x8]
10299d99c: d00ebb39    	adrp	x25, 0x120103000 <dyld_stub_binder+0x120103000>
10299d9a0: d280001a    	mov	x26, #0x0               ; =0
10299d9a4: f943cb37    	ldr	x23, [x25, #0x790] ; isEqualToString:
10299d9a8: f94013e8    	ldr	x8, [sp, #0x20]
10299d9ac: f9400108    	ldr	x8, [x8]
10299d9b0: eb18011f    	cmp	x8, x24
10299d9b4: 54000060    	b.eq	0x10299d9c0 <_Flutter_Image_provideRelativePathByUrl+0xdaa870>
10299d9b8: aa1403e0    	mov	x0, x20
10299d9bc: 954a25e5    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
10299d9c0: f9400fe8    	ldr	x8, [sp, #0x18]
10299d9c4: f87a7902    	ldr	x2, [x8, x26, lsl #3]
10299d9c8: aa1303e0    	mov	x0, x19
10299d9cc: aa1703e1    	mov	x1, x23
10299d9d0: 954a25db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d9d4: 370001c0    	tbnz	w0, #0x0, 0x10299da0c <_Flutter_Image_provideRelativePathByUrl+0xdaa8bc>
10299d9d8: 9100075a    	add	x26, x26, #0x1
10299d9dc: eb1a02df    	cmp	x22, x26
10299d9e0: 54fffe41    	b.ne	0x10299d9a8 <_Flutter_Image_provideRelativePathByUrl+0xdaa858>
10299d9e4: 910043e2    	add	x2, sp, #0x10
10299d9e8: 910163e3    	add	x3, sp, #0x58
10299d9ec: aa1403e0    	mov	x0, x20
10299d9f0: aa1503e1    	mov	x1, x21
10299d9f4: 52800204    	mov	w4, #0x10               ; =16
10299d9f8: 954a25d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299d9fc: aa0003f6    	mov	x22, x0
10299da00: b5fffd00    	cbnz	x0, 0x10299d9a0 <_Flutter_Image_provideRelativePathByUrl+0xdaa850>
10299da04: 52800015    	mov	w21, #0x0               ; =0
10299da08: 14000002    	b	0x10299da10 <_Flutter_Image_provideRelativePathByUrl+0xdaa8c0>
10299da0c: 52800035    	mov	w21, #0x1               ; =1
10299da10: aa1403e0    	mov	x0, x20
10299da14: 954a25d0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10299da18: aa1403e0    	mov	x0, x20
10299da1c: 954a25ce    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10299da20: 17ffff1f    	b	0x10299d69c <_Flutter_Image_provideRelativePathByUrl+0xdaa54c>
10299da24: 954a25d4    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
