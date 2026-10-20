
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1017643c8: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1017643cc: a9014ff4    	stp	x20, x19, [sp, #0x10]
1017643d0: a9027bfd    	stp	x29, x30, [sp, #0x20]
1017643d4: 910083fd    	add	x29, sp, #0x20
1017643d8: aa0203f3    	mov	x19, x2
1017643dc: aa0003f4    	mov	x20, x0
1017643e0: 900f4d08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1017643e4: f9431515    	ldr	x21, [x8, #0x628] ; markedTextRange
1017643e8: aa0203e0    	mov	x0, x2
1017643ec: 95930b53    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1017643f0: aa1303e0    	mov	x0, x19
1017643f4: aa1503e1    	mov	x1, x21
1017643f8: 95930b51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017643fc: aa1d03fd    	mov	x29, x29
101764400: 95930b52    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101764404: aa0003f5    	mov	x21, x0
101764408: f00f4d28    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10176440c: f9401501    	ldr	x1, [x8, #0x28] ; text
101764410: aa1303e0    	mov	x0, x19
101764414: 95930b4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101764418: aa1d03fd    	mov	x29, x29
10176441c: 95930b4b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101764420: aa0003f6    	mov	x22, x0
101764424: aa1303e0    	mov	x0, x19
101764428: 95930b4b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10176442c: b00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101764430: f9415501    	ldr	x1, [x8, #0x2a8] ; mmInputBoxTextChanged:text:
101764434: aa1403e0    	mov	x0, x20
101764438: aa1503e2    	mov	x2, x21
10176443c: aa1603e3    	mov	x3, x22
101764440: 95930b3f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101764444: aa1603e0    	mov	x0, x22
101764448: 95930b43    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10176444c: aa1503e0    	mov	x0, x21
101764450: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101764454: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101764458: a8c357f6    	ldp	x22, x21, [sp], #0x30
10176445c: 15930b3e    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
