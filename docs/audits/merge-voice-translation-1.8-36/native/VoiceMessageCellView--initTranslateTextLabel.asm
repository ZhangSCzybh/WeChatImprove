
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10627c9e8: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
10627c9ec: a9017bfd    	stp	x29, x30, [sp, #0x10]
10627c9f0: 910043fd    	add	x29, sp, #0x10
10627c9f4: aa0003f3    	mov	x19, x0
10627c9f8: f00ceaa8    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10627c9fc: f946b101    	ldr	x1, [x8, #0xd60] ; createTranslateTextLabel
10627ca00: 9466a9cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627ca04: aa1d03fd    	mov	x29, x29
10627ca08: 9466a9d0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627ca0c: 900cfde8    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
10627ca10: b98d8514    	ldrsw	x20, [x8, #0xd84]
10627ca14: f8746a68    	ldr	x8, [x19, x20]
10627ca18: f8346a60    	str	x0, [x19, x20]
10627ca1c: aa0803e0    	mov	x0, x8
10627ca20: 9466a9cd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627ca24: 900cfde8    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
10627ca28: b98d8108    	ldrsw	x8, [x8, #0xd80]
10627ca2c: f8686a60    	ldr	x0, [x19, x8]
10627ca30: f8746a62    	ldr	x2, [x19, x20]
10627ca34: d00cf408    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10627ca38: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
10627ca3c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10627ca40: a8c24ff4    	ldp	x20, x19, [sp], #0x20
10627ca44: 1466a9be    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>