
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101b33144: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
101b33148: a9017bfd    	stp	x29, x30, [sp, #0x10]
101b3314c: 910043fd    	add	x29, sp, #0x10
101b33150: aa0003f3    	mov	x19, x0
101b33154: 900f1c28    	adrp	x8, 0x11feb7000 <dyld_stub_binder+0x11feb7000>
101b33158: f9434d01    	ldr	x1, [x8, #0x698] ; resetSectionType
101b3315c: 9583cff8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b33160: 900f1c28    	adrp	x8, 0x11feb7000 <dyld_stub_binder+0x11feb7000>
101b33164: f9435101    	ldr	x1, [x8, #0x6a0] ; resetRowType
101b33168: aa1303e0    	mov	x0, x19
101b3316c: 9583cff4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b33170: b00f3608    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101b33174: b9802108    	ldrsw	x8, [x8, #0x20]
101b33178: f8686a60    	ldr	x0, [x19, x8]
101b3317c: f00f2e88    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101b33180: f9404501    	ldr	x1, [x8, #0x88] ; reloadData
101b33184: 9583cfee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b33188: 900f1c28    	adrp	x8, 0x11feb7000 <dyld_stub_binder+0x11feb7000>
101b3318c: f9435501    	ldr	x1, [x8, #0x6a8] ; checkAndShowAllEntriesClosedHintView
101b33190: aa1303e0    	mov	x0, x19
101b33194: a9417bfd    	ldp	x29, x30, [sp, #0x10]
101b33198: a8c24ff4    	ldp	x20, x19, [sp], #0x20
101b3319c: 1583cfe8    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
