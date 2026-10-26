
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029c9484: d10083ff    	sub	sp, sp, #0x20
1029c9488: a9017bfd    	stp	x29, x30, [sp, #0x10]
1029c948c: 910043fd    	add	x29, sp, #0x10
1029c9490: b4000122    	cbz	x2, 0x1029c94b4 <_Flutter_Image_provideRelativePathByUrl+0xdd6364>
1029c9494: 900ea988    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c9498: f941c101    	ldr	x1, [x8, #0x380] ; moveFileToTmpTrash:description:
1029c949c: f00de563    	adrp	x3, 0x11e678000 <dyld_stub_binder+0x11e678000>
1029c94a0: 913ea063    	add	x3, x3, #0xfa8
1029c94a4: 95497726    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c94a8: aa1d03fd    	mov	x29, x29
1029c94ac: 95497727    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c94b0: 14000013    	b	0x1029c94fc <_Flutter_Image_provideRelativePathByUrl+0xdd63ac>
1029c94b4: d00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c94b8: f9453500    	ldr	x0, [x8, #0xa68]
1029c94bc: 900ea388    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029c94c0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029c94c4: f00de568    	adrp	x8, 0x11e678000 <dyld_stub_binder+0x11e678000>
1029c94c8: 913e2108    	add	x8, x8, #0xf88
1029c94cc: f90003e8    	str	x8, [sp]
1029c94d0: f00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c94d4: 9125d063    	add	x3, x3, #0x974
1029c94d8: d00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c94dc: 911554a5    	add	x5, x5, #0x555
1029c94e0: d00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c94e4: 911ee4e7    	add	x7, x7, #0x7b9
1029c94e8: 52800022    	mov	w2, #0x1                ; =1
1029c94ec: 52800004    	mov	w4, #0x0                ; =0
1029c94f0: 52801766    	mov	w6, #0xbb               ; =187
1029c94f4: 95497712    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c94f8: d2800000    	mov	x0, #0x0                ; =0
1029c94fc: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1029c9500: 910083ff    	add	sp, sp, #0x20
1029c9504: 1549771b    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
