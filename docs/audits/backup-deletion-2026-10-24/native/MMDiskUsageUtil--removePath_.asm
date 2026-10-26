
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029ca44c: d10183ff    	sub	sp, sp, #0x60
1029ca450: a9025ff8    	stp	x24, x23, [sp, #0x20]
1029ca454: a90357f6    	stp	x22, x21, [sp, #0x30]
1029ca458: a9044ff4    	stp	x20, x19, [sp, #0x40]
1029ca45c: a9057bfd    	stp	x29, x30, [sp, #0x50]
1029ca460: 910143fd    	add	x29, sp, #0x50
1029ca464: aa0203f3    	mov	x19, x2
1029ca468: 900f1368    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1029ca46c: 52800029    	mov	w9, #0x1                ; =1
1029ca470: 39352509    	strb	w9, [x8, #0xd49]
1029ca474: aa0203e0    	mov	x0, x2
1029ca478: 95497330    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029ca47c: b00eb9c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1029ca480: f946e901    	ldr	x1, [x8, #0xdd0] ; length
1029ca484: aa1303e0    	mov	x0, x19
1029ca488: 9549732d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ca48c: b40006a0    	cbz	x0, 0x1029ca560 <_Flutter_Image_provideRelativePathByUrl+0xdd7410>
1029ca490: f00ebd48    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
1029ca494: f9420900    	ldr	x0, [x8, #0x410]
1029ca498: d00eb9a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029ca49c: f946dd01    	ldr	x1, [x8, #0xdb8] ; defaultManager
1029ca4a0: 95497327    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ca4a4: aa1d03fd    	mov	x29, x29
1029ca4a8: 95497328    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029ca4ac: aa0003f4    	mov	x20, x0
1029ca4b0: b40007e0    	cbz	x0, 0x1029ca5ac <_Flutter_Image_provideRelativePathByUrl+0xdd745c>
1029ca4b4: f9000fff    	str	xzr, [sp, #0x18]
1029ca4b8: 900eb9e8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1029ca4bc: f9411101    	ldr	x1, [x8, #0x220] ; removeItemAtPath:error:
1029ca4c0: 910063e3    	add	x3, sp, #0x18
1029ca4c4: aa1403e0    	mov	x0, x20
1029ca4c8: aa1303e2    	mov	x2, x19
1029ca4cc: 9549731c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ca4d0: aa0003f5    	mov	x21, x0
1029ca4d4: f9400ff6    	ldr	x22, [sp, #0x18]
1029ca4d8: aa1603e0    	mov	x0, x22
1029ca4dc: 95497317    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029ca4e0: 370003b5    	tbnz	w21, #0x0, 0x1029ca554 <_Flutter_Image_provideRelativePathByUrl+0xdd7404>
1029ca4e4: b00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029ca4e8: f9453517    	ldr	x23, [x8, #0xa68]
1029ca4ec: b00eb9c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1029ca4f0: f947f901    	ldr	x1, [x8, #0xff0] ; localizedDescription
1029ca4f4: aa1603e0    	mov	x0, x22
1029ca4f8: 95497311    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ca4fc: aa1d03fd    	mov	x29, x29
1029ca500: 95497312    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029ca504: aa0003f8    	mov	x24, x0
1029ca508: f00ea368    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029ca50c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029ca510: a90083f3    	stp	x19, x0, [sp, #0x8]
1029ca514: f00de568    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029ca518: 910c2108    	add	x8, x8, #0x308
1029ca51c: f90003e8    	str	x8, [sp]
1029ca520: d00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029ca524: 9125d063    	add	x3, x3, #0x974
1029ca528: b00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029ca52c: 911554a5    	add	x5, x5, #0x555
1029ca530: b00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029ca534: 9130cce7    	add	x7, x7, #0xc33
1029ca538: aa1703e0    	mov	x0, x23
1029ca53c: 52800082    	mov	w2, #0x4                ; =4
1029ca540: 52800004    	mov	w4, #0x0                ; =0
1029ca544: 52802fe6    	mov	w6, #0x17f              ; =383
1029ca548: 954972fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ca54c: aa1803e0    	mov	x0, x24
1029ca550: 95497301    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029ca554: aa1603e0    	mov	x0, x22
1029ca558: 954972ff    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029ca55c: 14000026    	b	0x1029ca5f4 <_Flutter_Image_provideRelativePathByUrl+0xdd74a4>
1029ca560: b00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029ca564: f9453500    	ldr	x0, [x8, #0xa68]
1029ca568: f00ea368    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029ca56c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029ca570: f00de568    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029ca574: 910b2108    	add	x8, x8, #0x2c8
1029ca578: f90003e8    	str	x8, [sp]
1029ca57c: d00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029ca580: 9125d063    	add	x3, x3, #0x974
1029ca584: b00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029ca588: 911554a5    	add	x5, x5, #0x555
1029ca58c: b00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029ca590: 9130cce7    	add	x7, x7, #0xc33
1029ca594: 52800022    	mov	w2, #0x1                ; =1
1029ca598: 52800004    	mov	w4, #0x0                ; =0
1029ca59c: 52802e66    	mov	w6, #0x173              ; =371
1029ca5a0: 954972e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ca5a4: 52800015    	mov	w21, #0x0               ; =0
1029ca5a8: 14000015    	b	0x1029ca5fc <_Flutter_Image_provideRelativePathByUrl+0xdd74ac>
1029ca5ac: b00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029ca5b0: f9453500    	ldr	x0, [x8, #0xa68]
1029ca5b4: f00ea368    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029ca5b8: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029ca5bc: f00de568    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029ca5c0: 910ba108    	add	x8, x8, #0x2e8
1029ca5c4: f90003e8    	str	x8, [sp]
1029ca5c8: d00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029ca5cc: 9125d063    	add	x3, x3, #0x974
1029ca5d0: b00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029ca5d4: 911554a5    	add	x5, x5, #0x555
1029ca5d8: b00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029ca5dc: 9130cce7    	add	x7, x7, #0xc33
1029ca5e0: 52800022    	mov	w2, #0x1                ; =1
1029ca5e4: 52800004    	mov	w4, #0x0                ; =0
1029ca5e8: 52802f26    	mov	w6, #0x179              ; =377
1029ca5ec: 954972d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ca5f0: 52800015    	mov	w21, #0x0               ; =0
1029ca5f4: aa1403e0    	mov	x0, x20
1029ca5f8: 954972d7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029ca5fc: aa1303e0    	mov	x0, x19
1029ca600: 954972d5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029ca604: aa1503e0    	mov	x0, x21
1029ca608: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1029ca60c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1029ca610: a94357f6    	ldp	x22, x21, [sp, #0x30]
1029ca614: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1029ca618: 910183ff    	add	sp, sp, #0x60
1029ca61c: d65f03c0    	ret
