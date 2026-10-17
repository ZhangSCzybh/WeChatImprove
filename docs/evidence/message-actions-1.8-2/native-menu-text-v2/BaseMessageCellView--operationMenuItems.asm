
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002a55c0: d100c3ff    	sub	sp, sp, #0x30
1002a55c4: a9014ff4    	stp	x20, x19, [sp, #0x10]
1002a55c8: a9027bfd    	stp	x29, x30, [sp, #0x20]
1002a55cc: 910083fd    	add	x29, sp, #0x20
1002a55d0: d00e9a48    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1002a55d4: f9405908    	ldr	x8, [x8, #0xb0]
1002a55d8: f9400108    	ldr	x8, [x8]
1002a55dc: f90007e8    	str	x8, [sp, #0x8]
1002a55e0: f00fdcc8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1002a55e4: f9464101    	ldr	x1, [x8, #0xc80] ; deleteMenuItem
1002a55e8: 95e606d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a55ec: aa1d03fd    	mov	x29, x29
1002a55f0: 95e606d6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a55f4: aa0003f4    	mov	x20, x0
1002a55f8: f90003e0    	str	x0, [sp]
1002a55fc: d00ff668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a5600: f9456d00    	ldr	x0, [x8, #0xad8]
1002a5604: d00ff2c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002a5608: f941c501    	ldr	x1, [x8, #0x388] ; arrayWithObjects:count:
1002a560c: 910003e2    	mov	x2, sp
1002a5610: 52800023    	mov	w3, #0x1                ; =1
1002a5614: 95e606ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a5618: aa1d03fd    	mov	x29, x29
1002a561c: 95e606cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a5620: aa0003f3    	mov	x19, x0
1002a5624: aa1403e0    	mov	x0, x20
1002a5628: 95e606cb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a562c: f94007e8    	ldr	x8, [sp, #0x8]
1002a5630: d00e9a49    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1002a5634: f9405929    	ldr	x9, [x9, #0xb0]
1002a5638: f9400129    	ldr	x9, [x9]
1002a563c: eb08013f    	cmp	x9, x8
1002a5640: 540000c1    	b.ne	0x1002a5658 <__text+0x29d658>
1002a5644: aa1303e0    	mov	x0, x19
1002a5648: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1002a564c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1002a5650: 9100c3ff    	add	sp, sp, #0x30
1002a5654: 15e606c7    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
1002a5658: 95e606c7    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>