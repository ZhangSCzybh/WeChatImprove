
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e484f0: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
100e484f4: a9017bfd    	stp	x29, x30, [sp, #0x10]
100e484f8: 910043fd    	add	x29, sp, #0x10
100e484fc: aa0003f3    	mov	x19, x0
100e48500: f00f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e48504: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
100e48508: 900f95c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e4850c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100e48510: 95b77b0b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48514: aa1d03fd    	mov	x29, x29
100e48518: 95b77b0c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4851c: aa0003f4    	mov	x20, x0
100e48520: b00f9948    	adrp	x8, 0x120171000 <dyld_stub_binder+0x120171000>
100e48524: f9407902    	ldr	x2, [x8, #0xf0]
100e48528: 900f81c8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e4852c: f9437d03    	ldr	x3, [x8, #0x6f8] ; onChatBoxSessionListChanged
100e48530: d00f7f88    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
100e48534: f9404901    	ldr	x1, [x8, #0x90] ; callExtension:selector:block:
100e48538: f00e3e04    	adrp	x4, 0x11d60b000 <dyld_stub_binder+0x11d60b000>
100e4853c: 9133a084    	add	x4, x4, #0xce8
100e48540: 95b77aff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48544: aa1403e0    	mov	x0, x20
100e48548: 95b77b03    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4854c: 900f81c8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e48550: f9438101    	ldr	x1, [x8, #0x700] ; updateChatBoxSessionDesc
100e48554: aa1303e0    	mov	x0, x19
100e48558: a9417bfd    	ldp	x29, x30, [sp, #0x10]
100e4855c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
100e48560: 15b77af7    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
