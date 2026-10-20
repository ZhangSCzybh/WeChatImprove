
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1017e04fc: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
1017e0500: a90157f6    	stp	x22, x21, [sp, #0x10]
1017e0504: a9024ff4    	stp	x20, x19, [sp, #0x20]
1017e0508: a9037bfd    	stp	x29, x30, [sp, #0x30]
1017e050c: 9100c3fd    	add	x29, sp, #0x30
1017e0510: aa0303f5    	mov	x21, x3
1017e0514: aa0003f4    	mov	x20, x0
1017e0518: d00fa288    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
1017e051c: 52800029    	mov	w9, #0x1                ; =1
1017e0520: 3929ad09    	strb	w9, [x8, #0xa6b]
1017e0524: d00f3628    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1017e0528: f9424913    	ldr	x19, [x8, #0x490] ; tableViewContext
1017e052c: aa0303e0    	mov	x0, x3
1017e0530: 95911b02    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1017e0534: aa1403e0    	mov	x0, x20
1017e0538: aa1303e1    	mov	x1, x19
1017e053c: 95911b00    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e0540: aa1d03fd    	mov	x29, x29
1017e0544: 95911b01    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e0548: aa0003f6    	mov	x22, x0
1017e054c: d00f4948    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1017e0550: f947bd01    	ldr	x1, [x8, #0xf78] ; tableView
1017e0554: 95911afa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e0558: aa1d03fd    	mov	x29, x29
1017e055c: 95911afb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e0560: aa0003f7    	mov	x23, x0
1017e0564: 900f32e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1017e0568: f9416101    	ldr	x1, [x8, #0x2c0] ; cellForRowAtIndexPath:
1017e056c: aa1503e2    	mov	x2, x21
1017e0570: 95911af3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e0574: aa1d03fd    	mov	x29, x29
1017e0578: 95911af4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e057c: aa0003f3    	mov	x19, x0
1017e0580: aa1503e0    	mov	x0, x21
1017e0584: 95911af4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e0588: aa1703e0    	mov	x0, x23
1017e058c: 95911af2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e0590: aa1603e0    	mov	x0, x22
1017e0594: 95911af0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e0598: f00f4c88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1017e059c: f9461d00    	ldr	x0, [x8, #0xc38]
1017e05a0: f00f48e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1017e05a4: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1017e05a8: 95911ae5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e05ac: aa0003e2    	mov	x2, x0
1017e05b0: f00f4908    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1017e05b4: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
1017e05b8: aa1303e0    	mov	x0, x19
1017e05bc: 95911ae0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e05c0: 340003a0    	cbz	w0, 0x1017e0634 <__text+0x17d8634>
1017e05c4: b00f3388    	adrp	x8, 0x11fe51000 <dyld_stub_binder+0x11fe51000>
1017e05c8: f940d915    	ldr	x21, [x8, #0x1b0] ; router
1017e05cc: aa1303e0    	mov	x0, x19
1017e05d0: 95911ada    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1017e05d4: aa1403e0    	mov	x0, x20
1017e05d8: aa1503e1    	mov	x1, x21
1017e05dc: 95911ad8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e05e0: aa1d03fd    	mov	x29, x29
1017e05e4: 95911ad9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e05e8: aa0003f4    	mov	x20, x0
1017e05ec: b00f32c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1017e05f0: f9463901    	ldr	x1, [x8, #0xc70] ; contact
1017e05f4: aa1303e0    	mov	x0, x19
1017e05f8: 95911ad1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e05fc: aa1d03fd    	mov	x29, x29
1017e0600: 95911ad2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e0604: aa0003f5    	mov	x21, x0
1017e0608: aa1303e0    	mov	x0, x19
1017e060c: 95911ad2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e0610: f00f3528    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
1017e0614: f943fd01    	ldr	x1, [x8, #0x7f8] ; openMessageContentView:
1017e0618: aa1403e0    	mov	x0, x20
1017e061c: aa1503e2    	mov	x2, x21
1017e0620: 95911ac7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e0624: aa1503e0    	mov	x0, x21
1017e0628: 95911acb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e062c: aa1403e0    	mov	x0, x20
1017e0630: 95911ac9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e0634: aa1303e0    	mov	x0, x19
1017e0638: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1017e063c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1017e0640: a94157f6    	ldp	x22, x21, [sp, #0x10]
1017e0644: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1017e0648: 15911ac3    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
