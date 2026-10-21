/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ea48b8: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104ea48bc: a9017bfd    	stp	x29, x30, [sp, #0x10]
104ea48c0: 910043fd    	add	x29, sp, #0x10
104ea48c4: aa0103f3    	mov	x19, x1
104ea48c8: aa0003f4    	mov	x20, x0
104ea48cc: aa0103e0    	mov	x0, x1
104ea48d0: 94b60a1a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104ea48d4: 91008280    	add	x0, x20, #0x20
104ea48d8: 94b60a2d    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104ea48dc: aa0003f4    	mov	x20, x0
104ea48e0: b40000c0    	cbz	x0, 0x104ea48f8 <_Flutter_MMFoundation_BindContext+0x13804dc>
104ea48e4: d00d7d88    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
104ea48e8: f942b901    	ldr	x1, [x8, #0x570]
104ea48ec: aa1403e0    	mov	x0, x20
104ea48f0: aa1303e2    	mov	x2, x19
104ea48f4: 94b60a12    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea48f8: aa1403e0    	mov	x0, x20
104ea48fc: 94b60a16    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea4900: aa1303e0    	mov	x0, x19
104ea4904: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104ea4908: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104ea490c: 14b60a12    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
