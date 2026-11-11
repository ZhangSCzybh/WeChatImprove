
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10121b824:     	sub	sp, sp, #0xa0
10121b828:     	stp	x28, x27, [sp, #0x40]
10121b82c:     	stp	x26, x25, [sp, #0x50]
10121b830:     	stp	x24, x23, [sp, #0x60]
10121b834:     	stp	x22, x21, [sp, #0x70]
10121b838:     	stp	x20, x19, [sp, #0x80]
10121b83c:     	stp	x29, x30, [sp, #0x90]
10121b840:     	add	x29, sp, #0x90
10121b844:     	mov	x20, x4
10121b848:     	mov	x21, x3
10121b84c:     	mov	x19, x2
10121b850:     	mov	x22, x0
10121b854:     	adrp	x8, 0x11f744000 <dyld_stub_binder+0x11f744000>
10121b858:     	mov	w9, #0x1                ; =1
10121b85c:     	strb	w9, [x8, #0x14d]
10121b860:     	mov	x0, x2
10121b864:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10121b868:     	cbz	x19, 0x10121b944 <__text+0x1213944>
10121b86c:     	cbz	w21, 0x10121b944 <__text+0x1213944>
10121b870:     	adrp	x8, 0x11ed8b000 <dyld_stub_binder+0x11ed8b000>
10121b874:     	ldrsw	x8, [x8, #0x2d4]
10121b878:     	mov	w9, #0x1                ; =1
10121b87c:     	strb	w9, [x22, x8]
10121b880:     	cmp	w21, #0x2
10121b884:     	b.le	0x10121b988 <__text+0x1213988>
10121b888:     	cmp	w21, #0x3
10121b88c:     	b.eq	0x10121ba74 <__text+0x1213a74>
10121b890:     	cmp	w21, #0x4
10121b894:     	b.eq	0x10121bad8 <__text+0x1213ad8>
10121b898:     	cmp	w21, #0x5
10121b89c:     	b.ne	0x10121be58 <__text+0x1213e58>
10121b8a0:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121b8a4:     	ldr	x0, [x8, #0xbc0]
10121b8a8:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10121b8ac:     	ldr	x1, [x8, #0xec0]
10121b8b0:     	mov	x2, x19
10121b8b4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b8b8:     	mov	x21, x0
10121b8bc:     	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121b8c0:     	ldr	x0, [x27, #0x780]
10121b8c4:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121b8c8:     	ldr	x22, [x8, #0x800]
10121b8cc:     	mov	x1, x22
10121b8d0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b8d4:     	mov	x29, x29
10121b8d8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121b8dc:     	mov	x23, x0
10121b8e0:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10121b8e4:     	ldr	x24, [x8, #0x508]
10121b8e8:     	cbz	w21, 0x10121bc70 <__text+0x1213c70>
10121b8ec:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121b8f0:     	ldr	x0, [x8, #0xb78]
10121b8f4:     	mov	x1, x24
10121b8f8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b8fc:     	mov	x2, x0
10121b900:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121b904:     	ldr	x1, [x8, #0xa40]
10121b908:     	mov	x0, x23
10121b90c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b910:     	mov	x29, x29
10121b914:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121b918:     	mov	x21, x0
10121b91c:     	adrp	x8, 0x11ea22000 <dyld_stub_binder+0x11ea22000>
10121b920:     	ldr	x1, [x8, #0x478]
10121b924:     	mov	x2, x19
10121b928:     	mov	x3, x20
10121b92c:     	mov	w4, #0x0                ; =0
10121b930:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b934:     	mov	x0, x21
10121b938:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121b93c:     	mov	x0, x23
10121b940:     	b	0x10121be54 <__text+0x1213e54>
10121b944:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121b948:     	ldr	x0, [x8, #0x618]
10121b94c:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121b950:     	ldr	x1, [x8, #0x310]
10121b954:     	adrp	x8, 0x11d05c000 <dyld_stub_binder+0x11d05c000>
10121b958:     	add	x8, x8, #0x38
10121b95c:     	str	x8, [sp]
10121b960:     	adrp	x5, 0x119d0c000 <dyld_stub_binder+0x119d0c000>
10121b964:     	add	x5, x5, #0x5ef
10121b968:     	adrp	x7, 0x119d0c000 <dyld_stub_binder+0x119d0c000>
10121b96c:     	add	x7, x7, #0x85a
10121b970:     	mov	w2, #0x4                ; =4
10121b974:     	mov	x3, #0x0                ; =0
10121b978:     	mov	w4, #0x0                ; =0
10121b97c:     	mov	w6, #0xbe               ; =190
10121b980:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b984:     	b	0x10121be58 <__text+0x1213e58>
10121b988:     	cmp	w21, #0x1
10121b98c:     	b.eq	0x10121bb58 <__text+0x1213b58>
10121b990:     	cmp	w21, #0x2
10121b994:     	b.ne	0x10121be58 <__text+0x1213e58>
10121b998:     	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121b99c:     	ldr	x0, [x27, #0x780]
10121b9a0:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121b9a4:     	ldr	x22, [x8, #0x800]
10121b9a8:     	mov	x1, x22
10121b9ac:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b9b0:     	mov	x29, x29
10121b9b4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121b9b8:     	mov	x25, x0
10121b9bc:     	adrp	x28, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121b9c0:     	ldr	x0, [x28, #0xbe8]
10121b9c4:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10121b9c8:     	ldr	x23, [x8, #0x508]
10121b9cc:     	mov	x1, x23
10121b9d0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b9d4:     	mov	x2, x0
10121b9d8:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121b9dc:     	ldr	x24, [x8, #0xa40]
10121b9e0:     	mov	x0, x25
10121b9e4:     	mov	x1, x24
10121b9e8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b9ec:     	mov	x29, x29
10121b9f0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121b9f4:     	mov	x26, x0
10121b9f8:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10121b9fc:     	ldr	x1, [x8, #0x150]
10121ba00:     	mov	x2, x19
10121ba04:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121ba08:     	mov	x29, x29
10121ba0c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121ba10:     	mov	x21, x0
10121ba14:     	mov	x0, x26
10121ba18:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121ba1c:     	mov	x0, x25
10121ba20:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121ba24:     	cbz	x21, 0x10121be10 <__text+0x1213e10>
10121ba28:     	ldr	x0, [x27, #0x780]
10121ba2c:     	mov	x1, x22
10121ba30:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121ba34:     	mov	x29, x29
10121ba38:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121ba3c:     	mov	x22, x0
10121ba40:     	ldr	x0, [x28, #0xbe8]
10121ba44:     	mov	x1, x23
10121ba48:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121ba4c:     	mov	x2, x0
10121ba50:     	mov	x0, x22
10121ba54:     	mov	x1, x24
10121ba58:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121ba5c:     	mov	x29, x29
10121ba60:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121ba64:     	mov	x23, x0
10121ba68:     	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
10121ba6c:     	ldr	x1, [x8, #0xd90]
10121ba70:     	b	0x10121bc30 <__text+0x1213c30>
10121ba74:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121ba78:     	ldr	x0, [x8, #0x780]
10121ba7c:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121ba80:     	ldr	x1, [x8, #0x800]
10121ba84:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121ba88:     	mov	x29, x29
10121ba8c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121ba90:     	mov	x21, x0
10121ba94:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121ba98:     	ldr	x0, [x8, #0xb78]
10121ba9c:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10121baa0:     	ldr	x1, [x8, #0x508]
10121baa4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121baa8:     	mov	x2, x0
10121baac:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121bab0:     	ldr	x1, [x8, #0xa40]
10121bab4:     	mov	x0, x21
10121bab8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121babc:     	mov	x29, x29
10121bac0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121bac4:     	mov	x22, x0
10121bac8:     	cbz	w20, 0x10121bc4c <__text+0x1213c4c>
10121bacc:     	adrp	x8, 0x11ea22000 <dyld_stub_binder+0x11ea22000>
10121bad0:     	ldr	x1, [x8, #0x460]
10121bad4:     	b	0x10121bc54 <__text+0x1213c54>
10121bad8:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121badc:     	ldr	x0, [x8, #0x780]
10121bae0:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121bae4:     	ldr	x1, [x8, #0x800]
10121bae8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121baec:     	mov	x29, x29
10121baf0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121baf4:     	mov	x22, x0
10121baf8:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121bafc:     	ldr	x0, [x8, #0xb78]
10121bb00:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10121bb04:     	ldr	x1, [x8, #0x508]
10121bb08:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bb0c:     	mov	x2, x0
10121bb10:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121bb14:     	ldr	x1, [x8, #0xa40]
10121bb18:     	mov	x0, x22
10121bb1c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bb20:     	mov	x29, x29
10121bb24:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121bb28:     	mov	x21, x0
10121bb2c:     	mov	x0, x22
10121bb30:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121bb34:     	cbz	x21, 0x10121be50 <__text+0x1213e50>
10121bb38:     	adrp	x8, 0x11ea22000 <dyld_stub_binder+0x11ea22000>
10121bb3c:     	ldr	x1, [x8, #0x470]
10121bb40:     	mov	x0, x21
10121bb44:     	mov	x2, x20
10121bb48:     	mov	x3, x19
10121bb4c:     	mov	w4, #0x0                ; =0
10121bb50:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bb54:     	b	0x10121be50 <__text+0x1213e50>
10121bb58:     	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121bb5c:     	ldr	x0, [x27, #0x780]
10121bb60:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121bb64:     	ldr	x22, [x8, #0x800]
10121bb68:     	mov	x1, x22
10121bb6c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bb70:     	mov	x29, x29
10121bb74:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121bb78:     	mov	x25, x0
10121bb7c:     	adrp	x28, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121bb80:     	ldr	x0, [x28, #0xbe8]
10121bb84:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10121bb88:     	ldr	x23, [x8, #0x508]
10121bb8c:     	mov	x1, x23
10121bb90:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bb94:     	mov	x2, x0
10121bb98:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121bb9c:     	ldr	x24, [x8, #0xa40]
10121bba0:     	mov	x0, x25
10121bba4:     	mov	x1, x24
10121bba8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bbac:     	mov	x29, x29
10121bbb0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121bbb4:     	mov	x26, x0
10121bbb8:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10121bbbc:     	ldr	x1, [x8, #0x150]
10121bbc0:     	mov	x2, x19
10121bbc4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bbc8:     	mov	x29, x29
10121bbcc:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121bbd0:     	mov	x21, x0
10121bbd4:     	mov	x0, x26
10121bbd8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121bbdc:     	mov	x0, x25
10121bbe0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121bbe4:     	cbz	x21, 0x10121bdd0 <__text+0x1213dd0>
10121bbe8:     	ldr	x0, [x27, #0x780]
10121bbec:     	mov	x1, x22
10121bbf0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bbf4:     	mov	x29, x29
10121bbf8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121bbfc:     	mov	x22, x0
10121bc00:     	ldr	x0, [x28, #0xbe8]
10121bc04:     	mov	x1, x23
10121bc08:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bc0c:     	mov	x2, x0
10121bc10:     	mov	x0, x22
10121bc14:     	mov	x1, x24
10121bc18:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bc1c:     	mov	x29, x29
10121bc20:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121bc24:     	mov	x23, x0
10121bc28:     	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
10121bc2c:     	ldr	x1, [x8, #0xd98]
10121bc30:     	mov	x2, x21
10121bc34:     	mov	x3, x20
10121bc38:     	mov	w4, #0x0                ; =0
10121bc3c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bc40:     	mov	x0, x23
10121bc44:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121bc48:     	b	0x10121bc64 <__text+0x1213c64>
10121bc4c:     	adrp	x8, 0x11ea22000 <dyld_stub_binder+0x11ea22000>
10121bc50:     	ldr	x1, [x8, #0x468]
10121bc54:     	mov	x0, x22
10121bc58:     	mov	x2, x19
10121bc5c:     	mov	w3, #0x0                ; =0
10121bc60:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bc64:     	mov	x0, x22
10121bc68:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121bc6c:     	b	0x10121be50 <__text+0x1213e50>
10121bc70:     	adrp	x28, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121bc74:     	ldr	x0, [x28, #0xbe8]
10121bc78:     	mov	x1, x24
10121bc7c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bc80:     	mov	x2, x0
10121bc84:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121bc88:     	ldr	x25, [x8, #0xa40]
10121bc8c:     	mov	x0, x23
10121bc90:     	mov	x1, x25
10121bc94:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bc98:     	mov	x29, x29
10121bc9c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121bca0:     	mov	x26, x0
10121bca4:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10121bca8:     	ldr	x1, [x8, #0x150]
10121bcac:     	mov	x2, x19
10121bcb0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bcb4:     	mov	x29, x29
10121bcb8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121bcbc:     	mov	x21, x0
10121bcc0:     	mov	x0, x26
10121bcc4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121bcc8:     	mov	x0, x23
10121bccc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121bcd0:     	ldr	x0, [x27, #0x780]
10121bcd4:     	mov	x1, x22
10121bcd8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bcdc:     	mov	x29, x29
10121bce0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121bce4:     	mov	x23, x0
10121bce8:     	ldr	x0, [x28, #0xbe8]
10121bcec:     	mov	x1, x24
10121bcf0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bcf4:     	mov	x2, x0
10121bcf8:     	mov	x0, x23
10121bcfc:     	mov	x1, x25
10121bd00:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bd04:     	mov	x29, x29
10121bd08:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121bd0c:     	mov	x24, x0
10121bd10:     	adrp	x8, 0x11ea22000 <dyld_stub_binder+0x11ea22000>
10121bd14:     	ldr	x1, [x8, #0x480]
10121bd18:     	mov	x2, x21
10121bd1c:     	mov	x3, x20
10121bd20:     	mov	w4, #0x0                ; =0
10121bd24:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bd28:     	mov	x25, x0
10121bd2c:     	mov	x0, x24
10121bd30:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121bd34:     	mov	x0, x23
10121bd38:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121bd3c:     	cbz	w25, 0x10121be50 <__text+0x1213e50>
10121bd40:     	ldr	x0, [x27, #0x780]
10121bd44:     	mov	x1, x22
10121bd48:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bd4c:     	mov	x29, x29
10121bd50:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121bd54:     	mov	x22, x0
10121bd58:     	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
10121bd5c:     	ldr	x23, [x8, #0x558]
10121bd60:     	adrp	x8, 0x11ea22000 <dyld_stub_binder+0x11ea22000>
10121bd64:     	ldr	x24, [x8, #0x488]
10121bd68:     	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10121bd6c:     	ldr	x8, [x8, #0x930]
10121bd70:     	str	x8, [sp, #0x10]
10121bd74:     	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
10121bd78:     	ldr	d0, [x8, #0x680]
10121bd7c:     	str	d0, [sp, #0x18]
10121bd80:     	adrp	x8, 0x10121b000 <__text+0x1213000>
10121bd84:     	add	x8, x8, #0xe80
10121bd88:     	adrp	x9, 0x11c281000 <dyld_stub_binder+0x11c281000>
10121bd8c:     	add	x9, x9, #0xae8
10121bd90:     	stp	x8, x9, [sp, #0x20]
10121bd94:     	mov	x0, x19
10121bd98:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10121bd9c:     	str	x19, [sp, #0x30]
10121bda0:     	strb	w20, [sp, #0x38]
10121bda4:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121bda8:     	ldr	x1, [x8, #0xe58]
10121bdac:     	add	x4, sp, #0x10
10121bdb0:     	mov	x0, x22
10121bdb4:     	mov	x2, x23
10121bdb8:     	mov	x3, x24
10121bdbc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121bdc0:     	mov	x0, x22
10121bdc4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121bdc8:     	ldr	x0, [sp, #0x30]
10121bdcc:     	b	0x10121bc68 <__text+0x1213c68>
10121bdd0:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121bdd4:     	ldr	x0, [x8, #0x618]
10121bdd8:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121bddc:     	ldr	x1, [x8, #0x310]
10121bde0:     	adrp	x8, 0x11d05c000 <dyld_stub_binder+0x11d05c000>
10121bde4:     	add	x8, x8, #0x58
10121bde8:     	str	x8, [sp]
10121bdec:     	adrp	x5, 0x119d0c000 <dyld_stub_binder+0x119d0c000>
10121bdf0:     	add	x5, x5, #0x5ef
10121bdf4:     	adrp	x7, 0x119d0c000 <dyld_stub_binder+0x119d0c000>
10121bdf8:     	add	x7, x7, #0x85a
10121bdfc:     	mov	w2, #0x4                ; =4
10121be00:     	mov	x3, #0x0                ; =0
10121be04:     	mov	w4, #0x0                ; =0
10121be08:     	mov	w6, #0xcb               ; =203
10121be0c:     	b	0x10121be4c <__text+0x1213e4c>
10121be10:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121be14:     	ldr	x0, [x8, #0x618]
10121be18:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121be1c:     	ldr	x1, [x8, #0x310]
10121be20:     	adrp	x8, 0x11d05c000 <dyld_stub_binder+0x11d05c000>
10121be24:     	add	x8, x8, #0x78
10121be28:     	str	x8, [sp]
10121be2c:     	adrp	x5, 0x119d0c000 <dyld_stub_binder+0x119d0c000>
10121be30:     	add	x5, x5, #0x5ef
10121be34:     	adrp	x7, 0x119d0c000 <dyld_stub_binder+0x119d0c000>
10121be38:     	add	x7, x7, #0x85a
10121be3c:     	mov	w2, #0x4                ; =4
10121be40:     	mov	x3, #0x0                ; =0
10121be44:     	mov	w4, #0x0                ; =0
10121be48:     	mov	w6, #0xd5               ; =213
10121be4c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121be50:     	mov	x0, x21
10121be54:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121be58:     	mov	x0, x19
10121be5c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121be60:     	ldp	x29, x30, [sp, #0x90]
10121be64:     	ldp	x20, x19, [sp, #0x80]
10121be68:     	ldp	x22, x21, [sp, #0x70]
10121be6c:     	ldp	x24, x23, [sp, #0x60]
10121be70:     	ldp	x26, x25, [sp, #0x50]
10121be74:     	ldp	x28, x27, [sp, #0x40]
10121be78:     	add	sp, sp, #0xa0
10121be7c:     	ret
10121be80:     	mov	x8, x1
10121be84:     	ldr	x2, [x0, #0x20]
10121be88:     	ldrb	w3, [x0, #0x28]
10121be8c:     	adrp	x9, 0x11ea22000 <dyld_stub_binder+0x11ea22000>
10121be90:     	ldr	x1, [x9, #0x488]
10121be94:     	mov	x0, x8
10121be98:     	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
