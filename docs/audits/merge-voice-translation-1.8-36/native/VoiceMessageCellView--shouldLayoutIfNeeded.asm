
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1062833b0: 900d4e08    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
1062833b4: 52800029    	mov	w9, #0x1                ; =1
1062833b8: 39285509    	strb	w9, [x8, #0xa15]
1062833bc: b00cfda8    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
1062833c0: b98d9d08    	ldrsw	x8, [x8, #0xd9c]
1062833c4: 38686808    	ldrb	w8, [x0, x8]
1062833c8: 36000068    	tbz	w8, #0x0, 0x1062833d4 <_Flutter_MMFoundation_BindContext+0x275efb8>
1062833cc: 52800000    	mov	w0, #0x0                ; =0
1062833d0: d65f03c0    	ret
1062833d4: d10143ff    	sub	sp, sp, #0x50
1062833d8: 6d0123e9    	stp	d9, d8, [sp, #0x10]
1062833dc: a90257f6    	stp	x22, x21, [sp, #0x20]
1062833e0: a9034ff4    	stp	x20, x19, [sp, #0x30]
1062833e4: a9047bfd    	stp	x29, x30, [sp, #0x40]
1062833e8: 910103fd    	add	x29, sp, #0x40
1062833ec: aa0003f3    	mov	x19, x0
1062833f0: b00cfda8    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
1062833f4: b98da108    	ldrsw	x8, [x8, #0xda0]
1062833f8: 38686808    	ldrb	w8, [x0, x8]
1062833fc: 370000a8    	tbnz	w8, #0x0, 0x106283410 <_Flutter_MMFoundation_BindContext+0x275eff4>
106283400: b00cfda8    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
106283404: b98d9908    	ldrsw	x8, [x8, #0xd98]
106283408: 38686a68    	ldrb	w8, [x19, x8]
10628340c: 36000108    	tbz	w8, #0x0, 0x10628342c <_Flutter_MMFoundation_BindContext+0x275f010>
106283410: 52800000    	mov	w0, #0x0                ; =0
106283414: a9447bfd    	ldp	x29, x30, [sp, #0x40]
106283418: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10628341c: a94257f6    	ldp	x22, x21, [sp, #0x20]
106283420: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
106283424: 910143ff    	add	sp, sp, #0x50
106283428: d65f03c0    	ret
10628342c: 900cfae8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
106283430: 910a8108    	add	x8, x8, #0x2a0
106283434: b9800115    	ldrsw	x21, [x8]
106283438: f8756a68    	ldr	x8, [x19, x21]
10628343c: b40002e8    	cbz	x8, 0x106283498 <_Flutter_MMFoundation_BindContext+0x275f07c>
106283440: f00cddc8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
106283444: f9410901    	ldr	x1, [x8, #0x210] ; viewModel
106283448: aa1303e0    	mov	x0, x19
10628344c: 94668f3c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106283450: aa1d03fd    	mov	x29, x29
106283454: 94668f3d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106283458: aa0003f4    	mov	x20, x0
10628345c: 900cea88    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106283460: f9471901    	ldr	x1, [x8, #0xe30] ; voiceNodeHeight
106283464: 94668f36    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106283468: 1e604008    	fmov	d8, d0
10628346c: f8756a60    	ldr	x0, [x19, x21]
106283470: f00cf428    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106283474: f9442501    	ldr	x1, [x8, #0x848] ; size
106283478: 94668f31    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628347c: 1e604029    	fmov	d9, d1
106283480: aa1403e0    	mov	x0, x20
106283484: 94668f34    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106283488: 1e692100    	fcmp	d8, d9
10628348c: 5400006d    	b.le	0x106283498 <_Flutter_MMFoundation_BindContext+0x275f07c>
106283490: 52800020    	mov	w0, #0x1                ; =1
106283494: 17ffffe0    	b	0x106283414 <_Flutter_MMFoundation_BindContext+0x275eff8>
106283498: d00cfa28    	adrp	x8, 0x1201c9000 <dyld_stub_binder+0x1201c9000>
10628349c: f9400908    	ldr	x8, [x8, #0x10] ; @<; 
1062834a0: a90023f3    	stp	x19, x8, [sp]
1062834a4: d00cdde8    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
1062834a8: f9402101    	ldr	x1, [x8, #0x40] ; shouldLayoutIfNeeded
1062834ac: 910003e0    	mov	x0, sp
1062834b0: 94668f25    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
1062834b4: 17ffffd8    	b	0x106283414 <_Flutter_MMFoundation_BindContext+0x275eff8>