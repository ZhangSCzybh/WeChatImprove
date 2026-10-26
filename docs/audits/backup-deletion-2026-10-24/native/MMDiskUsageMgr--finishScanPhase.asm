
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029b47e8: d101c3ff    	sub	sp, sp, #0x70
1029b47ec: a90457f6    	stp	x22, x21, [sp, #0x40]
1029b47f0: a9054ff4    	stp	x20, x19, [sp, #0x50]
1029b47f4: a9067bfd    	stp	x29, x30, [sp, #0x60]
1029b47f8: 910183fd    	add	x29, sp, #0x60
1029b47fc: aa0003f3    	mov	x19, x0
1029b4800: d00f1408    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1029b4804: 52800029    	mov	w9, #0x1                ; =1
1029b4808: 39347909    	strb	w9, [x8, #0xd1e]
1029b480c: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4810: f943ed15    	ldr	x21, [x8, #0x7d8] ; scanner
1029b4814: aa1503e1    	mov	x1, x21
1029b4818: 9549ca49    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b481c: aa1d03fd    	mov	x29, x29
1029b4820: 9549ca4a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b4824: b4000220    	cbz	x0, 0x1029b4868 <_Flutter_Image_provideRelativePathByUrl+0xdc1718>
1029b4828: aa0003f4    	mov	x20, x0
1029b482c: aa1303e0    	mov	x0, x19
1029b4830: aa1503e1    	mov	x1, x21
1029b4834: 9549ca42    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4838: aa1d03fd    	mov	x29, x29
1029b483c: 9549ca43    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b4840: aa0003f5    	mov	x21, x0
1029b4844: f00eba68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1029b4848: f944ed01    	ldr	x1, [x8, #0x9d8] ; isRunning
1029b484c: 9549ca3c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4850: aa0003f6    	mov	x22, x0
1029b4854: aa1503e0    	mov	x0, x21
1029b4858: 9549ca3f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b485c: aa1403e0    	mov	x0, x20
1029b4860: 9549ca3d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4864: 37000936    	tbnz	w22, #0x0, 0x1029b4988 <_Flutter_Image_provideRelativePathByUrl+0xdc1838>
1029b4868: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b486c: f9449501    	ldr	x1, [x8, #0x928] ; rejectScan
1029b4870: aa1303e0    	mov	x0, x19
1029b4874: 9549ca32    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4878: 37000880    	tbnz	w0, #0x0, 0x1029b4988 <_Flutter_Image_provideRelativePathByUrl+0xdc1838>
1029b487c: a902ffff    	stp	xzr, xzr, [sp, #0x28]
1029b4880: f9001fff    	str	xzr, [sp, #0x38]
1029b4884: f00ebe88    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
1029b4888: f9458500    	ldr	x0, [x8, #0xb08]
1029b488c: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4890: f9449901    	ldr	x1, [x8, #0x930] ; getUrgentLevel
1029b4894: 9549ca2a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4898: aa0003f4    	mov	x20, x0
1029b489c: 7100081f    	cmp	w0, #0x2
1029b48a0: 540000c0    	b.eq	0x1029b48b8 <_Flutter_Image_provideRelativePathByUrl+0xdc1768>
1029b48a4: 7100129f    	cmp	w20, #0x4
1029b48a8: 540000e1    	b.ne	0x1029b48c4 <_Flutter_Image_provideRelativePathByUrl+0xdc1774>
1029b48ac: b00b1ea8    	adrp	x8, 0x118d89000 <dyld_stub_binder+0x118d89000>
1029b48b0: 3dc3cd00    	ldr	q0, [x8, #0xf30]
1029b48b4: 14000006    	b	0x1029b48cc <_Flutter_Image_provideRelativePathByUrl+0xdc177c>
1029b48b8: b00b1ea8    	adrp	x8, 0x118d89000 <dyld_stub_binder+0x118d89000>
1029b48bc: 3dc3c900    	ldr	q0, [x8, #0xf20]
1029b48c0: 14000003    	b	0x1029b48cc <_Flutter_Image_provideRelativePathByUrl+0xdc177c>
1029b48c4: b00b1ea8    	adrp	x8, 0x118d89000 <dyld_stub_binder+0x118d89000>
1029b48c8: 3dc3d100    	ldr	q0, [x8, #0xf40]
1029b48cc: 3d8007e0    	str	q0, [sp, #0x10]
1029b48d0: 9100a3e0    	add	x0, sp, #0x28
1029b48d4: 910043e1    	add	x1, sp, #0x10
1029b48d8: 975badd4    	bl	0x1000a0028 <__text+0x98028>
1029b48dc: b00b1ea8    	adrp	x8, 0x118d89000 <dyld_stub_binder+0x118d89000>
1029b48e0: 3dc3d500    	ldr	q0, [x8, #0xf50]
1029b48e4: 3d8007e0    	str	q0, [sp, #0x10]
1029b48e8: 9100a3e0    	add	x0, sp, #0x28
1029b48ec: 910043e1    	add	x1, sp, #0x10
1029b48f0: 975badce    	bl	0x1000a0028 <__text+0x98028>
1029b48f4: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b48f8: f9449d01    	ldr	x1, [x8, #0x938] ; p_shouldFinishScanWithUrgentLevel:
1029b48fc: aa1303e0    	mov	x0, x19
1029b4900: aa1403e2    	mov	x2, x20
1029b4904: 9549ca0e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4908: 34000340    	cbz	w0, 0x1029b4970 <_Flutter_Image_provideRelativePathByUrl+0xdc1820>
1029b490c: 9100a3e0    	add	x0, sp, #0x28
1029b4910: 52800001    	mov	w1, #0x0                ; =0
1029b4914: 97d66e3e    	bl	0x101f5020c <_Flutter_Image_provideRelativePathByUrl+0x35d0bc>
1029b4918: f00ebde8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029b491c: f9453500    	ldr	x0, [x8, #0xa68]
1029b4920: b00ea428    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029b4924: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029b4928: d00de608    	adrp	x8, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b492c: 9118a108    	add	x8, x8, #0x628
1029b4930: f90003e8    	str	x8, [sp]
1029b4934: 900c5e43    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029b4938: 9125d063    	add	x3, x3, #0x974
1029b493c: f00c5e65    	adrp	x5, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029b4940: 9134f8a5    	add	x5, x5, #0xd3e
1029b4944: 900c5e87    	adrp	x7, 0x11b584000 <dyld_stub_binder+0x11b584000>
1029b4948: 910fc4e7    	add	x7, x7, #0x3f1
1029b494c: 52800042    	mov	w2, #0x2                ; =2
1029b4950: 52800004    	mov	w4, #0x0                ; =0
1029b4954: 528047c6    	mov	w6, #0x23e              ; =574
1029b4958: 9549c9f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b495c: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4960: f944a101    	ldr	x1, [x8, #0x940] ; startFinishScanDiskWithUrgentLevel:
1029b4964: aa1303e0    	mov	x0, x19
1029b4968: aa1403e2    	mov	x2, x20
1029b496c: 9549c9f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4970: f94017e0    	ldr	x0, [sp, #0x28]
1029b4974: b40000a0    	cbz	x0, 0x1029b4988 <_Flutter_Image_provideRelativePathByUrl+0xdc1838>
1029b4978: f9001be0    	str	x0, [sp, #0x30]
1029b497c: f9401fe8    	ldr	x8, [sp, #0x38]
1029b4980: cb000101    	sub	x1, x8, x0
1029b4984: 9549ca12    	bl	0x107c271cc <_Flutter_MMFoundation_BindContext+0x4102db0>
1029b4988: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1029b498c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1029b4990: a94457f6    	ldp	x22, x21, [sp, #0x40]
1029b4994: 9101c3ff    	add	sp, sp, #0x70
1029b4998: d65f03c0    	ret
