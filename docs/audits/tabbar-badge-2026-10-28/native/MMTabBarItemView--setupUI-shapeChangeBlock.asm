
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10472825c: d10183ff    	sub	sp, sp, #0x60
104728260: a90167fa    	stp	x26, x25, [sp, #0x10]
104728264: a9025ff8    	stp	x24, x23, [sp, #0x20]
104728268: a90357f6    	stp	x22, x21, [sp, #0x30]
10472826c: a9044ff4    	stp	x20, x19, [sp, #0x40]
104728270: a9057bfd    	stp	x29, x30, [sp, #0x50]
104728274: 910143fd    	add	x29, sp, #0x50
104728278: aa0203f5    	mov	x21, x2
10472827c: aa0103f6    	mov	x22, x1
104728280: aa0003f4    	mov	x20, x0
104728284: 91008000    	add	x0, x0, #0x20
104728288: 94d3fbc1    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10472828c: aa0003f3    	mov	x19, x0
104728290: b4000d60    	cbz	x0, 0x10472843c <_Flutter_MMFoundation_BindContext+0xc04020>
104728294: 9100a280    	add	x0, x20, #0x28
104728298: 94d3fbbd    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10472829c: aa0003f4    	mov	x20, x0
1047282a0: eb1502df    	cmp	x22, x21
1047282a4: 54000c80    	b.eq	0x104728434 <_Flutter_MMFoundation_BindContext+0xc04018>
1047282a8: b4000c74    	cbz	x20, 0x104728434 <_Flutter_MMFoundation_BindContext+0xc04018>
1047282ac: f00dd258    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
1047282b0: f9458b16    	ldr	x22, [x24, #0xb10] ; class NSNumber
1047282b4: f00dd248    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1047282b8: f9467900    	ldr	x0, [x8, #0xcf0] ; class CUtility
1047282bc: 900db8c8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1047282c0: f942c501    	ldr	x1, [x8, #0x588] ; selector genCurrentTimeInMsFrom1970
1047282c4: 94d3fb9e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047282c8: aa0003e2    	mov	x2, x0
1047282cc: 900dcee8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1047282d0: f947c901    	ldr	x1, [x8, #0xf90] ; selector numberWithUnsignedLongLong:
1047282d4: aa1603e0    	mov	x0, x22
1047282d8: 94d3fb99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047282dc: aa1d03fd    	mov	x29, x29
1047282e0: 94d3fb9a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047282e4: d00e2b19    	adrp	x25, 0x120c8a000 <dyld_stub_binder+0x120c8a000>
1047282e8: f944ab28    	ldr	x8, [x25, #0x950]
1047282ec: f904ab20    	str	x0, [x25, #0x950]
1047282f0: aa0803e0    	mov	x0, x8
1047282f4: 94d3fb98    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047282f8: f00dba28    	adrp	x8, 0x11fe6f000 <dyld_stub_binder+0x11fe6f000>
1047282fc: f9455d16    	ldr	x22, [x8, #0xab8] ; selector dr_forceChangeExpState
104728300: aa1303e0    	mov	x0, x19
104728304: aa1603e1    	mov	x1, x22
104728308: 94d3fb8d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472830c: aa1d03fd    	mov	x29, x29
104728310: 94d3fb8e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728314: aa0003f7    	mov	x23, x0
104728318: f9400808    	ldr	x8, [x0, #0x10]
10472831c: 52800001    	mov	w1, #0x0                ; =0
104728320: d63f0100    	blr	x8
104728324: aa1d03fd    	mov	x29, x29
104728328: 94d3fb8f    	bl	0x107c27164 <_Flutter_MMFoundation_BindContext+0x4102d48>
10472832c: aa1703e0    	mov	x0, x23
104728330: 94d3fb89    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728334: f00dd248    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104728338: f9454517    	ldr	x23, [x8, #0xa88] ; class NSString
10472833c: f944ab39    	ldr	x25, [x25, #0x950]
104728340: b00dbc88    	adrp	x8, 0x11feb9000 <dyld_stub_binder+0x11feb9000>
104728344: f947a501    	ldr	x1, [x8, #0xf48] ; selector tabIndex
104728348: aa1403e0    	mov	x0, x20
10472834c: 94d3fb7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728350: d00dcf08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104728354: f946a501    	ldr	x1, [x8, #0xd48] ; selector stringWithFormat:
104728358: a90003f9    	stp	x25, x0, [sp]
10472835c: f00d0202    	adrp	x2, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
104728360: 9113a042    	add	x2, x2, #0x4e8 ; CFString '%@_tab_red_dot_%ld'
104728364: aa1703e0    	mov	x0, x23
104728368: 94d3fb75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472836c: aa1d03fd    	mov	x29, x29
104728370: 94d3fb76    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728374: aa0003f7    	mov	x23, x0
104728378: f00dbb28    	adrp	x8, 0x11fe8f000 <dyld_stub_binder+0x11fe8f000>
10472837c: f9477d01    	ldr	x1, [x8, #0xef8] ; selector setDr_viewUniqueId:
104728380: aa1303e0    	mov	x0, x19
104728384: aa1703e2    	mov	x2, x23
104728388: 94d3fb6d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472838c: aa1703e0    	mov	x0, x23
104728390: 94d3fb71    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728394: f00db9c8    	adrp	x8, 0x11fe63000 <dyld_stub_binder+0x11fe63000>
104728398: f940dd01    	ldr	x1, [x8, #0x1b8] ; selector dr_setViewParam
10472839c: aa1303e0    	mov	x0, x19
1047283a0: 94d3fb67    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047283a4: aa1d03fd    	mov	x29, x29
1047283a8: 94d3fb68    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047283ac: aa0003f7    	mov	x23, x0
1047283b0: f9458b00    	ldr	x0, [x24, #0xb10] ; class NSNumber
1047283b4: 900dcee8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1047283b8: f947c101    	ldr	x1, [x8, #0xf80] ; selector numberWithUnsignedInteger:
1047283bc: aa1503e2    	mov	x2, x21
1047283c0: 94d3fb5f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047283c4: aa1d03fd    	mov	x29, x29
1047283c8: 94d3fb60    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047283cc: aa0003f5    	mov	x21, x0
1047283d0: f9400ae8    	ldr	x8, [x23, #0x10]
1047283d4: f00d0201    	adrp	x1, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
1047283d8: 91142021    	add	x1, x1, #0x508 ; CFString 'red_dot_shape'
1047283dc: aa1703e0    	mov	x0, x23
1047283e0: aa1503e2    	mov	x2, x21
1047283e4: d63f0100    	blr	x8
1047283e8: aa1d03fd    	mov	x29, x29
1047283ec: 94d3fb5e    	bl	0x107c27164 <_Flutter_MMFoundation_BindContext+0x4102d48>
1047283f0: aa1503e0    	mov	x0, x21
1047283f4: 94d3fb58    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047283f8: aa1703e0    	mov	x0, x23
1047283fc: 94d3fb56    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728400: aa1303e0    	mov	x0, x19
104728404: aa1603e1    	mov	x1, x22
104728408: 94d3fb4d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472840c: aa1d03fd    	mov	x29, x29
104728410: 94d3fb4e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728414: aa0003f5    	mov	x21, x0
104728418: f9400808    	ldr	x8, [x0, #0x10]
10472841c: 52800021    	mov	w1, #0x1                ; =1
104728420: d63f0100    	blr	x8
104728424: aa1d03fd    	mov	x29, x29
104728428: 94d3fb4f    	bl	0x107c27164 <_Flutter_MMFoundation_BindContext+0x4102d48>
10472842c: aa1503e0    	mov	x0, x21
104728430: 94d3fb49    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728434: aa1403e0    	mov	x0, x20
104728438: 94d3fb47    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10472843c: aa1303e0    	mov	x0, x19
104728440: a9457bfd    	ldp	x29, x30, [sp, #0x50]
104728444: a9444ff4    	ldp	x20, x19, [sp, #0x40]
104728448: a94357f6    	ldp	x22, x21, [sp, #0x30]
10472844c: a9425ff8    	ldp	x24, x23, [sp, #0x20]
104728450: a94167fa    	ldp	x26, x25, [sp, #0x10]
104728454: 910183ff    	add	sp, sp, #0x60
104728458: 14d3fb3f    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
