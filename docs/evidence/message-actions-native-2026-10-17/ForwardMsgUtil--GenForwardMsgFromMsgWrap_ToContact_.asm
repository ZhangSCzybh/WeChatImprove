
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101c49210: d10183ff    	sub	sp, sp, #0x60
101c49214: a90167fa    	stp	x26, x25, [sp, #0x10]
101c49218: a9025ff8    	stp	x24, x23, [sp, #0x20]
101c4921c: a90357f6    	stp	x22, x21, [sp, #0x30]
101c49220: a9044ff4    	stp	x20, x19, [sp, #0x40]
101c49224: a9057bfd    	stp	x29, x30, [sp, #0x50]
101c49228: 910143fd    	add	x29, sp, #0x50
101c4922c: aa0303f4    	mov	x20, x3
101c49230: aa0203f3    	mov	x19, x2
101c49234: aa0003f5    	mov	x21, x0
101c49238: d00f7f48    	adrp	x8, 0x120c33000 <dyld_stub_binder+0x120c33000>
101c4923c: 52800029    	mov	w9, #0x1                ; =1
101c49240: 39271109    	strb	w9, [x8, #0x9c4]
101c49244: aa0203e0    	mov	x0, x2
101c49248: 957f77bc    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c4924c: aa1403e0    	mov	x0, x20
101c49250: 957f77ba    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c49254: b00f0fa8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
101c49258: f9413d16    	ldr	x22, [x8, #0x278] ; m_uiMessageType
101c4925c: aa1303e0    	mov	x0, x19
101c49260: aa1603e1    	mov	x1, x22
101c49264: 957f77b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c49268: 7100a81f    	cmp	w0, #0x2a
101c4926c: 5400020c    	b.gt	0x101c492ac <_Flutter_Image_provideRelativePathByUrl+0x5615c>
101c49270: 7100301f    	cmp	w0, #0xc
101c49274: 5400038d    	b.le	0x101c492e4 <_Flutter_Image_provideRelativePathByUrl+0x56194>
101c49278: 7100981f    	cmp	w0, #0x26
101c4927c: 5400094c    	b.gt	0x101c493a4 <_Flutter_Image_provideRelativePathByUrl+0x56254>
101c49280: 7100341f    	cmp	w0, #0xd
101c49284: 54000a20    	b.eq	0x101c493c8 <_Flutter_Image_provideRelativePathByUrl+0x56278>
101c49288: 7100881f    	cmp	w0, #0x22
101c4928c: 54001481    	b.ne	0x101c4951c <_Flutter_Image_provideRelativePathByUrl+0x563cc>
101c49290: aa1303e0    	mov	x0, x19
101c49294: 957f77a9    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c49298: aa1303f7    	mov	x23, x19
101c4929c: b5000c37    	cbnz	x23, 0x101c49420 <_Flutter_Image_provideRelativePathByUrl+0x562d0>
101c492a0: 900f0f88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101c492a4: f942a915    	ldr	x21, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
101c492a8: 1400002e    	b	0x101c49360 <_Flutter_Image_provideRelativePathByUrl+0x56210>
101c492ac: 7100bc1f    	cmp	w0, #0x2f
101c492b0: 5400030d    	b.le	0x101c49310 <_Flutter_Image_provideRelativePathByUrl+0x561c0>
101c492b4: 51010808    	sub	w8, w0, #0x42
101c492b8: 7100091f    	cmp	w8, #0x2
101c492bc: 540007c3    	b.lo	0x101c493b4 <_Flutter_Image_provideRelativePathByUrl+0x56264>
101c492c0: 7100c01f    	cmp	w0, #0x30
101c492c4: 540009a0    	b.eq	0x101c493f8 <_Flutter_Image_provideRelativePathByUrl+0x562a8>
101c492c8: 7100c41f    	cmp	w0, #0x31
101c492cc: 54001281    	b.ne	0x101c4951c <_Flutter_Image_provideRelativePathByUrl+0x563cc>
101c492d0: 900f2968    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
101c492d4: f946c900    	ldr	x0, [x8, #0xd90]
101c492d8: 900f13a8    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c492dc: f9420901    	ldr	x1, [x8, #0x410] ; appMsgFromMsgWrap:
101c492e0: 1400004a    	b	0x101c49408 <_Flutter_Image_provideRelativePathByUrl+0x562b8>
101c492e4: 7100041f    	cmp	w0, #0x1
101c492e8: 540000a0    	b.eq	0x101c492fc <_Flutter_Image_provideRelativePathByUrl+0x561ac>
101c492ec: 71000c1f    	cmp	w0, #0x3
101c492f0: 540006c0    	b.eq	0x101c493c8 <_Flutter_Image_provideRelativePathByUrl+0x56278>
101c492f4: 71002c1f    	cmp	w0, #0xb
101c492f8: 54001121    	b.ne	0x101c4951c <_Flutter_Image_provideRelativePathByUrl+0x563cc>
101c492fc: 900f2968    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
101c49300: f946c900    	ldr	x0, [x8, #0xd90]
101c49304: 900f13a8    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c49308: f9420101    	ldr	x1, [x8, #0x400] ; textMsgFromMsgWrap:
101c4930c: 1400003f    	b	0x101c49408 <_Flutter_Image_provideRelativePathByUrl+0x562b8>
101c49310: 5100ac08    	sub	w8, w0, #0x2b
101c49314: 7100091f    	cmp	w8, #0x2
101c49318: 54000622    	b.hs	0x101c493dc <_Flutter_Image_provideRelativePathByUrl+0x5628c>
101c4931c: d00f2948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101c49320: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
101c49324: 900f0f88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101c49328: f942a915    	ldr	x21, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
101c4932c: d00e4c08    	adrp	x8, 0x11e5cb000 <dyld_stub_binder+0x11e5cb000>
101c49330: 913d2108    	add	x8, x8, #0xf48
101c49334: f90003e8    	str	x8, [sp]
101c49338: b00cc005    	adrp	x5, 0x11b44a000 <dyld_stub_binder+0x11b44a000>
101c4933c: 9126c4a5    	add	x5, x5, #0x9b1
101c49340: b00cc007    	adrp	x7, 0x11b44a000 <dyld_stub_binder+0x11b44a000>
101c49344: 913294e7    	add	x7, x7, #0xca5
101c49348: aa1503e1    	mov	x1, x21
101c4934c: 52800082    	mov	w2, #0x4                ; =4
101c49350: d2800003    	mov	x3, #0x0                ; =0
101c49354: 52800004    	mov	w4, #0x0                ; =0
101c49358: 528068a6    	mov	w6, #0x345              ; =837
101c4935c: 957f7778    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c49360: d00f2948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101c49364: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
101c49368: d00e4c08    	adrp	x8, 0x11e5cb000 <dyld_stub_binder+0x11e5cb000>
101c4936c: 913e2108    	add	x8, x8, #0xf88
101c49370: f90003e8    	str	x8, [sp]
101c49374: b00cc005    	adrp	x5, 0x11b44a000 <dyld_stub_binder+0x11b44a000>
101c49378: 9126c4a5    	add	x5, x5, #0x9b1
101c4937c: b00cc007    	adrp	x7, 0x11b44a000 <dyld_stub_binder+0x11b44a000>
101c49380: 913294e7    	add	x7, x7, #0xca5
101c49384: aa1503e1    	mov	x1, x21
101c49388: 52800082    	mov	w2, #0x4                ; =4
101c4938c: d2800003    	mov	x3, #0x0                ; =0
101c49390: 52800004    	mov	w4, #0x0                ; =0
101c49394: 52806c66    	mov	w6, #0x363              ; =867
101c49398: 957f7769    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4939c: d2800017    	mov	x23, #0x0               ; =0
101c493a0: 14000099    	b	0x101c49604 <_Flutter_Image_provideRelativePathByUrl+0x564b4>
101c493a4: 71009c1f    	cmp	w0, #0x27
101c493a8: 54000100    	b.eq	0x101c493c8 <_Flutter_Image_provideRelativePathByUrl+0x56278>
101c493ac: 7100a81f    	cmp	w0, #0x2a
101c493b0: 54000b61    	b.ne	0x101c4951c <_Flutter_Image_provideRelativePathByUrl+0x563cc>
101c493b4: 900f2968    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
101c493b8: f946c900    	ldr	x0, [x8, #0xd90]
101c493bc: 900f13a8    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c493c0: f9421101    	ldr	x1, [x8, #0x420] ; cardMsgFromMsgWrap:
101c493c4: 14000011    	b	0x101c49408 <_Flutter_Image_provideRelativePathByUrl+0x562b8>
101c493c8: 900f2968    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
101c493cc: f946c900    	ldr	x0, [x8, #0xd90]
101c493d0: 900f13a8    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c493d4: f9420501    	ldr	x1, [x8, #0x408] ; imgMsgFromMsgWrap:
101c493d8: 1400000c    	b	0x101c49408 <_Flutter_Image_provideRelativePathByUrl+0x562b8>
101c493dc: 7100bc1f    	cmp	w0, #0x2f
101c493e0: 540009e1    	b.ne	0x101c4951c <_Flutter_Image_provideRelativePathByUrl+0x563cc>
101c493e4: 900f2968    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
101c493e8: f946c900    	ldr	x0, [x8, #0xd90]
101c493ec: 900f13a8    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c493f0: f9420d01    	ldr	x1, [x8, #0x418] ; emojiMsgFromMsgWrap:
101c493f4: 14000005    	b	0x101c49408 <_Flutter_Image_provideRelativePathByUrl+0x562b8>
101c493f8: 900f2968    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
101c493fc: f946c900    	ldr	x0, [x8, #0xd90]
101c49400: 900f13a8    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c49404: f9421501    	ldr	x1, [x8, #0x428] ; locMsgFromMsgWrap:
101c49408: aa1303e2    	mov	x2, x19
101c4940c: 957f774c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c49410: aa1d03fd    	mov	x29, x29
101c49414: 957f774d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c49418: aa0003f7    	mov	x23, x0
101c4941c: b4fff437    	cbz	x23, 0x101c492a0 <_Flutter_Image_provideRelativePathByUrl+0x56150>
101c49420: d00f0f88    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101c49424: f9434d18    	ldr	x24, [x8, #0x698] ; m_nsUsrName
101c49428: aa1403e0    	mov	x0, x20
101c4942c: aa1803e1    	mov	x1, x24
101c49430: 957f7743    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c49434: aa1d03fd    	mov	x29, x29
101c49438: 957f7744    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c4943c: aa0003f9    	mov	x25, x0
101c49440: f00f0f88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101c49444: f9453901    	ldr	x1, [x8, #0xa70] ; setM_nsToUsr:
101c49448: aa1703e0    	mov	x0, x23
101c4944c: aa1903e2    	mov	x2, x25
101c49450: 957f773b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c49454: aa1903e0    	mov	x0, x25
101c49458: 957f773f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c4945c: d00f1008    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
101c49460: f9406901    	ldr	x1, [x8, #0xd0] ; revokeBatchId
101c49464: aa1303e0    	mov	x0, x19
101c49468: 957f7735    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4946c: aa1d03fd    	mov	x29, x29
101c49470: 957f7736    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c49474: aa0003f9    	mov	x25, x0
101c49478: b00f1008    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
101c4947c: f9471101    	ldr	x1, [x8, #0xe20] ; setRevokeBatchId:
101c49480: aa1703e0    	mov	x0, x23
101c49484: aa1903e2    	mov	x2, x25
101c49488: 957f772d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4948c: aa1903e0    	mov	x0, x25
101c49490: 957f7731    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c49494: 900f13a8    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c49498: f9421901    	ldr	x1, [x8, #0x430] ; setCommonTail:
101c4949c: aa1703e0    	mov	x0, x23
101c494a0: d2800002    	mov	x2, #0x0                ; =0
101c494a4: 957f7726    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c494a8: f00f2948    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
101c494ac: f9400119    	ldr	x25, [x8]
101c494b0: aa1403e0    	mov	x0, x20
101c494b4: aa1803e1    	mov	x1, x24
101c494b8: 957f7721    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c494bc: aa1d03fd    	mov	x29, x29
101c494c0: 957f7722    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c494c4: aa0003f8    	mov	x24, x0
101c494c8: f00f1008    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
101c494cc: f945e501    	ldr	x1, [x8, #0xbc8] ; IsCustAsst:
101c494d0: aa1903e0    	mov	x0, x25
101c494d4: aa1803e2    	mov	x2, x24
101c494d8: 957f7719    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c494dc: 340006c0    	cbz	w0, 0x101c495b4 <_Flutter_Image_provideRelativePathByUrl+0x56464>
101c494e0: aa1303e0    	mov	x0, x19
101c494e4: aa1603e1    	mov	x1, x22
101c494e8: 957f7715    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c494ec: 7100c41f    	cmp	w0, #0x31
101c494f0: 54000621    	b.ne	0x101c495b4 <_Flutter_Image_provideRelativePathByUrl+0x56464>
101c494f4: b00f0fa8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
101c494f8: f9414116    	ldr	x22, [x8, #0x280] ; m_uiAppMsgInnerType
101c494fc: aa1303e0    	mov	x0, x19
101c49500: aa1603e1    	mov	x1, x22
101c49504: 957f770e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c49508: 7100cc1f    	cmp	w0, #0x33
101c4950c: 54000281    	b.ne	0x101c4955c <_Flutter_Image_provideRelativePathByUrl+0x5640c>
101c49510: aa1803e0    	mov	x0, x24
101c49514: 957f7710    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c49518: 14000019    	b	0x101c4957c <_Flutter_Image_provideRelativePathByUrl+0x5642c>
101c4951c: d00f2948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101c49520: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
101c49524: 900f0f88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101c49528: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
101c4952c: d00e4c08    	adrp	x8, 0x11e5cb000 <dyld_stub_binder+0x11e5cb000>
101c49530: 913da108    	add	x8, x8, #0xf68
101c49534: f90003e8    	str	x8, [sp]
101c49538: b00cc005    	adrp	x5, 0x11b44a000 <dyld_stub_binder+0x11b44a000>
101c4953c: 9126c4a5    	add	x5, x5, #0x9b1
101c49540: b00cc007    	adrp	x7, 0x11b44a000 <dyld_stub_binder+0x11b44a000>
101c49544: 913294e7    	add	x7, x7, #0xca5
101c49548: 52800082    	mov	w2, #0x4                ; =4
101c4954c: d2800003    	mov	x3, #0x0                ; =0
101c49550: 52800004    	mov	w4, #0x0                ; =0
101c49554: 52806b46    	mov	w6, #0x35a              ; =858
101c49558: 17ffff90    	b	0x101c49398 <_Flutter_Image_provideRelativePathByUrl+0x56248>
101c4955c: aa1303e0    	mov	x0, x19
101c49560: aa1603e1    	mov	x1, x22
101c49564: 957f76f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c49568: aa0003f6    	mov	x22, x0
101c4956c: aa1803e0    	mov	x0, x24
101c49570: 957f76f9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c49574: 710016df    	cmp	w22, #0x5
101c49578: 54000221    	b.ne	0x101c495bc <_Flutter_Image_provideRelativePathByUrl+0x5646c>
101c4957c: 900f13a8    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c49580: f9421d01    	ldr	x1, [x8, #0x438] ; chatBotCardWrapFromMsgWrap:
101c49584: aa1503e0    	mov	x0, x21
101c49588: aa1703e2    	mov	x2, x23
101c4958c: 957f76ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c49590: aa1d03fd    	mov	x29, x29
101c49594: 957f76ed    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c49598: aa0003f8    	mov	x24, x0
101c4959c: b40000c0    	cbz	x0, 0x101c495b4 <_Flutter_Image_provideRelativePathByUrl+0x56464>
101c495a0: aa1803e0    	mov	x0, x24
101c495a4: 957f76e5    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c495a8: aa1703e0    	mov	x0, x23
101c495ac: 957f76ea    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c495b0: aa1803f7    	mov	x23, x24
101c495b4: aa1803e0    	mov	x0, x24
101c495b8: 957f76e7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c495bc: 900f10c8    	adrp	x8, 0x11fe61000 <dyld_stub_binder+0x11fe61000>
101c495c0: f9437101    	ldr	x1, [x8, #0x6e0] ; bypAdjustMsgBeforeSendToContact:
101c495c4: aa1703e0    	mov	x0, x23
101c495c8: aa1403e2    	mov	x2, x20
101c495cc: 957f76dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c495d0: 900f10a8    	adrp	x8, 0x11fe5d000 <dyld_stub_binder+0x11fe5d000>
101c495d4: f9413901    	ldr	x1, [x8, #0x270] ; copySecInfoFromMsg:toMsg:
101c495d8: aa1503e0    	mov	x0, x21
101c495dc: aa1303e2    	mov	x2, x19
101c495e0: aa1703e3    	mov	x3, x23
101c495e4: 957f76d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c495e8: f00f29a8    	adrp	x8, 0x120180000 <dyld_stub_binder+0x120180000>
101c495ec: f9427100    	ldr	x0, [x8, #0x4e0]
101c495f0: 900f13a8    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c495f4: f9422101    	ldr	x1, [x8, #0x440] ; patchIfNeeded:sourceMsg:
101c495f8: aa1703e2    	mov	x2, x23
101c495fc: aa1303e3    	mov	x3, x19
101c49600: 957f76cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c49604: aa1403e0    	mov	x0, x20
101c49608: 957f76d3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c4960c: aa1303e0    	mov	x0, x19
101c49610: 957f76d1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c49614: aa1703e0    	mov	x0, x23
101c49618: a9457bfd    	ldp	x29, x30, [sp, #0x50]
101c4961c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
101c49620: a94357f6    	ldp	x22, x21, [sp, #0x30]
101c49624: a9425ff8    	ldp	x24, x23, [sp, #0x20]
101c49628: a94167fa    	ldp	x26, x25, [sp, #0x10]
101c4962c: 910183ff    	add	sp, sp, #0x60
101c49630: 157f76d0    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>