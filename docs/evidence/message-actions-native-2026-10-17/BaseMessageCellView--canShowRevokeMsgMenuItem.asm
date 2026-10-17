
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002a7828: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1002a782c: a9014ff4    	stp	x20, x19, [sp, #0x10]
1002a7830: a9027bfd    	stp	x29, x30, [sp, #0x20]
1002a7834: 910083fd    	add	x29, sp, #0x20
1002a7838: aa0003f3    	mov	x19, x0
1002a783c: f00fdca8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002a7840: f9410901    	ldr	x1, [x8, #0x210] ; viewModel
1002a7844: 95e5fe3e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a7848: aa1d03fd    	mov	x29, x29
1002a784c: 95e5fe3f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a7850: aa0003f4    	mov	x20, x0
1002a7854: f00fdca8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002a7858: f9410501    	ldr	x1, [x8, #0x208] ; messageWrap
1002a785c: 95e5fe38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a7860: aa1d03fd    	mov	x29, x29
1002a7864: 95e5fe39    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a7868: aa0003f5    	mov	x21, x0
1002a786c: f00fdd08    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a7870: f9432101    	ldr	x1, [x8, #0x640] ; canShowRevokeMsgMenuItemForMessage:
1002a7874: aa1303e0    	mov	x0, x19
1002a7878: aa1503e2    	mov	x2, x21
1002a787c: 95e5fe30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a7880: aa0003f3    	mov	x19, x0
1002a7884: aa1503e0    	mov	x0, x21
1002a7888: 95e5fe33    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a788c: aa1403e0    	mov	x0, x20
1002a7890: 95e5fe31    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a7894: aa1303e0    	mov	x0, x19
1002a7898: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1002a789c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1002a78a0: a8c357f6    	ldp	x22, x21, [sp], #0x30
1002a78a4: d65f03c0    	ret