
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029c9e94: d10103ff    	sub	sp, sp, #0x40
1029c9e98: a9037bfd    	stp	x29, x30, [sp, #0x30]
1029c9e9c: 9100c3fd    	add	x29, sp, #0x30
1029c9ea0: b00d6128    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1029c9ea4: f947dd08    	ldr	x8, [x8, #0xfb8]
1029c9ea8: f90007e8    	str	x8, [sp, #0x8]
1029c9eac: 900b1dc8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1029c9eb0: fd41c500    	ldr	d0, [x8, #0x388]
1029c9eb4: fd000be0    	str	d0, [sp, #0x10]
1029c9eb8: 90000008    	adrp	x8, 0x1029c9000 <_Flutter_Image_provideRelativePathByUrl+0xdd5eb0>
1029c9ebc: 913c2108    	add	x8, x8, #0xf08
1029c9ec0: b00d6169    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
1029c9ec4: 91058129    	add	x9, x9, #0x160
1029c9ec8: a901a7e8    	stp	x8, x9, [sp, #0x18]
1029c9ecc: f90017e0    	str	x0, [sp, #0x28]
1029c9ed0: d00f15e8    	adrp	x8, 0x120c87000 <dyld_stub_binder+0x120c87000>
1029c9ed4: f9470108    	ldr	x8, [x8, #0xe00]
1029c9ed8: b100051f    	cmn	x8, #0x1
1029c9edc: 540000c1    	b.ne	0x1029c9ef4 <_Flutter_Image_provideRelativePathByUrl+0xdd6da4>
1029c9ee0: d00f15e8    	adrp	x8, 0x120c87000 <dyld_stub_binder+0x120c87000>
1029c9ee4: f946fd00    	ldr	x0, [x8, #0xdf8]
1029c9ee8: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1029c9eec: 910103ff    	add	sp, sp, #0x40
1029c9ef0: 15497497    	b	0x107c2714c <_Flutter_MMFoundation_BindContext+0x4102d30>
1029c9ef4: d00f15e0    	adrp	x0, 0x120c87000 <dyld_stub_binder+0x120c87000>
1029c9ef8: 91380000    	add	x0, x0, #0xe00
1029c9efc: 910023e1    	add	x1, sp, #0x8
1029c9f00: 954974a7    	bl	0x107c2719c <_Flutter_MMFoundation_BindContext+0x4102d80>
1029c9f04: 17fffff7    	b	0x1029c9ee0 <_Flutter_Image_provideRelativePathByUrl+0xdd6d90>
