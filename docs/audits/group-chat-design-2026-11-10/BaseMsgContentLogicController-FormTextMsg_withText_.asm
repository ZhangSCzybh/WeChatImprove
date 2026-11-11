
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002ce82c:     	stp	x26, x25, [sp, #-0x50]!
1002ce830:     	stp	x24, x23, [sp, #0x10]
1002ce834:     	stp	x22, x21, [sp, #0x20]
1002ce838:     	stp	x20, x19, [sp, #0x30]
1002ce83c:     	stp	x29, x30, [sp, #0x40]
1002ce840:     	add	x29, sp, #0x40
1002ce844:     	mov	x21, x3
1002ce848:     	mov	x20, x2
1002ce84c:     	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
1002ce850:     	mov	w9, #0x1                ; =1
1002ce854:     	strb	w9, [x8, #0x984]
1002ce858:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002ce85c:     	ldr	x19, [x8, #0xe10]
1002ce860:     	mov	x0, x3
1002ce864:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1002ce868:     	mov	x0, x20
1002ce86c:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1002ce870:     	mov	x0, x19
1002ce874:     	bl	0x107c27c08 <_Flutter_MMFoundation_BindContext+0x3eae8d4>
1002ce878:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1002ce87c:     	ldr	x1, [x8, #0xa60]
1002ce880:     	mov	w2, #0x1                ; =1
1002ce884:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ce888:     	mov	x19, x0
1002ce88c:     	adrp	x25, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002ce890:     	ldr	x0, [x25, #0x780]
1002ce894:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002ce898:     	ldr	x22, [x8, #0x800]
1002ce89c:     	mov	x1, x22
1002ce8a0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ce8a4:     	mov	x29, x29
1002ce8a8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002ce8ac:     	mov	x23, x0
1002ce8b0:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1002ce8b4:     	ldr	x1, [x8, #0xa70]
1002ce8b8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ce8bc:     	mov	x29, x29
1002ce8c0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002ce8c4:     	mov	x24, x0
1002ce8c8:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1002ce8cc:     	ldr	x1, [x8, #0xa68]
1002ce8d0:     	mov	x0, x19
1002ce8d4:     	mov	x2, x24
1002ce8d8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ce8dc:     	mov	x0, x24
1002ce8e0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002ce8e4:     	mov	x0, x23
1002ce8e8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002ce8ec:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1002ce8f0:     	ldr	x1, [x8, #0xa80]
1002ce8f4:     	mov	x0, x19
1002ce8f8:     	mov	x2, x21
1002ce8fc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ce900:     	mov	x0, x21
1002ce904:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002ce908:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1002ce90c:     	ldr	x1, [x8, #0xa78]
1002ce910:     	mov	x0, x19
1002ce914:     	mov	x2, x20
1002ce918:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ce91c:     	mov	x0, x20
1002ce920:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002ce924:     	ldr	x0, [x25, #0x780]
1002ce928:     	mov	x1, x22
1002ce92c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ce930:     	mov	x29, x29
1002ce934:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002ce938:     	mov	x20, x0
1002ce93c:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002ce940:     	ldr	x0, [x8, #0xbf8]
1002ce944:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1002ce948:     	ldr	x1, [x8, #0x508]
1002ce94c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ce950:     	mov	x2, x0
1002ce954:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002ce958:     	ldr	x1, [x8, #0xa40]
1002ce95c:     	mov	x0, x20
1002ce960:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ce964:     	mov	x29, x29
1002ce968:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002ce96c:     	mov	x21, x0
1002ce970:     	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1002ce974:     	ldr	x1, [x8, #0x70]
1002ce978:     	mov	x0, x19
1002ce97c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ce980:     	mov	x29, x29
1002ce984:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002ce988:     	mov	x22, x0
1002ce98c:     	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
1002ce990:     	ldr	x1, [x8, #0xe40]
1002ce994:     	mov	x0, x21
1002ce998:     	mov	x2, x22
1002ce99c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ce9a0:     	mov	x2, x0
1002ce9a4:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1002ce9a8:     	ldr	x1, [x8, #0xa98]
1002ce9ac:     	mov	x0, x19
1002ce9b0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ce9b4:     	mov	x0, x22
1002ce9b8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002ce9bc:     	mov	x0, x21
1002ce9c0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002ce9c4:     	mov	x0, x20
1002ce9c8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002ce9cc:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1002ce9d0:     	ldr	x1, [x8, #0xa88]
1002ce9d4:     	mov	x0, x19
1002ce9d8:     	mov	w2, #0x1                ; =1
1002ce9dc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ce9e0:     	mov	x0, x19
1002ce9e4:     	ldp	x29, x30, [sp, #0x40]
1002ce9e8:     	ldp	x20, x19, [sp, #0x30]
1002ce9ec:     	ldp	x22, x21, [sp, #0x20]
1002ce9f0:     	ldp	x24, x23, [sp, #0x10]
1002ce9f4:     	ldp	x26, x25, [sp], #0x50
1002ce9f8:     	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
