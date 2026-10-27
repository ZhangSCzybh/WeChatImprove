
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a96590: d10483ff    	sub	sp, sp, #0x120
104a96594: 6d0933ed    	stp	d13, d12, [sp, #0x90]
104a96598: 6d0a2beb    	stp	d11, d10, [sp, #0xa0]
104a9659c: 6d0b23e9    	stp	d9, d8, [sp, #0xb0]
104a965a0: a90c6ffc    	stp	x28, x27, [sp, #0xc0]
104a965a4: a90d67fa    	stp	x26, x25, [sp, #0xd0]
104a965a8: a90e5ff8    	stp	x24, x23, [sp, #0xe0]
104a965ac: a90f57f6    	stp	x22, x21, [sp, #0xf0]
104a965b0: a9104ff4    	stp	x20, x19, [sp, #0x100]
104a965b4: a9117bfd    	stp	x29, x30, [sp, #0x110]
104a965b8: 910443fd    	add	x29, sp, #0x110
104a965bc: aa0003f5    	mov	x21, x0
104a965c0: 900e0d48    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a965c4: 52800029    	mov	w9, #0x1                ; =1
104a965c8: 390ca909    	strb	w9, [x8, #0x32a]
104a965cc: b00dbc68    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a965d0: b9829113    	ldrsw	x19, [x8, #0x290]
104a965d4: f8736800    	ldr	x0, [x0, x19]
104a965d8: 900d9d88    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
104a965dc: f9438d01    	ldr	x1, [x8, #0x718] ; m_sessionInfo
104a965e0: 94c642d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a965e4: aa1d03fd    	mov	x29, x29
104a965e8: 94c642d8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a965ec: aa0003fb    	mov	x27, x0
104a965f0: f8736aa0    	ldr	x0, [x21, x19]
104a965f4: b00d9f68    	adrp	x8, 0x11fe83000 <dyld_stub_binder+0x11fe83000>
104a965f8: f9403901    	ldr	x1, [x8, #0x70] ; m_textForMessageLabel
104a965fc: 94c642d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96600: aa1d03fd    	mov	x29, x29
104a96604: 94c642d1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96608: aa0003fc    	mov	x28, x0
104a9660c: f00d9d68    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
104a96610: f9413517    	ldr	x23, [x8, #0x268] ; m_bShowUnReadAsRedDot
104a96614: aa1b03e0    	mov	x0, x27
104a96618: aa1703e1    	mov	x1, x23
104a9661c: 94c642c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96620: 34000be0    	cbz	w0, 0x104a9679c <_Flutter_MMFoundation_BindContext+0xf72380>
104a96624: f00d9d28    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104a96628: f942e501    	ldr	x1, [x8, #0x5c8] ; m_uUnReadCount
104a9662c: aa1b03e0    	mov	x0, x27
104a96630: 94c642c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96634: 710fa01f    	cmp	w0, #0x3e8
104a96638: 540004ab    	b.lt	0x104a966cc <_Flutter_MMFoundation_BindContext+0xf722b0>
104a9663c: b00db6e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a96640: f9454518    	ldr	x24, [x8, #0xa88]
104a96644: b00db6e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a96648: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
104a9664c: d00db348    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a96650: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104a96654: 94c642ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96658: aa1d03fd    	mov	x29, x29
104a9665c: 94c642bb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96660: aa0003f4    	mov	x20, x0
104a96664: b00db6e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a96668: f9462900    	ldr	x0, [x8, #0xc50] ; MMLanguageMgr
104a9666c: b00db348    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a96670: f947ad01    	ldr	x1, [x8, #0xf58] ; class
104a96674: 94c642b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96678: aa0003e2    	mov	x2, x0
104a9667c: f00d9d08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a96680: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104a96684: aa1403e0    	mov	x0, x20
104a96688: 94c642ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9668c: aa1d03fd    	mov	x29, x29
104a96690: 94c642ae    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96694: aa0003f6    	mov	x22, x0
104a96698: f00d9d08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a9669c: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
104a966a0: f00ce822    	adrp	x2, 0x11e79d000 <dyld_stub_binder+0x11e79d000>
104a966a4: 9138a042    	add	x2, x2, #0xe28 ; CFString 'MessageContent_Unread_MsgsMax'
104a966a8: 94c642a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a966ac: aa1d03fd    	mov	x29, x29
104a966b0: 94c642a6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a966b4: aa0003f9    	mov	x25, x0
104a966b8: 900db3a8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104a966bc: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
104a966c0: f90003fc    	str	x28, [sp]
104a966c4: aa1803e0    	mov	x0, x24
104a966c8: 14000027    	b	0x104a96764 <_Flutter_MMFoundation_BindContext+0xf72348>
104a966cc: aa0003f8    	mov	x24, x0
104a966d0: 7100081f    	cmp	w0, #0x2
104a966d4: 5400064b    	b.lt	0x104a9679c <_Flutter_MMFoundation_BindContext+0xf72380>
104a966d8: b00db6e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a966dc: f945451a    	ldr	x26, [x8, #0xa88]
104a966e0: b00db6e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a966e4: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
104a966e8: d00db348    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a966ec: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104a966f0: 94c64293    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a966f4: aa1d03fd    	mov	x29, x29
104a966f8: 94c64294    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a966fc: aa0003f4    	mov	x20, x0
104a96700: b00db6e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a96704: f9462900    	ldr	x0, [x8, #0xc50] ; MMLanguageMgr
104a96708: b00db348    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a9670c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
104a96710: 94c6428b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96714: aa0003e2    	mov	x2, x0
104a96718: f00d9d08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a9671c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104a96720: aa1403e0    	mov	x0, x20
104a96724: 94c64286    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96728: aa1d03fd    	mov	x29, x29
104a9672c: 94c64287    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96730: aa0003f6    	mov	x22, x0
104a96734: f00d9d08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a96738: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
104a9673c: b00cde42    	adrp	x2, 0x11e65f000 <dyld_stub_binder+0x11e65f000>
104a96740: 910ba042    	add	x2, x2, #0x2e8 ; CFString 'MessageContent_Unread_Msgs'
104a96744: 94c6427e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96748: aa1d03fd    	mov	x29, x29
104a9674c: 94c6427f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96750: aa0003f9    	mov	x25, x0
104a96754: 900db3a8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104a96758: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
104a9675c: a90073f8    	stp	x24, x28, [sp]
104a96760: aa1a03e0    	mov	x0, x26
104a96764: aa1903e2    	mov	x2, x25
104a96768: 94c64275    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9676c: aa1d03fd    	mov	x29, x29
104a96770: 94c64276    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96774: aa0003f8    	mov	x24, x0
104a96778: aa1c03e0    	mov	x0, x28
104a9677c: 94c64276    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96780: aa1903e0    	mov	x0, x25
104a96784: 94c64274    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96788: aa1603e0    	mov	x0, x22
104a9678c: 94c64272    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96790: aa1403e0    	mov	x0, x20
104a96794: 94c64270    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96798: aa1803fc    	mov	x28, x24
104a9679c: f00d9d68    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
104a967a0: f944c501    	ldr	x1, [x8, #0x988] ; m_msgWrap
104a967a4: aa1b03e0    	mov	x0, x27
104a967a8: 94c64265    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a967ac: aa1d03fd    	mov	x29, x29
104a967b0: 94c64266    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a967b4: aa0003f4    	mov	x20, x0
104a967b8: 900d9d48    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104a967bc: f9413d01    	ldr	x1, [x8, #0x278] ; m_uiMessageType
104a967c0: 94c6425f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a967c4: aa0003f6    	mov	x22, x0
104a967c8: aa1403e0    	mov	x0, x20
104a967cc: 94c64262    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a967d0: 71008adf    	cmp	w22, #0x22
104a967d4: 540015c1    	b.ne	0x104a96a8c <_Flutter_MMFoundation_BindContext+0xf72670>
104a967d8: b00dbc68    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a967dc: b982a516    	ldrsw	x22, [x8, #0x2a4]
104a967e0: f8766aa0    	ldr	x0, [x21, x22]
104a967e4: f00db388    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104a967e8: f9468d1a    	ldr	x26, [x8, #0xd18] ; setText:
104a967ec: aa1a03e1    	mov	x1, x26
104a967f0: aa1c03e2    	mov	x2, x28
104a967f4: 94c64252    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a967f8: f8736aa0    	ldr	x0, [x21, x19]
104a967fc: d00da768    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a96800: f941c118    	ldr	x24, [x8, #0x380] ; m_textForGreenLabel
104a96804: aa1803e1    	mov	x1, x24
104a96808: 94c6424d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9680c: aa1d03fd    	mov	x29, x29
104a96810: 94c6424e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96814: aa0003f4    	mov	x20, x0
104a96818: b00db368    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104a9681c: f946e901    	ldr	x1, [x8, #0xdd0] ; length
104a96820: 94c64247    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96824: aa0003f9    	mov	x25, x0
104a96828: aa1403e0    	mov	x0, x20
104a9682c: 94c6424a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96830: b4003ad9    	cbz	x25, 0x104a96f88 <_Flutter_MMFoundation_BindContext+0xf72b6c>
104a96834: f9003bfa    	str	x26, [sp, #0x70]
104a96838: f8736aa0    	ldr	x0, [x21, x19]
104a9683c: d00da768    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a96840: f9446d01    	ldr	x1, [x8, #0x8d8] ; m_widthForMessageLabelText
104a96844: 94c6423e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96848: 1e204008    	fmov	s8, s0
104a9684c: aa1b03e0    	mov	x0, x27
104a96850: aa1703e1    	mov	x1, x23
104a96854: 94c6423a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96858: 36003300    	tbz	w0, #0x0, 0x104a96eb8 <_Flutter_MMFoundation_BindContext+0xf72a9c>
104a9685c: d00db6e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a96860: f9404908    	ldr	x8, [x8, #0x90] ; CControlUtil
104a96864: f90037e8    	str	x8, [sp, #0x68]
104a96868: b00db3a8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104a9686c: f947a501    	ldr	x1, [x8, #0xf48] ; width
104a96870: aa1503e0    	mov	x0, x21
104a96874: 94c64232    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96878: 1e604008    	fmov	d8, d0
104a9687c: b00db6e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a96880: f9461908    	ldr	x8, [x8, #0xc30]
104a96884: f90027e8    	str	x8, [sp, #0x48]
104a96888: f90043fc    	str	x28, [sp, #0x80]
104a9688c: d00db6e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a96890: f9403d14    	ldr	x20, [x8, #0x78] ; MMThemeUtil
104a96894: b00db6e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a96898: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
104a9689c: d00db348    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a968a0: f944e917    	ldr	x23, [x8, #0x9d0] ; currentContext
104a968a4: aa1703e1    	mov	x1, x23
104a968a8: 94c64225    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a968ac: aa1d03fd    	mov	x29, x29
104a968b0: 94c64226    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a968b4: aa0003fc    	mov	x28, x0
104a968b8: f90033e0    	str	x0, [sp, #0x60]
104a968bc: d00db6e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a968c0: f9404100    	ldr	x0, [x8, #0x80] ; MMThemeManager
104a968c4: b00db348    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a968c8: f947ad1a    	ldr	x26, [x8, #0xf58] ; class
104a968cc: aa1a03e1    	mov	x1, x26
104a968d0: 94c6421b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a968d4: aa0003e2    	mov	x2, x0
104a968d8: f00d9d08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a968dc: f9464119    	ldr	x25, [x8, #0xc80] ; getService:
104a968e0: aa1c03e0    	mov	x0, x28
104a968e4: aa1903e1    	mov	x1, x25
104a968e8: 94c64215    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a968ec: aa1d03fd    	mov	x29, x29
104a968f0: 94c64216    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a968f4: f9002fe0    	str	x0, [sp, #0x58]
104a968f8: b00d9d28    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104a968fc: f9003ffb    	str	x27, [sp, #0x78]
104a96900: f947fd1b    	ldr	x27, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
104a96904: d00cd742    	adrp	x2, 0x11e580000 <dyld_stub_binder+0x11e580000>
104a96908: 91222042    	add	x2, x2, #0x888 ; CFString 'cell_headimg_left_margin'
104a9690c: f00cd103    	adrp	x3, 0x11e4b9000 <dyld_stub_binder+0x11e4b9000>
104a96910: 9137a063    	add	x3, x3, #0xde8 ; CFString '#mainframe_table'
104a96914: aa1b03e1    	mov	x1, x27
104a96918: 94c64209    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9691c: aa1d03fd    	mov	x29, x29
104a96920: 94c6420a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96924: aa0003e2    	mov	x2, x0
104a96928: f9002be0    	str	x0, [sp, #0x50]
104a9692c: d00d9d28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a96930: f9400101    	ldr	x1, [x8]
104a96934: aa1403e0    	mov	x0, x20
104a96938: 94c64201    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9693c: 1e651001    	fmov	d1, #12.00000000
104a96940: 1e612809    	fadd	d9, d0, d1
104a96944: d00db6e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a96948: f9403d1c    	ldr	x28, [x8, #0x78] ; MMThemeUtil
104a9694c: b00db6e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a96950: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
104a96954: aa1703e1    	mov	x1, x23
104a96958: 94c641f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9695c: aa1d03fd    	mov	x29, x29
104a96960: 94c641fa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96964: aa0003f4    	mov	x20, x0
104a96968: f90023e0    	str	x0, [sp, #0x40]
104a9696c: d00db6e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a96970: f9404100    	ldr	x0, [x8, #0x80] ; MMThemeManager
104a96974: aa1a03e1    	mov	x1, x26
104a96978: 94c641f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9697c: aa0003e2    	mov	x2, x0
104a96980: aa1403e0    	mov	x0, x20
104a96984: aa1903e1    	mov	x1, x25
104a96988: 94c641ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9698c: aa1d03fd    	mov	x29, x29
104a96990: 94c641ee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96994: aa0003f4    	mov	x20, x0
104a96998: d00cd742    	adrp	x2, 0x11e580000 <dyld_stub_binder+0x11e580000>
104a9699c: 91242042    	add	x2, x2, #0x908 ; CFString 'cell_headimg_size'
104a969a0: aa1b03e1    	mov	x1, x27
104a969a4: f9403ffb    	ldr	x27, [sp, #0x78]
104a969a8: f00cd103    	adrp	x3, 0x11e4b9000 <dyld_stub_binder+0x11e4b9000>
104a969ac: 9137a063    	add	x3, x3, #0xde8 ; CFString '#mainframe_table'
104a969b0: 94c641e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a969b4: aa1d03fd    	mov	x29, x29
104a969b8: 94c641e4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a969bc: aa0003f7    	mov	x23, x0
104a969c0: d00d9f88    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
104a969c4: f941e101    	ldr	x1, [x8, #0x3c0] ; parseSizeFromValues:
104a969c8: aa1c03e0    	mov	x0, x28
104a969cc: f94043fc    	ldr	x28, [sp, #0x80]
104a969d0: aa1703e2    	mov	x2, x23
104a969d4: 94c641da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a969d8: 1e602920    	fadd	d0, d9, d0
104a969dc: 1e669001    	fmov	d1, #20.00000000
104a969e0: 1e612800    	fadd	d0, d0, d1
104a969e4: f00d9d08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a969e8: f9463101    	ldr	x1, [x8, #0xc60] ; dynamicLength:
104a969ec: f94027e0    	ldr	x0, [sp, #0x48]
104a969f0: 94c641d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a969f4: 1e603908    	fsub	d8, d8, d0
104a969f8: f8736aa0    	ldr	x0, [x21, x19]
104a969fc: d00da768    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a96a00: f941c51a    	ldr	x26, [x8, #0x388] ; m_widthForGreenLabelText
104a96a04: aa1a03e1    	mov	x1, x26
104a96a08: 94c641cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96a0c: 1e22c000    	fcvt	d0, s0
104a96a10: 1e603908    	fsub	d8, d8, d0
104a96a14: f8766aa0    	ldr	x0, [x21, x22]
104a96a18: f00db348    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
104a96a1c: f9456d01    	ldr	x1, [x8, #0xad8] ; font
104a96a20: 94c641c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96a24: aa1d03fd    	mov	x29, x29
104a96a28: 94c641c8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96a2c: aa0003f9    	mov	x25, x0
104a96a30: b00d9d48    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104a96a34: f941d501    	ldr	x1, [x8, #0x3a8] ; labelWidth:maxWidth:font:
104a96a38: f94037e0    	ldr	x0, [sp, #0x68]
104a96a3c: aa1c03e2    	mov	x2, x28
104a96a40: 1e604100    	fmov	d0, d8
104a96a44: aa1903e3    	mov	x3, x25
104a96a48: 94c641bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96a4c: 1e604008    	fmov	d8, d0
104a96a50: aa1903e0    	mov	x0, x25
104a96a54: 94c641c0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96a58: aa1703e0    	mov	x0, x23
104a96a5c: 94c641be    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96a60: aa1403e0    	mov	x0, x20
104a96a64: 94c641bc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96a68: f94023e0    	ldr	x0, [sp, #0x40]
104a96a6c: 94c641ba    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96a70: f9402be0    	ldr	x0, [sp, #0x50]
104a96a74: 94c641b8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96a78: f9402fe0    	ldr	x0, [sp, #0x58]
104a96a7c: 94c641b6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96a80: f94033e0    	ldr	x0, [sp, #0x60]
104a96a84: 94c641b4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96a88: 1400010f    	b	0x104a96ec4 <_Flutter_MMFoundation_BindContext+0xf72aa8>
104a96a8c: d00da768    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a96a90: f9443d01    	ldr	x1, [x8, #0x878] ; attrDigestForSessionInfo:
104a96a94: aa1503e0    	mov	x0, x21
104a96a98: aa1b03e2    	mov	x2, x27
104a96a9c: 94c641a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96aa0: aa1d03fd    	mov	x29, x29
104a96aa4: 94c641a9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96aa8: aa0003f3    	mov	x19, x0
104a96aac: b00dbc68    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a96ab0: b982a514    	ldrsw	x20, [x8, #0x2a4]
104a96ab4: f8746aa0    	ldr	x0, [x21, x20]
104a96ab8: f90043fc    	str	x28, [sp, #0x80]
104a96abc: b40000b3    	cbz	x19, 0x104a96ad0 <_Flutter_MMFoundation_BindContext+0xf726b4>
104a96ac0: b00db388    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
104a96ac4: f9404d01    	ldr	x1, [x8, #0x98] ; setAttributedText:
104a96ac8: aa1303e2    	mov	x2, x19
104a96acc: 14000004    	b	0x104a96adc <_Flutter_MMFoundation_BindContext+0xf726c0>
104a96ad0: f00db388    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104a96ad4: f9468d01    	ldr	x1, [x8, #0xd18] ; setText:
104a96ad8: aa1c03e2    	mov	x2, x28
104a96adc: 94c64198    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96ae0: b00dbc68    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a96ae4: b982a108    	ldrsw	x8, [x8, #0x2a0]
104a96ae8: f8686aa0    	ldr	x0, [x21, x8]
104a96aec: 900db368    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104a96af0: f9453d01    	ldr	x1, [x8, #0xa78] ; image
104a96af4: 94c64192    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96af8: aa1d03fd    	mov	x29, x29
104a96afc: 94c64193    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96b00: b4001d40    	cbz	x0, 0x104a96ea8 <_Flutter_MMFoundation_BindContext+0xf72a8c>
104a96b04: f90037e0    	str	x0, [sp, #0x68]
104a96b08: f8746aa0    	ldr	x0, [x21, x20]
104a96b0c: b00db3a8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104a96b10: f947a516    	ldr	x22, [x8, #0xf48] ; width
104a96b14: aa1603e1    	mov	x1, x22
104a96b18: 94c64189    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96b1c: 1e604008    	fmov	d8, d0
104a96b20: aa1503e0    	mov	x0, x21
104a96b24: f90013f6    	str	x22, [sp, #0x20]
104a96b28: aa1603e1    	mov	x1, x22
104a96b2c: 94c64184    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96b30: 1e604009    	fmov	d9, d0
104a96b34: b00db6e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a96b38: f9461908    	ldr	x8, [x8, #0xc30]
104a96b3c: f9002fe8    	str	x8, [sp, #0x58]
104a96b40: d00db6e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a96b44: f9003bf3    	str	x19, [sp, #0x70]
104a96b48: f9403d13    	ldr	x19, [x8, #0x78] ; MMThemeUtil
104a96b4c: b00db6f8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
104a96b50: f945eb00    	ldr	x0, [x24, #0xbd0] ; MMContext
104a96b54: d00db348    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a96b58: f944e919    	ldr	x25, [x8, #0x9d0] ; currentContext
104a96b5c: aa1903e1    	mov	x1, x25
104a96b60: 94c64177    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96b64: aa1d03fd    	mov	x29, x29
104a96b68: 94c64178    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96b6c: f90027f4    	str	x20, [sp, #0x48]
104a96b70: aa0003f7    	mov	x23, x0
104a96b74: f90033e0    	str	x0, [sp, #0x60]
104a96b78: d00db6fc    	adrp	x28, 0x120174000 <dyld_stub_binder+0x120174000>
104a96b7c: f9404380    	ldr	x0, [x28, #0x80] ; MMThemeManager
104a96b80: b00db348    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a96b84: f947ad14    	ldr	x20, [x8, #0xf58] ; class
104a96b88: aa1403e1    	mov	x1, x20
104a96b8c: 94c6416c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96b90: aa0003e2    	mov	x2, x0
104a96b94: f00d9d08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a96b98: f9464116    	ldr	x22, [x8, #0xc80] ; getService:
104a96b9c: aa1703e0    	mov	x0, x23
104a96ba0: aa1603e1    	mov	x1, x22
104a96ba4: 94c64166    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96ba8: aa1d03fd    	mov	x29, x29
104a96bac: 94c64167    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96bb0: f9002be0    	str	x0, [sp, #0x50]
104a96bb4: b00d9d28    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104a96bb8: f947fd1a    	ldr	x26, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
104a96bbc: d00cd742    	adrp	x2, 0x11e580000 <dyld_stub_binder+0x11e580000>
104a96bc0: 91222042    	add	x2, x2, #0x888 ; CFString 'cell_headimg_left_margin'
104a96bc4: f9003ffb    	str	x27, [sp, #0x78]
104a96bc8: f00cd11b    	adrp	x27, 0x11e4b9000 <dyld_stub_binder+0x11e4b9000>
104a96bcc: 9137a37b    	add	x27, x27, #0xde8 ; CFString '#mainframe_table'
104a96bd0: aa1a03e1    	mov	x1, x26
104a96bd4: aa1b03e3    	mov	x3, x27
104a96bd8: 94c64159    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96bdc: aa1d03fd    	mov	x29, x29
104a96be0: 94c6415a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96be4: aa0003f7    	mov	x23, x0
104a96be8: d00d9d28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a96bec: f9400101    	ldr	x1, [x8]
104a96bf0: aa1303e0    	mov	x0, x19
104a96bf4: f9000fe1    	str	x1, [sp, #0x18]
104a96bf8: aa1703e2    	mov	x2, x23
104a96bfc: 94c64150    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96c00: 1e65100a    	fmov	d10, #12.00000000
104a96c04: 1e6a280b    	fadd	d11, d0, d10
104a96c08: d00db6e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a96c0c: f9403d13    	ldr	x19, [x8, #0x78] ; MMThemeUtil
104a96c10: f945eb00    	ldr	x0, [x24, #0xbd0] ; MMContext
104a96c14: f90023f9    	str	x25, [sp, #0x40]
104a96c18: aa1903e1    	mov	x1, x25
104a96c1c: 94c64148    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96c20: aa1d03fd    	mov	x29, x29
104a96c24: 94c64149    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96c28: aa0003f8    	mov	x24, x0
104a96c2c: f9404380    	ldr	x0, [x28, #0x80] ; MMThemeManager
104a96c30: f9001bf4    	str	x20, [sp, #0x30]
104a96c34: aa1403e1    	mov	x1, x20
104a96c38: 94c64141    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96c3c: aa0003e2    	mov	x2, x0
104a96c40: aa1803e0    	mov	x0, x24
104a96c44: f9001ff6    	str	x22, [sp, #0x38]
104a96c48: aa1603e1    	mov	x1, x22
104a96c4c: 94c6413c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96c50: aa1d03fd    	mov	x29, x29
104a96c54: 94c6413d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96c58: aa0003f9    	mov	x25, x0
104a96c5c: d00cd742    	adrp	x2, 0x11e580000 <dyld_stub_binder+0x11e580000>
104a96c60: 91242042    	add	x2, x2, #0x908 ; CFString 'cell_headimg_size'
104a96c64: f90017fa    	str	x26, [sp, #0x28]
104a96c68: aa1a03e1    	mov	x1, x26
104a96c6c: aa1b03e3    	mov	x3, x27
104a96c70: 94c64133    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96c74: aa1d03fd    	mov	x29, x29
104a96c78: 94c64134    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96c7c: aa0003fb    	mov	x27, x0
104a96c80: d00d9f88    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
104a96c84: f941e116    	ldr	x22, [x8, #0x3c0] ; parseSizeFromValues:
104a96c88: aa1303e0    	mov	x0, x19
104a96c8c: f9403bf3    	ldr	x19, [sp, #0x70]
104a96c90: aa1603e1    	mov	x1, x22
104a96c94: aa1b03e2    	mov	x2, x27
104a96c98: 94c64129    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96c9c: 1e602960    	fadd	d0, d11, d0
104a96ca0: 1e66900b    	fmov	d11, #20.00000000
104a96ca4: 1e6b2800    	fadd	d0, d0, d11
104a96ca8: f00d9d08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a96cac: f946311a    	ldr	x26, [x8, #0xc60] ; dynamicLength:
104a96cb0: f9402fe0    	ldr	x0, [sp, #0x58]
104a96cb4: aa1a03e1    	mov	x1, x26
104a96cb8: 94c64121    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96cbc: 1e603920    	fsub	d0, d9, d0
104a96cc0: 1e749009    	fmov	d9, #-10.00000000
104a96cc4: 1e69280c    	fadd	d12, d0, d9
104a96cc8: aa1b03e0    	mov	x0, x27
104a96ccc: f9403ffb    	ldr	x27, [sp, #0x78]
104a96cd0: 94c64121    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96cd4: aa1903e0    	mov	x0, x25
104a96cd8: 94c6411f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96cdc: aa1803e0    	mov	x0, x24
104a96ce0: 94c6411d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96ce4: aa1703e0    	mov	x0, x23
104a96ce8: 94c6411b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96cec: f9402be0    	ldr	x0, [sp, #0x50]
104a96cf0: 94c64119    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96cf4: f94033e0    	ldr	x0, [sp, #0x60]
104a96cf8: 94c64117    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96cfc: f94037e0    	ldr	x0, [sp, #0x68]
104a96d00: 94c64115    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96d04: 1e6c2100    	fcmp	d8, d12
104a96d08: 54000d0b    	b.lt	0x104a96ea8 <_Flutter_MMFoundation_BindContext+0xf72a8c>
104a96d0c: aa1503e0    	mov	x0, x21
104a96d10: f94013e1    	ldr	x1, [sp, #0x20]
104a96d14: 94c6410a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96d18: 1e604008    	fmov	d8, d0
104a96d1c: b00db6e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a96d20: f9461908    	ldr	x8, [x8, #0xc30]
104a96d24: f9002fe8    	str	x8, [sp, #0x58]
104a96d28: d00db6f9    	adrp	x25, 0x120174000 <dyld_stub_binder+0x120174000>
104a96d2c: f9403f33    	ldr	x19, [x25, #0x78] ; MMThemeUtil
104a96d30: b00db6f8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
104a96d34: f945eb00    	ldr	x0, [x24, #0xbd0] ; MMContext
104a96d38: f94023fc    	ldr	x28, [sp, #0x40]
104a96d3c: aa1c03e1    	mov	x1, x28
104a96d40: 94c640ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96d44: aa1d03fd    	mov	x29, x29
104a96d48: 94c64100    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96d4c: aa0003f4    	mov	x20, x0
104a96d50: f90037e0    	str	x0, [sp, #0x68]
104a96d54: d00db6e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a96d58: f9404100    	ldr	x0, [x8, #0x80] ; MMThemeManager
104a96d5c: f9401bfb    	ldr	x27, [sp, #0x30]
104a96d60: aa1b03e1    	mov	x1, x27
104a96d64: 94c640f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96d68: aa0003e2    	mov	x2, x0
104a96d6c: aa1403e0    	mov	x0, x20
104a96d70: f9002bfa    	str	x26, [sp, #0x50]
104a96d74: f9401ffa    	ldr	x26, [sp, #0x38]
104a96d78: aa1a03e1    	mov	x1, x26
104a96d7c: 94c640f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96d80: aa1d03fd    	mov	x29, x29
104a96d84: 94c640f1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96d88: f90033e0    	str	x0, [sp, #0x60]
104a96d8c: d00cd742    	adrp	x2, 0x11e580000 <dyld_stub_binder+0x11e580000>
104a96d90: 91222042    	add	x2, x2, #0x888 ; CFString 'cell_headimg_left_margin'
104a96d94: f00cd103    	adrp	x3, 0x11e4b9000 <dyld_stub_binder+0x11e4b9000>
104a96d98: 9137a063    	add	x3, x3, #0xde8 ; CFString '#mainframe_table'
104a96d9c: f94017f4    	ldr	x20, [sp, #0x28]
104a96da0: aa1403e1    	mov	x1, x20
104a96da4: 94c640e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96da8: aa1d03fd    	mov	x29, x29
104a96dac: 94c640e7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96db0: aa0003f7    	mov	x23, x0
104a96db4: aa1303e0    	mov	x0, x19
104a96db8: f9400fe1    	ldr	x1, [sp, #0x18]
104a96dbc: aa1703e2    	mov	x2, x23
104a96dc0: 94c640df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96dc4: 1e6a280a    	fadd	d10, d0, d10
104a96dc8: f9403f33    	ldr	x19, [x25, #0x78] ; MMThemeUtil
104a96dcc: f945eb00    	ldr	x0, [x24, #0xbd0] ; MMContext
104a96dd0: aa1c03e1    	mov	x1, x28
104a96dd4: 94c640da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96dd8: aa1d03fd    	mov	x29, x29
104a96ddc: 94c640db    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96de0: aa0003fc    	mov	x28, x0
104a96de4: d00db6e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a96de8: f9404100    	ldr	x0, [x8, #0x80] ; MMThemeManager
104a96dec: aa1b03e1    	mov	x1, x27
104a96df0: 94c640d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96df4: aa0003e2    	mov	x2, x0
104a96df8: aa1c03e0    	mov	x0, x28
104a96dfc: aa1a03e1    	mov	x1, x26
104a96e00: 94c640cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96e04: aa1d03fd    	mov	x29, x29
104a96e08: 94c640d0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96e0c: aa0003f9    	mov	x25, x0
104a96e10: d00cd742    	adrp	x2, 0x11e580000 <dyld_stub_binder+0x11e580000>
104a96e14: 91242042    	add	x2, x2, #0x908 ; CFString 'cell_headimg_size'
104a96e18: aa1403e1    	mov	x1, x20
104a96e1c: f00cd103    	adrp	x3, 0x11e4b9000 <dyld_stub_binder+0x11e4b9000>
104a96e20: 9137a063    	add	x3, x3, #0xde8 ; CFString '#mainframe_table'
104a96e24: 94c640c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96e28: aa1d03fd    	mov	x29, x29
104a96e2c: 94c640c7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96e30: aa0003f8    	mov	x24, x0
104a96e34: aa1303e0    	mov	x0, x19
104a96e38: f9403bf3    	ldr	x19, [sp, #0x70]
104a96e3c: aa1603e1    	mov	x1, x22
104a96e40: aa1803e2    	mov	x2, x24
104a96e44: 94c640be    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96e48: 1e602940    	fadd	d0, d10, d0
104a96e4c: 1e6b2800    	fadd	d0, d0, d11
104a96e50: a94503e1    	ldp	x1, x0, [sp, #0x50]
104a96e54: f9403ffb    	ldr	x27, [sp, #0x78]
104a96e58: 94c640b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96e5c: 1e603900    	fsub	d0, d8, d0
104a96e60: 1e692800    	fadd	d0, d0, d9
104a96e64: f94027e8    	ldr	x8, [sp, #0x48]
104a96e68: f8686aa0    	ldr	x0, [x21, x8]
104a96e6c: 900db3a8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104a96e70: f9418d01    	ldr	x1, [x8, #0x318] ; setWidth:
104a96e74: 94c640b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96e78: aa1803e0    	mov	x0, x24
104a96e7c: 94c640b6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96e80: aa1903e0    	mov	x0, x25
104a96e84: 94c640b4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96e88: aa1c03e0    	mov	x0, x28
104a96e8c: 94c640b2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96e90: aa1703e0    	mov	x0, x23
104a96e94: 94c640b0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96e98: f94033e0    	ldr	x0, [sp, #0x60]
104a96e9c: 94c640ae    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96ea0: f94037e0    	ldr	x0, [sp, #0x68]
104a96ea4: 94c640ac    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96ea8: aa1303e0    	mov	x0, x19
104a96eac: 94c640aa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96eb0: f94043fc    	ldr	x28, [sp, #0x80]
104a96eb4: 14000035    	b	0x104a96f88 <_Flutter_MMFoundation_BindContext+0xf72b6c>
104a96eb8: 1e22c108    	fcvt	d8, s8
104a96ebc: d00da768    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a96ec0: f941c51a    	ldr	x26, [x8, #0x388] ; m_widthForGreenLabelText
104a96ec4: f8736aa0    	ldr	x0, [x21, x19]
104a96ec8: aa1803e1    	mov	x1, x24
104a96ecc: 94c6409c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96ed0: aa1d03fd    	mov	x29, x29
104a96ed4: 94c6409d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a96ed8: aa0003f4    	mov	x20, x0
104a96edc: b00dbc68    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a96ee0: b982a917    	ldrsw	x23, [x8, #0x2a8]
104a96ee4: f8776aa0    	ldr	x0, [x21, x23]
104a96ee8: f9403be1    	ldr	x1, [sp, #0x70]
104a96eec: aa1403e2    	mov	x2, x20
104a96ef0: 94c64093    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96ef4: aa1403e0    	mov	x0, x20
104a96ef8: 94c64097    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96efc: f8766aa0    	ldr	x0, [x21, x22]
104a96f00: 900db3a8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104a96f04: f9418d01    	ldr	x1, [x8, #0x318] ; setWidth:
104a96f08: 1e604100    	fmov	d0, d8
104a96f0c: 94c6408c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96f10: f8766aa0    	ldr	x0, [x21, x22]
104a96f14: d00d9d28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a96f18: f9431d01    	ldr	x1, [x8, #0x638] ; right
104a96f1c: 94c64088    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96f20: 1e604008    	fmov	d8, d0
104a96f24: f8766aa0    	ldr	x0, [x21, x22]
104a96f28: f00db348    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
104a96f2c: f945a114    	ldr	x20, [x8, #0xb40] ; frame
104a96f30: aa1403e1    	mov	x1, x20
104a96f34: 94c64082    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96f38: 1e604029    	fmov	d9, d1
104a96f3c: f8736aa0    	ldr	x0, [x21, x19]
104a96f40: aa1a03e1    	mov	x1, x26
104a96f44: 94c6407e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96f48: 1e22c00a    	fcvt	d10, s0
104a96f4c: f8766aa0    	ldr	x0, [x21, x22]
104a96f50: aa1403e1    	mov	x1, x20
104a96f54: 94c6407a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96f58: f8776aa0    	ldr	x0, [x21, x23]
104a96f5c: d00db388    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104a96f60: f9403501    	ldr	x1, [x8, #0x68] ; setFrame:
104a96f64: 1e604100    	fmov	d0, d8
104a96f68: 1e604121    	fmov	d1, d9
104a96f6c: 1e604142    	fmov	d2, d10
104a96f70: 94c64073    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96f74: f8776aa0    	ldr	x0, [x21, x23]
104a96f78: d00db388    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104a96f7c: f9411101    	ldr	x1, [x8, #0x220] ; setHidden:
104a96f80: 52800002    	mov	w2, #0x0                ; =0
104a96f84: 94c6406e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a96f88: aa1c03e0    	mov	x0, x28
104a96f8c: 94c64072    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a96f90: aa1b03e0    	mov	x0, x27
104a96f94: a9517bfd    	ldp	x29, x30, [sp, #0x110]
104a96f98: a9504ff4    	ldp	x20, x19, [sp, #0x100]
104a96f9c: a94f57f6    	ldp	x22, x21, [sp, #0xf0]
104a96fa0: a94e5ff8    	ldp	x24, x23, [sp, #0xe0]
104a96fa4: a94d67fa    	ldp	x26, x25, [sp, #0xd0]
104a96fa8: a94c6ffc    	ldp	x28, x27, [sp, #0xc0]
104a96fac: 6d4b23e9    	ldp	d9, d8, [sp, #0xb0]
104a96fb0: 6d4a2beb    	ldp	d11, d10, [sp, #0xa0]
104a96fb4: 6d4933ed    	ldp	d13, d12, [sp, #0x90]
104a96fb8: 910483ff    	add	sp, sp, #0x120
104a96fbc: 14c64066    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
