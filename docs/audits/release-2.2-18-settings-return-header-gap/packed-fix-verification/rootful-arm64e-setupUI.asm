-[CSCustomViewController setupUI]:
    4ac4:	pacibsp
    4ac8:	stp	x22, x21, [sp, #-0x30]!
    4acc:	stp	x20, x19, [sp, #0x10]
    4ad0:	stp	x29, x30, [sp, #0x20]
    4ad4:	add	x29, sp, #0x20
    4ad8:	mov	x19, x0
    4adc:	adrp	x22, _OBJC_CLASSLIST_REFERENCES_$_@PAGE
    4ae0:	ldr	x0, [x22, _OBJC_CLASSLIST_REFERENCES_$_@PAGEOFF]
    4ae4:	bl	_objc_msgSend$systemGroupedBackgroundColor
    4ae8:	mov	x29, x29
    4aec:	bl	_objc_retainAutoreleasedReturnValue
    4af0:	mov	x20, x0
    4af4:	mov	x0, x19
    4af8:	bl	_objc_msgSend$view
    4afc:	mov	x29, x29
    4b00:	bl	_objc_retainAutoreleasedReturnValue
    4b04:	mov	x21, x0
    4b08:	mov	x2, x20
    4b0c:	bl	"_objc_msgSend$setBackgroundColor:"
    4b10:	mov	x0, x21
    4b14:	bl	_objc_release
    4b18:	mov	x0, x20
    4b1c:	bl	_objc_release
    4b20:	adrp	x8, _OBJC_CLASSLIST_REFERENCES_$_.403@PAGE
    4b24:	ldr	x0, [x8, _OBJC_CLASSLIST_REFERENCES_$_.403@PAGEOFF]
    4b28:	bl	_objc_alloc
    4b2c:	mov	x20, x0
    4b30:	mov	x0, x19
    4b34:	bl	_objc_msgSend$view
    4b38:	mov	x29, x29
    4b3c:	bl	_objc_retainAutoreleasedReturnValue
    4b40:	mov	x21, x0
    4b44:	bl	_objc_msgSend$bounds
    4b48:	mov	x0, x20
    4b4c:	mov	w2, #0x2
    4b50:	bl	"_objc_msgSend$initWithFrame:style:"
    4b54:	mov	x20, x0
    4b58:	mov	x0, x19
    4b5c:	mov	x2, x20
    4b60:	bl	"_objc_msgSend$setTableView:"
    4b64:	mov	x0, x20
    4b68:	bl	_objc_release
    4b6c:	mov	x0, x21
    4b70:	bl	_objc_release
    4b74:	mov	x0, x19
    4b78:	bl	_objc_msgSend$tableView
    4b7c:	mov	x29, x29
    4b80:	bl	_objc_retainAutoreleasedReturnValue
    4b84:	mov	x20, x0
    4b88:	movi.2d	v0, #0000000000000000
    4b8c:	bl	"_objc_msgSend$setEstimatedSectionHeaderHeight:"
    4b90:	mov	x0, x20
    4b94:	bl	_objc_release
    4b98:	mov	x0, x19
    4b9c:	bl	_objc_msgSend$tableView
    4ba0:	mov	x29, x29
    4ba4:	bl	_objc_retainAutoreleasedReturnValue
    4ba8:	mov	x20, x0
    4bac:	mov	w2, #0x12
    4bb0:	bl	"_objc_msgSend$setAutoresizingMask:"
    4bb4:	mov	x0, x20
    4bb8:	bl	_objc_release
    4bbc:	ldr	x0, [x22, _OBJC_CLASSLIST_REFERENCES_$_@PAGEOFF]
    4bc0:	bl	_objc_msgSend$systemGroupedBackgroundColor
    4bc4:	mov	x29, x29
    4bc8:	bl	_objc_retainAutoreleasedReturnValue
    4bcc:	mov	x20, x0
    4bd0:	mov	x0, x19
    4bd4:	bl	_objc_msgSend$tableView
    4bd8:	mov	x29, x29
    4bdc:	bl	_objc_retainAutoreleasedReturnValue
    4be0:	mov	x21, x0
    4be4:	mov	x2, x20
    4be8:	bl	"_objc_msgSend$setBackgroundColor:"
    4bec:	mov	x0, x21
    4bf0:	bl	_objc_release
    4bf4:	mov	x0, x20
    4bf8:	bl	_objc_release
    4bfc:	mov	x0, x19
    4c00:	bl	_objc_msgSend$tableView
    4c04:	mov	x29, x29
    4c08:	bl	_objc_retainAutoreleasedReturnValue
    4c0c:	mov	x20, x0
    4c10:	mov	w2, #0x1
    4c14:	bl	"_objc_msgSend$setSeparatorStyle:"
    4c18:	mov	x0, x20
    4c1c:	bl	_objc_release
    4c20:	mov	x0, x19
    4c24:	bl	_objc_msgSend$tableView
    4c28:	mov	x29, x29
    4c2c:	bl	_objc_retainAutoreleasedReturnValue
    4c30:	mov	x20, x0
    4c34:	mov	x8, #0x404b000000000000
    4c38:	fmov	d1, x8
    4c3c:	movi.2d	v0, #0000000000000000
    4c40:	movi.2d	v2, #0000000000000000
    4c44:	movi.2d	v3, #0000000000000000
    4c48:	bl	"_objc_msgSend$setSeparatorInset:"
    4c4c:	mov	x0, x20
    4c50:	bl	_objc_release
    4c54:	mov	x0, x19
    4c58:	bl	_objc_msgSend$headerView
    4c5c:	mov	x29, x29
    4c60:	bl	_objc_retainAutoreleasedReturnValue
    4c64:	mov	x20, x0
    4c68:	mov	x0, x19
    4c6c:	bl	_objc_msgSend$tableView
    4c70:	mov	x29, x29
    4c74:	bl	_objc_retainAutoreleasedReturnValue
    4c78:	mov	x21, x0
    4c7c:	mov	x2, x20
    4c80:	bl	"_objc_msgSend$setTableHeaderView:"
    4c84:	mov	x0, x21
    4c88:	bl	_objc_release
    4c8c:	mov	x0, x20
    4c90:	bl	_objc_release
    4c94:	mov	x0, x19
    4c98:	bl	_objc_msgSend$tableView
    4c9c:	mov	x29, x29
    4ca0:	bl	_objc_retainAutoreleasedReturnValue
    4ca4:	mov	x20, x0
    4ca8:	mov	x2, x19
    4cac:	bl	"_objc_msgSend$setDelegate:"
    4cb0:	mov	x0, x20
    4cb4:	bl	_objc_release
    4cb8:	mov	x0, x19
    4cbc:	bl	_objc_msgSend$tableView
    4cc0:	mov	x29, x29
    4cc4:	bl	_objc_retainAutoreleasedReturnValue
    4cc8:	mov	x20, x0
    4ccc:	mov	x2, x19
    4cd0:	bl	"_objc_msgSend$setDataSource:"
    4cd4:	mov	x0, x20
    4cd8:	bl	_objc_release
    4cdc:	adrp	x8, _OBJC_CLASSLIST_REFERENCES_$_.12@PAGE
    4ce0:	ldr	x20, [x8, _OBJC_CLASSLIST_REFERENCES_$_.12@PAGEOFF]
    4ce4:	mov	x0, x19
    4ce8:	bl	_objc_msgSend$tableView
    4cec:	mov	x29, x29
    4cf0:	bl	_objc_retainAutoreleasedReturnValue
    4cf4:	mov	x21, x0
    4cf8:	mov	x0, x20
    4cfc:	mov	x2, x21
    4d00:	bl	"_objc_msgSend$registerToTableView:"
    4d04:	mov	x0, x21
    4d08:	bl	_objc_release
    4d0c:	mov	x0, x19
    4d10:	bl	_objc_msgSend$view
    4d14:	mov	x29, x29
    4d18:	bl	_objc_retainAutoreleasedReturnValue
    4d1c:	mov	x20, x0
    4d20:	mov	x0, x19
    4d24:	bl	_objc_msgSend$tableView
    4d28:	mov	x29, x29
    4d2c:	bl	_objc_retainAutoreleasedReturnValue
    4d30:	mov	x19, x0
    4d34:	mov	x0, x20
    4d38:	mov	x2, x19
    4d3c:	bl	"_objc_msgSend$addSubview:"
    4d40:	mov	x0, x19
    4d44:	bl	_objc_release
    4d48:	mov	x0, x20
    4d4c:	ldp	x29, x30, [sp, #0x20]
    4d50:	ldp	x20, x19, [sp, #0x10]
    4d54:	ldp	x22, x21, [sp], #0x30
    4d58:	autibsp
    4d5c:	eor	x16, x30, x30, lsl #1
    4d60:	tbz	x16, #0x3e, 0x4d68
    4d64:	brk	#0xc471
    4d68:	b	_objc_release
