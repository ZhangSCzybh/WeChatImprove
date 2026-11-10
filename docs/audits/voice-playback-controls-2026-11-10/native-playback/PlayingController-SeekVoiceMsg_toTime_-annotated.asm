
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
10565c3f0: d101c3ff    	sub	sp, sp, #0x70
10565c3f4: a90267fa    	stp	x26, x25, [sp, #0x20]
10565c3f8: a9035ff8    	stp	x24, x23, [sp, #0x30]
10565c3fc: a90457f6    	stp	x22, x21, [sp, #0x40]
10565c400: a9054ff4    	stp	x20, x19, [sp, #0x50]
10565c404: a9067bfd    	stp	x29, x30, [sp, #0x60]
10565c408: 910183fd    	add	x29, sp, #0x60
10565c40c: aa0303f4    	mov	x20, x3
10565c410: aa0203f3    	mov	x19, x2
10565c414: aa0003f6    	mov	x22, x0
10565c418: f00d07a8    	adrp	x8, 0x11f753000 <dyld_stub_binder+0x11f753000>
10565c41c: 52800029    	mov	w9, #0x1                ; =1
10565c420: 39300909    	strb	w9, [x8, #0xc02]
10565c424: aa0203e0    	mov	x0, x2
10565c428: 94972e13    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10565c42c: 900cbb88    	adrp	x8, 0x11edcc000 <dyld_stub_binder+0x11edcc000>
10565c430: b9880508    	ldrsw	x8, [x8, #0x804] ; ivar: PlayingController.m_bPlaying offset=8
10565c434: 38686ac8    	ldrb	w8, [x22, x8]
10565c438: 36000808    	tbz	w8, #0x0, 0x10565c538 <_Flutter_MMFoundation_BindContext+0x18e3204>
10565c43c: 900cbb88    	adrp	x8, 0x11edcc000 <dyld_stub_binder+0x11edcc000>
10565c440: b988091a    	ldrsw	x26, [x8, #0x808] ; ivar: PlayingController.m_msgWrap offset=16
10565c444: f87a6ac0    	ldr	x0, [x22, x26]
10565c448: f00c9b88    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10565c44c: f9466d01    	ldr	x1, [x8, #0xcd8] ; selector: IsSameMsg:
10565c450: aa1303e2    	mov	x2, x19
10565c454: 94972e04    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c458: aa0003f9    	mov	x25, x0
10565c45c: d00cb5a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10565c460: f9430d15    	ldr	x21, [x8, #0x618]
10565c464: 900c9b88    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10565c468: f947e518    	ldr	x24, [x8, #0xfc8] ; selector: m_uiMesLocalID
10565c46c: aa1303e0    	mov	x0, x19
10565c470: aa1803e1    	mov	x1, x24
10565c474: 94972dfc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c478: aa0003f7    	mov	x23, x0
10565c47c: 36000899    	tbz	w25, #0x0, 0x10565c58c <_Flutter_MMFoundation_BindContext+0x18e3258>
10565c480: b00c9b68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565c484: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10565c488: 900be588    	adrp	x8, 0x11d30c000 <dyld_stub_binder+0x11d30c000>
10565c48c: 913ee108    	add	x8, x8, #0xfb8 ; CFString: msg:%u seek to time:%u
10565c490: a900d3f7    	stp	x23, x20, [sp, #0x8]
10565c494: f90003e8    	str	x8, [sp]
10565c498: f00a5f45    	adrp	x5, 0x11a247000 <dyld_stub_binder+0x11a247000>
10565c49c: 913600a5    	add	x5, x5, #0xd80
10565c4a0: f00a5f47    	adrp	x7, 0x11a247000 <dyld_stub_binder+0x11a247000>
10565c4a4: 91377ce7    	add	x7, x7, #0xddf
10565c4a8: aa1503e0    	mov	x0, x21
10565c4ac: 52800042    	mov	w2, #0x2                ; =2
10565c4b0: d2800003    	mov	x3, #0x0                ; =0
10565c4b4: 52800004    	mov	w4, #0x0                ; =0
10565c4b8: 52800f66    	mov	w6, #0x7b               ; =123
10565c4bc: 94972dea    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c4c0: d00cb5a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10565c4c4: f943c100    	ldr	x0, [x8, #0x780]
10565c4c8: b00c9b68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565c4cc: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
10565c4d0: 94972de5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c4d4: aa1d03fd    	mov	x29, x29
10565c4d8: 94972dea    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565c4dc: aa0003f5    	mov	x21, x0
10565c4e0: 900cb5c8    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
10565c4e4: f9401500    	ldr	x0, [x8, #0x28]
10565c4e8: d00cb248    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10565c4ec: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
10565c4f0: 94972ddd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c4f4: aa0003e2    	mov	x2, x0
10565c4f8: b00c9b68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565c4fc: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
10565c500: aa1503e0    	mov	x0, x21
10565c504: 94972dd8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c508: aa1d03fd    	mov	x29, x29
10565c50c: 94972ddd    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565c510: aa0003f6    	mov	x22, x0
10565c514: 900cb288    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
10565c518: f9428901    	ldr	x1, [x8, #0x510] ; selector: setProgress:
10565c51c: aa1403e2    	mov	x2, x20
10565c520: 94972dd1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c524: aa1603e0    	mov	x0, x22
10565c528: 94972dd2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c52c: aa1503e0    	mov	x0, x21
10565c530: 94972dd0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c534: 14000029    	b	0x10565c5d8 <_Flutter_MMFoundation_BindContext+0x18e32a4>
10565c538: d00cb5a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10565c53c: f9430d14    	ldr	x20, [x8, #0x618]
10565c540: 900c9b88    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10565c544: f947e501    	ldr	x1, [x8, #0xfc8] ; selector: m_uiMesLocalID
10565c548: aa1303e0    	mov	x0, x19
10565c54c: 94972dc6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c550: b00c9b68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565c554: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10565c558: 900be588    	adrp	x8, 0x11d30c000 <dyld_stub_binder+0x11d30c000>
10565c55c: 913de108    	add	x8, x8, #0xf78 ; CFString: msg:%u not plaing
10565c560: a90003e8    	stp	x8, x0, [sp]
10565c564: f00a5f45    	adrp	x5, 0x11a247000 <dyld_stub_binder+0x11a247000>
10565c568: 913600a5    	add	x5, x5, #0xd80
10565c56c: f00a5f47    	adrp	x7, 0x11a247000 <dyld_stub_binder+0x11a247000>
10565c570: 91377ce7    	add	x7, x7, #0xddf
10565c574: aa1403e0    	mov	x0, x20
10565c578: 52800082    	mov	w2, #0x4                ; =4
10565c57c: d2800003    	mov	x3, #0x0                ; =0
10565c580: 52800004    	mov	w4, #0x0                ; =0
10565c584: 52800e46    	mov	w6, #0x72               ; =114
10565c588: 14000013    	b	0x10565c5d4 <_Flutter_MMFoundation_BindContext+0x18e32a0>
10565c58c: f87a6ac0    	ldr	x0, [x22, x26]
10565c590: aa1803e1    	mov	x1, x24
10565c594: 94972db4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c598: b00c9b68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565c59c: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10565c5a0: a90083f7    	stp	x23, x0, [sp, #0x8]
10565c5a4: 900be588    	adrp	x8, 0x11d30c000 <dyld_stub_binder+0x11d30c000>
10565c5a8: 913e6108    	add	x8, x8, #0xf98 ; CFString: msg:%u seek but msg:%u is plaing
10565c5ac: f90003e8    	str	x8, [sp]
10565c5b0: f00a5f45    	adrp	x5, 0x11a247000 <dyld_stub_binder+0x11a247000>
10565c5b4: 913600a5    	add	x5, x5, #0xd80
10565c5b8: f00a5f47    	adrp	x7, 0x11a247000 <dyld_stub_binder+0x11a247000>
10565c5bc: 91377ce7    	add	x7, x7, #0xddf
10565c5c0: aa1503e0    	mov	x0, x21
10565c5c4: 52800082    	mov	w2, #0x4                ; =4
10565c5c8: d2800003    	mov	x3, #0x0                ; =0
10565c5cc: 52800004    	mov	w4, #0x0                ; =0
10565c5d0: 52800ee6    	mov	w6, #0x77               ; =119
10565c5d4: 94972da4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c5d8: aa1303e0    	mov	x0, x19
10565c5dc: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10565c5e0: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10565c5e4: a94457f6    	ldp	x22, x21, [sp, #0x40]
10565c5e8: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10565c5ec: a94267fa    	ldp	x26, x25, [sp, #0x20]
10565c5f0: 9101c3ff    	add	sp, sp, #0x70
10565c5f4: 14972d9f    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
