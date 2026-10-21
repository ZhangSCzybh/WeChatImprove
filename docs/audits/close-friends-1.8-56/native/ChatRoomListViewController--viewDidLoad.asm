
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100ed7730: d10103ff    	sub	sp, sp, #0x40
100ed7734: a90157f6    	stp	x22, x21, [sp, #0x10]
100ed7738: a9024ff4    	stp	x20, x19, [sp, #0x20]
100ed773c: a9037bfd    	stp	x29, x30, [sp, #0x30]
100ed7740: 9100c3fd    	add	x29, sp, #0x30
100ed7744: aa0003f3    	mov	x19, x0
100ed7748: b00feac8    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100ed774c: 52800029    	mov	w9, #0x1                ; =1
100ed7750: 3920cd09    	strb	w9, [x8, #0x833]
100ed7754: f00f9708    	adrp	x8, 0x1201ba000 <dyld_stub_binder+0x1201ba000>
100ed7758: f941a908    	ldr	x8, [x8, #0x350]
100ed775c: a90023e0    	stp	x0, x8, [sp]
100ed7760: b00f7b28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100ed7764: f941a901    	ldr	x1, [x8, #0x350] ; viewDidLoad
100ed7768: 910003e0    	mov	x0, sp
100ed776c: 95b53e76    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
100ed7770: 900f94f6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
100ed7774: f945eac0    	ldr	x0, [x22, #0xbd0]
100ed7778: b00f9148    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100ed777c: f944e914    	ldr	x20, [x8, #0x9d0] ; currentContext
100ed7780: aa1403e1    	mov	x1, x20
100ed7784: 95b53e6e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100ed7788: aa1d03fd    	mov	x29, x29
100ed778c: 95b53e6f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100ed7790: aa0003f5    	mov	x21, x0
100ed7794: b00f94c8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
100ed7798: f9452902    	ldr	x2, [x8, #0xa50]
100ed779c: f00f7b08    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
100ed77a0: f940a101    	ldr	x1, [x8, #0x140] ; registerExtension:withTarget:
100ed77a4: aa1303e3    	mov	x3, x19
100ed77a8: 95b53e65    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100ed77ac: aa1503e0    	mov	x0, x21
100ed77b0: 95b53e69    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100ed77b4: f945eac0    	ldr	x0, [x22, #0xbd0]
100ed77b8: aa1403e1    	mov	x1, x20
100ed77bc: 95b53e60    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100ed77c0: aa1d03fd    	mov	x29, x29
100ed77c4: 95b53e61    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100ed77c8: aa0003f4    	mov	x20, x0
100ed77cc: 900f94e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100ed77d0: f9462900    	ldr	x0, [x8, #0xc50]
100ed77d4: 900f9148    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100ed77d8: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100ed77dc: 95b53e58    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100ed77e0: aa0003e2    	mov	x2, x0
100ed77e4: d00f7b08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100ed77e8: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100ed77ec: aa1403e0    	mov	x0, x20
100ed77f0: 95b53e53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100ed77f4: aa1d03fd    	mov	x29, x29
100ed77f8: 95b53e54    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100ed77fc: aa0003f5    	mov	x21, x0
100ed7800: d00f7b08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100ed7804: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
100ed7808: b00eb302    	adrp	x2, 0x11e538000 <dyld_stub_binder+0x11e538000>
100ed780c: 91232042    	add	x2, x2, #0x8c8
100ed7810: 95b53e4b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100ed7814: aa1d03fd    	mov	x29, x29
100ed7818: 95b53e4c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100ed781c: aa0003f6    	mov	x22, x0
100ed7820: d00f9188    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
100ed7824: f9472101    	ldr	x1, [x8, #0xe40] ; setTitle:
100ed7828: aa1303e0    	mov	x0, x19
100ed782c: aa1603e2    	mov	x2, x22
100ed7830: 95b53e43    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100ed7834: aa1603e0    	mov	x0, x22
100ed7838: 95b53e47    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100ed783c: aa1503e0    	mov	x0, x21
100ed7840: 95b53e45    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100ed7844: aa1403e0    	mov	x0, x20
100ed7848: 95b53e43    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100ed784c: 900f9a68    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
100ed7850: 911a4108    	add	x8, x8, #0x690
100ed7854: b9800108    	ldrsw	x8, [x8]
100ed7858: f8686a60    	ldr	x0, [x19, x8]
100ed785c: b00f7b28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100ed7860: f9435901    	ldr	x1, [x8, #0x6b0] ; setBUsePanGesture:
100ed7864: 52800022    	mov	w2, #0x1                ; =1
100ed7868: 95b53e35    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100ed786c: 900f94e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100ed7870: f9462d00    	ldr	x0, [x8, #0xc58]
100ed7874: b00f7b28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100ed7878: f943d501    	ldr	x1, [x8, #0x7a8] ; BG_2
100ed787c: 95b53e30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100ed7880: aa1d03fd    	mov	x29, x29
100ed7884: 95b53e31    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100ed7888: aa0003f4    	mov	x20, x0
100ed788c: 900f91a8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
100ed7890: f946d501    	ldr	x1, [x8, #0xda8] ; view
100ed7894: aa1303e0    	mov	x0, x19
100ed7898: 95b53e29    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100ed789c: aa1d03fd    	mov	x29, x29
100ed78a0: 95b53e2a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100ed78a4: aa0003f3    	mov	x19, x0
100ed78a8: 900f9188    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
100ed78ac: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
100ed78b0: aa1403e2    	mov	x2, x20
100ed78b4: 95b53e22    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100ed78b8: aa1303e0    	mov	x0, x19
100ed78bc: 95b53e26    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100ed78c0: aa1403e0    	mov	x0, x20
100ed78c4: 95b53e24    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100ed78c8: a9437bfd    	ldp	x29, x30, [sp, #0x30]
100ed78cc: a9424ff4    	ldp	x20, x19, [sp, #0x20]
100ed78d0: a94157f6    	ldp	x22, x21, [sp, #0x10]
100ed78d4: 910103ff    	add	sp, sp, #0x40
100ed78d8: d65f03c0    	ret
