
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101066e50: f9400400    	ldr	x0, [x0, #0x8]
101066e54: b4000140    	cbz	x0, 0x101066e7c <__text+0x105ee7c>
101066e58: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
101066e5c: 910003fd    	mov	x29, sp
101066e60: d00ee208    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
101066e64: f9467501    	ldr	x1, [x8, #0xce8] ; selector length
101066e68: 95af037f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101066e6c: a8c17bfd    	ldp	x29, x30, [sp], #0x10
101066e70: b4000060    	cbz	x0, 0x101066e7c <__text+0x105ee7c>
101066e74: 52800020    	mov	w0, #0x1                ; =1
101066e78: d65f03c0    	ret
101066e7c: 52800000    	mov	w0, #0x0                ; =0
101066e80: d65f03c0    	ret
