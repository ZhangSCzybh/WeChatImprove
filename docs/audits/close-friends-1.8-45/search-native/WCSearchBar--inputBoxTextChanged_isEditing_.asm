
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109ddb46c: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
109ddb470: a9015ff8    	stp	x24, x23, [sp, #0x10]
109ddb474: a90257f6    	stp	x22, x21, [sp, #0x20]
109ddb478: a9034ff4    	stp	x20, x19, [sp, #0x30]
109ddb47c: a9047bfd    	stp	x29, x30, [sp, #0x40]
109ddb480: 910103fd    	add	x29, sp, #0x40
109ddb484: aa0303f6    	mov	x22, x3
109ddb488: aa0203f3    	mov	x19, x2
109ddb48c: aa0003f4    	mov	x20, x0
109ddb490: b00b73a8    	adrp	x8, 0x120c50000 <dyld_stub_binder+0x120c50000>
109ddb494: 52800029    	mov	w9, #0x1                ; =1
109ddb498: 3926fd09    	strb	w9, [x8, #0x9bf]
109ddb49c: aa0203e0    	mov	x0, x2
109ddb4a0: 9569ffe8    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
109ddb4a4: 900b1948    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
109ddb4a8: f946e915    	ldr	x21, [x8, #0xdd0] ; length
109ddb4ac: aa1303e0    	mov	x0, x19
109ddb4b0: aa1503e1    	mov	x1, x21
109ddb4b4: 9569ffe4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb4b8: f100001f    	cmp	x0, #0x0
109ddb4bc: 1a9f07f7    	cset	w23, ne
109ddb4c0: d00b0568    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
109ddb4c4: f9453501    	ldr	x1, [x8, #0xa68] ; placeHolderLabel
109ddb4c8: aa1403e0    	mov	x0, x20
109ddb4cc: 9569ffde    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb4d0: aa1d03fd    	mov	x29, x29
109ddb4d4: 9569ffdf    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb4d8: aa0003f9    	mov	x25, x0
109ddb4dc: b00b1968    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
109ddb4e0: f9411118    	ldr	x24, [x8, #0x220] ; setHidden:
109ddb4e4: aa1803e1    	mov	x1, x24
109ddb4e8: aa1703e2    	mov	x2, x23
109ddb4ec: 9569ffd6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb4f0: aa1903e0    	mov	x0, x25
109ddb4f4: 9569ffda    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb4f8: 34000176    	cbz	w22, 0x109ddb524 <_Flutter_MMFoundation_BindContext+0x62b7108>
109ddb4fc: aa1303e0    	mov	x0, x19
109ddb500: aa1503e1    	mov	x1, x21
109ddb504: 9569ffd0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb508: f100001f    	cmp	x0, #0x0
109ddb50c: 1a9f17e2    	cset	w2, eq
109ddb510: d00b24a8    	adrp	x8, 0x120271000 <dyld_stub_binder+0x120271000>
109ddb514: b9871d08    	ldrsw	x8, [x8, #0x71c]
109ddb518: f8686a80    	ldr	x0, [x20, x8]
109ddb51c: aa1803e1    	mov	x1, x24
109ddb520: 9569ffc9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb524: d00b07a8    	adrp	x8, 0x11fed1000 <dyld_stub_binder+0x11fed1000>
109ddb528: f945c517    	ldr	x23, [x8, #0xb88] ; clearButtonMode
109ddb52c: aa1403e0    	mov	x0, x20
109ddb530: aa1703e1    	mov	x1, x23
109ddb534: 9569ffc4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb538: f100081f    	cmp	x0, #0x2
109ddb53c: 54000281    	b.ne	0x109ddb58c <_Flutter_MMFoundation_BindContext+0x62b7170>
109ddb540: aa1303e0    	mov	x0, x19
109ddb544: aa1503e1    	mov	x1, x21
109ddb548: 9569ffbf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb54c: f100001f    	cmp	x0, #0x0
109ddb550: 1a9f17f9    	cset	w25, eq
109ddb554: f00b0468    	adrp	x8, 0x11fe6a000 <dyld_stub_binder+0x11fe6a000>
109ddb558: f944f117    	ldr	x23, [x8, #0x9e0] ; clearButton
109ddb55c: aa1403e0    	mov	x0, x20
109ddb560: aa1703e1    	mov	x1, x23
109ddb564: 9569ffb8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb568: aa1d03fd    	mov	x29, x29
109ddb56c: 9569ffb9    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb570: aa0003fa    	mov	x26, x0
109ddb574: aa1803e1    	mov	x1, x24
109ddb578: aa1903e2    	mov	x2, x25
109ddb57c: 9569ffb2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb580: aa1a03e0    	mov	x0, x26
109ddb584: 9569ffb6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb588: 14000019    	b	0x109ddb5ec <_Flutter_MMFoundation_BindContext+0x62b71d0>
109ddb58c: aa1403e0    	mov	x0, x20
109ddb590: aa1703e1    	mov	x1, x23
109ddb594: 9569ffac    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb598: f100041f    	cmp	x0, #0x1
109ddb59c: 54000241    	b.ne	0x109ddb5e4 <_Flutter_MMFoundation_BindContext+0x62b71c8>
109ddb5a0: aa1303e0    	mov	x0, x19
109ddb5a4: aa1503e1    	mov	x1, x21
109ddb5a8: 9569ffa7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb5ac: f00b0468    	adrp	x8, 0x11fe6a000 <dyld_stub_binder+0x11fe6a000>
109ddb5b0: f944f117    	ldr	x23, [x8, #0x9e0] ; clearButton
109ddb5b4: b50001c0    	cbnz	x0, 0x109ddb5ec <_Flutter_MMFoundation_BindContext+0x62b71d0>
109ddb5b8: aa1403e0    	mov	x0, x20
109ddb5bc: aa1703e1    	mov	x1, x23
109ddb5c0: 9569ffa1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb5c4: aa1d03fd    	mov	x29, x29
109ddb5c8: 9569ffa2    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb5cc: aa0003f9    	mov	x25, x0
109ddb5d0: aa1803e1    	mov	x1, x24
109ddb5d4: 52800022    	mov	w2, #0x1                ; =1
109ddb5d8: 9569ff9b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb5dc: aa1903e0    	mov	x0, x25
109ddb5e0: 17ffffe9    	b	0x109ddb584 <_Flutter_MMFoundation_BindContext+0x62b7168>
109ddb5e4: f00b0468    	adrp	x8, 0x11fe6a000 <dyld_stub_binder+0x11fe6a000>
109ddb5e8: f944f117    	ldr	x23, [x8, #0x9e0] ; clearButton
109ddb5ec: aa1403e0    	mov	x0, x20
109ddb5f0: aa1703e1    	mov	x1, x23
109ddb5f4: 9569ff94    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb5f8: aa1d03fd    	mov	x29, x29
109ddb5fc: 9569ff95    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb600: aa0003f8    	mov	x24, x0
109ddb604: 900b1948    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
109ddb608: f943f919    	ldr	x25, [x8, #0x7f0] ; isHidden
109ddb60c: aa1903e1    	mov	x1, x25
109ddb610: 9569ff8d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb614: 2a160008    	orr	w8, w0, w22
109ddb618: d00b15a9    	adrp	x9, 0x120091000 <dyld_stub_binder+0x120091000>
109ddb61c: f9413921    	ldr	x1, [x9, #0x270] ; showClearButtonSpace:
109ddb620: 52000102    	eor	w2, w8, #0x1
109ddb624: aa1403e0    	mov	x0, x20
109ddb628: 9569ff87    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb62c: aa1803e0    	mov	x0, x24
109ddb630: 9569ff8b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb634: aa1403e0    	mov	x0, x20
109ddb638: aa1703e1    	mov	x1, x23
109ddb63c: 9569ff82    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb640: aa1d03fd    	mov	x29, x29
109ddb644: 9569ff83    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb648: aa0003f6    	mov	x22, x0
109ddb64c: aa1903e1    	mov	x1, x25
109ddb650: 9569ff7d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb654: aa0003f8    	mov	x24, x0
109ddb658: aa1603e0    	mov	x0, x22
109ddb65c: 9569ff80    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb660: aa1403e0    	mov	x0, x20
109ddb664: aa1703e1    	mov	x1, x23
109ddb668: 9569ff77    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb66c: aa1d03fd    	mov	x29, x29
109ddb670: 9569ff78    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb674: aa0003f6    	mov	x22, x0
109ddb678: b00b1968    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
109ddb67c: f942f501    	ldr	x1, [x8, #0x5e8] ; setIsAccessibilityElement:
109ddb680: 52000302    	eor	w2, w24, #0x1
109ddb684: 9569ff70    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb688: aa1603e0    	mov	x0, x22
109ddb68c: 9569ff74    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb690: aa1303e0    	mov	x0, x19
109ddb694: aa1503e1    	mov	x1, x21
109ddb698: 9569ff6b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb69c: aa0003f5    	mov	x21, x0
109ddb6a0: f100001f    	cmp	x0, #0x0
109ddb6a4: 1a9f07f7    	cset	w23, ne
109ddb6a8: d00b24a8    	adrp	x8, 0x120271000 <dyld_stub_binder+0x120271000>
109ddb6ac: b9873916    	ldrsw	x22, [x8, #0x738]
109ddb6b0: f8766a80    	ldr	x0, [x20, x22]
109ddb6b4: d00b15a8    	adrp	x8, 0x120091000 <dyld_stub_binder+0x120091000>
109ddb6b8: f9413d01    	ldr	x1, [x8, #0x278] ; hideStartButton
109ddb6bc: 9569ff62    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb6c0: 6b0002ff    	cmp	w23, w0
109ddb6c4: 540000e0    	b.eq	0x109ddb6e0 <_Flutter_MMFoundation_BindContext+0x62b72c4>
109ddb6c8: f10002bf    	cmp	x21, #0x0
109ddb6cc: 1a9f07e2    	cset	w2, ne
109ddb6d0: f8766a80    	ldr	x0, [x20, x22]
109ddb6d4: d00b15a8    	adrp	x8, 0x120091000 <dyld_stub_binder+0x120091000>
109ddb6d8: f9414101    	ldr	x1, [x8, #0x280] ; setHideStartButton:
109ddb6dc: 9569ff5a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb6e0: aa1303e0    	mov	x0, x19
109ddb6e4: a9447bfd    	ldp	x29, x30, [sp, #0x40]
109ddb6e8: a9434ff4    	ldp	x20, x19, [sp, #0x30]
109ddb6ec: a94257f6    	ldp	x22, x21, [sp, #0x20]
109ddb6f0: a9415ff8    	ldp	x24, x23, [sp, #0x10]
109ddb6f4: a8c567fa    	ldp	x26, x25, [sp], #0x50
109ddb6f8: 1569ff59    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
