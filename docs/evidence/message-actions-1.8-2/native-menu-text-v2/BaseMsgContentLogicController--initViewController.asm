
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002b52e4: d10143ff    	sub	sp, sp, #0x50
1002b52e8: a9034ff4    	stp	x20, x19, [sp, #0x30]
1002b52ec: a9047bfd    	stp	x29, x30, [sp, #0x40]
1002b52f0: 910103fd    	add	x29, sp, #0x40
1002b52f4: aa0003f3    	mov	x19, x0
1002b52f8: 90104bc8    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
1002b52fc: 52800029    	mov	w9, #0x1                ; =1
1002b5300: 39324509    	strb	w9, [x8, #0xc91]
1002b5304: b00fdca8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002b5308: f945e501    	ldr	x1, [x8, #0xbc8] ; genBaseMsgContentViewController
1002b530c: 95e5c78c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b5310: aa1d03fd    	mov	x29, x29
1002b5314: 95e5c78d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b5318: d00ff948    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
1002b531c: b9833914    	ldrsw	x20, [x8, #0x338]
1002b5320: f8746a68    	ldr	x8, [x19, x20]
1002b5324: f8346a60    	str	x0, [x19, x20]
1002b5328: aa0803e0    	mov	x0, x8
1002b532c: 95e5c78a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b5330: f8746a60    	ldr	x0, [x19, x20]
1002b5334: 900fdc28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1002b5338: f946d101    	ldr	x1, [x8, #0xda0] ; setM_delegate:
1002b533c: aa1303e2    	mov	x2, x19
1002b5340: 95e5c77f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b5344: d10063a0    	sub	x0, x29, #0x18
1002b5348: aa1303e1    	mov	x1, x19
1002b534c: 95e5c788    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
1002b5350: f8746a73    	ldr	x19, [x19, x20]
1002b5354: b00e99c8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1002b5358: f947e108    	ldr	x8, [x8, #0xfc0]
1002b535c: f90003e8    	str	x8, [sp]
1002b5360: 900c5668    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1002b5364: fd41c100    	ldr	d0, [x8, #0x380]
1002b5368: 90000008    	adrp	x8, 0x1002b5000 <__text+0x2ad000>
1002b536c: 910f1108    	add	x8, x8, #0x3c4
1002b5370: fd0007e0    	str	d0, [sp, #0x8]
1002b5374: d00e9a29    	adrp	x9, 0x11d5fb000 <dyld_stub_binder+0x11d5fb000>
1002b5378: 91042129    	add	x9, x9, #0x108
1002b537c: a90127e8    	stp	x8, x9, [sp, #0x10]
1002b5380: 910003f4    	mov	x20, sp
1002b5384: 91008280    	add	x0, x20, #0x20
1002b5388: d10063a1    	sub	x1, x29, #0x18
1002b538c: 95e5c77b    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
1002b5390: b00fdca8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002b5394: f945ed01    	ldr	x1, [x8, #0xbd8] ; setMultiSelectedHandler:
1002b5398: 910003e2    	mov	x2, sp
1002b539c: aa1303e0    	mov	x0, x19
1002b53a0: 95e5c767    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b53a4: 91008280    	add	x0, x20, #0x20
1002b53a8: 95e5c77a    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
1002b53ac: d10063a0    	sub	x0, x29, #0x18
1002b53b0: 95e5c778    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
1002b53b4: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1002b53b8: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1002b53bc: 910143ff    	add	sp, sp, #0x50
1002b53c0: d65f03c0    	ret
1002b53c4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1002b53c8: a9014ff4    	stp	x20, x19, [sp, #0x10]
1002b53cc: a9027bfd    	stp	x29, x30, [sp, #0x20]
1002b53d0: 910083fd    	add	x29, sp, #0x20
1002b53d4: aa0203f4    	mov	x20, x2
1002b53d8: aa0103f3    	mov	x19, x1
1002b53dc: aa0003f5    	mov	x21, x0
1002b53e0: aa0103e0    	mov	x0, x1
1002b53e4: 95e5c755    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1002b53e8: 910082a0    	add	x0, x21, #0x20
1002b53ec: 95e5c768    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1002b53f0: aa0003f5    	mov	x21, x0
1002b53f4: b40000e0    	cbz	x0, 0x1002b5410 <__text+0x2ad410>
1002b53f8: b00fdca8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002b53fc: f945e901    	ldr	x1, [x8, #0xbd0] ; onMultiSelectChanged:selected:
1002b5400: aa1503e0    	mov	x0, x21
1002b5404: aa1303e2    	mov	x2, x19
1002b5408: aa1403e3    	mov	x3, x20
1002b540c: 95e5c74c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b5410: aa1503e0    	mov	x0, x21
1002b5414: 95e5c750    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b5418: aa1303e0    	mov	x0, x19
1002b541c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1002b5420: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1002b5424: a8c357f6    	ldp	x22, x21, [sp], #0x30
1002b5428: 15e5c74b    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>