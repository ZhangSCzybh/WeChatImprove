
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101e12948: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
101e1294c: a9014ff4    	stp	x20, x19, [sp, #0x10]
101e12950: a9027bfd    	stp	x29, x30, [sp, #0x20]
101e12954: 910083fd    	add	x29, sp, #0x20
101e12958: aa0003f3    	mov	x19, x0
101e1295c: b00f1b08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101e12960: f9455500    	ldr	x0, [x8, #0xaa8]
101e12964: 957851fd    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
101e12968: aa0003f4    	mov	x20, x0
101e1296c: 900f0168    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
101e12970: f9415101    	ldr	x1, [x8, #0x2a0] ; forwardMenuItem
101e12974: aa1303e0    	mov	x0, x19
101e12978: 957851f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101e1297c: aa1d03fd    	mov	x29, x29
101e12980: 957851f2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101e12984: aa0003f5    	mov	x21, x0
101e12988: 900f0148    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
101e1298c: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
101e12990: aa1403e0    	mov	x0, x20
101e12994: aa1503e2    	mov	x2, x21
101e12998: 957851e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101e1299c: 900f0168    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
101e129a0: f9415501    	ldr	x1, [x8, #0x2a8] ; addRevokeOrDeleteMenuItem:
101e129a4: aa1303e0    	mov	x0, x19
101e129a8: aa1403e2    	mov	x2, x20
101e129ac: 957851e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101e129b0: aa1503e0    	mov	x0, x21
101e129b4: 957851e8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101e129b8: aa1403e0    	mov	x0, x20
101e129bc: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101e129c0: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101e129c4: a8c357f6    	ldp	x22, x21, [sp], #0x30
101e129c8: 157851ea    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
