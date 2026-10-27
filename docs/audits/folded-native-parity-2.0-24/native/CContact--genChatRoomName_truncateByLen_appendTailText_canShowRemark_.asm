
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f914e4: d10703ff    	sub	sp, sp, #0x1c0
100f914e8: a9166ffc    	stp	x28, x27, [sp, #0x160]
100f914ec: a91767fa    	stp	x26, x25, [sp, #0x170]
100f914f0: a9185ff8    	stp	x24, x23, [sp, #0x180]
100f914f4: a91957f6    	stp	x22, x21, [sp, #0x190]
100f914f8: a91a4ff4    	stp	x20, x19, [sp, #0x1a0]
100f914fc: a91b7bfd    	stp	x29, x30, [sp, #0x1b0]
100f91500: 9106c3fd    	add	x29, sp, #0x1b0
100f91504: aa0503f5    	mov	x21, x5
100f91508: aa0403f9    	mov	x25, x4
100f9150c: aa0303f6    	mov	x22, x3
100f91510: aa0203f3    	mov	x19, x2
100f91514: d00e32e8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
100f91518: f9405908    	ldr	x8, [x8, #0xb0]
100f9151c: f9400108    	ldr	x8, [x8]
100f91520: f81a03a8    	stur	x8, [x29, #-0x60]
100f91524: f00fe4e8    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100f91528: 52800029    	mov	w9, #0x1                ; =1
100f9152c: 392be109    	strb	w9, [x8, #0xaf8]
100f91530: aa0203e0    	mov	x0, x2
100f91534: 95b25701    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100f91538: aa1903e0    	mov	x0, x25
100f9153c: 95b256ff    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100f91540: b00f7708    	adrp	x8, 0x11fe72000 <dyld_stub_binder+0x11fe72000>
100f91544: f940f514    	ldr	x20, [x8, #0x1e8] ; getRemark
100f91548: aa1303e0    	mov	x0, x19
100f9154c: aa1403e1    	mov	x1, x20
100f91550: 95b256fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91554: aa1d03fd    	mov	x29, x29
100f91558: 95b256fc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f9155c: aa0003f7    	mov	x23, x0
100f91560: d00f8b88    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100f91564: f946e91b    	ldr	x27, [x8, #0xdd0] ; length
100f91568: aa1b03e1    	mov	x1, x27
100f9156c: 95b256f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91570: aa0003f8    	mov	x24, x0
100f91574: aa1703e0    	mov	x0, x23
100f91578: 95b256f7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f9157c: f100031f    	cmp	x24, #0x0
100f91580: 7a401aa4    	ccmp	w21, #0x0, #0x4, ne
100f91584: 54001e81    	b.ne	0x100f91954 <__text+0xf89954>
100f91588: d00f8f08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f9158c: f947dd15    	ldr	x21, [x8, #0xfb8] ; CGroupMgr
100f91590: d00f7548    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100f91594: f9435114    	ldr	x20, [x8, #0x6a0] ; m_nsNickName
100f91598: aa1303e0    	mov	x0, x19
100f9159c: aa1403e1    	mov	x1, x20
100f915a0: 95b256e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f915a4: aa1d03fd    	mov	x29, x29
100f915a8: 95b256e8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f915ac: aa0003f7    	mov	x23, x0
100f915b0: b00f77a8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
100f915b4: f9408901    	ldr	x1, [x8, #0x110] ; IsReservedGroupTopic:
100f915b8: aa1503e0    	mov	x0, x21
100f915bc: aa1703e2    	mov	x2, x23
100f915c0: 95b256df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f915c4: aa0003f5    	mov	x21, x0
100f915c8: aa1703e0    	mov	x0, x23
100f915cc: 95b256e2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f915d0: 34001c35    	cbz	w21, 0x100f91954 <__text+0xf89954>
100f915d4: d00f8f08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f915d8: f9478114    	ldr	x20, [x8, #0xf00] ; CContact
100f915dc: d00f7548    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100f915e0: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
100f915e4: aa1303e0    	mov	x0, x19
100f915e8: 95b256d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f915ec: aa1d03fd    	mov	x29, x29
100f915f0: 95b256d6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f915f4: aa0003f5    	mov	x21, x0
100f915f8: b00f76c8    	adrp	x8, 0x11fe6a000 <dyld_stub_binder+0x11fe6a000>
100f915fc: f946b901    	ldr	x1, [x8, #0xd70] ; getChatRoomMemberUserName:
100f91600: aa1403e0    	mov	x0, x20
100f91604: aa1503e2    	mov	x2, x21
100f91608: 95b256cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f9160c: aa1d03fd    	mov	x29, x29
100f91610: 95b256ce    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f91614: aa0003fa    	mov	x26, x0
100f91618: aa1503e0    	mov	x0, x21
100f9161c: 95b256ce    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f91620: f00f8b68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100f91624: f9435101    	ldr	x1, [x8, #0x6a0] ; count
100f91628: aa1a03e0    	mov	x0, x26
100f9162c: 95b256c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91630: f9002fe0    	str	x0, [sp, #0x58]
100f91634: 340019e0    	cbz	w0, 0x100f91970 <__text+0xf89970>
100f91638: d00f8f08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f9163c: f945cd00    	ldr	x0, [x8, #0xb98]
100f91640: 95b256c6    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
100f91644: aa0003f7    	mov	x23, x0
100f91648: 4f00e400    	movi.16b	v0, #0x0
100f9164c: ad0483e0    	stp	q0, q0, [sp, #0x90]
100f91650: ad0583e0    	stp	q0, q0, [sp, #0xb0]
100f91654: aa1a03e0    	mov	x0, x26
100f91658: 95b256b8    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100f9165c: f00f8b68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100f91660: f9435514    	ldr	x20, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
100f91664: 910243e2    	add	x2, sp, #0x90
100f91668: 910343e3    	add	x3, sp, #0xd0
100f9166c: aa1403e1    	mov	x1, x20
100f91670: 52800204    	mov	w4, #0x10               ; =16
100f91674: 95b256b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91678: b4001ee0    	cbz	x0, 0x100f91a54 <__text+0xf89a54>
100f9167c: a90267f3    	stp	x19, x25, [sp, #0x20]
100f91680: f90023fb    	str	x27, [sp, #0x40]
100f91684: b00f7709    	adrp	x9, 0x11fe72000 <dyld_stub_binder+0x11fe72000>
100f91688: f00f8b6a    	adrp	x10, 0x120100000 <dyld_stub_binder+0x120100000>
100f9168c: f94053e8    	ldr	x8, [sp, #0xa0]
100f91690: d00f8b6b    	adrp	x11, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f91694: 900f754d    	adrp	x13, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f91698: f9400113    	ldr	x19, [x8]
100f9169c: f00f7548    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100f916a0: d00f754e    	adrp	x14, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100f916a4: 900f754f    	adrp	x15, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f916a8: f00f7550    	adrp	x16, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100f916ac: d00f8b71    	adrp	x17, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f916b0: aa0003f9    	mov	x25, x0
100f916b4: f9000ff4    	str	x20, [sp, #0x18]
100f916b8: f9001bf3    	str	x19, [sp, #0x30]
100f916bc: d280001c    	mov	x28, #0x0               ; =0
100f916c0: f9479129    	ldr	x9, [x9, #0xf20] ; calStringLen:
100f916c4: f9003be9    	str	x9, [sp, #0x70]
100f916c8: f944e949    	ldr	x9, [x10, #0x9d0] ; currentContext
100f916cc: f9003fe9    	str	x9, [sp, #0x78]
100f916d0: f947ad6a    	ldr	x10, [x11, #0xf58] ; class
100f916d4: f94641a9    	ldr	x9, [x13, #0xc80] ; getService:
100f916d8: a90827ea    	stp	x10, x9, [sp, #0x80]
100f916dc: f940c909    	ldr	x9, [x8, #0x190] ; getContactByName:
100f916e0: f94709c8    	ldr	x8, [x14, #0xe10] ; isSelf
100f916e4: a90627e8    	stp	x8, x9, [sp, #0x60]
100f916e8: f94645e8    	ldr	x8, [x15, #0xc88] ; getStringForCurLanguage:
100f916ec: f9001fe8    	str	x8, [sp, #0x38]
100f916f0: f944c609    	ldr	x9, [x16, #0x988] ; getContactDisplayName
100f916f4: f9414628    	ldr	x8, [x17, #0x288] ; appendFormat:
100f916f8: a904a7e8    	stp	x8, x9, [sp, #0x48]
100f916fc: f94053e8    	ldr	x8, [sp, #0xa0]
100f91700: f9400108    	ldr	x8, [x8]
100f91704: eb13011f    	cmp	x8, x19
100f91708: 54000060    	b.eq	0x100f91714 <__text+0xf89714>
100f9170c: aa1a03e0    	mov	x0, x26
100f91710: 95b25690    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
100f91714: f9404fe8    	ldr	x8, [sp, #0x98]
100f91718: f87c7914    	ldr	x20, [x8, x28, lsl #3]
100f9171c: d00f8f08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f91720: f9464900    	ldr	x0, [x8, #0xc90] ; CAppUtil
100f91724: f9403be1    	ldr	x1, [sp, #0x70]
100f91728: aa1703e2    	mov	x2, x23
100f9172c: 95b25684    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91730: f10006df    	cmp	x22, #0x1
100f91734: 5400008b    	b.lt	0x100f91744 <__text+0xf89744>
100f91738: 2a0003e8    	mov	w8, w0
100f9173c: eb16011f    	cmp	x8, x22
100f91740: 540015ac    	b.gt	0x100f919f4 <__text+0xf899f4>
100f91744: 7100441f    	cmp	w0, #0x11
100f91748: 54001782    	b.hs	0x100f91a38 <__text+0xf89a38>
100f9174c: d00f8f08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f91750: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
100f91754: f9403fe1    	ldr	x1, [sp, #0x78]
100f91758: 95b25679    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f9175c: aa1d03fd    	mov	x29, x29
100f91760: 95b2567a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f91764: aa0003fb    	mov	x27, x0
100f91768: f00f8f08    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f9176c: f9401500    	ldr	x0, [x8, #0x28] ; CContactMgr
100f91770: f94043e1    	ldr	x1, [sp, #0x80]
100f91774: 95b25672    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91778: aa0003e2    	mov	x2, x0
100f9177c: aa1b03e0    	mov	x0, x27
100f91780: f94047e1    	ldr	x1, [sp, #0x88]
100f91784: 95b2566e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91788: aa1d03fd    	mov	x29, x29
100f9178c: 95b2566f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f91790: aa0003f5    	mov	x21, x0
100f91794: f94037e1    	ldr	x1, [sp, #0x68]
100f91798: aa1403e2    	mov	x2, x20
100f9179c: 95b25668    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f917a0: aa1d03fd    	mov	x29, x29
100f917a4: 95b25669    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f917a8: aa0003f8    	mov	x24, x0
100f917ac: aa1503e0    	mov	x0, x21
100f917b0: 95b25669    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f917b4: aa1b03e0    	mov	x0, x27
100f917b8: 95b25667    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f917bc: b40009d8    	cbz	x24, 0x100f918f4 <__text+0xf898f4>
100f917c0: aa1803e0    	mov	x0, x24
100f917c4: f94033e1    	ldr	x1, [sp, #0x60]
100f917c8: 95b2565d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f917cc: 340000a0    	cbz	w0, 0x100f917e0 <__text+0xf897e0>
100f917d0: f9402fe8    	ldr	x8, [sp, #0x58]
100f917d4: 7100051f    	cmp	w8, #0x1
100f917d8: 540008e1    	b.ne	0x100f918f4 <__text+0xf898f4>
100f917dc: 140000ba    	b	0x100f91ac4 <__text+0xf89ac4>
100f917e0: aa1703e0    	mov	x0, x23
100f917e4: f94023e1    	ldr	x1, [sp, #0x40]
100f917e8: 95b25655    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f917ec: b4000680    	cbz	x0, 0x100f918bc <__text+0xf898bc>
100f917f0: d00f8f08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f917f4: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
100f917f8: f9403fe1    	ldr	x1, [sp, #0x78]
100f917fc: 95b25650    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91800: aa1d03fd    	mov	x29, x29
100f91804: 95b25651    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f91808: aa0003f4    	mov	x20, x0
100f9180c: d00f8f08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f91810: f9462900    	ldr	x0, [x8, #0xc50] ; MMLanguageMgr
100f91814: f94043e1    	ldr	x1, [sp, #0x80]
100f91818: 95b25649    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f9181c: aa0003e2    	mov	x2, x0
100f91820: aa1403e0    	mov	x0, x20
100f91824: f94047e1    	ldr	x1, [sp, #0x88]
100f91828: 95b25645    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f9182c: aa1d03fd    	mov	x29, x29
100f91830: 95b25646    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f91834: aa0003f5    	mov	x21, x0
100f91838: f9401fe1    	ldr	x1, [sp, #0x38]
100f9183c: d00ead82    	adrp	x2, 0x11e543000 <dyld_stub_binder+0x11e543000>
100f91840: 910ba042    	add	x2, x2, #0x2e8 ; CFString 'CreateChatRoom_MsgSeperate'
100f91844: 95b2563e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91848: aa1d03fd    	mov	x29, x29
100f9184c: 95b2563f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f91850: aa0003fb    	mov	x27, x0
100f91854: aa1803e0    	mov	x0, x24
100f91858: f9402be1    	ldr	x1, [sp, #0x50]
100f9185c: 95b25638    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91860: aa1d03fd    	mov	x29, x29
100f91864: 95b25639    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f91868: aa1603f3    	mov	x19, x22
100f9186c: aa1903f6    	mov	x22, x25
100f91870: aa1a03f9    	mov	x25, x26
100f91874: aa0003fa    	mov	x26, x0
100f91878: a90003fb    	stp	x27, x0, [sp]
100f9187c: aa1703e0    	mov	x0, x23
100f91880: f94027e1    	ldr	x1, [sp, #0x48]
100f91884: d00ea842    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
100f91888: 9134a042    	add	x2, x2, #0xd28 ; CFString '%@%@'
100f9188c: 95b2562c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91890: aa1a03e0    	mov	x0, x26
100f91894: aa1903fa    	mov	x26, x25
100f91898: aa1603f9    	mov	x25, x22
100f9189c: aa1303f6    	mov	x22, x19
100f918a0: f9401bf3    	ldr	x19, [sp, #0x30]
100f918a4: 95b2562c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f918a8: aa1b03e0    	mov	x0, x27
100f918ac: 95b2562a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f918b0: aa1503e0    	mov	x0, x21
100f918b4: 95b25628    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f918b8: 1400000d    	b	0x100f918ec <__text+0xf898ec>
100f918bc: aa1803e0    	mov	x0, x24
100f918c0: f9402be1    	ldr	x1, [sp, #0x50]
100f918c4: 95b2561e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f918c8: aa1d03fd    	mov	x29, x29
100f918cc: 95b2561f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f918d0: aa0003f4    	mov	x20, x0
100f918d4: f90003e0    	str	x0, [sp]
100f918d8: aa1703e0    	mov	x0, x23
100f918dc: f94027e1    	ldr	x1, [sp, #0x48]
100f918e0: f00ea842    	adrp	x2, 0x11e49c000 <dyld_stub_binder+0x11e49c000>
100f918e4: 9122a042    	add	x2, x2, #0x8a8 ; CFString '%@'
100f918e8: 95b25615    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f918ec: aa1403e0    	mov	x0, x20
100f918f0: 95b25619    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f918f4: aa1803e0    	mov	x0, x24
100f918f8: 95b25617    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f918fc: 9100079c    	add	x28, x28, #0x1
100f91900: eb1c033f    	cmp	x25, x28
100f91904: 54ffefc1    	b.ne	0x100f916fc <__text+0xf896fc>
100f91908: 910243e2    	add	x2, sp, #0x90
100f9190c: 910343e3    	add	x3, sp, #0xd0
100f91910: aa1a03e0    	mov	x0, x26
100f91914: f9400fe1    	ldr	x1, [sp, #0x18]
100f91918: 52800204    	mov	w4, #0x10               ; =16
100f9191c: 95b25608    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91920: aa0003f9    	mov	x25, x0
100f91924: b00f7709    	adrp	x9, 0x11fe72000 <dyld_stub_binder+0x11fe72000>
100f91928: f00f8b6a    	adrp	x10, 0x120100000 <dyld_stub_binder+0x120100000>
100f9192c: d00f8b6b    	adrp	x11, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f91930: 900f754d    	adrp	x13, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f91934: f00f7548    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100f91938: d00f754e    	adrp	x14, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100f9193c: 900f754f    	adrp	x15, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f91940: f00f7550    	adrp	x16, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100f91944: d00f8b71    	adrp	x17, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f91948: b5ffeba0    	cbnz	x0, 0x100f916bc <__text+0xf896bc>
100f9194c: a94267f3    	ldp	x19, x25, [sp, #0x20]
100f91950: 14000041    	b	0x100f91a54 <__text+0xf89a54>
100f91954: aa1303e0    	mov	x0, x19
100f91958: aa1403e1    	mov	x1, x20
100f9195c: 95b255f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91960: aa1d03fd    	mov	x29, x29
100f91964: 95b255f9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f91968: aa0003f4    	mov	x20, x0
100f9196c: 14000043    	b	0x100f91a78 <__text+0xf89a78>
100f91970: d00f8f08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f91974: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
100f91978: f00f8b68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100f9197c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100f91980: 95b255ef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91984: aa1d03fd    	mov	x29, x29
100f91988: 95b255f0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f9198c: aa0003f5    	mov	x21, x0
100f91990: d00f8f08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f91994: f9462900    	ldr	x0, [x8, #0xc50] ; MMLanguageMgr
100f91998: d00f8b68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f9199c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100f919a0: 95b255e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f919a4: aa0003e2    	mov	x2, x0
100f919a8: 900f7548    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f919ac: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100f919b0: aa1503e0    	mov	x0, x21
100f919b4: 95b255e2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f919b8: aa1d03fd    	mov	x29, x29
100f919bc: 95b255e3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f919c0: aa0003f6    	mov	x22, x0
100f919c4: 900f7548    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f919c8: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
100f919cc: d00ead82    	adrp	x2, 0x11e543000 <dyld_stub_binder+0x11e543000>
100f919d0: 910b2042    	add	x2, x2, #0x2c8 ; CFString 'CreateChatRoom_DefaultTopic'
100f919d4: 95b255da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f919d8: aa1d03fd    	mov	x29, x29
100f919dc: 95b255db    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f919e0: aa0003f4    	mov	x20, x0
100f919e4: aa1603e0    	mov	x0, x22
100f919e8: 95b255db    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f919ec: aa1503e0    	mov	x0, x21
100f919f0: 1400001f    	b	0x100f91a6c <__text+0xf89a6c>
100f919f4: b00f77a8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
100f919f8: f9408d01    	ldr	x1, [x8, #0x118] ; prefixWithLength:
100f919fc: aa1703e0    	mov	x0, x23
100f91a00: aa1603e2    	mov	x2, x22
100f91a04: 95b255ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91a08: aa1d03fd    	mov	x29, x29
100f91a0c: 95b255cf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f91a10: aa0003f4    	mov	x20, x0
100f91a14: f00f8b88    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100f91a18: f9450901    	ldr	x1, [x8, #0xa10] ; mutableCopy
100f91a1c: 95b255c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91a20: aa0003f5    	mov	x21, x0
100f91a24: aa1703e0    	mov	x0, x23
100f91a28: 95b255cb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f91a2c: aa1403e0    	mov	x0, x20
100f91a30: 95b255c9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f91a34: aa1503f7    	mov	x23, x21
100f91a38: a94267f3    	ldp	x19, x25, [sp, #0x20]
100f91a3c: b40000d9    	cbz	x25, 0x100f91a54 <__text+0xf89a54>
100f91a40: d00f8b68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f91a44: f9416901    	ldr	x1, [x8, #0x2d0] ; appendString:
100f91a48: aa1703e0    	mov	x0, x23
100f91a4c: aa1903e2    	mov	x2, x25
100f91a50: 95b255bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91a54: aa1a03e0    	mov	x0, x26
100f91a58: 95b255bf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f91a5c: aa1703e0    	mov	x0, x23
100f91a60: 95b255b6    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100f91a64: aa1703f4    	mov	x20, x23
100f91a68: aa1703e0    	mov	x0, x23
100f91a6c: 95b255ba    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f91a70: aa1a03e0    	mov	x0, x26
100f91a74: 95b255b8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f91a78: aa1903e0    	mov	x0, x25
100f91a7c: 95b255b6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f91a80: aa1303e0    	mov	x0, x19
100f91a84: 95b255b4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f91a88: f85a03a8    	ldur	x8, [x29, #-0x60]
100f91a8c: d00e32e9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
100f91a90: f9405929    	ldr	x9, [x9, #0xb0]
100f91a94: f9400129    	ldr	x9, [x9]
100f91a98: eb08013f    	cmp	x9, x8
100f91a9c: 540005a1    	b.ne	0x100f91b50 <__text+0xf89b50>
100f91aa0: aa1403e0    	mov	x0, x20
100f91aa4: a95b7bfd    	ldp	x29, x30, [sp, #0x1b0]
100f91aa8: a95a4ff4    	ldp	x20, x19, [sp, #0x1a0]
100f91aac: a95957f6    	ldp	x22, x21, [sp, #0x190]
100f91ab0: a9585ff8    	ldp	x24, x23, [sp, #0x180]
100f91ab4: a95767fa    	ldp	x26, x25, [sp, #0x170]
100f91ab8: a9566ffc    	ldp	x28, x27, [sp, #0x160]
100f91abc: 910703ff    	add	sp, sp, #0x1c0
100f91ac0: 15b255ac    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
100f91ac4: d00f8f08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f91ac8: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
100f91acc: f9403fe1    	ldr	x1, [sp, #0x78]
100f91ad0: 95b2559b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91ad4: aa1d03fd    	mov	x29, x29
100f91ad8: 95b2559c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f91adc: aa0003f5    	mov	x21, x0
100f91ae0: d00f8f08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f91ae4: f9462900    	ldr	x0, [x8, #0xc50] ; MMLanguageMgr
100f91ae8: f94043e1    	ldr	x1, [sp, #0x80]
100f91aec: 95b25594    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91af0: aa0003e2    	mov	x2, x0
100f91af4: aa1503e0    	mov	x0, x21
100f91af8: f94047e1    	ldr	x1, [sp, #0x88]
100f91afc: 95b25590    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91b00: aa1d03fd    	mov	x29, x29
100f91b04: 95b25591    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f91b08: aa0003f6    	mov	x22, x0
100f91b0c: d00ead82    	adrp	x2, 0x11e543000 <dyld_stub_binder+0x11e543000>
100f91b10: 910b2042    	add	x2, x2, #0x2c8 ; CFString 'CreateChatRoom_DefaultTopic'
100f91b14: f9401fe1    	ldr	x1, [sp, #0x38]
100f91b18: 95b25589    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f91b1c: aa1d03fd    	mov	x29, x29
100f91b20: 95b2558a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f91b24: aa0003f4    	mov	x20, x0
100f91b28: aa1603e0    	mov	x0, x22
100f91b2c: 95b2558a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f91b30: aa1503e0    	mov	x0, x21
100f91b34: 95b25588    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f91b38: aa1803e0    	mov	x0, x24
100f91b3c: 95b25586    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f91b40: aa1a03e0    	mov	x0, x26
100f91b44: 95b25584    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f91b48: a94267f3    	ldp	x19, x25, [sp, #0x20]
100f91b4c: 17ffffc7    	b	0x100f91a68 <__text+0xf89a68>
100f91b50: 95b25589    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
