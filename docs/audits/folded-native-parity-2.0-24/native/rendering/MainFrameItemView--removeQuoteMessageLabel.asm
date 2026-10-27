
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a927e4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104a927e8: a9014ff4    	stp	x20, x19, [sp, #0x10]
104a927ec: a9027bfd    	stp	x29, x30, [sp, #0x20]
104a927f0: 910083fd    	add	x29, sp, #0x20
104a927f4: aa0003f3    	mov	x19, x0
104a927f8: 900da0c8    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
104a927fc: f942d114    	ldr	x20, [x8, #0x5a0] ; removeSubViewWithTag:
104a92800: 52934d35    	mov	w21, #0x9a69            ; =39529
104a92804: 72a01315    	movk	w21, #0x98, lsl #16
104a92808: aa1403e1    	mov	x1, x20
104a9280c: 52934d22    	mov	w2, #0x9a69             ; =39529
104a92810: 72a01302    	movk	w2, #0x98, lsl #16
104a92814: 94c6524a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a92818: 110006a2    	add	w2, w21, #0x1
104a9281c: aa1303e0    	mov	x0, x19
104a92820: aa1403e1    	mov	x1, x20
104a92824: 94c65246    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a92828: d00db3a8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104a9282c: f9479d01    	ldr	x1, [x8, #0xf38] ; setNeedsDisplay
104a92830: aa1303e0    	mov	x0, x19
104a92834: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104a92838: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104a9283c: a8c357f6    	ldp	x22, x21, [sp], #0x30
104a92840: 14c6523f    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
