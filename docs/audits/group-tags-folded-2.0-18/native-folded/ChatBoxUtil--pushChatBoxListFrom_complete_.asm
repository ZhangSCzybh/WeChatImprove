
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e4c35c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
100e4c360: a9014ff4    	stp	x20, x19, [sp, #0x10]
100e4c364: a9027bfd    	stp	x29, x30, [sp, #0x20]
100e4c368: 910083fd    	add	x29, sp, #0x20
100e4c36c: aa0303f3    	mov	x19, x3
100e4c370: aa0203f4    	mov	x20, x2
100e4c374: d00f9948    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
100e4c378: f9451d15    	ldr	x21, [x8, #0xa38] ; ChatBoxSessionListViewController
100e4c37c: aa0303e0    	mov	x0, x3
100e4c380: 95b76b6e    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100e4c384: aa1403e0    	mov	x0, x20
100e4c388: 95b76b6c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100e4c38c: aa1503e0    	mov	x0, x21
100e4c390: 95b76b72    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
100e4c394: aa0003f5    	mov	x21, x0
100e4c398: f00f7f68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100e4c39c: f946e101    	ldr	x1, [x8, #0xdc0] ; setHidesBottomBarWhenPushed:
100e4c3a0: 52800022    	mov	w2, #0x1                ; =1
100e4c3a4: 95b76b66    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4c3a8: 900f7fc8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
100e4c3ac: f9438901    	ldr	x1, [x8, #0x710] ; PushViewController:animated:completion:
100e4c3b0: aa1403e0    	mov	x0, x20
100e4c3b4: aa1503e2    	mov	x2, x21
100e4c3b8: 52800023    	mov	w3, #0x1                ; =1
100e4c3bc: aa1303e4    	mov	x4, x19
100e4c3c0: 95b76b5f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4c3c4: aa1303e0    	mov	x0, x19
100e4c3c8: 95b76b63    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4c3cc: aa1403e0    	mov	x0, x20
100e4c3d0: 95b76b61    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4c3d4: aa1503e0    	mov	x0, x21
100e4c3d8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100e4c3dc: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100e4c3e0: a8c357f6    	ldp	x22, x21, [sp], #0x30
100e4c3e4: 15b76b5c    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
