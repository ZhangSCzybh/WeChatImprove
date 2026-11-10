
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002a933c: f00fa4a8    	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
1002a9340: 52800029    	mov	w9, #0x1                ; =1
1002a9344: 3923b909    	strb	w9, [x8, #0x8ee]
1002a9348: f9401808    	ldr	x8, [x0, #0x30]
1002a934c: f100051f    	cmp	x8, #0x1
1002a9350: 540009e1    	b.ne	0x1002a948c <__text+0x2a148c>
1002a9354: d10203ff    	sub	sp, sp, #0x80
1002a9358: a90557f6    	stp	x22, x21, [sp, #0x50]
1002a935c: a9064ff4    	stp	x20, x19, [sp, #0x60]
1002a9360: a9077bfd    	stp	x29, x30, [sp, #0x70]
1002a9364: 9101c3fd    	add	x29, sp, #0x70
1002a9368: aa0003f3    	mov	x19, x0
1002a936c: f9400408    	ldr	x8, [x0, #0x8]
1002a9370: f9401d00    	ldr	x0, [x8, #0x38]
1002a9374: b4000840    	cbz	x0, 0x1002a947c <__text+0x2a147c>
1002a9378: 95e5f3ef    	bl	0x107c26334 <_Flutter_MMFoundation_BindContext+0x3ead000>
1002a937c: 340002e0    	cbz	w0, 0x1002a93d8 <__text+0x2a13d8>
1002a9380: aa0003f4    	mov	x20, x0
1002a9384: b00f5348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002a9388: f9430d15    	ldr	x21, [x8, #0x618]
1002a938c: 95e58dcf    	bl	0x107c0cac8 <_Flutter_MMFoundation_BindContext+0x3e93794>
1002a9390: 900f3908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002a9394: f9418901    	ldr	x1, [x8, #0x310]
1002a9398: 900cc8c8    	adrp	x8, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a939c: 912d6d08    	add	x8, x8, #0xb5b
1002a93a0: a90123f4    	stp	x20, x8, [sp, #0x10]
1002a93a4: f00e6788    	adrp	x8, 0x11cf9c000 <dyld_stub_binder+0x11cf9c000>
1002a93a8: 910ce108    	add	x8, x8, #0x338
1002a93ac: a90003e8    	stp	x8, x0, [sp]
1002a93b0: 900cc8c5    	adrp	x5, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a93b4: 9120a4a5    	add	x5, x5, #0x829
1002a93b8: 900cc8c7    	adrp	x7, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a93bc: 912dc8e7    	add	x7, x7, #0xb72
1002a93c0: aa1503e0    	mov	x0, x21
1002a93c4: 52800082    	mov	w2, #0x4                ; =4
1002a93c8: d2800003    	mov	x3, #0x0                ; =0
1002a93cc: 52800004    	mov	w4, #0x0                ; =0
1002a93d0: 52803906    	mov	w6, #0x1c8              ; =456
1002a93d4: 95e5fa24    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a93d8: f00f5008    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
1002a93dc: f944c101    	ldr	x1, [x8, #0x980]
1002a93e0: aa1303e0    	mov	x0, x19
1002a93e4: 52800042    	mov	w2, #0x2                ; =2
1002a93e8: 95e5fa1f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a93ec: d100a3a0    	sub	x0, x29, #0x28
1002a93f0: aa1303e1    	mov	x1, x19
1002a93f4: 95e5fa19    	bl	0x107c27c58 <_Flutter_MMFoundation_BindContext+0x3eae924>
1002a93f8: f00ea508    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1002a93fc: f9449908    	ldr	x8, [x8, #0x930]
1002a9400: f90013e8    	str	x8, [sp, #0x20]
1002a9404: d00bb0e8    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
1002a9408: fd434100    	ldr	d0, [x8, #0x680]
1002a940c: 90000008    	adrp	x8, 0x1002a9000 <__text+0x2a1000>
1002a9410: 91124108    	add	x8, x8, #0x490
1002a9414: fd0017e0    	str	d0, [sp, #0x28]
1002a9418: f00dfea9    	adrp	x9, 0x11c280000 <dyld_stub_binder+0x11c280000>
1002a941c: 91110129    	add	x9, x9, #0x440
1002a9420: a90327e8    	stp	x8, x9, [sp, #0x30]
1002a9424: 910083f3    	add	x19, sp, #0x20
1002a9428: 91008260    	add	x0, x19, #0x20
1002a942c: d100a3a1    	sub	x1, x29, #0x28
1002a9430: 95e5fa00    	bl	0x107c27c30 <_Flutter_MMFoundation_BindContext+0x3eae8fc>
1002a9434: b00f5348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002a9438: f9447d00    	ldr	x0, [x8, #0x8f8]
1002a943c: f00f4fe8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1002a9440: f9446501    	ldr	x1, [x8, #0x8c8]
1002a9444: 95e5fa08    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9448: 340000a0    	cbz	w0, 0x1002a945c <__text+0x2a145c>
1002a944c: f9401be8    	ldr	x8, [sp, #0x30]
1002a9450: 910083e0    	add	x0, sp, #0x20
1002a9454: d63f0100    	blr	x8
1002a9458: 14000005    	b	0x1002a946c <__text+0x2a146c>
1002a945c: f00ea500    	adrp	x0, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1002a9460: f9454c00    	ldr	x0, [x0, #0xa98]
1002a9464: 910083e1    	add	x1, sp, #0x20
1002a9468: 95e58dcd    	bl	0x107c0cb9c <_Flutter_MMFoundation_BindContext+0x3e93868>
1002a946c: 91008260    	add	x0, x19, #0x20
1002a9470: 95e5f9f1    	bl	0x107c27c34 <_Flutter_MMFoundation_BindContext+0x3eae900>
1002a9474: d100a3a0    	sub	x0, x29, #0x28
1002a9478: 95e5f9ef    	bl	0x107c27c34 <_Flutter_MMFoundation_BindContext+0x3eae900>
1002a947c: a9477bfd    	ldp	x29, x30, [sp, #0x70]
1002a9480: a9464ff4    	ldp	x20, x19, [sp, #0x60]
1002a9484: a94557f6    	ldp	x22, x21, [sp, #0x50]
1002a9488: 910203ff    	add	sp, sp, #0x80
1002a948c: d65f03c0    	ret
1002a9490: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
1002a9494: a90157f6    	stp	x22, x21, [sp, #0x10]
1002a9498: a9024ff4    	stp	x20, x19, [sp, #0x20]
1002a949c: a9037bfd    	stp	x29, x30, [sp, #0x30]
1002a94a0: 9100c3fd    	add	x29, sp, #0x30
1002a94a4: 91008000    	add	x0, x0, #0x20
1002a94a8: 95e5f9ed    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1002a94ac: aa0003f3    	mov	x19, x0
1002a94b0: b40003e0    	cbz	x0, 0x1002a952c <__text+0x2a152c>
1002a94b4: f9400668    	ldr	x8, [x19, #0x8]
1002a94b8: 9103e100    	add	x0, x8, #0xf8
1002a94bc: 95e5f9e8    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1002a94c0: b4000360    	cbz	x0, 0x1002a952c <__text+0x2a152c>
1002a94c4: aa0003f5    	mov	x21, x0
1002a94c8: f9400668    	ldr	x8, [x19, #0x8]
1002a94cc: 9103e100    	add	x0, x8, #0xf8
1002a94d0: 95e5f9e3    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1002a94d4: aa0003f6    	mov	x22, x0
1002a94d8: b00f3988    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
1002a94dc: f9456514    	ldr	x20, [x8, #0xac8]
1002a94e0: b00f5008    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
1002a94e4: f9440501    	ldr	x1, [x8, #0x808]
1002a94e8: aa1403e2    	mov	x2, x20
1002a94ec: 95e5f9de    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a94f0: aa0003f7    	mov	x23, x0
1002a94f4: aa1603e0    	mov	x0, x22
1002a94f8: 95e5f9de    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002a94fc: aa1503e0    	mov	x0, x21
1002a9500: 95e5f9dc    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002a9504: 34000157    	cbz	w23, 0x1002a952c <__text+0x2a152c>
1002a9508: f9400668    	ldr	x8, [x19, #0x8]
1002a950c: 9103e100    	add	x0, x8, #0xf8
1002a9510: 95e5f9d3    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1002a9514: aa0003f5    	mov	x21, x0
1002a9518: aa1403e1    	mov	x1, x20
1002a951c: aa1303e2    	mov	x2, x19
1002a9520: 95e5f9d1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9524: aa1503e0    	mov	x0, x21
1002a9528: 95e5f9d2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002a952c: aa1303e0    	mov	x0, x19
1002a9530: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1002a9534: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1002a9538: a94157f6    	ldp	x22, x21, [sp, #0x10]
1002a953c: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1002a9540: 15e5f9cc    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
