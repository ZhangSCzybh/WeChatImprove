
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104727894: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104727898: a9014ff4    	stp	x20, x19, [sp, #0x10]
10472789c: a9027bfd    	stp	x29, x30, [sp, #0x20]
1047278a0: 910083fd    	add	x29, sp, #0x20
1047278a4: aa0203f3    	mov	x19, x2
1047278a8: aa0003f4    	mov	x20, x0
1047278ac: d00e28a8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
1047278b0: 52800029    	mov	w9, #0x1                ; =1
1047278b4: 391a2109    	strb	w9, [x8, #0x688]
1047278b8: aa0203e0    	mov	x0, x2
1047278bc: 94d3fe1f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1047278c0: 900dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
1047278c4: b98a1d16    	ldrsw	x22, [x8, #0xa1c]
1047278c8: f8766a80    	ldr	x0, [x20, x22]
1047278cc: f00dcf08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1047278d0: f9475d01    	ldr	x1, [x8, #0xeb8] ; selector superview
1047278d4: 94d3fe1a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047278d8: aa1d03fd    	mov	x29, x29
1047278dc: 94d3fe1b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047278e0: aa0003f5    	mov	x21, x0
1047278e4: 94d3fe1c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047278e8: b40000b5    	cbz	x21, 0x1047278fc <_Flutter_MMFoundation_BindContext+0xc034e0>
1047278ec: f8766a80    	ldr	x0, [x20, x22]
1047278f0: f00dcee8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1047278f4: f940f901    	ldr	x1, [x8, #0x1f0] ; selector removeFromSuperview
1047278f8: 94d3fe11    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047278fc: f8766a95    	ldr	x21, [x20, x22]
104727900: f8366a93    	str	x19, [x20, x22]
104727904: aa1303e0    	mov	x0, x19
104727908: 94d3fe0c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10472790c: aa1503e0    	mov	x0, x21
104727910: 94d3fe11    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104727914: 900dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
104727918: b98a2108    	ldrsw	x8, [x8, #0xa20]
10472791c: 38686a82    	ldrb	w2, [x20, x8]
104727920: d00dcf08    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104727924: f9444d01    	ldr	x1, [x8, #0x898] ; selector setSelected:
104727928: aa1303e0    	mov	x0, x19
10472792c: 94d3fe04    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727930: d00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104727934: f9466d01    	ldr	x1, [x8, #0xcd8] ; selector relayoutIconAndBadge
104727938: aa1403e0    	mov	x0, x20
10472793c: 94d3fe00    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727940: aa1303e0    	mov	x0, x19
104727944: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104727948: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10472794c: a8c357f6    	ldp	x22, x21, [sp], #0x30
104727950: 14d3fe01    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
