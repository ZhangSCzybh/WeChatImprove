
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1028fe4e8: d10203ff    	sub	sp, sp, #0x80
1028fe4ec: a9045ff8    	stp	x24, x23, [sp, #0x40]
1028fe4f0: a90557f6    	stp	x22, x21, [sp, #0x50]
1028fe4f4: a9064ff4    	stp	x20, x19, [sp, #0x60]
1028fe4f8: a9077bfd    	stp	x29, x30, [sp, #0x70]
1028fe4fc: 9101c3fd    	add	x29, sp, #0x70
1028fe500: 900f19c8    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1028fe504: 52800029    	mov	w9, #0x1                ; =1
1028fe508: 3928d509    	strb	w9, [x8, #0xa35]
1028fe50c: b00ec3b7    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
1028fe510: f9467ae0    	ldr	x0, [x23, #0xcf0]
1028fe514: b00ea9e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1028fe518: f9466901    	ldr	x1, [x8, #0xcd0] ; GetSystemCachePath
1028fe51c: 954ca308    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe520: aa1d03fd    	mov	x29, x29
1028fe524: 954ca309    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1028fe528: aa0003f4    	mov	x20, x0
1028fe52c: 900ec068    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1028fe530: f9465101    	ldr	x1, [x8, #0xca0] ; stringByAppendingPathComponent:
1028fe534: d00deb22    	adrp	x2, 0x11e664000 <dyld_stub_binder+0x11e664000>
1028fe538: 9131a042    	add	x2, x2, #0xc68
1028fe53c: 954ca300    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe540: aa1d03fd    	mov	x29, x29
1028fe544: 954ca301    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1028fe548: aa0003f3    	mov	x19, x0
1028fe54c: aa1403e0    	mov	x0, x20
1028fe550: 954ca301    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1028fe554: b00ec3b8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
1028fe558: f9463714    	ldr	x20, [x24, #0xc68]
1028fe55c: aa1303e0    	mov	x0, x19
1028fe560: 954ca312    	bl	0x107c271a8 <_Flutter_MMFoundation_BindContext+0x4102d8c>
1028fe564: 900ec008    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1028fe568: f944d915    	ldr	x21, [x8, #0x9b0] ; UTF8String
1028fe56c: aa1503e1    	mov	x1, x21
1028fe570: 954ca2f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe574: aa0003e2    	mov	x2, x0
1028fe578: f00eac48    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
1028fe57c: f945e116    	ldr	x22, [x8, #0xbc0] ; FolderSizeAtPath:
1028fe580: aa1403e0    	mov	x0, x20
1028fe584: aa1603e1    	mov	x1, x22
1028fe588: 954ca2ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe58c: aa0003f4    	mov	x20, x0
1028fe590: f9463700    	ldr	x0, [x24, #0xc68]
1028fe594: f00ea9c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1028fe598: f946f101    	ldr	x1, [x8, #0xde0] ; RemoveFile:
1028fe59c: aa1303e2    	mov	x2, x19
1028fe5a0: 954ca2e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe5a4: b00ec3a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1028fe5a8: f9453500    	ldr	x0, [x8, #0xa68]
1028fe5ac: f00ea9c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1028fe5b0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1028fe5b4: d00deb28    	adrp	x8, 0x11e664000 <dyld_stub_binder+0x11e664000>
1028fe5b8: 9132a108    	add	x8, x8, #0xca8
1028fe5bc: a90053e8    	stp	x8, x20, [sp]
1028fe5c0: f00c6365    	adrp	x5, 0x11b56d000 <dyld_stub_binder+0x11b56d000>
1028fe5c4: 911a9ca5    	add	x5, x5, #0x6a7
1028fe5c8: f00c6367    	adrp	x7, 0x11b56d000 <dyld_stub_binder+0x11b56d000>
1028fe5cc: 91245ce7    	add	x7, x7, #0x917
1028fe5d0: 52800042    	mov	w2, #0x2                ; =2
1028fe5d4: d2800003    	mov	x3, #0x0                ; =0
1028fe5d8: 52800004    	mov	w4, #0x0                ; =0
1028fe5dc: 528068c6    	mov	w6, #0x346              ; =838
1028fe5e0: 954ca2d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe5e4: f9467ae0    	ldr	x0, [x23, #0xcf0]
1028fe5e8: f00eafa8    	adrp	x8, 0x11fef5000 <dyld_stub_binder+0x11fef5000>
1028fe5ec: f9455d01    	ldr	x1, [x8, #0xab8] ; GetWebKitStoragePath
1028fe5f0: 954ca2d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe5f4: aa1d03fd    	mov	x29, x29
1028fe5f8: 954ca2d4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1028fe5fc: aa0003f7    	mov	x23, x0
1028fe600: f9463718    	ldr	x24, [x24, #0xc68]
1028fe604: 954ca2e9    	bl	0x107c271a8 <_Flutter_MMFoundation_BindContext+0x4102d8c>
1028fe608: aa1503e1    	mov	x1, x21
1028fe60c: 954ca2cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe610: aa0003e2    	mov	x2, x0
1028fe614: aa1803e0    	mov	x0, x24
1028fe618: aa1603e1    	mov	x1, x22
1028fe61c: 954ca2c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe620: aa0003f5    	mov	x21, x0
1028fe624: 900d6788    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1028fe628: f947e108    	ldr	x8, [x8, #0xfc0]
1028fe62c: f9000fe8    	str	x8, [sp, #0x18]
1028fe630: f00b2408    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1028fe634: fd423900    	ldr	d0, [x8, #0x470]
1028fe638: fd0013e0    	str	d0, [sp, #0x20]
1028fe63c: 90000008    	adrp	x8, 0x1028fe000 <_Flutter_Image_provideRelativePathByUrl+0xd0aeb0>
1028fe640: 911ae108    	add	x8, x8, #0x6b8
1028fe644: 900d67c9    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
1028fe648: 91058129    	add	x9, x9, #0x160
1028fe64c: a902a7e8    	stp	x8, x9, [sp, #0x28]
1028fe650: f9001fe0    	str	x0, [sp, #0x38]
1028fe654: b00ec3a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1028fe658: f946a500    	ldr	x0, [x8, #0xd48]
1028fe65c: b00ec028    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1028fe660: f9444d01    	ldr	x1, [x8, #0x898] ; isMainThread
1028fe664: 954ca2b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe668: 340000a0    	cbz	w0, 0x1028fe67c <_Flutter_Image_provideRelativePathByUrl+0xd0b52c>
1028fe66c: f94017e8    	ldr	x8, [sp, #0x28]
1028fe670: 910063e0    	add	x0, sp, #0x18
1028fe674: d63f0100    	blr	x8
1028fe678: 14000005    	b	0x1028fe68c <_Flutter_Image_provideRelativePathByUrl+0xd0b53c>
1028fe67c: b00d6780    	adrp	x0, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1028fe680: f9408c00    	ldr	x0, [x0, #0x118]
1028fe684: 910063e1    	add	x1, sp, #0x18
1028fe688: 954c3ae6    	bl	0x107c0d220 <_Flutter_MMFoundation_BindContext+0x40e8e04>
1028fe68c: aa1703e0    	mov	x0, x23
1028fe690: 954ca2b1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1028fe694: aa1303e0    	mov	x0, x19
1028fe698: 954ca2af    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1028fe69c: 8b1402a0    	add	x0, x21, x20
1028fe6a0: a9477bfd    	ldp	x29, x30, [sp, #0x70]
1028fe6a4: a9464ff4    	ldp	x20, x19, [sp, #0x60]
1028fe6a8: a94557f6    	ldp	x22, x21, [sp, #0x50]
1028fe6ac: a9445ff8    	ldp	x24, x23, [sp, #0x40]
1028fe6b0: 910203ff    	add	sp, sp, #0x80
1028fe6b4: d65f03c0    	ret
