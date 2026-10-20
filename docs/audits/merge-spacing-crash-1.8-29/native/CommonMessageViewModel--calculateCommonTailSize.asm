
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f692c8: d10203ff    	sub	sp, sp, #0x80
100f692cc: 6d0223e9    	stp	d9, d8, [sp, #0x20]
100f692d0: a90367fa    	stp	x26, x25, [sp, #0x30]
100f692d4: a9045ff8    	stp	x24, x23, [sp, #0x40]
100f692d8: a90557f6    	stp	x22, x21, [sp, #0x50]
100f692dc: a9064ff4    	stp	x20, x19, [sp, #0x60]
100f692e0: a9077bfd    	stp	x29, x30, [sp, #0x70]
100f692e4: 9101c3fd    	add	x29, sp, #0x70
100f692e8: aa0003f4    	mov	x20, x0
100f692ec: d00e3428    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
100f692f0: f9405908    	ldr	x8, [x8, #0xb0]
100f692f4: f9400108    	ldr	x8, [x8]
100f692f8: f9000fe8    	str	x8, [sp, #0x18]
100f692fc: f00fe628    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100f69300: 52800029    	mov	w9, #0x1                ; =1
100f69304: 39295d09    	strb	w9, [x8, #0xa57]
100f69308: f00f78c8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f6930c: f947b501    	ldr	x1, [x8, #0xf68] ; hasCommonTail
100f69310: 95b2f78b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69314: 36000f40    	tbz	w0, #0x0, 0x100f694fc <__text+0xf614fc>
100f69318: b00f76a8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
100f6931c: f9410501    	ldr	x1, [x8, #0x208] ; messageWrap
100f69320: aa1403e0    	mov	x0, x20
100f69324: 95b2f786    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69328: aa1d03fd    	mov	x29, x29
100f6932c: 95b2f787    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f69330: aa0003f5    	mov	x21, x0
100f69334: 900f78e8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f69338: f9411101    	ldr	x1, [x8, #0x220] ; commonTail
100f6933c: 95b2f780    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69340: aa1d03fd    	mov	x29, x29
100f69344: 95b2f781    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f69348: aa0003f6    	mov	x22, x0
100f6934c: 900f78e8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f69350: f9411501    	ldr	x1, [x8, #0x228] ; wordingForCurrentLanguage
100f69354: 95b2f77a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69358: aa1d03fd    	mov	x29, x29
100f6935c: 95b2f77b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f69360: aa0003f3    	mov	x19, x0
100f69364: aa1603e0    	mov	x0, x22
100f69368: 95b2f77b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6936c: aa1503e0    	mov	x0, x21
100f69370: 95b2f779    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f69374: d00f8cc8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100f69378: f946e901    	ldr	x1, [x8, #0xdd0] ; length
100f6937c: aa1303e0    	mov	x0, x19
100f69380: 95b2f76f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69384: b4000c40    	cbz	x0, 0x100f6950c <__text+0xf6150c>
100f69388: d00f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6938c: f9461916    	ldr	x22, [x8, #0xc30]
100f69390: f00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f69394: f9450117    	ldr	x23, [x8, #0xa00] ; 0�7 
100f69398: d00f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6939c: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
100f693a0: f00f8ca8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100f693a4: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100f693a8: 95b2f765    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f693ac: aa1d03fd    	mov	x29, x29
100f693b0: 95b2f766    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f693b4: aa0003f5    	mov	x21, x0
100f693b8: f00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f693bc: f9404100    	ldr	x0, [x8, #0x80]
100f693c0: d00f8ca8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f693c4: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100f693c8: 95b2f75d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f693cc: aa0003e2    	mov	x2, x0
100f693d0: 900f7688    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f693d4: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100f693d8: aa1503e0    	mov	x0, x21
100f693dc: 95b2f758    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f693e0: aa1d03fd    	mov	x29, x29
100f693e4: 95b2f759    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f693e8: aa0003f8    	mov	x24, x0
100f693ec: d00f7688    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100f693f0: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
100f693f4: f00eaac2    	adrp	x2, 0x11e4c4000 <dyld_stub_binder+0x11e4c4000>
100f693f8: 9132a042    	add	x2, x2, #0xca8
100f693fc: b00ea9e3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
100f69400: 9124a063    	add	x3, x3, #0x928
100f69404: 95b2f74e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69408: aa1d03fd    	mov	x29, x29
100f6940c: 95b2f74f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f69410: aa0003f9    	mov	x25, x0
100f69414: d00f76a8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100f69418: f946e101    	ldr	x1, [x8, #0xdc0] ; getMessageCssFloatValue:component:
100f6941c: aa1703e0    	mov	x0, x23
100f69420: aa1903e2    	mov	x2, x25
100f69424: aa1403e3    	mov	x3, x20
100f69428: 95b2f745    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6942c: 900f7688    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f69430: f9464d01    	ldr	x1, [x8, #0xc98] ; dynamicSystemFontOfSize:
100f69434: aa1603e0    	mov	x0, x22
100f69438: 95b2f741    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6943c: aa1d03fd    	mov	x29, x29
100f69440: 95b2f742    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f69444: aa0003f4    	mov	x20, x0
100f69448: aa1903e0    	mov	x0, x25
100f6944c: 95b2f742    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f69450: aa1803e0    	mov	x0, x24
100f69454: 95b2f740    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f69458: aa1503e0    	mov	x0, x21
100f6945c: 95b2f73e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f69460: d00e3408    	adrp	x8, 0x11d5eb000 <dyld_stub_binder+0x11d5eb000>
100f69464: f946c508    	ldr	x8, [x8, #0xd88]
100f69468: f9400108    	ldr	x8, [x8]
100f6946c: a900d3e8    	stp	x8, x20, [sp, #0x8]
100f69470: d00f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f69474: f9457500    	ldr	x0, [x8, #0xae8]
100f69478: 900f8cc8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
100f6947c: f9402901    	ldr	x1, [x8, #0x50] ; dictionaryWithObjects:forKeys:count:
100f69480: 910043e2    	add	x2, sp, #0x10
100f69484: 910023e3    	add	x3, sp, #0x8
100f69488: 52800024    	mov	w4, #0x1                ; =1
100f6948c: 95b2f72c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69490: aa1d03fd    	mov	x29, x29
100f69494: 95b2f72d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f69498: aa0003f5    	mov	x21, x0
100f6949c: b00f8d08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
100f694a0: f9443101    	ldr	x1, [x8, #0x860] ; sizeWithAttributes:
100f694a4: aa1303e0    	mov	x0, x19
100f694a8: aa1503e2    	mov	x2, x21
100f694ac: 95b2f724    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f694b0: 1e604008    	fmov	d8, d0
100f694b4: aa1503e0    	mov	x0, x21
100f694b8: 95b2f727    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f694bc: d00f7688    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100f694c0: f947ed01    	ldr	x1, [x8, #0xfd8] ; lineHeight
100f694c4: aa1403e0    	mov	x0, x20
100f694c8: 95b2f71d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f694cc: 900bf0c8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
100f694d0: fd433501    	ldr	d1, [x8, #0x668]
100f694d4: 1e610800    	fmul	d0, d0, d1
100f694d8: 1e64c000    	frintp	d0, d0
100f694dc: 1e64c101    	frintp	d1, d8
100f694e0: 1e651002    	fmov	d2, #12.00000000
100f694e4: 1e622828    	fadd	d8, d1, d2
100f694e8: 1e621001    	fmov	d1, #4.00000000
100f694ec: 1e612809    	fadd	d9, d0, d1
100f694f0: aa1403e0    	mov	x0, x20
100f694f4: 95b2f718    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f694f8: 14000008    	b	0x100f69518 <__text+0xf61518>
100f694fc: 900e3428    	adrp	x8, 0x11d5ed000 <dyld_stub_binder+0x11d5ed000>
100f69500: f9417908    	ldr	x8, [x8, #0x2f0]
100f69504: 6d402508    	ldp	d8, d9, [x8]
100f69508: 14000006    	b	0x100f69520 <__text+0xf61520>
100f6950c: 900e3428    	adrp	x8, 0x11d5ed000 <dyld_stub_binder+0x11d5ed000>
100f69510: f9417908    	ldr	x8, [x8, #0x2f0]
100f69514: 6d402508    	ldp	d8, d9, [x8]
100f69518: aa1303e0    	mov	x0, x19
100f6951c: 95b2f70e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f69520: f9400fe8    	ldr	x8, [sp, #0x18]
100f69524: d00e3429    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
100f69528: f9405929    	ldr	x9, [x9, #0xb0]
100f6952c: f9400129    	ldr	x9, [x9]
100f69530: eb08013f    	cmp	x9, x8
100f69534: 54000161    	b.ne	0x100f69560 <__text+0xf61560>
100f69538: 1e604100    	fmov	d0, d8
100f6953c: 1e604121    	fmov	d1, d9
100f69540: a9477bfd    	ldp	x29, x30, [sp, #0x70]
100f69544: a9464ff4    	ldp	x20, x19, [sp, #0x60]
100f69548: a94557f6    	ldp	x22, x21, [sp, #0x50]
100f6954c: a9445ff8    	ldp	x24, x23, [sp, #0x40]
100f69550: a94367fa    	ldp	x26, x25, [sp, #0x30]
100f69554: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
100f69558: 910203ff    	add	sp, sp, #0x80
100f6955c: d65f03c0    	ret
100f69560: 95b2f705    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>