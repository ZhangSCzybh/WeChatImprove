
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f9c9d0:     	sub	sp, sp, #0x40
100f9c9d4:     	stp	x22, x21, [sp, #0x10]
100f9c9d8:     	stp	x20, x19, [sp, #0x20]
100f9c9dc:     	stp	x29, x30, [sp, #0x30]
100f9c9e0:     	add	x29, sp, #0x30
100f9c9e4:     	mov	x8, x2
100f9c9e8:     	mov	x19, x0
100f9c9ec:     	adrp	x9, 0x11f743000 <dyld_stub_binder+0x11f743000>
100f9c9f0:     	mov	w10, #0x1               ; =1
100f9c9f4:     	strb	w10, [x9, #0x77d]
100f9c9f8:     	adrp	x9, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
100f9c9fc:     	ldr	x1, [x9, #0x538]
100f9ca00:     	adrp	x2, 0x11d044000 <dyld_stub_binder+0x11d044000>
100f9ca04:     	add	x2, x2, #0x2d8
100f9ca08:     	mov	x0, x8
100f9ca0c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9ca10:     	mov	x29, x29
100f9ca14:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9ca18:     	mov	x21, x0
100f9ca1c:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
100f9ca20:     	ldr	x1, [x8, #0x628]
100f9ca24:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9ca28:     	mov	x20, x0
100f9ca2c:     	mov	x0, x21
100f9ca30:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9ca34:     	cmp	x20, #0x3f9
100f9ca38:     	b.eq	0x100f9cb24 <__text+0xf94b24>
100f9ca3c:     	cmp	x20, #0x3f8
100f9ca40:     	b.ne	0x100f9cc00 <__text+0xf94c00>
100f9ca44:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f9ca48:     	ldr	x20, [x8, #0x638]
100f9ca4c:     	adrp	x8, 0x11ed88000 <dyld_stub_binder+0x11ed88000>
100f9ca50:     	ldrsw	x8, [x8, #0xfb8]
100f9ca54:     	ldr	x0, [x19, x8]
100f9ca58:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100f9ca5c:     	ldr	x1, [x8, #0x620]
100f9ca60:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9ca64:     	mov	x29, x29
100f9ca68:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9ca6c:     	mov	x21, x0
100f9ca70:     	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
100f9ca74:     	ldr	x1, [x8, #0x5c8]
100f9ca78:     	str	x0, [sp]
100f9ca7c:     	adrp	x2, 0x11d044000 <dyld_stub_binder+0x11d044000>
100f9ca80:     	add	x2, x2, #0x378
100f9ca84:     	mov	x0, x20
100f9ca88:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9ca8c:     	mov	x29, x29
100f9ca90:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9ca94:     	mov	x20, x0
100f9ca98:     	mov	x0, x21
100f9ca9c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9caa0:     	mov	w0, #0x38d9             ; =14553
100f9caa4:     	mov	x1, x20
100f9caa8:     	mov	w2, #0x0                ; =0
100f9caac:     	mov	w3, #0x0                ; =0
100f9cab0:     	bl	0x10241a0cc <_Flutter_Image_provideRelativePathByUrl+0x6a2558>
100f9cab4:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f9cab8:     	ldr	x0, [x8, #0x618]
100f9cabc:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100f9cac0:     	ldr	x1, [x8, #0x310]
100f9cac4:     	adrp	x8, 0x11cfa1000 <dyld_stub_binder+0x11cfa1000>
100f9cac8:     	add	x8, x8, #0x638
100f9cacc:     	str	x8, [sp]
100f9cad0:     	adrp	x3, 0x119b96000 <dyld_stub_binder+0x119b96000>
100f9cad4:     	add	x3, x3, #0xc6c
100f9cad8:     	adrp	x5, 0x119ce6000 <dyld_stub_binder+0x119ce6000>
100f9cadc:     	add	x5, x5, #0x900
100f9cae0:     	adrp	x7, 0x119ce7000 <dyld_stub_binder+0x119ce7000>
100f9cae4:     	add	x7, x7, #0x4ce
100f9cae8:     	mov	w2, #0x2                ; =2
100f9caec:     	mov	w4, #0x0                ; =0
100f9caf0:     	mov	w6, #0x8ff              ; =2303
100f9caf4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9caf8:     	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
100f9cafc:     	ldrsw	x8, [x8, #0x48]
100f9cb00:     	add	x0, x19, x8
100f9cb04:     	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
100f9cb08:     	mov	x19, x0
100f9cb0c:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100f9cb10:     	ldr	x1, [x8, #0xe70]
100f9cb14:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9cb18:     	mov	x0, x19
100f9cb1c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9cb20:     	b	0x100f9cbe8 <__text+0xf94be8>
100f9cb24:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f9cb28:     	ldr	x20, [x8, #0x638]
100f9cb2c:     	adrp	x8, 0x11ed88000 <dyld_stub_binder+0x11ed88000>
100f9cb30:     	ldrsw	x8, [x8, #0xfb8]
100f9cb34:     	ldr	x0, [x19, x8]
100f9cb38:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100f9cb3c:     	ldr	x1, [x8, #0x620]
100f9cb40:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9cb44:     	mov	x29, x29
100f9cb48:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9cb4c:     	mov	x21, x0
100f9cb50:     	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
100f9cb54:     	ldr	x1, [x8, #0x5c8]
100f9cb58:     	str	x0, [sp]
100f9cb5c:     	adrp	x2, 0x11d044000 <dyld_stub_binder+0x11d044000>
100f9cb60:     	add	x2, x2, #0x398
100f9cb64:     	mov	x0, x20
100f9cb68:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9cb6c:     	mov	x29, x29
100f9cb70:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9cb74:     	mov	x20, x0
100f9cb78:     	mov	x0, x21
100f9cb7c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9cb80:     	mov	w0, #0x38d9             ; =14553
100f9cb84:     	mov	x1, x20
100f9cb88:     	mov	w2, #0x0                ; =0
100f9cb8c:     	mov	w3, #0x0                ; =0
100f9cb90:     	bl	0x10241a0cc <_Flutter_Image_provideRelativePathByUrl+0x6a2558>
100f9cb94:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f9cb98:     	ldr	x0, [x8, #0x618]
100f9cb9c:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100f9cba0:     	ldr	x1, [x8, #0x310]
100f9cba4:     	adrp	x8, 0x11d044000 <dyld_stub_binder+0x11d044000>
100f9cba8:     	add	x8, x8, #0x3b8
100f9cbac:     	str	x8, [sp]
100f9cbb0:     	adrp	x3, 0x119b96000 <dyld_stub_binder+0x119b96000>
100f9cbb4:     	add	x3, x3, #0xc6c
100f9cbb8:     	adrp	x5, 0x119ce6000 <dyld_stub_binder+0x119ce6000>
100f9cbbc:     	add	x5, x5, #0x900
100f9cbc0:     	adrp	x7, 0x119ce7000 <dyld_stub_binder+0x119ce7000>
100f9cbc4:     	add	x7, x7, #0x4ce
100f9cbc8:     	mov	w2, #0x2                ; =2
100f9cbcc:     	mov	w4, #0x0                ; =0
100f9cbd0:     	mov	w6, #0x907              ; =2311
100f9cbd4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9cbd8:     	adrp	x8, 0x11ea17000 <dyld_stub_binder+0x11ea17000>
100f9cbdc:     	ldr	x1, [x8, #0x7c0]
100f9cbe0:     	mov	x0, x19
100f9cbe4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9cbe8:     	mov	x0, x20
100f9cbec:     	ldp	x29, x30, [sp, #0x30]
100f9cbf0:     	ldp	x20, x19, [sp, #0x20]
100f9cbf4:     	ldp	x22, x21, [sp, #0x10]
100f9cbf8:     	add	sp, sp, #0x40
100f9cbfc:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9cc00:     	ldp	x29, x30, [sp, #0x30]
100f9cc04:     	ldp	x20, x19, [sp, #0x20]
100f9cc08:     	ldp	x22, x21, [sp, #0x10]
100f9cc0c:     	add	sp, sp, #0x40
100f9cc10:     	ret
