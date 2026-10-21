
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1016a6644: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1016a6648: a9014ff4    	stp	x20, x19, [sp, #0x10]
1016a664c: a9027bfd    	stp	x29, x30, [sp, #0x20]
1016a6650: 910083fd    	add	x29, sp, #0x20
1016a6654: aa0403f6    	mov	x22, x4
1016a6658: aa0303f4    	mov	x20, x3
1016a665c: aa0203f3    	mov	x19, x2
1016a6660: aa0003f5    	mov	x21, x0
1016a6664: aa0203e0    	mov	x0, x2
1016a6668: 959602b4    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1016a666c: aa1403e0    	mov	x0, x20
1016a6670: 959602b2    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1016a6674: b4000273    	cbz	x19, 0x1016a66c0 <__text+0x169e6c0>
1016a6678: d00f5a48    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1016a667c: b9839108    	ldrsw	x8, [x8, #0x390]
1016a6680: 8b0802a0    	add	x0, x21, x8
1016a6684: aa1303e1    	mov	x1, x19
1016a6688: 959602ae    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
1016a668c: d00f5a48    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1016a6690: b9839908    	ldrsw	x8, [x8, #0x398]
1016a6694: 8b0802a0    	add	x0, x21, x8
1016a6698: aa1403e1    	mov	x1, x20
1016a669c: 959602a9    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
1016a66a0: d00f5a48    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1016a66a4: b9838d08    	ldrsw	x8, [x8, #0x38c]
1016a66a8: 38286ab6    	strb	w22, [x21, x8]
1016a66ac: b00f3f68    	adrp	x8, 0x11fe93000 <dyld_stub_binder+0x11fe93000>
1016a66b0: f946f101    	ldr	x1, [x8, #0xde0] ; updateStatus:
1016a66b4: aa1503e0    	mov	x0, x21
1016a66b8: 52800002    	mov	w2, #0x0                ; =0
1016a66bc: 959602a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a66c0: aa1403e0    	mov	x0, x20
1016a66c4: 959602a4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a66c8: aa1303e0    	mov	x0, x19
1016a66cc: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1016a66d0: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1016a66d4: a8c357f6    	ldp	x22, x21, [sp], #0x30
1016a66d8: 1596029f    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
