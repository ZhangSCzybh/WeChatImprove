
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a8d794: d10203ff    	sub	sp, sp, #0x80
104a8d798: 6d022beb    	stp	d11, d10, [sp, #0x20]
104a8d79c: 6d0323e9    	stp	d9, d8, [sp, #0x30]
104a8d7a0: a9045ff8    	stp	x24, x23, [sp, #0x40]
104a8d7a4: a90557f6    	stp	x22, x21, [sp, #0x50]
104a8d7a8: a9064ff4    	stp	x20, x19, [sp, #0x60]
104a8d7ac: a9077bfd    	stp	x29, x30, [sp, #0x70]
104a8d7b0: 9101c3fd    	add	x29, sp, #0x70
104a8d7b4: 1e604068    	fmov	d8, d3
104a8d7b8: 1e604049    	fmov	d9, d2
104a8d7bc: 1e60402a    	fmov	d10, d1
104a8d7c0: 1e60400b    	fmov	d11, d0
104a8d7c4: aa0203f3    	mov	x19, x2
104a8d7c8: aa0003f4    	mov	x20, x0
104a8d7cc: b00e0d88    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a8d7d0: 52800029    	mov	w9, #0x1                ; =1
104a8d7d4: 390c6d09    	strb	w9, [x8, #0x31b]
104a8d7d8: aa0203e0    	mov	x0, x2
104a8d7dc: 94c66657    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104a8d7e0: 900db9c8    	adrp	x8, 0x1201c5000 <dyld_stub_binder+0x1201c5000>
104a8d7e4: f942bd08    	ldr	x8, [x8, #0x578] ; MainFrameItemView
104a8d7e8: a90123f4    	stp	x20, x8, [sp, #0x10]
104a8d7ec: b00db3a8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104a8d7f0: f947d901    	ldr	x1, [x8, #0xfb0] ; initWithFrame:
104a8d7f4: 910043e0    	add	x0, sp, #0x10
104a8d7f8: 1e604160    	fmov	d0, d11
104a8d7fc: 1e604141    	fmov	d1, d10
104a8d800: 1e604122    	fmov	d2, d9
104a8d804: 1e604103    	fmov	d3, d8
104a8d808: 94c6664f    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
104a8d80c: aa0003f4    	mov	x20, x0
104a8d810: b40006e0    	cbz	x0, 0x104a8d8ec <_Flutter_MMFoundation_BindContext+0xf694d0>
104a8d814: b4000753    	cbz	x19, 0x104a8d8fc <_Flutter_MMFoundation_BindContext+0xf694e0>
104a8d818: d00d9dc8    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
104a8d81c: f947b101    	ldr	x1, [x8, #0xf60] ; initSubview
104a8d820: aa1403e0    	mov	x0, x20
104a8d824: 94c66646    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8d828: d00da1a8    	adrp	x8, 0x11fec3000 <dyld_stub_binder+0x11fec3000>
104a8d82c: f9430101    	ldr	x1, [x8, #0x600] ; updateWithCellData:
104a8d830: aa1403e0    	mov	x0, x20
104a8d834: aa1303e2    	mov	x2, x19
104a8d838: 94c66641    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8d83c: d00db738    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
104a8d840: f945eb00    	ldr	x0, [x24, #0xbd0] ; MMContext
104a8d844: f00db388    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a8d848: f944e915    	ldr	x21, [x8, #0x9d0] ; currentContext
104a8d84c: aa1503e1    	mov	x1, x21
104a8d850: 94c6663b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8d854: aa1d03fd    	mov	x29, x29
104a8d858: 94c6663c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8d85c: aa0003f6    	mov	x22, x0
104a8d860: f00db708    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
104a8d864: f9466902    	ldr	x2, [x8, #0xcd0]
104a8d868: b00d9d68    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104a8d86c: f940a117    	ldr	x23, [x8, #0x140] ; registerExtension:withTarget:
104a8d870: aa1703e1    	mov	x1, x23
104a8d874: aa1403e3    	mov	x3, x20
104a8d878: 94c66631    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8d87c: aa1603e0    	mov	x0, x22
104a8d880: 94c66635    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8d884: f945eb00    	ldr	x0, [x24, #0xbd0] ; MMContext
104a8d888: aa1503e1    	mov	x1, x21
104a8d88c: 94c6662c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8d890: aa1d03fd    	mov	x29, x29
104a8d894: 94c6662d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8d898: aa0003f6    	mov	x22, x0
104a8d89c: b00db728    	adrp	x8, 0x120172000 <dyld_stub_binder+0x120172000>
104a8d8a0: f9409d02    	ldr	x2, [x8, #0x138]
104a8d8a4: aa1703e1    	mov	x1, x23
104a8d8a8: aa1403e3    	mov	x3, x20
104a8d8ac: 94c66624    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8d8b0: aa1603e0    	mov	x0, x22
104a8d8b4: 94c66628    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8d8b8: f945eb00    	ldr	x0, [x24, #0xbd0] ; MMContext
104a8d8bc: aa1503e1    	mov	x1, x21
104a8d8c0: 94c6661f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8d8c4: aa1d03fd    	mov	x29, x29
104a8d8c8: 94c66620    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8d8cc: aa0003f5    	mov	x21, x0
104a8d8d0: f00db708    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
104a8d8d4: f946a502    	ldr	x2, [x8, #0xd48]
104a8d8d8: aa1703e1    	mov	x1, x23
104a8d8dc: aa1403e3    	mov	x3, x20
104a8d8e0: 94c66617    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8d8e4: aa1503e0    	mov	x0, x21
104a8d8e8: 94c6661b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8d8ec: aa1403e0    	mov	x0, x20
104a8d8f0: 94c66612    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104a8d8f4: aa1403f5    	mov	x21, x20
104a8d8f8: 14000012    	b	0x104a8d940 <_Flutter_MMFoundation_BindContext+0xf69524>
104a8d8fc: d00db728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a8d900: f9453500    	ldr	x0, [x8, #0xa68] ; iConsole
104a8d904: 900d9d68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a8d908: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104a8d90c: 900ce888    	adrp	x8, 0x11e79d000 <dyld_stub_binder+0x11e79d000>
104a8d910: 9130a108    	add	x8, x8, #0xc28 ; CFString 'init with nil cellData'
104a8d914: f90003e8    	str	x8, [sp]
104a8d918: f00b6b05    	adrp	x5, 0x11b7f0000 <dyld_stub_binder+0x11b7f0000>
104a8d91c: 9132aca5    	add	x5, x5, #0xcab
104a8d920: f00b6b07    	adrp	x7, 0x11b7f0000 <dyld_stub_binder+0x11b7f0000>
104a8d924: 913300e7    	add	x7, x7, #0xcc0
104a8d928: 52800042    	mov	w2, #0x2                ; =2
104a8d92c: d2800003    	mov	x3, #0x0                ; =0
104a8d930: 52800004    	mov	w4, #0x0                ; =0
104a8d934: 52800f46    	mov	w6, #0x7a               ; =122
104a8d938: 94c66601    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8d93c: d2800015    	mov	x21, #0x0               ; =0
104a8d940: aa1303e0    	mov	x0, x19
104a8d944: 94c66604    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8d948: aa1403e0    	mov	x0, x20
104a8d94c: 94c66602    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8d950: aa1503e0    	mov	x0, x21
104a8d954: a9477bfd    	ldp	x29, x30, [sp, #0x70]
104a8d958: a9464ff4    	ldp	x20, x19, [sp, #0x60]
104a8d95c: a94557f6    	ldp	x22, x21, [sp, #0x50]
104a8d960: a9445ff8    	ldp	x24, x23, [sp, #0x40]
104a8d964: 6d4323e9    	ldp	d9, d8, [sp, #0x30]
104a8d968: 6d422beb    	ldp	d11, d10, [sp, #0x20]
104a8d96c: 910203ff    	add	sp, sp, #0x80
104a8d970: d65f03c0    	ret
