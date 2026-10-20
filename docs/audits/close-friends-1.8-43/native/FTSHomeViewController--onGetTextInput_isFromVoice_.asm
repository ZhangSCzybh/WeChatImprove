
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101767980: d10143ff    	sub	sp, sp, #0x50
101767984: a9015ff8    	stp	x24, x23, [sp, #0x10]
101767988: a90257f6    	stp	x22, x21, [sp, #0x20]
10176798c: a9034ff4    	stp	x20, x19, [sp, #0x30]
101767990: a9047bfd    	stp	x29, x30, [sp, #0x40]
101767994: 910103fd    	add	x29, sp, #0x40
101767998: aa0303f5    	mov	x21, x3
10176799c: aa0203f4    	mov	x20, x2
1017679a0: aa0003f3    	mov	x19, x0
1017679a4: 900f5068    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1017679a8: f9453516    	ldr	x22, [x8, #0xa68]
1017679ac: d00f3688    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1017679b0: f942a917    	ldr	x23, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1017679b4: aa0203e0    	mov	x0, x2
1017679b8: 9592fde0    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1017679bc: 900e7168    	adrp	x8, 0x11e593000 <dyld_stub_binder+0x11e593000>
1017679c0: 91112108    	add	x8, x8, #0x448
1017679c4: a90053e8    	stp	x8, x20, [sp]
1017679c8: 900ce3e5    	adrp	x5, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
1017679cc: 911b74a5    	add	x5, x5, #0x6dd
1017679d0: b00ce3e7    	adrp	x7, 0x11b3e4000 <dyld_stub_binder+0x11b3e4000>
1017679d4: 911a2ce7    	add	x7, x7, #0x68b
1017679d8: aa1603e0    	mov	x0, x22
1017679dc: aa1703e1    	mov	x1, x23
1017679e0: 52800022    	mov	w2, #0x1                ; =1
1017679e4: d2800003    	mov	x3, #0x0                ; =0
1017679e8: 52800004    	mov	w4, #0x0                ; =0
1017679ec: 5280a946    	mov	w6, #0x54a              ; =1354
1017679f0: 9592fdd3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017679f4: d00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017679f8: f9414516    	ldr	x22, [x8, #0x288] ; setIsFromVoice:
1017679fc: aa1303e0    	mov	x0, x19
101767a00: aa1603e1    	mov	x1, x22
101767a04: aa1503e2    	mov	x2, x21
101767a08: 9592fdcd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101767a0c: b00f3808    	adrp	x8, 0x11fe68000 <dyld_stub_binder+0x11fe68000>
101767a10: f946f101    	ldr	x1, [x8, #0xde0] ; presenter
101767a14: aa1303e0    	mov	x0, x19
101767a18: 9592fdc9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101767a1c: aa1d03fd    	mov	x29, x29
101767a20: 9592fdca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101767a24: aa0003f7    	mov	x23, x0
101767a28: aa1603e1    	mov	x1, x22
101767a2c: aa1503e2    	mov	x2, x21
101767a30: 9592fdc3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101767a34: aa1703e0    	mov	x0, x23
101767a38: 9592fdc7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101767a3c: 900f36a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101767a40: f9478d01    	ldr	x1, [x8, #0xf18] ; searchBar
101767a44: aa1303e0    	mov	x0, x19
101767a48: 9592fdbd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101767a4c: aa1d03fd    	mov	x29, x29
101767a50: 9592fdbe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101767a54: aa0003f5    	mov	x21, x0
101767a58: 900f3a08    	adrp	x8, 0x11fea7000 <dyld_stub_binder+0x11fea7000>
101767a5c: f9453901    	ldr	x1, [x8, #0xa70] ; inputBoxSetText:
101767a60: aa1403e2    	mov	x2, x20
101767a64: 9592fdb6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101767a68: aa1403e0    	mov	x0, x20
101767a6c: 9592fdba    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101767a70: aa1503e0    	mov	x0, x21
101767a74: 9592fdb8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101767a78: aa1303e0    	mov	x0, x19
101767a7c: aa1603e1    	mov	x1, x22
101767a80: 52800002    	mov	w2, #0x0                ; =0
101767a84: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101767a88: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101767a8c: a94257f6    	ldp	x22, x21, [sp, #0x20]
101767a90: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101767a94: 910143ff    	add	sp, sp, #0x50
101767a98: 1592fda9    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
