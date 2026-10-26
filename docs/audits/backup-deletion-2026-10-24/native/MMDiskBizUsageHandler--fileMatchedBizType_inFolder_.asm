
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029a0568: d10583ff    	sub	sp, sp, #0x160
1029a056c: a9106ffc    	stp	x28, x27, [sp, #0x100]
1029a0570: a91167fa    	stp	x26, x25, [sp, #0x110]
1029a0574: a9125ff8    	stp	x24, x23, [sp, #0x120]
1029a0578: a91357f6    	stp	x22, x21, [sp, #0x130]
1029a057c: a9144ff4    	stp	x20, x19, [sp, #0x140]
1029a0580: a9157bfd    	stp	x29, x30, [sp, #0x150]
1029a0584: 910543fd    	add	x29, sp, #0x150
1029a0588: aa0303f4    	mov	x20, x3
1029a058c: aa0203f3    	mov	x19, x2
1029a0590: aa0803f5    	mov	x21, x8
1029a0594: f00d6268    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1029a0598: f9405908    	ldr	x8, [x8, #0xb0]
1029a059c: f9400108    	ldr	x8, [x8]
1029a05a0: f81a03a8    	stur	x8, [x29, #-0x60]
1029a05a4: d00f14a8    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1029a05a8: 52800029    	mov	w9, #0x1                ; =1
1029a05ac: 3933c509    	strb	w9, [x8, #0xcf1]
1029a05b0: aa0203e0    	mov	x0, x2
1029a05b4: 954a1ae1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029a05b8: aa1403e0    	mov	x0, x20
1029a05bc: 954a1adf    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029a05c0: 900b1f28    	adrp	x8, 0x118d84000 <dyld_stub_binder+0x118d84000>
1029a05c4: 3dc2a100    	ldr	q0, [x8, #0xa80]
1029a05c8: 3d8002a0    	str	q0, [x21]
1029a05cc: 900b1f28    	adrp	x8, 0x118d84000 <dyld_stub_binder+0x118d84000>
1029a05d0: fd454900    	ldr	d0, [x8, #0xa90]
1029a05d4: fd000aa0    	str	d0, [x21, #0x10]
1029a05d8: f00ebb08    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1029a05dc: f946e901    	ldr	x1, [x8, #0xdd0] ; length
1029a05e0: aa1303e0    	mov	x0, x19
1029a05e4: 954a1ad6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a05e8: b4000c20    	cbz	x0, 0x1029a076c <_Flutter_Image_provideRelativePathByUrl+0xdad61c>
1029a05ec: f9000bf5    	str	x21, [sp, #0x10]
1029a05f0: b00ea768    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029a05f4: f947bd01    	ldr	x1, [x8, #0xf78] ; m_bizMatchNode
1029a05f8: f90013f4    	str	x20, [sp, #0x20]
1029a05fc: aa1403e0    	mov	x0, x20
1029a0600: 954a1acf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a0604: aa1d03fd    	mov	x29, x29
1029a0608: 954a1ad0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029a060c: 4f00e400    	movi.16b	v0, #0x0
1029a0610: ad0183e0    	stp	q0, q0, [sp, #0x30]
1029a0614: ad0283e0    	stp	q0, q0, [sp, #0x50]
1029a0618: b00ea768    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029a061c: f947c501    	ldr	x1, [x8, #0xf88] ; m_arrBizMatchNode
1029a0620: f9000fe0    	str	x0, [sp, #0x18]
1029a0624: 954a1ac6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a0628: aa1d03fd    	mov	x29, x29
1029a062c: 954a1ac7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029a0630: aa0003f7    	mov	x23, x0
1029a0634: 900ebb08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029a0638: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1029a063c: 9100c3e2    	add	x2, sp, #0x30
1029a0640: 9101c3e3    	add	x3, sp, #0x70
1029a0644: f90017e1    	str	x1, [sp, #0x28]
1029a0648: 52800204    	mov	w4, #0x10               ; =16
1029a064c: 954a1abc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a0650: b4000520    	cbz	x0, 0x1029a06f4 <_Flutter_Image_provideRelativePathByUrl+0xdad5a4>
1029a0654: aa0003f9    	mov	x25, x0
1029a0658: f94023e8    	ldr	x8, [sp, #0x40]
1029a065c: f9400116    	ldr	x22, [x8]
1029a0660: b00ea768    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029a0664: b00ea769    	adrp	x9, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029a0668: d2800014    	mov	x20, #0x0               ; =0
1029a066c: aa0803f8    	mov	x24, x8
1029a0670: f947cd1b    	ldr	x27, [x8, #0xf98] ; isMarkBizFileNode
1029a0674: aa0903f5    	mov	x21, x9
1029a0678: f947c93c    	ldr	x28, [x9, #0xf90] ; isMatchWithName:
1029a067c: f94023e8    	ldr	x8, [sp, #0x40]
1029a0680: f9400108    	ldr	x8, [x8]
1029a0684: eb16011f    	cmp	x8, x22
1029a0688: 54000060    	b.eq	0x1029a0694 <_Flutter_Image_provideRelativePathByUrl+0xdad544>
1029a068c: aa1703e0    	mov	x0, x23
1029a0690: 954a1ab0    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1029a0694: f9401fe8    	ldr	x8, [sp, #0x38]
1029a0698: f874791a    	ldr	x26, [x8, x20, lsl #3]
1029a069c: aa1a03e0    	mov	x0, x26
1029a06a0: aa1b03e1    	mov	x1, x27
1029a06a4: 954a1aa6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a06a8: 340000c0    	cbz	w0, 0x1029a06c0 <_Flutter_Image_provideRelativePathByUrl+0xdad570>
1029a06ac: aa1a03e0    	mov	x0, x26
1029a06b0: aa1c03e1    	mov	x1, x28
1029a06b4: aa1303e2    	mov	x2, x19
1029a06b8: 954a1aa1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a06bc: 350007c0    	cbnz	w0, 0x1029a07b4 <_Flutter_Image_provideRelativePathByUrl+0xdad664>
1029a06c0: 91000694    	add	x20, x20, #0x1
1029a06c4: eb14033f    	cmp	x25, x20
1029a06c8: 54fffda1    	b.ne	0x1029a067c <_Flutter_Image_provideRelativePathByUrl+0xdad52c>
1029a06cc: 9100c3e2    	add	x2, sp, #0x30
1029a06d0: 9101c3e3    	add	x3, sp, #0x70
1029a06d4: aa1703e0    	mov	x0, x23
1029a06d8: f94017e1    	ldr	x1, [sp, #0x28]
1029a06dc: 52800204    	mov	w4, #0x10               ; =16
1029a06e0: 954a1a97    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a06e4: aa0003f9    	mov	x25, x0
1029a06e8: aa1803e8    	mov	x8, x24
1029a06ec: aa1503e9    	mov	x9, x21
1029a06f0: b5fffbc0    	cbnz	x0, 0x1029a0668 <_Flutter_Image_provideRelativePathByUrl+0xdad518>
1029a06f4: aa1703e0    	mov	x0, x23
1029a06f8: 954a1a97    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029a06fc: 900eaac8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029a0700: f941d501    	ldr	x1, [x8, #0x3a8] ; isMarkFolderWrap
1029a0704: f94013f4    	ldr	x20, [sp, #0x20]
1029a0708: aa1403e0    	mov	x0, x20
1029a070c: 954a1a8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a0710: 34000820    	cbz	w0, 0x1029a0814 <_Flutter_Image_provideRelativePathByUrl+0xdad6c4>
1029a0714: b00ea768    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029a0718: f947a901    	ldr	x1, [x8, #0xf50] ; m_onlyBizType
1029a071c: aa1403e0    	mov	x0, x20
1029a0720: 954a1a87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a0724: f9400bf5    	ldr	x21, [sp, #0x10]
1029a0728: f90002a0    	str	x0, [x21]
1029a072c: b00ea768    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029a0730: f947ad01    	ldr	x1, [x8, #0xf58] ; m_onlyFileTypeInUse
1029a0734: aa1403e0    	mov	x0, x20
1029a0738: 954a1a81    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a073c: b90012a0    	str	w0, [x21, #0x10]
1029a0740: b00ea768    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029a0744: f947b101    	ldr	x1, [x8, #0xf60] ; m_onlyWeChatFileClass
1029a0748: aa1403e0    	mov	x0, x20
1029a074c: 954a1a7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a0750: b90016a0    	str	w0, [x21, #0x14]
1029a0754: b00ea768    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029a0758: f947b501    	ldr	x1, [x8, #0xf68] ; m_storeTimeType
1029a075c: aa1403e0    	mov	x0, x20
1029a0760: 954a1a77    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a0764: f90006a0    	str	x0, [x21, #0x8]
1029a0768: 1400002b    	b	0x1029a0814 <_Flutter_Image_provideRelativePathByUrl+0xdad6c4>
1029a076c: f00ebe88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029a0770: f9453500    	ldr	x0, [x8, #0xa68]
1029a0774: b00ea4c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029a0778: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029a077c: b00de668    	adrp	x8, 0x11e66d000 <dyld_stub_binder+0x11e66d000>
1029a0780: 9131a108    	add	x8, x8, #0xc68
1029a0784: f90003e8    	str	x8, [sp]
1029a0788: 900c5ee3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029a078c: 9125d063    	add	x3, x3, #0x974
1029a0790: 900c5ee5    	adrp	x5, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029a0794: 91200ca5    	add	x5, x5, #0x803
1029a0798: 900c5ee7    	adrp	x7, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029a079c: 91320ce7    	add	x7, x7, #0xc83
1029a07a0: 52800082    	mov	w2, #0x4                ; =4
1029a07a4: 52800004    	mov	w4, #0x0                ; =0
1029a07a8: 52804f06    	mov	w6, #0x278              ; =632
1029a07ac: 954a1a64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a07b0: 1400001b    	b	0x1029a081c <_Flutter_Image_provideRelativePathByUrl+0xdad6cc>
1029a07b4: b00ea768    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029a07b8: f947d101    	ldr	x1, [x8, #0xfa0] ; m_bizType
1029a07bc: aa1a03e0    	mov	x0, x26
1029a07c0: 954a1a5f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a07c4: f9400bf4    	ldr	x20, [sp, #0x10]
1029a07c8: f9000280    	str	x0, [x20]
1029a07cc: b00ea768    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029a07d0: f947b501    	ldr	x1, [x8, #0xf68] ; m_storeTimeType
1029a07d4: aa1a03e0    	mov	x0, x26
1029a07d8: 954a1a59    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a07dc: f9000680    	str	x0, [x20, #0x8]
1029a07e0: b00ea768    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029a07e4: f947d901    	ldr	x1, [x8, #0xfb0] ; m_fileTypeInUse
1029a07e8: aa1a03e0    	mov	x0, x26
1029a07ec: 954a1a54    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a07f0: b9001280    	str	w0, [x20, #0x10]
1029a07f4: b00ea768    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029a07f8: f947e101    	ldr	x1, [x8, #0xfc0] ; m_wechatFileClass
1029a07fc: aa1a03e0    	mov	x0, x26
1029a0800: 954a1a4f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a0804: b9001680    	str	w0, [x20, #0x14]
1029a0808: aa1703e0    	mov	x0, x23
1029a080c: 954a1a52    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029a0810: f94013f4    	ldr	x20, [sp, #0x20]
1029a0814: f9400fe0    	ldr	x0, [sp, #0x18]
1029a0818: 954a1a4f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029a081c: aa1403e0    	mov	x0, x20
1029a0820: 954a1a4d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029a0824: aa1303e0    	mov	x0, x19
1029a0828: 954a1a4b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029a082c: f85a03a8    	ldur	x8, [x29, #-0x60]
1029a0830: f00d6269    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1029a0834: f9405929    	ldr	x9, [x9, #0xb0]
1029a0838: f9400129    	ldr	x9, [x9]
1029a083c: eb08013f    	cmp	x9, x8
1029a0840: 54000121    	b.ne	0x1029a0864 <_Flutter_Image_provideRelativePathByUrl+0xdad714>
1029a0844: a9557bfd    	ldp	x29, x30, [sp, #0x150]
1029a0848: a9544ff4    	ldp	x20, x19, [sp, #0x140]
1029a084c: a95357f6    	ldp	x22, x21, [sp, #0x130]
1029a0850: a9525ff8    	ldp	x24, x23, [sp, #0x120]
1029a0854: a95167fa    	ldp	x26, x25, [sp, #0x110]
1029a0858: a9506ffc    	ldp	x28, x27, [sp, #0x100]
1029a085c: 910583ff    	add	sp, sp, #0x160
1029a0860: d65f03c0    	ret
1029a0864: 954a1a44    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
