
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106f43944: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
106f43948: a9017bfd    	stp	x29, x30, [sp, #0x10]
106f4394c: 910043fd    	add	x29, sp, #0x10
106f43950: aa0003f3    	mov	x19, x0
106f43954: b00c85e8    	adrp	x8, 0x120000000 <dyld_stub_binder+0x120000000>
106f43958: f9447501    	ldr	x1, [x8, #0x8e8] ; contactsSelectorType
106f4395c: 94338df8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43960: b00c85e8    	adrp	x8, 0x120000000 <dyld_stub_binder+0x120000000>
106f43964: 9123c108    	add	x8, x8, #0x8f0
106f43968: b00c85e9    	adrp	x9, 0x120000000 <dyld_stub_binder+0x120000000>
106f4396c: 9123e129    	add	x9, x9, #0x8f8
106f43970: f100041f    	cmp	x0, #0x1
106f43974: 9a890108    	csel	x8, x8, x9, eq
106f43978: f9400101    	ldr	x1, [x8]
106f4397c: aa1303e0    	mov	x0, x19
106f43980: a9417bfd    	ldp	x29, x30, [sp, #0x10]
106f43984: a8c24ff4    	ldp	x20, x19, [sp], #0x20
106f43988: 14338ded    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
