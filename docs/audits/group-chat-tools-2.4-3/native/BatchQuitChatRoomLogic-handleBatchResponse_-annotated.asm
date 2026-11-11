
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10038f914:     	stp	x28, x27, [sp, #-0x60]!
10038f918:     	stp	x26, x25, [sp, #0x10]
10038f91c:     	stp	x24, x23, [sp, #0x20]
10038f920:     	stp	x22, x21, [sp, #0x30]
10038f924:     	stp	x20, x19, [sp, #0x40]
10038f928:     	stp	x29, x30, [sp, #0x50]
10038f92c:     	add	x29, sp, #0x50
10038f930:     	sub	sp, sp, #0x2a0
10038f934:     	mov	x19, x2
10038f938:     	mov	x20, x0
10038f93c:     	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10038f940:     	ldr	x8, [x8, #0xa30]
10038f944:     	ldr	x8, [x8]
10038f948:     	stur	x8, [x29, #-0x60]
10038f94c:     	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
10038f950:     	mov	w9, #0x1                ; =1
10038f954:     	strb	w9, [x8, #0xc05]
10038f958:     	mov	x0, x2
10038f95c:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10038f960:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038f964:     	ldr	x21, [x8, #0x400] ; selector: running
10038f968:     	mov	x0, x20
10038f96c:     	mov	x1, x21
10038f970:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f974:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038f978:     	ldr	x22, [x8, #0x4a0] ; selector: stage
10038f97c:     	cbz	w0, 0x10038fba4 <__text+0x387ba4>
10038f980:     	mov	x0, x20
10038f984:     	mov	x1, x22
10038f988:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f98c:     	cmp	x0, #0x2
10038f990:     	b.ne	0x10038fba4 <__text+0x387ba4>
10038f994:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038f998:     	ldr	x1, [x8, #0x4b0] ; selector: activeRequestRoomNames
10038f99c:     	mov	x0, x20
10038f9a0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f9a4:     	mov	x29, x29
10038f9a8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038f9ac:     	mov	x21, x0
10038f9b0:     	adrp	x8, 0x11d74e000 <dyld_stub_binder+0x11d74e000>
10038f9b4:     	ldr	x8, [x8, #0xa10]
10038f9b8:     	ldr	x2, [x8]
10038f9bc:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038f9c0:     	ldr	x1, [x8, #0x470] ; selector: setActiveRequestRoomNames:
10038f9c4:     	mov	x0, x20
10038f9c8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f9cc:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10038f9d0:     	ldr	x1, [x8, #0x870] ; selector: m_pbResponse
10038f9d4:     	mov	x0, x19
10038f9d8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f9dc:     	mov	x29, x29
10038f9e0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038f9e4:     	mov	x22, x0
10038f9e8:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10038f9ec:     	ldr	x1, [x8, #0x480] ; selector: baseResponse
10038f9f0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f9f4:     	mov	x29, x29
10038f9f8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038f9fc:     	mov	x25, x0
10038fa00:     	stp	x22, x0, [sp, #0x40]
10038fa04:     	cbz	x22, 0x10038fc10 <__text+0x387c10>
10038fa08:     	cbz	x25, 0x10038fc10 <__text+0x387c10>
10038fa0c:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10038fa10:     	ldr	x1, [x8, #0x488] ; selector: ret
10038fa14:     	mov	x0, x25
10038fa18:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fa1c:     	mov	x26, x0
10038fa20:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038fa24:     	mov	x24, x22
10038fa28:     	ldr	x23, [x8, #0x618]
10038fa2c:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10038fa30:     	ldr	x27, [x8, #0x938] ; selector: errMsg
10038fa34:     	mov	x0, x25
10038fa38:     	mov	x1, x27
10038fa3c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fa40:     	mov	x29, x29
10038fa44:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038fa48:     	mov	x28, x0
10038fa4c:     	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
10038fa50:     	ldr	x25, [x8, #0x520] ; selector: string
10038fa54:     	mov	x1, x25
10038fa58:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fa5c:     	mov	x29, x29
10038fa60:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038fa64:     	mov	x22, x0
10038fa68:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038fa6c:     	ldr	x1, [x8, #0x508] ; selector: resultList
10038fa70:     	mov	x0, x24
10038fa74:     	str	x1, [sp, #0x38]
10038fa78:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fa7c:     	mov	x29, x29
10038fa80:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038fa84:     	mov	x24, x0
10038fa88:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10038fa8c:     	ldr	x1, [x8, #0x850] ; selector: count
10038fa90:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fa94:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10038fa98:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10038fa9c:     	stp	x22, x0, [sp, #0x18]
10038faa0:     	stp	x21, x26, [sp, #0x8]
10038faa4:     	adrp	x8, 0x11cfc6000 <dyld_stub_binder+0x11cfc6000>
10038faa8:     	add	x8, x8, #0xf18 ; CFString: handle batch response, requestedRoomNames:%@ ret:%d errMsg:%@ resultCount:%lu
10038faac:     	str	x8, [sp]
10038fab0:     	adrp	x3, 0x119bcf000 <dyld_stub_binder+0x119bcf000>
10038fab4:     	add	x3, x3, #0xff4
10038fab8:     	adrp	x5, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038fabc:     	add	x5, x5, #0xb
10038fac0:     	adrp	x7, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038fac4:     	add	x7, x7, #0x45f
10038fac8:     	mov	x0, x23
10038facc:     	mov	w2, #0x2                ; =2
10038fad0:     	mov	w4, #0x0                ; =0
10038fad4:     	mov	w6, #0x156              ; =342
10038fad8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fadc:     	mov	x0, x24
10038fae0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038fae4:     	mov	x0, x22
10038fae8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038faec:     	mov	x0, x28
10038faf0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038faf4:     	cbz	w26, 0x10038fb00 <__text+0x387b00>
10038faf8:     	cmn	w26, #0xdb5
10038fafc:     	b.ne	0x10038fd74 <__text+0x387d74>
10038fb00:     	ldr	x28, [sp, #0x48]
10038fb04:     	mov	x0, x28
10038fb08:     	mov	x1, x27
10038fb0c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fb10:     	mov	x29, x29
10038fb14:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038fb18:     	mov	x22, x0
10038fb1c:     	mov	x1, x25
10038fb20:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fb24:     	mov	x29, x29
10038fb28:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038fb2c:     	mov	x24, x0
10038fb30:     	mov	x0, x22
10038fb34:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038fb38:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
10038fb3c:     	ldr	x1, [x8, #0xce8] ; selector: length
10038fb40:     	mov	x0, x24
10038fb44:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fb48:     	cbz	x0, 0x10038fb60 <__text+0x387b60>
10038fb4c:     	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
10038fb50:     	ldr	x1, [x8, #0x3a8] ; selector: setErrorMessage:
10038fb54:     	mov	x0, x20
10038fb58:     	mov	x2, x24
10038fb5c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fb60:     	ldp	x1, x23, [sp, #0x38]
10038fb64:     	mov	x0, x23
10038fb68:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fb6c:     	mov	x29, x29
10038fb70:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038fb74:     	mov	x22, x0
10038fb78:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038fb7c:     	ldr	x1, [x8, #0x510] ; selector: handleResultList:requestedRoomNames:
10038fb80:     	mov	x0, x20
10038fb84:     	mov	x2, x22
10038fb88:     	mov	x3, x21
10038fb8c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fb90:     	mov	x0, x22
10038fb94:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038fb98:     	mov	x0, x24
10038fb9c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038fba0:     	b	0x10038ffc4 <__text+0x387fc4>
10038fba4:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038fba8:     	ldr	x23, [x8, #0x618]
10038fbac:     	mov	x0, x20
10038fbb0:     	mov	x1, x21
10038fbb4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fbb8:     	mov	x21, x0
10038fbbc:     	mov	x0, x20
10038fbc0:     	mov	x1, x22
10038fbc4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fbc8:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10038fbcc:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10038fbd0:     	stp	x21, x0, [sp, #0x8]
10038fbd4:     	adrp	x8, 0x11cfc6000 <dyld_stub_binder+0x11cfc6000>
10038fbd8:     	add	x8, x8, #0xed8 ; CFString: ignore batch response, running:%d stage:%lu
10038fbdc:     	str	x8, [sp]
10038fbe0:     	adrp	x3, 0x119bcf000 <dyld_stub_binder+0x119bcf000>
10038fbe4:     	add	x3, x3, #0xff4
10038fbe8:     	adrp	x5, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038fbec:     	add	x5, x5, #0xb
10038fbf0:     	adrp	x7, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038fbf4:     	add	x7, x7, #0x45f
10038fbf8:     	mov	x0, x23
10038fbfc:     	mov	w2, #0x3                ; =3
10038fc00:     	mov	w4, #0x0                ; =0
10038fc04:     	mov	w6, #0x139              ; =313
10038fc08:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fc0c:     	b	0x10038ffdc <__text+0x387fdc>
10038fc10:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038fc14:     	ldr	x24, [x8, #0x618]
10038fc18:     	cmp	x22, #0x0
10038fc1c:     	cset	w22, ne
10038fc20:     	cmp	x25, #0x0
10038fc24:     	cset	w23, ne
10038fc28:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038fc2c:     	ldr	x1, [x8, #0x4f8] ; selector: stn_errType
10038fc30:     	mov	x0, x19
10038fc34:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fc38:     	mov	x25, x0
10038fc3c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038fc40:     	ldr	x1, [x8, #0x500] ; selector: stn_errCode
10038fc44:     	mov	x0, x19
10038fc48:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fc4c:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10038fc50:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10038fc54:     	stp	x25, x0, [sp, #0x20]
10038fc58:     	stp	x22, x23, [sp, #0x10]
10038fc5c:     	adrp	x8, 0x11cfc6000 <dyld_stub_binder+0x11cfc6000>
10038fc60:     	add	x8, x8, #0xef8 ; CFString: invalid batch response, requestedRoomNames:%@ responseExists:%d baseResponseExists:%d stnErrType:%d stnErrCode:%d
10038fc64:     	stp	x8, x21, [sp]
10038fc68:     	adrp	x3, 0x119bcf000 <dyld_stub_binder+0x119bcf000>
10038fc6c:     	add	x3, x3, #0xff4
10038fc70:     	adrp	x5, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038fc74:     	add	x5, x5, #0xb
10038fc78:     	adrp	x7, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038fc7c:     	add	x7, x7, #0x45f
10038fc80:     	mov	x0, x24
10038fc84:     	mov	w2, #0x3                ; =3
10038fc88:     	mov	w4, #0x0                ; =0
10038fc8c:     	mov	w6, #0x148              ; =328
10038fc90:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fc94:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038fc98:     	ldr	x1, [x8, #0x438] ; selector: setHasNetworkError:
10038fc9c:     	mov	x0, x20
10038fca0:     	mov	w2, #0x1                ; =1
10038fca4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fca8:     	movi.16b	v0, #0x0
10038fcac:     	stp	q0, q0, [sp, #0xf0]
10038fcb0:     	stp	q0, q0, [sp, #0xd0]
10038fcb4:     	mov	x0, x21
10038fcb8:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10038fcbc:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10038fcc0:     	ldr	x24, [x8, #0x858] ; selector: countByEnumeratingWithState:objects:count:
10038fcc4:     	add	x2, sp, #0xd0
10038fcc8:     	sub	x3, x29, #0xe0
10038fccc:     	mov	x1, x24
10038fcd0:     	mov	w4, #0x10               ; =16
10038fcd4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fcd8:     	cbz	x0, 0x10038fd58 <__text+0x387d58>
10038fcdc:     	mov	x26, x0
10038fce0:     	ldr	x8, [sp, #0xe0]
10038fce4:     	ldr	x22, [x8]
10038fce8:     	adrp	x23, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038fcec:     	adrp	x25, 0x11cf9b000 <dyld_stub_binder+0x11cf9b000>
10038fcf0:     	add	x25, x25, #0xe58 ; CFString: 
10038fcf4:     	mov	x28, #0x0               ; =0
10038fcf8:     	ldr	x27, [x23, #0x480] ; selector: recordFailureForRoom:errorMessage:
10038fcfc:     	ldr	x8, [sp, #0xe0]
10038fd00:     	ldr	x8, [x8]
10038fd04:     	cmp	x8, x22
10038fd08:     	b.eq	0x10038fd14 <__text+0x387d14>
10038fd0c:     	mov	x0, x21
10038fd10:     	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
10038fd14:     	ldr	x8, [sp, #0xd8]
10038fd18:     	ldr	x2, [x8, x28, lsl #3]
10038fd1c:     	mov	x0, x20
10038fd20:     	mov	x1, x27
10038fd24:     	mov	x3, x25
10038fd28:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fd2c:     	add	x28, x28, #0x1
10038fd30:     	cmp	x26, x28
10038fd34:     	b.ne	0x10038fcfc <__text+0x387cfc>
10038fd38:     	add	x2, sp, #0xd0
10038fd3c:     	sub	x3, x29, #0xe0
10038fd40:     	mov	x0, x21
10038fd44:     	mov	x1, x24
10038fd48:     	mov	w4, #0x10               ; =16
10038fd4c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fd50:     	mov	x26, x0
10038fd54:     	cbnz	x0, 0x10038fcf4 <__text+0x387cf4>
10038fd58:     	mov	x0, x21
10038fd5c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038fd60:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038fd64:     	ldr	x1, [x8, #0x490] ; selector: complete
10038fd68:     	mov	x0, x20
10038fd6c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fd70:     	b	0x10038ffc0 <__text+0x387fc0>
10038fd74:     	cmn	w26, #0xf0
10038fd78:     	b.eq	0x10038fd84 <__text+0x387d84>
10038fd7c:     	cmn	w26, #0xdb4
10038fd80:     	b.ne	0x10038fe84 <__text+0x387e84>
10038fd84:     	str	x26, [sp, #0x38]
10038fd88:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038fd8c:     	ldr	x0, [x8, #0x658]
10038fd90:     	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
10038fd94:     	ldr	x1, [x8, #0xd88] ; selector: array
10038fd98:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fd9c:     	mov	x29, x29
10038fda0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038fda4:     	mov	x25, x0
10038fda8:     	movi.16b	v0, #0x0
10038fdac:     	stp	q0, q0, [sp, #0x90]
10038fdb0:     	stp	q0, q0, [sp, #0xb0]
10038fdb4:     	mov	x0, x21
10038fdb8:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10038fdbc:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10038fdc0:     	ldr	x26, [x8, #0x858] ; selector: countByEnumeratingWithState:objects:count:
10038fdc4:     	add	x2, sp, #0x90
10038fdc8:     	add	x3, sp, #0x190
10038fdcc:     	mov	x1, x26
10038fdd0:     	mov	w4, #0x10               ; =16
10038fdd4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fdd8:     	cbz	x0, 0x10038fe50 <__text+0x387e50>
10038fddc:     	mov	x27, x0
10038fde0:     	ldr	x8, [sp, #0xa0]
10038fde4:     	ldr	x22, [x8]
10038fde8:     	adrp	x23, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038fdec:     	mov	x24, #0x0               ; =0
10038fdf0:     	ldr	x28, [x23, #0x518] ; selector: enqueueRetryForRoom:intoRoomNames:
10038fdf4:     	ldr	x8, [sp, #0xa0]
10038fdf8:     	ldr	x8, [x8]
10038fdfc:     	cmp	x8, x22
10038fe00:     	b.eq	0x10038fe0c <__text+0x387e0c>
10038fe04:     	mov	x0, x21
10038fe08:     	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
10038fe0c:     	ldr	x8, [sp, #0x98]
10038fe10:     	ldr	x2, [x8, x24, lsl #3]
10038fe14:     	mov	x0, x20
10038fe18:     	mov	x1, x28
10038fe1c:     	mov	x3, x25
10038fe20:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fe24:     	add	x24, x24, #0x1
10038fe28:     	cmp	x27, x24
10038fe2c:     	b.ne	0x10038fdf4 <__text+0x387df4>
10038fe30:     	add	x2, sp, #0x90
10038fe34:     	add	x3, sp, #0x190
10038fe38:     	mov	x0, x21
10038fe3c:     	mov	x1, x26
10038fe40:     	mov	w4, #0x10               ; =16
10038fe44:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fe48:     	mov	x27, x0
10038fe4c:     	cbnz	x0, 0x10038fdec <__text+0x387dec>
10038fe50:     	ldr	x8, [sp, #0x38]
10038fe54:     	cmn	w8, #0xf0
10038fe58:     	cset	w22, eq
10038fe5c:     	mov	x0, x21
10038fe60:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038fe64:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038fe68:     	ldr	x1, [x8, #0x520] ; selector: scheduleRetryForRoomNames:delayed:
10038fe6c:     	mov	x0, x20
10038fe70:     	mov	x2, x25
10038fe74:     	mov	x3, x22
10038fe78:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fe7c:     	mov	x0, x25
10038fe80:     	b	0x10038ffbc <__text+0x387fbc>
10038fe84:     	ldr	x0, [sp, #0x48]
10038fe88:     	mov	x1, x27
10038fe8c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fe90:     	mov	x29, x29
10038fe94:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038fe98:     	mov	x22, x0
10038fe9c:     	mov	x1, x25
10038fea0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fea4:     	mov	x29, x29
10038fea8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038feac:     	mov	x23, x0
10038feb0:     	mov	x0, x22
10038feb4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038feb8:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
10038febc:     	ldr	x1, [x8, #0xce8] ; selector: length
10038fec0:     	mov	x0, x23
10038fec4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fec8:     	cbz	x0, 0x10038fee0 <__text+0x387ee0>
10038fecc:     	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
10038fed0:     	ldr	x1, [x8, #0x3a8] ; selector: setErrorMessage:
10038fed4:     	mov	x0, x20
10038fed8:     	mov	x2, x23
10038fedc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038fee0:     	str	x23, [sp, #0x38]
10038fee4:     	movi.16b	v0, #0x0
10038fee8:     	stp	q0, q0, [sp, #0x70]
10038feec:     	stp	q0, q0, [sp, #0x50]
10038fef0:     	mov	x0, x21
10038fef4:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10038fef8:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10038fefc:     	ldr	x25, [x8, #0x858] ; selector: countByEnumeratingWithState:objects:count:
10038ff00:     	add	x2, sp, #0x50
10038ff04:     	add	x3, sp, #0x110
10038ff08:     	mov	x1, x25
10038ff0c:     	mov	w4, #0x10               ; =16
10038ff10:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ff14:     	cbz	x0, 0x10038ffa0 <__text+0x387fa0>
10038ff18:     	mov	x27, x0
10038ff1c:     	ldr	x8, [sp, #0x60]
10038ff20:     	ldr	x22, [x8]
10038ff24:     	adrp	x8, 0x11cf9b000 <dyld_stub_binder+0x11cf9b000>
10038ff28:     	add	x8, x8, #0xe58 ; CFString: 
10038ff2c:     	ldr	x9, [sp, #0x38]
10038ff30:     	cmp	x9, #0x0
10038ff34:     	csel	x26, x8, x9, eq
10038ff38:     	adrp	x23, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038ff3c:     	mov	x24, #0x0               ; =0
10038ff40:     	ldr	x28, [x23, #0x480] ; selector: recordFailureForRoom:errorMessage:
10038ff44:     	ldr	x8, [sp, #0x60]
10038ff48:     	ldr	x8, [x8]
10038ff4c:     	cmp	x8, x22
10038ff50:     	b.eq	0x10038ff5c <__text+0x387f5c>
10038ff54:     	mov	x0, x21
10038ff58:     	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
10038ff5c:     	ldr	x8, [sp, #0x58]
10038ff60:     	ldr	x2, [x8, x24, lsl #3]
10038ff64:     	mov	x0, x20
10038ff68:     	mov	x1, x28
10038ff6c:     	mov	x3, x26
10038ff70:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ff74:     	add	x24, x24, #0x1
10038ff78:     	cmp	x27, x24
10038ff7c:     	b.ne	0x10038ff44 <__text+0x387f44>
10038ff80:     	add	x2, sp, #0x50
10038ff84:     	add	x3, sp, #0x110
10038ff88:     	mov	x0, x21
10038ff8c:     	mov	x1, x25
10038ff90:     	mov	w4, #0x10               ; =16
10038ff94:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ff98:     	mov	x27, x0
10038ff9c:     	cbnz	x0, 0x10038ff3c <__text+0x387f3c>
10038ffa0:     	mov	x0, x21
10038ffa4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038ffa8:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038ffac:     	ldr	x1, [x8, #0x490] ; selector: complete
10038ffb0:     	mov	x0, x20
10038ffb4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ffb8:     	ldr	x0, [sp, #0x38]
10038ffbc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038ffc0:     	ldp	x23, x28, [sp, #0x40]
10038ffc4:     	mov	x0, x28
10038ffc8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038ffcc:     	mov	x0, x23
10038ffd0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038ffd4:     	mov	x0, x21
10038ffd8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038ffdc:     	mov	x0, x19
10038ffe0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038ffe4:     	ldur	x8, [x29, #-0x60]
10038ffe8:     	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10038ffec:     	ldr	x9, [x9, #0xa30]
10038fff0:     	ldr	x9, [x9]
10038fff4:     	cmp	x9, x8
10038fff8:     	b.ne	0x10039001c <__text+0x38801c>
10038fffc:     	add	sp, sp, #0x2a0
100390000:     	ldp	x29, x30, [sp, #0x50]
100390004:     	ldp	x20, x19, [sp, #0x40]
100390008:     	ldp	x22, x21, [sp, #0x30]
10039000c:     	ldp	x24, x23, [sp, #0x20]
100390010:     	ldp	x26, x25, [sp, #0x10]
100390014:     	ldp	x28, x27, [sp], #0x60
100390018:     	ret
10039001c:     	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
