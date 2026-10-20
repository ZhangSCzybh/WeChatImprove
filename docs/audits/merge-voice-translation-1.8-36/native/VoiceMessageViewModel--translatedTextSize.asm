
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10628e7a0: 6dbc23e9    	stp	d9, d8, [sp, #-0x40]!
10628e7a4: a90157f6    	stp	x22, x21, [sp, #0x10]
10628e7a8: a9024ff4    	stp	x20, x19, [sp, #0x20]
10628e7ac: a9037bfd    	stp	x29, x30, [sp, #0x30]
10628e7b0: 9100c3fd    	add	x29, sp, #0x30
10628e7b4: aa0003f4    	mov	x20, x0
10628e7b8: f00cdfe8    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
10628e7bc: f944a101    	ldr	x1, [x8, #0x940] ; voiceTranslateInfo
10628e7c0: 9466625f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e7c4: aa1d03fd    	mov	x29, x29
10628e7c8: 94666260    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e7cc: aa0003f5    	mov	x21, x0
10628e7d0: d00cdda8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10628e7d4: f942b101    	ldr	x1, [x8, #0x560] ; translatedText
10628e7d8: 94666259    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e7dc: aa1d03fd    	mov	x29, x29
10628e7e0: 9466625a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e7e4: aa0003f3    	mov	x19, x0
10628e7e8: aa1503e0    	mov	x0, x21
10628e7ec: 9466625a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e7f0: b00cf3a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10628e7f4: f946e901    	ldr	x1, [x8, #0xdd0] ; length
10628e7f8: aa1303e0    	mov	x0, x19
10628e7fc: 94666250    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e800: b40003a0    	cbz	x0, 0x10628e874 <_Flutter_MMFoundation_BindContext+0x276a458>
10628e804: b00cea28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10628e808: f947f915    	ldr	x21, [x8, #0xff0] ; richTextViewForCalcu
10628e80c: aa1403e0    	mov	x0, x20
10628e810: aa1503e1    	mov	x1, x21
10628e814: 9466624a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e818: aa1d03fd    	mov	x29, x29
10628e81c: 9466624b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e820: aa0003f6    	mov	x22, x0
10628e824: d00cdd88    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
10628e828: f9417101    	ldr	x1, [x8, #0x2e0] ; setContent:
10628e82c: aa1303e2    	mov	x2, x19
10628e830: 94666243    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e834: aa1603e0    	mov	x0, x22
10628e838: 94666247    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e83c: aa1403e0    	mov	x0, x20
10628e840: aa1503e1    	mov	x1, x21
10628e844: 9466623e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e848: aa1d03fd    	mov	x29, x29
10628e84c: 9466623f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e850: aa0003f4    	mov	x20, x0
10628e854: 900cf3e8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10628e858: f9442501    	ldr	x1, [x8, #0x848] ; size
10628e85c: 94666238    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e860: 1e604008    	fmov	d8, d0
10628e864: 1e604029    	fmov	d9, d1
10628e868: aa1403e0    	mov	x0, x20
10628e86c: 9466623a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e870: 14000003    	b	0x10628e87c <_Flutter_MMFoundation_BindContext+0x276a460>
10628e874: 9e6703e8    	fmov	d8, xzr
10628e878: 9e6703e9    	fmov	d9, xzr
10628e87c: aa1303e0    	mov	x0, x19
10628e880: 94666235    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e884: 1e604100    	fmov	d0, d8
10628e888: 1e604121    	fmov	d1, d9
10628e88c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10628e890: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10628e894: a94157f6    	ldp	x22, x21, [sp, #0x10]
10628e898: 6cc423e9    	ldp	d9, d8, [sp], #0x40
10628e89c: d65f03c0    	ret