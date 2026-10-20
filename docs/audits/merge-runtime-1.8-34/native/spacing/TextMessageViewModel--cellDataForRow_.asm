
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105c0b5b8: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
105c0b5bc: a9014ff4    	stp	x20, x19, [sp, #0x10]
105c0b5c0: a9027bfd    	stp	x29, x30, [sp, #0x20]
105c0b5c4: 910083fd    	add	x29, sp, #0x20
105c0b5c8: aa0203f4    	mov	x20, x2
105c0b5cc: aa0003f3    	mov	x19, x0
105c0b5d0: f00d1d88    	adrp	x8, 0x11ffbe000 <dyld_stub_binder+0x11ffbe000>
105c0b5d4: f9411101    	ldr	x1, [x8, #0x220] ; isLongSplitMessage
105c0b5d8: 94806ed9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0b5dc: 34000240    	cbz	w0, 0x105c0b624 <_Flutter_MMFoundation_BindContext+0x20e7208>
105c0b5e0: f00d11e8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
105c0b5e4: f9441101    	ldr	x1, [x8, #0x820] ; subViewModels
105c0b5e8: aa1303e0    	mov	x0, x19
105c0b5ec: 94806ed4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0b5f0: aa1d03fd    	mov	x29, x29
105c0b5f4: 94806ed5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0b5f8: aa0003f5    	mov	x21, x0
105c0b5fc: f00d1168    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105c0b600: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
105c0b604: aa1403e2    	mov	x2, x20
105c0b608: 94806ecd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0b60c: aa1d03fd    	mov	x29, x29
105c0b610: 94806ece    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0b614: aa0003f3    	mov	x19, x0
105c0b618: aa1503e0    	mov	x0, x21
105c0b61c: 94806ece    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0b620: 14000003    	b	0x105c0b62c <_Flutter_MMFoundation_BindContext+0x20e7210>
105c0b624: aa1303e0    	mov	x0, x19
105c0b628: 94806ec4    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105c0b62c: aa1303e0    	mov	x0, x19
105c0b630: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105c0b634: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105c0b638: a8c357f6    	ldp	x22, x21, [sp], #0x30
105c0b63c: 14806ecd    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>