
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
104e51b60:     	stp	x20, x19, [sp, #-0x20]!
104e51b64:     	stp	x29, x30, [sp, #0x10]
104e51b68:     	add	x29, sp, #0x10
104e51b6c:     	mov	x19, x2
104e51b70:     	mov	x20, x0
104e51b74:     	adrp	x8, 0x11edc6000 <dyld_stub_binder+0x11edc6000>
104e51b78:     	ldrsw	x8, [x8, #0x70]
104e51b7c:     	add	x0, x0, x8
104e51b80:     	mov	x1, x2
104e51b84:     	bl	0x107c27c9c <_Flutter_MMFoundation_BindContext+0x3eae968>
104e51b88:     	mov	x0, x19
104e51b8c:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
104e51b90:     	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
104e51b94:     	ldr	x1, [x8, #0xe18]
104e51b98:     	mov	x0, x20
104e51b9c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e51ba0:     	mov	x0, x19
104e51ba4:     	ldp	x29, x30, [sp, #0x10]
104e51ba8:     	ldp	x20, x19, [sp], #0x20
104e51bac:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
