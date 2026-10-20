
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10104915c: d10203ff    	sub	sp, sp, #0x80
101049160: a9026ffc    	stp	x28, x27, [sp, #0x20]
101049164: a90367fa    	stp	x26, x25, [sp, #0x30]
101049168: a9045ff8    	stp	x24, x23, [sp, #0x40]
10104916c: a90557f6    	stp	x22, x21, [sp, #0x50]
101049170: a9064ff4    	stp	x20, x19, [sp, #0x60]
101049174: a9077bfd    	stp	x29, x30, [sp, #0x70]
101049178: 9101c3fd    	add	x29, sp, #0x70
10104917c: aa0403f5    	mov	x21, x4
101049180: aa0303f4    	mov	x20, x3
101049184: aa0203f3    	mov	x19, x2
101049188: aa0003f6    	mov	x22, x0
10104918c: f00fdf28    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
101049190: 52800029    	mov	w9, #0x1                ; =1
101049194: 39370d09    	strb	w9, [x8, #0xdc3]
101049198: aa0203e0    	mov	x0, x2
10104919c: 95af77e7    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1010491a0: aa1403e0    	mov	x0, x20
1010491a4: 95af77e5    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1010491a8: aa1503e0    	mov	x0, x21
1010491ac: 95af77e3    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1010491b0: b00f71e8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
1010491b4: f941f517    	ldr	x23, [x8, #0x3e8] ; m_nsName
1010491b8: aa1403e0    	mov	x0, x20
1010491bc: aa1703e1    	mov	x1, x23
1010491c0: 95af77df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010491c4: aa1d03fd    	mov	x29, x29
1010491c8: 95af77e0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010491cc: aa0003f8    	mov	x24, x0
1010491d0: b00f7068    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
1010491d4: f9435d01    	ldr	x1, [x8, #0x6b8] ; setTagName:
1010491d8: aa1303e0    	mov	x0, x19
1010491dc: aa1803e2    	mov	x2, x24
1010491e0: 95af77d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010491e4: aa1803e0    	mov	x0, x24
1010491e8: 95af77db    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010491ec: d00f85c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1010491f0: f946e901    	ldr	x1, [x8, #0xdd0] ; length
1010491f4: aa1503e0    	mov	x0, x21
1010491f8: f9000be1    	str	x1, [sp, #0x10]
1010491fc: 95af77d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049200: b4000360    	cbz	x0, 0x10104926c <__text+0x104126c>
101049204: f00f8948    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
101049208: f940cd18    	ldr	x24, [x8, #0x198] ; 8N,
10104920c: aa1403e0    	mov	x0, x20
101049210: aa1703e1    	mov	x1, x23
101049214: 95af77ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049218: aa1d03fd    	mov	x29, x29
10104921c: 95af77cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101049220: aa0003f7    	mov	x23, x0
101049224: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
101049228: f9409901    	ldr	x1, [x8, #0x130] ; getAttributedTextForTagName:searchText:
10104922c: aa1803e0    	mov	x0, x24
101049230: aa1703e2    	mov	x2, x23
101049234: aa1503e3    	mov	x3, x21
101049238: 95af77c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10104923c: aa1d03fd    	mov	x29, x29
101049240: 95af77c2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101049244: aa0003f8    	mov	x24, x0
101049248: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
10104924c: f9409d01    	ldr	x1, [x8, #0x138] ; setAttributeTagName:
101049250: aa1303e0    	mov	x0, x19
101049254: aa1803e2    	mov	x2, x24
101049258: 95af77b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10104925c: aa1803e0    	mov	x0, x24
101049260: 95af77bd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101049264: aa1703e0    	mov	x0, x23
101049268: 95af77bb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10104926c: f9000ff5    	str	x21, [sp, #0x18]
101049270: d00f8948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101049274: f9454518    	ldr	x24, [x8, #0xa88]
101049278: b00f71e8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
10104927c: f941ed1b    	ldr	x27, [x8, #0x3d8] ; m_arrContactNameList
101049280: aa1403e0    	mov	x0, x20
101049284: aa1b03e1    	mov	x1, x27
101049288: 95af77ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10104928c: aa1d03fd    	mov	x29, x29
101049290: 95af77ae    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101049294: aa0003f9    	mov	x25, x0
101049298: f00f85a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10104929c: f9435117    	ldr	x23, [x8, #0x6a0] ; count
1010492a0: aa1703e1    	mov	x1, x23
1010492a4: 95af77a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010492a8: b00f8608    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1010492ac: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
1010492b0: f90003e0    	str	x0, [sp]
1010492b4: f00ea7e2    	adrp	x2, 0x11e548000 <dyld_stub_binder+0x11e548000>
1010492b8: 91312042    	add	x2, x2, #0xc48
1010492bc: aa1803e0    	mov	x0, x24
1010492c0: 95af779f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010492c4: aa1d03fd    	mov	x29, x29
1010492c8: 95af77a0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010492cc: aa0003f8    	mov	x24, x0
1010492d0: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
1010492d4: f940a101    	ldr	x1, [x8, #0x140] ; setMemberCountText:
1010492d8: aa1303e0    	mov	x0, x19
1010492dc: aa1803e2    	mov	x2, x24
1010492e0: 95af7797    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010492e4: aa1803e0    	mov	x0, x24
1010492e8: 95af779b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010492ec: aa1903e0    	mov	x0, x25
1010492f0: 95af7799    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010492f4: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
1010492f8: f940a51c    	ldr	x28, [x8, #0x148] ; setMemberListAttributedText:
1010492fc: aa1303e0    	mov	x0, x19
101049300: aa1c03e1    	mov	x1, x28
101049304: d2800002    	mov	x2, #0x0                ; =0
101049308: 95af778d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10104930c: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
101049310: f940a918    	ldr	x24, [x8, #0x150] ; setMemberListText:
101049314: d00ea282    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
101049318: 91032042    	add	x2, x2, #0xc8
10104931c: aa1303e0    	mov	x0, x19
101049320: aa1803e1    	mov	x1, x24
101049324: 95af7786    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049328: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
10104932c: f940ad19    	ldr	x25, [x8, #0x158] ; setShowMemberList:
101049330: aa1303e0    	mov	x0, x19
101049334: aa1903e1    	mov	x1, x25
101049338: 52800002    	mov	w2, #0x0                ; =0
10104933c: 95af7780    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049340: aa1403e0    	mov	x0, x20
101049344: aa1b03e1    	mov	x1, x27
101049348: 95af777d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10104934c: aa1d03fd    	mov	x29, x29
101049350: 95af777e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101049354: aa0003fa    	mov	x26, x0
101049358: aa1703e1    	mov	x1, x23
10104935c: 95af7778    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049360: aa0003f5    	mov	x21, x0
101049364: aa1a03e0    	mov	x0, x26
101049368: 95af777b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10104936c: b4000b95    	cbz	x21, 0x1010494dc <__text+0x10414dc>
101049370: b00f8d08    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
101049374: b982a508    	ldrsw	x8, [x8, #0x2a4] ; ivar ContactTagListViewController.m_contactTagSearchLogic
101049378: f8686ac0    	ldr	x0, [x22, x8]
10104937c: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
101049380: f940b101    	ldr	x1, [x8, #0x160] ; getAllContactUserNameMatchTip
101049384: 95af776e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049388: aa1d03fd    	mov	x29, x29
10104938c: 95af776f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101049390: f90007e0    	str	x0, [sp, #0x8]
101049394: aa1703e1    	mov	x1, x23
101049398: 95af7769    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10104939c: f9400ffa    	ldr	x26, [sp, #0x18]
1010493a0: b4000580    	cbz	x0, 0x101049450 <__text+0x1041450>
1010493a4: aa1a03e0    	mov	x0, x26
1010493a8: f9400be1    	ldr	x1, [sp, #0x10]
1010493ac: 95af7764    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010493b0: b4000500    	cbz	x0, 0x101049450 <__text+0x1041450>
1010493b4: f00f8948    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1010493b8: f940cd15    	ldr	x21, [x8, #0x198] ; 8N,
1010493bc: aa1403e0    	mov	x0, x20
1010493c0: aa1b03e1    	mov	x1, x27
1010493c4: 95af775e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010493c8: aa1d03fd    	mov	x29, x29
1010493cc: 95af775f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010493d0: aa0003f8    	mov	x24, x0
1010493d4: d00f8948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1010493d8: f9461900    	ldr	x0, [x8, #0xc30]
1010493dc: 900f6f88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1010493e0: f9464d01    	ldr	x1, [x8, #0xc98] ; dynamicSystemFontOfSize:
1010493e4: 1e659000    	fmov	d0, #14.00000000
1010493e8: 95af7755    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010493ec: aa1d03fd    	mov	x29, x29
1010493f0: 95af7756    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010493f4: aa0003fa    	mov	x26, x0
1010493f8: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
1010493fc: f940b501    	ldr	x1, [x8, #0x168] ; getTagMemberHighlightAttributedString:memberLableFont:searchText:dicSearchMatchTip:
101049400: aa1503e0    	mov	x0, x21
101049404: aa1803e2    	mov	x2, x24
101049408: aa1a03e3    	mov	x3, x26
10104940c: f9400fe4    	ldr	x4, [sp, #0x18]
101049410: f94007f5    	ldr	x21, [sp, #0x8]
101049414: aa1503e5    	mov	x5, x21
101049418: 95af7749    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10104941c: aa1d03fd    	mov	x29, x29
101049420: 95af774a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101049424: aa0003fb    	mov	x27, x0
101049428: aa1a03e0    	mov	x0, x26
10104942c: f9400ffa    	ldr	x26, [sp, #0x18]
101049430: 95af7749    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101049434: aa1803e0    	mov	x0, x24
101049438: 95af7747    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10104943c: aa1303e0    	mov	x0, x19
101049440: aa1c03e1    	mov	x1, x28
101049444: aa1b03e2    	mov	x2, x27
101049448: 95af773d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10104944c: 14000016    	b	0x1010494a4 <__text+0x10414a4>
101049450: aa1403e0    	mov	x0, x20
101049454: aa1b03e1    	mov	x1, x27
101049458: 95af7739    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10104945c: aa1d03fd    	mov	x29, x29
101049460: 95af773a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101049464: aa0003f5    	mov	x21, x0
101049468: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
10104946c: f940b901    	ldr	x1, [x8, #0x170] ; getMemberDesc:
101049470: aa1603e0    	mov	x0, x22
101049474: aa1503e2    	mov	x2, x21
101049478: 95af7731    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10104947c: aa1d03fd    	mov	x29, x29
101049480: 95af7732    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101049484: aa0003fb    	mov	x27, x0
101049488: aa1503e0    	mov	x0, x21
10104948c: 95af7732    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101049490: aa1303e0    	mov	x0, x19
101049494: aa1803e1    	mov	x1, x24
101049498: aa1b03e2    	mov	x2, x27
10104949c: 95af7728    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010494a0: f94007f5    	ldr	x21, [sp, #0x8]
1010494a4: aa1b03e0    	mov	x0, x27
1010494a8: 95af772b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010494ac: b00f7008    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1010494b0: f9444118    	ldr	x24, [x8, #0x880] ; isEditing
1010494b4: aa1603e0    	mov	x0, x22
1010494b8: aa1803e1    	mov	x1, x24
1010494bc: 95af7720    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010494c0: f9400bfc    	ldr	x28, [sp, #0x10]
1010494c4: 34000140    	cbz	w0, 0x1010494ec <__text+0x10414ec>
1010494c8: aa1303e0    	mov	x0, x19
1010494cc: aa1903e1    	mov	x1, x25
1010494d0: 52800002    	mov	w2, #0x0                ; =0
1010494d4: 95af771a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010494d8: 14000027    	b	0x101049574 <__text+0x1041574>
1010494dc: b00f7008    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1010494e0: f9444118    	ldr	x24, [x8, #0x880] ; isEditing
1010494e4: f9400ffa    	ldr	x26, [sp, #0x18]
1010494e8: 14000025    	b	0x10104957c <__text+0x104157c>
1010494ec: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
1010494f0: f940bd01    	ldr	x1, [x8, #0x178] ; memberListText
1010494f4: aa1303e0    	mov	x0, x19
1010494f8: 95af7711    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010494fc: aa1d03fd    	mov	x29, x29
101049500: 95af7712    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101049504: aa0003fb    	mov	x27, x0
101049508: aa1c03e1    	mov	x1, x28
10104950c: 95af770c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049510: b40000c0    	cbz	x0, 0x101049528 <__text+0x1041528>
101049514: aa1303e0    	mov	x0, x19
101049518: aa1903e1    	mov	x1, x25
10104951c: 52800022    	mov	w2, #0x1                ; =1
101049520: 95af7707    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049524: 14000012    	b	0x10104956c <__text+0x104156c>
101049528: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
10104952c: f940c101    	ldr	x1, [x8, #0x180] ; memberListAttributedText
101049530: aa1303e0    	mov	x0, x19
101049534: 95af7702    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049538: aa1d03fd    	mov	x29, x29
10104953c: 95af7703    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101049540: aa0003f5    	mov	x21, x0
101049544: aa1c03e1    	mov	x1, x28
101049548: 95af76fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10104954c: f100001f    	cmp	x0, #0x0
101049550: 1a9f07e2    	cset	w2, ne
101049554: aa1303e0    	mov	x0, x19
101049558: aa1903e1    	mov	x1, x25
10104955c: 95af76f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049560: aa1503e0    	mov	x0, x21
101049564: f94007f5    	ldr	x21, [sp, #0x8]
101049568: 95af76fb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10104956c: aa1b03e0    	mov	x0, x27
101049570: 95af76f9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101049574: aa1503e0    	mov	x0, x21
101049578: 95af76f7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10104957c: aa1603e0    	mov	x0, x22
101049580: aa1803e1    	mov	x1, x24
101049584: 95af76ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049588: aa0003e2    	mov	x2, x0
10104958c: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
101049590: f940c501    	ldr	x1, [x8, #0x188] ; setShowSelectControl:
101049594: aa1303e0    	mov	x0, x19
101049598: 95af76e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10104959c: b00f7068    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
1010495a0: f9429901    	ldr	x1, [x8, #0x530] ; isSelected:
1010495a4: aa1603e0    	mov	x0, x22
1010495a8: aa1403e2    	mov	x2, x20
1010495ac: 95af76e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010495b0: aa0003e2    	mov	x2, x0
1010495b4: b00f70e8    	adrp	x8, 0x11fe66000 <dyld_stub_binder+0x11fe66000>
1010495b8: f942c501    	ldr	x1, [x8, #0x588] ; setIsSelected:
1010495bc: aa1303e0    	mov	x0, x19
1010495c0: 95af76df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010495c4: b00f8d08    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010495c8: b982c908    	ldrsw	x8, [x8, #0x2c8] ; ivar ContactTagListViewController._selectedTags
1010495cc: f8686ac0    	ldr	x0, [x22, x8]
1010495d0: aa1703e1    	mov	x1, x23
1010495d4: 95af76da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010495d8: aa0003f5    	mov	x21, x0
1010495dc: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
1010495e0: f940c901    	ldr	x1, [x8, #0x190] ; getSelectTagLimit
1010495e4: aa1603e0    	mov	x0, x22
1010495e8: 95af76d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010495ec: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
1010495f0: f940cd17    	ldr	x23, [x8, #0x198] ; isMultipleReordering
1010495f4: eb0002bf    	cmp	x21, x0
1010495f8: 540000c2    	b.hs	0x101049610 <__text+0x1041610>
1010495fc: aa1603e0    	mov	x0, x22
101049600: aa1703e1    	mov	x1, x23
101049604: 95af76ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049608: aa0003e2    	mov	x2, x0
10104960c: 14000002    	b	0x101049614 <__text+0x1041614>
101049610: 52800022    	mov	w2, #0x1                ; =1
101049614: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
101049618: f940d101    	ldr	x1, [x8, #0x1a0] ; setIsSelectDisabled:
10104961c: aa1303e0    	mov	x0, x19
101049620: 95af76c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049624: aa1603e0    	mov	x0, x22
101049628: aa1703e1    	mov	x1, x23
10104962c: 95af76c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049630: aa0003e2    	mov	x2, x0
101049634: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
101049638: f940d501    	ldr	x1, [x8, #0x1a8] ; setIsDeselectDisabled:
10104963c: aa1303e0    	mov	x0, x19
101049640: 95af76bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049644: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
101049648: f940d901    	ldr	x1, [x8, #0x1b0] ; setTagData:
10104964c: aa1303e0    	mov	x0, x19
101049650: aa1403e2    	mov	x2, x20
101049654: 95af76ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049658: f00f7028    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
10104965c: f944e501    	ldr	x1, [x8, #0x9c8] ; updateView
101049660: aa1303e0    	mov	x0, x19
101049664: 95af76b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049668: aa1a03e0    	mov	x0, x26
10104966c: 95af76ba    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101049670: aa1403e0    	mov	x0, x20
101049674: 95af76b8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101049678: aa1303e0    	mov	x0, x19
10104967c: a9477bfd    	ldp	x29, x30, [sp, #0x70]
101049680: a9464ff4    	ldp	x20, x19, [sp, #0x60]
101049684: a94557f6    	ldp	x22, x21, [sp, #0x50]
101049688: a9445ff8    	ldp	x24, x23, [sp, #0x40]
10104968c: a94367fa    	ldp	x26, x25, [sp, #0x30]
101049690: a9426ffc    	ldp	x28, x27, [sp, #0x20]
101049694: 910203ff    	add	sp, sp, #0x80
101049698: 15af76af    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
