
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10176319c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1017631a0: a9017bfd    	stp	x29, x30, [sp, #0x10]
1017631a4: 910043fd    	add	x29, sp, #0x10
1017631a8: aa0003f3    	mov	x19, x0
1017631ac: b00f3828    	adrp	x8, 0x11fe68000 <dyld_stub_binder+0x11fe68000>
1017631b0: f946f101    	ldr	x1, [x8, #0xde0] ; presenter
1017631b4: 95930fe2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017631b8: aa1d03fd    	mov	x29, x29
1017631bc: 95930fe3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017631c0: aa0003f4    	mov	x20, x0
1017631c4: f00f3a08    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1017631c8: f9436901    	ldr	x1, [x8, #0x6d0] ; searchBarText
1017631cc: aa1303e0    	mov	x0, x19
1017631d0: 95930fdb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017631d4: aa1d03fd    	mov	x29, x29
1017631d8: 95930fdc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017631dc: aa0003f3    	mov	x19, x0
1017631e0: d00f36c8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1017631e4: f940ad01    	ldr	x1, [x8, #0x158] ; doSearch:
1017631e8: aa1403e0    	mov	x0, x20
1017631ec: aa1303e2    	mov	x2, x19
1017631f0: 95930fd3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017631f4: aa1303e0    	mov	x0, x19
1017631f8: 95930fd7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017631fc: aa1403e0    	mov	x0, x20
101763200: a9417bfd    	ldp	x29, x30, [sp, #0x10]
101763204: a8c24ff4    	ldp	x20, x19, [sp], #0x20
101763208: 15930fd3    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
