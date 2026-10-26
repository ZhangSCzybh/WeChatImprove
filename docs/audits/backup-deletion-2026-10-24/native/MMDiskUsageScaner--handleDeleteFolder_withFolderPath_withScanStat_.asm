
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029be55c: d10183ff    	sub	sp, sp, #0x60
1029be560: a9025ff8    	stp	x24, x23, [sp, #0x20]
1029be564: a90357f6    	stp	x22, x21, [sp, #0x30]
1029be568: a9044ff4    	stp	x20, x19, [sp, #0x40]
1029be56c: a9057bfd    	stp	x29, x30, [sp, #0x50]
1029be570: 910143fd    	add	x29, sp, #0x50
1029be574: aa0403f8    	mov	x24, x4
1029be578: aa0303f4    	mov	x20, x3
1029be57c: aa0203f3    	mov	x19, x2
1029be580: aa0003f5    	mov	x21, x0
1029be584: 900f13c8    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1029be588: 52800029    	mov	w9, #0x1                ; =1
1029be58c: 3934cd09    	strb	w9, [x8, #0xd33]
1029be590: aa0203e0    	mov	x0, x2
1029be594: 9549a2e9    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029be598: aa1403e0    	mov	x0, x20
1029be59c: 9549a2e7    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029be5a0: b00ebda8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029be5a4: f9463516    	ldr	x22, [x8, #0xc68]
1029be5a8: 900ea9a8    	adrp	x8, 0x11fef2000 <dyld_stub_binder+0x11fef2000>
1029be5ac: f9452917    	ldr	x23, [x8, #0xa50] ; GetFileLastTimeOfAccessModifyChangeBirth:
1029be5b0: aa1803e0    	mov	x0, x24
1029be5b4: 9549a2e1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029be5b8: aa1603e0    	mov	x0, x22
1029be5bc: aa1703e1    	mov	x1, x23
1029be5c0: aa1403e2    	mov	x2, x20
1029be5c4: 9549a2de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be5c8: aa0003f6    	mov	x22, x0
1029be5cc: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029be5d0: f9474101    	ldr	x1, [x8, #0xe80] ; m_curStartTime
1029be5d4: aa1803e0    	mov	x0, x24
1029be5d8: 9549a2d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be5dc: aa0003f7    	mov	x23, x0
1029be5e0: aa1803e0    	mov	x0, x24
1029be5e4: 9549a2dc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029be5e8: f10006df    	cmp	x22, #0x1
1029be5ec: 54000a6b    	b.lt	0x1029be738 <_Flutter_Image_provideRelativePathByUrl+0xdcb5e8>
1029be5f0: f00ea668    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029be5f4: f947b501    	ldr	x1, [x8, #0xf68] ; m_storeTimeType
1029be5f8: aa1303e0    	mov	x0, x19
1029be5fc: 9549a2d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be600: f100041f    	cmp	x0, #0x1
1029be604: 540003c1    	b.ne	0x1029be67c <_Flutter_Image_provideRelativePathByUrl+0xdcb52c>
1029be608: f00ea668    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029be60c: f947b118    	ldr	x24, [x8, #0xf60] ; m_onlyWeChatFileClass
1029be610: aa1303e0    	mov	x0, x19
1029be614: aa1803e1    	mov	x1, x24
1029be618: 9549a2c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be61c: 7100081f    	cmp	w0, #0x2
1029be620: 540000c0    	b.eq	0x1029be638 <_Flutter_Image_provideRelativePathByUrl+0xdcb4e8>
1029be624: aa1303e0    	mov	x0, x19
1029be628: aa1803e1    	mov	x1, x24
1029be62c: 9549a2c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be630: 7100141f    	cmp	w0, #0x5
1029be634: 54000241    	b.ne	0x1029be67c <_Flutter_Image_provideRelativePathByUrl+0xdcb52c>
1029be638: b00ebda8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029be63c: f9453500    	ldr	x0, [x8, #0xa68]
1029be640: f00ea3c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029be644: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029be648: b00de5c8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029be64c: 91272108    	add	x8, x8, #0x9c8
1029be650: a90053e8    	stp	x8, x20, [sp]
1029be654: d00c5de3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029be658: 9125d063    	add	x3, x3, #0x974
1029be65c: f00c5e25    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029be660: 9112f8a5    	add	x5, x5, #0x4be
1029be664: f00c5e27    	adrp	x7, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029be668: 9136f0e7    	add	x7, x7, #0xdbc
1029be66c: 52800042    	mov	w2, #0x2                ; =2
1029be670: 52800004    	mov	w4, #0x0                ; =0
1029be674: 52805e46    	mov	w6, #0x2f2              ; =754
1029be678: 14000041    	b	0x1029be77c <_Flutter_Image_provideRelativePathByUrl+0xdcb62c>
1029be67c: 2a1703e8    	mov	w8, w23
1029be680: cb160108    	sub	x8, x8, x22
1029be684: 528ea029    	mov	w9, #0x7501             ; =29953
1029be688: 72a00249    	movk	w9, #0x12, lsl #16
1029be68c: eb09011f    	cmp	x8, x9
1029be690: 5400086b    	b.lt	0x1029be79c <_Flutter_Image_provideRelativePathByUrl+0xdcb64c>
1029be694: b00ebda8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029be698: f9453500    	ldr	x0, [x8, #0xa68]
1029be69c: f00ea3c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029be6a0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029be6a4: b00de5c8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029be6a8: 9127a108    	add	x8, x8, #0x9e8
1029be6ac: a90053e8    	stp	x8, x20, [sp]
1029be6b0: d00c5de3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029be6b4: 9125d063    	add	x3, x3, #0x974
1029be6b8: f00c5e25    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029be6bc: 9112f8a5    	add	x5, x5, #0x4be
1029be6c0: f00c5e27    	adrp	x7, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029be6c4: 9136f0e7    	add	x7, x7, #0xdbc
1029be6c8: 52800042    	mov	w2, #0x2                ; =2
1029be6cc: 52800004    	mov	w4, #0x0                ; =0
1029be6d0: 52805ec6    	mov	w6, #0x2f6              ; =758
1029be6d4: 9549a29a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be6d8: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029be6dc: f9468d01    	ldr	x1, [x8, #0xd18] ; wrapCacheData
1029be6e0: aa1503e0    	mov	x0, x21
1029be6e4: 9549a296    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be6e8: aa1d03fd    	mov	x29, x29
1029be6ec: 9549a297    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029be6f0: aa0003f5    	mov	x21, x0
1029be6f4: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029be6f8: f9474501    	ldr	x1, [x8, #0xe88] ; deleteCacheByFullPath:
1029be6fc: aa1403e2    	mov	x2, x20
1029be700: 9549a28f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be704: aa1503e0    	mov	x0, x21
1029be708: 9549a293    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029be70c: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029be710: f941d501    	ldr	x1, [x8, #0x3a8] ; isMarkFolderWrap
1029be714: aa1303e0    	mov	x0, x19
1029be718: 9549a289    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be71c: aa0003e8    	mov	x8, x0
1029be720: b00ebde9    	adrp	x9, 0x12017b000 <dyld_stub_binder+0x12017b000>
1029be724: f9425520    	ldr	x0, [x9, #0x4a8]
1029be728: 340002e8    	cbz	w8, 0x1029be784 <_Flutter_Image_provideRelativePathByUrl+0xdcb634>
1029be72c: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029be730: f9474901    	ldr	x1, [x8, #0xe90] ; DeleteBizDir:
1029be734: 14000016    	b	0x1029be78c <_Flutter_Image_provideRelativePathByUrl+0xdcb63c>
1029be738: b00ebda8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029be73c: f9453500    	ldr	x0, [x8, #0xa68]
1029be740: f00ea3c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029be744: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029be748: a900dbf4    	stp	x20, x22, [sp, #0x8]
1029be74c: b00de5c8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029be750: 91282108    	add	x8, x8, #0xa08
1029be754: f90003e8    	str	x8, [sp]
1029be758: d00c5de3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029be75c: 9125d063    	add	x3, x3, #0x974
1029be760: f00c5e25    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029be764: 9112f8a5    	add	x5, x5, #0x4be
1029be768: f00c5e27    	adrp	x7, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029be76c: 9136f0e7    	add	x7, x7, #0xdbc
1029be770: 52800062    	mov	w2, #0x3                ; =3
1029be774: 52800004    	mov	w4, #0x0                ; =0
1029be778: 52806086    	mov	w6, #0x304              ; =772
1029be77c: 9549a270    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be780: 14000007    	b	0x1029be79c <_Flutter_Image_provideRelativePathByUrl+0xdcb64c>
1029be784: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029be788: f9474d01    	ldr	x1, [x8, #0xe98] ; DeleteBizUnknowDir:
1029be78c: aa1403e2    	mov	x2, x20
1029be790: 9549a26b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be794: aa1d03fd    	mov	x29, x29
1029be798: 9549a273    	bl	0x107c27164 <_Flutter_MMFoundation_BindContext+0x4102d48>
1029be79c: aa1403e0    	mov	x0, x20
1029be7a0: 9549a26d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029be7a4: aa1303e0    	mov	x0, x19
1029be7a8: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1029be7ac: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1029be7b0: a94357f6    	ldp	x22, x21, [sp, #0x30]
1029be7b4: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1029be7b8: 910183ff    	add	sp, sp, #0x60
1029be7bc: 1549a266    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
