
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101764310: d100c3ff    	sub	sp, sp, #0x30
101764314: a9014ff4    	stp	x20, x19, [sp, #0x10]
101764318: a9027bfd    	stp	x29, x30, [sp, #0x20]
10176431c: 910083fd    	add	x29, sp, #0x20
101764320: aa0003f3    	mov	x19, x0
101764324: f00f5068    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101764328: f9453500    	ldr	x0, [x8, #0xa68]
10176432c: b00f36a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101764330: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
101764334: f00e7168    	adrp	x8, 0x11e593000 <dyld_stub_binder+0x11e593000>
101764338: 9100a108    	add	x8, x8, #0x28
10176433c: f90003e8    	str	x8, [sp]
101764340: 900cd883    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
101764344: 91388063    	add	x3, x3, #0xe20
101764348: f00ce3e5    	adrp	x5, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
10176434c: 911b74a5    	add	x5, x5, #0x6dd
101764350: f00ce3e7    	adrp	x7, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
101764354: 913578e7    	add	x7, x7, #0xd5e
101764358: 52800042    	mov	w2, #0x2                ; =2
10176435c: 52800004    	mov	w4, #0x0                ; =0
101764360: 52806386    	mov	w6, #0x31c              ; =796
101764364: 95930b76    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101764368: 900f3828    	adrp	x8, 0x11fe68000 <dyld_stub_binder+0x11fe68000>
10176436c: f946f101    	ldr	x1, [x8, #0xde0] ; presenter
101764370: aa1303e0    	mov	x0, x19
101764374: 95930b72    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101764378: aa1d03fd    	mov	x29, x29
10176437c: 95930b73    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101764380: aa0003f4    	mov	x20, x0
101764384: b00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101764388: f9412101    	ldr	x1, [x8, #0x240] ; setIsKeyBoardSearch:
10176438c: 52800022    	mov	w2, #0x1                ; =1
101764390: 95930b6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101764394: aa1403e0    	mov	x0, x20
101764398: 95930b6f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10176439c: b00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017643a0: f9415101    	ldr	x1, [x8, #0x2a0] ; shouldReturnStartSearch
1017643a4: aa1303e0    	mov	x0, x19
1017643a8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1017643ac: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1017643b0: 9100c3ff    	add	sp, sp, #0x30
1017643b4: 15930b62    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
