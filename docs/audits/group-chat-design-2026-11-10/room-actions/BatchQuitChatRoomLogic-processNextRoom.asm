
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10038e808:     	sub	sp, sp, #0xc0
10038e80c:     	stp	x28, x27, [sp, #0x60]
10038e810:     	stp	x26, x25, [sp, #0x70]
10038e814:     	stp	x24, x23, [sp, #0x80]
10038e818:     	stp	x22, x21, [sp, #0x90]
10038e81c:     	stp	x20, x19, [sp, #0xa0]
10038e820:     	stp	x29, x30, [sp, #0xb0]
10038e824:     	add	x29, sp, #0xb0
10038e828:     	mov	x19, x0
10038e82c:     	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
10038e830:     	mov	w9, #0x1                ; =1
10038e834:     	strb	w9, [x8, #0xc01]
10038e838:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038e83c:     	ldr	x1, [x8, #0x400]
10038e840:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e844:     	cbz	w0, 0x10038ec18 <__text+0x386c18>
10038e848:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038e84c:     	ldr	x21, [x8, #0x440]
10038e850:     	mov	x0, x19
10038e854:     	mov	x1, x21
10038e858:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e85c:     	mov	x29, x29
10038e860:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038e864:     	mov	x20, x0
10038e868:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10038e86c:     	ldr	x1, [x8, #0x850]
10038e870:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e874:     	mov	x22, x0
10038e878:     	mov	x0, x20
10038e87c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038e880:     	cbz	x22, 0x10038eaa4 <__text+0x386aa4>
10038e884:     	mov	x0, x19
10038e888:     	mov	x1, x21
10038e88c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e890:     	mov	x29, x29
10038e894:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038e898:     	mov	x22, x0
10038e89c:     	adrp	x8, 0x11eca7000 <dyld_stub_binder+0x11eca7000>
10038e8a0:     	ldr	x1, [x8, #0x598]
10038e8a4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e8a8:     	mov	x29, x29
10038e8ac:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038e8b0:     	mov	x20, x0
10038e8b4:     	mov	x0, x22
10038e8b8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038e8bc:     	mov	x0, x19
10038e8c0:     	mov	x1, x21
10038e8c4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e8c8:     	mov	x29, x29
10038e8cc:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038e8d0:     	mov	x21, x0
10038e8d4:     	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
10038e8d8:     	ldr	x1, [x8, #0x4d0]
10038e8dc:     	mov	x2, #0x0                ; =0
10038e8e0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e8e4:     	mov	x0, x21
10038e8e8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038e8ec:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038e8f0:     	ldr	x1, [x8, #0x420]
10038e8f4:     	mov	x0, x19
10038e8f8:     	str	x1, [sp, #0x30]
10038e8fc:     	mov	x2, x20
10038e900:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e904:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038e908:     	ldr	x1, [x8, #0x418]
10038e90c:     	mov	x0, x19
10038e910:     	mov	w2, #0x1                ; =1
10038e914:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e918:     	adrp	x21, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038e91c:     	ldr	x0, [x21, #0x780]
10038e920:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10038e924:     	ldr	x23, [x8, #0x800]
10038e928:     	mov	x1, x23
10038e92c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e930:     	mov	x29, x29
10038e934:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038e938:     	mov	x24, x0
10038e93c:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038e940:     	ldr	x0, [x8, #0xbe8]
10038e944:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10038e948:     	ldr	x25, [x8, #0x508]
10038e94c:     	mov	x1, x25
10038e950:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e954:     	mov	x2, x0
10038e958:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10038e95c:     	ldr	x26, [x8, #0xa40]
10038e960:     	mov	x0, x24
10038e964:     	mov	x1, x26
10038e968:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e96c:     	mov	x29, x29
10038e970:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038e974:     	mov	x27, x0
10038e978:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10038e97c:     	ldr	x1, [x8, #0x150]
10038e980:     	mov	x2, x20
10038e984:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e988:     	mov	x29, x29
10038e98c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038e990:     	mov	x22, x0
10038e994:     	mov	x0, x27
10038e998:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038e99c:     	mov	x0, x24
10038e9a0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038e9a4:     	ldr	x0, [x21, #0x780]
10038e9a8:     	mov	x1, x23
10038e9ac:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e9b0:     	mov	x29, x29
10038e9b4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038e9b8:     	mov	x24, x0
10038e9bc:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038e9c0:     	ldr	x0, [x8, #0xb78]
10038e9c4:     	mov	x1, x25
10038e9c8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e9cc:     	mov	x2, x0
10038e9d0:     	mov	x0, x24
10038e9d4:     	mov	x1, x26
10038e9d8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038e9dc:     	mov	x29, x29
10038e9e0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038e9e4:     	mov	x23, x0
10038e9e8:     	mov	x0, x24
10038e9ec:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038e9f0:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038e9f4:     	ldr	x0, [x8, #0x9d0]
10038e9f8:     	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
10038e9fc:     	ldr	x1, [x8, #0x120]
10038ea00:     	mov	w2, #0x0                ; =0
10038ea04:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ea08:     	mov	x29, x29
10038ea0c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038ea10:     	mov	x24, x0
10038ea14:     	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038ea18:     	ldr	x0, [x27, #0xac0]
10038ea1c:     	mov	x1, x25
10038ea20:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ea24:     	mov	x2, x0
10038ea28:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
10038ea2c:     	ldr	x1, [x8, #0x890]
10038ea30:     	mov	x0, x22
10038ea34:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ea38:     	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10038ea3c:     	ldr	x25, [x8, #0xbc8]
10038ea40:     	adrp	x28, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
10038ea44:     	tbz	w0, #0x0, 0x10038ead0 <__text+0x386ad0>
10038ea48:     	ldr	x0, [x27, #0xac0]
10038ea4c:     	mov	x1, x25
10038ea50:     	mov	x2, x22
10038ea54:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ea58:     	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
10038ea5c:     	ldr	x26, [x8, #0x438]
10038ea60:     	cbz	w0, 0x10038ead8 <__text+0x386ad8>
10038ea64:     	mov	x0, x22
10038ea68:     	mov	x1, x26
10038ea6c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ea70:     	tbnz	w0, #0x0, 0x10038ead8 <__text+0x386ad8>
10038ea74:     	ldr	x1, [x28, #0xb98]
10038ea78:     	mov	x0, x23
10038ea7c:     	mov	x2, x20
10038ea80:     	mov	x3, x24
10038ea84:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ea88:     	tbz	w0, #0x0, 0x10038ead8 <__text+0x386ad8>
10038ea8c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038ea90:     	ldr	x1, [x8, #0x4c8]
10038ea94:     	mov	x0, x19
10038ea98:     	mov	x2, x20
10038ea9c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038eaa0:     	b	0x10038ebf8 <__text+0x386bf8>
10038eaa4:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038eaa8:     	ldr	x1, [x8, #0x4c0]
10038eaac:     	mov	x0, x19
10038eab0:     	ldp	x29, x30, [sp, #0xb0]
10038eab4:     	ldp	x20, x19, [sp, #0xa0]
10038eab8:     	ldp	x22, x21, [sp, #0x90]
10038eabc:     	ldp	x24, x23, [sp, #0x80]
10038eac0:     	ldp	x26, x25, [sp, #0x70]
10038eac4:     	ldp	x28, x27, [sp, #0x60]
10038eac8:     	add	sp, sp, #0xc0
10038eacc:     	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ead0:     	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
10038ead4:     	ldr	x26, [x8, #0x438]
10038ead8:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038eadc:     	mov	x9, x27
10038eae0:     	ldr	x27, [x8, #0x618]
10038eae4:     	cmp	x22, #0x0
10038eae8:     	cset	w21, ne
10038eaec:     	ldr	x0, [x9, #0xac0]
10038eaf0:     	mov	x1, x25
10038eaf4:     	mov	x2, x22
10038eaf8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038eafc:     	mov	x25, x0
10038eb00:     	mov	x0, x22
10038eb04:     	mov	x1, x26
10038eb08:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038eb0c:     	mov	x26, x0
10038eb10:     	ldr	x1, [x28, #0xb98]
10038eb14:     	mov	x0, x23
10038eb18:     	mov	x2, x20
10038eb1c:     	mov	x3, x24
10038eb20:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038eb24:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10038eb28:     	ldr	x1, [x8, #0x310]
10038eb2c:     	stp	x26, x0, [sp, #0x20]
10038eb30:     	stp	x21, x25, [sp, #0x10]
10038eb34:     	adrp	x8, 0x11cfc6000 <dyld_stub_binder+0x11cfc6000>
10038eb38:     	add	x8, x8, #0xdf8
10038eb3c:     	stp	x8, x20, [sp]
10038eb40:     	adrp	x3, 0x119bcf000 <dyld_stub_binder+0x119bcf000>
10038eb44:     	add	x3, x3, #0xff4
10038eb48:     	adrp	x5, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038eb4c:     	add	x5, x5, #0xb
10038eb50:     	adrp	x7, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038eb54:     	add	x7, x7, #0x212
10038eb58:     	mov	x0, x27
10038eb5c:     	mov	w2, #0x3                ; =3
10038eb60:     	mov	w4, #0x0                ; =0
10038eb64:     	mov	w6, #0xca               ; =202
10038eb68:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038eb6c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038eb70:     	ldr	x1, [x8, #0x478]
10038eb74:     	mov	x0, x19
10038eb78:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038eb7c:     	mov	x29, x29
10038eb80:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038eb84:     	mov	x25, x0
10038eb88:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038eb8c:     	ldr	x1, [x8, #0x480]
10038eb90:     	mov	x0, x19
10038eb94:     	mov	x2, x20
10038eb98:     	mov	x3, x25
10038eb9c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038eba0:     	mov	x0, x25
10038eba4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038eba8:     	mov	x0, x19
10038ebac:     	ldr	x1, [sp, #0x30]
10038ebb0:     	mov	x2, #0x0                ; =0
10038ebb4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ebb8:     	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10038ebbc:     	ldr	x8, [x8, #0x930]
10038ebc0:     	str	x8, [sp, #0x38]
10038ebc4:     	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
10038ebc8:     	ldr	d0, [x8, #0x680]
10038ebcc:     	adrp	x8, 0x10038e000 <__text+0x386000>
10038ebd0:     	add	x8, x8, #0xc38
10038ebd4:     	str	d0, [sp, #0x40]
10038ebd8:     	adrp	x9, 0x11c280000 <dyld_stub_binder+0x11c280000>
10038ebdc:     	add	x9, x9, #0x470
10038ebe0:     	stp	x8, x9, [sp, #0x48]
10038ebe4:     	str	x19, [sp, #0x58]
10038ebe8:     	adrp	x0, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10038ebec:     	ldr	x0, [x0, #0xa98]
10038ebf0:     	add	x1, sp, #0x38
10038ebf4:     	bl	0x107c0cb9c <_Flutter_MMFoundation_BindContext+0x3e93868>
10038ebf8:     	mov	x0, x24
10038ebfc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038ec00:     	mov	x0, x23
10038ec04:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038ec08:     	mov	x0, x22
10038ec0c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038ec10:     	mov	x0, x20
10038ec14:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038ec18:     	ldp	x29, x30, [sp, #0xb0]
10038ec1c:     	ldp	x20, x19, [sp, #0xa0]
10038ec20:     	ldp	x22, x21, [sp, #0x90]
10038ec24:     	ldp	x24, x23, [sp, #0x80]
10038ec28:     	ldp	x26, x25, [sp, #0x70]
10038ec2c:     	ldp	x28, x27, [sp, #0x60]
10038ec30:     	add	sp, sp, #0xc0
10038ec34:     	ret
10038ec38:     	ldr	x0, [x0, #0x20]
10038ec3c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038ec40:     	ldr	x1, [x8, #0x498]
10038ec44:     	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
