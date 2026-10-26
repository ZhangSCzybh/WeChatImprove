
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029c958c: d10083ff    	sub	sp, sp, #0x20
1029c9590: a9017bfd    	stp	x29, x30, [sp, #0x10]
1029c9594: 910043fd    	add	x29, sp, #0x10
1029c9598: b4000122    	cbz	x2, 0x1029c95bc <_Flutter_Image_provideRelativePathByUrl+0xdd646c>
1029c959c: 900ea988    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c95a0: f941c501    	ldr	x1, [x8, #0x388] ; moveFolderToTmpTrash:description:
1029c95a4: f00de563    	adrp	x3, 0x11e678000 <dyld_stub_binder+0x11e678000>
1029c95a8: 913ea063    	add	x3, x3, #0xfa8
1029c95ac: 954976e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c95b0: aa1d03fd    	mov	x29, x29
1029c95b4: 954976e5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c95b8: 14000013    	b	0x1029c9604 <_Flutter_Image_provideRelativePathByUrl+0xdd64b4>
1029c95bc: d00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c95c0: f9453500    	ldr	x0, [x8, #0xa68]
1029c95c4: 900ea388    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029c95c8: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029c95cc: f00de568    	adrp	x8, 0x11e678000 <dyld_stub_binder+0x11e678000>
1029c95d0: 913fa108    	add	x8, x8, #0xfe8
1029c95d4: f90003e8    	str	x8, [sp]
1029c95d8: f00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c95dc: 9125d063    	add	x3, x3, #0x974
1029c95e0: d00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c95e4: 911554a5    	add	x5, x5, #0x555
1029c95e8: d00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c95ec: 91210ce7    	add	x7, x7, #0x843
1029c95f0: 52800022    	mov	w2, #0x1                ; =1
1029c95f4: 52800004    	mov	w4, #0x0                ; =0
1029c95f8: 52801966    	mov	w6, #0xcb               ; =203
1029c95fc: 954976d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9600: d2800000    	mov	x0, #0x0                ; =0
1029c9604: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1029c9608: 910083ff    	add	sp, sp, #0x20
1029c960c: 154976d9    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
