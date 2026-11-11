
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10038e4b8:     	sub	sp, sp, #0xf0
10038e4bc:     	stp	x28, x27, [sp, #0x90]
10038e4c0:     	stp	x26, x25, [sp, #0xa0]
10038e4c4:     	stp	x24, x23, [sp, #0xb0]
10038e4c8:     	stp	x22, x21, [sp, #0xc0]
10038e4cc:     	stp	x20, x19, [sp, #0xd0]
10038e4d0:     	stp	x29, x30, [sp, #0xe0]
10038e4d4:     	add	x29, sp, #0xe0
10038e4d8:     	mov	x19, x0
10038e4dc:     	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
10038e4e0:     	mov	w9, #0x1                ; =1
10038e4e4:     	strb	w9, [x8, #0xc00]
10038e4e8:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038e4ec:     	ldr	x0, [x8, #0x8f8]
10038e4f0:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
10038e4f4:     	ldr	x1, [x8, #0x8c8]
10038e4f8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e4fc:     	tbz	w0, #0x0, 0x10038e798 <__text+0x386798>
10038e500:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038e504:     	ldr	x8, [x8, #0x618]
10038e508:     	str	x8, [sp, #0x50]
10038e50c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038e510:     	ldr	x1, [x8, #0x4a0]
10038e514:     	mov	x0, x19
10038e518:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e51c:     	mov	x25, x0
10038e520:     	adrp	x8, 0x11e9e0000 <dyld_stub_binder+0x11e9e0000>
10038e524:     	ldr	x1, [x8, #0x6c0]
10038e528:     	mov	x0, x19
10038e52c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e530:     	mov	x27, x0
10038e534:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038e538:     	ldr	x1, [x8, #0x4a8]
10038e53c:     	mov	x0, x19
10038e540:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e544:     	mov	x29, x29
10038e548:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038e54c:     	mov	x22, x0
10038e550:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038e554:     	ldr	x1, [x8, #0x4b0]
10038e558:     	mov	x0, x19
10038e55c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e560:     	mov	x29, x29
10038e564:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038e568:     	mov	x24, x0
10038e56c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038e570:     	ldr	x1, [x8, #0x440]
10038e574:     	str	x1, [sp, #0x58]
10038e578:     	mov	x0, x19
10038e57c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e580:     	mov	x29, x29
10038e584:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038e588:     	mov	x26, x0
10038e58c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038e590:     	ldr	x1, [x8, #0x448]
10038e594:     	str	x1, [sp, #0x60]
10038e598:     	mov	x0, x19
10038e59c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e5a0:     	mov	x29, x29
10038e5a4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038e5a8:     	mov	x28, x0
10038e5ac:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038e5b0:     	ldr	x1, [x8, #0x450]
10038e5b4:     	mov	x0, x19
10038e5b8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e5bc:     	mov	x29, x29
10038e5c0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038e5c4:     	mov	x20, x0
10038e5c8:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038e5cc:     	ldr	x1, [x8, #0x458]
10038e5d0:     	mov	x0, x19
10038e5d4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e5d8:     	mov	x29, x29
10038e5dc:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038e5e0:     	mov	x23, x0
10038e5e4:     	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
10038e5e8:     	ldr	x1, [x8, #0xba0]
10038e5ec:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e5f0:     	mov	x29, x29
10038e5f4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038e5f8:     	mov	x21, x0
10038e5fc:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10038e600:     	ldr	x1, [x8, #0x310]
10038e604:     	stp	x20, x0, [sp, #0x38]
10038e608:     	stp	x26, x28, [sp, #0x28]
10038e60c:     	adrp	x8, 0x11cfc6000 <dyld_stub_binder+0x11cfc6000>
10038e610:     	add	x8, x8, #0xdd8
10038e614:     	adrp	x3, 0x119bcf000 <dyld_stub_binder+0x119bcf000>
10038e618:     	add	x3, x3, #0xff4
10038e61c:     	adrp	x5, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038e620:     	add	x5, x5, #0xb
10038e624:     	adrp	x7, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038e628:     	add	x7, x7, #0x16e
10038e62c:     	stp	x22, x24, [sp, #0x18]
10038e630:     	stp	x25, x27, [sp, #0x8]
10038e634:     	str	x8, [sp]
10038e638:     	ldr	x0, [sp, #0x50]
10038e63c:     	mov	w2, #0x2                ; =2
10038e640:     	mov	w4, #0x0                ; =0
10038e644:     	mov	w6, #0xa3               ; =163
10038e648:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e64c:     	mov	x0, x21
10038e650:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038e654:     	mov	x0, x23
10038e658:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038e65c:     	mov	x0, x20
10038e660:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038e664:     	mov	x0, x28
10038e668:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038e66c:     	mov	x0, x26
10038e670:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038e674:     	mov	x0, x24
10038e678:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038e67c:     	mov	x0, x22
10038e680:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038e684:     	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
10038e688:     	ldr	x1, [x8, #0x618]
10038e68c:     	mov	x0, x19
10038e690:     	mov	x2, #0x0                ; =0
10038e694:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e698:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038e69c:     	ldr	x1, [x8, #0x408]
10038e6a0:     	mov	x0, x19
10038e6a4:     	mov	w2, #0x0                ; =0
10038e6a8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e6ac:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038e6b0:     	ldr	x1, [x8, #0x420]
10038e6b4:     	mov	x0, x19
10038e6b8:     	mov	x2, #0x0                ; =0
10038e6bc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e6c0:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038e6c4:     	ldr	x1, [x8, #0x418]
10038e6c8:     	mov	x0, x19
10038e6cc:     	mov	w2, #0x4                ; =4
10038e6d0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e6d4:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038e6d8:     	ldr	x1, [x8, #0x428]
10038e6dc:     	mov	x0, x19
10038e6e0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e6e4:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038e6e8:     	ldr	x1, [x8, #0x430]
10038e6ec:     	add	x2, x0, #0x1
10038e6f0:     	mov	x0, x19
10038e6f4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e6f8:     	mov	x0, x19
10038e6fc:     	ldr	x1, [sp, #0x58]
10038e700:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e704:     	mov	x29, x29
10038e708:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038e70c:     	mov	x20, x0
10038e710:     	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
10038e714:     	ldr	x21, [x8, #0x420]
10038e718:     	mov	x1, x21
10038e71c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e720:     	mov	x0, x20
10038e724:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038e728:     	mov	x0, x19
10038e72c:     	ldr	x1, [sp, #0x60]
10038e730:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e734:     	mov	x29, x29
10038e738:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038e73c:     	mov	x20, x0
10038e740:     	mov	x1, x21
10038e744:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e748:     	mov	x0, x20
10038e74c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038e750:     	adrp	x8, 0x11d74e000 <dyld_stub_binder+0x11d74e000>
10038e754:     	ldr	x8, [x8, #0xa10]
10038e758:     	ldr	x2, [x8]
10038e75c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038e760:     	ldr	x1, [x8, #0x470]
10038e764:     	mov	x0, x19
10038e768:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e76c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038e770:     	ldr	x1, [x8, #0x4b8]
10038e774:     	mov	x0, x19
10038e778:     	ldp	x29, x30, [sp, #0xe0]
10038e77c:     	ldp	x20, x19, [sp, #0xd0]
10038e780:     	ldp	x22, x21, [sp, #0xc0]
10038e784:     	ldp	x24, x23, [sp, #0xb0]
10038e788:     	ldp	x26, x25, [sp, #0xa0]
10038e78c:     	ldp	x28, x27, [sp, #0x90]
10038e790:     	add	sp, sp, #0xf0
10038e794:     	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e798:     	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10038e79c:     	ldr	x8, [x8, #0x930]
10038e7a0:     	str	x8, [sp, #0x68]
10038e7a4:     	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
10038e7a8:     	ldr	d0, [x8, #0x680]
10038e7ac:     	adrp	x8, 0x10038e000 <__text+0x386000>
10038e7b0:     	add	x8, x8, #0x7f8
10038e7b4:     	str	d0, [sp, #0x70]
10038e7b8:     	adrp	x9, 0x11c280000 <dyld_stub_binder+0x11c280000>
10038e7bc:     	add	x9, x9, #0x470
10038e7c0:     	stp	x8, x9, [sp, #0x78]
10038e7c4:     	str	x19, [sp, #0x88]
10038e7c8:     	adrp	x0, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10038e7cc:     	ldr	x0, [x0, #0xa98]
10038e7d0:     	add	x1, sp, #0x68
10038e7d4:     	bl	0x107c0cb9c <_Flutter_MMFoundation_BindContext+0x3e93868>
10038e7d8:     	ldp	x29, x30, [sp, #0xe0]
10038e7dc:     	ldp	x20, x19, [sp, #0xd0]
10038e7e0:     	ldp	x22, x21, [sp, #0xc0]
10038e7e4:     	ldp	x24, x23, [sp, #0xb0]
10038e7e8:     	ldp	x26, x25, [sp, #0xa0]
10038e7ec:     	ldp	x28, x27, [sp, #0x90]
10038e7f0:     	add	sp, sp, #0xf0
10038e7f4:     	ret
10038e7f8:     	ldr	x0, [x0, #0x20]
10038e7fc:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10038e800:     	ldr	x1, [x8, #0x318]
10038e804:     	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
