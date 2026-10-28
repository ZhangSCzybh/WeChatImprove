
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10518287c: d10183ff    	sub	sp, sp, #0x60
105182880: a9025ff8    	stp	x24, x23, [sp, #0x20]
105182884: a90357f6    	stp	x22, x21, [sp, #0x30]
105182888: a9044ff4    	stp	x20, x19, [sp, #0x40]
10518288c: a9057bfd    	stp	x29, x30, [sp, #0x50]
105182890: 910143fd    	add	x29, sp, #0x50
105182894: aa0203f4    	mov	x20, x2
105182898: aa0003f3    	mov	x19, x0
10518289c: b00dd5e8    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
1051828a0: 52800037    	mov	w23, #0x1               ; =1
1051828a4: 39337517    	strb	w23, [x8, #0xcdd]
1051828a8: b00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1051828ac: f945e900    	ldr	x0, [x8, #0xbd0]
1051828b0: d00d7be8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1051828b4: f944e901    	ldr	x1, [x8, #0x9d0]
1051828b8: 94aa9221    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051828bc: aa1d03fd    	mov	x29, x29
1051828c0: 94aa9222    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051828c4: aa0003f5    	mov	x21, x0
1051828c8: f00d65c8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1051828cc: f9416d01    	ldr	x1, [x8, #0x2d8]
1051828d0: 94aa921b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051828d4: aa0003f6    	mov	x22, x0
1051828d8: aa1503e0    	mov	x0, x21
1051828dc: 94aa921e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051828e0: 340004b6    	cbz	w22, 0x105182974 <_Flutter_MMFoundation_BindContext+0x165e558>
1051828e4: 7100069f    	cmp	w20, #0x1
1051828e8: 528000e8    	mov	w8, #0x7                ; =7
1051828ec: 1a94b114    	csel	w20, w8, w20, lt
1051828f0: b00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1051828f4: f9453500    	ldr	x0, [x8, #0xa68]
1051828f8: d00d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051828fc: b9890915    	ldrsw	x21, [x8, #0x908]
105182900: 38756a68    	ldrb	w8, [x19, x21]
105182904: f00d65a9    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105182908: f942a921    	ldr	x1, [x9, #0x550]
10518290c: a900d3e8    	stp	x8, x20, [sp, #0x8]
105182910: b00cb2a9    	adrp	x9, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
105182914: 913e2129    	add	x9, x9, #0xf88
105182918: f90003e9    	str	x9, [sp]
10518291c: d00b0ee3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
105182920: 91270063    	add	x3, x3, #0x9c0
105182924: 900b36e5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105182928: 912b00a5    	add	x5, x5, #0xac0
10518292c: 900b36e7    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105182930: 913a44e7    	add	x7, x7, #0xe91
105182934: 52800042    	mov	w2, #0x2                ; =2
105182938: 52800004    	mov	w4, #0x0                ; =0
10518293c: 52803be6    	mov	w6, #0x1df              ; =479
105182940: 94aa91ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182944: aa1303e0    	mov	x0, x19
105182948: 94aa91fc    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10518294c: 94aa921c    	bl	0x107c271bc <_Flutter_MMFoundation_BindContext+0x4102da0>
105182950: d00d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105182954: b9892908    	ldrsw	x8, [x8, #0x928]
105182958: b8286a74    	str	w20, [x19, x8]
10518295c: aa1303e0    	mov	x0, x19
105182960: 94aa9225    	bl	0x107c271f4 <_Flutter_MMFoundation_BindContext+0x4102dd8>
105182964: aa1303e0    	mov	x0, x19
105182968: 94aa91fb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10518296c: 38356a77    	strb	w23, [x19, x21]
105182970: 14000012    	b	0x1051829b8 <_Flutter_MMFoundation_BindContext+0x165e59c>
105182974: b00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105182978: f9453500    	ldr	x0, [x8, #0xa68]
10518297c: f00d65a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105182980: f942a901    	ldr	x1, [x8, #0x550]
105182984: b00cb2a8    	adrp	x8, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
105182988: 913da108    	add	x8, x8, #0xf68
10518298c: a90053e8    	stp	x8, x20, [sp]
105182990: d00b0ee3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
105182994: 91270063    	add	x3, x3, #0x9c0
105182998: 900b36e5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
10518299c: 912b00a5    	add	x5, x5, #0xac0
1051829a0: 900b36e7    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
1051829a4: 913a44e7    	add	x7, x7, #0xe91
1051829a8: 52800062    	mov	w2, #0x3                ; =3
1051829ac: 52800004    	mov	w4, #0x0                ; =0
1051829b0: 52803b26    	mov	w6, #0x1d9              ; =473
1051829b4: 94aa91e2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051829b8: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1051829bc: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1051829c0: a94357f6    	ldp	x22, x21, [sp, #0x30]
1051829c4: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1051829c8: 910183ff    	add	sp, sp, #0x60
1051829cc: d65f03c0    	ret
