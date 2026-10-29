
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a74364: 5289c428    	mov	w8, #0x4e21             ; =20001
104a74368: eb08007f    	cmp	x3, x8
104a7436c: 54000241    	b.ne	0x104a743b4 <_Flutter_MMFoundation_BindContext+0xf4ff98>
104a74370: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104a74374: a9017bfd    	stp	x29, x30, [sp, #0x10]
104a74378: 910043fd    	add	x29, sp, #0x10
104a7437c: f00dbd68    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a74380: b980d908    	ldrsw	x8, [x8, #0xd8]
104a74384: f8686813    	ldr	x19, [x0, x8]
104a74388: d00db488    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104a7438c: f9440901    	ldr	x1, [x8, #0x810] ; selector row
104a74390: aa0403e0    	mov	x0, x4
104a74394: 94c6cb6a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a74398: aa0003e2    	mov	x2, x0
104a7439c: 900da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a743a0: f9413501    	ldr	x1, [x8, #0x268] ; selector changeReadStatusAtIndex:
104a743a4: aa1303e0    	mov	x0, x19
104a743a8: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104a743ac: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104a743b0: 14c6cb63    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a743b4: d65f03c0    	ret
