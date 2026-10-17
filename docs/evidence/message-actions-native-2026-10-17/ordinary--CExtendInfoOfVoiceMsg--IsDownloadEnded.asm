
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b9a5d4: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104b9a5d8: a9017bfd    	stp	x29, x30, [sp, #0x10]
104b9a5dc: 910043fd    	add	x29, sp, #0x10
104b9a5e0: f00d9908    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
104b9a5e4: f9426501    	ldr	x1, [x8, #0x4c8] ; m_refMessageWrap
104b9a5e8: 94c232d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a5ec: aa1d03fd    	mov	x29, x29
104b9a5f0: 94c232d6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9a5f4: aa0003f3    	mov	x19, x0
104b9a5f8: b00d9528    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b9a5fc: f9411101    	ldr	x1, [x8, #0x220] ; m_uiDownloadStatus
104b9a600: 94c232cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a604: aa0003f4    	mov	x20, x0
104b9a608: aa1303e0    	mov	x0, x19
104b9a60c: 94c232d2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9a610: 12000280    	and	w0, w20, #0x1
104b9a614: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104b9a618: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104b9a61c: d65f03c0    	ret