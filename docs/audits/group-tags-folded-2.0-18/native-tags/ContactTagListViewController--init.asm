
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101045ef0: d100c3ff    	sub	sp, sp, #0x30
101045ef4: a9014ff4    	stp	x20, x19, [sp, #0x10]
101045ef8: a9027bfd    	stp	x29, x30, [sp, #0x20]
101045efc: 910083fd    	add	x29, sp, #0x20
101045f00: b00f8ba8    	adrp	x8, 0x1201ba000 <dyld_stub_binder+0x1201ba000>
101045f04: f9435d08    	ldr	x8, [x8, #0x6b8] ; `I,
101045f08: a90023e0    	stp	x0, x8, [sp]
101045f0c: b00f85e8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
101045f10: f9466901    	ldr	x1, [x8, #0xcd0] ; init
101045f14: 910003e0    	mov	x0, sp
101045f18: 95af848b    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
101045f1c: aa0003f3    	mov	x19, x0
101045f20: b4000320    	cbz	x0, 0x101045f84 <__text+0x103df84>
101045f24: d00f8968    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101045f28: f945e900    	ldr	x0, [x8, #0xbd0]
101045f2c: f00f85c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101045f30: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
101045f34: 95af8482    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101045f38: aa1d03fd    	mov	x29, x29
101045f3c: 95af8483    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101045f40: aa0003f4    	mov	x20, x0
101045f44: 900f8968    	adrp	x8, 0x120171000 <dyld_stub_binder+0x120171000>
101045f48: f940ed02    	ldr	x2, [x8, #0x1d8]
101045f4c: b00f6fa8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
101045f50: f940a101    	ldr	x1, [x8, #0x140] ; registerExtension:withTarget:
101045f54: aa1303e3    	mov	x3, x19
101045f58: 95af8479    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101045f5c: aa1403e0    	mov	x0, x20
101045f60: 95af847d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101045f64: b00f8d28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
101045f68: b982a108    	ldrsw	x8, [x8, #0x2a0]
101045f6c: 38286a7f    	strb	wzr, [x19, x8]
101045f70: f00f7028    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
101045f74: f947ad01    	ldr	x1, [x8, #0xf58] ; setIsEditing:
101045f78: aa1303e0    	mov	x0, x19
101045f7c: 52800002    	mov	w2, #0x0                ; =0
101045f80: 95af846f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101045f84: aa1303e0    	mov	x0, x19
101045f88: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101045f8c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101045f90: 9100c3ff    	add	sp, sp, #0x30
101045f94: d65f03c0    	ret
