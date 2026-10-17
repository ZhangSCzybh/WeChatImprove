
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10079219c: f0102648    	adrp	x8, 0x120c5d000 <dyld_stub_binder+0x120c5d000>
1007921a0: f9422108    	ldr	x8, [x8, #0x440]
1007921a4: b100051f    	cmn	x8, #0x1
1007921a8: 54000081    	b.ne	0x1007921b8 <__text+0x78a1b8>
1007921ac: f0102648    	adrp	x8, 0x120c5d000 <dyld_stub_binder+0x120c5d000>
1007921b0: f9421d00    	ldr	x0, [x8, #0x438]
1007921b4: 15d253e6    	b	0x107c2714c <_Flutter_MMFoundation_BindContext+0x4102d30>
1007921b8: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
1007921bc: 910003fd    	mov	x29, sp
1007921c0: 95d1d8f1    	bl	0x107c08584 <_Flutter_MMFoundation_BindContext+0x40e4168>
1007921c4: a8c17bfd    	ldp	x29, x30, [sp], #0x10
1007921c8: 17fffff9    	b	0x1007921ac <__text+0x78a1ac>
1007921cc: d10183ff    	sub	sp, sp, #0x60
1007921d0: a9025ff8    	stp	x24, x23, [sp, #0x20]
1007921d4: a90357f6    	stp	x22, x21, [sp, #0x30]
1007921d8: a9044ff4    	stp	x20, x19, [sp, #0x40]
1007921dc: a9057bfd    	stp	x29, x30, [sp, #0x50]
1007921e0: 910143fd    	add	x29, sp, #0x50
1007921e4: d00fcf08    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1007921e8: f9406914    	ldr	x20, [x8, #0xd0]
1007921ec: b00fcf18    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
1007921f0: f9458b00    	ldr	x0, [x24, #0xb10]
1007921f4: d00fcb88    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1007921f8: f947a915    	ldr	x21, [x8, #0xf50] ; numberWithInteger:
1007921fc: aa1503e1    	mov	x1, x21
100792200: 528002c2    	mov	w2, #0x16               ; =22
100792204: 95d253ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100792208: aa1d03fd    	mov	x29, x29
10079220c: 95d253cf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100792210: aa0003f3    	mov	x19, x0
100792214: f9458b00    	ldr	x0, [x24, #0xb10]
100792218: aa1503e1    	mov	x1, x21
10079221c: 528003a2    	mov	w2, #0x1d               ; =29
100792220: 95d253c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100792224: aa1d03fd    	mov	x29, x29
100792228: 95d253c8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10079222c: aa0003f6    	mov	x22, x0
100792230: f9458b00    	ldr	x0, [x24, #0xb10]
100792234: aa1503e1    	mov	x1, x21
100792238: 52800382    	mov	w2, #0x1c               ; =28
10079223c: 95d253c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100792240: aa1d03fd    	mov	x29, x29
100792244: 95d253c1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100792248: aa0003f7    	mov	x23, x0
10079224c: f9458b00    	ldr	x0, [x24, #0xb10]
100792250: aa1503e1    	mov	x1, x21
100792254: 52800542    	mov	w2, #0x2a               ; =42
100792258: 95d253b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10079225c: aa1d03fd    	mov	x29, x29
100792260: 95d253ba    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100792264: aa0003f5    	mov	x21, x0
100792268: 900fb588    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
10079226c: f9472d01    	ldr	x1, [x8, #0xe58] ; setWithObjects:
100792270: a9017fe0    	stp	x0, xzr, [sp, #0x10]
100792274: a9005ff6    	stp	x22, x23, [sp]
100792278: aa1403e0    	mov	x0, x20
10079227c: aa1303e2    	mov	x2, x19
100792280: 95d253af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100792284: aa1d03fd    	mov	x29, x29
100792288: 95d253b0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10079228c: f0102649    	adrp	x9, 0x120c5d000 <dyld_stub_binder+0x120c5d000>
100792290: f9421d28    	ldr	x8, [x9, #0x438]
100792294: f9021d20    	str	x0, [x9, #0x438]
100792298: aa0803e0    	mov	x0, x8
10079229c: 95d253ae    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1007922a0: aa1503e0    	mov	x0, x21
1007922a4: 95d253ac    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1007922a8: aa1703e0    	mov	x0, x23
1007922ac: 95d253aa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1007922b0: aa1603e0    	mov	x0, x22
1007922b4: 95d253a8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1007922b8: aa1303e0    	mov	x0, x19
1007922bc: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1007922c0: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1007922c4: a94357f6    	ldp	x22, x21, [sp, #0x30]
1007922c8: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1007922cc: 910183ff    	add	sp, sp, #0x60
1007922d0: 15d253a1    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>