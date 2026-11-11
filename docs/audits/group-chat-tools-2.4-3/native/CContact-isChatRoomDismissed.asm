
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101074b1c:     	stp	x20, x19, [sp, #-0x20]!
101074b20:     	stp	x29, x30, [sp, #0x10]
101074b24:     	add	x29, sp, #0x10
101074b28:     	adrp	x8, 0x11e9df000 <dyld_stub_binder+0x11e9df000>
101074b2c:     	ldr	x1, [x8, #0xfd8]
101074b30:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101074b34:     	mov	x29, x29
101074b38:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101074b3c:     	mov	x19, x0
101074b40:     	adrp	x8, 0x11ea08000 <dyld_stub_binder+0x11ea08000>
101074b44:     	ldr	x1, [x8, #0x600]
101074b48:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101074b4c:     	ubfx	w20, w0, #1, #1
101074b50:     	mov	x0, x19
101074b54:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101074b58:     	mov	x0, x20
101074b5c:     	ldp	x29, x30, [sp, #0x10]
101074b60:     	ldp	x20, x19, [sp], #0x20
101074b64:     	ret
