
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a74484: f00dbd68    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a74488: b9810908    	ldrsw	x8, [x8, #0x108]
104a7448c: 38686808    	ldrb	w8, [x0, x8]
104a74490: 7100051f    	cmp	w8, #0x1
104a74494: 54000361    	b.ne	0x104a74500 <_Flutter_MMFoundation_BindContext+0xf500e4>
104a74498: d10083ff    	sub	sp, sp, #0x20
104a7449c: a9017bfd    	stp	x29, x30, [sp, #0x10]
104a744a0: 910043fd    	add	x29, sp, #0x10
104a744a4: f00dbd68    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a744a8: b9810d08    	ldrsw	x8, [x8, #0x10c]
104a744ac: 52800029    	mov	w9, #0x1                ; =1
104a744b0: 38286809    	strb	w9, [x0, x8]
104a744b4: f00db7e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a744b8: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
104a744bc: b00d9e28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a744c0: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104a744c4: 900ce948    	adrp	x8, 0x11e79c000 <dyld_stub_binder+0x11e79c000>
104a744c8: 9128a108    	add	x8, x8, #0xa28 ; CFString 'ignore reload at transitioning'
104a744cc: f90003e8    	str	x8, [sp]
104a744d0: f00b6bc5    	adrp	x5, 0x11b7ef000 <dyld_stub_binder+0x11b7ef000>
104a744d4: 911458a5    	add	x5, x5, #0x516 ; string 'MainFrameAggregationViewController.mm'
104a744d8: f00b6bc7    	adrp	x7, 0x11b7ef000 <dyld_stub_binder+0x11b7ef000>
104a744dc: 9118f4e7    	add	x7, x7, #0x63d ; string '-[MainFrameAggregationViewController onSessionListChange]'
104a744e0: 52800042    	mov	w2, #0x2                ; =2
104a744e4: d2800003    	mov	x3, #0x0                ; =0
104a744e8: 52800004    	mov	w4, #0x0                ; =0
104a744ec: 528034a6    	mov	w6, #0x1a5              ; =421
104a744f0: 94c6cb13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a744f4: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104a744f8: 910083ff    	add	sp, sp, #0x20
104a744fc: d65f03c0    	ret
104a74500: b00da3e8    	adrp	x8, 0x11fef1000 <dyld_stub_binder+0x11fef1000>
104a74504: f9406501    	ldr	x1, [x8, #0xc8] ; selector updateContent
104a74508: 14c6cb0d    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
