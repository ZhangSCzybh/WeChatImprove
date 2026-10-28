
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105182434: d100c3ff    	sub	sp, sp, #0x30
105182438: a9014ff4    	stp	x20, x19, [sp, #0x10]
10518243c: a9027bfd    	stp	x29, x30, [sp, #0x20]
105182440: 910083fd    	add	x29, sp, #0x20
105182444: aa0003f3    	mov	x19, x0
105182448: b00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10518244c: f9453500    	ldr	x0, [x8, #0xa68]
105182450: f00d65a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105182454: f942a901    	ldr	x1, [x8, #0x550]
105182458: b00cb2a8    	adrp	x8, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
10518245c: 913ba108    	add	x8, x8, #0xee8
105182460: f90003e8    	str	x8, [sp]
105182464: d00b0ee3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
105182468: 91270063    	add	x3, x3, #0x9c0
10518246c: 900b36e5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105182470: 912b00a5    	add	x5, x5, #0xac0
105182474: 900b36e7    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105182478: 9135f0e7    	add	x7, x7, #0xd7c
10518247c: 52800042    	mov	w2, #0x2                ; =2
105182480: 52800004    	mov	w4, #0x0                ; =0
105182484: 52803286    	mov	w6, #0x194              ; =404
105182488: 94aa932d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10518248c: aa1303e0    	mov	x0, x19
105182490: 94aa932a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105182494: 94aa934a    	bl	0x107c271bc <_Flutter_MMFoundation_BindContext+0x4102da0>
105182498: d00d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10518249c: b9892908    	ldrsw	x8, [x8, #0x928]
1051824a0: b8686a69    	ldr	w9, [x19, x8]
1051824a4: 7100193f    	cmp	w9, #0x6
1051824a8: 540000c0    	b.eq	0x1051824c0 <_Flutter_MMFoundation_BindContext+0x165e0a4>
1051824ac: 52800069    	mov	w9, #0x3                ; =3
1051824b0: b8286a69    	str	w9, [x19, x8]
1051824b4: 528002e0    	mov	w0, #0x17               ; =23
1051824b8: 52800041    	mov	w1, #0x2                ; =2
1051824bc: 94aa28ca    	bl	0x107c0c7e4 <_Flutter_MMFoundation_BindContext+0x40e83c8>
1051824c0: aa1303e0    	mov	x0, x19
1051824c4: 94aa934c    	bl	0x107c271f4 <_Flutter_MMFoundation_BindContext+0x4102dd8>
1051824c8: aa1303e0    	mov	x0, x19
1051824cc: 94aa9322    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051824d0: 52801200    	mov	w0, #0x90               ; =144
1051824d4: 52800281    	mov	w1, #0x14               ; =20
1051824d8: 52800022    	mov	w2, #0x1                ; =1
1051824dc: 52800003    	mov	w3, #0x0                ; =0
1051824e0: 52800004    	mov	w4, #0x0                ; =0
1051824e4: 97373726    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
1051824e8: d00d70c8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
1051824ec: f942d101    	ldr	x1, [x8, #0x5a0]
1051824f0: aa1303e0    	mov	x0, x19
1051824f4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1051824f8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1051824fc: 9100c3ff    	add	sp, sp, #0x30
105182500: 14aa930f    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
