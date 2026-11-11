
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
10595a640:     	sub	sp, sp, #0xa0
10595a644:     	stp	x28, x27, [sp, #0x40]
10595a648:     	stp	x26, x25, [sp, #0x50]
10595a64c:     	stp	x24, x23, [sp, #0x60]
10595a650:     	stp	x22, x21, [sp, #0x70]
10595a654:     	stp	x20, x19, [sp, #0x80]
10595a658:     	stp	x29, x30, [sp, #0x90]
10595a65c:     	add	x29, sp, #0x90
10595a660:     	mov	x19, x2
10595a664:     	mov	x21, x0
10595a668:     	adrp	x8, 0x11f754000 <dyld_stub_binder+0x11f754000>
10595a66c:     	mov	w9, #0x1                ; =1
10595a670:     	strb	w9, [x8, #0x6a9]
10595a674:     	mov	x0, x2
10595a678:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10595a67c:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10595a680:     	ldr	x23, [x8, #0x620]
10595a684:     	mov	x0, x19
10595a688:     	mov	x1, x23
10595a68c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a690:     	mov	x29, x29
10595a694:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10595a698:     	mov	x20, x0
10595a69c:     	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10595a6a0:     	add	x8, x8, #0xc0c
10595a6a4:     	ldrsw	x28, [x8]
10595a6a8:     	ldr	x2, [x21, x28]
10595a6ac:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10595a6b0:     	ldr	x1, [x8, #0x478]
10595a6b4:     	mov	x0, x19
10595a6b8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a6bc:     	adrp	x25, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10595a6c0:     	adrp	x26, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10595a6c4:     	adrp	x24, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10595a6c8:     	adrp	x27, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10595a6cc:     	tbz	w0, #0x0, 0x10595a6f0 <_Flutter_MMFoundation_BindContext+0x1be13bc>
10595a6d0:     	mov	x22, x27
10595a6d4:     	mov	x27, x20
10595a6d8:     	adrp	x20, 0x11d0dd000 <dyld_stub_binder+0x11d0dd000>
10595a6dc:     	add	x20, x20, #0xf78
10595a6e0:     	mov	x0, x27
10595a6e4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10595a6e8:     	mov	x27, x22
10595a6ec:     	b	0x10595a788 <_Flutter_MMFoundation_BindContext+0x1be1454>
10595a6f0:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10595a6f4:     	ldr	x1, [x8, #0x158]
10595a6f8:     	mov	x0, x19
10595a6fc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a700:     	tbnz	w0, #0x0, 0x10595a788 <_Flutter_MMFoundation_BindContext+0x1be1454>
10595a704:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10595a708:     	ldr	x1, [x8, #0xed0]
10595a70c:     	mov	x0, x19
10595a710:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a714:     	tbz	w0, #0x2, 0x10595a788 <_Flutter_MMFoundation_BindContext+0x1be1454>
10595a718:     	ldr	x22, [x21, x28]
10595a71c:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10595a720:     	ldr	x0, [x8, #0xac0]
10595a724:     	ldr	x1, [x24, #0x508]
10595a728:     	str	x1, [sp, #0x38]
10595a72c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a730:     	mov	x2, x0
10595a734:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
10595a738:     	ldr	x1, [x8, #0x890]
10595a73c:     	mov	x0, x22
10595a740:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a744:     	cbz	w0, 0x10595a788 <_Flutter_MMFoundation_BindContext+0x1be1454>
10595a748:     	mov	x22, x27
10595a74c:     	ldr	x0, [x21, x28]
10595a750:     	adrp	x8, 0x11e9dd000 <dyld_stub_binder+0x11e9dd000>
10595a754:     	ldr	x1, [x8, #0x100]
10595a758:     	mov	x2, x19
10595a75c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a760:     	mov	x29, x29
10595a764:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10595a768:     	mov	x27, x0
10595a76c:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
10595a770:     	ldr	x26, [x8, #0xce8]
10595a774:     	mov	x1, x26
10595a778:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a77c:     	cbz	x0, 0x10595a81c <_Flutter_MMFoundation_BindContext+0x1be14e8>
10595a780:     	adrp	x26, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10595a784:     	b	0x10595a6e0 <_Flutter_MMFoundation_BindContext+0x1be13ac>
10595a788:     	ldr	x0, [x25, #0x780]
10595a78c:     	ldr	x1, [x26, #0x800]
10595a790:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a794:     	mov	x29, x29
10595a798:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10595a79c:     	mov	x22, x0
10595a7a0:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10595a7a4:     	ldr	x0, [x8, #0xbf8]
10595a7a8:     	ldr	x1, [x24, #0x508]
10595a7ac:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a7b0:     	mov	x2, x0
10595a7b4:     	ldr	x1, [x27, #0xa40]
10595a7b8:     	mov	x0, x22
10595a7bc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a7c0:     	mov	x29, x29
10595a7c4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10595a7c8:     	mov	x23, x0
10595a7cc:     	ldr	x2, [x21, x28]
10595a7d0:     	adrp	x8, 0x11ea3a000 <dyld_stub_binder+0x11ea3a000>
10595a7d4:     	ldr	x1, [x8, #0xb88]
10595a7d8:     	mov	x3, x20
10595a7dc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a7e0:     	mov	x0, x23
10595a7e4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10595a7e8:     	mov	x0, x22
10595a7ec:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10595a7f0:     	mov	x0, x20
10595a7f4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10595a7f8:     	mov	x0, x19
10595a7fc:     	ldp	x29, x30, [sp, #0x90]
10595a800:     	ldp	x20, x19, [sp, #0x80]
10595a804:     	ldp	x22, x21, [sp, #0x70]
10595a808:     	ldp	x24, x23, [sp, #0x60]
10595a80c:     	ldp	x26, x25, [sp, #0x50]
10595a810:     	ldp	x28, x27, [sp, #0x40]
10595a814:     	add	sp, sp, #0xa0
10595a818:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10595a81c:     	str	x26, [sp, #0x8]
10595a820:     	ldr	x0, [x25, #0x780]
10595a824:     	adrp	x26, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10595a828:     	ldr	x1, [x26, #0x800]
10595a82c:     	str	x1, [sp, #0x18]
10595a830:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a834:     	mov	x29, x29
10595a838:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10595a83c:     	str	x0, [sp, #0x30]
10595a840:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10595a844:     	ldr	x0, [x8, #0x890]
10595a848:     	ldr	x1, [sp, #0x38]
10595a84c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a850:     	mov	x2, x0
10595a854:     	ldr	x1, [x22, #0xa40]
10595a858:     	ldr	x0, [sp, #0x30]
10595a85c:     	str	x1, [sp, #0x10]
10595a860:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a864:     	mov	x29, x29
10595a868:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10595a86c:     	str	x0, [sp, #0x20]
10595a870:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10595a874:     	ldr	x1, [x8, #0xe48]
10595a878:     	adrp	x2, 0x11d325000 <dyld_stub_binder+0x11d325000>
10595a87c:     	add	x2, x2, #0x7b8
10595a880:     	mov	w3, #0x0                ; =0
10595a884:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a888:     	str	w0, [sp, #0x2c]
10595a88c:     	ldr	x0, [sp, #0x20]
10595a890:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10595a894:     	ldr	x0, [sp, #0x30]
10595a898:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10595a89c:     	mov	x0, x27
10595a8a0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10595a8a4:     	ldr	w8, [sp, #0x2c]
10595a8a8:     	tbnz	w8, #0x0, 0x10595a6e8 <_Flutter_MMFoundation_BindContext+0x1be13b4>
10595a8ac:     	mov	w0, #0xc9               ; =201
10595a8b0:     	mov	w1, #0x69               ; =105
10595a8b4:     	mov	w2, #0x1                ; =1
10595a8b8:     	mov	w3, #0x0                ; =0
10595a8bc:     	mov	w4, #0x0                ; =0
10595a8c0:     	bl	0x1020ea20c <_Flutter_Image_provideRelativePathByUrl+0x372698>
10595a8c4:     	ldr	x0, [x25, #0x780]
10595a8c8:     	ldr	x1, [sp, #0x18]
10595a8cc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a8d0:     	mov	x29, x29
10595a8d4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10595a8d8:     	mov	x27, x0
10595a8dc:     	str	x0, [sp, #0x30]
10595a8e0:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10595a8e4:     	ldr	x0, [x8, #0xbe8]
10595a8e8:     	ldr	x1, [sp, #0x38]
10595a8ec:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a8f0:     	mov	x2, x0
10595a8f4:     	mov	x0, x27
10595a8f8:     	ldr	x1, [sp, #0x10]
10595a8fc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a900:     	mov	x29, x29
10595a904:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10595a908:     	mov	x27, x0
10595a90c:     	mov	x0, x19
10595a910:     	mov	x1, x23
10595a914:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a918:     	mov	x29, x29
10595a91c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10595a920:     	mov	x23, x0
10595a924:     	adrp	x8, 0x11e9ea000 <dyld_stub_binder+0x11e9ea000>
10595a928:     	ldr	x1, [x8, #0xe40]
10595a92c:     	mov	x0, x27
10595a930:     	mov	x2, x23
10595a934:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a938:     	str	w0, [sp, #0x2c]
10595a93c:     	mov	x0, x23
10595a940:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10595a944:     	mov	x0, x27
10595a948:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10595a94c:     	ldr	x0, [sp, #0x30]
10595a950:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10595a954:     	ldr	w8, [sp, #0x2c]
10595a958:     	cbz	w8, 0x10595a6e8 <_Flutter_MMFoundation_BindContext+0x1be13b4>
10595a95c:     	ldr	x0, [x25, #0x780]
10595a960:     	ldr	x1, [sp, #0x18]
10595a964:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a968:     	mov	x29, x29
10595a96c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10595a970:     	mov	x23, x0
10595a974:     	str	x0, [sp, #0x30]
10595a978:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10595a97c:     	ldr	x0, [x8, #0xbe8]
10595a980:     	ldr	x1, [sp, #0x38]
10595a984:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a988:     	mov	x2, x0
10595a98c:     	mov	x0, x23
10595a990:     	ldr	x1, [sp, #0x10]
10595a994:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a998:     	mov	x29, x29
10595a99c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10595a9a0:     	mov	x23, x0
10595a9a4:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10595a9a8:     	ldr	x0, [x8, #0x688]
10595a9ac:     	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
10595a9b0:     	ldr	x1, [x8, #0xdb0]
10595a9b4:     	mov	x2, x19
10595a9b8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a9bc:     	mov	x29, x29
10595a9c0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10595a9c4:     	mov	x27, x0
10595a9c8:     	ldr	x3, [x21, x28]
10595a9cc:     	adrp	x8, 0x11ea09000 <dyld_stub_binder+0x11ea09000>
10595a9d0:     	ldr	x1, [x8, #0x108]
10595a9d4:     	mov	x0, x23
10595a9d8:     	mov	x2, x27
10595a9dc:     	mov	w4, #0x23               ; =35
10595a9e0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595a9e4:     	mov	x0, x27
10595a9e8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10595a9ec:     	mov	x0, x23
10595a9f0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10595a9f4:     	ldr	x0, [sp, #0x30]
10595a9f8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10595a9fc:     	mov	w0, #0xc9               ; =201
10595aa00:     	mov	w1, #0x66               ; =102
10595aa04:     	mov	w2, #0x1                ; =1
10595aa08:     	mov	w3, #0x0                ; =0
10595aa0c:     	mov	w4, #0x0                ; =0
10595aa10:     	bl	0x1020ea20c <_Flutter_Image_provideRelativePathByUrl+0x372698>
10595aa14:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10595aa18:     	ldr	x1, [x8, #0x628]
10595aa1c:     	mov	x0, x19
10595aa20:     	str	x1, [sp, #0x38]
10595aa24:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595aa28:     	mov	x29, x29
10595aa2c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10595aa30:     	mov	x27, x0
10595aa34:     	ldr	x1, [sp, #0x8]
10595aa38:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595aa3c:     	mov	x23, x0
10595aa40:     	mov	x0, x27
10595aa44:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10595aa48:     	cbnz	x23, 0x10595aa64 <_Flutter_MMFoundation_BindContext+0x1be1730>
10595aa4c:     	mov	w0, #0xc9               ; =201
10595aa50:     	mov	w1, #0x6c               ; =108
10595aa54:     	mov	w2, #0x1                ; =1
10595aa58:     	mov	w3, #0x0                ; =0
10595aa5c:     	mov	w4, #0x0                ; =0
10595aa60:     	bl	0x1020ea20c <_Flutter_Image_provideRelativePathByUrl+0x372698>
10595aa64:     	adrp	x8, 0x11edcf000 <dyld_stub_binder+0x11edcf000>
10595aa68:     	ldrsw	x8, [x8, #0xa00]
10595aa6c:     	add	x0, x21, x8
10595aa70:     	mov	x1, x19
10595aa74:     	bl	0x107c27c9c <_Flutter_MMFoundation_BindContext+0x3eae968>
10595aa78:     	mov	x0, x19
10595aa7c:     	ldr	x1, [sp, #0x38]
10595aa80:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595aa84:     	mov	x29, x29
10595aa88:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10595aa8c:     	adrp	x8, 0x11edcf000 <dyld_stub_binder+0x11edcf000>
10595aa90:     	ldrsw	x9, [x8, #0xa04]
10595aa94:     	ldr	x8, [x21, x9]
10595aa98:     	str	x0, [x21, x9]
10595aa9c:     	mov	x0, x8
10595aaa0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10595aaa4:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10595aaa8:     	ldr	x1, [x8, #0xda8]
10595aaac:     	mov	x0, x19
10595aab0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10595aab4:     	mov	x29, x29
10595aab8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10595aabc:     	adrp	x8, 0x11edcf000 <dyld_stub_binder+0x11edcf000>
10595aac0:     	ldrsw	x8, [x8, #0xa08]
10595aac4:     	ldr	x27, [x21, x8]
10595aac8:     	str	x0, [x21, x8]
10595aacc:     	b	0x10595a6e0 <_Flutter_MMFoundation_BindContext+0x1be13ac>
