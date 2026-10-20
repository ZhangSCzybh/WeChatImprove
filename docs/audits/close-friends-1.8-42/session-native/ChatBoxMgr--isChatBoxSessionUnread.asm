
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e4984c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
100e49850: a9017bfd    	stp	x29, x30, [sp, #0x10]
100e49854: 910043fd    	add	x29, sp, #0x10
100e49858: f00f9948    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100e4985c: f9408500    	ldr	x0, [x8, #0x108]
100e49860: 900f7fc8    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100e49864: f946fd01    	ldr	x1, [x8, #0xdf8] ; defaultMemoryMappedKV
100e49868: 95b77635    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4986c: aa1d03fd    	mov	x29, x29
100e49870: 95b77636    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e49874: aa0003f3    	mov	x19, x0
100e49878: f00f7f88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100e4987c: f9421d01    	ldr	x1, [x8, #0x438] ; getBoolForKey:defaultValue:
100e49880: b00eb742    	adrp	x2, 0x11e532000 <dyld_stub_binder+0x11e532000>
100e49884: 911f2042    	add	x2, x2, #0x7c8
100e49888: 52800003    	mov	w3, #0x0                ; =0
100e4988c: 95b7762c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49890: aa0003f4    	mov	x20, x0
100e49894: aa1303e0    	mov	x0, x19
100e49898: 95b7762f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4989c: aa1403e0    	mov	x0, x20
100e498a0: a9417bfd    	ldp	x29, x30, [sp, #0x10]
100e498a4: a8c24ff4    	ldp	x20, x19, [sp], #0x20
100e498a8: d65f03c0    	ret
