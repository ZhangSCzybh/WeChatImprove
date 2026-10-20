
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f906dc: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
100f906e0: a9017bfd    	stp	x29, x30, [sp, #0x10]
100f906e4: 910043fd    	add	x29, sp, #0x10
100f906e8: aa0003f3    	mov	x19, x0
100f906ec: f00f7548    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100f906f0: f947d101    	ldr	x1, [x8, #0xfa0] ; isChatroom
100f906f4: 95b25a92    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f906f8: 340000e0    	cbz	w0, 0x100f90714 <__text+0xf88714>
100f906fc: b00f92c8    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100f90700: b9876908    	ldrsw	x8, [x8, #0x768]
100f90704: b8686a68    	ldr	w8, [x19, x8]
100f90708: 7100011f    	cmp	w8, #0x0
100f9070c: 1a9f17e0    	cset	w0, eq
100f90710: 1400000b    	b	0x100f9073c <__text+0xf8873c>
100f90714: 900f7688    	adrp	x8, 0x11fe60000 <dyld_stub_binder+0x11fe60000>
100f90718: f9479101    	ldr	x1, [x8, #0xf20] ; isUseNewMuteFlag
100f9071c: aa1303e0    	mov	x0, x19
100f90720: 95b25a87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f90724: b9406668    	ldr	w8, [x19, #0x64]
100f90728: 7217011f    	tst	w8, #0x200
100f9072c: 1a9f17e9    	cset	w9, eq
100f90730: 531f7d08    	lsr	w8, w8, #31
100f90734: 7100001f    	cmp	w0, #0x0
100f90738: 1a880120    	csel	w0, w9, w8, eq
100f9073c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
100f90740: a8c24ff4    	ldp	x20, x19, [sp], #0x20
100f90744: d65f03c0    	ret
