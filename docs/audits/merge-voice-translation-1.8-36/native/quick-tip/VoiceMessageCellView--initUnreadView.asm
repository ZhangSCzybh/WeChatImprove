
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1062787b0: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1062787b4: a9014ff4    	stp	x20, x19, [sp, #0x10]
1062787b8: a9027bfd    	stp	x29, x30, [sp, #0x20]
1062787bc: 910083fd    	add	x29, sp, #0x20
1062787c0: f00d4e48    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
1062787c4: 52800029    	mov	w9, #0x1                ; =1
1062787c8: 3927b909    	strb	w9, [x8, #0x9ee]
1062787cc: 900cfe08    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
1062787d0: b98d6d14    	ldrsw	x20, [x8, #0xd6c]
1062787d4: f8746808    	ldr	x8, [x0, x20]
1062787d8: b40000a8    	cbz	x8, 0x1062787ec <_Flutter_MMFoundation_BindContext+0x27543d0>
1062787dc: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1062787e0: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1062787e4: a8c357f6    	ldp	x22, x21, [sp], #0x30
1062787e8: d65f03c0    	ret
1062787ec: aa0003f3    	mov	x19, x0
1062787f0: d00cf808    	adrp	x8, 0x12017a000 <dyld_stub_binder+0x12017a000>
1062787f4: f9408500    	ldr	x0, [x8, #0x108] ; �Nc 
1062787f8: d00ce028    	adrp	x8, 0x11fe7e000 <dyld_stub_binder+0x11fe7e000>
1062787fc: f9456d01    	ldr	x1, [x8, #0xad8] ; smallRedDot
106278800: 9466ba4f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106278804: aa1d03fd    	mov	x29, x29
106278808: 9466ba50    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627880c: f8746a68    	ldr	x8, [x19, x20]
106278810: f8346a60    	str	x0, [x19, x20]
106278814: aa0803e0    	mov	x0, x8
106278818: 9466ba4f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627881c: b00cfb88    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
106278820: 91126108    	add	x8, x8, #0x498
106278824: b9800108    	ldrsw	x8, [x8]
106278828: 8b080275    	add	x21, x19, x8
10627882c: fd4002a0    	ldr	d0, [x21]
106278830: fd400aa1    	ldr	d1, [x21, #0x10]
106278834: 1e612800    	fadd	d0, d0, d1
106278838: 1e651001    	fmov	d1, #12.00000000
10627883c: 1e612800    	fadd	d0, d0, d1
106278840: f8746a60    	ldr	x0, [x19, x20]
106278844: b00cde08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106278848: f9465501    	ldr	x1, [x8, #0xca8] ; setWcOrigin:
10627884c: 9e6703e1    	fmov	d1, xzr
106278850: 9466ba3b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106278854: fd400ea0    	ldr	d0, [x21, #0x18]
106278858: 1e6c1001    	fmov	d1, #0.50000000
10627885c: f8746a60    	ldr	x0, [x19, x20]
106278860: 1e610800    	fmul	d0, d0, d1
106278864: 900cde28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106278868: f9401901    	ldr	x1, [x8, #0x30] ; setCenterY:
10627886c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
106278870: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106278874: a8c357f6    	ldp	x22, x21, [sp], #0x30
106278878: 1466ba31    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>