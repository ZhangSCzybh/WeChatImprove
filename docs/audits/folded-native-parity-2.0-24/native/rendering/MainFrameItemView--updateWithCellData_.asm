
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a9c77c: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
104a9c780: a90157f6    	stp	x22, x21, [sp, #0x10]
104a9c784: a9024ff4    	stp	x20, x19, [sp, #0x20]
104a9c788: a9037bfd    	stp	x29, x30, [sp, #0x30]
104a9c78c: 9100c3fd    	add	x29, sp, #0x30
104a9c790: aa0203f3    	mov	x19, x2
104a9c794: aa0003f4    	mov	x20, x0
104a9c798: d00e0d08    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a9c79c: 52800029    	mov	w9, #0x1                ; =1
104a9c7a0: 390ce909    	strb	w9, [x8, #0x33a]
104a9c7a4: aa0203e0    	mov	x0, x2
104a9c7a8: 94c62a64    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104a9c7ac: 900d9f28    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
104a9c7b0: f943e116    	ldr	x22, [x8, #0x7c0] ; m_cellData
104a9c7b4: aa1403e0    	mov	x0, x20
104a9c7b8: aa1603e1    	mov	x1, x22
104a9c7bc: 94c62a60    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c7c0: aa1d03fd    	mov	x29, x29
104a9c7c4: 94c62a61    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a9c7c8: aa0003f5    	mov	x21, x0
104a9c7cc: f00dbc37    	adrp	x23, 0x120223000 <dyld_stub_binder+0x120223000>
104a9c7d0: eb13001f    	cmp	x0, x19
104a9c7d4: 540002a0    	b.eq	0x104a9c828 <_Flutter_MMFoundation_BindContext+0xf7840c>
104a9c7d8: aa1403e0    	mov	x0, x20
104a9c7dc: aa1603e1    	mov	x1, x22
104a9c7e0: 94c62a57    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c7e4: aa1d03fd    	mov	x29, x29
104a9c7e8: 94c62a58    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a9c7ec: aa0003f6    	mov	x22, x0
104a9c7f0: 94c62a59    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a9c7f4: aa1503e0    	mov	x0, x21
104a9c7f8: 94c62a57    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a9c7fc: b40001b6    	cbz	x22, 0x104a9c830 <_Flutter_MMFoundation_BindContext+0xf78414>
104a9c800: b9826ee8    	ldrsw	x8, [x23, #0x26c]
104a9c804: f8686a80    	ldr	x0, [x20, x8]
104a9c808: d00db348    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104a9c80c: f940f901    	ldr	x1, [x8, #0x1f0] ; removeFromSuperview
104a9c810: 94c62a4b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c814: 900d9d68    	adrp	x8, 0x11fe48000 <dyld_stub_binder+0x11fe48000>
104a9c818: f9419901    	ldr	x1, [x8, #0x330] ; initNameLabel
104a9c81c: aa1403e0    	mov	x0, x20
104a9c820: 94c62a47    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c824: 14000003    	b	0x104a9c830 <_Flutter_MMFoundation_BindContext+0xf78414>
104a9c828: aa1503e0    	mov	x0, x21
104a9c82c: 94c62a4a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a9c830: 900da748    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a9c834: f944b101    	ldr	x1, [x8, #0x960] ; setM_cellData:
104a9c838: aa1403e0    	mov	x0, x20
104a9c83c: aa1303e2    	mov	x2, x19
104a9c840: 94c62a3f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c844: b00da068    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
104a9c848: f9407901    	ldr	x1, [x8, #0xf0] ; updateBackgroundColor
104a9c84c: aa1403e0    	mov	x0, x20
104a9c850: 94c62a3b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c854: b00d9e68    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104a9c858: f9403901    	ldr	x1, [x8, #0x70] ; cpKeyForNickname
104a9c85c: aa1303e0    	mov	x0, x19
104a9c860: 94c62a37    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c864: aa1d03fd    	mov	x29, x29
104a9c868: 94c62a38    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a9c86c: aa0003f5    	mov	x21, x0
104a9c870: b9826ee8    	ldrsw	x8, [x23, #0x26c]
104a9c874: f8686a80    	ldr	x0, [x20, x8]
104a9c878: b00d9e68    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104a9c87c: f9403d16    	ldr	x22, [x8, #0x78] ; setCpKey:
104a9c880: aa1603e1    	mov	x1, x22
104a9c884: aa1503e2    	mov	x2, x21
104a9c888: 94c62a2d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c88c: aa1503e0    	mov	x0, x21
104a9c890: 94c62a31    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a9c894: f00d9f28    	adrp	x8, 0x11fe83000 <dyld_stub_binder+0x11fe83000>
104a9c898: f9404901    	ldr	x1, [x8, #0x90] ; cpKeyForMessage
104a9c89c: aa1303e0    	mov	x0, x19
104a9c8a0: 94c62a27    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c8a4: aa1d03fd    	mov	x29, x29
104a9c8a8: 94c62a28    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a9c8ac: aa0003f5    	mov	x21, x0
104a9c8b0: f00dbc28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a9c8b4: b982a508    	ldrsw	x8, [x8, #0x2a4]
104a9c8b8: f8686a80    	ldr	x0, [x20, x8]
104a9c8bc: aa1603e1    	mov	x1, x22
104a9c8c0: aa1503e2    	mov	x2, x21
104a9c8c4: 94c62a1e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c8c8: aa1503e0    	mov	x0, x21
104a9c8cc: 94c62a22    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a9c8d0: 900db368    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104a9c8d4: f947a101    	ldr	x1, [x8, #0xf40] ; setNeedsLayout
104a9c8d8: aa1403e0    	mov	x0, x20
104a9c8dc: 94c62a18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c8e0: aa1303e0    	mov	x0, x19
104a9c8e4: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104a9c8e8: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104a9c8ec: a94157f6    	ldp	x22, x21, [sp, #0x10]
104a9c8f0: a8c45ff8    	ldp	x24, x23, [sp], #0x40
104a9c8f4: 14c62a18    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
