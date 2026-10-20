
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10169993c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
101699940: a9017bfd    	stp	x29, x30, [sp, #0x10]
101699944: 910043fd    	add	x29, sp, #0x10
101699948: aa0003f3    	mov	x19, x0
10169994c: b00f4068    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101699950: f9436101    	ldr	x1, [x8, #0x6c0] ; numberOfItems
101699954: 959635fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101699958: aa0003f4    	mov	x20, x0
10169995c: b00f4068    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101699960: f9436501    	ldr	x1, [x8, #0x6c8] ; topNotSearchItemCount
101699964: aa1303e0    	mov	x0, x19
101699968: 959635f5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10169996c: cb000280    	sub	x0, x20, x0
101699970: a9417bfd    	ldp	x29, x30, [sp, #0x10]
101699974: a8c24ff4    	ldp	x20, x19, [sp], #0x20
101699978: d65f03c0    	ret
