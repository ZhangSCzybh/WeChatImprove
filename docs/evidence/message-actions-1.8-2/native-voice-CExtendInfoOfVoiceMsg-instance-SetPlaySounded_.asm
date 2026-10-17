
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b9a794: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104b9a798: a9014ff4    	stp	x20, x19, [sp, #0x10]
104b9a79c: a9027bfd    	stp	x29, x30, [sp, #0x20]
104b9a7a0: 910083fd    	add	x29, sp, #0x20
104b9a7a4: aa0003f3    	mov	x19, x0
104b9a7a8: f00d9908    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
104b9a7ac: f9426514    	ldr	x20, [x8, #0x4c8] ; m_refMessageWrap
104b9a7b0: aa1403e1    	mov	x1, x20
104b9a7b4: 94c23262    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a7b8: aa1d03fd    	mov	x29, x29
104b9a7bc: 94c23263    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9a7c0: aa0003f5    	mov	x21, x0
104b9a7c4: b00d9528    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b9a7c8: f9411101    	ldr	x1, [x8, #0x220] ; m_uiDownloadStatus
104b9a7cc: 94c2325c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a7d0: aa0003f6    	mov	x22, x0
104b9a7d4: aa1303e0    	mov	x0, x19
104b9a7d8: aa1403e1    	mov	x1, x20
104b9a7dc: 94c23258    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a7e0: aa1d03fd    	mov	x29, x29
104b9a7e4: 94c23259    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9a7e8: aa0003f3    	mov	x19, x0
104b9a7ec: b00d9528    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b9a7f0: f9413901    	ldr	x1, [x8, #0x270] ; setM_uiDownloadStatus:
104b9a7f4: 321c02c2    	orr	w2, w22, #0x10
104b9a7f8: 94c23251    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a7fc: aa1303e0    	mov	x0, x19
104b9a800: 94c23255    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9a804: aa1503e0    	mov	x0, x21
104b9a808: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104b9a80c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104b9a810: a8c357f6    	ldp	x22, x21, [sp], #0x30
104b9a814: 14c23250    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
