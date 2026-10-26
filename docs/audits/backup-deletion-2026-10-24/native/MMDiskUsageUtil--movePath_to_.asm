
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029ca620: d10203ff    	sub	sp, sp, #0x80
1029ca624: a90367fa    	stp	x26, x25, [sp, #0x30]
1029ca628: a9045ff8    	stp	x24, x23, [sp, #0x40]
1029ca62c: a90557f6    	stp	x22, x21, [sp, #0x50]
1029ca630: a9064ff4    	stp	x20, x19, [sp, #0x60]
1029ca634: a9077bfd    	stp	x29, x30, [sp, #0x70]
1029ca638: 9101c3fd    	add	x29, sp, #0x70
1029ca63c: aa0303f4    	mov	x20, x3
1029ca640: aa0203f3    	mov	x19, x2
1029ca644: 900f1368    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1029ca648: 52800029    	mov	w9, #0x1                ; =1
1029ca64c: 39352909    	strb	w9, [x8, #0xd4a]
1029ca650: aa0203e0    	mov	x0, x2
1029ca654: 954972b9    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029ca658: aa1403e0    	mov	x0, x20
1029ca65c: 954972b7    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029ca660: b00eb9c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1029ca664: f946e915    	ldr	x21, [x8, #0xdd0] ; length
1029ca668: aa1303e0    	mov	x0, x19
1029ca66c: aa1503e1    	mov	x1, x21
1029ca670: 954972b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ca674: b4000740    	cbz	x0, 0x1029ca75c <_Flutter_Image_provideRelativePathByUrl+0xdd760c>
1029ca678: aa1403e0    	mov	x0, x20
1029ca67c: aa1503e1    	mov	x1, x21
1029ca680: 954972af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ca684: b40008e0    	cbz	x0, 0x1029ca7a0 <_Flutter_Image_provideRelativePathByUrl+0xdd7650>
1029ca688: f00ebd48    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
1029ca68c: f9420900    	ldr	x0, [x8, #0x410]
1029ca690: d00eb9a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029ca694: f946dd01    	ldr	x1, [x8, #0xdb8] ; defaultManager
1029ca698: 954972a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ca69c: aa1d03fd    	mov	x29, x29
1029ca6a0: 954972aa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029ca6a4: aa0003f5    	mov	x21, x0
1029ca6a8: b4000a20    	cbz	x0, 0x1029ca7ec <_Flutter_Image_provideRelativePathByUrl+0xdd769c>
1029ca6ac: f90017ff    	str	xzr, [sp, #0x28]
1029ca6b0: d00eb9c8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1029ca6b4: f944c901    	ldr	x1, [x8, #0x990] ; moveItemAtPath:toPath:error:
1029ca6b8: 9100a3e4    	add	x4, sp, #0x28
1029ca6bc: aa1503e0    	mov	x0, x21
1029ca6c0: aa1303e2    	mov	x2, x19
1029ca6c4: aa1403e3    	mov	x3, x20
1029ca6c8: 9549729d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ca6cc: aa0003f6    	mov	x22, x0
1029ca6d0: f94017f7    	ldr	x23, [sp, #0x28]
1029ca6d4: aa1703e0    	mov	x0, x23
1029ca6d8: 95497298    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029ca6dc: 370003b6    	tbnz	w22, #0x0, 0x1029ca750 <_Flutter_Image_provideRelativePathByUrl+0xdd7600>
1029ca6e0: b00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029ca6e4: f9453518    	ldr	x24, [x8, #0xa68]
1029ca6e8: b00eb9c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1029ca6ec: f947f901    	ldr	x1, [x8, #0xff0] ; localizedDescription
1029ca6f0: aa1703e0    	mov	x0, x23
1029ca6f4: 95497292    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ca6f8: aa1d03fd    	mov	x29, x29
1029ca6fc: 95497293    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029ca700: aa0003f9    	mov	x25, x0
1029ca704: f00ea368    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029ca708: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029ca70c: a90103f4    	stp	x20, x0, [sp, #0x10]
1029ca710: f00de568    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029ca714: 910e2108    	add	x8, x8, #0x388
1029ca718: a9004fe8    	stp	x8, x19, [sp]
1029ca71c: d00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029ca720: 9125d063    	add	x3, x3, #0x974
1029ca724: b00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029ca728: 911554a5    	add	x5, x5, #0x555
1029ca72c: b00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029ca730: 9132a8e7    	add	x7, x7, #0xcaa
1029ca734: aa1803e0    	mov	x0, x24
1029ca738: 52800082    	mov	w2, #0x4                ; =4
1029ca73c: 52800004    	mov	w4, #0x0                ; =0
1029ca740: 52803306    	mov	w6, #0x198              ; =408
1029ca744: 9549727e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ca748: aa1903e0    	mov	x0, x25
1029ca74c: 95497282    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029ca750: aa1703e0    	mov	x0, x23
1029ca754: 95497280    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029ca758: 14000037    	b	0x1029ca834 <_Flutter_Image_provideRelativePathByUrl+0xdd76e4>
1029ca75c: b00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029ca760: f9453500    	ldr	x0, [x8, #0xa68]
1029ca764: f00ea368    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029ca768: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029ca76c: f00de568    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029ca770: 910ca108    	add	x8, x8, #0x328
1029ca774: f90003e8    	str	x8, [sp]
1029ca778: d00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029ca77c: 9125d063    	add	x3, x3, #0x974
1029ca780: b00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029ca784: 911554a5    	add	x5, x5, #0x555
1029ca788: b00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029ca78c: 9132a8e7    	add	x7, x7, #0xcaa
1029ca790: 52800022    	mov	w2, #0x1                ; =1
1029ca794: 52800004    	mov	w4, #0x0                ; =0
1029ca798: 528030e6    	mov	w6, #0x187              ; =391
1029ca79c: 14000011    	b	0x1029ca7e0 <_Flutter_Image_provideRelativePathByUrl+0xdd7690>
1029ca7a0: b00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029ca7a4: f9453500    	ldr	x0, [x8, #0xa68]
1029ca7a8: f00ea368    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029ca7ac: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029ca7b0: f00de568    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029ca7b4: 910d2108    	add	x8, x8, #0x348
1029ca7b8: f90003e8    	str	x8, [sp]
1029ca7bc: d00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029ca7c0: 9125d063    	add	x3, x3, #0x974
1029ca7c4: b00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029ca7c8: 911554a5    	add	x5, x5, #0x555
1029ca7cc: b00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029ca7d0: 9132a8e7    	add	x7, x7, #0xcaa
1029ca7d4: 52800022    	mov	w2, #0x1                ; =1
1029ca7d8: 52800004    	mov	w4, #0x0                ; =0
1029ca7dc: 52803186    	mov	w6, #0x18c              ; =396
1029ca7e0: 95497257    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ca7e4: 52800016    	mov	w22, #0x0               ; =0
1029ca7e8: 14000015    	b	0x1029ca83c <_Flutter_Image_provideRelativePathByUrl+0xdd76ec>
1029ca7ec: b00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029ca7f0: f9453500    	ldr	x0, [x8, #0xa68]
1029ca7f4: f00ea368    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029ca7f8: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029ca7fc: f00de568    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029ca800: 910da108    	add	x8, x8, #0x368
1029ca804: f90003e8    	str	x8, [sp]
1029ca808: d00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029ca80c: 9125d063    	add	x3, x3, #0x974
1029ca810: b00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029ca814: 911554a5    	add	x5, x5, #0x555
1029ca818: b00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029ca81c: 9132a8e7    	add	x7, x7, #0xcaa
1029ca820: 52800022    	mov	w2, #0x1                ; =1
1029ca824: 52800004    	mov	w4, #0x0                ; =0
1029ca828: 52803246    	mov	w6, #0x192              ; =402
1029ca82c: 95497244    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ca830: 52800016    	mov	w22, #0x0               ; =0
1029ca834: aa1503e0    	mov	x0, x21
1029ca838: 95497247    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029ca83c: aa1403e0    	mov	x0, x20
1029ca840: 95497245    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029ca844: aa1303e0    	mov	x0, x19
1029ca848: 95497243    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029ca84c: aa1603e0    	mov	x0, x22
1029ca850: a9477bfd    	ldp	x29, x30, [sp, #0x70]
1029ca854: a9464ff4    	ldp	x20, x19, [sp, #0x60]
1029ca858: a94557f6    	ldp	x22, x21, [sp, #0x50]
1029ca85c: a9445ff8    	ldp	x24, x23, [sp, #0x40]
1029ca860: a94367fa    	ldp	x26, x25, [sp, #0x30]
1029ca864: 910203ff    	add	sp, sp, #0x80
1029ca868: d65f03c0    	ret
