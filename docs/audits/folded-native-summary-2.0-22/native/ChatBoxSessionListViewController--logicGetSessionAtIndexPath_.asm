
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e4b324: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
100e4b328: a9014ff4    	stp	x20, x19, [sp, #0x10]
100e4b32c: a9027bfd    	stp	x29, x30, [sp, #0x20]
100e4b330: 910083fd    	add	x29, sp, #0x20
100e4b334: aa0203f3    	mov	x19, x2
100e4b338: 900f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e4b33c: f945e914    	ldr	x20, [x8, #0xbd0] ; MMContext
100e4b340: b00f95a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e4b344: f944e915    	ldr	x21, [x8, #0x9d0] ; currentContext
100e4b348: aa0203e0    	mov	x0, x2
100e4b34c: 95b76f7b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100e4b350: aa1403e0    	mov	x0, x20
100e4b354: aa1503e1    	mov	x1, x21
100e4b358: 95b76f79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b35c: aa1d03fd    	mov	x29, x29
100e4b360: 95b76f7a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4b364: aa0003f4    	mov	x20, x0
100e4b368: 900f9988    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
100e4b36c: f9420500    	ldr	x0, [x8, #0x408] ; ChatBoxMgr
100e4b370: 900f95a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100e4b374: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100e4b378: 95b76f71    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b37c: aa0003e2    	mov	x2, x0
100e4b380: d00f7f68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e4b384: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100e4b388: aa1403e0    	mov	x0, x20
100e4b38c: 95b76f6c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b390: aa1d03fd    	mov	x29, x29
100e4b394: 95b76f6d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4b398: aa0003f5    	mov	x21, x0
100e4b39c: f00f95c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
100e4b3a0: f9440901    	ldr	x1, [x8, #0x810] ; row
100e4b3a4: aa1303e0    	mov	x0, x19
100e4b3a8: 95b76f65    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b3ac: aa0003f6    	mov	x22, x0
100e4b3b0: aa1303e0    	mov	x0, x19
100e4b3b4: 95b76f68    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4b3b8: b00f81a8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e4b3bc: f943e901    	ldr	x1, [x8, #0x7d0] ; getSessionAtIndex:
100e4b3c0: aa1503e0    	mov	x0, x21
100e4b3c4: aa1603e2    	mov	x2, x22
100e4b3c8: 95b76f5d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b3cc: aa1d03fd    	mov	x29, x29
100e4b3d0: 95b76f5e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4b3d4: aa0003f3    	mov	x19, x0
100e4b3d8: aa1503e0    	mov	x0, x21
100e4b3dc: 95b76f5e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4b3e0: aa1403e0    	mov	x0, x20
100e4b3e4: 95b76f5c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4b3e8: aa1303e0    	mov	x0, x19
100e4b3ec: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100e4b3f0: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100e4b3f4: a8c357f6    	ldp	x22, x21, [sp], #0x30
100e4b3f8: 15b76f5e    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
