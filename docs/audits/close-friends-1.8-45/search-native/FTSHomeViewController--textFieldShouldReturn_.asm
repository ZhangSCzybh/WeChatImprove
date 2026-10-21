
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101764460: d100c3ff    	sub	sp, sp, #0x30
101764464: a9014ff4    	stp	x20, x19, [sp, #0x10]
101764468: a9027bfd    	stp	x29, x30, [sp, #0x20]
10176446c: 910083fd    	add	x29, sp, #0x20
101764470: aa0003f3    	mov	x19, x0
101764474: f00f5068    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101764478: f9453500    	ldr	x0, [x8, #0xa68]
10176447c: b00f36a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101764480: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
101764484: f00e7168    	adrp	x8, 0x11e593000 <dyld_stub_binder+0x11e593000>
101764488: 91012108    	add	x8, x8, #0x48
10176448c: f90003e8    	str	x8, [sp]
101764490: 900cd883    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
101764494: 91388063    	add	x3, x3, #0xe20
101764498: f00ce3e5    	adrp	x5, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
10176449c: 911b74a5    	add	x5, x5, #0x6dd
1017644a0: f00ce3e7    	adrp	x7, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
1017644a4: 91369ce7    	add	x7, x7, #0xda7
1017644a8: 52800042    	mov	w2, #0x2                ; =2
1017644ac: 52800004    	mov	w4, #0x0                ; =0
1017644b0: 528065e6    	mov	w6, #0x32f              ; =815
1017644b4: 95930b22    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017644b8: 900f3828    	adrp	x8, 0x11fe68000 <dyld_stub_binder+0x11fe68000>
1017644bc: f946f101    	ldr	x1, [x8, #0xde0] ; presenter
1017644c0: aa1303e0    	mov	x0, x19
1017644c4: 95930b1e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017644c8: aa1d03fd    	mov	x29, x29
1017644cc: 95930b1f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017644d0: aa0003f4    	mov	x20, x0
1017644d4: b00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017644d8: f9412101    	ldr	x1, [x8, #0x240] ; setIsKeyBoardSearch:
1017644dc: 52800022    	mov	w2, #0x1                ; =1
1017644e0: 95930b17    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017644e4: aa1403e0    	mov	x0, x20
1017644e8: 95930b1b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017644ec: b00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017644f0: f9415101    	ldr	x1, [x8, #0x2a0] ; shouldReturnStartSearch
1017644f4: aa1303e0    	mov	x0, x19
1017644f8: 95930b11    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017644fc: 52800020    	mov	w0, #0x1                ; =1
101764500: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101764504: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101764508: 9100c3ff    	add	sp, sp, #0x30
10176450c: d65f03c0    	ret
