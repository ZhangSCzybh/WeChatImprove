
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105111674: d10183ff    	sub	sp, sp, #0x60
105111678: a9025ff8    	stp	x24, x23, [sp, #0x20]
10511167c: a90357f6    	stp	x22, x21, [sp, #0x30]
105111680: a9044ff4    	stp	x20, x19, [sp, #0x40]
105111684: a9057bfd    	stp	x29, x30, [sp, #0x50]
105111688: 910143fd    	add	x29, sp, #0x50
10511168c: d00dd968    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
105111690: 52800029    	mov	w9, #0x1                ; =1
105111694: 392d3909    	strb	w9, [x8, #0xb4e]
105111698: b00d85a8    	adrp	x8, 0x1201c6000 <dyld_stub_binder+0x1201c6000>
10511169c: f9406108    	ldr	x8, [x8, #0xc0] ; NewMainFrameViewController
1051116a0: a90123e0    	stp	x0, x8, [sp, #0x10]
1051116a4: f00d6a28    	adrp	x8, 0x11fe58000 <dyld_stub_binder+0x11fe58000>
1051116a8: f9439501    	ldr	x1, [x8, #0x728] ; initWithNibName:bundle:
1051116ac: 910043e0    	add	x0, sp, #0x10
1051116b0: 94ac56a5    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
1051116b4: aa0003f3    	mov	x19, x0
1051116b8: b4001b40    	cbz	x0, 0x105111a20 <_Flutter_MMFoundation_BindContext+0x15ed604>
1051116bc: f00d88a8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051116c0: b9831508    	ldrsw	x8, [x8, #0x314]
1051116c4: f8686a60    	ldr	x0, [x19, x8]
1051116c8: f8286a7f    	str	xzr, [x19, x8]
1051116cc: 94ac56a2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051116d0: f00d88a8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051116d4: b9831908    	ldrsw	x8, [x8, #0x318]
1051116d8: f8686a60    	ldr	x0, [x19, x8]
1051116dc: f8286a7f    	str	xzr, [x19, x8]
1051116e0: 94ac569d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051116e4: f00d88a8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051116e8: b9832108    	ldrsw	x8, [x8, #0x320]
1051116ec: f8686a60    	ldr	x0, [x19, x8]
1051116f0: f8286a7f    	str	xzr, [x19, x8]
1051116f4: 94ac5698    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051116f8: f00d88a8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051116fc: b9832508    	ldrsw	x8, [x8, #0x324]
105111700: f8686a60    	ldr	x0, [x19, x8]
105111704: f8286a7f    	str	xzr, [x19, x8]
105111708: 94ac5693    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511170c: f00d88a8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105111710: b9832908    	ldrsw	x8, [x8, #0x328]
105111714: 38286a7f    	strb	wzr, [x19, x8]
105111718: f00d88a8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10511171c: b9832d08    	ldrsw	x8, [x8, #0x32c]
105111720: 38286a7f    	strb	wzr, [x19, x8]
105111724: d00d8308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105111728: f9453500    	ldr	x0, [x8, #0xa68] ; iConsole
10511172c: 900d6948    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105111730: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
105111734: f00cb608    	adrp	x8, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
105111738: 9111a108    	add	x8, x8, #0x468 ; CFString 'init newmainframe'
10511173c: f90003e8    	str	x8, [sp]
105111740: f00b3a25    	adrp	x5, 0x11b858000 <dyld_stub_binder+0x11b858000>
105111744: 9122e0a5    	add	x5, x5, #0x8b8
105111748: f00b3a27    	adrp	x7, 0x11b858000 <dyld_stub_binder+0x11b858000>
10511174c: 912b60e7    	add	x7, x7, #0xad8
105111750: 52800042    	mov	w2, #0x2                ; =2
105111754: d2800003    	mov	x3, #0x0                ; =0
105111758: 52800004    	mov	w4, #0x0                ; =0
10511175c: 52803506    	mov	w6, #0x1a8              ; =424
105111760: 94ac5677    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111764: d00d8308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105111768: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
10511176c: f00d7f68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105111770: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
105111774: 94ac5672    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111778: aa1d03fd    	mov	x29, x29
10511177c: 94ac5673    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105111780: aa0003f4    	mov	x20, x0
105111784: b00d8388    	adrp	x8, 0x120182000 <dyld_stub_binder+0x120182000>
105111788: f9456900    	ldr	x0, [x8, #0xad0] ; VoiceSearchActionReportService
10511178c: d00d7f68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105111790: f947ad01    	ldr	x1, [x8, #0xf58] ; class
105111794: 94ac566a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111798: aa0003e2    	mov	x2, x0
10511179c: 900d6948    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1051117a0: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
1051117a4: aa1403e0    	mov	x0, x20
1051117a8: 94ac5665    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051117ac: aa1d03fd    	mov	x29, x29
1051117b0: 94ac5666    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051117b4: 94ac5668    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051117b8: aa1403e0    	mov	x0, x20
1051117bc: 94ac5666    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051117c0: d00d8317    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
1051117c4: f9458ee0    	ldr	x0, [x23, #0xb18]
1051117c8: f00d7f68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1051117cc: f946b114    	ldr	x20, [x8, #0xd60] ; defaultCenter
1051117d0: aa1403e1    	mov	x1, x20
1051117d4: 94ac565a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051117d8: aa1d03fd    	mov	x29, x29
1051117dc: 94ac565b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051117e0: aa0003f6    	mov	x22, x0
1051117e4: d00d6bc8    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1051117e8: f9435103    	ldr	x3, [x8, #0x6a0] ; backToSplitViewEmptyViewController:
1051117ec: f00c2a48    	adrp	x8, 0x11d65c000 <dyld_stub_binder+0x11d65c000>
1051117f0: 913a4108    	add	x8, x8, #0xe90
1051117f4: f9400104    	ldr	x4, [x8]
1051117f8: b00d7f68    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1051117fc: f9470115    	ldr	x21, [x8, #0xe00] ; addObserver:selector:name:object:
105111800: aa1503e1    	mov	x1, x21
105111804: aa1303e2    	mov	x2, x19
105111808: d2800005    	mov	x5, #0x0                ; =0
10511180c: 94ac564c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111810: aa1603e0    	mov	x0, x22
105111814: 94ac5650    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105111818: f9458ee0    	ldr	x0, [x23, #0xb18]
10511181c: aa1403e1    	mov	x1, x20
105111820: 94ac5647    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111824: aa1d03fd    	mov	x29, x29
105111828: 94ac5648    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511182c: aa0003f6    	mov	x22, x0
105111830: b00d7448    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
105111834: f945b103    	ldr	x3, [x8, #0xb60] ; onSearch
105111838: d00cb1e4    	adrp	x4, 0x11e74f000 <dyld_stub_binder+0x11e74f000>
10511183c: 91102084    	add	x4, x4, #0x408 ; CFString 'keyCommandsOnSearch'
105111840: aa1503e1    	mov	x1, x21
105111844: aa1303e2    	mov	x2, x19
105111848: d2800005    	mov	x5, #0x0                ; =0
10511184c: 94ac563c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111850: aa1603e0    	mov	x0, x22
105111854: 94ac5640    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105111858: f9458ee0    	ldr	x0, [x23, #0xb18]
10511185c: aa1403e1    	mov	x1, x20
105111860: 94ac5637    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111864: aa1d03fd    	mov	x29, x29
105111868: 94ac5638    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511186c: aa0003f6    	mov	x22, x0
105111870: b00d7448    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
105111874: f945b503    	ldr	x3, [x8, #0xb68] ; onNextUnreadChat
105111878: d00cb1e4    	adrp	x4, 0x11e74f000 <dyld_stub_binder+0x11e74f000>
10511187c: 9110a084    	add	x4, x4, #0x428 ; CFString 'keyCommandsOnNextUnreadChat'
105111880: aa1503e1    	mov	x1, x21
105111884: aa1303e2    	mov	x2, x19
105111888: d2800005    	mov	x5, #0x0                ; =0
10511188c: 94ac562c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111890: aa1603e0    	mov	x0, x22
105111894: 94ac5630    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105111898: f9458ee0    	ldr	x0, [x23, #0xb18]
10511189c: aa1403e1    	mov	x1, x20
1051118a0: 94ac5627    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051118a4: aa1d03fd    	mov	x29, x29
1051118a8: 94ac5628    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051118ac: aa0003f6    	mov	x22, x0
1051118b0: b00d7448    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
1051118b4: f945b903    	ldr	x3, [x8, #0xb70] ; newChat
1051118b8: d00cb1e4    	adrp	x4, 0x11e74f000 <dyld_stub_binder+0x11e74f000>
1051118bc: 91112084    	add	x4, x4, #0x448 ; CFString 'keyCommandsNewChat'
1051118c0: aa1503e1    	mov	x1, x21
1051118c4: aa1303e2    	mov	x2, x19
1051118c8: d2800005    	mov	x5, #0x0                ; =0
1051118cc: 94ac561c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051118d0: aa1603e0    	mov	x0, x22
1051118d4: 94ac5620    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051118d8: f9458ee0    	ldr	x0, [x23, #0xb18]
1051118dc: aa1403e1    	mov	x1, x20
1051118e0: 94ac5617    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051118e4: aa1d03fd    	mov	x29, x29
1051118e8: 94ac5618    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051118ec: aa0003f6    	mov	x22, x0
1051118f0: b00d7448    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
1051118f4: f945bd03    	ldr	x3, [x8, #0xb78] ; closeCurChat
1051118f8: d00cb1e4    	adrp	x4, 0x11e74f000 <dyld_stub_binder+0x11e74f000>
1051118fc: 9111a084    	add	x4, x4, #0x468 ; CFString 'keyCommandsCloseCurChat'
105111900: aa1503e1    	mov	x1, x21
105111904: aa1303e2    	mov	x2, x19
105111908: d2800005    	mov	x5, #0x0                ; =0
10511190c: 94ac560c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111910: aa1603e0    	mov	x0, x22
105111914: 94ac5610    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105111918: f9458ee0    	ldr	x0, [x23, #0xb18]
10511191c: aa1403e1    	mov	x1, x20
105111920: 94ac5607    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111924: aa1d03fd    	mov	x29, x29
105111928: 94ac5608    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511192c: aa0003f6    	mov	x22, x0
105111930: b00d7448    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
105111934: f945c103    	ldr	x3, [x8, #0xb80] ; onNextChat
105111938: d00cb1e4    	adrp	x4, 0x11e74f000 <dyld_stub_binder+0x11e74f000>
10511193c: 91122084    	add	x4, x4, #0x488 ; CFString 'keyCommandsOnNextChat'
105111940: aa1503e1    	mov	x1, x21
105111944: aa1303e2    	mov	x2, x19
105111948: d2800005    	mov	x5, #0x0                ; =0
10511194c: 94ac55fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111950: aa1603e0    	mov	x0, x22
105111954: 94ac5600    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105111958: f9458ee0    	ldr	x0, [x23, #0xb18]
10511195c: aa1403e1    	mov	x1, x20
105111960: 94ac55f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111964: aa1d03fd    	mov	x29, x29
105111968: 94ac55f8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511196c: aa0003f6    	mov	x22, x0
105111970: b00d7448    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
105111974: f945c503    	ldr	x3, [x8, #0xb88] ; onLastChat
105111978: d00cb1e4    	adrp	x4, 0x11e74f000 <dyld_stub_binder+0x11e74f000>
10511197c: 9112a084    	add	x4, x4, #0x4a8 ; CFString 'keyCommandsOnLastChat'
105111980: aa1503e1    	mov	x1, x21
105111984: aa1303e2    	mov	x2, x19
105111988: d2800005    	mov	x5, #0x0                ; =0
10511198c: 94ac55ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111990: aa1603e0    	mov	x0, x22
105111994: 94ac55f0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105111998: f9458ee0    	ldr	x0, [x23, #0xb18]
10511199c: aa1403e1    	mov	x1, x20
1051119a0: 94ac55e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051119a4: aa1d03fd    	mov	x29, x29
1051119a8: 94ac55e8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051119ac: aa0003f6    	mov	x22, x0
1051119b0: f00d6a48    	adrp	x8, 0x11fe5c000 <dyld_stub_binder+0x11fe5c000>
1051119b4: f946b903    	ldr	x3, [x8, #0xd70] ; willEnterForeground:
1051119b8: f00c2a48    	adrp	x8, 0x11d65c000 <dyld_stub_binder+0x11d65c000>
1051119bc: 9138e108    	add	x8, x8, #0xe38
1051119c0: f9400104    	ldr	x4, [x8]
1051119c4: aa1503e1    	mov	x1, x21
1051119c8: aa1303e2    	mov	x2, x19
1051119cc: d2800005    	mov	x5, #0x0                ; =0
1051119d0: 94ac55db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051119d4: aa1603e0    	mov	x0, x22
1051119d8: 94ac55df    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051119dc: f9458ee0    	ldr	x0, [x23, #0xb18]
1051119e0: aa1403e1    	mov	x1, x20
1051119e4: 94ac55d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051119e8: aa1d03fd    	mov	x29, x29
1051119ec: 94ac55d7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051119f0: aa0003f4    	mov	x20, x0
1051119f4: d00d6a68    	adrp	x8, 0x11fe5f000 <dyld_stub_binder+0x11fe5f000>
1051119f8: f9463503    	ldr	x3, [x8, #0xc68] ; didEnterBackground:
1051119fc: f00c2a48    	adrp	x8, 0x11d65c000 <dyld_stub_binder+0x11d65c000>
105111a00: 9138c108    	add	x8, x8, #0xe30
105111a04: f9400104    	ldr	x4, [x8]
105111a08: aa1503e1    	mov	x1, x21
105111a0c: aa1303e2    	mov	x2, x19
105111a10: d2800005    	mov	x5, #0x0                ; =0
105111a14: 94ac55ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111a18: aa1403e0    	mov	x0, x20
105111a1c: 94ac55ce    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105111a20: aa1303e0    	mov	x0, x19
105111a24: a9457bfd    	ldp	x29, x30, [sp, #0x50]
105111a28: a9444ff4    	ldp	x20, x19, [sp, #0x40]
105111a2c: a94357f6    	ldp	x22, x21, [sp, #0x30]
105111a30: a9425ff8    	ldp	x24, x23, [sp, #0x20]
105111a34: 910183ff    	add	sp, sp, #0x60
105111a38: d65f03c0    	ret
