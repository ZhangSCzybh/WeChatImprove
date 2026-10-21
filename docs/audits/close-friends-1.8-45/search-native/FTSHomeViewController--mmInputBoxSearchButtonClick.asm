
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101764268: d100c3ff    	sub	sp, sp, #0x30
10176426c: a9014ff4    	stp	x20, x19, [sp, #0x10]
101764270: a9027bfd    	stp	x29, x30, [sp, #0x20]
101764274: 910083fd    	add	x29, sp, #0x20
101764278: aa0003f3    	mov	x19, x0
10176427c: f00f5068    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101764280: f9453500    	ldr	x0, [x8, #0xa68]
101764284: b00f36a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101764288: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10176428c: f00e7168    	adrp	x8, 0x11e593000 <dyld_stub_binder+0x11e593000>
101764290: 91002108    	add	x8, x8, #0x8
101764294: f90003e8    	str	x8, [sp]
101764298: 900cd883    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
10176429c: 91388063    	add	x3, x3, #0xe20
1017642a0: f00ce3e5    	adrp	x5, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
1017642a4: 911b74a5    	add	x5, x5, #0x6dd
1017642a8: f00ce3e7    	adrp	x7, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
1017642ac: 913434e7    	add	x7, x7, #0xd0d
1017642b0: 52800042    	mov	w2, #0x2                ; =2
1017642b4: 52800004    	mov	w4, #0x0                ; =0
1017642b8: 528062c6    	mov	w6, #0x316              ; =790
1017642bc: 95930ba0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017642c0: 900f3828    	adrp	x8, 0x11fe68000 <dyld_stub_binder+0x11fe68000>
1017642c4: f946f101    	ldr	x1, [x8, #0xde0] ; presenter
1017642c8: aa1303e0    	mov	x0, x19
1017642cc: 95930b9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017642d0: aa1d03fd    	mov	x29, x29
1017642d4: 95930b9d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017642d8: aa0003f4    	mov	x20, x0
1017642dc: b00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017642e0: f9412101    	ldr	x1, [x8, #0x240] ; setIsKeyBoardSearch:
1017642e4: 52800002    	mov	w2, #0x0                ; =0
1017642e8: 95930b95    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017642ec: aa1403e0    	mov	x0, x20
1017642f0: 95930b99    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017642f4: b00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017642f8: f9415101    	ldr	x1, [x8, #0x2a0] ; shouldReturnStartSearch
1017642fc: aa1303e0    	mov	x0, x19
101764300: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101764304: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101764308: 9100c3ff    	add	sp, sp, #0x30
10176430c: 15930b8c    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
