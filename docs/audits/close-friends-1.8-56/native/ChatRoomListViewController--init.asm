
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100ed76fc: d10083ff    	sub	sp, sp, #0x20
100ed7700: a9017bfd    	stp	x29, x30, [sp, #0x10]
100ed7704: 910043fd    	add	x29, sp, #0x10
100ed7708: f00f9708    	adrp	x8, 0x1201ba000 <dyld_stub_binder+0x1201ba000>
100ed770c: f941a908    	ldr	x8, [x8, #0x350]
100ed7710: a90023e0    	stp	x0, x8, [sp]
100ed7714: f00f9148    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
100ed7718: f9466901    	ldr	x1, [x8, #0xcd0] ; init
100ed771c: 910003e0    	mov	x0, sp
100ed7720: 95b53e89    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
100ed7724: a9417bfd    	ldp	x29, x30, [sp, #0x10]
100ed7728: 910083ff    	add	sp, sp, #0x20
100ed772c: d65f03c0    	ret
