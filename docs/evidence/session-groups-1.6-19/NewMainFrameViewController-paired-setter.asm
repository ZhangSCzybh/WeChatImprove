
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10510e3b4: 6db933ed    	stp	d13, d12, [sp, #-0x70]!
10510e3b8: 6d012beb    	stp	d11, d10, [sp, #0x10]
10510e3bc: 6d0223e9    	stp	d9, d8, [sp, #0x20]
10510e3c0: a9035ff8    	stp	x24, x23, [sp, #0x30]
10510e3c4: a90457f6    	stp	x22, x21, [sp, #0x40]
10510e3c8: a9054ff4    	stp	x20, x19, [sp, #0x50]
10510e3cc: a9067bfd    	stp	x29, x30, [sp, #0x60]
10510e3d0: 910183fd    	add	x29, sp, #0x60
10510e3d4: 1e6040a8    	fmov	d8, d5
10510e3d8: 1e604089    	fmov	d9, d4
10510e3dc: 1e60406a    	fmov	d10, d3
10510e3e0: 1e60404b    	fmov	d11, d2
10510e3e4: 1e60402c    	fmov	d12, d1
10510e3e8: 1e60400d    	fmov	d13, d0
10510e3ec: aa0003f3    	mov	x19, x0
10510e3f0: d00d88c8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10510e3f4: 910cf108    	add	x8, x8, #0x33c
10510e3f8: b9800116    	ldrsw	x22, [x8]
10510e3fc: f8766800    	ldr	x0, [x0, x22]
10510e400: 900d7468    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
10510e404: f9450114    	ldr	x20, [x8, #0xa00]
10510e408: aa1403e1    	mov	x1, x20
10510e40c: 52800022    	mov	w2, #0x1                ; =1
10510e410: 94ac634b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10510e414: d00d88c8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10510e418: 910c6108    	add	x8, x8, #0x318
10510e41c: b9800117    	ldrsw	x23, [x8]
10510e420: f8776a60    	ldr	x0, [x19, x23]
10510e424: f00d7fc8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
10510e428: f9441515    	ldr	x21, [x8, #0x828]
10510e42c: aa1503e1    	mov	x1, x21
10510e430: 52800002    	mov	w2, #0x0                ; =0
10510e434: 94ac6342    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10510e438: f8776a60    	ldr	x0, [x19, x23]
10510e43c: b00d7fc8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10510e440: f9439501    	ldr	x1, [x8, #0x728]
10510e444: 1e6041a0    	fmov	d0, d13
10510e448: 1e604181    	fmov	d1, d12
10510e44c: 1e604162    	fmov	d2, d11
10510e450: 1e604143    	fmov	d3, d10
10510e454: 94ac633a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10510e458: f8776a60    	ldr	x0, [x19, x23]
10510e45c: b00d7fc8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10510e460: f943a101    	ldr	x1, [x8, #0x740]
10510e464: 1e604120    	fmov	d0, d9
10510e468: 1e604101    	fmov	d1, d8
10510e46c: 94ac6334    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10510e470: f8776a60    	ldr	x0, [x19, x23]
10510e474: aa1503e1    	mov	x1, x21
10510e478: 52800022    	mov	w2, #0x1                ; =1
10510e47c: 94ac6330    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10510e480: f8766a60    	ldr	x0, [x19, x22]
10510e484: aa1403e1    	mov	x1, x20
10510e488: 52800002    	mov	w2, #0x0                ; =0
10510e48c: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10510e490: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10510e494: a94457f6    	ldp	x22, x21, [sp, #0x40]
10510e498: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10510e49c: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
10510e4a0: 6d412beb    	ldp	d11, d10, [sp, #0x10]
10510e4a4: 6cc733ed    	ldp	d13, d12, [sp], #0x70
10510e4a8: 14ac6325    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
