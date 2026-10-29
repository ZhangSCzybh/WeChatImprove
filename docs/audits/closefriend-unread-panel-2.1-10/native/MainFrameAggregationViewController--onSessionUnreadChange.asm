
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a7450c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104a74510: a9017bfd    	stp	x29, x30, [sp, #0x10]
104a74514: 910043fd    	add	x29, sp, #0x10
104a74518: aa0003f3    	mov	x19, x0
104a7451c: 900da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a74520: f9411d01    	ldr	x1, [x8, #0x238] ; selector updateBottomTitle
104a74524: 94c6cb06    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a74528: b00d9e68    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
104a7452c: f944dd01    	ldr	x1, [x8, #0x9b8] ; selector updateLayout
104a74530: aa1303e0    	mov	x0, x19
104a74534: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104a74538: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104a7453c: 14c6cb00    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
