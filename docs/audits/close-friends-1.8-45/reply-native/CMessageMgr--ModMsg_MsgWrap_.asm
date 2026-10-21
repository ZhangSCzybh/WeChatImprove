
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b2e324: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104b2e328: a9014ff4    	stp	x20, x19, [sp, #0x10]
104b2e32c: a9027bfd    	stp	x29, x30, [sp, #0x20]
104b2e330: 910083fd    	add	x29, sp, #0x20
104b2e334: aa0303f3    	mov	x19, x3
104b2e338: aa0203f4    	mov	x20, x2
104b2e33c: aa0003f5    	mov	x21, x0
104b2e340: aa0303e0    	mov	x0, x3
104b2e344: 94c3e37d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b2e348: 900d9888    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104b2e34c: f9413d16    	ldr	x22, [x8, #0x278] ; m_uiMessageType
104b2e350: aa1403e0    	mov	x0, x20
104b2e354: 94c3e379    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b2e358: aa1303e0    	mov	x0, x19
104b2e35c: aa1603e1    	mov	x1, x22
104b2e360: 94c3e377    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e364: 7100f81f    	cmp	w0, #0x3e
104b2e368: 540000c1    	b.ne	0x104b2e380 <_Flutter_MMFoundation_BindContext+0x1009f64>
104b2e36c: b00d9888    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b2e370: f9467101    	ldr	x1, [x8, #0xce0] ; UpdateContent:
104b2e374: aa1303e0    	mov	x0, x19
104b2e378: d2800002    	mov	x2, #0x0                ; =0
104b2e37c: 94c3e370    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e380: b00db7a8    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104b2e384: b9895508    	ldrsw	x8, [x8, #0x954]
104b2e388: f8686aa0    	ldr	x0, [x21, x8]
104b2e38c: 900d98e8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104b2e390: f9464901    	ldr	x1, [x8, #0xc90] ; ModMsg:MsgWrap:
104b2e394: aa1403e2    	mov	x2, x20
104b2e398: aa1303e3    	mov	x3, x19
104b2e39c: 94c3e368    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e3a0: b00d98a8    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b2e3a4: f9464d01    	ldr	x1, [x8, #0xc98] ; AsyncOnModMsg:MsgWrap:
104b2e3a8: aa1503e0    	mov	x0, x21
104b2e3ac: aa1403e2    	mov	x2, x20
104b2e3b0: aa1303e3    	mov	x3, x19
104b2e3b4: 94c3e362    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e3b8: aa1403e0    	mov	x0, x20
104b2e3bc: 94c3e366    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b2e3c0: aa1303e0    	mov	x0, x19
104b2e3c4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104b2e3c8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104b2e3cc: a8c357f6    	ldp	x22, x21, [sp], #0x30
104b2e3d0: 14c3e361    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
