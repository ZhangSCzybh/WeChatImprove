
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1003907b8:     	sub	sp, sp, #0x1d0
1003907bc:     	stp	d9, d8, [sp, #0x160]
1003907c0:     	stp	x28, x27, [sp, #0x170]
1003907c4:     	stp	x26, x25, [sp, #0x180]
1003907c8:     	stp	x24, x23, [sp, #0x190]
1003907cc:     	stp	x22, x21, [sp, #0x1a0]
1003907d0:     	stp	x20, x19, [sp, #0x1b0]
1003907d4:     	stp	x29, x30, [sp, #0x1c0]
1003907d8:     	add	x29, sp, #0x1c0
1003907dc:     	mov	x23, x3
1003907e0:     	mov	x20, x2
1003907e4:     	mov	x19, x0
1003907e8:     	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1003907ec:     	ldr	x8, [x8, #0xa30]
1003907f0:     	ldr	x8, [x8]
1003907f4:     	stur	x8, [x29, #-0x70]
1003907f8:     	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
1003907fc:     	mov	w9, #0x1                ; =1
100390800:     	strb	w9, [x8, #0xc08]
100390804:     	mov	x0, x2
100390808:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10039080c:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100390810:     	ldr	x1, [x8, #0x850] ; selector: count
100390814:     	mov	x0, x20
100390818:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10039081c:     	cbz	x0, 0x1003909a4 <__text+0x3889a4>
100390820:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390824:     	ldr	x1, [x8, #0x418] ; selector: setStage:
100390828:     	mov	x0, x19
10039082c:     	mov	w2, #0x3                ; =3
100390830:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390834:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390838:     	ldr	x22, [x8, #0x428] ; selector: retryGeneration
10039083c:     	mov	x0, x19
100390840:     	mov	x1, x22
100390844:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390848:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10039084c:     	ldr	x1, [x8, #0x430] ; selector: setRetryGeneration:
100390850:     	add	x2, x0, #0x1
100390854:     	mov	x0, x19
100390858:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10039085c:     	mov	x0, x19
100390860:     	mov	x1, x22
100390864:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390868:     	mov	x26, x0
10039086c:     	movi.16b	v0, #0x0
100390870:     	stp	q0, q0, [sp, #0x90]
100390874:     	stp	q0, q0, [sp, #0xb0]
100390878:     	mov	x0, x20
10039087c:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100390880:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100390884:     	ldr	x1, [x8, #0x858] ; selector: countByEnumeratingWithState:objects:count:
100390888:     	add	x2, sp, #0x90
10039088c:     	add	x3, sp, #0xd0
100390890:     	str	x1, [sp, #0x40]
100390894:     	mov	w4, #0x10               ; =16
100390898:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10039089c:     	cbz	x0, 0x1003909b8 <__text+0x3889b8>
1003908a0:     	mov	x25, x0
1003908a4:     	stp	x26, x23, [sp, #0x30]
1003908a8:     	stp	x20, x19, [sp, #0x48]
1003908ac:     	ldr	x8, [sp, #0xa0]
1003908b0:     	ldr	x19, [x8]
1003908b4:     	mov	w23, #0x1               ; =1
1003908b8:     	mov	x20, #0x0               ; =0
1003908bc:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
1003908c0:     	ldr	x24, [x8, #0x460] ; selector: retryCountByRoomName
1003908c4:     	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
1003908c8:     	ldr	x26, [x8, #0x650] ; selector: objectForKeyedSubscript:
1003908cc:     	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1003908d0:     	ldr	x27, [x8, #0xad0] ; selector: unsignedIntegerValue
1003908d4:     	ldr	x8, [sp, #0xa0]
1003908d8:     	ldr	x8, [x8]
1003908dc:     	cmp	x8, x19
1003908e0:     	b.eq	0x1003908ec <__text+0x3888ec>
1003908e4:     	ldr	x0, [sp, #0x48]
1003908e8:     	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
1003908ec:     	ldr	x8, [sp, #0x98]
1003908f0:     	ldr	x28, [x8, x20, lsl #3]
1003908f4:     	ldr	x0, [sp, #0x50]
1003908f8:     	mov	x1, x24
1003908fc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390900:     	mov	x29, x29
100390904:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100390908:     	mov	x22, x0
10039090c:     	mov	x1, x26
100390910:     	mov	x2, x28
100390914:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390918:     	mov	x29, x29
10039091c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100390920:     	mov	x28, x0
100390924:     	mov	x1, x27
100390928:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10039092c:     	mov	x21, x0
100390930:     	mov	x0, x28
100390934:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390938:     	mov	x0, x22
10039093c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390940:     	cmp	x23, x21
100390944:     	csel	x23, x23, x21, hi
100390948:     	add	x20, x20, #0x1
10039094c:     	cmp	x25, x20
100390950:     	b.ne	0x1003908d4 <__text+0x3888d4>
100390954:     	add	x2, sp, #0x90
100390958:     	add	x3, sp, #0xd0
10039095c:     	ldp	x1, x20, [sp, #0x40]
100390960:     	mov	x0, x20
100390964:     	mov	w4, #0x10               ; =16
100390968:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10039096c:     	mov	x25, x0
100390970:     	cbnz	x0, 0x1003908b8 <__text+0x3888b8>
100390974:     	mov	x0, x20
100390978:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10039097c:     	cmp	x23, #0x2
100390980:     	fmov	d0, #4.00000000
100390984:     	fmov	d1, #2.00000000
100390988:     	fcsel	d0, d1, d0, eq
10039098c:     	cmp	x23, #0x1
100390990:     	fmov	d1, #1.00000000
100390994:     	fcsel	d0, d1, d0, eq
100390998:     	ldr	x19, [sp, #0x50]
10039099c:     	ldp	x26, x23, [sp, #0x30]
1003909a0:     	b	0x1003909cc <__text+0x3889cc>
1003909a4:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
1003909a8:     	ldr	x1, [x8, #0x490] ; selector: complete
1003909ac:     	mov	x0, x19
1003909b0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003909b4:     	b	0x100390ac4 <__text+0x388ac4>
1003909b8:     	mov	x0, x20
1003909bc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1003909c0:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
1003909c4:     	ldr	x24, [x8, #0x460] ; selector: retryCountByRoomName
1003909c8:     	fmov	d0, #1.00000000
1003909cc:     	cmp	w23, #0x0
1003909d0:     	fmov	d1, xzr
1003909d4:     	fcsel	d8, d0, d1, ne
1003909d8:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1003909dc:     	ldr	x21, [x8, #0x618]
1003909e0:     	mov	x0, x19
1003909e4:     	mov	x1, x24
1003909e8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003909ec:     	mov	x29, x29
1003909f0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1003909f4:     	mov	x22, x0
1003909f8:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1003909fc:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
100390a00:     	str	x26, [sp, #0x28]
100390a04:     	str	d8, [sp, #0x20]
100390a08:     	stp	x0, x23, [sp, #0x10]
100390a0c:     	adrp	x8, 0x11cfc6000 <dyld_stub_binder+0x11cfc6000>
100390a10:     	add	x8, x8, #0xf98 ; CFString: schedule retry, roomNames:%@ retryCountByRoomName:%@ delayed:%d delay:%.1f generation:%lu
100390a14:     	stp	x8, x20, [sp]
100390a18:     	adrp	x3, 0x119bcf000 <dyld_stub_binder+0x119bcf000>
100390a1c:     	add	x3, x3, #0xff4
100390a20:     	adrp	x5, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
100390a24:     	add	x5, x5, #0xb
100390a28:     	adrp	x7, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
100390a2c:     	add	x7, x7, #0x6ce
100390a30:     	mov	x0, x21
100390a34:     	mov	w2, #0x2                ; =2
100390a38:     	mov	w4, #0x0                ; =0
100390a3c:     	mov	w6, #0x1c0              ; =448
100390a40:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390a44:     	mov	x0, x22
100390a48:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390a4c:     	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
100390a50:     	ldr	d0, [x8, #0x6f8] ; constant double=1000000000.0
100390a54:     	fmul	d0, d8, d0
100390a58:     	fcvtzs	x1, d0
100390a5c:     	mov	x0, #0x0                ; =0
100390a60:     	bl	0x107c278fc <_Flutter_MMFoundation_BindContext+0x3eae5c8>
100390a64:     	mov	x21, x0
100390a68:     	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
100390a6c:     	ldr	x8, [x8, #0x930]
100390a70:     	str	x8, [sp, #0x58]
100390a74:     	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
100390a78:     	ldr	d0, [x8, #0x680] ; constant double=1.6080749353e-314
100390a7c:     	str	d0, [sp, #0x60]
100390a80:     	adrp	x8, 0x100390000 <__text+0x388000>
100390a84:     	add	x8, x8, #0xb0c
100390a88:     	adrp	x9, 0x11c280000 <dyld_stub_binder+0x11c280000>
100390a8c:     	add	x9, x9, #0xbe0
100390a90:     	stp	x8, x9, [sp, #0x68]
100390a94:     	str	x19, [sp, #0x78]
100390a98:     	str	x26, [sp, #0x88]
100390a9c:     	mov	x0, x20
100390aa0:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100390aa4:     	str	x20, [sp, #0x80]
100390aa8:     	adrp	x1, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
100390aac:     	ldr	x1, [x1, #0xa98]
100390ab0:     	add	x2, sp, #0x58
100390ab4:     	mov	x0, x21
100390ab8:     	bl	0x107c0cba4 <_Flutter_MMFoundation_BindContext+0x3e93870>
100390abc:     	ldr	x0, [sp, #0x80]
100390ac0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390ac4:     	mov	x0, x20
100390ac8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390acc:     	ldur	x8, [x29, #-0x70]
100390ad0:     	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
100390ad4:     	ldr	x9, [x9, #0xa30]
100390ad8:     	ldr	x9, [x9]
100390adc:     	cmp	x9, x8
100390ae0:     	b.ne	0x100390b08 <__text+0x388b08>
100390ae4:     	ldp	x29, x30, [sp, #0x1c0]
100390ae8:     	ldp	x20, x19, [sp, #0x1b0]
100390aec:     	ldp	x22, x21, [sp, #0x1a0]
100390af0:     	ldp	x24, x23, [sp, #0x190]
100390af4:     	ldp	x26, x25, [sp, #0x180]
100390af8:     	ldp	x28, x27, [sp, #0x170]
100390afc:     	ldp	d9, d8, [sp, #0x160]
100390b00:     	add	sp, sp, #0x1d0
100390b04:     	ret
100390b08:     	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
100390b0c:     	stp	x20, x19, [sp, #-0x20]!
100390b10:     	stp	x29, x30, [sp, #0x10]
100390b14:     	add	x29, sp, #0x10
100390b18:     	mov	x19, x0
100390b1c:     	ldr	x0, [x0, #0x20]
100390b20:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390b24:     	ldr	x1, [x8, #0x400] ; selector: running
100390b28:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390b2c:     	cbz	w0, 0x100390b7c <__text+0x388b7c>
100390b30:     	ldr	x0, [x19, #0x20]
100390b34:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390b38:     	ldr	x1, [x8, #0x4a0] ; selector: stage
100390b3c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390b40:     	cmp	x0, #0x3
100390b44:     	b.ne	0x100390b7c <__text+0x388b7c>
100390b48:     	ldr	x20, [x19, #0x30]
100390b4c:     	ldr	x0, [x19, #0x20]
100390b50:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390b54:     	ldr	x1, [x8, #0x428] ; selector: retryGeneration
100390b58:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390b5c:     	cmp	x20, x0
100390b60:     	b.ne	0x100390b7c <__text+0x388b7c>
100390b64:     	ldp	x0, x2, [x19, #0x20]
100390b68:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390b6c:     	ldr	x1, [x8, #0x4e0] ; selector: sendBatchWithRoomNames:
100390b70:     	ldp	x29, x30, [sp, #0x10]
100390b74:     	ldp	x20, x19, [sp], #0x20
100390b78:     	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390b7c:     	ldp	x29, x30, [sp, #0x10]
100390b80:     	ldp	x20, x19, [sp], #0x20
100390b84:     	ret
