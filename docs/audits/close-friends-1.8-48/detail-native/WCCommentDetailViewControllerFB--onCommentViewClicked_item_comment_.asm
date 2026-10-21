
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106ead4e8: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
106ead4ec: a90157f6    	stp	x22, x21, [sp, #0x10]
106ead4f0: a9024ff4    	stp	x20, x19, [sp, #0x20]
106ead4f4: a9037bfd    	stp	x29, x30, [sp, #0x30]
106ead4f8: 9100c3fd    	add	x29, sp, #0x30
106ead4fc: aa0403f3    	mov	x19, x4
106ead500: aa0303f4    	mov	x20, x3
106ead504: aa0203f5    	mov	x21, x2
106ead508: aa0003f6    	mov	x22, x0
106ead50c: f00c7ce8    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
106ead510: f9468917    	ldr	x23, [x8, #0xd10] ; exitSelectState
106ead514: aa0403e0    	mov	x0, x4
106ead518: 9435e708    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106ead51c: aa1403e0    	mov	x0, x20
106ead520: 9435e706    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106ead524: aa1503e0    	mov	x0, x21
106ead528: 9435e704    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106ead52c: aa1603e0    	mov	x0, x22
106ead530: aa1703e1    	mov	x1, x23
106ead534: 9435e702    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ead538: b00c8a88    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106ead53c: f9472501    	ldr	x1, [x8, #0xe48] ; onClickContent:way:
106ead540: aa1603e0    	mov	x0, x22
106ead544: aa1503e2    	mov	x2, x21
106ead548: d2800003    	mov	x3, #0x0                ; =0
106ead54c: 9435e6fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ead550: aa1503e0    	mov	x0, x21
106ead554: 9435e700    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ead558: 900c9cc8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106ead55c: b984ad08    	ldrsw	x8, [x8, #0x4ac]
106ead560: f8686ad5    	ldr	x21, [x22, x8]
106ead564: 900c7cc8    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
106ead568: f940cd01    	ldr	x1, [x8, #0x198] ; tid
106ead56c: aa1403e0    	mov	x0, x20
106ead570: 9435e6f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ead574: aa1d03fd    	mov	x29, x29
106ead578: 9435e6f4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ead57c: aa0003f6    	mov	x22, x0
106ead580: aa1403e0    	mov	x0, x20
106ead584: 9435e6f4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ead588: b00c8a88    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106ead58c: f947a501    	ldr	x1, [x8, #0xf48] ; recordClickForFeed:comment:
106ead590: aa1503e0    	mov	x0, x21
106ead594: aa1603e2    	mov	x2, x22
106ead598: aa1303e3    	mov	x3, x19
106ead59c: 9435e6e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ead5a0: aa1303e0    	mov	x0, x19
106ead5a4: 9435e6ec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ead5a8: aa1603e0    	mov	x0, x22
106ead5ac: a9437bfd    	ldp	x29, x30, [sp, #0x30]
106ead5b0: a9424ff4    	ldp	x20, x19, [sp, #0x20]
106ead5b4: a94157f6    	ldp	x22, x21, [sp, #0x10]
106ead5b8: a8c45ff8    	ldp	x24, x23, [sp], #0x40
106ead5bc: 1435e6e6    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
