
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104727854: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104727858: a9017bfd    	stp	x29, x30, [sp, #0x10]
10472785c: 910043fd    	add	x29, sp, #0x10
104727860: f00dbb88    	adrp	x8, 0x11fe9a000 <dyld_stub_binder+0x11fe9a000>
104727864: f9408901    	ldr	x1, [x8, #0x110] ; selector badgeView
104727868: 94d3fe35    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472786c: aa1d03fd    	mov	x29, x29
104727870: 94d3fe36    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104727874: aa0003f3    	mov	x19, x0
104727878: d00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
10472787c: f9467d01    	ldr	x1, [x8, #0xcf8] ; selector removeSmallDot
104727880: 94d3fe2f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727884: aa1303e0    	mov	x0, x19
104727888: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10472788c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104727890: 14d3fe31    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
