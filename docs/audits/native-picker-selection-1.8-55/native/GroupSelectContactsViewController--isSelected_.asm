
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101ecd9b0: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
101ecd9b4: a9017bfd    	stp	x29, x30, [sp, #0x10]
101ecd9b8: 910043fd    	add	x29, sp, #0x10
101ecd9bc: d00f1948    	adrp	x8, 0x1201f7000 <dyld_stub_binder+0x1201f7000>
101ecd9c0: b987b508    	ldrsw	x8, [x8, #0x7b4]
101ecd9c4: f8686813    	ldr	x19, [x0, x8]
101ecd9c8: d00efb68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101ecd9cc: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
101ecd9d0: aa0203e0    	mov	x0, x2
101ecd9d4: 957565da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecd9d8: aa1d03fd    	mov	x29, x29
101ecd9dc: 957565db    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101ecd9e0: aa0003f4    	mov	x20, x0
101ecd9e4: f00f11a8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101ecd9e8: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
101ecd9ec: aa1303e0    	mov	x0, x19
101ecd9f0: aa1403e2    	mov	x2, x20
101ecd9f4: 957565d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecd9f8: aa1d03fd    	mov	x29, x29
101ecd9fc: 957565d3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101ecda00: f100001f    	cmp	x0, #0x0
101ecda04: 1a9f07f3    	cset	w19, ne
101ecda08: 957565d3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecda0c: aa1403e0    	mov	x0, x20
101ecda10: 957565d1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecda14: aa1303e0    	mov	x0, x19
101ecda18: a9417bfd    	ldp	x29, x30, [sp, #0x10]
101ecda1c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
101ecda20: d65f03c0    	ret
