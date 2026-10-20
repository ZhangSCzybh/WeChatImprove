
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f563cc: d10243ff    	sub	sp, sp, #0x90
100f563d0: 6d0233ed    	stp	d13, d12, [sp, #0x20]
100f563d4: 6d032beb    	stp	d11, d10, [sp, #0x30]
100f563d8: 6d0423e9    	stp	d9, d8, [sp, #0x40]
100f563dc: a9055ff8    	stp	x24, x23, [sp, #0x50]
100f563e0: a90657f6    	stp	x22, x21, [sp, #0x60]
100f563e4: a9074ff4    	stp	x20, x19, [sp, #0x70]
100f563e8: a9087bfd    	stp	x29, x30, [sp, #0x80]
100f563ec: 910203fd    	add	x29, sp, #0x80
100f563f0: 1e604068    	fmov	d8, d3
100f563f4: 1e604049    	fmov	d9, d2
100f563f8: 1e60402a    	fmov	d10, d1
100f563fc: 1e60400b    	fmov	d11, d0
100f56400: aa0003f3    	mov	x19, x0
100f56404: d00fe6c8    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100f56408: 52800029    	mov	w9, #0x1                ; =1
100f5640c: 39285509    	strb	w9, [x8, #0xa15]
100f56410: 1e60400c    	fmov	d12, d0
100f56414: f00bf148    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
100f56418: fd41cd00    	ldr	d0, [x8, #0x398]
100f5641c: 1e602060    	fcmp	d3, d0
100f56420: 5400026d    	b.le	0x100f5646c <__text+0xf4e46c>
100f56424: b00f90e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f56428: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
100f5642c: f00f7708    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f56430: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
100f56434: f9000bf3    	str	x19, [sp, #0x10]
100f56438: fd0007e8    	str	d8, [sp, #0x8]
100f5643c: d00eaf48    	adrp	x8, 0x11e540000 <dyld_stub_binder+0x11e540000>
100f56440: 912aa108    	add	x8, x8, #0xaa8
100f56444: f90003e8    	str	x8, [sp]
100f56448: b00d2045    	adrp	x5, 0x11b35f000 <dyld_stub_binder+0x11b35f000>
100f5644c: 911b4ca5    	add	x5, x5, #0x6d3
100f56450: b00d2047    	adrp	x7, 0x11b35f000 <dyld_stub_binder+0x11b35f000>
100f56454: 911ccce7    	add	x7, x7, #0x733
100f56458: 52800082    	mov	w2, #0x4                ; =4
100f5645c: d2800003    	mov	x3, #0x0                ; =0
100f56460: 52800004    	mov	w4, #0x0                ; =0
100f56464: 52804a06    	mov	w6, #0x250              ; =592
100f56468: 95b34335    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5646c: f00f9488    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100f56470: b9849908    	ldrsw	x8, [x8, #0x498]
100f56474: 8b080268    	add	x8, x19, x8
100f56478: 6d00290c    	stp	d12, d10, [x8]
100f5647c: 6d012109    	stp	d9, d8, [x8, #0x10]
100f56480: 900f7748    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
100f56484: f9410914    	ldr	x20, [x8, #0x210] ; viewModel
100f56488: aa1303e0    	mov	x0, x19
100f5648c: aa1403e1    	mov	x1, x20
100f56490: 95b3432b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56494: aa1d03fd    	mov	x29, x29
100f56498: 95b3432c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f5649c: aa0003f7    	mov	x23, x0
100f564a0: b00f7748    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100f564a4: f946d515    	ldr	x21, [x8, #0xda8] ; bgBubbleInfo
100f564a8: aa1503e1    	mov	x1, x21
100f564ac: 95b34324    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f564b0: aa1d03fd    	mov	x29, x29
100f564b4: 95b34325    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f564b8: aa0003f8    	mov	x24, x0
100f564bc: d00f7968    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f564c0: f9466516    	ldr	x22, [x8, #0xcc8] ; margin
100f564c4: aa1603e1    	mov	x1, x22
100f564c8: 95b3431d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f564cc: 1e61292d    	fadd	d13, d9, d1
100f564d0: aa1803e0    	mov	x0, x24
100f564d4: 95b34320    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f564d8: aa1703e0    	mov	x0, x23
100f564dc: 95b3431e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f564e0: aa1303e0    	mov	x0, x19
100f564e4: aa1403e1    	mov	x1, x20
100f564e8: 95b34315    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f564ec: aa1d03fd    	mov	x29, x29
100f564f0: 95b34316    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f564f4: aa0003f7    	mov	x23, x0
100f564f8: b00f7748    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100f564fc: f940d501    	ldr	x1, [x8, #0x1a8] ; isSender
100f56500: 95b3430f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56504: aa0003f8    	mov	x24, x0
100f56508: aa1703e0    	mov	x0, x23
100f5650c: 95b34312    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56510: 37000278    	tbnz	w24, #0x0, 0x100f5655c <__text+0xf4e55c>
100f56514: aa1303e0    	mov	x0, x19
100f56518: aa1403e1    	mov	x1, x20
100f5651c: 95b34308    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56520: aa1d03fd    	mov	x29, x29
100f56524: 95b34309    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56528: aa0003f4    	mov	x20, x0
100f5652c: aa1503e1    	mov	x1, x21
100f56530: 95b34303    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56534: aa1d03fd    	mov	x29, x29
100f56538: 95b34304    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f5653c: aa0003f5    	mov	x21, x0
100f56540: aa1603e1    	mov	x1, x22
100f56544: 95b342fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56548: 1e61396c    	fsub	d12, d11, d1
100f5654c: aa1503e0    	mov	x0, x21
100f56550: 95b34301    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56554: aa1403e0    	mov	x0, x20
100f56558: 95b342ff    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f5655c: f00f9488    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100f56560: b9849515    	ldrsw	x21, [x8, #0x494]
100f56564: f8756a60    	ldr	x0, [x19, x21]
100f56568: d00f8d88    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
100f5656c: f9403514    	ldr	x20, [x8, #0x68] ; setFrame:
100f56570: aa1403e1    	mov	x1, x20
100f56574: 1e604180    	fmov	d0, d12
100f56578: 1e604141    	fmov	d1, d10
100f5657c: 1e6041a2    	fmov	d2, d13
100f56580: 1e604103    	fmov	d3, d8
100f56584: 95b342ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56588: f8756a60    	ldr	x0, [x19, x21]
100f5658c: f00f8d48    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
100f56590: f945a101    	ldr	x1, [x8, #0xb40] ; frame
100f56594: 95b342ea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56598: f00f9488    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100f5659c: b984a908    	ldrsw	x8, [x8, #0x4a8]
100f565a0: f8686a60    	ldr	x0, [x19, x8]
100f565a4: aa1403e1    	mov	x1, x20
100f565a8: 95b342e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f565ac: f00f9488    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100f565b0: b9847d08    	ldrsw	x8, [x8, #0x47c]
100f565b4: f8686a60    	ldr	x0, [x19, x8]
100f565b8: b40001e0    	cbz	x0, 0x100f565f4 <__text+0xf4e5f4>
100f565bc: aa1403e1    	mov	x1, x20
100f565c0: 1e604160    	fmov	d0, d11
100f565c4: 1e604141    	fmov	d1, d10
100f565c8: 1e604122    	fmov	d2, d9
100f565cc: 1e604103    	fmov	d3, d8
100f565d0: a9487bfd    	ldp	x29, x30, [sp, #0x80]
100f565d4: a9474ff4    	ldp	x20, x19, [sp, #0x70]
100f565d8: a94657f6    	ldp	x22, x21, [sp, #0x60]
100f565dc: a9455ff8    	ldp	x24, x23, [sp, #0x50]
100f565e0: 6d4423e9    	ldp	d9, d8, [sp, #0x40]
100f565e4: 6d432beb    	ldp	d11, d10, [sp, #0x30]
100f565e8: 6d4233ed    	ldp	d13, d12, [sp, #0x20]
100f565ec: 910243ff    	add	sp, sp, #0x90
100f565f0: 15b342d3    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f565f4: a9487bfd    	ldp	x29, x30, [sp, #0x80]
100f565f8: a9474ff4    	ldp	x20, x19, [sp, #0x70]
100f565fc: a94657f6    	ldp	x22, x21, [sp, #0x60]
100f56600: a9455ff8    	ldp	x24, x23, [sp, #0x50]
100f56604: 6d4423e9    	ldp	d9, d8, [sp, #0x40]
100f56608: 6d432beb    	ldp	d11, d10, [sp, #0x30]
100f5660c: 6d4233ed    	ldp	d13, d12, [sp, #0x20]
100f56610: 910243ff    	add	sp, sp, #0x90
100f56614: d65f03c0    	ret