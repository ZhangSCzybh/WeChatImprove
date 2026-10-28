
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105127350: d101c3ff    	sub	sp, sp, #0x70
105127354: a9016ffc    	stp	x28, x27, [sp, #0x10]
105127358: a90267fa    	stp	x26, x25, [sp, #0x20]
10512735c: a9035ff8    	stp	x24, x23, [sp, #0x30]
105127360: a90457f6    	stp	x22, x21, [sp, #0x40]
105127364: a9054ff4    	stp	x20, x19, [sp, #0x50]
105127368: a9067bfd    	stp	x29, x30, [sp, #0x60]
10512736c: 910183fd    	add	x29, sp, #0x60
105127370: aa0003f3    	mov	x19, x0
105127374: 900dd8c8    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
105127378: 52800029    	mov	w9, #0x1                ; =1
10512737c: 392ea909    	strb	w9, [x8, #0xbaa]
105127380: b00d8268    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105127384: f9408d00    	ldr	x0, [x8, #0x118] ; CAppViewControllerManager
105127388: b00d68a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10512738c: f9423901    	ldr	x1, [x8, #0x470] ; getAppViewControllerManager
105127390: 94abff6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105127394: aa1d03fd    	mov	x29, x29
105127398: 94abff6c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10512739c: aa0003f5    	mov	x21, x0
1051273a0: b00d68a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1051273a4: f9455501    	ldr	x1, [x8, #0xaa8] ; getTopViewController
1051273a8: 94abff65    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051273ac: aa1d03fd    	mov	x29, x29
1051273b0: 94abff66    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051273b4: aa0003f4    	mov	x20, x0
1051273b8: aa1503e0    	mov	x0, x21
1051273bc: 94abff66    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051273c0: eb13029f    	cmp	x20, x19
1051273c4: 540002a1    	b.ne	0x105127418 <_Flutter_MMFoundation_BindContext+0x1602ffc>
1051273c8: b00d8808    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051273cc: b9831508    	ldrsw	x8, [x8, #0x314]
1051273d0: f8686a75    	ldr	x21, [x19, x8]
1051273d4: b00d8808    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051273d8: b9831908    	ldrsw	x8, [x8, #0x318]
1051273dc: f8686a60    	ldr	x0, [x19, x8]
1051273e0: b00d68e8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
1051273e4: f9451101    	ldr	x1, [x8, #0xa20] ; indexPathsForVisibleRows
1051273e8: 94abff55    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051273ec: aa1d03fd    	mov	x29, x29
1051273f0: 94abff56    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051273f4: aa0003f6    	mov	x22, x0
1051273f8: f00d7388    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
1051273fc: f9474501    	ldr	x1, [x8, #0xe88] ; onPageDisappearWithVisibleCellsIndexPath:reason:
105127400: aa1503e0    	mov	x0, x21
105127404: aa1603e2    	mov	x2, x22
105127408: 52800043    	mov	w3, #0x2                ; =2
10512740c: 94abff4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105127410: aa1603e0    	mov	x0, x22
105127414: 94abff50    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105127418: 900d827b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
10512741c: f945eb60    	ldr	x0, [x27, #0xbd0] ; MMContext
105127420: b00d7ec8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105127424: f944e916    	ldr	x22, [x8, #0x9d0] ; currentContext
105127428: aa1603e1    	mov	x1, x22
10512742c: 94abff44    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105127430: aa1d03fd    	mov	x29, x29
105127434: 94abff45    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105127438: aa0003f5    	mov	x21, x0
10512743c: b00d827c    	adrp	x28, 0x120174000 <dyld_stub_binder+0x120174000>
105127440: f941c380    	ldr	x0, [x28, #0x380] ; BrandTimelineMsgMgr
105127444: 900d7ec8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105127448: f947ad17    	ldr	x23, [x8, #0xf58] ; class
10512744c: aa1703e1    	mov	x1, x23
105127450: 94abff3b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105127454: aa0003e2    	mov	x2, x0
105127458: d00d6888    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10512745c: f9464118    	ldr	x24, [x8, #0xc80] ; getService:
105127460: aa1503e0    	mov	x0, x21
105127464: aa1803e1    	mov	x1, x24
105127468: 94abff35    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10512746c: aa1d03fd    	mov	x29, x29
105127470: 94abff36    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105127474: aa0003f9    	mov	x25, x0
105127478: 900d73a8    	adrp	x8, 0x11ff9b000 <dyld_stub_binder+0x11ff9b000>
10512747c: f9411101    	ldr	x1, [x8, #0x220] ; enableClearKeepposAfterClientBack
105127480: 94abff2f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105127484: aa0003fa    	mov	x26, x0
105127488: aa1903e0    	mov	x0, x25
10512748c: 94abff32    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105127490: aa1503e0    	mov	x0, x21
105127494: 94abff30    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105127498: 900d8279    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
10512749c: f9453720    	ldr	x0, [x25, #0xa68] ; iConsole
1051274a0: d00d6888    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1051274a4: f942a915    	ldr	x21, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1051274a8: b00cb568    	adrp	x8, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
1051274ac: 913d2108    	add	x8, x8, #0xf48 ; CFString 'didEnterBackground: enableClearKeepposAfterClientBack: %d'
1051274b0: a9006be8    	stp	x8, x26, [sp]
1051274b4: b00b3985    	adrp	x5, 0x11b858000 <dyld_stub_binder+0x11b858000>
1051274b8: 9122e0a5    	add	x5, x5, #0x8b8
1051274bc: f00b3987    	adrp	x7, 0x11b85a000 <dyld_stub_binder+0x11b85a000>
1051274c0: 9119d0e7    	add	x7, x7, #0x674
1051274c4: aa1503e1    	mov	x1, x21
1051274c8: 52800042    	mov	w2, #0x2                ; =2
1051274cc: d2800003    	mov	x3, #0x0                ; =0
1051274d0: 52800004    	mov	w4, #0x0                ; =0
1051274d4: 5281f546    	mov	w6, #0xfaa              ; =4010
1051274d8: 94abff19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051274dc: 3400089a    	cbz	w26, 0x1051275ec <_Flutter_MMFoundation_BindContext+0x16031d0>
1051274e0: 900d6968    	adrp	x8, 0x11fe53000 <dyld_stub_binder+0x11fe53000>
1051274e4: f9473d01    	ldr	x1, [x8, #0xe78] ; isBrandTLCacheExist
1051274e8: aa1303e0    	mov	x0, x19
1051274ec: 94abff14    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051274f0: 340007e0    	cbz	w0, 0x1051275ec <_Flutter_MMFoundation_BindContext+0x16031d0>
1051274f4: f945eb60    	ldr	x0, [x27, #0xbd0] ; MMContext
1051274f8: aa1603e1    	mov	x1, x22
1051274fc: 94abff10    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105127500: aa1d03fd    	mov	x29, x29
105127504: 94abff11    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105127508: aa0003f6    	mov	x22, x0
10512750c: f941c380    	ldr	x0, [x28, #0x380] ; BrandTimelineMsgMgr
105127510: aa1703e1    	mov	x1, x23
105127514: 94abff0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105127518: aa0003e2    	mov	x2, x0
10512751c: aa1603e0    	mov	x0, x22
105127520: aa1803e1    	mov	x1, x24
105127524: 94abff06    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105127528: aa1d03fd    	mov	x29, x29
10512752c: 94abff07    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105127530: aa0003f7    	mov	x23, x0
105127534: f00d68e8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
105127538: f9422101    	ldr	x1, [x8, #0x440] ; isTimelinePageActiveNow
10512753c: 94abff00    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105127540: aa0003f8    	mov	x24, x0
105127544: aa1703e0    	mov	x0, x23
105127548: 94abff03    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10512754c: aa1603e0    	mov	x0, x22
105127550: 94abff01    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105127554: 370004d8    	tbnz	w24, #0x0, 0x1051275ec <_Flutter_MMFoundation_BindContext+0x16031d0>
105127558: f9453720    	ldr	x0, [x25, #0xa68] ; iConsole
10512755c: b00cb568    	adrp	x8, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
105127560: 913da108    	add	x8, x8, #0xf68 ; CFString 'didEnterBackground, remove vc cache'
105127564: f90003e8    	str	x8, [sp]
105127568: b00b3985    	adrp	x5, 0x11b858000 <dyld_stub_binder+0x11b858000>
10512756c: 9122e0a5    	add	x5, x5, #0x8b8
105127570: f00b3987    	adrp	x7, 0x11b85a000 <dyld_stub_binder+0x11b85a000>
105127574: 9119d0e7    	add	x7, x7, #0x674
105127578: aa1503e1    	mov	x1, x21
10512757c: 52800042    	mov	w2, #0x2                ; =2
105127580: d2800003    	mov	x3, #0x0                ; =0
105127584: 52800004    	mov	w4, #0x0                ; =0
105127588: 5281f586    	mov	w6, #0xfac              ; =4012
10512758c: 94abfeec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105127590: b00d8808    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105127594: b9837d15    	ldrsw	x21, [x8, #0x37c]
105127598: f8756a60    	ldr	x0, [x19, x21]
10512759c: f00d68e8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
1051275a0: f940e501    	ldr	x1, [x8, #0x1c8] ; stopTimeCheck
1051275a4: 94abfee6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051275a8: 900d8268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1051275ac: f9469d00    	ldr	x0, [x8, #0xd38] ; MMTimer
1051275b0: 900d73a8    	adrp	x8, 0x11ff9b000 <dyld_stub_binder+0x11ff9b000>
1051275b4: f940e503    	ldr	x3, [x8, #0x1c8] ; onBrandTimelineCacheTimeOut
1051275b8: f00d6888    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1051275bc: f9427101    	ldr	x1, [x8, #0x4e0] ; scheduledNoRetainTimerWithTimeInterval:target:selector:userInfo:repeats:
1051275c0: 1e611000    	fmov	d0, #3.00000000
1051275c4: aa1303e2    	mov	x2, x19
1051275c8: d2800004    	mov	x4, #0x0                ; =0
1051275cc: 52800005    	mov	w5, #0x0                ; =0
1051275d0: 94abfedb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051275d4: aa1d03fd    	mov	x29, x29
1051275d8: 94abfedc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051275dc: f8756a68    	ldr	x8, [x19, x21]
1051275e0: f8356a60    	str	x0, [x19, x21]
1051275e4: aa0803e0    	mov	x0, x8
1051275e8: 94abfedb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051275ec: aa1403e0    	mov	x0, x20
1051275f0: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1051275f4: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1051275f8: a94457f6    	ldp	x22, x21, [sp, #0x40]
1051275fc: a9435ff8    	ldp	x24, x23, [sp, #0x30]
105127600: a94267fa    	ldp	x26, x25, [sp, #0x20]
105127604: a9416ffc    	ldp	x28, x27, [sp, #0x10]
105127608: 9101c3ff    	add	sp, sp, #0x70
10512760c: 14abfed2    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
