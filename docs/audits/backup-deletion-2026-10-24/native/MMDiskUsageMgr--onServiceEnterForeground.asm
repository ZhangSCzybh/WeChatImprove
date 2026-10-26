
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029b3358: d10143ff    	sub	sp, sp, #0x50
1029b335c: a9034ff4    	stp	x20, x19, [sp, #0x30]
1029b3360: a9047bfd    	stp	x29, x30, [sp, #0x40]
1029b3364: 910103fd    	add	x29, sp, #0x40
1029b3368: aa0003f3    	mov	x19, x0
1029b336c: 900ebe08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029b3370: f9453500    	ldr	x0, [x8, #0xa68]
1029b3374: d00ea428    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029b3378: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029b337c: d00ddb08    	adrp	x8, 0x11e515000 <dyld_stub_binder+0x11e515000>
1029b3380: 9113a108    	add	x8, x8, #0x4e8
1029b3384: f90003e8    	str	x8, [sp]
1029b3388: b00c5e43    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029b338c: 9125d063    	add	x3, x3, #0x974
1029b3390: 900c5e85    	adrp	x5, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029b3394: 9134f8a5    	add	x5, x5, #0xd3e
1029b3398: 900c5e87    	adrp	x7, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029b339c: 913e48e7    	add	x7, x7, #0xf92
1029b33a0: 52800042    	mov	w2, #0x2                ; =2
1029b33a4: 52800004    	mov	w4, #0x0                ; =0
1029b33a8: 52802a26    	mov	w6, #0x151              ; =337
1029b33ac: 9549cf64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b33b0: d2800000    	mov	x0, #0x0                ; =0
1029b33b4: 52928001    	mov	w1, #0x9400             ; =37888
1029b33b8: 72aee6a1    	movk	w1, #0x7735, lsl #16
1029b33bc: 9549cf81    	bl	0x107c271c0 <_Flutter_MMFoundation_BindContext+0x4102da4>
1029b33c0: f00d61c8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1029b33c4: f947e108    	ldr	x8, [x8, #0xfc0]
1029b33c8: f90007e8    	str	x8, [sp, #0x8]
1029b33cc: d00b1e68    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1029b33d0: fd41c100    	ldr	d0, [x8, #0x380]
1029b33d4: 90000008    	adrp	x8, 0x1029b3000 <_Flutter_Image_provideRelativePathByUrl+0xdbfeb0>
1029b33d8: 91104108    	add	x8, x8, #0x410
1029b33dc: fd000be0    	str	d0, [sp, #0x10]
1029b33e0: f00d6209    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
1029b33e4: 9115c129    	add	x9, x9, #0x570
1029b33e8: a901a7e8    	stp	x8, x9, [sp, #0x18]
1029b33ec: f90017f3    	str	x19, [sp, #0x28]
1029b33f0: 900d61e1    	adrp	x1, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1029b33f4: f9408c21    	ldr	x1, [x1, #0x118]
1029b33f8: 910023e2    	add	x2, sp, #0x8
1029b33fc: 9549678b    	bl	0x107c0d228 <_Flutter_MMFoundation_BindContext+0x40e8e0c>
1029b3400: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1029b3404: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1029b3408: 910143ff    	add	sp, sp, #0x50
1029b340c: d65f03c0    	ret
