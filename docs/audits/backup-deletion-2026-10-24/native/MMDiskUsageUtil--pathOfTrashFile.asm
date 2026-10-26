
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029c9c7c: d10103ff    	sub	sp, sp, #0x40
1029c9c80: a9037bfd    	stp	x29, x30, [sp, #0x30]
1029c9c84: 9100c3fd    	add	x29, sp, #0x30
1029c9c88: b00d6128    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1029c9c8c: f947dd08    	ldr	x8, [x8, #0xfb8]
1029c9c90: f90007e8    	str	x8, [sp, #0x8]
1029c9c94: 900b1dc8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1029c9c98: fd41c500    	ldr	d0, [x8, #0x388]
1029c9c9c: fd000be0    	str	d0, [sp, #0x10]
1029c9ca0: 90000008    	adrp	x8, 0x1029c9000 <_Flutter_Image_provideRelativePathByUrl+0xdd5eb0>
1029c9ca4: 9133c108    	add	x8, x8, #0xcf0
1029c9ca8: b00d6169    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
1029c9cac: 91058129    	add	x9, x9, #0x160
1029c9cb0: a901a7e8    	stp	x8, x9, [sp, #0x18]
1029c9cb4: f90017e0    	str	x0, [sp, #0x28]
1029c9cb8: d00f15e8    	adrp	x8, 0x120c87000 <dyld_stub_binder+0x120c87000>
1029c9cbc: f946f108    	ldr	x8, [x8, #0xde0]
1029c9cc0: b100051f    	cmn	x8, #0x1
1029c9cc4: 540000c1    	b.ne	0x1029c9cdc <_Flutter_Image_provideRelativePathByUrl+0xdd6b8c>
1029c9cc8: d00f15e8    	adrp	x8, 0x120c87000 <dyld_stub_binder+0x120c87000>
1029c9ccc: f946ed00    	ldr	x0, [x8, #0xdd8]
1029c9cd0: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1029c9cd4: 910103ff    	add	sp, sp, #0x40
1029c9cd8: 1549751d    	b	0x107c2714c <_Flutter_MMFoundation_BindContext+0x4102d30>
1029c9cdc: d00f15e0    	adrp	x0, 0x120c87000 <dyld_stub_binder+0x120c87000>
1029c9ce0: 91378000    	add	x0, x0, #0xde0
1029c9ce4: 910023e1    	add	x1, sp, #0x8
1029c9ce8: 9549752d    	bl	0x107c2719c <_Flutter_MMFoundation_BindContext+0x4102d80>
1029c9cec: 17fffff7    	b	0x1029c9cc8 <_Flutter_Image_provideRelativePathByUrl+0xdd6b78>
