
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b3f8ac: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104b3f8b0: a9014ff4    	stp	x20, x19, [sp, #0x10]
104b3f8b4: a9027bfd    	stp	x29, x30, [sp, #0x20]
104b3f8b8: 910083fd    	add	x29, sp, #0x20
104b3f8bc: aa0203f3    	mov	x19, x2
104b3f8c0: aa0003f4    	mov	x20, x0
104b3f8c4: d00d97e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104b3f8c8: f9479d15    	ldr	x21, [x8, #0xf38] ; GetChatName
104b3f8cc: aa0203e0    	mov	x0, x2
104b3f8d0: 94c39e1a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b3f8d4: aa1303e0    	mov	x0, x19
104b3f8d8: aa1503e1    	mov	x1, x21
104b3f8dc: 94c39e18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3f8e0: aa1d03fd    	mov	x29, x29
104b3f8e4: 94c39e19    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3f8e8: aa0003f5    	mov	x21, x0
104b3f8ec: 900d9828    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b3f8f0: f9464d01    	ldr	x1, [x8, #0xc98] ; AsyncOnModMsg:MsgWrap:
104b3f8f4: aa1403e0    	mov	x0, x20
104b3f8f8: aa1503e2    	mov	x2, x21
104b3f8fc: aa1303e3    	mov	x3, x19
104b3f900: 94c39e0f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3f904: aa1303e0    	mov	x0, x19
104b3f908: 94c39e13    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3f90c: aa1503e0    	mov	x0, x21
104b3f910: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104b3f914: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104b3f918: a8c357f6    	ldp	x22, x21, [sp], #0x30
104b3f91c: 14c39e0e    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
