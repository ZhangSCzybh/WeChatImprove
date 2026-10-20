
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106290d0c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
106290d10: a9017bfd    	stp	x29, x30, [sp, #0x10]
106290d14: 910043fd    	add	x29, sp, #0x10
106290d18: aa0003f3    	mov	x19, x0
106290d1c: f00cea08    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106290d20: f9463501    	ldr	x1, [x8, #0xc68] ; bShowingQuickTranTips
106290d24: 94665906    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106290d28: 34000280    	cbz	w0, 0x106290d78 <_Flutter_MMFoundation_BindContext+0x276c95c>
106290d2c: 900cea28    	adrp	x8, 0x11ffd4000 <dyld_stub_binder+0x11ffd4000>
106290d30: f9402101    	ldr	x1, [x8, #0x40] ; setBShowingQuickTranTips:
106290d34: aa1303e0    	mov	x0, x19
106290d38: 52800002    	mov	w2, #0x0                ; =0
106290d3c: 94665900    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106290d40: f00cdd68    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
106290d44: f9403901    	ldr	x1, [x8, #0x70] ; cellView
106290d48: aa1303e0    	mov	x0, x19
106290d4c: 946658fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106290d50: aa1d03fd    	mov	x29, x29
106290d54: 946658fd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106290d58: aa0003f3    	mov	x19, x0
106290d5c: 900cea28    	adrp	x8, 0x11ffd4000 <dyld_stub_binder+0x11ffd4000>
106290d60: f9402901    	ldr	x1, [x8, #0x50] ; animateHiddenQuickTransTips
106290d64: 946658f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106290d68: aa1303e0    	mov	x0, x19
106290d6c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
106290d70: a8c24ff4    	ldp	x20, x19, [sp], #0x20
106290d74: 146658f8    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106290d78: a9417bfd    	ldp	x29, x30, [sp, #0x10]
106290d7c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
106290d80: d65f03c0    	ret