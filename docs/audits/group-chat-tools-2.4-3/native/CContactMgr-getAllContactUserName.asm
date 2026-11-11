
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010c6f2c:     	stp	x20, x19, [sp, #-0x20]!
1010c6f30:     	stp	x29, x30, [sp, #0x10]
1010c6f34:     	add	x29, sp, #0x10
1010c6f38:     	mov	x19, x0
1010c6f3c:     	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1010c6f40:     	ldr	x0, [x8, #0x260]
1010c6f44:     	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
1010c6f48:     	mov	x20, x0
1010c6f4c:     	adrp	x8, 0x11ea08000 <dyld_stub_binder+0x11ea08000>
1010c6f50:     	ldr	x1, [x8, #0x9c8]
1010c6f54:     	mov	x0, x19
1010c6f58:     	mov	x2, x20
1010c6f5c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010c6f60:     	mov	x0, x20
1010c6f64:     	ldp	x29, x30, [sp, #0x10]
1010c6f68:     	ldp	x20, x19, [sp], #0x20
1010c6f6c:     	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
