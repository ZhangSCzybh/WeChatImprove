
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101a2c408: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
101a2c40c: a9014ff4    	stp	x20, x19, [sp, #0x10]
101a2c410: a9027bfd    	stp	x29, x30, [sp, #0x20]
101a2c414: 910083fd    	add	x29, sp, #0x20
101a2c418: aa0203f3    	mov	x19, x2
101a2c41c: b00ee8c8    	adrp	x8, 0x11f745000 <dyld_stub_binder+0x11f745000>
101a2c420: 52800029    	mov	w9, #0x1                ; =1
101a2c424: 393c6d09    	strb	w9, [x8, #0xf1b]
101a2c428: aa0203e0    	mov	x0, x2
101a2c42c: 9587ee12    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101a2c430: b4000773    	cbz	x19, 0x101a2c51c <__text+0x1a2451c>
101a2c434: b00e9408    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
101a2c438: f9450115    	ldr	x21, [x8, #0xa00] ; selector: type
101a2c43c: aa1303e0    	mov	x0, x19
101a2c440: aa1503e1    	mov	x1, x21
101a2c444: 9587ee08    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2c448: aa0003f4    	mov	x20, x0
101a2c44c: aa1303e0    	mov	x0, x19
101a2c450: aa1503e1    	mov	x1, x21
101a2c454: 9587ee04    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2c458: 71003c1f    	cmp	w0, #0xf
101a2c45c: 5400010b    	b.lt	0x101a2c47c <__text+0x1a2447c>
101a2c460: aa1303e0    	mov	x0, x19
101a2c464: aa1503e1    	mov	x1, x21
101a2c468: 9587edff    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2c46c: 7100441f    	cmp	w0, #0x11
101a2c470: 5400006c    	b.gt	0x101a2c47c <__text+0x1a2447c>
101a2c474: 51000694    	sub	w20, w20, #0x1
101a2c478: 1400002b    	b	0x101a2c524 <__text+0x1a24524>
101a2c47c: aa1303e0    	mov	x0, x19
101a2c480: aa1503e1    	mov	x1, x21
101a2c484: 9587edf8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2c488: 7100381f    	cmp	w0, #0xe
101a2c48c: 54000061    	b.ne	0x101a2c498 <__text+0x1a24498>
101a2c490: 52800234    	mov	w20, #0x11              ; =17
101a2c494: 14000024    	b	0x101a2c524 <__text+0x1a24524>
101a2c498: aa1303e0    	mov	x0, x19
101a2c49c: aa1503e1    	mov	x1, x21
101a2c4a0: 9587edf1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2c4a4: 7100481f    	cmp	w0, #0x12
101a2c4a8: 54000061    	b.ne	0x101a2c4b4 <__text+0x1a244b4>
101a2c4ac: 528002b4    	mov	w20, #0x15              ; =21
101a2c4b0: 1400001d    	b	0x101a2c524 <__text+0x1a24524>
101a2c4b4: aa1303e0    	mov	x0, x19
101a2c4b8: aa1503e1    	mov	x1, x21
101a2c4bc: 9587edea    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2c4c0: 7100541f    	cmp	w0, #0x15
101a2c4c4: 54000061    	b.ne	0x101a2c4d0 <__text+0x1a244d0>
101a2c4c8: 528000f4    	mov	w20, #0x7               ; =7
101a2c4cc: 14000016    	b	0x101a2c524 <__text+0x1a24524>
101a2c4d0: aa1303e0    	mov	x0, x19
101a2c4d4: aa1503e1    	mov	x1, x21
101a2c4d8: 9587ede3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2c4dc: 7100501f    	cmp	w0, #0x14
101a2c4e0: 54000061    	b.ne	0x101a2c4ec <__text+0x1a244ec>
101a2c4e4: 528002d4    	mov	w20, #0x16              ; =22
101a2c4e8: 1400000f    	b	0x101a2c524 <__text+0x1a24524>
101a2c4ec: aa1303e0    	mov	x0, x19
101a2c4f0: aa1503e1    	mov	x1, x21
101a2c4f4: 9587eddc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2c4f8: 7100881f    	cmp	w0, #0x22
101a2c4fc: 54000061    	b.ne	0x101a2c508 <__text+0x1a24508>
101a2c500: 528000b4    	mov	w20, #0x5               ; =5
101a2c504: 14000008    	b	0x101a2c524 <__text+0x1a24524>
101a2c508: aa1303e0    	mov	x0, x19
101a2c50c: aa1503e1    	mov	x1, x21
101a2c510: 9587edd5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2c514: 7100541f    	cmp	w0, #0x15
101a2c518: 5400006d    	b.le	0x101a2c524 <__text+0x1a24524>
101a2c51c: 52800014    	mov	w20, #0x0               ; =0
101a2c520: 1400000e    	b	0x101a2c558 <__text+0x1a24558>
101a2c524: 51000688    	sub	w8, w20, #0x1
101a2c528: 52800029    	mov	w9, #0x1                ; =1
101a2c52c: 1ac82134    	lsl	w20, w9, w8
101a2c530: b00e80c8    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a2c534: f9430501    	ldr	x1, [x8, #0x608] ; selector: isRecordItem
101a2c538: aa1303e0    	mov	x0, x19
101a2c53c: 9587edca    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2c540: 340000c0    	cbz	w0, 0x101a2c558 <__text+0x1a24558>
101a2c544: b00e8088    	adrp	x8, 0x11ea3d000 <dyld_stub_binder+0x11ea3d000>
101a2c548: f9458d01    	ldr	x1, [x8, #0xb18] ; selector: searchSubTypes
101a2c54c: aa1303e0    	mov	x0, x19
101a2c550: 9587edc5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a2c554: 2a140014    	orr	w20, w0, w20
101a2c558: aa1303e0    	mov	x0, x19
101a2c55c: 9587edc5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a2c560: aa1403e0    	mov	x0, x20
101a2c564: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101a2c568: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101a2c56c: a8c357f6    	ldp	x22, x21, [sp], #0x30
101a2c570: d65f03c0    	ret
