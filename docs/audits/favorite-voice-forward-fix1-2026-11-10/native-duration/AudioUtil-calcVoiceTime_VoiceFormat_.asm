
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1001834b4: 7100047f    	cmp	w3, #0x1
1001834b8: 54000100    	b.eq	0x1001834d8 <__text+0x17b4d8>
1001834bc: 350001c3    	cbnz	w3, 0x1001834f4 <__text+0x17b4f4>
1001834c0: 53017c48    	lsr	w8, w2, #1
1001834c4: 52849269    	mov	w9, #0x2493             ; =9363
1001834c8: 72b24929    	movk	w9, #0x9249, lsl #16
1001834cc: 9ba97d08    	umull	x8, w8, w9
1001834d0: d362fd08    	lsr	x8, x8, #34
1001834d4: 14000005    	b	0x1001834e8 <__text+0x17b4e8>
1001834d8: 52911128    	mov	w8, #0x8889             ; =34953
1001834dc: 72b11108    	movk	w8, #0x8888, lsl #16
1001834e0: 9ba87c48    	umull	x8, w2, w8
1001834e4: d365fd08    	lsr	x8, x8, #37
1001834e8: 0b080908    	add	w8, w8, w8, lsl #2
1001834ec: 531e7500    	lsl	w0, w8, #2
1001834f0: d65f03c0    	ret
1001834f4: d10103ff    	sub	sp, sp, #0x40
1001834f8: a90157f6    	stp	x22, x21, [sp, #0x10]
1001834fc: a9024ff4    	stp	x20, x19, [sp, #0x20]
100183500: a9037bfd    	stp	x29, x30, [sp, #0x30]
100183504: 9100c3fd    	add	x29, sp, #0x30
100183508: 900f5c88    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
10018350c: f946e900    	ldr	x0, [x8, #0xdd0]
100183510: f00f4268    	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
100183514: f944cd01    	ldr	x1, [x8, #0x998] ; selector: logWithLevel:module:file:line:func:printXLog:format:
100183518: 900e7168    	adrp	x8, 0x11cfaf000 <dyld_stub_binder+0x11cfaf000>
10018351c: 9123e108    	add	x8, x8, #0x8f8
100183520: f90003e8    	str	x8, [sp]
100183524: b00cd103    	adrp	x3, 0x119ba4000 <dyld_stub_binder+0x119ba4000>
100183528: 912dfc63    	add	x3, x3, #0xb7f
10018352c: d00cd124    	adrp	x4, 0x119ba9000 <dyld_stub_binder+0x119ba9000>
100183530: 9120bc84    	add	x4, x4, #0x82f
100183534: d00cd126    	adrp	x6, 0x119ba9000 <dyld_stub_binder+0x119ba9000>
100183538: 9120f0c6    	add	x6, x6, #0x83c
10018353c: 528000e2    	mov	w2, #0x7                ; =7
100183540: 52800365    	mov	w5, #0x1b               ; =27
100183544: 52800027    	mov	w7, #0x1                ; =1
100183548: 95ea91c7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10018354c: f00f5c68    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100183550: f943c100    	ldr	x0, [x8, #0x780]
100183554: d00f4228    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100183558: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
10018355c: 95ea91c2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100183560: aa1d03fd    	mov	x29, x29
100183564: 95ea91c7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100183568: aa0003f3    	mov	x19, x0
10018356c: 900f5c88    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
100183570: f9464d00    	ldr	x0, [x8, #0xc98]
100183574: f00f5908    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100183578: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
10018357c: 95ea91ba    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100183580: aa0003e2    	mov	x2, x0
100183584: d00f4228    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100183588: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
10018358c: aa1303e0    	mov	x0, x19
100183590: 95ea91b5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100183594: aa1d03fd    	mov	x29, x29
100183598: 95ea91ba    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10018359c: aa0003f4    	mov	x20, x0
1001835a0: b00f4288    	adrp	x8, 0x11e9d4000 <dyld_stub_binder+0x11e9d4000>
1001835a4: f940a501    	ldr	x1, [x8, #0x148] ; selector: currentAudioDuration
1001835a8: 95ea91af    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1001835ac: aa0003f5    	mov	x21, x0
1001835b0: aa1403e0    	mov	x0, x20
1001835b4: 95ea91af    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1001835b8: aa1303e0    	mov	x0, x19
1001835bc: 95ea91ad    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1001835c0: aa1503e0    	mov	x0, x21
1001835c4: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1001835c8: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1001835cc: a94157f6    	ldp	x22, x21, [sp, #0x10]
1001835d0: 910103ff    	add	sp, sp, #0x40
1001835d4: d65f03c0    	ret
