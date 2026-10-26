
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029a00c8: d100c3ff    	sub	sp, sp, #0x30
1029a00cc: a9027bfd    	stp	x29, x30, [sp, #0x20]
1029a00d0: 910083fd    	add	x29, sp, #0x20
1029a00d4: f00ebe88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029a00d8: f9454500    	ldr	x0, [x8, #0xa88]
1029a00dc: 3dc00040    	ldr	q0, [x2]
1029a00e0: a9412448    	ldp	x8, x9, [x2, #0x10]
1029a00e4: d00ebb4a    	adrp	x10, 0x12010a000 <dyld_stub_binder+0x12010a000>
1029a00e8: f946a541    	ldr	x1, [x10, #0xd48] ; stringWithFormat:
1029a00ec: a90127e8    	stp	x8, x9, [sp, #0x10]
1029a00f0: 3d8003e0    	str	q0, [sp]
1029a00f4: b00de662    	adrp	x2, 0x11e66d000 <dyld_stub_binder+0x11e66d000>
1029a00f8: 91312042    	add	x2, x2, #0xc48
1029a00fc: 954a1c10    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a0100: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1029a0104: 9100c3ff    	add	sp, sp, #0x30
1029a0108: d65f03c0    	ret
