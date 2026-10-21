
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101766628: d10303ff    	sub	sp, sp, #0xc0
10176662c: a9066ffc    	stp	x28, x27, [sp, #0x60]
101766630: a90767fa    	stp	x26, x25, [sp, #0x70]
101766634: a9085ff8    	stp	x24, x23, [sp, #0x80]
101766638: a90957f6    	stp	x22, x21, [sp, #0x90]
10176663c: a90a4ff4    	stp	x20, x19, [sp, #0xa0]
101766640: a90b7bfd    	stp	x29, x30, [sp, #0xb0]
101766644: 9102c3fd    	add	x29, sp, #0xb0
101766648: aa0003f4    	mov	x20, x0
10176664c: 900fa668    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
101766650: 52800029    	mov	w9, #0x1                ; =1
101766654: 3922d509    	strb	w9, [x8, #0x8b5]
101766658: b00f5068    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10176665c: f9467913    	ldr	x19, [x8, #0xcf0]
101766660: 900f3a08    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101766664: f9436901    	ldr	x1, [x8, #0x6d0] ; searchBarText
101766668: 959302b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10176666c: aa1d03fd    	mov	x29, x29
101766670: 959302b6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766674: aa0003f5    	mov	x21, x0
101766678: f00f3788    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
10176667c: f9436501    	ldr	x1, [x8, #0x6c8] ; trimString:
101766680: aa1303e0    	mov	x0, x19
101766684: f9001be1    	str	x1, [sp, #0x30]
101766688: aa1503e2    	mov	x2, x21
10176668c: 959302ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766690: aa1d03fd    	mov	x29, x29
101766694: 959302ad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766698: aa0003f3    	mov	x19, x0
10176669c: aa1503e0    	mov	x0, x21
1017666a0: 959302ad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017666a4: d00f3808    	adrp	x8, 0x11fe68000 <dyld_stub_binder+0x11fe68000>
1017666a8: f946f118    	ldr	x24, [x8, #0xde0] ; presenter
1017666ac: aa1403e0    	mov	x0, x20
1017666b0: aa1803e1    	mov	x1, x24
1017666b4: 959302a2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017666b8: aa1d03fd    	mov	x29, x29
1017666bc: 959302a3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017666c0: aa0003f5    	mov	x21, x0
1017666c4: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017666c8: f941e501    	ldr	x1, [x8, #0x3c8] ; latestCompeleteWebSearchQuery
1017666cc: 9593029c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017666d0: aa1d03fd    	mov	x29, x29
1017666d4: 9593029d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017666d8: aa0003f7    	mov	x23, x0
1017666dc: b00f4ce8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1017666e0: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
1017666e4: aa1303e2    	mov	x2, x19
1017666e8: 95930295    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017666ec: aa0003f6    	mov	x22, x0
1017666f0: aa1703e0    	mov	x0, x23
1017666f4: 95930298    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017666f8: aa1503e0    	mov	x0, x21
1017666fc: 95930296    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766700: aa1403e0    	mov	x0, x20
101766704: f9002bf8    	str	x24, [sp, #0x50]
101766708: aa1803e1    	mov	x1, x24
10176670c: 9593028c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766710: aa1d03fd    	mov	x29, x29
101766714: 9593028d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766718: aa0003f5    	mov	x21, x0
10176671c: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101766720: f941e901    	ldr	x1, [x8, #0x3d0] ; isTotalSearchDone
101766724: 95930286    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766728: aa0003fb    	mov	x27, x0
10176672c: aa1503e0    	mov	x0, x21
101766730: 95930289    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766734: b00f5068    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101766738: f945351c    	ldr	x28, [x8, #0xa68]
10176673c: 900f4d28    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
101766740: f947bd19    	ldr	x25, [x8, #0xf78] ; tableView
101766744: aa1403e0    	mov	x0, x20
101766748: aa1903e1    	mov	x1, x25
10176674c: 9593027c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766750: aa1d03fd    	mov	x29, x29
101766754: 9593027d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766758: aa0003f5    	mov	x21, x0
10176675c: d00f3748    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
101766760: f9452101    	ldr	x1, [x8, #0xa40] ; tableFooterView
101766764: 95930276    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766768: aa1d03fd    	mov	x29, x29
10176676c: 95930277    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766770: aa0003f7    	mov	x23, x0
101766774: b00f3a08    	adrp	x8, 0x11fea7000 <dyld_stub_binder+0x11fea7000>
101766778: f9454501    	ldr	x1, [x8, #0xa88] ; emptyFooterView
10176677c: aa1403e0    	mov	x0, x20
101766780: f90027e1    	str	x1, [sp, #0x48]
101766784: 9593026e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766788: aa1d03fd    	mov	x29, x29
10176678c: 9593026f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766790: aa0003f8    	mov	x24, x0
101766794: eb0002ff    	cmp	x23, x0
101766798: 1a9f07fa    	cset	w26, ne
10176679c: d00f5068    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1017667a0: f9409900    	ldr	x0, [x8, #0x130]
1017667a4: f00f3788    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
1017667a8: f9438501    	ldr	x1, [x8, #0x708] ; encryptForLog:
1017667ac: f9002ff3    	str	x19, [sp, #0x58]
1017667b0: aa1303e2    	mov	x2, x19
1017667b4: 95930262    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017667b8: aa1d03fd    	mov	x29, x29
1017667bc: 95930263    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017667c0: aa0003f3    	mov	x19, x0
1017667c4: d00f5448    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1017667c8: b98dc108    	ldrsw	x8, [x8, #0xdc0]
1017667cc: f8686a80    	ldr	x0, [x20, x8]
1017667d0: d00f4cc8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1017667d4: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1017667d8: 95930259    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017667dc: f00f3688    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1017667e0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1017667e4: a90387f6    	stp	x22, x1, [sp, #0x38]
1017667e8: a9025bfb    	stp	x27, x22, [sp, #0x20]
1017667ec: a90103f3    	stp	x19, x0, [sp, #0x10]
1017667f0: b00e7168    	adrp	x8, 0x11e593000 <dyld_stub_binder+0x11e593000>
1017667f4: 910ba108    	add	x8, x8, #0x2e8
1017667f8: a9006be8    	stp	x8, x26, [sp]
1017667fc: d00cd863    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
101766800: 91388063    	add	x3, x3, #0xe20
101766804: b00ce3e5    	adrp	x5, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
101766808: 911b74a5    	add	x5, x5, #0x6dd
10176680c: d00ce3e7    	adrp	x7, 0x11b3e4000 <dyld_stub_binder+0x11b3e4000>
101766810: 910e94e7    	add	x7, x7, #0x3a5
101766814: aa1c03e0    	mov	x0, x28
101766818: 52800042    	mov	w2, #0x2                ; =2
10176681c: 52800004    	mov	w4, #0x0                ; =0
101766820: 528093e6    	mov	w6, #0x49f              ; =1183
101766824: 95930246    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766828: aa1303e0    	mov	x0, x19
10176682c: 9593024a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766830: aa1803e0    	mov	x0, x24
101766834: 95930248    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766838: aa1703e0    	mov	x0, x23
10176683c: 95930246    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766840: aa1503e0    	mov	x0, x21
101766844: 95930244    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766848: aa1403e0    	mov	x0, x20
10176684c: aa1903e1    	mov	x1, x25
101766850: 9593023b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766854: aa1d03fd    	mov	x29, x29
101766858: 9593023c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10176685c: aa0003f3    	mov	x19, x0
101766860: b00f4ce8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
101766864: f943f901    	ldr	x1, [x8, #0x7f0] ; isHidden
101766868: 95930235    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10176686c: aa0003f7    	mov	x23, x0
101766870: aa1303e0    	mov	x0, x19
101766874: 95930238    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766878: b00f36a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10176687c: f9478d1c    	ldr	x28, [x8, #0xf18] ; searchBar
101766880: aa1403e0    	mov	x0, x20
101766884: aa1c03e1    	mov	x1, x28
101766888: 9593022d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10176688c: aa1d03fd    	mov	x29, x29
101766890: 9593022e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766894: aa0003f8    	mov	x24, x0
101766898: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
10176689c: f9403115    	ldr	x21, [x8, #0x60] ; enableLargeInput
1017668a0: aa1503e1    	mov	x1, x21
1017668a4: 95930226    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017668a8: 37001077    	tbnz	w23, #0x0, 0x101766ab4 <__text+0x175eab4>
1017668ac: 34001040    	cbz	w0, 0x101766ab4 <__text+0x175eab4>
1017668b0: aa1403e0    	mov	x0, x20
1017668b4: f9402be1    	ldr	x1, [sp, #0x50]
1017668b8: 95930221    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017668bc: aa1d03fd    	mov	x29, x29
1017668c0: 95930222    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017668c4: aa0003f3    	mov	x19, x0
1017668c8: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017668cc: f941ed01    	ldr	x1, [x8, #0x3d8] ; hasResult
1017668d0: 9593021b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017668d4: aa0003fa    	mov	x26, x0
1017668d8: aa1303e0    	mov	x0, x19
1017668dc: 9593021e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017668e0: aa1803e0    	mov	x0, x24
1017668e4: 9593021c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017668e8: f9402ff8    	ldr	x24, [sp, #0x58]
1017668ec: 340000da    	cbz	w26, 0x101766904 <__text+0x175e904>
1017668f0: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017668f4: f941f101    	ldr	x1, [x8, #0x3e0] ; updateCheckBoxHideState:
1017668f8: aa1403e0    	mov	x0, x20
1017668fc: aa1803e2    	mov	x2, x24
101766900: 9593020f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766904: 34000e1b    	cbz	w27, 0x101766ac4 <__text+0x175eac4>
101766908: 340000d7    	cbz	w23, 0x101766920 <__text+0x175e920>
10176690c: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101766910: f941f101    	ldr	x1, [x8, #0x3e0] ; updateCheckBoxHideState:
101766914: aa1403e0    	mov	x0, x20
101766918: aa1803e2    	mov	x2, x24
10176691c: 95930208    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766920: b00f4ce8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
101766924: f946e901    	ldr	x1, [x8, #0xdd0] ; length
101766928: aa1803e0    	mov	x0, x24
10176692c: 95930204    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766930: b4000d40    	cbz	x0, 0x101766ad8 <__text+0x175ead8>
101766934: aa1403e0    	mov	x0, x20
101766938: aa1c03e1    	mov	x1, x28
10176693c: 95930200    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766940: aa1d03fd    	mov	x29, x29
101766944: 95930201    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766948: aa0003f3    	mov	x19, x0
10176694c: aa1503e1    	mov	x1, x21
101766950: 959301fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766954: aa0003f5    	mov	x21, x0
101766958: aa1303e0    	mov	x0, x19
10176695c: 959301fe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766960: 34000ff5    	cbz	w21, 0x101766b5c <__text+0x175eb5c>
101766964: aa1403e0    	mov	x0, x20
101766968: f9402be1    	ldr	x1, [sp, #0x50]
10176696c: 959301f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766970: aa1d03fd    	mov	x29, x29
101766974: 959301f5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766978: aa0003f3    	mov	x19, x0
10176697c: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101766980: f941ad01    	ldr	x1, [x8, #0x358] ; onlyHasWebResult
101766984: 959301ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766988: aa0003f5    	mov	x21, x0
10176698c: aa1303e0    	mov	x0, x19
101766990: 959301f1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766994: 34000e55    	cbz	w21, 0x101766b5c <__text+0x175eb5c>
101766998: aa1403e0    	mov	x0, x20
10176699c: f9402be1    	ldr	x1, [sp, #0x50]
1017669a0: 959301e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017669a4: aa1d03fd    	mov	x29, x29
1017669a8: 959301e8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017669ac: aa0003f5    	mov	x21, x0
1017669b0: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017669b4: f9414101    	ldr	x1, [x8, #0x280] ; isFromVoice
1017669b8: 959301e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017669bc: f9401fe8    	ldr	x8, [sp, #0x38]
1017669c0: 0a000108    	and	w8, w8, w0
1017669c4: 36000de8    	tbz	w8, #0x0, 0x101766b80 <__text+0x175eb80>
1017669c8: d00f5068    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1017669cc: f9409913    	ldr	x19, [x8, #0x130]
1017669d0: b00f5068    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1017669d4: f9467900    	ldr	x0, [x8, #0xcf0]
1017669d8: f9401be1    	ldr	x1, [sp, #0x30]
1017669dc: aa1803e2    	mov	x2, x24
1017669e0: 959301d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017669e4: aa1d03fd    	mov	x29, x29
1017669e8: 959301d8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017669ec: aa0003f6    	mov	x22, x0
1017669f0: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017669f4: f941f501    	ldr	x1, [x8, #0x3e8] ; calculateCharacterCount:
1017669f8: aa1303e0    	mov	x0, x19
1017669fc: aa1603e2    	mov	x2, x22
101766a00: 959301cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766a04: aa0003f3    	mov	x19, x0
101766a08: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101766a0c: f940d101    	ldr	x1, [x8, #0x1a0] ; globalSearchInputConfig
101766a10: aa1403e0    	mov	x0, x20
101766a14: 959301ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766a18: aa1d03fd    	mov	x29, x29
101766a1c: 959301cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766a20: aa0003f7    	mov	x23, x0
101766a24: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101766a28: f941dd01    	ldr	x1, [x8, #0x3b8] ; largeInputShowMinTextLength
101766a2c: 959301c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766a30: aa0003f8    	mov	x24, x0
101766a34: aa1703e0    	mov	x0, x23
101766a38: 959301c7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766a3c: aa1603e0    	mov	x0, x22
101766a40: 959301c5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766a44: aa1503e0    	mov	x0, x21
101766a48: 959301c3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766a4c: eb38427f    	cmp	x19, w24, uxtw
101766a50: f9402ff8    	ldr	x24, [sp, #0x58]
101766a54: 540009a9    	b.ls	0x101766b88 <__text+0x175eb88>
101766a58: b00f5068    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101766a5c: f9453500    	ldr	x0, [x8, #0xa68]
101766a60: b00e7168    	adrp	x8, 0x11e593000 <dyld_stub_binder+0x11e593000>
101766a64: 910c2108    	add	x8, x8, #0x308
101766a68: f90003e8    	str	x8, [sp]
101766a6c: d00cd863    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
101766a70: 91388063    	add	x3, x3, #0xe20
101766a74: b00ce3e5    	adrp	x5, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
101766a78: 911b74a5    	add	x5, x5, #0x6dd
101766a7c: d00ce3e7    	adrp	x7, 0x11b3e4000 <dyld_stub_binder+0x11b3e4000>
101766a80: 910e94e7    	add	x7, x7, #0x3a5
101766a84: f94023e1    	ldr	x1, [sp, #0x40]
101766a88: 52800042    	mov	w2, #0x2                ; =2
101766a8c: 52800004    	mov	w4, #0x0                ; =0
101766a90: 52809626    	mov	w6, #0x4b1              ; =1201
101766a94: 959301aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766a98: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101766a9c: f941f901    	ldr	x1, [x8, #0x3f0] ; voiceSearchStartWebSearch
101766aa0: aa1403e0    	mov	x0, x20
101766aa4: 959301a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766aa8: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101766aac: f9415101    	ldr	x1, [x8, #0x2a0] ; shouldReturnStartSearch
101766ab0: 14000007    	b	0x101766acc <__text+0x175eacc>
101766ab4: aa1803e0    	mov	x0, x24
101766ab8: 959301a7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766abc: f9402ff8    	ldr	x24, [sp, #0x58]
101766ac0: 35fff25b    	cbnz	w27, 0x101766908 <__text+0x175e908>
101766ac4: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101766ac8: f941fd01    	ldr	x1, [x8, #0x3f8] ; setLoadingStatus
101766acc: aa1403e0    	mov	x0, x20
101766ad0: 9593019b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766ad4: 14000022    	b	0x101766b5c <__text+0x175eb5c>
101766ad8: aa1403e0    	mov	x0, x20
101766adc: f94027e1    	ldr	x1, [sp, #0x48]
101766ae0: 95930197    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766ae4: aa1d03fd    	mov	x29, x29
101766ae8: 95930198    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766aec: aa0003f3    	mov	x19, x0
101766af0: aa1403e0    	mov	x0, x20
101766af4: aa1903e1    	mov	x1, x25
101766af8: 95930191    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766afc: aa1d03fd    	mov	x29, x29
101766b00: 95930192    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766b04: aa0003f5    	mov	x21, x0
101766b08: 900f3748    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
101766b0c: f9406d01    	ldr	x1, [x8, #0xd8] ; setTableFooterView:
101766b10: aa1303e2    	mov	x2, x19
101766b14: 9593018a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766b18: aa1503e0    	mov	x0, x21
101766b1c: 9593018e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766b20: aa1303e0    	mov	x0, x19
101766b24: 9593018c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766b28: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101766b2c: f940b101    	ldr	x1, [x8, #0x160] ; feedbackButton
101766b30: aa1403e0    	mov	x0, x20
101766b34: 95930182    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766b38: aa1d03fd    	mov	x29, x29
101766b3c: 95930183    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766b40: aa0003f3    	mov	x19, x0
101766b44: d00f4d08    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
101766b48: f9411101    	ldr	x1, [x8, #0x220] ; setHidden:
101766b4c: 52800022    	mov	w2, #0x1                ; =1
101766b50: 9593017b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766b54: aa1303e0    	mov	x0, x19
101766b58: 9593017f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766b5c: aa1803e0    	mov	x0, x24
101766b60: a94b7bfd    	ldp	x29, x30, [sp, #0xb0]
101766b64: a94a4ff4    	ldp	x20, x19, [sp, #0xa0]
101766b68: a94957f6    	ldp	x22, x21, [sp, #0x90]
101766b6c: a9485ff8    	ldp	x24, x23, [sp, #0x80]
101766b70: a94767fa    	ldp	x26, x25, [sp, #0x70]
101766b74: a9466ffc    	ldp	x28, x27, [sp, #0x60]
101766b78: 910303ff    	add	sp, sp, #0xc0
101766b7c: 15930176    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766b80: aa1503e0    	mov	x0, x21
101766b84: 95930174    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766b88: b00f5068    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101766b8c: f9453500    	ldr	x0, [x8, #0xa68]
101766b90: b00e7168    	adrp	x8, 0x11e593000 <dyld_stub_binder+0x11e593000>
101766b94: 910ca108    	add	x8, x8, #0x328
101766b98: f90003e8    	str	x8, [sp]
101766b9c: d00cd863    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
101766ba0: 91388063    	add	x3, x3, #0xe20
101766ba4: b00ce3e5    	adrp	x5, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
101766ba8: 911b74a5    	add	x5, x5, #0x6dd
101766bac: d00ce3e7    	adrp	x7, 0x11b3e4000 <dyld_stub_binder+0x11b3e4000>
101766bb0: 910e94e7    	add	x7, x7, #0x3a5
101766bb4: f94023e1    	ldr	x1, [sp, #0x40]
101766bb8: 52800042    	mov	w2, #0x2                ; =2
101766bbc: 52800004    	mov	w4, #0x0                ; =0
101766bc0: 528096a6    	mov	w6, #0x4b5              ; =1205
101766bc4: 9593015e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766bc8: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101766bcc: f9413901    	ldr	x1, [x8, #0x270] ; trySwitchToLargeInputBox
101766bd0: 17ffffbf    	b	0x101766acc <__text+0x175eacc>
