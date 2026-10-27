
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1046ae32c: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
1046ae330: a90157f6    	stp	x22, x21, [sp, #0x10]
1046ae334: a9024ff4    	stp	x20, x19, [sp, #0x20]
1046ae338: a9037bfd    	stp	x29, x30, [sp, #0x30]
1046ae33c: 9100c3fd    	add	x29, sp, #0x30
1046ae340: aa0203f3    	mov	x19, x2
1046ae344: aa0003f5    	mov	x21, x0
1046ae348: f00e2c68    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
1046ae34c: 52800029    	mov	w9, #0x1                ; =1
1046ae350: 39128509    	strb	w9, [x8, #0x4a1]
1046ae354: aa0203e0    	mov	x0, x2
1046ae358: 94d5e378    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1046ae35c: d00dbd28    	adrp	x8, 0x11fe54000 <dyld_stub_binder+0x11fe54000>
1046ae360: f940e114    	ldr	x20, [x8, #0x1c0] ; sortTimeOverride
1046ae364: aa1503e0    	mov	x0, x21
1046ae368: aa1403e1    	mov	x1, x20
1046ae36c: 94d5e374    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae370: f00dbc77    	adrp	x23, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1046ae374: f94136e8    	ldr	x8, [x23, #0x268] ; m_uLastTime
1046ae378: 7100001f    	cmp	w0, #0x0
1046ae37c: 9a940101    	csel	x1, x8, x20, eq
1046ae380: aa1503e0    	mov	x0, x21
1046ae384: 94d5e36e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae388: aa0003f6    	mov	x22, x0
1046ae38c: aa1303e0    	mov	x0, x19
1046ae390: aa1403e1    	mov	x1, x20
1046ae394: 94d5e36a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae398: f94136e8    	ldr	x8, [x23, #0x268] ; m_uLastTime
1046ae39c: 7100001f    	cmp	w0, #0x0
1046ae3a0: 9a940101    	csel	x1, x8, x20, eq
1046ae3a4: aa1303e0    	mov	x0, x19
1046ae3a8: 94d5e365    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae3ac: aa0003f4    	mov	x20, x0
1046ae3b0: f00dbca8    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
1046ae3b4: f9413117    	ldr	x23, [x8, #0x260] ; m_bIsTop
1046ae3b8: aa1503e0    	mov	x0, x21
1046ae3bc: aa1703e1    	mov	x1, x23
1046ae3c0: 94d5e35f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae3c4: 340000a0    	cbz	w0, 0x1046ae3d8 <_Flutter_MMFoundation_BindContext+0xb89fbc>
1046ae3c8: aa1303e0    	mov	x0, x19
1046ae3cc: aa1703e1    	mov	x1, x23
1046ae3d0: 94d5e35b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae3d4: 340006e0    	cbz	w0, 0x1046ae4b0 <_Flutter_MMFoundation_BindContext+0xb8a094>
1046ae3d8: aa1503e0    	mov	x0, x21
1046ae3dc: aa1703e1    	mov	x1, x23
1046ae3e0: 94d5e357    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae3e4: 370000e0    	tbnz	w0, #0x0, 0x1046ae400 <_Flutter_MMFoundation_BindContext+0xb89fe4>
1046ae3e8: aa1303e0    	mov	x0, x19
1046ae3ec: aa1703e1    	mov	x1, x23
1046ae3f0: 94d5e353    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae3f4: 36000060    	tbz	w0, #0x0, 0x1046ae400 <_Flutter_MMFoundation_BindContext+0xb89fe4>
1046ae3f8: 52800034    	mov	w20, #0x1               ; =1
1046ae3fc: 1400002e    	b	0x1046ae4b4 <_Flutter_MMFoundation_BindContext+0xb8a098>
1046ae400: aa1503e0    	mov	x0, x21
1046ae404: aa1703e1    	mov	x1, x23
1046ae408: 94d5e34d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae40c: 340001a0    	cbz	w0, 0x1046ae440 <_Flutter_MMFoundation_BindContext+0xb8a024>
1046ae410: aa1303e0    	mov	x0, x19
1046ae414: aa1703e1    	mov	x1, x23
1046ae418: 94d5e349    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae41c: 34000120    	cbz	w0, 0x1046ae440 <_Flutter_MMFoundation_BindContext+0xb8a024>
1046ae420: b00dbfa8    	adrp	x8, 0x11fea3000 <dyld_stub_binder+0x11fea3000>
1046ae424: f947d917    	ldr	x23, [x8, #0xfb0] ; m_uTopTime
1046ae428: aa1503e0    	mov	x0, x21
1046ae42c: aa1703e1    	mov	x1, x23
1046ae430: 94d5e343    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae434: 6b0002df    	cmp	w22, w0
1046ae438: 1a8082d5    	csel	w21, w22, w0, hi
1046ae43c: 14000014    	b	0x1046ae48c <_Flutter_MMFoundation_BindContext+0xb8a070>
1046ae440: d00dbfa8    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
1046ae444: f9401118    	ldr	x24, [x8, #0x20] ; m_uUnTopTime
1046ae448: aa1503e0    	mov	x0, x21
1046ae44c: aa1803e1    	mov	x1, x24
1046ae450: 94d5e33b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae454: 6b0002df    	cmp	w22, w0
1046ae458: 1a8082d6    	csel	w22, w22, w0, hi
1046ae45c: 900dbfc8    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1046ae460: f946b517    	ldr	x23, [x8, #0xd68] ; sortTime
1046ae464: aa1503e0    	mov	x0, x21
1046ae468: aa1703e1    	mov	x1, x23
1046ae46c: 94d5e334    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae470: 6b0002df    	cmp	w22, w0
1046ae474: 1a8082d5    	csel	w21, w22, w0, hi
1046ae478: aa1303e0    	mov	x0, x19
1046ae47c: aa1803e1    	mov	x1, x24
1046ae480: 94d5e32f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae484: 6b00029f    	cmp	w20, w0
1046ae488: 1a808294    	csel	w20, w20, w0, hi
1046ae48c: aa1303e0    	mov	x0, x19
1046ae490: aa1703e1    	mov	x1, x23
1046ae494: 94d5e32a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae498: 6b00029f    	cmp	w20, w0
1046ae49c: 1a808288    	csel	w8, w20, w0, hi
1046ae4a0: 6b0802bf    	cmp	w21, w8
1046ae4a4: 1a9f07e8    	cset	w8, ne
1046ae4a8: da9f9114    	csinv	x20, x8, xzr, ls
1046ae4ac: 14000002    	b	0x1046ae4b4 <_Flutter_MMFoundation_BindContext+0xb8a098>
1046ae4b0: 92800014    	mov	x20, #-0x1              ; =-1
1046ae4b4: aa1303e0    	mov	x0, x19
1046ae4b8: 94d5e327    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1046ae4bc: aa1403e0    	mov	x0, x20
1046ae4c0: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1046ae4c4: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1046ae4c8: a94157f6    	ldp	x22, x21, [sp, #0x10]
1046ae4cc: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1046ae4d0: d65f03c0    	ret
