
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101d77b74 <_Flutter_Image_provideRelativePathByUrl>:
10203a828:     	sub	sp, sp, #0x40
10203a82c:     	stp	x22, x21, [sp, #0x10]
10203a830:     	stp	x20, x19, [sp, #0x20]
10203a834:     	stp	x29, x30, [sp, #0x30]
10203a838:     	add	x29, sp, #0x30
10203a83c:     	mov	x21, x3
10203a840:     	mov	x19, x2
10203a844:     	mov	x0, x2
10203a848:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10203a84c:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10203a850:     	ldr	x0, [x8, #0x780]
10203a854:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10203a858:     	ldr	x1, [x8, #0x800]
10203a85c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a860:     	mov	x29, x29
10203a864:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10203a868:     	mov	x22, x0
10203a86c:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10203a870:     	ldr	x0, [x8, #0xbe8]
10203a874:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10203a878:     	ldr	x1, [x8, #0x508]
10203a87c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a880:     	mov	x2, x0
10203a884:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10203a888:     	ldr	x1, [x8, #0xa40]
10203a88c:     	mov	x0, x22
10203a890:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a894:     	mov	x29, x29
10203a898:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10203a89c:     	mov	x20, x0
10203a8a0:     	mov	x0, x22
10203a8a4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a8a8:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10203a8ac:     	ldr	x1, [x8, #0x150]
10203a8b0:     	mov	x0, x20
10203a8b4:     	mov	x2, x19
10203a8b8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a8bc:     	mov	x29, x29
10203a8c0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10203a8c4:     	mov	x22, x0
10203a8c8:     	cbz	x0, 0x10203a8f0 <_Flutter_Image_provideRelativePathByUrl+0x2c2d7c>
10203a8cc:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10203a8d0:     	ldr	x1, [x8, #0x670]
10203a8d4:     	mov	x0, x20
10203a8d8:     	mov	x2, x22
10203a8dc:     	mov	w3, #0x1                ; =1
10203a8e0:     	mov	x4, x21
10203a8e4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a8e8:     	mov	x21, x0
10203a8ec:     	b	0x10203a938 <_Flutter_Image_provideRelativePathByUrl+0x2c2dc4>
10203a8f0:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10203a8f4:     	ldr	x0, [x8, #0x618]
10203a8f8:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10203a8fc:     	ldr	x1, [x8, #0x310]
10203a900:     	adrp	x8, 0x11d0fa000 <dyld_stub_binder+0x11d0fa000>
10203a904:     	add	x8, x8, #0x918
10203a908:     	stp	x8, x19, [sp]
10203a90c:     	adrp	x3, 0x119c93000 <dyld_stub_binder+0x119c93000>
10203a910:     	add	x3, x3, #0x582
10203a914:     	adrp	x5, 0x119e19000 <dyld_stub_binder+0x119e19000>
10203a918:     	add	x5, x5, #0x24a
10203a91c:     	adrp	x7, 0x119e19000 <dyld_stub_binder+0x119e19000>
10203a920:     	add	x7, x7, #0x7b6
10203a924:     	mov	w2, #0x2                ; =2
10203a928:     	mov	w4, #0x0                ; =0
10203a92c:     	mov	w6, #0x2b4              ; =692
10203a930:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a934:     	mov	w21, #0x0               ; =0
10203a938:     	mov	x0, x22
10203a93c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a940:     	mov	x0, x20
10203a944:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a948:     	mov	x0, x19
10203a94c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a950:     	mov	x0, x21
10203a954:     	ldp	x29, x30, [sp, #0x30]
10203a958:     	ldp	x20, x19, [sp, #0x20]
10203a95c:     	ldp	x22, x21, [sp, #0x10]
10203a960:     	add	sp, sp, #0x40
10203a964:     	ret
