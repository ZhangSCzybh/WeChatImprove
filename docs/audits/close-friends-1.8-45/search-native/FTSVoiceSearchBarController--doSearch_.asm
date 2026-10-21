
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10182a3b0: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10182a3b4: a9014ff4    	stp	x20, x19, [sp, #0x10]
10182a3b8: a9027bfd    	stp	x29, x30, [sp, #0x20]
10182a3bc: 910083fd    	add	x29, sp, #0x20
10182a3c0: aa0203f3    	mov	x19, x2
10182a3c4: aa0003f4    	mov	x20, x0
10182a3c8: f9402015    	ldr	x21, [x0, #0x40]
10182a3cc: f900201f    	str	xzr, [x0, #0x40]
10182a3d0: aa0203e0    	mov	x0, x2
10182a3d4: 958ff359    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10182a3d8: aa1503e0    	mov	x0, x21
10182a3dc: 958ff35e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a3e0: b00f3408    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10182a3e4: f9459501    	ldr	x1, [x8, #0xb28] ; cancelFTSSearch
10182a3e8: aa1403e0    	mov	x0, x20
10182a3ec: 958ff354    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a3f0: f00f33e8    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
10182a3f4: f9414901    	ldr	x1, [x8, #0x290] ; handleTextDidChange:
10182a3f8: aa1403e0    	mov	x0, x20
10182a3fc: aa1303e2    	mov	x2, x19
10182a400: 958ff34f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a404: aa1303e0    	mov	x0, x19
10182a408: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10182a40c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10182a410: a8c357f6    	ldp	x22, x21, [sp], #0x30
10182a414: 158ff350    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
