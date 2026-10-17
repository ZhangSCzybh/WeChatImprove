
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10029cf44: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
10029cf48: 910003fd    	mov	x29, sp
10029cf4c: f00ffa08    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10029cf50: b9821908    	ldrsw	x8, [x8, #0x218]
10029cf54: 8b080000    	add	x0, x0, x8
10029cf58: 95e6288d    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10029cf5c: a8c17bfd    	ldp	x29, x30, [sp], #0x10
10029cf60: 15e62884    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
