
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10121f880:     	sub	sp, sp, #0x20
10121f884:     	stp	x29, x30, [sp, #0x10]
10121f888:     	add	x29, sp, #0x10
10121f88c:     	adrp	x8, 0x11ea22000 <dyld_stub_binder+0x11ea22000>
10121f890:     	ldr	x1, [x8, #0x658]
10121f894:     	mov	w8, #0x1                ; =1
10121f898:     	strb	w8, [sp]
10121f89c:     	mov	x3, #0x0                ; =0
10121f8a0:     	mov	x4, #0x0                ; =0
10121f8a4:     	mov	x5, #0x0                ; =0
10121f8a8:     	mov	x6, #0x0                ; =0
10121f8ac:     	mov	w7, #0x1                ; =1
10121f8b0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121f8b4:     	ldp	x29, x30, [sp, #0x10]
10121f8b8:     	add	sp, sp, #0x20
10121f8bc:     	ret
