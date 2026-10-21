
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101c164e8: d10143ff    	sub	sp, sp, #0x50
101c164ec: a9015ff8    	stp	x24, x23, [sp, #0x10]
101c164f0: a90257f6    	stp	x22, x21, [sp, #0x20]
101c164f4: a9034ff4    	stp	x20, x19, [sp, #0x30]
101c164f8: a9047bfd    	stp	x29, x30, [sp, #0x40]
101c164fc: 910103fd    	add	x29, sp, #0x40
101c16500: aa0203f3    	mov	x19, x2
101c16504: aa0003f5    	mov	x21, x0
101c16508: b00f80e8    	adrp	x8, 0x120c33000 <dyld_stub_binder+0x120c33000>
101c1650c: 52800029    	mov	w9, #0x1                ; =1
101c16510: 39243109    	strb	w9, [x8, #0x90c]
101c16514: aa0203e0    	mov	x0, x2
101c16518: 95804308    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c1651c: d00f2748    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101c16520: f946f101    	ldr	x1, [x8, #0xde0] ; delegate
101c16524: aa1503e0    	mov	x0, x21
101c16528: 95804305    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c1652c: aa1d03fd    	mov	x29, x29
101c16530: 95804306    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c16534: aa0003f6    	mov	x22, x0
101c16538: f00f1508    	adrp	x8, 0x11feb9000 <dyld_stub_binder+0x11feb9000>
101c1653c: f946d501    	ldr	x1, [x8, #0xda8] ; getPluginTopViewController
101c16540: 958042ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c16544: aa1d03fd    	mov	x29, x29
101c16548: 95804300    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c1654c: aa0003f4    	mov	x20, x0
101c16550: aa1603e0    	mov	x0, x22
101c16554: 95804300    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c16558: b40007b4    	cbz	x20, 0x101c1664c <_Flutter_Image_provideRelativePathByUrl+0x234fc>
101c1655c: 900f2b08    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
101c16560: f9441500    	ldr	x0, [x8, #0x828]
101c16564: 958042fd    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
101c16568: aa0003f6    	mov	x22, x0
101c1656c: b00f1188    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
101c16570: f9449d01    	ldr	x1, [x8, #0x938] ; setDataItem:
101c16574: aa1303e2    	mov	x2, x19
101c16578: 958042f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c1657c: d00f1128    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101c16580: f9471101    	ldr	x1, [x8, #0xe20] ; username
101c16584: aa1303e0    	mov	x0, x19
101c16588: 958042ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c1658c: aa1d03fd    	mov	x29, x29
101c16590: 958042ee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c16594: aa0003f7    	mov	x23, x0
101c16598: d00f1528    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c1659c: f9413101    	ldr	x1, [x8, #0x260] ; setNsUsrName:
101c165a0: aa1603e0    	mov	x0, x22
101c165a4: aa1703e2    	mov	x2, x23
101c165a8: 958042e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c165ac: aa1703e0    	mov	x0, x23
101c165b0: 958042e9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c165b4: 900f1528    	adrp	x8, 0x11feba000 <dyld_stub_binder+0x11feba000>
101c165b8: f9460501    	ldr	x1, [x8, #0xc08] ; setHomepageType:
101c165bc: aa1603e0    	mov	x0, x22
101c165c0: d2800002    	mov	x2, #0x0                ; =0
101c165c4: 958042de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c165c8: d00f1528    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c165cc: f9414101    	ldr	x1, [x8, #0x280] ; isPrivate:
101c165d0: aa1503e0    	mov	x0, x21
101c165d4: aa1303e2    	mov	x2, x19
101c165d8: 958042d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c165dc: 340000c0    	cbz	w0, 0x101c165f4 <_Flutter_Image_provideRelativePathByUrl+0x234a4>
101c165e0: d00f1528    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c165e4: f9414501    	ldr	x1, [x8, #0x288] ; setBForbideComment:
101c165e8: aa1603e0    	mov	x0, x22
101c165ec: 52800022    	mov	w2, #0x1                ; =1
101c165f0: 958042d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c165f4: f00f1108    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101c165f8: f946d101    	ldr	x1, [x8, #0xda0] ; setM_delegate:
101c165fc: aa1603e0    	mov	x0, x22
101c16600: aa1503e2    	mov	x2, x21
101c16604: 958042ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c16608: d00f2768    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101c1660c: f945dd01    	ldr	x1, [x8, #0xbb8] ; navigationController
101c16610: aa1403e0    	mov	x0, x20
101c16614: 958042ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c16618: aa1d03fd    	mov	x29, x29
101c1661c: 958042cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c16620: aa0003f5    	mov	x21, x0
101c16624: b00f1128    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101c16628: f944e101    	ldr	x1, [x8, #0x9c0] ; PushViewController:animated:
101c1662c: aa1603e2    	mov	x2, x22
101c16630: 52800023    	mov	w3, #0x1                ; =1
101c16634: 958042c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c16638: aa1503e0    	mov	x0, x21
101c1663c: 958042c6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c16640: aa1603e0    	mov	x0, x22
101c16644: 958042c4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c16648: 14000011    	b	0x101c1668c <_Flutter_Image_provideRelativePathByUrl+0x2353c>
101c1664c: b00f2ae8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101c16650: f9453500    	ldr	x0, [x8, #0xa68]
101c16654: f00f1108    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101c16658: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
101c1665c: f00e4d88    	adrp	x8, 0x11e5c9000 <dyld_stub_binder+0x11e5c9000>
101c16660: 9136a108    	add	x8, x8, #0xda8
101c16664: f90003e8    	str	x8, [sp]
101c16668: f00cc165    	adrp	x5, 0x11b445000 <dyld_stub_binder+0x11b445000>
101c1666c: 911ea8a5    	add	x5, x5, #0x7aa
101c16670: b00cc187    	adrp	x7, 0x11b447000 <dyld_stub_binder+0x11b447000>
101c16674: 9131f4e7    	add	x7, x7, #0xc7d
101c16678: 52800082    	mov	w2, #0x4                ; =4
101c1667c: d2800003    	mov	x3, #0x0                ; =0
101c16680: 52800004    	mov	w4, #0x0                ; =0
101c16684: 528156e6    	mov	w6, #0xab7              ; =2743
101c16688: 958042ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c1668c: aa1403e0    	mov	x0, x20
101c16690: 958042b1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c16694: aa1303e0    	mov	x0, x19
101c16698: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101c1669c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101c166a0: a94257f6    	ldp	x22, x21, [sp, #0x20]
101c166a4: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101c166a8: 910143ff    	add	sp, sp, #0x50
101c166ac: 158042aa    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
