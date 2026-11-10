
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002bdcc0: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1002bdcc4: a9017bfd    	stp	x29, x30, [sp, #0x10]
1002bdcc8: 910043fd    	add	x29, sp, #0x10
1002bdccc: aa0003f3    	mov	x19, x0
1002bdcd0: b00f5608    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
1002bdcd4: b98b8108    	ldrsw	x8, [x8, #0xb80]
1002bdcd8: 52800029    	mov	w9, #0x1                ; =1
1002bdcdc: 38286809    	strb	w9, [x0, x8]
1002bdce0: b00f5608    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
1002bdce4: b98b6908    	ldrsw	x8, [x8, #0xb68]
1002bdce8: f8686800    	ldr	x0, [x0, x8]
1002bdcec: 900f4f48    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
1002bdcf0: f9464101    	ldr	x1, [x8, #0xc80]
1002bdcf4: 95e5a7dc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bdcf8: aa1d03fd    	mov	x29, x29
1002bdcfc: 95e5a7e1    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002bdd00: aa0003f4    	mov	x20, x0
1002bdd04: b00f5608    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
1002bdd08: b98b6d08    	ldrsw	x8, [x8, #0xb6c]
1002bdd0c: f8686a62    	ldr	x2, [x19, x8]
1002bdd10: f00f4f48    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1002bdd14: f9475501    	ldr	x1, [x8, #0xea8]
1002bdd18: 95e5a7d3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bdd1c: d00f38e8    	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
1002bdd20: f941b901    	ldr	x1, [x8, #0x370]
1002bdd24: aa1303e0    	mov	x0, x19
1002bdd28: 95e5a7cf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bdd2c: aa1403e0    	mov	x0, x20
1002bdd30: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1002bdd34: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1002bdd38: 15e5a7ce    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
