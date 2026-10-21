
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10181b484: d10143ff    	sub	sp, sp, #0x50
10181b488: a9015ff8    	stp	x24, x23, [sp, #0x10]
10181b48c: a90257f6    	stp	x22, x21, [sp, #0x20]
10181b490: a9034ff4    	stp	x20, x19, [sp, #0x30]
10181b494: a9047bfd    	stp	x29, x30, [sp, #0x40]
10181b498: 910103fd    	add	x29, sp, #0x40
10181b49c: aa0003f3    	mov	x19, x0
10181b4a0: 900f4ac8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10181b4a4: f9453500    	ldr	x0, [x8, #0xa68]
10181b4a8: d00f30e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10181b4ac: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10181b4b0: d00e6be8    	adrp	x8, 0x11e599000 <dyld_stub_binder+0x11e599000>
10181b4b4: 911ba108    	add	x8, x8, #0x6e8
10181b4b8: f90003e8    	str	x8, [sp]
10181b4bc: b00cd2c3    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
10181b4c0: 91388063    	add	x3, x3, #0xe20
10181b4c4: 900cdea5    	adrp	x5, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10181b4c8: 912160a5    	add	x5, x5, #0x858
10181b4cc: 900cdea7    	adrp	x7, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10181b4d0: 913160e7    	add	x7, x7, #0xc58
10181b4d4: 52800042    	mov	w2, #0x2                ; =2
10181b4d8: 52800004    	mov	w4, #0x0                ; =0
10181b4dc: 52801a66    	mov	w6, #0xd3               ; =211
10181b4e0: 95902f17    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b4e4: 91032260    	add	x0, x19, #0xc8
10181b4e8: 95902f29    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181b4ec: b4000300    	cbz	x0, 0x10181b54c <__text+0x181354c>
10181b4f0: aa0003f5    	mov	x21, x0
10181b4f4: 91032260    	add	x0, x19, #0xc8
10181b4f8: 95902f25    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181b4fc: aa0003f6    	mov	x22, x0
10181b500: 900f3488    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10181b504: f944d114    	ldr	x20, [x8, #0x9a0] ; reloadList
10181b508: f00f4748    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10181b50c: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
10181b510: aa1403e2    	mov	x2, x20
10181b514: 95902f0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b518: aa0003f7    	mov	x23, x0
10181b51c: aa1603e0    	mov	x0, x22
10181b520: 95902f0d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b524: aa1503e0    	mov	x0, x21
10181b528: 95902f0b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b52c: 34000117    	cbz	w23, 0x10181b54c <__text+0x181354c>
10181b530: 91032260    	add	x0, x19, #0xc8
10181b534: 95902f16    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181b538: aa0003f5    	mov	x21, x0
10181b53c: aa1403e1    	mov	x1, x20
10181b540: 95902eff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b544: aa1503e0    	mov	x0, x21
10181b548: 95902f03    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b54c: 900f3488    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10181b550: f944dd01    	ldr	x1, [x8, #0x9b8] ; updateSearchReport
10181b554: aa1303e0    	mov	x0, x19
10181b558: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10181b55c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10181b560: a94257f6    	ldp	x22, x21, [sp, #0x20]
10181b564: a9415ff8    	ldp	x24, x23, [sp, #0x10]
10181b568: 910143ff    	add	sp, sp, #0x50
10181b56c: 15902ef4    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
