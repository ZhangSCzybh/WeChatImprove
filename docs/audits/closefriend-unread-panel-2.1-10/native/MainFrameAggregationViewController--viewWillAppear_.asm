
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a72180: d10143ff    	sub	sp, sp, #0x50
104a72184: a9015ff8    	stp	x24, x23, [sp, #0x10]
104a72188: a90257f6    	stp	x22, x21, [sp, #0x20]
104a7218c: a9034ff4    	stp	x20, x19, [sp, #0x30]
104a72190: a9047bfd    	stp	x29, x30, [sp, #0x40]
104a72194: 910103fd    	add	x29, sp, #0x40
104a72198: aa0003f3    	mov	x19, x0
104a7219c: 900e0e68    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a721a0: 52800029    	mov	w9, #0x1                ; =1
104a721a4: 390aed09    	strb	w9, [x8, #0x2bb]
104a721a8: f00dba88    	adrp	x8, 0x1201c5000 <dyld_stub_binder+0x1201c5000>
104a721ac: f9429d08    	ldr	x8, [x8, #0x538]
104a721b0: a90023e0    	stp	x0, x8, [sp]
104a721b4: d00d9e48    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a721b8: f941d101    	ldr	x1, [x8, #0x3a0] ; selector viewWillAppear:
104a721bc: 910003e0    	mov	x0, sp
104a721c0: 94c6d3e1    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
104a721c4: d00db488    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104a721c8: f945e501    	ldr	x1, [x8, #0xbc8] ; selector navigationItem
104a721cc: aa1303e0    	mov	x0, x19
104a721d0: 94c6d3db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a721d4: aa1d03fd    	mov	x29, x29
104a721d8: 94c6d3dc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a721dc: aa0003f4    	mov	x20, x0
104a721e0: d00db4a8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104a721e4: f9446d01    	ldr	x1, [x8, #0x8d8] ; selector setLeftBarButtonItem:
104a721e8: d2800002    	mov	x2, #0x0                ; =0
104a721ec: 94c6d3d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a721f0: aa1403e0    	mov	x0, x20
104a721f4: 94c6d3d8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a721f8: 900db908    	adrp	x8, 0x120192000 <dyld_stub_binder+0x120192000>
104a721fc: f944c100    	ldr	x0, [x8, #0x980] ; class MainFrameAggregationLogic
104a72200: d00da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a72204: f940ed01    	ldr	x1, [x8, #0x1d8] ; selector isAutoPopWhenReturnOpen
104a72208: 94c6d3cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7220c: 34000d60    	cbz	w0, 0x104a723b8 <_Flutter_MMFoundation_BindContext+0xf4df9c>
104a72210: d00da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a72214: f940f101    	ldr	x1, [x8, #0x1e0] ; selector hasOpenedSession
104a72218: aa1303e0    	mov	x0, x19
104a7221c: 94c6d3c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a72220: 34000cc0    	cbz	w0, 0x104a723b8 <_Flutter_MMFoundation_BindContext+0xf4df9c>
104a72224: b00dbd88    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a72228: b980d908    	ldrsw	x8, [x8, #0xd8]
104a7222c: f8686a60    	ldr	x0, [x19, x8]
104a72230: d00da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a72234: f940f501    	ldr	x1, [x8, #0x1e8] ; selector shouldAutoPopWhenReturn
104a72238: 94c6d3c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7223c: 34000be0    	cbz	w0, 0x104a723b8 <_Flutter_MMFoundation_BindContext+0xf4df9c>
104a72240: d00da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a72244: f940f901    	ldr	x1, [x8, #0x1f0] ; selector setHasOpenedSession:
104a72248: aa1303e0    	mov	x0, x19
104a7224c: 52800002    	mov	w2, #0x0                ; =0
104a72250: 94c6d3bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a72254: b00dbd88    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a72258: b980e108    	ldrsw	x8, [x8, #0xe0]
104a7225c: 52800069    	mov	w9, #0x3                ; =3
104a72260: f8286a69    	str	x9, [x19, x8]
104a72264: d00da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a72268: f940fd01    	ldr	x1, [x8, #0x1f8] ; selector setNeedAutoPopToMainPage:
104a7226c: aa1303e0    	mov	x0, x19
104a72270: 52800022    	mov	w2, #0x1                ; =1
104a72274: 94c6d3b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a72278: b00dbd88    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a7227c: b980e517    	ldrsw	x23, [x8, #0xe4]
104a72280: f8776a60    	ldr	x0, [x19, x23]
104a72284: d00da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a72288: f940c101    	ldr	x1, [x8, #0x180] ; selector fromSnapshtoView
104a7228c: 94c6d3ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a72290: aa1d03fd    	mov	x29, x29
104a72294: 94c6d3ad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a72298: aa0003f4    	mov	x20, x0
104a7229c: b4000880    	cbz	x0, 0x104a723ac <_Flutter_MMFoundation_BindContext+0xf4df90>
104a722a0: b00db4c8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104a722a4: f946d515    	ldr	x21, [x8, #0xda8] ; selector view
104a722a8: aa1303e0    	mov	x0, x19
104a722ac: aa1503e1    	mov	x1, x21
104a722b0: 94c6d3a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a722b4: aa1d03fd    	mov	x29, x29
104a722b8: 94c6d3a4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a722bc: aa0003f6    	mov	x22, x0
104a722c0: b00db468    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a722c4: f943d501    	ldr	x1, [x8, #0x7a8] ; selector bounds
104a722c8: 94c6d39d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a722cc: d00db4a8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104a722d0: f9403501    	ldr	x1, [x8, #0x68] ; selector setFrame:
104a722d4: aa1403e0    	mov	x0, x20
104a722d8: 94c6d399    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a722dc: aa1603e0    	mov	x0, x22
104a722e0: 94c6d39d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a722e4: d00db4a8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104a722e8: f9411101    	ldr	x1, [x8, #0x220] ; selector setHidden:
104a722ec: aa1403e0    	mov	x0, x20
104a722f0: 52800002    	mov	w2, #0x0                ; =0
104a722f4: 94c6d392    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a722f8: aa1303e0    	mov	x0, x19
104a722fc: aa1503e1    	mov	x1, x21
104a72300: 94c6d38f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a72304: aa1d03fd    	mov	x29, x29
104a72308: 94c6d390    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a7230c: aa0003f5    	mov	x21, x0
104a72310: b00db468    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a72314: f9440501    	ldr	x1, [x8, #0x808] ; selector bringSubviewToFront:
104a72318: aa1403e2    	mov	x2, x20
104a7231c: 94c6d388    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a72320: aa1503e0    	mov	x0, x21
104a72324: 94c6d38c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a72328: f8776a60    	ldr	x0, [x19, x23]
104a7232c: d00da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a72330: f940cd01    	ldr	x1, [x8, #0x198] ; selector tabbarSnapshotView
104a72334: 94c6d382    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a72338: aa1d03fd    	mov	x29, x29
104a7233c: 94c6d383    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a72340: aa0003f3    	mov	x19, x0
104a72344: b4000300    	cbz	x0, 0x104a723a4 <_Flutter_MMFoundation_BindContext+0xf4df88>
104a72348: 900db468    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
104a7234c: f9476d01    	ldr	x1, [x8, #0xed8] ; selector addSubview:
104a72350: aa1403e0    	mov	x0, x20
104a72354: aa1303e2    	mov	x2, x19
104a72358: 94c6d379    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7235c: b00db4c8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104a72360: f947a501    	ldr	x1, [x8, #0xf48] ; selector width
104a72364: aa1403e0    	mov	x0, x20
104a72368: 94c6d375    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7236c: 1e6c1001    	fmov	d1, #0.50000000
104a72370: 1e610800    	fmul	d0, d0, d1
104a72374: d00d9e48    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a72378: f942dd01    	ldr	x1, [x8, #0x5b8] ; selector setCenterX:
104a7237c: aa1303e0    	mov	x0, x19
104a72380: 94c6d36f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a72384: 900db488    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104a72388: f9449d01    	ldr	x1, [x8, #0x938] ; selector height
104a7238c: aa1403e0    	mov	x0, x20
104a72390: 94c6d36b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a72394: f00d9e68    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
104a72398: f941e901    	ldr	x1, [x8, #0x3d0] ; selector setBottom:
104a7239c: aa1303e0    	mov	x0, x19
104a723a0: 94c6d367    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a723a4: aa1303e0    	mov	x0, x19
104a723a8: 94c6d36b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a723ac: aa1403e0    	mov	x0, x20
104a723b0: 94c6d369    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a723b4: 14000006    	b	0x104a723cc <_Flutter_MMFoundation_BindContext+0xf4dfb0>
104a723b8: d00da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a723bc: f940f901    	ldr	x1, [x8, #0x1f0] ; selector setHasOpenedSession:
104a723c0: aa1303e0    	mov	x0, x19
104a723c4: 52800002    	mov	w2, #0x0                ; =0
104a723c8: 94c6d35d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a723cc: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104a723d0: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104a723d4: a94257f6    	ldp	x22, x21, [sp, #0x20]
104a723d8: a9415ff8    	ldp	x24, x23, [sp, #0x10]
104a723dc: 910143ff    	add	sp, sp, #0x50
104a723e0: d65f03c0    	ret
