
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10627938c: d101c3ff    	sub	sp, sp, #0x70
106279390: a9035ff8    	stp	x24, x23, [sp, #0x30]
106279394: a90457f6    	stp	x22, x21, [sp, #0x40]
106279398: a9054ff4    	stp	x20, x19, [sp, #0x50]
10627939c: a9067bfd    	stp	x29, x30, [sp, #0x60]
1062793a0: 910183fd    	add	x29, sp, #0x60
1062793a4: aa0003f3    	mov	x19, x0
1062793a8: d00d4e48    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
1062793ac: 52800029    	mov	w9, #0x1                ; =1
1062793b0: 3927c909    	strb	w9, [x8, #0x9f2]
1062793b4: f00cfde8    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
1062793b8: b98d5517    	ldrsw	x23, [x8, #0xd54]
1062793bc: f8776800    	ldr	x0, [x0, x23]
1062793c0: b40003e0    	cbz	x0, 0x10627943c <_Flutter_MMFoundation_BindContext+0x2755020>
1062793c4: b00cf488    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1062793c8: f9475d01    	ldr	x1, [x8, #0xeb8] ; superview
1062793cc: 9466b75c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062793d0: aa1d03fd    	mov	x29, x29
1062793d4: 9466b75d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062793d8: aa0003f4    	mov	x20, x0
1062793dc: b4000220    	cbz	x0, 0x106279420 <_Flutter_MMFoundation_BindContext+0x2755004>
1062793e0: f8776a60    	ldr	x0, [x19, x23]
1062793e4: d00cf428    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1062793e8: f9403501    	ldr	x1, [x8, #0x68] ; alpha
1062793ec: 9466b754    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062793f0: 1e6e1001    	fmov	d1, #1.00000000
1062793f4: 1e612000    	fcmp	d0, d1
1062793f8: 54000141    	b.ne	0x106279420 <_Flutter_MMFoundation_BindContext+0x2755004>
1062793fc: f8776a60    	ldr	x0, [x19, x23]
106279400: d00cf448    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106279404: f943f901    	ldr	x1, [x8, #0x7f0] ; isHidden
106279408: 9466b74d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627940c: aa0003f5    	mov	x21, x0
106279410: aa1403e0    	mov	x0, x20
106279414: 9466b750    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106279418: 35000095    	cbnz	w21, 0x106279428 <_Flutter_MMFoundation_BindContext+0x275500c>
10627941c: 1400004d    	b	0x106279550 <_Flutter_MMFoundation_BindContext+0x2755134>
106279420: aa1403e0    	mov	x0, x20
106279424: 9466b74c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106279428: f8776a60    	ldr	x0, [x19, x23]
10627942c: b4000080    	cbz	x0, 0x10627943c <_Flutter_MMFoundation_BindContext+0x2755020>
106279430: b00cf468    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
106279434: f940f901    	ldr	x1, [x8, #0x1f0] ; removeFromSuperview
106279438: 9466b741    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627943c: d00ceac8    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106279440: f9463901    	ldr	x1, [x8, #0xc70] ; initQuickTransTipButton
106279444: aa1303e0    	mov	x0, x19
106279448: 9466b73d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627944c: f8776a62    	ldr	x2, [x19, x23]
106279450: b00cf428    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
106279454: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
106279458: aa1303e0    	mov	x0, x19
10627945c: 9466b738    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106279460: b00cde28    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
106279464: f9410901    	ldr	x1, [x8, #0x210] ; viewModel
106279468: aa1303e0    	mov	x0, x19
10627946c: 9466b734    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106279470: aa1d03fd    	mov	x29, x29
106279474: 9466b735    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106279478: aa0003f4    	mov	x20, x0
10627947c: b00cde28    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
106279480: f9410501    	ldr	x1, [x8, #0x208] ; messageWrap
106279484: 9466b72e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106279488: aa1d03fd    	mov	x29, x29
10627948c: 9466b72f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106279490: aa0003f5    	mov	x21, x0
106279494: f00cde48    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
106279498: f9435901    	ldr	x1, [x8, #0x6b0] ; IsDownloadEnded
10627949c: 9466b728    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062794a0: aa0003f6    	mov	x22, x0
1062794a4: aa1503e0    	mov	x0, x21
1062794a8: 9466b72b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062794ac: aa1403e0    	mov	x0, x20
1062794b0: 9466b729    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062794b4: f8776a60    	ldr	x0, [x19, x23]
1062794b8: 36000596    	tbz	w22, #0x0, 0x106279568 <_Flutter_MMFoundation_BindContext+0x275514c>
1062794bc: b00cf468    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1062794c0: f9476901    	ldr	x1, [x8, #0xed0] ; setAlpha:
1062794c4: 9e6703e0    	fmov	d0, xzr
1062794c8: 9466b71d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062794cc: f8776a61    	ldr	x1, [x19, x23]
1062794d0: 9100a3e0    	add	x0, sp, #0x28
1062794d4: 9466b726    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
1062794d8: d00cf7c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1062794dc: b00b9ba9    	adrp	x9, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1062794e0: f947e129    	ldr	x9, [x9, #0xfc0]
1062794e4: f9474d13    	ldr	x19, [x8, #0xe98]
1062794e8: f90003e9    	str	x9, [sp]
1062794ec: 90095848    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1062794f0: fd41c100    	ldr	d0, [x8, #0x380]
1062794f4: 90000008    	adrp	x8, 0x106279000 <_Flutter_MMFoundation_BindContext+0x2754be4>
1062794f8: 91163108    	add	x8, x8, #0x58c
1062794fc: fd0007e0    	str	d0, [sp, #0x8]
106279500: b00b9be9    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
106279504: 91150129    	add	x9, x9, #0x540
106279508: a90127e8    	stp	x8, x9, [sp, #0x10]
10627950c: 910003f4    	mov	x20, sp
106279510: 91008280    	add	x0, x20, #0x20
106279514: 9100a3e1    	add	x1, sp, #0x28
106279518: 9466b718    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
10627951c: b00cde28    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
106279520: f9402d01    	ldr	x1, [x8, #0x58] ; animateWithDuration:animations:completion:
106279524: f00ba043    	adrp	x3, 0x11d684000 <dyld_stub_binder+0x11d684000>
106279528: 910ac063    	add	x3, x3, #0x2b0
10627952c: 90095848    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
106279530: fd437100    	ldr	d0, [x8, #0x6e0]
106279534: 910003e2    	mov	x2, sp
106279538: aa1303e0    	mov	x0, x19
10627953c: 9466b700    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106279540: 91008280    	add	x0, x20, #0x20
106279544: 9466b713    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
106279548: 9100a3e0    	add	x0, sp, #0x28
10627954c: 9466b711    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
106279550: a9467bfd    	ldp	x29, x30, [sp, #0x60]
106279554: a9454ff4    	ldp	x20, x19, [sp, #0x50]
106279558: a94457f6    	ldp	x22, x21, [sp, #0x40]
10627955c: a9435ff8    	ldp	x24, x23, [sp, #0x30]
106279560: 9101c3ff    	add	sp, sp, #0x70
106279564: d65f03c0    	ret
106279568: f00cf468    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10627956c: f9411101    	ldr	x1, [x8, #0x220] ; setHidden:
106279570: 52800022    	mov	w2, #0x1                ; =1
106279574: a9467bfd    	ldp	x29, x30, [sp, #0x60]
106279578: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10627957c: a94457f6    	ldp	x22, x21, [sp, #0x40]
106279580: a9435ff8    	ldp	x24, x23, [sp, #0x30]
106279584: 9101c3ff    	add	sp, sp, #0x70
106279588: 1466b6ed    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>