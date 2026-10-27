
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b9f098: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104b9f09c: a9014ff4    	stp	x20, x19, [sp, #0x10]
104b9f0a0: a9027bfd    	stp	x29, x30, [sp, #0x20]
104b9f0a4: 910083fd    	add	x29, sp, #0x20
104b9f0a8: aa0203f3    	mov	x19, x2
104b9f0ac: d00e3a68    	adrp	x8, 0x1212ed000 <dyld_stub_binder+0x1212ed000>
104b9f0b0: f9409914    	ldr	x20, [x8, #0x130]
104b9f0b4: d00dab48    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104b9f0b8: f9467515    	ldr	x21, [x8, #0xce8]
104b9f0bc: aa0203e0    	mov	x0, x2
104b9f0c0: 94c2201e    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b9f0c4: aa1303e0    	mov	x0, x19
104b9f0c8: aa1503e1    	mov	x1, x21
104b9f0cc: aa1403e2    	mov	x2, x20
104b9f0d0: 94c2201b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9f0d4: 900d9f48    	adrp	x8, 0x11ff87000 <dyld_stub_binder+0x11ff87000>
104b9f0d8: f945fd02    	ldr	x2, [x8, #0xbf8]
104b9f0dc: d00dab48    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104b9f0e0: f9446501    	ldr	x1, [x8, #0x8c8]
104b9f0e4: aa1303e0    	mov	x0, x19
104b9f0e8: 94c22015    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9f0ec: 900dab28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104b9f0f0: f9431901    	ldr	x1, [x8, #0x630]
104b9f0f4: aa1303e0    	mov	x0, x19
104b9f0f8: 94c22011    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9f0fc: aa1303e0    	mov	x0, x19
104b9f100: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104b9f104: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104b9f108: a8c357f6    	ldp	x22, x21, [sp], #0x30
104b9f10c: 14c22012    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
