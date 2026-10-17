
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b9a6a4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104b9a6a8: a9014ff4    	stp	x20, x19, [sp, #0x10]
104b9a6ac: a9027bfd    	stp	x29, x30, [sp, #0x20]
104b9a6b0: 910083fd    	add	x29, sp, #0x20
104b9a6b4: aa0003f4    	mov	x20, x0
104b9a6b8: f00d9908    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
104b9a6bc: f9426515    	ldr	x21, [x8, #0x4c8] ; m_refMessageWrap
104b9a6c0: aa1503e1    	mov	x1, x21
104b9a6c4: 94c2329e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a6c8: aa1d03fd    	mov	x29, x29
104b9a6cc: 94c2329f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9a6d0: aa0003f3    	mov	x19, x0
104b9a6d4: b00d9528    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b9a6d8: f9411101    	ldr	x1, [x8, #0x220] ; m_uiDownloadStatus
104b9a6dc: 94c23298    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a6e0: 37180240    	tbnz	w0, #0x3, 0x104b9a728 <_Flutter_MMFoundation_BindContext+0x107630c>
104b9a6e4: d00daec8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b9a6e8: f9411d16    	ldr	x22, [x8, #0x238]
104b9a6ec: aa1403e0    	mov	x0, x20
104b9a6f0: aa1503e1    	mov	x1, x21
104b9a6f4: 94c23292    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a6f8: aa1d03fd    	mov	x29, x29
104b9a6fc: 94c23293    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9a700: aa0003f5    	mov	x21, x0
104b9a704: f00d9508    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104b9a708: f9478d01    	ldr	x1, [x8, #0xf18] ; isSenderFromMsgWrap:
104b9a70c: aa1603e0    	mov	x0, x22
104b9a710: aa1503e2    	mov	x2, x21
104b9a714: 94c2328a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a718: aa0003f4    	mov	x20, x0
104b9a71c: aa1503e0    	mov	x0, x21
104b9a720: 94c2328d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9a724: 14000002    	b	0x104b9a72c <_Flutter_MMFoundation_BindContext+0x1076310>
104b9a728: 52800014    	mov	w20, #0x0               ; =0
104b9a72c: aa1303e0    	mov	x0, x19
104b9a730: 94c23289    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9a734: aa1403e0    	mov	x0, x20
104b9a738: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104b9a73c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104b9a740: a8c357f6    	ldp	x22, x21, [sp], #0x30
104b9a744: d65f03c0    	ret
