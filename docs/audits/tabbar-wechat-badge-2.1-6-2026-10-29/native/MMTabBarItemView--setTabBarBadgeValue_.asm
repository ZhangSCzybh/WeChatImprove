
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1047272b0: d101c3ff    	sub	sp, sp, #0x70
1047272b4: a90267fa    	stp	x26, x25, [sp, #0x20]
1047272b8: a9035ff8    	stp	x24, x23, [sp, #0x30]
1047272bc: a90457f6    	stp	x22, x21, [sp, #0x40]
1047272c0: a9054ff4    	stp	x20, x19, [sp, #0x50]
1047272c4: a9067bfd    	stp	x29, x30, [sp, #0x60]
1047272c8: 910183fd    	add	x29, sp, #0x60
1047272cc: aa0203f4    	mov	x20, x2
1047272d0: aa0003f3    	mov	x19, x0
1047272d4: d00e28a8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
1047272d8: 52800029    	mov	w9, #0x1                ; =1
1047272dc: 391a1509    	strb	w9, [x8, #0x685]
1047272e0: 900dd278    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
1047272e4: f9453717    	ldr	x23, [x24, #0xa68] ; class iConsole
1047272e8: 900dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
1047272ec: b98a0919    	ldrsw	x25, [x8, #0xa08]
1047272f0: f8796800    	ldr	x0, [x0, x25]
1047272f4: f00dcec8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1047272f8: f945f516    	ldr	x22, [x8, #0xbe8] ; selector index
1047272fc: aa1603e1    	mov	x1, x22
104727300: 94d3ff8f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727304: d00db888    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104727308: f942a915    	ldr	x21, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
10472730c: a90083f4    	stp	x20, x0, [sp, #0x8]
104727310: 900d0228    	adrp	x8, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
104727314: 9110a108    	add	x8, x8, #0x428 ; CFString 'set badge value %ld for index %ld'
104727318: f90003e8    	str	x8, [sp]
10472731c: b00b8385    	adrp	x5, 0x11b798000 <dyld_stub_binder+0x11b798000>
104727320: 913feca5    	add	x5, x5, #0xffb ; string 'MMTabBarItemView.mm'
104727324: d00b8387    	adrp	x7, 0x11b799000 <dyld_stub_binder+0x11b799000>
104727328: 91003ce7    	add	x7, x7, #0xf ; string '-[MMTabBarItemView setTabBarBadgeValue:]'
10472732c: aa1703e0    	mov	x0, x23
104727330: aa1503e1    	mov	x1, x21
104727334: 52800042    	mov	w2, #0x2                ; =2
104727338: d2800003    	mov	x3, #0x0                ; =0
10472733c: 52800004    	mov	w4, #0x0                ; =0
104727340: 52800986    	mov	w6, #0x4c               ; =76
104727344: 94d3ff7e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727348: 900dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
10472734c: b98a151a    	ldrsw	x26, [x8, #0xa14]
104727350: f87a6a68    	ldr	x8, [x19, x26]
104727354: eb14011f    	cmp	x8, x20
104727358: 54000280    	b.eq	0x1047273a8 <_Flutter_MMFoundation_BindContext+0xc02f8c>
10472735c: f9453717    	ldr	x23, [x24, #0xa68] ; class iConsole
104727360: f8796a60    	ldr	x0, [x19, x25]
104727364: aa1603e1    	mov	x1, x22
104727368: 94d3ff75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472736c: a90083f4    	stp	x20, x0, [sp, #0x8]
104727370: 900d0228    	adrp	x8, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
104727374: 91112108    	add	x8, x8, #0x448 ; CFString 'TRDTemp set badge value %ld for index %ld'
104727378: f90003e8    	str	x8, [sp]
10472737c: b00b8385    	adrp	x5, 0x11b798000 <dyld_stub_binder+0x11b798000>
104727380: 913feca5    	add	x5, x5, #0xffb ; string 'MMTabBarItemView.mm'
104727384: d00b8387    	adrp	x7, 0x11b799000 <dyld_stub_binder+0x11b799000>
104727388: 91003ce7    	add	x7, x7, #0xf ; string '-[MMTabBarItemView setTabBarBadgeValue:]'
10472738c: aa1703e0    	mov	x0, x23
104727390: aa1503e1    	mov	x1, x21
104727394: 52800042    	mov	w2, #0x2                ; =2
104727398: d2800003    	mov	x3, #0x0                ; =0
10472739c: 52800004    	mov	w4, #0x0                ; =0
1047273a0: 528009c6    	mov	w6, #0x4e               ; =78
1047273a4: 94d3ff66    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047273a8: f83a6a74    	str	x20, [x19, x26]
1047273ac: 900dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
1047273b0: b98a1908    	ldrsw	x8, [x8, #0xa18]
1047273b4: f8686a60    	ldr	x0, [x19, x8]
1047273b8: f8286a7f    	str	xzr, [x19, x8]
1047273bc: 94d3ff66    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047273c0: f100069f    	cmp	x20, #0x1
1047273c4: 5400058b    	b.lt	0x104727474 <_Flutter_MMFoundation_BindContext+0xc03058>
1047273c8: 900dd268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1047273cc: f9454500    	ldr	x0, [x8, #0xa88] ; class NSString
1047273d0: f00dcf08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1047273d4: f946a501    	ldr	x1, [x8, #0xd48] ; selector stringWithFormat:
1047273d8: f90003f4    	str	x20, [sp]
1047273dc: f00cecc2    	adrp	x2, 0x11e4c2000 <dyld_stub_binder+0x11e4c2000>
1047273e0: 913d2042    	add	x2, x2, #0xf48 ; CFString '%ld'
1047273e4: 94d3ff56    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047273e8: aa1d03fd    	mov	x29, x29
1047273ec: 94d3ff57    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047273f0: b4000420    	cbz	x0, 0x104727474 <_Flutter_MMFoundation_BindContext+0xc03058>
1047273f4: aa0003f5    	mov	x21, x0
1047273f8: 900dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
1047273fc: b98a1116    	ldrsw	x22, [x8, #0xa10]
104727400: f8766a60    	ldr	x0, [x19, x22]
104727404: b00dcf08    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104727408: f9411101    	ldr	x1, [x8, #0x220] ; selector setHidden:
10472740c: 52800002    	mov	w2, #0x0                ; =0
104727410: 94d3ff4b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727414: f8766a60    	ldr	x0, [x19, x22]
104727418: f00dcf08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10472741c: f940bd01    	ldr	x1, [x8, #0x178] ; selector setValue:
104727420: aa1403e2    	mov	x2, x20
104727424: 94d3ff46    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727428: f8766a60    	ldr	x0, [x19, x22]
10472742c: 900db9e8    	adrp	x8, 0x11fe63000 <dyld_stub_binder+0x11fe63000>
104727430: f940dd01    	ldr	x1, [x8, #0x1b8] ; selector dr_setViewParam
104727434: 94d3ff42    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727438: aa1d03fd    	mov	x29, x29
10472743c: 94d3ff43    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104727440: aa0003f4    	mov	x20, x0
104727444: f9400808    	ldr	x8, [x0, #0x10]
104727448: b00cf4c1    	adrp	x1, 0x11e5c0000 <dyld_stub_binder+0x11e5c0000>
10472744c: 9123a021    	add	x1, x1, #0x8e8 ; CFString 'red_dot_content'
104727450: aa1503e2    	mov	x2, x21
104727454: d63f0100    	blr	x8
104727458: aa1d03fd    	mov	x29, x29
10472745c: 94d3ff42    	bl	0x107c27164 <_Flutter_MMFoundation_BindContext+0x4102d48>
104727460: aa1403e0    	mov	x0, x20
104727464: 94d3ff3c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104727468: aa1503e0    	mov	x0, x21
10472746c: 94d3ff3a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104727470: 14000008    	b	0x104727490 <_Flutter_MMFoundation_BindContext+0xc03074>
104727474: 900dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
104727478: b98a1108    	ldrsw	x8, [x8, #0xa10]
10472747c: f8686a60    	ldr	x0, [x19, x8]
104727480: b00dcf08    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104727484: f9411101    	ldr	x1, [x8, #0x220] ; selector setHidden:
104727488: 52800022    	mov	w2, #0x1                ; =1
10472748c: 94d3ff2c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727490: b00dbce8    	adrp	x8, 0x11fec4000 <dyld_stub_binder+0x11fec4000>
104727494: f9479d01    	ldr	x1, [x8, #0xf38] ; selector layoutBadgeView
104727498: aa1303e0    	mov	x0, x19
10472749c: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1047274a0: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1047274a4: a94457f6    	ldp	x22, x21, [sp, #0x40]
1047274a8: a9435ff8    	ldp	x24, x23, [sp, #0x30]
1047274ac: a94267fa    	ldp	x26, x25, [sp, #0x20]
1047274b0: 9101c3ff    	add	sp, sp, #0x70
1047274b4: 14d3ff22    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
