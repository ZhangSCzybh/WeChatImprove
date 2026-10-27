
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a80370: d10303ff    	sub	sp, sp, #0xc0
104a80374: a9066ffc    	stp	x28, x27, [sp, #0x60]
104a80378: a90767fa    	stp	x26, x25, [sp, #0x70]
104a8037c: a9085ff8    	stp	x24, x23, [sp, #0x80]
104a80380: a90957f6    	stp	x22, x21, [sp, #0x90]
104a80384: a90a4ff4    	stp	x20, x19, [sp, #0xa0]
104a80388: a90b7bfd    	stp	x29, x30, [sp, #0xb0]
104a8038c: 9102c3fd    	add	x29, sp, #0xb0
104a80390: aa0003f3    	mov	x19, x0
104a80394: d00e0de8    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a80398: 52800029    	mov	w9, #0x1                ; =1
104a8039c: 390b6109    	strb	w9, [x8, #0x2d8]
104a803a0: 900db7a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a803a4: f9411d14    	ldr	x20, [x8, #0x238] ; CMessageWrap
104a803a8: f9400400    	ldr	x0, [x0, #0x8]
104a803ac: b00d9e28    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
104a803b0: f944c51a    	ldr	x26, [x8, #0x988] ; m_msgWrap
104a803b4: aa1a03e1    	mov	x1, x26
104a803b8: 94c69b61    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a803bc: aa1d03fd    	mov	x29, x29
104a803c0: 94c69b62    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a803c4: aa0003f5    	mov	x21, x0
104a803c8: d00d9e28    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
104a803cc: f942c501    	ldr	x1, [x8, #0x588] ; getUserNameFromMsgWrap:
104a803d0: aa1403e0    	mov	x0, x20
104a803d4: aa1503e2    	mov	x2, x21
104a803d8: 94c69b59    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a803dc: aa1d03fd    	mov	x29, x29
104a803e0: 94c69b5a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a803e4: aa0003f8    	mov	x24, x0
104a803e8: aa1503e0    	mov	x0, x21
104a803ec: 94c69b5a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a803f0: f00db796    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104a803f4: f945eac0    	ldr	x0, [x22, #0xbd0] ; MMContext
104a803f8: 900db408    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a803fc: f944e919    	ldr	x25, [x8, #0x9d0] ; currentContext
104a80400: aa1903e1    	mov	x1, x25
104a80404: 94c69b4e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80408: aa1d03fd    	mov	x29, x29
104a8040c: 94c69b4f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80410: aa0003f4    	mov	x20, x0
104a80414: 900db7a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a80418: f9401500    	ldr	x0, [x8, #0x28] ; CContactMgr
104a8041c: f00db3e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a80420: f947ad17    	ldr	x23, [x8, #0xf58] ; class
104a80424: aa1703e1    	mov	x1, x23
104a80428: 94c69b45    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8042c: aa0003e2    	mov	x2, x0
104a80430: b00d9dc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a80434: f946411b    	ldr	x27, [x8, #0xc80] ; getService:
104a80438: aa1403e0    	mov	x0, x20
104a8043c: aa1b03e1    	mov	x1, x27
104a80440: 94c69b3f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80444: aa1d03fd    	mov	x29, x29
104a80448: 94c69b40    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8044c: aa0003f5    	mov	x21, x0
104a80450: 900d9de8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a80454: f940c91c    	ldr	x28, [x8, #0x190] ; getContactByName:
104a80458: aa1c03e1    	mov	x1, x28
104a8045c: f90027f8    	str	x24, [sp, #0x48]
104a80460: aa1803e2    	mov	x2, x24
104a80464: 94c69b36    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80468: aa1d03fd    	mov	x29, x29
104a8046c: 94c69b37    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80470: aa0003f8    	mov	x24, x0
104a80474: aa1503e0    	mov	x0, x21
104a80478: 94c69b37    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8047c: aa1403e0    	mov	x0, x20
104a80480: 94c69b35    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80484: a9056ff7    	stp	x23, x27, [sp, #0x50]
104a80488: f90023fc    	str	x28, [sp, #0x40]
104a8048c: b50004b8    	cbnz	x24, 0x104a80520 <_Flutter_MMFoundation_BindContext+0xf5c104>
104a80490: f945eac0    	ldr	x0, [x22, #0xbd0] ; MMContext
104a80494: aa1903e1    	mov	x1, x25
104a80498: 94c69b29    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8049c: aa1d03fd    	mov	x29, x29
104a804a0: 94c69b2a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a804a4: aa0003f4    	mov	x20, x0
104a804a8: b00db7a8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
104a804ac: f942e900    	ldr	x0, [x8, #0x5d0] ; StrangerContactMgr
104a804b0: aa1703e1    	mov	x1, x23
104a804b4: 94c69b22    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a804b8: aa0003e2    	mov	x2, x0
104a804bc: aa1403e0    	mov	x0, x20
104a804c0: aa1b03e1    	mov	x1, x27
104a804c4: 94c69b1e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a804c8: aa1d03fd    	mov	x29, x29
104a804cc: 94c69b1f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a804d0: aa0003f5    	mov	x21, x0
104a804d4: aa1c03e1    	mov	x1, x28
104a804d8: f94027e2    	ldr	x2, [sp, #0x48]
104a804dc: 94c69b18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a804e0: aa1d03fd    	mov	x29, x29
104a804e4: 94c69b19    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a804e8: aa0003f8    	mov	x24, x0
104a804ec: aa1503e0    	mov	x0, x21
104a804f0: 94c69b19    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a804f4: aa1403e0    	mov	x0, x20
104a804f8: 94c69b17    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a804fc: b5000138    	cbnz	x24, 0x104a80520 <_Flutter_MMFoundation_BindContext+0xf5c104>
104a80500: f00db788    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a80504: f9478100    	ldr	x0, [x8, #0xf00] ; CContact
104a80508: 94c69b14    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104a8050c: aa0003f8    	mov	x24, x0
104a80510: 900d9de8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a80514: f945fd01    	ldr	x1, [x8, #0xbf8] ; setM_nsUsrName:
104a80518: f94027e2    	ldr	x2, [sp, #0x48]
104a8051c: 94c69b08    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80520: 3940d668    	ldrb	w8, [x19, #0x35]
104a80524: 900d9dfb    	adrp	x27, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a80528: f00db795    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
104a8052c: b00d9dd7    	adrp	x23, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a80530: 360003a8    	tbz	w8, #0x0, 0x104a805a4 <_Flutter_MMFoundation_BindContext+0xf5c188>
104a80534: f945eac0    	ldr	x0, [x22, #0xbd0] ; MMContext
104a80538: aa1903e1    	mov	x1, x25
104a8053c: 94c69b00    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80540: aa1d03fd    	mov	x29, x29
104a80544: 94c69b01    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80548: aa0003f4    	mov	x20, x0
104a8054c: f9462aa0    	ldr	x0, [x21, #0xc50] ; MMLanguageMgr
104a80550: f9402be1    	ldr	x1, [sp, #0x50]
104a80554: 94c69afa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80558: aa0003e2    	mov	x2, x0
104a8055c: aa1403e0    	mov	x0, x20
104a80560: f9402fe1    	ldr	x1, [sp, #0x58]
104a80564: 94c69af6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80568: aa1d03fd    	mov	x29, x29
104a8056c: 94c69af7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80570: aa0003f5    	mov	x21, x0
104a80574: f94646e1    	ldr	x1, [x23, #0xc88] ; getStringForCurLanguage:
104a80578: b00ce8e2    	adrp	x2, 0x11e79d000 <dyld_stub_binder+0x11e79d000>
104a8057c: 910f2042    	add	x2, x2, #0x3c8 ; CFString 'BrandHolder_MessageItemMySelf'
104a80580: 94c69aef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80584: aa1d03fd    	mov	x29, x29
104a80588: 94c69af0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8058c: aa0003fc    	mov	x28, x0
104a80590: aa1503e0    	mov	x0, x21
104a80594: 94c69af0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80598: aa1403e0    	mov	x0, x20
104a8059c: 94c69aee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a805a0: 14000007    	b	0x104a805bc <_Flutter_MMFoundation_BindContext+0xf5c1a0>
104a805a4: f944c761    	ldr	x1, [x27, #0x988] ; getContactDisplayName
104a805a8: aa1803e0    	mov	x0, x24
104a805ac: 94c69ae4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a805b0: aa1d03fd    	mov	x29, x29
104a805b4: 94c69ae5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a805b8: aa0003fc    	mov	x28, x0
104a805bc: f9400660    	ldr	x0, [x19, #0x8]
104a805c0: f00da788    	adrp	x8, 0x11ff73000 <dyld_stub_binder+0x11ff73000>
104a805c4: f9460514    	ldr	x20, [x8, #0xc08] ; m_nsBrandNotifyPrefixName
104a805c8: aa1403e1    	mov	x1, x20
104a805cc: 94c69adc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a805d0: aa1d03fd    	mov	x29, x29
104a805d4: 94c69add    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a805d8: aa0003f5    	mov	x21, x0
104a805dc: f00db408    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104a805e0: f946e901    	ldr	x1, [x8, #0xdd0] ; length
104a805e4: f9001fe1    	str	x1, [sp, #0x38]
104a805e8: 94c69ad5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a805ec: aa0003f7    	mov	x23, x0
104a805f0: aa1503e0    	mov	x0, x21
104a805f4: 94c69ad8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a805f8: b4000157    	cbz	x23, 0x104a80620 <_Flutter_MMFoundation_BindContext+0xf5c204>
104a805fc: f9400660    	ldr	x0, [x19, #0x8]
104a80600: aa1403e1    	mov	x1, x20
104a80604: 94c69ace    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80608: aa1d03fd    	mov	x29, x29
104a8060c: 94c69acf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80610: aa0003f4    	mov	x20, x0
104a80614: aa1c03e0    	mov	x0, x28
104a80618: 94c69acf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8061c: aa1403fc    	mov	x28, x20
104a80620: f9400660    	ldr	x0, [x19, #0x8]
104a80624: 900d9e28    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104a80628: f947d901    	ldr	x1, [x8, #0xfb0] ; m_nsUserName
104a8062c: f9001be1    	str	x1, [sp, #0x30]
104a80630: 94c69ac3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80634: aa1d03fd    	mov	x29, x29
104a80638: 94c69ac4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8063c: aa0003f4    	mov	x20, x0
104a80640: f00db408    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104a80644: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
104a80648: 900cd182    	adrp	x2, 0x11e4b0000 <dyld_stub_binder+0x11e4b0000>
104a8064c: 9139a042    	add	x2, x2, #0xe68 ; CFString 'fav_weapp_messages'
104a80650: f90017e1    	str	x1, [sp, #0x28]
104a80654: 94c69aba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80658: aa0003f5    	mov	x21, x0
104a8065c: aa1403e0    	mov	x0, x20
104a80660: 94c69abd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80664: f90013fa    	str	x26, [sp, #0x20]
104a80668: 340007b5    	cbz	w21, 0x104a8075c <_Flutter_MMFoundation_BindContext+0xf5c340>
104a8066c: f945eac0    	ldr	x0, [x22, #0xbd0] ; MMContext
104a80670: aa1903e1    	mov	x1, x25
104a80674: 94c69ab2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80678: aa1d03fd    	mov	x29, x29
104a8067c: 94c69ab3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80680: aa0003f5    	mov	x21, x0
104a80684: 900db7a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a80688: f9401500    	ldr	x0, [x8, #0x28] ; CContactMgr
104a8068c: f9402be1    	ldr	x1, [sp, #0x50]
104a80690: 94c69aab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80694: aa0003e2    	mov	x2, x0
104a80698: aa1503e0    	mov	x0, x21
104a8069c: f9402fe1    	ldr	x1, [sp, #0x58]
104a806a0: 94c69aa7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a806a4: aa1d03fd    	mov	x29, x29
104a806a8: 94c69aa8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a806ac: aa0003f4    	mov	x20, x0
104a806b0: f9400660    	ldr	x0, [x19, #0x8]
104a806b4: aa1a03e1    	mov	x1, x26
104a806b8: 94c69aa1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a806bc: aa1d03fd    	mov	x29, x29
104a806c0: 94c69aa2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a806c4: aa0003fa    	mov	x26, x0
104a806c8: f00d9de8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104a806cc: f941e901    	ldr	x1, [x8, #0x3d0] ; m_nsRealChatUsr
104a806d0: 94c69a9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a806d4: aa1d03fd    	mov	x29, x29
104a806d8: 94c69a9c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a806dc: aa0003f7    	mov	x23, x0
104a806e0: aa1403e0    	mov	x0, x20
104a806e4: f94023e1    	ldr	x1, [sp, #0x40]
104a806e8: aa1703e2    	mov	x2, x23
104a806ec: 94c69a94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a806f0: aa1d03fd    	mov	x29, x29
104a806f4: 94c69a95    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a806f8: aa1903f6    	mov	x22, x25
104a806fc: aa1803f9    	mov	x25, x24
104a80700: aa1c03f8    	mov	x24, x28
104a80704: aa0003fc    	mov	x28, x0
104a80708: f944c761    	ldr	x1, [x27, #0x988] ; getContactDisplayName
104a8070c: 94c69a8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80710: aa1d03fd    	mov	x29, x29
104a80714: 94c69a8d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80718: aa0003fb    	mov	x27, x0
104a8071c: aa1803e0    	mov	x0, x24
104a80720: 94c69a8d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80724: aa1c03e0    	mov	x0, x28
104a80728: aa1903f8    	mov	x24, x25
104a8072c: aa1603f9    	mov	x25, x22
104a80730: f00db796    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104a80734: 94c69a88    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80738: aa1703e0    	mov	x0, x23
104a8073c: 94c69a86    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80740: aa1a03e0    	mov	x0, x26
104a80744: 94c69a84    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80748: aa1403e0    	mov	x0, x20
104a8074c: 94c69a82    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80750: aa1503e0    	mov	x0, x21
104a80754: 94c69a80    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80758: aa1b03fc    	mov	x28, x27
104a8075c: aa1c03e0    	mov	x0, x28
104a80760: f9401fe1    	ldr	x1, [sp, #0x38]
104a80764: 94c69a76    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80768: f00db789    	adrp	x9, 0x120173000 <dyld_stub_binder+0x120173000>
104a8076c: d00db448    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104a80770: b4000160    	cbz	x0, 0x104a8079c <_Flutter_MMFoundation_BindContext+0xf5c380>
104a80774: f9454520    	ldr	x0, [x9, #0xa88]
104a80778: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
104a8077c: f90003fc    	str	x28, [sp]
104a80780: 900cd802    	adrp	x2, 0x11e580000 <dyld_stub_binder+0x11e580000>
104a80784: 91202042    	add	x2, x2, #0x808 ; CFString '%@: '
104a80788: 94c69a6d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8078c: aa1d03fd    	mov	x29, x29
104a80790: 94c69a6e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80794: aa0003fa    	mov	x26, x0
104a80798: 14000003    	b	0x104a807a4 <_Flutter_MMFoundation_BindContext+0xf5c388>
104a8079c: f00cd0da    	adrp	x26, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104a807a0: 9103235a    	add	x26, x26, #0xc8 ; CFString ''
104a807a4: f9402bfb    	ldr	x27, [sp, #0x50]
104a807a8: f9400660    	ldr	x0, [x19, #0x8]
104a807ac: f00d9dc8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104a807b0: f947d901    	ldr	x1, [x8, #0xfb0] ; m_contact
104a807b4: 94c69a62    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a807b8: aa1d03fd    	mov	x29, x29
104a807bc: 94c69a63    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a807c0: aa0003f5    	mov	x21, x0
104a807c4: 900da828    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a807c8: f9423101    	ldr	x1, [x8, #0x460] ; isFavWeAppMsgHolder
104a807cc: 94c69a5c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a807d0: 340007a0    	cbz	w0, 0x104a808c4 <_Flutter_MMFoundation_BindContext+0xf5c4a8>
104a807d4: f9400660    	ldr	x0, [x19, #0x8]
104a807d8: b00d9de8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104a807dc: f942e514    	ldr	x20, [x8, #0x5c8] ; m_uUnReadCount
104a807e0: aa1403e1    	mov	x1, x20
104a807e4: 94c69a56    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a807e8: aa0003f7    	mov	x23, x0
104a807ec: aa1503e0    	mov	x0, x21
104a807f0: 94c69a59    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a807f4: 71000aff    	cmp	w23, #0x2
104a807f8: 540006a3    	b.lo	0x104a808cc <_Flutter_MMFoundation_BindContext+0xf5c4b0>
104a807fc: f00db788    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a80800: f9454508    	ldr	x8, [x8, #0xa88]
104a80804: f9000fe8    	str	x8, [sp, #0x18]
104a80808: f945eac0    	ldr	x0, [x22, #0xbd0] ; MMContext
104a8080c: aa1903e1    	mov	x1, x25
104a80810: 94c69a4b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80814: aa1d03fd    	mov	x29, x29
104a80818: 94c69a4c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8081c: aa0003f5    	mov	x21, x0
104a80820: f00db788    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a80824: f9462900    	ldr	x0, [x8, #0xc50] ; MMLanguageMgr
104a80828: aa1b03e1    	mov	x1, x27
104a8082c: 94c69a44    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80830: aa0003e2    	mov	x2, x0
104a80834: aa1503e0    	mov	x0, x21
104a80838: f9402fe1    	ldr	x1, [sp, #0x58]
104a8083c: 94c69a40    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80840: aa1d03fd    	mov	x29, x29
104a80844: 94c69a41    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80848: aa0003fb    	mov	x27, x0
104a8084c: b00d9dc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a80850: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
104a80854: f00cdee2    	adrp	x2, 0x11e65f000 <dyld_stub_binder+0x11e65f000>
104a80858: 910ba042    	add	x2, x2, #0x2e8 ; CFString 'MessageContent_Unread_Msgs'
104a8085c: 94c69a38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80860: aa1d03fd    	mov	x29, x29
104a80864: 94c69a39    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80868: aa1c03f7    	mov	x23, x28
104a8086c: aa0003fc    	mov	x28, x0
104a80870: f9400660    	ldr	x0, [x19, #0x8]
104a80874: aa1403e1    	mov	x1, x20
104a80878: 94c69a31    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8087c: d00db448    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104a80880: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
104a80884: a9006be0    	stp	x0, x26, [sp]
104a80888: f9400fe0    	ldr	x0, [sp, #0x18]
104a8088c: aa1c03e2    	mov	x2, x28
104a80890: 94c69a2b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80894: aa1d03fd    	mov	x29, x29
104a80898: 94c69a2c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8089c: aa0003f4    	mov	x20, x0
104a808a0: aa1a03e0    	mov	x0, x26
104a808a4: 94c69a2c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a808a8: aa1c03e0    	mov	x0, x28
104a808ac: aa1703fc    	mov	x28, x23
104a808b0: 94c69a29    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a808b4: aa1b03e0    	mov	x0, x27
104a808b8: f9402bfb    	ldr	x27, [sp, #0x50]
104a808bc: 94c69a26    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a808c0: aa1403fa    	mov	x26, x20
104a808c4: aa1503e0    	mov	x0, x21
104a808c8: 94c69a23    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a808cc: f945eac0    	ldr	x0, [x22, #0xbd0] ; MMContext
104a808d0: aa1903e1    	mov	x1, x25
104a808d4: 94c69a1a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a808d8: aa1d03fd    	mov	x29, x29
104a808dc: 94c69a1b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a808e0: aa0003f4    	mov	x20, x0
104a808e4: 900db7a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a808e8: f941c100    	ldr	x0, [x8, #0x380] ; BrandTimelineMsgMgr
104a808ec: aa1b03e1    	mov	x1, x27
104a808f0: 94c69a13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a808f4: aa0003e2    	mov	x2, x0
104a808f8: aa1403e0    	mov	x0, x20
104a808fc: f9402fe1    	ldr	x1, [sp, #0x58]
104a80900: 94c69a0f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80904: aa1d03fd    	mov	x29, x29
104a80908: 94c69a10    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8090c: aa0003f5    	mov	x21, x0
104a80910: f00d9e88    	adrp	x8, 0x11fe53000 <dyld_stub_binder+0x11fe53000>
104a80914: f9478101    	ldr	x1, [x8, #0xf00] ; useSimulatedNativePersonalCenter
104a80918: 94c69a09    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8091c: aa0003f7    	mov	x23, x0
104a80920: aa1503e0    	mov	x0, x21
104a80924: 94c69a0c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80928: aa1403e0    	mov	x0, x20
104a8092c: 94c69a0a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80930: b00d9df4    	adrp	x20, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104a80934: 34000137    	cbz	w23, 0x104a80958 <_Flutter_MMFoundation_BindContext+0xf5c53c>
104a80938: f9400660    	ldr	x0, [x19, #0x8]
104a8093c: f942e281    	ldr	x1, [x20, #0x5c0] ; m_uBrandNotifyType
104a80940: 94c699ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80944: 361000a0    	tbz	w0, #0x2, 0x104a80958 <_Flutter_MMFoundation_BindContext+0xf5c53c>
104a80948: aa1a03e0    	mov	x0, x26
104a8094c: 94c69a02    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80950: f00cd0da    	adrp	x26, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104a80954: 9103235a    	add	x26, x26, #0xc8 ; CFString ''
104a80958: f9400660    	ldr	x0, [x19, #0x8]
104a8095c: f00da788    	adrp	x8, 0x11ff73000 <dyld_stub_binder+0x11ff73000>
104a80960: f9460d01    	ldr	x1, [x8, #0xc18] ; m_bBrandNotifyNoPrefixName
104a80964: 94c699f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80968: 340000a0    	cbz	w0, 0x104a8097c <_Flutter_MMFoundation_BindContext+0xf5c560>
104a8096c: aa1a03e0    	mov	x0, x26
104a80970: 94c699f9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80974: f00cd0da    	adrp	x26, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104a80978: 9103235a    	add	x26, x26, #0xc8 ; CFString ''
104a8097c: f9400660    	ldr	x0, [x19, #0x8]
104a80980: f942e294    	ldr	x20, [x20, #0x5c0] ; m_uBrandNotifyType
104a80984: aa1403e1    	mov	x1, x20
104a80988: 94c699ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8098c: 362800a0    	tbz	w0, #0x5, 0x104a809a0 <_Flutter_MMFoundation_BindContext+0xf5c584>
104a80990: aa1a03e0    	mov	x0, x26
104a80994: 94c699f0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80998: f00cd0da    	adrp	x26, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104a8099c: 9103235a    	add	x26, x26, #0xc8 ; CFString ''
104a809a0: f9400660    	ldr	x0, [x19, #0x8]
104a809a4: aa1403e1    	mov	x1, x20
104a809a8: 94c699e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a809ac: 371800a0    	tbnz	w0, #0x3, 0x104a809c0 <_Flutter_MMFoundation_BindContext+0xf5c5a4>
104a809b0: f9400660    	ldr	x0, [x19, #0x8]
104a809b4: aa1403e1    	mov	x1, x20
104a809b8: 94c699e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a809bc: 362005c0    	tbz	w0, #0x4, 0x104a80a74 <_Flutter_MMFoundation_BindContext+0xf5c658>
104a809c0: f00db788    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a809c4: f9454514    	ldr	x20, [x8, #0xa88]
104a809c8: f945eac0    	ldr	x0, [x22, #0xbd0] ; MMContext
104a809cc: aa1903e1    	mov	x1, x25
104a809d0: 94c699db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a809d4: aa1d03fd    	mov	x29, x29
104a809d8: 94c699dc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a809dc: aa0003f5    	mov	x21, x0
104a809e0: f00db788    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a809e4: f9462900    	ldr	x0, [x8, #0xc50] ; MMLanguageMgr
104a809e8: aa1b03e1    	mov	x1, x27
104a809ec: 94c699d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a809f0: aa0003e2    	mov	x2, x0
104a809f4: aa1503e0    	mov	x0, x21
104a809f8: f9402fe1    	ldr	x1, [sp, #0x58]
104a809fc: 94c699d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80a00: aa1d03fd    	mov	x29, x29
104a80a04: 94c699d1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80a08: aa0003f7    	mov	x23, x0
104a80a0c: b00d9dc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a80a10: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
104a80a14: b00ce8e2    	adrp	x2, 0x11e79d000 <dyld_stub_binder+0x11e79d000>
104a80a18: 910fa042    	add	x2, x2, #0x3e8 ; CFString 'Brand_Timeline_BrandLive_MainSession_Digest'
104a80a1c: 94c699c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80a20: aa1d03fd    	mov	x29, x29
104a80a24: 94c699c9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80a28: aa0003fb    	mov	x27, x0
104a80a2c: d00db448    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104a80a30: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
104a80a34: f90003fc    	str	x28, [sp]
104a80a38: aa1403e0    	mov	x0, x20
104a80a3c: aa1b03e2    	mov	x2, x27
104a80a40: 94c699bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80a44: aa1d03fd    	mov	x29, x29
104a80a48: 94c699c0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80a4c: aa0003f4    	mov	x20, x0
104a80a50: aa1a03e0    	mov	x0, x26
104a80a54: 94c699c0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80a58: aa1b03e0    	mov	x0, x27
104a80a5c: 94c699be    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80a60: aa1703e0    	mov	x0, x23
104a80a64: 94c699bc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80a68: aa1503e0    	mov	x0, x21
104a80a6c: 94c699ba    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80a70: aa1403fa    	mov	x26, x20
104a80a74: f94023fb    	ldr	x27, [sp, #0x40]
104a80a78: f9400660    	ldr	x0, [x19, #0x8]
104a80a7c: f9401be1    	ldr	x1, [sp, #0x30]
104a80a80: 94c699af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80a84: aa1d03fd    	mov	x29, x29
104a80a88: 94c699b0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80a8c: aa0003f4    	mov	x20, x0
104a80a90: 900cd182    	adrp	x2, 0x11e4b0000 <dyld_stub_binder+0x11e4b0000>
104a80a94: 913aa042    	add	x2, x2, #0xea8 ; CFString 'chatroom_session_box'
104a80a98: f94017e1    	ldr	x1, [sp, #0x28]
104a80a9c: 94c699a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80aa0: aa0003f5    	mov	x21, x0
104a80aa4: aa1403e0    	mov	x0, x20
104a80aa8: 94c699ab    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80aac: 34000ab5    	cbz	w21, 0x104a80c00 <_Flutter_MMFoundation_BindContext+0xf5c7e4>
104a80ab0: f9400660    	ldr	x0, [x19, #0x8]
104a80ab4: f94013e1    	ldr	x1, [sp, #0x20]
104a80ab8: 94c699a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80abc: aa1d03fd    	mov	x29, x29
104a80ac0: 94c699a2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80ac4: aa0003f5    	mov	x21, x0
104a80ac8: b00d9de8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104a80acc: f9479d01    	ldr	x1, [x8, #0xf38] ; GetChatName
104a80ad0: 94c6999b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80ad4: aa1d03fd    	mov	x29, x29
104a80ad8: 94c6999c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80adc: aa0003f4    	mov	x20, x0
104a80ae0: aa1503e0    	mov	x0, x21
104a80ae4: 94c6999c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80ae8: aa1403e0    	mov	x0, x20
104a80aec: f9401fe1    	ldr	x1, [sp, #0x38]
104a80af0: 94c69993    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80af4: b4000780    	cbz	x0, 0x104a80be4 <_Flutter_MMFoundation_BindContext+0xf5c7c8>
104a80af8: f945eac0    	ldr	x0, [x22, #0xbd0] ; MMContext
104a80afc: aa1903e1    	mov	x1, x25
104a80b00: 94c6998f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80b04: aa1d03fd    	mov	x29, x29
104a80b08: 94c69990    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80b0c: aa0003f5    	mov	x21, x0
104a80b10: 900db7a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a80b14: f9401500    	ldr	x0, [x8, #0x28] ; CContactMgr
104a80b18: f9402be1    	ldr	x1, [sp, #0x50]
104a80b1c: 94c69988    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80b20: aa0003e2    	mov	x2, x0
104a80b24: aa1503e0    	mov	x0, x21
104a80b28: f9402fe1    	ldr	x1, [sp, #0x58]
104a80b2c: 94c69984    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80b30: aa1d03fd    	mov	x29, x29
104a80b34: 94c69985    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80b38: aa0003f7    	mov	x23, x0
104a80b3c: aa1b03e1    	mov	x1, x27
104a80b40: aa1403e2    	mov	x2, x20
104a80b44: 94c6997e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80b48: aa1d03fd    	mov	x29, x29
104a80b4c: 94c6997f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80b50: aa1803f9    	mov	x25, x24
104a80b54: aa0003f8    	mov	x24, x0
104a80b58: aa1703e0    	mov	x0, x23
104a80b5c: 94c6997e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80b60: aa1503e0    	mov	x0, x21
104a80b64: 94c6997c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80b68: f00db788    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a80b6c: f9454515    	ldr	x21, [x8, #0xa88]
104a80b70: f00db788    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a80b74: f9478100    	ldr	x0, [x8, #0xf00] ; CContact
104a80b78: d00da028    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
104a80b7c: f9408101    	ldr	x1, [x8, #0x100] ; genChatRoomName:truncateByLen:appendTailText:
104a80b80: b00ce8e4    	adrp	x4, 0x11e79d000 <dyld_stub_binder+0x11e79d000>
104a80b84: 91102084    	add	x4, x4, #0x408 ; CFString '... '
104a80b88: aa1803e2    	mov	x2, x24
104a80b8c: 52800143    	mov	w3, #0xa                ; =10
104a80b90: 94c6996b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80b94: aa1d03fd    	mov	x29, x29
104a80b98: 94c6996c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80b9c: aa0003f7    	mov	x23, x0
104a80ba0: d00db448    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104a80ba4: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
104a80ba8: f90003e0    	str	x0, [sp]
104a80bac: 900cd802    	adrp	x2, 0x11e580000 <dyld_stub_binder+0x11e580000>
104a80bb0: 91202042    	add	x2, x2, #0x808 ; CFString '%@: '
104a80bb4: aa1503e0    	mov	x0, x21
104a80bb8: 94c69961    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80bbc: aa1d03fd    	mov	x29, x29
104a80bc0: 94c69962    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a80bc4: aa0003f5    	mov	x21, x0
104a80bc8: aa1a03e0    	mov	x0, x26
104a80bcc: 94c69962    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80bd0: aa1703e0    	mov	x0, x23
104a80bd4: 94c69960    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80bd8: aa1803fa    	mov	x26, x24
104a80bdc: aa1903f8    	mov	x24, x25
104a80be0: 14000003    	b	0x104a80bec <_Flutter_MMFoundation_BindContext+0xf5c7d0>
104a80be4: f00cd0d5    	adrp	x21, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104a80be8: 910322b5    	add	x21, x21, #0xc8 ; CFString ''
104a80bec: aa1a03e0    	mov	x0, x26
104a80bf0: 94c69959    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80bf4: aa1403e0    	mov	x0, x20
104a80bf8: 94c69957    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80bfc: aa1503fa    	mov	x26, x21
104a80c00: 900da828    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a80c04: f9423501    	ldr	x1, [x8, #0x468] ; setM_prefixTextForQuoteMessage:
104a80c08: aa1303e0    	mov	x0, x19
104a80c0c: aa1a03e2    	mov	x2, x26
104a80c10: 94c6994b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a80c14: aa1c03e0    	mov	x0, x28
104a80c18: 94c6994f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80c1c: aa1a03e0    	mov	x0, x26
104a80c20: 94c6994d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80c24: aa1803e0    	mov	x0, x24
104a80c28: 94c6994b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a80c2c: f94027e0    	ldr	x0, [sp, #0x48]
104a80c30: a94b7bfd    	ldp	x29, x30, [sp, #0xb0]
104a80c34: a94a4ff4    	ldp	x20, x19, [sp, #0xa0]
104a80c38: a94957f6    	ldp	x22, x21, [sp, #0x90]
104a80c3c: a9485ff8    	ldp	x24, x23, [sp, #0x80]
104a80c40: a94767fa    	ldp	x26, x25, [sp, #0x70]
104a80c44: a9466ffc    	ldp	x28, x27, [sp, #0x60]
104a80c48: 910303ff    	add	sp, sp, #0xc0
104a80c4c: 14c69942    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
