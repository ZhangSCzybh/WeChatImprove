
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101ecc90c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
101ecc910: a9017bfd    	stp	x29, x30, [sp, #0x10]
101ecc914: 910043fd    	add	x29, sp, #0x10
101ecc918: 900f11c8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101ecc91c: f945dd01    	ldr	x1, [x8, #0xbb8] ; navigationController
101ecc920: 95756a07    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecc924: aa1d03fd    	mov	x29, x29
101ecc928: 95756a08    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101ecc92c: aa0003f3    	mov	x19, x0
101ecc930: f00efb68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101ecc934: f9478101    	ldr	x1, [x8, #0xf00] ; PopViewControllerAnimated:
101ecc938: 52800022    	mov	w2, #0x1                ; =1
101ecc93c: 95756a00    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecc940: aa1d03fd    	mov	x29, x29
101ecc944: 95756a08    	bl	0x107c27164 <_Flutter_MMFoundation_BindContext+0x4102d48>
101ecc948: aa1303e0    	mov	x0, x19
101ecc94c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
101ecc950: a8c24ff4    	ldp	x20, x19, [sp], #0x20
101ecc954: 15756a00    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
