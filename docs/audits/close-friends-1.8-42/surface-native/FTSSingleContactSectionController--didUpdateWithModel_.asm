
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1017e01d8: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1017e01dc: a9017bfd    	stp	x29, x30, [sp, #0x10]
1017e01e0: 910043fd    	add	x29, sp, #0x10
1017e01e4: aa0203f3    	mov	x19, x2
1017e01e8: aa0003f4    	mov	x20, x0
1017e01ec: aa0203e0    	mov	x0, x2
1017e01f0: 95911bd2    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1017e01f4: d00f4ce8    	adrp	x8, 0x12017e000 <dyld_stub_binder+0x12017e000>
1017e01f8: f947f900    	ldr	x0, [x8, #0xff0]
1017e01fc: f00f48e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1017e0200: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1017e0204: 95911bce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e0208: aa0003e2    	mov	x2, x0
1017e020c: f00f4908    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1017e0210: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
1017e0214: aa1303e0    	mov	x0, x19
1017e0218: 95911bc9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e021c: 340001a0    	cbz	w0, 0x1017e0250 <__text+0x17d8250>
1017e0220: d00f4928    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1017e0224: f9440d01    	ldr	x1, [x8, #0x818] ; rows
1017e0228: aa1303e0    	mov	x0, x19
1017e022c: 95911bc4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e0230: aa1d03fd    	mov	x29, x29
1017e0234: 95911bc5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e0238: b00f5088    	adrp	x8, 0x1201f1000 <dyld_stub_binder+0x1201f1000>
1017e023c: b986a509    	ldrsw	x9, [x8, #0x6a4] ; ivar FTSSingleContactSectionController._contacts
1017e0240: f8696a88    	ldr	x8, [x20, x9]
1017e0244: f8296a80    	str	x0, [x20, x9]
1017e0248: aa0803e0    	mov	x0, x8
1017e024c: 95911bc2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e0250: aa1303e0    	mov	x0, x19
1017e0254: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1017e0258: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1017e025c: 15911bbe    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
