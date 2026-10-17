
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b9a280: d10143ff    	sub	sp, sp, #0x50
104b9a284: a90257f6    	stp	x22, x21, [sp, #0x20]
104b9a288: a9034ff4    	stp	x20, x19, [sp, #0x30]
104b9a28c: a9047bfd    	stp	x29, x30, [sp, #0x40]
104b9a290: 910103fd    	add	x29, sp, #0x40
104b9a294: aa0003f3    	mov	x19, x0
104b9a298: f00d9908    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
104b9a29c: f9426514    	ldr	x20, [x8, #0x4c8] ; m_refMessageWrap
104b9a2a0: aa1403e1    	mov	x1, x20
104b9a2a4: 94c233a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a2a8: aa1d03fd    	mov	x29, x29
104b9a2ac: 94c233a7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9a2b0: aa0003f5    	mov	x21, x0
104b9a2b4: d00d95a8    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
104b9a2b8: f9423901    	ldr	x1, [x8, #0x470] ; generateExtCommonInfoXML
104b9a2bc: 94c233a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a2c0: aa1d03fd    	mov	x29, x29
104b9a2c4: 94c233a1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9a2c8: aa0003f6    	mov	x22, x0
104b9a2cc: aa1503e0    	mov	x0, x21
104b9a2d0: 94c233a1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9a2d4: b00daec8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b9a2d8: f9454500    	ldr	x0, [x8, #0xa88]
104b9a2dc: 900dab88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104b9a2e0: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
104b9a2e4: 29412668    	ldp	w8, w9, [x19, #0x8]
104b9a2e8: b9401a6a    	ldr	w10, [x19, #0x18]
104b9a2ec: a9015bea    	stp	x10, x22, [sp, #0x10]
104b9a2f0: a90027e8    	stp	x8, x9, [sp]
104b9a2f4: f00ce062    	adrp	x2, 0x11e7a9000 <dyld_stub_binder+0x11e7a9000>
104b9a2f8: 91272042    	add	x2, x2, #0x9c8
104b9a2fc: 94c23390    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a300: aa1d03fd    	mov	x29, x29
104b9a304: 94c23391    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9a308: aa0003f5    	mov	x21, x0
104b9a30c: aa1303e0    	mov	x0, x19
104b9a310: aa1403e1    	mov	x1, x20
104b9a314: 94c2338a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a318: aa1d03fd    	mov	x29, x29
104b9a31c: 94c2338b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9a320: aa0003f3    	mov	x19, x0
104b9a324: d00d9508    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b9a328: f9453d01    	ldr	x1, [x8, #0xa78] ; setM_nsContent:
104b9a32c: aa1503e2    	mov	x2, x21
104b9a330: 94c23383    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a334: aa1303e0    	mov	x0, x19
104b9a338: 94c23387    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9a33c: aa1503e0    	mov	x0, x21
104b9a340: 94c23385    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9a344: aa1603e0    	mov	x0, x22
104b9a348: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104b9a34c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104b9a350: a94257f6    	ldp	x22, x21, [sp, #0x20]
104b9a354: 910143ff    	add	sp, sp, #0x50
104b9a358: 14c2337f    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
