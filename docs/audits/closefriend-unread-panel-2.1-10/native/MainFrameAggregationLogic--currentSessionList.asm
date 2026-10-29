
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a6ed4c: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
104a6ed50: 910003fd    	mov	x29, sp
104a6ed54: f9401000    	ldr	x0, [x0, #0x20]
104a6ed58: d00db488    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a6ed5c: f9431501    	ldr	x1, [x8, #0x628] ; selector copy
104a6ed60: 94c6e0f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6ed64: a8c17bfd    	ldp	x29, x30, [sp], #0x10
104a6ed68: 14c6e102    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
