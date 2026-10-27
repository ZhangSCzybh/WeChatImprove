
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104eb35c4: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104eb35c8: a9017bfd    	stp	x29, x30, [sp, #0x10]
104eb35cc: 910043fd    	add	x29, sp, #0x10
104eb35d0: aa0003f3    	mov	x19, x0
104eb35d4: d00d86e8    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104eb35d8: f946c101    	ldr	x1, [x8, #0xd80] ; isSearchMultiKey
104eb35dc: 94b5ced8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eb35e0: 340000a0    	cbz	w0, 0x104eb35f4 <_Flutter_MMFoundation_BindContext+0x138f1d8>
104eb35e4: f00d86e8    	adrp	x8, 0x11ff92000 <dyld_stub_binder+0x11ff92000>
104eb35e8: f940c101    	ldr	x1, [x8, #0x180] ; resetTokenPickLogic
104eb35ec: aa1303e0    	mov	x0, x19
104eb35f0: 94b5ced3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eb35f4: f00d9b88    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104eb35f8: b9885108    	ldrsw	x8, [x8, #0x850]
104eb35fc: f8686a60    	ldr	x0, [x19, x8]
104eb3600: 900d7c48    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104eb3604: f9458901    	ldr	x1, [x8, #0xb10] ; reloadTableView
104eb3608: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104eb360c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104eb3610: 14b5cecb    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
