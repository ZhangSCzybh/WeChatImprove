
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029b095c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1029b0960: a9017bfd    	stp	x29, x30, [sp, #0x10]
1029b0964: 910043fd    	add	x29, sp, #0x10
1029b0968: f00ebea8    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
1029b096c: f9454900    	ldr	x0, [x8, #0xa90]
1029b0970: 900eaa48    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b0974: f9435d01    	ldr	x1, [x8, #0x6b8] ; GetDocumentPath
1029b0978: 9549d9f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b097c: aa1d03fd    	mov	x29, x29
1029b0980: 9549d9f2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b0984: aa0003f3    	mov	x19, x0
1029b0988: d00ebac8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1029b098c: f9465901    	ldr	x1, [x8, #0xcb0] ; stringByDeletingLastPathComponent
1029b0990: 9549d9eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b0994: aa1d03fd    	mov	x29, x29
1029b0998: 9549d9ec    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b099c: aa0003f4    	mov	x20, x0
1029b09a0: aa1303e0    	mov	x0, x19
1029b09a4: 9549d9ec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b09a8: aa1403e0    	mov	x0, x20
1029b09ac: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1029b09b0: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1029b09b4: 1549d9ef    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
