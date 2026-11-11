
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101d77b74 <_Flutter_Image_provideRelativePathByUrl>:
102039cc4:     	stp	x22, x21, [sp, #-0x30]!
102039cc8:     	stp	x20, x19, [sp, #0x10]
102039ccc:     	stp	x29, x30, [sp, #0x20]
102039cd0:     	add	x29, sp, #0x20
102039cd4:     	mov	x19, x2
102039cd8:     	mov	x0, x2
102039cdc:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
102039ce0:     	adrp	x8, 0x11ea08000 <dyld_stub_binder+0x11ea08000>
102039ce4:     	ldr	x20, [x8, #0x7d0] ; selector: m_nsChatRoomMemList
102039ce8:     	mov	x0, x19
102039cec:     	mov	x1, x20
102039cf0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039cf4:     	mov	x29, x29
102039cf8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102039cfc:     	mov	x21, x0
102039d00:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
102039d04:     	ldr	x1, [x8, #0xce8] ; selector: length
102039d08:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039d0c:     	mov	x22, x0
102039d10:     	mov	x0, x21
102039d14:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102039d18:     	cbz	x22, 0x102039d60 <_Flutter_Image_provideRelativePathByUrl+0x2c21ec>
102039d1c:     	mov	x0, x19
102039d20:     	mov	x1, x20
102039d24:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039d28:     	mov	x29, x29
102039d2c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102039d30:     	mov	x21, x0
102039d34:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
102039d38:     	ldr	x1, [x8, #0x678] ; selector: componentsSeparatedByString:
102039d3c:     	adrp	x2, 0x11cfa3000 <dyld_stub_binder+0x11cfa3000>
102039d40:     	add	x2, x2, #0xef8 ; CFString: ;
102039d44:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039d48:     	mov	x29, x29
102039d4c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102039d50:     	mov	x20, x0
102039d54:     	mov	x0, x21
102039d58:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102039d5c:     	b	0x102039d64 <_Flutter_Image_provideRelativePathByUrl+0x2c21f0>
102039d60:     	mov	x20, #0x0               ; =0
102039d64:     	mov	x0, x19
102039d68:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102039d6c:     	mov	x0, x20
102039d70:     	ldp	x29, x30, [sp, #0x20]
102039d74:     	ldp	x20, x19, [sp, #0x10]
102039d78:     	ldp	x22, x21, [sp], #0x30
102039d7c:     	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
