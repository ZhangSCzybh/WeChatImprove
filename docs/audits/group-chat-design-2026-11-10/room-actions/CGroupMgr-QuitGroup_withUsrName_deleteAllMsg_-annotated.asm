
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101d77b74 <_Flutter_Image_provideRelativePathByUrl>:
102037e90:     	stp	x24, x23, [sp, #-0x40]!
102037e94:     	stp	x22, x21, [sp, #0x10]
102037e98:     	stp	x20, x19, [sp, #0x20]
102037e9c:     	stp	x29, x30, [sp, #0x30]
102037ea0:     	add	x29, sp, #0x30
102037ea4:     	mov	x22, x4
102037ea8:     	mov	x20, x3
102037eac:     	mov	x19, x2
102037eb0:     	mov	x21, x0
102037eb4:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
102037eb8:     	ldr	x23, [x8, #0x4e0] ; selector: dicShouldDeleteAllMsgAfterQuit
102037ebc:     	mov	x0, x3
102037ec0:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
102037ec4:     	mov	x0, x19
102037ec8:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
102037ecc:     	mov	x0, x21
102037ed0:     	mov	x1, x23
102037ed4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102037ed8:     	mov	x29, x29
102037edc:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102037ee0:     	mov	x23, x0
102037ee4:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102037ee8:     	ldr	x0, [x8, #0x6c0]
102037eec:     	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
102037ef0:     	ldr	x1, [x8, #0x588] ; selector: numberWithBool:
102037ef4:     	mov	x2, x22
102037ef8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102037efc:     	mov	x29, x29
102037f00:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102037f04:     	mov	x22, x0
102037f08:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
102037f0c:     	ldr	x1, [x8, #0x350] ; selector: safeSetObject:forKey:
102037f10:     	mov	x0, x23
102037f14:     	mov	x2, x22
102037f18:     	mov	x3, x19
102037f1c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102037f20:     	mov	x0, x22
102037f24:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102037f28:     	mov	x0, x23
102037f2c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102037f30:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102037f34:     	ldr	x0, [x8, #0xbc0]
102037f38:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
102037f3c:     	ldr	x1, [x8, #0x9c8] ; selector: IsOpenIMChatRoom:
102037f40:     	mov	x2, x19
102037f44:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102037f48:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
102037f4c:     	add	x8, x8, #0x638
102037f50:     	adrp	x9, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
102037f54:     	add	x9, x9, #0x640
102037f58:     	cmp	w0, #0x0
102037f5c:     	csel	x8, x8, x9, ne
102037f60:     	ldr	x1, [x8]
102037f64:     	mov	x0, x21
102037f68:     	mov	x2, x19
102037f6c:     	mov	x3, x20
102037f70:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102037f74:     	mov	x21, x0
102037f78:     	mov	x0, x20
102037f7c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102037f80:     	mov	x0, x19
102037f84:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102037f88:     	mov	x0, x21
102037f8c:     	ldp	x29, x30, [sp, #0x30]
102037f90:     	ldp	x20, x19, [sp, #0x20]
102037f94:     	ldp	x22, x21, [sp, #0x10]
102037f98:     	ldp	x24, x23, [sp], #0x40
102037f9c:     	ret
