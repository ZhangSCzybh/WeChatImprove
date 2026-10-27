
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1050fcf20: d10103ff    	sub	sp, sp, #0x40
1050fcf24: 6d0123e9    	stp	d9, d8, [sp, #0x10]
1050fcf28: a9024ff4    	stp	x20, x19, [sp, #0x20]
1050fcf2c: a9037bfd    	stp	x29, x30, [sp, #0x30]
1050fcf30: 9100c3fd    	add	x29, sp, #0x30
1050fcf34: aa0003f3    	mov	x19, x0
1050fcf38: f00dda08    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
1050fcf3c: 52800029    	mov	w9, #0x1                ; =1
1050fcf40: 392c1509    	strb	w9, [x8, #0xb05]
1050fcf44: d00d8648    	adrp	x8, 0x1201c6000 <dyld_stub_binder+0x1201c6000>
1050fcf48: f9405508    	ldr	x8, [x8, #0xa8] ; NewMainFrameCell
1050fcf4c: a90023e0    	stp	x0, x8, [sp]
1050fcf50: d00d6a08    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1050fcf54: f940a901    	ldr	x1, [x8, #0x150] ; layoutSubviews
1050fcf58: 910003e0    	mov	x0, sp
1050fcf5c: 94aca87a    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
1050fcf60: 900d8968    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1050fcf64: b982c914    	ldrsw	x20, [x8, #0x2c8]
1050fcf68: f8746a68    	ldr	x8, [x19, x20]
1050fcf6c: b40002a8    	cbz	x8, 0x1050fcfc0 <_Flutter_MMFoundation_BindContext+0x15d8ba4>
1050fcf70: 900d8968    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1050fcf74: b982cd08    	ldrsw	x8, [x8, #0x2cc]
1050fcf78: fc686a68    	ldr	d8, [x19, x8]
1050fcf7c: f00d8068    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1050fcf80: f947a501    	ldr	x1, [x8, #0xf48] ; width
1050fcf84: aa1303e0    	mov	x0, x19
1050fcf88: 94aca86d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fcf8c: 1e604009    	fmov	d9, d0
1050fcf90: d00d8028    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1050fcf94: f9449d01    	ldr	x1, [x8, #0x938] ; height
1050fcf98: aa1303e0    	mov	x0, x19
1050fcf9c: 94aca868    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fcfa0: 1e604003    	fmov	d3, d0
1050fcfa4: f8746a60    	ldr	x0, [x19, x20]
1050fcfa8: 900d8068    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
1050fcfac: f9403501    	ldr	x1, [x8, #0x68] ; setFrame:
1050fcfb0: 9e6703e1    	fmov	d1, xzr
1050fcfb4: 1e604100    	fmov	d0, d8
1050fcfb8: 1e604122    	fmov	d2, d9
1050fcfbc: 94aca860    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fcfc0: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1050fcfc4: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1050fcfc8: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
1050fcfcc: 910103ff    	add	sp, sp, #0x40
1050fcfd0: d65f03c0    	ret
