
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002be0b4: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1002be0b8: a9017bfd    	stp	x29, x30, [sp, #0x10]
1002be0bc: 910043fd    	add	x29, sp, #0x10
1002be0c0: aa0003f3    	mov	x19, x0
1002be0c4: b00f38e8    	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
1002be0c8: f9418101    	ldr	x1, [x8, #0x300]
1002be0cc: 95e5a6e6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002be0d0: aa0003f4    	mov	x20, x0
1002be0d4: 340000a0    	cbz	w0, 0x1002be0e8 <__text+0x2b60e8>
1002be0d8: d00f3888    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
1002be0dc: f9469901    	ldr	x1, [x8, #0xd30]
1002be0e0: aa1303e0    	mov	x0, x19
1002be0e4: 95e5a6e0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002be0e8: b00f3888    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
1002be0ec: f9476101    	ldr	x1, [x8, #0xec0]
1002be0f0: aa1303e0    	mov	x0, x19
1002be0f4: aa1403e2    	mov	x2, x20
1002be0f8: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1002be0fc: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1002be100: 15e5a6d9    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
