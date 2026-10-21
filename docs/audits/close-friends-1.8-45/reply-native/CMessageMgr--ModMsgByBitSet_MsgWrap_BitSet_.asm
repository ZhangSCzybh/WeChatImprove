
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b2e3ec: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
104b2e3f0: a90157f6    	stp	x22, x21, [sp, #0x10]
104b2e3f4: a9024ff4    	stp	x20, x19, [sp, #0x20]
104b2e3f8: a9037bfd    	stp	x29, x30, [sp, #0x30]
104b2e3fc: 9100c3fd    	add	x29, sp, #0x30
104b2e400: aa0403f3    	mov	x19, x4
104b2e404: aa0303f4    	mov	x20, x3
104b2e408: aa0203f5    	mov	x21, x2
104b2e40c: aa0003f6    	mov	x22, x0
104b2e410: b00db7a8    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104b2e414: b9895508    	ldrsw	x8, [x8, #0x954]
104b2e418: f8686817    	ldr	x23, [x0, x8]
104b2e41c: b00d9888    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b2e420: f9467518    	ldr	x24, [x8, #0xce8] ; ModMsgByBitSet:MsgWrap:BitSet:
104b2e424: aa0303e0    	mov	x0, x3
104b2e428: 94c3e344    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b2e42c: aa1503e0    	mov	x0, x21
104b2e430: 94c3e342    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b2e434: aa1703e0    	mov	x0, x23
104b2e438: aa1803e1    	mov	x1, x24
104b2e43c: aa1503e2    	mov	x2, x21
104b2e440: aa1403e3    	mov	x3, x20
104b2e444: aa1303e4    	mov	x4, x19
104b2e448: 94c3e33d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e44c: b00d98a8    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b2e450: f9464d01    	ldr	x1, [x8, #0xc98] ; AsyncOnModMsg:MsgWrap:
104b2e454: aa1603e0    	mov	x0, x22
104b2e458: aa1503e2    	mov	x2, x21
104b2e45c: aa1403e3    	mov	x3, x20
104b2e460: 94c3e337    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e464: aa1403e0    	mov	x0, x20
104b2e468: 94c3e33b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b2e46c: aa1503e0    	mov	x0, x21
104b2e470: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104b2e474: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104b2e478: a94157f6    	ldp	x22, x21, [sp, #0x10]
104b2e47c: a8c45ff8    	ldp	x24, x23, [sp], #0x40
104b2e480: 14c3e335    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
