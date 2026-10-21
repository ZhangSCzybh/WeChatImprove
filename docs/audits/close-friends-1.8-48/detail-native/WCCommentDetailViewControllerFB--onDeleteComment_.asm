
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106ea80a4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
106ea80a8: a9014ff4    	stp	x20, x19, [sp, #0x10]
106ea80ac: a9027bfd    	stp	x29, x30, [sp, #0x20]
106ea80b0: 910083fd    	add	x29, sp, #0x20
106ea80b4: aa0203f3    	mov	x19, x2
106ea80b8: aa0003f4    	mov	x20, x0
106ea80bc: d00c8aa8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106ea80c0: f9452515    	ldr	x21, [x8, #0xa48] ; reportMenuAction:isComment:
106ea80c4: aa0203e0    	mov	x0, x2
106ea80c8: 9435fc1c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106ea80cc: aa1403e0    	mov	x0, x20
106ea80d0: aa1503e1    	mov	x1, x21
106ea80d4: 52800122    	mov	w2, #0x9                ; =9
106ea80d8: 52800023    	mov	w3, #0x1                ; =1
106ea80dc: 9435fc18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea80e0: 900c7cc8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
106ea80e4: f9463501    	ldr	x1, [x8, #0xc68] ; onDelete:
106ea80e8: aa1403e0    	mov	x0, x20
106ea80ec: aa1303e2    	mov	x2, x19
106ea80f0: 9435fc13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea80f4: aa1303e0    	mov	x0, x19
106ea80f8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
106ea80fc: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106ea8100: a8c357f6    	ldp	x22, x21, [sp], #0x30
106ea8104: 1435fc14    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
