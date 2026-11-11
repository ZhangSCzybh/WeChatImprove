
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f99848:     	stp	x28, x27, [sp, #-0x60]!
100f9984c:     	stp	x26, x25, [sp, #0x10]
100f99850:     	stp	x24, x23, [sp, #0x20]
100f99854:     	stp	x22, x21, [sp, #0x30]
100f99858:     	stp	x20, x19, [sp, #0x40]
100f9985c:     	stp	x29, x30, [sp, #0x50]
100f99860:     	add	x29, sp, #0x50
100f99864:     	mov	x19, x2
100f99868:     	mov	x20, x0
100f9986c:     	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
100f99870:     	mov	w9, #0x1                ; =1
100f99874:     	strb	w9, [x8, #0x76e]
100f99878:     	mov	x0, x2
100f9987c:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100f99880:     	adrp	x8, 0x11ed88000 <dyld_stub_binder+0x11ed88000>
100f99884:     	ldrsw	x8, [x8, #0xfb8]
100f99888:     	add	x0, x20, x8
100f9988c:     	mov	x1, x19
100f99890:     	bl	0x107c27c9c <_Flutter_MMFoundation_BindContext+0x3eae968>
100f99894:     	cbz	x19, 0x100f99a84 <__text+0xf91a84>
100f99898:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
100f9989c:     	ldr	x21, [x8, #0x9b8]
100f998a0:     	mov	x0, x19
100f998a4:     	mov	x1, x21
100f998a8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f998ac:     	mov	x29, x29
100f998b0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f998b4:     	adrp	x28, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f998b8:     	adrp	x25, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100f998bc:     	adrp	x26, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f998c0:     	adrp	x27, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100f998c4:     	adrp	x24, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100f998c8:     	cbz	x0, 0x100f99924 <__text+0xf91924>
100f998cc:     	mov	x20, x0
100f998d0:     	mov	x0, x19
100f998d4:     	mov	x1, x21
100f998d8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f998dc:     	mov	x29, x29
100f998e0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f998e4:     	mov	x21, x0
100f998e8:     	adrp	x8, 0x11ea16000 <dyld_stub_binder+0x11ea16000>
100f998ec:     	ldr	x1, [x8, #0xef0]
100f998f0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f998f4:     	mov	x22, x0
100f998f8:     	adrp	x8, 0x11ea17000 <dyld_stub_binder+0x11ea17000>
100f998fc:     	ldr	x1, [x8, #0x728]
100f99900:     	mov	x0, x19
100f99904:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f99908:     	mov	x23, x0
100f9990c:     	mov	x0, x21
100f99910:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f99914:     	mov	x0, x20
100f99918:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9991c:     	cmp	w22, w23
100f99920:     	b.hs	0x100f99984 <__text+0xf91984>
100f99924:     	ldr	x0, [x28, #0x780]
100f99928:     	ldr	x1, [x25, #0x800]
100f9992c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f99930:     	mov	x29, x29
100f99934:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f99938:     	mov	x20, x0
100f9993c:     	ldr	x0, [x26, #0xb78]
100f99940:     	ldr	x1, [x27, #0x508]
100f99944:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f99948:     	mov	x2, x0
100f9994c:     	ldr	x1, [x24, #0xa40]
100f99950:     	mov	x0, x20
100f99954:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f99958:     	mov	x29, x29
100f9995c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f99960:     	mov	x21, x0
100f99964:     	adrp	x8, 0x11ea17000 <dyld_stub_binder+0x11ea17000>
100f99968:     	ldr	x1, [x8, #0x730]
100f9996c:     	mov	x2, x19
100f99970:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f99974:     	mov	x0, x21
100f99978:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9997c:     	mov	x0, x20
100f99980:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f99984:     	adrp	x8, 0x11e9df000 <dyld_stub_binder+0x11e9df000>
100f99988:     	ldr	x21, [x8, #0xfd8]
100f9998c:     	mov	x0, x19
100f99990:     	mov	x1, x21
100f99994:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f99998:     	mov	x29, x29
100f9999c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f999a0:     	cbz	x0, 0x100f99a84 <__text+0xf91a84>
100f999a4:     	mov	x20, x0
100f999a8:     	mov	x0, x19
100f999ac:     	mov	x1, x21
100f999b0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f999b4:     	mov	x29, x29
100f999b8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f999bc:     	mov	x22, x0
100f999c0:     	adrp	x8, 0x11ea17000 <dyld_stub_binder+0x11ea17000>
100f999c4:     	ldr	x1, [x8, #0x740]
100f999c8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f999cc:     	mov	x23, x0
100f999d0:     	mov	x0, x19
100f999d4:     	mov	x1, x21
100f999d8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f999dc:     	mov	x29, x29
100f999e0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f999e4:     	mov	x21, x0
100f999e8:     	adrp	x8, 0x11ea17000 <dyld_stub_binder+0x11ea17000>
100f999ec:     	ldr	x1, [x8, #0x748]
100f999f0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f999f4:     	mov	x27, x26
100f999f8:     	mov	x26, x24
100f999fc:     	mov	x24, x0
100f99a00:     	mov	x0, x21
100f99a04:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f99a08:     	mov	x0, x22
100f99a0c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f99a10:     	mov	x0, x20
100f99a14:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f99a18:     	cmp	w23, w24
100f99a1c:     	b.hs	0x100f99a84 <__text+0xf91a84>
100f99a20:     	ldr	x0, [x28, #0x780]
100f99a24:     	ldr	x1, [x25, #0x800]
100f99a28:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f99a2c:     	mov	x29, x29
100f99a30:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f99a34:     	mov	x20, x0
100f99a38:     	ldr	x0, [x27, #0xb78]
100f99a3c:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100f99a40:     	ldr	x1, [x8, #0x508]
100f99a44:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f99a48:     	mov	x2, x0
100f99a4c:     	ldr	x1, [x26, #0xa40]
100f99a50:     	mov	x0, x20
100f99a54:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f99a58:     	mov	x29, x29
100f99a5c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f99a60:     	mov	x21, x0
100f99a64:     	adrp	x8, 0x11ea17000 <dyld_stub_binder+0x11ea17000>
100f99a68:     	ldr	x1, [x8, #0x750]
100f99a6c:     	mov	x2, x19
100f99a70:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f99a74:     	mov	x0, x21
100f99a78:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f99a7c:     	mov	x0, x20
100f99a80:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f99a84:     	mov	x0, x19
100f99a88:     	ldp	x29, x30, [sp, #0x50]
100f99a8c:     	ldp	x20, x19, [sp, #0x40]
100f99a90:     	ldp	x22, x21, [sp, #0x30]
100f99a94:     	ldp	x24, x23, [sp, #0x20]
100f99a98:     	ldp	x26, x25, [sp, #0x10]
100f99a9c:     	ldp	x28, x27, [sp], #0x60
100f99aa0:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
