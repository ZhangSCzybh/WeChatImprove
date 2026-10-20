
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f69564: d102c3ff    	sub	sp, sp, #0xb0
100f69568: 6d0233ed    	stp	d13, d12, [sp, #0x20]
100f6956c: 6d032beb    	stp	d11, d10, [sp, #0x30]
100f69570: 6d0423e9    	stp	d9, d8, [sp, #0x40]
100f69574: a9056ffc    	stp	x28, x27, [sp, #0x50]
100f69578: a90667fa    	stp	x26, x25, [sp, #0x60]
100f6957c: a9075ff8    	stp	x24, x23, [sp, #0x70]
100f69580: a90857f6    	stp	x22, x21, [sp, #0x80]
100f69584: a9094ff4    	stp	x20, x19, [sp, #0x90]
100f69588: a90a7bfd    	stp	x29, x30, [sp, #0xa0]
100f6958c: 910283fd    	add	x29, sp, #0xa0
100f69590: aa0003f3    	mov	x19, x0
100f69594: f00fe628    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100f69598: 52800029    	mov	w9, #0x1                ; =1
100f6959c: 39296109    	strb	w9, [x8, #0xa58]
100f695a0: f00f78c8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f695a4: f9463501    	ldr	x1, [x8, #0xc68] ; canShowReplyMessage
100f695a8: 95b2f6e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f695ac: 340005a0    	cbz	w0, 0x100f69660 <__text+0xf61660>
100f695b0: b00f76a8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
100f695b4: f9410516    	ldr	x22, [x8, #0x208] ; messageWrap
100f695b8: aa1303e0    	mov	x0, x19
100f695bc: aa1603e1    	mov	x1, x22
100f695c0: 95b2f6df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f695c4: aa1d03fd    	mov	x29, x29
100f695c8: 95b2f6e0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f695cc: aa0003f5    	mov	x21, x0
100f695d0: 900f78e8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f695d4: f940fd01    	ldr	x1, [x8, #0x1f8] ; getReplyMessage
100f695d8: 95b2f6d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f695dc: aa1d03fd    	mov	x29, x29
100f695e0: 95b2f6da    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f695e4: aa0003f4    	mov	x20, x0
100f695e8: aa1503e0    	mov	x0, x21
100f695ec: 95b2f6da    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f695f0: d00f9088    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
100f695f4: f9454515    	ldr	x21, [x8, #0xa88] ; ��, 
100f695f8: aa1303e0    	mov	x0, x19
100f695fc: aa1603e1    	mov	x1, x22
100f69600: 95b2f6cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69604: aa1d03fd    	mov	x29, x29
100f69608: 95b2f6d0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6960c: aa0003f7    	mov	x23, x0
100f69610: 900f78e8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f69614: f9411901    	ldr	x1, [x8, #0x230] ; aliasNicknameForReferMsg:hostMsg:
100f69618: aa1503e0    	mov	x0, x21
100f6961c: aa1403e2    	mov	x2, x20
100f69620: aa1703e3    	mov	x3, x23
100f69624: 95b2f6c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69628: aa1d03fd    	mov	x29, x29
100f6962c: 95b2f6c7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f69630: aa0003f5    	mov	x21, x0
100f69634: aa1703e0    	mov	x0, x23
100f69638: 95b2f6c7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6963c: d00f8cc8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100f69640: f946e901    	ldr	x1, [x8, #0xdd0] ; length
100f69644: aa1503e0    	mov	x0, x21
100f69648: 95b2f6bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6964c: f9000bf5    	str	x21, [sp, #0x10]
100f69650: b40002c0    	cbz	x0, 0x100f696a8 <__text+0xf616a8>
100f69654: aa1503e0    	mov	x0, x21
100f69658: 95b2f6b8    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100f6965c: 14000021    	b	0x100f696e0 <__text+0xf616e0>
100f69660: 900f9408    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100f69664: b9850908    	ldrsw	x8, [x8, #0x508]
100f69668: f8686a60    	ldr	x0, [x19, x8]
100f6966c: f8286a7f    	str	xzr, [x19, x8]
100f69670: 95b2f6b9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f69674: 900f9408    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100f69678: b9850515    	ldrsw	x21, [x8, #0x504]
100f6967c: d2828f68    	mov	x8, #0x147b             ; =5243
100f69680: f2a8f5c8    	movk	x8, #0x47ae, lsl #16
100f69684: f2cf5c28    	movk	x8, #0x7ae1, lsl #32
100f69688: f2e7f088    	movk	x8, #0x3f84, lsl #48
100f6968c: 4e080d00    	dup.2d	v0, x8
100f69690: 3cb56a60    	str	q0, [x19, x21]
100f69694: 900f9408    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100f69698: b9850d08    	ldrsw	x8, [x8, #0x50c]
100f6969c: f8686a60    	ldr	x0, [x19, x8]
100f696a0: f8286a7f    	str	xzr, [x19, x8]
100f696a4: 14000113    	b	0x100f69af0 <__text+0xf61af0>
100f696a8: aa1303e0    	mov	x0, x19
100f696ac: aa1603e1    	mov	x1, x22
100f696b0: 95b2f6a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f696b4: aa1d03fd    	mov	x29, x29
100f696b8: 95b2f6a4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f696bc: aa0003f6    	mov	x22, x0
100f696c0: 900f78e8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f696c4: f9411d01    	ldr	x1, [x8, #0x238] ; referMessageSenderDisplayName
100f696c8: 95b2f69d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f696cc: aa1d03fd    	mov	x29, x29
100f696d0: 95b2f69e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f696d4: aa0003f5    	mov	x21, x0
100f696d8: aa1603e0    	mov	x0, x22
100f696dc: 95b2f69e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f696e0: f00f76a8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
100f696e4: f9461501    	ldr	x1, [x8, #0xc28] ; isUseLightStyle
100f696e8: aa1303e0    	mov	x0, x19
100f696ec: 95b2f694    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f696f0: aa0003e3    	mov	x3, x0
100f696f4: 900f78e8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f696f8: f9412101    	ldr	x1, [x8, #0x240] ; generateReplySummaryAndReplace:useCustomBkg:
100f696fc: aa1403e0    	mov	x0, x20
100f69700: f90007f5    	str	x21, [sp, #0x8]
100f69704: aa1503e2    	mov	x2, x21
100f69708: 95b2f68d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6970c: aa1d03fd    	mov	x29, x29
100f69710: 95b2f68e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f69714: aa0003f6    	mov	x22, x0
100f69718: f00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6971c: f9409900    	ldr	x0, [x8, #0x130] ; ��- 
100f69720: 900f78e8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f69724: f9412501    	ldr	x1, [x8, #0x248] ; parseForContent:arrTagRanges:
100f69728: aa1603e2    	mov	x2, x22
100f6972c: d2800003    	mov	x3, #0x0                ; =0
100f69730: 95b2f683    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69734: aa1d03fd    	mov	x29, x29
100f69738: 95b2f684    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6973c: aa0003f7    	mov	x23, x0
100f69740: aa1603e0    	mov	x0, x22
100f69744: 95b2f684    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f69748: b00f9068    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
100f6974c: f9418116    	ldr	x22, [x8, #0x300] ; �+* 
100f69750: d00f76a8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100f69754: f9437901    	ldr	x1, [x8, #0x6f0] ; chatContact
100f69758: aa1303e0    	mov	x0, x19
100f6975c: 95b2f678    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69760: aa1d03fd    	mov	x29, x29
100f69764: 95b2f679    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f69768: aa0003f9    	mov	x25, x0
100f6976c: 900f7728    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
100f69770: f9476901    	ldr	x1, [x8, #0xed0] ; createMessageViewModelWithMessageWrap:contact:chatContact:
100f69774: aa1603e0    	mov	x0, x22
100f69778: aa1403e2    	mov	x2, x20
100f6977c: d2800003    	mov	x3, #0x0                ; =0
100f69780: aa1903e4    	mov	x4, x25
100f69784: 95b2f66e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69788: aa1d03fd    	mov	x29, x29
100f6978c: 95b2f66f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f69790: aa0003f8    	mov	x24, x0
100f69794: aa1903e0    	mov	x0, x25
100f69798: 95b2f66f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6979c: b00f9068    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
100f697a0: f9437900    	ldr	x0, [x8, #0x6f0] ; �&, 
100f697a4: d00f8ca8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f697a8: f947ad16    	ldr	x22, [x8, #0xf58] ; class
100f697ac: aa1603e1    	mov	x1, x22
100f697b0: 95b2f663    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f697b4: aa0003e2    	mov	x2, x0
100f697b8: d00f8cc8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100f697bc: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
100f697c0: aa1803e0    	mov	x0, x24
100f697c4: 95b2f65e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f697c8: f00f78d5    	adrp	x21, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f697cc: f90003f8    	str	x24, [sp]
100f697d0: 340005e0    	cbz	w0, 0x100f6988c <__text+0xf6188c>
100f697d4: f00f78c8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f697d8: f9467901    	ldr	x1, [x8, #0xcf0] ; hasReferImage
100f697dc: aa1803e0    	mov	x0, x24
100f697e0: 95b2f657    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f697e4: 34000540    	cbz	w0, 0x100f6988c <__text+0xf6188c>
100f697e8: d00f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f697ec: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
100f697f0: f00f8ca8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100f697f4: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100f697f8: 95b2f651    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f697fc: aa1d03fd    	mov	x29, x29
100f69800: 95b2f652    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f69804: aa0003f9    	mov	x25, x0
100f69808: d00f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6980c: f9462900    	ldr	x0, [x8, #0xc50]
100f69810: aa1603e1    	mov	x1, x22
100f69814: 95b2f64a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69818: aa0003e2    	mov	x2, x0
100f6981c: 900f7688    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f69820: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100f69824: aa1903e0    	mov	x0, x25
100f69828: 95b2f645    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6982c: aa1d03fd    	mov	x29, x29
100f69830: 95b2f646    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f69834: aa0003f6    	mov	x22, x0
100f69838: 900f7688    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f6983c: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
100f69840: 900eaec2    	adrp	x2, 0x11e541000 <dyld_stub_binder+0x11e541000>
100f69844: 910ba042    	add	x2, x2, #0x2e8
100f69848: 95b2f63d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6984c: aa1d03fd    	mov	x29, x29
100f69850: 95b2f63e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f69854: aa0003fa    	mov	x26, x0
100f69858: d00f8cc8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100f6985c: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
100f69860: aa1703e0    	mov	x0, x23
100f69864: aa1a03e2    	mov	x2, x26
100f69868: 95b2f635    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6986c: aa0003fb    	mov	x27, x0
100f69870: aa1a03e0    	mov	x0, x26
100f69874: 95b2f638    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f69878: aa1603e0    	mov	x0, x22
100f6987c: 95b2f636    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f69880: aa1903e0    	mov	x0, x25
100f69884: 95b2f634    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f69888: 3600151b    	tbz	w27, #0x0, 0x100f69b28 <__text+0xf61b28>
100f6988c: aa1703f8    	mov	x24, x23
100f69890: 5280001a    	mov	w26, #0x0               ; =0
100f69894: d00f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f69898: f9456d00    	ldr	x0, [x8, #0xad8]
100f6989c: d00f8ca8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f698a0: f941a101    	ldr	x1, [x8, #0x340] ; array
100f698a4: 95b2f626    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f698a8: aa1d03fd    	mov	x29, x29
100f698ac: 95b2f627    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f698b0: aa0003fc    	mov	x28, x0
100f698b4: f00f9057    	adrp	x23, 0x120174000 <dyld_stub_binder+0x120174000>
100f698b8: f94502e0    	ldr	x0, [x23, #0xa00] ; 0�7 
100f698bc: f00f78c8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f698c0: f946c91b    	ldr	x27, [x8, #0xd90] ; getTextMessageNodeWidth:
100f698c4: aa1b03e1    	mov	x1, x27
100f698c8: aa1303e2    	mov	x2, x19
100f698cc: 95b2f61c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f698d0: 1e604008    	fmov	d8, d0
100f698d4: f9468eb9    	ldr	x25, [x21, #0xd18] ; replyTextInset
100f698d8: aa1303e0    	mov	x0, x19
100f698dc: aa1903e1    	mov	x1, x25
100f698e0: 95b2f617    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f698e4: 1e612908    	fadd	d8, d8, d1
100f698e8: aa1303e0    	mov	x0, x19
100f698ec: aa1903e1    	mov	x1, x25
100f698f0: 95b2f613    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f698f4: 1e632908    	fadd	d8, d8, d3
100f698f8: f00f78c8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f698fc: f9460516    	ldr	x22, [x8, #0xc08] ; isCustAsstContext
100f69900: aa1303e0    	mov	x0, x19
100f69904: aa1603e1    	mov	x1, x22
100f69908: 95b2f60d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6990c: 34000200    	cbz	w0, 0x100f6994c <__text+0xf6194c>
100f69910: d00f93a8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
100f69914: 910b7108    	add	x8, x8, #0x2dc
100f69918: b9800108    	ldrsw	x8, [x8]
100f6991c: fc686a69    	ldr	d9, [x19, x8]
100f69920: f94502e0    	ldr	x0, [x23, #0xa00] ; 0�7 
100f69924: aa1b03e1    	mov	x1, x27
100f69928: aa1303e2    	mov	x2, x19
100f6992c: 95b2f604    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69930: 1e602120    	fcmp	d9, d0
100f69934: 540000cd    	b.le	0x100f6994c <__text+0xf6194c>
100f69938: 900f78e8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f6993c: f9412901    	ldr	x1, [x8, #0x250] ; bubbleWidthForReplyText
100f69940: aa1303e0    	mov	x0, x19
100f69944: 95b2f5fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69948: 1e604008    	fmov	d8, d0
100f6994c: d00f9088    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
100f69950: f9450917    	ldr	x23, [x8, #0xa10]
100f69954: aa1303e0    	mov	x0, x19
100f69958: aa1903e1    	mov	x1, x25
100f6995c: 95b2f5f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69960: 1e604009    	fmov	d9, d0
100f69964: 1e60402a    	fmov	d10, d1
100f69968: 1e60404b    	fmov	d11, d2
100f6996c: 1e60406c    	fmov	d12, d3
100f69970: f9000ffc    	str	x28, [sp, #0x18]
100f69974: d00f7708    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
100f69978: f942311b    	ldr	x27, [x8, #0x460] ; referPartialInfo
100f6997c: aa1403e0    	mov	x0, x20
100f69980: aa1b03e1    	mov	x1, x27
100f69984: 95b2f5ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69988: aa1d03fd    	mov	x29, x29
100f6998c: 95b2f5ef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f69990: aa0003f5    	mov	x21, x0
100f69994: 900f78e8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f69998: f9412d01    	ldr	x1, [x8, #0x258] ; sizeForContent:maxWidth:parseType:cleanable:inset:outArrStyles:hasImage:referPartialInfo:
100f6999c: 910063e5    	add	x5, sp, #0x18
100f699a0: aa1703e0    	mov	x0, x23
100f699a4: aa1803e2    	mov	x2, x24
100f699a8: 1e604100    	fmov	d0, d8
100f699ac: 52800643    	mov	w3, #0x32               ; =50
100f699b0: 52800004    	mov	w4, #0x0                ; =0
100f699b4: 1e604121    	fmov	d1, d9
100f699b8: 1e604142    	fmov	d2, d10
100f699bc: 1e604163    	fmov	d3, d11
100f699c0: 1e604184    	fmov	d4, d12
100f699c4: aa1a03e6    	mov	x6, x26
100f699c8: aa1503e7    	mov	x7, x21
100f699cc: 95b2f5dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f699d0: 1e60400a    	fmov	d10, d0
100f699d4: 1e604029    	fmov	d9, d1
100f699d8: f9400ffa    	ldr	x26, [sp, #0x18]
100f699dc: aa1a03e0    	mov	x0, x26
100f699e0: 95b2f5d6    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100f699e4: aa1c03e0    	mov	x0, x28
100f699e8: 95b2f5db    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f699ec: aa1503e0    	mov	x0, x21
100f699f0: 95b2f5d9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f699f4: f00f8ca8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100f699f8: f9435101    	ldr	x1, [x8, #0x6a0] ; count
100f699fc: aa1a03e0    	mov	x0, x26
100f69a00: 95b2f5cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69a04: f100081f    	cmp	x0, #0x2
100f69a08: 540000c3    	b.lo	0x100f69a20 <__text+0xf61a20>
100f69a0c: aa1303e0    	mov	x0, x19
100f69a10: aa1603e1    	mov	x1, x22
100f69a14: 95b2f5ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69a18: 7100001f    	cmp	w0, #0x0
100f69a1c: 1e6a1d0a    	fcsel	d10, d8, d10, ne
100f69a20: aa1303e0    	mov	x0, x19
100f69a24: aa1903e1    	mov	x1, x25
100f69a28: 95b2f5c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69a2c: 1e613948    	fsub	d8, d10, d1
100f69a30: aa1303e0    	mov	x0, x19
100f69a34: aa1903e1    	mov	x1, x25
100f69a38: 95b2f5c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69a3c: 1e633908    	fsub	d8, d8, d3
100f69a40: aa1303e0    	mov	x0, x19
100f69a44: aa1903e1    	mov	x1, x25
100f69a48: 95b2f5bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69a4c: 1e603929    	fsub	d9, d9, d0
100f69a50: aa1303e0    	mov	x0, x19
100f69a54: aa1903e1    	mov	x1, x25
100f69a58: 95b2f5b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69a5c: 1e623920    	fsub	d0, d9, d2
100f69a60: 900f9408    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100f69a64: b9850515    	ldrsw	x21, [x8, #0x504]
100f69a68: 8b150268    	add	x8, x19, x21
100f69a6c: 6d000108    	stp	d8, d0, [x8]
100f69a70: f00f8cc8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100f69a74: f9450901    	ldr	x1, [x8, #0xa10] ; mutableCopy
100f69a78: aa1a03e0    	mov	x0, x26
100f69a7c: 95b2f5b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69a80: 900f9408    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100f69a84: b9850909    	ldrsw	x9, [x8, #0x508]
100f69a88: f8696a68    	ldr	x8, [x19, x9]
100f69a8c: f8296a60    	str	x0, [x19, x9]
100f69a90: aa0803e0    	mov	x0, x8
100f69a94: 95b2f5b0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f69a98: aa1403e0    	mov	x0, x20
100f69a9c: aa1b03e1    	mov	x1, x27
100f69aa0: 95b2f5a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69aa4: aa1d03fd    	mov	x29, x29
100f69aa8: 95b2f5a8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f69aac: 900f9408    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100f69ab0: b9850d09    	ldrsw	x9, [x8, #0x50c]
100f69ab4: f8696a68    	ldr	x8, [x19, x9]
100f69ab8: f8296a60    	str	x0, [x19, x9]
100f69abc: aa0803e0    	mov	x0, x8
100f69ac0: 95b2f5a5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f69ac4: aa1a03e0    	mov	x0, x26
100f69ac8: 95b2f5a3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f69acc: f94003e0    	ldr	x0, [sp]
100f69ad0: 95b2f5a1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f69ad4: aa1803e0    	mov	x0, x24
100f69ad8: 95b2f59f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f69adc: f94007e0    	ldr	x0, [sp, #0x8]
100f69ae0: 95b2f59d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f69ae4: f9400be0    	ldr	x0, [sp, #0x10]
100f69ae8: 95b2f59b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f69aec: aa1403e0    	mov	x0, x20
100f69af0: 95b2f599    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f69af4: 8b150268    	add	x8, x19, x21
100f69af8: 6d400500    	ldp	d0, d1, [x8]
100f69afc: a94a7bfd    	ldp	x29, x30, [sp, #0xa0]
100f69b00: a9494ff4    	ldp	x20, x19, [sp, #0x90]
100f69b04: a94857f6    	ldp	x22, x21, [sp, #0x80]
100f69b08: a9475ff8    	ldp	x24, x23, [sp, #0x70]
100f69b0c: a94667fa    	ldp	x26, x25, [sp, #0x60]
100f69b10: a9456ffc    	ldp	x28, x27, [sp, #0x50]
100f69b14: 6d4423e9    	ldp	d9, d8, [sp, #0x40]
100f69b18: 6d432beb    	ldp	d11, d10, [sp, #0x30]
100f69b1c: 6d4233ed    	ldp	d13, d12, [sp, #0x20]
100f69b20: 9102c3ff    	add	sp, sp, #0xb0
100f69b24: d65f03c0    	ret
100f69b28: aa1703f8    	mov	x24, x23
100f69b2c: f9468eb6    	ldr	x22, [x21, #0xd18] ; replyTextInset
100f69b30: aa1303e0    	mov	x0, x19
100f69b34: aa1603e1    	mov	x1, x22
100f69b38: 95b2f581    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69b3c: 1e604008    	fmov	d8, d0
100f69b40: aa1303e0    	mov	x0, x19
100f69b44: aa1603e1    	mov	x1, x22
100f69b48: 95b2f57d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69b4c: 1e604029    	fmov	d9, d1
100f69b50: aa1303e0    	mov	x0, x19
100f69b54: aa1603e1    	mov	x1, x22
100f69b58: 95b2f579    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69b5c: 900f78e8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f69b60: f940f101    	ldr	x1, [x8, #0x1e0] ; setReplyTextInset:
100f69b64: 1e641003    	fmov	d3, #8.00000000
100f69b68: aa1303e0    	mov	x0, x19
100f69b6c: 1e604100    	fmov	d0, d8
100f69b70: 1e604121    	fmov	d1, d9
100f69b74: 95b2f572    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f69b78: 5280003a    	mov	w26, #0x1               ; =1
100f69b7c: 17ffff46    	b	0x100f69894 <__text+0xf61894>