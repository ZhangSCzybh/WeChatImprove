
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106290c64: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
106290c68: a9014ff4    	stp	x20, x19, [sp, #0x10]
106290c6c: a9027bfd    	stp	x29, x30, [sp, #0x20]
106290c70: 910083fd    	add	x29, sp, #0x20
106290c74: aa0003f3    	mov	x19, x0
106290c78: f00cea08    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106290c7c: f9463501    	ldr	x1, [x8, #0xc68] ; bShowingQuickTranTips
106290c80: 9466592f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106290c84: 370003c0    	tbnz	w0, #0x0, 0x106290cfc <_Flutter_MMFoundation_BindContext+0x276c8e0>
106290c88: f00cdd68    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
106290c8c: f9403914    	ldr	x20, [x8, #0x70] ; cellView
106290c90: aa1303e0    	mov	x0, x19
106290c94: aa1403e1    	mov	x1, x20
106290c98: 94665929    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106290c9c: aa1d03fd    	mov	x29, x29
106290ca0: 9466592a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106290ca4: aa0003f5    	mov	x21, x0
106290ca8: 9466592b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106290cac: b4000295    	cbz	x21, 0x106290cfc <_Flutter_MMFoundation_BindContext+0x276c8e0>
106290cb0: 900cea28    	adrp	x8, 0x11ffd4000 <dyld_stub_binder+0x11ffd4000>
106290cb4: f9402101    	ldr	x1, [x8, #0x40] ; setBShowingQuickTranTips:
106290cb8: aa1303e0    	mov	x0, x19
106290cbc: 52800022    	mov	w2, #0x1                ; =1
106290cc0: 9466591f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106290cc4: aa1303e0    	mov	x0, x19
106290cc8: aa1403e1    	mov	x1, x20
106290ccc: 9466591c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106290cd0: aa1d03fd    	mov	x29, x29
106290cd4: 9466591d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106290cd8: aa0003f3    	mov	x19, x0
106290cdc: 900cea28    	adrp	x8, 0x11ffd4000 <dyld_stub_binder+0x11ffd4000>
106290ce0: f9402501    	ldr	x1, [x8, #0x48] ; animateShowQuickTransTips
106290ce4: 94665916    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106290ce8: aa1303e0    	mov	x0, x19
106290cec: a9427bfd    	ldp	x29, x30, [sp, #0x20]
106290cf0: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106290cf4: a8c357f6    	ldp	x22, x21, [sp], #0x30
106290cf8: 14665917    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106290cfc: a9427bfd    	ldp	x29, x30, [sp, #0x20]
106290d00: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106290d04: a8c357f6    	ldp	x22, x21, [sp], #0x30
106290d08: d65f03c0    	ret