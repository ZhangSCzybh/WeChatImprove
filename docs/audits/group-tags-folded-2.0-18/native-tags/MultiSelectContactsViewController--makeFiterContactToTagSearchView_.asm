
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104eac5f4: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
104eac5f8: a90167fa    	stp	x26, x25, [sp, #0x10]
104eac5fc: a9025ff8    	stp	x24, x23, [sp, #0x20]
104eac600: a90357f6    	stp	x22, x21, [sp, #0x30]
104eac604: a9044ff4    	stp	x20, x19, [sp, #0x40]
104eac608: a9057bfd    	stp	x29, x30, [sp, #0x50]
104eac60c: 910143fd    	add	x29, sp, #0x50
104eac610: d10703ff    	sub	sp, sp, #0x1c0
104eac614: aa0203f3    	mov	x19, x2
104eac618: aa0003f6    	mov	x22, x0
104eac61c: f00c3a08    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104eac620: f9405908    	ldr	x8, [x8, #0xb0]
104eac624: f9400108    	ldr	x8, [x8]
104eac628: f81a03a8    	stur	x8, [x29, #-0x60]
104eac62c: f00dec88    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
104eac630: 52800029    	mov	w9, #0x1                ; =1
104eac634: 39084d09    	strb	w9, [x8, #0x213]
104eac638: aa0203e0    	mov	x0, x2
104eac63c: 94b5eabf    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104eac640: 900d9648    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104eac644: f9434100    	ldr	x0, [x8, #0x680]
104eac648: 94b5eac4    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104eac64c: f90013e0    	str	x0, [sp, #0x20]
104eac650: 4f00e400    	movi.16b	v0, #0x0
104eac654: ad0383e0    	stp	q0, q0, [sp, #0x70]
104eac658: ad0483e0    	stp	q0, q0, [sp, #0x90]
104eac65c: aa1303e0    	mov	x0, x19
104eac660: 94b5eab6    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104eac664: 900d92a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104eac668: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
104eac66c: 9101c3e2    	add	x2, sp, #0x70
104eac670: d10383a3    	sub	x3, x29, #0xe0
104eac674: a9004fe1    	stp	x1, x19, [sp]
104eac678: 52800204    	mov	w4, #0x10               ; =16
104eac67c: 94b5eab0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eac680: b4000780    	cbz	x0, 0x104eac770 <_Flutter_MMFoundation_BindContext+0x1388354>
104eac684: aa0003f7    	mov	x23, x0
104eac688: f94043e8    	ldr	x8, [sp, #0x80]
104eac68c: f9400114    	ldr	x20, [x8]
104eac690: d280001b    	mov	x27, #0x0               ; =0
104eac694: 900d7ee8    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
104eac698: f942dd18    	ldr	x24, [x8, #0x5b8] ; onFilterContactCandidate:
104eac69c: f00d7c68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104eac6a0: f9434d19    	ldr	x25, [x8, #0x698] ; m_nsUsrName
104eac6a4: f00d92a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104eac6a8: f946e91a    	ldr	x26, [x8, #0xdd0] ; length
104eac6ac: d00d7c68    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104eac6b0: f943c508    	ldr	x8, [x8, #0x788] ; safeAddObject:
104eac6b4: f90017e8    	str	x8, [sp, #0x28]
104eac6b8: f94043e8    	ldr	x8, [sp, #0x80]
104eac6bc: f9400108    	ldr	x8, [x8]
104eac6c0: eb14011f    	cmp	x8, x20
104eac6c4: 54000060    	b.eq	0x104eac6d0 <_Flutter_MMFoundation_BindContext+0x13882b4>
104eac6c8: f94007e0    	ldr	x0, [sp, #0x8]
104eac6cc: 94b5eaa1    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
104eac6d0: f9403fe8    	ldr	x8, [sp, #0x78]
104eac6d4: f87b791c    	ldr	x28, [x8, x27, lsl #3]
104eac6d8: aa1603e0    	mov	x0, x22
104eac6dc: aa1803e1    	mov	x1, x24
104eac6e0: aa1c03e2    	mov	x2, x28
104eac6e4: 94b5ea96    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eac6e8: 34000300    	cbz	w0, 0x104eac748 <_Flutter_MMFoundation_BindContext+0x138832c>
104eac6ec: aa1c03e0    	mov	x0, x28
104eac6f0: aa1903e1    	mov	x1, x25
104eac6f4: 94b5ea92    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eac6f8: aa1d03fd    	mov	x29, x29
104eac6fc: 94b5ea93    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eac700: aa0003f5    	mov	x21, x0
104eac704: aa1a03e1    	mov	x1, x26
104eac708: 94b5ea8d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eac70c: aa0003f3    	mov	x19, x0
104eac710: aa1503e0    	mov	x0, x21
104eac714: 94b5ea90    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eac718: b4000193    	cbz	x19, 0x104eac748 <_Flutter_MMFoundation_BindContext+0x138832c>
104eac71c: aa1c03e0    	mov	x0, x28
104eac720: aa1903e1    	mov	x1, x25
104eac724: 94b5ea86    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eac728: aa1d03fd    	mov	x29, x29
104eac72c: 94b5ea87    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eac730: aa0003f3    	mov	x19, x0
104eac734: a94207e0    	ldp	x0, x1, [sp, #0x20]
104eac738: aa1303e2    	mov	x2, x19
104eac73c: 94b5ea80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eac740: aa1303e0    	mov	x0, x19
104eac744: 94b5ea84    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eac748: 9100077b    	add	x27, x27, #0x1
104eac74c: eb1b02ff    	cmp	x23, x27
104eac750: 54fffb41    	b.ne	0x104eac6b8 <_Flutter_MMFoundation_BindContext+0x138829c>
104eac754: 9101c3e2    	add	x2, sp, #0x70
104eac758: d10383a3    	sub	x3, x29, #0xe0
104eac75c: a94003e1    	ldp	x1, x0, [sp]
104eac760: 52800204    	mov	w4, #0x10               ; =16
104eac764: 94b5ea76    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eac768: aa0003f7    	mov	x23, x0
104eac76c: b5fff920    	cbnz	x0, 0x104eac690 <_Flutter_MMFoundation_BindContext+0x1388274>
104eac770: f94007e0    	ldr	x0, [sp, #0x8]
104eac774: 94b5ea78    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eac778: f00d9628    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104eac77c: f9455500    	ldr	x0, [x8, #0xaa8]
104eac780: 94b5ea76    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104eac784: f9000be0    	str	x0, [sp, #0x10]
104eac788: 4f00e400    	movi.16b	v0, #0x0
104eac78c: ad0183e0    	stp	q0, q0, [sp, #0x30]
104eac790: ad0283e0    	stp	q0, q0, [sp, #0x50]
104eac794: f94013e0    	ldr	x0, [sp, #0x20]
104eac798: 94b5ea68    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104eac79c: 9100c3e2    	add	x2, sp, #0x30
104eac7a0: 9102c3e3    	add	x3, sp, #0xb0
104eac7a4: f94003e1    	ldr	x1, [sp]
104eac7a8: 52800204    	mov	w4, #0x10               ; =16
104eac7ac: 94b5ea64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eac7b0: b40008e0    	cbz	x0, 0x104eac8cc <_Flutter_MMFoundation_BindContext+0x13884b0>
104eac7b4: aa0003f7    	mov	x23, x0
104eac7b8: f94023e8    	ldr	x8, [sp, #0x40]
104eac7bc: f9400108    	ldr	x8, [x8]
104eac7c0: f90017e8    	str	x8, [sp, #0x28]
104eac7c4: d280001c    	mov	x28, #0x0               ; =0
104eac7c8: 900d92a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104eac7cc: f944e918    	ldr	x24, [x8, #0x9d0] ; currentContext
104eac7d0: f00d9288    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104eac7d4: f947ad19    	ldr	x25, [x8, #0xf58] ; class
104eac7d8: b00d7c68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104eac7dc: f946411a    	ldr	x26, [x8, #0xc80] ; getService:
104eac7e0: 900d7c88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104eac7e4: f940c91b    	ldr	x27, [x8, #0x190] ; getContactByName:
104eac7e8: d00d7c68    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104eac7ec: f943c508    	ldr	x8, [x8, #0x788] ; safeAddObject:
104eac7f0: f9000fe8    	str	x8, [sp, #0x18]
104eac7f4: f94023e8    	ldr	x8, [sp, #0x40]
104eac7f8: f9400108    	ldr	x8, [x8]
104eac7fc: f94017e9    	ldr	x9, [sp, #0x28]
104eac800: eb09011f    	cmp	x8, x9
104eac804: 54000060    	b.eq	0x104eac810 <_Flutter_MMFoundation_BindContext+0x13883f4>
104eac808: f94013e0    	ldr	x0, [sp, #0x20]
104eac80c: 94b5ea51    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
104eac810: f9401fe8    	ldr	x8, [sp, #0x38]
104eac814: f87c7913    	ldr	x19, [x8, x28, lsl #3]
104eac818: f00d9628    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104eac81c: f945e900    	ldr	x0, [x8, #0xbd0]
104eac820: aa1803e1    	mov	x1, x24
104eac824: 94b5ea46    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eac828: aa1d03fd    	mov	x29, x29
104eac82c: 94b5ea47    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eac830: aa0003f4    	mov	x20, x0
104eac834: 900d9648    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104eac838: f9401500    	ldr	x0, [x8, #0x28] ; P;,
104eac83c: aa1903e1    	mov	x1, x25
104eac840: 94b5ea3f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eac844: aa0003e2    	mov	x2, x0
104eac848: aa1403e0    	mov	x0, x20
104eac84c: aa1a03e1    	mov	x1, x26
104eac850: 94b5ea3b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eac854: aa1d03fd    	mov	x29, x29
104eac858: 94b5ea3c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eac85c: aa0003f6    	mov	x22, x0
104eac860: aa1b03e1    	mov	x1, x27
104eac864: aa1303e2    	mov	x2, x19
104eac868: 94b5ea35    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eac86c: aa1d03fd    	mov	x29, x29
104eac870: 94b5ea36    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eac874: aa0003f5    	mov	x21, x0
104eac878: aa1603e0    	mov	x0, x22
104eac87c: 94b5ea36    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eac880: aa1403e0    	mov	x0, x20
104eac884: 94b5ea34    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eac888: b4000095    	cbz	x21, 0x104eac898 <_Flutter_MMFoundation_BindContext+0x138847c>
104eac88c: a94107e0    	ldp	x0, x1, [sp, #0x10]
104eac890: aa1503e2    	mov	x2, x21
104eac894: 94b5ea2a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eac898: aa1503e0    	mov	x0, x21
104eac89c: 94b5ea2e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eac8a0: 9100079c    	add	x28, x28, #0x1
104eac8a4: eb1c02ff    	cmp	x23, x28
104eac8a8: 54fffa61    	b.ne	0x104eac7f4 <_Flutter_MMFoundation_BindContext+0x13883d8>
104eac8ac: 9100c3e2    	add	x2, sp, #0x30
104eac8b0: 9102c3e3    	add	x3, sp, #0xb0
104eac8b4: f94013e0    	ldr	x0, [sp, #0x20]
104eac8b8: f94003e1    	ldr	x1, [sp]
104eac8bc: 52800204    	mov	w4, #0x10               ; =16
104eac8c0: 94b5ea1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eac8c4: aa0003f7    	mov	x23, x0
104eac8c8: b5fff7e0    	cbnz	x0, 0x104eac7c4 <_Flutter_MMFoundation_BindContext+0x13883a8>
104eac8cc: f94013f3    	ldr	x19, [sp, #0x20]
104eac8d0: aa1303e0    	mov	x0, x19
104eac8d4: 94b5ea20    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eac8d8: aa1303e0    	mov	x0, x19
104eac8dc: 94b5ea1e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eac8e0: f94007e0    	ldr	x0, [sp, #0x8]
104eac8e4: 94b5ea1c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eac8e8: f85a03a8    	ldur	x8, [x29, #-0x60]
104eac8ec: f00c3a09    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104eac8f0: f9405929    	ldr	x9, [x9, #0xb0]
104eac8f4: f9400129    	ldr	x9, [x9]
104eac8f8: eb08013f    	cmp	x9, x8
104eac8fc: 54000141    	b.ne	0x104eac924 <_Flutter_MMFoundation_BindContext+0x1388508>
104eac900: f9400be0    	ldr	x0, [sp, #0x10]
104eac904: 910703ff    	add	sp, sp, #0x1c0
104eac908: a9457bfd    	ldp	x29, x30, [sp, #0x50]
104eac90c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
104eac910: a94357f6    	ldp	x22, x21, [sp, #0x30]
104eac914: a9425ff8    	ldp	x24, x23, [sp, #0x20]
104eac918: a94167fa    	ldp	x26, x25, [sp, #0x10]
104eac91c: a8c66ffc    	ldp	x28, x27, [sp], #0x60
104eac920: 14b5ea14    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
104eac924: 94b5ea14    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
