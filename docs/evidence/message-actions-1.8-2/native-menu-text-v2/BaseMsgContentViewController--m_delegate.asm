
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100365c14: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
100365c18: 910003fd    	mov	x29, sp
100365c1c: d00ff3c8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
100365c20: b9842508    	ldrsw	x8, [x8, #0x424]
100365c24: 8b080000    	add	x0, x0, x8
100365c28: 95e30559    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
100365c2c: a8c17bfd    	ldp	x29, x30, [sp], #0x10
100365c30: 15e30550    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>