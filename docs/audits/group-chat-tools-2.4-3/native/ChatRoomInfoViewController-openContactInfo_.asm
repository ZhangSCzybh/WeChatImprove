
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f99c74:     	stp	x22, x21, [sp, #-0x30]!
100f99c78:     	stp	x20, x19, [sp, #0x10]
100f99c7c:     	stp	x29, x30, [sp, #0x20]
100f99c80:     	add	x29, sp, #0x20
100f99c84:     	mov	x19, x2
100f99c88:     	mov	x20, x0
100f99c8c:     	mov	x0, x2
100f99c90:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100f99c94:     	mov	w0, #0xc9               ; =201
100f99c98:     	mov	w1, #0xb                ; =11
100f99c9c:     	mov	w2, #0x1                ; =1
100f99ca0:     	mov	w3, #0x0                ; =0
100f99ca4:     	mov	w4, #0x0                ; =0
100f99ca8:     	bl	0x1020ea20c <_Flutter_Image_provideRelativePathByUrl+0x372698>
100f99cac:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f99cb0:     	ldr	x21, [x8, #0xb88]
100f99cb4:     	adrp	x8, 0x11ed88000 <dyld_stub_binder+0x11ed88000>
100f99cb8:     	ldrsw	x8, [x8, #0xfb8]
100f99cbc:     	ldr	x22, [x20, x8]
100f99cc0:     	adrp	x8, 0x11e9ea000 <dyld_stub_binder+0x11e9ea000>
100f99cc4:     	ldr	x1, [x8, #0xb10]
100f99cc8:     	mov	x0, x20
100f99ccc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f99cd0:     	mov	x6, x0
100f99cd4:     	adrp	x8, 0x11ea16000 <dyld_stub_binder+0x11ea16000>
100f99cd8:     	ldr	x1, [x8, #0x7a8]
100f99cdc:     	mov	x0, x21
100f99ce0:     	mov	x2, x19
100f99ce4:     	mov	x3, x22
100f99ce8:     	mov	x4, x20
100f99cec:     	mov	x5, x20
100f99cf0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f99cf4:     	mov	x0, x19
100f99cf8:     	ldp	x29, x30, [sp, #0x20]
100f99cfc:     	ldp	x20, x19, [sp, #0x10]
100f99d00:     	ldp	x22, x21, [sp], #0x30
100f99d04:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
