
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1017629e8: d10083ff    	sub	sp, sp, #0x20
1017629ec: a9017bfd    	stp	x29, x30, [sp, #0x10]
1017629f0: 910043fd    	add	x29, sp, #0x10
1017629f4: b00f52c8    	adrp	x8, 0x1201bb000 <dyld_stub_binder+0x1201bb000>
1017629f8: f9466108    	ldr	x8, [x8, #0xcc0]
1017629fc: a90023e0    	stp	x0, x8, [sp]
101762a00: 900f3948    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
101762a04: f9469101    	ldr	x1, [x8, #0xd20] ; onNavigationCancelItemClick
101762a08: 910003e0    	mov	x0, sp
101762a0c: 959311ce    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
101762a10: a9417bfd    	ldp	x29, x30, [sp, #0x10]
101762a14: 910083ff    	add	sp, sp, #0x20
101762a18: d65f03c0    	ret
