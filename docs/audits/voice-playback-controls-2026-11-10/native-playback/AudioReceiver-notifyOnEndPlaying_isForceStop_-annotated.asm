
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10017746c: d10203ff    	sub	sp, sp, #0x80
100177470: a9045ff8    	stp	x24, x23, [sp, #0x40]
100177474: a90557f6    	stp	x22, x21, [sp, #0x50]
100177478: a9064ff4    	stp	x20, x19, [sp, #0x60]
10017747c: a9077bfd    	stp	x29, x30, [sp, #0x70]
100177480: 9101c3fd    	add	x29, sp, #0x70
100177484: aa0303f5    	mov	x21, x3
100177488: aa0203f3    	mov	x19, x2
10017748c: aa0003f4    	mov	x20, x0
100177490: b00fae48    	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
100177494: 52800029    	mov	w9, #0x1                ; =1
100177498: 39118509    	strb	w9, [x8, #0x461]
10017749c: aa0203e0    	mov	x0, x2
1001774a0: 95eac1f5    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1001774a4: f00f5cc8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1001774a8: f943c100    	ldr	x0, [x8, #0x780]
1001774ac: d00f4288    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1001774b0: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
1001774b4: 95eac1ec    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1001774b8: aa1d03fd    	mov	x29, x29
1001774bc: 95eac1f1    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1001774c0: aa0003f6    	mov	x22, x0
1001774c4: 900f5cc8    	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
1001774c8: f9432d17    	ldr	x23, [x8, #0x658]
1001774cc: 900f42e8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
1001774d0: f9454518    	ldr	x24, [x8, #0xa88] ; selector: OnEndPlaying:isForceStop:
1001774d4: b00eaea8    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1001774d8: f9449908    	ldr	x8, [x8, #0x930]
1001774dc: f9000be8    	str	x8, [sp, #0x10]
1001774e0: 900bba88    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
1001774e4: fd434100    	ldr	d0, [x8, #0x680] ; constant double=1.6080749353e-314
1001774e8: fd000fe0    	str	d0, [sp, #0x18]
1001774ec: 90000008    	adrp	x8, 0x100177000 <__text+0x16f000>
1001774f0: 9116d108    	add	x8, x8, #0x5b4
1001774f4: d00e0849    	adrp	x9, 0x11c281000 <dyld_stub_binder+0x11c281000>
1001774f8: 912ba129    	add	x9, x9, #0xae8
1001774fc: a90227e8    	stp	x8, x9, [sp, #0x20]
100177500: f9001bf3    	str	x19, [sp, #0x30]
100177504: 3900e3f5    	strb	w21, [sp, #0x38]
100177508: d00f4288    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10017750c: f9472d15    	ldr	x21, [x8, #0xe58] ; selector: callExtension:selector:block:
100177510: aa1303e0    	mov	x0, x19
100177514: 95eac1d8    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100177518: 910043e4    	add	x4, sp, #0x10
10017751c: aa1603e0    	mov	x0, x22
100177520: aa1503e1    	mov	x1, x21
100177524: aa1703e2    	mov	x2, x23
100177528: aa1803e3    	mov	x3, x24
10017752c: 95eac1ce    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177530: aa1603e0    	mov	x0, x22
100177534: 95eac1cf    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100177538: f9401be0    	ldr	x0, [sp, #0x30]
10017753c: 95eac1cd    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100177540: 900f42e8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
100177544: f9452d01    	ldr	x1, [x8, #0xa58] ; selector: getCurrentTimeMs
100177548: aa1403e0    	mov	x0, x20
10017754c: 95eac1c6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177550: f00f5cc8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100177554: f9430d08    	ldr	x8, [x8, #0x618]
100177558: d00f4289    	adrp	x9, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10017755c: f9418921    	ldr	x1, [x9, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
100177560: f00e71a9    	adrp	x9, 0x11cfae000 <dyld_stub_binder+0x11cfae000>
100177564: 91326129    	add	x9, x9, #0xc98 ; CFString: on audio play end with position:%d
100177568: a90003e9    	stp	x9, x0, [sp]
10017756c: b00cd185    	adrp	x5, 0x119ba8000 <dyld_stub_binder+0x119ba8000>
100177570: 910924a5    	add	x5, x5, #0x249
100177574: b00cd187    	adrp	x7, 0x119ba8000 <dyld_stub_binder+0x119ba8000>
100177578: 910dd0e7    	add	x7, x7, #0x374
10017757c: aa0803e0    	mov	x0, x8
100177580: 52800042    	mov	w2, #0x2                ; =2
100177584: d2800003    	mov	x3, #0x0                ; =0
100177588: 52800004    	mov	w4, #0x0                ; =0
10017758c: 52801766    	mov	w6, #0xbb               ; =187
100177590: 95eac1b5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177594: aa1303e0    	mov	x0, x19
100177598: 95eac1b6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10017759c: a9477bfd    	ldp	x29, x30, [sp, #0x70]
1001775a0: a9464ff4    	ldp	x20, x19, [sp, #0x60]
1001775a4: a94557f6    	ldp	x22, x21, [sp, #0x50]
1001775a8: a9445ff8    	ldp	x24, x23, [sp, #0x40]
1001775ac: 910203ff    	add	sp, sp, #0x80
1001775b0: d65f03c0    	ret
1001775b4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1001775b8: a9014ff4    	stp	x20, x19, [sp, #0x10]
1001775bc: a9027bfd    	stp	x29, x30, [sp, #0x20]
1001775c0: 910083fd    	add	x29, sp, #0x20
1001775c4: aa0103f3    	mov	x19, x1
1001775c8: aa0003f4    	mov	x20, x0
1001775cc: f9401015    	ldr	x21, [x0, #0x20]
1001775d0: b00f42c8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
1001775d4: f9433116    	ldr	x22, [x8, #0x660] ; selector: msgWrap
1001775d8: aa0103e0    	mov	x0, x1
1001775dc: 95eac1a6    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1001775e0: aa1503e0    	mov	x0, x21
1001775e4: aa1603e1    	mov	x1, x22
1001775e8: 95eac19f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1001775ec: aa1d03fd    	mov	x29, x29
1001775f0: 95eac1a4    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1001775f4: aa0003f5    	mov	x21, x0
1001775f8: 3940a283    	ldrb	w3, [x20, #0x28]
1001775fc: 900f42e8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
100177600: f9454501    	ldr	x1, [x8, #0xa88] ; selector: OnEndPlaying:isForceStop:
100177604: aa1303e0    	mov	x0, x19
100177608: aa1503e2    	mov	x2, x21
10017760c: 95eac196    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177610: aa1303e0    	mov	x0, x19
100177614: 95eac197    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100177618: aa1503e0    	mov	x0, x21
10017761c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100177620: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100177624: a8c357f6    	ldp	x22, x21, [sp], #0x30
100177628: 15eac192    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
