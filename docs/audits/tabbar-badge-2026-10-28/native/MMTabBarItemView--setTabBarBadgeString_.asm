
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1047274b8: d101c3ff    	sub	sp, sp, #0x70
1047274bc: a90267fa    	stp	x26, x25, [sp, #0x20]
1047274c0: a9035ff8    	stp	x24, x23, [sp, #0x30]
1047274c4: a90457f6    	stp	x22, x21, [sp, #0x40]
1047274c8: a9054ff4    	stp	x20, x19, [sp, #0x50]
1047274cc: a9067bfd    	stp	x29, x30, [sp, #0x60]
1047274d0: 910183fd    	add	x29, sp, #0x60
1047274d4: aa0203f3    	mov	x19, x2
1047274d8: aa0003f4    	mov	x20, x0
1047274dc: d00e28a8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
1047274e0: 52800029    	mov	w9, #0x1                ; =1
1047274e4: 391a1909    	strb	w9, [x8, #0x686]
1047274e8: aa0203e0    	mov	x0, x2
1047274ec: 94d3ff13    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1047274f0: 900dd278    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
1047274f4: f9453717    	ldr	x23, [x24, #0xa68] ; class iConsole
1047274f8: 900dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
1047274fc: b98a0919    	ldrsw	x25, [x8, #0xa08]
104727500: f8796a80    	ldr	x0, [x20, x25]
104727504: f00dcec8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104727508: f945f516    	ldr	x22, [x8, #0xbe8] ; selector index
10472750c: aa1603e1    	mov	x1, x22
104727510: 94d3ff0b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727514: d00db888    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104727518: f942a915    	ldr	x21, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
10472751c: a90083f3    	stp	x19, x0, [sp, #0x8]
104727520: 900d0228    	adrp	x8, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
104727524: 9111a108    	add	x8, x8, #0x468 ; CFString 'set badge string %@ for index %ld'
104727528: f90003e8    	str	x8, [sp]
10472752c: b00b8385    	adrp	x5, 0x11b798000 <dyld_stub_binder+0x11b798000>
104727530: 913feca5    	add	x5, x5, #0xffb ; string 'MMTabBarItemView.mm'
104727534: d00b8387    	adrp	x7, 0x11b799000 <dyld_stub_binder+0x11b799000>
104727538: 910210e7    	add	x7, x7, #0x84 ; string '-[MMTabBarItemView setTabBarBadgeString:]'
10472753c: aa1703e0    	mov	x0, x23
104727540: aa1503e1    	mov	x1, x21
104727544: 52800042    	mov	w2, #0x2                ; =2
104727548: d2800003    	mov	x3, #0x0                ; =0
10472754c: 52800004    	mov	w4, #0x0                ; =0
104727550: 52800be6    	mov	w6, #0x5f               ; =95
104727554: 94d3fefa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727558: 900dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
10472755c: b98a191a    	ldrsw	x26, [x8, #0xa18]
104727560: f87a6a88    	ldr	x8, [x20, x26]
104727564: eb13011f    	cmp	x8, x19
104727568: 54000280    	b.eq	0x1047275b8 <_Flutter_MMFoundation_BindContext+0xc0319c>
10472756c: f9453717    	ldr	x23, [x24, #0xa68] ; class iConsole
104727570: f8796a80    	ldr	x0, [x20, x25]
104727574: aa1603e1    	mov	x1, x22
104727578: 94d3fef1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472757c: a90083f3    	stp	x19, x0, [sp, #0x8]
104727580: 900d0228    	adrp	x8, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
104727584: 91122108    	add	x8, x8, #0x488 ; CFString 'TRDTemp set badge string %@ for index %ld'
104727588: f90003e8    	str	x8, [sp]
10472758c: b00b8385    	adrp	x5, 0x11b798000 <dyld_stub_binder+0x11b798000>
104727590: 913feca5    	add	x5, x5, #0xffb ; string 'MMTabBarItemView.mm'
104727594: d00b8387    	adrp	x7, 0x11b799000 <dyld_stub_binder+0x11b799000>
104727598: 910210e7    	add	x7, x7, #0x84 ; string '-[MMTabBarItemView setTabBarBadgeString:]'
10472759c: aa1703e0    	mov	x0, x23
1047275a0: aa1503e1    	mov	x1, x21
1047275a4: 52800042    	mov	w2, #0x2                ; =2
1047275a8: d2800003    	mov	x3, #0x0                ; =0
1047275ac: 52800004    	mov	w4, #0x0                ; =0
1047275b0: 52800c26    	mov	w6, #0x61               ; =97
1047275b4: 94d3fee2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047275b8: 8b1a0280    	add	x0, x20, x26
1047275bc: aa1303e1    	mov	x1, x19
1047275c0: 94d3fee0    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
1047275c4: 900dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
1047275c8: b98a1508    	ldrsw	x8, [x8, #0xa14]
1047275cc: f8286a9f    	str	xzr, [x20, x8]
1047275d0: 900dcee8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1047275d4: f946e901    	ldr	x1, [x8, #0xdd0] ; selector length
1047275d8: aa1303e0    	mov	x0, x19
1047275dc: 94d3fed8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047275e0: aa0003e8    	mov	x8, x0
1047275e4: 900dd7c9    	adrp	x9, 0x12021f000 <dyld_stub_binder+0x12021f000>
1047275e8: b98a1135    	ldrsw	x21, [x9, #0xa10]
1047275ec: f8756a80    	ldr	x0, [x20, x21]
1047275f0: b00dcf09    	adrp	x9, 0x120108000 <dyld_stub_binder+0x120108000>
1047275f4: f9411121    	ldr	x1, [x9, #0x220] ; selector setHidden:
1047275f8: b4000328    	cbz	x8, 0x10472765c <_Flutter_MMFoundation_BindContext+0xc03240>
1047275fc: 52800002    	mov	w2, #0x0                ; =0
104727600: 94d3fecf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727604: f8756a80    	ldr	x0, [x20, x21]
104727608: d00dcf08    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
10472760c: f945ed01    	ldr	x1, [x8, #0xbd8] ; selector setString:
104727610: aa1303e2    	mov	x2, x19
104727614: 94d3feca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727618: f8756a80    	ldr	x0, [x20, x21]
10472761c: 900db9e8    	adrp	x8, 0x11fe63000 <dyld_stub_binder+0x11fe63000>
104727620: f940dd01    	ldr	x1, [x8, #0x1b8] ; selector dr_setViewParam
104727624: 94d3fec6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727628: aa1d03fd    	mov	x29, x29
10472762c: 94d3fec7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104727630: aa0003f5    	mov	x21, x0
104727634: f9400808    	ldr	x8, [x0, #0x10]
104727638: b00cf4c1    	adrp	x1, 0x11e5c0000 <dyld_stub_binder+0x11e5c0000>
10472763c: 9123a021    	add	x1, x1, #0x8e8 ; CFString 'red_dot_content'
104727640: aa1303e2    	mov	x2, x19
104727644: d63f0100    	blr	x8
104727648: aa1d03fd    	mov	x29, x29
10472764c: 94d3fec6    	bl	0x107c27164 <_Flutter_MMFoundation_BindContext+0x4102d48>
104727650: aa1503e0    	mov	x0, x21
104727654: 94d3fec0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104727658: 14000003    	b	0x104727664 <_Flutter_MMFoundation_BindContext+0xc03248>
10472765c: 52800022    	mov	w2, #0x1                ; =1
104727660: 94d3feb7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727664: d00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104727668: f9466d01    	ldr	x1, [x8, #0xcd8] ; selector relayoutIconAndBadge
10472766c: aa1403e0    	mov	x0, x20
104727670: 94d3feb3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727674: aa1303e0    	mov	x0, x19
104727678: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10472767c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
104727680: a94457f6    	ldp	x22, x21, [sp, #0x40]
104727684: a9435ff8    	ldp	x24, x23, [sp, #0x30]
104727688: a94267fa    	ldp	x26, x25, [sp, #0x20]
10472768c: 9101c3ff    	add	sp, sp, #0x70
104727690: 14d3feb1    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
