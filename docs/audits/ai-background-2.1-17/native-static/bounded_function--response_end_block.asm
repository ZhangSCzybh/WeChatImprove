
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10517dfb0: d101c3ff    	sub	sp, sp, #0x70
10517dfb4: a9035ff8    	stp	x24, x23, [sp, #0x30]
10517dfb8: a90457f6    	stp	x22, x21, [sp, #0x40]
10517dfbc: a9054ff4    	stp	x20, x19, [sp, #0x50]
10517dfc0: a9067bfd    	stp	x29, x30, [sp, #0x60]
10517dfc4: 910183fd    	add	x29, sp, #0x60
10517dfc8: aa0003f3    	mov	x19, x0
10517dfcc: d00d7fb7    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
10517dfd0: b9402008    	ldr	w8, [x0, #0x20]
10517dfd4: f00d7c18    	adrp	x24, 0x120100000 <dyld_stub_binder+0x120100000>
10517dfd8: f00d7f95    	adrp	x21, 0x120170000 <dyld_stub_binder+0x120170000>
10517dfdc: b00d65f6    	adrp	x22, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10517dfe0: 7100211f    	cmp	w8, #0x8
10517dfe4: 54000383    	b.lo	0x10517e054 <_Flutter_MMFoundation_BindContext+0x1659c38>
10517dfe8: f945eae0    	ldr	x0, [x23, #0xbd0]
10517dfec: f944eb01    	ldr	x1, [x24, #0x9d0]
10517dff0: 94aaa453    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517dff4: aa1d03fd    	mov	x29, x29
10517dff8: 94aaa454    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517dffc: aa0003f4    	mov	x20, x0
10517e000: f94626a2    	ldr	x2, [x21, #0xc48]
10517e004: d00d70e8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
10517e008: f9423d03    	ldr	x3, [x8, #0x478]
10517e00c: 900c2388    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10517e010: f947e108    	ldr	x8, [x8, #0xfc0]
10517e014: f90007e8    	str	x8, [sp, #0x8]
10517e018: f009e008    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10517e01c: fd423900    	ldr	d0, [x8, #0x470]
10517e020: 90000008    	adrp	x8, 0x10517e000 <_Flutter_MMFoundation_BindContext+0x1659be4>
10517e024: 91033108    	add	x8, x8, #0xcc
10517e028: b00c23c9    	adrp	x9, 0x11d5f7000 <dyld_stub_binder+0x11d5f7000>
10517e02c: 9125a129    	add	x9, x9, #0x968
10517e030: fd000be0    	str	d0, [sp, #0x10]
10517e034: a901a7e8    	stp	x8, x9, [sp, #0x18]
10517e038: b9402268    	ldr	w8, [x19, #0x20]
10517e03c: b9002be8    	str	w8, [sp, #0x28]
10517e040: f9404ac1    	ldr	x1, [x22, #0x90]
10517e044: 910023e4    	add	x4, sp, #0x8
10517e048: 94aaa43d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517e04c: aa1403e0    	mov	x0, x20
10517e050: 94aaa441    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517e054: 39409274    	ldrb	w20, [x19, #0x24]
10517e058: f945eae0    	ldr	x0, [x23, #0xbd0]
10517e05c: f944eb01    	ldr	x1, [x24, #0x9d0]
10517e060: 94aaa437    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517e064: aa1d03fd    	mov	x29, x29
10517e068: 94aaa438    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517e06c: aa0003f3    	mov	x19, x0
10517e070: f94626a2    	ldr	x2, [x21, #0xc48]
10517e074: f9404ac1    	ldr	x1, [x22, #0x90]
10517e078: 900c2788    	adrp	x8, 0x11d66e000 <dyld_stub_binder+0x11d66e000>
10517e07c: 91188108    	add	x8, x8, #0x620
10517e080: 900c2789    	adrp	x9, 0x11d66e000 <dyld_stub_binder+0x11d66e000>
10517e084: 91180129    	add	x9, x9, #0x600
10517e088: 7100029f    	cmp	w20, #0x0
10517e08c: 9a881124    	csel	x4, x9, x8, ne
10517e090: d00d70e8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
10517e094: 91120108    	add	x8, x8, #0x480
10517e098: d00d70e9    	adrp	x9, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
10517e09c: 91106129    	add	x9, x9, #0x418
10517e0a0: 9a891108    	csel	x8, x8, x9, ne
10517e0a4: f9400103    	ldr	x3, [x8]
10517e0a8: 94aaa425    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517e0ac: aa1303e0    	mov	x0, x19
10517e0b0: 94aaa429    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517e0b4: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10517e0b8: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10517e0bc: a94457f6    	ldp	x22, x21, [sp, #0x40]
10517e0c0: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10517e0c4: 9101c3ff    	add	sp, sp, #0x70
10517e0c8: d65f03c0    	ret
