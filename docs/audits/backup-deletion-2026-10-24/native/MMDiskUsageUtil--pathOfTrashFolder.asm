
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029c9d88: d10103ff    	sub	sp, sp, #0x40
1029c9d8c: a9037bfd    	stp	x29, x30, [sp, #0x30]
1029c9d90: 9100c3fd    	add	x29, sp, #0x30
1029c9d94: b00d6128    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1029c9d98: f947dd08    	ldr	x8, [x8, #0xfb8]
1029c9d9c: f90007e8    	str	x8, [sp, #0x8]
1029c9da0: 900b1dc8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1029c9da4: fd41c500    	ldr	d0, [x8, #0x388]
1029c9da8: fd000be0    	str	d0, [sp, #0x10]
1029c9dac: 90000008    	adrp	x8, 0x1029c9000 <_Flutter_Image_provideRelativePathByUrl+0xdd5eb0>
1029c9db0: 9137f108    	add	x8, x8, #0xdfc
1029c9db4: b00d6169    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
1029c9db8: 91058129    	add	x9, x9, #0x160
1029c9dbc: a901a7e8    	stp	x8, x9, [sp, #0x18]
1029c9dc0: f90017e0    	str	x0, [sp, #0x28]
1029c9dc4: d00f15e8    	adrp	x8, 0x120c87000 <dyld_stub_binder+0x120c87000>
1029c9dc8: f946f908    	ldr	x8, [x8, #0xdf0]
1029c9dcc: b100051f    	cmn	x8, #0x1
1029c9dd0: 540000c1    	b.ne	0x1029c9de8 <_Flutter_Image_provideRelativePathByUrl+0xdd6c98>
1029c9dd4: d00f15e8    	adrp	x8, 0x120c87000 <dyld_stub_binder+0x120c87000>
1029c9dd8: f946f500    	ldr	x0, [x8, #0xde8]
1029c9ddc: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1029c9de0: 910103ff    	add	sp, sp, #0x40
1029c9de4: 154974da    	b	0x107c2714c <_Flutter_MMFoundation_BindContext+0x4102d30>
1029c9de8: d00f15e0    	adrp	x0, 0x120c87000 <dyld_stub_binder+0x120c87000>
1029c9dec: 9137c000    	add	x0, x0, #0xdf0
1029c9df0: 910023e1    	add	x1, sp, #0x8
1029c9df4: 954974ea    	bl	0x107c2719c <_Flutter_MMFoundation_BindContext+0x4102d80>
1029c9df8: 17fffff7    	b	0x1029c9dd4 <_Flutter_Image_provideRelativePathByUrl+0xdd6c84>
