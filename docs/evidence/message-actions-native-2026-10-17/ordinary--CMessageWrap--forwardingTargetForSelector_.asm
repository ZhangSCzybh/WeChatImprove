
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b9f110: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104b9f114: a9014ff4    	stp	x20, x19, [sp, #0x10]
104b9f118: a9027bfd    	stp	x29, x30, [sp, #0x20]
104b9f11c: 910083fd    	add	x29, sp, #0x20
104b9f120: aa0203f3    	mov	x19, x2
104b9f124: aa0003f4    	mov	x20, x0
104b9f128: b00db428    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9f12c: b982a508    	ldrsw	x8, [x8, #0x2a4]
104b9f130: 8b080016    	add	x22, x0, x8
104b9f134: f94002c0    	ldr	x0, [x22]
104b9f138: f00dab28    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104b9f13c: f9436115    	ldr	x21, [x8, #0x6c0] ; respondsToSelector:
104b9f140: aa1503e1    	mov	x1, x21
104b9f144: 94c21ffe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9f148: 37000220    	tbnz	w0, #0x0, 0x104b9f18c <_Flutter_MMFoundation_BindContext+0x107ad70>
104b9f14c: b00db428    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9f150: b982ad08    	ldrsw	x8, [x8, #0x2ac]
104b9f154: 8b080296    	add	x22, x20, x8
104b9f158: f94002c0    	ldr	x0, [x22]
104b9f15c: aa1503e1    	mov	x1, x21
104b9f160: aa1303e2    	mov	x2, x19
104b9f164: 94c21ff6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9f168: 37000120    	tbnz	w0, #0x0, 0x104b9f18c <_Flutter_MMFoundation_BindContext+0x107ad70>
104b9f16c: b00db428    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9f170: b982a908    	ldrsw	x8, [x8, #0x2a8]
104b9f174: 8b080296    	add	x22, x20, x8
104b9f178: f94002c0    	ldr	x0, [x22]
104b9f17c: aa1503e1    	mov	x1, x21
104b9f180: aa1303e2    	mov	x2, x19
104b9f184: 94c21fee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9f188: 340000e0    	cbz	w0, 0x104b9f1a4 <_Flutter_MMFoundation_BindContext+0x107ad88>
104b9f18c: f94002c0    	ldr	x0, [x22]
104b9f190: 94c21fea    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b9f194: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104b9f198: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104b9f19c: a8c357f6    	ldp	x22, x21, [sp], #0x30
104b9f1a0: 14c21ff4    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
104b9f1a4: d2800000    	mov	x0, #0x0                ; =0
104b9f1a8: 17fffffb    	b	0x104b9f194 <_Flutter_MMFoundation_BindContext+0x107ad78>