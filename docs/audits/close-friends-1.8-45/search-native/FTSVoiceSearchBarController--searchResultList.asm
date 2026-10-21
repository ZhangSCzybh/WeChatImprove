
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10181bb58: d10103ff    	sub	sp, sp, #0x40
10181bb5c: a9024ff4    	stp	x20, x19, [sp, #0x20]
10181bb60: a9037bfd    	stp	x29, x30, [sp, #0x30]
10181bb64: 9100c3fd    	add	x29, sp, #0x30
10181bb68: aa0003f3    	mov	x19, x0
10181bb6c: 900f3488    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10181bb70: f944c501    	ldr	x1, [x8, #0x988] ; resetSearchSectionType
10181bb74: 95902d72    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181bb78: 900f3108    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10181bb7c: f9419901    	ldr	x1, [x8, #0x330] ; dataSource
10181bb80: aa1303e0    	mov	x0, x19
10181bb84: 95902d6e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181bb88: aa1d03fd    	mov	x29, x29
10181bb8c: 95902d6f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10181bb90: aa0003f3    	mov	x19, x0
10181bb94: 900f3488    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10181bb98: f944f501    	ldr	x1, [x8, #0x9e8] ; displayedResults
10181bb9c: 95902d68    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181bba0: aa1d03fd    	mov	x29, x29
10181bba4: 95902d69    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10181bba8: aa0003f4    	mov	x20, x0
10181bbac: aa1303e0    	mov	x0, x19
10181bbb0: 95902d69    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181bbb4: 900f4ac8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10181bbb8: f9453513    	ldr	x19, [x8, #0xa68]
10181bbbc: b00f4728    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10181bbc0: f9435101    	ldr	x1, [x8, #0x6a0] ; count
10181bbc4: aa1403e0    	mov	x0, x20
10181bbc8: 95902d5d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181bbcc: d00f30e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10181bbd0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10181bbd4: a900d3e0    	stp	x0, x20, [sp, #0x8]
10181bbd8: d00e6be8    	adrp	x8, 0x11e599000 <dyld_stub_binder+0x11e599000>
10181bbdc: 911e2108    	add	x8, x8, #0x788
10181bbe0: f90003e8    	str	x8, [sp]
10181bbe4: 900cdea5    	adrp	x5, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10181bbe8: 912160a5    	add	x5, x5, #0x858
10181bbec: 900cdea7    	adrp	x7, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10181bbf0: 9135dce7    	add	x7, x7, #0xd77
10181bbf4: aa1303e0    	mov	x0, x19
10181bbf8: 52800042    	mov	w2, #0x2                ; =2
10181bbfc: d2800003    	mov	x3, #0x0                ; =0
10181bc00: 52800004    	mov	w4, #0x0                ; =0
10181bc04: 52802106    	mov	w6, #0x108              ; =264
10181bc08: 95902d4d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181bc0c: aa1403e0    	mov	x0, x20
10181bc10: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10181bc14: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10181bc18: 910103ff    	add	sp, sp, #0x40
10181bc1c: 15902d55    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
