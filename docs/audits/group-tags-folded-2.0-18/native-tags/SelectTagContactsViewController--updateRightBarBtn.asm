
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1057554f0: d10243ff    	sub	sp, sp, #0x90
1057554f4: a9036ffc    	stp	x28, x27, [sp, #0x30]
1057554f8: a90467fa    	stp	x26, x25, [sp, #0x40]
1057554fc: a9055ff8    	stp	x24, x23, [sp, #0x50]
105755500: a90657f6    	stp	x22, x21, [sp, #0x60]
105755504: a9074ff4    	stp	x20, x19, [sp, #0x70]
105755508: a9087bfd    	stp	x29, x30, [sp, #0x80]
10575550c: 910203fd    	add	x29, sp, #0x80
105755510: aa0003f3    	mov	x19, x0
105755514: 900da768    	adrp	x8, 0x120c41000 <dyld_stub_binder+0x120c41000>
105755518: 52800029    	mov	w9, #0x1                ; =1
10575551c: 390a4109    	strb	w9, [x8, #0x290]
105755520: d00d50e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105755524: f947d914    	ldr	x20, [x8, #0xfb0]
105755528: d00d50e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10575552c: f945e900    	ldr	x0, [x8, #0xbd0]
105755530: f00d4d48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105755534: f944e91a    	ldr	x26, [x8, #0x9d0] ; currentContext
105755538: aa1a03e1    	mov	x1, x26
10575553c: 94934700    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105755540: aa1d03fd    	mov	x29, x29
105755544: 94934701    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105755548: aa0003f6    	mov	x22, x0
10575554c: d00d50f5    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
105755550: f9462aa0    	ldr	x0, [x21, #0xc50]
105755554: d00d4d48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105755558: f947ad19    	ldr	x25, [x8, #0xf58] ; class
10575555c: aa1903e1    	mov	x1, x25
105755560: 949346f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105755564: aa0003e2    	mov	x2, x0
105755568: 900d3728    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10575556c: f9464118    	ldr	x24, [x8, #0xc80] ; getService:
105755570: aa1603e0    	mov	x0, x22
105755574: aa1803e1    	mov	x1, x24
105755578: 949346f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10575557c: aa1d03fd    	mov	x29, x29
105755580: 949346f2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105755584: aa0003fb    	mov	x27, x0
105755588: 900d3728    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10575558c: f9464517    	ldr	x23, [x8, #0xc88] ; getStringForCurLanguage:
105755590: d00c6a42    	adrp	x2, 0x11e49f000 <dyld_stub_binder+0x11e49f000>
105755594: 9128a042    	add	x2, x2, #0xa28
105755598: aa1703e1    	mov	x1, x23
10575559c: 949346e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057555a0: aa1d03fd    	mov	x29, x29
1057555a4: 949346e9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057555a8: aa0003fc    	mov	x28, x0
1057555ac: f00d3728    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1057555b0: f9444904    	ldr	x4, [x8, #0x890] ; onCancel:
1057555b4: d00d3728    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057555b8: f945e101    	ldr	x1, [x8, #0xbc0] ; getBarButtonWithTitle:target:action:style:
1057555bc: aa1403e0    	mov	x0, x20
1057555c0: f90013e1    	str	x1, [sp, #0x20]
1057555c4: aa1c03e2    	mov	x2, x28
1057555c8: aa1303e3    	mov	x3, x19
1057555cc: d2800005    	mov	x5, #0x0                ; =0
1057555d0: 949346db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057555d4: aa1d03fd    	mov	x29, x29
1057555d8: 949346dc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057555dc: aa0003f4    	mov	x20, x0
1057555e0: aa1c03e0    	mov	x0, x28
1057555e4: 949346dc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057555e8: aa1b03e0    	mov	x0, x27
1057555ec: 949346da    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057555f0: aa1603e0    	mov	x0, x22
1057555f4: 949346d8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057555f8: f00d4d68    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1057555fc: f945e516    	ldr	x22, [x8, #0xbc8] ; navigationItem
105755600: aa1303e0    	mov	x0, x19
105755604: aa1603e1    	mov	x1, x22
105755608: 949346cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10575560c: aa1d03fd    	mov	x29, x29
105755610: 949346ce    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105755614: aa0003fb    	mov	x27, x0
105755618: f00d4d88    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10575561c: f9446d01    	ldr	x1, [x8, #0x8d8] ; setLeftBarButtonItem:
105755620: f90017f4    	str	x20, [sp, #0x28]
105755624: aa1403e2    	mov	x2, x20
105755628: 949346c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10575562c: aa1b03e0    	mov	x0, x27
105755630: 949346c9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105755634: b00d3ba8    	adrp	x8, 0x11feca000 <dyld_stub_binder+0x11feca000>
105755638: f944c91b    	ldr	x27, [x8, #0x990] ; m_rightBarButtonTitle
10575563c: aa1303e0    	mov	x0, x19
105755640: aa1b03e1    	mov	x1, x27
105755644: 949346be    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105755648: aa1d03fd    	mov	x29, x29
10575564c: 949346bf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105755650: aa0003fc    	mov	x28, x0
105755654: d00d4d68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
105755658: f946e901    	ldr	x1, [x8, #0xdd0] ; length
10575565c: 949346b8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105755660: aa0003f4    	mov	x20, x0
105755664: aa1c03e0    	mov	x0, x28
105755668: 949346bb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10575566c: b40005f4    	cbz	x20, 0x105755728 <_Flutter_MMFoundation_BindContext+0x1c3130c>
105755670: aa1303e0    	mov	x0, x19
105755674: aa1b03e1    	mov	x1, x27
105755678: 949346b1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10575567c: aa1d03fd    	mov	x29, x29
105755680: 949346b2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105755684: aa0003f7    	mov	x23, x0
105755688: b00d56c8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
10575568c: b98b491a    	ldrsw	x26, [x8, #0xb48]
105755690: f87a6a60    	ldr	x0, [x19, x26]
105755694: f00d4d48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105755698: f9435118    	ldr	x24, [x8, #0x6a0] ; count
10575569c: aa1803e1    	mov	x1, x24
1057556a0: 949346a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057556a4: b4000360    	cbz	x0, 0x105755710 <_Flutter_MMFoundation_BindContext+0x1c312f4>
1057556a8: d00d50e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057556ac: f9454514    	ldr	x20, [x8, #0xa88]
1057556b0: aa1303e0    	mov	x0, x19
1057556b4: aa1b03e1    	mov	x1, x27
1057556b8: 949346a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057556bc: aa1d03fd    	mov	x29, x29
1057556c0: 949346a2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057556c4: aa0003f9    	mov	x25, x0
1057556c8: f87a6a60    	ldr	x0, [x19, x26]
1057556cc: aa1803e1    	mov	x1, x24
1057556d0: 9493469b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057556d4: b00d4da8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1057556d8: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
1057556dc: a90003f9    	stp	x25, x0, [sp]
1057556e0: b00c6c62    	adrp	x2, 0x11e4e2000 <dyld_stub_binder+0x11e4e2000>
1057556e4: 91222042    	add	x2, x2, #0x888
1057556e8: aa1403e0    	mov	x0, x20
1057556ec: 94934694    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057556f0: aa1d03fd    	mov	x29, x29
1057556f4: 94934695    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057556f8: aa0003f4    	mov	x20, x0
1057556fc: aa1703e0    	mov	x0, x23
105755700: 94934695    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105755704: aa1903e0    	mov	x0, x25
105755708: 94934693    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10575570c: aa1403f7    	mov	x23, x20
105755710: f87a6a60    	ldr	x0, [x19, x26]
105755714: aa1803e1    	mov	x1, x24
105755718: 94934689    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10575571c: f100001f    	cmp	x0, #0x0
105755720: 1a9f07f8    	cset	w24, ne
105755724: 14000058    	b	0x105755884 <_Flutter_MMFoundation_BindContext+0x1c31468>
105755728: d00d50fc    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
10575572c: b00d3808    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
105755730: f942b51b    	ldr	x27, [x8, #0x568] ; m_memberCountLimit
105755734: aa1303e0    	mov	x0, x19
105755738: aa1b03e1    	mov	x1, x27
10575573c: 94934680    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105755740: b40006a0    	cbz	x0, 0x105755814 <_Flutter_MMFoundation_BindContext+0x1c313f8>
105755744: d00d50e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105755748: f9454514    	ldr	x20, [x8, #0xa88]
10575574c: f945eb80    	ldr	x0, [x28, #0xbd0]
105755750: aa1a03e1    	mov	x1, x26
105755754: 9493467a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105755758: aa1d03fd    	mov	x29, x29
10575575c: 9493467b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105755760: aa0003fa    	mov	x26, x0
105755764: f9462aa0    	ldr	x0, [x21, #0xc50]
105755768: aa1903e1    	mov	x1, x25
10575576c: 94934674    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105755770: aa0003e2    	mov	x2, x0
105755774: aa1a03e0    	mov	x0, x26
105755778: aa1803e1    	mov	x1, x24
10575577c: 94934670    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105755780: aa1d03fd    	mov	x29, x29
105755784: 94934671    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105755788: aa0003f8    	mov	x24, x0
10575578c: f00c6a42    	adrp	x2, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
105755790: 91042042    	add	x2, x2, #0x108
105755794: aa1703e1    	mov	x1, x23
105755798: 94934669    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10575579c: aa1d03fd    	mov	x29, x29
1057557a0: 9493466a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057557a4: aa0003f9    	mov	x25, x0
1057557a8: b00d56c8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
1057557ac: b98b4908    	ldrsw	x8, [x8, #0xb48]
1057557b0: f8686a60    	ldr	x0, [x19, x8]
1057557b4: f00d4d48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1057557b8: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1057557bc: 94934660    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057557c0: aa0003f7    	mov	x23, x0
1057557c4: aa1303e0    	mov	x0, x19
1057557c8: aa1b03e1    	mov	x1, x27
1057557cc: 9493465c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057557d0: b00d4da8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1057557d4: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
1057557d8: a90083f7    	stp	x23, x0, [sp, #0x8]
1057557dc: f90003f9    	str	x25, [sp]
1057557e0: d00c6be2    	adrp	x2, 0x11e4d3000 <dyld_stub_binder+0x11e4d3000>
1057557e4: 910d2042    	add	x2, x2, #0x348
1057557e8: aa1403e0    	mov	x0, x20
1057557ec: 94934654    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057557f0: aa1d03fd    	mov	x29, x29
1057557f4: 94934655    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057557f8: aa0003f7    	mov	x23, x0
1057557fc: aa1903e0    	mov	x0, x25
105755800: 94934655    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105755804: aa1803e0    	mov	x0, x24
105755808: 94934653    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10575580c: aa1a03e0    	mov	x0, x26
105755810: 1400001b    	b	0x10575587c <_Flutter_MMFoundation_BindContext+0x1c31460>
105755814: f945eb80    	ldr	x0, [x28, #0xbd0]
105755818: aa1a03e1    	mov	x1, x26
10575581c: 94934648    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105755820: aa1d03fd    	mov	x29, x29
105755824: 94934649    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105755828: aa0003f4    	mov	x20, x0
10575582c: f9462aa0    	ldr	x0, [x21, #0xc50]
105755830: aa1903e1    	mov	x1, x25
105755834: 94934642    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105755838: aa0003e2    	mov	x2, x0
10575583c: aa1403e0    	mov	x0, x20
105755840: aa1803e1    	mov	x1, x24
105755844: 9493463e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105755848: aa1d03fd    	mov	x29, x29
10575584c: 9493463f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105755850: aa0003f8    	mov	x24, x0
105755854: f00c6a42    	adrp	x2, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
105755858: 91042042    	add	x2, x2, #0x108
10575585c: aa1703e1    	mov	x1, x23
105755860: 94934637    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105755864: aa1d03fd    	mov	x29, x29
105755868: 94934638    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10575586c: aa0003f7    	mov	x23, x0
105755870: aa1803e0    	mov	x0, x24
105755874: 94934638    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105755878: aa1403e0    	mov	x0, x20
10575587c: 94934636    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105755880: 52800038    	mov	w24, #0x1               ; =1
105755884: d00d50e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105755888: f947d900    	ldr	x0, [x8, #0xfb0]
10575588c: b00d3808    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
105755890: f942b904    	ldr	x4, [x8, #0x570] ; onDone:
105755894: f94013e1    	ldr	x1, [sp, #0x20]
105755898: aa1703e2    	mov	x2, x23
10575589c: aa1303e3    	mov	x3, x19
1057558a0: 528000a5    	mov	w5, #0x5                ; =5
1057558a4: 94934626    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057558a8: aa1d03fd    	mov	x29, x29
1057558ac: 94934627    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057558b0: aa0003f4    	mov	x20, x0
1057558b4: d00d4d88    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
1057558b8: f946bd01    	ldr	x1, [x8, #0xd78] ; setEnabled:
1057558bc: aa1803e2    	mov	x2, x24
1057558c0: 9493461f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057558c4: aa1303e0    	mov	x0, x19
1057558c8: aa1603e1    	mov	x1, x22
1057558cc: 9493461c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057558d0: aa1d03fd    	mov	x29, x29
1057558d4: 9493461d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057558d8: aa0003f3    	mov	x19, x0
1057558dc: d00d3728    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057558e0: f945f101    	ldr	x1, [x8, #0xbe0] ; setRightBarButtonItem:
1057558e4: aa1403e2    	mov	x2, x20
1057558e8: 94934615    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057558ec: aa1303e0    	mov	x0, x19
1057558f0: 94934619    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057558f4: aa1403e0    	mov	x0, x20
1057558f8: 94934617    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057558fc: aa1703e0    	mov	x0, x23
105755900: 94934615    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105755904: f94017e0    	ldr	x0, [sp, #0x28]
105755908: a9487bfd    	ldp	x29, x30, [sp, #0x80]
10575590c: a9474ff4    	ldp	x20, x19, [sp, #0x70]
105755910: a94657f6    	ldp	x22, x21, [sp, #0x60]
105755914: a9455ff8    	ldp	x24, x23, [sp, #0x50]
105755918: a94467fa    	ldp	x26, x25, [sp, #0x40]
10575591c: a9436ffc    	ldp	x28, x27, [sp, #0x30]
105755920: 910243ff    	add	sp, sp, #0x90
105755924: 1493460c    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
