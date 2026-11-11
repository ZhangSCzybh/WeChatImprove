
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10038f700:     	sub	sp, sp, #0x70
10038f704:     	stp	x22, x21, [sp, #0x40]
10038f708:     	stp	x20, x19, [sp, #0x50]
10038f70c:     	stp	x29, x30, [sp, #0x60]
10038f710:     	add	x29, sp, #0x60
10038f714:     	mov	x19, x3
10038f718:     	mov	x20, x2
10038f71c:     	mov	x21, x0
10038f720:     	mov	x0, x2
10038f724:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10038f728:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038f72c:     	ldr	x0, [x8, #0x840]
10038f730:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10038f734:     	ldr	x1, [x8, #0xc30]
10038f738:     	mov	x2, x19
10038f73c:     	mov	x3, x21
10038f740:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f744:     	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10038f748:     	ldr	x8, [x8, #0x930]
10038f74c:     	str	x8, [sp, #0x8]
10038f750:     	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
10038f754:     	ldr	d0, [x8, #0x680]
10038f758:     	adrp	x8, 0x10038f000 <__text+0x387000>
10038f75c:     	add	x8, x8, #0x7b4
10038f760:     	adrp	x9, 0x11c282000 <dyld_stub_binder+0x11c282000>
10038f764:     	add	x9, x9, #0xec0
10038f768:     	str	d0, [sp, #0x10]
10038f76c:     	stp	x8, x9, [sp, #0x18]
10038f770:     	str	w19, [sp, #0x38]
10038f774:     	stp	x21, x20, [sp, #0x28]
10038f778:     	mov	x0, x20
10038f77c:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10038f780:     	adrp	x0, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10038f784:     	ldr	x0, [x0, #0xa98]
10038f788:     	add	x1, sp, #0x8
10038f78c:     	bl	0x107c0cb9c <_Flutter_MMFoundation_BindContext+0x3e93868>
10038f790:     	ldr	x0, [sp, #0x30]
10038f794:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f798:     	mov	x0, x20
10038f79c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f7a0:     	ldp	x29, x30, [sp, #0x60]
10038f7a4:     	ldp	x20, x19, [sp, #0x50]
10038f7a8:     	ldp	x22, x21, [sp, #0x40]
10038f7ac:     	add	sp, sp, #0x70
10038f7b0:     	ret
10038f7b4:     	sub	sp, sp, #0x70
10038f7b8:     	stp	x24, x23, [sp, #0x30]
10038f7bc:     	stp	x22, x21, [sp, #0x40]
10038f7c0:     	stp	x20, x19, [sp, #0x50]
10038f7c4:     	stp	x29, x30, [sp, #0x60]
10038f7c8:     	add	x29, sp, #0x60
10038f7cc:     	mov	x19, x0
10038f7d0:     	ldr	x0, [x0, #0x20]
10038f7d4:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038f7d8:     	ldr	x20, [x8, #0x400]
10038f7dc:     	mov	x1, x20
10038f7e0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f7e4:     	adrp	x8, 0x11e9e0000 <dyld_stub_binder+0x11e9e0000>
10038f7e8:     	ldr	x21, [x8, #0x6c0]
10038f7ec:     	tbz	w0, #0x0, 0x10038f860 <__text+0x387860>
10038f7f0:     	ldr	w23, [x19, #0x30]
10038f7f4:     	ldr	x0, [x19, #0x20]
10038f7f8:     	mov	x1, x21
10038f7fc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f800:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10038f804:     	ldr	x22, [x8, #0xc28]
10038f808:     	cmp	w23, w0
10038f80c:     	b.ne	0x10038f868 <__text+0x387868>
10038f810:     	ldr	x0, [x19, #0x28]
10038f814:     	mov	x1, x22
10038f818:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f81c:     	mov	w8, #0x4810             ; =18448
10038f820:     	cmp	w0, w8
10038f824:     	b.ne	0x10038f868 <__text+0x387868>
10038f828:     	ldr	x0, [x19, #0x20]
10038f82c:     	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
10038f830:     	ldr	x1, [x8, #0x510]
10038f834:     	mov	w2, #0x0                ; =0
10038f838:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f83c:     	ldp	x0, x2, [x19, #0x20]
10038f840:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038f844:     	ldr	x1, [x8, #0x4f0]
10038f848:     	ldp	x29, x30, [sp, #0x60]
10038f84c:     	ldp	x20, x19, [sp, #0x50]
10038f850:     	ldp	x22, x21, [sp, #0x40]
10038f854:     	ldp	x24, x23, [sp, #0x30]
10038f858:     	add	sp, sp, #0x70
10038f85c:     	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f860:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10038f864:     	ldr	x22, [x8, #0xc28]
10038f868:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038f86c:     	ldr	x23, [x8, #0x618]
10038f870:     	ldr	x0, [x19, #0x20]
10038f874:     	ldr	w24, [x19, #0x30]
10038f878:     	mov	x1, x21
10038f87c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f880:     	mov	x21, x0
10038f884:     	ldr	x0, [x19, #0x28]
10038f888:     	mov	x1, x22
10038f88c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f890:     	mov	x22, x0
10038f894:     	ldr	x0, [x19, #0x20]
10038f898:     	mov	x1, x20
10038f89c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f8a0:     	mov	x20, x0
10038f8a4:     	ldr	x0, [x19, #0x20]
10038f8a8:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038f8ac:     	ldr	x1, [x8, #0x4a0]
10038f8b0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f8b4:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10038f8b8:     	ldr	x1, [x8, #0x310]
10038f8bc:     	stp	x20, x0, [sp, #0x20]
10038f8c0:     	stp	x21, x22, [sp, #0x10]
10038f8c4:     	adrp	x8, 0x11cfc6000 <dyld_stub_binder+0x11cfc6000>
10038f8c8:     	add	x8, x8, #0xeb8
10038f8cc:     	stp	x8, x24, [sp]
10038f8d0:     	adrp	x3, 0x119bcf000 <dyld_stub_binder+0x119bcf000>
10038f8d4:     	add	x3, x3, #0xff4
10038f8d8:     	adrp	x5, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038f8dc:     	add	x5, x5, #0xb
10038f8e0:     	adrp	x7, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038f8e4:     	add	x7, x7, #0x3d6
10038f8e8:     	mov	x0, x23
10038f8ec:     	mov	w2, #0x3                ; =3
10038f8f0:     	mov	w4, #0x0                ; =0
10038f8f4:     	mov	w6, #0x12e              ; =302
10038f8f8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f8fc:     	ldp	x29, x30, [sp, #0x60]
10038f900:     	ldp	x20, x19, [sp, #0x50]
10038f904:     	ldp	x22, x21, [sp, #0x40]
10038f908:     	ldp	x24, x23, [sp, #0x30]
10038f90c:     	add	sp, sp, #0x70
10038f910:     	ret
