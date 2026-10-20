
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10152d2e8: 6dbc23e9    	stp	d9, d8, [sp, #-0x40]!
10152d2ec: a90157f6    	stp	x22, x21, [sp, #0x10]
10152d2f0: a9024ff4    	stp	x20, x19, [sp, #0x20]
10152d2f4: a9037bfd    	stp	x29, x30, [sp, #0x30]
10152d2f8: 9100c3fd    	add	x29, sp, #0x30
10152d2fc: aa0003f3    	mov	x19, x0
10152d300: d00f4888    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10152d304: f9405101    	ldr	x1, [x8, #0xa0] ; initEmoticonView
10152d308: 959be78d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152d30c: d00f6588    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10152d310: 910a8108    	add	x8, x8, #0x2a0
10152d314: b9800114    	ldrsw	x20, [x8]
10152d318: f8746a60    	ldr	x0, [x19, x20]
10152d31c: b00f6608    	adrp	x8, 0x1201ee000 <dyld_stub_binder+0x1201ee000>
10152d320: b98dc515    	ldrsw	x21, [x8, #0xdc4]
10152d324: f8756a62    	ldr	x2, [x19, x21]
10152d328: b00f5e88    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10152d32c: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
10152d330: 959be783    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152d334: f8756a60    	ldr	x0, [x19, x21]
10152d338: d00f5ee8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10152d33c: f947a501    	ldr	x1, [x8, #0xf48] ; width
10152d340: 959be77f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152d344: 1e604008    	fmov	d8, d0
10152d348: f8756a60    	ldr	x0, [x19, x21]
10152d34c: b00f5ea8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10152d350: f9449d01    	ldr	x1, [x8, #0x938] ; height
10152d354: 959be77a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152d358: d2e80928    	mov	x8, #0x4049000000000000 ; =4632233691727265792
10152d35c: 9e670101    	fmov	d1, x8
10152d360: 1e612000    	fcmp	d0, d1
10152d364: 1e604c21    	fcsel	d1, d1, d0, mi
10152d368: f8746a60    	ldr	x0, [x19, x20]
10152d36c: 900f5ee8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
10152d370: f9453d01    	ldr	x1, [x8, #0xa78] ; setSize:
10152d374: 1e604100    	fmov	d0, d8
10152d378: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10152d37c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10152d380: a94157f6    	ldp	x22, x21, [sp, #0x10]
10152d384: 6cc423e9    	ldp	d9, d8, [sp], #0x40
10152d388: 159be76d    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>