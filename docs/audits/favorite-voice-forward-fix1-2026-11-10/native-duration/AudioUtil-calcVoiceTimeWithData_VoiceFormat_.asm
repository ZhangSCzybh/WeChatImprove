
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1001835d8: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1001835dc: a9014ff4    	stp	x20, x19, [sp, #0x10]
1001835e0: a9027bfd    	stp	x29, x30, [sp, #0x20]
1001835e4: 910083fd    	add	x29, sp, #0x20
1001835e8: aa0303f5    	mov	x21, x3
1001835ec: aa0203f3    	mov	x19, x2
1001835f0: aa0203e0    	mov	x0, x2
1001835f4: 95ea91a0    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1001835f8: 52800014    	mov	w20, #0x0               ; =0
1001835fc: 71000ebf    	cmp	w21, #0x3
100183600: 540001ac    	b.gt	0x100183634 <__text+0x17b634>
100183604: 34000275    	cbz	w21, 0x100183650 <__text+0x17b650>
100183608: 710006bf    	cmp	w21, #0x1
10018360c: 54000481    	b.ne	0x10018369c <__text+0x17b69c>
100183610: b00f5928    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
100183614: f9467501    	ldr	x1, [x8, #0xce8] ; selector: length
100183618: aa1303e0    	mov	x0, x19
10018361c: 95ea9192    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100183620: 52911128    	mov	w8, #0x8889             ; =34953
100183624: 72b11108    	movk	w8, #0x8888, lsl #16
100183628: 9ba87c08    	umull	x8, w0, w8
10018362c: d365fd08    	lsr	x8, x8, #37
100183630: 14000011    	b	0x100183674 <__text+0x17b674>
100183634: 710012bf    	cmp	w21, #0x4
100183638: 54000240    	b.eq	0x100183680 <__text+0x17b680>
10018363c: 71001ebf    	cmp	w21, #0x7
100183640: 540002e1    	b.ne	0x10018369c <__text+0x17b69c>
100183644: b00f5c88    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
100183648: f9405d00    	ldr	x0, [x8, #0xb8]
10018364c: 1400000f    	b	0x100183688 <__text+0x17b688>
100183650: b00f5928    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
100183654: f9467501    	ldr	x1, [x8, #0xce8] ; selector: length
100183658: aa1303e0    	mov	x0, x19
10018365c: 95ea9182    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100183660: 53017c08    	lsr	w8, w0, #1
100183664: 52849269    	mov	w9, #0x2493             ; =9363
100183668: 72b24929    	movk	w9, #0x9249, lsl #16
10018366c: 9ba97d08    	umull	x8, w8, w9
100183670: d362fd08    	lsr	x8, x8, #34
100183674: 0b080908    	add	w8, w8, w8, lsl #2
100183678: 531e7514    	lsl	w20, w8, #2
10018367c: 14000008    	b	0x10018369c <__text+0x17b69c>
100183680: b00f5c88    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
100183684: f9405900    	ldr	x0, [x8, #0xb0]
100183688: b00f4288    	adrp	x8, 0x11e9d4000 <dyld_stub_binder+0x11e9d4000>
10018368c: f940a901    	ldr	x1, [x8, #0x150] ; selector: calculateVoiceTime:
100183690: aa1303e2    	mov	x2, x19
100183694: 95ea9174    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100183698: aa0003f4    	mov	x20, x0
10018369c: aa1303e0    	mov	x0, x19
1001836a0: 95ea9174    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1001836a4: aa1403e0    	mov	x0, x20
1001836a8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1001836ac: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1001836b0: a8c357f6    	ldp	x22, x21, [sp], #0x30
1001836b4: d65f03c0    	ret
