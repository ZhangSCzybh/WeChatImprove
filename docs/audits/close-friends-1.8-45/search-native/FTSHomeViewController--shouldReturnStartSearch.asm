
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1017638f4: d10103ff    	sub	sp, sp, #0x40
1017638f8: a90157f6    	stp	x22, x21, [sp, #0x10]
1017638fc: a9024ff4    	stp	x20, x19, [sp, #0x20]
101763900: a9037bfd    	stp	x29, x30, [sp, #0x30]
101763904: 9100c3fd    	add	x29, sp, #0x30
101763908: aa0003f3    	mov	x19, x0
10176390c: 900f5088    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101763910: f9453515    	ldr	x21, [x8, #0xa68]
101763914: b00f3828    	adrp	x8, 0x11fe68000 <dyld_stub_binder+0x11fe68000>
101763918: f946f114    	ldr	x20, [x8, #0xde0] ; presenter
10176391c: aa1403e1    	mov	x1, x20
101763920: 95930e07    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101763924: aa1d03fd    	mov	x29, x29
101763928: 95930e08    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10176392c: aa0003f6    	mov	x22, x0
101763930: d00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101763934: f9411901    	ldr	x1, [x8, #0x230] ; isKeyBoardSearch
101763938: 95930e01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10176393c: b00e69c8    	adrp	x8, 0x11e49c000 <dyld_stub_binder+0x11e49c000>
101763940: 91002108    	add	x8, x8, #0x8
101763944: 900e69c9    	adrp	x9, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
101763948: 913fa129    	add	x9, x9, #0xfe8
10176394c: 7100001f    	cmp	w0, #0x0
101763950: 9a881128    	csel	x8, x9, x8, ne
101763954: d00f36a9    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101763958: f942a921    	ldr	x1, [x9, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10176395c: f00e7169    	adrp	x9, 0x11e592000 <dyld_stub_binder+0x11e592000>
101763960: 913e2129    	add	x9, x9, #0xf88
101763964: a90023e9    	stp	x9, x8, [sp]
101763968: b00cd883    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
10176396c: 91388063    	add	x3, x3, #0xe20
101763970: 900ce405    	adrp	x5, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
101763974: 911b74a5    	add	x5, x5, #0x6dd
101763978: 900ce407    	adrp	x7, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
10176397c: 912f64e7    	add	x7, x7, #0xbd9
101763980: aa1503e0    	mov	x0, x21
101763984: 52800042    	mov	w2, #0x2                ; =2
101763988: 52800004    	mov	w4, #0x0                ; =0
10176398c: 52805ba6    	mov	w6, #0x2dd              ; =733
101763990: 95930deb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101763994: aa1603e0    	mov	x0, x22
101763998: 95930def    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10176399c: 900f36c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1017639a0: f9478d01    	ldr	x1, [x8, #0xf18] ; searchBar
1017639a4: aa1303e0    	mov	x0, x19
1017639a8: 95930de5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017639ac: aa1d03fd    	mov	x29, x29
1017639b0: 95930de6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017639b4: aa0003f5    	mov	x21, x0
1017639b8: 900f3948    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1017639bc: f9427101    	ldr	x1, [x8, #0x4e0] ; inputBoxResignFirstResponder
1017639c0: 95930ddf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017639c4: aa1503e0    	mov	x0, x21
1017639c8: 95930de3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017639cc: aa1303e0    	mov	x0, x19
1017639d0: aa1403e1    	mov	x1, x20
1017639d4: 95930dda    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017639d8: aa1d03fd    	mov	x29, x29
1017639dc: 95930ddb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017639e0: aa0003f5    	mov	x21, x0
1017639e4: d00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017639e8: f9411d01    	ldr	x1, [x8, #0x238] ; onClickSearchButton
1017639ec: 95930dd4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017639f0: aa1503e0    	mov	x0, x21
1017639f4: 95930dd8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017639f8: aa1303e0    	mov	x0, x19
1017639fc: aa1403e1    	mov	x1, x20
101763a00: 95930dcf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101763a04: aa1d03fd    	mov	x29, x29
101763a08: 95930dd0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101763a0c: aa0003f4    	mov	x20, x0
101763a10: d00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101763a14: f9412101    	ldr	x1, [x8, #0x240] ; setIsKeyBoardSearch:
101763a18: 52800002    	mov	w2, #0x0                ; =0
101763a1c: 95930dc8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101763a20: aa1403e0    	mov	x0, x20
101763a24: 95930dcc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101763a28: d00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101763a2c: f9412501    	ldr	x1, [x8, #0x248] ; setJumpToSearchByVoiceInputInDeepThinking:
101763a30: aa1303e0    	mov	x0, x19
101763a34: 52800002    	mov	w2, #0x0                ; =0
101763a38: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101763a3c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101763a40: a94157f6    	ldp	x22, x21, [sp, #0x10]
101763a44: 910103ff    	add	sp, sp, #0x40
101763a48: 15930dbd    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
