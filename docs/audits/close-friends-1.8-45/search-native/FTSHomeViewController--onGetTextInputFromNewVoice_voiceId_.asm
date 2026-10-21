
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101767a9c: d10143ff    	sub	sp, sp, #0x50
101767aa0: a9015ff8    	stp	x24, x23, [sp, #0x10]
101767aa4: a90257f6    	stp	x22, x21, [sp, #0x20]
101767aa8: a9034ff4    	stp	x20, x19, [sp, #0x30]
101767aac: a9047bfd    	stp	x29, x30, [sp, #0x40]
101767ab0: 910103fd    	add	x29, sp, #0x40
101767ab4: aa0303f5    	mov	x21, x3
101767ab8: aa0203f3    	mov	x19, x2
101767abc: aa0003f4    	mov	x20, x0
101767ac0: 900f5068    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101767ac4: f9453516    	ldr	x22, [x8, #0xa68]
101767ac8: d00f3688    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101767acc: f942a917    	ldr	x23, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
101767ad0: aa0303e0    	mov	x0, x3
101767ad4: 9592fd99    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101767ad8: aa1303e0    	mov	x0, x19
101767adc: 9592fd97    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101767ae0: 900e7168    	adrp	x8, 0x11e593000 <dyld_stub_binder+0x11e593000>
101767ae4: 9111a108    	add	x8, x8, #0x468
101767ae8: a9004fe8    	stp	x8, x19, [sp]
101767aec: 900ce3e5    	adrp	x5, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
101767af0: 911b74a5    	add	x5, x5, #0x6dd
101767af4: b00ce3e7    	adrp	x7, 0x11b3e4000 <dyld_stub_binder+0x11b3e4000>
101767af8: 911b88e7    	add	x7, x7, #0x6e2
101767afc: aa1603e0    	mov	x0, x22
101767b00: aa1703e1    	mov	x1, x23
101767b04: 52800022    	mov	w2, #0x1                ; =1
101767b08: d2800003    	mov	x3, #0x0                ; =0
101767b0c: 52800004    	mov	w4, #0x0                ; =0
101767b10: 5280aa46    	mov	w6, #0x552              ; =1362
101767b14: 9592fd8a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101767b18: b00f38a8    	adrp	x8, 0x11fe7c000 <dyld_stub_binder+0x11fe7c000>
101767b1c: f946d101    	ldr	x1, [x8, #0xda0] ; setVoiceId:
101767b20: aa1403e0    	mov	x0, x20
101767b24: aa1503e2    	mov	x2, x21
101767b28: 9592fd85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101767b2c: aa1503e0    	mov	x0, x21
101767b30: 9592fd89    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101767b34: d00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101767b38: f9414515    	ldr	x21, [x8, #0x288] ; setIsFromVoice:
101767b3c: aa1403e0    	mov	x0, x20
101767b40: aa1503e1    	mov	x1, x21
101767b44: 52800022    	mov	w2, #0x1                ; =1
101767b48: 9592fd7d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101767b4c: b00f3808    	adrp	x8, 0x11fe68000 <dyld_stub_binder+0x11fe68000>
101767b50: f946f101    	ldr	x1, [x8, #0xde0] ; presenter
101767b54: aa1403e0    	mov	x0, x20
101767b58: 9592fd79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101767b5c: aa1d03fd    	mov	x29, x29
101767b60: 9592fd7a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101767b64: aa0003f6    	mov	x22, x0
101767b68: aa1503e1    	mov	x1, x21
101767b6c: 52800022    	mov	w2, #0x1                ; =1
101767b70: 9592fd73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101767b74: aa1603e0    	mov	x0, x22
101767b78: 9592fd77    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101767b7c: 900f36a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101767b80: f9478d01    	ldr	x1, [x8, #0xf18] ; searchBar
101767b84: aa1403e0    	mov	x0, x20
101767b88: 9592fd6d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101767b8c: aa1d03fd    	mov	x29, x29
101767b90: 9592fd6e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101767b94: aa0003f4    	mov	x20, x0
101767b98: 900f3a08    	adrp	x8, 0x11fea7000 <dyld_stub_binder+0x11fea7000>
101767b9c: f9453901    	ldr	x1, [x8, #0xa70] ; inputBoxSetText:
101767ba0: aa1303e2    	mov	x2, x19
101767ba4: 9592fd66    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101767ba8: aa1303e0    	mov	x0, x19
101767bac: 9592fd6a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101767bb0: aa1403e0    	mov	x0, x20
101767bb4: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101767bb8: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101767bbc: a94257f6    	ldp	x22, x21, [sp, #0x20]
101767bc0: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101767bc4: 910143ff    	add	sp, sp, #0x50
101767bc8: 1592fd63    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
