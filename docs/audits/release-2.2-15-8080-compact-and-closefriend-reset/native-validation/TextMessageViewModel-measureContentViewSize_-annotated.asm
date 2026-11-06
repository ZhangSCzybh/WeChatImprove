
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105f104a0: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
105f104a4: 910003fd    	mov	x29, sp
105f104a8: b00c73c8    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
105f104ac: 91244108    	add	x8, x8, #0x910
105f104b0: b9800108    	ldrsw	x8, [x8] ; ivar: CommonMessageViewModel.m_bgBubbleType offset=96
105f104b4: 52800189    	mov	w9, #0xc                ; =12
105f104b8: f8286809    	str	x9, [x0, x8]
105f104bc: d00c56e8    	adrp	x8, 0x11e9ee000 <dyld_stub_binder+0x11e9ee000>
105f104c0: f9434101    	ldr	x1, [x8, #0x680] ; selector: contentHeight
105f104c4: 94745de8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105f104c8: 4ea01c01    	mov.16b	v1, v0
105f104cc: 9e6703e0    	fmov	d0, xzr
105f104d0: a8c17bfd    	ldp	x29, x30, [sp], #0x10
105f104d4: d65f03c0    	ret
