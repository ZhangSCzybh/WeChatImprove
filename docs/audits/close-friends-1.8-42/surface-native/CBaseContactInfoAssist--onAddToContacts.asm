
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10029f478: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
10029f47c: a90157f6    	stp	x22, x21, [sp, #0x10]
10029f480: a9024ff4    	stp	x20, x19, [sp, #0x20]
10029f484: a9037bfd    	stp	x29, x30, [sp, #0x30]
10029f488: 9100c3fd    	add	x29, sp, #0x30
10029f48c: aa0003f3    	mov	x19, x0
10029f490: 900ffa08    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10029f494: b9825917    	ldrsw	x23, [x8, #0x258] ; ivar CBaseContactInfoAssist.m_delegate
10029f498: 8b170000    	add	x0, x0, x23
10029f49c: 95e61f3c    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10029f4a0: aa0003f5    	mov	x21, x0
10029f4a4: f00fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
10029f4a8: f9412114    	ldr	x20, [x8, #0x240] ; onAddToContact
10029f4ac: f00ff328    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10029f4b0: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
10029f4b4: aa1403e2    	mov	x2, x20
10029f4b8: 95e61f21    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10029f4bc: aa0003f6    	mov	x22, x0
10029f4c0: aa1503e0    	mov	x0, x21
10029f4c4: 95e61f24    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10029f4c8: 34000116    	cbz	w22, 0x10029f4e8 <__text+0x2974e8>
10029f4cc: 8b170260    	add	x0, x19, x23
10029f4d0: 95e61f2f    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10029f4d4: aa0003f5    	mov	x21, x0
10029f4d8: aa1403e1    	mov	x1, x20
10029f4dc: 95e61f18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10029f4e0: aa1503e0    	mov	x0, x21
10029f4e4: 95e61f1c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10029f4e8: f00fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
10029f4ec: f9412501    	ldr	x1, [x8, #0x248] ; doAddContact
10029f4f0: aa1303e0    	mov	x0, x19
10029f4f4: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10029f4f8: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10029f4fc: a94157f6    	ldp	x22, x21, [sp, #0x10]
10029f500: a8c45ff8    	ldp	x24, x23, [sp], #0x40
10029f504: 15e61f0e    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
