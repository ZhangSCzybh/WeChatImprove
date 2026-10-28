
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1051861ac: d100c3ff    	sub	sp, sp, #0x30
1051861b0: a9014ff4    	stp	x20, x19, [sp, #0x10]
1051861b4: a9027bfd    	stp	x29, x30, [sp, #0x20]
1051861b8: 910083fd    	add	x29, sp, #0x20
1051861bc: aa0003f3    	mov	x19, x0
1051861c0: b00d7f68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1051861c4: f9453500    	ldr	x0, [x8, #0xa68]
1051861c8: f00d6588    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1051861cc: f942a901    	ldr	x1, [x8, #0x550]
1051861d0: d00cb288    	adrp	x8, 0x11e7d8000 <dyld_stub_binder+0x11e7d8000>
1051861d4: 91152108    	add	x8, x8, #0x548
1051861d8: f90003e8    	str	x8, [sp]
1051861dc: d00b0ec3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
1051861e0: 91270063    	add	x3, x3, #0x9c0
1051861e4: 900b36c5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
1051861e8: 912b00a5    	add	x5, x5, #0xac0
1051861ec: b00b36c7    	adrp	x7, 0x11b85f000 <dyld_stub_binder+0x11b85f000>
1051861f0: 911bb8e7    	add	x7, x7, #0x6ee
1051861f4: 52800042    	mov	w2, #0x2                ; =2
1051861f8: 52800004    	mov	w4, #0x0                ; =0
1051861fc: 52808546    	mov	w6, #0x42a              ; =1066
105186200: 94aa83cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105186204: d00d8508    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105186208: b9891908    	ldrsw	x8, [x8, #0x918]
10518620c: 38286a7f    	strb	wzr, [x19, x8]
105186210: b00d7f68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105186214: f945e900    	ldr	x0, [x8, #0xbd0]
105186218: d00d7bc8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10518621c: f944e901    	ldr	x1, [x8, #0x9d0]
105186220: 94aa83c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105186224: aa1d03fd    	mov	x29, x29
105186228: 94aa83c8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10518622c: aa0003f3    	mov	x19, x0
105186230: d00d7f88    	adrp	x8, 0x120178000 <dyld_stub_binder+0x120178000>
105186234: f944c100    	ldr	x0, [x8, #0x980]
105186238: b00d7bc8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10518623c: f947ad01    	ldr	x1, [x8, #0xf58]
105186240: 94aa83bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105186244: aa0003e2    	mov	x2, x0
105186248: f00d6588    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10518624c: f9464101    	ldr	x1, [x8, #0xc80]
105186250: aa1303e0    	mov	x0, x19
105186254: 94aa83ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105186258: aa1d03fd    	mov	x29, x29
10518625c: 94aa83bb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105186260: aa0003f4    	mov	x20, x0
105186264: d00d70a8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105186268: f9430901    	ldr	x1, [x8, #0x610]
10518626c: 52800002    	mov	w2, #0x0                ; =0
105186270: 94aa83b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105186274: aa1403e0    	mov	x0, x20
105186278: 94aa83b7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10518627c: aa1303e0    	mov	x0, x19
105186280: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105186284: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105186288: 9100c3ff    	add	sp, sp, #0x30
10518628c: 14aa83b2    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
