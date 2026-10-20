
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101061468: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10106146c: a9014ff4    	stp	x20, x19, [sp, #0x10]
101061470: a9027bfd    	stp	x29, x30, [sp, #0x20]
101061474: 910083fd    	add	x29, sp, #0x20
101061478: aa0203f3    	mov	x19, x2
10106147c: aa0003f4    	mov	x20, x0
101061480: d00f88c8    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
101061484: f9432515    	ldr	x21, [x8, #0x648]
101061488: 900f7148    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
10106148c: f9432116    	ldr	x22, [x8, #0x640] ; fixContactFullPyAndParseContactKey:
101061490: aa0203e0    	mov	x0, x2
101061494: 95af1729    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101061498: aa1503e0    	mov	x0, x21
10106149c: aa1603e1    	mov	x1, x22
1010614a0: aa1303e2    	mov	x2, x19
1010614a4: 95af1726    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010614a8: aa1d03fd    	mov	x29, x29
1010614ac: 95af1727    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010614b0: aa0003f5    	mov	x21, x0
1010614b4: 900f7148    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
1010614b8: f9432501    	ldr	x1, [x8, #0x648] ; addContactSectionKey:
1010614bc: aa1403e0    	mov	x0, x20
1010614c0: aa1503e2    	mov	x2, x21
1010614c4: 95af171e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010614c8: aa1d03fd    	mov	x29, x29
1010614cc: 95af171f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010614d0: aa0003f4    	mov	x20, x0
1010614d4: aa1503e0    	mov	x0, x21
1010614d8: 95af171f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010614dc: b00f6ec8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1010614e0: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1010614e4: aa1403e0    	mov	x0, x20
1010614e8: aa1303e2    	mov	x2, x19
1010614ec: 95af1714    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010614f0: aa1303e0    	mov	x0, x19
1010614f4: 95af1718    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010614f8: aa1403e0    	mov	x0, x20
1010614fc: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101061500: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101061504: a8c357f6    	ldp	x22, x21, [sp], #0x30
101061508: 15af1713    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
