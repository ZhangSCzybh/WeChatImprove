
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1051860c4: d100c3ff    	sub	sp, sp, #0x30
1051860c8: a9014ff4    	stp	x20, x19, [sp, #0x10]
1051860cc: a9027bfd    	stp	x29, x30, [sp, #0x20]
1051860d0: 910083fd    	add	x29, sp, #0x20
1051860d4: aa0003f3    	mov	x19, x0
1051860d8: b00d7f68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1051860dc: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole @ 0x120173a68
1051860e0: f00d6588    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1051860e4: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format: @ 0x11fe39550
1051860e8: d00cb288    	adrp	x8, 0x11e7d8000 <dyld_stub_binder+0x11e7d8000>
1051860ec: 9114a108    	add	x8, x8, #0x528 ; CFString 'make sync pause' @ 0x11e7d8528
1051860f0: f90003e8    	str	x8, [sp]
1051860f4: d00b0ec3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
1051860f8: 91270063    	add	x3, x3, #0x9c0 ; string 'Sync' @ 0x11b3609c0
1051860fc: 900b36c5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105186100: 912b00a5    	add	x5, x5, #0xac0 ; string 'NewSyncService.mm' @ 0x11b85eac0
105186104: b00b36c7    	adrp	x7, 0x11b85f000 <dyld_stub_binder+0x11b85f000>
105186108: 911af8e7    	add	x7, x7, #0x6be ; string '-[NewSyncService makeSyncPause]' @ 0x11b85f6be
10518610c: 52800042    	mov	w2, #0x2                ; =2
105186110: 52800004    	mov	w4, #0x0                ; =0
105186114: 52808486    	mov	w6, #0x424              ; =1060
105186118: 94aa8409    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10518611c: d00d8508    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105186120: b9891908    	ldrsw	x8, [x8, #0x918] ; ivar m_bIsSyncPause offset 84 @ 0x120228918
105186124: 52800029    	mov	w9, #0x1                ; =1
105186128: 38286a69    	strb	w9, [x19, x8]
10518612c: b00d7f68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105186130: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext @ 0x120173bd0
105186134: d00d7bc8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105186138: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext @ 0x1201009d0
10518613c: 94aa8400    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105186140: aa1d03fd    	mov	x29, x29
105186144: 94aa8401    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105186148: aa0003f3    	mov	x19, x0
10518614c: d00d7f88    	adrp	x8, 0x120178000 <dyld_stub_binder+0x120178000>
105186150: f944c100    	ldr	x0, [x8, #0x980] ; class BypSyncService @ 0x120178980
105186154: b00d7bc8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105186158: f947ad01    	ldr	x1, [x8, #0xf58] ; selector class @ 0x1200fff58
10518615c: 94aa83f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105186160: aa0003e2    	mov	x2, x0
105186164: f00d6588    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105186168: f9464101    	ldr	x1, [x8, #0xc80] ; selector getService: @ 0x11fe39c80
10518616c: aa1303e0    	mov	x0, x19
105186170: 94aa83f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105186174: aa1d03fd    	mov	x29, x29
105186178: 94aa83f4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10518617c: aa0003f4    	mov	x20, x0
105186180: d00d70a8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105186184: f9430901    	ldr	x1, [x8, #0x610] ; selector setSyncPaused: @ 0x11ff9c610
105186188: 52800022    	mov	w2, #0x1                ; =1
10518618c: 94aa83ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105186190: aa1403e0    	mov	x0, x20
105186194: 94aa83f0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105186198: aa1303e0    	mov	x0, x19
10518619c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1051861a0: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1051861a4: 9100c3ff    	add	sp, sp, #0x30
1051861a8: 14aa83eb    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
