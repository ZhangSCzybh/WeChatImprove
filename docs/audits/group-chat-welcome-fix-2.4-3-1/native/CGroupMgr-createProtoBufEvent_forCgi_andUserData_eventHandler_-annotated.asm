
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101d77b74 <_Flutter_Image_provideRelativePathByUrl>:
102040bac:     	sub	sp, sp, #0x50
102040bb0:     	stp	x24, x23, [sp, #0x10]
102040bb4:     	stp	x22, x21, [sp, #0x20]
102040bb8:     	stp	x20, x19, [sp, #0x30]
102040bbc:     	stp	x29, x30, [sp, #0x40]
102040bc0:     	add	x29, sp, #0x40
102040bc4:     	mov	x22, x5
102040bc8:     	mov	x19, x4
102040bcc:     	mov	x23, x3
102040bd0:     	mov	x24, x2
102040bd4:     	mov	x21, x0
102040bd8:     	adrp	x8, 0x11f747000 <dyld_stub_binder+0x11f747000>
102040bdc:     	mov	w9, #0x1                ; =1
102040be0:     	strb	w9, [x8, #0x59e]
102040be4:     	mov	x0, x4
102040be8:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
102040bec:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102040bf0:     	ldr	x20, [x8, #0xaf0]
102040bf4:     	mov	x0, x24
102040bf8:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
102040bfc:     	mov	x0, x20
102040c00:     	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
102040c04:     	mov	x20, x0
102040c08:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
102040c0c:     	ldr	x1, [x8, #0x840] ; selector: setM_pbRequest:
102040c10:     	mov	x2, x24
102040c14:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040c18:     	mov	x0, x24
102040c1c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102040c20:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
102040c24:     	ldr	x1, [x8, #0x848] ; selector: setM_uiCgi:
102040c28:     	mov	x0, x20
102040c2c:     	mov	x2, x23
102040c30:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040c34:     	cbz	x19, 0x102040c4c <_Flutter_Image_provideRelativePathByUrl+0x2c90d8>
102040c38:     	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
102040c3c:     	ldr	x1, [x8, #0xd0] ; selector: setM_oUserData:
102040c40:     	mov	x0, x20
102040c44:     	mov	x2, x19
102040c48:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040c4c:     	cbz	x22, 0x102040c64 <_Flutter_Image_provideRelativePathByUrl+0x2c90f0>
102040c50:     	adrp	x8, 0x11ea1c000 <dyld_stub_binder+0x11ea1c000>
102040c54:     	ldr	x1, [x8, #0x4c8] ; selector: setM_eventHandlerClass:
102040c58:     	mov	x0, x20
102040c5c:     	mov	x2, x22
102040c60:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040c64:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102040c68:     	ldr	x0, [x8, #0x780]
102040c6c:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
102040c70:     	ldr	x1, [x8, #0x800] ; selector: currentContext
102040c74:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040c78:     	mov	x29, x29
102040c7c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102040c80:     	mov	x23, x0
102040c84:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102040c88:     	ldr	x0, [x8, #0xaf8]
102040c8c:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
102040c90:     	ldr	x1, [x8, #0x508] ; selector: class
102040c94:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040c98:     	mov	x2, x0
102040c9c:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
102040ca0:     	ldr	x1, [x8, #0xa40] ; selector: getService:
102040ca4:     	mov	x0, x23
102040ca8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040cac:     	mov	x29, x29
102040cb0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102040cb4:     	mov	x24, x0
102040cb8:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
102040cbc:     	ldr	x1, [x8, #0x850] ; selector: CreateProtobufEvent:Flag:
102040cc0:     	mov	x2, x20
102040cc4:     	mov	w3, #0x5                ; =5
102040cc8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040ccc:     	mov	x22, x0
102040cd0:     	mov	x0, x24
102040cd4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102040cd8:     	mov	x0, x23
102040cdc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102040ce0:     	cbz	w22, 0x102040d04 <_Flutter_Image_provideRelativePathByUrl+0x2c9190>
102040ce4:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102040ce8:     	ldr	x0, [x8, #0x840]
102040cec:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
102040cf0:     	ldr	x1, [x8, #0x858] ; selector: addPBEventObserverListItem:andValue:
102040cf4:     	mov	x2, x22
102040cf8:     	mov	x3, x21
102040cfc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040d00:     	b	0x102040d44 <_Flutter_Image_provideRelativePathByUrl+0x2c91d0>
102040d04:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102040d08:     	ldr	x0, [x8, #0x618]
102040d0c:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
102040d10:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
102040d14:     	adrp	x8, 0x11d045000 <dyld_stub_binder+0x11d045000>
102040d18:     	add	x8, x8, #0x1b8 ; CFString: CreateProtobufEvent failed
102040d1c:     	str	x8, [sp]
102040d20:     	adrp	x5, 0x119e19000 <dyld_stub_binder+0x119e19000>
102040d24:     	add	x5, x5, #0x24a
102040d28:     	adrp	x7, 0x119e19000 <dyld_stub_binder+0x119e19000>
102040d2c:     	add	x7, x7, #0xdcf
102040d30:     	mov	w2, #0x3                ; =3
102040d34:     	mov	x3, #0x0                ; =0
102040d38:     	mov	w4, #0x0                ; =0
102040d3c:     	mov	w6, #0x58b              ; =1419
102040d40:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040d44:     	mov	x0, x20
102040d48:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102040d4c:     	mov	x0, x19
102040d50:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102040d54:     	mov	x0, x22
102040d58:     	ldp	x29, x30, [sp, #0x40]
102040d5c:     	ldp	x20, x19, [sp, #0x30]
102040d60:     	ldp	x22, x21, [sp, #0x20]
102040d64:     	ldp	x24, x23, [sp, #0x10]
102040d68:     	add	sp, sp, #0x50
102040d6c:     	ret
