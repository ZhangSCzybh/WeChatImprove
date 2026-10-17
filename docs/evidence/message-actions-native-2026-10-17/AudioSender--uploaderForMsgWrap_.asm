
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100176448: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10017644c: a9014ff4    	stp	x20, x19, [sp, #0x10]
100176450: a9027bfd    	stp	x29, x30, [sp, #0x20]
100176454: 910083fd    	add	x29, sp, #0x20
100176458: aa0003f3    	mov	x19, x0
10017645c: d00fffe8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100176460: f9400114    	ldr	x20, [x8]
100176464: f00fe628    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
100176468: f9479d01    	ldr	x1, [x8, #0xf38] ; GetChatName
10017646c: aa0203e0    	mov	x0, x2
100176470: 95eac333    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100176474: aa1d03fd    	mov	x29, x29
100176478: 95eac334    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017647c: aa0003f5    	mov	x21, x0
100176480: b00fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100176484: f9447901    	ldr	x1, [x8, #0x8f0] ; IsBypMsgUserName:
100176488: aa1403e0    	mov	x0, x20
10017648c: aa1503e2    	mov	x2, x21
100176490: 95eac32b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100176494: aa0003f4    	mov	x20, x0
100176498: aa1503e0    	mov	x0, x21
10017649c: 95eac32e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001764a0: 34000114    	cbz	w20, 0x1001764c0 <__text+0x16e4c0>
1001764a4: b00fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1001764a8: f9447501    	ldr	x1, [x8, #0x8e8] ; bypUploader
1001764ac: aa1303e0    	mov	x0, x19
1001764b0: 95eac323    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001764b4: aa1d03fd    	mov	x29, x29
1001764b8: 95eac324    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001764bc: 14000005    	b	0x1001764d0 <__text+0x16e4d0>
1001764c0: 90100348    	adrp	x8, 0x1201de000 <dyld_stub_binder+0x1201de000>
1001764c4: b9829508    	ldrsw	x8, [x8, #0x294]
1001764c8: f8686a60    	ldr	x0, [x19, x8]
1001764cc: 95eac31b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1001764d0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1001764d4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1001764d8: a8c357f6    	ldp	x22, x21, [sp], #0x30
1001764dc: 15eac325    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>