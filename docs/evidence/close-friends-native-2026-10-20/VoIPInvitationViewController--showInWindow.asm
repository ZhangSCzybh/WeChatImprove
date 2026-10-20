
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106127c1c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
106127c20: a9014ff4    	stp	x20, x19, [sp, #0x10]
106127c24: a9027bfd    	stp	x29, x30, [sp, #0x20]
106127c28: 910083fd    	add	x29, sp, #0x20
106127c2c: aa0003f3    	mov	x19, x0
106127c30: 900d0368    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
106127c34: f942e100    	ldr	x0, [x8, #0x5c0] ; H ;
106127c38: 946bfd48    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
106127c3c: aa0003f4    	mov	x20, x0
106127c40: f00d0268    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
106127c44: f940a500    	ldr	x0, [x8, #0x148]
106127c48: 900ceac8    	adrp	x8, 0x11fe7f000 <dyld_stub_binder+0x11fe7f000>
106127c4c: f9457d01    	ldr	x1, [x8, #0xaf8] ; mainWindowScene
106127c50: 946bfd3b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106127c54: aa1d03fd    	mov	x29, x29
106127c58: 946bfd3c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106127c5c: aa0003f5    	mov	x21, x0
106127c60: b00ceaa8    	adrp	x8, 0x11fe7c000 <dyld_stub_binder+0x11fe7c000>
106127c64: f9442901    	ldr	x1, [x8, #0x850] ; setWindowScene:
106127c68: aa1403e0    	mov	x0, x20
106127c6c: aa1503e2    	mov	x2, x21
106127c70: 946bfd33    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106127c74: aa1503e0    	mov	x0, x21
106127c78: 946bfd37    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106127c7c: 900cff08    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
106127c80: f9451501    	ldr	x1, [x8, #0xa28] ; setDelegate:
106127c84: aa1403e0    	mov	x0, x20
106127c88: aa1303e2    	mov	x2, x19
106127c8c: 946bfd2c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106127c90: f00cea48    	adrp	x8, 0x11fe72000 <dyld_stub_binder+0x11fe72000>
106127c94: f945f101    	ldr	x1, [x8, #0xbe0] ; showWithAnimated:inWindow:showEndEditing:
106127c98: aa1303e0    	mov	x0, x19
106127c9c: 52800082    	mov	w2, #0x4                ; =4
106127ca0: aa1403e3    	mov	x3, x20
106127ca4: 52800004    	mov	w4, #0x0                ; =0
106127ca8: 946bfd25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106127cac: aa1403e0    	mov	x0, x20
106127cb0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
106127cb4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106127cb8: a8c357f6    	ldp	x22, x21, [sp], #0x30
106127cbc: 146bfd26    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
