
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b9a620: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104b9a624: a9014ff4    	stp	x20, x19, [sp, #0x10]
104b9a628: a9027bfd    	stp	x29, x30, [sp, #0x20]
104b9a62c: 910083fd    	add	x29, sp, #0x20
104b9a630: aa0003f3    	mov	x19, x0
104b9a634: f00d9908    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
104b9a638: f9426514    	ldr	x20, [x8, #0x4c8] ; m_refMessageWrap
104b9a63c: aa1403e1    	mov	x1, x20
104b9a640: 94c232bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a644: aa1d03fd    	mov	x29, x29
104b9a648: 94c232c0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9a64c: aa0003f5    	mov	x21, x0
104b9a650: b00d9528    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b9a654: f9411101    	ldr	x1, [x8, #0x220] ; m_uiDownloadStatus
104b9a658: 94c232b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a65c: aa0003f6    	mov	x22, x0
104b9a660: aa1303e0    	mov	x0, x19
104b9a664: aa1403e1    	mov	x1, x20
104b9a668: 94c232b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a66c: aa1d03fd    	mov	x29, x29
104b9a670: 94c232b6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9a674: aa0003f3    	mov	x19, x0
104b9a678: b00d9528    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b9a67c: f9413901    	ldr	x1, [x8, #0x270] ; setM_uiDownloadStatus:
104b9a680: 321e02c2    	orr	w2, w22, #0x4
104b9a684: 94c232ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a688: aa1303e0    	mov	x0, x19
104b9a68c: 94c232b2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9a690: aa1503e0    	mov	x0, x21
104b9a694: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104b9a698: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104b9a69c: a8c357f6    	ldp	x22, x21, [sp], #0x30
104b9a6a0: 14c232ad    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
