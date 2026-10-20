
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10627973c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
106279740: a9017bfd    	stp	x29, x30, [sp, #0x10]
106279744: 910043fd    	add	x29, sp, #0x10
106279748: aa0003f3    	mov	x19, x0
10627974c: f00cfde8    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
106279750: b98d5514    	ldrsw	x20, [x8, #0xd54]
106279754: f8746800    	ldr	x0, [x0, x20]
106279758: b50000c0    	cbnz	x0, 0x106279770 <_Flutter_MMFoundation_BindContext+0x2755354>
10627975c: d00ceac8    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106279760: f9463901    	ldr	x1, [x8, #0xc70] ; initQuickTransTipButton
106279764: aa1303e0    	mov	x0, x19
106279768: 9466b675    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627976c: f8746a60    	ldr	x0, [x19, x20]
106279770: d00cf488    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
106279774: f947a501    	ldr	x1, [x8, #0xf48] ; width
106279778: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10627977c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
106279780: 1466b66f    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>