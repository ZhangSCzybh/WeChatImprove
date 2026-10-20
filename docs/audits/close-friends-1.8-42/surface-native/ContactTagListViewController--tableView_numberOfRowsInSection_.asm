
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101048f8c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
101048f90: a9017bfd    	stp	x29, x30, [sp, #0x10]
101048f94: 910043fd    	add	x29, sp, #0x10
101048f98: aa0303e2    	mov	x2, x3
101048f9c: aa0003f3    	mov	x19, x0
101048fa0: b00f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
101048fa4: f9408901    	ldr	x1, [x8, #0x110] ; checkNoTagSectionWithSection:
101048fa8: 95af7865    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101048fac: 360000a0    	tbz	w0, #0x0, 0x101048fc0 <__text+0x1040fc0>
101048fb0: 52800020    	mov	w0, #0x1                ; =1
101048fb4: a9417bfd    	ldp	x29, x30, [sp, #0x10]
101048fb8: a8c24ff4    	ldp	x20, x19, [sp], #0x20
101048fbc: d65f03c0    	ret
101048fc0: d00f8d08    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
101048fc4: b982a908    	ldrsw	x8, [x8, #0x2a8] ; ivar ContactTagListViewController._arrContactTagData
101048fc8: f8686a60    	ldr	x0, [x19, x8]
101048fcc: 900f85c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101048fd0: f9435101    	ldr	x1, [x8, #0x6a0] ; count
101048fd4: a9417bfd    	ldp	x29, x30, [sp, #0x10]
101048fd8: a8c24ff4    	ldp	x20, x19, [sp], #0x20
101048fdc: 15af7858    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
